---
date: 2022-10-01
title: Harmonizing a Windows-side Python Script with a Linux-side Python Script
headline: "Tackling a Complex Project: How I Harmonized a Windows-side Python Script with a Linux-side Python Script"
description: I recently completed a project on JupyterLab, LXD, and WSL that required 60K queries and the use of a VPN and Windows desktop client. To make the process easier, I created a Python-side script to check for the existence of a file. Read my blog post to find out how I tackled this complex project!
keywords: Windows, Linux, Python, Script, JupyterLab, LXD, WSL, VPN, Windows Desktop Client, PyWinAuto, Automation, File, Existence
categories: container, wsl, linux, microsoft, jupyter, python
permalink: /blog/harmonizing-a-windows-side-python-script-with-a-linux-side-python-script/
layout: post
---


I did a project last week that really tested my JupyerLab on LXD on WSL
approach. It was a SERP scraping job that had nearly 60K queries in all. Now
you can't do this just off your laptop without VPN, so I used VPN. Problem
being that the VPN software has a slick Windows desktop client from which I had
to cycle IPs but I couldn't issue the commands from Linux-side because the
Windows automation piece, PyWinAuto, doesn't run from Linux. It only runs from
Python under Windows! Catch-22 and right after I spent all that time getting
myself fully on Linux Jupyter!

So I simply made a Python-side script that checked for the existence of a file
indicating the IP was still good. Once the file wasn't there, the VPN software
acquired a new IP and the file was put back in place. Whenever the Linux-side
script realized the IP was no longer good, it deleted the file. And so I
harmonized a Linux-side Python script with a Windows-side Python script and it
was far better than doing the whole project under Windows again. I am resisting
re-installing Windows-side Jupyter at this point.

An interesting side-note is that I had uninstalled the Python 3.10.5 that I had
gotten earlier from Python.org and now I'm installing Python through the
Microsoft store to see if it keeps itself auto-upgraded. If not, I can update
all from the Microsoft Store and see what happens. As of the time of writing
this, it's Python 3.10.7 from the store.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/october-first-no-gamma-burst-so-far-so-good/">October First No Gamma Burst... So Far So Good.</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-walrus-the-carpenter-who-had-trouble-getting-to-solla-sollew/">The Walrus & The Carpenter Who Had Trouble Getting to Solla Sollew</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>