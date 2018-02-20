--
-- Pipeline Configuration
--
--   This is an internal script used for configuring the pipeline. Normal
--   users should typically not edit this file, as most end-user settings
--   are exposed through the GlobalSettings.lua file
--

--
-- Import common settings
--

core.import(allScriptsRoot .. "GlobalSettings.lua", "global settings");

--
-- Import global defaults
--

--core.import(studioConfigDir .. "Global.lua", "studio config", { silent=true } )
--core.import(studioConfigDir .. branchName .. ".lua", "branch config", { silent=true } )

-- Import session startup script, if specified on commandLine
-- 
-- This is used by Drone to change settings

if commandLine.startupscript then
	core.import("/data/" .. commandLine.startupScript, _G)
end

--
-- Import Maya exporter settings
--

core.import(allScriptsRoot .. "MayaExport/Startup.lua", "MayaExport configuration")

core.import(scriptsRoot .. "Events.lua")
core.import(scriptsRoot .. "Actions.lua")
core.import(scriptsRoot .. "Settings.lua")

--   -config commandLine switch is used by Drone to configure custom settings
if commandLine.config then
	core.readKeyValueCfg("/data/" .. commandLine.config, _G)	
end

---------------------------------------------------------------------------
-- Ad hoc buildmonkey settings
--

if ( os.getenv("dice_autobuild") == "YES" ) then
	Pipeline.EnableRemoteLog = false
end

---------------------------------------------------------------------------
-- Parse settings from environment and commandline
--

ApplyEnvironmentVariableSettings()
ApplyCommandLineSettings(commandLine)

-- Perform computed configuration based on global settings (for dependent
-- settings)

core.import(allScriptsRoot .. "Common/GlobalConfiguration.lua", "global configuration");

---------------------------------------------------------------------------
-- "Computed" configuration
--

if GlobalSettings.Cache and not Cache.Disable then
	Cache.Disable = false
	Cache.ReadOnly = false
	Cache.WriteOnly = false

	if (GlobalSettings.Cache == "Enabled") then
	elseif (GlobalSettings.Cache == "Disabled") then
		Cache.Disable = true
	elseif (GlobalSettings.Cache == "ReadOnly") then
		Cache.ReadOnly = true
	elseif (GlobalSettings.Cache == "WriteOnly") then
		Cache.WriteOnly = true
	else
		error("Unknown cache mode: ", GlobalSettings.Cache)
	end
end

-- If caching is disabled then all use of remote cache should be disabled
if Cache.Disable then
	Cache.DisableRemoteCache = true
end

-- Configure indexing
if GlobalSettings.IndexingMode == "Enabled" then
	Pipeline.EnableIndexing = true
	Pipeline.EnableAssetLoadIndexing = true
else
	Pipeline.EnableIndexing = false
	Pipeline.EnableAssetLoadIndexing = false
end

-- Set up resource bundling
if GlobalSettings.ResourceBundleMode then
	if Pipeline.Verbose then
		print("Resource Bundle mode: " .. GlobalSettings.ResourceBundleMode)
	end
	
	Pipeline.BundleMode = GlobalSettings.ResourceBundleMode
end

-- Configure service mode

if GlobalSettings.ServiceMode then
	if GlobalSettings.ServiceMode == "Disabled" then
		Pipeline.ServiceMode = false
	elseif GlobalSettings.ServiceMode == "Manual" then
		Pipeline.DisableChangeMonitor = true
		Pipeline.ServiceMode = true
	elseif GlobalSettings.ServiceMode == "AutoTrigger" then
		Pipeline.DisableChangeMonitor = false
		Pipeline.ServiceMode = true
	end
end

-- Configure pipeline for the selected DX version

if GlobalSettings.DxVersion == 'Dx9' then
	LevelShaderState.Dx10PathEnable = false
	LevelShaderState.Dx9Sm3NvPathEnable = true
	SceneShaderState.Dx10PathEnable = false
	SceneShaderState.Dx9Sm3NvPathEnable = true
elseif GlobalSettings.DxVersion == 'Dx10' then
	LevelShaderState.Dx10PathEnable = true
	LevelShaderState.Dx9Sm3NvPathEnable = false
	SceneShaderState.Dx10PathEnable = true
	SceneShaderState.Dx9Sm3NvPathEnable = false
end

------------------------------------------------------------------------
-- Configure sound

if GlobalSettings.VoiceOvers == "None" then
	Level.EnableVoiceOvers = false
else
	-- Voiceovers default to off

	VoiceOverTree.EnableCommon = true
	Level.EnableVoiceOvers = true

	if GlobalSettings.SKU == "Internal" or GlobalSettings.VoiceOvers == "Minimal" then
		VoiceOverTree.EnableEnglish = true
	elseif GlobalSettings.SKU == "EU" then
		Level.EnableLocalizedVoiceOvers = true
		VoiceOverTree.EnableEnglish = true
		VoiceOverTree.EnableGerman = true
		VoiceOverTree.EnableSpanish = true
		VoiceOverTree.EnableItalian = true
		VoiceOverTree.EnableFrench = true
		VoiceOverTree.EnablePolish = true
		VoiceOverTree.EnableRussian = true
	elseif GlobalSettings.SKU == "JPN" then
		Level.EnableLocalizedVoiceOvers = true
		VoiceOverTree.EnableEnglish = true
		VoiceOverTree.EnableGerman = true
		VoiceOverTree.EnableSpanish = true
		VoiceOverTree.EnableItalian = true
		VoiceOverTree.EnableFrench = true
		VoiceOverTree.EnableJapanese = true
	end
end

--------------------------------------------------------------------------
-- Configuration scripts will set the MAYA_VERSION environment variable
-- to indicate which Maya version to use for the current branch
--

local MayaVersion = os.getenv("MAYA_VERSION")

if MayaVersion == "7.0" then
	MayaDependencies.MayaVersion = 700
elseif MayaVersion == "8.5" then
	MayaDependencies.MayaVersion = 850
end

--------------------------------------------------------------------------
-- Control pipeline use of D3D based on user role
--

if GlobalSettings.Profile == "BuildMonkey" then
	Pipeline.DisableHalDevice = true
	Mesh.TootleOptimizeEnable = false	-- Should we change this
						-- so that it uses software
						-- only instead of switching
						-- it off altogether?
end

--------------------------------------------------------------------------
-- Handle commandline options
--
--   Commandline options effectively override any settings specified
--   elsewhere.
--


local function cmdLineSwitch(switchName, fieldName)
	if (commandLine[string.lower(switchName)]) then
		Pipeline[fieldName] = true
	end
end

cmdLineSwitch("debug", "DebugMode");
cmdLineSwitch("validateData", "ValidateData");
cmdLineSwitch("rebuild", "Rebuild");
cmdLineSwitch("showReason", "ShowReason");
cmdLineSwitch("addToPerforce", "AddToPerforce");
cmdLineSwitch("noconsole", "NoConsole");
cmdLineSwitch("verbose", "Verbose");
cmdLineSwitch("service", "ServiceMode");
cmdLineSwitch("interactive", "InteractiveMode");
cmdLineSwitch("dumpMemory", "EnableMemoryDump");
cmdLineSwitch("trace", "EnableTracing");
cmdLineSwitch("nohal", "DisableHalDevice");
cmdLineSwitch("rebuildFilemap", "RebuildFilemap");

--
--  Parse commandline options that may occur multiple times ("list" options)
--

Pipeline.ExecCommands = {}
Pipeline.BundlesToUpdate = {}

for i,v in ipairs(commandLine) do
	if v == "-exec" and commandLine[i + 1] then
		table.insert(Pipeline.ExecCommands, commandLine[i + 1])
	end
	if v == "-action" and commandLine[i + 1] then
		table.insert(Pipeline.ExecCommands, "Actions:" .. commandLine[i + 1])
	end
	if v == "-updateBundle" and commandLine[i + 1] then
		if Pipeline.Verbose then
			print("UpdateBundle:", commandLine[i + 1])
		end
		table.insert(Pipeline.BundlesToUpdate, commandLine[i + 1])
	end
end

if GlobalSettings.TextureBaker and GlobalSettings.TextureBaker ~= 'Disabled' then
	SetSetting("Cache", "Disabled")
	Pipeline.EnableBakeTextures = true
	Mesh.ZOnlyMeshEnable = false
	Mesh.TextureBakingEnable = true
	if GlobalSettings.TextureBaker == 'Tree' then
		LevelShaderState.MeshBillboardGenerationSupportEnable = true
	end
end

----------------------------------------------------------------------------------------
--
-- Diagnostics dump
--

if Pipeline.Verbose then
	print ""
	print "Pipeline settings summary:"
	print "------------------------------------------------------"
	
	for k,v in pairs(Pipeline) do
		print(k, v)
	end
	
	print ""

	print "Pipeline commands:"
	print "------------------------------------------------------"
	
	for _,v in pairs(Pipeline.ExecCommands) do
		print(v)
	end
	
	print ""

	print "Command line:"
	print "------------------------------------------------------"
	
	for _,v in pairs(commandLine) do
		print(_,v)
	end

	print ""
end

if Pipeline.Verbose then
	print("SKU: " .. GlobalSettings.SKU);
	print("Cache mode: " .. GlobalSettings.Cache);
	print("Service mode: " .. GlobalSettings.ServiceMode)
	print("Index mode: " .. GlobalSettings.IndexingMode)
end
