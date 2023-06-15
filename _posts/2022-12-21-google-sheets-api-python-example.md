---
date: 2022-12-21
title: Google Sheets API Python Example
headline: Populate Data Into a Google Spreadsheet with the Google Sheets API and Python
description: "Learn how to use the Google Sheets API and Python to populate data into a Google Spreadsheet. This project will use the Google APIs released with GA4 and the URL https://developers.google.com/sheets/api/guides/concepts to connect to Google Sheets and capture an easy-to-read example of reading and writing. Follow my step-by-step guide to learn how to do this!"
keywords: Google Sheets API, Python, GA4, Reading, Writing, Populate Data, Google Spreadsheet, Tutorial, Step-by-Step Guide
categories: python, tutorial
permalink: /blog/google-sheets-api-python-example/
layout: post
group: blog
---


Okay, so I've got data from GA4. Whatcha gonna do? Whatcha gonna do is
inevitably populate data in a Google Spreadsheet, am I right? Am I right?
Somewhere along the way, this is going to be a top request from a stakeholder
and often to very great effect. Data being in Google Sheets can both be
consumed directly in row and column format, or it can be used as a data source
for Google Data Studio, now known as Looker. So data can become real in our
lives quickly by dropping it into Sheets. But how? And how most easily?

The least keystrokes? Pandas!

But wait, no! Don't use Pandas just yet if you don't have to. It will be a few
more keystrokes, but the increased control will be worth it.

Regardless of the radical new Google APIs we're seeing as a result of GA4, it
is unlikely these old familiar patterns will be going away anytime soon. And
such is our first step in connecting to Google Sheets:

```python
import ohawf
from apiclient.discovery import build

creds = ohawf.get()
service = build('sheets', 'v4', credentials=creds)
```

But beware! Even though I'm going to finish this project this way, it's easy to
find warnings on pages such as
https://github.com/googleapis/google-api-python-client
saying

> The maintainers of this repository recommend using Cloud Client Libraries for
> Python, where possible, for new code development...

The URL they're pointing to is https://github.com/googleapis/google-cloud-python
This page explains it https://cloud.google.com/apis/docs/client-libraries-explained
They say:

> Cloud Client Libraries are the recommended option for accessing Cloud APIs
> programmatically, where available. Cloud Client Libraries use the latest client
> library model and:

- Provide idiomatic code in each language to make Cloud APIs simple and intuitive to use.
- Provide a consistent style across client libraries to simplify working with multiple Cloud services.
- Handle all the low-level details of communication with the server, including authenticating with Google.
- Can be installed using familiar package management tools such as npm and pip.
- In some cases, give you performance benefits by using gRPC. For more information, see the gRPC APIs.

So even though I'm documenting "the old ways" here, they're going away
eventually. Until they do, they're a highly useful tool and known patterns.

So while we so it the old way, the URL for Google Sheets is https://developers.google.com/sheets/api/guides/concepts

Wow are Google's examples obfuscated (as usual) on https://developers.google.com/sheets/api/guides/values

Let's capture the bare minimum easy-to-read example of reading and writing a
range of data. Here's writing some data into a Google Spreadsheet.

```python
sheet = service.spreadsheets()
spreadsheet_id = f"{sheetid}"
range_names = "A1:B2"

values = [("foo", "bar"), ("spam", "eggs")]
body = {"values": values}
result = (
    service.spreadsheets()
    .values()
    .update(
        spreadsheetId=spreadsheet_id,
        range=range_names,
        valueInputOption="USER_ENTERED",
        body=body,
    )
    .execute()
)
```

And you can read the data back out again with:

```python
result = (
    service.spreadsheets()
    .values()
    .batchGet(spreadsheetId=spreadsheet_id, ranges=range_names)
    .execute()
)
ranges = result.get("valueRanges", [])
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/are-you-preparing-for-ga4mageddon-how-to-use-the-ga4-api-with-python/">Are You Preparing for GA4mageddon? How To Use The GA4 API With Python</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/wsl-lxd-let-us-run-generic-linux-server-build-scripts-without-docker/">WSL & LXD Let Us Run Generic Linux Server-Build Scripts Without Docker</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/tutorial/'>Tutorial</a></h4></li></ul>