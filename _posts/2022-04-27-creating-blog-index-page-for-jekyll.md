---
date: 2022-04-27
title: Creating Blog Index Page for Jekyll
headline: Generate an Index Page for Your Jekyll Blog with My Script!
description: I wrote a script to generate an index page for a blog using Jekyll. It reads a journal file and creates a post for each entry, complete with a title and slug. It then assembles an index page with links to each post, making it easier for readers to find what they're looking for. Click through to explore my blog!
keywords: Jekyll, Script, Index Page, Journal File, Post, Title, Slug, Links, Explore, Blog
categories: jekyll, script
permalink: /blog/creating-blog-index-page-for-jekyll/
layout: post
---


Jekyll has a way of creating index pages to expose links to the blog posts.


```python
import dateutil
from slugify import slugify


try:
    from IPython.display import display, Markdown

    h1 = lambda text: display(Markdown(f"# {text}"))
    h2 = lambda text: display(Markdown(f"## {text}"))
    h3 = lambda text: display(Markdown(f"### {text}"))
    jn = True
except:
    h1 = lambda text: print(f"# {text}")
    h2 = lambda text: print(f"## {text}")
    h3 = lambda text: print(f"## {text}")
    jn = False

folder_name = "../pythonically"
blog = "blog"

index_front_matter = f"""---
layout: post
title: "Pythonic Ally Blog Index"
slug: {blog}
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
                top.append(f"categories: {blog}\n")
                top.append(f"slug: {slug}\n")
                link = f"- [{title}](/{blog}/{slug}/)"
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


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/turning-repo-into-nbdev-project/">Turning Repo into nbdev Project</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/creating-blog-index-page-for-jekyll/">Creating Blog Index Page for Jekyll</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/script/'>Script</a></h4></li></ul>