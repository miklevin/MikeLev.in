---
date: 2022-04-30
title: Adding Style Sheets to Github Pages Jekyll Blog
headline: Successfully Added Style Sheets to My Github Pages Jekyll Blog!
description: I figured out how to add style sheets to my Github Pages Jekyll Blog using the sass css generator. After pasting the CSS provided in the article I was working off of underneath the @import 'jekyll-theme-hacker' line, I was able to add the prev/next arrows to my blog. Come read more about my journey in adding style sheets to my blog!
keywords: Github Pages, Jekyll Blog, Style Sheets, Sass CSS Generator, CSS, @import 'jekyll-theme-hacker', Prev/Next Arrows, Article, Journey
categories: journey, github pages
permalink: /blog/adding-style-sheets-to-github-pages-jekyll-blog/
layout: post
---


Okay, that was easy, adding the prev/next arrows to Jekyll blogs. But I'm not
quite done. There's some CSS that completes the project.

It was a bit tricky to figure out. I don't normally do the sass css generators,
but it's built into Jekyll. The default css for Jekyll is the type of thing you
download and put in location locally just like a default.html or post.html. And
like them, there will be some transformations occurring, but instead of just
using a style.css you use a style.scss which does an import:

    ---
    ---

    @import 'jekyll-theme-hacker';

Using the CSS provided at the article I'm working off of, I guessed that you
simply paste it underneath:

    ---
    ---

    @import 'jekyll-theme-hacker';

    .post-nav {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
    }

    .post-nav p {
        flex: 1 1 0;
        width: 45%;
    }

    .post-nav p:first-child {
        padding-right: 0.5em;
    }

    .post-nav p:last-child {
        padding-left: 0.5em;
        text-align: right;
    }


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/edit-10-blogs-homepages-or-templates-all-at-once/">Edit 10 Blogs, Homepages or Templates All At Once</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/adding-style-sheets-to-github-pages-jekyll-blog/">Adding Style Sheets to Github Pages Jekyll Blog</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/journey/'>Journey</a></h4></li>
<li><h4><a href='/github-pages/'>Github Pages</a></h4></li></ul>