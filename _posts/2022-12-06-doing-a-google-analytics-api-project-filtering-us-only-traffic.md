---
date: 2022-12-06
title: Doing a Google Analytics API Project (Filtering US Only Traffic)
headline: Learning to Connect to Google Analytics via API - Filtering US Only Traffic
description: I'm building a project to connect to Google Analytics via their API, and I've written code to retrieve metrics such as users, sessions, bounce rate, average session duration and pages/session. I'm also creating a text file with a list of profile IDs, segments and start/end dates for the past year, and I've written a loop to generate the start and end dates for each month. Follow along with my project to learn more!
keywords: Google Analytics, API, US, Traffic, Metrics, Users, Sessions, Bounce Rate, Average Session Duration, Pages/Session, Segment, Organic Search, Profile IDs, Start Date, End Date, Loop, Pip Install
categories: loop, api, google analytics
permalink: /blog/doing-a-google-analytics-api-project-filtering-us-only-traffic/
layout: post
---


My work stalled out a bit as Microsoft shifted to Linux Graphics and systemd
support under WSL2 on Windows 10. I had to stop the old hack ways I was doing
this and embrace the formal Microsoft way now that it's backported to Windows
10. Little things like this take some time to retool. And that distracts you
from the day-to-day work whose complication-level multiplies because now you're
doing it on a volatile platform. Ugh, okay.

In such circumstances, we have to put the love in it. Yesterday I got hung up
on a pip install with the -e option (for editable) not working in DrinkMe Linux
and it got me to thinking perhaps too much about why the terminal under Jupyter
isn't coming up with the cursor for the Python 3.11 venv. Maybe it doesn't run
the .bash_profile? Perhaps use a source activate in the install script. Okay,
done.

Now do a test install... ugh, yes one more. You can afford it. An installable
instance of a pip install where you (I) can continue development is an
important step. It's a transition to valuable videos and stuff to come. Okay,
so... save and quit.

I have edited out all pip install --editable stuff and I will do that manually.
I still want ohawf installed with a git clone but also have that repo instance
the one that's used when I pip install it. And that's what the -e extension of
pip is for. However, I'm having difficulty getting it working that way under my
DrinkMe Linux installer.

One interesting thing now since Microsoft added systemd to WSL2 under Windows
10 that I know JupyterLab will be served as a Linux daemon only if my journal
(or some other Linux terminal) is loaded. So if I see my vim journal,
JupyterLab should be the next screen to the right.

Okay, let's get this party started. On of the most common things SEOs need to
do is to connect to Google Analytics. My latest project has me connecting to
Google Analytics and for that we're going to need Google Authentication.

First of all I need to regain confidence in where my Python executable is
being loaded from. That can be done with this bit of code in a Jupyter
Notebook. Remember there's an implied "print" function on the bottom line of a
block of Jupyter code.

    import sys
    sys.executable

And that confirms:

    '/home/ubuntu/py311/bin/python3.11'

Okay the pip installable ohawf package has already been git cloned into
~/repos. To make it install from that location under JupyterLab, this can be
done right inside a code block from JupyterLab:

    pip install -e /home/ubuntu/repos/ohawf

Something's up and I just need to leave it alone. I can't do pip install
--editable right now for some reason. But a normal pip install works fine.
Strange. Well put ohawf back in requirements.txt for now.

Ugh, it's working with a normal pip install. Go with that for now.

    import ohawf
    creds = ohawf.get()

This triggers off the type of Web browser based authentication where you
copy/paste a token back to the Notebook. It's a deprecated or depreciated or
whatever method. That's a big reason I want it installed --editable, but I need
to get some work done.

Let's connect to some Google Analytics. The next step is almost always:

    from apiclient.discovery import build

And then there's this magic line:

    ga_service = build('analytics', 'v3', credentials=creds)

Okay now we have the service connection to Google Analytics. That's much of the
problem right there. The next side of the problem is the kooky JSON-based API
where a request is a kooky JSON-shape and the response is a kooky JSON-shape.
That's how many of the Google APIs work.

I need these metrics: Users	Sessions	Bounce Rate	Avg. Session Duration	Pages /
Session. I'm going to throw in organic search as well because I need to use a
segment parameter in here. Currently it's set to the organic segment ID (-5)
but it's really a placeholder for later.

    ga_service = build("analytics", "v3", credentials=creds)
    get = ga_service.data().ga().get

    metrics = [
        "ga:users",
        "ga:sessions",
        "ga:bounceRate",
        "ga:avgSessionDuration",
        "ga:pageviewsPerSession",
    ]
    metrics = ",".join(metrics)

    def ga(brand, gaid, segment, start_date, end_date):
        if segment:
            segment = f"gaid::{segment}"
        req = get(
            ids=f"ga:{gaid}",
            start_date=str(start_date),
            end_date=str(end_date),
            metrics=metrics,
            segment=segment,
            filters="ga:country==United States",
            samplingLevel="HIGHER_PRECISION",
        )
        resp = req.execute()
        return resp

Yes, that's looking pretty and can readily become the Google Analytics template
code example in DrinkMe Linux. Now forge on. I also need segment IDs to be
used!

Okay, so I need a text file with a list of profile IDs and segments.

Okay, so what's the list of GAIDs I'm working off of? Oh well what's the list
of properties?

And now to create start date, end date pairs for month-by-month back for a
year:

    for x in range(12):
        aday = datetime.now().date().replace(day=1) - relativedelta(months=x)
        bday = aday + relativedelta(months=1) - relativedelta(days=1)
        print(aday, bday)

Yup, that'll do it.

<div class="post-nav"><div class="post-nav-next"><a href="/blog/when-are-we-not-adapting-to-new-realities">When Are We Not Adapting to New Realities?</a><span class="arrow">&nbsp;&rarr;</span></div> &nbsp; <div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/python-playwright-codegen-and-playwright-inspector-tools">Python Playwright CodeGen and Playwright Inspector Tools</a></div></div>
## Categories

<ul>
<li><h4><a href='/loop/'>Loop</a></h4></li>
<li><h4><a href='/api/'>API</a></h4></li>
<li><h4><a href='/google-analytics/'>Google Analytics</a></h4></li></ul>