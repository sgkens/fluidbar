# **FluidBar Module Roadmap**

## **Milestone 1: Split-File Architecture & Renaming (v1.2.0)**
* Restructure monolithic file into `cmdlets/` and `libs/` subdirectories.
* Rename all endpoints and helpers from `SimpleBar` to `FluidBar`.
* Support custom terminal initialization under a unified `Initialize-Terminal.ps1` helper.
* Standardize local and pipeline build routines with `build_config.json`.
* Port and update existing Pester unit tests to target the new architecture.

## **Milestone 2: Enhanced TUI Controls & Auto-Documentation (v1.3.0)**
* Integrate `PHWriter` to dynamically generate and keep comment-based help updated.
* Add performance profile metrics for vertical arrays under high-frequency updates.
* Implement a `Repair-Terminal` panic recovery routine.

## **Milestone 3: Complete Homelab / Private Gallery Releases (v1.4.0)**
* Integrate NuGet package deployment pipelines for private GitLab storage.
* Automate pre-release tag matching logic in GitLab CI/CD.
