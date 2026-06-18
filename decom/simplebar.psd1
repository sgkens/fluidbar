# ==============================================================================
# File: SimpleBar.psd1
# ==============================================================================

@{
    RootModule        = 'SimpleBar.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'a1b2c3d4-e5f6-7890-1234-567890abcdef'
    Author            = 'Garvey K. Snow'
    CompanyName       = 'Phellams'
    Copyright         = '(c) 2026. All rights reserved.'
    Description       = 'Provides terminal-based ASCII and Unicode progress bars featuring ANSI styling, gradients, multi-column metrics, log tracking, and conditional color rendering.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'New-SimpleBar',
        'Invoke-SimpleBarAnimation',
        'New-VerticalBar',
        'New-3DBar',
        'New-DashboardBar',
        'New-TrailingLog',
        'New-Separator',
        'Get-TerminalBg',
        'New-SimpleSpinner',
        'New-SimpleLoader'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{
            Tags         = @('UI', 'Console', 'ProgressBar', 'ANSI', 'Dashboard', 'TUI')
            ProjectUri   = ''
            LicenseUri   = ''
            ReleaseNotes = 'Release 1.2.0: VT100 Enabler integration, restored animation wrapper, array/queue-based trailing log rendering, and strict sequence sizing separators.'
        }
    }
}