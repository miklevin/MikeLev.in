---
date: 2022-07-26
title: Linux Container Under Windows 10 WSL Supporting Graphics
headline: Unlocking Linux Graphics with Containers on Windows 10 WSL
description: I recently discovered that it is possible to get Linux graphics working with Linux containers on Windows 10 using VcXsrv. I figured out how to capture the DISPLAY variable from the host Linux and pass it to the container by writing it to a shared file. This technique is similar to activating Python virtual environments, and I'm excited to share my findings with you.
keywords: Linux, Windows 10, WSL, VcXsrv, DISPLAY variable, Python, Virtual Environments, Containers, Graphics, Host Linux, Shared File
categories: windows 10, wsl, graphics, linux, containers, python
permalink: /blog/linux-container-under-windows-10-wsl-supporting-graphics/
layout: post
---


I've been showing people how to get Linux graphics working under the Windows
Subsystem for Linux on Windows 10 using VcXsrv for awhile now. But now that I'm
using containers, the question arises whether these containers can use the same
Linux graphics. And so...

See if we can get Linux graphics under:

- Windows 10
- WSL2 (Windows Subsystem for Linux)
- LXD Container
- VcXsrv (X-Server)
  - Unnecessary on Windows 11 because of WSLg
  - WSL supports graphics on Windows 11 but not Windows 10

{% include youtubePlayer.html id="HWzKHzjLuic" %}

Yes, it was possible. The .bash_profile of the "host" Linux running directly
under WSL2 is must contain:

    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

This requirement predates containers to make VcXsrv know where to listen to
X-Windows messages. It amounts to finding the IP of the internal DNS server,
which is always a trick with these virtual-lan setups. That command extracts it
from a standard Linux file /etc/resolv.conf and plugs it into a location
accessible from the container.

I had to capture this variable and "pass it down" to the container. It's
dynamically generated on the host, but it must be the same one used in the
Linux container's DISPLAY environment variable. And since my ~/data location is
in common to the host and container, I am able to do this in the .bash_profile
as well:

    echo "export DISPLAY=${DISPLAY}" > ~/data/display.sh

An unexpected surprise is that because the contents of this file reads exactly
like an executable bash script:

    export DISPLAY=172.30.112.1:0

...I am able to put this one very simple line into the .bash_profile of the
container:

    source ~/data/display.sh

...which you may recognize as extremely similar to the command that activates
Python venvs:

    source ~/py310/bin/activate

...because it's using the same trick!


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/removing-password-authentication-from-ssh-services/">Removing Password Authentication from SSH Services</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/windows-11-is-more-like-windows-il-for-it-s-linux/">Windows 11 is more like Windows Il (for It's Linux)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/windows-10/'>Windows 10</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>