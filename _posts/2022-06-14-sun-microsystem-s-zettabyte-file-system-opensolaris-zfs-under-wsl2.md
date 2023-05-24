---
date: 2022-06-14
title: Sun Microsystem's Zettabyte File System (OpenSolaris ZFS) Under WSL2
headline: Successfully Installed Sun Microsystems' Zettabyte File System (OpenSolaris ZFS) on WSL2 to Access Best Developer Tools.
description: I'm installing OpenSolaris ZFS as part of a larger effort to have access to all the best developer stuff on my Linux WSL2 system. I ran into some errors while trying to get LXC and LXD running, but I was able to get everything working with the help of the 'wsl --help' command. I'm excited to have LXD running under WSL and am looking forward to the next livestream which will be about developing Linux system services with LXD.
keywords: Sun Microsystems, Zettabyte File System, OpenSolaris, ZFS, WSL2, Linux, LXC, LXD, 'wsl --help', Windows Subsystem, Oracle, Solaris, ICs, SNAP store, Docker, systemd, 'lxd init', livestream, blog
categories: systemd, linux, container, wsl, lxc
permalink: /blog/sun-microsystem-s-zettabyte-file-system-opensolaris-zfs-under-wsl2/
layout: post
---


# Sun Microsystems... Son, Mike Knows Systems

**WHAT:** Linux under Windows under WSL gets you a Linux terminal, but you don't
want to FUBAR it.

**WHY:** Commitment & Consistency... tell the nice people you're doing it and you
will force yourself to do it. (life-hack)

# Thank You Robert Cialdini For Your Work (Influence, Science & Practice)

There's no surer way to push yourself forward than commitment & consistency.
Remind the folks about Robert B. Cialdini and correct the pronunciation.

# The Best Laid Plans of Charlie Brown (Kicking The Football)

Don't make a big long rambling video like before. Just get set up the steps
necessary. Get the preview going now! Okay, done by 6:45. Not bad. Some folks
will get notified in time. I'm getting more and more of a feel for this. Like
anything else, it comes with practice. But being on the bleeding edge as I am,
expect your muscle memory to have to be retrained and retrained. This is NOT
like driving a car. It's like flying a jerry-rigged Wright brothers bicycle
airplane. So be it. To get the benefit today, it's worth it.

> **AFTER THE FACT NOTE:** This video started out being just a quick lesson on
> installing the ZFS filesystem (from Sun Microsystems) as a prerequisite to
> having Linux containers (LXD) under the Windows Subsystem for Linux (WSL) but
> due to changes in how the Linux service manager (systemd) works under Ubuntu
> 20.04 (under WSL?) and difficulty installing the SNAP store, things became
> much more complicated. But I overcame! I prevailed. And on the next video,
> we'll actually activate LXD containers under WSL... a vital and life-changing
> Linux trick.

{% include youtubePlayer.html id="4LzGU231els" %}

# Come See How The Sausages Is Made (Not For The Feint Of Heart)

Document process and jump right into it with the folks this morning...

I've been putting this off. Find the YouTube link to the guy. KeepItTechie. Go
subscribe to KeepItTechie. He's awesome.

{% include youtubePlayer.html id="TM64WElAwGg" %}

# When is a good time? Now is a good time!

zfsutils

You have access to all the best developer stuff now that you have a Linux
terminal under Windows.

Windows 10 is Wonderland (no friends, everything is harder)
Windows 11 is OZ (you have friends, everything gets easier with friends)

Installing the Zettabyte File System (ZFS)... talk history (quickly)

Sun Microsystems... Commodore of Workstations

- Designed their own hardware system
- Designed their own ICs (CPUs, GPUs and other co-processors)
- Designed their own software (OS... Solaris)

Like Commodore, Sun did everything better than the industry at large (at
first). It must not have been that great, because they're both gone.

Sun bought by Oracle... Berkeley DB (NoSQL before SQL) and MySQL (of the LAMP
stack before that died). Redis MongoDB CouchDB... PostgreSQL

Before Oracle bought Sun, Sun free and open sourced a whole bunch of stuff...
so before the kibosh was put on Sun's awesomeness, Sun let much of their tech
free...

OpenSolaris, a version of Unix you can think of like a branch different from
FreeBSD.

- Berkeley branch (leaked by Ken Thompson)
- Sun Branch Solaris, derived from something (from scratch?)
  - OpenSolaris
  - Improve everything
  - Filesystem

Yay! I have ZFS on my system... next step is getting LXD active.

Everything I've shown you so far in this video is to be able to answer zfs on
the question:

> Name of the storage backend to use?

Docker is nice... but docker is for dev's... not everyday Linux users unless
you're just running stuff distributed on docker (SNAP store).

But when you want a persistent but throw-away local Linux playground, Docker is
way confusing and overkill. Linux governance thinks so too and didn't adopt it
(or its methodologies) for standard Linux. They used generic Linux containers
under a generic Linux daemon (system service), which have come to be known as
LXC and LXD, respectively. You run LXC's on an LXD.

Like this...

systemd is the daemon manager for Linux akin to Windows Service Manager.

Linux version was lifted... from Apple's system management work on their Darwin
branch of Unix (BSD-lineage).

Okay, so now jump to it:

    sudo lxd init

Wait, what? It's not on my system? Okay so then:

    sudo apt install lxd

No luck. Here's the output. That doesn't look good.

    (py310) ubuntu@LunderVand:/mnt/c/Users/mikle/github$ sudo apt install lxd
    [sudo] password for ubuntu:
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    The following NEW packages will be installed:
      lxd
    0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
    Need to get 5532 B of archives.
    After this operation, 79.9 kB of additional disk space will be used.
    Get:1 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 lxd all 1:0.10 [5532 B]
    Fetched 5532 B in 1s (9364 B/s)
    Preconfiguring packages ...
    Selecting previously unselected package lxd.
    (Reading database ... 58500 files and directories currently installed.)
    Preparing to unpack .../archives/lxd_1%3a0.10_all.deb ...
    => Installing the LXD snap
    ==> Checking connectivity with the snap store
    ===> System doesn't have a working snapd and LXD was never used, skipping
    ==> Cleaning up leftovers
    System has not been booted with systemd as init system (PID 1). Can't operate.
    Failed to connect to bus: Host is down
    Failed to disable unit, unit lxd.socket does not exist.
    Failed to disable unit, unit lxd.service does not exist.
    Failed to disable unit, unit lxd-containers.service does not exist.
    umount: /var/lib/lxd/shmounts: no mount point specified.
    umount: /var/lib/lxd/devlxd: no mount point specified.
    Unpacking lxd (1:0.10) ...
    Setting up lxd (1:0.10) ...
    (py310) ubuntu@LunderVand:/mnt/c/Users/mikle/github$

# HAVING DIFFICULTIES

WTF? FUBAR? Get up, Charlie Brown! Okay, so you kicked at the football and
missed. Lucy pulled it away. This is not your fault. This is not the way it's
supposed to work. Don't get down Charlie Brown. Backoff. Retry. But corner
Lucy. Make her acknowledge what's happening. Control conditions. Restart your
Linux WSL2 system. This is low-level stuff going on because of systemd and snap
store messages. Reboot. What was that command again?

    PS C:\Users\mikle> wsl --help
    Copyright (c) Microsoft Corporation. All rights reserved.

    Usage: wsl.exe [Argument] [Options...] [CommandLine]

    Arguments for running Linux binaries:

        If no command line is provided, wsl.exe launches the default shell.

        --exec, -e <CommandLine>
            Execute the specified command without using the default Linux shell.

        --
            Pass the remaining command line as is.

    Options:
        --cd <Directory>
            Sets the specified directory as the current working directory.
            If ~ is used the Linux user's home path will be used. If the path begins
            with a / character, it will be interpreted as an absolute Linux path.
            Otherwise, the value must be an absolute Windows path.

        --distribution, -d <Distro>
            Run the specified distribution.

        --user, -u <UserName>
            Run as the specified user.

    Arguments for managing Windows Subsystem for Linux:

        --help
            Display usage information.

        --install [Options]
            Install additional Windows Subsystem for Linux distributions.
            For a list of valid distributions, use 'wsl --list --online'.

            Options:
                --distribution, -d [Argument]
                    Downloads and installs a distribution by name.

                    Arguments:
                        A valid distribution name (not case sensitive).

                    Examples:
                        wsl --install -d Ubuntu
                        wsl --install --distribution Debian

        --set-default-version <Version>
            Changes the default install version for new distributions.

        --shutdown
            Immediately terminates all running distributions and the WSL 2
            lightweight utility virtual machine.

        --status
            Show the status of Windows Subsystem for Linux.

        --update [Options]
            If no options are specified, the WSL 2 kernel will be updated
            to the latest version.

            Options:
                --rollback
                    Revert to the previous version of the WSL 2 kernel.

    Arguments for managing distributions in Windows Subsystem for Linux:

        --export <Distro> <FileName>
            Exports the distribution to a tar file.
            The filename can be - for standard output.

        --import <Distro> <InstallLocation> <FileName> [Options]
            Imports the specified tar file as a new distribution.
            The filename can be - for standard input.

            Options:
                --version <Version>
                    Specifies the version to use for the new distribution.

        --list, -l [Options]
            Lists distributions.

            Options:
                --all
                    List all distributions, including distributions that are
                    currently being installed or uninstalled.

                --running
                    List only distributions that are currently running.

                --quiet, -q
                    Only show distribution names.

                --verbose, -v
                    Show detailed information about all distributions.

                --online, -o
                    Displays a list of available distributions for install with 'wsl --install'.

        --set-default, -s <Distro>
            Sets the distribution as the default.

        --set-version <Distro> <Version>
            Changes the version of the specified distribution.

        --terminate, -t <Distro>
            Terminates the specified distribution.

        --unregister <Distro>
            Unregisters the distribution and deletes the root filesystem.
    PS C:\Users\mikle>

# Questions From The Chat... Yay! Keep Those Questions Coming In!

## What's Better, Docker or LXD?

Docker is better for distributing packaged software in the SNAP store due to
how it contains dependencies and composites software like patches...
transparent overlaid layers. Cool, but difficult.

LXD is better for tire-kicking Linux seekers who need a playground where they
can:

    rm -rf /

Everyone should have this experience. It is asserting control over Linux. But
you don't want to do it on your main Linux system. That is why I created the
[great and tiny resetable Levinux distro of Linux](https://levinux.com)... more
technically a "respin" than a distro, but still.

LXD is official from the Linux governance organization... who? Research this
for a future video.

systemd is the issue... must be enabled.

Whoah! Here is the answer:

{% include youtubePlayer.html id="SLDrvGUksv0" %}

This apparently worked under Ubuntu 18.04 but then stopped working under 20.04
due to a change in systemd and the snap store.

I'm frankly surprised that the snap store is required, but whatever. And I
don't even see how it gets installed from his instructions, but let me document
here what I typed to get ***sudo lxd init*** to work...

    sudo apt install -yqq daemonize dbus-user-session fontconfig

    sudo daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target

    exec sudo nsenter -t $(pidof systemd) -a su - $LOGNAME

And to test it:

    (py310) ubuntu@LunderVand:/mnt/c/Users/mikle/github$ snap version
    snap    2.54.3+20.04.1ubuntu0.3
    snapd   2.54.3+20.04.1ubuntu0.3
    series  16
    ubuntu  20.04
    kernel  5.10.102.1-microsoft-standard-WSL2
    (py310) ubuntu@LunderVand:/mnt/c/Users/mikle/github$ sudo lxc list
    [sudo] password for ubuntu:
    If this is your first time running LXD on this machine, you should also run: lxd init
    To start your first instance, try: lxc launch ubuntu:18.04

    +------+-------+------+------+------+-----------+
    | NAME | STATE | IPV4 | IPV6 | TYPE | SNAPSHOTS |
    +------+-------+------+------+------+-----------+

OMG, everything is matching the video. Remarkable. It's time to test:

    (py310) ubuntu@LunderVand:/mnt/c/Users/mikle/github$ sudo lxd init
    [sudo] password for ubuntu:
    Would you like to use LXD clustering? (yes/no) [default=no]:

OMG, the setup wizard for LXD started. Wow, wow, wow!

Okay, this livestream has gone on for long enough (>1 hour).

Cut it here. Bank your win. Document it for the blog.

Done, done and done!

See you folks soon for the ***really exciting*** part: LXD under WSL, a.k.a.
local Linux playgrounds for Linux system service (daemon) development.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/my-formative-years-at-all-boys-science-summer-camp-integrated-life/">My Formative Years at All-Boys Science Summer Camp / Integrated Life</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/trying-again-to-get-lxd-working-under-microsoft-subsystem-for-linux/">Trying Again To Get LXD Working Under Microsoft Subsystem For Linux</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/lxc/'>LXC</a></h4></li></ul>