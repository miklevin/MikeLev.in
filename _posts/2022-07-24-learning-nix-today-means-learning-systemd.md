---
date: 2022-07-24
title: Learning *nix Today Means Learning systemd!
headline: Take Control of Your Life with Linux and Systemd!
description: As I introduce you to the world of *nix, you'll learn how Linux has pulled ahead of the FreeBSD Unix community, allowing us to take control of our own lives. Discover how Lennart Poettering's controversial systemd for Linux, based on Apple's launchd and launch, has made system automation possible, replacing SysV. Get all the details on this exciting new development in my blog post.
keywords: Linux, Unix, FreeBSD, Systemd, Lennart Poettering, Launchd, Launch, Hypervisor, System Automation, SysV, Operating System
categories: unix, systemd, linux
permalink: /blog/learning-nix-today-means-learning-systemd/
layout: post
---


I am going to initiate you to the world of nix. Everyone's got to go through
some course in life. From some point, we choose and decide. We break down
walls. The world I'm proposing is pretty well called \*nix for Unix-like
operating systems. But given the profoundly strong initiative of adding
kernel-level hypervisor capabilities, soon thereafter by the unification of how
system services are handled with systemd, Linux has pulled a wee-bit ahead of
the FreeBSD Unix community, and it is them being forced into the somewhat
embarrassing position of having to change to stay Linux-compatible. So perhaps
it should be \*nux that I advocate. Or just plain nux.

There is a blurred line between when we are following a compelled course set in
motion for us by virtue of being born, and later when we take control of our
own lives. We eventually see things in a new light, shifting from the
perspective of a dependent child to one who must make it out there in life.
Whether it's on your own or not is one of those many decisions you'll need to
make.

Linux has pulled that far ahead that for general system-automation work, Linux
is the new standard, replacing SysV. There wasn't much wrong with SysV except
for a needless lack of convention across versions of Linux, plus the
requirements for an unreasonable amount of Unix/Bash-script skills. This was
not what Apple wanted for the Unix soon to be at the heart of Macintosh, so
they developed lauchd which came with the control program launchctl. Starting
to sound familiar? Well it should! It's what the controversial FOSS Linux
developer Lennart Poettering copied when writing the now-popular systemd for
Linux.

And do uh yeah, Unix was there first with replacement to a bash-file oriented
init system.

<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/lxd-container-on-windows-wsl2-using-nas-smb-cifs-share">LXD Container on Windows WSL2 Using NAS SMB/CIFS Share</a></div><div class="post-nav-next"><a href="/blog/from-average-windows-user-to-linux-terminal-user">From Average Windows User to Linux Terminal User</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/unix/'>Unix</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>