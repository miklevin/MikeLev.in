---
date: 2023-04-18
title: Optimizing MOZ Pro True Competitor Keyword Overlap For Quota Limits
headline: "Ready to Tackle a Mini-Project: Optimizing MOZ Pro True Competitor Keyword Overlap for Quota Limits"
description: I'm using the MOZ Pro True Competitor report to optimize keyword overlap, and have identified 128 competitors. After filtering them to those with at least 2% overlap, I'm left with 59 unique sites to download. To ensure accuracy, I'm adding the original sites and their subdomains back into the list. Now, I'm feeling rested and ready to tackle a mini-project of renaming the downloads without subdomains. Join me as I take on this task!
keywords: MOZ Pro, True Competitor, Keyword Overlap, Quota Limits, Competitors, Filtering, Unique Sites, Downloading, Subdomains, Accuracy, Original Sites, Renaming, Downloads, Mini-Project
categories: competitors, moz pro
permalink: /blog/optimizing-moz-pro-true-competitor-keyword-overlap-for-quota-limits/
layout: post
---


Alright, I'm liking this chisel-strike approach. I just keep powering through
the next baby-step, documenting it as much as reasonably possible. I also have
access to the Snowflake system now where I'll be doing this same project in
parallel, with a different set of benefits.

Let me first get the next round of data. I want to know the keywords that are
producing traffic for each of these sites. I'll be using up my MOZ Pro query
quotas on this, most likely.

If I were to look at all the competitors:

```python
competitors = set(df["Top Competitor URLs"].unique())
len(competitors)
```

    128

I see that there's 128. I only have 130 keyword queries left on MOZ Pro, so I
want to get that number down a bit. This brings it down to 75 competitors based
on the most overlap. I've filtered those competitors who have less than 2%
overlap.

```python
from pathlib import Path
import pandas as pd


pd.set_option("display.width", 1000)

DATA_DIR = "../data"

dfs = []
for f in Path(DATA_DIR).glob("Competitive Research_ True Competitor - Moz Pro*.csv"):
    fname = f.name
    site = fname.split()[-1][4:-4]
    df = pd.read_csv(f, encoding="utf-8")
    df["Competitor"] = site
    dfs.append(df)

df = pd.concat(dfs)

# Convert the percentage column to a float
df["Overlap"] = df["Overlap"].str.strip().str.rstrip("%").astype(float) / 100

# Filter to sites that have at least 2% keyword overlap
df = df[df["Overlap"] > 0.02]

# Sort by where there's the most overlap
df.sort_values("Overlap", ascending=False, inplace=True)

print(df.head(15))
```

            Top Competitor URLs  Domain Authority  Overlap  Rivalry          Competitor
    0             www.webmd.com                94     0.19       62  everydayhealth.com
    0           www.semrush.com                88     0.15       78             moz.com
    1        www.healthline.com                88     0.15       61  everydayhealth.com
    2        www.mayoclinic.org                91     0.14       56  everydayhealth.com
    0      www.whattoexpect.com                76     0.14       74      babycenter.com
    1                ahrefs.com                84     0.13       69             moz.com
    3           www.thebump.com                74     0.12       65      babycenter.com
    4           www.pampers.com                66     0.11       61      babycenter.com
    5    www.verywellfamily.com                71     0.10       59      babycenter.com
    5        www.wordstream.com                83     0.10       64             moz.com
    6  www.medicalnewstoday.com                91     0.10       49  everydayhealth.com
    2     americanpregnancy.org                81     0.10       68      babycenter.com
    1                www.nhs.uk                91     0.09       74      babycenter.com
    7           medlineplus.gov                87     0.09       47  everydayhealth.com
    2           www.youtube.com               100     0.09       66           pcmag.com

And only 59 of them are unique:

```python
competitors = set(df["Top Competitor URLs"].unique())
len(competitors)
```

    59

That's 59 different MOZ Pro data downloads I need to do. This manual work in
MOZ Pro is arguably the most difficult (and certainly tedious) part of the
project. Let's write them out to a local file.

It's also worth pointing out that the sites returned from MOZ Pro True
Competitor report keeps those subdomains included! This is a very important
fact because when we pull keyword reports, there is options for:

- keyword
- root domain
- subdomain
- exact page

And the number of keywords that come back WILL VARY, sometimes quite
dramatically. Sites that have gobs of unknown subdomains may produce vastly
more keywords than those in which you are actually interested, which brings up
the fact that we need to put our original sites back into this list if they
don't exist, but with the subdomains for which we're interested.

I didn't use subdomains when I renamed the downloads from the True Competitor
report, so that becomes our next mini-project.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/finding-a-site-s-popular-subdomain-with-a-redirect-chain-resolver/">Finding a Site's Popular Subdomain With a Redirect Chain Resolver</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/ever-have-to-combine-csvs-do-it-better-with-python-pandas/">Ever Have to Combine CSVs? Do It Better With Python Pandas!</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/moz-pro/'>MOZ Pro</a></h4></li></ul>