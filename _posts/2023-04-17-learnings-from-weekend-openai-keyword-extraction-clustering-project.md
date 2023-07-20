---
date: 2023-04-17
title: Learnings From Weekend OpenAI Keyword Extraction & Clustering Project
headline: "Gaining Experience with OpenAI: Learning to Leverage Virtual Assistants for Data Projects and Taxes"
description: I recently used the OpenAI API to gain hands-on experience with keyword extraction and clustering to create a story-like visualization in the console. I applied the 80/20 rule to solve the issue of errors with structured lists, and gained new respect for Vim/NeoVim and caution for VSCode. I'm now using NeoVim and Copilot to finish a data project, and have discovered that machines being intelligent now means that I have a virtual assistant.
keywords: OpenAI, API, Keyword Extraction, Clustering, Story Visualization, 80/20 Rule, Error, Structured Lists, Vim/NeoVim, VSCode, Data Project, Taxes, NeoVim, Copilot, Paid-for Intelligence, Virtual Assistant, Learn Faster, Learn Better
categories: python, microsoft, ai, vim
permalink: /blog/learnings-from-weekend-openai-keyword-extraction-clustering-project/
layout: post
group: blog
---


Key learning from the weekend is that I shouldn't trust data returned from
OpenAI if it's supposed to end up as well structured lists and stuff. While
OpenAI produced much better keywords than Yake and KMeans, it still mangled a
number of the lists with all sorts of creative errors, from double-commas to no
quotes to extra quotes to extra newlines. Catching all the errors isn't
practical, but failing to turn it into a list with an eval and just not
inserting the keywords on exception is practical.

This is a prime example of where the 80/20-rule has to be applied. Because
OpenAI garbaged up the keyword lists it produced because it refused to be
consistent across the board, I have to either do some cleanup or try/fail. My
solution was a combination of both.

Code like this isn't perfect, but it either works great or fails gracefully.
All these in-between errors just won't get through this process. Copilot
wouldn't suggest this, and everything it did suggest were terrible approaches.
I mean they could have worked if you went deep enough down the rabbit hole, but
it was not an 80/20-solution. This is.

```python
topics, api_hit = odb(TOPDB, find_topics, slug, topic_text)
# Prepare to split a quoted keyword list by removing leading and trailing quotes
topics = topics[1:-1]
# Now when we split on ", " it will be a list of keywords
topics = topics.split('", "')
# If this resulted in a list with more than one element, we can re-assemble it
if len(topics) > 1:
    # Re-assembling string-list of keywords, but without quotes
      topics = ", ".join(topics)
      top_matter.append(f"keywords: {topics}")
```

My big lessons from this weekend were more over tooling than I expected. I have
newfound respect for vim/NeoVim and renewed caution regarding VSCode. Merely
switching between this journal and coding shows me... shows me what? Shows me
that I think and work differently than most other people. Maybe others do, but
they don't project it as much as I do.

Copilot is okay. It will appear everywhere over time. Don't get bent about it
not being in Jupyter Notebooks. That won't stand. Even if it's not OpenAI in
Jupyter, but maybe this new Amazon AWS thing, CodeWhisperer.

I've got the data project to finish. It's almost start-to-finish that I have to
do, but I'm in a much better position to do it now. And I'm going to do it in a
.py file directly with NeoVim having Copilot to help, rather than on either of
the Notebook environments I've been playing with recently: VSCode and native
Linux JupyterLab. I fact, I tried VSCode Linux native and Windows with the WSL2
remote extension.

It's still quite early. I can slam out the data project today, along with taxes
later tonight, haha! I let things drag too long, but the stuff I'm distracted
with is worth it, especially when it's tooling. But I can't let that in itself
become for its own sake and a distraction. The point is to really get to do the
work well, using the tooling you have, and perchance incrementally improve over
time, but without major tooling overhauls.

Okay, force myself to do hard things. And project yourself primarily here
through your journal, but also as opportunity arises through YouTube and at
work. It seems like it should all be for work, but there's a large degree of
play and exploration that's necessary to get to the point where you can do work
differently and better than other. Get your ass off the center-line of the
average distribution curve. Not so far-off as to be fringe, but far off enough
to be doing things of profoundly recognizable value, like slamming meaningful
text around in a text file. That's so fundamental to so many things.

Another realization over the weekend is that the DrinkMe script I'm working on
should get to the email service running and perhaps a web interface to manage
systemd services. I should probably get some little rudimentary web interface
onto DrinkMe beyond just JuptyerLab. It should be for turning enabling,
disabling, and turning on and off systemd services. The functionality on this
service/email thing should be:

- Just having a daily email as a "heartbeat" or "pulse"
  (there's always something there to remind you)
- Making vim/NeoVim as much a part of DrinkMe experience as Jupyter
  (Daily journaling and thinking in vim)
- AI now lets you act on things faster

Okay, so now create a histogram of all the keywords OpenAI identified. And then
do a cool visualization that works in console as the final step.

Okay, but the keyword histogram data isn't as good as I had hoped it would be.
But now I've got a starting point. Now I have a hook. Don't chase the rabbit
down the rabbit hole going into the new work week. Get to the data project,
pronto.

Make it story-like.

What you did recently fits into the overall picture. I have much better
hands-on now with the OpenAI API and the different choices for keyword
extraction and clustering.

Be careful of paid-for intelligence.

Use it to learn and to up your game. Machines learn so we can learn faster and
better. It is a redistribution of accessibility to teaching intelligence. The
fact that machines are intelligent now means to me that I've got a good virtual
assistant coming that can also teach me to jump off cliffs and learn to fly
better, more often, and across a broader variety of situations.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/working-on-alternate-headline-leads-to-installing-jekyll-local/">Working on Alternate Headline Leads to Installing Jekyll Local</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/challenging-openai-to-write-a-better-subhead-than-this-headline/">Challenging OpenAI to Write a Better Subhead Than this Headline</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li></ul>