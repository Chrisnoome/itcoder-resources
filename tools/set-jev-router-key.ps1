# Stores the TypeSafe "ClaudeDesktop" key as the user env var TYPESAFE_ROUTER_KEY.
# Asks for the key so it never appears on screen, in chat or in the repo.
# Works in Windows PowerShell 5.1 and PowerShell 7. Restart the Claude app afterwards.
try {
    $secure = Read-Host 'Paste ClaudeDesktop key' -AsSecureString
    $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
    $plain = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
    if (-not $plain) { throw 'No key pasted.' }
    [Environment]::SetEnvironmentVariable('TYPESAFE_ROUTER_KEY', $plain.Trim(), 'User')
    Write-Host 'Saved TYPESAFE_ROUTER_KEY. Restart the Claude app.' -ForegroundColor Green
} catch {
    Write-Host "Failed: $($_.Exception.Message)" -ForegroundColor Red
}
Read-Host 'Press Enter to close'
