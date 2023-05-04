---
date: 2022-09-11
title: Recovering Old Laptops For Video Production Purposes
headline: Upgrading WSL1 and Resetting Windows 11 to Windows 10 - My Journey to Create a Video Tutorial
description: I'm creating a video tutorial to show how to upgrade WSL1 and reset Windows 11 to Windows 10, using a laptop with a version lower than 18917. To ensure accuracy, I'm researching Wikipedia pages and downloading Windows Win10_1809Oct_v2_English_x64.iso. Join me on my journey as I work to make this video and worry about ruining it with a system update!
keywords: Laptops, Video Production, Tutorial, Upgrade, Reset, Windows 11, Windows 10, Version, 18917, Wikipedia, Win10_1809Oct_v2_English_x64.iso, WSL1, Factory Reset, System Update
categories: windows 10, windows 11, version, tutorial
permalink: /blog/recovering-old-laptops-for-video-production-purposes/
layout: post
---


It's okay to let a few days go by without pushing out a video or two. Today I
will try to, however, if even just for myself getting to a good dev point.
Okay, the interest in my video about how to upgrade WSL1 is so strong that I
should do a more formal "all-the-way" video about healing Windows.

Healing Windows to heal the world.

Maybe I'll even show how to do a factory reset from Windows 11 to Windows 10.
But for now, just reset Windows 10 on one of my machines and then don't do the
flurry of updates. Make sure you're on a version lower than 18917 so that you
have WSL 1. Then do a Linux install to make sure you have a WSL1 on your
machine. Wow, early adopters really got fubar'd. THEY are your likely crowd
because they had the initiative to try wsl back in those early days.

Okay, work on a sort of script. It's not going to be a multiple take sort of
thing because it takes too long to reset windows. Learn a bit more to say some
interesting things during the video. Oh! The Wikipedia page has some
interesting tidbits https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux

WSL leverages the architecture of NT to run Linux programs as special isolated
minimal processes they call "pico processes" attached to kernel mode which they
explain on a protection ring page https://en.wikipedia.org/wiki/Protection_ring

Okay, I'm starting out on Windows Win10_1809Oct_v2_English_x64.iso gotten
through the Windows-ISO-Downloader.exe

For the longest time I resisted the concept of multiple laptops over
"integration" issues. One laptop to rule them all, and all that. But the
blindspot it created was what happens on a new laptop install. What happens
with different versions? Different environments? Different instal presumptions?
And by ignoring those questions you let manifest a nasty blindspot and set of
presumptions. Nothing is that important but what you deliberately protect. And
what you deliberately protect should be the corest of core and nothing more. Do
not protect any presumptions of operating systems or hardware or you've
enslaved yourself to some vendor or other.

That being said, the videos I'm trying to make for YouTube are right on the
vibrating edge of WSL (windows subsystem for linux) being available. I'm
working on a new machine where its version is below 18917 but with every System
Update I apply, it's creeping to that point. I'm currently installing 20H2 and
I'm worried that goes past the WSL2 boundary and will ruin the video I'm trying
to produce. I can always roll-back, but lost time effit!



## Categories

<ul>
<li><h4><a href='/windows-10/'>Windows 10</a></h4></li>
<li><h4><a href='/windows-11/'>Windows 11</a></h4></li>
<li><h4><a href='/version/'>Version</a></h4></li>
<li><h4><a href='/tutorial/'>Tutorial</a></h4></li></ul>