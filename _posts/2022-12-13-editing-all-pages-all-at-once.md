---
date: 2022-12-13
title: Editing All Pages All At Once
headline: Making the Big Transition to Best Foot Forward SEO
description: This blog post explores the challenges of adjusting to a new SEO workflow, including editing 13 files in vim buffers, cleaning up a Skite static site generator repo, and making changes to the main pages and blog query. It's a difficult transition for the author, who is a pack-rat when it comes to online things, and they must learn to let go of old habits in order to make the most of the blog query and toggle active or inactive posts.
keywords: SEO, Workflow, Editing, Vim Buffers, Skite, Static Site Generator, Main Pages, Blog Query, Toggle Active/Inactive, Best Foot Forward SEO, Pack-Rat, Online Things, Categorization, Navigation, Surf Straight Through, Publish-Date Oriented
categories: seo
permalink: /blog/editing-all-pages-all-at-once/
layout: post
---


In my continuing effort to practice "Best Foot Forward" SEO, I've de-linked all
the old cruft off of my MikeLev.in homepage. All that old content is "orphaned"
in that it's still there, but no links are leading into it. When I do a
https://www.google.com/search?q=site%3Amikelev.in search, it tells me there's
406 pages. I think I'm going to turn my current automatic SERP email that's
performing a search on Mike Levin SEO over to this new site: modifier search so
that I'm accumulating snapshots of Google's (estimated) view of my site day by
day.

Okay, I have to double-check a deliverable to work to make sure no data-pulls
have been missed for something I did against a list of sites for a list of
months. I think while I do this double-checking I'm also going to innovate on
how I do my work here. I used to have a bunch of different "site journals"
loaded at the same time in my vim buffers so I could edit the blog of a lot of
sites at once. I trimmed that down a lot to only 1 published blog (this) and 3
unpublished journals. So I'm really only publishing on one site while I journal
(auto-blogging) and only just the blog at that.

But when I do something I want to share in a more organized way than this blog,
it's quite difficult, and I'm thinking since I've trimmed back all the pages of
my site (de-linked and orphaned them), I can also edit the organized pages. So
why not load the Linux, Python, vim, git & blog markdown pages that Jekyll
publishes, so I can continuously refine? No reason why not. I may even load the
blog slice & dice files to make it totally meta, but once step at a time. Go
edit /usr/local/sbin to get my linux.md, python.md, vim.md, git.md and blog.md
files all loaded in memory. I'll keep the homepage index.md as the last vim
buffer so I can always :blast my way to the homepage.

Ugh, okay the project I'm putting aside for the moment is rendering mermaid
diagrams in Github Pages. Okay, edit /usr/local/sbin/all to do the magic. It
looks something like this:

```python
pre = "~/repos/hide/MikeLev.in/"
edit_pages = ['linux', 'python', 'vim', 'git', 'blog', 'index']
edit_pages = [f"{pre}{x}.md" for x in edit_pages]
edit_pages = " ".join(edit_pages)
edit_journals = f"vim {journals} ~/.vimrc {edit_pages}"
system(edit_journals)
```

Okay, easy enough. Once I edit my all file, I just quit out of vim and run the
all program again. That does all the work, and now I'm editing all those files
at once. It's fine to blank those. I don't have to preserve everything I've
ever written. It's in the git history anyway.

Yeah, so I have 2 files from the skite static site generator system loading
right along with the journal files, the main markdown files in my site and my
.vimrc. The idea is that I can be editing all sites all at once.

Let's try one of the tricks now that accelerates things. Let's try using the
category page to allow a trick to end up in the right place. That is to say,
under the right sight section.

Pshwew, this has been a pretty intense session. I have significantly updated my
workflow today.

- In my vim buffers, I'm editing 13 files.
  - My most important journal files (that slice & dice into blogs)
  - My most important main site pages (Linux, Python, vim, git & blog)
  - My .vimrc file
- I cleaned up my skite static site generator repo
  - I un-nbdev'itized the repo
  - I removed the blog tagline as an argument passed from site.csv file
- I "blanked" all my site's main pages and put in blog query
  - I removed the blog itself from main nav (too long and unstructured)
  - I added the code so categorized blog posts appear on each page
  - I removed the arrows that let you surf straight through the blog
  - I deleted all the categorization done in the past

Wow, there is going to be a very publish-date oriented order. And I've got a
good amount of categorization work cut out for me. This also suggests other
to-do items, such as controlling the sort-order of the blog query. Having an
ability to toggle active or inactive posts, etc.

Best Foot Forward SEO is a really big shift in thinking for me. It's taking me
some time to clean the slate. It's the pack-rat in me with these online things,
just like it is in real-life. I've got to get past that.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/fusion-ignition-achieved-q-1-thanks-to-lawrence-livermore-national-laboratory/">Fusion Ignition Achieved! Q = 1 Thanks to Lawrence Livermore National Laboratory</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/using-named-tuples-to-define-api-job-perform-housekeeping/">Using Named Tuples to Define API-job & Perform Housekeeping</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/seo/'>SEO</a></h4></li></ul>