---
date: 2023-04-18
title: Switched from text-davinci-002 to text-davinci-003
permalink: /blog/switched-from-text-davinci-002-to-text-davinci-003/
headline: "Exploring AI Capabilities: Switching from text-davinci-002 to text-davinci-003"
description: I switched to text-davinci-003 to get better summaries, descriptions, headlines, and keywords from OpenAI, but it cost me more. I committed the data to a git repo so I could access it even if the databases got deleted. Going forward, I'll only process single posts as I explore AI capabilities. Join me as I explore the AI capabilities and the cost of processing data.
keywords: AI, OpenAI, text-davinci-002, text-davinci-003, summaries, descriptions, headlines, keywords, processing, cost, git, repo, databases, single posts, explore, capabilities
categories: ai, openai, git, keywords
layout: post
---

After playing around with prompts and OpenAI models, I decided to re-process my
entire site. To get OpenAI to write better summaries, descriptions, headlines
and keywords, I switched from text-davinci-002 to text-davinci-003. It did a
better job specifically with the keywords and especially the formatting of the
keywords. The only problem was that it couldn't keep the meta descriptions
under 160 characters and this request ended up with a lot of sentences chopped
in the middle, despite telling it specifically not to. Maybe more importantly,
is it doubled my cost for the month, driving my total spend for processing
about 500 pages from $30 for the first run to $40 for the recent run. Including
my experimenting, I'm up to about $80 and I'm going to stop here.

![OpenAI Daily Usage Cost](/assets/images/OpenAI-daily-usage-cost.png)

Technically, I'm not stopping. I'm just not reprocessing the entire site again.
I've committed the data to the git repo, so even if the databases get deleted I
can get them back. And any time I write a new post, the process will run for
the single post. It's exciting to see the AI portions get written.


## Categories

<ul>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/openai/'>OpenAI</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/keywords/'>Keywords</a></h4></li></ul>