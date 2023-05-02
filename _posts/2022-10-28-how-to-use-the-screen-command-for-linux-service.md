---
date: 2022-10-28
title: How to Use the Screen Command for Linux Service
permalink: /blog/how-to-use-the-screen-command-for-linux-service/
headline: Exploring Linux Service with the Screen Command - Join Me on My Journey!
description: As I learn how to use the Screen Command for Linux Service, I'm documenting my journey with a blog post. I've written a file to be placed in /etc/systemd/system/ and have watched a video to help me better understand the process. Come join me as I explore this new technology!
keywords: Linux, Screen, Command, Service, Systemd, System, File, Video, Explore, Technology, Learning, Journey, Documentation
categories: learning, linux, journey, service, systemd, documentation
layout: post
---

It's time to make the service. I've learned a few things.

https://www.gnu.org/software/screen/manual/html_node/Socket-Directory.html

Here's the file that goes into /etc/systemd/system/

    [Unit]
    Description=Scheduling

    [Service]
    Type=forking
    Restart=always
    RestartSec=5
    User=ubuntu
    Group=ubuntu
    Environment="SCREENDIR=/home/ubuntu/.screen"
    WorkingDirectory=/home/ubuntu/repos/pulse/
    ExecStart=/usr/bin/screen -dmS pulse /home/ubuntu/py310/bin/python3.10 /home/ubuntu/repos/pulse/pulse.py

    [Install]
    WantedBy=multi-user.target

And here's the video:

{% include youtubePlayer.html id="9ySgYAb27FA" %}


## Categories

<ul>
<li><h4><a href='/learning/'>Learning</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/journey/'>Journey</a></h4></li>
<li><h4><a href='/service/'>Service</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/documentation/'>Documentation</a></h4></li></ul>