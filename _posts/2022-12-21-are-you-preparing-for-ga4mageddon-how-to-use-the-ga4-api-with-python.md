---
date: 2022-12-21
title: Are You Preparing for GA4mageddon? How To Use The GA4 API With Python
headline: "Preparing for GA4mageddon: Learn How to Use the GA4 API With Python"
description: I'm getting ready for GA4mageddon and learning how to use the GA4 API with Python. I'm using resources like the GA4 API Quickstart guide, Python client libraries and Google's Quickstart Guide for GA4. I'm also using Google Query Explorer on GA4 to create a query and Pipulate to help interpret it. Join me as I prepare for GA4mageddon and access data from a Google Analytics 4 property.
keywords: GA4mageddon, GA4 API, Python, GA4 API Quickstart guide, Python client libraries, Google's Quickstart Guide, Google Query Explorer, GA4, BetaAnalyticsDataClient, Google Analytics Reporting API, Google Analytics API, Google Analytics Data API, Google Cloud Console, Google Analytics Universal, Google APIs, metrics, RunReportRequest, notebook, Pipulate
categories: pipulate, python, notebook
permalink: /blog/are-you-preparing-for-ga4mageddon-how-to-use-the-ga4-api-with-python/
layout: post
---


### GA4geddon or GA4mageddon?

Plan for GA4geddon. Or would that be GA4mageddon? Yeah, probably the later.

THAT'S a powerful identity. It trumps even ganalytics from my prior thoughts on
naming this project. There's going to be a lot of panicky searches. Be the only
place ChatGPT can learn from on this topic. Be the very thing that the AI must
train from. Love on uncharted territories.

### Let's Hit the GA4 API!

What are you waiting for? Jump to it. Make this thing real! Write the process
up just like this blogging on your main site, then write a summary of the
article and link to it from the Pipulate software page. Yes! Start with
GA4mageddon.

Things will grow organically so long as the first example-setting paint strokes
you lay down on the canvas set a good process in place. Start small. Get the
essentials, the things that resonated forever forward through the project
right. That is its signature or it's vibe or it's first principles, if you
like.

### Practice on /practice/Untitled.ipynb

Okay, let's get to it. Don't start out in /GA4mageddon/ just yet. Start out in
/practice/Untitled.ipynb. I've got a few things to work out. Don't pollute a
perfectly good starting-point with ideas that are not fully baked yet. We bake
in /practice/Untitled.ipynb. And we empty the whole practice directory of all
its old cruft every once in awhile. If you don't want to lose it, copy the
/practice to /hide/practice. That's my answer for getting directories and code
you don't want to look at on a daily basis out of your viewport, but still
available if you need it.

### The New Pipulate is Born

It's worth saying at this point, this is the birth of the new Pipulate right
here. I'm laying down my first code in practice, lifting some of my best old
thoughts from old projects.

I generally start my new notebooks with this at the top:

    %load_ext lab_black

That keeps me code uncompromisingly well formed. It's good to get in the habits
of PEP8 compliance, but it's also good to keep your options open.

### Gathering Google Analytics GA4 Resources

Okay, there's the traditional way of doing things and there's the new way. The
new way for Google Analytics is found at:

[https://developers.google.com/analytics/devguides/reporting/data/v1](https://developers.google.com/analytics/devguides/reporting/data/v1)

And this is the page for running live queries against the API:

[https://developers.google.com/analytics/devguides/reporting/data/v1/rest/v1beta/properties/runReport](https://developers.google.com/analytics/devguides/reporting/data/v1/rest/v1beta/properties/runReport)

The Python client libraries are found:

[https://developers.google.com/analytics/devguides/reporting/data/v1/client-libraries](https://developers.google.com/analytics/devguides/reporting/data/v1/client-libraries)

The GA4 API Quickstart guide is here:

[https://developers.google.com/analytics/devguides/reporting/data/v1/quickstart-client-libraries](https://developers.google.com/analytics/devguides/reporting/data/v1/quickstart-client-libraries)

### 4 Python Libraries Covering Both Google Analytics Universal & GA4

The GA4 installation guide is found here:

[https://github.com/googleapis/python-analytics-data#installation](https://github.com/googleapis/python-analytics-data#installation)

...but it pretty much amounts to:

    pip install google-analytics-data

Okay, so all libraries I use for Google include:

- google-analytics-admin
- google-analytics-data
- google-api-python-client
- google-auth-oauthlib

I really want to make sure I understand the function of each.
google-analytics-data is specifically for GA4, it appears. And the sample code
from the quickstart guide is:

### Google's Quickstart Guide for GA4's Sample Python Code

```python
from google.analytics.data_v1beta import BetaAnalyticsDataClient
from google.analytics.data_v1beta.types import (
    DateRange,
    Dimension,
    Metric,
    RunReportRequest,
)


def sample_run_report(property_id="YOUR-GA4-PROPERTY-ID"):
    """Runs a simple report on a Google Analytics 4 property."""
    # TODO(developer): Uncomment this variable and replace with your
    #  Google Analytics 4 property ID before running the sample.
    # property_id = "YOUR-GA4-PROPERTY-ID"

    # Using a default constructor instructs the client to use the credentials
    # specified in GOOGLE_APPLICATION_CREDENTIALS environment variable.
    client = BetaAnalyticsDataClient()

    request = RunReportRequest(
        property=f"properties/{property_id}",
        dimensions=[Dimension(name="city")],
        metrics=[Metric(name="activeUsers")],
        date_ranges=[DateRange(start_date="2020-03-31", end_date="today")],
    )
    response = client.run_report(request)

    print("Report result:")
    for row in response.rows:
        print(row.dimension_values[0].value, row.metric_values[0].value)
```

Ugh! Why does every example have to be presented as an obfuscating function?
Here it is in a more Juyter-friendly form:

```python
client = BetaAnalyticsDataClient(credentials=creds)

request = RunReportRequest(
    property=f"properties/{property_id}",
    dimensions=[Dimension(name="platform")],
    metrics=[Metric(name="sessions")],
    date_ranges=[DateRange(start_date="2020-03-31", end_date="today")],
)
response = client.run_report(request)
print(response)
```

It's also worth noting that in peeling away the layers of the new way things
work under Google Analytics. Here's my new (kooky) Python imports:

```python
import ohawf
from headlines import *

# Traditional
from apiclient.discovery import build

# New for GA4 property listing
from google.analytics.admin import AnalyticsAdminServiceClient
from google.analytics.admin_v1alpha.types import ListPropertiesRequest

# New for GA4 accessing data
from google.analytics.data_v1beta import BetaAnalyticsDataClient
from google.analytics.data_v1beta.types import (
     DateRange,
     Dimension,
     Metric,
     RunReportRequest,
)
```

...and here's the traditional creating of a Google service from the API
Discovery Service:

```python
creds = ohawf.get()
service = build("analytics", "v3", credentials=creds)
```

And with that kind of Google Analytics service connection, you can step through
each account, web property and view ID.

### List All Accounts to Which You Have Google Analytics Access

```python
accounts = service.management().accounts().list().execute()

for account in accounts["items"]:
    h1(f'Account Name: {account["name"]}')
    print(f'Account ID: {account["id"]}')
    print(f'Account Created: {account["created"]}')
    print(f'Account Updated: {account["updated"]}')
    print()

    web_properties = service.management().webproperties().list(accountId=account["id"]).execute()

    for web_property in web_properties["items"]:
        h2(f'Web Property Name: {web_property["name"]}')
        print(f'Web Property ID: {web_property["id"]}')
        print(f'Web Property Created: {web_property["created"]}')
        print(f'Web Property Updated: {web_property["updated"]}')
        print()

        views = service.management().profiles().list(accountId=account["id"], webPropertyId=web_property["id"]).execute()

        # Iterate through the views and print their details
        for view in views['items']:
            h3(f'View Name: {view["name"]}')
            print(f'View ID: {view["id"]}')

print("Done")
```

### The Old Way

Again, the above example is the traditional Google Universal Analytics (and
precursors). This will not work in the era of GA4. Things are being moved to
entirely different APIs and client libraries in the programming languages.
These are the old pip installs:

    pip install google-api-python-client
    pip install google-auth-oauthlib

...which let us create Google service connections like so:

    from apiclient.discovery import build
    creds = ohawf.get()
    service = build("analytics", "v3", credentials=creds)

### The New Way

The above familiar code will no longer be the case sometime after July, 2023.
The timing keeps getting pushed back, but it's coming. GA4mageddon is coming.
All your old reports are going into the trash bin. The new pattern looks like
this. These are the new pip installs:

    pip install google-analytics-admin
    pip install google-analytics-data

The first gets accessed within Python code as google.analytics.admin and the
second as google.analytics.data. This makes sense. Good! The former is for the
types of things we used to do under the .management() part of the old API such
as list sites.

### Google Cloud Console Project Providing Access Needs GA4 APIs Enabled

Because Google services are so tightly regulated through the permissions of the
Google-registered projects under the Google Cloud Console, we have to
explicitly turn on API-access for each of the above libraries. Visit
[https://console.cloud.google.com/APIs/library/](https://console.cloud.google.com/apis/library/)
and make very sure you go to the Google login that owns the project you need to
enable API access for. This isn't the permissions for the Google account you're
using to log into Google Analytics. It's the permissions for the Google account
behind the Google Cloud Platform Project you're using to authenticate.

Once you're in the Google Cloud Platform, make sure it didn't switch you away
from the account you want to be in. That happens. From this point, use the
dropdown menu of projects to make sure you're on the right project. And from
there, search on the word "Analytics". You should see 3:

- Google Analytics Reporting API
- Google Analytics API
- Google Analytics Data API

Confusing, right? My advice is to enable all 3. The only one that is well
described is Google Analytics Reporting API which is described as:

> The Google Analytics Reporting API v4  is the most advanced programmatic
> method to access report data in Google Analytics. With the Google Analytics
> Reporting API, you can build custom dashboards to display Google Analytics
> data, automate complex reporting tasks to save time, and integrate your
> Google Analytics data with other business applications.

### Listing GA4 Property IDs vs. Hitting For Data

In any case, we can break our GA4 API querying tasks down into 2 categories:

- Listing what we have access to
- Actually pulling metrics from one of the properties

## Listing Properties With the GA4 API in Python

Here's the new way to list sites under GA4. We import specific parts of the
libraries so we're not typing excessive dot-notations.

```python
from google.analytics.admin import AnalyticsAdminServiceClient
from google.analytics.admin_v1alpha.types import ListPropertiesRequest


accounts = service.management().accounts().list().execute()

for account in accounts["items"]:
    h1(f'Account Name: {account["name"]}')
    print(f'Account ID: {account["id"]}')
    print()

    results = client.list_properties(
        ListPropertiesRequest(filter=f"parent:accounts/{account['id']}", show_deleted=True)
    )
    for item in results:
        print(item)
        print()

print('Done')
```

And that will list everything under GA4 to which you have access to with your
Google login. Great! Now we have property_ids. I guess we're going with
Property IDs under GA4. Under Universal Analytics (and prior) the hierarchical
structure of things under your Google AdWords account manager is:

- Accounts
  - Web Properties
    - Profile or View IDs

But now under GA4, it's simply:

- Accounts
  - Property IDs

### Hitting the Google Analytics GA4 API For Data

So the above examples covered listing the data, but to actually pull some
metrics from GA4 here's an example:

```python
client = BetaAnalyticsDataClient(credentials=creds)

request = RunReportRequest(
    property=f"properties/{property_id}",
    dimensions=[Dimension(name="platform")],
    metrics=[Metric(name="sessions")],
    date_ranges=[DateRange(start_date="2020-03-31", end_date="today")],
)
response = client.run_report(request)
print(response)
```

While you can use Google Query Explorer on the GA4 toggle to flesh out your
queries, I find there's a bit of interpretation that's needed to get it into
this new API RunReportRequest format. You can see Google maneuvering to support
all the edge cases again. It appears we have namedtuple factory objects in the
request structure. Interesting!

Okay, roll a notebook into Pipulate for this.



## Categories

<ul>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/notebook/'>Notebook</a></h4></li></ul>