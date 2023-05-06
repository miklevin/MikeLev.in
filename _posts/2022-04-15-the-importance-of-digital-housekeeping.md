---
date: 2022-04-15
title: The Importance of Digital Housekeeping
headline: Uncovering the Benefits of Digital Housekeeping for Stress Reduction and Increased Happiness
description: I'm trying to get my mlseo project up and running, and I recently had a discussion with my wife about the importance of digital housekeeping. I'm taking steps to reduce daily stress and increase happiness, like creating a github folder, deleting unnecessary items, and taking advantage of AeroSnap. I'm also trying to upgrade my JupyterLab and wondering if the desktop version will be upgraded too. I'm currently on Jupyter 3.3.2-2, but
keywords: Digital Housekeeping, Stress Reduction, Happiness, Github, Deleting Items, AeroSnap, JupyterLab, Upgrade, Jupyter, nbdev, Jekyll, Templating, Home Directory, Start Menu, Taskbar, 10_I, pip, mistune, websockets, git commit, Requirements
categories: jupyterlab, jupyter, jekyll, github, nbdev
permalink: /blog/the-importance-of-digital-housekeeping/
layout: post
---


Increase focus on mlseo. Get that righteous feedback loop in-place and
happening. I've made a decent start with nbdev, but things feel like they
stalled out. Why? I put a custom domain on my nbdev/docs folder and it doesn't
stylize the html with Jekyll. I'm wondering if I have to do that local for such
a special case. But I don't think so. I tested putting markdown in location and
that gets the Github Pages Jekyll template just fine. It works with markdown
but not with html files, which makes sense. But I thought a big point of using
nbdev for documentation was that Jekyll would take care of the templating when
hosting it on github.io. Sigh. There's more to learn.

Have a sort of Mantra for mlseo:

- Let every easy project stay easy.
- Wrap up an easy project cleanly.
- Identify clever new noteworthy bits.
- Roll good bits back into mlseo package.

I had an interesting few days with my wife regarding issues of digital
organization and the parallels with real life and relationship to anxiety.
There's a certain level of frustration that's sure to happen when you don't
know where things are. I Make very reasonable arguments about taking some time
to familiarize yourself with the default "home" directory (also known as
folder) that the operating system is always trying to put you in. It's the
default location JupyterLab puts you in after an install. It's that "username"
location that usually has Pictures, Music and other subfolders of everyday-use
interest. Yield to that. Lean into what the OS is trying to get you to do. Make
a github folder there and keep everything you work on in subfolders within
github. You will then always know where to go to find your code stuff.

Regarding shortcuts in the startbar, taskbar and desktop... use 'em. Don't have
ANYTHING in those locations that you didn't deliberately put there. Delete
everything you don't want or need from your start menu and desktop. Don't pin
ANYTHING to your taskbar. Change the Windows setting so that only running
software shows on the taskbar, and that ALL taskbar icons show no matter which
Virtual Desktop you're on. The default is way too confusing and to make it
usable only takes a trimming what's already there (deleting from the startbar
for example) and changing a few items in settings.

The frustration level was already high when I started that discussion with Nat,
and as I got into what solves it, I could just feel it getting worse. I
shrugged my shoulders and said that's all I can do. A little bit of time
invested up-front "settling into a machine" pays back in increased productivity
and happiness for the rest of the time you're on that machine or until some
OS-upgrade messes up the startbar again.

Another thing is to take advantage of AeroSnap. Messy disorganized windows can
be dragged against the side of the screen to "snap" to half-screen. You can
then choose what you want on the other half of the screen. If you don't choose
anything else, you can open another window such as Windows Explorer (Win+E) and
snap it onto the other side. Now you can freely drag-copy files between
locations between two Windows Explorers windows. I know it's a poor-person's
Norton Commander or whatever other file-manager you like, but it's a process
you can do on any windowing OS without a special software install, so it's a
good technique to know.

Okay, so that's housekeeping. Housekeeping is important, primarily for reducing
daily stress and increasing overall happiness in work and life.

Ressonates!

Okay, so now the nbdev stuff that's been tripping me up.

It mostly has to do with formatting the contents of my mlseo repo's docs folder
to be GithubPages-ready.

The nbdev_nb2md command has been failing from the Linux-side command-line. Try
it from Windows! It seems nuts, but it IS another thing to try.

I'm running the 10_requirements.ipynb file that I have as part of mlseo to
upgrade all the pip components. I saw JupyterLab get upgraded, which is
curious. I wonder if when I quit and load the desktop version if it will be the
upgraded version. Don't forget to git commit the requirements.txt to the mlseo
repo so I can get back the environment real quick after a JuptyerLab upgrade
via the old technique (Settings Add/Remove software). I'm currently on Jupyter
3.3.2-2. The pip upgrade says 3.3.3 is on my machine.

The 2 upgrades that have been held back for compatibility reasons are:

    Package    Version Latest Type
    ---------- ------- ------ -----
    mistune    0.8.4   2.0.2  wheel
    websockets 10.1    10.2   wheel


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/teaching-my-wife-vim/">Teaching My Wife vim</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-importance-of-digital-housekeeping/">The Importance of Digital Housekeeping</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyterlab/'>JupyterLab</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/github/'>Github</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li></ul>