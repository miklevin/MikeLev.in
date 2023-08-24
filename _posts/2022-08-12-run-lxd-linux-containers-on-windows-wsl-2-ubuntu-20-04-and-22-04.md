---
date: 2022-08-12
title: Run LXD Linux Containers on Windows WSL 2 Ubuntu 20.04 and 22.04
headline: "Break Free from Vendor Tyranny: Install LXD Linux Containers on Windows WSL 2"
description: This guide helps readers quickly and happily settle into a new digital home, free from vendor tyranny, using Windows Subsystem for Linux (WSL) and vendor-provided components like Github or Bitbucket. I use Windows machines as a host, WSL 2 to host Linux containers, and sprinkle my own customizations, including a Microsoft Network SAMBA/CIFS Shared Drive. I'm a big fan of LXD, the Linux Kernel Virtual Machine from Canonical.
keywords: Linux, Containers, Windows, WSL, 2, Ubuntu, 20.04, 22.04, Windows Subsystem, Github, Bitbucket, Microsoft Network, SAMBA, CIFS, Shared Drive, LXD, Canonical, Docker, API, Fstab, Home Directory, Volatile Core Image, Installing Containers
categories: wsl, git, container, ubuntu, python, microsoft, linux
permalink: /blog/run-lxd-linux-containers-on-windows-wsl-2-ubuntu-20-04-and-22-04/
layout: post
group: blog
---


There's no place like home. Yet, we lose our "home" a lot in life. Settling
quickly and happily back into a new home is one of the great skills in life, be
it in the physical world or the digital one.

Re-establishing all the familiarities and getting things running smoothly
again is challenging in either case, but it is a skill one can benefit from
improving. To that end, I've prepared this little guide.

# GUI's Are Syntactic Sugar (Not The Real OS)

What's home your digital home? Windows? MacOS? Point-and-clicking?
drag-and-dropping? Locations of things changing on you with every version
upgrade? Not me. I'm using stuff that hasn't changed much since the 1970s and
1990s and is still going strong. The locations of your keys on the keyboard
don't change (much) and software interfaces are superbly static so we can be
the dynamic ones. Fixed locations are better than floating ones when it comes
to improving over time, and that's what the type-in user interface provides.

Better still, the type-in OSes are generally free and open source, certainly
contributing something towards their eternal timelessness. While proprietary
Windows and MacOS go hopelessly obsolete, the Linux Terminal only gets better
with age.

Windows and Mac desktops are not really even OSes. They are syntactic sugar
sprinkled on top of what really matters, the text-based OS underneath. Apple
proved this in 2007 when they switched their proprietary OS9 to UNIX-base OSX
and hardly anyone noticed. But today most Mac users interact only with the
Cocoa puff and not Darwinian evolution below.

Apple prisoners stay prisoners because they can live only in the graphical user
interface where they're shaken down for money every few years. Steve Jobs used
to pry the arrow-keys off of keyboards he hated the command-line interface so
much. Separation from the "real OS" is very intentional, and you can fix that.

# Particular Instances of Hardware Is The Enemy

Even those who have made the break from GUIs still have problems because of
particular instances of hardware, virtual machines or even containers. The
crash of a piece of hardware in your life can be devastating, a lifetime of
work or memories lost. And the "cloud" isn't the entire answer, either. Just
having a little more control is.

My feeling is that you're not free from the tyranny of vendors until you can
quickly rebuild your home from parts, and the home you build is mostly a
text-based OS in which I guarantee you can learn to be comfortable. Like
anything else, it takes practice.

# Developers Know This. Microsoft Knows This. The Time is Ripe.

Developers know this and demand their Linux tools like gcc, git, apt, pip, npm
and all the other things that frustrate Mac and Linux users. They're all going
to Linux anyway and Microsoft knows this so has been working on their Windows
Subsystem for Linux (WSL) for quite some time.

Windows Subsystem for Linux is finally ready for prime time, and so ironically
Microsoft themselves is giving us all our best hope of finding our freedom and
independence from Microsoft, if only we can figure out how to use the tools
properly and form the right habits. Build your house from bricks and don't let
the Big Bad Wolf blow it over again, obsoleting your old GUI-based software.

# Vendors, Vendors Everywhere; Can't Escape Them For Now

To achieve this lofty goal, there are unfortunately vendor components we're
just not going to be able to get away from today. We will ditch Windows and
Github in the future and I'll take you there. But for right now, today there
are a few vendor-provided pieces we're going to need, such as Github or
Bitbucket for private git repos in a remote repository.

Unless you're ready to make the switch cold-turkey to Linux, we'll also be
using Windows for a little while longer. It gives us our warm-and-fuzzies,
games, drivers, readily available working systems, compatibility with the
office or whatever. There's a thousand tiny reasons starting out on Windows
reduces the pain. And it doesn't have to be multi-boot anymore. You get Windows
and Linux at the same time--the best of both worlds.

# Sprinkling On The Magic Fairy Dust

Fast-forward in your mind to where you're familiar and comfortable with the
Linux Terminal text-based interface to computers. Even there you won't be able
to sit down at just any Linux Terminal and be 100% comfortable. There will be a
few bits of customizations to sprinkle in; a mapped drive here, a text-editor
configuration file there. These are mine. It is the magic fairy dust I sprinkle
into a plain vanilla Linux system to make them home.

- The ~/.ssh folder and it's contents of public/private keys.
- My ~/github folder containing a smattering of projects kept in Gitub
- My ~/data folder which is a shared network drive location
- My .gitconfig file to help pull down those repos (easily reproduced)
- My .vimrc file (not so easily reproduced)
- My .pypirc file to let me easily update my published PyPI.org packages
- My .screenrc file because I use GNU screen program a lot

The list of essentials may be different for you and it evolves over time.
None-the-less, these are the parts that get recombined into whatever. It can be
onto the bare metal hardware, a virtual machine or a container. Once you have
the skills to recombine them, it doesn't matter. Just keep your ingredients
safe (and up-to-date) somewhere. Git repos are generally good for everything
except for the .ssh keys and other login credentials.

# To Map Locations Or To Copy Files, That Is The Question

Three of these are file locations while the rest are just individual little
files that just get dropped in the ~/ (home) folder of any Linux system. The
dot in front of the filenames means the OS hides them (invisible files) by
default. Config files are usually like that.

The 3 file locations are handled each in different ways. If there's a "host"
machine of any sort involved, I like to reuse the host's .ssh and github
folders so I don't have to make multiple copies of keys all around and so that
I don't have to keep git cloning out of Github, but either one can be produced
from scratch rather easily.

# A Tale Of Two Hosts: Windows & Linux

I'm using Windows machines as the host these days. This is because Windows
hardware is cheap and abundant, pre-installed, has lots of drivers and other
support, keeps me compatible with the office, and a thousand other little
reasons that just make this today's reality. It'll change in the future, but
for now I use the Windows Subsystem for Linux (WSL 2) to host Linux containers.
These Linux containers get the magic fairy dust sprinkled onto them to make
them home.

The next concept is a bit of a leap, but hang with me. Windows should not
directly be your host, because it's not timeless and eternal enough. Linux
should be your host, so our first priority is to get a sort of Linux host
running side-by-side with Windows under Windows Subsystem for Linux (WSL 2). We
will then use this WSL2 Linux instance to host subsequent Linux containers onto
which we will sprinkle the magic fairy-dust making them home.

# Windows Subsystem For Linux & Cross-OS Symbolic Links

I've documented plenty how to get WSL2 running in the first place. I may add
those instructions or hyperlink them here later, but for now once you have a
WSL2 Linux instance running, you can map locations from Windows host over to
Linux host like this from within the WSL2 Linux Terminal, changing usernames to
your case:

    ln -s /mnt/c/Users/winuser/github/ /home/wsluser/github
    ln -s /mnt/c/Users/winuser/.ssh/ /home/wsluser/.ssh

These are the easy ones because those locations really reside on the real
hardware of the host machine. The ln command makes UNIX-style symbolic links.
They're one of the million-dollar tricks of Unix/Linux and you should google
them to really grok it. It's a gift that this works in this context. Network
drives aren't so easy.

# Persistent Mounting of Microsoft Network SAMBA/CIFS Shared Drives

Network drives reside somewhere else on your network than your actual laptop.
Why would you do this? Your laptop should not be your single point-of-failure.
You should start getting yourself used to working on different physical
hardware since your home's about to float now anyway. Don't go through all this
trouble and then make any single laptop all that precious. Use a NAS and back
up its storage to 2 additional locations. And it's easier to get a shared
network drive in your home than you think with such products as QNAP or
Synology NAS (network attached storage).

I like to use a location called ~/data. If I haven't explained it yet, ~/
always means "home". When you see ~/, think /home/username/. The tilde is just
a shortcut. And to map a network drive to such a location, here's what we do.

    cd ~/
    mkdir data
    sudo mount -t drvfs '\\EchidNAS\data' /home/wsluser/data

There's some special Microsoft magic going on here with that drvfs fileformat
it's defining. From the page
[https://docs.microsoft.com/en-us/windows/wsl/wsl-config](https://docs.microsoft.com/en-us/windows/wsl/wsl-config)
it says:

> DrvFs is a filesystem plugin to WSL that was designed to support interop
> between WSL and the Windows filesystem. DrvFs enables WSL to mount drives with
> supported file systems under /mnt, such as /mnt/c, /mnt/d, etc.

Suffice to say it works and is the key to moving files around easily between
the 2 hosts, and in the future between containers and other physical computers
on your network. Of course adjust your paths and usernames to match:

Unfortunately, that network mount will be lost between every reboot without
editing the /etc/fstab file to make it persistent. So this line must be edited
into /etc/fstab. It needs admin privileges to edit, so I sudo vim /etc/fstab.

    \\EchidNAS\data /home/ubuntu/data drvfs defaults 0 0

At this point, you can exit your WSL login, restart WSL and go back in to make
sure you still have your ~/data drive:

    wsl --shutdown
    wsl -d Ubuntu-20.04

# Sprinkle Magic Fairy Dust From ~/data/home To ~/

Now that you've mounted your network drive where you keep all those precious
components you can build your house from and made sure the link will survive a
reboot, you can with confidence copy stuff from it home:

    cd ~/
    cp ~/data/home/.* .

You can exit and log back into this new Linux host to make sure your
environment is fully activated. In particular that will run your .bash_profile.
If you have stuff in your .bash_profile file that doesn't exist (yet), you'll
get errors. I typically activate a Python venv (virtual environment) from in
there, so I have to comment that line out.

# Now I've Got A Linux Host... Ho Ho Ho

This is a nice, solid Linux host machine for your Linux containers. This is not
your new actual home. This is a Linux host under which your LXD Linux
containers will be created and treated as home. There's a subtle point to get
here. It's all about the application program interfaces (APIs). APIs are the
real tools here. You learn an API and internalize it as a part of yourself like
learning a new language. You don't want it going obsolete on you all the time
and be left speaking a dead language... like Windows. You want to be speaking
Linux to create and manage other Linux.

Many will suggest at this point (and Microsoft certainly would) that you should
just use this WSL Linux instance directly as your new Linux home. The problem
being that you'll continue nurturing your Windows dependences. There's tons of
subtleties and nuance using a Windows machine as a Linux host directly. You'll
be building your house from straw because down this path, you'll be becoming
expert at the Microsoft WSL API and not the LXD API. What you really want to do
is learn the LXD (Linux container host) API, which I expect will eventually
stabilize be mainstreamed into Linux the way the Linux Kernel Virtual Machine
(KVM) did. LXD is from Canonical, the people who make Ubuntu. It still has to
officially win the battle for the kernel and ubiquity in other distros, but
it's well on its way.

# But What About Docker Vs. LXD?

Most people will be advocating Docker over LXD at this point because of its
enormous uptake over the past decade. And yes, Docker is awesome and won't be
going away. But Docker is for Apps. LXD is for complete Linux systems. Or in
other words, Docker is for the "possessions" inside your home but not for the
entire home itself. LXD is for your entire home.

Docker can fake it, but you feel the faking. Once a particular home is
"perfected", a docker image can be turned into a wonderful distributable
plug-in image so anyone can plug it in and enjoy that home. So docker is great
for app store ecosystems. But if you want to start customizing that home and
making it yours (like a developer), it's done with a series of layered-on or
composited overlays. Docker makes a sort of nonvolatile or immutable core image

Once you're in an LXD container in comparison, it's exactly like being in a
regular Linux system. Just Google LXD vs Docker and you'll get the gist.

# Installing LXD Containers on a Linux Running Under Windows WSL 2

This is where it gets tricky. I've got quite a bit to expand here in this
article related to mapping in drives from the Linux host to the containers.

{% include youtubePlayer.html id="xmZcsq8Mqk4" %}


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/use-python-to-cycle-your-ip-with-hma-vpn-software-and-windows-automation/">Use Python to Cycle Your IP with HMA VPN Software and Windows Automation</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/why-linux-fights-obsolescence-and-lxd-is-key/">Why Linux Fights Obsolescence and LXD is Key</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/container/'>Containers</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>