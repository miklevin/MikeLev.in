---
date: 2022-04-30
title: Edit 10 Blogs, Homepages or Templates All At Once
headline: "Breathing New Life into MikeLev.in: Creating a layouts Folder and Using Helper-Scripts to Edit Files"
description: I'm breathing new life into MikeLev.in, creating a \_layouts folder in each repo with a default.html file to get my Google Analytics code on each site. I've also created helper-scripts to edit all my site-files at once and am putting rudimentary site-navigation links in place. I'm considering switching gears to make it about previous/next blog, so stay tuned for more updates!
keywords: Edit, Blogs, Homepages, Templates, MikeLev.in, \_layouts, default.html, Google Analytics, helper-scripts, site-files, site-navigation, previous/next blog
categories: homepages, edit, templates, google analytics
permalink: /blog/edit-10-blogs-homepages-or-templates-all-at-once/
layout: post
---


Okay, so I am breathing new life into MikeLev.in. I struggled to figure out
which of my registered domains I should put this sort of open-ended rambling
writing into and had settled on whatsametafor.io due to its very ambiguity. But
now I'm thinking it may be a distraction. Where does the .io extension come
from? Is the price going to be hiked on me every year like the .me?

Either way, it's best to develop this site since it exactly matches my name and
I don't see my name changing anytime soon. I should consider the purpose to
which I put Mike-Levin.com. It was my personal "exact match" domain even older
than MikeLev.in. I should look at link toxicity reports however based on it,
considering it was in the hands of Russian spammers for so many years.

In either case, they are both important assets to me. This one will carry on
the momentum I had started in the early and mid 2010's. And now instead of just
random open-ended writing, I should use this to think through my next step.
What is the least time-consuming, energy-consuming path to accelerating my
advancement? Where is the biggest bang for the buck?

Try putting dates into the blog index page. It would be useful to see when
things were published from that page. Nice, okay. I'll keep that for a bit. But
now go look at the Liquid template system. Start taking control of your Github
Pages Jekyll templates. I'm using Hacker everywhere right now, but that can
only last for so long.

I've already created a \_layouts folder in each repo with a default.html file
in each in order to get my (up-to-date) Google Analytics code on each site.
I'll be making a post on that soon. But this gives a convenient place to start
experimenting with overriding the Hacker template. I'm already sort of doing
that, so try putting some site-wide navigation in default.html.

Okay, I have a bunch of helper-scripts now that help me edit all my site-files
at once. I can edit all my journals at once, which makes copy/pasting entries
between them very easy. I can edit all my homepages at once and all my
default.html's at once.

- ./all.sh
- ./homepages.sh
- ./defaults.sh

And my release script and .vimrc file (vim configuration) are actually always
loaded right along with my journal files. In this way, I can continually
improve my release system and text-editing environment organically over time.

I'm one of those people who really doesn't believe in plugins because of plugin
dependency syndrome. You should more-or-less be able to sit down at almost any
system, get vim installed and be fairly productive by just dropping your .vimrc
into location. One file and poof! Familiar editing environment.

By editing all my default.html's, I put the most rudimentary site-navigation
links in place. It's just switching between "Home" and "Blog", but hey it's a
start.

Hmmm. I think this is going to evolve to being about previous/next blog post
links rather than about Liquid templates. Because I'm controlling the output of
each and every blog-post programmatically with my blogslicer package, it seems
that I should switch gears to make it about that.

Hmm, nope. It should be a wholly separate post that I put over there on
Pythonic Ally site.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/edit-10-blogs-homepages-or-templates-all-at-once">Edit 10 Blogs, Homepages or Templates All At Once</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/submerging-a-migrated-wordpress-site">Submerging A Migrated WordPress Site</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/edit/'>Edit</a></h4></li>
<li><h4><a href='/google-analytics/'>Google Analytics</a></h4></li></ul>