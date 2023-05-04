---
date: 2023-04-18
title: Automatically Log Into MOZ Pro with Playwright Browser Automation
permalink: /blog/automatically-log-into-moz-pro-with-playwright-browser-automation/
headline: Automate Your MOZ Pro Logins with Playwright Browser Automation
description: This blog post will walk you through using Microsoft Playwright's browser automation software to automatically log into MOZ Pro and download Keyword Explorer data for each subdomain. Using asynchronous mode and my standard Chrome automation template, I am logging into the MOZ Pro website and using the Keyword Explorer feature to pull keywords from a given site with the help of the async Python library. Read on to learn how to automate this process.
keywords: Automation, Playwright, Browser, Microsoft, MOZ Pro, Keyword Explorer, Asynchronous, Chrome, Python, Jupyter Notebook, Competitors, Site, Close
categories: microsoft, python, automation, jupyter notebook, moz pro, chrome
layout: post
---

Alright, onto the fun part, browser automation! We want to get the download the
Keyword Explorer data for each of these subdomains. Some of them are in there
as apex domains like mashable.com nordvpn.com, but that's because their main
website is not a subdomain. They use the apex domain as their main site. So
we're going to keep "subdomain" selected in the automation for the sake of
simplicity and it will probably work fine, but it's something for me to keep an
eye on.

## Browser Automation in Jupyter Notebook Requires Async

I've also been working in JupyterNotebook so far, and I find this the most
natural way to even do the browser automation work, however the state of things
right now means that I need to keep it in "async" mode. It's not that bad, but
the code is just a little more complicated than it could be with the browser
automation software I'm using, Microsoft Playwright, which supports both
synchronous and asynchronous modes. But if Playwright in Jupyter, it's
asynchronous or nothing right now.

## Working Against Combined True Competitors List

I changed the name of the last file to moz_combine_competitors.ipynb. Sometimes
it takes doing the next step to figure out how to label the last step because
it puts it in perspective. We have a "combined competitors" list from MOZ Pro
True Competitors report. And we did it for several sites, so we have all their
competitors, plus the original seed-sites we provided all combined together in
a list called pull_keywords.text, because we're about to use the MOZ Pro
Keyword Explorer to pull all those keyword lists.

Let's start out in a Jupyter Notebook as usual, because I think it keeps this
type of work as accessible as possible, despite async mode.

## My Standard Chrome Automation Template for MOZ Pro

The new Jupyter Notebook, I'm naming moz_pull_keywords.ipynb. Okay, let's start
out with my recently standard opening code for automation. This sets the stage
for logging in with a username and password kept in a file called mozcreds.txt
elsewhere on the system. Caution, it's not encrypted. This is not meant for web
development. This is a way of running things local on your machine. It's not
always that way with Jupyter Notebooks which are usually just as well hosted in
the cloud, but in the case of browser automation, it is not so. This particular
example is running from your local machine only, and a Linux one at that.

If you're on Windows, you can use WSL2 and my Jupyter setup with the
[https://mikelev.in/drinkme](drinkme) script. If it's TOO easy, everyone would
be doing it.

## Opens MOZ Pro, Logs In, and Closes

And just a reminder, this only opens MOZ Pro, logs in, lets it sit there for 10
seconds and closes the window. But like when the Wright Brothers achieved lift
in the wind tunnel, it's that success assured moment. The first step is the
hardest, and getting this to work with Jupyter Notebook is the first step.

```python
import nest_asyncio

nest_asyncio.apply()

import asyncio
from playwright.async_api import Playwright, async_playwright


pause_to_record = False

slow_mo = 100
moz_creds = "/home/ubuntu/repos/moz/assets/mozcreds.txt"
chrome_exe = "/usr/bin/google-chrome"
downloads_path = "/home/ubuntu/Downloads"
user_data = "/home/ubuntu/.config/google-chrome/"


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
    keyword = "example.com"  # or set to any default value that you prefer
    headless = False
else:
    import argparse

    headless = True
    parser = argparse.ArgumentParser(
        description="Pull keywords from MOZ Pro given -s site."
    )
    parser.add_argument("-s", "--site", type=str, required=True, help="Value for site")
    args = parser.parse_args()
    keyword = args.keyword

with open(moz_creds) as fh:
    UN, PW = [x.strip().split(" ")[1] for x in fh.readlines()]


async def main():
    async with async_playwright() as playwright:
        context = await playwright.chromium.launch_persistent_context(
            viewport={"width": 1200, "height": 900},
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

        try:
            await page.get_by_role("link", name="Log in").click()
            await page.locator("#email").click()
            await page.locator("#email").fill(UN)
            await page.locator("#email").press("Tab")
            await page.locator("#password").fill(PW)
            await page.locator("#password").press("Enter")
            # await page.get_by_role("navigation").get_by_role(
            #     "link", name="Moz Pro"
            # ).click()
        except:
            ...

        # Codegen activated
        if pause_to_record:
            await page.pause()  # Edit this line in for codegen and out for automation.

        # -- BEGIN CODEGEN LINES --

        # Insert async Python lines copied from Codegen here.
        # Some modifications will almost certainly be necessary.

        # -- END CODEGEN LINES --

        # When done, close the browser.
        await asyncio.sleep(10)
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

The following blog posts will expand on this to actually use the Keyword
Explorer to download the keyword list for each competitor site.


## Categories

<ul>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/automation/'>Automation</a></h4></li>
<li><h4><a href='/jupyter-notebook/'>Jupyter Notebook</a></h4></li>
<li><h4><a href='/moz-pro/'>MOZ Pro</a></h4></li>
<li><h4><a href='/chrome/'>Chrome</a></h4></li></ul>