---
date: 2022-06-16
title: There's No Place Like Home & You Get To Decide Where That Is... Or Do You?
headline: Mapping Your Windows Home Folder to a Linux Home Folder - Learn How Here!
description: In this video, I show how to use symbolic links to map a Windows home folder to a Linux home folder, and how to use the 'ln' command and '-s' switch. I also explain setting up a virtualenv as a bonus. I emphasize the importance of backing up .config files in order to avoid losing work in the Linux container. Watch now to learn how to set up your Windows/Linux environment!
keywords: Windows, Linux, Symbolic Links, Home Folder, Virtualenv, 'ln' Command, '-s' Switch, .config Files, Backup, WSL, Container
categories: container, virtualenv, linux, microsoft, wsl
permalink: /blog/there-s-no-place-like-home-you-get-to-decide-where-that-is-or-do-you/
layout: post
group: blog
---


This video amounts to:

- running one command
- restarting Linux
- checking that it worked

We are turning ~/ from /home/healus to /mnt/c/Users/mikle

The rest is foundational background knowledge.

For the years that I've been using WSL (Windows Subsystem for Linux), I've been
functionally using my Windows home folder C:\\Users\\[usernmae], cd'ing to it
with my .bash\_profile script that runs every time a Linux Terminal is opened.
When I deleted my Unbuntu 20.04 to downgrade to 18.04 for some technical
reasons, it turned out having all my important "home" files on the Windows side
saved my butt. It gave me the freedom to delete the Linux container without
fear because the home directory lived outside of it.

In the video I made on the topic, I made a big deal of being able to pull down
all your work again from Github, but honestly I knew that I had a safety net by
having had used this other approach which I felt I was ready to abandon. Now
having gone through the process and realized there are files here and there I
didn't have in Github and am glad I had Windows-side. The straw that broke the
camels back is my vim spellcheck library. I'm going to improve my approach.
I'm going to do it here live at 5:00 AM as the sun rises.

I've given myself a good half-hour cushion between announcing (scheduling) the
stream and now. So get your ducks in a row. Know the issues.

It looks like there's plenty of information on this one askubuntu.com link:

https://askubuntu.com/questions/465493/how-can-i-symlink-my-home-folder-from-another-drive

Looks like a Stack Exchange site. Explain to the nice folks the difference
between Stack Exchange (the Q&A rating reputation CMS-system) and instances of
sites created with it like StackOverflow.

Anyhoo, the magic words are:

    ln -s /extra-home/username /home/username

...which for me means:

    ln -s /mnt/c/Users/mikle /home/healus

And that should do it!

However, as healus you can't very well go changing such a major thing about
yourself while you are you, so for a short while it's good to be somebody else.
That somebody is superuser:

    sudo su

It pains me to be doing such foundational stuff OS-wise still into my 50s. But
this symlink stuff is lifetime foundational. Under \*nix operating systems,
it's akin to piping and everything being a read/write file. It teaches you
about the Unix way and will serve you for your entire life. I should have used
symlinks more through my life, but it's never too late.

Bring up docs on the ln command. Explain the -s switch.

Oh! Show the nice people manual pages and how it eliminates the need to pipe
--help to ls! I should have shown that long ago. Maybe a separate video?

Okay, but did it work? It's going to take a shutdown and restart to be sure.
From a Powershell or COM:

    wsl --shutdown

And afterwards, it's still going to look like ~/ in the prompt, so print the
working directory:

    pwd

Hopefully, that's the successful video.

Maybe go into setting up your virtualenv as a bonus. Oh, that's going to make
my new startup script create errors because there are locations that aren't
there. Whoops. Disable your old .bash\_profile so those errors don't occur.
Just rename it. Hmmm, no. That's one of the few files that's gone. I have it in
the helpers repo so it's preserved but won't cause the error. This is good.

I am ready for the video.

Learnings:

Symbolic links are easy to make.

They are made using the source's "folder name"

The source's folder name is created in the target location.

You cannot so easily remap your ~/ Linux/Unix home location
to the WSL /mnt/c/Users/[username] location even though it's
soooooo tempting.

Instead, create symbolic links from your favorite Windows-side
folders (github) to /home/[username] locations Linux-side.

This is a compromise, but satisfies my 80/20-rule needs. If
you forget to commit to git repos and delete your WSL Linux
container, your work is still there.

But beware losing .config files from ~/home (needs baking up)


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/microsoft-edge-history-is-now-syncing-turn-off/">Microsoft Edge history is now syncing (turn off)</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-epic-nbdev-static-site-generator-post/">The Epic nbdev Static Site Generator Post</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/virtualenv/'>Virtualenv</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li></ul>