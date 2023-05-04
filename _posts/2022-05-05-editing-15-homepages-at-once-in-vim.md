---
date: 2022-05-05
title: Editing 15 Homepages at Once in vim
headline: Editing 15 Homepages Simultaneously with vim - A Step-by-Step Guide
description: I'm editing 15 homepages at once using vim, creating necessary files and folders, and writing a configuration file for a Jekyll website. This configuration file includes a list of plugins, a theme name, an author, a permalink, a Google Analytics ID, a title, a description, and an apex - all saved in the apex directory of the website. Come read my blog post to learn more!
keywords: Vim, Homepages, Files, Folders, Configuration, Jekyll, Plugins, Theme, Permalink, Google Analytics, Title, Description, Apex, all.sh, hps.sh, default.html, _config.yml
categories: homepages, jekyll, google analytics, vim
permalink: /blog/editing-15-homepages-at-once-in-vim/
layout: post
---


Let's edit 15 homepages at once! So I start out with the file that
creates my all.sh file that lets me edit 15 journal.md files at once (which
gets sliced & diced into these blogs using pip install blogslicer)...

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

# DELETE OLD HELPERS BECAUSE APPEND
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
                # print(afullpath)
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

And here's the revised one that outputs a hps.sh that will load the 15 sites
into vim. Easy peasy! So I ought to do something with this newfound ability.

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

# DELETE OLD HELPERS BECAUSE APPEND
for helper in ['all.sh', 'hps.sh']:
    if Path(helper).exists():
        Path(helper).unlink()

with open('sites.txt', 'r') as fh:
    with open('hps.sh', 'a') as fw:
        fw.write(f"vim")
        for i, site in enumerate(fh):
            fw.write(f" ./{site.rstrip()}/index.md")

with open('sites.txt', 'r') as fh:
    with open('all.sh', 'a') as fw:
        fw.write(f"vim ./journal/journal.txt")

        for i, site in enumerate(fh):
            site = site.rstrip()
            print(i + 1, site)
            fw.write(f" ./{site}/journal.md")

            # Ensure existence of each Jekyll folder
            for afolder in ensure_folders:
                afullpath = f'{ghp}{site}/{afolder}'
                # print(afullpath)
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


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/editing-15-homepages-at-once-in-vim">Editing 15 Homepages at Once in vim</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-dangers-of-being-predisposed-why-apple-won">The Dangers of Being Predisposed (Why Apple Won)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/google-analytics/'>Google Analytics</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li></ul>