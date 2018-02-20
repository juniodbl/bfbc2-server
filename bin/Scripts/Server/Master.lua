print("Loading scripts...")

serverSaveFilePath = "/options/serverAdminSave.lua"

dofile("Scripts/Server/Startup.lua")
dofile("Scripts/Server/Shutdown.lua")
dofile("Scripts/Server/Server.lua")

print("Done loading scripts.")
