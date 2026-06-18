# ==============================================================================
# File: Invoke-FluidBarAnimation.ps1 (Public Cmdlet)
# ==============================================================================
function Invoke-FluidBarAnimation {
    <#
    .SYNOPSIS
        Sequences progress bar rendering frames from 0 to 100 with cursor state safety.
    .DESCRIPTION
        Console wrapper that sequences New-FluidBar generation across a 0 to 100 iteration loop.
        It handles console cursor toggling (?25l / ?25h) and carriage returns (\r) to overwrite in place.
    .PARAMETER BarParameters
        A splatted hashtable containing arguments for New-FluidBar.
    .PARAMETER DelayMilliseconds
        The execution pause duration between iterative rendering frames.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [hashtable]$BarParameters,

        [Parameter(Mandatory = $false)]
        [int]$DelayMilliseconds = 25
    )

    process {
        $esc = [char]27
        Write-Host -NoNewline "$esc[?25l"
        
        try {
            for ($i = 0; $i -le 100; $i++) {
                $BarParameters['Fill'] = $i
                $frame = New-FluidBar @BarParameters
                
                Write-Host -NoNewline "`r$frame"
                Start-Sleep -Milliseconds $DelayMilliseconds
            }
            Write-Host ""
        }
        finally {
            # Safely restore the cursor state
            Write-Host -NoNewline "$esc[?25h"
        }
    }
}
