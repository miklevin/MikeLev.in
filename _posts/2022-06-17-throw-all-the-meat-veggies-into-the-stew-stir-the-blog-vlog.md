---
date: 2022-06-17
title: Throw All The Meat & Veggies Into The Stew & Stir The Blog / Vlog
headline: "Unlocking Efficiency: How Downgrading Ubuntu & Adding Sites Streamlined My Workflow"
description: I recently wrote a blog post about my experience with downgrading Ubuntu 20.04 to 18.04 so I could use LXD Linux containers on WSL Windows Subsystem for Linux. To make my workflow more efficient, I created a vim keyboard macro that generates the site I'm editing and added sites to sites.csv in the skite repo. Read my blog post to find out how this game-changing experience helped me streamline my workflow.
keywords: Downgrading, Ubuntu, 20.04, 18.04, LXD, Linux, Containers, WSL, Windows, Subsystem, Vim, Keyboard, Macro, Generates, Site, Editing, Sites.csv, Skite, Repo, Technical, Content, MikeLevinSEO.com, Personal, Blog, Streamline, Workflow, Game-Changing, Experience
categories: linux, vim, container, wsl, microsoft, ubuntu
permalink: /blog/throw-all-the-meat-veggies-into-the-stew-stir-the-blog-vlog/
layout: post
---


Wow, that was one of the most epic blog posts I've ever written. The genesis on
that was that with the innocent seeming downgrading of my Ubuntu 20.04 to 18.04
to have a better chance of getting LXD Linux containers working on WSL Windows
Subsystem for Linux, I broke my fragile chewing-gum and paper-clips blogging
release system. And it was for the best. It was in desperate need of an
overhaul and it took precedent over my streak of YouTube livecasting.

I originally documented that whole Unix Script-based version over on
MikeLevinSEO.com, figuring I'd separate technical content (there) versus more
personal content here. But after all my talk about one big integrated life, I
see how futile that was. I need everything dropped in one big vat, initially.
We throw all the meat and veggies into the stew pot and stir it up.

Every time we revisit something we want to rewrite it. Things should be short
and easily rewritable. They should also remain "living" code in Jupyter
Notebooks. These things should remain fluid and flexible so that when
inspiration hits you can mold it to taste. I'm in that stirring and molding
phase. I'm going to go for an 80/20-rule win: a vim keyboard macro to generate
just the site I'm editing. That should be possible by just feeding the script
the name of the path of the file being edited.

vim will let you show the full path up to the "head":

    :echo expand('%:p:h')

We could put that value into a vim macro with this:

    :let @l = expand('%:p:h')

Okay, wow I got it working:

    let @l = ":execute '!python ~/github/skite/skite/core.py -f ~/github/skite/sites.csv -x ' . expand('%:p:h') . '; read -p \"Press Enter to Continue...\"'^M"

Amazing! Pshwew, a real game-changer. Only generate out the sites I'm working
on. Simply add sites that I may generate out to sites.csv in the skite repo. I
need some figlet output! I started out thinking I would need a bash script
wrapper. I don't! Oh boy, okay.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/the-epic-nbdev-static-site-generator-post/">The Epic nbdev Static Site Generator Post</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/education-of-the-woogle-bug/">Education Of The Woogle Bug</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li></ul>