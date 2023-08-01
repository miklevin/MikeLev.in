---
date: 2022-05-01
title: Disabling Github CI nbdev_install_git_hooks
headline: "Deciding Where to Host My Project: How Disabling Github CI nbdev_install_git_hooks Led Me to mikelevinseo.com"
description: I recently updated my release script using a bash loop and asked myself a few questions to help me decide what the next steps should be. After disabling Github CI nbdev_install_git_hooks and running my release script, I decided the best place to host my project was mikelevinseo.com. Read my blog post to find out how I got there and what I did next.
keywords: Github, CI, nbdev_install_git_hooks, Bash, Loop, Release Script, Hosting, mikelevinseo.com, Repo Page
categories: loop, git, linux
permalink: /blog/disabling-github-ci-nbdev-install-git-hooks/
layout: post
group: blog
---


I just updated my release script using a bash loop. That was very satisfying. I
guess I question now how much these next steps on the blogslicer project belong
here on Pythonic Ally. All this Github Pages Jekyll stuff... not really even
sure where it belongs. Maybe SEO? I'm using MikeLevinSEO.com for the mlseo repo
page. Maybe Mike-Levin.com? Or just on plain MikeLev.in. Anyway, I can sort
that out as I go. Don't lose momentum is the important thing.  And on the front
of not losing momentum, it's time to ask my standard questions:

1. What's most broken?
2. Where do I get the biggest bang for the buck?
3. What plates need to be spun?

Oh! USING mlseo is the process of Pipulating. And so it's just about time to
bring pipulate.com back to life applying everything form mlseo and creating
that righteous feedback loop to push forward the usefulness of mlseo.

Okay, so every time I push to pipulate or blogslicer, I get a Github CI Run
failed email. nbdev enables Github continuous integration (CI) with a
easy-to-run script after you nbdev_new so long as your repo is public. It's
tempting to do, but whatever it does causes errors on every push, so I found
this page to [disable Github CI](https://docs.github.com/en/actions/managing-workflow-runs/disabling-and-enabling-a-workflow)
I followed the instructions and just deleted all my "Run Failed" CI emails. Now
I'm running my release script again...

And it worked! Wow, yeah, this is not Pythonic Ally at all anymore. Neither is
it the type of thing I really want to put on the Linux, Python, vim & git site.
No, this is feeling a lot like what SHOULD be on mikelevinseo.com BEFORE I
turned it into the repo page for mlseo. I may have to rethink that.

But don't lose momentum. Keep going! Every Little Project Gets Done... Next!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/adding-style-sheets-to-github-pages-jekyll-blog/">Adding Style Sheets to Github Pages Jekyll Blog</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/disabling-github-ci-nbdev-install-git-hooks/">Disabling Github CI nbdev_install_git_hooks</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/loop/'>Loop</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>