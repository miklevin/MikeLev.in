---
date: 2022-09-13
title: Switching From WSL to LXD Containers Permanently
headline: "Making the Switch to LXD Containers: My Permanent Workflow Change"
description: I'm making a big change to my workflow and switching from Windows Subsystem for Linux (WSL) to LXD Containers on Windows. I've set up the mappings and added a command to my .bash_profile in WSL, and now I'm testing to make sure it's working. I'm hoping to move all my work over to the Container, and I've even figured out a trick to find the Windows home location. Come read my blog post to find out more!
keywords: Windows, WSL, LXD, Containers, Workflow, Mappings, .bash_profile, Testing, Move, Trick, Home, Location
categories: microsoft, trick, container, wsl
permalink: /blog/switching-from-wsl-to-lxd-containers-permanently/
layout: post
---


Wow, I did some absolutely amazing work yesterday with the Jupyter install
script and changing my github centralized location into repos. This will
probably be my last journal entry directly on WSL (Windows subsystem for Linux)
and instead all following activity will be from within an LXD container on
Windows. It's time to practice what I preach. I only have a few mappings to
make on the new jupyter container by running these lxc commands from the Ubuntu
18.04 WSL instance:

```bash
lxc config device add jupyter repos disk source=/mnt/c/Users/mikle/repos path=/home/ubuntu/repos
lxc config device add jupyter ssh disk source=/home/healus/.ssh/ path=/home/ubuntu/.ssh/
lxc config device add jupyter data disk source=/home/healus/data/ path=/home/ubuntu/data/
```

Wow, okay this is huge for my workflow. I'm literally taking WSL out of the
picture for all intents and purposes, because once you're on a real LXD
instance, you might as well be on any generic Linux. It is less compromised
than WSL. All I have to do is put this at the bottom of my .bash_profile in
wsl:

```bash
until
        lxc exec jupyter -- su --login ubuntu 2>/dev/null
do
        sleep 1
done
```

Okay, this is a test. I am continuing editing this from inside the LXD
container. No more WSL... woot!

I have a huge round of work to do tonight, but if I play my cards right, I can
move it all over to the Container. Push hard! 1, 2, 3... 1?

Mount my WSL locations on the LXD container. Here's the trick to finding your
Windows home location:

    WIN_HOME="$(printenv | grep -o '/mnt/c/Users/[a-zA-Z]*/')"


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/going-down-the-wsl-to-lxd-install-script-rabbit-hole/">Going Down the WSL to LXD Install Script Rabbit Hole</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/writing-automated-install-script-for-lxd-jupyter-on-wsl/">Writing Automated Install Script for LXD & Jupyter on WSL</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/trick/'>Tricks</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li></ul>