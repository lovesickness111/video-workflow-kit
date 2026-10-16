. "$PSScriptRoot/common.ps1"
$localDir = Join-Path $KitRoot 'local'
New-Item -ItemType Directory -Path $localDir -Force | Out-Null
$file = Join-Path $localDir 'secrets.env'
$values = [ordered]@{}
if (Test-Path -LiteralPath $file) {
    foreach ($line in [IO.File]::ReadAllLines($file)) {
        if ($line -match '^([A-Z_][A-Z0-9_]*)=(.*)$') { $values[$matches[1]]=$matches[2] }
    }
}
foreach ($name in @('ELEVENLABS_API_KEY','ZERNIO_API_KEY')) {
    Write-Host "$name - press Enter to keep the existing value or skip. Input is hidden."
    $secure = Read-Host -Prompt $name -AsSecureString
    $pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
    try {
        $plain = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer)
        if ($plain.Length -gt 0) {
            if ($plain -match '[\r\n]') { throw 'Key must be one line.' }
            $values[$name] = $plain.Trim()
        }
    } finally {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer)
        $plain = $null
        $secure.Dispose()
    }
}
$lines = foreach ($entry in $values.GetEnumerator()) { $entry.Key + '=' + $entry.Value }
[IO.File]::WriteAllLines($file,[string[]]$lines,(New-Object Text.UTF8Encoding($false)))
if (!(Test-Path -LiteralPath (Join-Path $localDir 'accounts.json'))) {
    Copy-Item -LiteralPath (Join-Path $KitRoot 'config/accounts.example.json') -Destination (Join-Path $localDir 'accounts.json')
}
Write-Host 'Saved keys locally without displaying them. Do not share local/secrets.env.'
