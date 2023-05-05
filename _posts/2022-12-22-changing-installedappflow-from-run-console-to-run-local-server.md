---
date: 2022-12-22
title: Changing InstalledAppFlow from run_console() to run_local_server()
headline: Successfully Connecting Google Analytics GA4 and Retrieving Organic Traffic Data in Linux JupyterLab Across WSL
description: I spent the day working on a code project that involved connecting to Google Analytics GA4, updating my library ohawf for OAuth2 authentication and changing the InstalledAppFlow flow. After a long session, I'm proud to say I got it to work in Linux JupyterLab across WSL. Read my blog post to find out more about my journey and how I achieved success.
keywords: Google Analytics GA4, OAuth2, InstalledAppFlow, run_console(), run_local_server(), Linux JupyterLab, WSL, Organic Traffic
categories: wsl
permalink: /blog/changing-installedappflow-from-run-console-to-run-local-server/
layout: post
---


Today's work is going to be adding a single line to the end of a list in Google
Sheets. Everything I'm going to do for Pipulate is going to start out as a
long, rambling post here. I think everything through out loud.

I did a nice piece of work yesterday, figuring out how to connect to Google
Analytics GA4. It wasn't easy. It looks like it's going to be easy because when
you search on the Google Query Explorer, you get the GA4 Query Explorer which
is like the old UA Query Explorer.

Well, I'm having problems figuring out how to use GA4 to get to organic
traffic. The GA4 Query Explorer is less than helpful.

To get organic traffic data from Google Analytics using the
google-analytics-data library, you will need to install the library and
authenticate with the Google Analytics API. Here's an example of how you can
retrieve the organic traffic data for a given time period:

```python
import google.auth
from google.analytics.data_v1alpha.client import Client

# Set the account, property, and view IDs for your Google Analytics account
ACCOUNT_ID = '12345678'
PROPERTY_ID = 'UA-12345678-1'
VIEW_ID = '123456789'

# Set the start and end dates for the time period you want to retrieve data for
start_date = '2022-01-01'
end_date = '2022-01-31'

# Set the metrics and dimensions you want to retrieve
metrics = ['sessions']
dimensions = ['channelGrouping']

# Set the filter to only include organic traffic
filters = 'channelGrouping==Organic Search'

# Authenticate with the Google Analytics API
creds, _ = google.auth.default()
client = Client(credentials=creds)

# Use the Google Analytics Data API to retrieve data for the specified time period
response = client.reports().batch_get(
    body={
        'reportRequests': [
            {
                'viewId': VIEW_ID,
                'dateRanges': [{'startDate': start_date, 'endDate': end_date}],
                'metrics': [{'expression': m} for m in metrics],
                'dimensions': [{'name': d} for d in dimensions],
                'filtersExpression': filters
            }
        ]
    }
).execute()

# Print the data
if 'reports' in response:
    report = response['reports'][0]
    rows = report.get('data', {}).get('rows', [])
    for row in rows:
        dimension_values = row.get('dimensions', [])
        metric_values = row.get('metrics', [])[0].get('values', [])
        print(f'Organic traffic: {metric_values[0]} sessions')
else:
    print('No data found')
```

This code will print the number of sessions for organic traffic for the
specified time period. You can modify the metrics and dimensions variables to
retrieve other data, such as pageviews or user demographics. You can also use
the filtersExpression parameter to filter the data by other criteria, such as
specific pages or countries.

Wow today turned out to be a pretty marathon session. I updated my ohawf
library which is for Google OAuth2 authentication. I had to upgrade from nbdev
to nbdev 2. I also had to change the InstalledAppFlow flow from to
run_console() to run_local_server(). It's a small miracle it works in the Linux
JupyterLab across WSL. Wow.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/an-essay-on-modern-seo-a-call-to-pipulate/">An Essay on Modern SEO. A Call to Pipulate.</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/a-place-to-put-things/">A Place to Put Things</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/wsl/'>WSL</a></h4></li></ul>