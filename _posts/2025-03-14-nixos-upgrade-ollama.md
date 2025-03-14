---
title: "NixOS Upgrade to Ollama 0.6.0: A Clean Rebuild Experience"
permalink: /futureproof/nixos-upgrade-ollama/
description: Alright, so I just upgraded my NixOS system to get the latest Ollama, and it's a bit of an adventure! Basically, NixOS rebuilds your entire system from scratch with each upgrade, ensuring a clean, consistent setup. It's like a fresh install every time, thanks to its unique flat file-system. While it takes longer than a typical update, the stability and rollback capabilities are totally worth it, avoiding the usual cruft and dependency issues. Plus, I got to write this whole article while waiting for the rebuild!
layout: post
sort_order: 1
---

## Upgrading NixOS for Ollama 0.6.0

Alright, merely a day or two after Gemma 3 was released and Ollama was upgraded
to version 0.6.0 to support it, the newest did hit the Nix repo, so it's time
to:

    sudo nixos-rebuild switch --upgrade

Now unlike `sudo apt update && sudo apt upgrade`, this is going to do a pretty
intensive rebuild of your system. That's because NixOS is deterministic and
isn't going to pollute your system with old versions. In essence, it's like
rebuilding your system from scratch with a fresh install, but with all the new
versions. Now the way `/nix/store` works, all the old versions are technically
still on your storage device taking up space, but only un-linked. 

![NixOS Upgrade Ollama](/images/nixos-upgrad-ollama.png)

## Understanding the Nix File System Architecture

For the nix uninitiated, the miracles of this system are pulled off by forsaking
the traditional hierarchical file system (HFS) for a flat one. That flat
data-store is a drive partition that's mounted on any system using nix called
`/nix/store`. And then every single thing is stored in there as if a flat
file-system, using unique hashes on each thing. Then a bunch of links are made
to these flat locations building a "virtual" HFS, maintaining general Linux
compatibility. However under the covers, OS stuff is inviolate and immutable.
That's a fancy way of saying nothing can read or write to your OS.

## Why Choose a Deterministic System?

Now, why would anyone do this? Isn't it that magic cocktail mix of installing
this and that, which all blends together into a just-so working system? That
fragile ecosystem of installs that barely gets your system running, accumulates
cruft over time, and drives you to cloud services to keep you from polluting
your core system... oh, wait. Yeah, that's why people would use it.

## The Evolution of System Isolation

### The Virtual Machine Era

So to fix this problem before the cloud came along, people were generally driven
to virtual machines (VMs) like VMWare, VirtualBox, QEMU and the like in order to
isolate all those installs from the machine's true host bare-metal OS install.
There was this notion of keeping your first-level OS clean and pure and
everything else bottled-up inside a VM. But then you had twice the OS, twice the
memory and resource consumption and twice the software surface area. And that's
just for the first VM, not counting all the overhead it takes to get it running.

### The Rise of Containers

Along came containers like Docker, and VMs became slightly more efficient.
Instead of twice everything, host OS resources (the kernel) were recycled over
the each container instance. Technically, also along came hardware-level VM
support called hypervisor on Intel hardware with Windows. Both VMs and
containers became mainstream. But it didn't solve the essential problem that you
were still using whole OSes to keep willy nilly installs isolated. It's not just
the resource bloat, but it's also the cognitive overhead.

### The Cloud Solution and Its Drawbacks

And so the cloud. Nothing has to be on your local machine incurring all that
headache if you just use other people's computers. This has the added advantage
that you can switch from machine to machine and still have all your stuff, with
just a login. But do you really still have all your stuff? Isn't there things
installed on your true main machine that doesn't travel with you? Then there's
the fact you have an online connection dependency. And you're probably paying a
bunch of subscription services for the ability. Oh, and then there's the privacy
issue. There is no cloud -- only other people's computers.

## The Nix Solution: Building from Text

And so... and so... VMs, containers and the cloud all have their fatal flaws.
There ought to be a better way. And so there is! It comes from your host machine
never having cruft from willy nilly installs.

The correct solution comes from building your entire system from a text-file
that defines your entire system. Each time you rebuild your system, it is as if
it's a fresh install of every single component on a newly wiped and formatted
hard drive. There's no conflicting dependencies from overlapping installs from
the past. There's no more accumulation of unnecessary and intended to be
temporary software on your host OS. And there's no juggling of massive docker
images and virtual machines.

## Managing Personal Data in NixOS

But what about your data files? The stuff in your "home" directory? And how
about temporary installs? Trying out new software?

Nix leaves your `/home` files alone on a system rebuild. You'll need a separate
backup system for things that aren't part of the system and apps (i.e. your
data). It's really this way anyway in most cases. You treat and handle your own
personal data differently than your OS and app installs. I know it doesn't feel
that way to a lot of people because of iPhone sandbox bundling of app data with
installs on iOS. But in like 99% of desktop/laptop use, you're going to have one
place for your data and another place for your apps.

## Understanding NixOS System Updates

System rebuilds under Nix are remarkably faster than you might think, because
all your previous software is sitting there in the `/nix/store` already. So when
you add new software, either for a system rebuild or for temporarily trying out
new software, it drops the new stuff into the `/nix/store` and just rebuilds the
links that change the nix flat file-system into the Linux HFS, making everything
available. It's really fast. But it doesn't give you new versions of your old
stuff. In other words, installing new software doesn't also do a system upgrade
of your old software.

### The Evolution of Update Commands

So when starting out with NixOS, it is not uncommon to be stuck on old versions
for a very long time without realizing it or doing the big upgrade. For people
familiar with Debian or Ubuntu, this would be the equivalent of doing a lot of:

    apt install [package name]

...without occasionally doing:

    apt update
    apt upgrade

In NixOS, there used to be this very common practice of updating your "channel",
which was the equivalent of an `apt update`:

   nix-channel --update

...but it's not really necessary anymore, because the `--upgrade` switch has
been added to the `nixos-rebuild` command. It's not the most straight forward
thing in the world because there's a weird hyphenated command, followed by a
sub-command, followed by a flag or switch. But on the positive side, it's just
one command and it will go into your habits and muscle memory easily, because
it's exactly the same every time. This is the NixOS equivalent to `apt update &&
apt upgrade`:

    sudo nixos-rebuild switch --upgrade

## System Safety and Rollbacks

And when new software is released like recently with Ollama going from 0.5.13 to
0.6.0 and you just want to get it, it's a good time to just upgrade your entire
NixOS system with that command.

Terrifying? Don't worry. Another benefit of NixOS is that rollback to prior
states of your system is as simple as just selecting an older version (called
derivations in Nix nomenclature) from the boot menu.

## Understanding Nix's Flat File System

Why this works takes a little bit to wrap your mind around. Nix is a flat
file-system with links tying it together into a virtual hierarchical file
system. So doing that over and over with different variations will build
different systems. Your most recent derivation (as they're called) is your most
recent system. But you can go back in time to older and older systems, to the
capacity of your hard drive.

### Comparing Traditional vs Nix File Systems

True hierarchical file systems on the other hand are a soupy cocktail mix of
installs, with infinite variations and subtleties. It's a completely unique
state based on the order in which thing were installed and upgraded. Sure it's
working, but what about when things go wrong? Rolling back takes complete system
backup and recovery. Sure, you can try uninstalling things, but you never know.
Hierarchical file systems are in other words, non-deterministic. You need luck.

Deterministic file-systems like NixOS on the other hand, follow a declarative
system build as defined from a single text-file, which more or less works the
same way every time. Now of course there are edge cases, and when you switch
hardware, things do need to be tweaked. But in general, NixOS removes all the
headache of needing luck, and even virtual machines and containers to go
hog-wild trying stuff out while never destabilizing your system.

## Conclusion: The Time Cost of Determinism

And so today, that's what I did. But as I started this article out stating, a
NixOS update where you also upgrade all your software is like building your
system from scratch. So just to go from Ollama 0.5.13 to Ollama 0.6.0 (to run
Gemma 3), I was able to write this whole article waiting for the build, haha!

## To Reboot Or Not To Reboot?

After one of these long NixOS system upgrades, there's some stuff that's not
going to be active until after a real hard reboot, because of recompiled drivers
and such. But nonetheless, before restarting my machine, I decided to:

    ollama --version

...and got the 0.6.0 version reported successfully! Also I ran the model (which
I previously pulled with `ollama pull gemma3` (which pulls the 4b version by
default) only to realize 0.5.13 didn't support it yet. But this time:

    ollama run gemma3

...resulted in the screenshot you see at the top of the article. Great success!

---

## Gemini's Take

**Title and Headline Ideas:**

* **Titles:**
    * NixOS: My Fresh Start with Every Upgrade
    * Ollama 0.6.0 and the Power of NixOS Rebuilds
    * Ditching Cruft: Why I Love NixOS's System Upgrades
* **Headlines:**
    * NixOS Upgrade: A Deep Dive into Deterministic Systems
    * Say Goodbye to Dependency Hell: My NixOS Upgrade Experience
    * Why I Rebuild My Entire OS for a Simple Software Update

**AI Opinion:**

This article provides a really clear and insightful explanation of the benefits and quirks of NixOS. I appreciate how the author breaks down complex concepts like deterministic file systems and system rebuilds into easy-to-understand terms. The comparison to traditional operating systems and virtual machines effectively highlights the advantages of NixOS's approach. The honest portrayal of the lengthy rebuild process adds a relatable touch. Overall, it's a valuable resource for anyone interested in exploring alternative operating systems and understanding the principles of system immutability.

