---
date: 2022-06-09
title: Installing WSL2 on Windows 10 Requires Kernel Update And Hypervisor Turned On
permalink: /blog/installing-wsl2-on-windows-10-requires-kernel-update-and-hypervisor-turned-on/
headline: Three Steps to Get WSL2 Running on Windows 10
description: "Learn how to use WSL2 (Windows Subsystem for Linux) on Windows 10 with just three steps: enabling Windows Subsystem for Linux, enabling Hypervisor, and downloading and running a patch. To make sure any future WSL instances are version 2, run the command 'wsl --set-default-version 2'. For more information on Terminal-based Linux, follow Mike Levin on YouTube."
keywords: WSL2, Windows 10, Kernel Update, Hypervisor, Enable, Download, Run, Patch, Command, Terminal-based Linux, Mike Levin, YouTube
categories: windows 10, wsl2, download, youtube
layout: post
---

Get your ass to Linux! If you're on Windows, it's most easily done immediately
after the Windows 11 update. But if you're anything like me, you're going to
stay on Windows 10 as long as possible. But did you know that your attempts to
turn on ***"the good stuff"***, i.e. WSL2 is undermined by three separate
steps, none of which is that is that easy or intuitive. If you try, you'll get
this error message:

> WSL2 requires an update to its kernel component. For information, visit
> https://aka.ms/wsl2kernel

# Translated: WSL2 on Windows 10 Requires These Steps

What's the big deal? The big deal is performance, network context, real Linux
kernel and connectivity between Windows and Linux OSes (file/drive sharing). In
other words, it's a question of whether the Linux you're using under Windows is
as good as genuine Linux (WSL2) or not (WSL1). It's worth jumping through a few
hoops for WSL2.

So what to do? If you search in Google on the error you get trying to upgrade a
WSL instance to version 2, you get this incredibly useful bit silent guy:

{% include youtubePlayer.html id="vgk7yMkrDRk" %}

...but the dummy jerk doesn't even talk during his video. He just sort of
pantomimes his way through expecting you to watch and know what he's not even
talking about. I decided to embed his video here and break it down for you.

Okay, first that shortcut URL is going to forward you to this actual address:
[Manual installation steps for older versions of WSL](https://docs.microsoft.com/en-us/windows/wsl/install-manual)
This seems like a misnomer because it jumps right into checking requirements
for running WSL 2. That does not seem like "older versions of WSL" to me. I
think someone's a little confused. It's no wonder this stuff is nearly
impossible on Windows 10. Anyhoo, there's really just 3 steps:

# Step #1: Enable Windows Subsystem for Linux

```bash
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

# Step #2: Enable Hypervisor

```bash
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

# Step #3: Download & Run This Patch

And here's the step that trips everyone up. A patch needs to be run.

[https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

Did I say three steps? Well, also do this. It will make the next wsl instance
you create version 2 automatically. You don't want to go having to convert wsl
1 instances into wsl2, especially if you just went through this rigmarole.

    wsl --set-default-version 2

And that's it! Follow these steps and you can start your journey to getting
your ass off Windows too. But you're not getting off of Windows if you're not
in the process of mastering (10 years or 10K hours) Terminal-based Linux (or
Unix).

Follow [this dude](https://YouTube.com/MikeLevin) on YouTube. He seems to know
what he's talking about.


## Categories

<ul>
<li><h4><a href='/windows-10/'>Windows 10</a></h4></li>
<li><h4><a href='/wsl2/'>WSL2</a></h4></li>
<li><h4><a href='/download/'>Download</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li></ul>