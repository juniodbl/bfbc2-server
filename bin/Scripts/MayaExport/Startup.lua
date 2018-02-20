--
-- MayaExport startup script
--

MayaExport = {
	-- When Verbose is set to true, the program will emit messages to stdout, 
	-- indicating what commands and responses are sent between the pipeline 
	-- and the exporter process
	
	Verbose = false,
	IdleTimeout = 120,
	MaxConcurrentSessionCount = 2,
	SafeMode = true,
	
	contexts = {
		-- Default context
		{ 
			name='default',
			recycleMode='always', 
			enableButtonBasher=true 
		},
		-- Granny Context
		{
			name='granny',
			recycleMode='always',
			enableButtonBasher=true
		},
		-- Havok context
		{ 
			name='havok', 
			recycleMode='always', 
			enableButtonBasher=true 
		}
	}
}
