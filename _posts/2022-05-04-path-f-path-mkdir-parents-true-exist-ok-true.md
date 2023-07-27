---
date: 2022-05-04
title: Path(f'{\_path}').mkdir(parents=True, exist_ok=True)
headline: "Creating a Release Process: Building a Blog Publishing System with Python and Bash"
description: I'm up early, focused on operation ELTgd, and have been able to put my new blog publishing system to use. I've written scripts in Python and Bash to create directories and config files, and to commit the changes to git. I'm now editing 19 files in vim to make sure a bunch of folders exist on all 15 sites. Join me as I detail my release process and the steps I take to ensure everything runs smoothly.
keywords: ELTgd, Operation, Blog Publishing, Python, Bash, Directories, Config Files, Git, Vim, Jekyll, _config.yml, Path Library, Bash Scripting
categories: vim, git, linux, jekyll, python
permalink: /blog/path-f-path-mkdir-parents-true-exist-ok-true/
layout: post
group: blog
---


It's 7:00 AM. Focus on operation ELTgd... Felt good. Every Little Thing gets
done, and it feels good. Had such a wonderful time chatting with Adi last
night. I was able to put my new blog publishing system to use right away. They
were very receptive to me publishing my art-work online. I have memories of
what a big deal it was for me when I was about their age to have my art put
into a children's art gallery. One thing even sold. Adi's stuff is far better
at their age than mine was at my age. So it's right that I start to give her a
similar experience, but for the new world. Maybe I'll get them into NFTs, haha!

Okay, so I can add graphics to my blog posts very easily now. But there's still
a lot of bopping around to different folders and terminals to copy files, git
commit and such. I want to be able to just drop a keyworded file into location,
make the journal entry match, then run my release script. I tried last night
when I was losing steam and broke the script so try again this morning with a
fresh mind. 1, 2, 3... 1?

The key thing missing is to regularly make sure a bunch of folders exist on all
of the 15 sites. If the folders already exist, no problem. Don't do anything.
But if they don't, make them.

I now have the choice of doing any of these things in either Python or bash
scripts. This sort of thing is best accomplished (for me, at least) in Python.
The wedged-in Python script runs early in the main bash release script
(blast.sh), so that's good. Anything the blast script looks for can be set-up
by the Python script (make_helpers.sh). So get to it!

I edit both of these files right here in vim where I do my journaling. If I do
the :ls command in vim, here's what I see:

    :ls
      1 #    "./journal/journal.txt"        line 43
      2 %a   "./MikeLevinSEO.com/journal.md" line 38
      3      "./MikeAtEleven.com/journal.md" line 0
      4      "./LinuxPythonvimgit.com/journal.md" line 0
      5      "./PythonicAlly.com/journal.md" line 0
      6      "./MikeLev.in/journal.md"      line 0
      7      "./TardigradeCircus.com/journal.md" line 0
      8      "./RemovableFinger.com/journal.md" line 0
      9      "./Mike-Levin.com/journal.md"  line 0
     10      "./LunderVand.com/journal.md"  line 0
     11      "./WhatsaMetaFor.io/journal.md" line 0
     12      "./GuerillaTech.com/journal.md" line 0
     13      "./TicTacUFOSightings.com/journal.md" line 0
     14      "./PythonicAlly.org/journal.md" line 0
     15      "./Pipulate.com/journal.md"    line 0
     16      "./Levinux.com/journal.md"     line 0
     17      "~/.vimrc"                     line 0
     18      "./helpers/make_helpers.py"    line 0
     19      "./blast.sh"                   line 0

Nice, huh? I'm up to 19 files that I edit at the same time, regularly. For
anyone following this (yeah, right) if it's not totally apparent, the vim
command I use to get to the last file is also the name of the last file, which
is also the concept of what the last file does when run (blasts out a release).
All very meta, which in itself helps compel me to use the system merely by
virtue of being such a strong mental framework.

And beyond the journal-file of each site, which get sliced & diced into the
individual blog pages, there are the 3 files which are really the center of my
life and work-flow. Line 18 & 19 are the release system, each of which really
do have a number of other sub-scripts such as blogslicer which I've documented
a lot. I keep blogslicer loaded as a Jupyter Notebook which gets converted into
a PyPI-release-ready package every time I run my release script, though I don't
push a rev to PyPI every time. I feel that'd be rude.

Okay, so enough rambling. Here's make_helpers.py before:

```python
import shutil
from pathlib import Path
from subprocess import run

# SET ROOT OF RELEASE SYSTEM
ghp = "/mnt/c/Users/mikle/github/"

# CLEAN OUT OLD SLICED FILES
if Path('all.sh').exists():
    Path('all.sh').unlink()

with open('sites.txt', 'r') as fh:
    with open('all.sh', 'a') as fw:
        fw.write(f"vim ./journal/journal.txt ")

        for i, line in enumerate(fh):
            line = line.rstrip()
            print(i + 1, line)
            fw.write(f" ./{line}/journal.md")

            # Optional do-once items
            shutil.copy(f'{ghp}helpers/templates/default.html', f'{ghp}{line}/_layouts/default.html')

with open('all.sh', 'a') as fw:
    fw.write(f" ~/.vimrc")
    fw.write(f" ./helpers/make_helpers.py")
    fw.write(f" ./blast.sh")

run(["git", "commit", "-am", "Updated all.sh"], cwd=f"{ghp}/helpers/")

with open('gaids.txt') as fh:
    for line in fh:
        if line:
            gaids = line.rstrip().split()
            code = gaids[0]
            apex = gaids[1]
            title = ' '.join(gaids[2:])
            title = f'{title} | {gaids[1]}'
            aconfig = f'''plugins:
  - jekyll-feed
theme: jekyll-theme-hacker
author: Mike Levin
permalink: /:slug/
gaid: {code}
title: {title}
description: Welcome to {title}
apex: {apex}'''
            print(aconfig)
            print()
            with open(f'../{apex}/_config.yml', 'w') as fw:
                fw.write(aconfig)
```

Okay, so the key thing is to make sure that the existence of all the folders
needed for Jekyll exist. We do that with pathlib.Path().mkdir(exist_ok=True)

The whole Jekyll directory structure is:

[Jekyll Directory Structure](https://jekyllrb.com/docs/structure/)

    .
    ├── _config.yml
    ├── _data
    │   └── members.yml
    ├── _drafts
    │   ├── begin-with-the-crazy-ideas.md
    │   └── on-simplicity-in-technology.md
    ├── _includes
    │   ├── footer.html
    │   └── header.html
    ├── _layouts
    │   ├── default.html
    │   └── post.html
    ├── _posts
    │   ├── 2007-10-29-why-every-programmer-should-play-nethack.md
    │   └── 2009-04-26-barcamp-boston-4-roundup.md
    ├── _sass
    │   ├── _base.scss
    │   └── _layout.scss
    ├── _site
    ├── .jekyll-cache
    │   └── Jekyll
    │       └── Cache
    │           └── [...]
    ├── .jekyll-metadata
    └── index.html # can also be an 'index.md' with valid front matter

Okay, that's such a good starting point. Isolate the folders:

    _config.yml
    _data
    _includes
    _layouts
    _posts
    _sass
    assets/css
    assets/images

Yeah, easy enough. So here's the revised make_helpers.py script:

```python
import shutil
from pathlib import Path
from subprocess import run

# SET ROOT OF RELEASE SYSTEM
ghp = "/mnt/c/Users/mikle/github/"

# FOLDERS WHICH MUST EXIST PER SITE
ensure_folders = '''_data
\includes
\layouts
\posts
\sass
assets/css
assets/images'''.split('\n')

# CLEAN OUT OLD SLICED FILES
if Path('all.sh').exists():
    Path('all.sh').unlink()

with open('sites.txt', 'r') as fh:
    with open('all.sh', 'a') as fw:
        fw.write(f"vim ./journal/journal.txt ")

        for i, site in enumerate(fh):
            site = site.rstrip()
            print(i + 1, site)
            fw.write(f" ./{site}/journal.md")

            # Ensure existence of each Jekyll folder
            for afolder in ensure_folders:
                afullpath = f'{ghp}{site}/{afolder}'
                print(afullpath)
                Path(f'{afullpath}').mkdir(parents=True, exist_ok=True)

            # Optional do-once items
            shutil.copy(f'{ghp}helpers/templates/default.html', f'{ghp}{site}/_layouts/default.html')

with open('all.sh', 'a') as fw:
    fw.write(f" ~/.vimrc")
    fw.write(f" ./helpers/make_helpers.py")
    fw.write(f" ./blast.sh")

run(["git", "commit", "-am", "Updated all.sh"], cwd=f"{ghp}/helpers/")

with open('gaids.txt') as fh:
    for site in fh:
        if site:
            gaids = site.rstrip().split()
            code = gaids[0]
            apex = gaids[1]
            title = ' '.join(gaids[2:])
            title = f'{title} | {gaids[1]}'
            aconfig = f'''plugins:
  - jekyll-feed
theme: jekyll-theme-hacker
author: Mike Levin
permalink: /:slug/
gaid: {code}
title: {title}
description: Welcome to {title}
apex: {apex}'''
            print(aconfig)
            print()
            with open(f'../{apex}/_config.yml', 'w') as fw:
                fw.write(aconfig)
```

I wish I could highlight the changes from before to after, but that's not one
of Jekyll's default abilities yet. I'll look into plugins, but there's a
limited set available on the Github Pages instance (like the RSS one I'm
using).

I'm tempting to git add the contents of each folder in this script, but it runs
so early in the release process it won't do any good. I may add a Python
post-processing step to my release, but that sort of thing is easily enough
accomplished in bash. I move stuff like directory creation here because of
commands like this:

```python
Path(f'{afullpath}').mkdir(parents=True, exist_ok=True)
```

...which are really so powerful. The amount of cryptic bash scripting that
parents=True and exist_ok=True spares you from is greatly appreciated.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/vim-b1-commands-much-force-like-obi-wan/">vim :b1 Commands Much Force Like Obi-Wan</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/path-f-path-mkdir-parents-true-exist-ok-true/">Path(f'{\_path}').mkdir(parents=True, exist_ok=True)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>