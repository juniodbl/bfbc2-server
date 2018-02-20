-- Tracker Startup script
--
--   This is executed when the data directory is registered with the tracker
--

core = require "Frost.Core"

require "os"
require "vfs"

Cache = {
	UseConsistentHashing = true,
	BuildTimeThreshold = 0,

	Realms = 
	{
		{ 
			name = "default",
			primary = {
				{name="bm-bamse.dice.ad.ea.com", size=3500},
			},
			content = {
				{name="bm-bamse.dice.ad.ea.com", size=1}
			}
		}
	}
}

print("Setup executed!")

