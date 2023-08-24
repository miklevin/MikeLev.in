---
date: 2023-02-02
title: Testing Google Photos Organization Program
headline: Exploring the Impact of Media on Society with Google Photos Organization
description: I'm testing a Google Photos organization system, uploading photos to my NAS, and setting up a home cloud to increase my storage capabilities. To get around certain API limitations, I'm using Microsoft Playwright browser automation on a headless LXD server. In this blog post, I discuss the impact of media on society and how it can be used to shape public opinion and create a more informed and connected society. Read more to find out my thoughts on this important topic.
keywords: Google Photos, Organization, API, Microsoft Playwright, Browser Automation, Headless LXD, Server, Media, Society, Public Opinion, Informed, Connected
categories: python, browser automation, microsoft playwright, google
permalink: /blog/testing-google-photos-organization-program/
layout: post
group: blog
---


Okay, so I am beginning to stress test this Google Photos Organization system
that I'm finally starting to cobble together. It's going to be an appropriate
thing to run overnight. Processing can take awhile and when you hit a busy
week, it could push the job to over-quotas. I need a better way to monitor
that.

So keep in mind and stay sensitive to the fact you can run out of API quota,
especially when you hit big media weeks.

Okay, so tonight is significant developing capabilities-wise on a couple of
fronts. First, I'm actually uploading from my phone to the NAS, even though
it's over 10K media items on the phone now. It goes back a few months since I
hit my 2TB limit on Google One Premium. I don't want to pay $20/mo for more
storage. I think storage is cheap. Its cheap enough to buy your own backup
redundancy. Primary home NAS is mirrored, but that's not a backup. That is just
a less corruptible main drive. Then you have at least 2 backups being made of
that, for a total of 3 copies.

You spend some time and focus making sure your backup procedures are pretty
good. But even those 4TB are going to get used up pretty quickly if we're not
careful. We're going for something like a seeming 10x increase in cloud storage
without upping from Premium. I hardly want to keep that, but 2TB cloud storage
is nice. Anyhoo, from iPhone to NAS through mobile app software able to do such
a task from phones now (wow) is just nearing completion. QFile does a good job
eliminating the need for non-home-cloud services. Make your own home-cloud
services and serve yourself.

I had some odd instances where apps stopped getting access to my photos and
media. It was like a sudden lock-down against hacking or something. I can
imagine rogue apps got elevated rights through upgrades and slurped down lots
of personal data like photo galleries, and now Apple takes OS-level defenses
against that. I feel tighter, more granular security in the latest iPhone OS
upgrade. That is good.

But still, its time to take more in-house. Not every image has to pass out
through the satellites and Internet to get back into your home from one box to
another. Yay, digital nervous system of the planet, but why if you don't have
to? Learn to do a little bit of processing with the resources you have at home.
I mean it will inevitably interact with the Internet. But it doesn't have to
lead with having to host your code elsewhere. First, self-host. Tap bigger
resources when you need them later. Just my opinion.

In another case of it not necessarily having to pass through the cloud every
time, I had to figure out how to share my Linux Chrome User-Data location from
my WSL laptop instance to an LXD container I run as my home Pipulate server.

Okay, so what's a Pipulate server. What is it to pipulate? Easy! It's just
running a lightweight local Linux machine somewhere like a server so you can
move things you've been working on in Jupyter to 24x7 automation. So I am sure
that in a lot of cases that's going to mean right on your Windows laptop where
WSL is running, and that's fine to start getting experience. Mock it up right
on your laptop and get it running exactly as it would on a server. Except it
isn't going to be running that reliably on your laptop, naturally.

Now the other front on which I have a first going on is that I'm using
Microsoft Playwright browser automation on a headless LXD server on my home
NAS. I was able to give it logged in session by archiving my local and known
working google-chrome user-data directory which is nearly a gigabyte! Sheesh!
Anyway it was too many small files to transmit readily even over a home
wireless network, so I zipped it into one big file on my laptop copied the zip
to the NAS, unzipped it native on the NAS and then gave the LXD server access
to that user data. And it worked. I can automate Google Photos and get around
certain API limitations, like not being able to delete media.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/where-to-begin-pickle-your-dicts/">Where to Begin? Pickle Your Dicts!</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/using-google-photos-api-to-generate-main-archive-favorite-media-lists/">Using Google Photos API to Generate Main, Archive & Favorite Media Lists</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/browser-automation/'>Browser Automation</a></h4></li>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li></ul>