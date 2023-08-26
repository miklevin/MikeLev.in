---
date: 2023-04-30
title: Write Python Function for Blog Previous Next Arrows
headline: I wrote a Python Function to Create Blog Previous/Next Arrows!
description: "I wrote a Python function to create blog navigation arrows. It takes the index position and length of a sequence, as well as a list of tuples containing hrefs and titles, and returns HTML for the prev/next arrows. This is now live on my category pages and I'm ready to add it to my Jekyll `_posts` pages too."
keywords: Python, Function, Blog, Previous, Next, Arrows, Jekyll, Config, YML, File, Digital, World, Capitalization, Categories, Pages, Filtering, Homeschooling, Pandemic, Internet, ChatGPT, Crypto-Bros, Auto-Complete, Tech, Journal, Environment, Organizing, Pre-Processing, Transformation, Static, Site, Generators, Hugo, Script, Reading, Sequence, Linear, Flow, Responsibilty, Kid,
categories: flow, python, jekyll, ai
permalink: /blog/write-python-function-for-blog-previous-next-arrows/
layout: post
group: blog
---


The best laid plans! I stayed up pretty late last night after a nap, but did
very little of the physical environment organizing that I had planned and
instead organized the digital world still more, fixing capitalization issues on
the categories and making prev/next arrows on the category pages. I also
filtered a whole lot more categories out, making it look like something I'm
going to want to break out externally, maybe in Jekyll's `_config.yml` file.

But here I am awake early anyway because I did get enough sleep including the
nap from yesterday. Spent some time with the kid during unexpected very early
morning hours. They're a night owl, especially when here. I remember myself
loving to do that as a kid, and it was only a sense of responsibility that
stopped me from doing it more. It's a very different world now, between
homeschooling and the pandemic and the internet. 

ChatGPT and things like it look like "the big cheat". It's no wonder it's
attracting the attention of the similarly big-cheat aligned crypto-bros. I'm
almost sorry I'm drawn to this magical auto-complete tech given who it seems to
align me with, but it's okay. I'm going to use the tools in ways they have not
thought to, including to help journal.

One tiny chisel-strike project before I get started with the day. The last
thing bothering me is my inability to swap the position of the prev/next arrows
with the category links on the article pages. It's because the category links
are put in with Python as part of what Jekyll considers the `content` block,
while the arrows are put in with Liquid templates as part of the `layout`. If I
switch the arrows from being under Jekyll/Liquid/Ruby to being part of my
Python pre-processing transformation, I have more control and the system
becomes more transferable to other static site generators such as Hugo.

I tend to avoid functions when I can because it breaks the linear flow of
reading a script. When you can't avoid it and the function is the smart way to
go because of code reuse, then you have to make it smart and fun. Smart in that
you can still maintain the easier linear sequence readability of the script (if
you're like me) and fun in that if you're going to interrupt the flow of the
program, it might as well be strongly nicknamed and understood as a "fun" place
to go in your program to accomplish a certain thing not so easily crammed into
the liner flow.

In this case I'm making an arrow builder. The inline code looks like this:

```python
    for i, cat in enumerate(top_cats):
        # Set arrow-key navigation:
        if i:
            aprev = top_cats[i - 1]
            prev_slug = slugify(aprev)
            prev_title = cdict[aprev]["title"]
            prev_arrow = f'<span class="arrow">&larr;&nbsp;</span><a href="/{prev_slug}/">{prev_title}</a>'
        else:
            aprev = None
            prev_slug = None
            prev_title = None
            prev_arrow = '<span class="arrow">&nbsp;</span>'
        if i < len(top_cats) - 1:
            anext = top_cats[i + 1]
            next_slug = slugify(anext)
            next_title = cdict[anext]["title"]
            next_arrow = f'<a href="/{next_slug}/">{next_title}</a><span class="arrow">&nbsp;&rarr;</span>'
        else:
            anext = None
            next_slug = None
            next_title = None
            next_arrow = f'<span class="arrow">&nbsp;</span>'
        slug = slugify(cat)
        filename = f"{PATH}{REPO}cat_{slug}.md"
        include_file = f"cat_{slug}.md"
        permalink = f"/{slug}/"
        with open(filename, "w", encoding="utf-8") as fh:
            cat_str = f"""---
title: {cdict[cat]["title"]}
permalink: {permalink}
layout: default
[3 dashes]

# {cdict[cat]["title"]}

"""
            fh.write(cat_str)
            fh.write(f"%7B%7B%25%20include%20%7Binclude_file%7D%20%25%7D%7D")
            arrow_link = f"""
<div class="post-nav">
  <div class="post-nav-prev"> {prev_arrow} </div>
  <div class="post-nav-next"> {next_arrow} </div>
</div>
"""
            fh.write(arrow_link)
```

That's about as ugly as it gets when it comes to Python code. And I'm getting
ready to handle a ***second*** set of arrows by bringing the prev/next article
links from Jekyll. There's no way I'm reproducing this mess. Let's make a nice
clean slate. We do this by going into the "playground" section of the code,
which is precisely where I have made for the experimental new stuff like this
so I never struggle to look for where I'm working on new things. In vim/NeoVim
it's just a `Shift+G` away.

```python
#  _____ _            ____  _                                             _
# |_   _| |__   ___  |  _ \| | __ _ _   _  __ _ _ __ ___  _   _ _ __   __| |
#   | | | '_ \ / _ \ | |_) | |/ _` | | | |/ _` | '__/ _ \| | | | '_ \ / _` |
#   | | | | | |  __/ |  __/| | (_| | |_| | (_| | | | (_) | |_| | | | | (_| |
#   |_| |_| |_|\___| |_|   |_|\__,_|\__, |\__, |_|  \___/ \__,_|_| |_|\__,_|
# Put new stuff here                |___/ |___/

def arrow_maker():
    ...
```

This arrow making function isn't going to need to know everything about the
sequence for which it's making arrows, but it will need to know 2 things about
the sequence:

- The point in the index that it's up to (the counter)
- The overall length of the sequence.

```python
def arrow_maker(i, length):
    print(i, length)
    ...
```

Now knowledge about the internals of the list itself does come into play,
specifically in building the prev/next links. Now I can shove access to the
entire sequence in there every time, but the "shape" of the lists for which
this is creating prev/next arrows may not be consistent. If I want these arrows
to work generically with any sequence, the less it knows about the internals of
the list it's making arrows for, the better.

In that case, the API becomes a bit noisier because it needs all the prev/next
info, namely the slug and the title for both prev and next. So that's 4 more
pieces of information to be passed in on arguments. I'd like to make an
argument against that, but maybe we handle it beautifully. This is where
namedtuples often come in for the beautification of tuples, but at the cost of
more overhead. I'm not sure I want to go there. I'm going to try first with a
couple of naked position-dependent tuples.

```python
def arrow_maker(i, length, prev_stub_title, next_stub_title):
    print(i, length)
    ...
```

Well, that's not short but it is clear. Why not break it out into 4 arguments?
Because pairing data that belongs together in tuple-packs makes it easier to
understand. It "binds" the data together. And so parsing this inside the
function looks like this:

```python
def arrow_maker(i, length, prev_stub_title, next_stub_title):
    prev_slug, prev_title = prev_stub_title
    next_slug, next_title = next_stub_title

    # Detect if we're at the beginning or end of the sequence:
    if i:
        ...
    else:
        ...
    if i < length - 1:
        ...
    else:
        ...

    # Build the arrows:
    arrow_link = ""
    return arrow_link
```

Yup, that's bringing us along the right lines to a nice clean function.

Hmmm... I'm forcing all that logic about figuring out the stubs and titles
outside the function to the point right before it's called, and that's some
ugly code. If I just insist on a standardized format for sequences to be fed
into the `build_arrow()` function, I can make it cleaner inside and outside the
function. Something like a list comprehension would be called for to put
whatever list you're building arrows for into maybe a list of tuples. Same
tuple idea, different overall shape.

```python
arrow_list = [x for x in zip(slugs, titles)]
```

There's a possibility I could even use generators for very long lists, but
that's for another day. For now, let's redesign the `build_arrow()` API around
this concept:

```python
def arrow_maker(i, length, stub_title_list):
    prev_slug, prev_title = stub_title_list[i - 1]
    next_slug, next_title = stub_title_list[i + 1]

    # Detect if we're at the beginning or end of the sequence:
    if i:
        ...
    else:
        ...
    if i < length - 1:
        ...
    else:
        ...

    # Build the arrows:
    arrow_link = ""
    return arrow_link
```

Wow, I like that more, but now there will always be a `stub_title_list`
building step before building arrows for a sequence, but that's the lesser of
various evils here. Here is the next step in its simplest form, with reminders
of the old arrows I'm replacing form which I still have to transpose spans and
styles:

```python
def arrow_maker(i, length, stub_title_list):
    prev_slug, prev_title = stub_title_list[i - 1]
    next_slug, next_title = stub_title_list[i + 1]

    # Detect if we're at the beginning or end of the sequence:
    if i:
        prev_arrow = f'<a href="{prev_slug}">{prev_title}</a>'
    else:
        prev_arrow = ""
    if i < length - 1:
        next_arrow = f'<a href="{next_slug}">{next_title}</a>'
    else:
        next_arrow = ""

    # Build the arrows:
    arrow_link = ""
    return arrow_link

    # Old arrows (spans and styles are important)
    # prev_arrow = f'<span class="arrow">&larr;&nbsp;</span><a href="/{prev_slug}/">{prev_title}</a>'
    # prev_arrow = '<span class="arrow">&nbsp;</span>'
    # next_arrow = f'<a href="/{next_slug}/">{next_title}</a><span class="arrow">&nbsp;&rarr;</span>'
    # next_arrow = f'<span class="arrow">&nbsp;</span>'
```

Things still have some beauty now. The trick is to layer in the actual HTML
elements and maintain beauty. That's where f-strings typically come in these
days with Python.

```python
def arrow_maker(i, length, stub_title_list):

    # Get the prev/next slugs and titles:
    prev_slug, prev_title = stub_title_list[i - 1]
    next_slug, next_title = stub_title_list[i + 1]
    larr = '<span class="arrow">&larr;&nbsp;</span>'
    rarr = '<span class="arrow">&nbsp;&rarr;</span>'

    # Detect if we're at the beginning or end of the sequence:
    if i:
        prev_arrow = f'{larr}<a href="{prev_slug}">{prev_title}</a>'
    else:
        prev_arrow = '<span class="arrow">&nbsp;</span>'
    if i < length - 1:
        next_arrow = f'<a href="{next_slug}">{next_title}</a>{rarr}'
    else:
        next_arrow = '<span class="arrow">&nbsp;</span>'

    # Build the arrows:
    arrow_link = ""
    return arrow_link
```

This looks fairly clean. Yup. And here's the final form that worked. Previous
Next arrows for blogs and other sequences of pages (such as category pages in
this case) is now working, and here's the function's final form:

```python
def arrow_maker(i, length, href_title_list):
    """Returns the prev/next arrows for a page. It must be given a list of
    tuples containing the hrefs and titles of the pages in the sequence. It
    must also be given the index of the current page in the sequence. It will
    return the HTML for the prev/next arrows. Path issues must be dealt with
    beforehand in the tuple sequence."""

    # Get the prev/next slugs and titles:
    larr = '<span class="arrow">&larr;&nbsp;</span>'
    rarr = '<span class="arrow">&nbsp;&rarr;</span>'

    # Detect if we're at the beginning or end of the sequence:
    if i:
        prev_slug, prev_title = href_title_list[i - 1]
        prev_arrow = f'{larr}<a href="{prev_slug}">{prev_title}</a>'
    else:
        prev_arrow = '<span class="arrow">&nbsp;</span>'
    if i < length - 1:
        next_slug, next_title = href_title_list[i + 1]
        next_arrow = f'<a href="{next_slug}">{next_title}</a>{rarr}'
    else:
        next_arrow = '<span class="arrow">&nbsp;</span>'

    # Build the arrows:
    prev_link = f'<div class="post-nav-prev">{prev_arrow}</div>'
    next_link = f'<div class="post-nav-next">{next_arrow}</div>'
    arrow_link = f'<div class="post-nav">{prev_link}{next_link}</div>'
    return arrow_link
```

This is now live on my category arrows and I should be able to add it to my
Jekyll `_posts` pages now too, tearing out the previously Liquid template
system version, which while impressive is not as controlled or portable as
this. 

Okay, it looks great. On the category pages, I have the occasional hanging
`<ol>` showing up, but I'll fix that later. Call this released!


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/write-python-function-for-blog-previous-next-arrows/">Write Python Function for Blog Previous Next Arrows</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/embrace-displace-embrace-a-new-place-wsl2-linux/">Embrace & Displace --> Embrace a New Place (WSL2 Linux)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/flow/'>Flow</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>