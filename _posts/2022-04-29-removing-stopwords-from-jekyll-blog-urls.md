---
date: 2022-04-29
title: Removing Stopwords From Jekyll Blog URLs
headline: "15-Year Project Complete: Removing Stopwords from Jekyll Blog URLs"
description: I recently completed a 15-year project, blogslicer, as part of my ELPGD (every little project gets done) mentality. I used Linux, Python, vim, and git to create the program, and now I'm incorporating a feature to remove stopwords from Jekyll blog URLs using the Python library, nltk. I'm writing code to create a blog post with a given title, slug, and path, which will generate a journal.md file with a table
keywords: Linux, Python, vim, git, ELPGD, nltk, Stopwords, Jekyll, URLs, journal.md, table, contents, _posts, layout, title, categories, slug, blog.md, list
categories: linux, vim, python, git, journal.md, jekyll
permalink: /blog/removing-stopwords-from-jekyll-blog-urls/
layout: post
group: blog
---


Yesterday I got the must-have features of my blogslicer program done. It can be
found in github as [blogslicer](https://github.com/miklevin/blogslicer/). This
is actually rather big in my life and one of the perfect "because I'm 50"
projects. It's the first of my ELPGD (every little project gets done)
mentality. Honestly, I've spent the last 15 years or so just re-educating
myself and getting tech-literate again.

- I once was tech-literate because of the Amiga computer. Then it went away.
- I again was tech-literate because of Microsoft Active Server Pages. Then it
  went away.
- I was fooled twice and refused to get fooled again.
  - So I passed over Ruby on Rails
  - So I passed over JavaScript on the server
- After long soul-searching, I settled on:
  - Linux
  - Python
  - vim
  - git

And I never looked back... oh, except when JavaScript took over the world as
"the full webstack". Then I looked back, had buyer's remorse, looked more
closely at JavaScript and ECMA script, then was happy with my LPvg (Linux,
Python, vim & git) decision. Ugh! I see the hamster wheel JavaScript folks are
on today and I see it as the institutionalization of the very tech-reset-button
I despise. Even if your core language stays the same, it's just as bad if the
core language is awful and all the frameworks based on it (out of necessity)
are both equally awful and constantly changing.

If I need a web-service (or web-anything, for that matter) there's Flask. There
always was Flask. There always will be Flask. And while there are many others
like FastAPI, pylons and the like, they're all optional higher-dependency
fad-driven edge cases that come and go. Flask always remains. It's too big to
fail and too widely deployed to not be upgraded. We see that in its embracing
of async/await... though the same can't be said of the ubiquitous Requests
package. But the point almost still stands because httpx came along as an
API-compatible version of Requests that does support async/await, so you don't
really have to relearn old stuff. You can just focus on the new. And when
Request finally does come around, chances are its implementation will be
similar enough to httpx that your career of computer literacy won't be nuked
the way it is in a move from React to Vue or from Vue to Svelte or whatnot.

Okay, all that's just sort of a deep-breath preamble to what I want to do next
on blogslicer. URLs are too long. I need to filter stop-words out of the URLs
when a custom URL is constructed from the title. This is instead of
implementing some arbitrary plug/slug replacement system. If you're basing URLs
on titles then you're basing URLs on titles. Most of the things you'd want to
overwrite that for is editing out stopwords anyway. And so...

```python
import nltk
from nltk.corpus import stopwords

nltk.download("stopwords", quiet=True)
stops = stopwords.words("english")
...
slug = title.lower()
slug = " ".join([x for x in slug.split() if x not in stops])
```

Yup. And so now incorporate it into the code:

```python
# export

import nltk
import argparse
from dateutil import parser
from slugify import slugify
from nltk.corpus import stopwords

nltk.download("stopwords", quiet=True)
stops = stopwords.words("english")

if hasattr(__builtins__, "__IPYTHON__"):
    from IPython.display import display, Markdown

    h1 = lambda text: display(Markdown(f"# {text}"))
    h2 = lambda text: display(Markdown(f"## {text}"))
    h3 = lambda text: display(Markdown(f"### {text}"))

    folder_name = "../pythonically"
    blog_title = "Pythonic Ally Blog Index"
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
---"""

journal_path = f"{folder_name}/journal.md"
output_path = f"{folder_name}/_posts/"
slicer = "-" * 80

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

h1(f"There Are {counter} Posts:")

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
                slug = title.lower()
                slug = " ".join([x for x in slug.split() if x not in stops])
                slug = slugify(slug)
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

It's time to look into how to highlight specific lines of code in markdown
under Jekyll.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/creating-blog-index-page-for-jekyll/">Creating Blog Index Page for Jekyll</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/removing-stopwords-from-jekyll-blog-urls/">Removing Stopwords From Jekyll Blog URLs</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/journal-md/'>Journal.md</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li></ul>