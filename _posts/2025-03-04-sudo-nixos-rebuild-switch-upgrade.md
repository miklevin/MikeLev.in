---
title: sudo nixos-rebuild switch --upgrade
permalink: /futureproof/sudo-nixos-rebuild-switch-upgrade/
description: "I've transitioned to NixOS, a game-changing OS powered by the Nix package manager, and I'm sharing my experience. Ditching the familiar worlds of Mac and Windows, I dove into Nix's deterministic system configurations, which solve the classic 'it works on my machine' headache. Learn about the essential sudo nixos-rebuild switch --upgrade command for seamless updates and explore how NixOS embodies 'Infrastructure as Code' through its configuration.nix file. I break down the Nix command structure, explaining subcommands and switches, and reveal why I believe NixOS is the future of portable and reliable software development."
layout: post
sort_order: 1
---

## My Journey from Mac, Windows (and Amiga) to NixOS

I am on NixOS now (at home), and a Macbook when using the office-provided
computer. So I'm keeping myself grounded in the proprietary world that the tech
elites are gaga about -- the Apple ecosystem, and admittedly awesome hardware.

## The Revolutionary Impact of Nix Package Management

However, as much as I possibly can I am no NixOS, the OS that's built from the
nix deterministic system configuration tool. Nix is changing the world, and
nobody knows it. Even the validation of this is undercurrent that nobody will
recognize. The great and awesome GNU Project, those folks who turn Linux
Torvald's low-level driver stuff into full-fledged Linux have copied nix in the
form of guix. It's not as developed yet especially in its macOS support, but it
is not only validation of this world-changing tech, but also a way to hedge your
bet by having an alternative to nix, because translators (probably AI-powered)
will surely let us switch between the two. 

### Solving the Universal Developer Problem

Bottom line: VMs and containers are no longer really necessary for most use
cases to build containerized systems. And the new way is better because it's
deterministic, meaning it builds the exact same way every time with everything
pinned to versions and local resources caches that will work now and forever
into the future. Even more simply put, it solves the "it doesn't work on my
machine" problem. And it's been around for years and is a mature solution and
has been copied and validated by the people who make the official Linux
commands. Further validation comes from companies like Lucky Palmer's military
defense company, Anduril, that's known to use it, and countless others who don't
advertise it so much but use nix as a secret weapon.

### Understanding the Nix Command

In a nutshell the `nix` command is a tool for defining and building
environments. It can be used to build environments under Windows (using WSL) or
under Macs (native). It can also be used to build the entire OS, and that's what
NixOS is -- a whole OS built from nix, which just happens to be Linux. Yes, this
sounds a lot like VMs (virtual machines) and containers (Docker), but it's not.
It's just plopping what you need into a flat hashed store on your hard drive and
having a bunch of links assemble it into a standard conventional Linux subsystem
that seems to work out of a subfolder on your Mac or Windows computer.
Technically, also on any Linux distro from a subfolder, or AS the Linux distro
itself (which is called nixOS).

### From Levinux to NixOS: A Personal Evolution

So, I've been on Linux on and off throughout the years, even making my own
respin of an incredibly tiny version (Tiny Core Linux) called Levinux. So I'm no
stranger to the wacky premise of this whole nix arrangement. We were both
scratching similar itches, but Levinux turned out to be a little toy intro to
Linux that used old reliable QEMU (the PC emulator Android uses) binaries. Nix
on the other hand turned out to be a tour de force, redefining software
development and code portability. In many ways, it is the ultimate realization
of the software portability dream of Unix, the granddaddy OS from which Linux
was derived. Nix is the solid alternative to VMs and containers that I've been
waiting for, and I'm all-in.

## The Daily Habits of NixOS Users

Okay, so the daily habits of being on NixOS are a bit different, and that leads
me to the onus for this article. It's the really simple things, like finding the
replacement for:

```bash
sudo apt-get update
sudo apt-get upgrade
```

This is the command on the popular Debian-based derivative of Linuxes that
includes Ubuntu which first updates the local directory of available software in
the distro's cloud-based software repository. The second is the command to
upgrade all your installed software ***using the updated repo data***. It's
something Debian/Ubuntu users do all the time to keep their systems updated and
secure. Some folks these days know the abbreviated version:

```bash
sudo apt update && apt upgrade
```

...which does both at once. It gets into your fingers as a sort of habit and you
just know to do it like applying system patches on Windows every once in awhile.
And it's hard to make the switch to a new Linux distro, especially one as wacky
as NixOS. And I find myself having to look up the command all the time, as
simple as it is:

```bash
sudo nixos-rebuild switch --upgrade
```

And that's it! It's merely one `--upgrade` switch longer than the much more
common nix command:

```bash
sudo nixos-rebuild switch
```

## Longer Build Times with --upgrade

For anyone forging this most righteous and worthwhile path, be warned that this
nixos-rebuild command with the `--upgrade` switch command does quite a bit more
than the Debain/Ubuntu `apt-upgrade` command, and be ready for a wait of
anywhere from a half-hour to 2-hours depending on how long it's been since you
last did it. It's deterministic, remember? So many parts effectively get rebuilt
from source! And if you've got a lot of CUDA libraries and other things that are
always changing, it's going to rebuild it all, optimized for your hardware of
course, so it's totally worth it. 

### Upgrade Strategy and Rollback Safety

So my advice is just get used to throwing the `--upgrade` switch at the end of
your "normal" system rebuilds for adding/removing software packages every once
in awhile, so the change don't accumulate up. And because it's deterministic and
rollbacks are super-easy at startup, if things go wrong with versions, drivers
or whatever, you just choose your prior state at the boot menu! I can't describe
to you how game-changing the nix way is.

## The Core of NixOS: Configuration as Code

...which is the standard "rebuild" that Nix people do all the time when they
edit their `configuration.nix` file that defines their entire system. That's
right. Your whole system is defined by a single file. Keep it in a git repo or a
USB keychain, and you'll never be without your tweaked-out system again! Some
folks call this ***Infrastructure as Code*** or IaC. Nix is the ultimate Iac.
One text-file spell casts your entire system into existence. No giant VM or
container file to lug around. No vulnerability to base-images changing at the
Docker or LXD hubs. Just deterministic text-file system-building goodness.

## Hardware Configuration: The Automatic Component

Of course, the whole story is a bit longer. A second file called
`hardware-configuration.nix` is created automatically because not all hardware
is created equally. But it's created automatically by nix interrogating your
system and plopping it next to the main configuration file, and you never have
to touch or edit it. If you delete it, it gets generated again. So really only
the main file is needed to define your entire system.

## Advanced Configuration: Modules and Flakes

And the story gets deeper the more you look, but they're not gotcha's. They're
options! If you don't want your entire system defined in a single file, you can
use external text-files called modules and call them from `configuration.nix`.
Or you can use cross-platform distributable version of these modules called Nix
flakes (`flake.nix` files), which is designed to conveniently work with git so
that a git repo effectively becomes a unit of IaC (infrastructure as code). Put
simply, a git repo can carry everything around with it that it needs to run in
the form of a single text-file that defines it.

### The Philosophy of Flakes and System Organization

The nix story goes deeper and deeper. These nix flakes are not only modules from
which you can build your main system, thus managing any complexity that creeps
into your big `configuration.nix`, but it really is like chipping off flakes
from the motherstone or lithic core of your system. Hmm. How to explain? If you
are a purist about it, you can define only those things you plan on using
forever-forward in life as tools, like `vim`, `git` and such and put it in your
`configuration.nix` file, but break off things you might like to distribute to
other people like any project you keep in a GitHub repo, or even other
developer-like environments like graphic design stuff that might have GIMP,
InkScape, Davinci Resolve and stuff.

## Gaming and Software Compatibility

And so, the whole question of which Linux distro to use just goes away. Yes, it
can run Steam and the other engines that are increasing in popularity. Yes, it
can run Wine and the Bottles for running your Windows games (or office
software), and if you really want to, it can run Flatpack and Docker to get
anything you have difficulty with otherwise, but that starts to defeat the
"deterministic" purpose. Remember, nix lets you not be forced into the weak
position of ***having to use Docker and Flatpack*** because the parent system
sucks. When you get determinism in your OS, you also get pristine uninstalls and
almost total lack of system cruft and pollution and dependency conflicts and
path hell building up over time.

## Cross-Platform Development and Nix's Advantage

Nix is as if Linux suddenly became a generic subsystem of both Mac and Windows,
the same way the JavaScript engines are a subsystem through your browser, but
way more powerful because it has all the power of full Linux plus access to your
full local system. So from a developer standpoint, it's a dream. Another
technology out there tries to leverage the cross-OS capabilities of the browser
for much this same purpose, called Electron. But Electron bundles-in and relies
on and limits you to the Chromium browser (the non-proprietary version of Google
Chrome) and a webserver called NodeJS. So all your development work has to be in
JavaScript for node, and then has many browser sandbox limits on top of that.
With nix, your code becomes similarly portable but with a vast software
repository for free, all the power of Linux and full access to your local
machine for building powerful apps.

## Understanding the Nix Triangle

Sometimes people draw a triangle to explain what Nix is. It's a Domain-Specific
Language (DSL) for the declarative system configuration and package management
part. It happens to look like Haskell, for what that's worth. Nix's competition
from the GNU Project, Guix (pronounced Geeks), is based on LISP-like Scheme,
much more popular in the world than Haskell, for what that's worth. I believe
that Guix will eventually catch up with Nix, but that's good. It means you have
two portable declarative deterministic code execution environments to use as an
alternative to VirtualBox, VMWare, Docker, or whatever is your VM/container
poison. And surely LLMs will be able to translate between Nix and Guix before
long, so two paths to bloatware-independence.

### The Three Pillars: DSL, Package Manager, and OS

Oh yeah, the other two points of the triangle describing what Nix is are OS and
package manager. DSL for Domain-Specific Language is one point, used for
defining your system in text-files. But of course the thing you define needs to
be able to pull the actual software from somewhere, and that's the package
manager part. It greatly leverages GitHub for this, but it could be anything.
Once it grabs something, it puts it into a local cache or store, which you could
back up somewhere, so theoretically your versions are pinned forever into the
future. Your ability to run your own software can never be taken away from you
because base Docker images in some hub have changed or gone away. This repo
aspect of Nix can loosely be compared to `apt-get` (or just `apt`) in
Debian/Ubuntu or `yum` (often now, `dnf`) on RedHat distros, or `pacman` from
Arch. 

## The Optional Nature of NixOS

We talked about the OS corner of the triangle already. So Nix is a language for
describing and defining Linux systems (and Windows/Mac subsystems), the software
repository system for building those systems/subsystems from their sources from
around the Internet, and an optional OS that you can build from scratch using
those two parts, called NixOS. I cannot emphasize enough that the NixOS part of
this, ***actually being based on Linux***, ***is optional!*** It is very easy to
just use the `nix` command through your whole developer career (or nix-app-using
career -- more on that soon) without ever even thinking about Linux. Nix can be
just some command, like the Mac Homebrew `brew` command. In fact, Nix is a lot
like Homebrew, but perfected -- and can even optionally use `brew` like it can
anything else, though such flakes stop being portable, of course.

## Wrapping Up: The Command Structure

So this article ended up being a general overview of Nix and NixOS. I only
really intended for it to be a reminder to myself about the `--upgrade` switch
after the word `switch`, which is not a switch but rather a subcommand, haha!

### Command Inconsistencies

Yes, there are inconsistencies in the nix commands. Specifically, there are
all these different hyphenated commands, like:

1. nix
2. nixos-rebuild
3. nix-env
4. nix-shell
5. nix-build
6. nix-channel
7. nix-collect-garbage
8. nix-store
9. nix-instantiate
10. nix-copy
11. nix-hash
12. nix-prefetch-url
13. nix-repl
14. nix-daemon
15. nixos-option
16. nix-profile

Now a certain number of these have non-hyphenated subcommands, which you would
think are switches but are not, including the incredibly important and popular
`nixos-rebuild switch`, which actually uses the word `switch` but is not one,
yet has a very important switch often used after it, `--upgrade`. And so all
that is challenging for me to wrap my head around. Here's some other common
subcommands:

1. nix
   - build
   - develop
   - flake show

2. nixos-rebuild
   - switch
   - boot
   - test

But wait, there's more! Not only do we have subcommands that aren't switches,
but we *also* have actual switches... and they mostly use the double-hyphen
syntax. Think of them as modifiers to the command or subcommand you're running.
Some of the *most* common ones include:

*   `--help`:  Stuck?  `--help` is your friend.  Append it to almost any Nix command (or subcommand) to get a quick rundown of its purpose and available options.  `nixos-rebuild switch --help` will tell you all about the available switches for the `switch` subcommand, for example.
*   `--version`: Need to know what version of Nix you're running? Use `--version`.
*   `--verbose`: Sometimes things aren't working, and you want *more* information. `--verbose` cranks up the output, giving you a more detailed view of what's happening under the hood.
*   `--update`:  Especially relevant when dealing with channels.  `nix-channel --update` pulls down the latest package definitions.
*   `--upgrade`: As we've already established, this one is crucial for keeping your system up-to-date with `nixos-rebuild switch --upgrade`.
*   `--show-trace`: When things go *really* wrong, and you get cryptic error messages, `--show-trace` can be a lifesaver. It provides a stack trace, helping you pinpoint the source of the problem.

## Understanding How Switches Modify Commands

The important thing to remember is that these switches *modify* the behavior of
the *command or subcommand*. So `nixos-rebuild switch` does one thing, and
`nixos-rebuild switch --upgrade` does something slightly different (but
crucially important!).

### Breaking Down the Command Structure 

The key is to think of it this way: `nixos-rebuild` is the program you're
running, `switch` is *what* you're telling it to do, and `--upgrade` is *how*
you want it to do it.

### Embracing the Learning Curve

And yes, it's a bit of a hodgepodge of syntax styles. But once you get the hang
of it (and remember to use `--help`!), it becomes manageable. And the power and
reproducibility that Nix provides is well worth the occasional syntax
head-scratcher.

---

## Gemini's Summary

> Per my usual process, I have Google Gemini read and summarize my articles,
> helping me write a description, alternative titles and possible headlines, as
> well as telling me what it thinks about it in general.

As the author, I've found a new home in NixOS, a revolutionary operating system built on the deterministic Nix package manager. This article is my journey from traditional OS environments to NixOS, highlighting its power to solve the "it works on my machine" problem through reproducible builds. I detail the essential command `sudo nixos-rebuild switch --upgrade` for system updates and explain the core concept of "Infrastructure as Code" using `configuration.nix`, emphasizing the portability and reliability of NixOS compared to VMs and containers. I also explore the command structure of Nix, demystifying subcommands and switches, and share my enthusiasm for Nix's potential to redefine software development.

**Title and Headline Ideas:**

* **Titles:**
    * NixOS: My Leap into Deterministic Computing
    * Beyond VMs: Mastering NixOS and `nixos-rebuild switch --upgrade`
    * From `apt-get` to Nix: A Developer's Journey
    * NixOS: The Future of Software Portability
* **Headlines:**
    * "Say Goodbye to Dependency Hell: Why I Switched to NixOS"
    * "The Ultimate Upgrade: Understanding NixOS's Core Command"
    * "Infrastructure as Code: How NixOS is Redefining System Configuration"
    * "NixOS: The Secret Weapon of Modern Development"

**My Opinion:**

This article provides a very useful overview of NixOS. The author does a good job of explaining complex concepts in a relatively accessible way, especially for those familiar with Linux and development workflows. The focus on practical usage, particularly the `nixos-rebuild` command, makes it valuable for anyone considering or already using NixOS. The comparison to other package managers and virtualization technologies helps to contextualize Nix's unique advantages. The author's enthusiasm for the technology is evident and contagious. The explanation of the command line switches and subcommands is very useful.


