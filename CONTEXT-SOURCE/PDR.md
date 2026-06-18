# **Project Decision Record (PDR)**

## **PDR-01: Module Restructuring and Rename to FluidBar**

### **Context**
The module was originally named `SimpleBar` and maintained as a single monolithic script file (`simplebar.ps1`). While simple, this layout introduced performance overhead during module loading and made local unit testing and automated build packaging difficult. To align with the standard Phellams deployment pipeline and the `phellams-automation-agent` developer spec, the codebase must transition to a clean, multi-file framework.

### **Decision**
We will:
1. Rename the module and all core cmdlets from `SimpleBar` / `simplebar` to `FluidBar` / `fluidbar`.
2. Restructure the monolithic file into a split-file layout:
   - **`FluidBar.psm1` (Root Module Loader)**: Discovers and dot-sources all scripts using high-performance .NET file enumeration, and controls public exports explicitly.
   - **`/cmdlets/`**: Hosts public Verb-Noun `.ps1` cmdlets, file-per-cmdlet (e.g. `New-FluidBar.ps1`).
   - **`/libs/`**: Hosts private shared helper scripts (e.g. `Get-TerminalUI.ps1`, `Get-TerminalPalette.ps1`) and terminal initializers.
3. Configure the standard Phellams build chain using `build_config.json`, `phwriter-metadata.ps1`, `.gitlab-ci.yml`, and `test-unit-pester.ps1`.

### **Consequences**
- 🟩 **Improved Load Performance**: Using .NET file enumeration bypasses native pipeline bottlenecks during session loading.
- 🟩 **Easier Maintainability**: Individual cmdlets can be edited and tested independently.
- 🟩 **Pipeline Integration**: Aligns perfectly with the standard GitLab CI/CD building and deployment templates.
- 🟥 **Breaking Change**: Older script references to `New-SimpleBar` or `SimpleBar` manifest will fail and must be updated to `New-FluidBar` / `FluidBar`.
