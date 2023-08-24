---
date: 2022-07-29
title: Using GNU Screen to Monitor Linux System Daemon Service
headline: Mastering Linux Technology with GNU Screen and LXD Containers
description: Learn how to install Linux on Windows machines and get Linux services running under GNU Screen under an LXD Container. Discover the advantages of mastering generic Linux tech over web development and how to get started. I provide an example of a Python script to monitor a Linux system daemon service, and I walk you through the steps for installing Ubuntu 18.04, updating the file /etc/systemd/system/pulse.service, installing the program screen.
keywords: Linux, Ubuntu, Windows, WSL, LXD, Container, GNU Screen, System Daemon, Service, Monitor, Install, Update, File, Program, Command, Python, Script, Web Development, Advantages, Master
categories: web development, wsl, container, ubuntu, python, microsoft, linux
permalink: /blog/using-gnu-screen-to-monitor-linux-system-daemon-service/
layout: post
group: blog
---


This is a pretty epic blog entry and video in which I get Linux services
running under GNU Screen under an LXD Container under Ubuntu 18.04 Linux under
the Windows Subsystem for Linux.

{% include youtubePlayer.html id="IAzfFPe11SQ" %}

What should my pitch be to the world? The iron is hot! Moving now puts you
about 5 years ahead of the coming WebDev implosion. NodeJS, ReactJS and the
like will only get you so far in tech. Being a Web Developer is a lot more
pigeon holed than people think. It's just that the Web is still the big, sexy
thing right now, and it's quite suitable for human interface design. But not
everything's a Website or an App. Not everything requires that deep dive into
UI-stuff. That's the silent majority of tech. That's the world of
everything-but Web Tech. And that's the world I'm inviting you into here.

How do we begin?

Well, as so many things do, it starts with Windows. You probably own a Windows
laptop of some sort. If it's fairly modern, it's running Windows 10 or 11. And
if so, you're one step from Linux if on Windows 11, and 4 steps if on 10.

This seems like a super-nerdy thing, but generic Linux tech is a door opener to
so many things in life.

Generic Linux tech means getting most Microsoft and other profit-driven
proprietary vendor tech out of the picture.

Stay on Windows for a few years, but condition yourself to get off of it by
mastering the text-based Linux terminal.

Even if everything gets taken away from you, what remains in your head will be
enough to just sit down and reboot your life.

The particular power you'll acquire is the ability to generically automate
things in the world of information tech. That's valuable.

You'll be able to keep doing stuff while you walk away from your computer,
multiplying your power in this world.

What precisely did we do in the last few videos? We made Linux services on
Linux containers residing on standard Windows 10 (or Windows 11) systems using
little more than what Microsoft provided by default.

This makes available to you thr bizarro alternative world of tech that has come
to dominate severs and all consumer electronics under the covers. Even
Microsoft itself is coming around, which makes this timing so important.

You're about 5 years ahead of thr world at large recognizing this and
recalibrating around the new reality. Tech trends will change. What skills are
valuable in the workplace will change. The very concept of modern literacy will
change.

Following this path now gives you access to the “generic tech” of Linux,
Python, vim & git. You can start working on projects that make use of them
right now today. You don't have to buy anything. You don't have to make
yourself dependent on any one company.

You just start at the beginning with some simple magic incantations, and have
many new life path-choices open up to you. This is not hype. Just follow me.

I present to you a more practical daily approach to mastering generic tech than
the currently popular WebDev path provides.

- More fundamental / thus longer living
- More broadly applicable / thus useful
- More accessible / thus easier to get started

So the trick now is to turn your practice into your day to day work. We break
the sort of work you need to tackle into 2 phases of startup steps to get you
to the exploratory phase I'm at now.

Where I'm at now are just generic tech skills everyone should have, way more
basic than all that fad-driven Web Development stuff that dominates the media.
This is simply what happens when you turn on a piece of hardware.

Let's get the necessary pieces down and make a video.

This is what goes in ~/github/pulse/pulse.py

```python
from time import sleep
from datetime import datetime

print("Hello World")

while True:
    anow = f"{datetime.now()}"
    print(anow)
    with open("/tmp/pulse.txt", 'a') as fh:
        fh.write(anow + '\n')
    sleep(5)
```

This is what currently is in /etc/systemd/system/pulse.service

```shell
[Unit]
Description=Run Python script to handle scheduling

[Service]
Type=simple
Restart=always
RestartSec=5
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu/github/pulse/
ExecStart=/home/ubuntu/py310/bin/python3.10 /home/ubuntu/github/pulse/pulse.py
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=multi-user.target
```

This is what we need to put into /etc/systemd/system/pulse.service to make it
run under gnu screen:

```shell
[Unit]
Description=Run Python script to handle scheduling

[Service]
Type=forking
Restart=always
RestartSec=5
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu/github/pulse/
ExecStart=/usr/bin/screen -dmS pulse /home/ubuntu/py310/bin/python3.10 /home/ubuntu/github/pulse/pulse.py
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=multi-user.target
```

This is how we install the screen program:

    sudo apt install screen

And after we make the changes to the file we have to actually reload the daemon
(not simply stop and start the service).

    sudo systemctl daemon-reload

Wow, it's weird that I'm not the only one talking about this stuff:

{% include youtubePlayer.html id="clZCrVZH4Gg" %}

I learned that to install Linux on your Windows machine for the first time, you
can see what Linux's are available with:

    wsl --list --online

Ha ha ha, yeah so it's all knowing the magical incantations. This is an
important one. I will have to update the magic-spell-for-Linux. Instead of what
I recommend so much which (today) winds you up with Ubuntu 20.04, I want you to
end up with 18.04 to make the lxd init wizard go smooth. Oh, showing all this
should be one of the videos I take the time to edit. The iron is hot! But
nonsense. Just do it in your style and keep focusing on your day-job and your
kid. Don't take excessively deep rabbit-hole plunges. Okay, so when I run that
command from a PowerShell, I get this:

```bash
PS C:\WINDOWS\system32> wsl --list --online
The following is a list of valid distributions that can be installed.
Install using 'wsl --install -d <Distro>'.

NAME            FRIENDLY NAME
Ubuntu          Ubuntu
Debian          Debian GNU/Linux
kali-linux      Kali Linux Rolling
openSUSE-42     openSUSE Leap 42
SLES-12         SUSE Linux Enterprise Server v12
Ubuntu-16.04    Ubuntu 16.04 LTS
Ubuntu-18.04    Ubuntu 18.04 LTS
Ubuntu-20.04    Ubuntu 20.04 LTS
PS C:\WINDOWS\system32>
```

Okay, so the command to get 18.04 installed must be:

    wsl --install -d "Ubuntu-18.04"

Wow, this streamlines my instructions to people. It will need this context:

There are various rough edges today that will be smoothed out. We're walking
through a portal to another world, the world of Linux.

But we do not want to cross over into just one particular instance of Linux
installed side-by-side with your Windows. No, we want to cross over into the
world of "owning" generic Linux instances that you can treat like folders in a
directory.

Now this might sound like virtual machines to those of you who have been around
the block a few times. Rather, it's more like using all the stuff that's been
done to support virtual machines, but to use it for something else so efficient
that it just feels like switching directories when you're using them, and not
virtual machines.

Oh, installing nettools gets you ifconfig if you don't have it. That explains
why it's not always there. I like this YouTuber guy Dave's Garage.

    sudo apt install net-tools

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/setting-up-lxd-on-wsl2-with-systemd-enabled-ubuntu-18-04/">Setting Up LXD on WSL2 with systemd enabled Ubuntu 18.04</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/sending-emails-with-python-through-smtp/">Sending Emails With Python Through SMTP</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/web-development/'>Web Development</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/container/'>Containers</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>