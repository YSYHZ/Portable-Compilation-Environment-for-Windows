@echo off
net session>nul 2>nul && goto nx || echo Please run as admin
pause
exit

:nx
set "letter=%~dp0"
::cd %letter%
::判断是否存在软件便携版和判断该脚本是否在正确的文件夹下，先不做
set "My_CODE=%letter%Visual Studio Code\VSCode-win32-x64-1.95.3"
set "My_CONDA=%letter%Miniconda3\Scripts"
set "My_GCC=%letter%MinGW\bin"
set "My_CMAKE=%letter%cmake-3.31.1-windows-x86_64\bin"
for /f "skip=2 tokens=2,* delims= " %%i in ('reg query "HKEY_CURRENT_USER\Environment" /v "Path"') do set "USERPATH=%%j"
if "%USERPATH:~-1,1%"==";" (set "USERPATH=%USERPATH:~0,-1%") 
ECHO.
ECHO Enter the option you want to set as a user variable from the following options:
ECHO   1 - Visual Studio Code
ECHO   2 - Miniconda3
ECHO   3 - MinGW
ECHO   4 - Cmake
ECHO   5 - All of the above
ECHO   6 - EXIT
ECHO.
CHOICE /C:123456

IF errorlevel 6 EXIT
IF errorlevel 5 goto FIVE
IF errorlevel 4 goto FOUR
IF errorlevel 3 goto THREE
IF errorlevel 2 goto TWO
IF errorlevel 1 goto ONE

:ONE
where code 2>nul && echo Visual Studio code is already in the system path && goto nx
set "USERPATH=%USERPATH%;%My_CODE%"
reg add "HKEY_CURRENT_USER\Environment" /v "Path" /t REG_EXPAND_SZ /d "%USERPATH%" /f
echo Restart the resource manager in 3 seconds & timeout /T 3 /NOBREAK
taskkill /im explorer.exe /f
explorer.exe
exit

:TWO
where conda 2>nul && echo Miniconda3 is already in the system path && goto nx
set "USERPATH=%USERPATH%;%My_CONDA%"
reg add "HKEY_CURRENT_USER\Environment" /v "Path" /t REG_EXPAND_SZ /d "%USERPATH%" /f
echo Restart the resource manager in 3 seconds & timeout /T 3 /NOBREAK
taskkill /im explorer.exe /f
explorer.exe
exit

:THREE
where gcc 2>nul && echo MinGW is already in the system path && goto nx
set "USERPATH=%USERPATH%;%My_GCC%"
reg add "HKEY_CURRENT_USER\Environment" /v "Path" /t REG_EXPAND_SZ /d "%USERPATH%" /f
echo Restart the resource manager in 3 seconds & timeout /T 3 /NOBREAK
taskkill /im explorer.exe /f
explorer.exe
exit

:FOUR
where cmake 2>nul && echo Cmake is already in the system path && goto nx
set "USERPATH=%USERPATH%;%My_CMAKE%"
reg add "HKEY_CURRENT_USER\Environment" /v "Path" /t REG_EXPAND_SZ /d "%USERPATH%" /f
echo Restart the resource manager in 3 seconds & timeout /T 3 /NOBREAK
taskkill /im explorer.exe /f
explorer.exe
exit

:FIVE
set "NEW_USERPATH=%USERPATH%"
where code 2>nul && echo Visual Studio code is already in the system path || set "NEW_USERPATH=%NEW_USERPATH%;%My_CODE%"
where conda 2>nul && echo Miniconda3 is already in the system path || set "NEW_USERPATH=%NEW_USERPATH%;%My_CONDA%"
where gcc 2>nul && echo MinGW is already in the system path || set "NEW_USERPATH=%NEW_USERPATH%;%My_GCC%"
where cmake 2>nul && echo Cmake is already in the system path || set "NEW_USERPATH=%NEW_USERPATH%;%My_CMAKE%"
if "%NEW_USERPATH%" neq "%USERPATH%" (
reg add "HKEY_CURRENT_USER\Environment" /v "Path" /t REG_EXPAND_SZ /d "%NEW_USERPATH%" /f
echo Restart the resource manager in 3 seconds & timeout /T 3 /NOBREAK
taskkill /im explorer.exe /f
explorer.exe
exit
) else (echo. & echo No change & goto nx)