---
date: 2023-02-03
title: Using Google Photos API to Generate Main, Archive & Favorite Media Lists
headline: Creating Easier Access to Google Photos API with Python Functions
description: I'm using Google Photos API to generate three databases - 'all', 'main', and 'favorites' - and an 'archive' database. I'm using Python functions to query the API, store the results, and create custom labeled tuples with a start date and end date. I'm also chunking the project into week-by-week chunks, making it easier to manage. This code provides a way to make the code clearer and easier to understand.
keywords: Google Photos API, Generate, Main, Archive, Favorite, Media Lists, Python, Query, Store, Results, Create, Custom, Labeled, Tuples, Start Date, End Date, Chunking, Project, Manage, Code, Clearer, Understand, Database, Input Values, Pickled Format, SQLite, Week-by-Week, Namedtuple, Splat, Query-Writing, Function, Labels, Meaning, Table
categories: tuples, python, database
permalink: /blog/using-google-photos-api-to-generate-main-archive-favorite-media-lists/
layout: post
---


Okay the Google Photos gradual delete program that uses browser automation on a
headless Linux server making up for the API's lack of organizing features ran
overnight. It's a slow process, but moving things into the trashcan is allowed
to trickle day by day. Emptying Trashcan is still manual, or automatic on files
deleted more than 60 days ago, so there's a nice margin for error.

The thing I find issue with is how I generate the databases. There is not
necessarily a Next Page Token.

My start has been absolutely awesome. However, I do want to maybe protect
favorites from deletion even if they're in the archive. That's an interesting
thing. Delete favorites off last.

Get busy! We need 3 queries, each of which has its own chunked raw data:

    "includeArchivedMedia": archive

Hmmm. I designed this lovely function to query against Google Photos:

```python
def search(npt, start, end, archive=True, favorites=False):
    sY, sM, sD = start.split("-")
    eY, eM, eD = end.split("-")

    args = {
        "pageSize": 100,
        "pageToken": npt,
        "filters": {
            "includeArchivedMedia": archive,
            "dateFilter": {
                "ranges": [
                    {
                        "startDate": {"year": sY, "month": sM, "day": sD},
                        "endDate": {"year": eY, "month": eM, "day": eD},
                    }
                ]
            },
        },
    }
    if favorites:
        args["filters"]["featureFilter"] = {"includedFeatures": ["FAVORITES"]}
    return args
```

And I can send input like this:

```python
search("foo", "2023-01-31", "2023-02-31", archive=False, favorites=True)
```

...which creates this output:

```python
{'pageSize': 100,
 'pageToken': 'foo',
 'filters': {'includeArchivedMedia': False,
  'dateFilter': {'ranges': [{'startDate': {'year': '2023',
      'month': '01',
      'day': '31'},
     'endDate': {'year': '2023', 'month': '02', 'day': '31'}}]},
  'featureFilter': {'includedFeatures': ['FAVORITES']}}}
```

Okay, so for each week I actually want to produce 3 raw databases. The data
within is chunked because of paged requests and replies. That means no ideal
primary key for each chunk. Maybe the API call, but the first has "None's" by
default, so you can't go using "None" as a primary key type. There always needs
to be SOMETHING there to be unique, to be a key.

So much personality and understandability and usability of a pseudo-app like
this (pseudo-app because it exists mostly as it exists as a distributed Jupyter
Notebook), comes from how you name these files.

- 2000.db (now ambiguous and unnecessary)
- 2000-all.db
- 2000-main.db
- 2000-favs.db

So with 3 API-calls, you can get all, main and favs. With 1 more pass, you get:

- 2000-archive.db

There's no API-call to produce only media items from the archive, so we must
live with doing the 3 data-pulls we can, keep 3 separate "raw" databases. Such
a database as this contains "chunked" data. That is, the results were banked
right away in a pickled format using the details of the API-call to "unpickle"
that data, and therefore you can take a snapshot of an API-response for later
recreation, much like a cache, but 100% under your control with SQLite3 tech.

Okay, the best way to produce economic product is to be skilled. These are the
skills now in the new data era. If you don't want to be reliant on particular
products that are a signature of this time and place, and you'd rather "just
know tech stuff", then follow closely. I'm about to talk through how to use
API-calls as namedtuple primary keys in a sqlite database, without having to
know SQL nor much more but how to use a Python dict and the "context manager",
which is a fancy way of knowing to use the ***with*** keyword.

I need to run the above query with a variety of different input-values in order
to produce the local data I need for following steps. This is the raw-data
data-collection phase of a project. But it's too big to get it all right away.
So how do you "chunk" your greater job. How would you for example, process your
entire Google Photos history in week-by-week chunks?

Weeks are about right, because if you think of each week as an image-folder, no
week will have so much media that it becomes unmanageable with a typical modern
laptop. A ~2020 Windows laptop can handle a week's worth of Google Data photo
from your account pretty easily. I suppose some people may have such busy
media-production weeks that it'd strain this system on busy weeks. But for the
most part, looking at your entire life week-by-week is going to be a couple
thousand folders at most.

So let's chunk your life up based on weeks. The week of your birth is week 1.
I'm so close to Unix Timestamp time which is January 1, 1970 that I use the
week of my birthday in the example. Change it to UTC or put your own birthday
in there. That'll give you a week-1 and a fixed frame-of-reference for time.
Got that? You control the X/Y-axis of your life. You live the X, so let's
create the tick-marks of your life. Week-1 is a number of days between 1 and 7
based on what day-of-the-week you were born. That's week 1. Week 2 is the first
full week following that starting Monday. And so on.

So I produce this output:

    Constrain time-ranges
    Using start date: Thursday, 1970-08-27
    Week-zero starts: Monday, 1970-08-24
    It has been 2737 weeks since start.
    Table of tuples (this is your life)¶

    Start
    Week(number='0', start='1970-08-24', end='1970-08-30')
    Week(number='1', start='1970-08-31', end='1970-09-06')
    Week(number='2', start='1970-09-07', end='1970-09-13')
    ...
    Week(number='2734', start='2023-01-16', end='2023-01-22')
    Week(number='2735', start='2023-01-23', end='2023-01-29')
    Week(number='2736', start='2023-01-30', end='2023-02-05')
    End

    Selecting random week
    Random week between 2010-11-08 and 2018-01-01 is:
    Week(number='2426', start='2017-02-20', end='2017-02-26')

And so you see, you give it an initial input and now you've got a week-1 and a
finite number of bundled arguments ready to be serializable string-keys (my
favorite kind of keys). This is kooky. Follow along. Python's got something
called a ***namedtuple*** that you get access to like this:

```python
from collections import namedtuple
```

And with that, you can create your own custom "labeled" tuple like so:

```python
Week = namedtuple("Week", "number, start, end")
```

And now you can stamp out new instances of your new instance. This is instances
of instances ala Object Oriented Factory Classes blah blah, couldn't care less.
Namedtuples are cool. Forget the silly labels around these labellers. Just be
happy tuples are so readily made pretty.

```python
aweek = Week(number='0', start='1970-08-24', end='1970-08-30')
```

Which you can do with position-dependent brevity:

```python
aweek = Week('0', '1970-08-24', '1970-08-30')
```

I don't want to use Python "None" values as a key in a database. But I can use
a container object that contains optional None's. To use it as a key, I can
convert an object to its text-based representation. In other words, convert a
tuple to a string. And the string representation of None is no longer None. So
the string representation of these namedtuple objects will be our keys.

But wait, there's more! What if you want the positions in the tuple labeled so
the database keys are a serializable object that tells you a lot about the
object on sight, namely the values that were sent to the API to produce the
value connected to this key, which you will remember is the API response.

Loops are both the least efficient and most readable way of creating all the API parameter combinations that are going to be needed overall.  This is all combinations.

```python
for week in weeks:
    print(week)
    for a in [True, False]:
        for b in [True, False]:
            print(f"a: {a} b: {b}")
    print()
```

This can be restated as:

```python
for week in weeks:
    print(week)
    for includeArchive in [True, False]:
        for onlyFavorites in [True, False]:
            print(f"includeArchive: {includeArchive} onlyFavorites: {onlyFavorites}")
    print()
```

Which outputs:

    1
    includeArchive: True onlyFavorites: True
    includeArchive: True onlyFavorites: False
    includeArchive: False onlyFavorites: True
    includeArchive: False onlyFavorites: False

    2
    includeArchive: True onlyFavorites: True
    includeArchive: True onlyFavorites: False
    includeArchive: False onlyFavorites: True
    includeArchive: False onlyFavorites: False

    3
    includeArchive: True onlyFavorites: True
    includeArchive: True onlyFavorites: False
    includeArchive: False onlyFavorites: True
    includeArchive: False onlyFavorites: False

Yuck. I don't like this mental framework. Only certain strongly nicknamed combinations are necessary. Start with the nickname and purpose.

- all
- favorites_archive_included
- main_archives_not_included

There are certain lists Google Photos API doesn't like like "only archives". But the above-described ones are are possible and help derive the other lists. Match each of the above with the API arguments

- all includeArchive: True onlyFavorites: False
- favorites_archive_included includeArchive: True onlyFavorites: True
- main_archives_not_included includeArchive: False onlyFavorites: False

Boring, spicy, everything? Main, favs and all!

- all includeArchive: True onlyFavorites: False
- favs includeArchive: True onlyFavorites: True
- main includeArchive: False onlyFavorites: False

We have this structure:

```python
table = [(True, False), (True, True), (False, False)]
for atuple in table:
    print(atuple)
```

Yup. This provides much clearer thinking. The following code will create a table of namedtuples ready to splat into that query-writing function for the Google Photos API.

```python
tots = [(True, False), (True, True), (False, False)]
table = []
start = "2023-01-01"
end = "2023-01-07"
for i, atuple in enumerate(tots):
    arch, fav = atuple
    aweek = Week(i, start, end, arch, fav)
    table.append(aweek)
```

We have an opportunity to layer in labels and meaning without it being too verbose. Let's!

```python
paramdict = {"all": (True, False), "favs": (True, True), "main": (False, False)}
weektupes = []
start = "2023-01-01"
end = "2023-01-07"
for name in paramdict:
    atuple = paramdict[name]
    arch, fav = atuple
    aweek = Week(i, start, end, arch, fav)
    weektupes.append((name, aweek))
weektupes
```

Which lets us do this:

```python
for weektupe in weektupes:
    name, aweek = weektupe
    dbname = f"{aweek.number}-{name}.db"
    print(dbname)
```

And now housekeeping is ready for the three types of raw data capture we're
going to need to do for each week. We've got the api values of the requests all
planned out.

Wow such a small piece of outer loop code and so much it accomplishes.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/testing-google-photos-organization-program/">Testing Google Photos Organization Program</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/how-to-cluster-keywords-from-google-suggest-api/">How To Cluster Keywords From Google Suggest API</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/tuples/'>Tuples</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li></ul>