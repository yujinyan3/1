param(
    [Parameter(Mandatory = $true)]
    [string]$Operation,

    [ValidateSet("setup", "design", "code", "test", "docs", "release")]
    [string]$Category = "docs",

    [string]$Result = "See the next project update.",

    [string]$Operator = $env:USERNAME
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$logPath = Join-Path $repoRoot "docs\operation-log.md"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"

function Escape-MarkdownCell([string]$Value) {
    return ($Value -replace "\|", "\|").Replace("`r", " ").Replace("`n", " ")
}

$line = "| $(Escape-MarkdownCell $timestamp) | $(Escape-MarkdownCell $Operator) | $(Escape-MarkdownCell $Category) | $(Escape-MarkdownCell $Operation) | $(Escape-MarkdownCell $Result) |"
Add-Content -LiteralPath $logPath -Value $line -Encoding UTF8
Write-Output "Added operation log entry to $logPath"
