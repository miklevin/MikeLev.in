---
date: 2022-12-01
title: Much Starts With the Ability To Create and Use Local Caches
headline: Exploring Local Caches for Self-Reliance and Independence
description: I have been exploring Microsoft's implementation of systemd under wsl and have had mixed results. To ensure self worth and independence, I suggest investing in free and open source software (FOSS) and using caches, such as a SQLite .db file, to ensure persistence. I have been exploring the use of local caches for short-term memory and for storing variables used in programs, and share my experiences to help others.
keywords: Microsoft, systemd, wsl, FOSS, SQLite, .db, Unix-system, local caches, short-term memory, variables, programs, December 1st, 2022, background services, Linux, abstraction, hardware, proprietary systems, cloud, persistence, caches
categories: microsoft, wsl, hardware, systemd, 2022, linux, sqlite
permalink: /blog/much-starts-with-the-ability-to-create-and-use-local-caches/
layout: post
---


Wow, December 1st, 2022! Time flies. Lately I've been trying to use Microsoft's
implementation of systemd under wsl with less than stellar results. Systemd is
mainly for running background services under Linux.

Experiences are uniquely shareable now. Now that there's a completely portable
easy-to-build Unix-system using all standard components, there's some powerful
spells to be cast. These are shared-experience spells that tap into the power
of Linux, Microsoft's subsystem for Linux and the Containerization movement, to
keep any particular instance of hardware or host operating system unimportant.

Yup. That just about sums up my Ikigai,

You have cashes. You use caches in your head for short-term memory and in
unlimited places all throughout your computer and software and apps, whether
you know it or not. Local caches are big. Well, they're small, but they're big.
They're a good place to start technology-wise and on your adventure into Linux,
Python, vim and git.

What's suspiciously missing from my preferred platform of LPvg is something
that addresses long-term storage. How do the contents of variables used in your
program persist between program-runs? Do you "write" them somewhere?

Well, yes! Certainly, you do; either explicitly or implicitly. But you can't
store things forever. Eventually you run out of storage space. So why not keep
them small and make them expendable?

Sure, why not. But we can't call it a database, because it's okay if they
disappear. Okay, let's just imply a little bit of data stuck in a temporary
little nook. You mean like a squirrel squireling away nuts? Yes, exactly like
that! Well, we call that a cache.

Cashes are small, persistent memory-stores, plain and simple.

Imagine you have limited time to review things in your memory.

Having more available in your memory to review than time you had to review it
would be a waste. Recent things are more important to keep on-hand, and thus
short-term or addressable memory (yes, both computers and biological systems
like you). Remember that.

So the trick of conserving precious resources is to only have that which you
need to review on-hand and in-memory.

That is the allure of using caches, and so they're used a lot for the stuff you
access most. Least-used things get moved over to long-term memory or get
deleted.

Almost everything can be moved elsewhere, but for the most important things
that need be kept rapidly accessible on-hand.

Systems are generally optimized for nearby resources. Less goes wrong. Sorting
out what belongs in local-space versus some slow archive is always an issue. Do
you really need Amazon S3 or things like it?

Why not just use local fast or local long-term storage? Both are perfect caches
when you're developing applications like website crawlers or are collecting
data for analysis and machine learning.

All a database is is a cache with some assurances it isn't going away, for you
see caches tend to expire and be expendable.

Cache gone? No big. We'll just start re-populating it now. Sometimes they're
meant to expire and auto-delete in order to freshen the on-hand data.

Databases on the other hand are considered valuable long-term assets. That's
one factor driving the popularity of Cloud services. Who makes that persistent?
Amazon, Google, Microsoft and N-other companies. Happy to infrastructure for
you.

And there's this hybrid-service lock/in stuff going on with cloud providers. If
you use our proprietary storage for your data. can be read by our proprietary
processors without copying your data somewhere else. So long as you use us for
everything, components work together as if local to each other even though
you're using the cloud. How Google makes everything flow readily into BigQuery
is a perfect example. Cha'Ching!

It makes you part of their network, ecosystem, nervous center. They want you to
be a child of their corporation; a dependent. And yes, we are all dependent
creatures and we don't burn our computers from sand. But no, you do not have to
make yourself beholden to some other company for your ability to build and use
systems. Your self-worth skill-wise should be FOSS-based local resources first.

How to un-proprietary the incredibly Cloud-biased movement coloring every
tutorial and tool today? Choose your interfaces carefully. A Pytnon dict, yes.
The AWS S3 API? No! By using common timeless abstractions, you cal always wire
back in the kooky proprietary bits for this advantage or that.

You should use just enough abstraction to let you more or less forget about the
particular hardware or proprietary systems underneath that are being used.

Even most stuff running on the hard-metal without virtualization will have some
abstraction-layer so all the world's popular tools will work on them  just as
well as on divvied-out slices of a cloud datacenter.

So there's a lowest common denominator of systems. A system in this case is a
fully functional computer. That's where the timeless APIs reside. Learn to use
one local general purpose computer well. Tap all its local resources for what
there're worth, then move onto the cloud when you have to.

Persistence is always an issue. Persistence in caches is easy, especially if
you're tapping into the resources of your laptop or a typical cloud
infrastructure as a service (IaaS) like Amazon EC2. You always have some local
writable hard drive storage which you could use for a SQLite .db file.

That's my favorite kind of cache—the local kind using sqlite3 for optimized and
complied-C performance. And for that, all you need is a simple piece of local
hardware or a basic cloud server instance. They all have a bit of writable
drive space suitable for local cashes.

If you wrote your one local-like instance of a general computer well, then it
will scale. It might not have all the efficiencies in the world, but you can
always multiply that one instance times N. That's a valid approach to scaling.

And my latest work has been making one of these standard generic computers
available locally under Windows, accessible to the vast majority of
laptop-users out there. Let's face it, most people are in Windows and are not
going to replace it with Linux on the bare-metal.

I mean, why would you? You got Windows for free on the laptop and it makes it
able to run all modern PC games, and you'll have fewer driver, networking and
peripheral problems, because proprietary profit. YOU should profit from their
urgent need to give you a good experience to stay on their stuff.

Some proprietary is fine, so long as it's just wonderful widows-dressing for
the FOSS systems upon which you invest your livelihood, and indeed life. Being
literate in certain areas of FOSS will last a lifetime. Mastering the latest
Microsoft thing will last until they obsolete or redefine that thing.

So, let's learn local cashes.



## Categories

<ul>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/hardware/'>Hardware</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/2022/'>2022</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/sqlite/'>SQLite</a></h4></li></ul>