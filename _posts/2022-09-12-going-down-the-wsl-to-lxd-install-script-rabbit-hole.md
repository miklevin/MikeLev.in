---
date: 2022-09-12
title: Going Down the WSL to LXD Install Script Rabbit Hole
headline: Exploring the WSL and LXD Install Script to Create a Jupyter Server on Windows
description: I'm working on a project to create a bash install script that will set up a Jupyter server on a Windows machine. I'm writing the script, installing it from an Ubuntu 18.04 instance with LXD, creating a PowerShell script, and setting up a ~/repos folder and jupyme repo. Follow my journey as I build this project and learn along the way.
keywords: Windows, Bash, Script, Ubuntu, LXD, PowerShell, Jupyter, Server, Instance, Repos, Github, Jupyme
categories: python, container, ubuntu, git, linux, microsoft, jupyter, powershell
permalink: /blog/going-down-the-wsl-to-lxd-install-script-rabbit-hole/
layout: post
---


Okay, I set my journal startup to go right to my MikeLev.in blog because it
makes for better videos, and that rabbit! It's really good branding. It
differentiates me quite nicely. Nobody has that rabbit facing that direction
because I reversed the original artwork.

Hmmm, there's really so much potential of what to do. What NOT to do. Okay,
think it through clearly. One way to smash this thing is to movement-atize all
my latest work, and those few install scripts (I've already begun) can go a
long way.

Following onto an idea I haven't even published yet is the concept that the
combination of changing expectations brought about by Docker, WSL and
containers in general, no single Linux instance should be thought of as all
that important. You can get it back from either a backup of the image or from a
relatively simple server build script.

You don't want to start working on preserving any particular container image
until you have the server build scripts solid. That's where the specialness
really resides. The server-build scripts are the interesting the magic spells
for people like me who don't want deeper into the arcana or higher into the
dockersphere.

So currently there's really nothing special about my jupyter lxd instance.
Let's make a bash install script that will just create a new instance of a
Jupyter server fully running and working on localhost:8888 on the Windows
machine. Wow, nailed it! This gets installed from an Ubuntu 18.04 instance with
LXD running. I should make a PowerShell script to do that next.

```bash
#!/usr/bin/env bash

CONTAINERS="$(lxc ls -c "n" --format csv | grep jupyter)"

for container in $CONTAINERS; do
  echo "Stopping $container..."
  lxc stop $container
done

JUPYTER_EXISTS="$(lxc ls -c "n" --format csv | grep jupyter)"

if [ "$JUPYTER_EXISTS" == "jupyter" ]; then
  lxc delete jupyter --force
  echo "Old Jupyter container deleted."
else
  echo "jupyter container doesn't exist"
fi

lxc launch ubuntu:18.04 jupyter
lxc config device add jupyter jupyme proxy listen=tcp:0.0.0.0:8888 connect=tcp:127.0.0.1:8888

until [ ! -z "$(lxc ls jupyter -c '4' --format csv)" ]
do
  sleep 2
done

lxc exec jupyter -- apt update
lxc exec jupyter -- apt upgrade -y
lxc exec jupyter -- mkdir /home/ubuntu/repos
lxc exec jupyter -- add-apt-repository ppa:deadsnakes/ppa -y
lxc exec jupyter -- apt install python3.10 -y
lxc exec jupyter -- apt install python3.10-venv -y
lxc exec jupyter -- python3.10 -m venv /home/ubuntu/py310
lxc exec jupyter -- curl -L -o /home/ubuntu/.bash_profile "https://raw.githubusercontent.com/miklevin/dotconfigs/main/.bash_profile"
lxc exec jupyter -- curl -L -o /home/ubuntu/.bash_prompt "https://raw.githubusercontent.com/miklevin/dotconfigs/main/.bash_prompt"
lxc exec jupyter -- /home/ubuntu/py310/bin/python3.10 -m pip install jupyterlab
lxc exec jupyter -- chmod -R 777 /home/ubuntu/py310
lxc exec jupyter -- chmod -R 777 /home/ubuntu/repos
```

Simply logging into this machine with:

    lxc exec jupyter -- su --login ubuntu

...will cause the Jupyter server to be running. I don't think my .bash files
belong in that dotconfig repo anymore. I think I should round everything up
into a repo names, oh maybe jupyn! That's my first instinct.

Now is the time to change my big master ~/github folder to ~/repos. Just go for
it. 1, 2, 3... 1? Okay, I changed a whole bunch of references from github to
repos. Now go into repos and make a jupyme folder... or is that JupWyn? Wow, I
want to write jupyme. It flows better. Check the googles for which is less
taken. Yeah, change of decision. We're definitely going with jupyme. It just
rolls off the tongue better.

Okay, wow, I got my first version of the Jupyter install script on WSL pretty
well worked out. You need to already have LXD on WSL and maybe I'll do a script
for that next.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/developing-priceless-and-timeless-tech-habits/">Developing Priceless and Timeless Tech Habits</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/switching-from-wsl-to-lxd-containers-permanently/">Switching From WSL to LXD Containers Permanently</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/powershell/'>Powershell</a></h4></li></ul>