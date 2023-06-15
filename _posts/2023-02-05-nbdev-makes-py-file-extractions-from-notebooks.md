---
date: 2023-02-05
title: nbdev Makes .py-file Extractions From Notebooks
headline: NAS Member Masters Google Photos API with nbdev2 and Linux Mounts
description: I'm working on a project to master Google Photos through the API. To do this, I'm introducing nbdev2 and using Linux mounts to synchronize my WSL Linux ~/data directory on my Windows laptop with my ~/data directory on the NAS LXD server. As a member of the National Academy of Sciences (NAS), I'm proud to be part of an organization that promotes excellence in scientific research and works to advance science for the betterment of humanity.
keywords: nbdev, Google Photos, API, Linux, WSL, Windows, NAS, LXD, National Academy of Sciences, NAS, non-profit, scientific research, advance science, humanity
categories: nbdev, container, wsl, microsoft, python, google, linux
permalink: /blog/nbdev-makes-py-file-extractions-from-notebooks/
layout: post
group: blog
---


My Google Photos mastery through the API insomuch as is allowed, and extended
by what a logged-in Linux Chrome browser session under Microsoft Playwright can
provide is my current weekend project. Pshwew, that was a mouthful! Key parts
are built and runnable already. Housekeeping remains. This post is about that
housekeeping.

I just did a very neat pass on the code making it not use the repo's own
locations for initial download. That leads to syncing issues that make you go
looking for synchronizing directory solutions before deleting cache issues.
That's no good. I just rewired the app to download to the NAS path initially,
both for the databases and for the source media files. All data belongs to NAS.
Okay, next step... hmmm.

It's the delete-work of course, which is working but wired-up one way. I have
to wire it up another way and keep it working.

This is also the perfect time to bring nbdev2 into the picture. I don't want to
synchronize a notebook and .py file. And I may occasionally want to do my edits
on the .py file and have those flow back up to the Notebook. nbdev can do that,
I'm led to believe. It works so well on its other promises, I'm going to move
ahead with nbdev. Think! Next step then is to initialize it as an nbdev
directory. It's worth doing a pip upgrade first:

    pip install -U nbdev

And I'm now on:

    Successfully installed nbdev-2.3.11

Sweet. Okay, the logic goes like this:

Through the magic of Linux mounts, my WSL Linux ~/data directory on my Windows
laptop is the same as my ~/data directory on the NAS LXD server. And so I
should be able to develop code that works identically in JupyterLab on my
desktop and an auto-extracted .py-version of that Notebook on the NAS LXD
server. This is very nice indeed. Okay, so first I go to the gphotos folder
and:

    nbdev_new

It goes through it's init dance, asks me to type in a description, and voila!
It's full of folders. The one of interest to us is nbs. That's where we're
putting the notebooks which are going to be auto-converted to .py-files. The
00_core.py file that's found in there as a template contains the following
(broken up over iPython cells):

```python
# core

> Fill in a module description here

#| default_exp core

#| hide
from nbdev.showdoc import *

#| export
def foo(): pass

#| hide
import nbdev; nbdev.nbdev_export()
```

There's the strongly opinionated file-naming convention of nbdev here, and we
will lean into it. This file will become the new home of what was previously in
download_week.py in its best working form. That all gets cramed now into the
cell tagged "export".

Wow, it's working. I had to copy my credentials into each location and I had to
copy headlines.py into both locations. But that's a small price for such a huge
leap forward. Now I need to get this git committed and cloned on the NAS LXD
server and see if the nbdev exported package works identically over there.

Simplify paths. Have paths work identically across different instances. Keep
local data to a minimum. Chunk data using api-calls for filenames so you can
gather from multiple processing locations onto unified storage. Name your
chunked files to be glob friendly.

Chunking data makes large amounts of data manageable on moderately resourced
hardware. Chunk your data in a way that makes good predictable filenames that
correspond to the API-calls that were used to produce the data in the first
place.

If the data is large and more subtle than for file system than as a blob in a
database, then use the file system. Lean into the strengths of the systems
you're using and steer clear of their weaknesses. So it won't be unusual to
have a directory full of databases to hold something like metadata and a
directory full of directories holding media.

Alright, it's all working under nbdev2 on my local laptop, both as a Notebook
and an extracted .py-file. Time to git commit, push and hop on over to the NAS.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/expanding-my-google-suggest-jupyter-notebook-to-include-stop-words/">Expanding My Google Suggest Jupyter Notebook to Include Stop Words</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-ais-will-find-you-if-you-re-unique/">The AIs Will Find You If You're Unique</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>