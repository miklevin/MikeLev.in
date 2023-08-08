---
date: 2023-08-07
title: Bram Moolenaar's Death is a Kick in the Pants for MyKoz.AI Project
headline: "MyKoz.AI: A Journey of Self-Reinvention and Embracing Linux, Python, vim & git"
description: "I'm a fan of the tools I use, and the toolmakers who make them. I'm a fan of Linux, Python, vim & git, and I'm deeply moved by Bram Moolenaar's death. I'm on a journey to the Noosphere, and MyKoz.AI is my Noosphere endeavor. I'm doing this by adding a Linux subsystem serving JupyterLab to existing Windows 10 or 11 desktops, optionally starting fresh with a 'Reset this PC' approach. I'm packaging it to be appealing to the masses: a path for those determined to master tools for life on a continuous journey of self-improvement."
keywords: RIP, Bram Moolenaar, Vim, NeoVim, vi, Amiga, Fred Fish Disk, Linux, Python, git, Bill Joy, Sun Microsystems, Berkeley Unix, Vint Cerf, Tim Berners-Lee, LPvg, Levinux, PuTTY, WSL, NT, Windows 10, Windows 11, Mac, Hypervisor, Intel processor, Jekyll, Google Pages, DNS, https, Cloudflare, CSS, git repo,
categories: lpvg, mac, python, amiga, git, linux, jekyll, wsl, vi, vim, levinux, microsoft
permalink: /blog/bram-moolenaar-s-death-is-a-kick-in-the-pants-for-mykoz-ai-project/
layout: post
group: blog
---


Continuity over time is one of the values of this journal. It is also another
place where you can reinvent yourself, cleanse your palate and start anew. I
did so with a new banner at the top. It's not shown as part of the normal
publishing procedure, and it will probably only ever show properly when I shoot
YouTube videos of my journaling, which I feel I ought to do again soon. Now?

# RIP Bram Moolenaar, creator of vim. I Write this in vim (NeoVim)

That's what Copilot suggests I write. It's a good idea, because if not for vim,
the original "vi" program may never have made a cultural comeback that it began
in 1988 when Bram Moolenaar, I believe first worked on vim. It gained a bunch
of notoriety later when it became broadly distributed on the Amiga computer's
"Fred Fish Disk" #591. That's was Public Domain software disks that were big
back around 1991 before the Web (but after the Internet).

I'm writing this in NeoVim, which is a fork of vim. I'm using NeoVim because
the Copilot AI needs the NeoVim API to work. Otherwise, I'd be using vim.
Apparently that ghost-text that appears as I type is a feature of NeoVim, and
not vim. It took me a bit to change and tested my API-compatibility for
disruption resistance theories. I talk a lot about future-proofing and
resisting obsolescence, and this is a good example of that.

I made the transition from vim to NeoVim. It took some work adjusting my macros
and optional journal publishing features, but I did it. "Journals" like this
one are actually single text-files that are parsed by a Python script that
generates very bare-bones markdown files that get dropped in place in Google
Pages (google.io) which uses the Jekyll static site generator (SSG) and
publishes the pages.

I use DNS to resolve registered domains to Google Pages. I use the https
protocol on the Google Pages side, and apparently Cloudflare to provide the
https certificate. At any rate, the site gets published as an https static site
that's stylized with CSS. The CSS is handled on my side in a file that's in the
same git repo as the journal.md. Graphics go in there according to the Jekyll
file layout conventions, so usually in a `repo/assets/imges/file.png` type of
path. 

Similarly, CSS goes `repo/assets/css/style.css` and so on. You just edit a few
text files and put graphics in location and git commit and push to Github. It
automatically gets published as a site. The only cost to this is having a
Github account, which you can do for free, and registering a domain name, which
you can do for about $10 a year.

# A Reflection on MyKoz.AI, Linux, Python, vim & git, and Bram Moolenaar

I find satisfaction in improving things over time. And thus, it is all the more
of a learning opportunity when things don't turn out exactly as planned. This
happens not just in relationships with people, but also in relationships with
tech. I have some good content, but I'm not "breaking out". I don't take time
to edit my content, it's minimally monetized, and I don't have the best
equipment in the world. I'm publishing a bunch of what I do just as a sort of
"side effect" of doing what I do. And I like it that way, because I love doing
what I do?

What is it I do? Well, it's rather meta. My favorite thing has turned out to be
tending to a toolset that I use to do other things. I'm not the toolmaker, but
I'm the tool user. I am a ***fanboy*** of the toolmakers and the tools I use. I
am keenly aware that vim, written by Bram Moolenaar, is built on the precursor
named vi, which was written by Bill Joy. 

I'm also aware that Bill Joy was a co-founder of Sun Microsystems and re-wrote
much of what is now the Berkeley Unix distribution, and that vi is part of the
various Unix and Linux standards. Bill Joy is 68 years old, and Bram Moolenaar
was 62 when he died last week. I'm 52 years old and have done nothing like Bill
or Bram yet to help the world. To make it a better place. By being a tool-user
who in his respects the toolmakers, is able to at least instruct on how to
assemble one of the most powerful yet tiny toolboxes in the world. I call it My
Cause, and do a Fonzie thumbs-up, pronounced "Ayyy". But since there's no .Ayyy
domain name, .AI will do. So I call it MyKoz.AI.

Our tools tell us stories. You wouldn't think such touching human stories come
from such (at first) boring and complex tools. But I'm here to tell you the
stories are even better than that. Wait until you heart the story of Bell Lab's
recruiting of Ken Thompson to work on research, which later led to Unix being
invented quite by accident. And Unix provided the foundation for Linux, which
together gave us the Internet and Web, as the work of Vint Cerf and Tim
Berners-Lee (and many more folks) were layered on top.

So you see, modern "free" computing (free as in libre) is a story of
coincidence, layered on cooperation and community. It's a story of people who
were willing to leave their comfort zone and share their work with others, who
often get "bit" by the "sharing bug" and become addicted to the process of
sharing. There's so much meaning and purpose to be found in the sharing of
tools and knowledge.

These things I advocate, Linux, Python, vim & git seem at first like a "geeky"
thing to do and a lot more trouble than it's worth. But I'm here to tell you
that couldn't be further from the truth. These tools are some of the most
powerful tools in the world, and are so much more love-worthy and capable of
sustaining you financially and spiritually through the years than I think most
people realize. It takes awhile for the significance of vi, vim and NeoVim to
sink in.

My own stories regarding my gradual path to LPvg (Linux, Python, vim & git) are
bittersweet and for another time. This article is intended to get across how
deep this rabbit hole goes. It's designed to be a gentle chat with Morpheus
(for Matrix fans) without being cornered into an "either/or" choice. We know
what Neo'd do. He'd take the red pill. But I'm not here to tell you that you
can stay on Windows 10 or 11 and still chase the rabbit down the Linux hole.

See, we're in what's called the Nooshpere. It's a term coined by Pierre
Teilhard de Chardin, a French philosopher and Jesuit priest who lived from 1881
to 1955. He was a paleontologist and geologist, and he was a big fan of
evolution. He was also a big fan of the concept which was to become the
Internet, which he predicted in 1945. He called it the Noosphere, which is a
play on the word biosphere. 

When all human knowledge flows out into one big mix, only the most new, novel,
unique and creative ideas resist compression. Everything else can be described
with pointers and references to things that previously exist. They are
compressible. If you want to live in the Noosphere, you have to be
uncompressible. 

# MyKoz.AI Real/OS is My Noosphere Endeavor

I've done it before. The initial concepts date back to 2009, probably. I can
trace it in Github to 2013 when I finally decided I could put things with
compiled binaries that I don't have the source to in a repo. I called it
Levinux, and it was (and is, because it still has a fanbase) a way to run Linux
on the desktop of Windows or Mac. It was a way to get people to try Linux
without having to install it. It specifically taught the trick of connecting to
it remotely with a terminal. 

This was back in the days where a tiny free easy to find program PuTTY was the
way to do it on Windows PCs. Macs had the ssh program built into their
Terminal, because Macs were Unix-based already. For Dune fans, I very much
thought of Levinux as the Pain Box of the gom jabbar from the opening scene of
the first book, where Paul Atreides is tested by the Bene Gesserit Reverend
Mother. He had to stick his hand in a pain box that the cognizant mind knew was
not dangerous without pulling his hand out even while it felt like it was
burning to prove he was human enough to be a leader.

Since those days, PuTTY itself has been maligned with false distributions that
include malware. And the Windows Subsystem for Linux (WSL) has been invented,
which is a way to run Linux on Windows without a virtual machine. It is so
clever how that all came to be with the "Circles of Protection" behind NT so
gloriously coming into play, that it's for a separate article. Suffice to say
that the "virtualisations" features coming into being on the Intel processor in
the form of the Hypervisor perfectly dove-tailed with the "Circles of
Protection" that were already in place in Windows NT.

That's why two great operating systems can run side-by-side on the same
machine. There used to be a distinction between Type 1 and Type 2
virtualization, with the former being the very expensive and stable stuff
designed for servers, and the latter being the free stuff designed for
consumers running on top of Windows or Mac. But now, with the Hypervisor
features built into the Intel processor, the distinction is gone. NT which
still underlies Windows 10 and 11 is a Type 1 Hypervisor. I don't know the
backstory of how the Mac pulls it off (with 3rd party software), but it does.
And you can get a similar effect on Linux with KVM. So, it's Linux subsystems
for everybody!

# You've Already Got a Desktop (Not That They Matter)

Running Linux subsystems asks for very little compromise... except that you
stop thinking of Linux as an alternative desktop. Sure, there are endless
choices of desktops, but they're all just a way to get to the Terminal, because
that's where the true career and life-changing power of Linux resides. It's not
in "yet another desktop". That's a red herring. It's a distraction. Focus!

Just use the desktop you're familiar with. For me, that's Windows 10. Microsoft
is doing everything in its power to push you along to Windows 11, but if you
have 2 laptops in your life and know how to back up your data and switch around
between hardware, then you can always perform a "clean install" of Windows 10
on one of your laptops. Over time, you can use this "shake and bake" approach
to switching between at least two pieces of hardware to always be able to
introduce small changes in process and software to your life. It's a great way
to keep your mind sharp and your skills up to date.

What you're doing is swapping out what you can think of as your "Host OS" for a
Linux subsystem. You're not replacing your desktop. You're not replacing your
laptop. You're not replacing your operating system. You're just adding a Linux
subsystem, and doing a bit of building there using new FOSS techniques that
help you gradually make your skills timeless. It's a sort of Noah's Ark
approach to computing. The concept of Digital Nomadism is a great way to think
about it. You're not replacing your home. You're just adding a home on wheels.

We can attempt to hop into the Noosphere, pivot to a new destination, leave our
comfort zone or otherwise challenge ourselves to grow without having to
sacrifice our current lifestyle. We can do it in a way that's not a binary
choice. We can do it in a way that's not a "fork in the road". The language of
"flattening the curve" has come into our lives in a big way with the Covid-19
pandemic. We can flatten the curve of our own learning by making it a gradual
process. That's what MyKoz.AI is all about.

# So Then Why a "Reset this PC" Approach?

We're not replacing our desktop, but we can cleanse our palate. We can start
fresh. We can start with a clean slate. It's just that the new slate isn't
quite so shocking as Linux Mint or Ubuntu or Plasma or whatever else your Linux
friends are telling you is going to be so much better. The truth is your
laptops are rigged to give you a positive, successful experience minimizing
driver problems and other weirdness. Why walk away from all that into the
wilderness? Why not just remodel where you're already living?

Windows for better or for worse is the world's most used operating system. It's
familiar. It's important to know professionally. It's got drivers and game
support. It's much that you need, but also much that you don't. And to get the
balance between the two more advantageous to your Tech Muscle Memory, you can
just start fresh. You can just "Reset this PC" and start over. Reinstall and
don't give it an Internet connection or a Microsoft account. Just use it as a
Host OS for your Linux subsystems.

# It's All About Muscle Memory

You're going to develop a new way of thinking about your computer. This
involves developing new "muscle memory" for your fingers and your brain. It's
new habits that take awhile to set in, and quite an amount of "suspended
disbelief" to get you to the point where you're willing to try it. It's exactly
the same as with a movie or video game, where you have to let yourself go into
the flow and just accept the premise of the story if you want to enjoy it.

Starting your journey on your old friend Windows, but in the stripped-down but
patched-up form of what Microsoft themselves called "The Last Windows You'll
Ever Need" is a great way to get started. To a large degree, this claim holds
true even for patched-up Windows, but for the way it tries to slam
commercialism down your throat with the Search Box in the Taskbar, and the
inability to turn Cortana off. We'll get to those pesky details later. First,
we abide by the 80/20-Rule: 80% of the results come from 20% of the effort.

That old familiar Host OS stripped down should still have that familiar feeling
and be 100% compatible with everything you used to be doing. I believe many
people get a feeling of relief and surprise that it can always be this way. At
very least, it forces a re-evaluation of what's important and what's not. It's
a life hack. It's a way to get a fresh start without having to give up the
familiar. It's that same feeling you get with a new phone when you have to make
that decision between reinstalling all your apps or recovering from a backup
from your previous phone (if even possible based on your details).

# What's the Point of All This?

The point of this is that to get better and better at something over time,
which we presume to be one of the goals you have if you read this far, you need
to be able to build on what you already know. By internalizing a skill to where
it's automatic, like riding a bicycle or driving a car, you can then build on
that skill. The part of your brain that was previously deeply occupied
performing the skill, while acquiring learning, is now free to focus on other
things. You have freed up your "executive function" to focus on other things.
The mechanics and skills of actual driving are now automatic.

And so it can be with your computer. What field of endeavor does not have a
component to it that doesn't involve writing, data or both? What I'm talking
about here with Linux, Python, vim & git are the 80/20-Rule FOSS tools of the
trade for writing, data and both. You might not have heard of the LPvg platform
spoken about this way before, but vim is just as good of a writing environment
as any word processor, and after you've had a few positive experiences with
Python under JupyterLab, vim is where you'll switch over to "real" automation.

In time, the process becomes self-perpetuating. Following my advice, you'll
soon be journaling in vim like you're seeing me doing here. You'll be hearing
your own voice "forced" through the actualizer of writing. You will take your
abstract and inarticulate thoughts and articulate them through the
manifestation engine that goes from thoughts-to-bits. 

That's what I'm doing here. You're reading this because I'm thinking it into
existence through vim. I say vim, but it's NeoVim. I will use them
interchangeably now, in honor of Bram Moolenaar who just passed. But also a
shout-out to the whole NeoVim team for making it better.

So the point of this is to manifest. The point of this is to actualize. And if
you think there's something excessively "woo-woo" about that, then I will
kindly remind you that you're here reading this, and to think about the sort of
magical connection between us that's happening right now.

## Linux for Life

Am I convincing you? Am I helping to change the course of your life by helping
to impart the realization that all code you want to have a long life should run
on Linux as the code execution platform? Certainly Microsoft agrees, or they
would not have included the Linux Subsystem in Windows 10, so fully complete in
ways that they seemed to be reserving for Windows 11, including Linux graphics
support. But they backported that all to Windows 10. There's a level of
commitment here to bringing Linux to the masses that's unprecedented. It's
because if Microsoft doesn't do it, developers will look elsewhere for
development platforms that are modern and up-to-date.

## Python for Power

So Microsoft is convinced, but maybe not you. Python, you ask? You heard it was
a slow and dead-end language and that people are moving onto other things like
Go or Rust. Well, I'm here to tell you that Python is the most popular
programming language in the world, and it's not going anywhere. As recently as
this week, mixed right in with the Bram Moolenaar news, was the news that
Python PEP 703 – Making the Global Interpreter Lock Optional in CPython was
accepted. This is a huge deal. It means that Python will be able to run
concurrently on multiple cores, thus removing one of the last remaining
objections to Python as a language.

Oh, and did I mention that Python hired Guido van Rossum, the creator of
Python, to work on Python full-time? He's been working on Python for 30 years
now, and even though he stepped down as the BDFL (Benevolent Dictator For
Life), he's still very much involved in the language, and on-staff at
Microsoft. Intel, Google, Microsoft, Facebook, Amazon, and many other
companies, including the US Government, are all heavily invested in Python.
Then there's all the startups and small businesses that use Python. Oh, did I
mention the machine learning and data science communities? Python is the
language of choice for those fields.

## Vim for Verve

Vim? Oh, that's the most controversial of the LPvg bunch. But I'd humbly submit
that "vim emulation mode" sometimes called "vim bindings" is the most popular
add-on to other editors, from vim's ancient rival Emacs, to the modern
contenders like VSCode, Sublime Text, and even Microsoft's own Visual Studio.
Vim is the most popular editor in the world, not merely because it goes back to
1976, works great on slow, low-bandwidth connections (useful for remote server
maintenance), is part of the Unix and Linux standards (ships in some form with
every distribution), but it also gained this status because it lives up to the
hype. Year after year. For decades. Against all odds. Surviving cataclysms like
the too-soon loss of Bram himself. 

## Git for Greatness

Git? Well, that's the easiest sell of all. Git is the most popular version
control system in the world. It's what GitHub.com was built on, but you don't
need GitHub to use git. You can use git locally, or you can use git with any
other git hosting service. It not only helps you have infinite backup and undo
capabilities, but it also helps you collaborate with others. The collaboration
features were developed to be robust enough to support the development of the
Linux kernel itself, so to say it's battle tested is an understatement. And
those same collaboration features can be tweaked to turn it into whole
deployment systems for releasing and scaling your work.

## LPvg for Life

These four tools, Linux, Python, vim & git, are the 80/20 Rule tools of the
trade for writing, data and both. They really are so much more than "just 4
things". Linux in particular contains so much that I have to specify that even
there we have to pair it down. Remove the GUI and you have a headless server.
Remove almost everything you can't re-install from a package manager and you
have a barebones server. Technically, the main thing you need is a way to get
into it, traditionally an SSH server. But if you're following this path of
jumping on the LPvg bandwagon on the Microsoft Subsystem for Linux, you already
have the Windows desktop GUI, so you can really focus on the parts that matter.

This is where you leave your comfort zone. I know that if I were to ask the
average sojourner to open the `Linux Terminal`, an icon I leave out on the
desktop after the MyKoz.AI installation, they would be lost. That's one of the
various reasons I have a JupyterLab icon on the desktop. It's a way to get
started with ***Linux*** without having to use the ***Linux Terminal***. It may
not be immediately obvious, but JupyterLab is Linux application (in the case of
MyKoz.AI) that runs on Linux, but is accessed through a web browser.

This is why in the same Intro Repo that I have available immediately upon
running JupyterLab takes you so quickly from Jupyter Notebook to a Linux
systemd ***daemon*** service that runs in the background. It's a way to get
over that almost insurmountable hurdle that plagues all Notebook users of going
from Notebook to 24x7x365 server. If you "mock up" your Notebook to to do some
data science or machine learning task, and then you need it done according to a
schedule, or even just keep running without scheduling, most people are stuck.
They don't know how to get from Notebook to server. 

And so the reason we go to LPvg through JupyterLab is because it's a way to
get started with Linux without having to use the Linux Terminal. This is the
***one key skill*** that will elevate you from an undifferentiated Jupyter
Notebook tire-kicker to a ***Linux power user***. And it's not just about
Linux. It's about the ***Linux Terminal***.

The joke goes that in a millennium from now, when our space-faring descendants
return to Earth and greet our Earth-bound descendants, they will open their
chest plates and show them how they're still booting from a Linux kernel.

## MyKoz.AI for the Masses

Okay, so to actualize this further, I'm going to have to check off a number of
items from my to-do list. Maybe today!

                - README.txt: Write it for the Newbie (how to).
                - Intro Repo: Clear Instructions for the Newbie
                - NeoVim path: Show them how to start vimtutor.
                - Pipulate Repo: Reboot FOSS SEO from scratch.
                - WHIM Repo: With Help, I Monitor (systemd)





<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/rip-bram-moolenaar-creator-of-vim-i-write-this-in-vim-neovim/">RIP Bram Moolenaar, creator of vim. I Write this in vim (NeoVim)</a></div> &nbsp; <div class="post-nav-next"><a href=""></a></div></div>
## Categories

<ul>
<li><h4><a href='/lpvg/'>LPvg</a></h4></li>
<li><h4><a href='/mac/'>Mac</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/amiga/'>Amiga</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/vi/'>vi</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/levinux/'>Levinux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>