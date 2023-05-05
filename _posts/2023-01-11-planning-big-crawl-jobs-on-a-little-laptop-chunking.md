---
date: 2023-01-11
title: Planning Big Crawl Jobs On a Little Laptop (Chunking)
headline: Tackling a Million-Page Crawl on One Machine with Momentary Unthrottled Concurrency
description: I recently had a breakthrough in creating a SQLite3 database to capture data from a list of URLs, and now I'm creating a keyword histogram and grouping the pages by keyword themes. I've been assigned a million-page crawl, and I'm tackling it all on one machine with momentarily unthrottled concurrency in chunks. Come read about my journey and how I'm processing the data in finite jobs and moving the chunks off my local.
keywords: Crawl Jobs, Little Laptop, Chunking, SQLite3 Database, Keyword Histogram, Grouping, Million-Page Crawl, Concurrency, Processing, Data, Finite Jobs, Moving Chunks
categories: processing
permalink: /blog/planning-big-crawl-jobs-on-a-little-laptop-chunking/
layout: post
---


Wow, okay. Yesterday's late-night project was to do the http fetching against a
list of URLs. I capture all that data into a SQLite3 database properly using
the URL field as the primary-key and putting the "raw" crawled HTML data into a
BLOB field by passing the insert command as an insert "pattern" plus Python
data tuples. That's the mechanism to get unencoded binary blobs into a SQLite
table. It was a nice little breakthrough. It now resides in Pipulate under the
practice folder named crawl_and_extract.ipynb (no longer
sequential_crawl.ipynb). I now want to do 2 quickies to expand the system:

1. Create a keyword histogram per page
2. Group the pages by keyword themes (using the page's full text)

Fast-forward to 10:00 PM. Wow, intense few days at work. Covering a lot of
ground. Showed my latest crawler tech. Well-received. Got a million-page crawl
to perform. Gonna look at some good data management techniques. I like to crawl
on my local machine that I'm working on, but would also like to farm out to
other machines. Always local. May be Windows laptops with WSL. May be
NAS-hosted Linux instances. Think it through!

Deciding to do it all on one machine, but with momentarily unthrottled
concurrency... in chunks. Get your list of URLs before-hand and crawl the data
in N-sized chunks and spew them right onto the drive. Process chunk-by-chunk
and optionally even move them off your local drive and onto your NAS while you
go. Nice, sequential finite jobs. Even concurrency gets mapped onto sequential
chunks, haha!


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&nbsp;&rarr;</span><a href="/blog/sorting-by-histogram-intersections-with-kmeans-clustering/">Sorting by Histogram Intersections with KMeans Clustering</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/joining-urls-across-ga-gsc-majestic/">Joining URLs across GA, GSC & Majestic</a><span class="arrow">&larr;&nbsp;</span></div></div>
## Categories

<ul>
<li><h4><a href='/processing/'>Processing</a></h4></li></ul>