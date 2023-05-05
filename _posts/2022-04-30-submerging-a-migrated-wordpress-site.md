---
date: 2022-04-30
title: Submerging A Migrated WordPress Site
headline: "Migrating My WordPress Blog to Jekyll: Fixing Broken Picture Links Along the Way"
description: I'm in the midst of migrating my WordPress blog to Jekyll and am running into a few issues. I'm moving the index.md file, making a subfolder, and renaming the file to index.md. While I've brought my old homepage back to life, I'm now dealing with broken picture links that I must fix. Follow my journey as I work through this process.
keywords: Migrating, WordPress, Jekyll, index.md, Subfolder, Renaming, Broken Picture Links, Site Hierarchy, Shell Commands, Homepage, Fixing
categories: jekyll
permalink: /blog/submerging-a-migrated-wordpress-site/
layout: post
---


For my next ELTGD trick, I'm going to add site-navigation across all my sites.
There's got to be a "home" link and a "blog" link. And I don't even know enough
about Jekyll yet to do that.

But before I do THAT I first must do THIS... this being a few touches to
MikeLev.in so that it's not hopelessly out of date. I migrated my old WordPress
blog to Jekyll not long ago and let all that HostMonster / BlueHost stuff
expire, as well as the GoDaddy stuff associated with it. Good riddance!
$100/year for private Github repos is really all you need these days for static
sites. It used to be a good deal to get unlimited WordPress CPanel hosting with
those bottom-scrapers, but honestly the tech liability of managing N-WordPress
sites is fatiguing and unwise these days. All that PHP, WordPress and Plugin
perpetual upgrading and fixing of incompatibilities over an array of sites.
Nope!

There's so many date-directories made for the blog, historical blog posts,
custom pages and bits of design work I may like to borrow from that it's silly
to nuke the whole site. Rather, I'm just going to "submerge" it maybe 1-click
further down in the site hierarchy than it is today. That way it frees up the
site to be part of my new Github Pages Jekyll movement. Okay, so get to it!

1, 2, 3... 1? Well step #1 is going to be to move /github/MikeLevin/index.md to
/github/MikeLevin/mike-levin.md (I might as well get some keyword juice out of
the move). And then I... oh wait! I've got nifty shell-command formatting
thanks to Jekyll:

```bash
github mv index.md mike-levin.md
cp ../helpers/index.md .
git add index.md mike-levin.md
```

Oops! My system on MikeLev.in is a bit different than all the new sites so I
had to actually make a /mike-levin/ subfolder and move mike-levin.md into it
and rename it as index.md. That should bring my old homepage back alive in a
subfolder. It did, but all the picture links broke. Fix them...


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/submerging-a-migrated-wordpress-site/">Submerging A Migrated WordPress Site</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/every-little-project-gets-done/">Every Little Project Gets Done!</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li></ul>