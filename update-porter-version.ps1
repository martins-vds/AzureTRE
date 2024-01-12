[CmdletBinding()]
param (
    [Parameter()]
    [ValidateSet("major", "minor", "patch")]
    [string]
    $Increment = "patch"
)

Get-childitem -Filter porter.yaml -Recurse | ForEach-Object {
    $file = $_.FullName
    $content = Get-Content $file
    $version = $content | Select-String -Pattern "^version:\s*(?<major>\d+)\.(?<minor>\d+)\.(?<patch>\d+)$" | % { 
        $major = $_.Matches[0].Groups["major"].Value
        $minor = $_.Matches[0].Groups["minor"].Value
        $patch = $_.Matches[0].Groups["patch"].Value
            
        if ($Increment -eq "major") {
            $major = [int]$major + 1
            $minor = 0
            $patch = 0
        }
        elseif ($Increment -eq "minor") {
            $minor = [int]$minor + 1
            $patch = 0
        }
        else {
            $patch = [int]$patch + 1
        }
    
        return "$major.$minor.$patch"        
    }

    $content -replace "^version:\s*.*$", "version: $version" | Set-Content $file
}