@echo off
rem --------------------------------------------------------------------
rem Test script to validate some steps of the build procedures locally
rem Usage test.cmd <platform> <configuration>
rem        platform: either 'amd64' or 'X64' or 'x86'
rem        configuration: either 'debug' or 'release'
rem --------------------------------------------------------------------
@echo on

cd ..
SET libpng_repo="https://github.com/glennrp/libpng"
IF NOT EXIST libpng (git clone -q --branch=master %libpng_repo% libpng)
rem cmd.exe /c build.cmd %1 %2                                                                             
cd local


