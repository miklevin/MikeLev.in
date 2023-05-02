---
date: 2022-07-31
title: Share Folder Between Windows, WSL Linux, Container and Home Cloud
permalink: /blog/share-folder-between-windows-wsl-linux-container-and-home-cloud/
headline: Setting up a Complex Shared Folder Across Windows, WSL2, LXD Containers, and a Home Cloud
description: "As an IT professional, I'm setting up a shared ~/data folder across four different locations: my laptop's main Windows system, a Linux system running under WSL2, an LXD Linux Container hosted under WSL2, and an LXD Container hosted on a separate machine. I'm mapping a network drive from my laptop's Windows system, mounting a drive from the Linux system, and adding a device to the LXD Linux Container. Follow my journey as I set up this complex shared folder"
keywords: Windows, WSL2, Linux, Container, Home Cloud, Network Drive, LXD, Mapping, Mounting, Device, QNAP NAS
categories: container, device, lxd, wsl2, linux
layout: post
---

![Share Folder Windows Linux Wsl Container Cloud](/assets/images/share-folder-windows-linux-wsl-container-cloud.JPG)

For my next trick, I really have to nail down and document how I get that
~/data directory to be in common across:

- The "Main" Windows system pre-installe on laptop
- The Linux running directly under WSL2 (on laptop)
- The LXD Linux Container hosted under WSL2 (on laptop)
- An LXD Container hosted on physically separate machine (qnap nas)

In situations like this when you want to share files freely between systems
there are lots of choices. Increasingly copying stuff up to and down from
Github is becoming the easiest choice, but that's stupid because of all the
extra delay and overhead. We have the perfect interface for moving files
around, and that's just copying files between drives. We should continue to
enjoy that simple interface even with all these hosts, containers, cloud
servers and whatnot.

In other words, all 4 of these locations that I currently have in play will
have a ~/data location (except for Windows that uses letter-drives).

There's a broader issue to address here. To make a ~/data folder accessible
"everywhere", it's primary location shouldn't really be on your laptop because
when your laptop goes offline, anything else using it loses contact. So it's
time to talk about the QNAP NAS a bit more. It's a good setup for letting the
nice people know they need a 24x7 place to run code that isn't their laptop and
isn't the cloud. That's such a huge right of passage with tech capability. Some
would call it a home server. Whatever. It's just a place to run your containers
that isn't your laptop and isn't the cloud. Call it a home server if you will.

Show the diagram from yesterday.

Let's to through them one at a time.

# Add shared folder on the main windows system (on laptop)

- Use Windows Explorer (Winkey+E)
- Paste \\EchidNAS into address bar (or drill-down or whatever)
- Right-click, Map network drive and give it a "Letter" (silly Windows)

# Add shared folder on a WSL2 instance of Linux (on laptop)

- FYI, this is NOT dependent on mapping the Windows letter-drive.
- Launch Windows Terminal and go into Linux
- mkdir /mnt/data
- sudo mount -t drvfs '\\EchidNAS\data' /mnt/data
    PS C:\Users\mikle\pyw3105\Scripts> .\Activate.ps1
    (pyw3105) PS C:\Users\mikle\pyw3105\Scripts> cd ..\..\github\mlseo\
    pip install -e .
- Edit /etc/fstab to make it persistent.
  - sudo vim /etc/fstab
  - \\EchidNAS\data /mnt/data drvfs defaults 0 0
- It lives under ~/data
    ln -s /mnt/data /home/ubuntu/data

# Add shared folder on LXD Linux Container hosted under WSL2 (on laptop)

    lxc config device add Munchkin data disk source=/mnt/data path=/home/ubuntu/data

And after that command is done from the Linux host, the following command has
to be done from inside a container Terminal session.

    ln -s /mnt/data /home/ubuntu/data

# Add shared folder LXD Container hosted on physically separate machine (qnap nas)


## Categories

<ul>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/device/'>Device</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li>
<li><h4><a href='/wsl2/'>WSL2</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>