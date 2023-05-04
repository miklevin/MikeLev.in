---
date: 2023-02-01
title: Numbering Weeks from UTC-Zero Vs. Your Birthday
headline: Deciding the Best Way to Chunk Time for a Google Photos Querying Project
description: I'm trying to decide the best way to break up my Google Photos querying project into chunks of time. Should I use weeks measured from Unix Timestamp or from my own birthday? I'm now considering writing my own code, as I'm losing faith in the code I was given from ChatGPT. Read more to find out how I'm tackling this project.
keywords: Google Photos, Unix Timestamp, Birthday, Chunk Time, Code, API, Documentation
categories: api, google photos
permalink: /blog/numbering-weeks-from-utc-zero-vs-your-birthday/
layout: post
---


February 1st, wow! Time keeps on ticking, ticking, ticking into the future.

It's funny that the mental block I'm stuck on with my Python Jupyter work is
how to chunk time for Google Photos querying purposes. I am fairly set on
measuring time in weeks so that the chunking can let you process a week at a
time, tagging and deduping your Google Photos. A week seems just about right. A
day, even though the database keys would be more obvious as you can use exact
date, would make the task look too huge because each database key will probably
also manifest as a directory. A directory of photos for every day is too many
to click into, do your thing, back out and move to the next day. And chunking
photos based on months would be too many pictures per folder. Week it is. But
from where to begin numbering?

Does everyone number their weeks differently based on their birthday? Or does
everyone start numbering week 1 from Unix Timestamp. What is Unix Timestamp
time?

Unix Timestamp is a format for representing time and date as a single number,
which represents the number of seconds that have elapsed since January 1st,
1970 at 00:00:00 UTC.

It was introduced as a standard way of representing time across different
systems and programming languages, as it provides a single point of reference
for time and date. The Unix Timestamp starts on January 1st, 1970, at 00:00:00
UTC, which is the "epoch".

The day of the week for the start of the Unix Timestamp was Thursday.

The fact that UTC starts on a Thursday is interesting. Week 1 will not be an
exact week whether we choose that as universal start time or a birthday. Let's
write the code so that it could work either way.

Put your best foot forward and finish that tweet that's stuck in draft.

Wow, I may be getting some good advice from ChatGPT:

```python
import os

from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build

def create_album(album_name):
    # Authenticate the user
    credentials = Credentials.from_authorized_user_file(os.environ['CREDENTIALS_FILE'])

    # Build the Google Photos Library API client
    service = build('photoslibrary', 'v1', credentials=credentials)

    # Create the album metadata
    album_metadata = {'album': {'albumType': 'album', 'productUrl': '', 'isWriteable': True, 'albumMetadata': {'albumTitle': {'text': album_name}}}}

    # Call the API to create the album
    album = service.albums().create(body=album_metadata).execute()

    return album

def add_photos_to_album(album_id, media_item_ids):
    # Authenticate the user
    credentials = Credentials.from_authorized_user_file(os.environ['CRENTIALS_FILE'])

    # Build the Google Photos Library API client
    service = build('photoslibrary', 'v1', credentials=credentials)

    # Call the API to add the media items to the album
    service.mediaItems().batchAdd(albumId=album_id, body={'mediaItemIds': media_item_ids}).execute()
```

I'm having less and less confidence with the code ChatGPT gives me. When it
doesn't work I have to debug somebody else's code. When I cobble it together
from API documentation, it might not work right away, but at least I'm
debugging my own code, based on more recent documentation to boot!


<div class="post-nav"><div class="post-nav-next"><a href="/blog/the-road-to-microsoft-semi-independence">The Road to Microsoft Semi-Independence</a><span class="arrow">&nbsp;&rarr;</span></div> &nbsp; <div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/the-crazy-old-batch-files-were-right">The Crazy Old Batch Files Were Right</a></div></div>
## Categories

<ul>
<li><h4><a href='/api/'>API</a></h4></li>
<li><h4><a href='/google-photos/'>Google Photos</a></h4></li></ul>