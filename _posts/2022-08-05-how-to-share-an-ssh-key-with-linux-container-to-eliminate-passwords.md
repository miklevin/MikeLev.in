---
date: 2022-08-05
title: How to Share an SSH Key with Linux Container to Eliminate Passwords
headline: I Figured Out How to Eliminate Passwords from Linux Containers with SSH Keys
description: I recently faced a challenge when trying to get code up to Github from a newly created Linux container. To solve this, I figured out a way to share my SSH keys from my host system to the container, eliminating the need for passwords. To help others, I created a video and shared the code on Github. Learn how to share SSH keys from a host system to a Linux container with my easy-to-follow guide.
keywords: Linux, Container, SSH Key, Host System, Github, Password, Video, Code, Guide, Challenge, Developing
categories: linux, container, git
permalink: /blog/how-to-share-an-ssh-key-with-linux-container-to-eliminate-passwords/
layout: post
group: blog
---


Nut asks: exist this code on github?

Well, no. But that's a good idea. In fact, it's good inspiration for a video
because nothing is straight forward. In this case developing on a freshly
created Linux container that's not been fully set up as one of my development
systems, trying to get the code up to Github, the challenge is password
challenges... Github won't know who I am connecting in from the container, as I
would be. Normally I'm not challenged for Github passwords because I'm sitting
on my keys found in my .ssh directory.

Oh, I have the keys still. It's just that they're on the "host" system and not
the container off of which I'm working. But how to put the keys where I need to
override... oh, should I just copy/paste code off container to where keys are
set up already? That would be so easy, just to copy the text over. Even without
shared drives, you could copy/paste the text of the key-files over using the
Operating System's buffer, copying form Notepad and pasting to vim. But no!
Show the people proper 3haring of keys through folder mapping and re-use.
People have to know how to share their keys from Windows or Linux host systems
to their Linux Containers.

Get your thoughts and notes together. Make a nice video. Okay, here it is:

{% include youtubePlayer.html id="H9CiMIiUheA" %}

Currently, you're running on a server called Huey. Huey has your pip install
huey work. The question was asked from the video about sending emails from a
Linux services, so that's the code running on the Munchkin container. Having
the host machines .ssh location shared to the container is the desirable
solution here because you don't want to copy your keys all over the place.
Endeavor to keep your keys in one place with a good secure backup somewhere and
other. But then just map that .ssh location into wherever else needs it. Avoid
key duplication.

Okay, so how do we see how lxd containers are configured?

    lxc config device add Munchkin dotssh disk source=/mnt/c/Users/mikle/.ssh/ path=/home/ubuntu/.ssh/

Okay, so I can create the repo right on the container where the deployed code
exists. That's a great way to get the latest authoritative known-working code,
but what about the Jupyter Notebook from the Windows-side? Well, once I clone
the thing back down from Github Windows-side, I can certainly add it. I can
maybe even use nbdev_clean_nbs to strip metadata out of the Notebook if nbdev
lets me do that on non nbdev-init'ed locations. Try and find out. Video-time?
For sure.

Yes, Nut. The code [is on github](https://github.com/miklevin/scheduler).

This was an extremely important exercise for me to go through, because I'm
advocating moving to Linux Containers, and when you do important work on that
container, you need a way for it to migrate onto other containers, your host,
etc.

I have a github directory that starts out very Windows-centric, because it's
"native" location is:

    C:\Users\[username]\github

But which from Linux systems running under Windows Subsystem for Linux (WSL) is
located:

    /mnt/c/Users/mikle/github

Not all one-off containers need my entire github folder accessible, so that's
one mapping I don't enforce (the way I do ~/data). I need to move my data
around by reference more than I need to move my github repos around by
reference. It's okay to copy (especially via Github.com itself) git repos
around.

So let me pull the scheduler repo I just made on Github back down on my Linux
host machine.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/lightweight-python-data-pipelining-with-huey-to-replace-scheduler/">Lightweight Python Data Pipelining With Huey (to Replace Scheduler)</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/turning-python-huey-data-pipeline-into-schedule-repo-alternative/">Turning Python Huey Data Pipeline into Schedule Repo Alternative</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li></ul>