---
date: 2022-06-25
title: Figuring Out The LXD/LXC Command-line API
headline: Exploring the LXD/LXC Command-line API After My LXC Container Became Unsupported
description: "As a Linux user, I recently received a notice that my LXC container is unsupported. To learn the LXD/LXC command-line API, I discovered the command `lxc exec instance_name -- command` to execute commands in the LXD image, `lxc list` to view containers, `lxc start foo` to start one, and `lxc exec foo -- su --login ubuntu` to log."
keywords: LXD, LXC, Command-line, API, Linux, Unsupported, Container, Execute, List, Start, Log
categories: execute, lxc, container, linux, python
permalink: /blog/figuring-out-the-lxd-lxc-command-line-api/
layout: post
---


For my next trick, I have to get really comfortable with the lxc commands under
lxd. Even that I know that's my next trick has been quite a trick. The term
"lxc" has two very different meanings, especially as older lxc technology is
actively becoming deprecated and unsupported. I got a notice form my QEMU NAS
hosting a sort of baby-Kubernetes that my lxc container is now unsupported and
I need to upgrade it. However, the ***"lxc command"*** on the command-line
under lxd is alive and well. And the one I now need to learn more urgently than
any other is:

    lxc exec <instance_name> -- <command>

This explains why there is a space ***BEFORE AND AFTER*** a double-minus. This
is very rare in a Unix/Linux API. Double-minus signs are usually reserved for
the long-version of a command-line argument, such as --help being the verbose
alternative to -h and --editable being the verbose alternative to -e. It's such
a standard nix convention that seeing this really threw me off. Come on,
Ubuntu! Find a better way. Oh, the damage is done. Okay, learn the API...

Okay, so I have an lxd image (no longer an lxc?) named "foo". To execute
commands (in general) inside the foo container, I do this:

    lxc exec foo -- [command]

It is important beyond important to understand that the first double-minus is a
delimiter to a command. Unix/Linux commands will very frequently carry an
***additional double-minus argument*** and so in order to read a login
instruction correctly, we must read:

    lxc exec foo -- su --login ubuntu

...as "With the lxc command that still controls things under the lxd ***Linux
system daemon*** and is not really the old lxc deprecated tech even though it
is named that way, execute against the image named "foo" the commands that
follow this double-minus that must have a space between it and the command. In
this case the command is "switch user" to the ubuntu user. I believe this means
that the command is normally executing as "root". I believe this is confirmed
because if we didn't want to switch users right away and actually wanted to
***be root***, we would use this command:

    lxc exec foo -- /bin/bash

That is the equivalent of saying all the above, but instead of immediately
trying to switch user, we effectively just launch a bash shell with no command,
which terminates at simply sitting in a bash shell as root.

So:

  --login

...is a command-line parameter to ***switch user (su)*** and "ubuntu" is the
value being fed in for that parameter. It can be thought of as a key/value pair
with login as the key and ubuntu as the value. The parameter is --login and the
argument is ubuntu. The language surrounding APIs is absolutely terrible.

But I think I got this.

9 times out of 10, I'm going to want to:

    lxc list
    lxc start foo
    lxc exec foo -- su --login ubuntu

That will show me what containers I have and start one if it's not started and
log into it to do stuff there.

And now one of the profoundly important tests I need to do is whether the Linux
container instances running under LXD under Windows subsystem for Linux (WSL2)
do themselves run systemd, which is required for the sort of Linux system
daemon experimental automation work I'm about to embark on:

![Lxd Lxc Instances Under Wsl Wsl2 Running Systemd](/assets/images/lxd-lxc-instances-under-wsl-wsl2-running-systemd.jpg)

...and they do! Woot! Success assured.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/vim-tricks-why-the-walrus-fears-the-carpenter/">vim tricks: Why The Walrus Fears The Carpenter</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-key-lxc-api-detail-i-must-master/">The Key LXC API Detail I Must Master</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/execute/'>Execute</a></h4></li>
<li><h4><a href='/lxc/'>LXC</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>