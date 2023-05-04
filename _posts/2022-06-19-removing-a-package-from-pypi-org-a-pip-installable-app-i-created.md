---
date: 2022-06-19
title: Removing a Package From PyPI.org (a pip installable app I created)
headline: "Exploring Solutions to My Challenges: Removing a Package from PyPI.org and Renaming a Notebook"
description: I'm removing a package from PyPI.org that I created, renaming a notebook from 00_core.ipynb to 10_slice.ipynb, and researching how to request an account recovery. I'm also switching to making 'sub-groups' of blog posts and looking for a solution. Come read about my journey and see how I'm tackling these challenges.
keywords: PyPI.org, Package Removal, Notebook Renaming, Account Recovery, Sub-Groups, Blog Posts, Solutions, Challenges
categories: 
permalink: /blog/removing-a-package-from-pypi-org-a-pip-installable-app-i-created/
layout: post
---


It's not often I break the flow of a single-session getting-something-done into
two articles here. Just a few days ago I did that epic post about getting my
personal CMS-system rebooted and mixed about a zillion topics. But in this case
I need to merge the function of two repos and remove one of them from PyPI! And
the removal of a previously published and shared bit of functionality from PyPI
is topic worth focusing on in and of itself.

Similar to the previous post, I'm renaming a notebook from 00_core.ipynb, this
time to 10_slice.ipynb. I'm also moving it from ~/github/blogslicer/ to
~/github/skite/ and my world is improved. I test-render it with
nbdev_build_lib and it checks out. Finally, I fix the path and filename
reference to it in the recently renamed (also from 00_core.ipynb)
00_skite.ipynb. Now test-generate the site... nice. Works like a charm.

Next, take a nice long hot morning Father's Day bath and research on your phone
removing packages from PyPy...

https://blog.ovalerio.net/archives/1971

I wish to completely eradicate the blogslicer Repo. It hasn't been out long and
is very special use case which I believe nobody else has or scratches an itch
nobody else feels or knows that they do. I'll fix that later but probably with
skite. pip install kite is probably in the future, but now that I know how to
pip install -e --editable I do t need to put it in PyPI for development
purposes. Game changer, for sure!

Okay, so think! Log into PyPI... 2FA! I don't have 2FA set up for PyPI... or at
least I never remember setting it up. Ugh! Okay, put in an account recovery
request. Releasing into existing packages still works. I'll probably want to
put some sort of warning in the blogslicer repo, but it's become a very low
priority now.

I'm going to switch to making "sub-groups" of blog posts. Probably the
prev/next arrows at the top of a blog post page will be different from the ones
at the bottom of a blog post page. I found this:

https://stackoverflow.com/questions/28331879/jekyll-next-and-previous-links-with-different-categories

and this

https://github.com/jekyll/jekyll/issues/260

It's not going to be a clear win, but there is some hope.



## Categories

<ul></ul>