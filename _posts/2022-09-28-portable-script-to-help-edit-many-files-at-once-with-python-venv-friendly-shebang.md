---
date: 2022-09-28
title: Portable Script to Help Edit Many Files at Once with Python venv-friendly shebang!
headline: "Making Editing Easier: Using Python venv-friendly Shebang & ASCII Art to Edit Multiple Files Across Any Machine"
description: I'm making my program easier to use for editing all my journals across any machine. I'm using Python venv-friendly shebang to ensure portability and adding ASCII art to keep me informed. I'm going through the process of editing, pulling, editing, and pushing the repos. Come find out how I'm doing it!
keywords: Python, venv-friendly, shebang, ASCII art, editing, pulling, repos, portability, git, commit, push, journals
categories: python, git
permalink: /blog/portable-script-to-help-edit-many-files-at-once-with-python-venv-friendly-shebang/
layout: post
---


I'm updating my /usr/local/sbin/all program which lets me edit all my journals
at once. Since I've been taking to working on more than my main machine, I've
decided to make it much easier to edit all my journals at once on any machine.
Normally it's quite a pain to make sure I'm keeping all my laptops in sync with
git repositories. I've experimented a lot with a NAS for these purposes lately,
but the NAS turned out to be too slow for many some purposes. And so having the
actual physical files (the repos) on the very machine you're editing from is a
better experience. And since I'm already using a program to load all the files
at once, it's the perfect opportunity to do a git pull of all of them first and
when done, doing a git commit and push. Here's the updated script. Even the
shebang is updated for portability.

```python
#! /usr/bin/env python3.10

import shlex
import shutil
import argparse
import pandas as pd
from os import system
from os import getuid
from sys import stdout
from art import text2art
from pwd import getpwuid
from subprocess import Popen, PIPE

# Set Default Number of Files to Edit
default_number = 3

# Get Linux Username for portability between systems
username = getpwuid(getuid())[0]

# Use big pretty ascii art to keep user informed
fig = lambda x: print(text2art(x))
fig("Editing Journals")

# Determine how many journals to edit at once
aparser = argparse.ArgumentParser()
add_arg = aparser.add_argument
add_arg("-n", "--number", required=False)
args = aparser.parse_args()
number = args.number
df = pd.read_csv("~/repos/journal/sites.csv", delimiter="|")
df = df.applymap(lambda x: x.strip())
df.columns = [x.strip() for x in df.columns]
if number == None:
    df = df.head(default_number)
elif number.isnumeric():
    number = int(number)
    if number > df.shape[0]:
        number = df.shape[0]
    df = df.head(number)
    print('hit')


def flush(std):
    for line in std:
        line = line.strip()
        if line:
            print(line)
            stdout.flush()


def git(cwd, args):
    cmd = ["/usr/bin/git"] + shlex.split(args)
    print(f"COMMAND: << {shlex.join(cmd)} >>")
    process = Popen(
        args=cmd,
        cwd=cwd,
        stdout=PIPE,
        stderr=PIPE,
        shell=False,
        bufsize=1,
        universal_newlines=True,
    )
    flush(process.stdout)
    flush(process.stderr)


alist = df[['path']].values.tolist()
journals = " ".join([f'~/{x[0]}/journal.md' for x in alist])

fig("Pulling Repos")

print("vim")
loc = f"/home/{username}/repos/vim"
git(loc, "pull")

for item in alist:
    repo = item[0]
    print(repo)
    loc = f"/home/{username}/{repo}"
    git(loc, 'pull')
    print()

edit_journals = f"vim {journals} ~/.vimrc"
system(edit_journals)

shutil.copyfile(f"/home/{username}/.screenrc", f"/home/{username}/repos/vim/.screenrc")
shutil.copyfile(f"/home/{username}/.gitconfig", f"/home/{username}/repos/vim/.gitconfig")
shutil.copyfile(f"/home/{username}/.bash_prompt", f"/home/{username}/repos/vim/.bash_prompt")
shutil.copyfile(f"/home/{username}/.bash_profile", f"/home/{username}/repos/vim/.bash_profile")
shutil.copyfile(f"/usr/local/sbin/all", f"/home/{username}/repos/vim/all")

fig("Pushing Repos")

print("vim")
loc = f"/home/{username}/repos/vim"
git(loc, 'commit -am "Pushing vim to Github..."')
git(loc, "push")
print()

for item in alist:
    repo = item[0]
    print(repo)
    loc = f"/home/{username}/{repo}"
    git(loc, f'commit -am "Pushing {repo} to Github..."')
    git(loc, "push")
    print()

fig("Done!")
```


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/start-documenting-my-best-tricks-on-this-site">Start Documenting My Best Tricks On This Site</a></div><div class="post-nav-next"><a href="/blog/serp-scraping-with-site-search-modifier-and-custom-date-range">SERP Scraping with site Search Modifier and Custom Date Range</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li></ul>