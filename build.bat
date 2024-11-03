@REM ------- BEGIN build.bat ----------------
@setlocal
@echo off
set path="C:\Program Files\WinRAR\";%path%

winrar.exe a -afzip -m5 -ed -r -ep1 -ibck "build\lovegame-src.zip" * -x*build\*

:: rename "build\lovegame-src.zip" "build\lovegame-src.love"
cd build
rename lovegame-src.zip lovegame-src.love
cd ..

del /q "build\Classified Chaos.exe"

copy /b "C:\Users\bourp\Downloads\love-11.5-win64\love-11.5-win64\love.exe" + "build\lovegame-src.love" "build\Classified Chaos.exe"

del /q "build\lovegame-src.love"

cd build
start "Classified Chaos" "Classified Chaos.exe"