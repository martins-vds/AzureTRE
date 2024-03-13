Remove-Item -LiteralPath "C:\AzureData" -Force -Recurse
$ErrorActionPreference = "Stop"

if( ${SharedStorageAccess} -eq 1 )
{
  $Command = "net use z: \\${StorageAccountFileHost}\${FileShareName} /u:AZURE\${StorageAccountName} ${StorageAccountKey}"
  $Command | Out-File  "C:\ProgramData\Start Menu\Programs\StartUp\attach_storage.cmd" -encoding ascii
}

$PipConfigFolderPath = "C:\ProgramData\pip\"
If(!(Test-Path $PipConfigFolderPath))
{
  New-Item -ItemType Directory -Force -Path $PipConfigFolderPath
}

$PipConfigFilePath = $PipConfigFolderPath + "pip.ini"

$proxy = "${nexus_proxy_url}"

if( $proxy -ne "")
{
  $ConfigBody = @"
[global]
index = $($proxy)/repository/pypi/pypi
index-url = $($proxy)/repository/pypi/simple
trusted-host = $($proxy)
"@

  # We need to write the ini file in UTF8 (No BOM) as pip won't understand Powershell's default encoding (unicode)
  $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
  [System.IO.File]::WriteAllLines($PipConfigFilePath, $ConfigBody, $Utf8NoBomEncoding)

}

### Anaconda Config
if( ${CondaConfig} -eq 1 -and $proxy -ne "")
{
  conda config --add channels $proxy/repository/conda-mirror/main/  --system
  conda config --add channels $proxy/repository/conda-repo/main/  --system
  conda config --remove channels defaults --system
  conda config --set channel_alias $proxy/repository/conda-mirror/  --system
}

if ($proxy -ne "")
{

  # Docker proxy config
  $DaemonConfig = @"
{
"registry-mirrors": ["$($proxy):8083"]
}
"@

  $DaemonConfig | Out-File -Encoding Ascii ( New-Item -Path $env:ProgramData\docker\config\daemon.json -Force )

  $RConfig = @"
local({
    r <- getOption("repos")
    r["Nexus"] <- "$($proxy)/repository/r-proxy/"
    options(repos = r)
})
"@

  $RConfig | Out-File -Encoding Ascii ( New-Item -Path $Env:ProgramFiles\R\R-4.1.2\etc\Rprofile.site -Force )
}
