---
date: 2023-02-07
title: Backup Google Photos to Self Hosted Alternative
headline: "Backing Up Google Photos: Exploring Self-Hosted Alternatives"
description: I have created a program to back up my Google Photos, combining two scripts into a single file. I am now considering whether to keep the program as an nbdev app, and am exploring options to transition it from a notebook to a server. I am also considering not using the app in my FOSS SEO book, but recognize the value of the Jupyter Notebook under nbdev. Come read about my journey to make the best decision for my program!
keywords: Backup, Google Photos, Self Hosted, Alternative, Program, nbdev, App, Notebook, Server, QNAP, Container Station, Upgrade, Container, Metaphor, Tutorial, FOSS, SEO, Book, Jupyter
categories: jupyter, qnap, container, nbdev, google, seo, tutorial
permalink: /blog/backup-google-photos-to-self-hosted-alternative/
layout: post
---


Are you looking for a self-hosted Google Photos alternative but have invested
many years and thousands of images into Google Photos? Are you on the 2TB plan
but have run out of space, facing $20/mo cloud storage extortion racket? Have
you looked for ways to switch, but everything would lose albums, favorites,
resolution, or meta data? Do you love the Google Photos app but are looking for
a reasonable way to get off of Google Photos over time? If so, then you've come
to the right place!

You address many issues when you finally make the commitment to move off of
Google Photos. In fact, you address so many issues that it appears to me the
ideal place to get a modern technology education, especially in light of rising
AI. If you don't get your pictures off Google Photos, their AI-models are going
to be learning from them and answering questions about how to market to you or
manipulate you better based on your most personal data, your media library.
Perhaps only Alexa-like devices that listen all the time have better input.

## Hide your sensitive photos & videos

Google's strategy with Google Photos has been similar to Apple's. Pose the
service as fundamental and obviously called-for: backing up your photos, videos
and other media automatically, relentlessly, and for the most part silently and
in the background. Rapidly growing adoption of multi-factor authentication has
lulled us into a false sense of security, but we see it's not fully addressed
due to the implementation of the Google Photos locked folder for sensitive
photos and video. Also, Apple recently made their local hidden album password
protected in case someone gets a hold of your unlocked phone.

The Google Photos locked folder feature is only available on Android phones, so
it really doesn't solve the problem. The master copy of anything not
cloud-synced is instead highly vulnerable on a phone you carry around with you,
and the sensitive stuff gets put instead into your phone backups. That has its
own set of issues from whether you really actually back up your phone, to the
security of the backup. Neither Google's folder nor Apple's hidden album is a
good solution.

I now have 2 really cool components of this project. I've been ignoring albums
for awhile, but don't forget this code:

```python
h1("Save Albumn Belongings")
# Warning: Takes Forever to Run. Find a way to optimize.
belongdb = f"photos/db/belonging.db"

table = []
with sqldict(belongdb) as db:
    albums = df.to_records(index=False)
    albums = [tuple(x) for x in albums]
    for i, album in enumerate(albums):
        name, album_id = album
        print(i, name, album_id)
        npt = None
        while True:
            args = {"albumId": str(album_id), "pageSize": 100, "pageToken": npt}
            results = service.mediaItems().search(body=args).execute()
            table += [x["id"] for x in results["mediaItems"]]
            npt = results.get("nextPageToken", None)
            if not npt:
                break
        db[album[1]] = table
        db.commit()
```

This is a raw data capture of the album belonging data. This is kind of a big
deal if you have done lots of album organization inside Google Photos. I've
stripped it out of the files that are running regularly now.

Hmmm, I have them both as systemd services ad for the first time, delete.py
looks like it caught up with core.py (which I should probably rename).

I've combined the 2 scripts:

- One that downloads Google Photos
- One that moves everything in archives (minus favorites) to Trash

...into a single googlephotos.py file which is systemd friendly.

The program is in a state now where it runs really well and it would only be
confusing to keep parts of it in Jupyter Notebooks, LOL! So it turns out I used
nbdev primarily so that I could do the initial development in nbdev.

This brings up the question, do I keep it as an nbdev app? It seems like a lot
of overhead for something that now will likely never go back to a notebook. If
I do this, I have to (should) change the subfolder arrangement in the repo and
change the reference in the service. It gets rid of a redundant directory
level. Yes, this is the way this should go.

Do the work directly on the server. It's worth noting that I actually upgraded
QNAP's Container Station right while the googlephotos daemon was running and it
popped right back running after the upgrade. Nice. I should probably consider
creating an entirely new container and moving everything from one to the next.
I should also show strong metaphors for what this process looks like. Ghost in
the machine and all that. Meaningless hardware and a small soul-nugget of apps
that get moved around with just a few repos and services.

Another thing is now that this app is pulled out of notebooks, it may not be as
suitable as I thought for a first tutorial in my FOSS SEO book. Maybe it's just
as well. It brings up too many issues and should be its own thing. I should
maybe carry through on my plan.

In a world where there is basically infinite free information available for you
to consume, how does someone who has content to offer you make money?

Position yourself has the hottest next-generation SEO.

Best AI SEO Tools?

Hmmm, maybe.

But for now, get on with the googlephotos.py cleanup. When I combined all my
package imports, I had a mess.

```python
libs = """import ohawf
import pandas as pd
from httpx import get
from pathlib import Path
from random import randint
from collections import namedtuple
from apiclient.discovery import build
from sqlitedict import SqliteDict as sqldict
from datetime import date, datetime, timedelta
from shutil import copyfile, move, copytree, rmtree
import asyncio
from time import sleep
from headlines import *
from shutil import move
from pathlib import Path
from random import shuffle
from datetime import datetime
from sqlitedict import SqliteDict as sqldict
from playwright.sync_api import Playwright, sync_playwright""".split("\n")

alist = [(len(x), x) for x in libs]
alist.sort()
seen = set()
for item in alist:
    if item not in seen:
        print(item[1])
        seen.add(item)
```

Which prints:

```python
import ohawf
import asyncio
import pandas as pd
from httpx import get
from time import sleep
from headlines import *
from shutil import move
from pathlib import Path
from random import randint
from random import shuffle
from datetime import datetime
from collections import namedtuple
from apiclient.discovery import build
from sqlitedict import SqliteDict as sqldict
from datetime import date, datetime, timedelta
from shutil import copyfile, move, copytree, rmtree
from playwright.sync_api import Playwright, sync_playwright
```

Hmmm. I think I can see how the Jupyter Notebook under nbdev is still going to
be valuable in this process. It's in ***TEACHING*** what's going on in a
Pipulate server. It's a learning tool. It doesn't have to be the live running
code, so long as the live running code on the server has been precisely
extracted from it.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/the-ais-will-find-you-if-you-re-unique/">The AIs Will Find You If You're Unique</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/used-twitter-4000-characters-for-machine-learning-general-license/">Used Twitter 4000 Characters For Machine Learning General License</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/qnap/'>QNAP</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/tutorial/'>Tutorial</a></h4></li></ul>