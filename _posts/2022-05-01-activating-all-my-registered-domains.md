---
date: 2022-05-01
title: Activating All My Registered Domains
headline: Organizing My Domains with Scripts and Google Analytics
description: I have taken the initiative to activate all of my registered domains, creating scripts to help me organize them. I have created a sites.txt file, an edit.sh file, and have gone to Google Analytics to get new GA-4 codes. I have also moved content from one website to another, and made mikelevinseo.com its own site. Read this blog post to learn how I organized my domains and content!
keywords: Domains, Scripts, sites.txt, edit.sh, Google Analytics, GA-4 codes, Website, Folders, Journals, Jupyter Notebook, .py file, Git, List, Repos, Content, mikelevinseo.com, PythonicAlly.com
categories: google, git, python, jupyter
permalink: /blog/activating-all-my-registered-domains/
layout: post
group: blog
---


I like the whole ELTgd approach. Every Last Thing gets done. I need to get more
done, but the biggest thing I have to offer the world... I guess make that the
SECOND biggest thing I have to offer the world, but the biggest thing I SHOULD
offer the world while I'm alive is this Linux, Python, vim & git transition.

I think I'm making a mistake not putting all this SEO Jekyll stuff on
mikelevinseo.com. That domain has been around forever, even though I lost it
once and got it back just like mike-levin.com. I think what I need to do is to
start renaming my repos to be the exact domain name with the preferred
UpperLowercase setting and their dot-extensions.

Do it! Document it here. You can always copy this entry to another blog. 1, 2,
3... 1? List 'em and work them like a checklist.

Okay, I'm actually going to pump this up to 15 sites, pretty much all that I
have registered.

- MikeLev.in
- MikeLevinSEO.com
- PythonicAlly.com
- LinuxPythonvimgit.com
- MikeAtEleven.com
- TardigradeCircus.com
- RemovableFinger.com
- Mike-Levin.com
- LunderVand.com
- WhatsaMetaFor.io
- GuerillaTech.com
- TicTacUFOSightings.com
- PythonicAlly.org
- Pipulate.com
- Levinux.com

Hmmm. I'm making the decision to put all the domains I have registered into
play. And so I need to bring some sanity to the process. I need scripts to help
me sort things. Okay, so let's do it. Make a sites.txt in your helper folder.
Iterate through it with Python to see what folders (and probably repos) I need
to make exist:

```python
from pathlib import Path

with open('sites.txt') as fh:
    for site in fh:
        site = site.rstrip()
        if Path(f"../{site}").is_dir():
            print(True, site)
        else:
            print(False, site)
```

Okay, not a bad start. Now make a file so that I can edit all their
journal.md's at the same time:

```python
from pathlib import Path
import shutil

if Path('edit.sh').exists():
    Path('edit.sh').unlink()

with open('sites.txt', 'r') as fh:
    with open('edit.sh', 'a') as fw:
        fw.write(f"vim ./journal/journal.txt ")

        for site in fh:
            site = site.rstrip()
            fw.write(f"./{site}/journal.md ")

            # If the folder doesn't exist, create it.
            if Path(f"../{site}").is_dir():
                print(True, site)
            else:
                print(False, site)
                Path(f"../{site}").mkdir()

            # If the journal doesn't exist, copy template into location.
            if Path(f"../{site}/journal.md").exists():
                print(True)
            else:
                print(False)
                shutil.copy('journal.md', f"../{site}/")
            print()
shutil.copy('edit.sh', f"../")
```

Okay, that's awesome. I want to be able to start the editing session from
within my github folder and not within a particular repo. I feel the itch to
commit and push THIS journal entry, but I just put things into a broken state.
Oops, this is going to get ugly. Make it easier to read.

```python
from pathlib import Path
import shutil

if Path('edit.sh').exists():
    Path('edit.sh').unlink()

with open('sites.txt', 'r') as fh:
    with open('edit.sh', 'a') as fw:
        fw.write(f"vim ./journal/journal.txt ")

        for site in fh:
            site = site.rstrip()
            fw.write(f"./{site}/journal.md ")

            # If the folder doesn't exist, create it.
            folder_exists = Path(f"../{site}").is_dir()
            print(folder_exists, "Folder", site)
            if not folder_exists:
                Path(f"../{site}").mkdir()

            # If the journal doesn't exist, copy template into location.
            journal_exists = Path(f"../{site}/journal.md").exists()
            print(journal_exists, 'Journal')
            if not journal_exists:
                shutil.copy('journal.md', f"../{site}/")

            print()
shutil.copy('edit.sh', f"../")
```

Okay, good start. Now make sure they're all git repos. This script doesn't do
everything. Implied here are visits over to Github.com when it's not yet
maintained there, and the tying together of new remote to local repos.

It's also important to note that I had to move this script from a Jupyter
Notebook to a .py file because of git issues. Git just isn't as robust on
Windows. Or perhaps it's that file-paths are just easer in a Unix/Linux
environment. Either way, it works under WSL.

```python
if Path('edit.sh').exists():
    Path('edit.sh').unlink()

with open('sites.txt', 'r') as fh:
    with open('edit.sh', 'a') as fw:
        fw.write(f"vim ./journal/journal.txt ")

        for site in fh:
            site = site.rstrip()
            url = f"https://{site.lower()}"
            print(url)
            fw.write(f"./{site}/journal.md ")

            # If the folder doesn't exist, create it.
            folder_exists = Path(f"../{site}").is_dir()
            print(folder_exists, "Folder", site)
            if not folder_exists:
                Path(f"../{site}").mkdir()

            # If the journal doesn't exist, copy template into location.
            journal_exists = Path(f"../{site}/journal.md").exists()
            print(journal_exists, 'Journal')
            if not journal_exists:
                shutil.copy('journal.md', f"../{site}/")

            # If the journal doesn't exist, copy template into location.
            is_repo = Path(f"../{site}/.git").is_dir()
            print(is_repo, 'git repo')
            if not is_repo:
                run(["git", "init"], cwd=f"../{site}/")
                run(["pwd"], cwd=f"../{site}/")
                run(["git", "add", "journal.md"], cwd=f"../{site}/")
                run(["git", "commit", "-am", "Added Journal"], cwd=f"../{site}/")
                # run(["git", "push"], cwd=f"../{site}/")

            print()
shutil.copy('edit.sh', f"../")
```

I still like working in Notebooks more than vim for this sort of "feeling stuff
out" work.

Okay, so work out any issues on each of these sites and get a new easier to
maintain release system going.

No reason to document all the variations I'm doing to get the \_layouts,
\_includes, \_config.yml file, favicon and other things in place. It's just
tedious script variations and I'm not making it into one big clean run-once
sort of thing, so anyone here will just have to adapt the above samples to your
situation. You get the idea.

Okay, I despereately want to externalize the Google Analytics code in the
default.html files but I have 2 more to do the old way (copy/paste default.html
and paste new GA code in there) before I parameterize or liquify or whatever
it. So off to GA to get new GA code for the new sites.

Okay, I have the new GA-4 code for every site including the new
PythonicAlly.org site.

Now it's time to make mikelevinseo.com its own site and to cut over all the
stuff I've been loading in PythonicAlly.com that is much too in-depth for so
early in that site.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/from-jupyter-notebook-to-pip-installable-package-in-one-go/">From Jupyter Notebook to pip Installable Package In One Go</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/bash-script-loading-external-files/">Bash Script Loading External Files</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>