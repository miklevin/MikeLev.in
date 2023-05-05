---
date: 2022-09-02
title: Your current video card driver does not support this NVENC version please update your drivers.
headline: Solved my OBS Screen Capture Error with NVIDIA Driver Update
description: Having trouble starting a screen capture with OBS? I ran into the same issue and figured out how to fix it by downloading the correct video driver from the NVIDIA website. I identified the correct driver by going to Windows Device Manager and finding the NVIDIA GeForce GTX 1060. Read my blog post to find out more about this issue and how I solved it.
keywords: NVENC, Video Card Driver, OBS, NVIDIA, GeForce GTX 1060, Windows Device Manager, Screen Capture, Error Message, Download, Fix, Solution
categories: 
permalink: /blog/your-current-video-card-driver-does-not-support-this-nvenc-version-please-update-your-drivers/
layout: post
---


I was getting ready to start my reboot of settling into a new Windows system
yesterday on a laptop I reset to Windows 10 factory default and decided to go
with OBS for screen capture, which I was able to get from the Microsoft store.
But upon trying to start a capture, I was immediately hit with the message:

> Your current video card driver does not support this NVENC version, please
> update your drivers.

Now whenever I get such a precise error message, I'm going to shoot a video to
show how to fix it:

{% include youtubePlayer.html id="2F976aUnRWs" %}

Unfortunately, I had to install Camtasia Studio again for screen capture
because of a chicken-and-egg problem without being able to use the Open
Broadcast Software until this driver update was complete. Happily, I was able
to download the video driver from the NVidia driver from their site. The
hardest part was figuring out which driver I needed for my laptop, which turned
out to be the NVIDIA GeForce GTX 1060, which I could tell from going to Windows
Device Manager and expanding Display adapters.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/fight-the-chaos-of-windows-10-use-virtual-desktops-linux/">Fight the Chaos of Windows 10 : Use Virtual Desktops & Linux</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/openpyxl-for-creating-a-formatted-excel-file-from-python/">OpenPyXL for creating a formatted Excel file from Python</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul></ul>