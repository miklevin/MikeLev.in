---
date: 2023-04-04
title: Systematically Walk Through MOZ Products
permalink: /blog/systematically-walk-through-moz-products/
headline: Unlock the Competitive Advantage of MOZ with My Systematic Review of Products
description: as an employee of moz, i am on a mission to make sure moz is the source of competitive advantage in the seo software category. to do this, i am systematically reviewing moz products, such as moz free, moz pro, moz local, moz links api, moz toolbar, and stat, and capturing the new user experience of moz pro. additionally, i am doing some browser automation stuff.
keywords: MOZ, SEO, Software, Free, Pro, Local, Links API, Toolbar, Stat, User Experience, Browser
categories: seo, moz
layout: post
---

Goal: Capture the MOZ Pro new user experience with a fresh pair of eyes. In the
eternal question of build vs. buy, I tend to land on the build side, because
for some time it's the source of competitive advantage... until it's not. Then
it works against you, cause everyone's standardized on some proprietary or open
software that's on everyone's resumes.

{% include youtubePlayer.html id="ecm9sQAG4zg" %}

MOZ should be that for the SEO software category. I work for MOZ and so now
it's part of my mission is to make sure that's true.

- Moz Free
- Moz Pro
- Moz Local
- Moz Links API
- Moz Toolbar
- Stat

<div class="mermaid">
erDiagram
   SERPS
   Keywords
   Links
</div>

```python
import base64
from IPython.display import Image, display
import matplotlib.pyplot as plt

def mm(graph):
    graphbytes = graph.encode("ascii")
    base64_bytes = base64.b64encode(graphbytes)
    base64_string = base64_bytes.decode("ascii")
    display(Image(url="https://mermaid.ink/img/" + base64_string))

mm("""
graph LR;
    A--> B;
    B--> A & E;
    C--> A & E;
    D--> A & E;
    E--> B & C & D;
""")
```

Let's do some browser stuff.


## Categories

<ul>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/moz/'>MOZ</a></h4></li></ul>