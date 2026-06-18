# ==============================================================================
# File: FluidBar.psd1
# ==============================================================================
@{
    RootModule         = 'FluidBar.psm1'
    ModuleVersion      = '1.3.0'
    GUID               = 'a1b2c3d4-e5f6-7890-1234-567890abcdef'
    Author             = 'Garvey K. Snow'
    CompanyName        = 'Phellams'
    Copyright          = '(c) 2026 Garvey K. Snow. All rights reserved.'
    Description        = 'Provides terminal-based ASCII and Unicode progress bars featuring ANSI styling, gradients, multi-column metrics, log tracking, and conditional color rendering.'
    PowerShellVersion  = '5.1'
    FunctionsToExport  = @(
        'New-FluidBar',
        'New-FluidSpinner',
        'New-FluidLoader',
        'New-FluidSeparator',
        'New-FluidVerticalBar',
        'New-Fluid3DBar',
        'New-FluidDashboardBar',
        'New-Sparkline',
        'Join-TuiBlock',
        'New-TuiPanel',
        'Hide-TerminalCursor',
        'Show-TerminalCursor',
        'Enable-TerminalAltBuffer',
        'Disable-TerminalAltBuffer',
        'New-TrailingLog',
        'Invoke-FluidBarAnimation',
        'Get-TerminalBG',
        'Format-TuiString'
    )
    CmdletsToExport    = @()
    VariablesToExport  = @()
    AliasesToExport    = @()
    PrivateData        = @{
        PSData = @{
            Tags                     = @('UI', 'Console', 'ProgressBar', 'ANSI', 'Dashboard', 'TUI')
            ReleaseNotes             = @{
                '1.3.0' = 'Added support for value/max-value dynamic filling, custom labels and formatting patterns, styling presets, and multi-property ColorPalette overrides.'
                '1.2.0' = 'Renamed from SimpleBar to FluidBar. Implemented split-file module architecture, VT100 initialization enabler, Pester unit tests, and GitLab CI/CD build scripts.'
            }
            RequireLicenseAcceptance = $false
            LicenseUri               = 'https://choosealicense.com/licenses/mit'
            ProjectUri               = 'https://gitlab.com/phellams/fluidbar.git'
            IconUri                  = 'https://raw.githubusercontent.com/phellams/phellams-general-resources/main/logos/fluidbar/dist/png/fluidbar-logo-128x128.png'
            
            # CHOCOLATEY CONFIGURATION
            ChocoDescription         = 'Provides terminal-based ASCII and Unicode progress bars featuring ANSI styling, gradients, multi-column metrics, log tracking, and conditional color rendering.'
            ChocoTitle               = 'FluidBar'
            LicenseUrl               = 'https://choosealicense.com/licenses/mit'
            ProjectUrl               = 'https://gitlab.com/phellams/fluidbar'
            IconUrl                  = 'https://raw.githubusercontent.com/phellams/phellams-general-resources/main/logos/fluidbar/fluidbar-logo-128x128.png'
            Docsurl                  = 'https://gitlab.com/phellams/fluidbar'
            MailingListUrl           = 'https://gitlab.com/phellams/fluidbar/issues'
            projectSourceUrl         = 'https://gitlab.com/phellams/fluidbar'
            bugTrackerUrl            = 'https://gitlab.com/phellams/fluidbar/issues'
            Summary                  = 'Provides terminal-based ASCII and Unicode progress bars featuring ANSI styling, gradients, multi-column metrics, log tracking, and conditional color rendering.'
        }        
    }
    RequiredModules    = @()
    RequiredAssemblies = @()
    FormatsToProcess   = @()
    TypesToProcess     = @()
    NestedModules      = @()
    ScriptsToProcess   = @()
}
