require "vfs"
require "os"

levelList = {}
currentLevelIndex = 0
maxLevelIndex = 0

function Server_LoadNextLevel()


  if (levelList[currentLevelIndex] ~= nil) then
	print("Loading level: " .. levelList[currentLevelIndex])
	loadNextLevel(levelList[currentLevelIndex])
	if (currentLevelIndex < maxLevelIndex) then
	  currentLevelIndex = currentLevelIndex + 1
	else
	  currentLevelIndex = 1
	end
  else
    print("Levelindex " .. currentLevelIndex .. " do not exist")
  end
  
end

function Server_AddLevel(levelName)

  maxLevelIndex = maxLevelIndex + 1	
  levelList[maxLevelIndex] = levelName
  print("Added level '" .. levelName .. "' to level list")
  writeServerData()
  if (currentLevelIndex == 0) then
    currentLevelIndex = 1
  end
  
end

function Server_RemoveLevel(levelIndex)

  if (levelList[levelIndex] ~= nil) then
	print("Removing level '" .. levelList[levelIndex] .. "' at index: " .. levelIndex)
	--table.remove(levelList, levelIndex)
	for i=levelIndex,(maxLevelIndex-1),1 do
	  levelList[i] = levelList[i+1]
	end
	table.remove(levelList, maxLevelIndex)
	maxLevelIndex = maxLevelIndex - 1
	
	writeServerData()
	if (currentLevelIndex > maxLevelIndex) then
      currentLevelIndex = maxLevelIndex
    end
  else
    print("No level at index: " .. levelIndex)
  end

end

function Server_ListLevels()
   
  for k,v in pairs(levelList) do
	if (k == currentLevelIndex) then
	  print("[" .. k .. "]: " .. v .. " <<")
	else
	  print("[" .. k .. "]: " .. v)
	end
  end
  
end

function writeServerData()

  local currentPlatform = string.lower(dice.getCurrentPlatformName())
  if (currentPlatform == "xenon" or currentPlatform == "ps3") then
    return
  end
  
  local f = vfs.open(serverSaveFilePath, "w")
  
  if not f then
	-- File not found
	return
  end 
  
  serializedTable = tableToString(levelList)
  
  f:write("levelList = " .. serializedTable .. "\n")
  
  --print("Wrote to file: levelList = " .. serializedTable)
  
  
  
  f:close()

end
