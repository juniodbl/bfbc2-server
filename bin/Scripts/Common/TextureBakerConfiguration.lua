#!/bin/lua

--
-- Texture-baking related setup
--
	
if GlobalSettings.TextureBaker == 'Tree' then
	TextureBaker = { }
	TextureBaker.Passes =
	{
		{
			["Mesh"] = '',
			["TextureName"] = '',
		},
	}
end

if GlobalSettings.TextureBaker == 'Mesh' then
	TextureBaker = { }
	TextureBaker.Passes =
	{
		{
			["Mesh"] = 'Objects/Architecture/EUR/EUR_House_10x8_S_f01t01v01/EUR_House_10x8_S_f01t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/EUR/EUR_House_12x12_S_f02t01v01/EUR_House_12x12_S_f02t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/EUR/EUR_House_12x8_S_f02t01v01/EUR_House_12x8_S_f02t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/EUR/EUR_House_14x8_S_f02t01v01/EUR_House_14x8_S_f02t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/EUR/EUR_House_18x10_S_f01t01v01/EUR_House_18x10_S_f01t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/EUR/EUR_House_18x14_S_f01t01v01/EUR_House_18x14_S_f01t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/EUR/EUR_House_8x8_S_f01t01v01/EUR_House_8x8_S_f01t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Industry/IND_CommsCenter_t01v01/IND_CommsCenter_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Industry/IND_FactoryOffice_t01v01/IND_FactoryOffice_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Industry/IND_HydroGenerator_t01v01/IND_HydroGenerator_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Industry/IND_SmallFactory_t01v01/IND_SmallFactory_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Industry/IND_Warehouse_t01v01/IND_Warehouse_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/MEC/MEC_House_8x8_S_f01t01v01/MEC_House_8x8_S_f01t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/MEC/MEC_House_12x8_S_f01t01v01/MEC_House_12x8_S_f01t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/MEC/MEC_House_12x12_S_f02t01v01/MEC_House_12x12_S_f02t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/MEC/MEC_House_18x10_S_f01t01v01/MEC_House_18x10_S_f01t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/MEC/MEC_House_18x14_S_f02t01v01/MEC_House_18x14_S_f02t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/MEC/MEC_House_18x14_S_f02t01v01/MEC_HousePart_18x14_t01v01/MEC_HousePart_18x14_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Military/MIL_Watchtower_t01v01/MIL_Watchtower_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Unique/UNI_Monastery_t01v01/UNI_Monastery_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Unique/UNI_Monastery_t03v01/UNI_Monastery_t03v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Unique/UNI_Palace_t01v01/UNI_Palace_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Common/COM_Barn_t01v01/COM_Barn_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Common/COM_Barrack_t01v01/COM_Barrack_t01v01_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Common/COM_Barrack_t02v02/COM_Barrack_t02v02_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
		{
			["Mesh"] = 'Objects/Architecture/Common/COM_Barrack_t02v03/COM_Barrack_t02v03_Mesh',
			["Lod"] = 0,
			["TexCoord"] = 3,
			["Technique"] = 1,
			["Width"] = 512,
			["Height"] = 512,
		},
	}	
end
