# ==============================================================================
# File: test-unit-pester.ps1
# ==============================================================================
param (
    [switch]$CI
)

BeforeAll {
    # Centralized Module Root Path Determination
    $ModuleManifest = [System.IO.Path]::Combine($PSScriptRoot, "..", "FluidBar.psd1")
    Import-Module $ModuleManifest -Force
}

Describe 'New-FluidBar Core Logic' {
    
    Context 'Boundary and Validation Constraints' {
        It 'Throws an error if Fill is less than 0' {
            { New-FluidBar -Fill -1 } | Should -Throw
        }

        It 'Throws an error if Fill is greater than 100' {
            { New-FluidBar -Fill 101 } | Should -Throw
        }

        It 'Throws an error if Width is less than 3' {
            { New-FluidBar -Fill 50 -Width 2 } | Should -Throw
        }
        
        It 'Throws an error if neither Fill nor Value is specified' {
            { New-FluidBar } | Should -Throw
        }
    }

    Context 'Mathematical Accuracy and String Lengths' {
        It 'Returns exactly the specified total Width including brackets' {
            $bar = New-FluidBar -Fill 50 -Width 25 -Brackets @('[', ']')
            $bar.Length | Should -Be 25
        }

        It 'Calculates 0% fill correctly' {
            $bar = New-FluidBar -Fill 0 -Width 10 -Brackets @('|', '|') -FillChar 'X' -EmptyChar '-'
            $bar | Should -Be '|--------|'
        }

        It 'Calculates 50% fill correctly' {
            $bar = New-FluidBar -Fill 50 -Width 10 -Brackets @('|', '|') -FillChar 'X' -EmptyChar '-'
            $bar | Should -Be '|XXXX----|'
        }

        It 'Calculates 100% fill correctly' {
            $bar = New-FluidBar -Fill 100 -Width 10 -Brackets @('|', '|') -FillChar 'X' -EmptyChar '-'
            $bar | Should -Be '|XXXXXXXX|'
        }
    }

    Context 'Percentage Text Injection' {
        It 'Injects text Before the left bracket' {
            $bar = New-FluidBar -Fill 25 -Width 10 -PercentagePosition Before -Brackets @('[', ']')
            $bar | Should -Match '^25% \['
        }

        It 'Injects text After the right bracket' {
            $bar = New-FluidBar -Fill 75 -Width 10 -PercentagePosition After -Brackets @('[', ']')
            $bar | Should -Match '\] 75%$'
        }

        It 'Injects text in the Center of the inner bar' {
            $bar = New-FluidBar -Fill 50 -Width 20 -PercentagePosition Center -FillChar '=' -EmptyChar '-'
            $bar | Should -Match '=======50%-------'
        }
    }

    Context 'Multiline Output Generation' {
        It 'Returns a single string with embedded newlines when Height is > 1' {
            $bar = New-FluidBar -Fill 100 -Width 10 -BorderStyle Thin
            $lines = $bar -split [Environment]::NewLine
            $lines.Count | Should -Be 3
        }
    }

    Context 'ANSI Escape Sequence Generation' {
        It 'Applies correct ANSI sequences in Solid Color mode' {
            $palette = @{ Fill = "38;5;46" }
            $bar = New-FluidBar -Fill 100 -Width 10 -ColorPalette $palette -ColorMode Solid
            $bar | Should -Match '\x1b\[38;5;46m'
        }

        It 'Generates True-Color RGB sequences in Gradient mode' {
            $bar = New-FluidBar -Fill 100 -Width 10 -ColorMode Gradient -GradientStart @(255, 0, 0) -GradientEnd @(0, 255, 0)
            # Checks for standard 38;2;R;G;B sequence
            $bar | Should -Match '\x1b\[38;2;\d+;\d+;\d+m'
        }
    }

    Context 'Extended Features (v1.3.0)' {
        It 'Calculates fill percentage dynamically using Value and MaxValue' {
            # 50 / 200 = 25% fill
            $bar = New-FluidBar -Value 50 -MaxValue 200 -Width 10 -Brackets @('|', '|') -FillChar 'X' -EmptyChar '-'
            $bar | Should -Be '|XX------|'
        }

        It 'Uses custom static Label string' {
            $bar = New-FluidBar -Fill 50 -Width 20 -PercentagePosition Center -Label "WAIT" -FillChar '=' -EmptyChar '-'
            $bar | Should -Match '=======WAIT-------'
        }

        It 'Applies custom LabelFormat pattern string' {
            $bar = New-FluidBar -Value 30 -MaxValue 120 -Width 30 -PercentagePosition Center -LabelFormat "Val:{0}/{1} ({2:N0}%)" -FillChar '=' -EmptyChar '-'
            $bar | Should -Match '==Val:30/120 \(25%\)---'
        }

        It 'Uses predefined Spark style preset' {
            # Spark style uses '█' fill, ' ' empty, and '▕'/'▏' brackets
            $bar = New-FluidBar -Fill 50 -Width 10 -Style Spark
            $bar | Should -Be '▕████    ▏'
        }

        It 'Combines Foreground, Background, and Font Styles in ColorPalette' {
            # 1 = Bold, 38;5;46 = Green FG, 48;5;232 = Dark Gray BG
            $palette = @{ 
                Fill      = '38;5;46'
                FillBg    = '48;5;232'
                FillStyle = 'Bold'
            }
            $bar = New-FluidBar -Fill 100 -Width 10 -ColorPalette $palette -ColorMode Solid
            # SGR sequence must combine bold, foreground, background: \x1b[1;38;5;46;48;5;232m
            $bar | Should -Match '\x1b\[1;38;5;46;48;5;232m'
        }
    }
}
