---
date: 2022-06-15
title: Windows Updates KB5014699 & KB5013887 & LXD on WSL2 Under Ubuntu 20.04
headline: "Struggling to Decide: Should I Make My Next Video Out of the Arts?"
description: "After a long update process, I realized the Windows Updates I had downloaded weren't what I was looking for. I then tried to get LXD running under WSL2 on Ubuntu 20.04 but was unsuccessful. Switching to Ubuntu 18.04 allowed me to get LXD running, but now I'm faced with a difficult decision: do I make my next video out of the arts? Read my blog post to find out what I decide!"
keywords: Windows, Updates, KB5014699, KB5013887, LXD, WSL2, Ubuntu, 20.04, 18.04, Update Process, Forced Restart, Video, Arts, Decision, Commit
categories: container, microsoft, wsl, ubuntu
permalink: /blog/windows-updates-kb5014699-kb5013887-lxd-on-wsl2-under-ubuntu-20-04/
layout: post
group: blog
---


Wow, this latest Windows Update was a rough one. I had been doing a number of
low-level OS things especially on the Linux side of the Windows Subsystem for
Linux (WSL, WSL2) lately trying to get the LXD container system to work and
figured it was time for a full system reboot. I saw the little-red-dot on the
power icon of Windows 10 indicating there were downloaded updates to apply, and
I thought "great!" This must be the updates I'm waiting for.

![21H2 View Update History Windows Feature Updates](/assets/images/21H2-view-update-history-windows-feature-updates.JPG)

{% include youtubePlayer.html id="AO0k64YPJLM" %}

# These Are Not The Windows Updates You're Looking For

But after a very long update process on the blue-screen it went to a
black-screen and never came back. I gave it a good generous 10-minutes... and
no luck! Force a restart with the "soft" hard reset button (there are no longer
***real hardware reset buttons*** on laptops. That's insane.

After the forced restart I went into Settings / Windows Update to see if I
could get a description of what just happened to my machine and it occurred to
me to do this livecast. It's early. It's of interest.

Get into the Zone... The Flow... The Bear Necessities...

Forcibly get into the zone this morning because of distractions that could not
be allowed. One controls their mind. Your mind is yours. No one or nothing has
the right to derail or otherwise precondition you for the day in ways you do
not want for yourself. Journals like this and playlists like that are tools to
help you condition your mind.

Yesterday I tried getting LXD (standard Linux containers) working under WSL2
(Windows Subsystem for Linux)... and failed due to a number of reasons. Things
didn't work as advertised. The remedies were deep rabbit holes. I didn't have a
successful journey through Wonderland yesterday.

# Windows Update KB5014699

[June 14, 2022—KB5014699 (OS Builds 19042.1766, 19043.1766, and 19044.1766)](https://support.microsoft.com/en-us/topic/june-14-2022-kb5014699-os-builds-19042-1766-19043-1766-and-19044-1766-5c81d49d-0b6e-4808-9485-1f54e5d1bb15)

On May 19, 2022, we released an out-of-band (OOB) update to address an issue
that might cause machine certificate authentication failures on domain
controllers. If you haven't installed the May 19, 2022 or later releases, then
installing this June 14, 2022 update will also address that issue. For more
information, see the Before installing this update section in this article.

# Windows Update KB5013887

[June 14, 2022-KB5013887 Cumulative Update for .NET Framework 3.5 and 4.8 for Windows 10, version 20H2, Windows Server, version 20H2, Windows 10 Version 21H1, and Windows 10 Version 21H2](https://support.microsoft.com/en-us/topic/june-14-2022-kb5013887-cumulative-update-for-net-framework-3-5-and-4-8-for-windows-10-version-20h2-windows-server-version-20h2-windows-10-version-21h1-and-windows-10-version-21h2-b3bba918-9e0e-49cf-81e4-ab86ab7f76b6)

The June 14, 2022 update for Windows 10, version 20H2, Windows Server, version
20H2, Windows 10 Version 21H1, and Windows 10 Version 21H2 includes cumulative
reliability improvements in .NET Framework 3.5 and 4.8. We recommend that you
apply this update as part of your regular maintenance routines. Before you
install this update, see the Prerequisites and Restart requirement sections.

These are not the updates I'm looking for.

# So Give A Try At LXD under WSL Again

So try getting sudo lxd init "unlocked"

Edited zfs out of /etc/modules

Restarted Linux under WSL

Following instructions under https://blog.simos.info/how-to-run-lxd-containers-in-wsl2/
pedantically.

No luck, no luck, no luck!

# LXD on Ubuntu 18.04 works vs 20.04 where it doesnt?

Ugh! Is it being on Ubuntu 20.04 versus 18.04? Maybe. Yes, just maybe.

Switch your main laptop over to Ubunutu 18.04? Simultaneously? Delete 20.04 for
fewer moving parts? Make my next video out of it? Ugh! Maybe. Just maybe.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/failed-getting-lxd-working-under-wsl2-under-ubuntu-20-04-systemd-snap/">Failed Getting LXD Working Under WSL2 Under Ubuntu 20.04 systemd & snap</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/reverting-wsl2-from-ubuntu-20-04-to-18-04-to-get-lxd-containers-working/">Reverting WSL2 From Ubuntu 20.04 to 18.04 To Get LXD Containers Working</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/container/'>Containers</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li></ul>