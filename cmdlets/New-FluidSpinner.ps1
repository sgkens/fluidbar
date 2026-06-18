function New-SimpleSpinner {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [int]$Tick,

        [Parameter(Mandatory = $false)]
        [string[]]$Brackets = @('[', ']'),

        [Parameter(Mandatory = $false)]
        [ValidateSet('Line', 'Braille', 'Pulse', 'Dots', 'Block')]
        [string]$Style = 'Braille',

        [Parameter(Mandatory = $false)]
        [ValidateSet('None', 'Thin', 'Double', 'Rounded')]
        [string]$BorderStyle = 'None',

        [Parameter(Mandatory = $false)]
        [hashtable]$ColorPalette = @{},

        [Parameter(Mandatory = $false)]
        [ValidateSet('Solid', 'Conditional')]
        [string]$ColorMode = 'Solid',

        [Parameter(Mandatory = $false)]
        [hashtable]$ColorThresholds = @{ 30 = "38;5;196"; 70 = "38;5;226"; 100 = "38;5;46" }
    )

    process {
        $ui = Get-TerminalUI -BorderStyle $BorderStyle
        # Limit current value to 1-100 logic if conditional coloring is tied to tick cycles
        $val = if ($Tick -ge 100) { $Tick % 100 } else { $Tick }
        $palette = Get-TerminalPalette -ColorPalette $ColorPalette -ColorMode $ColorMode -ColorThresholds $ColorThresholds -CurrentValue $val

        $frames = @{
            'Line'    = @('-', '\', '|', '/')
            'Braille' = @('⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏')
            'Dots'    = @('⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷')
            'Pulse'   = @('░', '▒', '▓', '█', '▓', '▒')
            'Block'   = @('▏', '▎', '▍', '▌', '▋', '▊', '▉', '█', '▇', '▆', '▅', '▄', '▃', '▂', ' ')
        }
        
        $activeFrames = $frames[$Style]
        $frameIndex = $Tick % $activeFrames.Count
        $char = [string]$activeFrames[$frameIndex]

        $rawLeft = if ($Brackets.Count -gt 0) { $Brackets[0] } else { '' }
        $rawRight = if ($Brackets.Count -gt 1) { $Brackets[1] } else { '' }

        $fillCode = (& $palette.GetFillColor 1 1)
        if ($null -eq $fillCode) { $fillCode = (& $palette.GetStaticColor 'Fill') }
        
        $bracketCode = (& $palette.GetStaticColor 'Brackets')
        $borderCode = (& $palette.GetStaticColor 'Border')

        $coloredLeft = (& $palette.Apply $rawLeft $bracketCode)
        $coloredRight = (& $palette.Apply $rawRight $bracketCode)
        $coloredChar = (& $palette.Apply $char $fillCode)

        $barLine = -join ($coloredLeft, $coloredChar, $coloredRight)

        if ($ui.HasBorder) {
            $horizontalCount = $rawLeft.Length + 1 + $rawRight.Length
            $topBorder = $ui.TopLeft + ($ui.Horizontal * $horizontalCount) + $ui.TopRight
            $bottomBorder = $ui.BottomLeft + ($ui.Horizontal * $horizontalCount) + $ui.BottomRight
            
            $coloredTop = (& $palette.Apply $topBorder $borderCode)
            $coloredBottom = (& $palette.Apply $bottomBorder $borderCode)
            $coloredVert = (& $palette.Apply $ui.Vertical $borderCode)

            $midLine = -join ($coloredVert, $barLine, $coloredVert)
            Write-Output ( -join ($coloredTop, [Environment]::NewLine, $midLine, [Environment]::NewLine, $coloredBottom))
        }
        else {
            Write-Output $barLine
        }
    }
}