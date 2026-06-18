# ==============================================================================
# File: Get-TerminalPalette.ps1 (Private Helper)
# ==============================================================================
function Get-TerminalPalette {
    <#
    .SYNOPSIS
        Generates a Palette Object for color application, conditional mapping, and gradients.
    .DESCRIPTION
        Returns a PSCustomObject containing scriptblocks for applying SGR escape sequences.
        Supports Foreground (FG), Background (BG), and text Styles (Bold, Dim, Underline, etc.).
        Uses GetNewClosure() to guarantee thread and scope safety.
    #>
    param (
        [hashtable]$ColorPalette,
        [string]$ColorMode,
        [hashtable]$ColorThresholds,
        [int[]]$GradientStart,
        [int[]]$GradientEnd,
        [int]$CurrentValue,
        [int]$MaxValue = 100
    )

    $esc = [char]27
    $reset = "$esc[0m"

    # Type Translation scriptblock: converts [R,G,B] arrays or 256-color indexes to TrueColor SGR strings
    $parseColor = {
        param($Value, [string]$Mode = 'FG')
        if ($null -eq $Value) { return $null }
        if ($Value -is [array] -and $Value.Count -ge 3) {
            $prefix = if ($Mode -eq 'BG') { '48;2;' } else { '38;2;' }
            return "$prefix$([int]$Value[0]);$([int]$Value[1]);$([int]$Value[2])"
        }
        
        $valStr = [string]$Value
        if ($valStr -match '^\d+$') {
            $codeVal = [int]$valStr
            # Skip wrapping if it's already a basic standard SGR color code
            if (($codeVal -ge 30 -and $codeVal -le 37) -or 
                ($codeVal -ge 40 -and $codeVal -le 47) -or
                ($codeVal -ge 90 -and $codeVal -le 97) -or
                ($codeVal -ge 100 -and $codeVal -le 107)) {
                return $valStr
            }
            $prefix = if ($Mode -eq 'BG') { '48;5;' } else { '38;5;' }
            return "$prefix$valStr"
        }
        return $valStr
    }

    $parseStyle = {
        param($Value)
        if ($null -eq $Value) { return $null }
        $styleMap = @{
            'Bold'      = '1'
            'Dim'       = '2'
            'Italic'    = '3'
            'Underline' = '4'
            'Blink'     = '5'
            'Reverse'   = '7'
            'Invert'    = '7'
            'Hidden'    = '8'
            'Strike'    = '9'
        }
        
        $styles = [System.Collections.Generic.List[string]]::new()
        foreach ($s in ($Value -split '[,|]')) {
            $trimmed = $s.Trim()
            if ($styleMap.ContainsKey($trimmed)) {
                $styles.Add($styleMap[$trimmed])
            }
            elseif ($trimmed -match '^\d+$') {
                $styles.Add($trimmed)
            }
        }
        
        if ($styles.Count -gt 0) {
            return $styles -join ';'
        }
        return $null
    }

    $getCombinedCode = {
        param([string]$Key, [string]$FallbackFG)
        
        $fg = $null
        $bg = $null
        $style = $null
        
        # Scan ColorPalette keys for matches (case-insensitive)
        if ($null -ne $ColorPalette) {
            foreach ($k in $ColorPalette.Keys) {
                if ($k -ieq $Key) {
                    $fg = (& $parseColor $ColorPalette[$k] 'FG')
                }
                elseif ($k -ieq "$Key`Bg") {
                    $bg = (& $parseColor $ColorPalette[$k] 'BG')
                }
                elseif ($k -ieq "$Key`Style") {
                    $style = (& $parseStyle $ColorPalette[$k])
                }
            }
        }
        
        # Use fallback foreground if no custom FG is defined
        if ($null -eq $fg -and $null -ne $FallbackFG) {
            $fg = $FallbackFG
        }
        
        $parts = [System.Collections.Generic.List[string]]::new()
        if ($null -ne $style) { [void]$parts.Add($style) }
        if ($null -ne $fg) { [void]$parts.Add($fg) }
        if ($null -ne $bg) { [void]$parts.Add($bg) }
        
        if ($parts.Count -gt 0) {
            return $parts -join ';'
        }
        return $null
    }.GetNewClosure()

    $paletteObj = [PSCustomObject]@{
        Apply          = {
            param([string]$Text, [string]$Code)
            $esc = [char]27
            $reset = "$esc[0m"
            if ([string]::IsNullOrWhiteSpace($Code) -or [string]::IsNullOrEmpty($Text)) { return $Text }
            return "$esc[$Code`m$Text$reset"
        }.GetNewClosure()
        
        GetFillColor   = {
            param([int]$Index, [int]$TotalFill)
            
            if ($ColorMode -eq 'Conditional') {
                $matchingThreshold = $null
                $minKey = [int]::MaxValue
                foreach ($k in $ColorThresholds.Keys) {
                    if ($k -ge $CurrentValue -and $k -lt $minKey) {
                        $minKey = $k
                        $matchingThreshold = $k
                    }
                }
                if ($null -ne $matchingThreshold) { 
                    $fgCode = (& $parseColor $ColorThresholds[$matchingThreshold] 'FG')
                    return (& $getCombinedCode 'Fill' $fgCode)
                }
                return $null
            }
            
            if ($ColorMode -eq 'Gradient') {
                $ratio = 0
                if ($TotalFill -gt 1) { $ratio = $Index / ($TotalFill - 1) }
                $r = [math]::Round($GradientStart[0] + ($GradientEnd[0] - $GradientStart[0]) * $ratio)
                $g = [math]::Round($GradientStart[1] + ($GradientEnd[1] - $GradientStart[1]) * $ratio)
                $b = [math]::Round($GradientStart[2] + ($GradientEnd[2] - $GradientStart[2]) * $ratio)
                $fgCode = "38;2;$r;$g;$b"
                return (& $getCombinedCode 'Fill' $fgCode)
            }

            return (& $getCombinedCode 'Fill' $null)
        }.GetNewClosure()

        GetStaticColor = {
            param([string]$Key)
            return (& $getCombinedCode $Key $null)
        }.GetNewClosure()
    }
    
    return $paletteObj
}
