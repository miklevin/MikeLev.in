---
date: 2022-09-16
title: ubuntu1804.exe, ubuntu2004.exe and ubuntu2204.exe Oh My!
headline: "Exploring WSL2LXD with Ubuntu 18.04, 2004, and 2204: My Experience and Implications"
description: Today I was working on a project using WSL2LXD to host Ubuntu 18.04 instances. I had to remember the locations of the exe files for Ubuntu 18.04, 2004, and 2204, which I discovered were located in WindowsApps. I also speculated that Microsoft may be limiting how many slots can be used for each exe in WSL. Learn more about my experience.
keywords: Ubuntu, 1804, 2004, 2204, WSL2LXD, WindowsApps, Microsoft, Slot, Limiting
categories: ubuntu, microsoft
permalink: /blog/ubuntu1804-exe-ubuntu2004-exe-and-ubuntu2204-exe-oh-my/
layout: post
---


Okay now get back to my normal workflow. I have this (my full-screen vim
journal) on screen 1, albeit admittedly no longer fullscreen. I have enough
reasons for the tabs of Microsoft Terminal to show enough these days to just
allow it to show. It's improving fast. There's a "focus mode" that's not full
screen that I have to explore, and you can finally remove Azure from the
profiles. Oh, and add Ubuntu 18.04 to the profiles... done. Let's see if that
survives between reinstalls. Anyhoo, back to my main work. 1, 2, 3... 1?

I'll let the folks here have a bit of insight to my day-job. Just sanitize as I
go. I keep a separate browser for certain types of work because Google login
aliases under GSuite are extremely stubborn. It's dashboard work, which in this
case means an automatically updated Google Sheet. I know dashboards are so much
more these days with Google Data Studio and other product, but sometimes based
on the nature of the data it's just best to plop it into a spreadsheet with
some good color-coding, and that's the case with these dashboards.

Okay, done. Didn't really document as much here as I thought. But it does show
the fact that of the many, many things I'll be using this new wsl2lxd project
for will be working on spreadsheet format things. Also I'm done my work early
enough on a Friday to crank out my weekly report without it running into a
weekend. I've been meaning to use one of these journals for that, but only with
mixed success.

I can tell already that reinstalling these Ubuntu-18.04 instances for LXD
hosting under WSL is something I'm going to be doing often. Many of the basics
of not getting screwed by this process I have already worked out. I need to
remount my data drive in that persistent way:

Mount the data drive:

    sudo mount -t drvfs '\\EchidNAS\data' /home/wsluser/data

vim /etc/fstab

    \\EchidNAS\data /home/wsluser/data drvfs defaults 0 0

Okay, when I go over this in a video, I have to remember the following salient
points:

WSL has an odd approach to their Windows subsystem by which there is an exe for
each Ubuntu found in this strange location:

    C:\Users\%USERNAME%\AppData\Local\Microsoft\WindowsApps

Methinks this is something like a Web Store sandboxing location. Anyway in here
we find:

- ubuntu1804.exe
- ubuntu2004.exe
- ubuntu2204.exe

...along with winget, some pythons, a MicrosoftEdge and wt. Go figure. Anyway,
my speculation is that you get "one slot" for each exe in WSL so you can't be
running 2 Ubuntu 18.04's and such. It feels like this is a way of Microsoft
letting you have experience with each version Linux but to not run too many at
once, giving both Microsoft and Linux a bad name. This may factor somewhat into
them not (easily) allowing a Linux container system on WSL.


## Categories

<ul>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>