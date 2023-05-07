---
date: 2022-04-26
title: Using Blog Titles for Filenames
headline: "Success: Using Blog Titles for Unique Filenames"
description: "I'm excited to share that I made great progress on a blog slicing and dicing system. I managed to maintain my blogging format while also figuring out the title stuff. I now have `_counter_` posts, each with a unique filename based on the post title, as well as the title, layout, categories, and slug. Come read more to learn how I did it!"
keywords: blogging, filename, post title, layout, categories, slug, slicing, dicing, system, progress, concessions, unique
categories: progress, blogging, unique
permalink: /blog/using-blog-titles-for-filenames/
layout: post
---


Made a lot of good progress yesterday on the blog slice & dice system. Just
have to get that title stuff down. Okay, got it done. There are little
concessions here and there because I'm keeping my blogging format mostly
intact.

```python
import dateutil
from slugify import slugify
from IPython.display import display, Markdown


h1 = lambda text: display(Markdown(f"# {text}"))
h2 = lambda text: display(Markdown(f"## {text}"))
h3 = lambda text: display(Markdown(f"### {text}"))

site_base = "https://pythonically.com"
slicer = "-" * 80

dates = []
counter = -1
date_next = False
with open("./index.md", "r") as fh:
    for line in fh:
        line = line.rstrip()
        if date_next:
            adate = line[3:]
            date_next = False
            adatetime = dateutil.parser.parse(adate).date()
            dates.append(adatetime)
            date_next = False
        if line == slicer:
            date_next = True
            counter = counter + 1
dates.reverse()

h1(f"There Are {counter} Posts:")

table = []
at_top = True
with open("./index.md", "r") as fh:
    for i, line in enumerate(fh):
        line = line.rstrip()
        if line == slicer:
            if at_top:
                at_top = False
                table = []
                continue
            adatetime = dates[counter - 1]
            filename = f"./_posts/{adatetime}-post-{counter}.md"
            h3(f"FILE: {filename}")
            with open(filename, "w") as fw:
                title = f"Post {counter}"
                if table[0] == slicer:
                    table = table[1:]
                maybe = table[1]
                has_title = False
                if table and maybe and maybe[0] == "#":
                    title = maybe[maybe.find(" ") + 1 :]
                    title = slugify(title)
                    has_title = True
                top = []
                top.append("---\n")
                top.append("layout: post\n")
                top.append(f'title: "{title}"\n')
                top.append("categories: blog\n")
                slug = title.lower().replace(" ", "-")
                top.append(f"slug: {slug}\n")
                top.append("---\n")
                top.append("\n")
                top_chop = 2
                if has_title:
                    top_chop = 3
                table = [f"{x}\n" for x in table[top_chop:]]
                table = top + table
                # display(Markdown(''.join(table)))
                print("".join(table))
                fw.writelines(table)
            counter = counter - 1
            table = []
        table.append(line)
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/how-to-control-urls-and-links-in-jekyll/">How To Control URLs and Links in Jekyll</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/using-blog-titles-for-filenames/">Using Blog Titles for Filenames</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/progress/'>Progress</a></h4></li>
<li><h4><a href='/blogging/'>Blogging</a></h4></li>
<li><h4><a href='/unique/'>Unique</a></h4></li></ul>