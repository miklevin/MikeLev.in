---
date: 2022-09-08
title: Run Jupyter from LXD Linux Container on Windows
headline: Learn to Run Jupyter from an LXD Linux Container on Windows!
description: Learn how to run Jupyter from an LXD Linux Container on Windows with me! I walk you through setting up an LXD container, adding a proxy device, logging into the container, adding a Python 3.10 virtual environment, creating a .bash_profile to activate the venv, installing Jupyter Lab, creating a script to run Jupyter in a way that the proxy can reach, and finally setting up a browser window to access Jupyter.
keywords: LXD, Linux, Container, Windows, Python, 3.10, Virtual, Environment, .bash_profile, Activate, Venv, Jupyter, Lab, Script, Proxy, Browser, Access
categories: python, container, jupyter, access, microsoft, linux
permalink: /blog/run-jupyter-from-lxd-linux-container-on-windows/
layout: post
---


{% include youtubePlayer.html id="vAOx5QMbRG4" %}

This is not for the feint of heart, but I've made it easy as possible and it will change your life.

We're going to start this video from the point of having LXD working under WSL2.

LXD is the Linux container system that's better than Docker for this sort of thing.

WSL is the Windows subsystem for Linux, to which all roads lead these days—even Docker.

We go this route to make Windows fully compatible with the modern developer world.

We don't simply use Docker because we need a full Linux system, exactly what LXD is for.

The abilities you learn in this process are timeless and will future-proof your career.

First we create an LXD container. These get automatically started. Make sure
any other containers you may have running are stopped.

    lxc launch ubuntu:20.04 kingcoyote

If you're not at LXD working under WSL, refer to my videos to get here.

Add a proxy device to container that forwards localhost:8888 requests on WSL to
container.

    lxc config device add kingcoyote jupyme proxy listen=tcp:0.0.0.0:8888 connect=tcp:127.0.0.1:8888

Log into container and sudo apt update and sudo apt upgrade.

    lxc exec kingcoyote -- su --login ubuntu
    sudo apt update
    sudo apt upgrade -y

Add the deadsnakes personal package archive (PPA) to your Ubuntu repo system.

apt install Python 3.10 and it's virtual environment manager, venv.

Use venv to create a virtual environment in your home folder.

    sudo add-apt-repository ppa:deadsnakes/ppa

    sudo apt install python3.10 -y
    sudo apt install python3.10-venv -y
    python3.10 -m venv ~/py310

Create and edit your .bash_profile to activate the venv every time you log in.

    vim ~/.bash_profile
    i
    source ~/py310/bin/activate
    [Esc]:qw[Enter]

Log out and into the container to ensure your profile-edit and venv are working
properly.

    exit
    [Up-arrow+Enter]

Your prompt should look like:

    (py310) ubuntu@kingcoyote:~$

Install Jupyter Lab with pip, generate config file and set a password and make
a repo directory.

    pip install jupyterlab
    jupyter server --generate-config
    jupyter server password
    mkdir ~/repos

Change directory to /usr/local/sbin and sudo vim jn and put this script inside
to run jupyter in a way that the proxy can reach. In other words the command
forces Jupyter Server to run using [IP]:8888 instead of localhost:8888. It also
kills dead screen sessions and prevents double-running.

    cd /usr/local/sbin
    sudo vim jn

Copy/paste this script into jn:

    # Put the following lines in /usr/local/sbin/jn
    cd ~/repos
    screen -wipe >/dev/null 2>&1
    if ! screen -list | grep -q "jupyter"; then
        screen -dmS jupyter /home/ubuntu/py310/bin/jupyter lab --ip 0.0.0.0 --port 8888 --no-browser
    fi

Add this code to jn, save and exit. You must now make this script executable.

    sudo chmod +x jn

Edit this line into your .bash_profile

    jn

Log out of container and back in to test your edits and ensure jupyter's
running in a screen. Try the following command:

    exit
    [Up-arrow+Enter]

    screen -ls

If it shows as a screen then you can log into it with the following command:

    screen -r jupyter

Ctrl + A (and while still pressing Ctrl), tap D to detach from gnu screen
session.

All good? Okay, go to a Edge in Windows and visit http://localhost:8888

Enter password. Allow browser to remember password.

Switch theme to dark mode.

Go to Edge menu and turn page into app. Allow it to add to Start Menu.

Quit browser and run from Start Menu. No password!

Switch app to full screen mode.

Check Terminal for forward-slashes.

You can try making a notebook and:

    import sys

    sys.version

    sys.executable

    import os

    os.name

    os.getcwd()


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/thinking-through-jupyter-video/">Thinking Through Jupyter Video</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/writing-first-version-of-install-scripts-for-jupyter-on-lxd-on-wsl/">Writing First Version of Install Scripts for Jupyter on LXD on WSL</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/access/'>Access</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>