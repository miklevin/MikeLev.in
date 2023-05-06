---
date: 2023-02-02
title: The Crazy Old Batch Files Were Right
headline: Unlocking the Power of Browser Automation and Python 3 to Manipulate Media and Control Hardware
description: I recently used browser automation to work around Google Photo API limitations and am now attempting to slurp down all the images that have been uploaded to the cloud over the years, while keeping the Apple Motion data intact. I'm teaching people how to set up a Pipulate Free & Open Source SEO server on their Windows 10 or 11 desktop, leveraging the Microsoft Subsystem for Linux and Jupyter Notebooks. I'm also exploring how Python 3 will remain the final version of Python.
keywords: Browser Automation, Google Photo API, Images, Apple Motion Data, Pipulate Free & Open Source SEO, Windows 10, Windows 11, Microsoft Subsystem for Linux, Jupyter Notebooks, Python 3, Linux Graphics, Systemd Service Manager, Ubuntu Linux, Data Manipulation, Tech Mechanics, Real-Time, Hardware, Batch Files, Generic Hardware, Startup
categories: windows 10, windows 11, browser automation, jupyter notebooks
permalink: /blog/the-crazy-old-batch-files-were-right/
layout: post
---


Wow, yesterday's work on Google Photos was amazing. I used browser automation
to get around Google Photo API limitations, namely that you can't do
manipulations on any media that your app did not actually create itself. Ugh!
It's a really interesting issue. If you come up with something that will list
the IDs of images you want to manipulate as a group, you can't thrown them into
a new album you created unless you also created the media. Pre-existing media
can't even go into new albums you create! Wow.

All those images slurped up to the Google Photos cloud over the years. Can I
similarly slurp them down? Of course it was a little at a time here and there
slurping them up which makes it feel so fast and amazing, but in reality is
little batches spread out over a very long period of time. To have any sanity
slurping them back down, it's going to have to be similarly spread over time.

Process a week at a time, but a day at a time. If the week-folders end up
small, process more than a single week every day. Set yourself some sort of
range or quota limit. Look at what a single day should be able to accomplish.
Prepare to move it to the home cloud, pronto. This code is doing browser
automation of Google Photos and I want it to run headlessly.

The current week I'm processing has 3041 images. 2336 of those images are from
the archive, meaning those will get deleted from the Google cloud. That was a
particularly busy week.

I turned off the delay, turned slow motion to 0 and headless to True, so let's
see how long deleting 2336 files takes.

Hmmm. A major concern in this project is keeping all the Apple Motion data
intact.

Okay, the mime type for Apple motion video is image/heif

There's also the more common image/heic format.

Keep in mind this logic for a better way to retrieve files. Trying this should
be my first order of business, and then checking whether what's fetched has the
Apple live photo video contained. Don't forget your Amiga IFF lessons.
Regardless of what your viewer shows you, anything could be in there.

I'm convinced that the frequent HEIC files are the full Apple live images. I
think the file sizes are about right and what they say about HEIC and HEIF
being nearly interchangeable these days, chances are everyone just keeps using
the HEIC extension even if it's mime time is image/heif. So that means my
project can proceed pretty cleanly.

Since this is Jupyter Notebook based, at least for now while in development,
it's important to understand that a big storage location is necessary. You
likely are either going to want a large external drive that you have to keep
lugging around, or better yet, network attached storage, or a NAS. I'll be
using a NAS. But it takes so long to process data on a NAS, the idea is that
we'll shuttle it off over there once we're done the important things local,
right on your laptop. One week's worth of data is sized just about right to
always fit on your laptop. If not, how much media could you really be
producing? A few thousand media files in a week totalling 2 or 3 gigs of data
is the most you'll ever want to process on a modern local machine.

The delete part of the process, probably more accurately called the "Move to
Trash" part of the process is agonizing to sit through, and I certainly want it
off my laptop. The NAS will be highly utilized in this project.

Okay, this is going to merit it's own special page to promote this project soon
enough, or maybe I'll just keyword-cluster up topic pages and Google Photos
will be one of them. Anyway:

My Google Photos API through Jupyter Notebooks project has leapt forward over
the last couple of days. It's being shaped by my discoveries as I go. Google
Images isn't a service that you get off of easily once you're a few terabytes
in, but I'm determined to do so using JupyterLab and Python.

This Google Photos API and browser automation project touches on so much that's
kinda sorta almost-SEO, such as manipulating data and dealing with different
systems and gotchas, that it seems a good place to start teaching generic tech
mechanics.

So much of SEO is the use of generic and broadly applicable data manipulation
tools against a broad assortment and quantity of data. Folks like to say ETL in
the tech field, standing for extract transform and list. While I don't agree
with that order, that's what we are… SEOs. We're human ETLs, on the fly, spin
the wheel of data source, describe a process. I'll engineer it. No teams. No
sprints. No squats. I just Pytnon Notebook it on up.

So you're in the $99.99 / year 2 TB Premium Google One plan and you thought
you'd never use up 2TB of storage. I mean that's still considered a fairly big
drive in the stores, right? What's that? A 4TB drive is $50? But what about how
safe my data is? Safe, how? Safe from accidental data loss? Or safe from
accidental data leak? Neither' aa great option, so I'm going to strike a nice
compromise that will also have the benefit of easing you into your daily Python
scripts.

So, Organize Yourself, and get off Google Photos — eventually. Our primary goal
is really just a big-time pruning. Let's say over the years you've been sending
things to the archive. Briefly Google Photos experimented with renaming it to
Hide. Photos and videos moved to the archive stop showing in the main list. But
if any archived images are use in albums, they will still appear. They also
appear in search and image recognition starts recognizing same faces and makes
groups.

Uhhh, yup. George Orwellian 1984 but in reverse is here. They hardly need to
push their screens into our homes when we're pushing the digital memories of
our lives onto their computers. When did this happen? We'll, the frog's been
cooked. Luckily, it's not too late to reverse entropy. Ply the role of
Maxwell's Demon by writing Linux daemons—no, don't go running! I'm being
completely cerial. You on Windows 10 or 11 can do this neat trick.

This is a good project. It leverages the best Microsoft Subsystem for Linux, or
WSL. It uses the fact that both Linux Graphics and the systemd service manager
has come to the default Ubuntu Linux distro that Microsoft provides in order to
uniquely deal with logins, both through the web user interface and through the
API. Jump through less hoops to get exciting results quick. Organizing Google
Photos, perchance to learn some tech, is a great way to start.

I believe that many of you have been wanting to do this particular kind of
de-cloud-ification project for awhile and have just not known where to start.
Well you start right here. I'm finally getting around to it and am hereby
sharing it with you as the free introductory chapter to my FOSS SEO book,
server recipe & set of Python Notebooks that constitute Pipulate.com.

Set up a Pipulate Free & Open Source SEO server, or just a Pipulate Server for
short. Set one up on your Windows 10 or 11 desktop. Start communicating with it
through Jupyter Notebooks. A hand full of notebooks reflect live jobs that are
really there running 24x7 on your behalf, completely unreliably on your
laptop—oh, but when you move it to run also on some NAS or RaspberryPi or
anything that can run Linux with a net connection in your home, then watch out!
Your capabilities really take off. And yes it's a challenge getting over that
hump.

I'm going to teach you a few things old school. Old's kewl, and I'll keep
telling myself that. Mikey likey muscle memory, so when things change on me
needlessly and screws up my hard-won mapping, I get pissed. Tech is like being
a taxi driver who has to move to a new city every 2 to 5 years. That's hardly
enough time to learn the streets of a city inside our, much less a modern tech
tool.

Those in the Python community have just said no. Python 2.6 is all we will ever
need. Actually, they let it go to version 3.11. That's 11 releases into version
three. That numbering system expands infinitely. There may never be a Python 4.
The final shape of this strange Nunchaku weapon that is Python is finally
emerging.  And it definitely includes Unicode. But little else appears weighty
enough to break backwards compatibility. I like this about Python.

Python built on Linux captures a tempest in a teapot. That this runs on your
Windows desktop now with a "for humans" Linux system manager now standardized
is reason to rejoice that precisely nobody gets. It's being drown out by
ChatGPT.

Old school means batch files. And batch files were an advance over mechanical
toggle switches. Real-time is an illusion. It's just low latency and small
caches. Don't let everyone trick you. Hardware loads files. Hardware runs
files. We're lucky we can control what's on those files, because by doing so we
can control the entire machine. And it need not be a Mac or Windows laptop.
You'll just genetically be able to control hardware that's held together with
text files. We will write those batch files together and control generic
hardware from startup.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/numbering-weeks-from-utc-zero-vs-your-birthday/">Numbering Weeks from UTC-Zero Vs. Your Birthday</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/where-to-begin-pickle-your-dicts/">Where to Begin? Pickle Your Dicts!</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/windows-10/'>Windows 10</a></h4></li>
<li><h4><a href='/windows-11/'>Windows 11</a></h4></li>
<li><h4><a href='/browser-automation/'>Browser Automation</a></h4></li>
<li><h4><a href='/jupyter-notebooks/'>Jupyter Notebooks</a></h4></li></ul>