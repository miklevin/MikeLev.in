---
date: 2022-11-03
title: Powering My Way Through 3 Different Data Automation Projects
headline: Finished My Data Automation Projects with Satisfaction Despite Mental Fatigue
description: Today, I powered my way through three data automation projects, using tricks to make the work more enjoyable and browser automation to avoid extra steps. I sliced a Jupyter Notebook, loaded data, and used a modulo technique to chop a long keyword list into batches of 100. Despite feeling mentally fatigued, I finished the day with a sense of satisfaction. Read more to learn how I overcame hurdles and proved the viability of the project.
keywords: Data Automation, Jupyter Notebook, Browser Automation, Google Chrome, User Profile, SEMRush, SERP-Scraping, Keyword List, Modulo Technique, Fuzzy Matching
categories: browser automation, jupyter notebook
permalink: /blog/powering-my-way-through-3-different-data-automation-projects/
layout: post
---


Sometimes the new work is mentally fatiguing even before you begin, but it has
to get done. And in those times you've got to trick yourself into finding the
love. Of course after you find the love for the work at hand and dive into it
you're not tricking yourself anymore. You really have gotten into the flow or
the zone. It's just a getting started thing. And that's where the tricks of
conjuring love-worthiness come into play.

Trick #1: Nicknames. Or a good label. Sometimes all you have to do is give a
good nickname to a project. Project? Blech! Sounds too big. Remember, Every
Little Thing gets done! Project is too big a way of thinking of it. That's
disheartening. Instead, think of it a little thing.  It's a little thing to
make a new folder on your computer with a well-chosen nickname. That's what
you're going to cal your repository. Just made a repo called semrushautomation.

Yup. I'm going to automate certain functions inside a website so that I don't
have to use the API and use up api-tokens. So the folder is made and now I make
my first Jupyter Notebook in that folder and give it the same name as the
folder. Reinforce the nickname. And now I'm copy/pasting the best
starting-point code over to this notebook from a similar project.

Okay, since it's browser automation on a site that requires login, just pop the
site up in Chrome ***at all*** and take note that you're actually already
logged in. The way I use browser automation in Microsoft Playwright and
Puppeteer is with regular Google Chrome (not chromium) and so I can give it my
whole browser user profile including the "keep me logged in" status of various
websites. I'm using that to avoid putting in unnecessary login code. Okay,
confirmed!

Alright now instead of just the homepage put in the URL of the tool within the
site that you're going to be using. Okay now some particular thing is making it
seem more difficult than it is. It's a hurdle that must be overcome. And then
another little hurdle like it is likely to follow. And then another. And so the
strategy is to just go get the first one done then come back here and think out
loud again... okay, done. Success assured.

Beware distractions. They can be terribly powerful and you feel like you should
indulge in one as a reward for getting one of the above steps done. If you do,
set a time-limit. Indulge in say Google Discover Homepage which gives you
science news stories galore. Read one. Return! Okay, I have what amounts to a
single test-run with sample data of what will be going into a loop for many
runs with real data. So I have an outer loop context to think about and getting
the real data ready to be used. Next step!

Proving the viability of a project is part of the fun. Getting that "success
assured" moment is a thing. You don't know what you don't know until you try,
so try as soon as possible. Make discoveries and note things. Watch closely so
you can let your subconscious take things in you may not notice at first.
Getting access to the real data come sometimes be a hurdle in itself, or at
least getting the real data where you need it and how you need it as the input
for some process.

Now it's time to slice the Jupyter Notebook. What was once a test is now going
to be a real job, so the Python imports and setting of initial configuration
variables need not be re-run all the time. And I need a code block between the
imports and what is to soon become one iteration in a loop. But before I get to
loopifying the code, I need to load the data as part of the outer-context to
the loop. The input data (list of keywords) will control the loop. While not
quite a 1-liner, I find this line pretty magical:

    with open("keywords.csv") as fh:
        keywords = [x.rstrip() for x in fh.readlines()]

Now we've got a list of keywords as a Python list in memory in our Jupyter
Notebook. Our old friend modulo is chomping at the bit to get started.
Outer-loop time! I need to chop my long keyword list into batches of 100. We
will build it up. First step:

    for i, keyword in enumerate(keywords):
        print(i, keyword)

If you're not familiar with modulo, think to yourself what technique must be
used in spreadsheets and other grids to alternate the white to light-grey row
backgrounds. Rows often alternate between 2 shades for better readability and
clearly if the rows were numbered, you could use such rules as if the number is
even shade it and if the number is odd don't shade it. See? That's how modulo
is used. That would be row_number % 2. The percentage sign in this context is
the modulo math operator. If you wanted to identify every 3rd line it would be
row_number % 3 and so on. Here we're using 100. Also I'm trying to make my
convention for modulo results of a counter the underscore-version of that
counter name.

    for i, keyword in enumerate(keywords):
        _i = i % 100
        if not _i:
            print(i, keyword)

Alright now there's multiple ways of going about the steps to follow. One might
say there's radically different philosophies and preferences. Each approach has
its own strengths and weaknesses. I'm shifting towards a new philosophy that
keeps each step as discrete and readable as possible. And so I'm going to want
to step through ready-made chunked (in groups of 100 keywords) data. And so we
chunk it:

    tables = []
    for i, keyword in enumerate(keywords):
        _i = i % 100
        if not _i:
            if i:
                tables.append(table)
            table = []
            print(i, keyword)
        table.append(keyword)

At the end you have nested tables and you can use a for table in tables loop to
unpack and use each chunk. So the above step is really in preparation for an
outer loop.

Fast forward to end of work day. Pshwew! Marathon session. Not only did I
finish that Chrome automation project that this journal entry started out with,
but I also ran a 2000+ keyword SERP-scraping job with various transforms to
make it useful in the deliverable, and I'm on to the 3rd item for today which
is sort of like reverse-tagging. I'm taking keyword cluster terms which are
essentially category or topic keywords and matching them back to the content
they were inferred from.

And I'm finishing up that last project too. Woo! Today went from automating
data-pulls against the SEMRush web UI to performing actual Google search result
scraping to a fuzzy matching project. Most days don't have this quantity of
deliverables. It's all really one deliverable ultimately but with a lot of
facets.

Wow, what a day. In fact, it's tomorrow by the time I'm writing this paragraph
but I don't want to start a new blog post. Just watch The Shape of Water. Wow.
Been awhile since I saw a movie as moving as that. Gotta get to sleep. But mind
racing. Looking forward to editing that email I auto-send to myself. Don't let
myself overlook it!


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/permission-denied-publickey-fatal-could-not-read-from-remote-repository">Permission denied publickey fatal Could not read from remote repository</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/planning-the-lifehack-email">Planning the Lifehack Email</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/browser-automation/'>Browser Automation</a></h4></li>
<li><h4><a href='/jupyter-notebook/'>Jupyter Notebook</a></h4></li></ul>