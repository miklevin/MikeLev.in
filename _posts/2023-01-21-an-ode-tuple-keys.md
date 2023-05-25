---
date: 2023-01-21
title: An Ode Tuple Keys
headline: Exploring the Power of Tuples in Python and Web Crawling
description: I'm downloading an update for Windows 10 Version 22H2 and transitioning to Linux, using the power of NT's 'rings of protection'. I'm running Web browser automation under Microsoft Playwright and using iPython Notebooks under JupyterLab running on Linux. I'm also exploring the usefulness of tuples in Python, and looping through a database of URLs to extract data and create a table which I'm writing to a parquet file.
keywords: Windows 10, Version 22H2, Linux, NT, Rings of Protection, Web Browser Automation, Microsoft Playwright, iPython Notebooks, JupyterLab, Python, Tuples, URLs, Database, HTTP Response Code, HTML Parsing, Title, Description, Headlines, Body Copy, Parquet File
categories: python, linux, microsoft playwright, tuples, database, microsoft, jupyter
permalink: /blog/an-ode-tuple-keys/
layout: post
---


Okay, think! Oh yes:

2023-01 Cumulative Update Preview for Windows 10 Version 22H2 for x64-based Systems (KB5019275)

...is downloading in the background. I'm sure I'll have a chance to save this
before an automatic reboot, right? I feel transition occurring. Microsoft is
using the power of NT's "rings of protection" to slide Linux in, and perhaps
one day slide WindowsAPI out, but for a desktop windowing shell for Linux like
Cocoa is for Apple on Macs. Who cares what manages your windows, so long as it
works every time and can look like the premium version of the thing?

This is why Linux X-Windows based graphics are feeling a bit crusty. The
influence of X is clear: slow, clunky updates. The influence of Wayland, which
is allegedly in there to speed things up, not so much. Yet, Web browser
automation under Microsoft Playwright under Linux works well. I'm running such
automations directly from iPython Notebooks under JupyterLab running on Linux
as a service under gnu screen under systemd.


2023-01 Cumulative Update Preview for Windows 10 Version 22H2 for x64-based Systems (KB5019275)

...is downloading in the background. I'm sure I'll have a chance to save this
before an automatic reboot, right? I feel transition occurring. Microsoft is
using the power of NT's "rings of protection" to slide Linux in, and perhaps
one day slide WindowsAPI out, but for a desktop windowing shell for Linux like
Cocoa is for Apple on Macs. Who cares what manages your windows, so long as it
works every time and can look like the premium version of the thing?

This is why Linux X-Windows based graphics are feeling a bit crusty. The
influence of X is clear: slow, clunky updates. The influence of Wayland, which
is allegedly in there to speed things up, not so much. Yet, Web browser
automation under Microsoft Playwright under Linux works well. I'm running such
automations directly from iPython Notebooks under JupyterLab running on Linux
as a service under gnu screen under systemd.

I can design a system service, which is the heartbeat of a system. I can decide
how often it wakes up to do a thing. It is a homunculus you're using
incantations to conjure out of the earth and sand of your computer. It's just
that as running Windows, the design of such homunculus was ridiculous. Systemic
automation with a desktop OS as a dependency is a ridiculous homunculus. I
propose almost just such a homunculus, only just a little less ridiculous.

Linux won, folks. Microsoft knows. That's why they're including it with
Windows. It's not just o keep Windows appealing to developers It's because
developers are right, Linux won and is the language of choice for servers.
What's that? Everything's a server now? In what way does Microsoft still win in
this scenario? Well let me explain.

Microsoft's "NT" (new technology) basically anticipated this and gage Microsoft
a get-out-of-proprietary free card. NT is circles of protection. All the things
that makes Windows truly Windows today is the invisible stuff managing memory
and other resources silently in the background. The rest is window dressing.

Whereas Linux lets you slip on different desktop windowing environments such as
GNOME, KDE, xfce and lxde, Microsoft lets you slip on wholly different OSes of
which what we call Windows today is but one. How well Linux virtualises, once
this nifty "hypervisor" system is turned on is a testament to how well designed
NT, upon which all modern Microsoft Windows is based, actually is. Microsoft
can transition to Linux, so long as it can keep paying customers of Azuret or
another.

Anyhoo...

# An Ode Tuple Keys

    Have a Tuple said the Python
    To a Counter() with an instance
    So each instance[('had', 'keyed', 'columns')]
    For unique from-neighbor distance.

    Underrated is the method
    In by which a set will see
    That you won't need 'dex, sequential
    If you've got primary key!

Such notions get voted down on Reddit, LOL! Oh well, can't please everyone. But
I am enormously self-pleased with that poem. Few get how useful tuples are in
Python.

I've got tuples on the brain. At first with Python, you get infatuated with
lists and dicts. I mean they're both really super powerful and with almost
limitless application. But it's the poor misunderstood tuple that never gets
the spotlight for it's unlimited usefulness. Well, I'm here to tell you the
tuple is infinitely useful, and really the key to understanding the Python API.

There's just so many places where tuple packing and unpacking is occurring,
symmetrically coordinated up around the comma'd values. You see because an
ugly verbose language of excessive parenthesis is being avoided, the actual use
of parenthesis becomes optional when use of a comma implies tuples are preset.
And the result is a beautifully explicit implicit terse language. But it takes
awhile to grok. Let me demonstrate.

```python
atuple = ("one", "two")
```

This is really so deceptively simple. It is not a dynamic Python "list" so
there is no atuple.append() or atuple.add() sub-function, a.k.a. method in
Java-ease. Datatypes like tuples, lists and dicts carry around different
methods depending on the capabilities of the datatype. Dicts search on their
keys fast. Lists let you append and pop. But tuples are rigidly sized, once
created. Well, this makes them the perfect datatype for database rows. It needs
to be said and heard more that a tuple is like a fixed-width database record.
And so a able of tuples is the equivalent of a SQL table or Excel tab.

Even without the Pandas or numpy libraries, you can manage lists of tuples in
Python native datatypes and do a lot of data-science things. And because of the
syntax of using commas to separate items in a tuple, the use of commas in
certain places forces the interpreter to understand the datatype being used has
the tuple API. And so the parenthesis can be implicit, dropped, and you've got
some really neat code to do stuff.

One of my favorites is the way I've been using URLs as database keys a lot
lately. URLs are unique resource locators, and so they are perfect database
keys. That's all the Internet is when you look at it a certain way. Plug in a
certain Internet address, which may include the use of certain protocols,
making it for instance a Web address or ftp file location. In any case, you
plug a key in and you get data in response.

There's a table full of tuples
Don't get df's on the brain

I just wrote this:

```python
import httpx
import pandas as pd
from pathlib import Path
from asyncio import gather
from collections import Counter
from bs4 import BeautifulSoup as bsoup
from sqlitedict import SqliteDict as sqldict

data = "crawl"
depthdb = f"{data}/depth.db"
responsedb = f"{data}/responses.db"

user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
headers = {"user-agent": user_agent}

# Load URLs from link crawl
table = []
with sqldict(depthdb) as db:
    for url in db:
        table.append(url)
print(f"Total URLs: {len(table)}")

# Plan the crawl
if not Path(responsedb).exists():
    with sqldict(responsedb) as db:
        for url in table:
            db[url] = None
        db.commit()

# Find uncrawled URLs
urls = []
with sqldict(responsedb) as db:
    uncrawled = 0
    for url in table:
        resposne = db[url]
        if response == None and uncrawled <= 1000:
            uncrawled += 1
            urls.append(url)
print(f"Uncrawled URLs: {len(urls)}")

# Crawl uncrawled URLs
async with httpx.AsyncClient(headers=headers) as client:
    apromise = gather(*[client.get(url) for url in urls], return_exceptions=True)
    with sqldict(responsedb, timeout=5000) as db:
        for response in await apromise:
            try:
                db[str(response.url)] = response
                db.commit()
            except:
                ...
print("Done crawl")

c = Counter()
with sqldict(responsedb) as db:
    for url in db:
        response = db[url]
        if type(response) == httpx.Response:
            status_code = response.status_code
            c[status_code] += 1

for status_code in c:
    print(f"{status_code} pages: {c[status_code]}")

table = []
heading_tags = ["h1", "h2", "h3", "h4", "h5", "h6"]
with sqldict(responsedb) as db:
    for url in db:
        response = db[url]
        if type(response) == httpx.Response:
            status_code = response.status_code
            html = response.text
            soup = bsoup(response.text, "html.parser")

            try:
                title = soup.title.string.strip()
            except:
                title = None
            try:
                description = soup.find("meta", attrs={"name": "description"}).attrs[
                    "content"
                ]
            except:
                description = None
            try:
                headlines = "\n\n".join(
                    [
                        f"{x.text.strip()}"
                        for x in soup.find_all(heading_tags)
                        if x.text.strip()
                    ]
                )
            except:
                headlines = None
            stripped_strings = " ".join(soup.stripped_strings)
            body_copy = " ".join(
                [x for x in [title, description, stripped_strings] if x]
            )
            atuple = (
                str(response.url),
                response.status_code,
                title,
                description,
                headlines,
                body_copy,
                str(soup),
            )
            table.append(atuple)


cols = ["url", "status_code", "title", "description", "headlines", "body_copy", "html"]

df = pd.DataFrame(table, columns=cols)
df.to_parquet(f"{data}/extration.parquet")
print(f"{df.shape[0]} URLs")
print("Done")
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/starting-to-ideate-the-idea-capture-device/">Starting to Ideate the Idea Capture Device</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/deep-breath-before-keyword-histogram-clustering/">Deep Breath Before Keyword Histogram Clustering</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li>
<li><h4><a href='/tuples/'>Tuples</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>