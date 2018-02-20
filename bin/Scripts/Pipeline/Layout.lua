--
-- Bundle layout rules
--

BundleLayout = {
	-- If this changes, all bundles will be invalidated and rebuilt. Change 
	-- this whenever the layout rules are changed
	
	signature = "sboberg_1",
	
	patterns = {
		{ "^AI/.*", "/AI" },
	}
}

--
-- Map filename -> bundle name
--
--  This function is called by the pipeline whenever it needs to classify 
--  an output file. The filename passed is the file name relative to the
--  platform root directory.
--

function BundleLayout:mapFilenameToBundle(fileName)
	-- First try the pattern table

	for _, pair in ipairs(self.patterns) do
		assert(#pair == 2, "patterns must contain {string,string} pairs only!")

		if (string.match(fileName, pair[1])) then
			return pair[2]
		end
	end
	
	if (string.match(fileName, ".*%.dbx$")) then
		return "dbx"
	end
	
	return nil		-- Don't put in a bundle!
end

function mapFilenameToBundle(fileName)
	return BundleLayout:mapFilenameToBundle(fileName)
end

--
-- Bundler settings
--

BundleBuilder = {
	RootEntries = { 
		{
			BundleName = "VO", 
			RootPartitions = { 
				"Sound/VO/VO_Common", 
				"Sound/VO/VO_EN",
				"Sound/VO/VO_IT",
				"Sound/VO/VO_FR",
				"Sound/VO/VO_ES",
				"Sound/VO/VO_DE",
				"Sound/VO/VO_PL",
				"Sound/VO/VO_RU"
			},
			IncludeResources = false,
		}
	}
}

