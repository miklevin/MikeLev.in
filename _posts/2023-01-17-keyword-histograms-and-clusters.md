---
date: 2023-01-17
title: Keyword Histograms and Clusters
headline: Ready to Share My Steps for Keyword Processing with Yake KeywordExtractor!
description: I've already done the hard work of extracting keywords using the Yake KeywordExtractor, and now I'm ready to discuss extracting them from the entire dataset. I've also used lambda functions to control the insertion of spaces between each tag-stripped element, and I'm eager to share the steps I've taken for keyword processing. Click here to read more!
keywords: Histograms, Clusters, Yake, KeywordExtractor, Lambda, Functions, Tag-Stripped, Element, Processing, Extractions, Dataset, Spaces
categories: 
permalink: /blog/keyword-histograms-and-clusters/
layout: post
group: blog
---


I got through making keyword histograms against content yesterday. Now I want
to make keyword clusters.

- K-means clustering: This is a popular method for grouping similar keywords
  together based on their histogram values.
- Hierarchical clustering: This method builds a hierarchy of clusters, where
  each cluster is split into smaller sub-clusters until all keywords are in
  their own cluster.
- DBSCAN: Density-Based Spatial Clustering of Applications with Noise, which
  groups together keywords that are closely located in feature space.

Ugh, so much to work through for keyword clustering again. I've done it before,
but my current day-job work is not calling for clustering at the moment. It may
be calling for histogram keyword extraction, so I got that done using Yake
KeywordExtractor. If I need to explain it, it's on this page:

https://liaad.github.io/yake/

When work gets started today I should be ready to demonstrate performing
extractions over the entire data-set, such as URLs and titles. That's really in
the bag already based on the work I did yesterday and over the weekend.

Be ready to discuss.

There are several steps for processing keywords, and it's important to note
that they each need slightly different text-preparation. For example, if you're
looking for commonly used or important keyword themes, the text directly
extracted from an HTML page's "body copy" alone might not suffice. Very
important keywords are actually in the title tag, which do not automatically
occur in the body element, so a soup.get_text() is particularly vulnerable to
missing important page themes.

It's also worth noting that soup.get_text() gets rid of too many spaces,
appending words together as it strips out tags. It's better to control the
insertion of a space between every tag-stripped element yourself:

I've done really good work with these lambda functions that look just like
applied text-processing.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/the-critical-juncture-with-ai-my-next-steps/">The Critical Juncture With AI & My Next Steps</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/thinking-through-python-google-photos-sorter/">Thinking Through Python Google Photos Sorter</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul></ul>