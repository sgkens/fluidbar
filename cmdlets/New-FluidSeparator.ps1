# ==============================================================================
# File: New-Separator.ps1 (Public Cmdlet)
# ==============================================================================
function New-Separator {
    <#
    .SYNOPSIS
        Provides a robust, structurally calculated horizontal rule for separating output between modules or log streams.
    .DESCRIPTION
        Provides a robust, structurally calculated horizontal rule for separating output between modules or log streams.
    .PARAMETER Char
        The character to be repeated to construct the separator.
    .PARAMETER Repeat
        Specifies the absolute character width of the generated separator.
    .PARAMETER ColorMode
        Color application: Solid, Gradient.
    .PARAMETER ColorPalette
        Custom color palette overrides.
    .PARAMETER GradientStart
        TrueColor RGB starting boundary color. Default is 60,60,60.
    .PARAMETER GradientEnd
        TrueColor RGB ending boundary color. Default is 255,255,255.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0)]
        [char]$Char = '─',

        [Parameter(Mandatory = $false)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Repeat = 50,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Solid', 'Gradient')]
        [string]$ColorMode = 'Solid',

        [Parameter(Mandatory = $false)]
        [hashtable]$ColorPalette = @{ Fill = @(128, 128, 128) },

        [Parameter(Mandatory = $false)]
        [int[]]$GradientStart = @(60, 60, 60),

        [Parameter(Mandatory = $false)]
        [int[]]$GradientEnd = @(255, 255, 255)
    )

    process {
        $palette = Get-TerminalPalette -ColorPalette $ColorPalette -ColorMode $ColorMode -GradientStart $GradientStart -GradientEnd $GradientEnd -CurrentValue 100

        if ($ColorMode -eq 'Solid') {
            $rawString = [string]$Char * $Repeat
        
            $solidCode = (& $palette.GetStaticColor 'Fill')
            if ($null -eq $solidCode) { $solidCode = "38;5;255" } 
        
            $output = (& $palette.Apply $rawString $solidCode)
            Write-Output $output
        } 
        else {
            $coloredChars = [System.Collections.Generic.List[string]]::new($Repeat)
        
            for ($i = 0; $i -lt $Repeat; $i++) {
                $code = (& $palette.GetFillColor $i $Repeat)
                $coloredChars.Add((& $palette.Apply $Char $code))
            }
        
            Write-Output (-join $coloredChars)
        }
    }
}
