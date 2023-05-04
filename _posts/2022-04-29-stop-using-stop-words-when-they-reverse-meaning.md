---
date: 2022-04-29
title: Stop Using Stop-Words When They Reverse Meaning
headline: "Fixing Stopwords: How I Rescued My Post From Getting Mangled in the URL"
description: I recently wrote a post about stopwords and noticed that the title was getting distorted in the URL. To fix this, I wrote some code to strip out all stopwords and create a post with a more appropriate URL. This code also creates a folder to store the posts and generates a blog.md file with a list of all the posts. Read my blog post to learn more about how I fixed this issue!
keywords: stopwords, URL, code, strip, folder, store, posts, blog.md, file, list, fix, issue, meaning, mangled, appropriate
categories: 
permalink: /blog/stop-using-stop-words-when-they-reverse-meaning/
layout: post
---


Ugh, after all that stopwords stuff from the earlier post, I'm stripping it
out. The meaning can get totally mangled. For example, the title:

    Don't Obfuscate A Perfectly Fine Pythonic FizzBuzz

...became the URL:

    https://pythonically.com/blog/obfuscate-perfectly-fine-pythonic-fizzbuzz/

Ugh! Unacceptable! Okay, so I stripped out all that stop_words stuff, and the
code is now:

```python
# export

import nltk
import argparse
from pathlib import Path
from dateutil import parser
from slugify import slugify


if hasattr(__builtins__, "__IPYTHON__"):
    from IPython.display import display, Markdown

    h1 = lambda text: display(Markdown(f"# {text}"))
    h2 = lambda text: display(Markdown(f"## {text}"))
    h3 = lambda text: display(Markdown(f"### {text}"))

    folder_name = "../pythonically"
    blog_title = "Pythonic Ally Blog"
    blog_slug = "blog"
else:
    h1 = lambda text: print(f"# {text}")
    h2 = lambda text: print(f"## {text}")
    h3 = lambda text: print(f"## {text}")

    aparser = argparse.ArgumentParser()
    add_arg = aparser.add_argument
    add_arg("-p", "--path", required=True)
    add_arg("-t", "--title", required=True)
    add_arg("-s", "--slug", required=True)
    args = aparser.parse_args()

    folder_name = args.path
    blog_title = args.title
    blog_slug = args.slug


index_front_matter = f"""---
layout: post
title: "{blog_title}"
slug: {blog_slug}
---

## [{blog_title} as One Page](/journal/)

"""

journal_path = f"{folder_name}/journal.md"
output_path = f"{folder_name}/_posts/"
slicer = "-" * 80

Path(output_path).mkdir(exist_ok=True)

dates = []
counter = -1
date_next = False
with open(journal_path, "r") as fh:
    for line in fh:
        line = line.rstrip()
        if date_next:
            adate = line[3:]
            date_next = False
            adatetime = parser.parse(adate).date()
            dates.append(adatetime)
            date_next = False
        if line == slicer:
            date_next = True
            counter = counter + 1
dates.reverse()

table = []
at_top = True
index_list = []
with open(journal_path, "r") as fh:
    for i, line in enumerate(fh):
        line = line.rstrip()
        if line == slicer:
            if at_top:
                at_top = False
                table = []
                continue
            adatetime = dates[counter - 1]
            filename = f"{output_path}{adatetime}-post-{counter}.md"
            h3(f"FILE: {filename}")
            with open(filename, "w") as fw:
                title = f"Post {counter}"
                slug = title
                if table[0] == slicer:
                    table = table[1:]
                maybe = table[1]
                has_title = False
                if table and maybe and maybe[0] == "#":
                    title = maybe[maybe.find(" ") + 1 :]
                    has_title = True
                slug = slugify(title)
                top = []
                top.append("---\n")
                top.append("layout: post\n")
                top.append(f'title: "{title}"\n')
                top.append(f"categories: {blog_slug}\n")
                top.append(f"slug: {slug}\n")
                link = f"- [{title}](/{blog_slug}/{slug}/)"
                index_list.append(link)
                top.append("---\n")
                top.append("\n")
                top_chop = 2
                if has_title:
                    top_chop = 3
                table = [f"{x}\n" for x in table[top_chop:]]
                table = top + table
                print("".join(table))
                fw.writelines(table)
            counter = counter - 1
            table = []
        table.append(line)

index_page = index_front_matter + "\n\n" + "\n".join(index_list)

with open(f"{folder_name}/blog.md", "w") as fh:
    fh.writelines(index_page)
```


<div class="post-nav"><div class="post-nav-next"><a href="/blog/massaging-10-sites-into-shape-at-once">Massaging 10 Sites Into Shape At Once</a><span class="arrow">&nbsp;&rarr;</span></div> &nbsp; <div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/stop-using-stop-words-when-they-reverse-meaning">Stop Using Stop-Words When They Reverse Meaning</a></div></div>
## Categories

<ul></ul>