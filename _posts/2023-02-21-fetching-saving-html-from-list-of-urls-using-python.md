---
date: 2023-02-21
title: Fetching & Saving HTML From List of URLs Using Python
headline: Creating a Program to Scrape Data from a Website for a Friend Using Python and Linux
description: As I prepare to start my new job, I'm taking care of all the necessary tasks, including ordering a standing desk and organizing my apartment. I also attended a group meeting with my employer and got all the onboarding paperwork done. To help out a friend, I'm creating a program to scrape data from a website and store it in an Excel file, using Python and Linux.
keywords: Fetching, Saving, HTML, URLs, Python, Standing Desk, Organizing, Group Meeting, Employer, Onboarding, Scrape, Store, Excel, Linux, SEO, Tuesday, Job, Monday, Supermarket, Ikea, Apartment, JupyterLab, Server, Practice Directory, Notebook, HTTPX, Synchronous Work, Read, Lists, Crawl, HTTP Request, SQLite3, Database, File, Extract, Title, Description, Head
categories: panda, jupyter, html, python, linux, seo, database
permalink: /blog/fetching-saving-html-from-list-of-urls-using-python/
layout: post
---


Wow, it's Tuesday. No new OnTheRise.AI website yet. I'll fix that today. But my
back hurts. And I have a favor to do for a friend. I just ordered a standing
desk from Amazon. I'm going to avoid sitting down today. I got a lot of good
sleep last night and have for a few nights running to try to heal, but I
haven't been eating that well. I have to hit the supermarket today. More
lifting and carrying things up steps. Ugh! Okay, take it easy on yourself.

If ever you needed your daily metaphor rules, it's today. Time is running out.
I have big goals before my new job starts. Fight the chaos. Do another few
incremental passes at order. Plan your layering-up of the daily baby-steps.
Work towards something huge and positive for humanity keying off your
love-worthy interests in the time you have left on this material world. Meaning
is what yo ascribe to it.

Wow, even just knowing that I have to modify my behavior today to not sit down
in order to promote healing is a big step. Don't take on projects that are
going to require the heavy-lifting capabilities you lack of late, namely a
comfy new couch which I'm tempted to go get from Ikea. Maybe I go there for the
adventure (I've got to get out) and order it for delivery, and maybe even
assembly. I would have never before done that in my life, but living on a 2nd
floor, with a bad back and 52 years old may finally tip those scales.

Okay, carry on with the day. Keep writing. Keep doing. Don't let up. I think
not sitting down today will be key. I think not sitting down today is like a
running agent monitoring me. It adds just the right extra amount of little
meta-task that keeps me self-monitoring and self-correcting.

I'm making some progress. Ugh, one accumulates a lot of stuff in one's life.
And most of it is still not even my accumulation. It's mostly from previous
"lives" and previous "families". I'm the dumping ground as I always was, when
my dad died, my mom went crazy and disappeared. Then my first wife had a kid
with another man and left me. And my latest attempt at family is not going so
well, and my last real connection is to that of my child. So everything is
about getting things nice for myself and my child. And I've got a lot to purge,
but my kid would probably still like to look over the stuff I'm getting rid of.
And I can structure my place (have been structuring my place) to gradually
digest and expunge almost everything, until just mostly just connections
between living things exist, and internal skills that can allow me any material
allowances I may need in life, and to help my child have that same ability.

Okay, wow. I'm onto something. Standing up all day really keeps me aware and
from falling into doom scrolling and similar distractions.

Let's fight demoralization. Exposure to true information does not matter
anymore. A person who has been demoralized is unable to assess true
information. The facts tell nothing to them. Even if they were showered with
authentic proof of documents and pictures. Even if they're taken by force and
shown the first-hand evidence, they'll still deny it.

Okay, I was in on a big group meeting with my next employer today even though I
don't really start until Monday, but I think it was a great idea. I met a lot
of new people. It's going to be something of a superpower to be working out of
the New York area as I'll be able to get to the New York office time to time.
Maybe even once a week or so. Once every 2 weeks seems more reasonable, but a
little taste of the past, I think. Wow.

Wow, okay. I got all the onboarding paperwork done today. I'm asking for a Mac
instead of a PC so that I can speak knowledgably about recent macs. It's been
awhile since I've been on a modern Mac.

Okay, I've got to do a favor for a friend before I lose all motivation today. I
did very well on working on the apartment get it organized for the next phase
of my life. I did good on the preparing the paperwork for my next job front.
But now I have to do right by a friend. And although I can feel in my bones
(bad back and all), I've been putting off doing this sort of work until the new
job started. It just felt like I had so much other stuff to do. But it can't
wait because I said I'd do it and he's a friend.

So, let's get started and make some journal fodder of it. No names of sites or
actual data shown. Just process. Y'all gotta crawl once in awhile, and for some
reason everyone's wrapped around ScreamingFrog's fingers. It's not a bad deal
what they ask for their annual license and they do offer a lot of features. But
why pay even that, or more importantly nurture a dependency upon a for-profit
3rd-party company and product for your capabilities?

What are the choices, you ask? I'm glad you asked! You always need to know
where to start, and I'm going to tell you every day how I do the SEO things I
do. There are no more secret deliverables, especially once I'm working for Moz.
I'm going to show the world how to do stuff, with and without Moz product. I'm
right now a mostly "without" sort of person. I'm the kind of person who codes
my own systems, because doing so just means knowing a little bit of Python. My
dependency is on a free and open source software platform, plus a light
sprinkling of equally FOSS Python packages. Let's get started.

We start on a Pipulate system. I know I need to make it clearer, but if you're
on Windows 10 or 11, then you're in luck! You can run Linux. In particular, you
can run JupyterLab as a Linux service and have a whole lot of automatable
SEO-stuff sitting on your desktop. To make it impervious to your laptop's going
to sleep, we simply get another Linux running somewhere else that's identical
to the one on your laptop. Test on laptop, push to 24x7 persona SEO-server.

The iron is hot to take up Python. Don't you see ChatGPT spewing out the code?
Well, who's going to copy/paste it into a system? You, silly! But where? Sure
you can cobble something together. There's lots of ways to get an easy-to-use
local Python coding environment running. But why not use the one that's least
proprietary (no Microsoft or other paid software required) and most similar to
how this stuff runs in true server context?

Anyhow, I believe the easiest way to do it is to just run the <a
href="https://mikelev.in/drinkme">drink me</a> install script to set everything
up just so. Once that's done, you visit the JupyterLab you're now Linux-side
hosting by going to http://localhost:8888. I'd actually recommend doing it from
Microsoft Edge so you can save JupyterLab as an App, and thus have it run
full-screen without a web address bar, have it in your start menu and such.

In JupyterLab you'll see there's a practice directory. Now that fact I can say
stuff like this knowing your environment will match mine is what makes it
Pipulate. It's like I gave you a virtual machine or a container, but all you
did was run an install script which set up the server natively under the
Windows Subsystem for Linux (WSL). You're running a Linux server and all your
paths and environment variables are the same as mine. It's a great common API.

The practice directory is clean and pristine. I only commit stuff in there that
I want to share with the world. I make new notebooks in the practice directory
all the time which are not actually part of the repo. I do my work starting
from a fresh notebook every time by copy/pasting over any bits from the
template. This forces you to think through the process every time and customize
it for the way you need this time, without getting hung up deciphering
decisions of the past. You're coding literate, right? Start fresh! Express
yourself.

```python
import httpx
import pandas as pd
from pathlib import path
from sqlitedict import sqlitedict as sqldict
```

We're going to do it the synchronous way. I'm using httpx so that asynchronous
remains an option, but it's only a few hundred URLs to crawl and the code is
much easier to read in sequential mode. Anyhow, let's load the URLs. If someone
gave you such a list in native Excel .xlsx format, you can load it directly
into Python using Pandas.

```python
urls1 = pd.read_excel("urls1.xlsx", header=None).iloc[:,0].tolist()
urls2 = pd.read_excel("urls2.xlsx", header=None).iloc[:,0].tolist()
```

This is really a trick to avoid converting file-formats. Pandas can read Excel
files directly if you have OpenPyXL installed, which is part of the Pipulate
install. I don't even keep dataframes in memory. I just want the two lists of
URLs. It's only 2 lists because I'm keeping them separate. This exercise works
just as well with just one list of URLs.

Next thing we're going to need is a user agent

```python
user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
headers = {"user-agent": user_agent}
```

You can take a peek at the URLs you're about to crawl like this:

```python
for i, url in enumerate(urls1):
    print(i, url)
```

And if you're okay with that list of URLs, you can actually perform the crawl
like so:

```python
with sqldict("urls1.db", timeout=60) as db:
    for i, url in enumerate(urls1):
        if url not in db:
            db[url] = httpx.get(url, headers=headers)
            db.commit()
            print(i, url)
```

And that's it. That crawl is stored on drive. The rest is extracting and
transforming data for your stakeholders. See? No screamingfrog required for
menial crawl tasks. And it's okay if it fails in the middle and you have to
restart. It knows how far its gotten and won't re-crawl any of the URLs it
already has. All together, the code looks like this:

```python
import httpx
import pandas as pd
from pathlib import path
from sqlitedict import sqlitedict as sqldict


urls1 = pd.read_excel("urls1.xlsx", header=None).iloc[:,0].tolist()

user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
headers = {"user-agent": user_agent}

with sqldict("urls1.db", timeout=60) as db:
    for i, url in enumerate(urls1):
        if url not in db:
            db[url] = httpx.get(url, headers=headers)
            db.commit()
            print(i, url)
```

Okay, so now we're sitting on .db files which are SQLite3 database files. We
can read the data out reversing how it went in, checking if you have good
response codes. This trick works because the httpx response object (which we're
pulling out of the database) happens to use the response code in it's
developer-defined string representation. That's how it would work with the
Requests object as well.

```python
with sqldict("urls1.db") as db:
    for i, url in enumerate(db):
        print(i, url, db[url])
```

And to turn that into an extraction, it's this:

```python
table = []
heading_tags = ["h1", "h2", "h3", "h4", "h5", "h6"]
with sqldict("urls2.db") as db:
    for i, url in enumerate(db):
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
df.to_excel("business.xlsx", index=False)
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/back-hurts-but-maintain-your-indomitable-spirit/">Back Hurts, But Maintain Your Indomitable Spirit</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/keep-taking-those-baby-steps-every-day/">Keep Taking Those Baby-Steps Every Day</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/panda/'>Pandas</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li></ul>