---
date: 2022-06-18
title: I'll Just Put This In My /usr/local/sbin/
permalink: /blog/i-ll-just-put-this-in-my-usr-local-sbin/
headline: Discovering a System to Back Up System Customizations and Edit Files Listed in a CSV File at Once
description: I recently changed my journal from .txt to .md to be compatible with my new content management system. I'm excited to have discovered this system which allows me to back up my system customizations with a vim repo, and to edit all files listed in a csv file at once. I'm now sharing this with the world - join me to learn how to work this way and make the most of your system!
keywords: usr/local/sbin/, journal, .txt, .md, content management system, vim repo, csv file, Linux Terminal, git repo, sites.csv, vim buffer, script, system customizations, Microsoft, annual dues, organized, world, sharing
categories: microsoft, script
layout: post
---

And here we go! I just renamed journal.txt to journal.md to keep it consistent
and compatible with my new content management system. This is a huge move for
me. Previously, I couldn't care less about how markdown rendered in my personal
private journal. It was not for sharing. Events of recent times have made it
painfully obvious that almost the entire purpose of this location is to "seed"
content for other locations. You need somewhere to *just begin writing* without
inhibition or particularly committed purpose, but still with the open-endedness
to just copy/paste it over to where it belongs... which just by virtue of doing
that ***POOF!*** It's published. Or at very least, it's organized into another
private Github repo. Not everything maintained with my content management
system need necessarily be published via the Github Pages system. But the same
system that can is identical to one that does not (and keeps it private). The
only difference is the public/private setting in Github and configuration of
Github Pages... brilliant!

Okay, so we pay out annual dues to Microsoft for unlimited private repos. So
what? It's nothing compared to the boon of abilities this yields in one's life.
Plus it keeps all your personal information management skills compatible with
what's necessary for a professional developer. Double-win! And now that I've
adjusted my Linux Terminal prompt to show what git repo ***branch*** is active
(although I'm almost always in main), I can start to take more advantage of git
branches by virtue of it being kept in the front of my mind. Previously
(currently, really), I only use git as a sort of personal unlimited undo
feature. I'm not a professional developer, so I don't really collaborate on
code. All my "code" is personal, or just really journal-writing like this. Git
and vim being so thought-of as developer tools does a disservice to humanity.
It should be incorporated into mainstream education so everyone has these
abilities.

Okay, so where am I going with this? Getting organized, of course. For months
I've had a list of Github Pages sites to assure myself I could get them
published easily and add content to them with vim copy/paste between buffers of
always-loaded files. It worked well. But how much do I really have to update
TicTacUFOSightings.com or TardigradeCircus.com. They're both great ideas, but
their time has not come (or is over). As of yesterday, my content management
system supports site-files in arbitrary location and of arbitrary lengths, so I
could keep all these sites in there and more while only generating out the ones
I need while I'm typing in them. If I'm in my personal journal, I hit the @l
macro (or I may switch it to @g) in order to slice & dice it and output it to
the \_posts directory within. Ugh, am I going to have to neutralize all the
markdown in this file now? Yeah, maybe. Casual project over time. It would have
great utility for even this journal to be sliced & diced as if published.

Hmmm, okay so next steps? Take ~/github/skite/sites.csv and put a copy of it
into ~/github/journal. Rearrange them for the order you want to use them and
add in the private repos that are not part of public Github Page publishing.
I've got a tremendously important letter to write tomorrow. I want to get a
first draft done today. It's about an incident that happened today and I want
to capture all the details (in a longer version) while it's still fresh on my
mind and want to talk about it as the incident that happened yesterday. But
technically it actually happened today, so I can wait until tomorrow (Father's
Day) and still talk about it as yesterday. So I can have a chance to gather my
thoughts and get organized in these other "higher level" ways that has been
long overdue. Okay, so go and copy sites.csv into journal.

Okay, so now I should be able to just :badd sites.csv and have it in my vim
buffer along with this journal. Check! Okay, now add the entries for the other
repos. Interesting! My WorkJournal.zd line works as an example. So I already
had one in there that worked this way and the slice & dice system was already
working on it, so I know I have it working. Of course, the only difference is
whether the Github repos it pushes into are public and Github Pages or not, so
this is just a solid system for managing any journal. Sweet!

```python
#!/home/healus/py310/bin/python

from os import system
import pandas as pd


df = pd.read_csv("~/github/journal/sites.csv", delimiter="|")
df = df.applymap(lambda x: x.strip())
df.columns = [x.strip() for x in df.columns]
alist = df[['path']].values.tolist()
journals = " ".join([f'~/{x[0]}/journal.md' for x in alist])
edit_journals = f"vim {journals}"
system(edit_journals)
```

Sweet. Now I edit ~/github/journal/sites.csv to whatever I like and then just
type "all" from any Linux Terminal, and I'm editing all files listed in csv.

Hmmm, while I'm at it I ought to always be editing my .vimrc and on quitting,
backing it all up to my vim repo, along with my .bash\_profile and
/usr/local/sbin/all file.

```python
#!/home/healus/py310/bin/python

import shlex
import shutil
import pandas as pd
from os import system
from sys import stdout
from subprocess import Popen, PIPE

df = pd.read_csv("~/github/journal/sites.csv", delimiter="|")
df = df.applymap(lambda x: x.strip())
df.columns = [x.strip() for x in df.columns]
alist = df[['path']].values.tolist()
journals = " ".join([f'~/{x[0]}/journal.md' for x in alist])
edit_journals = f"vim {journals} ~/.vimrc"
system(edit_journals)


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


shutil.copyfile("/home/healus/.vimrc", "/home/healus/github/vim/.vimrc")
shutil.copyfile("/home/healus/.bash_profile", "/home/healus/github/vim/.bash_profile")
shutil.copyfile("/usr/local/sbin/all", "/home/healus/github/vim/all")

loc = "/home/healus/github/vim"
git(loc, 'commit -am "Pushing .vimrc to Github..."')
git(loc, "push")

print("Done")
```

The utility of this is pretty amazing. I edit all my files at once whenever I
like, but I keep the list of master files in a visually formatted csv file that
serves other purposes in the content management system. Whenever I quit out of
this vim session, all my system customizations are backed up to vim.

I wish I worked this way since I discovered stuff like this at 18 years old on
the Amiga. Well, I know now. Share it with the world. Okay, done.

## Categories

<ul>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/script/'>Script</a></h4></li></ul>