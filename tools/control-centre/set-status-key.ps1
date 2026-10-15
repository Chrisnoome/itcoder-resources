# Makes a random status key for the control centre's Platform card (15 October 2026).
# 1. Generates a 48-character key and stores it as the Windows user env var BESTLESSONS_STATUS_KEY.
# 2. Puts it on the clipboard and runs set-server-config.py STATUS_KEY for live and test:
#    when it asks for STATUS_KEY, press Ctrl+V then Enter, then confirm.
# 3. Clears the clipboard. The key is never written to a file or shown in chat.
try {
    $bytes = New-Object byte[] 36
    [Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
    $key = [Convert]::ToBase64String($bytes).Replace('+','-').Replace('/','_')
    [Environment]::SetEnvironmentVariable('BESTLESSONS_STATUS_KEY', $key, 'User')
    Set-Clipboard -Value $key
    Write-Host 'Key made and saved as BESTLESSONS_STATUS_KEY. It is on the clipboard.' -ForegroundColor Green
    Write-Host 'At the STATUS_KEY prompt: Ctrl+V, Enter, then confirm.' -ForegroundColor Yellow
    & "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/set-server-config.py" STATUS_KEY --site both
} catch {
    Write-Host "Failed: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    Set-Clipboard -Value ' '
    Write-Host 'Clipboard cleared. Restart the control centre (and the Claude app) to pick up the key.'
}
Read-Host 'Press Enter to close'
