---
date: 2022-06-23
title: Get LXD Running Under WSL2 on Windows 11 with Ubuntu 18.04
headline: Get LXD Up and Running on Windows 11 with Ubuntu 18.04
description: Learn how I got LXD running on Windows 11 with Ubuntu 18.04. I'll show you how to download the install.sh file, enable systemd, and test if it's running. Plus, I'll share how to fix failed attempts and start fresh. Get all the steps you need to get LXD up and running today.
keywords: LXD, WSL2, Windows 11, Ubuntu 18.04, Install.sh, Systemd, Distrod, Enable, Ps, Comm, Purge, Delete, Fresh Attempt
categories: microsoft, wsl, journaling, systemd, container
permalink: /blog/get-lxd-running-under-wsl2-on-windows-11-with-ubuntu-18-04/
layout: post
---


Teach how to get LXD under WSL2 running, easy peasy!

{% include youtubePlayer.html id="10pibiReR94" %}

https://github.com/nullpo-head/wsl-distrod

To enable systemd on an existing WSL2 installed Linux:

    curl -L -O "https://raw.githubusercontent.com/nullpo-head/wsl-distrod/main/install.sh"
    chmod +x install.sh
    sudo ./install.sh install

And then enable it:

    /opt/distrod/bin/distrod enable

Test whether systemd is running:

    ps --no-headers -o comm 1

If that prints "systemd" you're all set to install lxd!

# If there had been failed attempts:

    sudo apt purge lxd
    sudo rm -rf /var/lib/lxd

# If a fresh attempt:

    sudo apt install lxd
    sudo lxd init
    (yes all the way through wizard)

Reboot. wsl --shutdown from Powershell

    lxc launch images:ubuntu/18.04 u1804a
    lxc exec u1804a -- su --login ubuntu

Keep this in mind for sharing volumes from pool:

    lxc storage volume create default blah
    lxc config device add c1 blah disk pool=default source=blah path=/blah
    lxc config device add c2 blah disk pool=default source=blah path=/blah

There's also advice on sharing host volumes (including home):
- https://ubuntu.com/blog/mounting-your-home-directory-in-lxd
- https://www.cyberciti.biz/faq/how-to-add-or-mount-directory-in-lxd-linux-container/


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/on-being-unstoppable-apis-lxd-lxd-under-wsl2-success/">On Being Unstoppable, APIs & LXD / LXD Under WSL2 (Success!)</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/lxd-linux-containers-in-windows-linux-wsl2-but-what-is-home/">LXD Linux Containers in Windows Linux WSL2, But What Is Home?</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li></ul>