@echo off
rem --------------------------------------------------------------------
rem A script to build libpng locally
rem Usage build.cmd <platform> <configuration>
rem        platform: either 'X64' or 'x86'
rem                  'amd64' is accepted as well and converted to 'X64'
rem                   (load-library) default is 'X64'
rem        configuration: either 'debug' or 'release'
rem                   (load-library) default is 'debug'
rem --------------------------------------------------------------------

cd ..
SET libpng_repo="https://github.com/glennrp/libpng"
SET libpng_version="v1.6.37"

@echo on

IF NOT EXIST libpng (git clone -q --branch=%libpng_version% %libpng_repo% libpng)
IF NOT EXIST zlib  powershell -ExecutionPolicy Bypass %~dp0\..\EZTools\load-library.ps1 zlib %1 %2

powershell -ExecutionPolicy Bypass .\build-libpng.ps1 %1 %2 -configure

cd %~dp0


