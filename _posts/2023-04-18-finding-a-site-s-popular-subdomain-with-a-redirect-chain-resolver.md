---
date: 2023-04-18
title: Finding a Site's Popular Subdomain With a Redirect Chain Resolver
headline: Uncovering the Most Popular Subdomain of a Site with a Redirect Chain Resolver
description: I created a mini-project to find the most popular subdomain of a site using a redirect chain resolver, Requests library, and a blacklist filter. After excluding certain sites, I was able to pull data from 53 sites. Read my blog post to find out how I did it!
keywords: Redirect Chain Resolver, Requests Library, Blacklist Filter, Mini-Project, Subdomain, Popular, URL, Protocol
categories: 
permalink: /blog/finding-a-site-s-popular-subdomain-with-a-redirect-chain-resolver/
layout: post
---


This is a mini-project that I do all the time. But since I'm building this
project up from scratch, let's do it again. This adds a couple of new
functions. One uses the Requests library to find the last redirect in a
redirect chain. The other chops off the http or https protocol from a URL. The
result is the same as what comes back from True Competitors, the apex domain
plus the most important subdomain.

```python
from pathlib import Path
import pandas as pd
import requests


pd.set_option("display.width", 1000)

DATA_DIR = "../data"

dfs = []
our_sites = []
for f in Path(DATA_DIR).glob("Competitive Research_ True Competitor - Moz Pro*.csv"):
    fname = f.name
    site = fname.split()[-1][4:-4]
    our_sites.append(site)
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

competitors = set(df["Top Competitor URLs"].unique())


def get_final_redirect(apex_domain):
    url = f"https://{apex_domain}"
    try:
        response = requests.head(url, allow_redirects=True)
        return response.url
    except:
        return None


def chop_protocol(url):
    """
    Takes a URL as input and chops off either the secure or non-secure protocol
    from the beginning of the URL, returning the result.
    """
    # Define the protocols we want to remove
    protocols = ["http://", "https://"]

    # Loop through each protocol and remove it if it exists
    for protocol in protocols:
        if url.startswith(protocol):
            url = url[len(protocol) :]
            if url[-1] == "/":
                url = url[:-1]
            break

    return url


our_resolved_sites = set()
for site in our_sites:
    landing_page = get_final_redirect(site)
    chopped_protocol = chop_protocol(landing_page)
    our_resolved_sites.add(chopped_protocol)

all_sites = competitors | our_resolved_sites
print(len(all_sites))
```

    66

We know this worked because the original list of 59 competitors went up by the
same amount as the number of sites we're seeing the process with. This means
we're going to be doing 66 nearly identical downloads from MOZ Pro Keywords
Explorer, but put into subdomain mode.

It's important to note that I put the seed sites into the competitor list
because we're going to want the keyword data for all the sites, competitors and
ourselves included.

Another thing to note is that it's not really worth pulling the keyword data
for all of these sites. Some of them are enormous and only show up as
competitors because of the vast scope of content they have. Pulling keyword
data on even just their subdomain would pollute the keyword list with
excessively broad topics. So I'm going create a blacklist filter including such
sites as:

```python
black_list = {
    "support.google.com",
    "www.facebook.com",
    "myaccount.google.com",
    "developers.google.com",
    "blog.hubspot.com",
    "www.amazon.com",
    "www.youtube.com",
    "apps.apple.com",
    "www.instagram.com",
    "www.hulu.com",
    "www.nytimes.com",
    "ads.google.com",
    "play.google.com",
}

pull_sites = all_sites - black_list
print(len(pull_sites))
```

    53

And that brings us down to only pulling 53 sites from MOZ Pro. That's something
we could almost do reasonably manually.

Here's one more version with some more reporting and outputting the results
into the data directory.

```python
from pathlib import Path
import pandas as pd
import requests


pd.set_option("display.width", 1000)

DATA_DIR = "../data/"

dfs = []
our_sites = []
for f in Path(DATA_DIR).glob("Competitive Research_ True Competitor - Moz Pro*.csv"):
    fname = f.name
    site = fname.split()[-1][4:-4]
    our_sites.append(site)
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

competitors = set(df["Top Competitor URLs"].unique())


def get_final_redirect(apex_domain):
    url = f"https://{apex_domain}"
    try:
        response = requests.head(url, allow_redirects=True)
        return response.url
    except:
        return None


def chop_protocol(url):
    """
    Takes a URL as input and chops off either the secure or non-secure protocol
    from the beginning of the URL, returning the result.
    """
    # Define the protocols we want to remove
    protocols = ["http://", "https://"]

    # Loop through each protocol and remove it if it exists
    for protocol in protocols:
        if url.startswith(protocol):
            url = url[len(protocol) :]
            if url[-1] == "/":
                url = url[:-1]
            break

    return url


our_resolved_sites = set()
for site in our_sites:
    landing_page = get_final_redirect(site)
    chopped_protocol = chop_protocol(landing_page)
    our_resolved_sites.add(chopped_protocol)

# Show original list lengths
print(f"Seed Sites: {len(our_resolved_sites)}")
print(f"Competitors: {len(competitors)}")

# Show the combined lists
all_sites = competitors | our_resolved_sites
print(f"Combined before fitlering: {len(all_sites)}")

# Show the combined lists after we removed blacklisted sites
pull_sites = all_sites - black_list
print(f"Combined after fitlering: {len(pull_sites)}")

# Save the file in the data directory
save_as = DATA_DIR + "pull_keywords.txt"
with open(save_as, "w") as fh:
    for site in pull_sites:
        fh.write(site + "\n")
print(f"{save_as} saved!")
```

    Seed Sites: 7
    Competitors: 59
    Combined before fitlering: 66
    Combined after fitlering: 53
    ../data/pull_keywords.txt saved!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/automatically-log-into-moz-pro-with-playwright-browser-automation/">Automatically Log Into MOZ Pro with Playwright Browser Automation</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/optimizing-moz-pro-true-competitor-keyword-overlap-for-quota-limits/">Optimizing MOZ Pro True Competitor Keyword Overlap For Quota Limits</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul></ul>