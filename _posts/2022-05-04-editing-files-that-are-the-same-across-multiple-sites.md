---
date: 2022-05-04
title: Editing Files That Are The Same Across Multiple Sites
headline: Just Finished My Work Day and Taking Extra Time to Update Blogging System
description: After a long work day, I'm taking extra time to make sure my blogging system is up-to-date. I'm creating a list of common files to edit, as well as a list of files that need to be copied for each release. I'm also setting up an 'includes' directory and adjusting the release code to make sure everything is pushed properly. Ready to get your blogging system up-to-date? Read on to find out how!
keywords: Editing, Files, Multiple Sites, Work Day, Blogging System, List, Common Files, Edit, Copy, Release, Includes, Directory, Adjust, Push
categories: 
permalink: /blog/editing-files-that-are-the-same-across-multiple-sites/
layout: post
---


Okay, the work day is over. Let's get a little more done on the blogging
system. The main thing wrong is the inability to edit everything common to all
sites at once and having them automatically pushed on the release. List all the
common stuff:

    _config.yml
    default.html
    favicon.ico
    index.md
    journal.md
    post.html
    style.scss
    youtubePlayer.html

Okay, \_config.yml doesn't apply anymore and I'm going to want to customize
favicon.ico for each site (first thing?). So which get copied every time? Oh,
these do:

    default.html
    post.html
    style.scss
    youtubePlayer.html

Okay, get freer with creating includes, so make an includes directory, put the
youtubePlayer.htm in here and adjust the release code to push everything from
there into each site's Jekyll \_include folder. Done.

```bash
# PUBLISH SITES
figlet Publish Sites... -t
filename='./helpers/sites.txt'
n=1
while read line; do
    figlet $line -t
    cd $line
    cp ../helpers/templates/includes/* _includes/
    cp ../helpers/templates/style.scss assets/css/
    cp ../helpers/templates/default.html _layouts/
    cp ../helpers/templates/post.html _layouts/
    git add --all
    git commit -am "Updating all"
    git push
    cd ..
    n=$((n+1))
done < $filename
```
<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="editing-files-that-are-the-same-across-multiple-sites">Editing Files That Are The Same Across Multiple Sites</a></div><div class="post-nav-next"><a href="a-new-way-to-visualize-general-relativity">A New Way To Visualize General Relativity</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul></ul>