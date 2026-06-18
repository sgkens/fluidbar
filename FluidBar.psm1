# ==============================================================================
# File: FluidBar.psm1
# ==============================================================================
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Centralized Module Root Path Determination
$ModuleRoot = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Path)

# High-Performance .NET File Enumeration
$TargetPattern = "*.ps1"
$SearchOption = [System.IO.SearchOption]::AllDirectories
$ScriptFiles = [System.IO.Directory]::GetFiles($ModuleRoot, $TargetPattern, $SearchOption)

# Explicit Function Tracking arrays
$PublicFunctions = [System.Collections.Generic.List[string]]::new()

foreach ($File in $ScriptFiles) {
    # Skip directories used for testing, building, or git tracking
    $FileName = [System.IO.Path]::GetFileName($File)
    if ($FileName -eq 'phwriter-metadata.ps1') {
        continue
    }

    $RelativePath = $File.Replace($ModuleRoot, "")
    # Exclude build output, git, submodules, tools, and test runner folders
    if ($RelativePath -match '[\\/](dist|tools|test|automator-devops|\.git)[\\/]') {
        continue
    }

    # Dot-source in the module scope
    . $File
}

# Only gather public functions for export from the 'cmdlets' directory
$CmdletPath = [System.IO.Path]::Combine($ModuleRoot, "cmdlets")
if ([System.IO.Directory]::Exists($CmdletPath)) {
    $CmdletFiles = [System.IO.Directory]::GetFiles($CmdletPath, "*.ps1", [System.IO.SearchOption]::AllDirectories)
    foreach ($File in $CmdletFiles) {
        $FileName = [System.IO.Path]::GetFileNameWithoutExtension($File)
        if ($FileName -match '^[a-zA-Z]+-[a-zA-Z0-9]+$') {
            $PublicFunctions.Add($FileName)
        }
    }
}

# Strict Scoping Layer
# NOTE: Add Support for Alias and Variable exports if needed, currently only exporting functions from cmdlets
Export-ModuleMember -Function $PublicFunctions.ToArray() -Variable @()
