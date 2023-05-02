---
date: 2022-04-25
title: Slicing & Dicing Single File to Jekyll Blog Posts
permalink: /blog/slicing-dicing-single-file-to-jekyll-blog-posts/
headline: Refining My Journey of Slicing & Dicing a Single File into Jekyll Blog Posts
description: I recently livestreamed a project where I was slicing and dicing a single long journal file into separate files. I used debugging messages and headlines to provide a hierarchy, pre-processed titles into slugs, and added frontmatter and `_config.yml` file. Join me as I share my journey of refining the project and the challenges I faced along the way.
keywords: Slicing, Dicing, Single File, Jekyll, Blog Posts, Debugging Messages, Headlines, Hierarchy, Pre-Processing, Titles, Slugs, Frontmatter, _config.yml
categories: jekyll
layout: post
---

I pushed out a few livestreams yesterday slice and dicing these single long
journal files into smaller separate files. I did it under the pressure of
livestreaming and didn't quite bring it to completion. I need to do a wee bit
more exercise in clear thinking. I did a pretty good job of a rough first pass,
but that's how bugs get in. Rough first pass needs a sort of clarity
superimposed on it afterwards. You can't ***always*** work like Roomba, just
backing up, turning a little and retrying. Sometimes you need to look at the
entire situation and make higher-order determinations.

One of the ways to do this is to be very precise about the debugging messages
that you output while the script runs. This output is side-effects of the
script. The functional result of running the script is the same whether the
print statement output is shown or not, so the print statement is purely for me
during the running of the script. Make it work for me better.

Get your in-Notebook headlines!

Okay, headlines are in. Putting in headlines makes everything start to fall in
place. The hierarchy implied by headlines, especially h1, h2 & h3 are highly
clarifying.

Pshwew! That took some wrangling. It turned out that there's some sort of
nuances keeping the Title from working as URLs, or at least easily. I
pre-process the titles into slugs and use the slugs in the frontmatter and
\_config.yml file.

I'll have to maybe do another video or publish the code or something. Suffice
to say I have the "success assured" moment now under my belt. I have just a bit
more pushing to do to hit this project home.

I need to have a more sensible default filename. Right now the URLs would
change every time I sliced & diced the journal because the counter goes UP as
it goes through the file, but the fine is in reverse chronological notation.

What are my blogging conventions?

The page slicer token is always 80 hyphens. That's such a clean "cut".

There needs to be a slicer token at the bottom of the document indicating the
"last" or perhaps the "first" post, depending on how you think about it.

Okay, done. I had to start the counter from -1 to get it right. It counts-up
and then counts-down. The URLs will never change so long as the headline never
changes. But these things have no headlines. Fix that, but make them optional.
You have a system now that creates a very nice default URL /blog/post-n/


## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li></ul>