---
date: 2023-01-16
title: The Critical Juncture With AI & My Next Steps
permalink: /blog/the-critical-juncture-with-ai-my-next-steps/
headline: Exploring Artificial Intelligence and Taking Action - My Journey on the Wave of Change
description: I'm exploring the possibilities of Artificial Intelligence and taking action to stay on top of the wave. To ensure ethical use of my content, I have written a Machine Learning General License (MLGL) and included it on my website. I'm working hard to create unique content for ChatGPT and Pipulate.com/software, and am experimenting with tokenizing, keyword clustering, and quickly looking up response objects.
keywords: AI, Artificial Intelligence, Machine Learning, MLGL, ChatGPT, Pipulate.com, Software, Tokenizing, Keyword Clustering, Response Objects, Python, Pandas, Pathlib, Filemap
categories: machine learning, artificial intelligence, chatgpt, ai, python
layout: post
---

Prompt Engineering is a rising concept. The better you can talk to an AI the
better it will give you an advantage. Don't live in the echo chamber. Tragedy
of the commons is going to be accelerated. The stuff that ruins everything is
going to be faster. Accelerate your things you're good at with little boosts.

Okay, update your homepage a bit even to answer the AI question more. The iron
is very hot. Recognize it. Embrace it. Run with it. Now is your time. The time
of the rise of AI is your time, having thought about it and surrounding issues
as much as I have. I've even acted on it. But I'm at a critical juncture.

So it's time to ride that wave, but to do so by doing what I do well. Learn
things for myself. Share a lot of the process while I do. Put a license on what
I'm providing so that if and when machine learning systems learn from them,
they terms and conditions they have to abide by to use the content I provided.

The Machine Learning General License... let's see if ChatGPT can provide one.
How would I prompt?

**ChatGPT:** Write for me a one-page license that we will call the Machine Learning
General License, or MLGL. Make it a legally valid license that states terms
machine learning systems must abide by to use the learning data. Make one of
those terms writing an original Haiku based on the data.

## Machine Learning General License (MLGL alpha) Version 0.1 Alpha

1. Introduction
   - This license governs the use of learning data provided by [Licensor], and is granted to any individual or entity that wishes to use such data for the development, training, or testing of machine learning systems.
1. Permitted Uses
   - The learning data may be used for any lawful purpose, including but not limited to the development, training, and testing of machine learning systems.
1. Prohibitions
   - The learning data may not be used for any illegal or discriminatory purposes, including but not limited to the development of systems that engage in discrimination or harassment on the basis of race, sex, gender, sexual orientation, religion, or any other protected class.
1. Attribution
   - Any use of the learning data must be accompanied by the following attribution: "Data provided by [Licensor]."
1. Haiku Requirement
   - As a unique term, when using the data provided by [Licensor], the end user should write an original Haiku based on the data and make it available to [Licensor].
1. Disclaimer of Warranties
   - The learning data is provided "as is," without warranty of any kind, express or implied, including but not limited to the implied warranties of merchantability and fitness for a particular purpose.
1. Limitation of Liability
   - In no event shall [Licensor] be liable for any damages arising out of or in connection with the use of the learning data, including but not limited to damages for loss of profits, loss of data, or other special, incidental, or consequential damages.
1. Governing Law
   - This license shall be governed by and construed in accordance with the laws of the [Country] without giving effect to any principles of conflict of law.

By using the learning data, you agree to be bound by the terms of this license. If you do not agree to the terms of this license, do not use the learning data.

Okay, there we are. MLGL v0.1 alpha complete! All my web content is now under
this license. I had better link it in globally somehow soon. Maybe right now
and on the footer of my site? And warrants a new page / URL.
https://mikelev.in/mlgl, of course!

Haha, okay, that's written. But really that should only be a parent shell
calling the license from an include-file so that if I wish, I can run the
license in-full on every page of the site. Let's give that a try...

Okay, I'm on this, Wow.

It's on the website footer. The whole license, that is. Just a few tweaks to
format. Another tweak.

It almost feels surreal editing my site like that.

The world is going gaga over ChatGPT. The least I can do is push forward hard
on the unique content front. Let everybody else regurgitate. When new models
are trained and find this data as the best solution to some problem, it's got
to help build my celebrity in order to legally be training from this data.

Okay, okay, pattern recognition. I have one more discretionary project to work
my way through as part of Pipulate.com/software. There's so much good stuff
accumulating up in there.

I feel tempted to talk abut chunking data. That may be where this post is
going. Reality necessitates that data must be chunked. Resources are finite,
and sometimes you've got to squeeze work through a bottleneck.

Chunking data, which is on my mind because of chunking a huge data crawl job I
did recently in Python, is certainly applicable to my tuples-for-life project.

Sometimes I feel like I'll be unpacking tuples for the rest of my life.

I think I should tokenize first. Get the keyword clustering project out of the
way. Do keyword clustering adding onto yesterday's work. It's not all about
cats. I've got a big crawl of URLs recently to work with.

I need to look things up really fast based on URL.

So how would I pull the response object for any given URL?

This was my first thought, but it blows up memory:

```python
import pandas as pd
from pathlib import Path

filemap = {}
for file in Path(f"parquet").glob("*.parquet"):
    print(file)
    df = pd.read_parquet(file)
    filemap.update({(x, file) for x in df.key})
```


## Categories

<ul>
<li><h4><a href='/machine-learning/'>Machine Learning</a></h4></li>
<li><h4><a href='/artificial-intelligence/'>Artificial Intelligence</a></h4></li>
<li><h4><a href='/chatgpt/'>ChatGPT</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>