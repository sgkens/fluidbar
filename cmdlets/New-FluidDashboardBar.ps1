# ==============================================================================
# File: New-DashboardBar.ps1 (Public Cmdlet)
# ==============================================================================
function New-DashboardBar {
    <#
    .SYNOPSIS
        Aggregates custom objects to automate multi-line dashboard reporting formats, complete with offset subtext lines.
    .DESCRIPTION
        Aggregates custom objects to automate multi-line dashboard reporting formats, complete with offset subtext lines.
    .PARAMETER Data
        Must contain properties structured with .Percentage and .Subtext elements.
    .PARAMETER Width
        Visual width of each bar. Default is 50.
    .PARAMETER Style
        Preset structural overrides mapping to Block, Wave, or Braille.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [PSCustomObject]$Data,

        [Parameter(Mandatory = $false)]
        [int]$Width = 50,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Block', 'Wave', 'Braille')]
        [string]$Style = 'Block'
    )

    process {
        $props = $Data.psobject.properties
        $outLines = [System.Collections.Generic.List[string]]::new()

        foreach ($prop in $props) {
            $name = $prop.Name.PadRight(15)
            $val = $prop.Value.Percentage
            $lines = $prop.Value.Subtext

            $fillChar = '█'
            $emptyChar = '░'

            if ($Style -eq 'Wave') { $fillChar = '~'; $emptyChar = '·' }
            if ($Style -eq 'Braille') { $fillChar = '⣿'; $emptyChar = '⠀' }

            # Calls the renamed New-FluidBar
            $bar = New-FluidBar -Fill $val -Width $Width -FillChar $fillChar -EmptyChar $emptyChar -PercentagePosition After
            $outLines.Add("$name $bar")

            if ($null -ne $lines) {
                foreach ($line in $lines) {
                    $outLines.Add("                $line")
                }
            }
            $outLines.Add("")
        }

        Write-Output ($outLines -join [Environment]::NewLine)
    }
}
