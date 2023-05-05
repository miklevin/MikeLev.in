---
date: 2022-09-26
title: SERP Scraping with site Search Modifier and Custom Date Range
headline: Improving SERP Job Efficiency with Custom Code and Automation
description: I'm working on a project to get SERP job running quickly and efficiently. I'm using Linux-side programs in JupyterLab, server automation, IP-cycling with HMA vpn on Windows, and custom code to scrape SERPs with a custom date range and site search modifier. I'm looping through a list of sites and date ranges to perfect the project. Come read more about my progress and join me on this journey!
keywords: SERP, Scraping, Site Search Modifier, Custom Date Range, Linux-side programs, JupyterLab, Server Automation, IP-cycling, HMA VPN, Windows, Code, Date Range, List of Sites, Looping, Improvement, Perfecting, Project
categories: jupyterlab
permalink: /blog/serp-scraping-with-site-search-modifier-and-custom-date-range/
layout: post
---


Okay, that was quite a journey. I lost the original code but this is much
better. It lets me work Linux-side in both JupyterLab and for server
automation, but while on a Windows desktop, I get the advantage of IP-cycling
with HMA vpn. I get the best of all worlds, but I have to move on fast to the
next stage of this project. I have to get the actual SERP job running ASAP. I
want a wonderful show for the upcoming phone-call.

Okay, so go back to your original code for this project.

Wow, it's going better than I could have imagined. Here's the current code:

```python
import re
import pandas as pd
from httpx import get
from pathlib import Path
from time import time, sleep
from urllib.parse import unquote
from urllib.parse import quote_plus
from IPython.display import display, HTML
from sqlitedict import SqliteDict as sqldict

user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
headers = {"user-agent": user_agent}

with open("sites.txt") as fh:
    sites = [x.strip() for x in fh.readlines()]

def query(site, arange):
    range_start, range_end = arange
    range_start = quote_plus(range_start)
    range_end = quote_plus(range_end)
    # rv = f"https://www.google.com/search?q=site:{site}&sxsrf=ALiCzsbCDuAVqfRF67b3y_R9JyBHJwHvmQ:1663873352409&source=lnt&tbs=cdr%3A1%2Ccd_min%3A{range_start}%2Ccd_max%3A{range_end}&tbm="
    rv = f"https://www.google.com/search?q=site:{site}&source=lnt&tbs=cdr%3A1%2Ccd_min%3A{range_start}%2Ccd_max%3A{range_end}"
    return rv

def extract_serps(text):
    """Return list of Google search results from provided "raw" SERP scrape.
    Useful for checking whether SERPS actually collected or extracting results."""

    rv = False
    try:
        div_pat = re.compile('<div class="yuRUbf">(.*?)</div>')
        divs = re.findall(div_pat, text)
        lot = []
        for div in divs:
            pat_url = re.compile('<a href="(.*?)"')
            url_group = re.match(pat_url, div)
            pat_title = re.compile('<h3 class="LC20lb MBeuO DKV0Md">(.*?)</h3>')
            title_group = re.search(pat_title, div)
            try:
                url = url_group.groups(0)[0]
            except:
                url = ""
            try:
                title = title_group.groups(0)[0]
            except:
                title = ""
            lot.append((url, title))
        rv = lot
    except:
        pass
    return rv

len(sites)

ranges = [
    ("6/16/2022", "7/15/2022"),
    ("7/16/2022", "8/15/2022"),
    ("8/16/2022", "9/15/2022")
]

start = time()
for i, site in enumerate(sites):
    print(f"{i + 1} of {len(sites)}")
    print(f"{site}: ")
    for y, arange in enumerate(ranges):
        with sqldict('serps.db', timeout=90) as db:
            url = query(site, arange)
            if url not in db:
                print(f"range {y + 0}: {arange}")
                print(f"url: {url}")
                response = get(url, headers = headers, timeout=90)
                status_code = response.status_code
                if status_code != 200:
                    print("Getting new IP")
                    Path('goodip.txt').unlink(missing_ok=True)
                    sleep(30)
                    response = get(url, headers = headers)
                db[url] = response
                print(f"status code: {status_code}")
                serps = extract_serps(response.text)
                print("SERPS:")
                if serps:
                    for serp in serps:
                        print(serp)
                print()
                db.commit()
                print(f"Seconds since start: {int(time() - start)} ", flush=True)
                print(f"{len(sites) - i - 2} to go.")
                print()
            else:
                # print(f"Already in db: {url}")
                print("Already in db. ", end="")
    print()
print("Done")
```

I'm still working on and refining this thing.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/portable-script-to-help-edit-many-files-at-once-with-python-venv-friendly-shebang/">Portable Script to Help Edit Many Files at Once with Python venv-friendly shebang!</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/automating-cycling-ips-on-hma-vpn-using-pywinauto/">Automating Cycling IPs on HMA VPN Using PyWinAuto</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyterlab/'>JupyterLab</a></h4></li></ul>