---
date: 2023-04-22
title: Admiring the Usefulness of YAML-ness in my Journaling System
headline: "Reveling in the Glory of My Code Working as It Should: Exploring the Benefits of YAML-ness in My Journaling System"
description: I'm reveling in the glory of my code working as it should. I'm using YAML-ness to create a journaling system with a dictionary of lower-case usage as keys and all the happenstance uses as lists in each value. I wrote a program to parse a journal file and extracted the front matter of each post, then loaded it into a YAML dictionary. I'm now ready to give this a title and share my journey of slicing up my life into chunks.
keywords: YAML, Journaling, System, Dictionary, Lower-Case, Usage, Keys, Lists, Value, Parsing, File, Front Matter, Posts, Validation, Code, Common, Proper Case, Slice, Function, Comma Separated Values, Megabyte, Titles, Descriptions, Category Pages, Post Slugs, Format, Write_post_to_file, Front_matter_inserter, Life, Chunks, Whole
categories: value, keys, yaml
permalink: /blog/admiring-the-usefulness-of-yaml-ness-in-my-journaling-system/
layout: post
---


It's very satisfying pushing out a new journal entry and seeing it get
auto-described, keyworded, and now categorized too. It's time to make the
category pages have Proper Case. And I'm not just going to use a Proper Case
function that can get it wrong, nor have some lookup table of preferred
mappings to keep vim and git lower-case while Linux and Python get upper-case.
No, instead I'll use statistics again. My first step looks like this:

```python
DBFILE = "/home/ubuntu/repos/hide/MikeLev.in/_data/keywords.db"

from sqlitedict import SqliteDict as sqldict
from collections import defaultdict

words = defaultdict(list)

with sqldict(DBFILE) as db:
    for slug, keywords in db.iteritems():
        keywords = keywords.split(", ")
        for keyword in keywords:
            lower_word = keyword.strip().lower()
            words[lower_word].append(keyword)

words
```

You will recall that I already have the keyword database from prior posts. Now,
I just need to make a dictionary of the lower-case usage as keys and all the
happenstance uses as lists in each value. I can then use the most common
happenstance use as the proper case for each keyword.

```python
from collections import Counter

proper_words = {}

for lower_word, happenstance_words in words.iteritems():
    proper_words[lower_word] = Counter(happenstance_words).most_common(1)[0][0]
```

And my second edit:

```python
DBFILE = "/home/ubuntu/repos/hide/MikeLev.in/_data/keywords.db"

from sqlitedict import SqliteDict as sqldict
from collections import defaultdict
from collections import Counter

words = defaultdict(list)

with sqldict(DBFILE) as db:
    for slug, keywords in db.iteritems():
        keywords = keywords.split(", ")
        for keyword in keywords:
            lower_word = keyword.strip().lower()
            words[lower_word].append(keyword)

pwords = {}
for key in words:
    alist = words[key]
    pwords[key] = Counter(alist).most_common(1)[0][0]
```

And now I've got a proper-case mapping dictionary based on most common usage!

Okay, that went remarkably well. Now for the more difficult bit.

When I do things that pull a list of "slugs" or the slugified titles that I use
as the database primary keys, I am often out of context for pulling the actual
subsequent actual titles and descriptions I need for constructing whatever
page. And so my next step is to use the journal.md file much like I would use a
headlines.db file. There's not even a titles.db because the .db files only get
created for things that OpenAI might have provided. My system requires a title
be provided for publishing, and thus it is always on each post in journal.db
but can't be found in any other file.

Okay, and this is my new improved YAML validation code:

```python
import re
import yaml
from collections import defaultdict

JOURNAL = "/home/ubuntu/repos/hide/MikeLev.in/journal.md"
CHOPPER = (80 * "-") + "\n"


def parse_journal(full_path, reverse=False):
    """Parse a journal file into posts. Returns a generator of posts, reverse-order."""
    with open(full_path, "r") as fh:
        post_str = fh.read()
        pattern = r"-{78,82}\s*\n"
        posts = re.split(pattern, post_str)
        if reverse:
            posts.reverse()  # Reverse so article indexes don't change.
        for post in posts:
            yield post


def extract_front_matter(jekyll):
    parts = jekyll.split("---")
    myaml = f"{parts[0]}"
    return myaml


yaml_dict = defaultdict(dict)
for i, post in enumerate(parse_journal(JOURNAL)):
    if i:
        front_matter = extract_front_matter(post)
        try:
            yaml.safe_load(front_matter)
        except:
            print(front_matter)
            raise SystemExit()
```

Wow, we can actually load the YAML data and use it. This is a much cleaner way
to do it than I was previously.

```python
import re
import yaml
from collections import defaultdict

JOURNAL = "/home/ubuntu/repos/hide/MikeLev.in/journal.md"
CHOPPER = (80 * "-") + "\n"


def parse_journal(full_path, reverse=False):
    """Parse a journal file into posts. Returns a generator of posts, reverse-order."""
    with open(full_path, "r") as fh:
        post_str = fh.read()
        pattern = r"-{78,82}\s*\n"
        posts = re.split(pattern, post_str)
        if reverse:
            posts.reverse()  # Reverse so article indexes don't change.
        for post in posts:
            yield post


def extract_front_matter(jekyll):
    parts = jekyll.split("---")
    myaml = f"{parts[0]}"
    return myaml


yaml_dict = defaultdict(dict)
for i, post in enumerate(parse_journal(JOURNAL)):
    if i:
        front_matter = extract_front_matter(post)
        try:
            yaml.safe_load(front_matter)
        except:
            print(front_matter)
            raise SystemExit()
        yaml_data = yaml.load(front_matter, Loader=yaml.FullLoader)
        print(yaml_data)
        if i > 10:
            raise SystemExit()
print("Done")
```

Okay, so I now have an early-phase YAML validator before I even delete the
files that are going to be regenerated. I always delete files first for a sort
of smaller set of possibilities and more controlled set of conditions. You want
to avoid file collision conditions whenever possible, and you can always do
this with a clean-up phase.

Unified language interfaces... Hmmm. Your skills in a spoken, and perhaps even
written, language is a very important part of your ability to take advantage of
AI. It turns out English is becoming sort of a great interoperable layer of
AI-tech the same way the Linux API and script files have been for decades.

Can you see the eerie similarity between the two? The Linux API is the
hard-textual interface, while the spoken word is the soft-textual interface.
The revolution is more based on language as a particular preferred interface
than others. And this after all the years of graphical point and click
touchscreen user interfaces.

A weird and wonderful world of words is upon us. Of course it's in more
languages than English, but we folks who do not do well with multiple languages
can really dig in on one language and get a lot of mileage out of it. Or at
worst, one language for speaking, one for operating systems, one for
programming, one for manipulating text, and one for manipulating data.

That is, English, Linux, Python, vim and git.

That's it.

This is one particular broad yet small approach to tech.

It's an approach that keeps you from becoming overwhelmed.

As your understanding of a thing increases, you can take cleaner cuts. You can
go back over work you did, and you can see how you can do it better. This
continual improvement is the key to success. So don't get hung up and paralyzed
by first implementation details. Just get it working the way you intend,
however you can. Then you can go back and make it better.

I so want to clean my code now, having made a key realization. It's a perfect
example of how the same concepts keep recurring at different scales, and are
still just as applicable. Everybody's favorite list-maker in Python, the
.slice() function is great for parsing comma separated values such as keywords,
for example. But what I failed to realize is that it's just as valid a
technique for slicing whole megabyte files into chunks based on a separator.

Same thing! That's kind of mind-blowing to me, making me rethink my
line-by-line parsing of post-chunks. My slice & dice system generally takes a
single very long text-file, one often named journal.md, and chops it up into
individual posts. Each post is then parsed for its YAML front matter, and then
it's dropped into a Github repo, where the Jekyll static site generator system
kicks-in and publishes it as a site.

Okay, so I got the Titles and Descriptions on the Category pages coming up
correctly, using Post "slugs", which are my keys for the YAML data. Wow, what a
pay-off. That is the coolest thing ever this kind of capability is just there.

I need to clean up chopchop.py a bit. Not too aggressively. Rabbit holes be not
welcome today. And so...

Wow, I won't do the code clean-up right now, but that's because I want to revel
in the glory of everything working exactly as it's supposed to right now. And
this file format I'm using that's sort of like YAML, and which can be easily
parsed and used like YAML is just so cool. It's meta.

It's reminiscent of some of my old framework building, but it's a very blah
framework. It's a couple of words and you "get it" framework, and if you're a
vim user, it's a format made in heaven. One long diary.md or journal.md for the
rest of your life is a very real, and indeed I would almost call it table
stakes, capability you should have. Not one that gets lost or reset every 2 to
5 years, but rather one text file that lasts your whole life forward, from the
moment you begin using it.

That's what I do. That's what this is. At least on the professional-side, where
it really serves you well if you can document and express well. This can blow
PowerPoint and stuff like that out of the water, because if you wanted your
YAML matter to be transformed into a slideshow, no problem! It's all about easy
parsing and transforms.

So let me put the finishing touches on this cleanup idea so it's documented for
later when I have the motivation to do it. I use the following two functions:

- write_post_to_file()
- front_matter_inserter()

...called from a post generator. They each do different things with the post
text content being yielded, along with its YAML front matter, and had I had
such a clear understanding of the thing, I'd have .sliced() it up into chunks
and then used the .split() function to get the YAML front matter, and then
parsed it with YAML. But I didn't. I just did it the way I knew how, and it
worked. But now I know better, and I can do it better.

So I wrap this post up here, because I have another project I want to get to.
But keep this slicing at different zoom-levels in mind. It's a very powerful
for more than moving keywords back and forth between field-stuffed strings and
structured data. It can be used on these text-files for life, and if your
slicer character is followed by some YAML-like front matter terminated with a
triple hyphen, you can use it to slice up your life into chunks, and then
recombine them into a whole.

That's my Journal-publishing system now, on each run. It's technically never
the same journal.md file as before the release process. I'll have to make sure
I'm being gentle on the git repo. But you get the idea.

It's now time to give this a title and publish it, let OpenAI do its thing, and
get onto how I'm going to get those category descriptions written.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/openai-category-pages-nearly-done/">OpenAI Category Pages Nearly Done</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/designing-yamlesque-post-generator-api/">Designing YAMLesque Post Generator API</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/value/'>Value</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li></ul>