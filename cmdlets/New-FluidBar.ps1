# ==============================================================================
# File: New-FluidBar.ps1 (Public Cmdlet)
# ==============================================================================
function New-FluidBar {
    <#
    .SYNOPSIS
        Generates static string representations of progress intervals with precise structural and color formatting.
    .DESCRIPTION
        Generates static string representations of progress intervals with precise structural and color formatting.
        Supports standard fills or Value/MaxValue bounds, custom labels, predefined styles, and advanced color palettes.
    .PARAMETER Brackets
        Cap strings for the left and right boundaries.
    .PARAMETER Fill
        The completion percentage. Drives internal character counts.
    .PARAMETER Value
        The current value of progress (used with MaxValue to calculate percentage).
    .PARAMETER MaxValue
        The maximum bound of progress (used with Value, defaults to 100).
    .PARAMETER Width
        The absolute total character length of the generated string output (excluding ANSI escape codes).
    .PARAMETER FillChar
        The character populating the completed segment.
    .PARAMETER EmptyChar
        The character populating the remaining segment.
    .PARAMETER BorderStyle
        Applies a border style: None, Thin, Double, Rounded.
    .PARAMETER ColorPalette
        Custom color palette mapping (Keys: Fill, FillBg, FillStyle, Empty, EmptyBg, EmptyStyle, Brackets, Border, etc.).
    .PARAMETER PercentagePosition
        Defines relative text injection (None, Center, Start, End, Before, After).
    .PARAMETER Label
        Custom label text string to inject/display.
    .PARAMETER LabelFormat
        Custom formatting template for label text (e.g. "Processed: {0}/{1} ({2:N1}%)").
        Parameters passed to template: {0} = Value, {1} = MaxValue, {2} = calculated percentage.
    .PARAMETER Style
        Predefined style presets: Classic, Block, Line, Spark, Dot, Star, Slash, Custom.
    .PARAMETER ColorMode
        Defines the coloring logic (Solid, Conditional, Gradient).
    .PARAMETER ColorThresholds
        Map of integer thresholds to SGR color sequences for Conditional mode.
    .PARAMETER GradientStart
        TrueColor RGB array defining the 0% index color.
    .PARAMETER GradientEnd
        TrueColor RGB array defining the 100% index color.
    .PARAMETER Smooth
        Applies a smooth high-resolution Unicode character for the final tip segment.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0)]
        [string[]]$Brackets = @('[', ']'),

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateRange(0, 100)]
        [int]$Fill,

        [Parameter(Mandatory = $false)]
        [double]$Value,

        [Parameter(Mandatory = $false)]
        [double]$MaxValue = 100,

        [Parameter(Mandatory = $false)]
        [ValidateRange(3, [int]::MaxValue)]
        [int]$Width = 20,

        [Parameter(Mandatory = $false)]
        [string]$FillChar = [string]([char]9608),

        [Parameter(Mandatory = $false)]
        [string]$EmptyChar = '-',

        [Parameter(Mandatory = $false)]
        [ValidateSet('None', 'Thin', 'Double', 'Rounded')]
        [string]$BorderStyle = 'None',

        [Parameter(Mandatory = $false)]
        [hashtable]$ColorPalette = @{},

        [Parameter(Mandatory = $false)]
        [ValidateSet('None', 'Center', 'Start', 'End', 'Before', 'After')]
        [string]$PercentagePosition = 'None',

        [Parameter(Mandatory = $false)]
        [string]$Label,

        [Parameter(Mandatory = $false)]
        [string]$LabelFormat,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Classic', 'Block', 'Line', 'Spark', 'Dot', 'Star', 'Slash', 'Custom')]
        [string]$Style = 'Custom',

        [Parameter(Mandatory = $false)]
        [ValidateSet('Solid', 'Conditional', 'Gradient')]
        [string]$ColorMode = 'Solid',

        [Parameter(Mandatory = $false)]
        [hashtable]$ColorThresholds = @{ 30 = "38;5;196"; 70 = "38;5;226"; 100 = "38;5;46" },

        [Parameter(Mandatory = $false)]
        [int[]]$GradientStart = @(255, 0, 0),

        [Parameter(Mandatory = $false)]
        [int[]]$GradientEnd = @(0, 255, 0),

        [Parameter(Mandatory = $false)]
        [switch]$Smooth
    )

    process {
        if (!$PSBoundParameters.ContainsKey('Fill') -and !$PSBoundParameters.ContainsKey('Value')) {
            throw [System.ArgumentException]::new("Either -Fill or -Value must be specified.")
        }

        # Determine FillPercent based on Value/MaxValue or Fill
        $FillPercent = if ($PSBoundParameters.ContainsKey('Value')) {
            $calculated = ($Value / $MaxValue) * 100.0
            [math]::Max(0.0, [math]::Min(100.0, $calculated))
        } else {
            [double]$Fill
        }

        # Predefined style configurations
        $styles = @{
            'Block'   = @{ FillChar = [string]([char]9608); EmptyChar = '░'; Brackets = @('[', ']') }
            'Line'    = @{ FillChar = '━'; EmptyChar = '─'; Brackets = @(' ', ' ') }
            'Spark'   = @{ FillChar = '█'; EmptyChar = ' '; Brackets = @('▕', '▏') }
            'Classic' = @{ FillChar = '#'; EmptyChar = '-'; Brackets = @('[', ']') }
            'Dot'     = @{ FillChar = '●'; EmptyChar = '○'; Brackets = @('(', ')') }
            'Star'    = @{ FillChar = '★'; EmptyChar = '☆'; Brackets = @('{', '}') }
            'Slash'   = @{ FillChar = '/'; EmptyChar = ' '; Brackets = @('|', '|') }
        }

        if ($Style -ne 'Custom' -and $styles.ContainsKey($Style)) {
            $selected = $styles[$Style]
            if (!$PSBoundParameters.ContainsKey('FillChar')) { $FillChar = $selected.FillChar }
            if (!$PSBoundParameters.ContainsKey('EmptyChar')) { $EmptyChar = $selected.EmptyChar }
            if (!$PSBoundParameters.ContainsKey('Brackets')) { $Brackets = $selected.Brackets }
        }

        $ui = Get-TerminalUI -BorderStyle $BorderStyle
        $palette = Get-TerminalPalette -ColorPalette $ColorPalette -ColorMode $ColorMode -ColorThresholds $ColorThresholds -GradientStart $GradientStart -GradientEnd $GradientEnd -CurrentValue ([math]::Round($FillPercent))

        $rawLeft = if ($Brackets.Count -gt 0) { $Brackets[0] } else { '' }
        $rawRight = if ($Brackets.Count -gt 1) { $Brackets[1] } else { '' }

        $borderOffset = if ($ui.HasBorder) { 2 } else { 0 }
        $innerWidth = $Width - ($rawLeft.Length + $rawRight.Length) - $borderOffset
        if ($innerWidth -lt 1) { $innerWidth = 1 }

        $fillFloat = ($FillPercent / 100.0) * $innerWidth
        $fullBlocks = [math]::Floor($fillFloat)
        if ($fullBlocks -gt $innerWidth) { $fullBlocks = $innerWidth }
        if ($fullBlocks -lt 0) { $fullBlocks = 0 }

        $tipChar = $null
        if ($Smooth -and $fullBlocks -lt $innerWidth) {
            $remainder = $fillFloat - $fullBlocks
            $smoothSteps = @(' ', '▏', '▎', '▍', '▌', '▋', '▊', '▉')
            $stepIndex = [math]::Round($remainder * ($smoothSteps.Count - 1))
            if ($stepIndex -gt 0) {
                $tipChar = $smoothSteps[$stepIndex]
            }
        }

        $fillCount = $fullBlocks
        $emptyCount = $innerWidth - $fillCount

        $innerString = $null
        if ($Smooth -and $tipChar) {
            $adjustedEmpty = $emptyCount - 1
            if ($adjustedEmpty -lt 0) { $adjustedEmpty = 0 }
            $innerString = ([string]$FillChar * $fillCount) + $tipChar + ([string]$EmptyChar * $adjustedEmpty)
        }
        else {
            $innerString = ([string]$FillChar * $fillCount) + ([string]$EmptyChar * $emptyCount)
        }

        # Build custom label or percentage representation string
        $pctText = if ($PSBoundParameters.ContainsKey('Label')) {
            $Label
        } elseif ($PSBoundParameters.ContainsKey('LabelFormat')) {
            $v = if ($PSBoundParameters.ContainsKey('Value')) { $Value } else { $Fill }
            $mv = if ($PSBoundParameters.ContainsKey('Value')) { $MaxValue } else { 100 }
            [string]::Format($LabelFormat, $v, $mv, $FillPercent)
        } else {
            "{0}%" -f [math]::Round($FillPercent)
        }

        if ($PercentagePosition -in @('Start', 'Center', 'End')) {
            if ($innerWidth -ge $pctText.Length) {
                $insertIndex = 0
                if ($PercentagePosition -eq 'Center') { $insertIndex = [math]::Floor(($innerWidth - $pctText.Length) / 2) } 
                elseif ($PercentagePosition -eq 'End') { $insertIndex = $innerWidth - $pctText.Length }
                $innerString = $innerString.Remove($insertIndex, $pctText.Length).Insert($insertIndex, $pctText)
            }
        }

        # strong typing generic collection to bypass boxing penalty
        $coloredInnerChars = [System.Collections.Generic.List[string]]::new($innerWidth)
        $innerCharArray = $innerString.ToCharArray()

        $emptyCode = (& $palette.GetStaticColor 'Empty')

        for ($i = 0; $i -lt $innerWidth; $i++) {
            $currentChar = $innerCharArray[$i]
            $code = $null

            if ($i -lt $fillCount -or ($Smooth -and $tipChar -and $i -eq $fillCount)) {
                $colorFillCount = if ($fillCount -gt 0) { $fillCount } else { 1 }
                $code = (& $palette.GetFillColor $i $colorFillCount)
            }
            else {
                $code = $emptyCode
            }

            $coloredInnerChars.Add((& $palette.Apply $currentChar $code))
        }

        $assembledInner = -join $coloredInnerChars

        $bracketCode = (& $palette.GetStaticColor 'Brackets')
        $borderCode = (& $palette.GetStaticColor 'Border')

        $coloredLeft = (& $palette.Apply $rawLeft $bracketCode)
        $coloredRight = (& $palette.Apply $rawRight $bracketCode)

        $barLine = -join ($coloredLeft, $assembledInner, $coloredRight)

        $output = if ($ui.HasBorder) {
            $horizontalCount = $Width - 2
            if ($horizontalCount -lt 1) { $horizontalCount = 1 }
            
            $topBorder = $ui.TopLeft + ($ui.Horizontal * $horizontalCount) + $ui.TopRight
            $bottomBorder = $ui.BottomLeft + ($ui.Horizontal * $horizontalCount) + $ui.BottomRight
            
            $coloredTop = (& $palette.Apply $topBorder $borderCode)
            $coloredBottom = (& $palette.Apply $bottomBorder $borderCode)
            $coloredVert = (& $palette.Apply $ui.Vertical $borderCode)

            $midLine = -join ($coloredVert, $barLine, $coloredVert)

            if ($PercentagePosition -eq 'Before') {
                $padSpace = " " * ($pctText.Length + 1)
                $coloredTop = "$padSpace$coloredTop"
                $coloredBottom = "$padSpace$coloredBottom"
                $midLine = "$pctText $midLine"
            }
            elseif ($PercentagePosition -eq 'After') {
                $midLine = "$midLine $pctText"
            }

            -join ($coloredTop, [Environment]::NewLine, $midLine, [Environment]::NewLine, $coloredBottom)
        }
        else {
            if ($PercentagePosition -eq 'Before') { "$pctText $barLine" } 
            elseif ($PercentagePosition -eq 'After') { "$barLine $pctText" }
            else { $barLine }
        }

        Write-Output $output
    }
}
