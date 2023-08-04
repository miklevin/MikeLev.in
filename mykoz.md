---
permalink: /mykoz/
title: "MyKoz: AReal/OS - Using Linux to Improve Forever"
description: By installing the Linux version of JupyterLab on Windows, you are running the same code on your computer as you can on all Linux servers. From there you ease your way into a lifetime of mindfulness and timeless skills by keeping a 1-text-file Journal in vim for the rest of your life.
group: mykoz
---

![Mykoz A Real OS](/assets/images/mykoz-a-real-os-banner.png)

You've heard of Marcus Aurelius and Stoicism? This is MyKoz: AReal/OS and
Tow-it-ism; a way of using a Linux Subsystem on Windows for a minimalistic and
portable approach to computing.

This .bat script replaces the default Windows 10 or 11 Linux Subsystem Ubuntu
22.04 with a new one that has JupyterLab installed along with the latest
Python, NeoVim, and a few other goodies to get you started on your journey.

If you've been thinking of taking up skills that will last a lifetime in the
areas of programming, data science, and machine learning, this URL is the place
to start:

## Installation Procedure

Copy and paste the following into a Windows batch file, and double-click to
run. It will install Linux JupyterLab on Windows Subsystem for Linux (WSL) with
a few Github repositories to get you started with Free and Open Source SEO
Software.

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

