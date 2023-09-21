---
date: 2023-01-03
title: YouTube Analytics API Delegation Driving Me to Web Browser Automation
headline: Exploring YouTube Analytics and Reporting APIs and Considering Web Scraping as a Backup
description: I'm attempting to access YouTube Analytics, but the API is proving difficult. After trying to use parameters such as onBehalfOfOwner, I'm getting 403s. I'm now considering web browser automation, and am exploring Microsoft Playwright to automate web browser sessions and capture a manual login. Join me as I explore the possibilities of the YouTube Analytics and Reporting APIs, and consider web scraping as an alternative.
keywords: YouTube, Analytics, API, Delegation, Driving, Web Browser Automation, Parameters, onBehalfOfOwner, 403s, System-Managed Reports, Content Owners, Reports, YouTube, Web Scraping, APIs, Convoluted, Poorly Documented, Microsoft Playwright, Automate, Web Browser Sessions, Login, Load
categories: youtube, microsoft playwright, python
permalink: /blog/youtube-analytics-api-delegation-driving-me-to-web-browser-automation/
layout: post
group: blog
---


Every AI learns from someone. But the one it learns from. My attention turns to
getting YouTube Analytics. Remember to incur your spirit animal, the Roomba on
this one. I remember this work, with delegation and all. It's not easy.

Time to log into YouTube analytics. There appear to be 2 types of APIs, a
specifically YouTube Analytics one and a YouTube Data API:

- https://github.com/youtube/api-samples/blob/master/python/yt_analytics_v2.py
- https://developers.google.com/youtube/v3/getting-started

And on the page about YouTube Analytics, we find the extremely difficult to
read (for me) example:

```python
# -*- coding: utf-8 -*-

import os
import google.oauth2.credentials
import google_auth_oauthlib.flow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from google_auth_oauthlib.flow import InstalledAppFlow

SCOPES = ['https://www.googleapis.com/auth/yt-analytics.readonly']

API_SERVICE_NAME = 'youtubeAnalytics'
API_VERSION = 'v2'
CLIENT_SECRETS_FILE = 'YOUR_CLIENT_SECRET_FILE.json'
def get_service():
  flow = InstalledAppFlow.from_client_secrets_file(CLIENT_SECRETS_FILE, SCOPES)
  credentials = flow.run_console()
  return build(API_SERVICE_NAME, API_VERSION, credentials = credentials)

def execute_api_request(client_library_function, **kwargs):
  response = client_library_function(
    **kwargs
  ).execute()

  print(response)

if __name__ == '__main__':
  # Disable OAuthlib's HTTPs verification when running locally.
  # *DO NOT* leave this option enabled when running in production.
  os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'

  youtubeAnalytics = get_service()
  execute_api_request(
      youtubeAnalytics.reports().query,
      ids='channel==MINE',
      startDate='2017-01-01',
      endDate='2017-12-31',
      metrics='estimatedMinutesWatched,views,likes,subscribersGained'
      dimensions='day',
      sort='day'
  )
```

Ugh, yuck! I just hate this programming style. Let's restate it a little more
clearly in my mind.

```print
import ohawf
from googleapiclient.discovery import build

creds = ohawf.get()
service = build("youtubeAnalytics", "v2", credentials=creds)

query = {
    "dimensions": "day",
    "endDate": "2022-12-31",
    "ids": "channel==MINE",
    "metrics": "estimatedMinutesWatched,views,likes,subscribersGained",
    "sort": "day",
    "startDate": "2017-01-01",
}
result = service.reports().query(**query).execute()

print(result)
```

Hmmm, tearing out even more inessentials, this can be stated as:

```python
import ohawf
from googleapiclient.discovery import build

creds = ohawf.get()
service = build("youtubeAnalytics", "v2", credentials=creds)

result = (
    service.reports()
    .query(
        **{
            "dimensions": "day",
            "endDate": "2022-12-31",
            "ids": "channel==MINE",
            "metrics": "views",
            "sort": "day",
            "startDate": "2022-01-01",
        }
    )
    .execute()
)
print(result)
```

I don't know. Maybe I like the version with a query variable more. Either way,
it should shed some light on how obfuscated the Google examples are to a mind
like mine. Their style only makes sense for Intellisense addicts.

This shows how easily you can switch between viewing key/value pairs as a dict
versus a function or class with named arguments. It's always so much easier for
me to view it as a dict, then to splat them where they need to go.

Alright, that's a good starting point. But now I need to do the queries against
channels that aren't mine. All that delegation stuff.

Oh, yuck! 403s everywhere in my attempts using parameters like onBeahlfOfOwner.
Maybe I should be using Intellisense.

Back off. Look around. Take note. Retry.

From the page:

https://developers.google.com/youtube/reporting

System-managed reports

Supported for content owners who have access to the corresponding reports in
the Reports section of YouTube's Creator Studio.

It might be one of the system-managed reports that I need.

https://developers.google.com/youtube/reporting/v1/reports/system_managed

Web UIs vs. APIs

How or this not a more popular topic? It's time I took it up and made it part
of my mantle. Don't get me wrong. Use the APIs if you can and avoid web
scraping. But if you can't, scrape the Web user interface. Sometimes there's
data there you can't get through an API. Not all of a service's features are
necessarily available in the API, and even when they are sometimes the details
are so convoluted and poorly documented it isn't worth the trouble. So
sometimes we must scrape the web.

 I spent a day looking for how to use YouTube Analytics and YouRube Reporting
APIs. There are 2 APIs that might be used when querying YouTube, explained
https://developers.google.com/youtube/reporting

I now want to think of full automated web browser sessions, I.e. the contents
of a single browser-automation scripts, as consisting of a head, body and
footer sections. Even more ideally, I'd like to think of it as part of Python's
with/open context manager that cleans up after itself and eliminates need for
try/finally gobbledygook on your code. But I can't. Implementation is up to me,
so I control the close.

I may actually use the extended code that the context manager spares you from
dealing with as the starting point on this project. An entire automated web
session against a single site is what goes in the try/finally arrangement. The
opening connection phase has the login and explicit saving of a user session
containing logged-in status to local storage. It then closes the browser.

As it goes into the inner portion of the try section, it will iterate through a
loop, changing parameters on a browser invocation. However on this inner loop,
the browser is not closed per loop. By using Microsoft Playwright in headless
mode, it should be one of the big speed gains by recycling the open and present
on memory but not displaying on the screen logged-in session. It's page
build-up and distraction that's costly, not just changing the URL, or parameter
arguments on a URL with a querystring.

Ugh! Yeah, I'm completely convincing myself. The trouble I'm encountering with
mystery parameters with mystery conditions of login with mystery choice of APIs
to use, I'm chased thoroughly away from the Google Analytics OR Reporting APIs
for getting YouTube data. No my friend, I'm about to scrape.

So any waning interest I had in my own blogpost here is swept aside as I get
into technical implementation. A different part of the brain is activated. 1,
2, 3... 1? I need a 3-phase approach based in JupyterLab.

You've got to be really excited about the story you're telling. And it's
moments like this that re-ignite it in your own mind. Okay, so first, I've got
some really great code for capturing a manually performed login and loading it
again. I used it on a previous project, and it's a million$ bit of magic.

    python -m playwright codegen --target python-async --save-storage keep.db --viewport-size 1400,1400
    python -m playwright codegen --target python-async --load-storage keep.db --viewport-size 1400,1200


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/per-week-tuples-as-a-google-photos-project/">Per Week Tuples as a Google Photos Project?</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/data-jockeying-101/">Data Jockeying 101</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/youtube/'>YouTube</a></h4></li>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>