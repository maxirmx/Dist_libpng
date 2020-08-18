@echo off
rem --------------------------------------------------------------------
rem A script to generate NMake command line and execute it 
rem Usage build.cmd <platform> <configuration>
rem        platform: either 'amd64' or 'X64' or 'x86'
rem        configuration: either 'debug' or 'release'
rem --------------------------------------------------------------------

IF "%1"=="x86" (
rem  echo Building for x86 
) ELSE (
IF "%1"=="X64" (
rem  echo Building for X64 aka amd64 
) ELSE (
IF "%1"=="amd64" (
rem  echo Building for X64 aka amd64
) ELSE (
  echo Platform "%1" was not recognized
  exit -1 
)
)
)


IF "%2"=="release" (
rem  echo Building release 
  SET CFLAGS=-nologo -D_CRT_SECURE_NO_DEPRECATE -D_CRT_SECURE_NO_WARNINGS -MD -O2 -W3 -Zi -Fd"libpng"
) ELSE (
IF "%2"=="debug" (
rem  echo Building debug
  SET CFLAGS=-nologo -D_CRT_SECURE_NO_DEPRECATE -D_CRT_SECURE_NO_WARNINGS -MDd -Od -W3 -Zi -Fd"libpng"
) ELSE (
  echo Configuration "%2" was not recognized
  exit -1 
)
)

SET INCLUDE=..\zlib\include;%INCLUDE%
SET LIB=..\zlib\lib;%LIB%

echo CFLAGS:  ^<%CFLAGS%^>
echo INCLUDE: ^<%INCLUDE%^>
echo LIB:     ^<%LIB%^>

rem --------------------------------------------------------------------
rem nmake -e Causes environment variables to override makefile macro definitions.
rem          (CFLAGS) 
rem --------------------------------------------------------------------

@echo on
cd libpng
nmake -e -f scripts\makefile.vcwin32 libpng.lib
cd ..

