$ErrorActionPreference = 'Stop';

$packageName           = $env:ChocolateyPackageName
$softwareName          = $packageName
$version               = $env:ChocolateyPackageVersion
$url                   = "https://github.com/dorssel/usbipd-win/releases/download/v$version/usbipd-win_$version.msi"
$url64                 = $url
$checksum              = 'cfaa80ef59c68d5519763f62c1cdac3bf1409ee0d7c0ba7b4d57f3c3c343c2c1'
$checksum64            = $checksum

$packageArgs = @{
  packageName    = $packageName
  softwareName   = $softwareName

  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'

  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'

  fileType       = 'msi'
  silentArgs     = "/quiet"
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
