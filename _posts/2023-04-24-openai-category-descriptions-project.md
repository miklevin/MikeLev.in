---
date: 2023-04-24
title: OpenAI Category Descriptions Project
headline: I Solved a Problem and Now I'm Ready to Move On!
description: "I just released a project I've been working on for the past few days. After overcoming an issue with category tags, I'm now ready to move onto the next step: identifying data locations, deciding whether to rely on them in an existing context or break them out, and creating a parameter. Read my blog post to find out more!"
keywords: Project, Release, Category, Tag, Constant, Type, Empty List, Identifying, Location, Program, Data, Existing Context, Break, Parameter
categories: 
permalink: /blog/openai-category-descriptions-project/
layout: post
group: blog
---


Okay it is tomorrow morning and I jumped right into my journal. The work from
the past few days is now live on the site and I get to get its benefit, and to
test it. 

Only category tags aren't working right. I'm not writing them into the
individual post files. They should be in there because it's actually used (or
will be) for control of navigation highlighting.

In other words, my Liquid templates should be able to be written so that
whenever an article is displaying that has a category tag, the navigation
element for that category should be highlighted. This will give users a sense
of where they are in the site. I may want to think about more category tags
than just Linux, Python, vim & git. 

I should also think more about the design of the category index pages, in both
senses the index of categories (looking quite naked) and each individual
category page with its list of articles. The category pages listing articles
looks like it should have something at the top, such as a description of the
category, which should be able to be written by OpenAI given the descriptions
on the page. That project's coming up.

Okay, I worked out the problem in the categories yaml front matter not being
populated in the Jekyllesque post files. I had to add CATEGORIES as a global
constant of type empty list. But is it an constant? Well, it's constantly a
very important list that can't be populated correctly at the outset, but I
still know the name I want to use for it. So a constant as an empty list is
fine in Python, even if it's to make it a naughty, naughty global.

Globals in Python are not sins because a .py-file maps to an ever-present
container parent class. BAM! You OO it and you don't even know it. Globals are
fine. They're just attributes of the module.

This sets the stage perfectly now for the OpenAI Category Descriptions project.

This will be of some popular interest, I expect. I should document it well.
Less rambling versions. That's what AI is good for: rolling-up all the
important points, and packaging the rambling for the hard-core fans who want to
drill-down into the daily gore chore.

Have more nuanced control than anyone can reasonably expect over more
unexpectedly friendly and powerful low-level tools than anyone can reasonably
learn. That's the goal. And I'm getting there.

My next step is to use this solid category tagging to do the next level of
stuff. Also, actually do the category descriptions project.

Next steps

- Identify the locations in the program where the data exists
- Decide whether to rely on that in an existing context or to break it out
- If breaking it out, decide whether to use a global or a parameter
- If a parameter, decide whether to pass it in or to use a default

And that's about it. I'm going to go ahead and release this post. It's a good
stopping point and I know where to begin when I next re-approach this project.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/openai-category-descriptions-project/">OpenAI Category Descriptions Project</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/steve-jobs-and-bill-gates-having-amiga-envy/">Steve Jobs and Bill Gates having Amiga-envy</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul></ul>