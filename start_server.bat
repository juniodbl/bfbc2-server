@echo off

::Edit the following parameters

::Only change this, when you want to run a Vietnamserver (1 - enabled; 0 - disabled
set vietnam=0
::Change this to set your serverlocation (e.g. EU)
set region=EU
::Change this to set a title for the commandprompt (e.g. Bad Company 2: Best Maps)
set title=Bad Company 2: Best Maps



:: Do not touch anything after that, unless you know what you do!
title %title%
:server
echo Starting server...
cd bin\
Frost.Game.Main_Win32_Final.exe -serverInstancePath "..\instances\bc2" -mapPack2Enabled %vietnam% -timeStampLogNames -region %region% -heartBeatInterval 20000 -displayErrors 0 -displayAsserts 0 -plasmalog 1
echo.
echo Server is restarting in 5 seconds...
ping -n 5 127.0.0.1 > nul
goto server