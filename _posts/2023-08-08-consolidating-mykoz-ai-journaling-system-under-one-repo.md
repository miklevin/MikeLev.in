---
date: 2023-08-08
title: Consolidating MyKoz.AI Journaling System Under One Repo
headline: "Journaling MyKoz.AI: Consolidating All Repos Under One Roof"
description: "This post is about consolidating the MyKoz.AI journaling system under one repository. I discuss the need to update the `.bash_profile` to include `sudo hwclock -s`, the need to create a `README.txt` file, and the decision to use one repo with the folders Intro, Journal, Practice, and Service. This is the preparatory work before MyKoz.AI can really be soft-launched. These repo's and particularly the Journaling system need to be in-place."
keywords: MyKoz.AI, Journaling, System, Repo, Bash_profile, WSL2, Linux, Clock, Terminals, Windows, Host, Sleep, ToDo, README, JypyterLab, F5, Intro, Whim, Repos, Initial Caps, Python, Packaging, Convention, Nbdev, Practice, Service, Alphabetize, Directory, YAMLChop, Pipulate, Levinux, Publish, Generic, Boot,
categories: wsl, publish, levinux, linux, pipulate, microsoft, nbdev, journaling, python
permalink: /blog/consolidating-mykoz-ai-journaling-system-under-one-repo/
layout: post
group: blog
---


Okay, I had to update the `.bash_profile` to include `sudo hwclock -s` because
***still*** WSL2 doesn't keep the Linux clock in Terminals in sync the clock
with the Windows host. It has something to do with your laptop going to sleep.
And just closing the Terminal and re-opening isn't enough.

Okay, this is just going to be a quick ticking off of items from the MyKoz.AI
ToDo list. I'm going to start with the "README.txt" file. I already create it
and plop it on the desktop. 

Okay, the README.txt is updated and the JypyterLab icon no longer needs an F5
after the install to appear. 

Now let me get the Intro and Whim repos in place. Should I use the initial caps
in the repo names? Its not Python packaging convention, which I eventually want
to be moving towards, especially using nbdev. But it looks so much better in
documentation with initial caps. 

Hmmm. Haven't I made up enough words? If I'm going to install an Intro folder,
why not just call everything what it is?

- Intro
- Practice
- Service

Those will alphabetize nicely, in the correct order that I would want people to
experience them. That means if it's pulling from my own GitHub, I'll have to
rename my old practice repo. Maybe not with the upper and lower case
differentiation. Oh, don't forget journaling!

- Intro
- Journal
- Practice
- Service

Hmmm. Could I keep it nice and pristine like that? Can I even avoid a directory
with the mysterious and perhaps intimidating name YAMLChop? Yes, that can live
directly in the Journal folder, giving the journal the ability to optionally
publish itself. Wow! That's a big deal. I can't believe I didn't think of that
before. Make it all generic under the one name, MyKoz.AI. 

It's going to be hard enough to get MyKoz.AI across, I don't need a Pipulate,
Levinux, YAMLChop and the like. Even Pipulate may be phased out as something
you just pip install. I can "boot" that project from scratch and not have it
part of the initial install. Then I can make "Creating Pipulate" a part of the
Intro. I could cover nbdev and everything on a more advanced track.

Yes, this is a good plan. Let's get those Repos in location with all due
haste... 

Okay so Upper and lowercase are the same for Github repos. I can't have a
Journal and a journal repo. Also, I want to keep the "all" program identical
for everyone, giving them the same experience more or less as what I'm getting.
So there needs to be a way to fork off a custom all. Maybe another word. I'm
tempted to use "go" but that's so heavily used in tech. Maybe "start" or
"begin". I could also go with vimit. That's a good one. Like vimtutor, but
vimit. It also suggests as vim-it-all, like "go for it" or damn it all.

Yes, vimit it what I'll use for the main public facing program. Think it
through a bit. What is the magic behind `all` and the soon-to-be `vimit`? 

It's always found when you type it because it's located in the `~/pyenv/bin`
folder, which means it's isolated into a Python virtual environment. That's
very powerful because we're piggybacking off everything the formidable
virtualenv program. I previously tried using the default venv Python standard
library model. They are more-or-less equivalent and API-compatible, but the one
being included standard in Python is in flux on installer. I'm going to use a
non-moving target until the venv story stabilizes.

Okay, so clearly the "Journal" repo is going to be an important one because it
will hold the journal.md that I'll try to get people vim-journaling with, the
transposed YAMLChop/chop.py program, and the `all` program (when it's not
living in ~/pyenv/bin). Much will be centered around it. So first a renaming of
what's already there to avoid file collision. And I make the corresponding
updates in both ~/pyenv/bin and ~/repos/vim where I'm currently keeping it. Now
I just quit out of here and rename folders and see if I can run all again.

Okay amazingly that worked just fine. But it doesn't change the git repo remote
URL. For that, we need `git remote set-url origin`. Okay, I set a new origin
and renamed it on Github. Now another quit and reload.

Okay, it worked. Excellent. Everything's going to follow the same pattern.
`vimit` script, so I might as well create that now.

```
cd ~/repos
mkdir Journal
cd Journal
cp ~/pyenv/bin/all vimit
```

Hmmm. No, that space is going to be `Jekyll` space, meaning the static site
generator system will kick in and try to process any files there, and that's a
no-no location for Python. So let's make a subfolder named `_python` and put
the `vimit` script there. Okay, done. Also I'm putting the `chop.py` file from
the YAMLChop repo there. This is getting good. I like the self-contained
approach. Okay, now let's put a blank template `journal.md` in the Jekyll
`_drafts` location... Hmmm. No, I want that `_python` location to be `_code`
because already I have an `init.vim` from NeoVim that I want in there.

Alright. Given what I'm doing with `vim.init`, there's a very good chance I'm
breaking the local instance of this thing. But that's no big deal. It will
force me on how to make my local instance stay separate from the global. I may
even retire the YAMLChop repo and just make everything work out of the Journal
repo. That's a good idea. I'll do that. 





<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/bram-moolenaar-s-death-is-a-kick-in-the-pants-for-mykoz-ai-project/">Bram Moolenaar's Death is a Kick in the Pants for MyKoz.AI Project</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/be-mickey-don-t-be-the-brooms-losing-jobs-to-ai/">Be Mickey. Don't Be The Brooms (Losing Jobs to AI)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/publish/'>Publish</a></h4></li>
<li><h4><a href='/levinux/'>Levinux</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>