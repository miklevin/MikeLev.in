---
date: 2022-10-27
title: You Need a Personal Server In Your Life & The Time is Nigh
headline: Create Your Own Personal Server and Reach Your Goals!
description: I discovered that I could use my NAS as an application server, and with the help of Linux containers, I could transfer my laptop simulations to a home cloud without any fees. I was able to condition myself to go the direction I wanted to go and reach my goals, and mastering generic Linux was key for my long-term success. Read my blog post to learn how I did it and create your own personal server.
keywords: NAS, Linux, Containers, LXD, Home Cloud, Cloud Provider, Laptop Simulations, Application Server, Personal Server, Long-term Success, External Influences, Conditioning, Goals, On-task
categories: linux, container, success
permalink: /blog/you-need-a-personal-server-in-your-life-the-time-is-nigh/
layout: post
group: blog
---


It can be incredibly difficult to stay on-task every day in pursuit of some
goal, especially if it's just you yourself trying to make it happen. With the
outside influence of pushing parents or having committed by spending money to
education, you employ outside influences to keep you going. But they are not
always genuinely of your own choosing.

Sometimes you're lucky and the direction parents and school compel you are the
same direction some deeper internal force wants you to go. But not always. In
fact the residual effect of outside influence can feel like internal influence
maybe for the rest of your life because you internalized it and used that
external force to override your own internal preferences.

The problem is knowing. Knowing comes from a result of thinking and speculating
and testing and doing. This is self-reflection and knowing yourself. Problem
is, even this is a skill which if you develop excessively under the influence
of outsiders, even YouTubers, is still not necessarily your own. You need a
breaking-free-of-influence process that still somehow conditions you.

How to condition yourself to go the direction you want to go and do the things
you want to do? How do you not get derailed by the powerful outside influences
in your life? You make something that serves you (and only you) in your life.
You make a server and you have it play the role of parent, school or youtuber.
You choose your own path in such a way your path reinforces staying on it.

I'm in my fifties now and from time-to-time have had servers in my life. They
were almost always for employers. On those rare occasions I set servers up for
myself, they didn't have the staying power to help me navigate my life
long-term. And by long-term I'm talking 2 years, 5 years, 10 years. Can you
keep a server running on your behalf for ten years helping you out?

I've been on many false-starts including Raspberry Pi's, virtual machines, and
yes even real physical server-grade hardware in my home. The problem is a
dynamic life and outside influences. Moving. Rearranging. Even just neglect of
the server long enough to forget how it works not wanting the extra overhead in
your life of re-figuring it all out and enabling it again.

Disruptions to setting up ones own personal server prevents certain
accelerating and compounding return effects that you want/need in your life to
move you forward from from ever even occurring. They are interrupting. They are
blocking your blossoming. Most of us go through life like a barely germinated
seed sitting on fertile soil with plenty of breathable carbon, but the power of
the sun is blocked by a taller more spread out canopy of trees. Your figurative
seed never busts open to send its roots down and its leaves up.

Feel familiar? Well if you have even the most basic technical leanings, such as
the ability to use Excel and do the occasional macro, then you have all the
ability necessary to have a permanent ongoing and resilient to disruption
server in your life. It's getting easier every year. I did it the hard way in
my twenties and thirties trying to make my mark in NYC but it didn't stick. Now
that I'm in my fifties, I've stepped back to assess tools, methodology and
technique. And I find it now uniquely doable thanks to LXD Linux containers.

I tested the techniques directly on my laptop. I did things to make computer
programming code on my laptop run exactly as it would on a cheap generic Linux
server. Any device you buy can basically be set up this way. This is not true
of Windows or Mac servers which require you to use their proprietary software
in their ways, which thus creates a dependency, expiration date and fragility
in the long-term. Everything about a personal server is about generic Linux.
And even if you're on a Windows or Mac system, mastering generic Linux should
be your goal if you're thinking long-term.

Once the techniques worked on my laptop simulating a server I looked around to
the things in my home that could also work like a generic Linux server. I had a
device called a NAS for network-attached storage. That acronym sells such
devices so short. Since these devices need to provide network protocol services
they needed little computers built-in. Once you build a little computer into
something that's just supposed to give you more drive space, it's natural to
use it for more things. The precedent is set by DHCP servers that issue IP
addresses in all our homes. Your home WiFi router is working in much this same
way but lacks the freedom for many other services than DHCP. NASes don't have
such limitations.

Since NASes already needed built-in computers, and powerful built-in computers
are so easy to provide cheaply, it only made sense to make NASes serve
applications. So the "AS" of NAS can also stand for "Application Server". And
one of the applications it can serve is the LXD Linux container host. And
therefore everything you've been running in "server mode" on your laptop is now
transferable to a home cloud. Since your NAS is on all the time, you've now got
a generic Linux server running 24x7 without paying a cent to any cloud
provider.

I received an email at 2:30 AM this morning telling me so. Now I've got a
generic home Linux server running 24x7 from my NAS. If I wanted to move it from
my NAS to some other hardware, I either move the container or re-run my server
install scripts which work on almost any hardware that supports Linux because
highly generic. I have now both easy portability and reproducibility of the
now-lifetime 24x7 server system.

And so what now

Add more intent to your life.

Create a plan for clear daily forward progress.

Customize it to you and what you know about yourself. Be realistic.

For me it's publishing some writing and getting out some video to document my
actions, my systems, my evolution before the day has barely gotten underway.

Use this slightly altered and expanded perspective to improve your performance
on your day-job.

Win back lost time the extra overhead of this process incurs by working smarter
and not harder.

If this is not possible, re-examine the "intent" you're trying to set for
yourself with the emails. Make adjustments to what you are trying g to get
yourself to do each day.

And so for me now, it's little chisel-strikes refining that email and the
process surrounding it.

Switch it from just using GNU screen in a terminal session starred manually to
using GNU screen in a terminal session stared by Linux's system for
automatically starting services.

- Linux Service (systemd)
- Automatically starts at startup
- And if it exits, it automatically restarts

Layer in better messaging and intent to keep compelling me forward every day.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/running-automated-script-on-nas-24x7-under-lxd-container/">Running Automated Script on NAS 24x7 Under LXD Container</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/how-to-use-the-screen-command-for-linux-service/">How to Use the Screen Command for Linux Service</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/success/'>Success</a></h4></li></ul>