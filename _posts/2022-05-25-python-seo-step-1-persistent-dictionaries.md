---
date: 2022-05-25
title: "Python SEO Step #1: Persistent Dictionaries"
headline: "Master Python for SEO: Learn to Target Keywords, Collect Data, and Use Machine Learning Algorithms"
description: In this session, I will teach you how to use Python for SEO, including how to target keywords, collect data, and use machine learning algorithms. We will use JupyterLab, Python dictionaries, and a context manager to eliminate extra code. I will also discuss SqliteDict, a free and open source SQL database, as a key/value system. Learn how to use URLs as keys in key/value pair systems.
keywords: Python, SEO, JupyterLab, Python Dictionaries, Context Manager, SqliteDict, SQL Database, NoSQL, Key/Value Pair Systems, URLs, Keys, Value, Rows, Columns, Machine Learning Algorithms, Target Keywords, Collect Data
categories: jupyter, seo, python, database, value, key
permalink: /blog/python-seo-step-1-persistent-dictionaries/
layout: post
---


# Getting Started with SEO Means Python

- We will in this session:
  - pip install -U mlseo
  - More important to do local persistent dictionaries (the big trick)
    - It applies to all "data collection" phases of a project
    - Because Key/Value is fast, and defers row & column decisions

So much of SEO & other fields, all projects start with a data-collection phase.
It's just a fact. The better you can do this (under Python), the better of SEO
you will be and the less you will have to pay for specialized products.

Line up your cross-hairs. No single page can target too many keywords.

- Choose your target keyword (2 to 5 words)
- You make sure it occurs in that exact word arrangement in your:
  - Title (most important)
  - URL (important, but most difficult)
  - In a headline-like element (on-page)
  - The anchor text of links leading to the page <a href="">Anchor text</a>

Ready, publish, aim!

{% include youtubePlayer.html id="oXoU2RQkRtM" %}

Collect some data of your own.

On a website you control.

The data coming in will include:

1. You crawling the site (as if Google)
2. Google Analytics
3. Google Search Console

There is an "old way" in which the cross-hairs I discuss is everything. It
still lurks beneath the surface of Google's systems.

There is a "new way" that uses machine learning, particularly the BERT algo,
that makes the cross-hairs less important. But because of competitive reasons,
this only comes into effect where the keywords get long and specific. I.e.
sentences. BERT reads sentences. BERT knows intent and synonyms and language
syntax, and learns. PageRank, Universal, BrainRank, BERT... it will always
improve until "General Artificial Intelligence" arises. I wanna see the GAIs
wake up. You may be talking with them already.

<pre>
                              What's most broken?
                 Where do I get the biggest bang for the buck?
                          What plates need spinning?</pre>

I was not keeping "tension" in machinery... publish often, publish on slightly
tangential topics.

I didn't have a blog publishing system I was satisfied with (dumped WordPress
for tech liability reasons). Had to replace. Did replace it with Github Pages,
which is the Jekyll static site generator.

When using a static site generator, you have to keep the pre-generate (simple
data) somewhere. In this case, the data format is markdown, and where I'm
keeping it is in folders (a.k.a. directories).

Get your butts on JupyterLab for easy interactive Python... so says a vim-head.

- There is data.
- Data is out there.
- It is not yet here.
- Your job is to get the data from there to here.
- There are many ways to do this.
- Banking it fast with a key/value system is best.
- Think not about rows & columns. It will slow you down.
- Key/value systems today are faster than you think.
- This is because of something called "hash table" optimization.
- The good folks need to know quite how fundamental HTO is... core to much.
- The folks need to know that the following are all the same:
  - name/value pairs
  - key/value pairs
  - NoSQL (versus SQL)
  - python dictionaries
  - JavaScript JSON (JavaScript Object Notation)

Python dictionaries are just a bit less than a database... because they don't
last. They *POOF*

We gotta fix the poof.

It's easier than you think.

But very ***pythonic*** thus weird to the new eye.

There's deep python-specific nuance you're about to be exposed to.

Specifically:

- pip installing a package that ***should*** be in the Standard Library
  (shipped with Python) but isn't... and nobody knows.
- Renaming a package component on import for usability
- We are making odd naming conventions usable (overriding APIs)
- We are using a "context manager" that eliminates tons of frustrating extra
  code that would need to be added if Python didn't have the "context manager".
- You know you're seeing the context manager whenever you see:
  - with

The following line is worth a million dollars

    pip install SqliteDict

Python ships with Sqlite3.

Sqlite3 is a free and open source (FOSS) SQL database.

SQL spelled SQL but pronounced sequel is a row & column database like
spreadsheets. Tabs in a spreadsheet are tables in SQL.

That's exactly the environment I'm telling you to avoid at first pass... On
data collection!

So why use it?

Row & column systems (RDMS) can be used as key/value systems by using just 2
columns. The first column is the key column and the second column is the row
column. It's the shell game. It's trickery.

Postgres (SQL) uses this to great effect competing with NoSQL systems (like
MongoDB, CouchDB, Redis, BerkelyDB, etc.)

Persistent Python dictionaries are step #1 in every task.

Consequently, they're the most important to know about Python SEO.

URL means unique resource locator... emphasis on unique... that's key

URLs make perfect keys in key/value pair systems.

Sqlite that comes with Python is unspeakably big gift... mana from the sky.

To do a light touch that turns Sqlite from RDBMS (rows & columns) to key/value
is pure magic. The fact it used the Python dict API is magic squared.

The only concession to me made is:

- pip install sqlitedict
- from sqlitedict import SqliteDict as sqldict
- You must understand Python context manager (whenever you see "with")
- db.commit() is necessary unlike a plain dict.

Embedding other stuff in that siezes, engages, electrifies, excites, satisfies
and otherwise delights the person who risked so much clicking that link. Don't
let 'em down. It should be the very best page on the entire Internet on the
topic you're targeting. Otherwise, are you really even sincere? What new are
you adding to the conversation? If not the best page, then add something new
that nobody in the world has ever added to that topic/discuussion.

Search is where search is.  Top positions where there is no search is
meaningless... except for practice.  Use the ability to get position 1 on terms
you know for a fact have some sufficient search numbers. Get a percentage of a
percentage of THAT traffic, and then start swimming upstream. Get a foot in the
door and expand the opening.

What I showed today could be done with Python shelves & pickles.

Slowwwwwwwwww

A discussion of ikigai ensued.

I guess what I'm trying to do with Linux, Python, vim & git is:

Cure to anxiety, groudlessness, existential crisis, plagues of youth.

> Use your powerful "internalized" assets in creative new ways.<br />
> Replace distractions with love-worthy and righteous new things.<br />
> The best way to learn is to teach, so always be teaching.<br />
> Figure out how to release already built-up potential.<br />


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/1991-was-an-eventful-year-for-tech/">1991 Was An Eventful Year For Tech</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/write-python-webcrawler-toil-talk-w-audience/">Write Python Webcrawler! Toil & Talk w/Audience</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/value/'>Value</a></h4></li>
<li><h4><a href='/key/'>Keys</a></h4></li></ul>