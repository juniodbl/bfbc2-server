--
-- Global Settings
--
--  These are front-end settings exposed to the end-user. The idea is that
--  settings that are interesting to the majority of end-users should be 
--  defined here to enable tools to query for exposed options.
--
--  This file is imported by Pipeline, Game, etc
--

GlobalSettings = {}
GlobalSettings.Meta = {}

local function ValidateSetting(name, value)
	assert(name and value)

	local meta = GlobalSettings.Meta[name]
	local lowerValue = string.lower(value)

	if meta then
		for _,v in ipairs(meta.validValues) do
			if string.lower(v[1]) == lowerValue then
				return v[1]
			end
		end

		-- We intentionally don't build this string in the loop above
		-- in an attempt to generate less ephemeral garbage

		local choices = nil

		for _,v in ipairs(meta.validValues) do
		    if choices then
				choices = choices .. ", " .. v[1]
			else
				choices = v[1]
			end	
		end

		error("Setting '" .. name .. "' cannot be set to specified value: " .. value .. ", valid values are " .. choices)
	else
		error("Undefined setting - '" .. name .. "'")
	end
end

local function DefineSetting(descriptionTable)
	assert(descriptionTable[1] and descriptionTable[2], "Settings must have name and default values!")
	
	local name = descriptionTable[1];
	local defaultValue = descriptionTable[2];
	
	GlobalSettings[name] = defaultValue
	GlobalSettings.Meta[name] = {}

	GlobalSettings.Meta[name].default = defaultValue
	
	if descriptionTable.description then
		GlobalSettings.Meta[name].description = descriptionTable.description
	end

	if descriptionTable.validValues then
		GlobalSettings.Meta[name].validValues = descriptionTable.validValues
	end

	if descriptionTable.commandLine then
		GlobalSettings.Meta[name].commandLine = descriptionTable.commandLine
	end

	if descriptionTable.envVar then
		GlobalSettings.Meta[name].envVar = descriptionTable.envVar
	end
	
	-- Validate default vs validValues
	ValidateSetting(name, defaultValue)
end

function ApplyCommandLineSettings(commandLine)
	for setting,meta in pairs(GlobalSettings.Meta) do
		if meta.commandLine then
			local options = meta.commandLine

			for _,entry in ipairs(options) do
				local k = entry[1]
				local v = entry[2]

				local value = commandLine[string.lower(k)]

				if value then
					if not v then
						SetSetting(setting, value, string.format(" (due to -%s %s)", k, value))
					else
						SetSetting(setting, v, string.format(" (due to -%s)", k))
					end
				end
			end
		end
	end
end

function ApplyEnvironmentVariableSettings()
	for setting,meta in pairs(GlobalSettings.Meta) do
		if meta.envVar then
			local envVarValue = os.getenv(meta.envVar)

			if envVarValue then
				SetSetting(setting, envVarValue)
			end
		end
	end
end


function SetSetting(settingName, value, source)
	if not GlobalSettings[settingName] then 
		error("Attempted set of unknown setting '" .. settingName .. "'")
	else
		GlobalSettings[settingName] = ValidateSetting(settingName, value)

		if log then
			log:debug("Set setting " .. settingName .. " to value: " .. value .. (source or ""))
		end	
	end
end

function GetGlobalSetting(settingName)
	if not GlobalSettings[settingName] then 
		error("Attempted get of unknown setting '" .. settingName .. "'")
	else
		return GlobalSettings[settingName] 
	end
end

--------------------------------------------------------------------------
-- Setting definitions
--

DefineSetting {
	"Cache", "Enabled", 

	validValues = { 
		{ "Enabled", 		"Normal cache mode" },
		{ "Disabled", 		"No caching" },
		{ "ReadOnly", 		"Only read from caches (never upload)" },
		{ "WriteOnly",		"Only write to caches (useful for fixing problems)" }
	},
	description = "Cache Control",
	commandLine = {
		{ "cacheMode" },
		{ "nocache", 		"Disabled" },
		{ "readonlyCache", 	"ReadOnly" },
		{ "writeOnlyCache", "WriteOnly" },
		{ "cache",			"Enabled" }
	},
	envVar = "PIPELINE_CACHE_MODE"
}

DefineSetting {
	"IndexingMode", "Enabled",

	validValues = {
		{ "Enabled",		"Index is used for build acceleration" },
		{ "Disabled",		"Indexing is not used to accelerate builds" },
	},
	description = "Indexing control",
	commandLine = {
		{ "noindex",		"Disabled" },
		{ "index",			"Enabled" },
		{ "noindexing",		"Disabled" },
		{ "indexing",		"Enabled" }
	}
}

DefineSetting {
	"SKU", "Internal",

	validValues = {
		{ "Internal",		"Internal SKU, used for development" },
		{ "EU",				"European SKU" },
		{ "JPN",			"Japanese SKU" }
	},
	description = "SKU Selector",
	commandLine = {
		{ "SKU" }
	},
	envVar = "DICE_SKU"
}

DefineSetting {
	"ResourceBundleMode", "Development",
	
	validValues = { 
		{ "Disabled", 		"No bundles will be built or loaded by the game" }, 
		{ "Development", 	"Incremental bundles will be built, suitable for development" }, 
		{ "Final", 			"Self-contained bundles will be built, use for final or demo builds" },
	},
	description = "Resource Bundle Control",
	commandLine = {
		{ "bundleMode" },
		{ "nobundles",		"Disabled" },
	},
	envVar = "PIPELINE_BUNDLE_MODE"
}

DefineSetting {
	"Profile", "Default",
	
	validValues = { 
		{ "Default",		"Generic Role" }, 
		{ "BuildMonkey", 	"Headless build machine" },
		{ "Programmer",		"Coder" }, 
		{ "LevelDesigner",	"Level Designer (level logic)" },
	},
	description = "Pick the role that best describes you"
}

DefineSetting {
	"ServiceMode", "Disabled",
	
	validValues = { 
		{ "Disabled",		"No automatic rebuilds, no automatic resource loading" }, 
		{ "AutoTrigger",	"Automatically trigger pipeline builds on source data changes" },
		{ "Manual",			"Manually triggered service mode pipeline builds" },
	},
	description = "Service Mode Control",
	commandLine = {
		{ "serviceMode" },
	}
}

DefineSetting {
	"DxVersion", "Dx10",

	validValues = {
		{ "Dx9",			"DirectX 9 (WinXP)" },
		{ "Dx10",			"DirectX 10 (Vista)" },
	},
	description = "DirectX API version selector.",
	commandLine = {
		{ "Dx9",			"Dx9" },
		{ "Dx10",			"Dx10" }
	}
}

DefineSetting {
	"TextureBaker", "Disabled",

	validValues = {
		{ "Mesh",			"Mesh texture baking enabled" },
		{ "Tree",			"Tree texture baking enabled" },
		{ "Disabled",		"Texture baking disabled" },
	},
	description = "Texture baking configuration",
	commandLine = {
		{ "textureBaker" },
	}
}


---------------------------------------------------------------------------
-- Quality settings
--

DefineSetting {
	"Audio", "Enabled",

	validValues = {
		{ "Disabled",		"No audio required" },
		{ "Basic",			"Basic audio only - no variations or extra fluff" },
		{ "Enabled",		"Full audio" },
	},
	commandLine = {
		{ "noaudio",		"Disabled" },
		{ "audioMode" }
	}
}

DefineSetting {
	"VoiceOvers", "Regular",

	validValues = {
		{ "Regular",		"Voice overs are enabled" },
		{ "Minimal",		"Only common (non-localized) voice overs are enabled" },
		{ "None",			"No voice overs are enabled" },
	},
	commandLine = {
		{ "voiceOverMode" },
		{ "novo",			"None" }
	}
}

DefineSetting {
	"Shading", "Full",

	validValues = {
		{ "SimpleShading",	"Simple shading - no textures, no shaders" },
		{ "Full",			"Full shading" },
	}
}

--------------------------------------------------------------------------
-- Overridden settings (temporary: use to change settings from default values)
--

if dice.Environment:getUserIdentifier() == "sboberg" then
	SetSetting("ServiceMode", "AutoTrigger")
--	SetSetting("ResourceBundleMode", "Development")
	SetSetting("Cache", "Enabled")
--	SetSetting("Cache", "ReadOnly")
--	SetSetting("VoiceOvers", "None")
--	SetSetting("Audio", "Disabled")
end


-- DX10 can only be run on Vista

if os.getenv("DICE_VISTA") == "1" and GlobalSettings.DxVersion == 'Dx10' then
	SetSetting("DxVersion", "Dx10")
else
	SetSetting("DxVersion", "Dx9")
end

-- This works around occasional issues with incremental bundle building (which 
-- ought to be addressed - remove this once this is done)

if ( os.getenv("dice_autobuild") == "YES" ) then
	SetSetting("ResourceBundleMode", "Final")
	SetSetting("SKU", "EU")
end

if GlobalSettings.TextureBaker and GlobalSettings.TextureBaker ~= 'Disabled' then
	core.readKeyValueCfg("Scripts/Common/TextureBakerConfiguration.lua")
end
