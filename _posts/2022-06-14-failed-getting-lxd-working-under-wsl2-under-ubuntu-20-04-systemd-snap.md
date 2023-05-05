---
date: 2022-06-14
title: Failed Getting LXD Working Under WSL2 Under Ubuntu 20.04 systemd & snap
headline: "My Journey to Get LXD Working Under WSL2: A Failed Attempt"
description: "I tried to get LXD running on WSL2, but couldn't make it work. Now I'm trying two things to make it work: installing the kernel headers and ZFS, and loading the module. I'll need to reload the module after each restart. Read my blog post to find out how this journey went!"
keywords: LXD, WSL2, Ubuntu 20.04, systemd, snap, kernel headers, ZFS, module, restart, failed, journey, efforts
categories: systemd, lxd, wsl2, journey
permalink: /blog/failed-getting-lxd-working-under-wsl2-under-ubuntu-20-04-systemd-snap/
layout: post
---


# Trying to get LXD working under WSL2

> The prize is big;<br />
> On turf I'm first.<br />
> To crack this nut<br />
> I have a thirst.<br />
> The itch I scratch<br />
> Make no mistake's<br />
> The bug you catch:<br />
> Windows ESCAPE!<br />
> <br />
> <cite>&#151;Mike Levin, 2022</cite><br />

# First Attempt Failed Despite Heroic Rabbit-Chasing Efforts

{% include youtubePlayer.html id="Wx97QTMFCt0" %}

Play pied piper showing the way to fullscreen Linux Terminal goodness.

Ugh! The last livestream attempting to

    sudo lxd init

Failed on 2 fronts:

1. It did not present zfs as an option
2. The it did not result in anything listed when trying:

    sudo lxd list

There were error messages and it seemed network-related, so I have 2 things I'm
going to try:

More information on making zfs available as an option:
https://stanislas.blog/2018/02/lxc-zfs-pool-lxd/

It suggests that you first install the kernel headers to allow us to compile
and install kernel modules:

    apt install linux-headers-$(uname -r)

It them suggests we install ZFS ***AND*** DKMS modules (old instructions didn't
have DKMS):

    apt install zfs-dkms zfsutils-linux

Next is says we need to load the module:

    modprobe zfs

And it also says that after every restart it needs to be reloaded, which we can
do with this:

    echo "zfs" >> /etc/modules


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/windows-updates-kb5014699-kb5013887-lxd-on-wsl2-under-ubuntu-20-04/">Windows Updates KB5014699 & KB5013887 & LXD on WSL2 Under Ubuntu 20.04</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/trying-again-to-get-lxd-working-under-microsoft-subsystem-for-linux/">Trying Again To Get LXD Working Under Microsoft Subsystem For Linux</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li>
<li><h4><a href='/wsl2/'>WSL2</a></h4></li>
<li><h4><a href='/journey/'>Journey</a></h4></li></ul>