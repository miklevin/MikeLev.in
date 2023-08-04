---
date: 2022-06-22
title: Fixing Jupyter Desktop Set Python Environment Error Message
headline: Fix JupterLab-Desktop Error Message with Python 3.10.5 and venv pyw3105
description: I recently encountered an error message when using JupterLab-Desktop 3.3.4-2 and was able to fix it by installing the official Python 3.10.5 from Python.org and creating a venv named pyw3105. Read my blog post to find out how I did it and learn how to fix the Jupter Desktop Set Python Environment problem.
keywords: Jupyter, Desktop, Set, Python, Environment, Error, Message, Fix, Install, Official, Python.org, Venv, Pyw3105, Instructions, Readthedocs.io
categories: python, desktop, message, jupyter
permalink: /blog/fixing-jupyter-desktop-set-python-environment-error-message/
layout: post
group: blog
---


I'm currently JupterLab-Desktop 3.3.4-2 and got an error message I hadn't seen
since the last version 3.3.4-1 I had to skip (because of this error). But I got
it spontaneously on the latest version I've been using for months and I can't
let JupyterLab Desktop get taken away from me, so I decided to fix it.

Would have liked to have gotten back to LXD.

In my attempt to fix the Jupyter Desktop Set Python Environment problem, I:

- Installed the official (and best) Python 3.10.5 from Python.org
  - Not from the Microsoft store (much easier) (type python from com or
    powershell)
- I checked if venv came with the python.exe from python.org
  - It did
  - I could use it with carefully controlled paths to .\python.exe
  - And the use of the -m switch (arg or parameter)
  - I created a venv named pyw3105 in my C:\Users\[username]\pyw3105
  - Without source activate (the way you activate venv's)
- After I had that virtualenv, I was able to install the py 3.10 kernel
  - per the instructions at
  - https://ipython.readthedocs.io/en/stable/install/kernel_install.html
  - .\python.exe -m pip install ipykernel
  - I cd'd C:\Users\[username] ...because my venv resided here
  - .\python.exe -m ipykernel install --user --name pyw3105

And that "registered" the new Python 3.10.5 kernel with JupyterDesktop and it's
now my default (yay!)

To get JupyterLab working again, I believe it was a result of deleting the
JupyterLab config file:

  jupyterlab-desktop-data

Found in a Windows path like:

C:\Users\[username]\AppData\Roaming\jupyterlab-desktop

I am sorry I had to break this into two videos and that I went the long way in
fixing it. However, I'm very happy I'm on Python 3.10.5 in JupyterLab now.

Perhaps it was providence that it spontaneously stopped working (giving that
Jupyter Desktop Set Python Environment error).

# Part 1: The Failure

{% include youtubePlayer.html id="2IiizcGpv74" %}

# Part 2: The Success

{% include youtubePlayer.html id="MRGgahrrNAs" %}


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/livestreaming-question-answers-with-youtube-audience/">Livestreaming Question & Answers With YouTube Audience</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/on-being-unstoppable-apis-lxd-lxd-under-wsl2-success/">On Being Unstoppable, APIs & LXD / LXD Under WSL2 (Success!)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/desktop/'>Desktop</a></h4></li>
<li><h4><a href='/message/'>Message</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>