<div align="center">
    <img src="https://raw.githubusercontent.com/phellams/phellams-general-resources/main/logos/fluidbar/dist/banner/png/fluidbar-1024x512.png" alt="FluidBar Logo">
    <img alt="mit license" src="https://img.shields.io/badge/License-MIT-blue?style=flat&logo=windowsterminal"> 
    <br>
    <img src="https://img.shields.io/badge/true_color_RGB-purple?style=for-the-badge&logo=windowsterminal" alt="true-color RGB">
    <img src="https://img.shields.io/badge/ANSI_/_VT-blue?style=for-the-badge&logo=windowsterminal" alt="true-color RGB">
    <img src="https://img.shields.io/badge/Unicode_/_ASCII-green?style=for-the-badge&logo=windowsterminal" alt="true-color RGB">
    <img src="https://img.shields.io/badge/Powershell_5.1+-red?style=for-the-badge&logo=windowsterminal" alt="true-color RGB">
    <hr>
    <p> Provides terminal-based <b>ASCII</b> and Unicode</b> progress bars featuring strict mathematical string sizing, embedded text overlays, ANSI styling, and true-color <b>RGB</b> gradients.
    </p>
    <small>Compatibility:</b><strong>PowerShell 5.1+</strong>, <strong>PowerShell Core (7+)</strong></small>
    <br>
    <small>Platforms:</b><strong>pwsh-osx</strong>, <strong>pwsh-osx</strong>,<strong>pwsh-win</strong></small>
    <br>
    <br>
    <span>
        <a href="https://gitlab.com/phellams/fluidbar#api-reference"><b>API Reference</b></a> |
        <a href="https://gitlab.com/phellams/fluidbar#examples"><b>Examples</b></a> | 
        <a href="https://github.com/phellams/fluidbar">GitHub-Mirror</a> |
        <a href="https://www.powershellgallery.com/packages/fluidbar">PSGallery</a>
    </span>
    <hr>
</div>

<details>
<summary><strong>📚Table of Contents</strong></summary>

- [**Installation**](#installation)
  - [Additinonal Installation Options:](#additinonal-installation-options)
    - [📦 GitLab Packages](#-gitlab-packages)
    - [🧺 Generic Asset](#-generic-asset)
    - [💾 Git Clone](#-git-clone)
- [**🟦 API Reference**](#-api-reference)
  - [*New-SimpleBar*](#new-simplebar)
  - [🔘 *New-VerticalBar*](#-new-verticalbar)
    - [**Examples:**](#examples)
      - [1️⃣ **Render a simple vertical bar chart with a single data point:**](#1-render-a-simple-vertical-bar-chart-with-a-single-data-point)
      - [2️⃣ **Render a simple vertical bar chart with multiple data points:**](#2-render-a-simple-vertical-bar-chart-with-multiple-data-points)
  - [`New-3DBar`](#new-3dbar)
  - [`New-DashboardBar`](#new-dashboardbar)
  - [`Invoke-SimpleBarAnimation` - Sample function example](#invoke-simplebaranimation---sample-function-example)
    - [Outputs](#outputs)
  - [New-TrailingLog](#new-trailinglog)
    - [`-LogData `](#-logdata-)
    - [`-MaxLines `](#-maxlines-)
    - [`-ColorMode `](#-colormode-)
    - [`-GradientStart `](#-gradientstart-)
    - [`-GradientEnd `](#-gradientend-)
  - [New-Separator](#new-separator)
  - [Overview](#overview)
  - [Syntax](#syntax)
  - [Parameters](#parameters)
    - [`-Char `](#-char-)
    - [`-Repeat `](#-repeat-)
    - [`-ColorMode `](#-colormode-)
    - [`-ColorPalette `](#-colorpalette-)
    - [`-GradientStart `](#-gradientstart-)
    - [`-GradientEnd `](#-gradientend-)
  - [`Get-TerminalBG`](#get-terminalbg)
    - [Syntax](#syntax)
    - [Return Value](#return-value)
  - [`New-SimpleSpinner`](#new-simplespinner)
    - [Syntax](#syntax)
    - [Parameters](#parameters)
  - [`New-SimpleLoader`](#new-simpleloader)
    - [Syntax](#syntax)
    - [Parameters](#parameters)
- [**Usage Examples**](#usage-examples)
  - [1️⃣ Standard Output](#1-standard-output)
  - [2️⃣ Formatted Color Conditional Injection](#2-formatted-color-conditional-injection)
  - [3️⃣ Rendering a Progress Bar with a Custom Color Palette](#3-rendering-a-progress-bar-with-a-custom-color-palette)
  - [4️⃣ Rendering a Progress Bar with a Custom Color Threshold](#4-rendering-a-progress-bar-with-a-custom-color-threshold)
  - [5️⃣ Full Terminal Animation (True RGB)](#5-full-terminal-animation-true-rgb)
  - [6️⃣ Full Terminal Animation (True RGB) Sample Function](#6-full-terminal-animation-true-rgb-sample-function)
  - [Horizontal Border Styling](#horizontal-border-styling)
  - [Console Animation Wrapper](#console-animation-wrapper)
  - [3D Extrusion](#3d-extrusion)
  - [Multi-Column Vertical Arrays](#multi-column-vertical-arrays)
  - [Trailing History Logs](#trailing-history-logs)
  - [Horizontal Rule Separator](#horizontal-rule-separator)
- [**RGB Array Support**](#rgb-array-support)
  - [Overview](#overview)
- [Testing](#testing)
- [License](#license)

</details>

## **Installation**

Phellams modules are available from [**PowerShell Gallery**](https://www.powershellgallery.com/packages/fluidbar) and [**Chocolatey**](https://chocolatey.org/packages/fluidbar). you can access the raw assets via [**Gitlab Generic Assets**](https://gitlab.com/phellams/fluidbar/-/packages?orderBy=name&sort=desc&search[]=fluidbar) or nuget repository via [**Gitlab Packages**](https://gitlab.com/phellams/fluidbar/-/packages/?orderBy=name&sort=desc&search[]=fluidbar&type=NuGet).

|▓▓▓▓▒▒▒▒░░░|▓▓▓▓▒▒▒▒░░░|▓▓▓▓▒▒▒▒░░░|
|-|-|-|
|📦 PSGallery | <a href="https://www.powershellgallery.com/packages/fastfsc"> <img src="https://img.shields.io/powershellgallery/v/fastfsc?label=version&style=flat-square&logoColor=blue&labelColor=23CD5C5C&color=%231E3D59" alt="powershellgallery"></a> | <img src="https://img.shields.io/powershellgallery/dt/fastfsc?style=flat-square&logoColor=blue&label=downloads&labelColor=23CD5C5C&color=%231E3D59" alt="powershellgallery-downloads"> |

### Additinonal Installation Options:
 
|▓▓▓▓▒▒▒▒░░░|▓▓▓▓▒▒▒▒░░░|▓▓▓▓▒▒▒▒░░░|
|-|-|-|
|💼 Releases/Tags | <a href="https://gitlab.com/phellams/fastfsc/-/releases"> <img src="https://img.shields.io/gitlab/v/release/phellams%2Ffastfsc?include_prereleases&style=flat-square&logoColor=%2300B2A9&labelColor=%23CD5C5C&color=%231E3D59" alt="gitlab-release"></a> | <a href="https://gitlab.com/phellams/fastfsc/-/tags"> <img src="https://img.shields.io/gitlab/v/tag/phellams%2Ffastfsc?include_prereleases&style=flat-square&logoColor=%&labelColor=%23CD5C5C&color=%231E3D59" alt="gitlab tags"></a> |

#### GitLab Packages

Using `nuget`: See the [**packages**](https://gitlab.com/phellams/fastfsc/-/packages?orderBy=name&sort=asc&search[]=fastfsc&type=NuGet) page for installation instructions.

> For instructions on adding `nuget` **sources** packages from *GitLab* see [**Releases**](https://github.com/sgkens/fastfsc/releases) artifacts or via the [**Packages**](https://gitlab.com/phellams/fastfsc/-/packages?orderBy=name&sort=asc&search[]=fastfsc&type=NuGet) page.

#### Generic Asset

The latest release artifacts can be downloaded from the [**Generic Assets Artifacts**](https://gitlab.com/phellams/fastfsc/-/packages?orderBy=type&sort=desc&type=Generic) page.

#### Git Clone

```bash
# Clone the repository
git clone https://gitlab.com/phellams/fastfsc.git
cd fastfsc
import-module .\
```

---

## **API Reference**

### *💲New-SimpleBar*

Core rendering engine. Generates static string representations of progress intervals with precise structural and color formatting.

**🔹Sytax:**

```
New-SimpleBar [[-Brackets] <String[]>] [-Fill] <Int32> [-Width <Int32>] 
              [-FillChar <Char>] [-EmptyChar <Char>] [-BorderStyle <String>] 
              [-ColorPalette <Hashtable>] [-PercentagePosition <String>] 
              [-ColorMode <String>] [-ColorThresholds <Hashtable>] 
              [-GradientStart <Int32[]>] [-GradientEnd <Int32[]>] 
              [<CommonParameters>]`
```

**🔹Parameters**

| **Parameter** | **Type** | **Required** | **Default** | **Validation** | **Description** |
| --- | --- | --- | --- | --- | --- |
| `Brackets` | `String[]` | False | `@('[', ']')` | None | Cap strings for the left and right boundaries. |
| `Fill` | `Int32` | True | None | `0-100` | The completion percentage. Drives internal character counts. |
| `Width` | `Int32` | False | `20` | `> 2` | The absolute total character length of the generated string output (excluding ANSI escape codes). |
| `Height` | `Int32` | False | `1` | `> 0` | The number of identical vertical lines returned. Always outputs as a single string joined by newlines. |
| `FillChar` | `Char` | False | `█` (`[char]9608`) | None | The character populating the completed segment. |
| `EmptyChar` | `Char` | False | `-` | None | The character populating the remaining segment. |
| `ColorPalette` | `Hashtable` | False | `@{}` | None | Mappable keys include `Fill`, `Empty`, `Brackets`, and `Border`. Values are ANSI SGR sequence strings. |
| `PercentagePosition` | `String` | False | `None` | Set | `None`, `Center`, `Start`, `End`, `Before`, `After`. Defines relative text injection. |
| `ColorMode` | `String` | False | `Solid` | Set | `Solid`, `Conditional`, `Gradient`. Defines the logical application of ANSI sequences to the filled segment. |
| `ColorThresholds` | `Hashtable` | False | Map | None | Map of integer thresholds (max %) to ANSI SGR sequences. Used when `ColorMode` is `Conditional`. |
| `GradientStart` | `Int32[]` | False | `@(255,0,0)` | None | Array of `R, G, B` integers defining the 0% index color. Used when `ColorMode` is `Gradient`. |
| `GradientEnd` | `Int32[]` | False | `@(0,255,0)` | None | Array of `R, G, B` integers defining the 100% index color. Used when `ColorMode` is `Gradient`. |
| `BorderStyle` | `String` | False | `None` | Set | `None`, `Thin`, `Double`, `Rounded`. Applies an architectural wrap around the bar. |


**🔻Outputs**

`System.String`

**SGR** Sequences Strings examples: 

 - Red with background blue and bold `38;5;196;48;1`



---

### *💲New-VerticalBar*

Renders a multi-column TUI chart natively handling variable arrays via hashtable/ordered dictionary data inputs.

**Sytax:**

```
New-VerticalBar [[-Data] <OrderedDictionary>] [-Height <Int32>] [-Style <String>] 
                [-ColorMode <String>] [-ColorThresholds <Hashtable>]
                [-ColorPalette <Hashtable>]
                [<CommonParameters>]`
```

**Parameters**

| **Parameter** | **Type** | **Required** | **Default** | **Validation** | **Description** |
| --- | --- | --- | --- | --- | --- |
| `Data` | `OrderedDictionary` | True | None | None | Key-Value pairs driving column headers and percentage heights, if providing the `[ordered]@{}` directly it must be wrapped in `()` or function with throw `argument transformation` exeption. |
| `Height` | `Int32` | False | `10` | None | Total terminal lines utilized for the Y-axis. Default is `10`. |
| `Style` | `String` | False | `FullBlock` | Set | `FullBlock`, `ShadeStack`, `BrailleCol`, `ThinPipe`, `DoublePipe`, `DotRise`, `DiamondStack`, `ArrowRise`, `WaveCol`, `SegmentLED`. |
| `ColorMode` | `String` | False | `Conditional` | Set | `Solid`, `Conditional`, `Gradient`. Configured for `Conditional` threshold mapping by default (inverted logic: red at top, green at bottom). |
| `ColorThresholds` | `Hashtable` | False | Map | None | Map of integer thresholds (max %) to ANSI SGR sequences. Used when `ColorMode` is `Conditional`. |

#### **Examples:**

> `-Data` requires an `[ordered]` **Dictionary** with a single or multiple *key-value* pair, and must be wrapped in `()`.

##### 1️⃣ **Render a simple vertical bar chart with a single data point:**

```powershell
New-VerticalBar -Data ([ordered]@{ 'A1' = 20; }) `
                -Height 10 `
                -Style 'FullBlock'

# Or [ordered] init via variable
   | 
$data = [ordered]@{ 'A1' = 20; }
New-VerticalBar -Data $data -Height 10 -Style 'FullBlock'
```

**🔻Outputs**

<pre>
 20 
 ░  
 ░  
 ░  
 ░  
 ░  
 ░  
 ░  
 ░  
 █  
 █  
A1  
</pre>

##### 2️⃣ **Render a simple vertical bar chart with multiple data points:**

```powershell
New-VerticalBar -Data [ordered]@{ 'A1' = 20; 'B1' = 50; 'C1' = 80; } `
                -Height 10 `
                -Style 'FullBlock'

# Or [ordered] init via variable
   |
$data = [ordered]@{ 'A1' = 20; 'B1' = 50; 'C1' = 80; }
New-VerticalBar -Data $data -Height 10 -Style 'FullBlock'
```

**🔻Outputs**🔻

<pre>
20  50  80 
 ░   ░   ░  
 ░   ░   ░  
 ░   ░   █  
 ░   ░   █  
 ░   ░   █  
 ░   █   █  
 ░   █   █  
 ░   █   █  
 █   █   █  
 █   █   █  
A1  B1  C1
</pre>              

---

### `New-3DBar`

Renders an extruded pipe style graphic mapped across 3 vertical lines, complete with structural caps.

**Sytax:**

```
New-3DBar [[-Title <String>] [-Fill <Int32>] [-Width <Int32>] [-Subtext <String>]]
          [<CommonParameters>]`
```

**Parameters**

* **`Title`**: `String`. Injected structurally above the rendered pipe.
* **`Fill`**: `Int32`. Determines the visual pipe volume.
* **`Subtext`**: `String`. Optional descriptor injected below the output array.
* **`colormode`**: 
* **`ColorPalette`**: `Hashtable`. Custom color palette to override the default, accepts SGC sequences and RGB values.
    - Keys: `Fill`, `Frame`, `Empty`

**Examples**

• Render a simple 3D bar with a single data point:

```powershell
New-3DBar -Title 'My 3D Bar' -Fill 50 -Width 20 -Subtext 'Subtext' 
```

• Render a simple 3D bar with custom color palette:

```powershell
New-3DBar -Title 'My 3D Bar' -Fill 50 -Width 20 -Subtext 'Subtext' -ColorPalette @{ Fill="38;5;46"; Frame="38;5;240"; Empty="38;5;236" }
```

---

### `New-DashboardBar`

Aggregates custom objects to automate multi-line dashboard reporting formats, complete with offset subtext lines.

**Parameters**

* **`Data`**: `PSCustomObject`. Must contain properties structured with `.Percentage` and `.Subtext` elements.
* **`Style`**: `String`. Preset structural overrides mapping to `Block`, `Wave`, or `Braille`.

---

### `Invoke-SimpleBarAnimation` - Sample function example

Console wrapper that sequences `New-SimpleBar` generation across a `0` to `100` iteration loop. It natively handles console cursor toggling (`[?25l` / `[?25h`) and uses carriage returns (`\r`) to overwrite output in place.

**Parameters**

| Parameter | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `BarParameters` | `Hashtable` | True | None | A splatted hashtable containing arguments for `New-SimpleBar`. The wrapper forcefully overrides the `Fill` key during iteration. |
| `DelayMilliseconds` | `Int32` | False | `25` | The script execution pause duration between iterative rendering frames. |

#### Outputs

* `None` (Outputs directly to host).

---

### `New-TrailingLog`

The New-TrailingLog pipeline natively processes this Queue object into sequential arrays for trailing output without additional casting.

**syntax:**

```
New-TrailingLog [-LogData] <Object> [-MaxLines <Int32>] [-ColorMode <String>] [-GradientStart <Int32[]>] [-GradientEnd <Int32[]>] [-SolidColor <String>] [<CommonParameters>]
```

**Parameters**

| Parameter | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `LogData` | `Object` | True | None | The raw collection of data representing the execution log. Designed to accept `[String[]]`, `[System.Collections.Generic.List[string]]`, or `[System.Collections.Generic.Queue[string]]`. The cmdlet evaluates the collection assuming the highest index points to the most recently logged entry. |
| `MaxLines` | `Int32` | False | `5` | Specifies the exact numerical height of the output block. |
| `ColorMode` | `String` | False | `GradientFade` | Determines the formatting protocol across the lines. |
| `GradientStart` | `Int32[]` | False | `@(60, 60, 60)` | Array of three integers (`R`, `G`, `B`) dictating the color of the oldest visible entry in the block before fading toward the midpoint. |
| `GradientEnd` | `Int32[]` | False | `@(255, 255, 255)` | Array of three integers (`R`, `G`, `B`) dictating the color of the newest solid block, which serves as the endpoint target for the fading logic. |
| `SolidColor` | `String` | False | `"38;5;255;255;255"` | The color to be applied to the entire output block. |

**🔻Outputs**

`[string]` - Outputs System.String

---

### `New-Separator`

`New-Separator` provides a robust, structurally calculated horizontal rule for separating output between modules or log streams. By pre-calculating the repeat length before encoding, it ensures output scales exactly to the user's column width requirements without visual tearing. It natively supports RGB true-color gradients or static palette colors inherited from the `Get-TerminalPalette` engine.

**Syntax**

<pre>
New-Separator [[-Char] (Char)]
              [-Repeat (Int32)] 
              [-ColorMode (String)]
              [-ColorPalette (Hashtable)] 
              [-GradientStart (Int32[])] (Int32[])]
              [-GradientEnd (Int32[])] (Int32[])]
              [(CommonParameters)]
</pre>

**Parameters**

| Parameter | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `Char` | `Char` | False | `─` | The character to be repeated to construct the separator. |
| `Repeat` | `Int32` | False | `50` | Specifies the absolute character width of the generated separator. |
| `ColorMode` | `String` | False | `Solid` | Determines the coloring application methodology across the generated string. |
| `ColorPalette` | `Hashtable` | False | `@{ Fill = @(128, 128, 128) }` | A hashtable supporting SGR strings or `[int[]]` RGB arrays. The separator references the `Fill` key during `Solid` mode. |
| `GradientStart` | `Int32[]` | False | `@(60, 60, 60)` | Array of three integers (`R`, `G`, `B`) representing the starting boundary color at index 0. Only applies when `ColorMode` is set to `Gradient`. |
| `GradientEnd` | `Int32[]` | False | `@(255, 255, 255)` | Array of three integers (`R`, `G`, `B`) representing the ending boundary color at the final index. Only applies when `ColorMode` is set to `Gradient`. |

**🔻Outputs**

`[string]` - Outputs System.String

---

``
### `Get-TerminalBG`

Queries the active PowerShell host environment (`[System.Console]::BackgroundColor`) to determine the current shell background color state. Translates the legacy 16-color .NET `ConsoleColor` enumerator directly into the corresponding ANSI SGR (Select Graphic Rendition) background integer code.

This allows modular integration with the `Get-TerminalPalette` engine. For example, if a developer wants to render the `EmptyChar` track of a bar to perfectly match the user's customized console background, they can invoke this function to pull the dynamic value at runtime instead of hardcoding a hex or TrueColor array.


**Syntax**

```powershell
Get-TerminalBg [<CommonParameters>]
```

**Parameters**

`None`

**🔻Outputs**

* **Type:** `System.String`
* **Format:** Returns a string representation of standard ANSI background integers (e.g., `"40"` through `"47"`, or `"100"` through `"107"`). Returns `"40"` (Black) as a safe fallback if the host environment returns an unknown state.

---

### `New-SimpleSpinner`

Generates a stateless, single-character animation frame based on the provided iteration integer. Wraps securely into bracket or border structures while scaling visually according to standard palette configurations.

**Syntax**

<pre>
New-SimpleSpinner [-Tick] (Int32) [-Brackets (String[])] [-Style (String)] 
                  [-BorderStyle (String)]
                  [-ColorPalette (Hashtable)] 
                  [-ColorMode (String)]
                  [-ColorThresholds (Hashtable)] 
                  [(CommonParameters)]
</pre>

**Parameters**

* **`Tick`**: `Int32`. The current loop iteration, representing the absolute frame cycle index.
* **`Style`**: `String`. Selects the mathematical rotation mapped to the sequence constraint. Accepts `Line`, `Braille`, `Pulse`, `Dots`, or `Block`.

---

### `New-SimpleLoader`

Calculates a back-and-forth oscillating positional animation designed for tasks where fixed percentages are unknown. Structural pad limits are rendered before ANSI injection to maintain consistent console dimensions.

**Syntax**

<pre>
New-SimpleLoader [-Tick] (Int32) [-Width (Int32)] [-Direction (String)] 
                 [-FillChar (Char)] [-EmptyChar (Char)] [-Brackets (String[])] 
                 [-BorderStyle (String)] [-ColorPalette (Hashtable)] 
                 [-ColorMode (String)] [-ColorThresholds (Hashtable)] 
                 [(CommonParameters)]
</pre>

**Parameters**

| Parameter | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `Tick` | `Int32` | True | None | The current loop iteration executing the mathematical position modulus. |
| `Width` | `Int32` | False | `20` | The structural size constraint for the animation track. |
| `Direction` | `String` | False | `Horizontal` | Horizontal drives a physical character back and forth across the EmptyChar track. Vertical simulates a wave constraint across a single terminal line mathematically cycling step-height box blocks (` `, `▂`, `▄`, `█`) repeated across the Width domain. |
| `FillChar` | `Char` | False | `[char]9608` | The character populating the completed segment. |
| `EmptyChar` | `Char` | False | `-` | The character populating the remaining segment. |
| `Brackets` | `String[]` | False | `@('[', ']')` | Cap strings for the left and right boundaries. |
| `BorderStyle` | `String` | False | `None` | Applies a border style: None, Thin, Double, Rounded. |
| `ColorPalette` | `Hashtable` | False | `@{}` | Custom color palette mapping (Keys: Fill, Empty, Brackets, Border). |
| `ColorMode` | `String` | False | `Solid` | Determines the coloring logic (Solid, Conditional, Gradient). |
| `ColorThresholds` | `Hashtable` | False | Map | Map of integer thresholds to SGR color sequences for Conditional mode. |  

---

### `Format-TuiString`

Formats a string with ANSI SGR sequences to fit within a specified width.

**Syntax**

<pre>
Format-TuiString [-Text] (String) 
                 [-Width] (Int32) 
                 [-Alignment] (String) 
                 [-PadChar] (Char) 
                 [(CommonParameters)]
</pre>

**Parameters**

| Parameter | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `Text` | `String` | True | None | The text to be formatted. |
| `Width` | `Int32` | True | None | The maximum width of the formatted string. |
| `Alignment` | `String` | False | `Left` | Determines the text alignment (Left, Center, Right). |
| `PadChar` | `Char` | False | ` ` | The character to be used for padding. |

**🔻Outputs**

`[string]` - Outputs System.String

---

### `New-Sparkline`

Generates a compact, inline data visualization line utilizing Unicode step blocks. Automatically evaluates array ranges to dynamically map boundaries to block heights.

**Syntax**

<pre>
New-Sparkline [-Data] (Double[]) 
              [-ColorPalette (Hashtable)]
              [-ColorMode (String)] 
              [-GradientStart (Int32[])] 
              [-GradientEnd (Int32[])] 
              [(CommonParameters)] 
</pre>

**Parameters**

| **Parameter** | **Type** | **Required** | **Default** | **Validation** | **Description** |
| --- | --- | --- | --- | --- | --- |
| `Data` | `Double[]` | True | None | None | The array of data to be rendered. |
| `ColorPalette` | `Hashtable` | False | `@{}` | None | Custom color palette mapping (Keys: Fill, Empty, Brackets, Border). |
| `ColorMode` | `String` | False | `Solid` | Set | `Solid`, `Conditional`, `Gradient`. Configured for `Conditional` threshold mapping by default (inverted logic: red at top, green at bottom). |
| `GradientStart` | `Int32[]` | False | `@(255, 0, 0)` | None | Array of three integers (`R`, `G`, `B`) defining the 0% index color. Used when `ColorMode` is `Gradient`. |
| `GradientEnd` | `Int32[]` | False | `@(0, 255, 0)` | None | Array of three integers (`R`, `G`, `B`) defining the 100% index color. Used when `ColorMode` is `Gradient`. |

**🔻Outputs**

`[string]` - Outputs System.String

---

### `Join-TuiBlock`

Horizontal string concatenation engine. Strips ANSI formatting in memory to establish true visible width boundaries of the left block, applying precise whitespace buffers before adjoining the right block. Ideal for assembling complex, multi-component TUI dashboards.

**Syntax**

<pre>
Join-TuiBlock [-LeftBlock] (String) 
              [-RightBlock] (String) 
              [-Padding (Int32)] 
              [(CommonParameters)]
</pre>

**Parameters**

| **Parameter** | **Type** | **Required** | **Default** | **Validation** | **Description** |
| --- | --- | --- | --- | --- | --- |
| `LeftBlock` | `String` | True | None | None | The left block to be joined. |
| `RightBlock` | `String` | True | None | None | The right block to be joined. |
| `Padding` | `Int32` | False | `4` | None | The number of spaces to be inserted between the blocks. |

**🔻Outputs**

`[string]` - Outputs System.String

---

### `New-TuiPanel`

Encapsulates string arrays or pre-rendered component blocks within strict, titled ANSI border definitions. Scales dimensions dynamically based on internal component length logic while retaining alignment control.

**Syntax**

<pre>
New-TuiPanel [-Content] (String[]) 
             [-Title (String)] 
             [-Width (Int32)] 
             [-BorderStyle (String)] 
             [-ColorPalette (Hashtable)] 
             [-Alignment (String)] 
             [-Padding (Int32)] 
             [(CommonParameters)]
</pre>

**Parameters**

| **Parameter** | **Type** | **Required** | **Default** | **Validation** | **Description** |
| --- | --- | --- | --- | --- | --- |
| `Content` | `String[]` | True | None | None | The array of content to be rendered. |
| `Title` | `String` | False | `""` | None | The title to be rendered. |
| `Width` | `Int32` | False | `0` | None | The absolute total character length of the generated string output (excluding ANSI escape codes). |
| `BorderStyle` | `String` | False | `Thin` | Set | `Thin`, `Double`, `Rounded`. Applies an architectural wrap around the bar. |
| `ColorPalette` | `Hashtable` | False | `@{ Border = "38;5;240"; Title = "38;5;255" }` | None | Custom color palette mapping (Keys: Fill, Empty, Brackets, Border). |
| `Alignment` | `String` | False | `Left` | Set | `Left`, `Center`, `Right`. Defines relative text injection. |
| `Padding` | `Int32` | False | `1` | None | The number of spaces to be inserted between the blocks. |

**🔻Outputs**

`[string]` - Outputs System.String

---

### `Hide-TerminalCursor` / `Show-TerminalCursor`

Sends the VT100 `?25l` (hide) and `?25h` (show) SGR execution codes to the host. Crucial for high-frequency rendering loops to prevent the visible cursor block from visually stuttering as it rapidly jumps back and forth across the terminal window during buffer overwrites.

#### Best Practice Implementation

Best Practice Implementation

Use this to develop full-screen applications that do not pollute the user's scrollback buffer with leftover dashboard artifacts after the script terminates.

```powershell
try {
    Enable-TerminalAltBuffer
    Hide-TerminalCursor
    
    # Initialize full-screen TUI application
    while ($true) {
        # Frame rendering
    }
} finally {
    Show-TerminalCursor
    Disable-TerminalAltBuffer
}
```

## **Usage Examples**

### 1️⃣ Standard Output

```powershell
New-SimpleBar -Brackets @('<', '>') -Fill 45 -Width 25 -PercentagePosition Center
```

**Output Structure:**

`<█████████45%------------>`

### 2️⃣ Formatted Color Conditional Injection

```powershell
$palette = @{ Empty = "38;5;236"; Brackets = "38;5;245" }
New-SimpleBar -Fill 80 -Width 40 -ColorMode Conditional -ColorPalette $palette -PercentagePosition After
```

**Output Structure:**

`[██████████████████████████████--------] 80%`

### 3️⃣ Rendering a Progress Bar with a Custom Color Palette

```powershell
New-SimepleBar -Fill 100 `
              -Width 10 `
              -ColorPalette @{ Fill = "38;5;46" } `
              -ColorMode Solid
```

**Output Structure:**

`[████████]`

### 4️⃣ Rendering a Progress Bar with a Custom Color Threshold

```powershell
New-SimpleBar -Fill 40 `
              -Width 40 `
              -ColorMode Conditional `
              -ColorPalette @{ Empty = "38;5;236"; Brackets = "38;5;245" }`
              -PercentagePosition After
```

**Output Structure:**

<pre>
[███████████████-----------------------] 40%
</pre>

### 5️⃣ Full Terminal Animation (True RGB)

```powershell
New-SimpleBar -Fill 80 `
              -Width 40 `
              -ColorMode Gradient `
              -ColorPalette @{ Empty = "38;5;236"; Brackets = "38;5;245" } `
              -PercentagePosition After `
              -FillChar '#' `
              -GradientStart 255,10,100 `
              -GradientEnd 0,240,10
```

**Output Structure:**
> Note: The gradient is rendered as a single string with embedded ANSI SGR sequences.

<pre>
[##############################--------] 80%
</pre>

### 6️⃣ Full Terminal Animation (True RGB) Sample Function

```powershell
$params = @{
    Width = 50
    PercentagePosition = 'Center'
    ColorMode = 'Gradient'
    GradientStart = @(0, 255, 255)
    GradientEnd = @(128, 0, 128)
}
Invoke-SimpleBarAnimation -BarParameters $params -DelayMilliseconds 10
```

**Output Structure:**

> Note: The gradient is rendered as a single string with embedded ANSI SGR sequences.

<pre>
[██████████████████████100%██████████████████████]
</pre>


### Horizontal Border Styling

```powershell
New-SimpleBar -Fill 65 -BorderStyle Rounded -Width 30 -PercentagePosition Center
```

**Output Structure:**

<pre>
╭────────────────────────────╮
│[███████████65%███---------]│
╰────────────────────────────╯
</pre>

### Console Animation Wrapper

```powershell
$params = @{
    Width = 50
    PercentagePosition = 'Center'
    ColorMode = 'Gradient'
}
Invoke-SimpleBarAnimation -BarParameters $params -DelayMilliseconds 10
```

### 3D Extrusion

```powershell
New-3DBar -Title "CPU 6-core" -Fill 58 -Subtext "3.8 GHz · usr 58% sys 14%"
```

**Output Structure:**

<pre>
CPU 6-core
[╭──────────────────────╮················]  58%
[│██████████████████████│················]
[╰──────────────────────╯················]
3.8 GHz · usr 58% sys 14%
</pre>

### Multi-Column Vertical Arrays

```powershell
$metrics = [Ordered]@{ CPU=72; RAM=55; GPU=88; NET=41; DSK=63; SWP=18 }
New-VerticalBar -Data $metrics -Style BrailleCol -BorderStyle Thin
```

### Trailing History Logs

```powershell
$history = [System.Collections.Generic.Queue[string]]::new()
$history.Enqueue("INIT: Load Sequence Complete")
$history.Enqueue("WARN: High Latency Detected")
New-TrailingLog -LogData $history -MaxLines 5 -ColorMode GradientFade
```

**Output Structure:**

<pre>
INIT: Load Sequence Complete
WARN: High Latency Detected
</pre>

### Horizontal Rule Separator

```powershell
New-Separator -Char '=' -Repeat 45 -ColorMode Gradient -GradientStart @(128,0,128) -GradientEnd @(0,255,255)
```

**Output Structure:**

<pre>=============================================</pre>

## **RGB Array Support**

### Overview

The `-ColorPalette` and `-ColorThresholds` **hashtable** parameters across all visual functions feature dynamic schema interpretation. They natively accept either literal string definitions  or strictly formatted integer arrays representing the `[R, G, B]` true-color spectrum.
Type Translation Example

If an array consisting of exactly three values is parsed within the map, the engine intercepts the property prior to concatenation and formats it.

**User Entry:**

```powershell
-ColorPalette @{ 
    Border = @(255, 0, 255) # RGB Magenta 
    Empty  = "38;5;236"     # SGR Fallback
}
```

**Internal Translation Engine:**

```powershell
# Intercepts @(255, 0, 255)
return "38;2;255;0;255"
```

## Testing

This module utilizes the [Pester](https://pester.dev/) testing framework to validate character arithmetic, string constraints, and ANSI logic.

To execute the test suite:

```powershell
Invoke-Pester -Path .\SimpleBar.Tests.ps1 -Output Detailed
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.