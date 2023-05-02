---
date: 2023-04-18
title: How to Use Pandas and Python's Pathlib to Load Multiple CSV Files for Data Analysis
permalink: /blog/how-to-use-pandas-and-python-s-pathlib-to-load-multiple-csv-files-for-data-analysis/
headline: "Unlock Data Analysis with Pandas and Pathlib: My Journey of Automating File Loading"
description: I released a video and tweeted the link in time for the live premiere, and I created a program called ChopChop to help me chop my journal.md file. I used the .glob() method of a pathlib Path object to get a list of all the files in a directory, which I then used to 'seed' my data project. Finally, I used pandas dataframes to turn the list of file paths into something I can expand outwards from. Check out my blog.
keywords: Pandas, Python, Pathlib, CSV, Data Analysis, ChopChop, Glob, Path, Object, Directory, Seed, Data Project, Video, Live Premiere, Journal.md, Files, Dataframes
categories: journal.md, csv, python
layout: post
---

I say no distractions, and yet the first thing I do is push out a video. It was
totally worth it because it was one of my first instances of having the
bi-directional linking between YouTube video and published blog post at the
moment of publishing each. Normally I have to go back and edit one or the
other, putting the article link in the YouTube video description and the embed
the YouTube video in the blog post article page. But this time, I was able to
do it all at once. I'm going to try to do this for more videos. I also tweeted
the YouTube link in time for the live premiere.

I love the name of my new blogslicer program: ChopChop! It is a reminder to me
to work fast, in addition to chop-chopping my long journal.md file into smaller
files. Chop, chop! Get to work. Okay, let's get to work.

When last we left off on the data project, I was merely using the .glob()
method of a pathlib Path object to get a list of all the files in a directory.

So you've got a few CSVs you've downloaded from the Web UI of MOZ Pro and
you're ready to do something with them. These CSV files are lookups on a few
websites. This is to "seed" the data project with something which we can expand
outwards from. We have to do this because while using APIs, we only have access
to a limited amount of data in the system.

The "big version" of this project isn't going to require you to "seed" it with
a small number of sites. But what you do when you're approaching it from the
angle of only having access to MOZ Pro web UI and MOZ Links API is to make the
ambition of the project smaller. We seed the process with ourselves and a few
competitors. In this exercise, one of the listed sites would be us and the
other few competitors. However, since I'm using sites in my employer's network
for this study, none of them is really "us". I will choose an arbitrary site
from the list to serve as "us" (versus a competitor).

Here's how easy it is to turn a list of file paths into a list of pandas data.
I'm not concatenating them into one big list yet, because if I did they'd lose
the context of which original CSV it was loaded from. But this is a first step
and because of the way scope works, you can look at the last Pandas dataframe.

Pandas dataframes are roughly the equivalent of a tab in an Excel spreadsheet
or a table in a SQL database.

![Python Path Glob Pandas Df List Concat](/assets/images/Python-Path-glob-pandas-df-list-concat.png)

```python
from pathlib import Path
import pandas as pd

DATA_DIR = "../data"

dfs = []
for f in Path(DATA_DIR).glob("Competitive Research_ True Competitor - Moz Pro*.csv"):
    df = pd.read_csv(f, encoding="utf-8")
    dfs.append(df)
    print(f)
```


## Categories

<ul>
<li><h4><a href='/journal-md/'>Journal.md</a></h4></li>
<li><h4><a href='/csv/'>CSV</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>