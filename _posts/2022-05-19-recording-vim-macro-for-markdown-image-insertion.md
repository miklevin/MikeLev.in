---
date: 2022-05-19
title: Recording vim macro for markdown image insertion
headline: Learn How to Quickly Insert Images into Your Blog Posts with Vim Macros!
description: Today I'm hosting a livecasting event to show you how to use vim macros to quickly turn keyworded image files into the markdown required for HTML image insertion. I'll be demonstrating how to use search & replace patterns to capitalize and separate words, so you can learn how to quickly add images to your blog posts. Join me to learn this time-saving technique!
keywords: vim, macro, markdown, image, insertion, livecasting, event, keyworded, file, search, replace, patterns, capitalize, separate, words, quickly, add, images, blog, posts, time-saving, technique, html
categories: html, search, macro, vim
permalink: /blog/recording-vim-macro-for-markdown-image-insertion/
layout: post
---


This post is for a livecasting performance art event of recording a very
important vim macro: turning a keyworded-image-file.jpg into the full markdown
required for html image insertion.

This is what we're trying to accomplish, starting with ***alt-text.jpg***

```markdown
![Alt text](alt-text.jpg)
```

Here is a more specific example: ***chicken-hawk-from-foghorn-leghorn.jpg*** needs to
become:

```markdown
![Chicken Hawk From Foghorn Leghorn](/assets/images/chicken-hawk-from-foghorn-leghorn.jpg)
```

This is the vim search & replace patterns that I built-up. The difference
between the first and the second example is the addition of the \%V which tells
vim to restrain the search & replace operation you're about to do to the visual
selection. That was tricky!

    # Proper-case capitalize everything on line
    s/\<./\u&/g

    # Proper-case capitalize everything under visual selection
    s/\%V\<./\u&/g

    # Replace hyphens in everything under visual selection
    s/\%V\-/ /g

# Recording vim macros as performance art

{% include youtubePlayer.html id="IO1PpTKjx7U" %}

And you can see my [.vimrc file on Github](https://github.com/miklevin/vim).



## Categories

<ul>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/search/'>Search</a></h4></li>
<li><h4><a href='/macro/'>Macro</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li></ul>