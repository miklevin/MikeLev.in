---
date: 2022-12-26
title: An Essay on Modern SEO. A Call to Pipulate.
headline: "Exploring SEO in the Modern Market: A Journey of Data Analysis and Automation"
description: I'm exploring the effectiveness of SEO in the modern market, using data from Google Search Console and Google Analytics. I'm utilizing Python, Jupyter, and linear regression to analyze my website's keyword trends and create automated clarity-inducing reminders. By doing so, I can better understand what's driving people to my website and optimize it for success. Join me on my journey as I take a deep dive into the basics of SEO and website optimization.
keywords: Modern SEO, Pipulate, Google Search Console, Google Analytics, Python, Jupyter, Linear Regression, Website Optimization, Trends, Keywords, Graph, Quantify, Search Console, Investigate, Optimize
categories: jupyter, seo, pipulate, python, google
permalink: /blog/an-essay-on-modern-seo-a-call-to-pipulate/
layout: post
---


SEO stands for "Search Engine Optimization" in the field of marketing and
advertising. If you write it, they will come. You are assured a certain amount
of reliable, recurring visitors to your website merely by virtue of existing.
Or are you?

## Does SEO still work?

Am I still getting traffic by virtue of merely existing? What is quality,
anyway? Yup, we're relying on AI more than PageRank now I think. Or we soon
will be. So is all that an old type of "organic" traffic dying off? Do we all
now just have to pay for traffic, or be one of those few websites somehow
deemed best? What does the data in our website tell us?

### Looking For Data

How do we know? The default dashboards of Search Console and Google Analytics?
Custom reports? Particular drill-down paths through the menus? How do you know,
and even then, how do you know what to do as a result of charts and graphs and
exportable lists? What questions are we even asking, and to whom do we ask them
and how?

### We Find Google GSC & GA APIs

We ask our questions of Google, of course. Usually through their GSC or GA
APIs. With simple expression, and usually through Python and in Jupyter. Also
in a way where we could make it re-send us that answer again with the data of a
new day. Real-time's great, but bat ain't bad, 'cause we all have to sleep.
Think wake-up emails of your bidding.

## Automatic Clarity-inducing Reminders

That's what we seek here, right? Clarity. A wake-up call you rigged to ensure a
good day. Actionable and repeatable. Got a concept? Here's some code. Flesh it
out, refine it and customize. Send it as an email. Throw it into a scheduler.
The email is no more than you need and no less than a satisfactory answer.
80/20-rule.  Strike the right balance of tech liability and perfection.

### Expressing Inquiries With Ease

Eventually the language of expression fades into the background as a
transparent tool. You forget about a hammer while hammering or else you'll miss
the nail. SEO, you say? What are the basics today? Express it simply.

### Looking For Trends

Wow's my site doing over time? So the data coming back is almost certainly
going to be time-series. We're going to want to look at trend-lines for stuff.
But what stuff? Which keywords are leading people to my site through search, of
course! What are the landing pages? How many are influx of new people and how
many are folks I see all the time at my site?

## First the Google Search Console API

Answering this is usually a Google game these days. You use Google Search
Console for SEO data and Google Analytics for Users and Sessions. PageViews are
on the way out, but we'll defer the GA discussion for later. Let's first focus
on GSC. GSC only returns the 3 metrics, impressions, clicks and position. It
also returns ctr (click-through rate), but that's just a ratio derived from
impressions and clicks. Well, let me just show you a bit of response...

    {'rows': [{'keys': ['pipulate'],
       'clicks': 17,
       'impressions': 72,
       'ctr': 0.2361111111111111,
       'position': 3.0694444444444446},
      {'keys': ['levinux'],
       'clicks': 4,
       'impressions': 42,
       'ctr': 0.09523809523809523,
       'position': 5.023809523809524},
    ...
      {'keys': ['youtube xvid'],
       'clicks': 0,
       'impressions': 11,
       'ctr': 0,
       'position': 11.818181818181818},
      {'keys': ['تولبار اليكسا للفايرفوكس'],
       'clicks': 0,
       'impressions': 13,
       'ctr': 0,
       'position': 19.846153846153847}],
     'responseAggregationType': 'byProperty'}

The dictionary in the response containing 'keys' as a key is followed by a list
of keywords, a list that's usually 1 long. Sometimes, there's a URL or Platform
or Geo data in there, depending on the dimensions included in your request. So
reaching into these objects can be bit tricky, parsed by fancy combinations of
list comprehensions, lambdas and mapping. This site will provide plenty of
examples.

### Looking For Trends

Okay, so what keywords are leading people to my site? What are the trends?
Where am I on the rise? Which keywords and landing pages are those? Where am I
on the decline? Just give me the highlights — with only 20% of the effort I
imagine could go into a project like this, how do I get 80% of the benefit?

### Trends, The Basics

Don't fail to do the basics before the advanced stuff. There is much you can
visualize with just your GSC data and matplotlib in Jupyter. It's not very
sexy, but it proves you're competent. Take in a bunch of X & Y values, and plot
them in a grid. Make the dates on your X-axis readable. Make the metric used on
the Y-axis clear.

### Automatically Emailing Actionable Findings

Sure you can do that in Excel, but can you automate the sending of that graph
in email with no webserver in the picture and no proprietary software? If you
can provide net connection and Linux machine, you've got site trend monitoring
as an ongoing SEO service you could offer, without depending on paid-for 3rd
party software or services. A few good Python scripts and you can deliver what
most small to medium size businesses need to know to optimize their sites.
Let's break it down.

### The Basics Is Linear Regression

Graph one line. Then try quantifying a trend with a linear regression. Sort a
dataframe by the steepest negative and positive line-slopes. Find the most
in-danger and up-and-coming tends. Look at those keywords and landing pages.
You can use your sites own Search Console data to do these exercises. You don't
rely on all that much to do such informative and actionable investigations like
this. This is the basic minimum skill set you should look for in somebody
claiming to be an SEO. The good news is it's simpler than you think.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/changing-installedappflow-from-run-console-to-run-local-server/">Changing InstalledAppFlow from run_console() to run_local_server()</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/let-s-visualize-websites-as-network-node-graphs/">Let's Visualize Websites as Network Node Graphs</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li></ul>