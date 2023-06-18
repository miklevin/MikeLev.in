---
date: 2023-05-10
title: Adding Python Version Parameter Support to DrinkMe for Snowflake Snowpack
headline: Exploring the Possibilities of Python Version Parameter Support with DrinkMe and Snowflake Snowpack
description: Explore the power of Snowflake's Snowpack data warehouse with Python 3.8 support. Learn how to set up a parameterized .bat file to install the Snowflake connector and access the data in a familiar Python environment. Discover the advantages of manipulating terabytes of data without pulling it down to your local machine.
keywords: Python, Version, Parameter, Support, DrinkMe, Snowflake, Snowpack, MOZ, Links, Data, SEOs, Content, Auto-Generated, AI, Industry, Ziff Davis, Jupyter Notebook, Experiential, Internal Clients, Abstract, Fictional, Sites, Brand, Impact, Rapidly Changing, Streamlit, Visualization, Lazy Loading, Terabytes, Query, APIs, Cloud, Data Warehouse, Marketplace, Copilot,
categories: ai, drinkme, seo, python, jupyter
permalink: /blog/adding-python-version-parameter-support-to-drinkme-for-snowflake-snowpack/
layout: post
group: blog
---


I'm producing a series of Jupyter Notebook deliverables, alternating between
experiential stuff for real Ziff Davis properties and internal clients, and
then more abstract or fictional sites for the public. Working for MOZ and
helping to sell MOZ products, I can be much more free with deliverables.

YES! That's the story. That's the Hello World! I've got to keep tension in that
machine. Watch your distractions. Develop your moz github repo, even if you're
not making articles and videos for everything. Explore the Links API more. See
what's possible, more than just the light descriptions. Do some mighty
impressive deliverables with broad application.

Hmmm. Murphy's Law is Murphy's Law. As I take my deep breath to get started, I
hit a snafu (situation normal, all effed-up). I want to play with Snowflake
through Jupyter Notebook, but I don't want Anaconda. I want to work some PFM,
but the Snowflake WebUI for Python... ugh. A whole new UI. A whole new Python
environment with non-standard rules.

Upon investigating, it looks like there's pretty decent Jupyter Notebook
support, where I'd feel comfortable. But it's only Python 3.8! Argh! But there
are some enticing advantages to this approach. First I should point out that
it's not just `pip install snowflake-connector-python` as one would hope. That
will install something, but it pulls all the data locally and loses much of the
advantage of using the Snowflake package. Anyone will be able to use the Web UI
and show a few interesting things, dealing with that bit of funkiness. But few
will be able to really reveal the power.

The power comes from using something called `snowpark`, which is not merely the
snowflake-connector. It takes advantage of the ability to leave all the data
you're working with in the cloud and not actually pull it down to your local
machine (or Colab/whatever). You leave it on the Snowflake cloud and page
through virtual Pandas-like dataframes with lazy loading. Hmmm. Much less
painful and much more of the type of advantage one would hope to get from a
system like this. And I can work in my familiar Python environments, probably
even NeoVim. It's another place I should check the VSCode experience too.

Okay, the plan is forming. I've taken long enough on this front and I have to
make moves ahead worthy of the moves ahead I've made on my blogging system
front that makes these investigations fun, easily published and AI-powered. YOu
can not underestimate the importance of tools whose strengths is to transport
you into the zone and get you into flow state. I am in.

The temptations are mounting, because not only will I be able to say things
like: I could be manipulating terabytes of data with this query, but it all
***feels*** local and I'm in the familiar Python environment of any Data
Science or Data Engineer professional. This is the sort of difference in APIs
between situation A and situation B the folks I answer to may be interested in
hearing about. This is a major differentiation of Snowflake over other
approaches. Other cloud data warehouse marketplaces may offer this, but it is
cloud data warehouses that offer this.

Also, they're dangling one of my favorite data visualization tools in front of
me, [streamlit](https://streamlit.io/), and I keep talking about the
visualization aspect of this and if I can get it into the demo with and talk
about the lazy loading of terabytes of data, well then this starts to become
interesting. Hmmm. This is all looking and sounding and feeling wonderful, but
for one thing.

Did I mention Murphy's Law? It requires Python 3.8 exactly. And while yes, I
could just venv a new Python 3.8 environment, I'm not sure I want to do that.
My whole approach is to use the same Python environment for everything because
it's already on a Windows virtual Linux environment and I hate doing these
ziggurats of VEs. But the solution is clear, but I must avoid rabbit holes. I'm
clearly not going to do the querying work tonight unless I take a nap. But I
can get the environment ready, and I'm in very familiar turf. I can just
parameterize drinkme.bat to take a parameter of the Python version. And I now
have Copilot in my .bat's to help me, haha!

Okay, deep breath... I need a refresher on parametrizing .bat files. I need to
write a `Hello World` of parametrizing bash scripts and test it on the old
DOS-like CMD window and the newer Powershell terminal.

```
@echo off
echo Hello %1
```

Yep, confirmed. That'll echo back whatever (unlabeled) parameter you feed it,
and that's fine. I'm not going to be feeding it that many... uh, Ubuntu
version? No, no, no! Rabbit holes. One itch tonight. One anonymous parameter
tonight. Forge on ahead! Have a Snowpark's chance in hell of doing this work
tomorrow.

I need a version that will set a default value if not received, which will work
identically in either DOS-style CMD or Powershell...

```
@echo off
SET VAR=%1
IF "%VAR%"=="" SET VAR=3.11
SET VAR=%VAR: =%
echo %VAR%
```

Okay, that gives us a default value when invoked from either CMD or Powershell,
and it sets a default value to 3.11 if nothing is provided.

But now we're playing a game of baton. I have to hand this value now as an
argument to the install.sh (Linux-side bash script) that's being invoked from
the Windows-side .bat file. So it's the exact same deal. First we need to
establish that we can read arguments at all with a sort of hello world:

```bash
#!/bin/bash
echo "$1"
````

Confirmed. Chances are the way I have it set up now, `install.sh` will never
**not** have an argument, but we have to program defensively. So how do we
likewise set a default value in a bash script if an argument is not provided?

```bash
#!/bin/bash
VAR=${1:-3.11}
echo $VAR
```

Nice. The `install.bat` and `install.sh` should functionally be working exactly
the same now, except if an argument is provided on the command-line of the .bat
file, it should be passed along to the .sh file and be available to be used as
the requested Python version.

This is a classic rabbit hole, but given how easy it is to rebuild a whole
Linux instance under my `drinkme` system, I should take advantage of that fact.
I can just be on Python 3.8 for awhile while I'm using `Snowpark` and go back
lager. Eventually, they're going to have to support newer Python versions, so
this is a temporary thing anyway.

Okay, think. Next step? Commit and push and do the test on a different laptop
so journaling isn't interrupted, given that it's running on the very Linux VM
I'll be replacing. It's worth pointing out non of the repos or data get wiped
out symlinked in from Windows-side as they are.

Okay doing the experiment now. I love having the 2 laptops running at once.
Switch hardware occasionally. Rebuild your Linux-side occasionally. All very
healthy. All very dynamic-lifestyle with static-lifestyle advantages.
Transportable muscle memory, almost unbelievably nice after all my setbacks in
these types of things over the years.

Okay, I've tweaked the drinkme repo. I renamed the py311 virtual environment to
just pyenv so I don't have to keep it updated so many places. And drinkme is
running just fine with the default (Python 3.11) and now I'm testing it with
Python 3.8. If it works, I'm going to bed. I'll do the Snowflake / Snowpack
part of it tomorrow.

Okay, it worked like a charm. Now miklevin/drinkme can support at least tested
python 3.8 and probably a whole lot of other versions as a command-line
parameter when running install.bat, which of course means you can't use the
desktop double-click trick if you want to change the Python version. Instead,
you open a CMD or Powershell and run it from a command-line with the
number-like argument 3.6, 3.8, 3.10, etc.

    .\install.bat 3.8







<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/ode-to-azrael-and-a-world-completely-changed/">Ode to Azrael And a World Completely Changed</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/if-you-re-so-good-at-seo-why-aren-t-ais-talking-to-you/">If You're So Good at SEO, Why Aren't AIs Talking to You?</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/drinkme/'>DrinkMe</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>