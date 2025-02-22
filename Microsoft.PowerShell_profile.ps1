# Set the execution policy to allow running scripts
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Import useful modules
Import-Module PSReadLine
Import-Module PowerShellGet
Import-Module Pester

# Set the default error action preference to 'Stop'
$ErrorActionPreference = 'Stop'

# Set the default output encoding to UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Enable tab completion for cmdlets, functions, and aliases
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Enable syntax highlighting
Set-PSReadLineOption -Colors @{
    Command = 'DarkGreen'
    Parameter = 'DarkCyan'
    Variable = 'DarkYellow'
    String = 'DarkMagenta'
    Number = 'DarkGray'
    Type = 'DarkBlue'
    Operator = 'DarkRed'
    Comment = 'DarkGray'
}

# Set the prompt to display current directory and git branch
function prompt {
    $gitBranch = $(git rev-parse --abbrev-ref HEAD 2>$null)
    $gitUsername = $(git config user.name)
    
    if ($gitBranch) {
        "$PWD [$gitBranch] ($gitUsername)>"
    } else {
        "$PWD ($gitUsername)>"
    }
}

# Improved prediction settings
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -MaximumHistoryCount 10000

# Display profile path at the start of the session
Write-Host "Profile loaded from $PROFILE" -ForegroundColor Green

# Add custom aliases
Set-Alias -Name ll -Value Get-ChildItem -ErrorAction SilentlyContinue
Set-Alias -Name cdp -Value Set-Location -ErrorAction SilentlyContinue
Set-Alias -Name np -Value New-Item -ErrorAction SilentlyContinue