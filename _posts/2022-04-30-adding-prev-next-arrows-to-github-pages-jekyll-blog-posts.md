---
date: 2022-04-30
title: Adding Prev/Next Arrows to Github Pages Jekyll Blog Posts
headline: Adding Previous/Next Links to My Blog Posts with Jekyll and Github Pages
description: "I recently created a blog slicing and dicing system and am adding previous/next links to my blog posts. To do this, I'm directly inserting them into the markdown files and using Github Pages Hacker Theme page to grab the raw code for the post.html file. I checked to make sure Google Analytics tag manager code was still being applied and copied the post.html file into the `_layouts` folder of each of my sites. Come read more about my blog slicing and dicing system!"
keywords: "Github Pages, Jekyll, Blog Posts, Previous/Next Arrows, Markdown, Hacker Theme page, Raw Code, `_layouts` folder, Google Analytics, Tag Manager, 404 Issue, Release Script"
categories: github pages, google analytics, jekyll
permalink: /blog/adding-prev-next-arrows-to-github-pages-jekyll-blog-posts/
layout: post
---


Hello, hello, hello! This is your Pythonic Ally again. The time has come the
walrus said to add previous/next links to the blog posts in the blog slice &
dice system you just saw me create.

There are options for doing this (probably) in the Liquid template system that
Jekyll is built on. But since I'm outputting these pages pythonically, I'm
sitting on top of all the data I need right at the moment the files are
generated, so why not just put them directly in the markdown files? No need for
some templating system dependency!

Okay, good approach. Now think it through. This is a wonderful shining example
of why we keep our Python code both in a Jupyter Notebook and in a .py file. My
release system both creates and uses the .py file from the Notebook. I almost
never look at or think about the .py file that actually does the blog slicing
but it's always in sync with the Notebook version that I'm always tweaking and
refining. Great workflow!

This is one such tweak.

It goes something like this:

Whenever we encounter the slicer-token (80 * "-"), we know to output the table
we must have just accumulated-up along with the date that we know to be in a
corresponding list of dates that we created from a prior spin-through. Actually
handling the dates was one of the more difficult parts of the blogslicer
project. The concept goes like this:

There is a slicer token above and below every blog post.

Therefore when spinning through a single-page-journal that's going to be sliced
& diced into individual files, the first slicer-token encountered is a
throw-away one because it hasn't been "accumulating up" a blog post to that
point. However, on that first instance it is still important to grab the date
which it knows it's going to encounter on the next line. This slicer-token,
date-grab continues until the last slicer-token underneath of which there will
be no date. To make things easy, I just surround the attempts at date-grabs in
a try/except. That way the last slicer-token which has no date after it won't
generate an error.

Okay, so that's the system.

I had to do a loop ahead of time to know how many blog posts there are and so
the counter can count-down from the highest number down to 1. In this way, blog
posts will automatically always get the same title and URL if they have to be
auto-generated. So that first spin-through is necessary.

It's on the 2nd spin-through that title-logic is applied. Title logic can't be
moved to the 1st spin-through because that's what generates the requirements
for the 2nd spin-through. But without having the titles already on-hand, we
can't look-ahead to the next title, which is what would be necessary to create
the "next" arrow of a previous/next blog post navigator system.

It looks like we'll be doing a THIRD spin-through. This complexity may argue
for using what's built into Jekyll. Let me see if their blog posting system
accommodates for arrows. If not, I'll be doing a 3rd spin-through and appending
the arrows to the bottom of each blog-post file for sure. Not the biggest deal,
but investigate Jekyll post system first.

Here's a wonderful article that focuses on a CSS feature called flexbox:

[ByteDude's Jekyll blog post prev/next arrows](https://www.bytedude.com/jekyll-previous-and-next-posts/)

Me detects lots of rabbit-hole issues here. I haven't even thought about
formatting the prev/next arrows I was planning on "manually" inserting with
Python, and that's a point which the canned solutions cover well. So why not
just use the canned solution?

The only reason I can think why not is that I don't know how to override the
blog post template. But it couldn't be different than the normal page template,
right? I hope it won't make me have to add my Google Analytics code all over
again. Hopefully it's a nested or compositing or inheriting system... whatever
language you want to put on "inner" modifications not having to re-create all
the "outer" wrapper customizations. The outer-wrapper stuff of
\_layouts\default.html should still apply.

So I go to Github Hacker theme page [Github Pages Hacker Theme](https://github.com/pages-themes/hacker)

I grab the raw code at: [Raw Hacker Post Theme](https://raw.githubusercontent.com/pages-themes/hacker/master/_layouts/post.html)

I drop it into /github/pythonically/\_layouts and add it to the repo.

I edit out the code that adds tags, which I don't sue anyway. Commit and
push...

Okay, that worked. But I noticed another problem that the default title/url
that's created if there's no title explicitly set is causing a 404. I don't
know if it's a content issue or a blogslicer issue. Ugh! Nothing informative is
available anywhere to debug.

Oh, my bad! I just did a fast-track git commit/push without using my release
script which actually does all the blog slice & dice work. Without using the
release script, links are bound to be broken. Remember that. Okay, the
\_layouts\post.html is doing its job exactly as hoped, meaning that the Google
Analytics tag manager code that I add with \_layouts/default.html are still
being applied. This is a compositing system. Excellent! Good work Jekyll on
that. So next step? Drop in the code from the article!

@g

...wait... Refresh... Yes! Success! Just that easy!

But I don't have the CSS yet. Hmmm. Well, I want to copy this file into
location for each of my sites.

Use my itersites.py file in /github/helpers/ to copy the post.html into
\_layouts, git add and git commit... okay, done.

Do a release and get at least some barebones (unformatted with CSS) prev/next
arrows propagated all over the place...


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/adding-prev-next-arrows-to-github-pages-jekyll-blog-posts/">Adding Prev/Next Arrows to Github Pages Jekyll Blog Posts</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/moved-whatsametafor-io-blog-content-here/">Moved WhatsaMetaFor.io Blog Content Here</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/github-pages/'>Github Pages</a></h4></li>
<li><h4><a href='/google-analytics/'>Google Analytics</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li></ul>