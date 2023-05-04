---
date: 2022-09-20
title: Created Windows Shortcut To Start Linux Jupyter on LXD
headline: Create a Windows Shortcut to Easily Access Linux Jupyter on LXD
description: "This blog post explains how I created a Windows Shortcut (LXD.lnk) to start a Jupyter server on WSL, getting around API limitations and ensuring the command-line parameters of WSL and LXD work properly. With this shortcut, I can easily visit http://localhost:8888 and start the Jupyter server. Learn how I did it in this post!"
keywords: Windows Shortcut, Linux Jupyter, LXD, WSL, API Limitations, Command-line Parameters, Exec Command, Localhost, 8888
categories: wsl, lxd
permalink: /blog/created-windows-shortcut-to-start-linux-jupyter-on-lxd/
layout: post
---


Okay, I added LXD.lnk to the WSL2LXD repo. It's very simple:

    wt PowerShell -c "wsl -d Ubuntu-18.04"

This works because when the Ubuntu 18.04 .bash_login script is:

    jupyterlogin

And this is a program in /usr/local/sbin on WSL:

    until
            lxc jupyterstart 2>/dev/null
    do
            sleep 1
    done
    lxc exec jupyter -- su --login ubuntu

And now this is actually using the alias feature of lxc which you can see when
logged into just WSL with lxc alias list. Anyway, jupyerstart is an alias for:

    exec jupyter -- su --login ubuntu -c /usr/local/sbin/jupyterstart

And now there's one more /usr/local/sbin file in the picture, but this one is
under LXD and just starts the Jupyter server:

    cd ~/repos
    screen -wipe >/dev/null 2>&1
    if ! screen -list | grep -q "jupyter"; then
        screen -dmS jupyter /home/ubuntu/py310/bin/jupyter lab --ip 0.0.0.0 --port 8888 --no-browser --ServerApp.password='[long hash deleted]'
    fi
    echo "Visit http://localhost:8888"

Pshwew! There's a lot of getting around API limitations going on here by use of
sbin commands. There's a temptation to make bash script one-liners and feed
them on the command-line parameters of wsl and lxd, but that generally doesn't
work. If it's not permission problems then it's semicolon parsing. It turns out
that dropping magic little sbin commands into place and calling ***them*** on
the command-line seems to always work.



## Categories

<ul>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li></ul>