# ==============================================================================
# File: New-3DBar.ps1 (Public Cmdlet)
# ==============================================================================
function New-3DBar {
    <#
    .SYNOPSIS
        Renders an extruded pipe style graphic mapped across 3 vertical lines, complete with structural caps.
    .DESCRIPTION
        Renders an extruded pipe style graphic mapped across 3 vertical lines, complete with structural caps.
    .PARAMETER Title
        Injected structurally above the rendered pipe.
    .PARAMETER Fill
        Determines the visual pipe volume.
    .PARAMETER Width
        Total visual width. Default is 40.
    .PARAMETER Subtext
        Optional descriptor injected below the output array.
    .PARAMETER ColorPalette
        Custom color palette overrides. Defaults to Fill=38;5;33 and Frame=38;5;240.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Title,

        [Parameter(Mandatory = $true)]
        [int]$Fill,

        [Parameter(Mandatory = $false)]
        [int]$Width = 40,

        [Parameter(Mandatory = $false)]
        [string]$Subtext = "",

        [Parameter(Mandatory = $false)]
        [hashtable]$ColorPalette = @{ Fill = "38;5;33"; Frame = "38;5;240" }
    )

    process {
        $palette = Get-TerminalPalette -ColorPalette $ColorPalette
        $frameCode = (& $palette.GetStaticColor 'Frame')
        $fillCode = (& $palette.GetStaticColor 'Fill')

        $innerWidth = $Width - 2
        $fillCount = [math]::Round(($Fill / 100.0) * $innerWidth)
        $emptyCount = $innerWidth - $fillCount

        $emptyDots = '·' * $emptyCount

        $topFill = '─' * $fillCount
        $rawTop = "╭$topFill╮$emptyDots"
        $coloredTop = (& $palette.Apply "[$rawTop]" $frameCode)

        $midFill = '█' * $fillCount
        $coloredMidFill = (& $palette.Apply $midFill $fillCode)
        $coloredMidEmpty = (& $palette.Apply $emptyDots $frameCode)
        $vBar = (& $palette.Apply '│' $frameCode)
        $bracketL = (& $palette.Apply '[' $frameCode)
        $bracketR = (& $palette.Apply ']' $frameCode)
    
        $coloredMid = "$bracketL$vBar$coloredMidFill$vBar$coloredMidEmpty$bracketR"

        $botFill = '─' * $fillCount
        $rawBot = "╰$botFill╯$emptyDots"
        $coloredBot = (& $palette.Apply "[$rawBot]" $frameCode)

        $out = [System.Collections.Generic.List[string]]::new()
        $out.Add("$Title")
        $out.Add("$coloredTop  $Fill%")
        $out.Add($coloredMid)
        $out.Add($coloredBot)
        if (![string]::IsNullOrWhiteSpace($Subtext)) { $out.Add($Subtext) }

        Write-Output ($out -join [Environment]::NewLine)
    }
}
