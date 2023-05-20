---
date: 2022-11-30
title: Clear Screen, Clear Mind... Focus, Focus, Focus!
headline: "Discovering Linux: Striving to Reduce Noise and Focus on What Sparks Joy"
description: I am writing a Linux install script for Windows 10 or 11 users, and taking the time to reboot my system each morning to focus on what sparks joy, motivation and momentum. I am also striving to reduce surface area, factors, variables and general noise. I am passionate about Linux and its many features, such as security, flexibility, and scalability, making it a great choice for a variety of applications.
keywords: Linux, Windows 10, Windows 11, Reboot, Focus, Joy, Motivation, Momentum, Noise, Features, Security, Flexibility, Scalability, Online Courses, Reading Resources, Forums, Repos, SimpleNotes, Open Source, Operating System, Community, Developers, Users, Stability, Customizability, Hardware, GNU, GNU Linux, GNU Project, GNU Public License
categories: linux, joy, motivation, gnu, open source, success, microsoft
permalink: /blog/clear-screen-clear-mind-focus-focus-focus/
layout: post
---


On both Unix and Linux, it's clear. On PowerShell, it's both clear and cls. On
a DOS window (a.k.a. Command Prompt), it's only cls. So if you're writing a
Linux install script for Windows 10 or 11 users as I am with DrinkMe Linux, you
use the cls command between "Hit Enter to Proceed" prompts, except of course
when you want that falling down a rabbit-hole effect.

I reboot my system almost every morning when I get started. I don't have to.
Windows now has just as much ability to not require a reboot for ages as Macs,
but I prefer a clean slate. It promotes new thought. Stuff that's not important
but poses as important by squatting in your attention-space now has to reassert
itself as important, and sustained over time, truly important stuff surfaces.

I try to delete out all my notes from SimpleNotes all the time so that what
remains is the stuff I really want to act on. Having an archive isn't bad. It
just shouldn't be cluttering your mind on every interaction. We strive to
reduce surface area, factors, variables and general noise. We try to focus
those things that spark joy, fuel motivation and continue momentum.

Recently my most prevalently used storage-location for active work had been
"github". I changed it to "repos" because not all repos you create are
necessarily pushed up to Github. Freeing yourself from dependence on Github
using a self-hosted GitLab will be one of the topics covered here. Not in some
"wouldn't that be nice" tutorial, but by bottling it. It will be one of the
best types of apps to do early and break off from a local WSL-based Linux on
your laptop onto some server located in your house whose files are backed up
with a 1, 2, 3 strategy. It's the right type of dependency-reducing
meta-project that makes all the difference.

Okay, but I'm getting ahead of myself. All I really want to do is clear out my
repos directory. I want it to be good for the videos I'm likely to shoot here.
And keep in mind it could be on this laptop or on other laptops you have at
home. Your dev platform has now gone entirely portable, thanks to WSL install
scripts that are capable of doing all your pip-installs, apt-installs and git
cloning. It's better to rebuild a server from scratch than to try to copy an
image of the entire container around. Just run a small script which assembles
everything together, right down to and including your latest work in git repos.

Let's show the nice folks why Systemd!

But now the whole pulse thing is just on my "remote" local server (an LXD
container on my QNAP NAS Network Attached Storage).

Time to show 'em git! I can get it on my laptop then wrap it into DrinkMe
Linux. Interestingly, any thing I do in repos can be part of the FOSS product.
But that's just maintenance.

So many directions to go! Work has to take priority and I just got a GA/GSC
request, and that belongs in DrinkMe Linux... your path to not being an
imposter in the field of SEO. OAuth2 rears its ugly head again. My
flow.run_console() approach continues to work, but only with great effort
taking it out of production-mode and white-listing an explicit list of email
addresses. Ugh! Look at what other people are doing...

Okay, went down a shallow rabbit hole with pydata-google-auth
https://pypi.org/project/pydata-google-auth/ which covers a lot of the same
issues as ohawf.

Ugh, I'm all over the place in my mind right now because the requests from work
bring me one direction then another. Think! Make things clear. Make things
easy.

Ugh, I've really got to clear my mind. Work from MikeLev.in homepage out.
Figure everything out. Use the flexibility of your trimmed-down system to trim
down even more and then flesh things back out again, per current realities.

Playing with OpenAI. Stimulate some ideas:

## What are people search for most in Google

1. News
2. Weather
3. Videos
4. Images
5. Maps
6. Shopping
7. Flights
8. Sports
9. Restaurants
10. Directions

## What are people interested in about Linux?

1. System administration
2. Open source software
3. Security
4. Operating system design
5. Command line tools
6. Networking
7. Scripting
8. Programming
9. Automation
10. Server management

## Are people interested in Linux?

Yes, many people are interested in Linux. It is a popular open source operating
system with a strong community of developers and users who are passionate about
its use. Linux is popular for its security, flexibility, and scalability,
making it a great choice for a variety of applications.

## How do you learn Linux?

1. Take online courses or tutorials
2. Read books or online resources
3. Join forums and ask questions
4. Install Linux and practice using it
5. Use virtual machines to experiment safely
6. Take a certification course
7. Attend conferences and workshops
8. Watch YouTube videos and webinars
9. Participate in hackathons and competitions
10. Follow Linux-related blogs and publications

## Can AI write better than humans?

No, AI cannot write better than humans. AI is only as good as the data and
algorithms that power it. AI may be able to produce content faster or more
efficiently, but it lacks the subtle nuances and creativity that humans can
bring to writing. AI may be able to help humans with grammar, spelling, and
other aspects of writing, but it cannot replicate the emotions, insights, and
stories that make writing unique.

## What are the top things people like about Linux?

1. Security: Linux is renowned for its high levels of security, with strong built-in tools that help protect against malicious attacks.
2. Customizability: Linux offers unprecedented levels of customizability. You can pick and choose the components you want and build a system that fits your specific needs.
3. Open Source: Linux is open source, meaning anyone can access the source code and modify it for their own use.
4. Stability: Linux is known for its stability, meaning it rarely crashes or freezes.
5. Compatibility: Linux is compatible with many hardware components, including older hardware.
6. Cost: Linux is free, so it’s an affordable option for those on a budget.
7. Community: Linux has a large community of users and developers who provide support, troubleshooting help, and tutorials.
8. Flexibility: Linux is flexible and can be used for a variety of tasks, such as web hosting, media streaming, and gaming.

## Explain Linux to me.

Linux is a free and open-source operating system. It is based on the Linux
kernel, an operating system kernel that was first released in 1991. Linux is
widely used in servers, mainframes, supercomputers, and desktops. It can be
used for a variety of purposes, including web hosting, media streaming, gaming,
and more. The Linux kernel is released under the GNU General Public License and
is free for anyone to use, modify, and redistribute. Linux is popular for its
stability, security, customizability, and compatibility with a wide range of
hardware components. It also has a large community of users and developers who
provide support, tutorials, and more.

## Why do people still use Windows?

People still use Windows because it is a well-known and widely used operating
system. It has a long history of providing users with a reliable and secure
platform for their computing needs. It is also compatible with a wide range of
hardware components, and its interface is familiar to many users. Windows also
offers a variety of apps and services, such as Office 365 and cloud storage,
that are not available on Linux. Additionally, many applications and games are
designed to run on Windows, making it the platform of choice for many users.

## Are people going to use Windows forever?

No, people are not going to use Windows forever. As technology continues to
advance, new operating systems and technologies are being developed to meet the
needs of users. Linux is becoming increasingly popular, and there are also
other alternatives such as MacOS and Chrome OS. Additionally, cloud computing
is becoming more popular, which makes it easier to access applications and
services without the need for a dedicated operating system. As new technologies
emerge, the usage of Windows is likely to decline.

## Is Linux an operating system?

Yes, Linux is an operating system. It is based on the Linux kernel, which was
first released in 1991. Linux is free and open source, meaning anyone can
access the source code and modify it for their own use. It is widely used in
servers, mainframes, supercomputers, and desktops. It is popular for its
stability, security, customizability, and compatibility with a wide range of
hardware components. It also has a large community of users and developers who
provide support, tutorials, and more.

## Is Linux a Desktop operating system?

Yes, Linux is a desktop operating system. It is based on the Linux kernel,
which was first released in 1991. Linux is free and open source, meaning anyone
can access the source code and modify it for their own use. It is widely used
in servers, mainframes, supercomputers, and desktops. It is popular for its
stability, security, customizability, and compatibility with a wide range of
hardware components. It also has a large community of users and developers who
provide support, tutorials, and more.

## What is a Desktop operating system?

A desktop operating system is a type of operating system designed to run on
computers and other devices with a graphical user interface. They are usually
based on the same foundations as server operating systems, but they are
designed to be used by a single user at a time. Common desktop operating
systems include Windows, MacOS, Linux, and ChromeOS. They are responsible for
managing the hardware resources of the computer and providing an environment in
which applications can be run.

## What is GNU Linux?

GNU Linux is a type of Linux operating system that is based on the GNU project.
It is one of the most popular types of Linux, and it is used on a variety of
computers and devices. The GNU project is a software project that was created
in 1983 by Richard Stallman to provide an open source operating system that
would be free of any proprietary software. GNU Linux is distributed under the
GNU General Public License, which means anyone can access, modify, and
distribute the software.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/become-aware-of-how-tech-churn-harms-you/">Become Aware of How Tech-churn Harms You</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/much-starts-with-the-ability-to-create-and-use-local-caches/">Much Starts With the Ability To Create and Use Local Caches</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/joy/'>Joy</a></h4></li>
<li><h4><a href='/motivation/'>Motivation</a></h4></li>
<li><h4><a href='/gnu/'>GNU</a></h4></li>
<li><h4><a href='/open-source/'>Open Source</a></h4></li>
<li><h4><a href='/success/'>Success</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>