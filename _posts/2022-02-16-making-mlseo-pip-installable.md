---
date: 2022-02-16
title: Making mlseo pip installable
headline: "Creating mlseo: My Journey to Setting Up a Pip Installable Module"
description: I'm using mlseo as a pip installable module to get the process of making packages into my fingers. I'm creating a package called mlseo which will include my latest techniques for pulling data from Google Analytics and Search Console. I'm setting up the settings.ini file and extracting the packages, and I'm following the nbdev instructions to install and create a Github personal access token. Come follow my journey and learn how to set up your own mlseo package!
keywords: Mlseo, Pip Installable, Package, Google Analytics, Search Console, Nbdev, Github, Personal Access Token, Settings.ini, Extracting Packages
categories: nbdev, pipulate, google, git
permalink: /blog/making-mlseo-pip-installable/
layout: post
group: blog
---


Well, so another day. I'm going to use mlseo as the pip installable module name
that will take the place of pipulate in my heart and mind for awhile, because I
don't want to go breaking things on people.

Do it all the nbdev way. I have to get the making of packages into my fingers.
Think! Your publishing and sharing of the fruits of your labor is no harder
than git committing and pushing this to the mikelevinseo repo in Github. Thanks
to Jekyll's magic publishing system, this pushes out. And, okay, think!

1, 2, 3... 1? If doing things the nbdev way, follow the nbdev instructions.
Recycle the existing mlseo private repo that I have. I can keep files in
location so long as there's not naming convention collisions. I can bill this
as doing a revision into nbdev. Documentation!

Step #1: Starting point? Oh yeah, it's https://nbdev.fast.ai/

Okay, so visualize the result. I want to have a package called mlseo. It should
have all my latest techniques, especially focused around pulling data out of
Google Analytics, Search Console, performing "SERPs" and various other data
pulling, transforming and saving options. The idea is for it to become a sort
of Mike's Best-of Python for SEO tricks.

Okay, so make sure nbdev is installed and at it's latest version. That's
important because I'm experiencing things breaking and being fixed in the
nbdev_build_lib process among other things. Break and fix bleeding edge with
nbdev, for sure.

It's also worth noting that all the package creation and extraction work is
happening on the WSL2-side of my Windows laptop. So that (Linux terminal) is
where I am doing:

    pip install -U nbdev

Okay, try:

    nbdev_new

Ugh, it's a private repo. I had to create a Github personal access token. Okay,
yes from terminal I had to type:

    export GITHUB_TOKEN=[Github provided token]

    nbdev_new

    Executing: git config --local include.path ../.gitconfig
    Success: hooks are installed and repo's .gitconfig is now trusted

Wow, I didn't think it would be that easy. Okay, this is Jeremy Howard we're
talking about here. Get ready to have a meme infect your mind. Be ready and
open to it because his preaching most suits this choir. I'm ready to jump on
the nbdev bandwagon, then soon fast.ai thereafter. But first...

Look at the mlseo repo. Do ls -la command. Do git status command. Figure out
what nbdev_new added to the folder. Oh yeah, settings.ini is the big one.
That is what needs to be setup correctly before any sort of releases, and
perhaps even before any sort of build. There's now a folder also named mlseo
which is where the packages will be "extracted" to, but I already have an
mlseo.py file, so this will be a little awkward for awhile. Good news is that
unlike Pipulate which may be deployed out there, mlseo's been a private repo,
so I won't piss anyone off. I also won't be too quickly sharing, even though
yes I am documenting it here where it's public. Perhaps I'll throw it public in
time, but for now... next step?

Oh yes! This is where things start moving over to Jupyter! I'm starting to
appreciate the selection of the name Jupiter and changing of the i to a y. It's
omage to Python. I should really talk about that in a video. Not only that, but
it's subversive also in that it's going to be working more and more like a
large body with lots of mass gobbling up everything around it.

That was actually a hurdle overcome, nbdev_new'ing into an already existing
private repo. Check!


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/how-i-became-obsessive-about-obsolescence-proofing/">How I Became Obsessive About Obsolescence-Proofing</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/making-mlseo-pip-installable/">Making mlseo pip installable</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li></ul>