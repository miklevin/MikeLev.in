---
date: 2022-09-25
title: Failed To Get This Going During Weekend
headline: "Failed Attempt at Multi-OS Project: My Experience and Challenges"
description: I tried to get a project going this weekend, involving cycling IPs and installing the latest JupyterLab-Desktop, but I failed. Instead, I decided to stay on Linux and communicate with files. This project is split across multiple OSes, with a Python busy loop Windows-side without Jupyter. Read my blog post to learn more about my experience and the challenges I faced!
keywords: Cycling IPs, JupyterLab-Desktop, Linux, Files, OSes, Python, Busy Loop, Windows-side, StackOverflow, Challenges, Experience
categories: python, linux
permalink: /blog/failed-to-get-this-going-during-weekend/
layout: post
---


Ugh, after all my work getting Linux Jupyter running with graphics under
Windows, my next project involves cycling IPs after every so often. I lost my
code somehow from the last time I did this, but it's so critical and necessary
to this next job which I would actually like to get running overnight tonight
to get a jump on it. So, recreate! What do you still know? When I investigated
it last, I found this StackOverflow discussion and code:

[https://stackoverflow.com/questions/69705923/control-windows-app-hma-vpn-using-pywinauto](https://stackoverflow.com/questions/69705923/control-windows-app-hma-vpn-using-pywinauto)

```python
from pywinauto import Desktop,Application
vpn_app = Application(backend="uia").start('C:\Program Files\Privax\HMA VPN\Vpn.exe')
dialog=Desktop(backend="uia").HMA
panel0=dialog.Pane
# Command to connect / disconnect the VPN: connect_button.click()
connect_button=panel0.ConnectButton
# Command to change the IP address: changeIP.click()
changeIP=panel0.Button5
# Check VPN state:
# 0 if disconnected
# 1 if connected
print(connect_button.get_toggle_state())

# Command to connect / disconnect the VPN: connect_button.click()
connect_button=panel0.ConnectButton
connect_button.click()

# Command to change the IP address: changeIP.click()
changeIP=panel0.Button5
changeIP.click()

# Check VPN state:
# 0 if disconnected
# 1 if connected
print(connect_button.get_toggle_state())
```

What a gift and wonderful starting point. Okay, bite the bullet and reinstall
JupyterLab-desktop. It's up to 3.4.6-1 just released 2 weeks ago.
https://github.com/jupyterlab/jupyterlab-desktop/releases/download/v3.4.6-1/JupyterLab-Setup-Windows.exe

Wow, 532MB. This thing is a quarter to half half as big as Anaconda. Anyhoo,
force Windows to let me download, then force Windows to let me run. New Windows
security really works against this sort of thing. I'm going to Install Python
environment using the bundled installer to stay on the well beaten track and
see what versions they're bundling these days. I'm also going to accept the
rest of the defaults regarding "just for me" and paths.

Okay, done. Reboot system to make sure I'm making a very clean fresh start. So
now only Ubuntu 20.04 for journaling in memory plus JupyterLab Desktop for
Windows. Okay, sometimes getting momentum again is all about a series of
ridiculously small but clearly defined steps. JupyterLab Desktop uses my
Windows "home" folder (C:\Users\%USERNAME%) as home, so from there I can go
into the repo folder, which is the same across most of the platforms I use at
home now (yay!).

Oh I just noticed that right-click closing a tab also closes that Python
kernel. I wonder how long it's been that way. Useful information. Okay, I'm
convinced I lost the old code to do this, so work it up in baby steps... 1, 2,
3... 1? Make a strong new nickname for this, so the code-loss problem won't
happen again. It deserves its own repo... serpcycler! Okay, done. Make a strong
new nickname for this, so the code-loss problem won't happen again. It deserves
its own repo... serpcycler! Okay, done.

Ugh, I have to get this done and my first attempt failed miserably and because
it's the weekend and there's tons of distractions, I lost momentum. And that's
fine because the projects it lost to were worth it. Anyway, it failed because
my attempt to install the latest JupyterLab-Desktop failed to connect to the
kernel. I could revert to older versions but I'm taking this as a message to
stay on Linux and just find another way. I can communicate across OSes with
files. And so all I need is a file that says needs new IP and when it's
noticed, it gets a new IP, deletes the file and starts monitoring for it again.
Yes! This way I can keep the bulk of the project Linux-side.

Okay, so this project is broken into at least 2 parts, split across OSes
communicating via files. Make a Python busy loop Windows-side without Jupyter.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/programming-a-python-do-nothing-machine/">Programming a Python Do Nothing Machine</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/if-greys-exist-they-re-a-banana-crops/">If Greys Exist They're a Banana Crops</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>