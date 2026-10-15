# Stores the TypeSafe "ClaudeDesktop" key as the user env var TYPESAFE_ROUTER_KEY.
# Asks for the key so it never appears on screen, in chat or in the repo.
# Restart the Claude desktop app afterwards.
$secure = Read-Host 'Paste ClaudeDesktop key' -AsSecureString
$plain = ConvertFrom-SecureString $secure -AsPlainText
[Environment]::SetEnvironmentVariable('TYPESAFE_ROUTER_KEY', $plain, 'User')
Write-Host 'Saved TYPESAFE_ROUTER_KEY. Restart the Claude app.'
