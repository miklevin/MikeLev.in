---
date: 2022-11-04
title: Permission denied publickey fatal Could not read from remote repository
headline: Git Cloning Solved After Changing LXD Linux Container to Privileged Mode
description: I encountered a problem when trying to git clone a repository from an LXD Linux Container running on Windows Subsystem for Linux (WSL). After discovering the container was running in unprivileged mode, I changed it to privileged mode with the lxc config command and rebooted. This fixed the file permissions issue and allowed me to successfully git clone the repository. Read more about my experience and how I solved the problem.
keywords: Permission, Denied, Publickey, Fatal, Could, Not, Read, Remote, Repository, LXD, Linux, Container, Windows, Subsystem, WSL, Privileged, Mode, lxc, Config, Command, Reboot, File, Permissions, Ownership, Git, Clone, Research, Issue, Unprivileged
categories: linux, wsl, lxd, git, lxc, container
permalink: /blog/permission-denied-publickey-fatal-could-not-read-from-remote-repository/
layout: post
---


Trying to git clone and getting the error message:

Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

{% include youtubePlayer.html id="C9fffTNoNOg" %}

Well then you're in luck! You've come to the right place. I show you how to fix
that problem and put your public key id_rsa.pub file in location in Github.com
/ Settings / SSH and GPG keys AND I show you how to do it in the context of a
privileged LXD Linux Container running under Windows Subsystem for Linux (WSL)
running under Windows 10 or 11.

This sets the stage for me git cloning a number of repos into the LXD SEO Dev
platform I'm preparing.

# lxc config show -- expanded container security:privileged=true

{% include youtubePlayer.html id="A3E2nEMUknI" %}

Follow up on yesterday's video regarding LXD privileged containers.

Show with the wsl powershell command:

    lxc config show --expanded jupyter

...that you are in privileged mode by finding "security.privileged: true"

Then go into the container and show some permissions.

Then use sudo chown to change some permissions.

Set the stage for the next video with the .ssh keys, but don't go there yet.
Too much for one video!

Let's do ssh-keygen!

Done!

Sometimes you don't know what you don't know until mysterious obstacles are
thrown up in your face that are hard to recognize and you don't even realize
are a symptom if something wrong. This was the case recently with my taking up
of LXD Linux Containers as my primary new platform to develop on, employ to,
and distribute as tools. The problem arose when it came time to pull down git
repos from Github from within the container. Simple enough but full of nested
gotcha.

First it must be pointed out that I'm endeavoring to keep resources that would
normally have to be copied into multiple locations actually only in one
location and just link all the other locations back to this main copy. And the
main copy is usually directly under Windows in such locations that we know as
C:\Users\[windowsusername]\.ssh, C:\Users\[windowsusername]\repos and such.
This way Windows has access, the Windows subsystem for Linux has access through
its /mnt/c/[windowsusername] convention. With further "lxc config" commands
access trickles all the way down to the .ssh folder of the Linux container
under WSL under Windows.

Good news so far. This all worked out. But what didn't work out was git cloning
from the container. The .ssh id_rsa files were there but not fully accessible
due to file permissions. Where you normally see users and groups such as
ubuntu, I was seeing user nobody in group nogroup. No amount of chown and chmod
variation attempts could fix this, and so through sheer immersion using
software defaults, I "felt out" lurking security issues that blocked my plans.
But it's an easy to identify and explain symptom and I couldn't be the first
encountering it, right? So I Google up the issue of privileged LXD containers
(the original default) versus unprivileged containers (the new default).

Wit this to go on I threw in the single lxc config command required to start
the container up in privileged mode. I learned how to confirm this fact with
another lxc command, but didn't see the results I expected until after a full
reboot. Once I rebooted (I could have probably just used "wsl --shutdown") the
nobody nogroup file ownership was replaced by ubuntu ubuntu as expected, and
chown and chmod started working. Woot! Detective work is always necessary, and
sometimes it's just to figure out the greater context under which you're
working. Your reality may be different than you think and changing your reality
may be one simple command.

# Checking LXD Privileged or Unprivileged Linux Container

{% include youtubePlayer.html id="MLV8X0PPllI" %}


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/powering-my-way-through-3-different-data-automation-projects/">Powering My Way Through 3 Different Data Automation Projects</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/joining-data-between-spreadsheet-tabs-better-than-vlookup/">Joining Data Between Spreadsheet Tabs Better Than VLookup</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/lxc/'>LXC</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li></ul>