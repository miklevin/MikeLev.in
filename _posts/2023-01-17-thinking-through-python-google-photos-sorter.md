---
date: 2023-01-17
title: Thinking Through Python Google Photos Sorter
headline: Making Moving Images from Google Photos to a Home Cloud NAS Easier with Python Sets and Jupyter Notebooks
description: I'm creating processes to gradually move images from Google Photos to a home cloud NAS in a fun and addicting way. I'm using Python sets to identify and remove duplicates, chunking data to create indexed sequential namedtuples for each week of my life up to 100 years, and creating thumbnail folders when I'm ready.
keywords: Python, Google Photos, Sorting, Duplicates, Namedtuples, Jupyter Notebooks, Windows, Big Data, Small Resources, NAS
categories: jupyter, google, microsoft, python
permalink: /blog/thinking-through-python-google-photos-sorter/
layout: post
group: blog
---


Gradually move images from Google Photos to home cloud NAS, scrubbing them off
the cloud bit by bit as you go.

To do it this reasonably sized & organized chunks, making it make fun & easy to
dedupe and organize as thumbnails pass through your local machine.

To prevent that overwhelmed feeling of having to much to do, and rather to
prepare it with processes that trigger your dopamine reward systems. Make
slurping your images off the cloud fun and addicting.

To this end, we must endeavor:

To have the "big files" never actually reach your local machine, but rather
only thumbnails whose file names are also perceptual image hashes so that files
manipulation is both fast and a good mechanism for identifying and removing
duplicate images.

Preserve all the lossless resolution, meta data, original filenames, original
dates created and the like. Store all that data for each image into the
thumbnail metadata for each image. Thumbnails beacons a metadata backup of
original source images.

The thumbnails on the local machine, usually a laptop, are so small that your
entire Google image library is not a problem to store locally in thumbnail
form. The number of images such a system should be able to handle with ease
should be in the tens of millions.

Local databases with tens of millions of keys aren't necessarily snappy. But
in-memory Python sets that big actually still are. No matter the state of
original files or thumbs, be able to re-zip them back together with a scan of
each. Same source image in will always result  it the same perceptual image
hash filename out. Use this fact to not sweat a lot.

An in-memory set of filenames can always be used for removing duplicates, so
feel free to organize thumbnails into sub folders. Duplication of thumbnails is
not even such a big real. You can harvest "directory-belongings" and then reset
the system by reverting sorting to some default preference.

 I particular state of sorting should be considered that precious, because they
can always be re-created sorting by such-and-such a parameter. If we can figure
out how images belong in galleries based on their original filenames and create
dates, we can just apply that sorting and get original in-gallery sorting back.

The thumbnails will be so numerous that they should never all be dumped into a
single directory for OS performance reasons, even though filenames, perceptual
image hashes as they are, would be a good way to remove duplicates. We will use
in-memory sets for deduplicating purposes. There will always be various means
of sorting thumbnails into sub folders, and popping between different methods
encouraged.

Chunking data as you go, creating lists of images from your Google Photos
library based on date ranges will help mitigate the large number of thumbnails
per folder problem, but not completely. Date chunking only provides one type of
thumbnail-sorting and not necessarily the best.

Sorts can be accomplished based on perceptual hash hamming distance similarity
grouping, histogram similarity grouping, resolution-closeness grouping,
original filename similarity grouping and the like. I have a few of these
implemented already and have a few still to do.

Chunking first by date range works well with API quota limits. We can create
indexed sequential namedtuple, one for every week of our life so far. We know
we want to reach 5200, which is 52 weeks in a year times 100 years. That sets a
good goal — a sort of Y2K on our lives. Making 100 years old is a blessing I
thing humans are meant for.

With your weekly tuples for life in hand, you can spin through the Google
Photos API from the week of your birth forward to find the first week that has
data. The fact that in many cases this predates the existence of Google Photos
does not matter, because photos with older dates may have been added later. So
we're basically scanning to find the oldest photo in your Google Photos,
archived or not.

Each week tuple in your life that has any photos in it will get a thumbnail
folder. But only those weeks with folders will get a thumbnail image. Images in
either the visible library or the archive for that time-period will result in a
folder being created. But the folders are beget created until you're ready to
create thumbnails for that time-period.

While we're designing this with server automation in mind, we're writing it in
Jupyter Notebooks in JupyterLab on a typical Windows laptop — nothing big. The
data may get big, but the computer which is our means of manipulating all that
data remains small. This is exercising in handling big-ish data with little
resources. Step 1: keep source file data elsewhere when you can. A NAS would be
nice.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/keyword-histograms-and-clusters/">Keyword Histograms and Clusters</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/starting-to-ideate-the-idea-capture-device/">Starting to Ideate the Idea Capture Device</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>