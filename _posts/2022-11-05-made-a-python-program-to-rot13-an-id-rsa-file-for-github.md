---
date: 2022-11-05
title: Made a Python Program to Rot13 an id_rsa file for Github
headline: I Created a Python Program to Transfer an id_rsa File to a lxdwin Repo
description: Today, I faced a challenge while transferring an id_rsa file to a lxdwin repo. I documented my experience in a video and found a StackOverflow page with the solution. Despite this, I encountered a problem with Github recognizing my ssh public key, so I decided to ssh the keys into the repo. Read my full story to discover how I overcame this issue!
keywords: Python, Program, Rot13, id_rsa, File, Github, Transfer, lxdwin, Repo, Video, StackOverflow, SSH, Public Key, Pipulate, Settings, Windows, Directory
categories: python, setting, git, pipulate, microsoft
permalink: /blog/made-a-python-program-to-rot13-an-id-rsa-file-for-github/
layout: post
group: blog
---


No big projects. Get one little thing done that moves things forward in an
irreversible way. Lather, rinse, repeat and "projects" will get done of their
own volition and you do not need to punish yourself. Find the love!

Okay, simply transfer the id_rsa keys into location on the lxdwin repo. The
problem there is that I now think I should use different filenames than I did
in the video. So I'm going to re-generate them. Why not make a video out of it?
What preparations?

Get that StackOverflow page with the solution showing:
https://stackoverflow.com/questions/4565700/how-to-specify-the-private-ssh-key-to-use-when-executing-shell-command-on-git

- I am creating or piggybacking on an exiting .ssh directory Windows-side.
- It goes in C:\Users\[winusername]\.ssh very similar to how it work on Linux.
- That is the same as /home/ubuntu/.ssh

So there is a colliding key concern.

Okay, I hit an unexpected snafu (situation normal, all eff'd up) in Github
recognizing the recorded ssh public key in the Pipulate Github Settings as the
same as one used in a repo! Wow, that's smart. Great way to disable the ability
for the keys to be used maliciously against github. But still sometimes
necessary for a distributed automation system that needs to git clone on its
own.

So this project isn't really done until I ssh those keys into place.

Next video? Oh, that Python needs to be a standalone command! Argparsing! Ugh!
Okay, most people reach for Click or some other heavyweight crap. No need. But
there is a need to get it out of Jupyter. Another interesting video. Do it!
Prep?

Google up a good ArgParse documentation page.

I just created the Python command.

{% include youtubePlayer.html id="gO6gl2zYuRg" %}

{% include youtubePlayer.html id="8J0zpdZSe_c" %}


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/joining-data-between-spreadsheet-tabs-better-than-vlookup/">Joining Data Between Spreadsheet Tabs Better Than VLookup</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/just-moving-life-forward/">Just Moving Life Forward</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/setting/'>Settings</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>