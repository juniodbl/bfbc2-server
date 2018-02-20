--
-- Game startup script
--

require "vfs"
core = require "Frost.Core"
logging = require "Frost.Logging"

-- The global platform variable can be used to detect which platform
-- we are currently executing on

platform = dice.getCurrentPlatformName()

-- Set up a logger which logs to the console (not stdout)
-- By default, we only show warnings or worse. For more verbose
-- diagnostics, you may set the level to INFO or DEBUG.

log = logging.console()
log:setLevel(logging.INFO)

core.import("Scripts/Game/Configure.lua")

