--
-- Game configuration script
--

-- Local helper functions
function commandLine:lookup(name, default)
	local value = self[string.lower(name)]

	return value or default
end

local function cmdLineSwitch(switchName, fieldName, inTable)
	local table = inTable or Game

	if (commandLine:lookup(switchName)) then
		table[fieldName] = true
	end
end

function cmdLineOption(optionName, default)
	return commandLine:lookup(optionName, default)
end

local function readCfg(name)
	log:debug("reading cfg: " .. name)
	core.readKeyValueCfg(name, _G)
end

---------------------------------------------------------------------------
-- Import the global settings file to get settings which should apply to 
-- all components in the system
core.import("Scripts/GlobalSettings.lua")

---------------------------------------------------------------------------
-- Parse settings from environment and commandline
--

ApplyEnvironmentVariableSettings()
ApplyCommandLineSettings(commandLine)

-- Perform computed configuration based on global settings (for dependent
-- settings)

core.import("Scripts/Common/GlobalConfiguration.lua", "global configuration");

-- Basic settings 
core.import("Scripts/Game/Settings.lua")

-- Import old-school cfg files for backwards compatibility
--local defaultConfigFile = commandLine:lookup("defaultConfig")
--if defaultConfigFile then
--	readCfg(defaultConfigFile)
--else
--	log:debug("reading Game.cfg")
--	readCfg("Game.cfg")
--end


local diceRetail = commandLine:lookup("dice_retail")

if not diceRetail then
	log:debug("reading non DICE_RETAIL User.Game.cfg")
	readCfg("User.Game.cfg")
end
		
--readCfg("GameSettings.cfg")

if not diceRetail then
	log:debug("reading non DICE_RETAIL User.GameSettings.cfg")
	readCfg("User.GameSettings.cfg")
end

----------------------------------------------------------------------------
-- Procedural configuration
--

if GlobalSettings.ResourceBundleMode then
	if GlobalSettings.ResourceBundleMode ~= "Disabled" then
		Game.UseBundles = true
	else
		Game.UseBundles = false	
	end
end

if GlobalSettings.TextureBaker and GlobalSettings.TextureBaker ~= 'Disabled' then
--	[djo]: todo: runtime settings for texture baking
end

--------------------------------------------------------------------------
-- Platform configuration
--

local currentPlatform = dice.getCurrentPlatformName()
local platformArgument = commandLine:lookup("platform")

if currentPlatform == "Win32" then
	if platformArgument then
		platformArgument = string.lower(platformArgument)

		if (platformArgument ~= "ps3" and platformArgument ~= "xenon" and platformArgument ~= "win32") then
			error("Unknown platform specified in -platform argument! (" .. tostring(platformArgument) .. ")")
		end

		readCfg(platformArgument .. "GameSettings.cfg")
	end
elseif currentPlatform == "Xenon" or currentPlatform == "Ps3" or currentPlatform == "Win32" then
	readCfg(currentPlatform .. "GameSettings.cfg")
end

--------------------------------------------------------------------------
-- Handle any Drone override options
--

local customConfigFile = commandLine:lookup("customConfig") or commandLine:lookup("config")

if customConfigFile then
	readCfg(customConfigFile)	
end

--------------------------------------------------------------------------
-- Handle commandline options
--
--   Commandline options effectively override any settings specified
--   elsewhere.
--

if not Game then Game = {} end

cmdLineSwitch("verbose", "Verbose")

Window.Size.x = cmdLineOption("windowWidth", Window.Size.x)
Window.Size.y = cmdLineOption("windowHeight", Window.Size.y)
Window.Position.x = cmdLineOption("windowPosX", Window.Position.x)
Window.Position.y = cmdLineOption("windowPosY", Window.Position.y) 
Window.Fullscreen = cmdLineOption("fullscreen", Window.Fullscreen)

if Game.Verbose then
	print "------------Commandline parameters:"
	for k,v in pairs(commandLine) do print (k,v) end
end

-- Handle <Table>.<Member> settings

for _,option in ipairs(commandLine) do
	local table,member = string.match(option, "^%-(%w+)%.(%w+)")

	if table and member then
		local value = commandLine[_ + 1] 
		if not _G[table] then _G[table] = {} end
		_G[table][member] = value 
	end
end

--

log:debug("Bundles are " .. (Game.UseBundles and "on" or "off"))
