---
date: 2023-01-01
title: From NoSQL SqliteDict to SQL Transformation
headline: "Exploring Machine Learning and Programming: My Journey Into SQL Transformation and Open Source Libraries"
description: I have been using the SqliteDict package to store data from API calls, and I'm now looking into parsing Google Photos data by day. I wrote a Python program to look at the contents of a database, and I'm now working on updates to the open source library ohawf. I'm planning to push out better documentation and am even thinking of creating an MLML license. Click through to read more about my journey in programming and machine learning!
keywords: NoSQL, SqliteDict, SQL, Transformation, API, Google Photos, Python, Database, Open Source, Library, ohawf, Documentation, MLML, Linux, Proprietary, Tools, Apple, SimpleNote, Vim, Git, AI, Model-Fitting, Races, Spacefaring, Child, Nurturing, Territory, Defending, Monkeys, Exploitation, Species, Galactic, Federation, Intelligent, Emotionally, Mature, Super
categories: open source, child, google, python, vim, proprietary, database, linux, git, ai
permalink: /blog/from-nosql-sqlitedict-to-sql-transformation/
layout: post
group: blog
---


So far, we've been using the pip installed SqliteDict package to do rapid
key/value data-capture. There's little easier than using your API-calls as the
keys and the API-response as the values. You can spin-through your calls and
commit your captures to storage to transform later. But it's going into storage
probably as an httpx response object blob (binary large object), or in some
cases as plain text such as a JSON. The example I gave for Google Photos for
example spins through your photo library using 9000 of your 10000 API for the
day and drops it into a .db file.

I've got to think about parsing Google Photos by day so I can pick up where I
left off. Give every day its own sort of uniqueness and parse day-by-day,
catching up on the backlog and being on top of it forever forward. But how can
you start "scrolling from the middle" in Google Photos API? Hmmm, let's ask
ChatGPT:

## How do you step through Google Photos using the photoslibrary api in python but starting from a certain date?

To start from a certain date when using the Google Photos Library API in Python, you can use the pageToken parameter in combination with the dateFilter.ranges.startDate parameter in your API request.

Here is an example of how you can use these parameters to retrieve media items from the library starting from a certain date:

# Set the start date for the date range filter
start_date = '2022-01-01T00:00:00Z'

# Set the `pageToken` parameter to an empty string
page_token = ''

```python
while True:
  # Set the `dateFilter.ranges.startDate` parameter in the API request
  # using the start_date variable
  response = service.mediaItems().search(
      pageSize=100,
      pageToken=page_token,
      dateFilter={'ranges': [{'startDate': start_date}]},
  ).execute()

  # Process the response

  # Set the `page_token` variable to the value of the `nextPageToken` field
  # in the response
  page_token = response.get('nextPageToken', '')
  if not page_token:
    break
```

This code will retrieve batches of media items starting from the start_date and continuing until it has retrieved all media items. The page_token variable is used to keep track of the current page in the result set, and the loop continues until the nextPageToken field is not present in the response, indicating that all pages have been retrieved.

That's nice. Thanks, ChatGPT and whoever it stole it from.

Okay, moving on. From a single Google Photos record, we want to design a SQL
database for the flattening. ChatGPT...

## How do you use the JSON structure of an object to design a SQLite3 Create Table statement to hold a flattened version?

To use the JSON structure of an object to design a CREATE TABLE statement for SQLite3, you can follow these steps:

Begin by defining the name of the table and the names of the columns that you want to include in the table. You can use the keys in the JSON object as the column names.

For each column, determine the data type that you want to use based on the data type of the values in the JSON object. SQLite3 supports a number of data types, including INTEGER, REAL, TEXT, and BLOB.

Use the CREATE TABLE statement to define the table, specifying the column names and data types. For example:

    CREATE TABLE tablename (
      column1 INTEGER,
      column2 TEXT,
      column3 REAL
    );

If you want to make any of the columns a primary key or foreign key, you can use the PRIMARY KEY and FOREIGN KEY constraints in the CREATE TABLE statement. For example:

    CREATE TABLE tablename (
      column1 INTEGER PRIMARY KEY,
      column2 TEXT,
      column3 REAL,
      FOREIGN KEY(column3) REFERENCES othertable(othercolumn)
    );

---

Okay, I can work with that as a starting point. We can get a few sample Google
Photo records like so:

```python
import ohawf
from sqlitedict import SqliteDict as sqldict

table = []
with sqldict("gphotos.db") as db:
    for i, gid in enumerate(db):
        print(i, end=" ")
        table.append((gid, db[gid]))
        if i > 1:
            break
```

And now we can look at the contents like key/value pairs like so:

```python
for record in table:
    for key in record[1]:
        value = record[1][key]
        print(f"key: {key} data: {value}")
    print()
```

This lets you look at some real data as you prepare a transform to flatten JSON
into SQL tables. It reveals 2 issues. The number of keys that come back may be
different for different records. I discovered a "description" field on some
records for example. I also see that one of the keys, mediaMetadata, has nested
sub-keys, one of which is "photo", which has more sub-keys. I'm going to want
to capture it all in the flattening. But one thing at a time. Let's spin
through all our records and make sure we know all the top-level keys...

```python
keys = set()
with sqldict("gphotos.db") as db:
    for i, gid in enumerate(db):
        record = db[gid]
        if len(record) == 2:
            for key in record[1]:
                keys.add(key)
```

Every key found this way will definitely get its own SQL table column because
it's flat in nature, being the first key in the object structure. They're
top-level navigation, such as it were. I wonder if mediaMetaData has consistent
fields. I know it's not flat, because I've already seen the subfield-stuffed
"photo" mediaMetaData key.

Ooh, ooh, here's one for you, ChatGPT:

## How do you pickle a key?

To "pickle a key" typically means to serialize the key using the pickle module in Python. The pickle module can be used to serialize any object in Python, including keys. Here's an example of how you can pickle a key using the pickle module:

```python
import pickle

# Assuming that `key` is the key you want to pickle

# Serialize the key using pickle.dumps()
serialized_key = pickle.dumps(key)

# You can then save the serialized key to a file or send it over the network
with open('key.pkl', 'wb') as f:
    f.write(serialized_key)
```

To deserialize the key later, you can use the pickle.loads() function:

```python
import pickle

# Load the serialized key from a file
with open('key.pkl', 'rb') as f:
    serialized_key = f.read()

# Deserialize the key using pickle.loads()
key = pickle.loads(serialized_key)
```

Damn, this is too interesting! Do you see it too?

Linux lets you close the lid to laptops in your life, without ever interrupting
GNU screens running your scripts elsewhere.

There are 3 places to run things. My New Years resolution is to get this fact
down pat. Give each place a strong identity and nickname in your mind. Divvy
out your getting-code-to-run proclivity and abilities between these three
strongly themed location. What shall I name mine, hmmmm... put it in Python
dict terms, but maybe think in YAML so you don't get bogged down with Python
curly brace syntax.

code_running_locations:
- laptop
- home_server
- work_cloud

Not sure how I feel about all those underscores, but it does get the point
across. Linux, all the way, baby! Poor Mac users, stuck on Apple Unix. Talk
about being locked in the top of an Ivory Tower, sheesh! I've got to teach Mac
people how to get off the proprietary bits. Unix ain't bad, and you should be
able to find your way around a terminal. But are you really going to take up
mastering lauchd as your generic tech-skill over systemd? No wonder all roads
lead to WebDev. There's such a confluence of proprietary that one feeds the
hunger for non-Apple systems with this Web Framework or that, which runs under
NodeJS, which gives Macintosh users that elite feeling, along with Ruby on
Rails, and that whole hip Web 2.0 wishes-it-was Linux/Python hip Web 2.0
toolset.

Is this still that same post where I started doing SQL? Wow, epic January 1st,
2023! Good way to get started. Keep running with this... oh hah, my morning
notes! You think it's been all over the place so far, wait until you see
this... loads up SimpleNote, copy-all, paste!

Scanning for Light Touches with Big Payoffs

There are firmly obsolescence resistant tools, such as Linux Python, vim & git.
They each beat an arch-rival that meritoriously should have won. Linux beat
Unix, the standard. Python edges out built-in JavaScript and C. VSCode can't
kill vim, the Black Knight.

The grey aliens are the same-like looking blah creatures they are because AI.
Model-fitting chops off the outliers and favors the plain old whitewashed
middle. Average all beings of your race and optimize genetics for traits deemed
favorable. Lather rinse and repeat for a few generations, and all diversity is
lost.

We are early-stage pre-spacefaring child nurturing territory defending monkeys.
To the lizard races who may have dozens of unviable eggs that hatch onto
helpful beings, the crying of an infant may not move them. Insectoid aliens?
Even worse. It's a good thing that we're going to practice with aliens of our
own creation for awhile, because contact always destroys the technologically
inferior species. Sux when the blankets have smallpox, but for countless more
reasons it will always end badly for the country bumpkins.

When you don't know what you don't know, you can't defend your minds or your
home planet. You are in a highly exploitable state. Very vulnerable to food and
cheap-labor seeking un-empathetic, un-mammalian-like species. Most roads lead
to ruin, I'm afraid on a galactic game of Clue. If aliens exist, probably the
only think keeping us safe is some version of the Green Lantern Corps.

I'm of course talking about a Star Trek-like galactic federation of
intelligent, emotionally mature super-monkeys that maintain and value
individuality and distinctiveness. Balanced coexistence in a stable-enough
system. To each their own, but don't come shitting in my yard or you'll get a
smackdown. Let races evolve. Let them get things out of their system.

If you don't back off from a race as it's maturing and figuring out atomics and
fusion and AI and AG, and artificially suppress their true nature so them can
jump on the spacefaring species too soon, then you just may have planted the
seeds of your own doom. You're super-capable because balance. Introduce
something that throws off that balance, like a warrior species suddenly with
starships and robot spaces, then somebody's going hunting, and that's not good
for anybody.

Though shalt remove complex issues of file-paths and cross-boundary
state-fullness when evaluating taking up this technology or that. You always
can find a technological short-cut, but it's bound to be a dependency-inducing
trap. You'll never get away from this library or that, or being exhibits and
staff at this facility or that. Genuinely unique, recently evolved
problem-solving genetic code is likely to be highly valued, the universe
throughout.

Evolving our AIs today firmly puts us on the path to another extinction-event
class problem, similar to atomics, and similar to when sentient monkey
populations got down to the thousands. You need a deep and wide enough gene
pool to pale horse cooper papers, some variety of that of Light Touch Big
Payoff Scanning

There are firmly obsolescence resistant tools, such as Linux Python, vim & git.
They each beat an arch-rival that meritoriously should have won. Linux beat
Unix, the standard. Python edges out built-in JavaScript and C. VSCode can't
kill vim, the Black Knight.

The grey aliens are the same-like looking blah creatures they are because AI.
Model-fitting chops off the outliers and favors the plain old whitewashed
middle. Average all beings of your race and optimize genetics for traits deemed
favorable. Lather rinse and repeat for a few generations, and all diversity is
lost.

We are early-stage pre-spacefaring child nurturing territory defending monkeys.
To the lizard races who may have dozens of unviable eggs that hatch onto
helpful beings, the crying of an infant may not move them. Insectoid aliens?
Even worse. It's a good thing that we're going to practice with aliens of our
own creation for awhile, because contact always destroys the technologically
inferior species. Sux when the blankets have smallpox, but for countless more
reasons it will always end badly for the country bumpkins.

When you don't know what you don't know, you can't defend your minds or your
home planet. You are in a highly exploitable state. Very vulnerable to food and
cheap-labor seeking un-empathetic, un-mammalian-like species. Most roads lead
to ruin, I'm afraid on a galactic game of Clue. If aliens exist, probably the
only think keeping us safe is some version of the Green Lantern Corps.

I'm of course talking about a Star Trek-like galactic federation of
intelligent, emotionally mature super-monkeys that maintain and value
individuality and distinctiveness. Balanced coexistence in a stable-enough
system. To each their own, but don't come shitting in my yard or you'll get a
smackdown. Let races evolve. Let them get things out of their system.

If you don't back off from a race as it's maturing and figuring out atomics and
fusion and AI and AG, and artificially suppress their true nature so them can
jump on the spacefaring species too soon, then you just may have planted the
seeds of your own doom. You're super-capable because balance. Introduce
something that throws off that balance, like a warrior species suddenly with
starships and robot spaces, then somebody's going hunting, and that's not good
for anybody.

Though shalt remove complex issues of file-paths and cross-boundary
state-fullness when evaluating taking up this technology or that. You always
can find a technological short-cut, but it's bound to be a dependency-inducing
trap. You'll never get away from this library or that, or being exhibits and
staff at this facility or that. Genuinely unique, recently evolved
problem-solving genetic code is likely to be highly valued, the universe
throughout.

Evolving our AIs today firmly puts us on the path to another extinction-event
class problem, similar to atomics, and similar to when sentient monkey
populations got down to the thousands. You need a deep and wide enough gene
pool to pale horse cooper papers, some variety of that of Light Touch Big
Payoff

There are firmly obsolescence resistant tools, such as Linux Python, vim & git.
They each beat an arch-rival that meritoriously should have won. Linux beat
Unix, the standard. Python edges out built-in JavaScript and C. VSCode can't
kill vim, the Black Knight.

The grey aliens are the same-like looking blah creatures they are because AI.
Model-fitting chops off the outliers and favors the plain old whitewashed
middle. Average all beings of your race and optimize genetics for traits deemed
favorable. Lather rinse and repeat for a few generations, and all diversity is
lost.

We are early-stage pre-spacefaring child nurturing territory defending monkeys.
To the lizard races who may have dozens of unviable eggs that hatch onto
helpful beings, the crying of an infant may not move them. Insectoid aliens?
Even worse. It's a good thing that we're going to practice with aliens of our
own creation for awhile, because contact always destroys the technologically
inferior species. Sux when the blankets have smallpox, but for countless more
reasons it will always end badly for the country bumpkins.

When you don't know what you don't know, you can't defend your minds or your
home planet. You are in a highly exploitable state. Very vulnerable to food and
cheap-labor seeking un-empathetic, un-mammalian-like species. Most roads lead
to ruin, I'm afraid on a galactic game of Clue. If aliens exist, probably the
only think keeping us safe is some version of the Green Lantern Corps.

I'm of course talking about a Star Trek-like galactic federation of
intelligent, emotionally mature super-monkeys that maintain and value
individuality and distinctiveness. Balanced coexistence in a stable-enough
system. To each their own, but don't come shitting in my yard or you'll get a
smackdown. Let races evolve. Let them get things out of their system.

If you don't back off from a race as it's maturing and figuring out atomics and
fusion and AI and AG, and artificially suppress their true nature so them can
jump on the spacefaring species too soon, then you just may have planted the
seeds of your own doom. You're super-capable because balance. Introduce
something that throws off that balance, like a warrior species suddenly with
starships and robot spaces, then somebody's going hunting, and that's not good
for anybody.

Though shalt remove complex issues of file-paths and cross-boundary
state-fullness when evaluating taking up this technology or that. You always
can find a technological short-cut, but it's bound to be a dependency-inducing
trap. You'll never get away from this library or that, or being exhibits and
staff at this facility or that. Genuinely unique, recently evolved
problem-solving genetic code is likely to be highly valued, the universe
throughout.

Evolving our AIs today firmly puts us on the path to another extinction-event
class problem, similar to atomics, and similar to when sentient monkey
populations got down to the thousands. You need a deep and wide enough gene
pool to pale horse cooper papers, some variety of that of...

---

Okay, back from paste.

And back to that SQL-stuff I want to finish. I left a script running on my NAS.
My experiment:

```sh
[py310] ubuntu@ev:~/data/gphotos $ python ~/repos/gphotos/gphoto_keys.py
Using scopes from ohawf source code.
Logging in... Successfully logged in as m*******@gmail.com
[py310] ubuntu@ev:~/data/gphotos $ ls
gphotos.db  keys.pkl
```

Wow, I'm so happy with my updates to [ohawf](https://pypi.org/project/ohawf/)
over the past few days. It now supports properly scoped feeding of pickled
credentials files, client_secret json's and scopes lists. You can pick
different authenticated and authorized google logins. In a pinch, you can throw
it into flow.run_console() mode and do the token copy/paste trick for Google OAuth2

Hmmm. Gonna push out some better documentation for ohawf. I think it could be
very popular. What's the nbdev release process for ohawf again?

```sh
nbdev_bump_version
nbdev_export
nbdev_docs
git commit -am "Something meaninful"
git push
nbdev_pypi
```

When in doubt, use HTML. Think!

- Got a github and you're yearning something to report?
- NB Dev, just bump the version then nbdev_export

Hmmm...

    version
    export
    docs
    git commit & push
    pypi

With all that I publish like this, maybe I should write an MLML license... the
Mike Levin Machine Learning License. I guess that would be the MLMLL, or just
the MLL as it would be shortened to. I don't need my name in it, LOL! MLOL!
MLMLLOL! MLMLMAOL! Stop me bore I teach a machine something stupid again.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/should-i-no-longer-hyde-from-a-jekyll-server/">Should I No Longer Hyde From a Jekyll Server?</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/every-week-date-for-last-30-years-with-fixed-ids/">Every Week Date for Last 30 Years With Fixed IDs</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/open-source/'>Open Source</a></h4></li>
<li><h4><a href='/child/'>Child</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/proprietary/'>Proprietary</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>