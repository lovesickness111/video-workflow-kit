param([switch]$SkipPrerequisites)
. "$PSScriptRoot/common.ps1"

function Install-KitPrerequisite {
    param([string]$Command,[string]$Package)
    if (Get-Command $Command -ErrorAction SilentlyContinue) { return }
    if ($SkipPrerequisites -or !(Get-Command winget.exe -ErrorAction SilentlyContinue)) {
        throw "Missing $Command. Install $Package and rerun setup."
    }
    Invoke-KitChecked 'winget.exe' @('install','--id',$Package,'--exact','--silent','--accept-source-agreements','--accept-package-agreements')
    Refresh-KitPath
}
try { $python = Get-KitPython } catch {
    if ($SkipPrerequisites -or !(Get-Command winget.exe -ErrorAction SilentlyContinue)) { throw }
    Invoke-KitChecked 'winget.exe' @('install','--id','Python.Python.3.12','--exact','--silent','--accept-source-agreements','--accept-package-agreements')
    Refresh-KitPath
    $python = Get-KitPython
}
Install-KitPrerequisite 'node.exe' 'OpenJS.NodeJS.LTS'
Install-KitPrerequisite 'git.exe' 'Git.Git'
Install-KitPrerequisite 'ffmpeg.exe' 'Gyan.FFmpeg.Shared'
$python = Get-KitPython
& node.exe -e 'process.exit(Number(process.versions.node.split(".")[0]) >= 22 ? 0 : 1)'
if ($LASTEXITCODE -ne 0) { throw 'Node.js 22+ required. Update Node.js LTS, reopen the terminal and rerun.' }
$venvPython = Join-Path $KitRoot '.venv/Scripts/python.exe'
if (!(Test-Path -LiteralPath $venvPython)) {
    Invoke-KitChecked $python @('-m','venv',(Join-Path $KitRoot '.venv'))
}
Invoke-KitChecked $venvPython @('-m','pip','install','--requirement',(Join-Path $KitRoot 'config/python-requirements.txt'))
Push-Location (Join-Path $KitRoot 'tools/publisher')
try {
    Invoke-KitChecked 'npm.cmd' @('ci','--ignore-scripts')
    Invoke-KitChecked 'npm.cmd' @('run','build')
} finally { Pop-Location }
New-Item -ItemType Directory -Path (Join-Path $KitRoot 'local') -Force | Out-Null
$accounts = Join-Path $KitRoot 'local/accounts.json'
if (!(Test-Path -LiteralPath $accounts)) { Copy-Item -LiteralPath (Join-Path $KitRoot 'config/accounts.example.json') -Destination $accounts }
Write-Host 'Installed locally. No transcription or posting was performed.'
& "$PSScriptRoot/doctor.ps1"
