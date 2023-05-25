---
date: 2022-08-02
title: Ubuntu 18.04 vs Ubuntu 20.04 for LXD Under WSL2, Wizard Defaults
headline: "Testing Ubuntu 20.04 for Easier LXD Installation: Ubuntu 18.04 is the Easier Option"
description: In this blog post, I share how I tested Ubuntu 20.04 to see if I could easily install LXD. I found that Ubuntu 18.04 is the easier option, since it comes pre-installed with LXD and allows you to quickly get up and running. I also discuss my preference for local services over cloud resources, my advocacy for Linux and my blue-collar mechanic approach to tech literacy. Finally, I suggest JupyterLab-Desktop as a great way to learn Python.
keywords: Ubuntu, 18.04, 20.04, LXD, WSL2, Wizard, Pre-installed, Local Services, Cloud Resources, Linux, Tech Literacy, JupyterLab-Desktop, Python, Systemd, QNAP, Synology NAS, Microsoft, Apple, Unix, Code, REPL, iPython, nbdev, vim, git
categories: systemd, python, qnap, vim, git, wsl, ubuntu, linux, microsoft, container, nbdev
permalink: /blog/ubuntu-18-04-vs-ubuntu-20-04-for-lxd-under-wsl2-wizard-defaults/
layout: post
---


Regarding the need for Ubuntu 18.04 for a easy LXD install, let's do a test. It
should be easy, because WSL2 & distrod & containers, am I right?

In this blog post I have to satisfy my curiosity as to whether the distrod
trick is possible on Ubuntu 20.04. I know so much more about checking and
activating systemd now than in prior videos, this one is worthwhile just to
target that particular subject. Is systemd easy to install on WSL2 instances of
default Linux Ubuntu 20.04, and once it is can you apt install lxd or should
you use the snap store, and if you do will it work? The idea is to make the lxd
init process go smoothly through the wizard process. If not, there's too many
technical decisions to make setting up the container host.

    sudo apt update
    sudo apt install lxd
    lxd init
    [Enter]
    [Enter]
    [Enter]
    [Enter]
    [Enter]
    [Enter]
    [Enter]
    [Enter]... through the wizard!

Yep, I just tested it with Ubuntu 20.04 which comes pre-installed with lxd, the
init process doesn't let you just hit Enter for the defaults through the wizard
and have it work. There's magic numbers to figure out to answer the wizard to
make it work under Ubuntu 20.04. Yet it works with all the defaults perfectly
well under Ubuntu 18.04.

And ***THAT'S*** why I advocate sticking with 18.04 for now to get started with
LXD right away. Yes, that's it. Get started with Linux Containers right away,
through the destined to be more popular LXD than Docker. While yes, I quite
understand and easy Docker images are to host and run, can I have root? May I
drop .service files into /etc/systemd/system? As Mickey, can I instantiate a
broom and take control of its actions?

Is strive here and now to show you how to do this, for I need to do it for
myself and I would like to begin leaving a trail that could be followed by myy
child and others needing a way onto being among the privileged class of the
information age.

Just know how to read and write general tech, the parts which together do
enough to get by and are likely to be around for a good, long while.

Regardless of what the YouTube comments say, I am not Gilfoyle. I am just a
determined user of average ability who over time managed to wrangle enough
comfort-level in vim to make the switch to mostly Terminal. Add determination
and stick-to-itiveness to average ability, and most people I believe could
master enough Linux command line to get by. Terminal is less terminal than you
may think. \*nix survive.

Microsoft's now on the Linux bandwagon. If that's not a sign you should be too,
I don't know what is. But the message is a little different, and beautifully
Microsoftishly embrace-and-displace than many I think were expecting. Linux
Desktops? Who needs 'em? Let's be honest here folks, a visual desktop, anything
with a Graphical User Interface (GUI) is going to be wired to an application
programming interface (API) that could be anything in the back-end. We saw
Apple make the switch from their proprietary MacOS 9 to OSX, which was Unix,
back in 2007 and hardly anyone noticed. Microsoft could totally rewire Windows
to a Linux-based backend, replacing Windows such as it were. Windows would be
to Linux what Apple's Cocoa is to Unix.

The world's response would be a big yawn. By that time, Windows being dead
would be over. You use what you use as a graphical windowing and
virtual-desktop managing environment. Who cares how things get done which
provide for you a standard Linux Terminal? Let it be Windows 10, Windows 11 or
whatever out there if it gets you good hardware and general support today, if
it also gets you genuine Linux today?

What I'm advocating rather easily with practice, just like anything else. What
I am not is any sort of super hacker or industrial strength tech guy. Take up
the stuff today that's setting in as "standard". Okay, so Linux won. It takes
awhile to admit it, but now with systemd falling into place, I can show people
some neat tricks they didn't know were so easily and readily available to use,
if only you knew the secret magical incantations.

I advocate figuring out those incantations and the general rules surrounding
them, to instantiate instances of generic Linux computers, upon which all
resources are isolated. Then there's some habits to form so that you can "live
and work" inside those containerized computer units.

I further advocate doing this natively and directly on your laptop. I advocate
not using cloud resources or cloud providers whenever possible. Instead, use
Cloud APIs (application programming interfaces), but let them be wired to local
services whenever possible, either right on your laptop or on a home server
running behind your home router; something like a QNAP or Synology NAS (network
application server). Learn on laptop, push to "local" cloud.

Learn about and appreciate all the plethora of web services available from
Amazon, Google, Microsoft, and endless smaller service providers, but try to
avoid building dependencies to them into your software or systems. Of course
with Microsoft having bought Github.com and npm company behind the free NodeJS
default repo, it's pretty hard to avoid Microsoft dependencies.

I have to admit that with the world turning decidedly Apple and Android because
of Mobile and Microsoft missing the boat that the days of Microsoft were
numbered. Surely Linux Desktops would set in and make everything Microsoft did
consumer-facing look unnecessary. Netscape posed a similar threat evolving the
browser to replace the desktop too fast, and was so snuffed. It took Google
with ChromeOS and Android devices getting larger to make Microsoft jump. Even
Steve Ballmer, unenlightened predecessor to Satya Nadella, couldn't stop it.

You should be able to infuse text with power in a generic spell-casting sort of
way.

Anybody should be able to learn and be taught this generic tech system through
the popularly available means that the era and conditions allow. In general, it
should be some sort of screen and keyboard at very minimum. Making it a
touchscreen would be nice with stylus support for drawing would be a big plus.
I like stylus as a machine interface device a lot. Simulating drawing and
buttons seems a natural way to interact with machines.

So I prefer Microsoft hardware over most because of the quality of host
hardware for the money, the sort of guarantee it would work. I like a baseline
level of product quality as nice as the Apple experience, to which I had become
accustomed. I loved the early Macbook Airs, circa 2010, and still have them in
use as quite capable laptops. I don't have time to be a hardware hacker or deal
with driver issues, so Apple appeals to me.

But ironically enough, despite Apple making the move to Unix in 2007, one of
the disadvantages of Apple is it not being Linux. Linux has the big official
software repos, Debian-based, RedHat-based, and seemingly now a
distro-independent snap version. There's contending "App Store" tech for Linux
to get rid of distro-dependent installers like apt, yum and pacman (Debian,
RedHat and Arch, respectively) and just have one "snap install" version that
works across any of them.

And that works. And that's Docker container-driven tech. And it's a small
miracle in and of itself, but it's not what I'm interested in. I'm interested
in making things easy, not harder. I don't think we should have to be of some
supernatural tech-power like Gilfoyle to be everyday effective. No, we should
be able to be of rather average intelligence and ability, and still be able to
automate-away.

# Gilfoyle Quote

"What do I do? System Architecture. Networking and Security. No one in this
 house can touch me on that. But does anyone appreciate that? While you were
busy minoring in gender studies and singing acapella at Sarah Lawrence, I was
getting root access to NSA servers. I was a click away from starting a second
Iranian revolution. I prevent cross site scripting, I monitor for DDoS attacks,
emergency database rollbacks, and faulty transaction handlings. The internet,
heard of it? Transfers half a petabyte of data a minute, do you have any idea
how that happens? All of those YouPorn ones and zeros streaming directly to
your shitty little smart phone day after day. Every dipshit who shits his pants
if he can't get the new dubstep Skrillex remix in under 12 seconds. It's not
magic, it's talent and sweat. People like me ensuring your packets get
delivered unsniffed. So what do I do? I make sure that one bad config on one
key component doesn't bankrupt the entire fucking company. That's what the fuck
I do."

―Gilfoyle, "The Cap Table"

That being said, I like to get my spell-incantations down and enjoy my
spell-casting platform. Like it or not, one of the best starting points for
spell-casting platforms is still Windows. Just go buy a laptop. What are you
going to get. Just go buy a modern game. What type of computer is it for?
Windows won a long time ago, and we're living the repercussions. And those
repercussions are mostly about drivers and economy of scale for game
developers. You need to target a money-spending market that exists for
commercial products. Sorry, that's just the way the world works.

Printer drivers, Bluetooth support or whatever. Windows has it working out of
the box and most Linux distros will leave you device-less. You'll be lucky if
you get your audio working. Leave it to the proprietary folks to sort it all
out. That's what you're paying for, and who cares if that part is Windows,
Linux or Apple. So long as when it comes speaking the standard languages of
tech, there's something there to listen to you and carry out your instructions.
So let Windows be a host to a Windows subsystem, so long as that subsystem is
there and not full of show-stopping gotcha's.

As opposed to Gilfoyle or Mr. Robot who live the glamorous life of some
super-hacker, I myself just struggle to get by as a blue-collar mechanic of
tech. I try to be creative, but it's my mechanical skills that come in great
handy when often carrying out the vision of others. Product-visions are a dime
a dozen. Everyone can have a good idea. It's having the technical skills to
carry it out (and in some ways, think it out properly) are more valuable. Those
are practice-over-time craft skills.

And those have all to a great degree just fallen into place because Linux
systemd. There's a story here that needs to be told and perchance become a
little more mainstream. It's not as sexy as Web development and NodeJS, but it
is sexy in its own way, taking control of that Frankenstein moment of giving
power to hardware and making it come alive... but under your instructions...
because you listened to me here and now and started learning systemd.

It's not hacking. It's Mickeys Sorcerers Apprentice 101. Take control of the
hardware as its being powered on and has not acquired any pre-existing state
except for some immutable nonvolatile boot process that hands off control over
to parts you directly control. How is that not Tech 101? How is it that life
begins at some such-and-such paid-for (eventually) cloud service providers
these days instead of your local and usually quite formidable hardware
resources? No reason, but for lack of knowledge that such a path exists.

Let me show you that path. This is just basic literacy these days. What I'm
showing you having to do with text-based Linux is your birthright as a human
being to the free and open source software licensed specifically so you can
freely use it. Jump on this evolutionary bandwagon in which you run code that
can keep running, maybe forever with some systems we can build here together.

That's not enterprise scaling network hacking tech I'm talking about here. It's
technique and capability of another sort... a basic sort. One that allows us to
automate like Mickey animating the brooms in Sorcerers Apprentice, but done
correctly. We address the issues systematically and in the appropriate sequence
and context to allow folks to jump onboard the spell-casting bandwagon, and do
it right.

That path begins with the certain acceptance of cheap, capable hardware brought
to you in part by unfair trade practices pressuring original equipment
manufacturers (OEM) like Gateway and Dell to only include Microsoft software
as the pre-installed operating systems of all computers they sold (i.e. no
Linux-based laptops) or else they'd get disadvantageous pricing on Microsoft
licences versus other OEM competitors that yielded to Microsoft, ensuring an
industry-lock on pre-installed OS.

That gave us the Microsoft-dominant world we have today, like it or not. Get on
the mainstream or suffer the consequences. We're all jumping on the Linux
bandwagon together here, you of the pure-Linux dogma religions, those of the
Microsoft Windows System for Linux (wsl) path (like me of late), those on
Macintosh who have a pure Unix Terminal which can at least homebrew it from a
community-driven FOSS repo, those on ChromeOS who have a Debian Terminal and
the same apt system as Ubuntu. There's even non-Mac Unix camps out there based
on FreeBSD, derived from ye ole Bell Labs UNIX by Ken Thompson rewrote by Bill
Joy, the same guy as who wrote the precursor to my beloved vim.

You know where much of my need for hardware-love has been displaced to? Python
and vim. The vim/Python combination is awesome, because that's sort of all you
really need... up to a point. If you already really know what you're doing, you
don't need the experimental "feeling around until it works" mode of operating
that JupyterLab provides. The path I advocate takes advantage of the host
environment, be it Windows, Mac or pure Linux Desktop by calling for
JupyerLab-Desktop as a way to gain your Python legs. Even now after being
capable of doing Python development work in vim, I still prefer JupyterLab due
to the wacky-awesome browser-based REPL (read, eval, print-loop) time-freezing
environment that is the iPython project for humans.

Did I lose you? Sorry, things got awesome with JupyterLab-Desktop and the world
hardly knows. It's the on-ramp to the Linux, Python, vim & git future-proofing
I advocate, without the steep initial learning curve of vim. Still learn vim.
Just learn Python through JupyterLab, and then keep it always-open as a sort of
calculator with wonderful copy/paste capabilities. Copy/paste your working
Python code into a .py-file. In the future, learn how to do that automatically
from a magic fairydust-sprinkled Jupyter Notebook, using the pip-installable
nbdev framework. Yuck, frameworks. Okay, I'll take the nbdev one. The benefits
are just too great.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/you-get-blinded-by-the-hardware/">You Get Blinded By The Hardware</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/use-python-decorators-for-linux-service-scheduling/">Use Python Decorators For Linux Service Scheduling</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/qnap/'>QNAP</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li></ul>