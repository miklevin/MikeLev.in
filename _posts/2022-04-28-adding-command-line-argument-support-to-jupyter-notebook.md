---
date: 2022-04-28
title: Adding Command-Line Argument Support to Jupyter Notebook
headline: Adding Command-Line Argument Support to Jupyter Notebook - My Journey to Making a Change
description: I have added command-line argument support to my Jupyter Notebook using the Python standard library argparse. I have coded up a .py file and tested it successfully, and am now transplanting it into blogslicer, creating functions for displaying headings, and using dateutil and slugify modules. I wrote a script to slice and dice my blog posts into the correct format for Jekyll and incorporated it into my regular publishing release script. I made a change to my world
keywords: "Command-Line Argument, Jupyter Notebook, Python, argparse, .py file, blogslicer, headings, dateutil, slugify, Jekyll, vim, git, `_include`, `_posts`"
categories: jupyter notebook, python, vim, git, jekyll
permalink: /blog/adding-command-line-argument-support-to-jupyter-notebook/
layout: post
---


The time has come the walrus said to parameterize blogslicer. Running it in a
notebook is dandy, but incorporating it into my regular release process is
better. And my release process is a bash shell script.

Everyone should use bash shell scripts even if you're on Windows (as I am) or
Mac because it's one of those timeless skills that transcends all else in tech.

In case you didn't notice, tech is text and text is tricks. And so by the
transitive property of because-I-say-so, all tech is tricks. And by far one of
the greatest of all tricks is to take something you've developed in a Jupyter
Notebook which could apply to a whole host of different situations and to turn
it into a parameterized package.

Huh? Yeah, that just means making the file.ipynb into a file.py and make sure
you can send it input-values on the command-line string. Sometimes these are
called parameters. And the parameters take arguments. Parameters have rules
like whether labeling the input with keywords is necessary or whether absolute
positions after the file.py have special meaning, such as:

```bash
blogslicer.py -foo bar
```

And so what we do is look at the Python standard library and find argparse. And
after years of shunning pip installs for something the standard library did
perfectly well, I'm doing a complete 180. Most people will guide you towards
docopt (best package name ***ever***) or click. After a thorough cheerleading
session by Cecil Phillip on the [Talk Python to Me](https://talkpython.fm/episodes/show/363/python-for-.net-and-c-developers)
podcast, I'm going to give Typer a try.

I'm actually quite new to the Python mypy optional type annotation system which
typer seems to use, so this may be a new experience for me. I may have to add
type annotations to blogslicer, which will make this a doubly interesting
project. Okay, so 1, 2, 3... 1?

```python
pip install typer
```

The example at https://typer.tiangolo.com/ says... oh, boooo! This thing seems
to actually require the use of functions. Darn it! That's the thing about these
snooty right-way-to-do-things opinionated apps. Shoot, I was looking forward to
it too.

So do I change this journal entry? Nope! The process is as insightful as
anything else. So let me remind myself what it'd look like with argparse.

```python
import argparse

parser = argparse.ArgumentParser()
add_arg = parser.add_argument
add_arg("-p", "--path", required=True)
add_arg("-t", "--title", required=True)
add_arg("-s", "--slug", required=True)
args = parser.parse_args()
```

This is all well and good, but it won't run in a Jupyter Notebook. Okay, so I
need to create another Notebook as a test. I don't want to mix this in with the
good code yet. I'm isolating a test:

```python
# export

if hasattr(__builtins__, "__IPYTHON__"):
    folder_name = "../pythonically"
    blog_title = "Pythonic Ally Blog Index"
    blog_slug = "blog"
else:
    import argparse

    parser = argparse.ArgumentParser()
    add_arg = parser.add_argument
    add_arg("-p", "--path", required=True)
    add_arg("-t", "--title", required=True)
    add_arg("-s", "--slug", required=True)
    args = parser.parse_args()
    print(args)

    folder_name = args.path
    blog_title = args.title
    blog_slug = args.slug

print(folder_name, blog_title, blog_slug)
```

You will notice the export command at the top. That's for nbdev. There's also
another code-block in the notebook which sets the default file-name. The point
is here that I can use notebooks even to code up .py files that are not going
to run in the context of Jupyter. I use nbdev_build_lib which outputs the file.
And I test it like this:

```bash
python testargs.py -p "./pythonically" -t "This is my title" -s "blog"
./pythonically This is my title blog
```

And that is what we call a massive success! DocOpt? Click? Typer? Pishaw! Who
needs them. I've reverted to my old belief that the good ol' standard library
is arguably good enough for arguments.

And so now it's time to transplant my test code into blogslicer!

```python
# export

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

if hasattr(__builtins__, "__IPYTHON__"):
    folder_name = "../pythonically"
    blog_title = "Pythonic Ally Blog Index"
    blog_slug = "blog"
else:
    import argparse

    parser = argparse.ArgumentParser()
    add_arg = parser.add_argument
    add_arg("-p", "--path", required=True)
    add_arg("-t", "--title", required=True)
    add_arg("-s", "--slug", required=True)
    args = parser.parse_args()

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

Okay, but I see that I have 2 different places (and techniques) where I test
whether it's running in a Notebook or not. I should combine them as such:

```python
# export

import argparse
from dateutil import parser
from slugify import slugify


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

Pshwew! Okay, I think I've got it. Now after I nbdev_build_lib, I can run this
on the command-line after cd'ing into the blogslider/blogslicer subfolder that
nbdev creates.

```bash
python core.py -p "../../pythonically" -t "Pythonic Ally Blog" -s "blog"
```

And it worked! It output the sliced & diced files into the correct Jekyll
\_posts folder, and so I am ready to incorporate this into my regular
publishing release script. I'm tempted to put blogslicer into PyPi.org right
away, but there's no need so long as I can wrangle my paths correctly.

And it worked! I know because you're reading this as a result of me
incorporating the whole process into my regular release system.

What regular release system? Oh, the one that runs whenever I'm blogging in vim
and press my @g macro... like I did just now. I won't overload this post with
my entire release script, but the part that publishes this site looks like
this:

```bash
figlet pythonically -w 120
python ./blogslicer/blogslicer/core.py -p "./pythonically" -t "Pythonic Ally Blog" -s "blog"
cd pythonically
# git pull
git add _includes/*
git add _posts/*
git commit -am "Updating all"
git push
cd ..
```

And so the world has changed forever for me with one little incremental step
forward.

<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/adding-command-line-argument-support-to-jupyter-notebook">Adding Command-Line Argument Support to Jupyter Notebook</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/every-little-project-gets-done-elpgd">Every Little Project Gets Done (ELPGD)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter-notebook/'>Jupyter Notebook</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li></ul>