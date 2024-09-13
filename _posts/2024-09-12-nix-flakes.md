---
title: Getting Started with Nix Flakes
permalink: /nix-flakes/
description: Fill in
layout: post
---

## Getting Started with Nix Flakes

I'm just starting to grok nix. I discovered NixOS some months ago, and
recognized kindred spirit. Some 15 years ago, I stared a project called Levinux
that tried to make a completely portable minimum Linux system for through the
ages that would play host to such roles as my main development system and home
of a private journal. But I based it on ye old emulator, QEMU, and it lacked
performance and viability as a main day-to-day platform. Both virtual machines
and containers have disappointed me too. 

But a language exits for you to deterministically define a whole system with a
text file? It'd be like a bash file that does a whole bunch of sequential apt
installs without version issues because everything's pinned. In such a scenario,
you can just rebuild a system anytime, anywhere and on almost anything. Hardware
changes. Platforms change. But a phantom system can cut through it all in time
and space by nixing all those versioning issues of Unix/Linux, or Unix-like, or
sometimes *nix, or just nix. 

What a brilliant name for a brilliant system. I would have preferred if it was
just Python, somehow. But as it is, it's related to Haskell as far as syntax,
which means it's yet another curly brace language, but even weirder. It's going
to take some polyglotism that ain't really in me. I'm a confirmed monoglot. I
speak English-only, in terms of spoken languages, and I speak Python only when I
can help it, in machine terms. Much doesn't fit my head. Python does, just
barely. Taking on learning this system configuration language is a challenge for
me, but one that is worth it.

Okay, the last piece here is whether it's as long-living as other important
fundamental tech I've taken up.

But it should be proven, free and open source, and
fairly well set in for it not to be a fringe platform.

sudo nixos-rebuild switch --flake /home/mike/nixos-config#nixos


