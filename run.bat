@echo off
REM Ask for the file/module name
set /p name=Enter name: 

echo.
echo ===== Compiling with Icarus Verilog =====
iverilog -o .\%name%.vvp .\%name%.v .\%name%_tb.v
if errorlevel 1 (
    echo  Compilation FAILED
    pause
    exit /b
)
echo  Compilation completed successfully

echo.
echo ===== Running Simulation =====
vvp .\%name%.vvp
if errorlevel 1 (
    echo  Simulation FAILED
    pause
    exit /b
)
echo  Simulation completed successfully

echo.
echo ===== Opening GTKWave =====
gtkwave .\%name%.vcd
if errorlevel 1 (
    echo  GTKWave FAILED to open
    pause
    exit /b
)
echo  GTKWave opened successfully

echo.
echo ===== All tasks completed =====
cls

pause
exit
