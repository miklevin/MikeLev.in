---
permalink: /drinkme
title: install linux jupyterlab on windows
description: a good way to start learning linux is to install it on windows and use the linux version of python under jupyterlab. this page will redirect you to the install script.
---

# {{ page.title }}

## {{ page.description }}

Copy the text below to your clipboard. Then create a file called `drinkme.bat`
on your Windows 10 or 11 desktop, save it, and double-click it. It will
download the latest version of MyKoz, replacing the default Windows Ubuntu
22.04 with one that will host JupyterLab on `localhost:8888` using the Linux
version of Python running on the Windows Subsystem for Linux (WSL). It will
also install a few Github repositories to get you started with Free and Open
Source SEO software, if that is of any interest to you. If not, it is a lesson
in generic data collection and analysis, which is the core of AI and many other
things.

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



