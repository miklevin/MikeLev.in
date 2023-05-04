---
date: 2022-09-17
title: Preserving ~/.jupyter config files between WSL 2 LXD installs
headline: Preserving JupyterLab Dark Theme Across WSL 2 LXD Installs
description: I'm working on a project that requires WSL 2 LXD, and I needed to save my ~/.jupyter config files between installs. I identified the default location and created a transfer directory, added an environment variable, and tested the process. After reinstalling, I confirmed that my JupyterLab dark theme was still active. Follow my journey as I go through the process and make sure my JupyterLab dark theme is still active.
keywords: "WSL 2 LXD, ~/.jupyter, config files, transfer directory, environment variable, JupyterLab, dark theme, PowerShell, lxc jupyterlogin, jupyterscreen, localhost:8888, install.bat, repos/wsl2lxd"
categories: powershell, jupyterlab
permalink: /blog/preserving-jupyter-config-files-between-wsl-2-lxd-installs/
layout: post
---


I have tons of work to do this weekend on an entirely other front than either
my kid or this new... uh... wsl2lxd... work. It still doesn't roll off the
tongue but I want it aligned to what people are going to search on. It's
definitely lxd and wsl. LXD4WSL? That feels maybe more genuine because I'm not
converting wsl to lxd. But you ***are going from*** wsl to lxd, so it is legit.
And you do start out in wsl and go to lxd, so I'll keep it. The other way
around sounds too much like you're modifying lxd for wsl. Well so long as I
stay with this naming approach I'll have such issues because I want a number
between them (and not a hyphen or underscore).

Okay, next? Get one or two tiny things in today before the day gets underway
proper. I also have one of those long drives to the Poconos this weekend to
pick up and drop off stuff. Ugh! Four plus hours and all the related energy and
momentum lost on just that. But I'll cross that bridge. Use your good morning
energy right now wisely.

Okay, realization: Jupyter uses environment variables that have been set in the
shell from which it is run. This provides a way to control things about Jupyter
without having to feed everything on the command that runs it. I'm shoving a
lot on that command right now, especially the hash that keeps the password
"foo". It's one of the idiosyncrasies about Jupyter on LXD under WSL that's
hard to get around. The server must be "secured" and if you're not passing
tokens (even harder to do in this context) then you're using a password. Oh
foo. Okay... environment variables to change where the config files go so you
only ever need set theme to black once. And there's that "reset kernel and
clear all" keyboard shortcut I never want to set again. 1, 2, 3... 1?

Identify the default location Jupyter stores config files. Okay, per this page:
https://docs.jupyter.org/en/latest/use/jupyter-directories.html

> Config files are stored by default in the ~/.jupyter directory.

Not bad. So first order of business is to allow repos to contain hidden config
files. I already do that with the display.sh file for passing WSL host DNS
server IP for display port address for VcXsrv X-Windows server. I never thought
to make it invisible. Do that... done. Okay in doing so I realize I already
have a transfer directory in repos ~/repos/transfer and this is completely
appropriate to contain .jupyter. It will be nice to keep all the hidden stuff
(for transfer) grouped under repos. Okay... make the install scripts make that
location... hmmm, I really love the symmetry of install.bat and install.sh
because of how it implies the two halves of the process, what they're doing and
where they take place although it's annoying in command-line completion.

Okay, making the transfer directory belongs Windows-side in install.bat and
that's done. Wow, this is nice. That's also going to be the mechanism to move
apt_installs.sh and requirements.txt down into LXD. Okay, now simply add:

    # Allow all your Jupyter configuration (dark mode) survive reinstalls.
    export JUPYTER_CONFIG_DIR=~/repos/transfer/.jupyter

...to .bash_config. Wow, this is too easy! My practice on such things while
making Levinux is going a long way. Why hasn't anyone done this before. All
those poor people running Jupyter directly under Whinedoze when they don't have
to! If you're micro soft then you whine doze. This is all too suddenly easy.
It's no wonder Microsoft didn't include systemd on wsl. Some hurdles had to be
put in place before this discovery was made and made popular. I'm in a race.
Gotta get this published pronto. 1, 2, 3... 1? Okay, environment variable is
activated. Directory exits. This should just work now. Do a full install test.
Process?

- Run it once now. Notice it's JupyterLab Light.
- Change it to JupyterLab Dark.
- Open PowerShell, enter outer Linux, login to inner Linux, view Jupyter Server
  - wsl -d Ubuntu-18.04
  - lxc jupyterlogin
  - jupyterscreen
- Restart server
  - Ctrl+C
  - y
  - jupyterstart
- Ensure that JupyterLab dark theme is still active by visiting localhost:8888

Okay, all done. That ensures that currently Jupyter configs are working and
persistent between server restarts. Now do a reinstall of the whole WSL
instance, LXD instance and JupyterLab Server instance (install.bat):

- Open a PowerShell
- cd to repos\wsl2lxd
- Run .\install.bat

Watch the bunny go down the rabbit hole... Wow if this works it's yet another
benefit of running Jupyter this way when you're on Windows. It provides an easy
way for your Jupyter configuration to survive upgrading Jupyter. You can
upgrade Jupyter in location with an apt upgrade or you can just reinstall the
whole thing which will have no real harm. It'll wipe out your apt and pip
installs but I'm working on that too. After they're run, they'll be kept in the
transfer directory always accessible during reinstalls. Wow!

Okay, do a refresh on localhost:8888... back to password... hit Enter... back
to white! Good, this was an old fashioned ~/.jupyter config store location. No
put JupyterLab dark theme back on and run the install script again...

Do a refresh on localhost:888 which for the one person who's following along
here I'm actually doing from an installed Edge app which is much better than in
a localhost:8888 tab in a browser. Bingo! JupyterLab dark theme! The config has
survived between re-installs. Great success.

Think through next steps regarding apt and pip installs. This very much clears
the way. I'll drop those files directly into ~/repos/transfer. Avoid
subdirectory-hell. You're already two deep.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/running-ubuntu-18-04-and-ubuntu-20-04-simultaneously-under-wsl-2">Running Ubuntu 18.04 and Ubuntu 20.04 Simultaneously Under WSL 2</a></div><div class="post-nav-next"><a href="/blog/ubuntu1804-exe-ubuntu2004-exe-and-ubuntu2204-exe-oh-my">ubuntu1804.exe, ubuntu2004.exe and ubuntu2204.exe Oh My!</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/powershell/'>Powershell</a></h4></li>
<li><h4><a href='/jupyterlab/'>JupyterLab</a></h4></li></ul>