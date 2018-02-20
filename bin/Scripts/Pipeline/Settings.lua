--
-- Internal Pipeline settings
--
--   This is not really the best place to change settings locally,
--   please see GlobalSettings.lua instead and use it if at all
--   possible
--

Pipeline = 
{
	Verbose = false,
	Rebuild = false,
	ShowReason = true,
	AddToPerforce = false,
	DisableChangeMonitor = false,

	--	Debugging options
	Profiler = false,
	DebugMode = false,
	EnableTimingLog = false,

	EnablePostBuildSteps = false,

	BinaryResultObjects	= false,
	ResultObjectLruSize	= 1000,
	
	UseBinaryXml = true,
	BundleCommitFailuresAreWarnings = false,
}

Core = 
{
	LogLevel = "Info",
}

Cache = 
{
	UseConsistentHashing = true,
	TimeToLive = 120,
        BuildTimeThreshold = 0,
	UpstreamAvalancheNode = "dice-bm40",
	EnableTugelaCache = false,
}



				
local contentCacheConfig;


contentCacheConfig = {
	{name="10.20.96.148", size=3000},		-- dice-bm150
	{name="10.20.96.149", size=5000},		-- dice-bm151
	{name="10.20.96.160", size=7000}		-- dice-bm152
}


Cache.realms = 
{
	{
		name = "default",
		content = contentCacheConfig
	},
}

Animation = 
{
	ForceLowQuality  = false,
	ExportSettings = 'Animations/Settings/AnimationPipelineExportSettings',
}

-- Don't set RebuildHavokSourceAssets to true without consulting TnT --jgi
Havok = 
{
	WriteShapeLog = false,
	WriteMemoryLog = false,
	ErrorOnStaticValidationError = true,	
	RebuildHavokSourceAssets = false,
	DetailExport = true,
	LogTriangleDensity = true,
	UseNewImportCode = false,
}

HavokComposite =
{
	WriteShapeLog = false,
	WriteMemoryLog = false,
	ErrorOnStaticValidationError = true,	
	RebuildHavokSourceAssets = false,
	DetailExport = true,
	LogTriangleDensity = true,
	UseNewImportCode = false,

	AllowDefaultCollisionShape = true
}

Texture =
{
	SkipMipmapsPs3Enable = true
}

Mesh = 
{
	Verbose = false,
	ZOnlyMeshEnable = true,
	StripTreeMeshesEnable = true,
	TootleOptimizeEnable = false,
	Ps3EdgeEnable = true,
	Ps3EdgeCompressPositionsEnable = true,	
	Ps3EdgeCompressIndicesEnable = true,	
	Ps3EdgeMinSubsetTriangleCount = 0,
	
	StreamingEnable = true,
	Ps3StreamingEnable = true,
	XenonStreamingEnable = false,
	Win32StreamingEnable = false,
	MinStreamingLodSize = 32768,
	
	SootSkipShaderNames =
	{
		"Template",
		"Tmpl",
		"NoSoot"
	},
	WarningsAsErrorsEnable = false,
}

LightMap =
{
	LightMapsEnable = true,
--	RenderLightMapsEnable = true,
--	ForceRenderLightMaps = true,
--	SaveDebugMeshesEnable = true,

	LightMapTextCoord = "TexCoord3",
	
	LightMapSkipShaderNames = 
	{
		"glass",
		"dirt"
	}
}

Level = 
{
	VoAnimTreesEnable = true,
}

LevelShaderState =
{
	SimpleShaderEnable = false,
	SeperateMeshShaderDbs = false,
	SingleDb = true,
	Dx10PathEnable = false,
	TerrainDebugColorEnable = false,
	TerrainOverdrawModeEnable = false,

	PointLightCount = 1,

	VanillaShadowmapsEnable = true,
	CascadedBox3ShadowmapsEnable = true, 
--	CascadedBox4ShadowmapsEnable = true, 	
}

SceneShaderState = 
{
	SimpleShaderEnable = false,
	SeperateMeshShaderDbs = false,
	SingleDb = true,
	Dx10PathEnable = true,
	TerrainDebugColorEnable = true,
	TerrainOverdrawModeEnable = true,
	
	PointLightCount = 1,
	
	VanillaShadowmapsEnable = true,
	CascadedBox3ShadowmapsEnable = true, 
--	CascadedBox4ShadowmapsEnable = true, 	
}

ShaderDatabase = 
{
	UseRemoteCache = true,				-- Cannot be enabled when ManualSourceChangeEnable is used.
										-- Will not result in error but ManualSourceChangeEnable will
										-- be skipped
	UseSourceCodeDigestAsKey = false,	-- When true, the source code digest is used as cache key 
										-- (very safe, but due to pipeline indeterminism the hit
										-- rate is quite low).
										-- Otherwise, the shader ID is used (slightly less safe)
	SaveDebugInfo = false,
	ForceCompileInConstantsEnable = true,
	Ps3PackVertexElementsEnable = true,
	Ps3ForceHalfPrecisionEnable = false,
	Ps3ForceVertexDynamicBranchesEnable = false,
	Ps3ForcePixelDynamicBranchesEnable = false,
	NonFiniteColoringEnable = false,
	ManualSourceChangeEnable = false,
	StateMetricsEnable = false,
	StateSolutionCacheEnable = false,
	DatabaseCache = true
}

Terrain = 
{
	MaskFunctionsEnable = false,	
	
	RedundantMaterialNameStrings = 
	{ 
		"SP01_",
		"SP02_",
		"SP03_",
		"SP04_",
		"SP05_",
		"SP06_",
		"SP07_",
		"SP08_",
		"SP09_",
		"MP_BeachHead_",
		"MP_Harbor_",
		"MP_Ignition_",
		"MP_Monastery_",
		"_Material",
		"_Mtrl"
	}
}

MayaDependencies = 
{
	MayaVersion = 700
}

VoiceOverTree = {
	EnableCommon = false,
	EnableEnglish = false,
	EnableFrench = false,
	EnableGerman = false,
	EnableItalian = false,
	EnableSpanish = false,
	EnableJapanese = false,
	EnablePolish = false,
	EnableRussian = false
}

Wave = {
	ForceLowMemory = false
}
