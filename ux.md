---
permalink: /ux/
title: Install Linux JupyterLab on Windows
description: MyKoz is a Windows 10 or 11 batch file that installs Linux JupyterLab on Windows Subsystem for Linux (WSL).
---

# {{ page.title }}

## {{ page.description }}

Copy and paste the following into a Windows batch file, and double-click to run. It will install Linux JupyterLab on Windows Subsystem for Linux (WSL) with a few Github repositories to get you started with Free and Open Source SEO Software.

```bash
@echo off
setlocal enableDelayedExpansion
set "TIME=%TIME::=%"
set "TIME=%TIME:.=%"
set /a "T=%TIME%"
set "URL=https://raw.githubusercontent.com/miklevin/drinkme/main/install.bat?cache=%T%"
set "FILENAME=Rabbit Hole.bat"
curl -s -o "%FILENAME%" "%URL%" ^
    -H "Cache-Control: no-cache, no-store, must-revalidate" ^
    -H "Pragma: no-cache" ^
    -H "Expires: 0" ^
    --proxy-header "Cache-Control: no-cache" ^
    --proxy-header "Cache-Control: no-store"
```

<img alt="Alice Falling Down Rabbit Hole ASCII Art" src="/assets/images/alice-ascii-art-copyright-mike-levin.png">



