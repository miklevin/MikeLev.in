---
date: 2022-04-08
title: Jupyter Notebooks Are Dev Tools With nbdev
headline: Exploring nbdev and LPvg with JupyterLab to Automate 24x7 Systems
description: I'm exploring nbdev and LPvg to advance my knowledge of Python and the tools available for 24x7 automated systems. I'm using JupyterLab on Windows and have learned about commands like nbdev_clean_nbs, nbdev_build_lib, nbdev_build_docs, and more to help with the release process. I'm excited to see what I can do with nbdev and am embracing the challenge of incorporating it into my workflow
keywords: Jupyter, Notebooks, Dev, Tools, nbdev, LPvg, Python, Commands, nbdev_clean_nbs, nbdev_build_lib, nbdev_build_docs, Papermill, Parameterize, Notebooks, nbdev_bump_version, git, push, make, pypi, pip, installable, libraries, mistune, version, 0.8.4, Anaconda, J
categories: jupyter, nbdev, pypi, python, git, lpvg, journaling
permalink: /blog/jupyter-notebooks-are-dev-tools-with-nbdev/
layout: post
---


Well, I just copy/pasted that entry from yesterday about whatsametafor.io and
nbdev out to that site. In fact, this very entry now will probably be the
second journal-style entry over there. Get stuff kicked off. You can just start
pushing stuff out as markdown transformed into HTML through the Jekyll system.
That's good for now. It's a solution that abides by the 80/20-rule to large
degree. It's the github.io documentation publishing system that this trick
uses, along with the associating of custom registered domains with github.io
spaces. It's a good trick.

As I get more advanced, I'll use some sort of "make" process to build these
journal entries from whatever, and perhaps to paginate and organize them into a
more user-friendly surfable tree-structure or other navigation system. I'm
keeping it open ended, because just like my YouTube videos, I'm doing this
writing more for me than for you. If it ever helps you out in any way, I am of
course glad I could do some good in this world. But it's more about total
immersion and practice in this Linux, Python, vim & git methodology I advocate.

Adeptness in LPvg doesn't come easy and requires lots of practice. It's with
that practice, organizing content over a diverse set of sites will also come
easy. It's just copy/paste between text files, and eventually running some
scripts to put things in place. The scripts can of course be triggered with a
git push integration these days, but that's getting ahead of myself. I'm
focusing on nbdev and my advancements over the past few days right now. That's
where I push my own personal state-of-the-art forward.

Okay, just dump out your new realizations. This belongs on whatsametafor.io
because it is all about tooling-up. Isn't that my linuxpythonvimgit.com site?
Well, I'll sort that all out later. This is heady stuff and quite derivative
from my LPvg approach, because it plays off of the honorary-mention of
JupyterLab in my essential toolkit. JupyterLab is a game-changer for a number
of reasons I'll cover in a separate article. But when the time comes to do more
advanced things than the Python execution context of Jupyter (clicking Run in
browser) provides, there are basically 2 approaches: Papermill to parameterize
Notebooks (still .ipynb) or nbdev to "extract" package.py files appropriate for
parametrized use in Linux scheduler/pipeline systems or even releasing as pip
installable PyPI packages for publishing and sharing.

Clearly I went the nbdev route since I've been talking about it so much. In
fact, I'm quite enamored with the approach and am willing to forgive a "make"
process for the .py-file package-extraction just as happily as I'm embracing
the web browser as a portal to a standard CPython.exe. For you see, Jupyter
really is based on a fairly recent but always quite standard official Python
release, and so all the skills and techniques you learn, even while running
Python in a web browser, are 100-percent applicable to a long-term career
involving Python, Jupyter or not.

I wasn't keen on Jupyter at first but it won me over. I like generic old-school
tools. I dislike Excel and I'm just this side of Linux guru commands like awk
and gcc. I mostly use minimal Linux, Python, vim and git. That means no desktop
graphical user interface. Mikey likey generic command-line interface. Generic
means obsolescence resistant, disruption proof and a good candidate for the
sort of muscle memory you use for natural recording and playing back keyboard
macros. This is vim. It's a zen-zoning thing. So it was to my great surprise
I've added Desktop Jupyter to my indispensable toolkit.

I learned Notebooks on Jupyter Classic as running in a browser tab and
installed by Anaconda. I fell in love with its unique exploratory coding
environment and how you could mix in documentation and really talk about
process. It was perfect for my field of search engine optimization (SEO), a
form of data jockeying. I jumped to JupyterLab when it came out for the better
user interface and promise of data-dashboard-building possibilities (as made
clear by the dask package).

Anaconda changed their terms of service and Jupyter put out a standalone Web
app version, and the world has changed. Nobody knows it yet, but stand-alone
Jupyter changes everything. There is now the one clear best stepping stone into
programming for newcomers… period. Not newcomers to Python in particular or
even just Data Science or Machine Learning. But everybody with a mainstream
desktop Windows, Mac or Linux can write and share in language and in a way
where the skills will directly last them the rest of their lives.

Microsoft got close with their Store install when you type python from a CMD
window and how it subsequently guides you to VSCode as a way to write and test
your code. You'll get a very recent Python 3.10 that works as python.exe
filename.py but you'll never have to because all of your interaction will be
through VSCode. And if you're fine with being dependent on vendor tools until
the next time fads change everything and you have to retrain your muscle memory
all over again, then you're good. It's a very cool aid.

But now that you don't need all of Anaconda on your machine to get to the good
part, Jupyter, then if you can find it, the Microsoft Installer file (MSI) for
Jupyter provides a much better on-ramp to the wonderful world of coding in
general and Python in particular than anything else I've experienced. Of course
Mac and Debian/RPM have their own installers. We all win when JupyterLab works
well stand-alone in this world of Web-apps and wheels.

I'm over 10 years int Python now, mostly though the vim text editor and
headless Linux servers. That 10 years of Python was also in "fool-me-twice"
mode. In other words, I'm determined to not get fooled again. And so I've
steered clear of particular vendors and "vibes" of products that have steered
me wrong in the past. And when I say steered me wrong, I particularly mean that
the hard-won muscle-memory-bound skills of text-editor adeptness, automatic
macro-making ability and such. I'll always build upon what I know. I was quite
happy to add new API-extensions to my Python know-how, such as list
comprehensions, lambdas, the context manager, the walrus operator and such. But
these all get layered-in over the years without invalidating all your past
work. Python's only at version 3 after 30 years after all. That says a lot
about API stability.

Notebooks with a .ipynb extension or all the same Jupyter features in VSCode
with a .py extension? Going the VSCode route with .py extensions is indeed very
tempting and may even be the better choice for "pure" developers. Certainly if
you're using NodeJS in a "full web stack" you're going to ***need*** VSCode.
You can't really manage the complexity of the directory structures and build
process without vendor power-tools. But if the current fads of WebDev aren't an
artificially limiting criteria for you today, using actual .ipynb (Notebook)
files through JupyterLab has its advantages.

Top among them is that Notebooks are intended to read like, well, Notebooks.
You can go back and forth between code and documentation. The documentation are
cells which are switched from their default mode as Code (Python by default) to
Markdown. When in Markdown mode, a cell lets you use the abbreviated easy
notation for making headlines, sub-heads, paragraphs, lists, code excerpts and
the like without the overhead of full-fledged HTML tags. In other words, all
those pointy brackets go away and you can focus on just content.

Wait, what? Focus on content in programming code? Yes, where better! Python's
top criteria when Guido van Rossum wrote the language was readability. Readable
code is long-lived useful code. People having to inherit and take over other
peoples code don't have to adapt to style that much. Sure there will be some
style, but the more people program in Python over time, the more styles
converge onto a Pythonic ideal that makes you just as self-satisfied with your
idyllic solution as in a PERL code obfuscation contest. Different vibes.
Python's got a good readable vibe that frees your documentation efforts up for
really high level stuff.

In other words, because the operation of Python code is in so many cases,
self-evident, your documentation can talk more about overarching purpose than
the mechanics. Or when you do talk about the mechanics, it's really something
worth talking about because implementation isn't immediately obvious.

Okay, so Notebooks good. Notebooks in standalone desktop Jupyter even better.
.ipynb files have a reason to exist that doesn't go away because VSCode can
apply the Juptyer REPL-engine (what makes exploratory programming possible) to
.py files in VSCode. In case you didn't know, you can execute code in VSCode
block-by-block just like in Jupyter because VSCode detects a Jupyter
installation and "lifts" those features. You've got to love a Free and Open
Source Software world. All sorts of feature-embedding Kung Fu is possible. And
some of this VSCode Kung Fu appears at first glance to invalidate, or at least
obsolete .ipynb Notebooks. As evidence they don't I present to you the
continuing growing popularity of Notebooks in all places where their Notebook
qualities are actually an asset. Data Science, Finance and my field of SEO are
three that pop to mind.

I have to force my way through next steps. I've recently overcome a number of
hurdles working a Notebook developer tool, appropriately named nbdev, into my
work-flow. It wasn't easy. It still isn't easy. But I have faith that it will
become easy because the benefits are just so big. All those upsides of
Notebooks has the one whopping big downside that when it comes time to
automate, you need to either take the code out of the .ipynb Notebook
environment, or you need ways to run your Notebooks a lot more like they were
standalone .py-files, right down to supporting parameterized input so
schedulers/pipelines can apply the same processes against different input.

As I mentioned earlier in this article, when faced with the choice between the
two leading packages for these purposes, you have to pick a "vibe" such as it
were. The vibe of Papermill works the actual .ipynb Notebooks into a
parameterized, schedule-able, and otherwise automateable component. This
maintains a Notebook-centric vibe. While appealing at first, the alternative
sprang out of fast.ai and a Literate Programming advocate, Jeremy Howard. You
really have to listen to Jeremy Howard speak to appreciate how deep this goes.
Google the still-living computer scientist Donald Knuth and Literate
Programming to appreciate the vision Jeremy's trying to achieve with nbdev.

Honestly, the way best-of-breed components build upon each other these days, it
should be no surprise that someone connected the dots between components to
release such potential. In particular, the iPython "REPL" engine existed before
the browser-based version we know as Jupyter. iPython would become literally
millions of times more accessible if only you could get to it through the
familiar web browser user interface. So the dots were connected between
iPython, Chrome browser components via the Electron project, NodeJS with all
the components talking to each other through ZeroMQ. For those familiar with
how the lightweight Flask weboframework sits on top of Werkzeug and the Jinja
templates to release such vast potential by cleverly connecting the dots on the
underlying components, it's the same thing.

nbdev is a bit more subtle, but along the same lines. Arguably, Project Jupyter
itself is serving the role of Flask, gluing together iPython, Electron and
ZeroMQ, creating what we know today as the Notebook phenomenon. For those not
familiar with the broader Notebook product category in academia that has been
around for awhile that Jupyter has become the FOSS (free and open source)
leader, it's been dominated by such products as MATLAB (not to be confused with
the popular Python package Matplotlib) and Wolfram Mathematica. These are
products that math students in college use to solve all sorts of mathematical
problems while embedding student notes. This field has been somewhat disrupted
by Project Jupyter. While MATLAB and Mathematica are both commercial products
with licensing fees, Jupyter is both free and open source and comes by default
with Python, leading to a much greater ability to ***integrate*** whatever
analytical processes you explored your way to in a Notebook to 24x7 automated
systems.

Jupyter made a huge impact maybe a decade ago when the field of Science (in
general) had a crisis of reproducibility. Studies showed that over 1/3 of all
published scientific research was unreproducible by scientific colleagues given
the same original data-set and the published findings. Given that a main tenant
of science is that given the same initial conditions and processes, you can
expect the same results, this was a problem. And nobody wanted to require the
payment of commercial licenses to MATLAB or Mathematica to distribute
reproducible science. Jupyter Notebooks were in ready-shape to step in and fill
this vacuum. It was a perfect storm. So now a lot of people are in Notebooks
working in "Lost" mode. That is, they have to sit there and press the button.

nbdev bridges that gap between Notebooks and 24x7 information technology
systems. By that I mean that the very same code as is in the Notebook is the
production-ready code being used in webservers or schedulers. You could imagine
something that looks much like a data dashboard inside of Jupyter can be
transplanted into a web environment so that a web address will reproduce that
same dashboard in browser, or alternatively be emailed as a PDF attachment on a
daily basis or updating a Google Sheet. Bridging this gap with nbdev is not
merely a stupid Notebook-trick (as it would be with Papermill). Instead, it's
easing you into the world of standard (Notebook-less) Linux/Python code-running
contexts.

Okay, so pip install nbdev. Easy enough, right? If you're on Windows using the
Windows Subsystem for Linux (WSL or WSL2), then you have to pip install nbdev a
second time over on the Linux side. I highly recommend this because the tools
are developed on a Unix/Linux like environment (Mac, I think) and using the
command-line tools just works more smoothly. That's not to say you can't use
the nbdev command-line tools from the Windows side, through say PowerShell. But
I wholeheartedly believe that it's easier in Linux, and this of all places
should be where you begin your venture into the Unix/Linux command-line
interface (CLI), also known as the Terminal or SSH Shell. It's the "old way"
that will never go obsolete.

I work in JupyterLab Desktop for Windows. This means that all the environment
paths are of the oddball Windows sort. Consequently, it's good to take up
operating system independent habits such as using pathlib.Path from the Python
standard library for all file interaction. Keeping your paths OS-independent
will generally mean that you're coding in a platform-independent fashion.

Now here's the thing. That concept of you coding in a platform-independent
fashion comes off as so many buzzwords. It is not. This is significant and new
and different. Once acquiring some pretty good Python skills and a basic
command of the "naked" or "headless" Linux code execution context (Raspberry
Pi's, cloud servers, etc.), you have always applicable, always relevant skills
for a lifetime. The joke goes that when our machine children return to Earth in
a million years to see what's become of use, they'll still have a Linux boot
kernel. Learning this stuff has a long shelf-life and high degree of
applicability.

So really it's about "taking control" of a piece of hardware. Anyone can write
a bit of code in Jupyter. But to really make it have an ongoing impact on the
world, it needs to start running when some server somewhere starts running, and
keep running until you want it to stop. So interestingly, the seldom-discussed
big trick in tech is getting some code running as if it were an operating
system service auto-started at boot. That's the Frankenstein moment of
breathing life into a previously powerless piece of equipment. That's where
real power comes from in tech. Anyone can install, run and use other peoples'
products. But I'm talking about having the generic ability to "make products".

Recently thanks to some standardization in the Linux distros, there's a "simple
enough" boot sequence, service-launcher (daemons), scheduler called systemd. d
is for daemon. Simple enough? It was copied from a pre-existing Mac OSX system
manager called launchd. If you want to learn Linux a little beyond the ssh, cd
and ls commands so you can take full control of a machine, you want to learn
some systemd. We're about 10 years into systemd and most major Linux distros
are using it, so it looks like we've got a winner. Learn how to start services
at boot-time essentially turning it into an appliance (setting up Docker
images, for example) and you will appear to be a tech deity.

Okay, so once you've pip installed nbdev, what's different? What's changed in
JupyterLab? Well, almost nothing you'll notice straight away. Instead, there's
a prescribed workflow that kicks in. In this way, it's reminiscent of data
pipelining software or certain frameworks in which you simply adhere to a
certain convention, and you'll get some magical benefits.

First, you must know that there are command-line commands that have been
installed onto your system. They go by such names as nbdev_new,
nbdev_build_lib, nbdev_clean_nbs and such. They should be executed from the
same command-line environment that runs your Python. This has presented a
unique challenge for me with Desktop Jupyter for Windows.

Flash-update! I just tested the default Terminal configuration in Jupyter
3.3.2-2 and a Microsoft PowerShell is properly configured! Pip is working from
there. The same Python 3.8.13 can run from there. I even tested a few of the
nbdev commands, including command-line completion in PowerShell to cycle
through all the different nbdev commands. nbdev_clean_nbs and nbdev_build_lib
both worked. nbdev_build_docs had problems, but I only really got that working
on the Linux side for the first time yesterday controlling the issues like
hiding the async function. So now the PowerShell that comes up as a default
part of JupyterLab Desktop has just now become very equivalent to the Anaconda
Prompts did in the past. This is good news for people who haven't taken the WSL
Linux plunge on Windows yet. Don't use this as an excuse not to.

On the WSL Linux side, I'm running Ubuntu 20.04. I boot directly into my daily
working virtualenv where I'm running Python 3.10, which is slightly ahead of my
3.8 on Jupyter. I steer clear of the new pattern matching filter functions for
now. I'm looking forward to Jupyter being on 3.10.

The main gist of nbdev, you can get at their tutorials. Here's their [minimal
example](https://nbdev.fast.ai/example.html) and here's their [general
tutorial](https://nbdev.fast.ai/tutorial.html)

I'll give you my main take-aways.

You can't just make a new folder and nbdev_new in there. You've got to have a
git remote endpoint and the easiest way to do that is to host it on Github.
Also it should be public because of something about installing the git hooks.
You can switch the repo back to private after running nbdev_new. Also if you
don't use nbdev_new, you can [clone this
template](https://github.com/fastai/nbdev_template).

Once nbdev_new runs successfully, the next important thing to know is that
there are fields that really have to be filled-in in settings.ini, including
keywords and description. Some of them are edited out on the default and HAVE
TO be edited back in.

There's a bunch of commands in nbdev, but the main commands that I'll use in my
release process are:

- nbdev_clean_nbs (Get the meta garbage out of git commits)
- nbdev_build_lib (Extracts package, should be done before nbdev_build_docs)
- nbdev_build_docs (Creates a docs/file.html for every file.ipynb)
- nbdev_bump_version (Increments version number for PyPI release)
- git commit -am "Ready for release"
- git push
- make pypi

I also like to make sure all my pip installable libraries are up-to-date. This
can occasionally break nbdev. The package in particular that has to be locked
at a certain version right now for the nbdev_build_docs procedure is:

    !pip install -U mistune==0.8.4

Okay, so what I want to figure out most is how the html files in /docs get
published. Clearly the index.html becomes README.md for Github's main project
page.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/concurrent-web-crawling-in-python/">Concurrent Web Crawling in Python</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/jupyter-notebooks-are-dev-tools-with-nbdev/">Jupyter Notebooks Are Dev Tools With nbdev</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/pypi/'>PyPI</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/lpvg/'>LPvg</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li></ul>