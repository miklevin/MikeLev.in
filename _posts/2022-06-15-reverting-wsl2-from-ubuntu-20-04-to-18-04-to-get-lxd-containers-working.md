---
date: 2022-06-15
title: Reverting WSL2 From Ubuntu 20.04 to 18.04 To Get LXD Containers Working
headline: "Learning New Technologies: Exploring WSL2, LXD, venv, virtualenv, tmux, screen, and Python"
description: I recently explored the process of downgrading Ubuntu 20.04 to 18.04 under WSL2, as well as concepts such as LXD, venv, virtualenv, tmux, screen, and Python. I discussed the importance of good fixed-file-location habits, and how LXD is similar to venv/virtualenv in terms of packaging dependencies. I also compared Docker and LXD.
keywords: WSL2, Ubuntu, 20.04, 18.04, LXD, Containers, venv, virtualenv, tmux, screen, Python, Good Habits, Packaging Dependencies, Docker, \*nix Commands, venv, virtualenv, Python, In-House SEO, Kubernetes, MySQL, PostgreSQL, Redis, MongoDB, Virtualenv, Python Standard Library
categories: 20.04, containers, lxd, python, virtualenv, wsl2, ubuntu, docker
permalink: /blog/reverting-wsl2-from-ubuntu-20-04-to-18-04-to-get-lxd-containers-working/
layout: post
---


- Removing: Ubuntu 20.04 LTS
- Installing: Ubuntu 18.04 LTS

In a previous video, I Charlie Brown kicked at the football... and missed. In
the voice of Lucy:

> Oh, Charlie Brown. When will you stop trying to win the prize?

NEVER! Just don't chase the rabbit forever.

# Improving Backoff & Retry Methodology

Figure out what backoff and retry in this case properly means. I'm not alone in
wanting this. Others have explored this particular Wonderland. Figure out how
to walk in their footsteps.

Make the above the beginning to a new video!

lxd-on-wsl-ubuntu-20.04-focal-fassa-to-18.04-bionic-beaver.JPG

(py310) ubuntu@LunderVand:/mnt/c/Users/mikle/github$ sudo lxd internal error,
please report: running "lxd" failed: timeout waiting for snap system profiles
to get updated

Ah, information! That helps. But get straight the documentation you're going to
be following. Make this primarily about:

- Downgrading Ubuntu 20.04 to Ubuntu 18.04 under WSL2
- Struggling with the "just throw out host machine" issue
  - I only have 13 GB free on my laptop
  - SSH keys are the biggest issue
  - OMG, this is huge / shouldn't have to do this

https://wsl.dev/wsl2-lxd-funtoo/
https://blog.simos.info/how-to-run-lxd-containers-in-wsl2/

After all this, it may still be a colossal fail! Let the world see you try to
kick that football Charlie Brown!

Don't be embarrassed!

# The Methodology of venv, VirtualEnv and LXC / LXD

- Keep all your eggs in one basket.
  - Get to know the Unix way.
  - You'll know you're home by ~/
  - Keep all your stuff close to ~/github
- Copy that basket all over the place.

LXD is like Docker, but part of Linux proper.

LXD is the Container system allowing virtual machine-like Linux instances but
better because they are faster and more efficient (sharing host machine's
kernel i.e. resoures). It comes from the Unix chroot command, but is much more
user friendly now.

Put your keys back in place so that git cloning works, and you get your stuff
back!

.vimrc
Key work repos (git repositories,
usually off of Github)

ZFS is better because the old Sun Microsystems is generally better at
everything than everyone.  Research OpenSolaris (or just Solaris) and ZFS in
particular. It was designed for nearly zero- compromise against data-loss.

The OS tied truly to the hardware is special.  The OSes tied to virtual machine
management layers are interchangable and more flakey.

Good fixed-file-location habits... you'll never
wonder where that that thing is again!

There's no place like ~/github

Docker won... in a lot of place. Better for resume.
However Docker is not an official part of Unix.
LXD is core Linux knowledge now... Docker isn't.

LXD is just like venv or virtualenv... it's just about packaging dependencies
and keeping play-work from polluting your important main OS.

Think about Python without venv or virtualenv... it's unthinkable.

WSL2 installs on Windows 11 easily... not so on Windows 10, so my Pied Piper
message of easy wsl --install ONLY WORKS if you're on Windows 11. Why?

Windows 10 makes you (too much for the average user):

- Activate WSL (complex command)
- Activate Hypervisor (complex command)
- Patch a Linux kernel (download & running .MSI Microsoft installer file)

On Windows 11, you just type:

    wsl --install

...and it does all the above steps.

tmux vs screen
screen is part of the official GNU command set (every Unix or Linux has it)

LXD (if not today then in the near future) is always there. It's generic tech.

Generic tech (as unsexy as it sounds) is ALWAYS better than fad du jour.

Python is better than JavaScript... huh?

Python has replaced PERL in Linux default distros... more important than
JavaScript in a browser because browsers are just one API (to humans). Linux is
the API to EVERYTHING. Python is the new Unix Bash Script.

Timeless
LXD... timeless.

3 Timeslots you might catch me:

~8:00 AM EST before work
~12:00 PM Noon EST (lunch)
~6:00 PM - \*wildcard (whenever I'm inspired)

I plan on getting new \*nix commands "into my fingers"... that means it's ready
to use any moment of your life from now forward... no question of whether it's
there. No questions of how it works or whether it might ever let you down. No,
it's now like it's part of your body.

- Starting to use venv or virtualenv in Python

As an in-house SEO very happy where I am, I don't have to pander to the resume
keywords... I can develop my skills how I like... Kubernetes

Heavyweight tech liability, both on the actual hardware (even if cloud) and in
your mind. MySQL, PostgreSQL, Redis, MongoDB... because mikey likey sqlite.

SQLite good

- virtualenv is not part of the Python standard library
  - all sample documentation uses it
- venv IS NOW part of the Python standard library
  - Python governance did not adopt virtualenv (from PyPI)

I'd be on venv full-time, except all sample code uses virtualenv


<div class="post-nav"><div class="post-nav-next"><a href="/blog/windows-updates-kb5014699-kb5013887-lxd-on-wsl2-under-ubuntu-20-04">Windows Updates KB5014699 & KB5013887 & LXD on WSL2 Under Ubuntu 20.04</a><span class="arrow">&nbsp;&rarr;</span></div> &nbsp; <div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/lxd-on-wsl2-is-a-few-months-ahead-of-its-time">LXD on WSL2 is a Few Months Ahead Of Its Time</a></div></div>
## Categories

<ul>
<li><h4><a href='/20-04/'>20.04</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/virtualenv/'>Virtualenv</a></h4></li>
<li><h4><a href='/wsl2/'>WSL2</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/docker/'>Docker</a></h4></li></ul>