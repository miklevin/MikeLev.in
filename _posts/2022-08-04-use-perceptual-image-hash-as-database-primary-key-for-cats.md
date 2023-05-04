---
date: 2022-08-04
title: Use Perceptual Image Hash as Database Primary Key for Cats
headline: Switching to pip install huey - Using Perceptual Image Hash to Store Cat Data in SQLite3 Database
description: I switched up my pip install scheduler to pip install huey and used Python PIL and ImageHash libraries to calculate a perceptual image hash for each cat. This hash was used as the filename and primary key for a shared SQLite3 database, which I then accessed from a Windows system in JupyterLab Desktop. Check out my blog post to see how it all worked out!
keywords: Perceptual Image Hash, Database Primary Key, Cats, pip install scheduler, pip install huey, Python PIL, ImageHash, SQLite3, Windows, JupyterLab Desktop, Linux, Hosts, Containers, Jupyter Notebook
categories: linux, jupyter notebook, containers, cats
permalink: /blog/use-perceptual-image-hash-as-database-primary-key-for-cats/
layout: post
---


Next step? Switch pip install scheduler to pip install huey!

But first! I started showing Python persistent dictionaries yesterday using
sqlitedict and sqlite3. I eluded to the fact that:

- The "This Cat Does Not Exit" images I'm downloading could go into a database
- The ***primary key*** for that cat record could be a perceptual image hash
- Showing all the database keys would be the same as showing image thumbnails
- Because the primary key is a perceptual image hash, it will naturally dedupe

And it's done. I captured the session for your YouTube viewing pleasure. Go
through this video and you'll see how we:

- Use the Python PIL and ImageHash libraries to calculate a perceptual image
  hash for each cat
- Use that image hash as the new filename for the cat, replacing sequential
  numbering like cat1.jpg, cat2.jpg
- Use that image hash as the database primary key in a SQLite3 database
- Put that SQlite3 database on a location shared by Windows, Linux, Hosts and
  Containers
- Access that SQLite3 database from a Jupyter Notebook on a Windows system in
  JypyterLab Desktop
- Step through the database and display the cat images from the Notebook

{% include youtubePlayer.html id="usBoZ38Exak" %}


<div class="post-nav"><div class="post-nav-next"><a href="/blog/use-python-decorators-for-linux-service-scheduling">Use Python Decorators For Linux Service Scheduling</a><span class="arrow">&nbsp;&rarr;</span></div> &nbsp; <div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/lightweight-python-data-pipelining-with-huey-to-replace-scheduler">Lightweight Python Data Pipelining With Huey (to Replace Scheduler)</a></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/jupyter-notebook/'>Jupyter Notebook</a></h4></li></ul>