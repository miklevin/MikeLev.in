---
date: 2022-09-09
title: Writing First Version of Install Scripts for Jupyter on LXD on WSL
headline: "Becoming More Independent: Setting Up a New Environment on LXD on WSL"
description: I'm helping people become more independent of desktop software and be able to use Linux terminal for their day-to-day tasks. To do this, I set up a new environment on LXD on WSL, trimmed my public Github repos, and created a new repo with an install script. I'm also crafting a message for my public website that will appeal to people in general and capture their attention. Come and learn how to become more independent and use Linux terminal for your daily tasks.
keywords: Writing, Install Scripts, Jupyter, LXD, WSL, Linux Terminal, Public Github Repos, Configuration Files, Free Software, GI, Website, Message, Attention, Plowing, Competition
categories: wsl, jupyter, container, message, linux terminal
permalink: /blog/writing-first-version-of-install-scripts-for-jupyter-on-lxd-on-wsl/
layout: post
group: blog
---


Pshwew! That was one for the history book. I have so much I want/need to do.
All this retooling goes directly to how effective I am at my day-job. This
moving to containers is a big one. If all goes well, this is the last journal
entry that I'm writing directly on a WSL-instance of Linux. After that, it will
all be on an LXD container instance. To that end, I have a few small touches to
do. I really like how distrod works with curl to drop the install.sh file into
location.

Okay, so clean up my public github repos. Turn everything to private that you
can, and even start thinking about deleting the private ones that are just
clutter and distraction. Do a quick pass. Definitely 80/20-rule here. Think
about the experience people will have when they come in checking me out.

Okay, I trimmed back everything public on my Github.com repos that shouldn't be
there. But now I actually want to PUT a new repo there that has all my good
configuration stuff. I should really only have to have a few curl statements to
pull down:

- .vimrc
- .screenrc
- .bash_profile (for WSL)
- .bash_profile (for LXD)
- .bash_prompt

It looks like I should give it some directory structure so file renaming is not
necessary.

Ooh, I also want to change all my github folders into repo folders. Sheesh!
Maybe that's a violation of the 80/20-rule for now.

dotconfigs

Okay, I put the repo in location.

    https://github.com/miklevin/dotconfigs

And here's the way I've been getting the install file from distrod:

    curl -L -O "https://raw.githubusercontent.com/nullpo-head/wsl-distrod/main/install.sh"

And so it stands to reason, I should have the URLs:

    curl -L -O "https://raw.githubusercontent.com/miklevin/dotconfigs/main/.bash_profile"
    curl -L -O "https://raw.githubusercontent.com/miklevin/dotconfigs/main/.bash_prompt"
    curl -L -O "https://raw.githubusercontent.com/miklevin/dotconfigs/main/.screenrc"
    curl -L -O "https://raw.githubusercontent.com/miklevin/dotconfigs/main/.vimrc"

And I made an install script that can be pulled down with:

From WSL:

    curl -L -O "https://raw.githubusercontent.com/miklevin/dotconfigs/main/install.sh"

From LXD:

    curl -L -O "https://raw.githubusercontent.com/miklevin/dotconfigs/main/lxd/install.sh"

Interesting! How far do I go with the install script? If I go too far, it might
as well be a Docker image and that's stupid. So much of the point here is to
help people walk this path and have increased capabilities at the end; not to
do just another apps store, snap, consumer-oriented thing. I'm giving people
their forward-slashes so they can use them.

Okay, think! 1, 2, 3... 1?

Oh, of course!

So you're on Windows on you main, daily working machine. Sure you can install
Linux on some other machine or do some multi-boot thing on your main machine
for a little Linux experience, but the point is to integrate Linux Terminal
(the important part) into your daily life enough to start affecting your
habits, achieving new normals, and ultimately making Windows or any other
particular desktop environment interchangeable and optional. Once your main
home is the Unix-like Linux command-line, you are impervious to disruption in
the tech industry.

Yes that's a bit claim, and you will still need to know a few other things that
will be hosted through the Linux terminal, such as Python, vim and git, but
these things too will be with you for your entire life free of the feature and
user-interface churn that so plagues desktop software in desktop environments.
You can still use desktop software, but try focusing on stuff that's free
across any desktop, such as the Photoshop replacement Gimp, the Illustrator
replacement InkScape, he Maya replacement Blender, and the Microsoft Office 365
replacement LibreOffice. The main products are burdened with feature-creep to
justify keeping you spending.

I started out on Adobe Photoshop 3, the first version to introduce layers.
Today, the Adobe Creative Cloud is over $50/mo for the privilege of what
amounts to being in the graphics arts guild. If you don't pay the Adobe tax,
you're out, and if you're just a casual graphics software user like me, it's
not worth it. It feels like Adobe drove me away with a stick. And that's just
the graphics software. Similar techniques are used by the vendors all the way
down to the OS to keep you spending and part of their quarterly projections.
That's the main thing for them. It's the wrong spirit to have infused into your
tools.

The Free and Open Source Software movement possesses the right spirit. Learn
once, run anywhere, never pay. The main argument to keep you on the proprietary
stuff in my estimation comes down to convincing you of the next must-have
proprietary feature, like automatic background removal in Photoshop. However
the truth is these features will eventually come to FOSS software too if they
really are must-haves, but most aren't. They're fringe-features that are fun
for a time but whose main purpose is to instill in you the fear of missing out
as your competitors and peers enjoy these features. It's lack of confidence in
one's own ability they prey on, and it's group-think they rely upon.

Ugh, that's all too deep of background.

I need to appeal to people in general and they lack the attention span to go
deep early. Jump right into it. Don't let anything sound boring ever.

I've got a new machine set up.

Okay, let's see how this should go.

The main thing is to massage your public website into the correct message.
Plow everything into MikeLev.in and then let it trickle out to other sites like
LPvg.org. Basically become your own competition, but don't get hung up.

Cut this journal entry here. :w


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/run-jupyter-from-lxd-linux-container-on-windows/">Run Jupyter from LXD Linux Container on Windows</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-coddling-of-the-american-mind-yup-someone-s-a-big-fragile/">The Coddling Of The American Mind. Yup. Someone's a Big Fragile.</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/message/'>Message</a></h4></li>
<li><h4><a href='/linux-terminal/'>Linux Terminal</a></h4></li></ul>