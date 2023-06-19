---
date: 2023-04-06
title: Tackling MOZ Browser Automation Until I Get It Right
headline: Exploring Automated Browser Tasks with MOZ Pro - Join Me on My Journey!
description: I'm tackling browser automation with the MOZ Links API and Chrome, and have set up a Playwright context on a Linux server. I'm writing code to automate tasks for MOZ Pro, and running the code from the command line with 'python mozpro.py -k' to analyze keywords and download the results. Join me on my journey as I explore the possibilities of automated browser tasks with MOZ Pro!
keywords: Browser Automation, MOZ Links API, Chrome, Playwright, Linux Server, MOZ Pro, Python, Keyword Explorer, CSV File, Headless Chrome, Endpoints, Command Line
categories: browser automation, seo, python, microsoft playwright
permalink: /blog/tackling-moz-browser-automation-until-i-get-it-right/
layout: post
group: blog
---


Wow, okay, I just slammed out what I think is a great introduction to the MOZ
Links API. Knock people's socks off with how effectively I can walk people
through the basics of an API ***and*** browser automation. The Links API stuff
is kind of just like a warm up given how simple the issues are compared to
browser automation.

{% include youtubePlayer.html id="z52sZ7GgwPQ" %}

I made a few interesting choices yesterday that I right now have to decide
whether I'm happy with. I wanted to push right on ahead to nbdev as applied to
the Links API and Browser Automation notebooks, however I don't really have all
the fundamentals worked out for the browser automation yet.

First, I decided to lock in on Chrome. Even though it would seem that using
Firefox or Chromium would be leaning into the strengths of Microsoft
Playwright, there are always little nuances that keep steering me back to
Chrome. However the one big show-stopper is that the ability to load and save
specific state files the way you can with the `--load-storage` and
`--save-storage` flags from playwright codegen does not appear to be available
in how you can use the `playwright.chromium.launch_persistent_context()`
method.

I am balanced in the middle of leaning into Playwright's defaults and what my
gut is telling me is worth the extra work. Let's keep it Chrome. I think I
could easily switch it to Edge if I do. I could also connect it to genuine user
profiles which would not be so easy with Firefox or Chromium.

I change the deliberately left out of repo file named assets/mozcreds.txt to
linksapi.txt so that I can use the other name for the more general website
login info. Doing a manual login every time while still using persistent
sessions under Chrome/Edge seems to be the best way to go.

Okay, now this bit of code handles login. It has quite a number of things going
for it:

- It uses genuine Linux Chrome. Issues regarding User Agents are easier.
- It's tied to a genuine User Profile which offers similar advantages.
  - While this cold be an issue when moving to server, it's not necessary.
  - The user_data location can be changed to a temporary directory.
  - Operation is otherwise identical because login still occurs.

```python
import nest_asyncio

nest_asyncio.apply()

import asyncio
import IPython
from playwright.async_api import Playwright, async_playwright

pause_to_record = False
# pause_to_record = True

slow_mo = 50
headless = True
moz_creds = "assets/mozcreds.txt"
chrome_exe = "/usr/bin/google-chrome"
downloads_path = "/home/ubuntu/Downloads"
user_data = "/home/ubuntu/.config/google-chrome/"
# user_data = "session"

def in_notebook():
    try:
        if IPython.get_ipython().__class__.__name__ == 'ZMQInteractiveShell':
            return True   # Jupyter notebook or qtconsole
        else:
            return False  # Other type (likely a script)
    except NameError:
        return False      # Probably standard Python interpreter

with open(moz_creds) as fh:
    UN, PW = [x.strip().split(" ")[1] for x in fh.readlines()]

async def main():
    async with async_playwright() as playwright:
        context = await playwright.chromium.launch_persistent_context(
            viewport={"width": 1200, "height": 1100},
            downloads_path=downloads_path,
            executable_path=chrome_exe,
            user_data_dir=user_data,
            accept_downloads=True,
            headless=headless,
            channel="chrome",
            slow_mo=slow_mo,
        )
        page = await context.new_page()
        await page.goto("https://moz.com/")

        # Codegen activated
        if pause_to_record:
            await page.pause()  # Edit this line in for codegen and out for automation.

        # -- BEGIN CODEGEN LINES --
        try:
            await page.get_by_role("link", name="Log in").click()
            await page.locator("#email").click()
            await page.locator("#email").fill(UN)
            await page.locator("#email").press("Tab")
            await page.locator("#password").fill(PW)
            await page.locator("#password").press("Enter")
            await page.get_by_role("navigation").get_by_role("link", name="Moz Pro").click()
        except:
            ...

        await page.goto("https://analytics.moz.com/pro/keyword-explorer/keyword/suggestions?locale=en-US")
        await page.get_by_placeholder("Enter a term or phrase to get analysis, suggestions, difficulty, and more").fill("linux")
        await page.get_by_role("button", name="analyze").click()
        async with page.expect_download() as download_info:
            await page.get_by_role("button", name="Export CSV").click()
        download = download_info.value
        download = await download
        await download.save_as("downloads/" + download.suggested_filename)
        # -- END CODEGEN LINES --

        # When done, close the browser.
        await asyncio.sleep(2)
        await context.close()


async def run_main():
    await main()


if in_notebook():
    try:
        asyncio.get_running_loop()
        asyncio.run(run_main())
    except RuntimeError as e:
        if "no running event loop" in str(e):
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            loop.run_until_complete(run_main())
else:
    asyncio.run(run_main())
```

Wow, I played around with it a lot and I think I've got my next major
breakthrough. This script simply goes into MOS Keyword Explorer and downloads
the CSV file for the keyword "linux".

I want to get the most mileage out of this script as possible. NBDev is rapidly
coming up, but before that I want to make it optionally support arguments.

```python
import nest_asyncio

nest_asyncio.apply()

import asyncio
from playwright.async_api import Playwright, async_playwright


def in_notebook():
    """Return True if run from a Jupyter Notebook and False if not."""
    try:
        import IPython

        if IPython.get_ipython().__class__.__name__ == "ZMQInteractiveShell":
            return True  # Jupyter notebook or qtconsole
        else:
            return False  # Other type (likely a script)
    except NameError:
        return False  # Probably standard Python interpreter


if in_notebook():
    keyword = "Foo"  # or set to any default value that you prefer
else:
    import argparse

    parser = argparse.ArgumentParser(description="Example script")
    parser.add_argument("-k", "--keyword", type=str, required=True, help="Value for keyword")
    args = parser.parse_args()
    keyword = args.keyword

pause_to_record = False
# pause_to_record = True

slow_mo = 50
headless = False
moz_creds = "assets/mozcreds.txt"
chrome_exe = "/usr/bin/google-chrome"
downloads_path = "/home/ubuntu/Downloads"
user_data = "/home/ubuntu/.config/google-chrome/"
# user_data = "session"

with open(moz_creds) as fh:
    UN, PW = [x.strip().split(" ")[1] for x in fh.readlines()]


async def main():
    async with async_playwright() as playwright:
        context = await playwright.chromium.launch_persistent_context(
            viewport={"width": 1200, "height": 800},
            downloads_path=downloads_path,
            executable_path=chrome_exe,
            user_data_dir=user_data,
            accept_downloads=True,
            headless=headless,
            channel="chrome",
            slow_mo=slow_mo,
        )
        page = await context.new_page()
        await page.goto("https://moz.com/")

        # Codegen activated
        if pause_to_record:
            await page.pause()  # Edit this line in for codegen and out for automation.

        # -- BEGIN CODEGEN LINES --
        try:
            await page.get_by_role("link", name="Log in").click()
            await page.locator("#email").click()
            await page.locator("#email").fill(UN)
            await page.locator("#email").press("Tab")
            await page.locator("#password").fill(PW)
            await page.locator("#password").press("Enter")
            await page.get_by_role("navigation").get_by_role(
                "link", name="Moz Pro"
            ).click()
        except:
            ...

        await page.goto(
            "https://analytics.moz.com/pro/keyword-explorer/keyword/suggestions?locale=en-US"
        )
        await page.get_by_placeholder(
            "Enter a term or phrase to get analysis, suggestions, difficulty, and more"
        ).fill(keyword)
        await page.get_by_role("button", name="analyze").click()
        async with page.expect_download() as download_info:
            await page.get_by_role("button", name="Export CSV").click()
        download = download_info.value
        download = await download
        await download.save_as("downloads/" + download.suggested_filename)
        # -- END CODEGEN LINES --

        # When done, close the browser.
        await asyncio.sleep(2)
        await context.close()


async def run_main():
    await main()


if in_notebook():
    try:
        asyncio.get_running_loop()
        asyncio.run(run_main())
    except RuntimeError as e:
        if "no running event loop" in str(e):
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            loop.run_until_complete(run_main())
else:
    asyncio.run(run_main())
```

Wow, this is pretty amazing. It's tested working on both Jupyter Notebook and
and a Windows subsystem for Linux (WSL) Ubuntu 20.04.1 LTS. I'm going to have
to test it on Linux without Windows.

Okay, it's time to set this up on my NAS LXD container. Making this work on a
headless cloud server is part of the pitch and I have to be able to follow
through. First problem I found is that git doesn't track empty folders. I
already have 3 I want to track, so I'll have to create them and then add them
and add a .gitkeep file to them.

- assets
- downloads
- dbs

Okay, worked like a charm. I had to create the mozcreds.txt file and put my
credentials in there. I also had to pip install nest_asyncio. I added
nest_asyncio to the drinkme requirements.txt file.

One of my realizations is that I can turn headless on or off now based on the
server. Here's the final form before nbdev-ifying it:

```python
import nest_asyncio

nest_asyncio.apply()

import asyncio
from playwright.async_api import Playwright, async_playwright


pause_to_record = False
# pause_to_record = True

slow_mo = 50
moz_creds = "assets/mozcreds.txt"
chrome_exe = "/usr/bin/google-chrome"
downloads_path = "/home/ubuntu/Downloads"
user_data = "/home/ubuntu/.config/google-chrome/"
# user_data = "session"


def in_notebook():
    """Return True if run from a Jupyter Notebook and False if not."""
    try:
        import IPython

        if IPython.get_ipython().__class__.__name__ == "ZMQInteractiveShell":
            return True  # Jupyter notebook or qtconsole
        else:
            return False  # Other type (likely a script)
    except NameError:
        return False  # Probably standard Python interpreter


if in_notebook():
    keyword = "Foo"  # or set to any default value that you prefer
    headless = False
else:
    import argparse

    headless = True
    parser = argparse.ArgumentParser(description="Example script")
    parser.add_argument(
        "-k", "--keyword", type=str, required=True, help="Value for keyword"
    )
    args = parser.parse_args()
    keyword = args.keyword

with open(moz_creds) as fh:
    UN, PW = [x.strip().split(" ")[1] for x in fh.readlines()]


async def main():
    async with async_playwright() as playwright:
        context = await playwright.chromium.launch_persistent_context(
            viewport={"width": 1200, "height": 800},
            downloads_path=downloads_path,
            executable_path=chrome_exe,
            user_data_dir=user_data,
            accept_downloads=True,
            headless=headless,
            channel="chrome",
            slow_mo=slow_mo,
        )
        page = await context.new_page()
        await page.goto("https://moz.com/")

        # Codegen activated
        if pause_to_record:
            await page.pause()  # Edit this line in for codegen and out for automation.

        # -- BEGIN CODEGEN LINES --
        try:
            await page.get_by_role("link", name="Log in").click()
            await page.locator("#email").click()
            await page.locator("#email").fill(UN)
            await page.locator("#email").press("Tab")
            await page.locator("#password").fill(PW)
            await page.locator("#password").press("Enter")
            await page.get_by_role("navigation").get_by_role(
                "link", name="Moz Pro"
            ).click()
        except:
            ...

        await page.goto(
            "https://analytics.moz.com/pro/keyword-explorer/keyword/suggestions?locale=en-US"
        )
        await page.get_by_placeholder(
            "Enter a term or phrase to get analysis, suggestions, difficulty, and more"
        ).fill(keyword)
        await page.get_by_role("button", name="analyze").click()
        async with page.expect_download() as download_info:
            await page.get_by_role("button", name="Export CSV").click()
        download = download_info.value
        download = await download
        await download.save_as("downloads/" + download.suggested_filename)
        # -- END CODEGEN LINES --

        # When done, close the browser.
        await asyncio.sleep(2)
        await context.close()


async def run_main():
    await main()


if in_notebook():
    try:
        asyncio.get_running_loop()
        asyncio.run(run_main())
    except RuntimeError as e:
        if "no running event loop" in str(e):
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            loop.run_until_complete(run_main())
else:
    asyncio.run(run_main())
```

When called from a command-line, it looks like this:

```bash
$ python mozpro.py -k "foo"
```

Very interesting. I have some decisions to make regarding how many variations I
want for different MOZ Pro "endpoints". The Web UI is going to have so many
parameters! I'm not going to start a holy endeavor to cover everything. I'm
just going to provide a few excellent template examples.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/when-your-tools-are-timeless-so-are-you/">When Your Tools Are Timeless, So Are You</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/notebook-based-browser-automation-with-nbdev/">Notebook-based Browser Automation With NBDev</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/browser-automation/'>Browser Automation</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li></ul>