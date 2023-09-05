---
date: 2022-07-18
title: Refresh Your Mind With The LXD API
headline: "Refreshing My Mind with LXD API: My Journey Back to NYC"
description: Recently, I moved back to New York City and have been struggling both emotionally and financially. To thrive in tomorrow's world, I'm learning the LXD API to create containers and refresh my mind. With the lxc command, I can easily create a new container, even adding a user and password if I want. I'm amazed at how quickly I can create a container, and can't wait to see what the future holds.
keywords: LXD API, Container, lxc command, New York City, Emotional, Financial, Thrive, Tomorrow's World, User, Password, Create, Easily, Future
categories: future, container, new york city
permalink: /blog/refresh-your-mind-with-the-lxd-api/
layout: post
group: blog
---


Wow has it been difficult to get my head in the game again, lately. I just
moved from the Poconos back to New York City. It has not been easy physically,
financially or emotionally. One has to catch one's self in spiraling. One must
exert extreme cognitive and bodily control to undergo such transitions with
grace and continuing positivity. This is a large part of what it takes to be
human. We are strong.

It's easy to do "good enough" when you're following on yesterday's habits. But
when the deck gets reshuffled a bit you can measure yourself and try to do
better according to today's and perchance tomorrow's standard. The point is not
to thrive standing still, but to thrive just as well and better than most in
tomorrow's world.

I'm on a good path with using Linux, Python, vim & git for grounding and nearly
all things. But I'm spiraling again. Catch yourself! That disembodied feeling
of switching homes, laptops or now as it turns out, containers. I need to
settle into a container as a new home and make that LXD container feel like
home... every time I open the Terminal.

I want a "new" home that comes from lxd. 1, 2, 3... 1?

Give myself a refresher course. Grounding... grounding? Grounding! It's what
happens when you open a terminal. See if you can change the Linux system you're
running on. Once again, the thing that is important here is learning the lxc
command for everyday easy casual use. Or more likely, for a one-time
"startup-cost" round of activity, followed by getting back to day-to-day
business. We're in the startup cost phase of new-API-embracing.

Take a look at what containers are available.

    lxc ls

Log into it. Check if putting this in .bash_profile works (it does).

    lxc exec foo -- su --login ubuntu

Delete the current container:

    lxc stop foo
    lxc delete foo

Create a new container:

    lxc launch images:ubuntu/18.04 GlookingLass

I can log in as root:

    lxc exec GlookingLass /bin/bash

I can add a user (with a home directory) and a password:

    useradd -m healus
    passwd healus

But I don't think I want to create a new username and password. I can just use
the lxc default, ubuntu/ubuntu.

Okay, so it's really just that easy to create new home directories. This is
chroot evolved, for sure. A cookie-cutter template system for slamming out new
vanilla Linux systems.

Wow, that's eerie cool how easy it is to slam out a new container.

They don't even have a default python!


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/fairly-certain-i-had-a-brush-with-catknappers/">Fairly Certain I Had a Brush With Catknappers</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/moving-into-lxd-wsl2-home-once-you-ve-moved-into-containers/">Moving Into LXD WSL2 ~/ "Home" Once You've Moved Into Containers</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/future/'>Future</a></h4></li>
<li><h4><a href='/container/'>Containers</a></h4></li>
<li><h4><a href='/new-york-city/'>New York City</a></h4></li></ul>