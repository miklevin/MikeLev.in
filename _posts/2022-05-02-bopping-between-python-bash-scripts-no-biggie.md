---
date: 2022-05-02
title: Bopping Between Python & Bash Scripts No Biggie
headline: Migrating Wordpress Content to Github Pages with Python & Bash Scripts
description: I recently moved my Wordpress site off of my HostMonster account and exported the content as markdown. To re-publish the content, I used Github Pages and managed the blog content across 15 sites with a single journal.md file and a bash file. To make the process easier, I wrote a Python script, make_helpers, to manage the sites.txt file and change the order of the file locations. Read my blog post to find out how I did it.
keywords: Python, Bash, Scripts, Wordpress, HostMonster, Markdown, Github, Pages, Journal.md, Sites.txt, File Locations, Make_Helpers
categories: python, wordpress, journal.md, git, linux
permalink: /blog/bopping-between-python-bash-scripts-no-biggie/
layout: post
---


Well I've been yanking my new blog-content between sites fast and furious over
the past week as my new journal.md to sliced & diced YYYY-MM-DD-tile-words.md
format that Jekyll likes came together. I'm cutting down technical liabilities.

It all started when I finally decided to get my decrepit old Word Press site
that's been with me almost since the rise of the Web off of my old HostMonster
account. The export tool I used, which I believe was a plugin, was specifically
for exporting as markdown keeping the relative paths to the graphics assets
intact.

The exporting went smoothly but how to get it all re-published. Markdown...
github.io, hmmm. In an act of desperation I dumped it all into Github,
activated Github Pages and did just enough jiggering around of file-locations
and yaml files to get the silly thing hosted again, as outdated as it was.

The way I can easily manage blogs across now 15 sites is that the entire blog
(per site) is managed in a single journal.md file. The way I can load 15 files
to edit easily is to have a all.sh bash file that I execute. It contains
commands like:

```bash
vim ./journal/journal.txt ./MikeLev.in/journal.md ./MikeLevinSEO.com/journal.md ./PythonicAlly.com/journal.md ./LinuxPythonvimgit.com/journal.md ./MikeAtEleven.com/journal.md ./TardigradeCircus.com/journal.md ./RemovableFinger.com/journal.md ./Mike-Levin.com/journal.md ./LunderVand.com/journal.md ./WhatsaMetaFor.io/journal.md ./GuerillaTech.com/journal.md ./TicTacUFOSightings.com/journal.md ./PythonicAlly.org/journal.md ./Pipulate.com/journal.md ./Levinux.com/journal.md ~/.vimrc ./blast.sh
```

However the ORDER of these things I'd like to change from time to time, so it
all gets controlled from a file sites.txt which contains:

    MikeLev.in
    MikeLevinSEO.com
    PythonicAlly.com
    LinuxPythonvimgit.com
    MikeAtEleven.com
    TardigradeCircus.com
    RemovableFinger.com
    Mike-Levin.com
    LunderVand.com
    WhatsaMetaFor.io
    GuerillaTech.com
    TicTacUFOSightings.com
    PythonicAlly.org
    Pipulate.com
    Levinux.com

So I want to be able to change the order of how they get loaded into vim,
because I cycle through all the journals with [Ctrl]+[Space] very reminiscent
of Amiga+N from before the tech dark ages of about 1990 through 2020. Yes, tech
only just became usable (muscle-memory-achievable) again.

So part of my release system is going to be to read this file in and to write
out a new all.sh every time. But my release system is a bash script and I like
to do this sort of stuff from python. So what I really want is the bash script
to run a particular Python script every time.

Now the temptation here is to make the Python script actually something I
maintain in a Jupyter Notebook for the exploratory environment. However, I've
been down this sort of road enough that I know that this sort of thing just
works better in Linux backslash backslash backslash. That's the sound of
Microsoft backslashing us. Okay, so...

Okay, that's done. At the beginning of my release script, I invoke this little
goody:

```python
import shutil
from pathlib import Path
from subprocess import run

ghp = "/mnt/c/Users/mikle/github/"

if Path('all.sh').exists():
    Path('all.sh').unlink()

with open('sites.txt', 'r') as fh:
    with open('all.sh', 'a') as fw:
        fw.write(f"vim ./journal/journal.txt ")

        for i, line in enumerate(fh):
            line = line.rstrip()
            print(i + 1, line)
            fw.write(f" ./{line}/journal.md")

with open('all.sh', 'a') as fw:
    fw.write(f" ~/.vimrc")
    fw.write(f" ./blast.sh")

run(["git", "commit", "-am", "Updated all.sh"], cwd=f"{ghp}/helpers/")
```

And so now whenever I need to do something across all the repos that's easier
in Python than in a bash shell script, I just drop it in make_helpers.py

Woot!


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/activating-all-my-registered-domains/">Activating All My Registered Domains</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/bopping-between-python-bash-scripts-no-biggie/">Bopping Between Python & Bash Scripts No Biggie</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/wordpress/'>WordPress</a></h4></li>
<li><h4><a href='/journal-md/'>Journal.md</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>