---
date: 2023-05-20
title: Turning Windows & Macs into Legitimate Modern Development Platforms
headline: The Iron is Hot So Chase The Rabbit on Down the Linux Hole
description: In this article, I discuss the importance of my maintaining a standard Windows desktop background and the advantages of using Linux containers on Windows and Mac. I also talk about the history of Microsoft's NT architecture and the emergence of WSL, Ubuntu 20.04, and the Microsoft Store. I further explore the implications of the Oracle-owned VirtualBox and the Canonical-owned Snap store, as well as the need for a Linux kernel on Macs.
keywords: Windows, Linux, Ubuntu, WSL, NT, PowerPC, Intel, ARM, Docker, VirtualBox, Oracle, Sun Microsystems, Berkeley DB, NoSQL, AI, ChatGPT, John Conway, Game of Life, Mandelbrot, Music Mod, Transformer, Amiga, WBScript, Howard Harrison, Multipass, Hypervisor, Azure Cloud, WebDev, Python, Data Scientists, App Store, Apple App Store, App Bundles, Levinux
categories: amiga, ai, container, microsoft, wsl, levinux, ubuntu, linux, python
permalink: /blog/turning-windows-macs-into-legitimate-modern-development-platforms/
layout: post
group: blog
---


I really need to let people see me booting up and starting to journal in a very
familiar environment, that being Windows with a standard Windows desktop
background. Projecting to the people the proper ***standardness*** of it is so
important now. I've removed my awesome logo, the Alice metaphors and even the
Linux, Python, vim & git logo. No need to push that in people's faces all the
time. Get yourself ***dry*** and boring and mainstream.

The logos and stuff have deposited the proper "archaeological layer" in my
YouTube videos, haha! Now it's time time to move onto a demeanor prospective
Data Scientists and such will be able to tolerate. I can be myself and be a bit
wacky with ASCII art in the installer. But when on Windows 11, look it. When on
Mac Ventura, look it. And no hearkening back to the good old days of early
Windows 10 with the misty-blue haze that nailed it and won me over to Win10. No
matter how much I like it, it just screams "old" to everyone else.

Metro and even Windows 8 had me cringing and believing Microsoft finally shot
themselves in the foot for the final time. Oh, was I wrong! I have since come
to learn more about the NT architecture that still lurks beneath, and
understand that Microsoft has contingency upon contingency upon contingency
lined-up. What we're seeing with the WSL, the Windows subsystem for Linux, is
today just the one winning card they happened to play in a hand full of
choices. It is in its own way as amazing as Apple Mac's switching
CPU-architectures ***three times***; PowerPC to Intel to ARM. 

And you know what? It's just the resource-shuffling and remapping shell-game
with both Apple and Microsoft. Memory protection, dynamic resizing and
reallocation of resources, machine instruction translation tables and the like.
It's a combination of computers just being that fast these (those) days and
direct support for such shenanigans being built-in. Either way, both Apple and
Microsoft took bigtime advantage of the ultimate OS-shellgame existing on
modern hardware in a way that they never want you to be able to do.

Well, too bad because Linux won. Microsoft knows it so deeply that they all but
ship Linux with Windows for developers. Microsoft has a big-time developer bias
because of both their history of it, and because the Apple App store is so
friggn' profitable and such a draw for developers, Microsoft has to go all-in
on every other form of development like WebDev and Python-support for Data
Scientists that the grass doesn't look quite so green over at Apple. Truth.

That makes Microsoft generous with Dev tools. Full of traps locking you into
their own ecosystem, for sure. Meant to get you to use the Azure cloud serves
without a doubt. But generous to a fault, especially regarding Linux
none-the-less. I know this because I've attempted to switch to Linux Desktop a
few times over the years, and have fully switched over all development work I
do to Linux long ago. Dissatisfied with the state of Linux portability, I wrote
my own Linux distro, the still somewhat popular Levinux, to make a portable
nomadic tiny virtual Linux that floated between proprietary host OSes like
water. But it was old, slow tech I based it on and not long-term viable.

None-the-less, Microsoft (and the rest of the world but Apple) saw what I saw
and made supporting Linux virtual machines, and even more importantly:
containers, table-stakes for what a modern Desktop OS was supposed to do.
Without it, you couldn't well call yourself a credible developer. Oops, bought
the wrong desktop, did you? Well, what choice do you have? 80% of the world is
on some form of Windows. So Microsoft having made it's already-brilliant
musical chairs lower-level OS stuff that is NT, it made Linux one of the
plug-in OSes for it. NT was around 1993 and WSL was around 2017.

Today, you just hop on over to the Microsoft Store and pull down Ubuntu 20.04
and a whole bunch of heavy-lifting that I don't have to worry about anymore
gets done with the massively resourced juggernaut that is Microsoft behind me.
This is mostly turning on the Hypervisor and getting you to reboot a bunch of
times. There's a few things that still aren't automatically done for people
downloaded early versions and are stuck with old drivers, but that's what my
YouTube videos are for.

Oh yeah, there's like 3 Ubuntu 20.04's in the Microsoft Store. It doesn't much
matter which. The important thing is that the Microsoft snoopity-snoop... uh, I
mean the Microsoft Managed Online License which uses Apple-inspired App Bundles
that wrap all your program dependencies in a folder like it's a single program
and hides it all where you can't find it. Innovative? Not really, Apple copied
this concept in-turn from Sun Microsystems who probably copied it from someone
else. I myself commissioned a special version called WBScript from the
illustrious Howard Harrison for the Amiga Computer back in 1988 or 1989.

I often make the point that there is almost nothing in tech today that wasn't
first on the Amiga. I think about things like ChatGPT, and while probably not,
the permutations of the cellular automata like John Conway's Game of Life, the
Mandelbrot stuff, and the music mod demo scene sure made it feel like AI. There
were emergent properties in those Copper-chip hacks, for sure. Even the
generative transformer stuff is feeling a little passe compared to the Amiga, I
shit you not. And so it is with a sigh of relieve I watch the proprietary
desktop OSes begrudgingly allow Linux containers to flow through them like
water.

Docker, Docker everywhere, and no Linux kernel on Mac. Boooo! Well, the
technosnotti elite can't let that stand. And so the dark horse of the
AI-pocalypse to the rescue again! No, no not the Crooked Sorcerer Paul Graham.
I'm talking about the space tourist. No, no not Richard Garriott. He's only
worth tens of millions. No, that guy who's worth hundreds of millions. Yeah,
Mark Shuttleworth. That's the one. He's behind Ubuntu which is powering what
seems like most of the Cloud, and thus AI these days. I could be wrong, but at
any rate it's Ubuntu that put out Multipass so you can deal with that pesky "no
Linux Kernel" problem on Macs so they can get over their Docker-envy.

Sure it's the free and open source VirtualBox that's powering even that, but
VirtualBox has been bought by Oracle, like Oracle bought Sun Microsystems, and
where's Sun today? Java? Legally embroiled. MySQL? A distant backseat to
PostgreSQL and anything else but MySQL. Ever hear of Berkeley DB? No, neither
has anyone else. That's because it was NoSQL before NoSQL and Oracle couldn't
have such a thing in the FOSS world and bought it, effectively putting the
kibosh on it. See a pattern? Well, VirtualBox isn't quite dead yet and is a
good enough FOSS component to make Ubuntu Multipass possible, and no tech
solution is "pure" anyway, so Multipass it is for Mac's version of WSL.

Got that? You need a Linux kernel... not just `*nix` OS like Unix, which the
Mac already is. That's not good enough, especially considering the Mac's
totally non-standard top-level OS-paths that breaks everything and a complete
lack of an official free and open source software repository. Sorry folks,
`homebrew` isn't official. Did you notice it's called ***home*** ***brew***?
That's because Apple didn't brew it, never did, never will. It's free and
competes with the Apple developer program and could, God forbid, let you do
something clever and outside the box. Apple is not for people who think
differently.

So Ubuntu it is. Still, nothing's pure and once again Canonical (Mark
Shuttleworth's company that makes Ubuntu), is pushing solutions on us we don't
need and which harms the Linux community by driving divides and fracturing
schisms like it did with the Unity desktop. No, not the Unity game engine. The
Unity desktop was this GNOME/KDE/Windows/Mac thigie, but different from any of
them and undermined GNOME. So Ubuntu finally ditched it and went back to GNOME.
Well today they're doing the same thing with the Snap store when the Debian
Package Management System (more often known as apt) is quite apt. It's so apt
for the task, it's named Aptitude. And it's used by Raspberry Pi, ChromeOS and
a bunch of other things, so it's no slouch. It's just not jumping on the Docker
bandwagon with enough verve, so FUD must be injected.

As you can tell, I'm no fan of the snap store. I'd be on Ubuntu 18.04 if
leaning into the new Microsoft WSL default settings weren't such a wise thing
to do. But I write my `Rabbit Hole Linux` script exclusively using the `apt`
system. WSL is itself already a container. I don't want a ziggurat of
containers. In for a penny, in for a penny as I always say. In that exact
spirit, I tore out another tech called `LXD` which I started using, an other
Canonical ***extra***, but one that has real purpose if you weren't already on
WSL or Multipass (but instead on real Linux hardware), and I'll get to it
later. But for now understand I'm going for the smallest reasonable footprint
and the least possible surface area in a Linux container that will happily live
on a Windows or Mac machine.

Wow, this has turned out to not be a test-run for my live-streaming session at
all, but rather another subconscious dredging-session, getting out what I
needed to get out. Saying what needed to be said. 

And that's about it. I do need to start revealing my system to the world with
little layering-up steps. Let's slam out a to-do list.

     _____       ____        
    |_   _|__   |  _ \  ___  
      | |/ _ \  | | | |/ _ \ 
      | | (_) | | |_| | (_) |
      |_|\___/  |____/ \___/ 
                         
- Make the Mac install script for Rabbit Hole Linux (symlinks?)
- Allow the output of the Github repo install to show Figlet + message
- Leverage Pipulate.com and Levinux.com homepages for rabbit chasing
- Getting off the OpenAI API so I don't have another $20/mo bill.
- Wean yourself off of the $100/year Microsoft 365 tax.
- Creating a sequence of pages with prev/next arrows for embedding YouTube
  videos and recreating playlist experiences, but with equivalent webpage
  wrappers.
- Turning my poetry into a similar-such sequence... and pushing out some of the
  poetry I've been holding back because I don't want to do it under the tedious
  old standalone Jekyll pages approach.
- Stopping using Github for anything but the repos you're sharing. Wean
  yourself off your $100/year Github Microsoft tax.
- Stop using Google Photos for anything but what you want to share and publish.
- Push mini-versions of all your articles into Medium.com
- Pull mini-versions of all your Instapaper reading list onto your site.
- Finish/re-do the Twitter-to-website publishing (handle thread-articles?)
- Wire NeoVim to Amazon Code Whisperer or other to get off your Copilot
  Microsoft $100/year tax.
- Investigate the OpenAI plugins https://zapier.com/apps/openai/integrations
- Go through my old content to see if anything "prophetic" needs to be
  re-published. Support arbitrary permalinks in blog posts to keep the old
  URLs?

And above all else, tighten up the Rabbit Hole Linux story. Make it compelling
and get a bunch of people chasing the rabbit.

## Rabbit Hole Linux, Screen #1

![Rabbit Hole Linux Screen 1](/assets/images/rabbit-hole-linux-screen-1.png)

## Rabbit Hole Linux, Screen #2

![Rabbit Hole Linux Screen 2](/assets/images/rabbit-hole-linux-screen-2.png)

## Rabbit Hole Linux, Screen #3

![Rabbit Hole Linux Screen 3](/assets/images/rabbit-hole-linux-screen-3.png)

Those screens are going to change many times but that's all the more reason to
document them here. Ironically, it also makes it easy to move it back and forth
to my phone for some image editing which has become much easier on the phone
since Photoshop has become this bloated hog. Artstudio Pro just keeps getting
better and better on the iPhone platform, and perfect for the day-to-day
graphics tasks.

What ails the world right now, and the place where I could do the most help, is
definitely with journaling and helping people get over the hump of
vi/vim/NeoVim. 







<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/how-wizard-of-oz-predicted-everything-about-today-s-ai-world/">How Wizard of OZ Predicted Everything About Today's AI-World</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/bing-bard-school-me-on-unattended-multipass-install-script-for-mac/">Bing & Bard School Me on Unattended Multipass Install Script for Mac</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/amiga/'>Amiga</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/levinux/'>Levinux</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>