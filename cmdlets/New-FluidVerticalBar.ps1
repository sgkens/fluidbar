# ==============================================================================
# File: New-VerticalBar.ps1 (Public Cmdlet)
# ==============================================================================
function New-VerticalBar {
    <#
    .SYNOPSIS
        Renders a multi-column TUI chart natively handling variable arrays via hashtable/ordered dictionary data inputs.
    .DESCRIPTION
        Renders a multi-column TUI chart natively handling variable arrays via hashtable/ordered dictionary data inputs.
    .PARAMETER Data
        Key-Value pairs driving column headers and percentage heights.
    .PARAMETER Height
        Total terminal lines utilized for the Y-axis. Default is 10.
    .PARAMETER Style
        Style selection: FullBlock, ShadeStack, BrailleCol, ThinPipe, DoublePipe, DotRise, DiamondStack, ArrowRise, WaveCol, SegmentLED.
    .PARAMETER BorderStyle
        Border layout style: None, Thin, Double, Rounded.
    .PARAMETER ColorPalette
        Theme palette overrides.
    .PARAMETER ColorMode
        Color mode logic: Solid, Conditional.
    .PARAMETER ColorThresholds
        Map of integer thresholds to SGR color sequences for Conditional mode.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.Collections.Specialized.OrderedDictionary]$Data,

        [Parameter(Mandatory = $false)]
        [int]$Height = 10,

        [Parameter(Mandatory = $false)]
        [ValidateSet('FullBlock', 'ShadeStack', 'BrailleCol', 'ThinPipe', 'DoublePipe', 'DotRise', 'DiamondStack', 'ArrowRise', 'WaveCol', 'SegmentLED')]
        [string]$Style = 'FullBlock',

        [Parameter(Mandatory = $false)]
        [ValidateSet('None', 'Thin', 'Double', 'Rounded')]
        [string]$BorderStyle = 'None',

        [Parameter(Mandatory = $false)]
        [hashtable]$ColorPalette = @{},

        [Parameter(Mandatory = $false)]
        [ValidateSet('Solid', 'Conditional')]
        [string]$ColorMode = 'Conditional',

        [Parameter(Mandatory = $false)]
        [hashtable]$ColorThresholds = @{ 30 = "38;5;46"; 70 = "38;5;226"; 100 = "38;5;196" } 
    )

    process {
        $ui = Get-TerminalUI -BorderStyle $BorderStyle
        $palette = Get-TerminalPalette -ColorPalette $ColorPalette -ColorMode $ColorMode -ColorThresholds $ColorThresholds

        $keys = $Data.Keys
        $values = $Data.Values

        $charSets = @{
            'FullBlock'    = @{ Empty = '░'; Full = '█'; Steps = @('░', '▁', '▂', '▃', '▄', '▅', '▆', '▇') }
            'ShadeStack'   = @{ Empty = '░'; Full = '█'; Steps = @('░', '▒', '▓') }
            'BrailleCol'   = @{ Empty = '⠀'; Full = '⣿'; Steps = @('⠀', '⣀', '⣄', '⣤', '⣦', '⣶', '⣷') }
            'ThinPipe'     = @{ Empty = '╎'; Full = '┃'; Steps = @('╎') }
            'DoublePipe'   = @{ Empty = '│'; Full = '║'; Steps = @('│') }
            'DotRise'      = @{ Empty = '·'; Full = '●'; Steps = @('·', '∘') }
            'DiamondStack' = @{ Empty = '◇'; Full = '◆'; Steps = @('◇') }
            'ArrowRise'    = @{ Empty = '·'; Full = '▴'; Steps = @('·', '▲') }
            'WaveCol'      = @{ Empty = '·'; Full = '∿'; Steps = @('·', '≈', '~') }
            'SegmentLED'   = @{ Empty = '╌'; Full = '▬'; Steps = @('╌') }
        }
        $set = $charSets[$Style]

        # generic collections to bypass boxing penalty
        $columns = [System.Collections.Generic.List[Object]]::new($values.Count)
        foreach ($val in $values) {
            $colPalette = Get-TerminalPalette -ColorPalette $ColorPalette -ColorMode $ColorMode -ColorThresholds $ColorThresholds -CurrentValue $val
            $fillLines = ($val / 100.0) * $Height
            $fullBlocks = [math]::Floor($fillLines)
            $remainder = $fillLines - $fullBlocks
            
            $stepIndex = [math]::Round($remainder * ($set.Steps.Count - 1))
            $tipChar = if ($remainder -gt 0) { $set.Steps[$stepIndex] } else { $set.Empty }

            $columns.Add([PSCustomObject]@{
                    Value     = $val
                    FullCount = $fullBlocks
                    TipChar   = $tipChar
                    Palette   = $colPalette
                })
        }

        $outputLines = [System.Collections.Generic.List[string]]::new()

        $valRowChars = [System.Collections.Generic.List[string]]::new()
        foreach ($key in $keys) { [void]$valRowChars.Add($Data[$key].ToString().PadLeft(3).PadRight(4)) }
        $outputLines.Add(-join $valRowChars)

        for ($row = $Height; $row -gt 0; $row--) {
            $lineChars = [System.Collections.Generic.List[string]]::new()
            
            foreach ($col in $columns) {
                $char = $set.Empty
                if ($col.FullCount -ge $row) {
                    $char = $set.Full
                }
                elseif ($col.FullCount -eq ($row - 1)) {
                    $char = $col.TipChar
                }

                if ($Style -eq 'WaveCol' -and $char -eq $set.Full) {
                    $char = $set.Steps[$row % $set.Steps.Count]
                }

                $colorCode = (& $col.Palette.GetFillColor 1 1)
                $renderedChar = (& $col.Palette.Apply $char $colorCode)
                $lineChars.Add(" $renderedChar  ")
            }
            $outputLines.Add(-join $lineChars)
        }

        $headerRowChars = [System.Collections.Generic.List[string]]::new()
        foreach ($key in $keys) { 
            $truncKey = if ($key.Length -gt 3) { $key.Substring(0, 3) } else { $key.PadRight(3) }
            $headerRowChars.Add("$truncKey ") 
        }
        $outputLines.Add(-join $headerRowChars)

        if ($ui.HasBorder) {
            $contentWidth = ($keys.Count * 4)
            $borderCode = (& $palette.GetStaticColor 'Border')
            
            $topBorderStr = $ui.TopLeft + ($ui.Horizontal * $contentWidth) + $ui.TopRight
            $botBorderStr = $ui.BottomLeft + ($ui.Horizontal * $contentWidth) + $ui.BottomRight

            $topBorder = (& $palette.Apply $topBorderStr $borderCode)
            $bottomBorder = (& $palette.Apply $botBorderStr $borderCode)
            $vChar = (& $palette.Apply $ui.Vertical $borderCode)

            $framedLines = [System.Collections.Generic.List[string]]::new()
            $framedLines.Add($topBorder)
            foreach ($line in $outputLines) {
                $framedLines.Add("$vChar$line$vChar")
            }
            $framedLines.Add($bottomBorder)
            Write-Output ($framedLines -join [Environment]::NewLine)
        }
        else {
            Write-Output ($outputLines -join [Environment]::NewLine)
        }
    }
}
