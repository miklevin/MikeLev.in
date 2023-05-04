---
date: 2022-12-30
title: Browser Automation Becoming Natural & Easy At Long Last
headline: Making Browser Automation Easier with Pandas and Playwright
description: I'm working on a big project and documenting my progress on my blog. I've combined tabs into one data frame, deduped the list, calculated job eta, picked APIs date format, and defined typical month ranges for GA APIs. I'm now ready to perform browser automation, configuring the browser to be headless and setting up a namedtuple for arguments. I'm also using the Pandas library to read a directory full of downloads and joining them together.
keywords: Browser Automation, Tabs, Data Frame, Dedupe, Job Eta, API, Date Format, Month Ranges, Configure, Headless, Namedtuple, Arguments, SqliteDict, Async_playwright, Context Manager, Pre-recorded, Intermittent Random Pauses, Playwright Inspector, Record Logged-in Sessions, Pandas Library, Downloads, Stacking Approach, Year, Pivot Tables, Excel File
categories: api, browser automation, sqlitedict
permalink: /blog/browser-automation-becoming-natural-easy-at-long-last/
layout: post
---


Okay, every time I do a big ambitious project, I want to save the best parts of
it here on my increasingly hard to find blog. I'm making the blog index page
more than 1-click off the main homepage. This blog is going to be increasingly
hard to find because I'm gently submerging it into the deeper hierarchy of my
site. This is all the housekeeping work BEFORE actually performing any browser
automation:

```python
import datetime
import calendar
import pandas as pd
from pathlib import Path
from datetime import datetime
from collections import namedtuple
from sqlitedict import SqliteDict as sqldict
from dateutil.relativedelta import relativedelta as rd

# Configure
dbname = "job.db"
excel_with_tabs_to_combine = "filename.xlsx"
download_folder = "downloads"

# Combine all tabs into 1 df
dfs = pd.read_excel(excel_with_tabs_to_combine, sheet_name=None)
table = []
for key in dfs.keys():
    df = dfs[key]
    df["tab"] = key
    table.append(df)
df = pd.concat(table)

# Dedupe the list
print(f"Before dedupe: {df.shape[0]}")
df["domain"] = df["domain"].apply(str.strip).apply(str.lower)
df.drop_duplicates(subset=["domain"], inplace=True)
domains = list(df["domain"])
domain_count = len(domains)
print(f"After dedupe: {domain_count}")

# Calculate job eta
number_of_timeranges = 11
batch_size = 100
seconds_per_iter = 5  # Time the action in
batches_per_timerange = domain_count / batch_size
print(f"Batches per time-range: {batches_per_timerange:.0f} batched requests")
one_loop_duration = seconds_per_iter * batches_per_timerange
print(f"Duration per time-range loop: {one_loop_duration / 60:.0f} minutes")
batches_per_timerange * number_of_timeranges
number_of_requests = int(domain_count / batch_size * number_of_timeranges)
print(f"Number of batched requests: {number_of_requests}")
whole_job_duration = one_loop_duration * number_of_timeranges
print(f"Whole job duration: {whole_job_duration / 60 / 60:.1f} hours")

# Pick your API's date format
patterns = ["%Y-%m-%d", "%d-%m-%Y", "%Y/%m/%d", "%d/%m/%Y"]
pattern = patterns[0]

# Typical month ranges for GA APIs
months_back = 11
month_offset = 1
timetuples = []
for x in range(months_back):
    start_date = datetime.now().date().replace(day=1) - rd(months=x + month_offset)
    end_date = start_date + rd(months=1) - rd(days=1)
    start_date = start_date.strftime(pattern)
    end_date = end_date.strftime(pattern)
    timetuples.append((start_date, end_date))

timetuples.reverse()
for timetuple in timetuples:
    print(timetuple)

# CAUTION, THIS WILL DELETE DATABASE!!!

# Populate a table of arguments
Args = namedtuple("Args", "id, start_date, end_date, batch")
try:
    Path(dbname).unlink()
except:
    ...

print("Shaping Request Table...")
arg_id = 1
table, batch = [], []
for i, adom in enumerate(domains):
    if i:
        batch.append(adom)
    if i and not i % 100:
        for atuple in timetuples:
            start_date, end_date = atuple
            table.append(Args(arg_id, start_date, end_date, batch))
            arg_id += 1
        batch = []
# and one last batch
for atuple in timetuples:
    start_date, end_date = atuple
    table.append(Args(arg_id, start_date, end_date, batch))
    arg_id += 1

print(f"Calculated to expect: {i / 100 * 12:.0f}")
print(f"Arguments in table: {len(table)}")
print(f"Number of batched requests: {number_of_requests}")

for item in table:
    print(f"Req {item[0]} {item[1]} {item[2]} batch size: {len(item[3])}")

# Populate the Database with None value for each key
num = len(table)
with sqldict(dbname) as db:
    for i, arg in enumerate(table):
        print(f"{i + 1} is ReqID {arg.id} batching {len(arg.batch)}")
        db[str(arg)] = None
    db.commit()
print("Done")
```

Once you've got all those delicious namedtuples with sub-lists of 100 each
defined, we're ready for browser automation. And ***THIS*** is the actual
Chrome automation which is serving as the template now for my future browser
automation jobs.

```python
import asyncio
from time import sleep
from pathlib import Path
from random import randint
from collections import namedtuple
from sqlitedict import SqliteDict as sqldict
from playwright.async_api import Playwright, async_playwright, expect, TimeoutError

# Configure
headless = True
somesite = [enter some site here]
Args = namedtuple("Args", "id, start_date, end_date, batch")
downloaded = [int(x.name.split("-")[0]) for x in Path("downloads").glob("*")]

# Open database of args
with sqldict(dbname) as db:
    # Use context manager in async mode for Microsoft Playwright
    async with async_playwright() as p:
        playwright = await async_playwright().start()
        # Configure browser
        browser = await playwright.chromium.launch_persistent_context(
            user_data_dir="/home/ubuntu/.config/google-chrome/",
            headless=headless,
            accept_downloads=True,
            executable_path="/usr/bin/google-chrome",
            channel="chrome",
            no_viewport=True,
            slow_mo=10,
            downloads_path="/home/ubuntu/Downloads",
            # args=["--start-maximized"],
        )
        page = await browser.new_page()
        print("Opening page")
        await page.goto(f"{somesite}/projects/")
        print("Page open")
        await asyncio.sleep(5)

        # Loop through pre-recorded API args
        num = len(db)
        for i, str_arg in enumerate(db):

            # Cause intermittent random pauses
            if i > 10 and not i % randint(25, 250):
                # Set a random pause from 1 to 5 minutes
                random_number = randint(60, (60 * 5))
                # Fuzz the pause
                fuzz = randint(1, 100)
                delay = f"{random_number}.{fuzz}"
                delay = float(delay)
                print(f"Random pause of {delay} seconds.")
                sleep(delay)

            # Revert string-keys to original nametuples
            data = db[str_arg]
            arg = eval(str_arg)
            print(f"{i + 1} Processing {arg.id} of {num} containing {len(arg.batch)} items.")

            # So much can go wrong. Beep a lot to get attention if it does.
            if data == None or arg.id not in downloaded:
                try:
                    # The details of what happens here can change dramatically.
                    # Always be ready to re-record and parameterize the requests.
                    # Use the line that follows to launch Playwright Inspector to record logged-in session.
                    # python -m playwright codegen --target python-async --save-storage keep.db --viewport-size 1400,1400
                    # Close the Playwright inspector and browser, then use the following line for further recording.
                    # python -m playwright codegen --target python-async --load-storage keep.db --viewport-size 1400,1200

                    api_url = f"{somesite}/analytics/traffic/bulk-analysis/?displayDate={arg.start_date}&searchType=domain&q=example.com"
                    await page.goto(api_url)
                    table = []
                    for adomain in arg.batch:
                        table.append(adomain)
                    lines = "\n".join(table).strip()
                    await page.locator("[data-test=\"clear\"]").click()
                    await page.get_by_role("textbox").fill(lines)
                    await page.locator("[data-test=\"submit\"]").click()
                    async with page.expect_download() as download_info:
                        await page.get_by_role("button", name="Export to CSV").click()
                        download = await download_info.value
                        filename = Path(download_folder) / f"{arg.id}-{arg.start_date}-{arg.end_date}-{Path(download.suggested_filename)}"
                        await download.save_as(filename)
                        db[str_arg] = filename.name
                        db.commit()
                except:
                    for i in range(30):
                        beep()

print("Done")
```

Pshwew! Okay, then finally we have the typical case of a directory full of
downloads, but the columns are compatible with each other, so they can be
joined with a sort of "stacking" approach (one CSV on top of another) which
Pandas calls "concat" for concatenate. It's also important to point out that we
add new columns to the Pandas DataFrame df's as we throw them into the list in
order to tell one month from another. I break out month and year into separate
columns, but also include a full yyyy-mm-dd column because it makes sorting and
pivot tables so much easier.

```python
import pandas as pd
from pathlib import Path

files = Path("downloads").glob("*")

table = []
for i, afile in enumerate(files):
    filename = afile.name
    parts = filename.split("-")
    print(parts)
    year = parts[1]
    month = parts[2]
    start_date = f"{year}-{month}-01"
    df = pd.read_csv(afile)
    df["file"] = filename.split("-")[1].split(".")[0]
    df["year"] = year
    df["month"] = month
    df["start_date"] = start_date
    table.append(df)
    print(i, int(time() - start), filename)
df = pd.concat(table)
df.to_excel("stacked_csvs.xlsx", index=False)
print("Done")
```


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/flattening-the-curve-of-ai-free-energy">Flattening The Curve of AI & Free Energy</a></div><div class="post-nav-next"><a href="/blog/planning-a-pivot-of-big-data-pull">Planning a Pivot of Big Data Pull</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/api/'>API</a></h4></li>
<li><h4><a href='/browser-automation/'>Browser Automation</a></h4></li>
<li><h4><a href='/sqlitedict/'>SqliteDict</a></h4></li></ul>