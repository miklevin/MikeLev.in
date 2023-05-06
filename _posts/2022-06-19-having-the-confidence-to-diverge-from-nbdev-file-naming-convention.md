---
date: 2022-06-19
title: Having The Confidence To Diverge From nbdev File Naming Convention
headline: "Revamping My Content Release System: My Journey to Breaking From nbdev File Naming Conventions"
description: I recently revamped my content release system and made changes to my .vimrc file, including replacing the blast.sh bash file with a new core.py file renamed to skite.py. Additionally, I deleted the blogslicer repo and removed it from PyPI. I'm pleased with my progress and will be writing a new article about it - come read all about my journey!
keywords: Content Release System, .vimrc, blast.sh, bash file, core.py, skite.py, blogslicer, repo, PyPI, article, journey, progress, revising
categories: .vimrc, progress, journey, blogslicer, pypi
permalink: /blog/having-the-confidence-to-diverge-from-nbdev-file-naming-convention/
layout: post
---


I could not be more pleased with how the my content release system has
developed over the past few days. It is unfortunate the reason why I have the
time to work on it, but it is nonetheless useful and will help me remedy the
cause by virtue of getting more organized. I am embarking on a new chapter. I
am seeking to understand things more deeply and document my process of
understanding and making more immediate use of the deep understanding and
documentation. You can see this start to take place in how I'm managing and
updating my .vimrc file.

I no longer use the blast.sh bash file. In fact, It's time to go delete it.
Done. There's quite a bit of revision that could be done in the helpers repo.
I've adopted the skite repo now for the CMS and there should be aspects of it
that closely reflect the Jekyll static site generator system, such as the
\_layouts, \_assets and \_includes folders. Another interesting thing I want to
do is get rid of the concept of "core.py" for the skite system. I'm not really
following that object oriented package model that nbdev promotes. So think
through good nicknames for functionality. There should be:

- skite.py for top-level (it just makes sense)
- slice.py for the slicing process

Okay, go ahead and make these changes... 1, 2, 3... 1?

- Quit out of them in Jupyter
- git mv 00_core.ipynb 00_skite.ipynb
- Delete .py files in skite/skite
- !nbdev_build_lib and check skite/skite
- Change references to core.py in .vimrc
- Quit out of this file-editing session and reload

Okay, that part of it went very well. But now I want to eliminate the
blogslicer repo, and even remove it from PyPI! Wow, I should cut this journal
entry and make that the focus of a wholly new article.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/i-ll-just-put-this-in-my-usr-local-sbin/">I'll Just Put This In My /usr/local/sbin/</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/removing-a-package-from-pypi-org-a-pip-installable-app-i-created/">Removing a Package From PyPI.org (a pip installable app I created)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/vimrc/'>.vimrc</a></h4></li>
<li><h4><a href='/progress/'>Progress</a></h4></li>
<li><h4><a href='/journey/'>Journey</a></h4></li>
<li><h4><a href='/blogslicer/'>blogslicer</a></h4></li>
<li><h4><a href='/pypi/'>PyPI</a></h4></li></ul>