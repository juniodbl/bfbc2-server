--
-- Define basic settings tables
--

Game = {
	EnableRuntimeLogFile = true,
	UseBundles = false,
}

Client = {
}

Server = {
}

NetworkSettings = {
	Version = "V0.0",
	ProtocolVersion = 0,
	TitleId = 4,
	ClientPort = 1001,
	ServerPort = 1003,
	MaxGhostCount = 1024,
	MaxClientCount = 64,
}

Window = {
	Position = { x=0, y=0 },
	Size = { x=1280, y=720 },
	Fullscreen = false,
}

Core = {
	DiskLayoutPathPatterns = {
		-- Bundles are always ok.
		"/dist/",
		-- Code that uses the remote fs explicitly is ok, too.
		"/remote/",
		-- When using the remote FS, the VFS generates accesses to the cache path.
		"/cache/",
		-- Authorative DLC packages are OK
		"/package/",
		-- All log files are ok to read.
		".log",
		"systems/shader/pswhite_d3d10.res",
		"systems/debugrenderer",
		"systems/ui/shaders",
		-- We parse scripts at startup.
		"/scripts/",
		-- PS3 job ELFs are used in Debug/Release configurations
		"/Jobs/",	
		-- dataversion.dbx is bound explicitly in non-final configurations
		"/dataversion.dbx",
		"/data/database.dbmanifest",
		-- The UI drags in localization files from disk :-(
		"/localization/bin/",
		-- Movies stream from disk.
		"/movies/",
		-- AI files are loaded from disk.
		"/ai/levels/",
		"/aerialheightmap.res",
		-- When using final bundles, this path maps to streaming wave files.
		"/sound/streaming/",
		-- When using final bundles, this path maps to on-demand loaded wave files.
		"/sound/ondemand/",
		-- Award textures live here (bundle backend).
		"/async/awards/",
		-- Temp is a non-final output path for things such as profiler reports.
		"/temp/",
		-- In non-final bundle mode, we have to allow /sound/ since on-demand and streaming files are still on disk.
		"/sound/",
		"/mesh/streaming/",
		".lua",
		".omg",
		"checksum",
		"tmpchksum",
		"gameDataInfo/",
		"_description.dbx",
		-- Demo recordings get stored here
		"demos/",
		-- Files stored on the user's PC, in the local user's game-specific directory (C:\Users\<username>\BFBC2 on this machine for instance), are accessed via this alias
		"/data/local/",
		-- All files specific for a server instance (server config files, PB temp files, etc)
		"/serverinstance/"
	}
}
