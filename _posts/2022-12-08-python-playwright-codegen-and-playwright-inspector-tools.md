---
date: 2022-12-08
title: Python Playwright CodeGen and Playwright Inspector Tools
permalink: /blog/python-playwright-codegen-and-playwright-inspector-tools/
headline: Making Automation Easier with Python Playwright CodeGen and Playwright Inspector Tools
description: I'm using the Python Playwright CodeGen and Playwright Inspector Tools to make automation easier. With the built-in tools I can record my browser activity and generate code for it. After experimenting with different commands, I was able to successfully run the python -m playwright codegen --target python-async command, allowing me to record my automation code in JupyterLab. I also created two templates for easier development.
keywords: Python, Playwright, CodeGen, Inspector, Tools, Automation, Browser, JupyterLab, Templates, Development, Headless, Server
categories: python, automation, jupyterlab, playwright, development
layout: post
---

I always make the first Virtual Desktop on my Windows systems a maximized Linux
Terminal running vim with my journal in it. Now I do keep multiple journals,
but they're all loaded at once. Or as many as I like are loaded at once,
according a parameter I feed my /usr/local/sbin/all command. Notice the lack of
any file extension on the "all" program. That's by design so that the whole
Unix-like system this work regardless of your programming language, so long as
it's made for Linux and can take in arguments from the command-line... and
maybe inherit the invoking shell's environment variables. For you see, a
Terminal is a shell (often BASH) which have rules, which constitute an
application program interface (API), and that's much of what's important about
Linux.

Okay, so think this process through. Make automation easier in playright. Use
the tools that are built in. It's possible to record what you're doing int the
browser.

    [py311] ubuntu@LunderVand:~/repos/codegen $ python -m playwright codegen --help
    Usage: playwright codegen [options] [url]

    open page and generate code for user actions

    Options:
      -o, --output <file name>        saves the generated script to a file
      --target <language>             language to generate, one of javascript, playwright-test,
                                      python, python-async, python-pytest, csharp, csharp-mstest,
                                      csharp-nunit, java (default: "python")
      --save-trace <filename>         record a trace for the session and save it to a file
      -b, --browser <browserType>     browser to use, one of cr, chromium, ff, firefox, wk, webkit
                                      (default: "chromium")
      --block-service-workers         block service workers
      --channel <channel>             Chromium distribution channel, "chrome", "chrome-beta",
                                      "msedge-dev", etc
      --color-scheme <scheme>         emulate preferred color scheme, "light" or "dark"
      --device <deviceName>           emulate device, for example  "iPhone 11"
      --geolocation <coordinates>     specify geolocation coordinates, for example
                                      "37.819722,-122.478611"
      --ignore-https-errors           ignore https errors
      --load-storage <filename>       load context storage state from the file, previously saved
                                      with --save-storage
      --lang <language>               specify language / locale, for example "en-GB"
      --proxy-server <proxy>          specify proxy server, for example "http://myproxy:3128" or
                                      "socks5://myproxy:8080"
      --proxy-bypass <bypass>         comma-separated domains to bypass proxy, for example
                                      ".com,chromium.org,.domain.com"
      --save-har <filename>           save HAR file with all network activity at the end
      --save-har-glob <glob pattern>  filter entries in the HAR by matching url against this glob
                                      pattern
      --save-storage <filename>       save context storage state at the end, for later use with
                                      --load-storage
      --timezone <time zone>          time zone to emulate, for example "Europe/Rome"
      --timeout <timeout>             timeout for Playwright actions in milliseconds, no timeout by
                                      default
      --user-agent <ua string>        specify user agent string
      --viewport-size <size>          specify browser viewport size in pixels, for example "1280,
                                      720"
      -h, --help                      display help for command

    Examples:

      $ codegen
      $ codegen --target=python
      $ codegen -b webkit https://example.com

It looks like the command I may be interested in is:

    python -m playwright codegen --target python-async

Wow, this is working better than I could have imagined. I may have to allow
"playwright install" to occur during the installation. The playwright-installed
version may be good for doing the recording. Lean into strengths.

After some experimentation, this is really the line I want (do login with the
first version):

    python -m playwright codegen --target python-async --save-storage keep.db --viewport-size 1400,1400
    python -m playwright codegen --target python-async --load-storage keep.db --viewport-size 1400,1200

JupyterLab will allow async automation code not inside an async function due to
how it's written. It's easier to develop and debug without it being inside a
function. If it were ever put on a headless server scheduled, we'd have to
rework it a bit. It can also work in Jupyter the way it does on the server, but
it's less easy to develop that way. And so, the key insights:

This is a template that works in Jupyter:

    from playwright.async_api import async_playwright
    import asyncio

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
            args=["--start-maximized"],
        )

        page = await browser.new_page()
        await page.goto("https://www.google.com/search?q=mike+levin+seo")
        await page.screenshot(path="screenshot.png", full_page=True)
        # await asyncio.sleep(10)
        await browser.close()

This is the template that gets recorded from Playwright Inspector:

    import asyncio

    from playwright.async_api import Playwright, async_playwright, expect


    async def run(playwright: Playwright) -> None:
        browser = await playwright.chromium.launch(headless=False)
        context = await browser.new_context(storage_state="keep.db", viewport={"width":1500,"height":1300})
        page = await context.new_page()
        await page.goto("https://google.com/")

        # ---------------------
        await context.close()
        await browser.close()


    async def main() -> None:
        async with async_playwright() as playwright:
            await run(playwright)


    asyncio.run(main())


## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/automation/'>Automation</a></h4></li>
<li><h4><a href='/jupyterlab/'>JupyterLab</a></h4></li>
<li><h4><a href='/playwright/'>Playwright</a></h4></li>
<li><h4><a href='/development/'>Development</a></h4></li></ul>