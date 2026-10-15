# Makes the keys for the control centre's Corrections card (block-sections-design.md, Phase 3, 15 October 2026).
# One key per site, because the test site is plain http: a key seen there must not open live.
# For live, then test:
# 1. Generates a 48-character key and stores it as the Windows user env var BESTLESSONS_BLOCKS_KEY_LIVE / _TEST.
# 2. Puts it on the clipboard and runs set-server-config.py blockRequestsKey for that site:
#    when it asks for blockRequestsKey, press Ctrl+V then Enter, then confirm.
# 3. Clears the clipboard. A key is never written to a file or shown in chat.
# Optional, for the local testbed: set BESTLESSONS_LOCAL_URL (http://localhost:8081/) and
# BESTLESSONS_BLOCKS_KEY_LOCAL to the blockRequestsKey in the local config/config.php.
foreach ($site in @('live', 'test')) {
    try {
        $bytes = New-Object byte[] 36
        [Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
        $key = [Convert]::ToBase64String($bytes).Replace('+','-').Replace('/','_')
        $name = 'BESTLESSONS_BLOCKS_KEY_' + $site.ToUpper()
        [Environment]::SetEnvironmentVariable($name, $key, 'User')
        Set-Clipboard -Value $key
        Write-Host "The $site key is made and saved as $name. It is on the clipboard." -ForegroundColor Green
        Write-Host 'At the blockRequestsKey prompt: Ctrl+V, Enter, then confirm.' -ForegroundColor Yellow
        & "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/set-server-config.py" blockRequestsKey --site $site
    } catch {
        Write-Host "Failed for ${site}: $($_.Exception.Message)" -ForegroundColor Red
    } finally {
        Set-Clipboard -Value ' '
    }
}
Write-Host 'Clipboard cleared. Restart the control centre (and the Claude app) to pick up the keys.'
Read-Host 'Press Enter to close'
