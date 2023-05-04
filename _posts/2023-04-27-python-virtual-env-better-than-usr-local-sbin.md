---
date: 2023-04-27
title: Python Virtual Env Better Than /usr/local/sbin
headline: "Optimizing my Editing Process with a New `all` Script in NeoVim"
description: "I've improved my process for editing multiple files in NeoVim with an `all` script. This script is now located in the /bin folder of my Python virtual environment, making the system more flexible and allowing me to switch between machines easily. I wrote a new script to help with this process, and I'm now able to pull from my git repos, copy the files to the correct locations, edit them in NeoVim, and push the changes back to my git repos."
keywords: Scripts, All Scripts, Python, Virtual Environment, /bin Folder, Multiple Files, NeoVim, Reverse-Copy, Git Repos, Copy Files, Edit Files, Push Changes
categories: scripts, python, neovim
permalink: /blog/python-virtual-env-better-than-usr-local-sbin/
layout: post
---


My life becomes better if my `all` script were more editable, and in fact was
one of its own files loaded. It then becomes much more meta. Are there other
locations as good as /usr/local/sbin for this sort of thing? First, look at my
environment path variable.

Do an experiment putting a Python script with no .py extension but with the
execute bit set in ~/bin and see if you get the same effect...

```bash
mkdir ~/bin
sudo mv /usr/local/sbin/all ~/bin/
sudo chown ubuntu:ubuntu ~/bin/all
```

Nope, like I thought, that folder had to be made so couldn't possibly be in the
existing path. Look at the path. How again? Oh yeah, printenv!

Well, there's /usr/sbin which sounds promising!

```bash
[py311] ubuntu@LunderVand:~/repos $ cd /usr/sbin
[py311] ubuntu@LunderVand:/usr/sbin $
```

It exists! Woot! And it's in the already existing path. Both very good signs. I
guess I'll be moving startjupyter there too from the drinkme project, but I'll
do that later.

```bash
sudo mv ~/bin/all /usr/sbin/
all
```

Yep, confirmed that works! Okay, make that the permanent new location. It also
couldn't hurt to run drinkme again, maybe even with the .config folder
Windows-side renamed to get that error I saw yesterday when switching machines.

Wow, worth noting that /usr/sbin is full of stuff! Almost certainly from
Debian-like apt installs under Ubuntu. Okay, noted.

Best laid plans, ugh! You still need to sudo to edit files in /usr/sbin even if
it's owned by the non-admin user (sudo chown ubuntu:ubuntu).

Ugh! Compomise a little. Let's try putting it in the bin folder of the Python
virtual environment:

```bash
cp /usr/sbin/all /home/ubuntu/py311/bin/
all
```

Works from there! Now let's make sure I didn't leave any "all" files around.
Okay now let's edit it in that location (which can be abbreviated as
~/py311/bin). 

Okay, so now I have by `all` script in a location that's in my path, and I can
edit it without sudo. The tricky part was making sure that when I edit files
that are outside repos, such as my init.vim and all, that when I switch to a
new machine and run all there, it actually has everything. There's extreme
order-sensitivity on what you copy where when during the process.

But I have it workd out and am very comfortably moving between 2 machines.
And when I do move like that, a system I built for myself for journaling moves
with that. There's a vision developing here. 

Okay, done. And my process is permanently improved moving forward. I have a new
coding style developing that makes heavy use of Figlet ASCII art.

The valuable ability I find from putting things in /usr/local/sbin of being
able to run a Python script from anywhere without having to specify the
location is preserved. I can run `all` from anywhere, and it will ensure all my
regularly edited files are loaded into buffers.

One of those buffers now contains the `all` script itself, which I was not able
to do while it was in the old location that offered that advantage. In looking
for a new location (early in the console "path" environment variable), I
discovered that the /bin folder of the Python virtual environment is in the
path, and there was no downside to putting it there.

The upside of making it one of the very files its loading to edit makes the
whole system come alive and be subject to rapid refinement and improvement, and
indeed a more flexible life because the files that are pre-loaded for editing
are sort of a snapshot of what's going on in your life. 

Wheras I was hesitant to edit the `all` script when it was in the old location,
I'm not hesitant to edit it now. And so now I'm in a more flexible state of
what the "text files of my life" are.

And the final nuance I worked out is how to make this work well when switching
around to different machines. I have to make sure I copy the right files to the
right places at the right times. For example, I do a git pull on all my repos
before I begin editing in case I've made edits from another machine. However,
some of the files live outside of repos, such as my init.vim and my `all`, and
for those to be in sync, I have to copy them out of the repos and into location
before loading them into NeoVim to edit. So there's a copy-files and a
reverse-copy function. The reverse-copy runs immeidately after the git pull.

Here's the new code for the new `all` script:

```python
#! /usr/bin/env python
#        _             _ _           _ _
# __   _(_)_ __ ___   (_) |_    __ _| | |   Why edit 1 file when you can
# \ \ / / | '_ ` _ \  | | __|  / _` | | |   edit everything all at once?
#  \ V /| | | | | | | | | |_  | (_| | | |   Why mess with tabs when you can
#   \_/ |_|_| |_| |_| |_|\__|  \__,_|_|_|   :bn into buffers?


import shlex
import shutil
from os import system
from os import getuid
from sys import stdout
from time import sleep
from pwd import getpwuid
from pyfiglet import Figlet
from subprocess import Popen, PIPE


# Get Linux Username for portability between systems
USERNAME = getpwuid(getuid())[0]
GIT_EXE = "/usr/bin/git"
REPOS = f"/home/{USERNAME}/repos/"
HIDE = f"{REPOS}hide/"

# Files to edit
edit_files = [
    f"{HIDE}MikeLev.in/journal.md",
    f"{HIDE}journal/journal.txt",
    "~/.config/nvim/init.vim",
    "~/py311/bin/all",
    f"{REPOS}skite/chopchop.py",
]

# Places to put files after editing
copy_to_destination = {
    "/home/ubuntu/py311/bin/all": f"{REPOS}vim/all",
    "/home/ubuntu/.config/nvim/init.vim": f"{REPOS}vim/init.vim",
}

# Repos to push after editing
git_repos = [
    f"{REPOS}vim",
    f"{REPOS}skite",
    f"{HIDE}journal",
    f"{HIDE}MikeLev.in",
]


# Load function early so we can use it, pronto!
def fig(text, description=None, font="standard"):
    #  _____ _       _      _
    # |  ___(_) __ _| | ___| |_
    # | |_  | |/ _` | |/ _ \ __|
    # |  _| | | (_| | |  __/ |_
    # |_|   |_|\__, |_|\___|\__|
    #          |___/
    """Let them see text!"""
    f = Figlet(font=font)
    print(f.renderText(text))
    if description:
        print(description)
    sleep(0.5)


def flush(std):
    """Flush a stream."""
    for line in std:
        line = line.strip()
        if line:
            print(line)
            stdout.flush()


def git(cwd, line_command):
    """Run a Linux git command."""
    cmd = [GIT_EXE] + shlex.split(line_command)
    show_cmd = " ".join(cmd)
    print(f"Running: {show_cmd}")
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


def git_pull():
    for arepo in git_repos:
        fig(f"{arepo.split('/')[-1]}", font="cybermedium")
        git(arepo, "pull")
        print()


def load_editor():
    print("Loading editor...")
    files = " ".join(edit_files)
    command = f"nvim {files}"
    system(command)


def git_push():
    print("Hit")
    for repo in git_repos:
        fig(f"{repo.split('/')[-1]}", font="cybermedium")
        print(f"Pushing {repo} to Github...")
        git(repo, "commit -am 'pushing to github...'")
        git(repo, "push")
        print()


def copy_files():
    for source, destination in copy_to_destination.items():
        print(f"Copying {source} to {destination}")
        shutil.copyfile(source, destination)


def reverse_copy():
    for destination, source in copy_to_destination.items():
        print(f"Copying {source} to {destination}")
        shutil.copyfile(source, destination)


fig("vim it all...", "Loading data into multiple vim buffers\n")

# Main Control Flow
git_pull()
reverse_copy()
load_editor()
copy_files()
git_push()
```


<div class="post-nav"><div class="post-nav-next"><a href="/blog/adding-an-advice-from-openai-field-to-my-journal">Adding an Advice From OpenAI Field to my Journal</a><span class="arrow">&nbsp;&rarr;</span></div> &nbsp; <div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/indomitable-spirit">Indomitable Spirit</a></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/neovim/'>NeoVim</a></h4></li></ul>