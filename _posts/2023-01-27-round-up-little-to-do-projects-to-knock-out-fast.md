---
date: 2023-01-27
title: Round Up Little To-Do Projects to Knock Out Fast
permalink: /blog/round-up-little-to-do-projects-to-knock-out-fast/
headline: "Creating My Own Website: Joining Me On My Journey to the Instapaper API!"
description: I'm creating a version of my projects on my own website, starting with the Twitter API and then hitting the Instapaper API to create an RSS feed on my blog. To do this, I'll need an Instapaper API key and the requests library in Python. Come join me on my journey as I make a GET request to the Instapaper API!
keywords: Round Up, Little To-Do Projects, Knock Out Fast, Twitter API, Instapaper API, RSS Feed, Instapaper API Key, Requests Library, Python, GET Request
categories: python
layout: post
---

Lets work our way through every side-project while ChatGPT is still free. Round
up my content from around the web and make a version on my own website. Whether
or not you publish (re-publish) it.

- Hitting Twitter API (done)
- Hitting Instapaper API
- Making RSS feed on my blog

## How do I get all my Instapaper content with Python?

You can use the Instapaper API to retrieve your content from Instapaper using Python. Here are the basic steps:

1. Sign up for an API key from Instapaper.
1. Install the requests library in Python.
1. Use the requests library to make a GET request to the Instapaper API to retrieve your content.
1. Parse the response in json format to extract the content you need.
1. If you are using the OAuth authentication for Instapaper API, you will need to pass your OAuth token and secret along with your request.

Here is an example of how you can use the requests library to retrieve your
Instapaper content:

```python
import requests

# Set up authentication
api_key = "YOUR_API_KEY"

# Make the request
response = requests.get("https://www.instapaper.com/api/1/bookmarks/list", auth=(api_key, ""))

# Parse the response
data = response.json()

# Extract the content
for item in data["bookmarks"]:
    print(item["url"])
```

---

Okay, so I've got Instapaper documented.


## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li></ul>