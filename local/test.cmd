@echo off
rem --------------------------------------------------------------------
rem Test script to validate some steps of the build procedures locally
rem Usage test.cmd <platform> <configuration>
rem        platform: either 'amd64' or 'X64' or 'x86'
rem        configuration: either 'debug' or 'release'
rem --------------------------------------------------------------------

cd ..
SET libpng_repo="https://github.com/glennrp/libpng"
SET libpng_version="v1.6.37"

@echo on

IF NOT EXIST libpng (git clone -q --branch=%libpng_version% %libpng_repo% libpng)
IF NOT EXIST zlib  powershell -ExecutionPolicy Bypass %~dp0\..\EZTools\load-library.ps1 zlib %1 %2

cmd /c build.cmd %2

cd cd %~dp0


