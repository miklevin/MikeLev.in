---
date: 2023-01-10
title: Joining URLs across GA, GSC & Majestic
headline: Embarking on a Data-Joining Adventure with Majestic SEO Link Data!
description: I'm embarking on a project to create a master-list of URLs with Majestic SEO link data, using sqldict, list comprehensions, fstrings, JupyterLab, Linux, Windows, and async Python page-fetching. I'm using client.get(url) to retrieve data from a table, and have printed out the data to confirm it was correctly retrieved. Come join me on my journey!
keywords: GA, GSC, Majestic, sqldict, list comprehensions, fstrings, JupyterLab, Linux, Windows, async, Python, page-fetching, client.get, url, responsedb, loop, store, retrieve, confirm
categories: python, loop, jupyter, microsoft, linux
permalink: /blog/joining-urls-across-ga-gsc-majestic/
layout: post
group: blog
---


Okay, new day new project. It's the big URL project.

Okay, it's time to make a master-list of URLs for a network of sites and join
it to Majestic SEO link data. That means GSC, GA and Majestic. "Empty out" the
active URLs for each. Actually, first enumerate all data-sources using what the
account can access, filtered by a list of Google Analytics profile ids and
GSC-style domains. I've done all that lately. Majestic will probably be the
hardest part. Think! I've got that code somewhere.

I'm liking just reading text files for the lists of IDs and stuff. Where does
this belong? Practice_safe!

Okay, this should be the most elegant instance of me stepping through Google
Analytics data, emptying out as much as I can based on nextPageToken.

We're going to be doing fast raw data capture again. And I'm going to be doing
the tuple approach again (I think).

Find the maximum number of URLs that can be dumped for a site.

In this case I think I'll make the tuples as I go. What should they be like?

GA is letting us pull way more URLs than it used to using nextPageToken, so we
have to limit it somewhere reasonable when "tasting" URLs across the network...
purpose?

This would dump out data forever it seems. It got up to 160K before I stopped
it.

```python
npt = 0
with sqldict("ga.db") as db:
    for profile in profiles:
        print(profile)
        while npt != "Done":
            response = ga(query(profile, npt))
            try:
                npt = response["reports"][0]["nextPageToken"]
                print(npt)
            except:
                npt = "Done"
            key = Args(profile, npt)
            db[str(key)] = response
            db.commit()
                break
```

Okay, that could go on forever. It got to 160K on one site before I stopped it
for fear of rate quota exceeded. Think! Use your tried-and-true tuple approach.

Alright, I have a much better approach working. We need to work with finite API
calls, and so we create the tuples with None where no data was yet collected:

# Create the keys for uncollected data

```python
with sqldict("ga.db") as db:
    for profile in profiles:
        profile = int(profile)
        for npt in range(0, 50000, 10000):
            arg = Args(profile, npt)
            if str(arg) not in db:
                print(arg)
                db[str(arg)] = None
        db.commit()
```

This will show what has data so far:

# Show what has data

```python
with sqldict("ga.db") as db:
    for key in db:
        data = db[key]
        display = "fetched"
        if data == None:
            display = None
        print(key, display)
print("Done")
```

Everything is highly interruptible.

Think about the GSC query.

Fast-forward.

Wow, end of a long work day. Adi was with me until this morning.

It's really nice having sqldict's, list comprehensions and fstrings all at my
finger-tips in JupyterLab running in Linux on a Windows desktop. Stuff is
getting interesting. My day-to-day is getting up to data-collection, given a
list of URLs. So why not get ahead of this? Make an example of it. Get some
practice in.

Let's make it impressive when it happens. It's not even 8:00 PM so the night is
young. The tuples-for-life project still calls out to me for my discretionary
time, but there's so much overlap, it matters not. Engage!

1, 2, 3... 1? Name the file. I renamed an old file I did to
sequential_crawler.ipynb. That will differentiate it nicely from what's to
come. But this may actually become the same project and file. I'm starting the
new one at the bottom of that one.

Okay, we're making it some awesome async Python page-fetching.

https://www.python-httpx.org/async/

Whoahhh. After a bit of study, I think I have my most rapid-fire way of
collecting data yet:

```python
# Fetch All Pages All At Once
responsedb = f"{data_folder}/responses.db"
async with httpx.AsyncClient(headers=headers) as client:
    apromise = gather(*[client.get(url) for url in table], return_exceptions=True)
    with sqldict(responsedb) as db:
        for response in await apromise:
            db[str(response.url)] = response
        db.commit()
```

I can confirm that the data was pulled with this:

```python
with sqldict(responsedb) as db:
    for i, url in enumerate(db):
        response = db[url]
        print(i, url, response)
```

And we're going to want to soup the shit of of this.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/automating-2fa-web-login-via-microsoft-playwright/">Automating 2FA Web Login via Microsoft Playwright</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/planning-big-crawl-jobs-on-a-little-laptop-chunking/">Planning Big Crawl Jobs On a Little Laptop (Chunking)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/loop/'>Loop</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>