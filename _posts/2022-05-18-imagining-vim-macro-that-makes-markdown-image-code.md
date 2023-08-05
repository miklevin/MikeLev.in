---
date: 2022-05-18
title: Imagining vim Macro That Makes Markdown Image Code
headline: Vim Macro Makes Web Publishing Easier for Information Age Professionals
description: As an Information Age professional, I use vim as my text editor to create image tags from keyworded filenames for my web publishing system based on Github's Github Pages Jekyll static site generator. I use proper-case for the web accessible alt-text area, which is beneficial for both the visually impaired and search engines. With vim, I can easily name my files with keywords and tag my images for search with alt-text. Learn how I use vim to make web publishing easier.
keywords: vim, macro, Markdown, image, code, Information Age, text editor, web publishing, Github Pages, Jekyll, static site generator, proper-case, alt-text, keywords, files, search, tool
categories: search, seo, vim, static site generator, jekyll, text editor
permalink: /blog/imagining-vim-macro-that-makes-markdown-image-code/
layout: post
group: blog
---


The time has come to cast a new vim-spell so powerful, it boggles.

The single most common tedious task I need to do these days in my new web
publishing system based on Github's Github Pages Jekyll static site generator
is the creating of image tags from an already keyword filename such as:

    carl-rogers-listen-and-understand-to-their-satisfaction.png

First off, it just make so much sense to keyword an image at this point that
it's hard to believe that web publishing software doesn't somehow enforce it
early in the publishing process. I mean really why not bind the keywords to the
image in the filename and forego some tedious and convoluted later image
keywording process? To not use the keywords you're targeting and intend to
bring traffic in on when naming the file is just stupid.

Okay, so we've got a keyworded filename. What next?

The markdown syntax for creating an image is:

```markdown
![Alternative text for web accessability](path/to/image.png)
```

Okay, nice. I can show markdown with markdown. I didn't expect it to work so
easily with markdown fenced code blocks (fencing). I expected to have to
neutralize or escape characters with backslashing. This is much better. Yay!
Now let's proceed.

We've already got a keyworded image. The trick is just to get it into its
respective locations. I like using proper-case for the web accessible alt-text
area for the visually impaired. This also happens to be good for search
engines. It is the equivalent of tagging images for machine learning. So if
you're not using alt-text to tag your images for search, it's about as stupid
as not using keywords to name your files.

Lack of alt-text on a non-keyworded-filename.jpg is doubly stupid. Or maybe
that's stupid-squared? Anyhow, the rest is vim.

You are using vim as your text-editor, right? Any self-respecting coder,
programmer, seo, journaler, writer, sysadmin, devops or otherwise Information
Age professional is, right? Otherwise you've put your gonads in Microsoft's
hands (VSCode, right, right, am I right?).


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/add-flax-seeds-to-blended-drinks-to-make-your-poo-firm/">Add Flax Seeds to Blended Drinks to Make Your Poo Firm</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/imagining-vim-macro-that-makes-markdown-image-code/">Imagining vim Macro That Makes Markdown Image Code</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/search/'>Search</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/static-site-generator/'>Static Site Generator</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/text-editor/'>Text Editor</a></h4></li></ul>