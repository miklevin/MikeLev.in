---
date: 2022-02-17
title: Testing nbdev
headline: "Learning nbdev: My 20+ Year Journey as an SEO"
description: I'm an SEO with over 20 years of experience, and I'm learning the nbdev library. I've set up the settings.ini file and tested out nbdev_build_libs, and I'm now creating a 00_core.ipynb file. I'm making sure to record the dependencies and to avoid using the 'black' uncompromising code formatter in iPhone Carnets. Join me as I share my journey of learning nbdev and how I'm adapting
keywords: nbdev, SEO, settings.ini, nbdev_build_libs, 00_core.ipynb, dependencies, black, iPhone Carnets, 1996, instructions, website, note, adapting
categories: dependency, seo, nbdev
permalink: /blog/testing-nbdev/
layout: post
group: blog
---


Okay, let's add some continuity here. I've been an SEO on and off for what,
since like around 1996. Technically much of that was as a Webmaster. Webmaster
led naturally to SEO in those days if you were connected to the purpose and
action of the website. It was pretty clear they were the mouth of the
opportunity funnel. Fast-forward 26 years. Still in the field of SEO. Actual
job responsibilities have been all over the place. Always leaning technical.
Rarely taking my own advice. Ugh! Time to do so. 1, 2, 3... 1?

{% include youtubePlayer.html id="Ao473NQjgRI" %}

Okay yesterday I did nbdev_new in mlseo.

I'm following the instructions at https://nbdev.fast.ai/

Yep, as I thought you can't nbdev_build_lib right away after doing nbdev_new.
You have to set up the settings.ini.

I really only had to un-comment-out the copyright and description fields, and
nbdev_build_lib works. Yeah, that made it create the mlseo subdirectory that I
thought was supposed to be there. Okay.

I also just tested nbdev_build_libs which worked. It looks like all .ipynb
files get converted into documentation.

Okay, I'm making progress. Now do some planning!

Okay, in mlseo/mlseo there are only these files:

    __init__.py
    __pycache__
    _nbdev.py

And so nothing is really being exported as a default package. This is different
than cloning the nbdev template from Github. There's a little more you need to
do for yourself, and so you just need to know. Namely there ought to be a file
like 00_core.ipynb.

Look at the Notebooks already in mlseo. Okay, deleted tests.ipynb. I'm leaving
Example.ipynb (for now) and will keep the .py files that are in there already.
All packages will be generated into mlseo/mlseo so whatever's in mlseo.py is
really only copy-from candidates. But the biggest copy-from location is really
my seokata repo (also private in Github).

Okay create a new 00_core.ipynb.

Record the dependencies.

The first cell is:

    # hide
    from nbdev.showdoc import *

...which of course is comes from pip install nbdev.

I will make sure that the "black" uncompromising code formatter is being used
everywhere template-wise. The cell doesn't have an export comment so it won't
end up in the exported package. Also, iPhone Carnets doesn't support black so
make a note about that for the user.

List the types of tasks you want to be able to do with this codebase.

ISSUES
- Virtual env's aren't easy in standalone Jupyter.
- Plugins like Kite, TabNine & spellchecking not easy (possible? in SAJL).
- SEOKata contains all my recent work
- I'm new to nbdev

So I've made great progress. The pattern by which all my future SEO
deliverables will be produced.

Kite or TabNine plugins on standalone Jupyter? No, doesn't look like it.

Did the live-cast.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/making-mlseo-pip-installable/">Making mlseo pip installable</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/journaling-as-performance-art/">Journaling As Performance Art</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/dependency/'>Dependency</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li></ul>