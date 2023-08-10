---
date: 2023-04-17
title: Fixing How OpenAI Couldn't Format Keywords Consistently
headline: Creating Consistent Keyword Formatting with OpenAI Code
description: I'm working to fix OpenAI keyword problems by writing code to recognize text that doesn't match the keyword format, handling commas inside quotes, and creating histograms. I've used this code to re-write the database of keywords for my blog, validate YAML in Python without Jekyll, and create category pages and navigation. I'm committed to developing a code that can consistently format keywords.
keywords: OpenAI, Keywords, Formatting, Commas, Quotes, Histograms, Database, Re-write, Validate, YAML, Python, Jekyll, Category Pages, Navigation, Regular Expressions, Popular, Content, Error Message, File Path
categories: database, seo, jekyll, yaml, python, ai, navigation
permalink: /blog/fixing-how-openai-couldn-t-format-keywords-consistently/
layout: post
group: blog
---


I'm going to fix the OpenAI keyword problems. This gets us started by
recognizing things that don't match the "keyword one", "keyword two" format.
First, I catch singletons.

```python
from sqlitedict import SqliteDict as sqldict


inside_comma = r'^("[^"]+",\s*)+"[^"]+"$'

with sqldict("topics.db") as db:
    for i, (key, value) in enumerate(db.iteritems()):
        nv = None
        if not re.match(inside_comma, value):
            if value.count('"') == 2 and value[0] == '"' and value[-1] == '"':
                nv = value
        print(nv)
```

Fast-forward to handling the most common case, the comma inside the quotes:

    "keyword one," "keyword two," "keyword three"

The problems are like this one and many variations. I've already bored you.
Let's get the code done!

```python

```python
from collections import Counter
from sqlitedict import SqliteDict as sqldict


def good_pat(text):
    inside_comma = r'^("[^"]+",\s*)+"[^"]+"$'
    if not re.match(inside_comma, text):
        return False
    else:
        return True

def get_max_count_key(data):
    counts = Counter(data)
    max_count = max(counts.values())
    max_count_keys = [key for key, value in counts.items() if value == max_count]

    return max_count_keys[0] if max_count_keys else None


with sqldict("topics.db") as db:
    for i, (key, value) in enumerate(db.iteritems()):
        nv = None
        if good_pat(value):
            nv = value
        else:
            # Do some setup for tests

            # Turn value into a list
            alist = value.split(" ")
            # Only keep list elements longer than 1
            alist = [x for x in alist if len(x) > 1]
            # Create a list of the 2nd-to-last characters
            comma_test = [x[-2] for x in alist]
            # Chreate a histogram of those characters
            counts = Counter(comma_test)
            # Get the most frequent ending character
            max_end = get_max_count_key(counts)

            if value.count('"') == 2 and value[0] == '"' and value[-1] == '"':
                # Simple case of the singleton
                nv = value
            elif max_end == ",":
                alist = value[1:-1]
                alist = alist.split('," "')
                last_item = alist[-1]
                last_item_last_char = last_item[-1]
                if last_item_last_char == '.':
                    alist[-1] = last_item_last_char[1:-1]
                alist = [f'"{x}"' for x in alist if x]
                astring = ", ".join(alist)
                if good_pat(astring):
                    nv = astring
        print(i, nv)
        print()
        if not nv:
            print(value)
            raise SystemExit()
```

Ugh! That got out of hand. I'm taking a new approach:

```python
import re
from collections import Counter
from sqlitedict import SqliteDict as sqldict


def check_pat(text):
    inside_comma = r'(^("[^"]+",\s*)+"[^"]+"$)|(^"[^",]*"$)'
    if re.match(inside_comma, text):
        return text
    else:
        return None


with sqldict("topics.db") as db:
    for i, (key, value) in enumerate(db.iteritems()):
        newlist = check_pat(value)
        if not newlist:
            noquotes = value.replace('"', '')
            alist = noquotes.split(", ")
            alist = [f'"{x}"' for x in alist]
            alist = ", ".join(alist)
            newlist = check_pat(alist)
            if not newlist:
                print(i, value)
                raise SystemExit()
```

And I developed that one nearly finished:

```python
import re
from collections import Counter
from sqlitedict import SqliteDict as sqldict


def check_pat(text):
    """Checks for good quote-and-comma string format."""
    inside_comma = r'(^("[^"]+",\s*)+"[^"]+"$)|(^"[^",]*"$)'

    if re.match(inside_comma, text, re.MULTILINE) and "\n" not in text:
        return text
    else:
        return None


with sqldict("topics.db") as db:
    for i, (key, value) in enumerate(db.iteritems()):
        newlist = check_pat(value)
        if not newlist and value.count('"') > 3:
            # Just strip out the quotes if not a singleton
            noquotes = value.replace('"', "")
            alist = noquotes.split(", ")
            alist = [f'"{x}"' for x in alist]
            alist = ", ".join(alist)
            newlist = check_pat(alist)
            if not newlist and "\n" in value:
                alist = value.split("\n")
                alist = [x.replace('"', "") for x in alist]
                alist = [f'"{x}"' for x in alist]
                alist = ", ".join(alist)
                newlist = check_pat(alist)
                if not newlist:
                    print(i, alist)
                    raise SystemExit()
        print(i, newlist)
        print()
print("Done")
```

And here's the finished code that re-writes the database:

```python
import re
from collections import Counter
from sqlitedict import SqliteDict as sqldict


def check_pat(text):
    """Checks for good quote-and-comma string format."""
    inside_comma = r'(^("[^"]+",\s*)+"[^"]+"$)|(^"[^",]*"$)'
    if re.match(inside_comma, text, re.MULTILINE) and "\n" not in text:
        return text
    else:
        return None


with sqldict("topics.db") as db:
    for i, (key, value) in enumerate(db.iteritems()):
        newlist = check_pat(value)
        if not newlist and value.count('"') > 3:
            # Just strip out the quotes if not a singleton
            noquotes = value.replace('"', "")
            alist = noquotes.split(", ")
            alist = [f'"{x}"' for x in alist]
            alist = ", ".join(alist)
            newlist = check_pat(alist)
            if not newlist and "\n" in value:
                alist = value.split("\n")
                alist = [x.replace('"', "") for x in alist]
                alist = [f'"{x}"' for x in alist]
                alist = ", ".join(alist)
                newlist = check_pat(alist)
                if not newlist:
                    print(i, alist)
                    raise SystemExit()
            real_list = eval(f"[{newlist}]")
            assert (type(real_list)) == list
            db[key] = newlist
    db.commit()
print("Done")
```

And there were a few stragglers that had to be cleaned up:

```python
with sqldict("topics.db") as db:
    for i, (key, value) in enumerate(db.iteritems()):
        proc = False
        if value:
            check_pat(value)
            try:
                eval(f"[{value}]")
            except:
                proc = True
        if proc:
            alist = value.split(", ")
            alist = [x.replace('"', "") for x in alist]
            alist = [f'"{x}"' for x in alist]
            alist = ", ".join(alist)
            print(i, alist)
            db[key] = alist
    db.commit()
```

And now I can do a histogram of the keywords on my blog:

```python
keywords = []
with sqldict("topics.db") as db:
    for i, (key, value) in enumerate(db.iteritems()):
        alist = eval(f"[{value}]")
        alist = [x.lower() for x in alist if x]
        keywords += alist
kwhist = Counter(keywords)
kwhist = kwhist.most_common()
[x for x in kwhist if x[1] > 5]
```

And here's the most popular keywords on my site. I'll have to make category
pages and navigation out of this.

```python
[('python', 89),
 ('linux', 70),
 ('vim', 50),
 ('seo', 41),
 ('windows', 28),
 ('ai', 26),
 ('lxd', 25),
 ('jekyll', 22),
 ('jupyterlab', 20),
 ('git', 20),
 ('technology', 20),
 ('microsoft', 17),
 ('github pages', 15),
 ('wsl2', 15),
 ('wsl', 15),
 ('bing', 15),
 ('jupyter notebooks', 13),
 ('nbdev', 12),
 ('artificial intelligence', 12),
 ('youtube', 11),
 ('github', 11),
 ('jupyter notebook', 11),
 ('automation', 11),
 ('journaling', 11),
 ('data', 11),
 ('writing', 10),
 ('web development', 10),
 ('systemd', 10),
 ('jupyter', 9),
 ('unix', 9),
 ('windows 10', 9),
 ('windows subsystem for linux', 9),
 ('foss', 9),
 ('chatgpt', 9),
 ('website', 8),
 ('code', 8),
 ('productivity', 8),
 ('script', 8),
 ('blog', 8),
 ('markdown', 8),
 ('ubuntu', 8),
 ('api', 8),
 ('machine learning', 8),
 ('vscode', 8),
 ('NeoVim', 8),
 ('blog post', 7),
 ('google', 7),
 ('video', 7),
 ('pipulate', 7),
 ('coding', 7),
 ('html', 6),
 ('github.io', 6),
 ('google analytics', 6),
 ('documentation', 6),
 ('configuration', 6),
 ('ubuntu 20.04', 6),
 ('ubuntu 18.04', 6),
 ('challenges', 6),
 ('quantum mechanics', 6),
 ('open source', 6),
 ('google photos', 6),
 ('ufos', 6),
 ('openai', 6),
 ('mac', 6)]
```

And one final newsflash here. I had to do one more update of the keyword
database:

```python
keywords = []
with sqldict("topics.db") as db:
    for i, (key, value) in enumerate(db.iteritems()):
        if value:
            alist = value.split(", ")
            alist = [x.replace('"', "") for x in alist]
            # alist = [f'"{x}"' for x in alist]
            alist = ", ".join(alist)
            print(i, alist)
            db[key] = alist
    db.commit()
```

...because I kept getting YAML parsing errors when I tried to insert them
Jekyll frontmatter. It's related to the quotes. I wrote this program so I can
validate YAML in Python without Jekyll:

```python
import os
import yaml

folder_path = "/home/ubuntu/repos/hide/MikeLev.in/_posts"

for filename in os.listdir(folder_path):
    if filename.endswith(".md"):
        file_path = os.path.join(folder_path, filename)
        with open(file_path, "r") as file:
            post_content = file.read()
            _, yaml_front_matter, _ = post_content.split("---", maxsplit=2)
            try:
                yaml.safe_load(yaml_front_matter)
                print(f"{file_path}: YAML front matter is valid.")
            except yaml.YAMLError as e:
                print(f"{file_path}: Error in YAML front matter:", e)
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/planning-python-packaging-for-seo-deliverable/">Planning Python Packaging for SEO Deliverable</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/switched-from-text-davinci-002-to-text-davinci-003/">Switched from text-davinci-002 to text-davinci-003</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/navigation/'>Navigation</a></h4></li></ul>