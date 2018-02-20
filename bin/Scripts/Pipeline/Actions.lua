--
-- This script defines custom pipeline actions
--

Actions = {}

function Actions:buildPathData(levelName)
	Level.ForceBuildPathfinding = true

	addAsset("Levels/" .. levelName, "Win32")
end

function Actions:buildMayaData()
	Pipeline.ServiceMode = false

	addAsset("Materials/Materials", "Editor")
end
	
function Actions:bakeTextures(options)
	Pipeline.ServiceMode = false

	assert(options.Mesh and options.Lod and options.TexCoord and options.Technique and options.Width and options.Height, "Incorrect arguments to bakeTextures")

	TextureBaker = {
		Passes = {
			options
		}
	}

	applySettings()

	addAsset(options.Mesh, "Win32")
end

