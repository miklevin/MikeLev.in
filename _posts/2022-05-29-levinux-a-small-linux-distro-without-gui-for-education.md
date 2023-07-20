---
date: 2022-05-29
title: Levinux, a Small Linux Distro without GUI for Education
headline: "Introducing Levinux: A Simple Linux Distro for Learning Unix/Linux"
description: I'm Mike Levinux and I created Levinux, a Linux distro designed to help people learn Unix/Linux. It includes components such as Tiny Core Linux, QEMU, BusyBox, and a virtual Linux, plus a file-transfer system and a server-building script system. I advocate for the use of Vim and Git for security, and suggest using Python and forward-slashes for code that will run anywhere.
keywords: Levinux, Linux, Unix, Tiny Core Linux, QEMU, BusyBox, Virtual Linux, File-Transfer, Server-Building, Script System, Vim, Git, Python, OpenSSH, JupyterLab Desktop, Pythonic
categories: python, levinux, git, vim, linux
permalink: /blog/levinux-a-small-linux-distro-without-gui-for-education/
layout: post
group: blog
---


In this post, I answer the following questions:

- Can I teach myself Linux?
- How long will it take to learn Linux?
- Is Linux hard for beginners?
- Can you learn Linux for free?

...and then go off on a complete tangent, fixing an obscure little issue in my
distribution of Linux called Levinux.

> I have a Linux of my own.<br />
> My name is Mike [Levinux](https://levinux.com/).<br />
> It's not a distro I have grown<br />
> So much as a respinux!<br />
> <br />
> <cite>&#151;Mike Levin, 2022</cite><br />

1. Can I teach myself Linux? Yes!
2. How long will it take to learn Linux? About 5 minutes.
3. Is Linux hard for beginners? No, not with an open mind.
4. Can you learn Linux for free? Yes.

# But Not in This Article. This Is Not Even a Levinux Lesson.

This article is me rambling on forever about all the profoundly cool stuff that
went into this still applicable today timeless fossil of a learning-piece for
those taking up Unix and Linux (collectively known as \*nix) operating systems.
For a lighter overview, may I suggest:

- [The Levnux Slideshow](https://levinux.com/)
- [The Seminal Levinux Article](https://mikelev.in/ux/)
- [Levinux on Github](https://github.com/miklevin/Levinux.com)

But by all means, continue.

> Face your FEAR OF HEADLESS SERVERS with this ~20MB Virtual Linux w/ Python,
> vim & git. Stick your hand in the \*nix gom jabbar with a double-click from
> the desktop of your Mac, Windows or Linux PC.

{% include youtubePlayer.html id="bddM-JyNuXs" %}

# Now Onto Some Truly Geeky \*nix Talk

Genuinely new Linux distros are actually few in number, or at least mainstream
popularity (plenty of tire-kickers) because it's not easy building Linux from
source and actually adding value in a way that's of interest and use to the
public. There are a few and the two king-of-the-hills are (as of the time I
last cared to research):

# A Few From-Scratch Linux Distros

- RedHat Linux of the IBM-funded lineage (CentOS, Mandrake, etc.)
- Debian Linux of the now-Microsoft lineage (Ubuntu, Mint, etc.)
- Gentoo of the independent optimized for your hardware crowd
- Arch Linux whose users want the best of all worlds, minus desktop bloat
- Tiny Core Linux (TCL) whose users think even Arch is way too big
- Linux From Scratch (LFS) for those with whom the force is strong

You know, this list really probably goes on a bit. Maybe genuine Linux distros
are few in number versus the nearly infinite second-order derivatives like
Ubuntu. But I've hit some of my favorite high-points. There's others mixed in
and some are even surprisingly popular Unix versions, one you're running right
now and don't even know it.

# The Invisible Hands Reaching Into Your Intel-PC Right Now

- [Minix of the Intel Management Engine](https://www.zdnet.com/article/minix-intels-hidden-in-chip-operating-system/) which is a full Unix with network stack
  and everything providing a backdoor on your Intel-based system right now.
- FreeBSD which nearly every Internet address-routing computer (DNS / domain
  name server) is based on.

Minix in particular is of interest to me. I looked at basing Levinux on that
back in the day. Intel had been baking it into your processors since around 2008.
I didn't start looking for the beating heart of Levinux until around 2012
or so, when my kid was 2 years old and I realized I needed a sort of "Noah's
Arc" for my work. Looking around, I found and fell in love with Tiny Core
Linux, which comes form this guy Robert Shingledecker who is the first person
to bring Linux to municipal government in the United States. He's got a great
story and is another one of those decisive be and divisive individuals.

I guess I ought to shout out to QNX Unix. It's a proprietary version of Minix,
basically baked into everything from Blackberries to coin-op laundry machines.
If it's got a computer inside, nobody's has the time for truly proprietary shit
anymore, so it's going to be some tiny form of Unix or Linux... always. Did I
mention drones?

# Curses! Foiled Again.

I tried building my own Linux from scratch (Refer to LFS above) along with
compiling QEMU from source. I could have gotten the 20MB zipped distro down to
probably 2MB to 5MB and not had the QEMU disappearing pointer problem. The key
to this appeared to be MinGW (today MinGW-64), a subset of Cygwin (a way of
turning Windows PCs into POSIX-compliant \*nix machines) plus a wonderful
library (I still want to use it) called Curses. Curses lets you do a lot of
neat tricks with text-terminals that you think are reserved for Graphics. The
popular Python ***pip install rich*** makes wonderful use of it today,
validating my suspicions 10-years ago when I was researching this stuff.

# A Very Deep Rabbit Hole

Roomba can only crash into a wall, turn a bit and retry so many times.
Channeling the spirit of The Incredible Hulk with only a touch of Bruce Banner
to manage the turns (how I work) wasn't good enough. This task was going to
take a whole lot more Bruce and a whole lot less Hulk.

Ugh! Did I mention Rabbit Hole evaluations. This rabbit hole was too deep for
me. Controlling the linking of libraries in C to bake-in static libraries that
resisted for a thousand-tiny reasons... plus learning Curses and about a
zillion QEMU compile-options.

Uncle! Uncle! I cry uncle.

# 80/20-Rule To The Rescue!

Oh wait, wasn't everything just working perfectly a moment ago but for the
pointer disappearing. And you know, maybe someone out there wants the options
for graphics in the Levinux console. And a 20MB download isn't really so bad.
And many other sour grapes I could conjure.

Just focus on a good Alice in Wonderland-style experience. People will
appreciate it in any case. Did I mention the 80/20-rule? And those
QEMU-binaries... there's that one from Japan everyone uses. And there's that
one for the Mac that was mainstream there for awhile. Okay, okay, mix them
together in this magical cocktail based around Mac's packaging system that
copies my & Howard Harrison's WBScript for the Amiga back in the 90s (I later
found out Sun Microsystems also used this directory-as-an-app trick), shake
well, then bash a few times... voila!

Bob's your uncle! (he really is.. I've got an Uncle Bob)

# The Basic Ingredients for a Tiny Linux Server

So, what I chose for Levinux and some of the ingredients and components that
went into it are:

- [Tiny Core Linux](http://tinycorelinux.net/) (yay!)
  - [Robert Shingledecker](https://www.amazon.com/Official-Damn-Small-Linux-Book/dp/0132338696)
    is the person who created DSL (damn small linux)
  - The Damn Small Unix people are all [sour grapes](http://www.damnsmalllinux.org/wiki/robert_shingledecker.html) about
    it, but still TCL is better than DCL in my opinion.
  - Has a repository system like Debian (Ubuntu), but smaller
  - I've frozen on older versions... 7.x, they're up to 12
- QEMU is a free and open source software PC Emulator
  - QEMU is distributed in many ways for many different use-cases
  - It is something like a swiss army knife of emulators
  - I use historically popular binaries that have proven over the years
  - Not the most efficient emulators / VMs out there.
  - Maximum variety of OS desktops that it works on
- BusyBox Linux
  - GNU-like set of Unix-like commands, but at ~500K (not MB)
  - There's also a very tiny companion busybox webserver
  - A BusyBox webserver
  - A DropBear SSH server (google DropBears, the Australian ones, not the tech
    one--fasinating story)
- A Tiny Virtual Linux that runs with a double-click from
  - Windows, Mac or other Linux desktops (GNOME, KDE, Xfce tested)
  - No Install necessary
  - No Admin Rights necessary
  - File-transfer between host OS and VM at start-up for server-building
  - A robust server-building / net-appliance-building script system
  - The whole thing distributed in a .zip file that's under 20MB
  - The whole thing free and open sourced on Github (not at first, but
    eventually)

Pshwew! Honestly, it was a miracle this whole thing worked in the first place.
It's a miracle it still works as well as it does today and still serves its
purpose for education so quintessentially. A paragon of perfection, as I said
in the YouTube description. Every time I see the Dropbear SSH server doing its
thing and the busybox-httpd webserver doing its thing, and using the default vi
program built into BusyBox Linux, I get the chills. It is a true example of how
Unix/Linux skills are generic in nature and when you go this route, you're not
learning one particular thing, but really technology in general.

That's because Unix/Linux simply has ascended to unchallenged already-won
dominance. Even Microsoft has come around in the most "I meant to do that" way.

{% include youtubePlayer.html id="9hNIX7V21pU" %}

And a final note before we get onto the nitty gritty of what I'm fixing here,
QEMU is actually in fact using the much maligned lately technique of PC
***EMULATION*** (vs. virtualisation or containerization). It's much maligned
because emulation is very slow compared to virtualisation, and practically not
moving at all compared to the so-popular containerization (docker, LXC/LXD) of
today.

# Stick Your Hand In The Pain-Box. Go Ahead-less!

In other words, don't expect Levinux to do ***anything*** for you other than to
kick off your schooling in old's kool text-based Unix/Linux. I view it as the
Gom Jabbar pain-box of Dune that is used by the Bene Gesserit sisterhood (kind
of like Minix) to determine whether you're fit to be a leader of human race.
Levinux is a similar little black pain-box testing whether you're fit to learn
\*nix.

![Dune Gom Jabbar Pain Box Levinux Linux](/assets/images/dune-gom-jabbar-pain-box-levinux-linux.webp)

# Don't Get All Diffie w/Me. You Can Go To Hellman.

Go ahead. Download Levinux, unzip it and double-click the icon for your OS.
You'll get the server-build phase and be invited to SSH. I bet you can't. Not
with the instructions I give. That's because since I released Levinux, SHA-1,
the encryption/checksum system for secure communication has been hacked.
Something in the system changed, probably the ssh programs run from Powershell,
PuTTY, default on the Mac and such changed to give warnings. It couldn't be
Levinux because nothing big has really much changed there... for 7 years!

# QEMU Virtual LAN & Network Address Translation

So I researched it and figured it out. SSH programs can be told to go ahead and
work with SHA-1 anyway. The nattering naybobs who will ***yell at you*** for
this don't know what they're talking about. It's about the same as the ninny's
who think you shouldn't pickle data in Python even if it's not a program to be
used by the public. That's like saying you shouldn't shoot a gun in a shooting
range. Levinux runs in QEMU's virtual LAN (local area network) context. It's
got its own subnet and DHCP server. No traffic is getting in unless you create
a NAT-rule (network address translation). It's safe.

To understand more about the technology being used here:

- [QEMU networking context](https://wiki.qemu.org/Documentation/Networking)
- [Whitfield Diffie and Martin Hellman](https://news.stanford.edu/2016/03/01/turing-hellman-diffie-030116/)

# OpenSSH Legacy Option

Whoah, whoah there Hulk! Slow down there a minute. No amount of smashing is
going to make it work. You need to let Bruce Banner take the wheel for a
minute. Just for a minute, Hulk. Then you can smash Linux with

    sudo su
    rm -rf /*

...all you want. But to actually log into Levinux using a modern ssh client,
you're going to have to type:

```bash
ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 tc@localhost -p 2222
```

# Hulk SMASH!

Okay, got it? No? Well, the password is "foo". Stop and read man, will you?!?!
Oh yeah... The Hulk. Anyway, type in:

    foo

...as the password for user "tc" when challenged. You won't see it... no, Hulk!
No smash. It's okay... not seeing passwords is intentional. It's a security
precaution. Think about it... oh yeah, The Hulk.

You okay, boy? You in? Okay now. Follow the instructions. Maybe install Python.
Maybe check out vim. You don't really have to do either if you've got some
vi-skills or are willing to develop some.

![Bruce Banner Controllig The Hulk](/assets/images/bruce-banner-controllig-the-hulk.jpeg)

When I advocate vim, I do so in part because it's little sibling, vi, is built
into everything including 500KB busybox Linux, I shit you not.

Is that good, Hulk? Hulk vi?

No? Not of interest? Still want to smash... sigh, okay. Type:

```bash
sudo su
rm -rf /
```

Now you can go into the Reset folder, double-click whichever reset script
appears to be the right one for your OS. If Windows, override all the
resistance. If Linux, the execute-bits may not be set right or the double-click
action not registered or any one of a thousand other little details.

Eash, Hulk! The Gom Jabbar test will tell you if you're human.

Still with me?

# Congratulations, You're Human

You may even be qualified to lead humanity into the future. Just learn yourself
the Bene Gesserit ways of Linux, Python, vim & git.

Mom! He's using the voice again!

![Candace Flynn Phineas Turned Into A Badass](/assets/images/candace-flynn-phineas-turned-into-a-badass.png)

# Next Step After Levinux

I've really given up tiny versions of Linux. I wanted them as a sort of Noah's
Arc so that my (mostly) Python code was not tied to one particular server,
Raspberry Pi, Cloud service, or whatever. I wanted my code to live on my
keychain in an always-ready-to-run with a double-click sort of Kung Fu way.

I was so hurt so many times by technology going obsolete on me that my desire
to future-proof myself led to a sort of paranoia that led to the concept of
tiny virtual Linux (or maybe Unix) servers. I don't feel this way anymore. And
I still totally think tiny linux servers are as cool as talking frogs, I'll
still kiss the frog. Otherwise, this frog is cooked.

![But A Talking Frog Is Cooler Than A Princess Engineer Joke](/assets/images/but-a-talking-frog-is-cooler-than-a-princess-engineer-joke.png)

Play with tiny linux servers from time to time, but don't rely on them as your
main development machine or anything. Maybe if you work on embedded systems
like those in drones, they become your main thing. But 99 times out of 100,
just use a mainstream OS that supports a good Unix or Linux. Macs ***ARE***
Unix with fully operational bash-like Terminal Shells and Windows has recently
become good enough, thanks to Windows Subsystem for Linux (WSL). And ChromeOS
has a good Debian-based bash Terminal.

# The Promise of Unix / Linux has Borne Out

In other words, the promise of Unix / Linux has borne out and you don't have to
carry an extra one around with you as a Noah's Arc backup. Just keep your code
in Github. Clone it onto any machine. Run it.

So long as you use forward-slashes instead of back-slashes and beware of the
Mac's slightly non-standard directory structures, your code will pretty much
run anywhere. No Noah's Arc required.

Python, vim & git play into this delivered promise too. Python 3.x code will
pretty much run on anything with Python 3.x. For an added bonus, resist direct
reference to file-systems and instead go through Python's pathlib. But even
that's not really necessary. The world has yielded to forward-slashes and the
Unix/Linux directory structure.

Death by broken Windows paths is over.

This will now be true for every hardware platform past, present and future,
which will always include some version of vi or git (if those platforms want to
pretend to exist). Developers won't allow otherwise.

And with standardization, comes the great unwashed hordes of developers, with
which comes the great groundswell of a new literate class of global citizens
who would laugh at a proprietary Windows without putting WSL Linux capabilities
first.

The new lingua franca of tech has settled down, and it's known as LPvg:

- Linux
- Python
- vim
- git

# Final Shout-Out to Jupyter

Getting started ain't easy. The universal code-runner that I sought in Levinux
is now replaced in my heart with [JupyterLab
Desktop](https://github.com/jupyterlab/jupyterlab-desktop/releases). Download
it. Install it.  Forget all this Linux, vim & git stuff for a few hours. Just
let the Pythonic pythoniness of Python wash over you for a little.

In JupyterLab Desktop, the "Hello World" program is:

    "Hello World"


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/if-i-were-green-i-would-die-abba-di-abba-di/">If I Were Green I Would Die. Abba Di Abba Di.</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/gathering-my-stories/">Gathering My Stories</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/levinux/'>Levinux</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>