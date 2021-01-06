Param (
#  platform: either 'amd64' or 'x86'
#            'X64' is accepted as well and converted to 'amd64'
   [parameter(Mandatory=$false)][string]$platform="amd64",
#  platform: either 'debug' or 'release'
   [parameter(Mandatory=$false)][string]$configuration="debug",
# configure switch implies running vcvarsall.bat through CmdScript to inherit environment variables (local build)
   [parameter()][switch]$configure
)

 switch($platform) {
   "X64"   { $platform = "amd64"; break;  } 
   "x86"   { break; } 
   "amd64" { break; } 
   default { "build-libpng.ps1: platform <" + $platform + "> was not recognized"; exit (-1);  } 
 }

 $env:CFLAGS = '-nologo -D_CRT_SECURE_NO_DEPRECATE -D_CRT_SECURE_NO_WARNINGS -W3 -Zi -Fd"libpng"'
 switch($configuration) {
   "release" { 
     $env:CFLAGS = $env:CFLAGS + ' -MD -O2'
     break; 
   } 
   "debug"   { 
     $env:CFLAGS = $env:CFLAGS + ' -MDd -Od'
     break; 
   } 
   default   { "build-libpng.ps1: configuration <" + $configuration + "> was not recognized"; exit (-1);  } 
 }

 $env:INCLUDE = "..\zlib\include;" + $env:INCLUDE
 $env:LIB     = "..\zlib\lib;" + $env:LIB



 if ($configure) {
  .\EZTools\use-environment.ps1 "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" $platform
 } 

 "CFLAGS:        " + $env:CFLAGS
 "LIB:           " + $env:LIB
 "INCLUDE:       " + $env:INCLUDE

 $dname = Get-Location

 $bp =  @("-e", "-x -",
          "-f", "scripts\makefile.vcwin32",  
          "libpng.lib") 

 Set-Location "libpng"
 & nmake $bp
 Set-Location $dname
