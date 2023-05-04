---
date: 2022-12-28
title: Planning A Large Browser Automation Job
headline: Preparing for a Large Browser Automation Job
description: I'm getting ready for a big browser automation job. I'm creating a new folder, making a repository, giving the project a codename, loading data into a dataframe, deduplicating it, calculating an estimated time of completion, and generating API-calls for the full year. Plus, I'm setting up a structure to step through a database and perform an API call or browser automation, creating a namedtuple with 100 domains, and using a template for browser automation.
keywords: Browser Automation, Folder, Repository, Codename, Dataframe, Deduplication, Estimated Time of Completion, API-Calls, Database, Namedtuple, Template, Headless Mode, Accepting Downloads, Slow Motion
categories: browser automation, template, database
permalink: /blog/planning-a-large-browser-automation-job/
layout: post
---


Alright, that last project was just awesome and I've been pushing forward my
state of the art, and my E-E-A-T in the field of SEO, if ever questioned. Be
ready to walk through the set of projects that any SEO worth their salt these
days should be able to carry out, such as linear regression analysis from
Search Console data, but which few actually can do. Get it into your muscle
memory. It's at that point with the tools where you can. They're sufficiently
generic and timeless. Visualizing a site's hierarchy as revealed by a
site-crawl is just about in that category too. That's 2 big categories:

- Linear Regression Analysis of API-pulled GSC Keyword Data
- Visualization of a Crawled Website's Link Graph

But that leaves a next category I have to get-down with equal ease. It's the
chrome automation piece. It's data collection, for sure. Okay... deep breath.
Make this something you can improve the Pipulate site with. I'm up to Chrome
Automation over there, anyway. 1, 2, 3... 1?

All browser automation projects start out the same these days. Make a new
folder that gives the project a strong identity... okay, and get the practice
folder down to bare-bones again.

I ought to give pipulate users a practice folder with barebones files in them.
But don't just make the directory. Make a repo called "practice" with good
barebones files in there and git clone it. Put it in the git_install.bat phase.

Okay, for right now it's creating a Notebook with a good codename before we
hake a standalone folder for it. That's a good principle. Let things be born in
the practice folder and not actually in a new folder for which you need to
choose a strong repo name and nickname for the project right away. Go with a
codename for a .ipynb file and allow some flexibility. Let the right repo name
dawn on you as you're doing the work. Okay... so codename norush.ipynb

First we load all the data into a dataframe and dedupe based on a column:

```python
import pandas as pd

dfs = pd.read_excel('[filename].xlsx', sheet_name=None)

table = []
for key in dfs.keys():
    df = dfs[key]
    df["tab"] = key
    table.append(df)

df = pd.concat(table)
print(f"Before dedupe: {df.shape}")
df.drop_duplicates(subset=["domain"], inplace=True)
print(f"After dedupe: {df.shape}")
```

Okay, a lot of this project is proprietary so the details won't end up here,
however there's some truisms that we frontload the project with. Prepare thy
named tuples! But first, we get an ETA of the time-duration of the script run.

``` python
import pandas as pd

with open("config.txt") as fs:
    filename = fs.read()

dfs = pd.read_excel(filename, sheet_name=None)

table = []
for key in dfs.keys():
    df = dfs[key]
    df["tab"] = key
    table.append(df)

df = pd.concat(table)
print(f"Before dedupe: {df.shape}")
df.drop_duplicates(subset=["domain"], inplace=True)
print(f"After dedupe: {df.shape}")

time_per_iter = 60  # Time the action in browser
eta = df.shape[0] / 100 / time_per_iter
print(f"ETA: {eta:.2f} hours.")
```

Okay, each API-call is going to batch-up 100 items from the list. In other
words, the API supports sending up to 100 requests at a time. Let's tend to the
tuples! Named Tuples for housekeeping! Generate all the API-calls first. My
normal go-to logic for date-ranges is this.

```python
from datetime import datetime
from dateutil.relativedelta import relativedelta as rd

patterns = ["%Y-%m-%d", "%d-%m-%Y"]
pattern = patterns[0]

# Typical month ranges for GA APIs
months_back = 16
for x in range(months_back):
    start_date = datetime.now().date().replace(day=1) - rd(months=x)
    end_date = start_date + rd(months=1) - rd(days=1)
    start_date = start_date.strftime(pattern)
    end_date = end_date.strftime(pattern)
    print(start_date, end_date)
```

Okay, unlike as usual with month-ranges, this run is going to just be for the
full year, so that date logic is as follows:

### Get API-Friendly Start & End Date of This Year

```python
import datetime
import calendar
import pandas as pd
from collections import namedtuple
from sqlitedict import SqliteDict as sqldict

with open("config.txt") as fs:
    filename = fs.read()

dfs = pd.read_excel(filename, sheet_name=None)

table = []
for key in dfs.keys():
    df = dfs[key]
    df["tab"] = key
    table.append(df)

df = pd.concat(table)
print(f"Before dedupe: {df.shape}")
df.drop_duplicates(subset=["domain"], inplace=True)
print(f"After dedupe: {df.shape}")

time_per_iter = 60  # Time the action in browser
eta = df.shape[0] / 100 / time_per_iter
print(f"ETA: {eta:.2f} hours.")

year = datetime.datetime.now().year
first_day_of_year = datetime.datetime(year, 1, 1)
num_days_in_year = calendar.isleap(year) and 366 or 365
last_day_of_year = first_day_of_year + datetime.timedelta(days=num_days_in_year-1)
pattern = "%Y-%m-%d"
start_date = first_day_of_year.strftime(pattern)
end_date = last_day_of_year.strftime(pattern)

print(start_date, end_date)

Args = namedtuple("Args", "id, start_date, end_date, batch")

table, batch = [], []
for i, adomain in enumerate(df["domain"]):
    batch.append(adomain)
    if i and not i % 100:
        table.append(Args(i, start_date, end_date, batch))
        batch = []

num = len(table)
with sqldict("norush.db") as db:
    for i, arg in enumerate(table):
        print(f"{i + 1} of {num} from {arg.id - 99} to {arg.id}:")
        db[str(arg)] = None
        # for adomain in arg.batch:
        #     pass
        #     print(adomain)
        # break
    db.commit()
print("Done")
```

Okay, this is some respectable housekeeping while we make these API-calls. As
large as those Args are, each being stuffed with 100 domains as they are, I'm
***STILL*** using them as the database key! This code sets the structure for
how we're going to step through our database to perform an API call or browser
automation.

```python
from sqlitedict import SqliteDict as sqldict
from collections import namedtuple

Args = namedtuple("Args", "id, start_date, end_date, batch")

with sqldict("norush.db") as db:
    num = len(db)
    for i, str_arg in enumerate(db):
        data = db[str_arg]
        if not data:
            arg = eval(str_arg)
            print(f"{i + 1} of {num} from {arg.id - 99} to {arg.id}:")

            # This is where we construct our API-call
            # or browser automation.

            for adomain in arg.batch:
                pass
            #     print(adomain)
            # break
```

Okay, and now it's time for browser automation! 1, 2, 3... 1? Copy & paste
template code for browser automation! That's step #1. Paste it here and get it
in more places for future reference!

```python
import asyncio
from playwright.async_api import Playwright, async_playwright, expect, TimeoutError

chrome_exe = "/usr/bin/google-chrome"
user_data = "/home/ubuntu/.config/google-chrome/"
downloads_path = "/home/ubuntu/Downloads"

async with async_playwright() as p:
    playwright = await async_playwright().start()
    browser = await playwright.chromium.launch_persistent_context(
        user_data_dir=user_data,
        headless=False,
        accept_downloads=True,
        executable_path=chrome_exe,
        channel="chrome",
        no_viewport=True,
        slow_mo=10,
        downloads_path=downloads_path,
        # args=["--start-maximized"],
    )

    page = await browser.new_page()
    await page.goto("https://www.google.com/")
```



## Categories

<ul>
<li><h4><a href='/browser-automation/'>Browser Automation</a></h4></li>
<li><h4><a href='/template/'>Template</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li></ul>