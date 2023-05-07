---
date: 2022-11-29
title: WSL Linux Graphics and Systemd Support Takes Priority Over LXD
headline: Prioritizing Linux Graphics and Systemd Over LXD in WSL - Check Out My Repository 'drinkme'
description: "I'm MikleVin and I recently created a new repository to prioritize getting Linux graphics and SYSTEMD working over LXD Linux Containers in the Windows Subsystem for Linux. Check out my repository 'drinkme' at https://github.com/miklevin/drinkme and stay tuned for my upcoming video to explain these changes."
keywords: WSL, Linux, Graphics, Systemd, LXD, Containers, Windows, Subsystem, MikleVin, Repository, Drinkme, Video, Prioritize, Changes
categories: systemd, microsoft, container, change, drinkme, wsl, graphic, linux
permalink: /blog/wsl-linux-graphics-and-systemd-support-takes-priority-over-lxd/
layout: post
---


{% include youtubePlayer.html id="SgN6nWn6JHk" %}

Yesterday, YouTube viewer eugrus asked:

> Aren't the WSL distros also basically containers? Why not import LXC-tarballs
> as WSL distros instead of adding an actual LXC management layer?

I answered it was that I wanted to master the LXC API and not WSL. Getting good
at Microsoft tech in particular shuts you into Microsoft. No sooner did I
express that opinion than I realized getting LXD to work under the new Windows
Subsystem for Linux that was just released under the Microsoft store was going
to be harder than I thought -- at least with full Linux graphics support.

The puzzle becomes this:

- Get Linux Graphics working
- Get SYSTEMD working
- Get LXD Linux Containers working
- Get Linux Graphics & SYSTEMD working UNDER an LXD Linux Container

It seems possible, but it turns out I can't dedicate all the time in the world
to this. It starts to defeat the purpose. So some time yesterday I backed off
and decided to 2 out of 4 ain't bad. Much of the reason I used LXD was because
the Linux provided by Microsoft was so non-standard and any scripts I wrote to
automate building my environments would be different against a Microsoft Linux
vs. an LXD Linux because the first thing I'd have to do is a hack to get
SYSTEMD installed. That's no longer true, or only just requires an
/etc/wsl.conf file as opposed to a distrod or other 3rd-party hack.

And so... and so... the repo LXDWIN is no more. Instead it's now:

     ____       _       _      __  __        _     _
    |  _ \ _ __(_)_ __ | | __ |  \/  | ___  | |   (_)_ __  _   ___  __
    | | | | '__| | '_ \| |/ / | |\/| |/ _ \ | |   | | '_ \| | | \ \/ /
    | |_| | |  | | | | |   <  | |  | |  __/ | |___| | | | | |_| |>  <
    |____/|_|  |_|_| |_|_|\_\ |_|  |_|\___| |_____|_|_| |_|\__,_/_/\_\


LOL! I started using the Alice in Wonderland motif in Levinux and it seems to
have worked well, so I figure I'll make one of its great symbols of commitment
(and throwing caution to the wind) into the repo name. It can be found at
https://github.com/miklevin/drinkme or using the old shortcut which I
redirected to the new location https://mikelev.in/ux

It's time to make a video, right? ASAP. The iron is hot. Lots of people are
probably trying to figure out what these changes mean.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/microsoft-added-linux-graphics-and-systemd-to-wsl-for-windows-10/">Microsoft Added Linux Graphics and Systemd to WSL for Windows 10</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/lxdwin-is-now-the-drinkme-jupyterlab-linux-install-script/">LXDWIN is now the DrinkMe JupyterLab Linux Install Script</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/change/'>Changes</a></h4></li>
<li><h4><a href='/drinkme/'>DrinkMe</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/graphic/'>Graphics</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>