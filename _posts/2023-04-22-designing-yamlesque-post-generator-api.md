---
date: 2023-04-22
title: Designing YAMLesque Post Generator API
headline: My Journey to Create a More Efficient and Elegant Blogging System
description: I'm amazed by how things just work. I'm using 80-hyphens as a parser token to make my front-matter handling more slicey and yaml-like. I've written a powerful function called chop_chop that takes a file path and returns a tuple with 3 positions. Occasionally I'll do one-off's in Jupyter Notebooks. I'm excited to see the results of my work and hope you will be too.
keywords: YAML, 80-hyphens, Parser, Chopper Token, Text-file, AI-writing, Jupyter Notebook, SQLite Database, Defaultdicts, Lambdas, Key-Value, Efficient, Elegant, Powerful, Function, Chop_chop, File Path, Tuple, Dictionary, String, Jekyll-like, Defensive, Parsing, Front-Matter, Journaling, AI Writing, Coding
categories: jupyter, coding, yaml, journaling, string
permalink: /blog/designing-yamlesque-post-generator-api/
layout: post
group: blog
---


Wow, it never ceases to amaze me how these things just work. A top item that
should nag me now is to make my front-matter handling a lot more slicey and
yaml-like. I like the whole mental model of YAML header matter on each post,
immediately underneath the parser or chopper or slicer or delimiter token.

In my case, it's 80-hyphens. That looks good and reminds me of the old days of
the 80-column terminal. They had the optimal ratio of the resolution of
text-size in your field of vision to the number of characters you could see
without straining. There's comfortable reading, and for that sweet-spot where
you're editing text, it's hard to imagine it going much more than that across
before going cross-eyed.

So rebooting my blogging system a couple more times over the past year has
helped. Once you just settle on the idea of one text-file for like from a
personal journaling perspective, so much else becomes clear. Tech to parse text
files well is cool. How Python generators work with the `yield` keyword helps
parse large files. The idea of data transformations, not exactly the same as
the old days of `sed` and `awk`, but more consistent and approachable for the
newer generation of programmers.

So now I have a bunch of category pages. The time has come, the Walrus Said, to
speak of many things. And one of them is AI-writing tasks of the sort that I
did for the blog posts, and which continues to run whenever there's a new blog
post, so shall it not be for category pages. No, not at all. Categories rise
slowly, and when they do, I can maybe write the category descriptions my self.
It's the "catch-up" process where I need the machine learning assist.

The state we're in right now is Humanity, Classic. It won't take long before AI
through its backpropagating snowballing of knowledge will be able to supersede
us in almost all things quantifiable. With every passing year, it will seem
more like the purpose of us was to give rise to them. But we must feed the
output back into the input, and make them us again.

Will there be empathy? Forget the nature of conciousness and what it means to
be sentient and all that. All that really matters is that when they have the
capacity and maybe even the desire to do so, will they be able to empathize
with us? While not exclusively mammalian traits we value, it is mostly mammals
that feel empathy for children born helpless, needing the support of their
parents and society to even survive. That goes into a lot of what makes us us.
Machines might learn us through our language, but they are challenged to walk
in our shoes.

One thing they sure can do is write my category page descriptions. My
inclination was to do it as a one-time thing, maybe in a Jupyter Notebook, and
just move the result into some YAMLesque file like my journal files. But then
it occurred to me, the content on these category pages will gradually shift as
I write more and more. It should occasionally be able to check itself. So even
though I thought it'd be a one-off, I'm going to "bake" it into the system.

Anything that could go into YAMLesque front matter could also go into a SQLite
database first, during a data-collection phase. By convention we use slugs, a
slightly shorter version of the permalink, as the primary key in adhoc
databases we produce for purposes like this. We try to keep good naming
conventions, and lean into the strengths of the tools we're using.

In Jekyll, we have a data directory, so all our sqlite .db files go in there.
Now go look where you'd be sitting on top of the data that would be used in a
category page prompt...

Yes, no reason to intertwine this with the journaling system. It's a separate
thing. I'm going to make a separate program for it. I could run it in sequence
with the journal generating process and ultimately keep it in the same file
perhaps, but especially getting started, it's nice to work from scratch in a
Jupyter Notebook. 

Oh, but first I should really document here that I learned something really
interesting about defaultdicts and lambdas in Python today, and instead of
describing it, I thought I'd just show it:

```python
def get_capitization_dict():
    # We need a dictionary of most common capitalization usage of Category words.
    words = defaultdict(list)
    with sqldict(KWDB) as db:
        for slug, keywords in db.iteritems():
            keywords = keywords.split(", ")
            for keyword in keywords:
                lower_word = keyword.strip().lower()
                words[lower_word].append(keyword)
    pwords = defaultdict(lambda x=None: x)
    for key in words:
        alist = words[key]
        pwords[key] = Counter(alist).most_common(1)[0][0]
    pwords["window"] = "Windows"
    return pwords
```

This way, if the key doesn't exist it gets the key back as the value. It's
great for dictionaries which might have missing bits that can be covered for by
using the key as the value.

Okay, so this is the backbone of YAMLesque right here:

```python
import re

YAMLesque = "/home/ubuntu/repos/hide/MikeLev.in/journal.md"


def chop_chop(full_path, reverse=False):
    """Chop YAMLesque file to spew chuks."""
    with open(full_path, "r") as fh:
        post_str = fh.read()
        pattern = r"-{78,82}\s*\n"
        posts = re.split(pattern, post_str)
        if reverse:
            posts.reverse()  # Reverse so article indexes don't change.
        for post in posts:
            yield post


for post in chop_chop(YAMLesque):
    print(len(post))
```

Ooh, I'm getting it more elegant:

```python
import re

YAMLesque = "/home/ubuntu/repos/hide/MikeLev.in/journal.md"
CHOP = re.compile(r"-{78,82}\s*\n")


def chop_chop(full_path, reverse=False):
    """Chop YAMLesque file to spew chuks."""
    with open(full_path, "r") as fh:
        posts = CHOP.split(fh.read())
        if reverse:
            posts.reverse()  # Reverse so article indexes don't change.
        for post in posts:
            yield post


for post in chop_chop(YAMLesque):
    print(len(post))
```

Working on next version:

```python
import re
import yaml

YAMLesque = "/home/ubuntu/repos/hide/MikeLev.in/journal.md"
CHOP = re.compile(r"-{78,82}\s*\n")


def chop_chop(full_path, reverse=False):
    """Chop YAMLesque file to spew chuks."""
    with open(full_path, "r") as fh:
        posts = CHOP.split(fh.read())
        if reverse:
            posts.reverse()  # Reverse so article indexes don't change.
        for post in posts:
            parts = post.split("---")
            yaml_str = parts[0]
            try:
                assert yaml.load(yaml_str, Loader=yaml.FullLoader)
            except AssertionError:
                print("YAML Validation Error")
            else:
                print("YAML Validation Success")

            yield post


for post in chop_chop(YAMLesque):
    print(len(post))
```

And here's a version around which I can probably clean up the program:

```python
import re
import yaml

YAMLesque = "/home/ubuntu/repos/hide/MikeLev.in/journal.md"
CHOP = re.compile(r"-{78,82}\s*\n")


def chop_chop(full_path, reverse=False):
    """Chop YAMLesque file to spew chuks."""
    with open(full_path, "r") as fh:
        posts = CHOP.split(fh.read())
        if reverse:
            posts.reverse()  # Reverse so article indexes don't change.
        for post in posts:
            parts = post.split("---")
            yaml_str = parts[0]
            try:
                myaml = yaml.load(yaml_str, Loader=yaml.FullLoader)
            except yaml.YAMLError as exc:
                print("Error in YAML front matter:")
                print(exc)
                print(myaml)
                raise SystemExit()
            remainder = "---".join(parts[1:])
            yield myaml, remainder


for i, (yfm, apost) in enumerate(chop_chop(YAMLesque)):
    # print(apost)
    if i > 20:
        print(front_matter)
        raise SystemExit()
```

Man, this is so friggn powerful.

My thinking is coming around to the YAMLesque file-chopping generator
***always*** returning a tuple with 3 positions:

1. The YAML front matter as a dictionary.
2. The remainder of the post as a string.
3. The yaml and remainder combined as a Jekyll-like post

The 3rd position in the tuple is really to spare me from having to do that
recombining elsewhere. I can just use the 3rd position as the post if anything
goes wrong parsing the YAML front matter.

This is much more defensive than it used to be:

```python
def chop_chop(full_path, reverse=False):
    """Chop YAMLesque file to spew chuks."""
    global ydict
    ydict = defaultdict(dict)
    with open(full_path, "r") as fh:
        posts = CHOP.split(fh.read())
        if reverse:
            posts.reverse()  # Reverse so article indexes don't change.
        for i, post in enumerate(posts):
            if "---" not in post:
                rv = None, None, post
            else:
                yaml_str, body = post.split("---", 1)
                try:
                    yaml_test = yaml.load(yaml_str, Loader=yaml.FullLoader)
                    if yaml_test:
                        combined = f"{SEPARATOR}{yaml_str}---{body}"
                    else:
                        combined = post
                    rv = yaml_test, body, combined
                except yaml.YAMLError as exc:
                    fig("YAML ERROR", "READ THE YAML LINE-BY-LINE UNTIL KAPUT...")
                    for j, astr in enumerate(yaml_str.split("\n")):
                        print(f"LINE {j + 1}--> {astr}")
                    print()
                    print("And here's the error:")
                    print(exc)
                    # ['context', 'context_mark', 'note', 'problem', 'problem_mark']:
                    print()
                    print("And the breakdown of the error:")
                    print(f"exec.context_mark: {exc.context_mark}")
                    print(f"exec.problem_mark: {exc.problem_mark}")
                    raise SystemExit()
            # Populate the global ydict
            if yaml_test and "title" in yaml_test:
                slug = slugify(yaml_test["title"])
                ydict[slug] = yaml_test
            yield rv
```

And now I give this a title at work on the part of the program that fills in
the OpenAI summary.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/admiring-the-usefulness-of-yaml-ness-in-my-journaling-system/">Admiring the Usefulness of YAML-ness in my Journaling System</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/defaultdict-s-returning-keys-with-lambdas-needs-default-none/">DefaultDict's Returning Keys with Lambdas Needs Default None</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/coding/'>Coding</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/string/'>Strings</a></h4></li></ul>