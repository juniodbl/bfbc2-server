-- Pipeline startup script
--
--   This is executed very early, and can really only be used to
--   configure settings.
--
--   The settings specified here will override any settings in the
--   legacy settings file pipeline.config
--

core = require "Frost.Core"

require "os"
require "vfs"

Environment = {}

local userName = os.getenv("USERNAME")

if userName then Environment.UserName = userName end

branchName = os.getenv("BRANCH_NAME")

if not branchName then error("Configuration error: BRANCH_NAME environment variable not set -- fix the .diceconfig file for this branch!") end

-- This is a verification tag to make sure the script is in sync with runtime
-- whenever something is changed that requires changes to be present on both
-- the script end and the runtime end, this should be updated. The value is
-- just an arbitrary string and has no semantic relevance

local expectVerificationTag = "22062007"

if verificationTag ~= expectVerificationTag then
	error("verification tag mismatch! Most likely, your data/Scripts folder is not right for your build!")
end

-- Execute configuration and setup scripts

allScriptsRoot = "/Data/Scripts/"
scriptsRoot = allScriptsRoot .. "Pipeline/"

core.import(scriptsRoot .. "Configuration.lua")
core.import(scriptsRoot .. "Layout.lua")

