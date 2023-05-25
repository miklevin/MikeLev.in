---
date: 2023-04-18
title: A Script To Pull Keywords From MOZ Pro Keyword Research Ranking Keywords
headline: Automating Keyword Research With Playwright and Jupyter Notebook
description: This blog post provides a step-by-step guide to automating browser actions using Playwright Browser Automation and Jupyter Notebook to pull keywords from MOZ Pro's Keyword Research Ranking Keywords. Additionally, I explain how to set up the environment, execute the code, and download files from a website.
keywords: Automating, Browser, Actions, Playwright, Browser Automation, Jupyter Notebook, MOZ Pro, Keyword Research, Ranking Keywords, Environment, Execute, Code, Download, Files, Website, Script, Set, Click, Link, Subdomain, List Item, Placeholder, Analyze, Button, Export, CSV, Save, Folder, Close
categories: execute, python, jupyter, panda, seo, action, microsoft playwright, browser automation
permalink: /blog/a-script-to-pull-keywords-from-moz-pro-keyword-research-ranking-keywords/
layout: post
---


It's time to actually record actions in browser automation. My first step is to
add the first bit of recorded actions at all. I'm not performing the actual
form submit, but I'm going to record the actions that lead up to it.

## Playwright Browser Automation in Jupyter Notebook: Recording With Codegen

{% include youtubePlayer.html id="AH-Eh3_SyqM" %}

## Playwright Browser Automation: Stepping Through a List

{% include youtubePlayer.html id="sGZvUkIxMB4" %}

And the final step. It's not pretty, but it got the job done:

```python
# | export

import nest_asyncio

nest_asyncio.apply()

import re
import asyncio
from pathlib import Path
from playwright.async_api import Playwright, async_playwright


PAUSE_TO_RECORD = False

DATA_DIR = "../data/"
load_from = DATA_DIR + "pull_keywords.txt"

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
    for attempt in range(10):
        if len(list(Path("/home/ubuntu/repos/moz/downloads/").glob("*.csv"))) == len(list(Path("/home/ubuntu/repos/moz/downloads/").glob("*.csv"))):
            print("Done")
            raise SystemExit()
        try:
            async with async_playwright() as playwright:
                context = await playwright.chromium.launch_persistent_context(
                    viewport={"width": 1600, "height": 900},
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
                except:
                    ...

                # Codegen activated
                if PAUSE_TO_RECORD:
                    await page.pause()  # Edit this line in for codegen and out for automation.

                # -- BEGIN CODEGEN LINES --

                await page.get_by_title("Moz Pro").click()
                await page.get_by_role("link", name="Moz Pro Home").click()
                await page.get_by_role("link", name="Keyword Research").click()
                with open(load_from) as fh:
                    for i, line in enumerate(fh.readlines()):
                        site = line.strip()
                        # Build a set of everything already downloaded
                        seen = set()
                        for file in Path("/home/ubuntu/repos/moz/downloads/").glob("*.csv"):
                            seen_site = file.name.split("_")[1]
                            seen.add(seen_site)
                        if site not in seen:
                            print(i, site)
                            await page.get_by_role("link", name="Ranking Keywords").click()
                            await asyncio.sleep(3)
                            await page.locator("form").filter(has_text="root domainUnited States - en-USanalyze").locator("span").first.click()
                            await page.get_by_role("listitem").filter(has_text="subdomain").click()
                            await page.get_by_placeholder("Enter a subdomain (ex: news.mydomain.com) to find keywords that rank").click()
                            await page.get_by_placeholder("Enter a subdomain (ex: news.mydomain.com) to find keywords that rank").fill(site)
                            await page.get_by_role("button", name="analyze").click()
                            async with page.expect_download(timeout=5000000) as download_info:
                                await page.get_by_role("button", name="Export CSV").click()
                            download = await download_info.value
                            download = download_info.value
                            download = await download
                            await download.save_as(
                                "/home/ubuntu/repos/moz/downloads/" + download.suggested_filename
                            )
                # When done, close the browser.
                await asyncio.sleep(10)
                await context.close()
        except:
            await asyncio.sleep(10)
            ...


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


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/automatically-log-into-moz-pro-with-playwright-browser-automation/">Automatically Log Into MOZ Pro with Playwright Browser Automation</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/going-from-blog-keyword-histogram-to-category-pages/">Going From Blog Keyword Histogram to Category Pages</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/execute/'>Execute</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/panda/'>Pandas</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/action/'>Actions</a></h4></li>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li>
<li><h4><a href='/browser-automation/'>Browser Automation</a></h4></li></ul>