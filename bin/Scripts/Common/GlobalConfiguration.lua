--
-- Global Configuration
--
--   This file should be executed by all settings consumers, including the
--   game and pipeline. It contains procedural configuration logic to
--   resolve dependent settings.
--

if GetGlobalSetting("Audio") == "Disabled" then
	-- No sound -> no VO

	SetSetting("VoiceOvers", "None")
end

