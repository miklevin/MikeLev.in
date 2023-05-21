---
date: 2022-09-21
title: Google Chrome for Linux Under LXD on WSL on Windows
headline: Successfully Launched Google Chrome on Linux Using LXD on WSL on Windows
description: I succeeded in getting Google Chrome up and running on my Linux system using LXD on WSL on Windows. I followed several steps to make sure the configuration settings would survive between reinstalls, and I'm thrilled to be able to launch it with google-chrome. After some hard work, I'm finally able to enjoy the fruits of my labor!
keywords: Google, Chrome, Linux, LXD, WSL, Windows, Configuration, Settings, Reinstalls, Requirements, Repo, Commands, Apt_installs.sh, Requirements.txt, Launch, Working, Hard Work
categories: container, wsl, setting, google, microsoft, linux
permalink: /blog/google-chrome-for-linux-under-lxd-on-wsl-on-windows/
layout: post
---


Okay I'm in a great position. I need to use this for my dayjob pronto! I have
graphics working on the lxdwin default install. I have the optional apt and
pip installs working too. Now with all due haste!

Put the Google Chrome requirements in the main repo. This is friggin' awesome.
1, 2, 3... 1?

Did a few googles. Threw a few commands in apt_installs.sh. Testing now.

OMFG, thank you! It's working. google-chrome is the way to launch it. Now get
to work. Don't lose anymore time in tooling. When you get a new dependency,
throw it into requirements.txt or apt_installs.sh in the lxdwin repo. Wow, this
is friggn' coming together.

Oh, just do one more with most of the requirements thrown in as are obvious
from looking at... at which repo? It's mostly now from seokata. Okay, focus!

Got everything done today that I needed to do, albeit pushing midnight. Still
counts, right?

Anyhow, on the lxdwin front, I got Google Chrome installing and its
configuration settings surviving between reinstalls.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/wsl2lxd-is-now-lxdwin-apt-pip-installs-done-graphics-implemented/">WSL2LXD is now lxdwin, Apt & Pip Installs Done. Graphics Implemented.</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/working-on-a-tiktok-script/">Working on a TikTok Script</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/setting/'>Settings</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>