---
date: 2022-12-21
title: WSL & LXD Let Us Run Generic Linux Server-Build Scripts Without Docker
headline: Run a Linux Server on Windows with WSL & LXD - No Docker Needed!
description: As a user, I prefer LXD from Canonical over Docker for its ease of installation without a complex API. Additionally, Windows Subsystem for Linux (WSL) provides a container system that can be used to create 'server build scripts' to install a Linux server on Windows 10 or 11. With this, I can have a Linux server running in the background on my laptop. Read more to learn how to set up your own Linux server on Windows.
keywords: WSL, LXD, Linux, Server-Build, Scripts, Docker, Installation, Complex API, Windows, Container System, Server, Laptop, Software, Compositing System, Leverage, Scripts, Install
categories: container, microsoft, linux, python, wsl
permalink: /blog/wsl-lxd-let-us-run-generic-linux-server-build-scripts-without-docker/
layout: post
group: blog
---


You will find various anti-patterns here. Among the biggest is that I don't
think you should focus on Docker. There's better container tech, the sort that
doesn't lock-down system-space and force you to use a kooky compositing system
API. You should just be able to install software to your hearts content, as if
it were a real system.

Therefore, my container preference is LXD from Canonical, the same people who
brought us Ubuntu and the distro-independent snap installer. But most people
are on Windows and Microsoft's Windows Subsystem for Linux (WSL) already is a
container system and on 3/4 of the world's desktops. It's the tech that comes
with Windows that Docker relies upon, minus the Docker. So let's use it!

To leverage WSL, I prefer "server build scripts". With Windows offering
something close to standard generic Linux comes the support for standard
generic Linux installers. It's now easy to bottle-up some type of server,
expressing and distributing it as an install script. This trick works because
of lowest common denominators. You know all Windows 10 and 11 systems have
certain things available to everyone, such as the Linux subsystem.

Thanks to those quite high lowest common denominators, anyone on Windows 10 or
11 can do this trick. WSL now supports Linux graphics (across Windows 10 & 11)
and Linux services (called systemd) which install scripts can get running. This
leads to nice little Linux servers running in the background right on your
Windows laptop that you can get in and hack.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/google-sheets-api-python-example/">Google Sheets API Python Example</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/a-place-to-put-things/">A Place to Put Things</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li></ul>