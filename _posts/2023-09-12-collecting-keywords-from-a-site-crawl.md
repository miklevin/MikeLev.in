---
date: 2023-09-12
title: Collecting Keywords From a Site Crawl
headline: Creating a Rapid Keyword List Refiner from Title Tag Crawl Data
description: I'm creating a keyword list refiner that works on title tag crawl data from a website crawl. This refiner is an alternative to buying a keyword list from an SEO software vendor. It will gameify the process, help get into the zone, and clean the list as you go. I'm using Python's readline module to make the title tags editable on the command-line.
keywords: site crawl, keyword list, SEO software, search results, Jupyter Notebooks, Python, input function, line editor, ipywidgets, readline module, terminal, command line, Pipulate, SQLite database, gameifies, cleans list, duplicate, actuals, title tag, brand name, pipe symbol, ampersand, SEO, 80/20-rule, zone-inducing, keyword collection, proper-case, common keyword, first word, title tag
categories: pipulate, seo, 80/20-rule, python, jupyter, linux
permalink: /blog/collecting-keywords-from-a-site-crawl/
layout: post
group: blog
---


I'm making a rapid keyword list refiner that works on title tag crawl data.
Given a list of title tags from a website crawl which are rarely in good enough
shape to be a keyword list directly, we have to re-work each title tag. It may
have multiple keywords "embedded" that we need to differentiate, perhaps
repeating a root keyword across each. 

This is an alternative to "buying" a keyword list from one of the SEO software
vendors, both an expensive and questionable proposition. A better starting
point is getting it directly off of the site from a crawl so you can compare
what they appear to be targeting against actual search results. Start from
***actuals***.

Once a website crawl is done, preferably with a free and opens source SEO tool
you didn't have to pay for, we need to edit each title tag into the right
keywords. It's work that would often be done in a spreadsheet, but there's a
number of downsides to that. I wish to make an environment that gameifies the
process, gets you into the zone in the work, and cleans the list as you go,
removing duplicates and using what it learns to improve the process as it goes.

Normally, I work in Jupyter Notebooks for this sort of thing. It's a wonderful
environment for "mocking up" code that may eventually go somewhere else, like
scheduled automations. But in this app, I need a sort of interactivity that
doesn't come easy. I'm asking for the title tags to be editable as if having
clicked into a spreadsheet cell so you can edit what's already there. Python's
built-in `input` function seems to be the right thing, but default values don't
get pre-filled in an editable form. Got the picture? I need a ***line
editor***.

Alternative approaches like `ipywidgets` that are a possibility in Jupyter
Notebooks add too much complexity, especially when Python's standard library
`readline` module does exactly what I need. The only catch is that it has to be
run from the terminal (aka command line). In accordance with the 80/20-rule,
getting 80% of the benefit I'm seeking from the first 20% of the effort I'm
putting in, I'm going this route. To understand the subtlety of what I'm
talking about, you can run this code from a terminal:

```python
# file: test.py
import readline

def input_with_prefill(prompt, prefill):
  readline.set_startup_hook(lambda: readline.insert_text(prefill))
  try:
    return input(prompt)
  finally:
    readline.set_startup_hook()

prefilled_value = "This is the prefilled value."

value = input_with_prefill("Enter a value: ", prefilled_value)

print("You entered:", value)
```

Now I'm working off some prior work I've done in my free and open source SEO
project called Pipulate, which has some very standard code that's used after a
site crawl has put the data into a local SQLite database, and we repurpose the
above code to step through each title-tag interactively:

```python
import config
import readline
from bs4 import BeautifulSoup as bsoup
from sqlitedict import SqliteDict as sqldict

responsedb = f"{config.name}/responses.db"

def input_with_prefill(prefill):
  readline.set_startup_hook(lambda: readline.insert_text(prefill))
  try:
    return input()
  finally:
    readline.set_startup_hook()

with sqldict(responsedb) as db:
    for i, url in enumerate(db):
        response = db[url]
        soup = bsoup(response.text, "html.parser")
        title = soup.title.string.strip()
        value = input_with_prefill(title)
        print("You entered:", value)
```

This will simply throw up each title tag from the site with the opportunity to
edit it on the command-line, but the goal is to speed up the work immensely so
you can fly through such a list with everything you do helping speed up the
process as you go. The easiest first edit is to assume that the keywords are
comma separated in the title tag, so we can do this:

```python
with sqldict(responsedb) as db:
    for i, url in enumerate(db):
        response = db[url]
        soup = bsoup(response.text, "html.parser")
        title = soup.title.string.strip()
        value = input_with_prefill(title)
        alist = value.split(",")
        print(alist)
```

And indeed running the new version gets across the idea of what I'm trying to
do. But the next things I notice is that the frequent use of the pipe symbol to
separate brand names from title tag needs to be parsed too.

```python
import re
pattern = "( \| | - | & )"

with sqldict(responsedb) as db:
    for i, url in enumerate(db):
        response = db[url]
        soup = bsoup(response.text, "html.parser")
        title = soup.title.string.strip()
        t = title.replace(" and ", " ")
        t = re.sub(r"\s+", " ", t)
        t = re.sub(pattern, ", ", t)
        kwstr = input_with_prefill(t)
        kwlist = kwstr.split(",")
        kwlist = [x.strip() for x in kwlist]
        print(kwlist)
```

This next step strips out vertical bars ` | ` and hyphens with spaces around
them ` - `, two common ways to separate site names, brands and such in a title
tag and replaces it with a comma to become like any other keyword. Ampersands
with spaces around them are stripped out for similar reasons. I also similarly
strip out ` and ` because we don't want that to become part of any of the
keywords. And I added a list comprehension to strip out leading or trailing
white space on each resulting keyword.

Already in test-running this thing, I can feel the addictive and zone-inducing
quality of the process, which is exactly what I'm looking for. Now we're going
to make it never offer to record the same keywords twice, base on what you've
already "collected". It's in-memory right now, meaning every time it's run, it
will ***forget*** what's been collected, but we'll make it persistent soon. It
will be another tiny database `keywords.db`, but first things first. This means
I'll have to parse the keyword list ***before*** presenting it to the user as
well as after. So I have to refactor a bit with a function so the code remains
readable:

```python
# file: pwgame.py
import config
import re
import readline
from bs4 import BeautifulSoup as bsoup
from sqlitedict import SqliteDict as sqldict

responsedb = f"{config.name}/responses.db"

def input_with_prefill(prefill):
  readline.set_startup_hook(lambda: readline.insert_text(prefill))
  try:
    return input()
  finally:
    readline.set_startup_hook()

pattern = "( \| | - | & )"

def kwclean(s):
    s = s.replace(" and ", " ")
    s = re.sub(r"\s+", " ", s)
    s = re.sub(pattern, ", ", s)
    kwlist = s.split(",")
    kwlist = [x.strip() for x in kwlist]
    return kwlist

with sqldict(responsedb) as db:
    for i, url in enumerate(db):
        response = db[url]
        soup = bsoup(response.text, "html.parser")
        title = soup.title.string.strip()
        title = ", ".join(kwclean(title))
        kwout = input_with_prefill(title)
        print(kwout)
```

This next step introduces the `seen` variable which is a Python `set` datatype.
We use it to keep track of every keyword we've "seen" so far. We have made it
case insensitive by lower-casing everything that goes into and checks against
the set. You might think the "seen" variable is the one we'll make persistent
for the permanent keyword collection, but no. I want to keep the original
proper-case (upper and lower) usage because there's lots of brand names and
proper nouns in there, and this is good information we don't want to throw out.

You will know this bit of code is working by things like brand name only being
presented for collection once.

```python
# file: pwgame.py
import config
import re
import readline
from bs4 import BeautifulSoup as bsoup
from sqlitedict import SqliteDict as sqldict

responsedb = f"{config.name}/responses.db"

def input_with_prefill(prefill):
  readline.set_startup_hook(lambda: readline.insert_text(prefill))
  try:
    return input()
  finally:
    readline.set_startup_hook()

pattern = "( \| | - | & )"

def kwclean(s):
    s = s.replace(" and ", " ")
    s = re.sub(r"\s+", " ", s)
    s = re.sub(pattern, ", ", s)
    kwlist = s.split(",")
    kwlist = [x.strip() for x in kwlist]
    return kwlist

with sqldict(responsedb) as db:
    seen = set()
    for i, url in enumerate(db):
        response = db[url]
        soup = bsoup(response.text, "html.parser")
        title = soup.title.string.strip()
        title = ", ".join(kwclean(title))
        before_kws = kwclean(title)
        after_kws = []
        for kw in before_kws:
            kwlow = kw.lower()
            if kwlow not in seen:
                after_kws.append(kw)
            seen.add(kwlow)
        kw_str = ", ".join(after_kws)
        collect = input_with_prefill(kw_str)
        print(collect)
```

This next step will do some of the lightest touches for the biggest wins. In
SEO, you rarely target individual keywords because they are so competitive. So
if you're looking at one title tag at a time, chances are either the ***most
common*** keyword used in the title should be prefixed onto each keyword
candidate, or ***the first*** word in the title should be prefixed. It's
another 80/20-rule win that can safe us a lot of typing. It may be hard to
follow this code, but it was a pleasure to write!

```python
# file: pwgame.py
import config
import re
import readline
from collections import Counter
from bs4 import BeautifulSoup as bsoup
from sqlitedict import SqliteDict as sqldict

responsedb = f"{config.name}/responses.db"

def input_with_prefill(prefill):
    readline.set_startup_hook(lambda: readline.insert_text(prefill))
    try:
        return input()
    finally:
        readline.set_startup_hook()

pattern = "( \| | - | & )"

def kwclean(s):
    s = s.replace(" and ", " ")
    s = re.sub(r"\s+", " ", s)
    s = re.sub(pattern, ", ", s)
    kwlist = s.split(",")
    kwlist = [x.strip() for x in kwlist]
    return kwlist

with sqldict(responsedb) as db:
    seen = set()
    for i, url in enumerate(db):
        response = db[url]
        soup = bsoup(response.text, "html.parser")
        title = soup.title.string.strip()
        title = ", ".join(kwclean(title))
        before_kws = kwclean(title)
        after_kws = []
        counter = Counter()
        for kw in before_kws:
            kwlow = kw.lower()
            if kwlow not in seen:
                after_kws.append(kw)
            seen.add(kwlow)
            words = kw.split(" ")
            for word in words:
                counter[word] += 1
        maxval = max(counter.values())
        maxlabel = max(counter, key=counter.get)
        mod_kws = []
        for i, kw in enumerate(after_kws):
            words = kw.split()
            if i == 0:
                first = None
                if len(words) > 1:
                    first = words[0]
            if len(words) == 1:
                if maxval > 1:
                    kw = f"{maxlabel} {kw}"
                elif first:
                    kw = f"{first} {kw}"
            chops = ["More"]
            for chop in chops:
                if kw[:len(f"{chop} ")].lower() == f"{chop} ".lower():
                    kw = kw[len(f"{chop} "):]
            mod_kws.append(kw)
        kw_str = ", ".join(mod_kws)
        collect = input_with_prefill(kw_str)
        print(collect)
```

Now it's time to capture our good work to a database and make it persistent.
But more than just persistence (capturing the data into a database), we want
everything that has been processed thus far to work as a filter against what we
are setting out to process. This makes it safe and easy to re-run. You can stop
in the middle of a large job and pick up where you left off with all the work
you've done so far still working for you.

This means the Python `seen` set variable needs to be re-populated up to where
you left off on the re-run. We handle it just like we did with the crawl. The
URLs make perfect keys for key-value databases. We can remember what keywords
were collected for each URL. Now there's a few data structure questions here.
Maybe since we only collect each keyword once, we actually make the keyword
into the key. 

We want to think in terms of lightest touch that achieves most of what we need.
We especially want to keep the code clean and easy to read. Committing to a new
database is the easy part. We can basically add this code under where the final
output of the "collected" keywords is displayed. We need a new database and a
way to check if it's been created yet, so these new lines go near the top of
the file:

```python
from pathlib import Path
keywordsdb = f"{config.name}/keywords.db"
```

Now for efficiency, we want to skip over any URLs we processed. We will make
evaluations on a per-keyword basis too, but this is a fast filter that gives us
a big up-front win. The database might not exist yet (on the first run), so we
have to check for it. And because we're using the actual keywords as the
database dict keys, we have to make a set of all the values (URLs) found.

```python
seen_urls = set()
if Path(keywordsdb).is_file():
    with sqldict(keywordsdb) as db:
        for keyword in db:
            url = db[keyword]
            seen_urls.add(url)
```

And if the database is found, we also need to populate the `seen` set with its
keys. The keys are the keywords we previously recorded in their original case
form. So we need to `.lower()` them as we flow them in.

```python
seen = set()
if Path(keywordsdb).is_file():
    with sqldict(keywordsdb) as db:
        for kw in db:
            seen.add(kw.lower())
```

As we proceed down the file, there's a place where we've done all our
modifications to the keywords discovered in the title tag and present them to
the user, but we never want to present anything that's been seen. This one
little list comprehension takes care of that.

```python
mod_kws = [x for x in mod_kws if x.lower() not in seen]
```

And at the place at the bottom of the program where we show back to the user
their modified keyword list user input as a string, we parse it back into a
real list and record it in the new database. Notice I parse on just a comma `,'
and not a comma space `, `. This is because you never know what a user types in
and it's better to assume the responsibility of stripping out any spaces left
around the keyword yourself. Also notice I have to use a different label for
the database connection `db2` because we're already indented under the open
`db` connection. Also notice where adding to `seen` has been moved. It had to
be put way at the bottom so as to not filter too early.

I had to change a my technique for keeping track of URLs that were already
seen, adding a new database just for that because too much re-processing of
already looked-at URLs was occurring when you restarted the process. The
previous version would only filter seen URLs if keywords were recorded from
them. This new version lets you plow through the list, restarting as often as
you need with minimum reprocessing.

```python
# file: pwgame.py
import config
import re
import readline
from pathlib import Path
from collections import Counter
from bs4 import BeautifulSoup as bsoup
from sqlitedict import SqliteDict as sqldict

responsedb = f"{config.name}/responses.db"
keywordsdb = f"{config.name}/keywords.db"
seenurlsdb = f"{config.name}/seenurls.db"


def input_with_prefill(prefill):
    readline.set_startup_hook(lambda: readline.insert_text(prefill))
    try:
        return input()
    finally:
        readline.set_startup_hook()


pattern = "( \| | - | & )"


def kwclean(s):
    s = s.replace(" and ", " ")
    s = re.sub(r"\s+", " ", s)
    s = re.sub(pattern, ", ", s)
    kwlist = s.split(",")
    kwlist = [x.strip() for x in kwlist]
    return kwlist


seen_urls = set()
if Path(seenurlsdb).is_file():
    with sqldict(seenurlsdb) as db:
        for url in db:
            seen_urls.add(url)

seen = set()
if Path(keywordsdb).is_file():
    with sqldict(keywordsdb) as db:
        for kw in db:
            seen.add(kw.lower())

with sqldict(responsedb) as db:
    for numpages, url in enumerate(db):
        ...

countdown = numpages
print(countdown)

with sqldict(responsedb) as db:
    for i, url in enumerate(db):
        print(countdown - i)
        if url not in seen_urls:
            response = db[url]
            soup = bsoup(response.text, "html.parser")
            title = soup.title.string.strip()
            title = ", ".join(kwclean(title))
            before_kws = kwclean(title)
            after_kws = []
            counter = Counter()
            for kw in before_kws:
                kwlow = kw.lower()
                if kwlow not in seen:
                    after_kws.append(kw)
                words = kw.split(" ")
                for word in words:
                    counter[word] += 1
            maxval = max(counter.values())
            maxlabel = max(counter, key=counter.get)
            mod_kws = []
            for j, kw in enumerate(after_kws):
                words = kw.split()
                if j == 0:
                    first = None
                    if len(words) > 1:
                        first = words[0]
                if len(words) == 1:
                    if maxval > 1:
                        kw = f"{maxlabel} {kw}"
                    elif first:
                        kw = f"{first} {kw}"
                chops = ["More"]
                for chop in chops:
                    if kw[: len(f"{chop} ")].lower() == f"{chop} ".lower():
                        kw = kw[len(f"{chop} ") :]
                mod_kws.append(kw)
            mod_kws = [x for x in mod_kws if x.lower() not in seen]
            kw_str = ", ".join(mod_kws)
            if not kw_str:
                continue
            collect = input_with_prefill(kw_str)
            print(collect)
            collect_list = collect.split(",")
            collect_list = [x.strip() for x in collect_list]
            with sqldict(keywordsdb) as db2:
                for kw in collect_list:
                    if kw and kw not in seen:
                        db2[kw] = url
                        seen.add(kw.lower())
                db2.commit()
            with sqldict(seenurlsdb) as db2:
                db2[url] = None
                db2.commit()
```








<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/internalizing-the-tools-of-your-trade-that-are-timeless-to-boot/">Internalizing the Tools of Your Trade That are Timeless to Boot</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-journaling-for-life-tool-conundrum/">The Journaling For Life Tool Conundrum</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/80-20-rule/'>80/20-Rule</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>