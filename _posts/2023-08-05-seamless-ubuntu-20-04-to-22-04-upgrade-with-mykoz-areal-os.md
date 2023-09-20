---
date: 2023-08-05
title: Seamless Ubuntu 20.04 to 22.04 Upgrade with MyKoz AReal/OS
headline: Seamlessly Upgraded from Ubuntu 20.04 to 22.04 with MyKoz AReal/OS!
description: I successfully upgraded from Ubuntu 20.04 to 22.04 and my daily journaling script worked seamlessly! I'm now exploring how to make this same functionality available to everyone, while keeping it as close to the mainstream systems as possible. I'm also looking into how to best take advantage of Windows for durability of paths and file-locations between Linux-side upgrades.
keywords: Ubuntu, 20.04, 22.04, MyKoz, AReal/OS, Linux, JupyterLab, Vim, Journaling, Public, Private, Systems, Automation, nbdev, CSS, Sass, Fullstack, Webdev, Windows, Symbolic, Links, .ssh, Directory, Release, Blog Post
categories: jupyter, ubuntu, linux, journaling, python, microsoft, vim, nbdev
permalink: /blog/seamless-ubuntu-20-04-to-22-04-upgrade-with-mykoz-areal-os/
layout: post
group: blog
---


Wow, I have both Ubuntu 20.04 (my old day-to-day) and Ubuntu 22.04, the new one
that Microsoft sort of forced me onto by changing the default for WSL and me
fixing the MyKoz script (previously drinkme) to stay in sync with it. And the
amazing thing is the "all" script that I use to initiate my daily journaling
flowed seamlessly from one to the other. This is a first and shows the power of
the MyKoz AReal/OS approach. Friggin awesome!

Okay, so I'm going to have to think through how to allow everybody to have this
same functionality. I have it working for everyone as far as a Linux-backed
version of JupyterLab, and that's pretty well tested. But the vim journaling
part of it is a bit more off the beaten path. I'm going to have to think
through where, if any I have unique customizations. Naturally the particular
text files loaded into vim are unique to me, but I can just have a default.

I will set everyone up with one public blog and one private journal. I will
also load one file for pseudo-automation, so they can edit a file that's
invoked by a running systemd service. I ***may*** even make it nbdev-powered,
but that may be too much complexity for folks out of the starting gate. I want
to avoid non-standard systems built on non-standard systems. I want to stick as
close to the out-of-the-box defaults of the massively popular mainstream
systems I'm piggybacking off of and gluing together.

I will have to review the vim macro keyboard shortcuts. Make it as generic as
possible for daily blogging. @j to start a new journal entry. @p to publish the
public blog, etc. Wire it for Github and the Github Pages (github.io)
publishing system. Name the repos very clearly for what stays private and what
becomes public. Don't make the private one too easy to even get onto Github.
But make the public one (the blog) almost tripping over itself to get
published. I'll need a very stripped-down and simplified CSS. None of that sass
or fullstack webdev nonsense. As few moving parts as possible.

An important concept here is how Windows is really taken advantage of for
durability of paths and file-locations for repos, configurations and such
between Linux-side upgrades. I went from Ubuntu 20.04 to 22.04 and everything
just kept working. That's because of the install script making symbolic links
to the Windows-side. That's right down to the .ssh directory, so when it gets
time to release this blog post, it should just work. Let's try!




















<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/mykoz-areal-os-an-independent-nomatic-digital-home/">MyKoz: AReal/OS, An Independent, Nomatic Digital Home</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/simplifying-websites-and-life-with-single-long-text-files/">Simplifying Websites and Life with Single Long Text Files</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li></ul>