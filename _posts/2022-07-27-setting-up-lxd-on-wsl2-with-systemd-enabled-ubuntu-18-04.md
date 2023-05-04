---
date: 2022-07-27
title: Setting Up LXD on WSL2 with systemd enabled Ubuntu 18.04
permalink: /blog/setting-up-lxd-on-wsl2-with-systemd-enabled-ubuntu-18-04/
headline: Exploring LXD on WSL2 with Ubuntu 18.04 - My Journey to Set Up My First Container
description: I'm setting up my first LXD container on WSL2, using Ubuntu 18.04. I've used lxd init and lxc launch to get the container running, and added two locations from the WSL2 Linux host to the container. I'm now preparing to start experimenting and need to make sure I have the right tools installed. I'm also learning how to check if systemd is running, and getting everything ready for my first container.
keywords: LXD, WSL2, Ubuntu, 18.04, lxd init, lxc launch, Linux host, container, /etc/fstab, python3.10, python3.10-venv, vim repo, .vimrc, .gitconfig, .bash_prompt, ps, process, ID 1
categories: ubuntu, lxd, container, wsl2, .vimrc
layout: post
---

What a wonderful starting point. Make sure I document for myself how to
instantiate a new container and make it feel like home:

This is working off of LXD installed with apt (not snap) on a WSL2 Ubuntu 18.04
instance. WSL installs 20.04 by default so to make this environment you have to
install Ubuntu 18.04 from the Microsoft Store. Unfortunately, systemd must be
running in order for lxd to install, but systemd is not running on WSL2 Linux.
You can't even just turn it on. There's an external dependency here. I'm
confident it will go away in time as Microsoft recently hired Lennart
Poettering who created systemd. But until then you have to use
(distrod)[https://github.com/nullpo-head/wsl-distrod]. On an already
existing siting Linux host under WSL2, this turns on systemd:

```bash
curl -L -O "https://raw.githubusercontent.com/nullpo-head/wsl-distrod/main/install.sh"
chmod +x install.sh
sudo ./install.sh install
```

Okay, once this is done, LXD should install cleanly:

```bash
sudo apt install lxd
sudo lxd init
```

That init command is the way to set up LXD for the first time. It steps you
through a wizard with recommended defaults. The reason to use Ubuntu 18.04
installed from apt (instead of installed from snap under Ubuntu 20.04) is so
that you can just hit [Enter] through the entire wizard. Once that's done you
can use the "lxc" commands. Almost all further use of "lxd" as a command is
over. All the creation and manipulation of instances of containers is
accomplished through the lxc command.

    lxc ls

You can also use "lxc list". Either way, this is the beginning of your new
container habits. If there's stuff there then the general pattern is:

    lxc stop ContainerName
    lxc start ContainerName

If there's no container there and you want to create a new one, the concept is
"launch". Ugh, can you believe it? Yet more mental gymnastics of word/meaning
remapping for the container world.

    lxc launch images:ubuntu/18.04 GlookingLass

This is the creation of a container instance of an image. The image itself is
never saved locally as any sort of master image. It just becomes an immediately
runnable instance by using it in an lxc start statement. But there's a few
things that ought to be done.

    lxc config device add GlookingLass github disk source=/mnt/c/Users/mikle/github path=/home/ubuntu/github
    lxc config device add GlookingLass dotssh disk source=/mnt/c/Users/mikle/.ssh/ path=/home/ubuntu/.ssh/
    lxc config device add GlookingLass data disk source=/mnt/data path=/home/ubuntu/data

Those are the two locations from the WSL2 Linux "host" that get added through
the lxc command. It's also worth noting that on the host, this was done to make
the data location available:

    mkdir /mnt/data
    sudo mount -t drvfs '\\EchidNAS\data' /home/ubuntu/data

NOTE: I learned on a following day that this line had to be added to my
/etc/fstab to make it persistent.

    sudo vim /etc/fstab

Added this line:

    \\EchidNAS\data /mnt/data drvfs defaults 0 0

And so if this container is moved around, how these locations get established
may vary. But so long as the containers are on my Windows laptop, these
commands work. As an added bonus, I have this on the .bash_profile of the WSL2
Linux host so that containers can always have access to the WSL2 host's
nameserver in case I want Linux containers to use graphical apps through
X-Server.

    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    echo "export DISPLAY=${DISPLAY}" > ~/data/displa.sh

And in the .bash_profile of the container:

    source ~/py310/bin/activate
    source ~/data/display.sh
    . ~/.bash_prompt
    cd ~/github

Oh, that reminds me. To get Python 10 installed and a virtualenv created:

    sudo apt update
    sudo apt install git
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install python3.10
    sudo apt install python3.10-venv
    python3.10 -m venv py310

This is close to the general container-building pattern I'll be using maybe
forever forward now. With this information in-hand I should go ahead and do
experiments knowing I can just do it all again. Make the new patterns in my
head. And then make a video where my actions are more practiced for the world.
1, 2, 3... 1?

At this time I will git clone my vim repo and from there, copy these files to
home ~/

- .vimrc
- .gitconfig

Oh! One more thing. Let's get my current favorite gratuitous Linux prompt
highlighting working. That's what that .bash_prompt file is that's being
referred to in the .bash_profile file. Basically just grab it from here
(https://github.com/bpeebles/bash_prompt.sh)[https://github.com/bpeebles/bash_prompt.sh]
and save it as ~/.bash_prompt. Refer to it in .bash_profile as instructed and
you'll have a nifty prompt that shows your:

- Light blue active Python venv
- Green username@host
- Yellow for the path
- Purple for git branch

It's a good time to remind myself how to see if systemd is running. This is
useful on both the WSL2 Linux host machine to see whether you need to install
distrod, or on the containers to assure yourself systemd is running for the
next step. That's the "ps" command.

Okay, so if you want to know if systemd is running, what you're looking for is
the name of the **comm**and running on **pid 1**. That's "process ID 1". In
both Unix and Linux, everything running on your system is given an ID in the
order it runs. By definition, the "init" task is the very first thing to run.
The old name of the init task was init. So this is how we look at it:

    ps 1

The "ps" command that stands for "process status" in Unix/Linux lists all hte
running processes. The number 1 tells it to only list the data for the process
with the ID 1. This is your init process. You'll see in the COMMAND column
there's a lot of gobbledygook for the path and stuff. We can customize the
output to just the command column, which gives its appreciation.

    ps -o comm 1

This is good but it still shows the column header which is confusing and would
mess up automations if you're writing something that's just supposed to pull
back the name. And so we can suppress the headers:

    ps --no-headers -o comm 1

And there we have it. That's what's necessary to see if we're running systemd
or not. I've got to get that into my head so I don't struggle every time. The
concept is that it's just looking at ID 1 with the ps command. The rest is
formatting.

Now I feel comfortable experimenting with my first container. Initially, it
feels precious. But because you're in script-land, everything is easily
automateable so long as you keep good notes. And I am.

Everything I've done so far has really been for this next step.

Just do it without getting hung up on a video. Do it with a video after you've
done it to a container or two. Hmmm. Snapshot a container before you do the
work. What are these moves?

Get a service running:

{% include youtubePlayer.html id="DswpaXLkddk" %}

## Categories

<ul>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/wsl2/'>WSL2</a></h4></li>
<li><h4><a href='/vimrc/'>.vimrc</a></h4></li></ul>