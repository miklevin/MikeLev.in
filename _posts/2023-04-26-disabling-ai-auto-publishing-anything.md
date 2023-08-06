---
date: 2023-04-26
title: Disabling AI Auto-Publishing Anything
headline: "Switching to Windows 11: Transferring the 'Soul' and Navigating a New Site with Python"
description: I recently discovered a problem with Jekyll when trying to produce a list of the 10 most recent posts. To solve this, I used Python to control the list iteration and created a 5 x 20 grid of the top-100 categories on my website. After testing it in Jupyter, I successfully produced a table with the top 100 categories. I also recently switched from Windows 10 to Windows 11 and was able to transfer the 'soul' of the machine, including my system setup.
keywords: Jekyll, Python, Grid, Windows, AI, Navigation, System, Installs, Settings, Site, Categories, Tags, Search
categories: ai, navigation, python, setting, search, jekyll, microsoft
permalink: /blog/disabling-ai-auto-publishing-anything/
layout: post
group: blog
---


Interesting, the publishing sequence isn't kept intact when you ask Jekyll to
produce say a list of the 10 most recent posts. One of the few places I use
that right now is on the homepage. An important place. I'll have to give that
thought. I'm coming to the conclusion that when it comes time to iterate lists
to draw navigational elements, it's better to do it Python-side and assert
explicit control.

Speaking of which, I'm going to create a 5 x 20 grid of the top-100 categories
on my site. Now this is a great example of AI-assisted stupid data tricks (in
the most endearing sense). Hey Copilot, let's produce some markdown of a table.
I have a website with the top 100 categories as a Python dictionary. I want to
produce a table of the top 100 categories, 5 columns by 20 rows. Here's the
sample code:

```python
import math
import json
import pandas as pd

with open('categories.json') as f:
    categories = json.load(f)

df = pd.DataFrame(categories.items(), columns=['category', 'count'])
df = df.sort_values(by=['count'], ascending=False)
df = df.reset_index(drop=True)

rows = 20
cols = 5
total = rows * cols
pages = math.ceil(len(df) / total)

for page in range(pages):
    print(f'Page {page + 1} of {pages}')
    print('-----------------')
    print(df.iloc[page * total:(page + 1) * total].to_markdown())
    print()
```

There, I didn't even need to leave my journal for that, although I did have to
do something akin to letting it prompt me one line at a time. It wasn't one of
those massive all-at-once suggestions. And it's suggestion is good. I want
something I can pick up and test in Jupyter without an outside json-file
dependency. I could just produce some random text for each category with an
efficient loop. I want to focus on drawing the table. Reproduce this markdown
table, but in Python.

| Column 1 | Column 2 | Column 3 | Column 4 | Column 5 |
| -------- | -------- | -------- | -------- | -------- |
| Row 1, Column 1 | Row 1, Column 2 | Row 1, Column 3 | Row 1, Column 4 | Row 1, Column 5 |
| Row 2, Column 1 | Row 2, Column 2 | Row 2, Column 3 | Row 2, Column 4 | Row 2, Column 5 |
| Row 3, Column 1 | Row 3, Column 2 | Row 3, Column 3 | Row 3, Column 4 | Row 3, Column 5 |
| Row 4, Column 1 | Row 4, Column 2 | Row 4, Column 3 | Row 4, Column 4 | Row 4, Column 5 |
| Row 5, Column 1 | Row 5, Column 2 | Row 5, Column 3 | Row 5, Column 4 | Row 5, Column 5 |
| Row 6, Column 1 | Row 6, Column 2 | Row 6, Column 3 | Row 6, Column 4 | Row 6, Column 5 |
| Row 7, Column 1 | Row 7, Column 2 | Row 7, Column 3 | Row 7, Column 4 | Row 7, Column 5 |
| Row 8, Column 1 | Row 8, Column 2 | Row 8, Column 3 | Row 8, Column 4 | Row 8, Column 5 |
| Row 9, Column 1 | Row 9, Column 2 | Row 9, Column 3 | Row 9, Column 4 | Row 9, Column 5 |
| Row 10, Column 1 | Row 10, Column 2 | Row 10, Column 3 | Row 10, Column 4 | Row 10, Column 5 |
| Row 11, Column 1 | Row 11, Column 2 | Row 11, Column 3 | Row 11, Column 4 | Row 11, Column 5 |
| Row 12, Column 1 | Row 12, Column 2 | Row 12, Column 3 | Row 12, Column 4 | Row 12, Column 5 |
| Row 13, Column 1 | Row 13, Column 2 | Row 13, Column 3 | Row 13, Column 4 | Row 13, Column 5 |
| Row 14, Column 1 | Row 14, Column 2 | Row 14, Column 3 | Row 14, Column 4 | Row 14, Column 5 |
| Row 15, Column 1 | Row 15, Column 2 | Row 15, Column 3 | Row 15, Column 4 | Row 15, Column 5 |
| Row 16, Column 1 | Row 16, Column 2 | Row 16, Column 3 | Row 16, Column 4 | Row 16, Column 5 |
| Row 17, Column 1 | Row 17, Column 2 | Row 17, Column 3 | Row 17, Column 4 | Row 17, Column 5 |
| Row 18, Column 1 | Row 18, Column 2 | Row 18, Column 3 | Row 18, Column 4 | Row 18, Column 5 |
| Row 19, Column 1 | Row 19, Column 2 | Row 19, Column 3 | Row 19, Column 4 | Row 19, Column 5 |
| Row 20, Column 1 | Row 20, Column 2 | Row 20, Column 3 | Row 20, Column 4 | Row 20, Column 5 |

Here's the code to produce that table:

```python
rows = 20
cols = 5

for row in range(rows):
    for col in range(cols):
        print(f'Row {row + 1}, Column {col + 1}', end=' | ')
    print()
```

Ah, that's much nicer. The example markdown came from chat.openai.com and the
Python code that reproduced it came out of Copilot. There's no headers, but
I'll worry about that later. Let me add this to my homepage...

Ohhh! I have to write it as includes/category_list.html. I have the homepage
already set up to bring in that include file. But it's not the include file
itself I have to edit, but rather making the include file. And so that goes
into the chopchop.py script. It may be another edit-in-able step.

Okay, this has been one of my least painful, and most preserving of
"superpowers" switching of hardware I've done in awhile. The "soul" of the
machine I was in love with traveled with me on a Linux VM. Not a particular VM
instance requiring big file transfers, but rather running that drinkme script
file that spins up a Ubuntu 20.04 WSL2, with all the apt installs and pip
installs and .bash_profile, .vimrc (now init.vim) and that sort of stuff
transferring over seamlessly.

It is from Windows to Windows, albeit Windows 10 to 11. But still, the process
went well, and in the process I got a new site navigation system. 

A nuance I'm still working out is that the AI-generated stuff doesn't get
released on the site-gen it was produced, not deliberately, but I'm considering
keeping that behavior in order to always have a chance to edit the AI's work
before first publish. 


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/have-journal-will-travel-across-machines/">Have Journal Will Travel (across machines)</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/neovim-publishing-macro-using-terminal-expand/">NeoVim Publishing Macro Using :terminal & expand()</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/navigation/'>Navigation</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/setting/'>Settings</a></h4></li>
<li><h4><a href='/search/'>Search</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>