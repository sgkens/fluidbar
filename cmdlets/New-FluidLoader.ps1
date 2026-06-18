function New-SimpleLoader {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [int]$Tick,

        [Parameter(Mandatory = $false)]
        [ValidateRange(3, [int]::MaxValue)]
        [int]$Width = 20,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Horizontal', 'Vertical')]
        [string]$Direction = 'Horizontal',

        [Parameter(Mandatory = $false)]
        [char]$FillChar = [char]9608, # █

        [Parameter(Mandatory = $false)]
        [char]$EmptyChar = '-',

        [Parameter(Mandatory = $false)]
        [string[]]$Brackets = @('[', ']'),

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
        $val = if ($Tick -ge 100) { $Tick % 100 } else { $Tick }
        $palette = Get-TerminalPalette -ColorPalette $ColorPalette -ColorMode $ColorMode -ColorThresholds $ColorThresholds -CurrentValue $val

        $rawLeft = if ($Brackets.Count -gt 0) { $Brackets[0] } else { '' }
        $rawRight = if ($Brackets.Count -gt 1) { $Brackets[1] } else { '' }

        $borderOffset = if ($ui.HasBorder) { 2 } else { 0 }
        $innerWidth = $Width - ($rawLeft.Length + $rawRight.Length) - $borderOffset
        if ($innerWidth -lt 1) { $innerWidth = 1 }

        $coloredInnerChars = [System.Collections.Generic.List[string]]::new()
        
        $fillCode = (& $palette.GetFillColor 1 1)
        if ($null -eq $fillCode) { $fillCode = (& $palette.GetStaticColor 'Fill') }
        $emptyCode = (& $palette.GetStaticColor 'Empty')

        if ($Direction -eq 'Horizontal') {
            # Bouncing logic across the structural width
            $cycleLength = ($innerWidth - 1) * 2
            if ($cycleLength -le 0) { $cycleLength = 1 }
            
            $pos = $Tick % $cycleLength
            if ($pos -ge $innerWidth) { 
                $pos = $cycleLength - $pos 
            }

            for ($i = 0; $i -lt $innerWidth; $i++) {
                if ($i -eq $pos) {
                    $coloredInnerChars.Add((& $palette.Apply [string]$FillChar $fillCode))
                }
                else {
                    $coloredInnerChars.Add((& $palette.Apply [string]$EmptyChar $emptyCode))
                }
            }
        } 
        else {
            # Vertical logic bounded to a single line using varying height frame blocks
            $vFrames = @(' ', '▂', '▃', '▄', '▅', '▆', '▇', '█', '▇', '▆', '▅', '▄', '▃', '▂')
            $frameIndex = $Tick % $vFrames.Count
            $char = [string]$vFrames[$frameIndex]

            for ($i = 0; $i -lt $innerWidth; $i++) {
                $coloredInnerChars.Add((& $palette.Apply $char $fillCode))
            }
        }

        $assembledInner = -join $coloredInnerChars

        $bracketCode = (& $palette.GetStaticColor 'Brackets')
        $borderCode = (& $palette.GetStaticColor 'Border')

        $coloredLeft = (& $palette.Apply $rawLeft $bracketCode)
        $coloredRight = (& $palette.Apply $rawRight $bracketCode)

        $barLine = -join ($coloredLeft, $assembledInner, $coloredRight)

        if ($ui.HasBorder) {
            $horizontalCount = $Width - 2
            if ($horizontalCount -lt 1) { $horizontalCount = 1 }
            
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