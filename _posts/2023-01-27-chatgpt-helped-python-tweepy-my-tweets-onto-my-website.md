---
date: 2023-01-27
title: ChatGPT Helped Python Tweepy my Tweets Onto My Website
headline: Successfully Pulled 3K of My 11K Tweets Using Python and ChatGPT!
description: I used the Python package Tweepy and the ChatGPT assisted coding session to successfully access the Twitter API and pull 3K of my 11K tweets since 2007. I've posted the code on my website, and I've also created a CSV file of all the tweets I pulled. Come check out my website to see how I did it!
keywords: ChatGPT, Python, Tweepy, Twitter, API, Coding, Session, Website, CSV, File, Code, Pull, 3K, 11K, 2007
categories: python, twitter, csv, chatgpt, api, coding
permalink: /blog/chatgpt-helped-python-tweepy-my-tweets-onto-my-website/
layout: post
---


It's amazing to me that I don't have it documented here in this journal yet,
but a few days ago, I hit the Twitter API using the Python tweepy package and
it went well. I only got about 3K of my 11K tweets since 2007, but it's a
start. Here's the page [https://mikelev.in/tweets/](https://mikelev.in/tweets/)
and here's the code. It's going to need some cleanup, but it's a start.

{% include youtubePlayer.html id="qwdKZ8Ge9uk" %}

## ChatGPT Assisted Coding Session, Hitting Twitter API

```python
import tweepy
import pandas as pd
from sqlitedict import SqliteDict as sqldict

with open("creds/twitter.txt", "rt") as fh:
    api_key, api_key_secret, bearer_token = fh.read().split("\n")

auth = tweepy.OAuth2BearerHandler(bearer_token)
api = tweepy.API(auth)

username = "miklevin"

# Technique 1
with sqldict("tweets/raw_backfill.db") as db:
    max_id = None
    while True:
        tweets = api.user_timeline(
            screen_name=username, tweet_mode="extended", count=200, max_id=max_id
        )
        if len(tweets) == 0:
            break
        db[str(max_id)] = tweets
        db.commit()
        max_id = tweets[-1].id - 1

# Technique 2
with sqldict("tweets/raw2_backfill.db") as db:
    max_id = 7567832972707979263
    for page in tweepy.Cursor(api.user_timeline, screen_name=username, max_id=max_id).pages():
        if len(tweets) == 0:
            break
        db[str(max_id)] = tweets
        db.commit()
        max_id = tweets[-1].id - 1

with sqldict("tweets/raw2_backfill.db") as db:
    for key in db:
        print(key)

with sqldict("tweets/raw_backfill.db") as db:
    with sqldict("tweets/tweets.db") as db2:
        for max_id in db:
            tweets = db[max_id]
            for tweet in tweets:
                db2[tweet.id_str] = tweet
            db2.commit()

table = []
with sqldict("tweets/tweets.db") as db:
    for i, tweet_id in enumerate(db):
        tweet = db[tweet_id]
        id = tweet.id
        created_at = tweet.created_at
        full_text = tweet.full_text
        url = f"https://twitter.com/miklevin/status/{id}"
        row = (id, created_at, full_text, url)
        table.append(row)

columns = ["id", "created_at", "full_text", "url"]

df = pd.DataFrame(table, columns=columns)

df.to_csv("tweets/tweets.csv", index=False)

front_matter = """---
title: Tweets
group: homepage
permalink: /tweets/
description: A page of all my tweets.
---

"""

with open("../hide/MikeLev.in/tweets.md", "wt") as fh:
    fh.write(front_matter)

with open("../hide/MikeLev.in/tweets.md", "at") as fh:
    for i, row in enumerate(table):
        id, created_at, full_text, url = row
        fh.write(f"\n\n## {created_at}")
        fh.write(f"\n\n{full_text}")
        fh.write(f"\n{url}")
print("Done")
```


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/figuring-out-which-saw-to-keep-sharp/">Figuring Out Which Saw To Keep Sharp</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/round-up-little-to-do-projects-to-knock-out-fast/">Round Up Little To-Do Projects to Knock Out Fast</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/twitter/'>Twitter</a></h4></li>
<li><h4><a href='/csv/'>CSV</a></h4></li>
<li><h4><a href='/chatgpt/'>ChatGPT</a></h4></li>
<li><h4><a href='/api/'>API</a></h4></li>
<li><h4><a href='/coding/'>Coding</a></h4></li></ul>