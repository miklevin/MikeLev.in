---
date: 2022-11-27
title: Microsoft Added Linux Graphics and Systemd to WSL for Windows 10
headline: Exploring the Aftermath of Installing Linux Graphics and Systemd on Windows 10
description: I recently installed Linux graphics and Systemd on Windows 10, and now I'm exploring the aftermath. I'm researching how to make the vGPU accessible and usable, mapping locations and environment variables, and setting up the WAYLAND_DISPLAY and XDG_RUNTIME_DIR. I'm looking into lxdwin script, Levinux/Getonux projects, and lxc config set to configure the jupyter environment. Join me as I explore the aftermath of this installation!
keywords: Microsoft, Linux, Graphics, Systemd, WSL, Windows 10, vGPU, Environment Variables, WAYLAND_DISPLAY, XDG_RUNTIME_DIR, lxdwin script, Levinux, Getonux, lxc config set, GitHub, Container, Map, Jupyter Environment, PULSE_SERVER
categories: systemd, microsoft, graphic, levinux, container, git, linux, wsl
permalink: /blog/microsoft-added-linux-graphics-and-systemd-to-wsl-for-windows-10/
layout: post
---


Okay... Microsoft pulled a fast one... but in a good way and I now have to
figure out the aftermath. Fix lxdwin script. I need a better name for the
project than that to ride the wave of inevitable attention this is going to
receive. But first, solve the riddle. What riddle? Getting Linux graphics
working in containerized mode now that WSLg (essentially) is on Windows 10.
Meaning, Linux graphics now works under Windows 10 which I confirmed.

This is also related to sharing the vGPU to a container / making the vGPU
accessible and usable as if native by the container. I'll cross that bridge
next, but for this one I need to read this page carefully:

https://github.com/microsoft/wslg/blob/main/samples/container/Containers.md

Okay, for a container to have access to graphics, these locations must be
accessible from within the container:

    /tmp/.X11-unix
    /mnt/wslg

Okay definitely no biggie. That's at worst 2 mount commands, or maybe lxc
config commands. What else? Environment variables! Ugh, those are hard to pass.
They're showing the docker way of doing it. First understand what they are,
then look for elegant ways to pass them down in LXD.

    DISPLAY
    WAYLAND_DISPLAY
    XDG_RUNTIME_DIR
    PULSE_SERVER

Interesting! They're not saying what those values are, just that they need to
be handed down.

Okay! First clue is that this line:

    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

...now should simply be:

    export DISPLAY=:0

But that isn't enough. When attempting to run xeyes in the container, it
reports:

    Error: Can't open display: :0

Okay, so onto the mapped locations! Think it through.

Hmm. Levinux to kick the tires. Getonux to make the transition. That may be a
very good Linux version name, or at least project name for lxdwin. It has a lot
of what I'm looking for. Get On UX. But UX will imply *nix.Hmm. Levinux to kick
the tires. Getonux to make the transition. That may be a very good Linux
version name, or at least project name for lxdwin. It has a lot of what I'm
looking for. Get On UX. But UX will imply *nix.Hmm. Levinux to kick the tires.
Getonux to make the transition. That may be a very good Linux version name, or
at least project name for lxdwin. It has a lot of what I'm looking for. Get On
UX. But UX will imply \*nix.

That's not thinking it through! Look at your 2 install files: .bat and .sh.
The answer is in install.sh in commands like this:

    lxc config device add jupyter repos disk source=${WIN_HOME}repos/ path=/home/ubuntu/repos/

So the 2 lines should be:

    lxc config device add jupyter wslg disk source=/mnt/wslg/ path=/mnt/wslg/

Alert! Having had checked, the x11 location doesn't need to be mapped. Okay,
modified the lxdwin script. Manually did the config command. xeyes still not
showing. So the final environment variables are probably necessary.

    WAYLAND_DISPLAY
    XDG_RUNTIME_DIR
    PULSE_SERVER

Let's take a look at the contents of those environment variables under just
WSL:

    wayland_display=wayland-0
    xdg_runtime_dir=/mnt/wslg/runtime-dir
    pulse_server=/mnt/wslg/pulseserver

Okay, I don't want to hardwire these things but rather I should pass them down
similar to how I USED TO pass the display env down, or even in a better way. I
also notice this environment variable which may be important:

    WSL2_GUI_APPS_ENABLED=1

Hmm. If I use static values (likely okay) I can make entries inside a config
file with entries like

    lxc.environment = ABC=DEF

This page documents it: https://linuxcontainers.org/lxc/manpages/man5/lxc.container.conf.5.html

Even better are the instructions on this page: https://linuxcontainers.org/lxd/docs/master/instance-exec/

    lxc config set <instance_name> environment.ENVVAR=VALUE

If that's the case, if I use static values I can just throw a few easy lines
into install.sh.

    lxc config set jupyter environment.WAYLAND_DISPLAY wayland-0
    lxc config set jupyter environment.XDG_RUNTIME_dir /mnt/wslg/runtime-dir
    lxc config set jupyter environment.PULSE_SERVER /mnt/wslg/pulseserver


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/planning-a-spell/">Planning a Spell</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/wsl-linux-graphics-and-systemd-support-takes-priority-over-lxd/">WSL Linux Graphics and Systemd Support Takes Priority Over LXD</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/graphic/'>Graphics</a></h4></li>
<li><h4><a href='/levinux/'>Levinux</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li></ul>