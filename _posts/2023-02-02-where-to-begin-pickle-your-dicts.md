---
date: 2023-02-02
title: Where to Begin? Pickle Your Dicts!
headline: Unlock the Potential of Data and Tech Skills - Create a Pipulate Server from a Windows Linux Instance
description: This blog post invites readers to explore the possibilities of data and tech skills, providing an example of how to create a Pipulate server from a Windows Linux instance. It also dives into the appeal of tool use, and how to create a Python dictionary object and store it in a SQLite database using the SqliteDict package. Join me as I explore the potential of data and tech skills and the tools available to make them work!
keywords: Pipulate, Windows Linux, Tool Use, Python, Dictionary, SQLite, Database, SqliteDict, Context Manager, .commit()
categories: database, python, pipulate, sqlitedict, sqlite
permalink: /blog/where-to-begin-pickle-your-dicts/
layout: post
---


Welcome to my opening paragraph. You will desperately want to skip around and
get to the good parts, and you're not even through the 2nd sentence yet. See?
Don't go meta too fast. That's lesson 1. Dig what you're into and get into the
groove and play and lose track of time just because. If it's not feeding your
soul and you're not coming away strangely contented and happy with life, then
why?

Don't over-reach for your first project. Often times your over-ambition is
precisely the thing that's going to do you in. If you have preconceived notions
about a topic from the TikToks and the Reddit's, back up and remember a lot of
work went into them making it look so easy. Life's only so long and you're only
going to cram so many of those 10-years-to-master skills in. Choose wisely!

I choose YOU, Data! Data is data. The connection between that data and how it
somehow takes on an almost magical meaning to the right people is a kick. Tech
skills that help you make other people rich, and which may make you yourself
such some day sound pretty nifty. Oh, and the implements of the trade are none
too shabby either, for those of us who love hating JavaScript. Python pandas in
Linux Jupyter on Windows Edge!  Notebooks be like better than .py files with
nbdev. Prepare for your life to change.

You will feel somewhat like a spell caster when you dabble in tech text
scripts. There are so many tricks in spell casting. Things really just have to
be so just-right that most of the tech field has gone ga-ga over Docker, which
gets it just so but then slaps your hands off. Docker's awesome, but it locks
everything down so tight, it's not like you have root access to install
anything. Docker locks you out.

Oh, no, no, no! Come in and read my install.bat script. I invite you to look at
that old school DOS-style boot script. Microsoft is giving an inch. I am taking
a mile. If we control the intial boot-up of a common default Windows Linux
instance, then we can have it install a bunch of stuff just-so on the initial
run. Voila, a server! The result is a Pipulate server built before your eyes in
a way the skills you're about to get will teach you to appreciate.

Dohhh. Back to meta. Okay, the love-worthy bits may vary based on your vibe,
but for me I find having an Alice in Wonderland type adventure that lights up
all the right Dopamine or Serration neuroreceptors or whatever. I mean it's not
exactly being on a roller coaster, but making something of real value to work
from your own effort, appeals to me. I imagine I get a fix from tool use like a
craftsperson would, and it is why I get so angry when tools change so fast.

The best tools won't change fast. They might change little by little over the
years, in which case continual ongoing master can be yours, because we all
continue to learn. It's only that now learning can be honing and perfecting and
optimizing. It's up to you as a developer to hop between the tools you like
best and which last longest, and perhaps even which cost the least. Work from
abundance.

I'm stating you out on like the best tool ever. It's the Python dict. Yup,
think of a dict as a tool. Go ask Guido if you have issues with naming
conventions. But a dict is by far the best tool to get really familiar with
right up front. A dict is a set of key/value pairs. Technically, only the keys
are part of the set, because sets don't contain duped. Every item in a set is
unique, and that's the same as a key. With that key, you unlock a value. Search
on keys. Plan keys to be searchable.

The entire Internet is a dict. Plug a URL in, get something bigger back.
Key-value, get it? You might also hear name-value and other varieties. If we
were talking SQL, the key would be the primary key. They have the same unique
constraint attribute.

The popular JSON format in the JavaScript works is essentially the same thing,
and you can covert one into the other seamlessly. The big realization with this
key-value relationship is that a value can in turn be another dict object, so
these things can nest and make arbitrary shapes and hierarchies. Other things
like XML have existed before but little has been as successful as JSON or the
Python dict. You create them like so:

```python
import httpx

url = "https://mikelev.in"
adict = {}
adict[url] = httpx.get(url)
```

And now you have one dict with one key/value pair. The value being the whole
frogging response object to that http request. Yup, binary data like that can
be values of a dict. So a month later, you could reverse the process to read
the saved dict off of the drive to see what was on that webpage on that date
without needing the Internet archive. Seeing the connection to SEO yet? You
need persistent dicts. Your Python dictionary objects need to be saveable like
a csv file. That's step 1. That's where to begin. Pickle your dicts. But I'll
show you the easy way.

If any package deserved to be part of the Python standard library, it's this.
It should be called something better, but it's not. And it could go away, but
what it's doing os so simple something will replace it providing the same or
close enough API. Watch how we make that dict persistent.

```python
import httpx
from sqlitedict import SqliteDict as sqldict

url = "https://mikelev.in"
with sqldict("crawl.db") as db:
    if url not in db:
        response = httpx.get(url)
        db[url] = response
        db.commit()
```

So it's a tiny bit more code to make the dict persistent, but not much. You'll
learn about the "with" keyword in Python and how that indicates the Context
Manager which you'll hardly even know is at work there, but which is so
convenient. File-write stuff is traditionally hairy because of file-locks and
hardware details. But this uses Python's built-in SQLite3 instance which is
highly optimized and compiled C-code for performance, but it's using a nearly
standard Python ***dict*** data-type to represent the SQL database. And just
like that, you don't need to know SQL to get a lot of advantages of SQLite. You
only need know Python dicts and a bit about the ***with*** keyword in Python.
Oh, and .commit(). You need to know about .commit().


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/testing-google-photos-organization-program">Testing Google Photos Organization Program</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-crazy-old-batch-files-were-right">The Crazy Old Batch Files Were Right</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/sqlitedict/'>SqliteDict</a></h4></li>
<li><h4><a href='/sqlite/'>SQLite</a></h4></li></ul>