---
date: 2022-08-17
title: A Day In The Life of An SEO SERPs, Python Pandas & SEMRush
headline: "Exploring the World of SEO: A Day in My Life of Code and Analysis"
description: Today, I'm embarking on a scavenger hunt to find the code I used the last time I did this project. I'm using Python to extract information from a database file, transform it into a usable format, and export it as a CSV file and an Excel xlsx file. I'm also using regex and tldextract to extract the domain from the search results. Finally, I'm using a bulk keyword analysis tool and a pivot table to organize the data.
keywords: SEO, SERPs, Python, Pandas, SEMRush, Database, CSV, Excel, xlsx, Regex, tldextract, Bulk Keyword Analysis, Pivot Table, Scavenger Hunt, Virtual Desktops, SQLite, Extract_serps, Tuple, List, Dataframe, Google Sheet
categories: excel, python, sqlite, csv, seo, pandas, database
permalink: /blog/a-day-in-the-life-of-an-seo-serps-python-pandas-semrush/
layout: post
---


Okay, part of making Linux, Python, vim & git love-worthy is making even just
your day-job, the things you do to pay for it all, love-worthy as well. You
can't let what you "have to do" make you lose your love for what you "want to
do" just because they employ and tap the same tools and capacity in you. Make
what you have to do into what you want to do through Jedi mind tricks. This is
the exercise you're looking for. Okay, 1, 2, 3... 1?

Fixed locations for Virtual Desktops: Journal, Jupyter, Web. Yup. Okay, always
nice to close everything and make a fresh start as if a system reboot after
closing everything so things don't auto-re-open. Then launch each screen's
item. I'm on screen 1 with the journal here now. 1, 2, 3... screen 2! That's
Jupyter.

Hmmm, there;s always a scavenger hunt at this point. What did you use the last
time you did this project. Are you going to reuse the old code or just do it
from scratch. If reusing the code, are you going to do it in-location where the
project was last time, or are you going to start fresh in some new location? If
you start fresh in a new location, are you going to copy/paste bits of your
old code or import it like a Python package for reusable components? You always
know something better if you write it from scratch. The question is exactly how
much from scratch? We don't burn our computers from sand, so we're always
choosing our shortcuts.

I find one of the strongest approaches is to start fresh every time. Give the
project a strong nickname. If that nickname already exists in your repos,
rethink. If it doesn't, get started in a new folder, directory, repo or
whatever name you want to use. It should probably be child to a ~/github folder
so that you can make good evaluations regarding name collisions. If you're
searching through complex hierarchies for past work, you're making a mistake.
Keep it all flat under /home/[username]/github/. If you're on Windows, install
WSL so you have such a location.

Create the new repo folder directory. Give it a good nickname. Create the new
.ipynb Notebook. Rename notebook from Untitled.ipynb and give it a good
nickname too, maybe the same as the folder. That's always a more important step
than it would seem.

Move the data you'll be working with into that folder.

Okay, it was like 5GB of data on the network and the Windows-based copy crapped
out on me so I just restarted Windows. Okay, what's the easiest way in Python
to step through a set of files in the folder you're in?

```python
from os import listdir
for file in listdir('.'):
    print(file)
```

But we only want those that end with .db so this list comprehension:

```python
[x for x in listdir('.') if x[-3:] == '.db']
```

And so the above becomes:

```python
from os import listdir
for file in [x for x in listdir('.') if x[-3:] == '.db']:
    print(file)
```

And now that we know that, we can really just reduce it to this line to give us
a list containing all the database file names:

```python
dbfiles = [x for x in listdir('.') if x[-3:] == '.db']
````

Each of these is a sqlite database that used pip install sqlitedict to create a
key-value style database. And to load them back in, we need that import. We can
do the import and test that we can load each database with this. They're big
files, so I need to put in that timeout:

```python
from sqlitedict import SqliteDict as sqldict
for dbfile in dbfiles:
    with sqldict(dbfile, timeout=10) as db:
        for key in db:
            data = db[key]
```

This will also give you some idea of how long it's going to take to spin
through the data because it actually loads each record into memory.

Okay, now given that the data is the entire Python response object of scraped
search results and you have an extract_serps function on-hand such as this one:

```python
import re

def extract_serps(text):
    rv = False
    try:
        div_pat = re.compile('<div class="yuRUbf">(.*?)</div>')
        divs = re.findall(div_pat, text)
        lot = []
        for div in divs:
            pat_url = re.compile('<a href="(.*?)"')
            url_group = re.match(pat_url, div)
            pat_title = re.compile('<h3 class="LC20lb MBeuO DKV0Md">(.*?)</h3>')
            title_group = re.search(pat_title, div)
            try:
                url = url_group.groups(0)[0]
            except:
                url = ""
            try:
                title = title_group.groups(0)[0]
            except:
                title = ""
            lot.append((url, title))
        rv = lot
    except:
        pass
    return rv
```

...then you can make sure you can extract the serps from the data and that it's
coming out properly.

```python
from sqlitedict import SqliteDict as sqldict
for dbfile in dbfiles:
    with sqldict(dbfile, timeout=10) as db:
        for key in db:
            data = db[key]
            if data:
                serps = extract_serps(data.text)
            raise SystemExit()
```

Yeah, that's the stuff. This is friggin' performance art. I can feel the
dopamine rush kicking in. If you're someone in life that feels the impostor
syndrome in what you do, take up Python. Get to know it and learn to think in
Python. Become freely expressive as you would be in normal writing. Become
freely expressive (like this) in normal writing, for that matter. It's all the
same thing. Okay, next step? Well, the data only contains a list with links and
titles, and we need to know what domain the SERPs came from in the final
transformed data format, and also the SERP positions. On any given iteration of
the above loop, the position in the serps list actually is the search engine
position. Given Python's zero-based indexes, you just have to add 1 to know the
SERP position. Oh, the database key which is actually the key in the key-value
pairs also needs to be moved into the transformed output data. It's essentially
going into Excel format where there are no database keys, so the key becomes
just another column.

We get the domain name from the name of the database file on each outer-loop
iteration. We could extract it from the link each time using urlparse, but
that's way too much overhead. We can just use slicing to do that. We're sitting
on the dbfiles list of database filenames, so we can do this to test our
thinking:

```python
dbfiles[0].split("-")[1][:-3]
```

Bingo! Okay, so in the loop we just replace dbfiles[0] with dbfile:

from sqlitedict import SqliteDict as sqldict
for dbfile in dbfiles:
    domain = dbfile.split("-")[1][:-3]
    with sqldict(dbfile, timeout=10) as db:
        for key in db:
            data = db[key]
            if data:
                serps = extract_serps(data.text)
            raise SystemExit()

Now there's a tricky piece to wrap your mind around. We've got to add a third
loop because we have to transform the shape of each row in the serps list. We
can do that in a way where we can inspect the first row we encounter:

```python
from sqlitedict import SqliteDict as sqldict
for dbfile in dbfiles:
    domain = dbfile.split("-")[1][:-3]
    with sqldict(dbfile, timeout=10) as db:
        for key in db:
            data = db[key]
            serps = extract_serps(data.text)
            for serp in serps:
                row = serp
                if row:
                    raise SystemExit()
```

But the row needs some data appended to it, so we add the domain, keyword and
serp position to each row. If you're doing this in Jupyter, you can just
inspect the row value afterwards to see the first row you're going to
encounter. But all these rows need to be thrown into a table. Okay. Notice I
check to make sure data is there and how I turn the row into a tuple on the
table append to be kind to my laptop's memory. I'm also moving all my import
statements to the top of the Notebook, so you won't be seeing them in the
following code snippets anymore unless there's a new one.

```python
table = []
for dbfile in dbfiles:
    domain = dbfile.split("-")[1][:-3]
    with sqldict(dbfile, timeout=10) as db:
        for key in db:
            data = db[key]
            if data:
                serps = extract_serps(data.text)
                for i, serp in enumerate(serps):
                    row = [domain, key, i + 1] + list(serp)
                    table.append(tuple(row))
```

I had to convert the serp row into a list. It was previously a tuple which is
great for memory, but you can't add tuples to append row elements. You can with
lists, so I do. And guess what? We're sitting on top of a table that's all
ready to be transformed into a pandas dataframe. And so there will be a new
import!

```python
import pandas as pd
df = pd.DataFrame(table, columns=["domain", "keyword", "positon", "url"])
```

Do you see why nearly doing a project from scratch every time is often the
right way to go? It forces you to think through the project and have a deep
familiarity with the data and the process. It's not big codebases or millions
of lines of code like this stuff used to be in the past. It's just easy breezy
conversation.

Now if you have Excel, you can load the CSV directly into Excel to see how we
did:

```python
df.to_csv("serps.csv", index=False)
```

And there's 2 things I notice. First, some html is slipping into the title
column and second, there's some gobbledygook that's clearly indicative of an
encoding error. So as usual we grab for utf-16 on the encoding:

```python
df.to_csv("serps.csv", encoding="utf-16", index=False)
```

Well, that worked but we lost our columns when bringing it into Excel. This
means that the CSV file-format handling got confused. You know the best way to
deal with that? Ditch CSV, especially now that Pandas supports exporting to
native Excel xlsx file format directly, though you do need to pip install
openpyxl if you haven't already. The new file-save looks like this. You should
delete the old serps.csv.

```python
df.to_excel("serps.xlsx", encoding="utf16", index=False)
```

And that did it! But now to deal with the html slipping into the title tags
which is still a problem. Now there's more efficient ways to do this with
compiling the regex pattern and maybe making a strip_html function, but I'm in
a hurry.

```python
table = []
for dbfile in dbfiles:
    domain = dbfile.split("-")[1][:-3]
    with sqldict(dbfile, timeout=10) as db:
        for key in db:
            data = db[key]
            if data:
                serps = extract_serps(data.text)
                for i, serp in enumerate(serps):
                    url, title = serp
                    title = re.sub('<[^<]+?>', '', title)
                    row = [domain, key, i + 1] + [url, title]
                    table.append(tuple(row))
```

Wow okay yeah, that did it. And it was all on a dopamine rush of the thrill of
being able to do this "from scratch" without scrambling for this and that. This
is such a big thing with tech today, everyone wants to reuse code at too high
an abstraction-level, the abstraction level of easy breezy communication. I
would not have liked to have rewritten the extract_serps function, so that's
the bit I reused. Nothing else.

Okay, there's another caveat to this project. I have another site.db file that
I've been hiding because not all the results are from the same domain as they
were with the previous databases (restrained by a site: google search modifier
as they were... gee, did I forget to mention that?). Okay, so here's a more
typical situation which I also happen to have to handle on this project where
the domain in the search results may be anything. Now normally you can just use
urlparse from the standard library for this sort of thing, but I prefer pip
install tldextract because registered domains, or "apex" domains, are actually
rather tricky given all the country double-TLDs like .co.uk. For example:

```python
from tldextract import extract
extract("blah.foo.co.uk")
# Results in:
ExtractResult(subdomain='blah', domain='foo', suffix='co.uk')
```

And so we modify the upper code. This is where those allergic to retyping code
or copy/pasting blocks instead of writing functions (the disciples of the DRY
school, for "don't repeat yourself") will freak out--especially on that RegEx
bit which I totally could externalize into a function. But to them, I say I'm
not DRY. I'm WET. We enjoy typing. Let me repeat myself: we enjoy typing! Nyah
nyah nya nyah nya!

```python
dbfile = "./site/serps.db"
table = []
with sqldict(dbfile, timeout=10) as db:
    for key in db:
        data = db[key]
        if data:
            domain = "foo"
            serps = extract_serps(data.text)
            for i, serp in enumerate(serps):
                url, title = serp
                parts = extract(url)
                domain = f"{parts.domain}.{parts.suffix}"
                title = re.sub("<[^<]+?>", "", title)
                row = [domain, key, i + 1] + [url, title]
                table.append(tuple(row))
```

Alright, all the data is transformed. Now, don't lose your momentum. I'm coming
down from the dopamine rush, but that's a problem in the final mile. This kind
of work isn't done until it's done. And just because the part that you now
think is the only sexy, exciting part of the project is over doesn't mean that
the next step can't seem just as sexy and exciting to you with the right mental
tricks.

Now is a good time to pat yourself on the back and give yourself your own big
attaboy's. Close all windows on all your various virtual desktops except for
the first 3, which contain journal, jupyter and browser, respectively. Think!
Getting down to just those 3 screens with those 3 apps is a great way to
evaluate next steps... of course!

Open Google Sheets. Close all browser tabs except for tab 1 containing Google
Sheets. Find the old deliverable that was like this one I'm working on.

There's a 500 keyword list that this project is based on. I need to pull
metrics like search volume against all those keywords and this is a case where
there's no reason to hit an API. The Web user interface is plenty. SEMRush has
a bulk keyword took that takes 100 keywords at a time, entered comma separated
in to a field that detects the commas and changes the UI to a cool numbered
keyword-per-line web form. Nice responsiveness. Anyhow, I need to shake & bake
the keyword list into groups of 100. Here's the code I used for that:

```python
from os import listdir
import pandas as pd
import warnings

warnings.simplefilter(action="ignore", category=UserWarning)

# Use the SEMRush bulk keyword analysis tool at
# https://www.semrush.com/analytics/keywordoverview/bulk/?db=us
# pasting in 100 keywords at a time. Watch the trailing comma.

with open("keywords.txt") as fh:
    keywords = [x.strip() for x in fh.readlines()]

for i, keyword in enumerate(keywords):
    keyword = keyword.replace(",", " ")
    if not i % 100:
        print()
        print()
    print(keyword, end=",")

semrushfiles = [x for x in listdir(".") if x.find("_bulk_") > -1]

dflist = []
for file in semrushfiles:
    df = pd.read_excel(file, engine="openpyxl")
    dflist.append(df)

df = pd.concat(dflist)
df.to_excel("keywords.xlsx", encoding="utf16", index=False)
```

Pshwew! Okay, it's hours later during the day. Busy, busy, busy!

It's time to move all this data into Google Sheets and turn it into a great big
pivot table. Pivot tables in Google Sheets is pretty bleeding edge.

<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/reworking-site">Reworking Site</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/bring-pipulate-levinux-back-into-the-picture">Bring Pipulate & Levinux Back Into The Picture</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/excel/'>Excel</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/sqlite/'>SQLite</a></h4></li>
<li><h4><a href='/csv/'>CSV</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li></ul>