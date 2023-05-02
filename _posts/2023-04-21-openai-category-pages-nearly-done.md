---
date: 2023-04-21
title: OpenAI Category Pages Nearly Done
permalink: /blog/openai-category-pages-nearly-done/
headline: Nearly Finished Enhancing My Website with Jekyll's YAML-based Category Pages
description: I'm nearly finished creating category pages for my website using Jekyll's YAML-like front matter, and I'm using a Python-based YAML validator to make sure I don't make any mistakes. I'm also lemmatizing keyword groups and picking categories from a top-N list to limit the number of categories. I just need to make the category pages look better, have the correct titles and descriptions, and use the most common proper case.
keywords: OpenAI, Category Pages, Jekyll, YAML, Validator, Lemmatizing, Keyword Groups, Top-N List, Titles, Descriptions, Proper Case
categories: jekyll, yaml, openai
layout: post
---

Wow, so the old keystrokes I use for New Journal Entry and Add Headline are
still the ones I use now, but the @h macro command for Headline is now for
Header data, because that's what Jekyll's YAML-like front matter really is.
That was a big realization, and once I had it I was able to use a Python-based
YAML validator at just the right point to keep me from having to figure out my
YAML-format mistakes on the Gihtub site during the Github.io publishing step.

I need to insert category pages. But I need to limit the number of categories
for the site overall. I do have that place already where I choose the top-N
(usually set to 100) keywords based on a frequency count. The keywords are
lemmurized, so they group up into single, unique categories best. I can get
that top-categories list during site generation (and basically do already), but
the trick is to have each post pick just those categories out of that list to
which it belongs.

Okay, classic task in my field. I'm moving the lemmatizing to earlier in the
process so that keyword groups are lemmatized keys. Slick.

Okay, category pages are almost done. It's going well. Release this post and
get onto follow-up issues, like:

- Making the Category pages look better
- Having most common Proper Case for each category
- Having the correct Titles & Descriptions for each category post


## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/openai/'>OpenAI</a></h4></li></ul>