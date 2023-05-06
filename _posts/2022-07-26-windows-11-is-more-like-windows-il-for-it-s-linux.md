---
date: 2022-07-26
title: Windows 11 is more like Windows Il (for It's Linux)
headline: "Experience the Move to Linux with Windows 11: It's Time to Take Up the Old-School Terminal Stuff!"
description: Get ready to take the plunge into the world of Linux and Unix-based systems with Windows 11! I'm stubbornly staying on Windows 10 for now, but by enabling Windows Subsystem for Linux and the Hypervisor, I can still experience the move-to-Linux experience Microsoft has planned for us. With the help of Steve Jobs and Lennart Poettering, I can run Linux Terminal sessions under WSL2 and even upgrade my instance to Linux Containers.
keywords: Windows 11, Linux, Unix, Windows Subsystem for Linux, Hypervisor, Linux Terminal, WSL2, Linux Containers, Ubuntu 18, Steve Jobs, Lennart Poettering, System Management, Lauchd, Init, Text-based Terminal
categories: windows 11, unix, wsl2, linux terminal, linux
permalink: /blog/windows-11-is-more-like-windows-il-for-it-s-linux/
layout: post
---


I'm not going to make the argument that it's time for you to learn Linux. If
you don't know that by now, it's your bad. However, I will clarify that this
does not mean learning a Linux desktop such as Ubuntu or KDE Plasma. The time
of the Linux Desktop is not necessarily upon us, nor would it matter.

No folks, I'm talking about those boring old text-based Terminal windows where
you better be seeing ~$ or some variation. If you're seeing C:\> or some
variation of that, you're in trouble. Out with the DOS; in with the \*nix!

From the time Steve Jobs went on a rampage against the command-line to promote
his point-and-click Macintosh computer, the world has been conditioned to think
there's something inherently bad about that text-based environment. Well, good.
It'll turn a lot of people away, and those who can overcome that fear will have
an advantage. So the first lesson of learning Linux is to overcome the fear of
the terminal.

There are other ways to interoperate with a computer than all the
point-and-click baby-talk Steve Jobs tricked us into abiding by for some forty
years. Ah yes, about 40 years since the 1984 introduction of the Mac and the
first (laughable) versions of Windows a year later in 1985. They pulled one
over on us, didn't they? Computers are now a predominantly consumer and
fashion-driven industry, aren't they? Their battle over control is a battle
over your soul, and you can feel it.

Are you a Mac or are you a PC person doesn't compare to are you an Android or
are you an iPhone person. And the fact that it's proprietary vs. proprietary in
the former case, and again proprietary vs. proprietary in the later is
problematic too. There always seem to be two main options, a split between a
quality experience at a premium or a commodity-driven economy-of-scale product
from the rest of the industry pulling together enough to beat a
mega-competitor. Shouldn't we be past all this nonsense by now?

We are. Unix-like operating systems won in a broad sense, and Linux won in
particular, when it comes to rapidly molding some hardware into something
custom. There's never been a better time to take up all that old-school
text-based Terminal stuff. For you see the era of Jobs and Gates has finally
come to an end. Text-based terminal is cool again, and the source of all-age
power.

I say all-age power, because it's accessible to people of all ages, and the
power it provides is relevant, regardless of what "age" we're in, be it the
rise of computers or the rise of general artificial intelligence. Learning to
touch-type on standard keyboards will make you more powerful on this world and
in life than simply relying on forever improving voice recognition. The idea is
to master inanimate matter. For once the matter is self-animated, what's the
point. Take a break from watching the machine evolution for a bit and focus on
evolving yourself a bit. Learn Linux Terminal and a hand-full of complimentary
tools. Be relevant today and long into the future.

One irony is that it was way back in 2007 when the Apple Macintosh itself
switched MacOS to be Unix-based under the hood, under the stewardship of Steve
Jobs. So it is the very same person who drove us to our excessive reliance on
point-and-click operating systems who swapped out the proprietary innards with
the great new emerging standard. He just didn't contribute much back beyond
that.

Well that's not totally true. Linux wouldn't have systemd today if it weren't
for Steve Jobs. For you see at the time Apple forked a version of a BSD kernel
called Mach but it didn't have all the bells and whistles. In particular, it
lacked system management, for which Apple developed the initialization
management software (init) called lauchd. It even has a lauchctl. Sound
familiar? It should. It's the model Lennart Poettering looked at when
developing systemd, which has taken over Linux system service management on
most distros.

At about the same time and nearly 20-years after Apple embraced Unix, Windows
is now shipping ready-to-install Linux. It's not technically shipping with
Linux. But ever since Windows 11, having a working true Linux Terminal has been
typing one command in a "Run as admin" PowerShell away. Unfortunately, on
Windows 10, there's 3 steps that come before that, but it's still worth it.
Whether on Windows 10 or 11, Microsoft now officially supports your Linux
adventure.

All your dev-like work should be occurring with forward-slashes. Even if you're
not a software developer but you need to manipulate data a lot, you should be
doing things in a Terminal, and that terminal should have forward-slashes.

This is magic-land. This is where the spells are not merely cast, for that's
using any old software. No, this special place called Terminal is magic because
it's what controls the show before there is a show. It was has control first
during the hardware's initial boot procedure.


No, I make
almost the reverse argument. Forever shifting desktops work against achieving
mastery, because the tools keep changing.

I'm stubbornly staying on Windows 10 until Windows 11 is cool enough for me.
But that's because I can have the move-to-Linux experience that Microsoft has
planned for us while still on Windows 10. Most people can not because of the
complexity of having the proper WSL2-experience on Windows 10. It takes:

# Step #1: Enable Windows Subsystem for Linux

This command must be typed into a PowerShell, I believe as admin.

    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Step #2: Enable Hypervisor

This command is similar to the one above, but it specifically turns on your
native hardware's (laptop's CPU) support for hypervisor features. This allows
hardware-level "virtual machine" technology to permit full, true Windows to run
simultaneous with full, true Linux. Neither is the other's "host". That role
will now be played by the hypervisor features, as managed by the wsl.exe
program on the Windows side. Dadump, dump!

    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Step #3: Download & Run This Patch

And here's the step that trips everyone up. A patch needs to be run. I'm not
sure exactly what's going on here, but it is my speculation that whatever this
is is one of the big reasons why Windows 11. There's some serious
system-wrangling going on here to make the miracle that is the Windows
Subsystem for Linux work. Even with this patch, support for WSLg (Linux
graphics capabilities) has not come to Windows 10.

(https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)[https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi]

{% include youtubePlayer.html id="vgk7yMkrDRk" %}

And so, patched up and done with however many reboots this makes you do, you
are now able to run your Linux Terminal sessions under WSL2. But if you've
already been on WSL for awhile, you will have to convert your WSL Linux
instances from 1 to 2.

But wait! Before you go upgrading your instance, ask yourself if it isn't
actually a good time to move yourself over not just to Linux Terminal, but
Linux Containers too? Of course it is! So for now, as of this writing, you want
to be on Ubuntu 18.04 for your main WSL2 Linux system, and that's not the
default.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/linux-container-under-windows-10-wsl-supporting-graphics/">Linux Container Under Windows 10 WSL Supporting Graphics</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/setting-up-lxd-on-wsl2-with-systemd-enabled-ubuntu-18-04/">Setting Up LXD on WSL2 with systemd enabled Ubuntu 18.04</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/windows-11/'>Windows 11</a></h4></li>
<li><h4><a href='/unix/'>Unix</a></h4></li>
<li><h4><a href='/wsl2/'>WSL2</a></h4></li>
<li><h4><a href='/linux-terminal/'>Linux Terminal</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>