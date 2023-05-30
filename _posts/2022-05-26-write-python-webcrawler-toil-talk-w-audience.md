---
date: 2022-05-26
title: Write Python Webcrawler! Toil & Talk w/Audience
headline: "Explore Programming with a Tech Samurai: Writing a Python Webcrawler & Comparing Languages"
description: As a professional programmer, I'm exploring the world of webcrawling with Python. I'll discuss how to avoid recursion and use iteration, as well as key-value data-stores, Python context managers, user agents, and the DRY principle. I'll also compare Python to other languages like RUST, and discuss the challenges of being a programmer in the digital age. Join me as I explore the world of programming and share my secret weapons as a tech Samurai!
keywords: Python, Webcrawler, Iteration, Key-Value Data-Store, Python Context Manager, User Agent, DRY Principle, RUST, Programming, Communication, High Standards, 24/7 Availability, Generalist, Marketing, Secret Weapons, Samurai Warrior
categories: coding, python, marketing
permalink: /blog/write-python-webcrawler-toil-talk-w-audience/
layout: post
---


The time has come the walrus said to write a web crawler... AGAIN! This is one
of my all-time best livecasts. It's a 3-hour gift of awesome that you should
watch from beginning to end if you're in the field of SEO or anything else
where data is important. Of course you can ignore me and remain dependent on
vendor products.

Okay, so it's time to code a webcrawler. This is not my first time. I know
precisely what pitfalls I wish to avoid, namely recursion.

# Avoid Recursion... The Infinite Pitfall

Recursion is tempting. It's awesome. It's not nice to the memory of your
computer nor to knowing what's going on.

So what is recursion for the uninitiated? The alluring way to write a crawler
is this where you call a function from itself like this:

    def foo(bar):
        foo(bar)

    foo('value')

This solves some of the challenges of writing a crawler, but creates others.
So it seems like a good idea at first, but simple iteration is better:

    for x in range(1000)
        foo(bar)

# Onto Coding The Crawler

This session follows onto yesterday's video of Python dictionary high
performance persistence, thanks to Sqlite3 built into Python, but generally
inaccessible for FAST key/value-pair (NoSQL) interface. It's usually row &
column, which slows you down mentally. Key/value data-capture lets you work
fast and furious.  It is in my opinion that the use of a key-value data-store
is the first step in any project involving fetching data because no matter what
you fetch, there's details of the request that become the key, and the fetched
data that becomes the value. Fetch, store, fetch, store, fetch, store. You can
always transform the data later.

{% include youtubePlayer.html id="OBgtq0BuX94" %}

# It's 3:30 AM

To toil or not to toil? That is the question. Sleep is good, but once you've
got enough, uninterrupted focus-time that is "out-of-time" for getting into the
zone or the flow is good too. One must balance the two.

1, 2, 3... 1? Notebook!

To have a "real" database in the picture is usually a tech liability. It's not
with Sqlite.

# A Reminder, It's About SEO & Keywords

We have to get a handle on the "issues" going on in a website.

- Is it targeting keywords?
  - Title tag
  - Keywords in URL
  - Headline-like element
- Is it a spider-trap (wasting resources)
  - Surfable calendars with no end
  - Infinite pagination

# Crawl Strategy

Pull the whole site down quickly into Sqlite3.

While we COULD do asyncronous concurrent web crawling for some real fast site
slurping, we're going to do sequential page-fetching for simplicity's sake and
to make a point about starting small on the crawl. Don't go for a million pages
initially, especially when getting started learning Python & crawlers. Time
enough for x10 complexity later.

Using URLs as Database keys is key.

- Vint Cerf (Internet) https://datatracker.ietf.org/doc/html/rfc2616
- Tim Berners-Lee (Web)

Don't be beholden to the "echo chamber" of SEO or any other field... go to the
original sources of information.

# Python Context Manager

"With" indicates the Python "context manager" (which avoids explicit opening
and closing of files). It's NOT a loop.

Don't always follow the common wisdom. Those folks are talking in forums and
twitter because they don't have work to do. I'm doing THIS at 4:20 AM because I
have no time, and I DO have MOTIVATION... AND SO, AT 4:20, I show you stuff.

Thank's Jer... there's stuff I'm not covering like http SESSIONS. Huh? Same a
browser... login is still logged in on your 2nd page-load, otherwise you'd be
logging in an awful lot on websites. Session is persistence of certain data
(often cookie-based) between pageloads.

Also skipping setting user_agent.

DRY Don't Repeat Yourself... not even once!!! If you do, they will be all over
you like someone who learned Java in CompSci 101. They're wrong.

# Finished Web Crawler Code

```python
from sqlitedict import SqliteDict as sqldict
import requests
from requests.models import Response
from mlseo import *

url = 'https://mikelev.in/'
resp = requests.get(url)

# We Initialize First Data Write of a Crawl
with sqldict('crawl.db') as db:
    db[url] = resp
    links = extract_links(resp.text)
    for link in links:
        if link not in db:
            db[link] = None
    db.commit()

for x in range(10):
    with sqldict('crawl.db', timeout=20) as db:
        for i, key in enumerate(db):
            resp = db[key]
            if not resp:
                print(i, key)
                resp = requests.get(key)
                if type(resp) == Response:
                    if resp.status_code == 200:
                        db[key] = resp
                        links = extract_links(resp.text)
                        for link in links:
                            if link not in db:
                                db[link] = None
                    db.commit()
    h2(f'LOOP {x}')
h1('Done')
```

I took a little time after the livecast to make all the URLs get recorded, even
if they're 404 (page not founds). They can always be queried later to find the
bad pages. To find the pages they linked from will be a different project,
because this version of a crawler basically throws out the "link graph".

```python
from sqlitedict import SqliteDict as sqldict
from requests.models import Response
from mlseo import *
import requests

url = "https://mikelev.in/"
resp = requests.get(url)

# We Initialize First Data Write of a Crawl
with sqldict("crawl.db") as db:
    db[url] = resp
    links = extract_links(resp.text)
    for link in links:
        if link not in db:
            db[link] = None
    db.commit()

for x in range(10):
    h2(f"LOOP {x + 1}")
    with sqldict("crawl.db", timeout=20) as db:
        for i, key in enumerate(db):
            resp = db[key]
            if resp == None:
                print(i, key)
                resp = requests.get(key)
                db[key] = resp
                db.commit()
                if type(resp) == Response and resp.status_code == 200:
                    links = extract_links(resp.text)
                    for link in links:
                        if link not in db:
                            db[link] = None
                    db.commit()
h1("Done!")
```

# Follow-on Discussion With Audience

Wow, what an epic 3-hour session!

Once again I throw it open to discussion with the folks on the livecast chat.
And once again, the discussion comes back to my love for a particular set of
tools:

- Linux
- Python
- vim
- git

"Full Web Stack"... rat race... hamster wheel... fire & motion

# Joel Spolsky Fire & Motion Article

What's fire and motion, you ask? Well, read [Joel Spolsky's article on the
topic](https://www.joelonsoftware.com/2002/01/06/fire-and-motion/) (a topic on
which he wrongly backtracked &#151; Microsoft put a horse-head in your bed,
Joel?). But to put in in a nutshell:

- Soldiers in World War One did trench warfare.
- Took a trench one at a time, charging forward in surges.
- They had to duck under enemy fire.
- All the work goes into taking the next trench... and might kill you.
- This is moving from dev tool to dev tool in tech.
- You pay vendors for upgrades.
- There is a consultant feeding frenzy... like sharks. Everyone gets $$$
- But you get killed trying to take the next trench.

What I say is simply don't engage in trench warfare (fire & motion / constant
re-training). Choose better tools. Choose free and open source software (FOSS)
tools that are serious about not changing the APIs on you every 2 to 5 years.
Look at the grief caused in the Python community going from Python 2.x to
Python 3.x. It tore the Python community apart, and those were small API
changes compared to what happens every year in the JavaScript world with the
ECMA Script standard.

# Python is Less of a Moving Target

Yes, but Python changes too. Like recently, it's Python 3.8 to Python 3.10. Did
it change a lot? No, it only changed very little. And they were mostly additive
changing with no older APIs breaking and little to no retraining necessary. We
got the walrus operator and a new switch-like filter. Yawn! Not at all like:

ReactJS vs VueJS

Boy, those folks are really screwed. And where are you going to have to all run
to after VueJS goes out of style, my friends? Sure JavaScript is the pee in the
pool of tech just like Python and PERL now, but it's tied to a time-and-place.
It's tied to the state of browser platforms and mobile devices of the early
2020's... just like PostScript was tied to the laserprinters of the 1990s. A
platform-specific language does not a timeless tool make.

Sorry, JavaScript bros.

Django in 1998... you could Django today... Maybe switch from mako templates to
jinja2... maybe.

- Linux
- Python
- vim
- git

Are timeless, obsolescence-proof (future-proof), resist disruption.

# LISP & eMacs Users are Real Wizards

I covet... I am jealous of the true "meta" wizards of tech who uses as their
equivalent of LPvg:

- LISP (some dialect)
- eMacs (text editor)
- ??? (they probably wrote themselves... refer to above 2 points)

This is both a:

- Spiritual issue
- Pragmatic issue

# Python is For Cheaters & Shortcut-Takers

Specifically, Python is for shortcut-takers and finish-line racers. Python lets
you get stuff done fast, building on many, many shoulders of many, many
domain-specialists. You name the field, I can pip install the package, from
gene splicing to goat herding.

This is not a bad thing. We all stand on the shoulders of giants. Python people
just have a big box of giants to choose from. Python is a bit less plagued by
NIH-syndrome than some other languages. NIH stands for "Not Invented Here".
Many programmers want to do all the work themselves for the experience. While
that can be good, wouldn't it also be nice to satisfy your boss (or yourself)
today? I mean right now? I mean you could be done the project already.

If I were talking about a child's game of red-light, green-light, the question
is who is better off when RED LIGHT is shouted out? It's the Python user, of
course. It's because Python makes all the right compromises (for productivity)
that most people want to make most of the time. If you want to go off the
beaten track, you want LISP or something like it.

- The 80/20-rule (get value out of the 1st 1/5th of time) applies to LPvg
- LISP/emacs people can be 100% uncompromising, but the "win" is later.
  - Original DARPA DOD AI contests were won by LISP wizards
  - Crossing CA desert with autonomous vehicles... possible because LISP
  - Doesn't apply so much today, because Python 80/20-ruled even that.
  - LISP is for perfectionists
  - Python is for cheaters (creative thief's)

# Am I Saying Don't Use RUST?

But what about other languages that are gangbusters in popularity today like
RUST? Actually, specifically RUST. I mean RUST is everywhere no today, isn't
it? Yes, and it's great. There's always going to be an "almost C" language. In
the past it was Java. Then it was Google's Go Lang. Today's C-like language du
jour is RUST.

Not only is there room for RUST & GoLang, they SHOULD be used where
appropriate. I love Python because I'm not a professional developer. I don't
write drivers, OSes, or native apps. Those things are usually best with some
language that's "like" C, but fixes it's biggest headaches.

- Go Lang did that for Google... great! Many advantages.
- Rust is doing it in many other places. Also, awesome.

# Not Computer Literacy... It's Just Plain Literacy!

Programming, coding... whatever... is just plain literacy. It's not computer
literacy. It's not really even tech. It's just communicating without many of
the shortcomings of human spoken languages. Autistic? Maybe. Want to know my
vibe? Want to know Python's vibe? Go to a Jupyter Notebook and run:

    import this

# I Am Not A Geine

So why am I not (or at least not consider myself) a "professional programmer"?
It's because professional programmers make products and are held to very high
standards and are on the hook for things that make me cringe. It makes you much
like an indentured servant. In the old days, you'd be "on a beeper". Today,
it's just 24x7 availability through the Net. If your product fails anyone
anywhere, they're looking for you.

Web Development: Web Server... like a genie. *POOF* What do you need?

# WebDev be like:

    *POOF* What do you need?
    *POOF* What do you need?
    *POOF* What do you need?
    *POOF* What do you need?
    *POOF* What do you need?

Not my vibe.

# Linux services (automation after Notebooks) be like:

- Here's your daily meal.
- Here's your daily vitamin.
- It's exactly what you ordered.
- I knows your requests because it's the same as yesterday's.
- I can expand the menu. But chiefs do that very carefully.

***This is my vibe.***

# Even when it's not automated

- Exploratory programming (creative exploration)
- Jupyter Notebook
- It's just literacy
- Donald Knuth Computer Literacy
- But they call it "REPL" for Read Eval Print Loops (word = yuck!)

Aside from having no good name, ***this is my vibe too***.

# Samurai Warriors of The Information Age

Samurai Warriors of the Information Age are not professional developers. Those
are the farmers or herders. Some may be plain soldiers. None of that is for me.
I am a generalist in the world of marketing who carries secret weapons.

It's easy to think of my vibe as a Samurai warrior of tech. It isn't the same
as working you like a WebDev or App Developer workhorse. Someone cracks the
whip at you, you can just walk away. Your skills are valuable, rare and
applicable under any conditions for any employer. You're not tied to a
particular code-base or project. You just carry your universally applicable
samurai sword around inside of you. It is an internal asset that's never going
bad or going away.

They're standing by ready to slice of a head.

Huh? By slicing off a head, I mean getting data. Prepping data. Transforming
data. Making it pretty. Delivering it to people who need it... all without a
webserver even in the picture. If it has to be automated, you put it on a Linux
daemon under systemd (a Linux service). The value is just like that of ye olde
Samurai slicing off a head.

# Gotta Fix MikeLev.in... Eventually

Next steps: using the crawl discoveries TO FIX MIKELEV.IN!!!

Especially the titles tags!

Github Pages Jekyll system... and my blog slice & dice system.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/python-seo-step-1-persistent-dictionaries/">Python SEO Step #1: Persistent Dictionaries</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/trying-to-get-python-sbin-commands-from-nbdev/">Trying to get Python sbin commands from nbdev</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/coding/'>Coding</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/marketing/'>Marketing</a></h4></li></ul>