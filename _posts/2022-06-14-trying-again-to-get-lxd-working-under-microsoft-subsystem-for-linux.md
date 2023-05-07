---
date: 2022-06-14
title: Trying Again To Get LXD Working Under Microsoft Subsystem For Linux
headline: Determined To Get LXD Working Under Microsoft Subsystem For Linux - Join My Journey!
description: I'm determined to get LXD running under Microsoft Subsystem for Linux, and I'm not giving up! I've followed the official instructions and attempted to create a new storage pool, but I keep running into errors. To document my journey, I'm creating a new video - join me as I work to make this work!
keywords: LXD, Microsoft Subsystem for Linux, Storage Pool, Errors, Video, Command, Documentation, Journey, Determined, Attempting
categories: container
permalink: /blog/trying-again-to-get-lxd-working-under-microsoft-subsystem-for-linux/
layout: post
---


Wow, get right to the wizard:

    sudo lxd init

This one is unusual because it is the workday, but it is a major dependency I
have to satisfy before I proceed even with my day-job, so get 'er done. Turn
off monetization on the livestream on this one to avoid any issues. This is
under the category of "the best way to learn is to teach" and if livestreaming
this step is the best way to do it to get over this hump, so be it.

What comes after sudo lxd init?

Load the official LCD instructions:
https://linuxcontainers.org/lxd/getting-started-cli/

Be on the lookout for:

- image server
- image name
- instance name

They get used in an instantiation command:

    lxc launch <image_server>:<image_name> <instance_name>

For example:

    lxc launch images:ubuntu/20.04 ubuntu-container

If you get this far in this video, you're golden.

STOP!

    Name of the new storage pool [default=default]:
    Name of the storage backend to use (btrfs, dir, lvm, ceph) [default=btrfs]: zfs
    Invalid input, try again.

    Name of the storage backend to use (btrfs, dir, lvm, ceph) [default=btrfs]:
    Create a new BTRFS pool? (yes/no) [default=yes]:
    Would you like to use an existing empty disk or partition? (yes/no) [default=no]:
    Size in GB of the new loop device (1GB minimum) [default=30GB]: 5
    Would you like to connect to a MAAS server? (yes/no) [default=no]:
    Would you like to create a new local network bridge? (yes/no) [default=yes]:
    What should the new bridge be called? [default=lxdbr0]:
    What IPv4 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]:
    What IPv6 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]:
    Would you like LXD to be available over the network? (yes/no) [default=no]:
    Would you like stale cached images to be updated automatically? (yes/no) [default=yes]
    Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]:
    Error: Failed to create network 'lxdbr0': Failed adding outbound NAT rules for network "lxdbr0" (ip): Failed apply nftables config: Failed to run: nft
    table ip lxd {
    chain pstrt.lxdbr0 {
            type nat hook postrouting priority 100; policy accept;
            ip saddr 10.49.21.0/24 ip daddr != 10.49.21.0/24 masquerade
    }
    }
    : Error: Could not process rule: No such file or directory

          ^^^^^^^^^^^^
    Error: No such file or directory; did you mean chain ‘out.lxdbr0' in table ip ‘lxd'?

          ^^^^^^^^^^^^
    ubuntu@LunderVand:/mnt/c/Users/mikle/github$

Kicked at the football... and missed. Oh, Charlie Brown. When will you stop
trying to win the prize?

NEVER! Just don't chase the rabbit forever. Figure out what backoff and retry
in this case properly means. I'm not alone in wanting this. Others have
explored this particular Wonderland. Figure out how to walk in their footsteps.

Make the above the beginning to a new video!


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/sun-microsystem-s-zettabyte-file-system-opensolaris-zfs-under-wsl2/">Sun Microsystem's Zettabyte File System (OpenSolaris ZFS) Under WSL2</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/failed-getting-lxd-working-under-wsl2-under-ubuntu-20-04-systemd-snap/">Failed Getting LXD Working Under WSL2 Under Ubuntu 20.04 systemd & snap</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/container/'>Container</a></h4></li></ul>