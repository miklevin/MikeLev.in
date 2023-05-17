---
date: 2022-04-29
title: Massaging 10 Sites Into Shape At Once
headline: "Speed Up Site Optimization: How I Massaged 10 Sites Into Shape At Once"
description: I recently optimized my Jekyll blog post URLs by removing stopwords, and I wanted to roll out the changes across all my sites. To make the process faster, I created a script that I could execute from Linux on Windows. With this script, I was able to quickly and easily make the same changes across all my sites. Read more to learn how I did it.
keywords: "Jekyll, URLs, Stopwords, Linux, Windows, Script, Git, Index.md, `_config.yml`, Helper Folder"
categories: jekyll, git, python, microsoft, linux
permalink: /blog/massaging-10-sites-into-shape-at-once/
layout: post
---


Okay, I just removed stopwords from Jekyll blog post URLs. I did it quite
easily borrowing some code I recently did for [mlseo](https://pypi.org/project/mlseo/).
And next I think I want to roll the advances out across all my sites that could
benefit. Okay, so do it!

I just did whatsametafor.io. There were some interesting steps that I have to
remember:

- git mv index.md journal.md
- Put a new index.md in location
- Update the \_config.yml file

Do https://linuxpythonvimgit.com/ next and update that check-list. Also instead
of venturing into all these different Github.io templates (a mistake) focus on
one single template (hacker) so that you can move forward across all sites more
rapidly. Sure, they'll all look the same at first, but I can focus later on
divergence. It's convergence right now that accelerates the process.

Okay so let's do this thing.

- cd into ~/github/linuxpythonvimgit
- git mv index.md journal.md
- cp ../whatsametafor/index.md .
- Edits to index.md
- git add index.md
- mkdir \_posts

Ugh! Do this for every folder at once. Okay, so I put some "source" files into
my helper folder, such as a sample \_config.yml and index.md file. Then I
execute this script from Linux on Windows. Because of the use of git in the
commands, it is not an appropriate script to run from JuptyerLabs on Windows.

```python
from subprocess import run
from pathlib import Path


sites = """guerillatech
linuxpythonvimgit
lundervand
mike-levin
mikeateleven
pipulate
pythonically
removablefinger
tardigradecircus
tictacufosightings
whatsametafor""".split('\n')

ghp = "/mnt/c/Users/mikle/github/"

for site in sites:
    Path(f'../{site}/_posts').mkdir(exist_ok=True)
    print(site)
    if not Path(f"{ghp}{site}/index.md").is_file():
        run(["cp", "index.md", f"{ghp}{site}/"], cwd=f"{ghp}helpers/")
    run(["git", "add", "_posts"], cwd=f"{ghp}{site}/")
    run(["git", "add", "blog.md"], cwd=f"{ghp}{site}/")
    run(["git", "add", "index.md"], cwd=f"{ghp}{site}/")
    run(["cp", "_config.yml", f"{ghp}{site}/"], cwd=f"{ghp}helpers/")
    run(["git", "add", "_config.yml"], cwd=f"{ghp}{site}/")
    run(["git", "commit", "-am", "Added _posts"], cwd=f"{ghp}{site}/")
    print()
```

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/adding-command-line-argument-support-to-jupyter-notebook/">Adding Command-Line Argument Support to Jupyter Notebook</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/massaging-10-sites-into-shape-at-once/">Massaging 10 Sites Into Shape At Once</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>