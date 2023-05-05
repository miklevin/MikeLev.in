---
date: 2022-04-26
title: Turning Repo into nbdev Project
headline: "Transforming Repo into nbdev Project: My Journey"
description: I created a GitHub repo for my project, blogslicer, and connected it to my local directory. After editing the settings.ini file, I moved and renamed the notebook into the repo, added the necessary cells and comments for nbdev, and attempted to publish the project. Finally, I altered pythonically.com to not use index.md as the journal. Read my blog post to learn how I did it!
keywords: Repo, nbdev, GitHub, project, blogslicer, local directory, settings.ini, notebook, cells, comments, publishing, pythonically.com, journal
categories: notebook, blogslicer, nbdev, github, publishing
permalink: /blog/turning-repo-into-nbdev-project/
layout: post
---


Let's see how quickly you can get blogslicer in PyPi.org as an nbdev project.

Okay, I just:

- Created ~/github/blogslicer
- Created github repo
- Tied the 2 together and pushed
- Did nbdev_new
- Edited settings.ini
- Moved and renamed the notebook into repo
- Attempted nbdev_clean_nbs (didn't appear to work)
- Added notebook to repo and pushed

Okay, what next? Make the new one which is now named 00_core.py work on files
that are not in its own directory.

I added the various cells and comments that nbdev needs. nbdev_clean_nbs is now
doing its thing. This stuff is only now going to be published as a result of
this process working.

I should alter pythonically.com to not use index.md as the journal or the
homepage. Instead, it will be journal.md and I will put another index.md in
location. I will have to quit out of vim where I have all my site journals
loaded and edit the all.sh file with the new filename. Don't do this with ALL
your sites yet. Just start with pythonically.com and see how it goes.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/turning-repo-into-nbdev-project/">Turning Repo into nbdev Project</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/slicing-dicing-single-file-to-jekyll-blog-posts/">Slicing & Dicing Single File to Jekyll Blog Posts</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/notebook/'>Notebook</a></h4></li>
<li><h4><a href='/blogslicer/'>blogslicer</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/github/'>Github</a></h4></li>
<li><h4><a href='/publishing/'>Publishing</a></h4></li></ul>