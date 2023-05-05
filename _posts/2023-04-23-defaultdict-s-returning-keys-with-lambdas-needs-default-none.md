---
date: 2023-04-23
title: DefaultDict's Returning Keys with Lambdas Needs Default None
headline: Creating a YAMLesque Journaling System with Python Defaultdict and Lambda Techniques
description: I have created a YAMLesque journaling system and used powerful techniques such as setting a default None value with Python defaultdict and lambdas for improved flow control and efficiency. Learn how I used this project to write two blog posts, and watch the new release process in action.
keywords: YAMLesque, Journaling, Code, Figlet, Banners, Functions, Defaultdict, Lambdas, Flow Control, Efficiency, Realization, Python, Default None, Draft, Posts, Title
categories: python, draft, journaling
permalink: /blog/defaultdict-s-returning-keys-with-lambdas-needs-default-none/
layout: post
---


The output is now the input. Almost everything is cleaned up now based on my
slicing and yaml-parsing insights. This YAMLesque journaling system is
definitely for blogging with traditional field-names like titles and
descriptions, but it can be adapted to many things. I should be careful to not
hard-wire field-names nor their purposes. I could stand to be more flexible
with what serves as a primary key. 

But again, therein lie rabbit holes. I'm not going to go down them. Instead,
I'll forge on and get to a great actual place using the system starting tomorrow
morning when I wake up. That means tonight I get the parts replaced that I
recently gutted, namely the post_list.html include file that blog.md refers to.
It's the main reverse chronological list of posts.

Okay, everything is done to get me back to where I was, but with much cleaner
code. Some of the highlights are:

- Heavy use of Figlet banners for easy visual scanning
- Turned most things into functions for easier flow control
- Used a defaultdict to make the code more elegant
- Used a lambda in conjunction with a defaultdict to return a default value
- Ripped out all the HTML neutralizing and replace with very simple function
- Stronger mental model around the whole chop chop generator thing
- Slicing a journal always returns a 3-tuple: (yaml, body, combined)
- The combined yaml and body can be use on yaml-read fails for easy rebuilds

I let myself sleep on this for a few consecutive nights, doing a little each
day. My realizations are as follows:

- Lots of validation to the 1-text-file for life model (easy editing)
- Lots of validation to using YAML for the header matter (easy parsing)
- Lots of validation to using 80-hyphens as the parser token (very visual)
- Lots of validation to using a generator to chop the file (highly efficient)

The Copilot AI is clearly very impressed with my use of defaultdicts with
lambdas. I had to do something very strange to get the behavior I wanted. For
those who don't know, defaultdicts are for those developers who are tired of
initializing counters and such in a dictionary of counters. You can just say
what the default value is, so if it's a counter, you set the default to zero.
If it's a list, you set the default to an empty list, and so on.

But what if it's a dictionary of the expected Proper Case capitalization usage
of a word. It could be iphone, iPhone, IPhone, IPHONE or whatever. The computer
doesn't know from single-use. We need usage frequencies, like another keyword
histogram to make a usage frequency histogram, from which we make a global
pcase dictionary. So, I set the default to a lambda that returns a defaultdict
with a default whatever "key" I plugged into it, so if there wasn't a
statistically chosen most common use, it will at least get out of it what you
put into it. This is the proper way to do it, which it took me awhile to get
to:

```python
from collections import defaultdict

pwords = defaultdict(lambda x=None: x)
```

I tried all the variations, namely this without a "None" value for x. It
doesn't work unless a default value is set for the lambda.

Another key learning of the last few days was that once you have a good strong
idea of how you want to do something, and in this case it was a generator
always returning a 3-tuple with a pre-assembled rebuild fallback behavior,
everything falls into place. I was able to rip out a lot of code and replace it
with a few lines of code.

At first I resisted chasing that particular rewrite rabbit down the rabbit
hole, but sleeping on it made me realize how stupid that was. Don't live with
code that you desperately want to require, no matter how new it is and no
matter how perfectly (by some miracle) it's doing exactly what you want it to
do. It's much better for it to be shorter, more readable code that's also doing
exactly what you want it to be doing, but for reasons you understand and are
immediately apparent to anyone looking at the code.

When parsing a yamlesque textfile such a a journal with a few fields per post
like date and title, you can slice the entire file on the page-slicing token
and return each post and yaml front-matter as a part of a memory efficient
Python generator. 

The page slicing token and the yaml front matter slicing token should be
different. This simplifies visualizing how the pages slice and helps keep the
meaning of triple minus "---" distinct to parsing front matter from body copy. 

Every page returned by the page slicing generator is in turn sliced on "---".
If more than one part is returned from that, you know you have some
not-yet-validated yaml front matter. If the sequence length returned is just 1,
there's no yaml front matter and you can return the pre-sliced input as the
return value. 

The page slicer returns a 3-position tuple. The first position is the yaml data
if any was able to be generated. If not, it will be an empty dict. The 2nd
position is the body copy that came after the front matter. The 3rd field is
the 2 combined so no one has to struggle with what to do what the yaml is None,
which is what an empty dictionary will evaluate to when checked. 

This creates a very clear mental model. Slice a journal and you'll always be
able to reconstruct the original journal at very least by appending all the
position-3 return values. If you wanted to do something else like expand the
number of fields, you can always append the new yaml to the post yourself. 

And so you see, something ALWAYS gets returned for every item in your YAMLesque
source, good yaml or not. Only the page-slicing token needs to be good to
ensure a blob-like unit returned.

Okay, now do a test release and see if it works. This will be the first time
when I have 2 posts in draft, and I turn only one of them to released by giving
it a title. What should the title of this post be? Hmmm.

Well I talked about the YAMLesque project overall, but the most interesting
thing in this post must be how you have to set a default None value when you're
using a Python defaultdict to return a key with a lambda. That's a mouthful,
but it's a very powerful technique that I'm sure I'll be using a lot in the
future, and which Copilot also seems to be very impressed with.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/openai-category-descriptions-project/">OpenAI Category Descriptions Project</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/designing-yamlesque-post-generator-api/">Designing YAMLesque Post Generator API</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/draft/'>Drafts</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li></ul>