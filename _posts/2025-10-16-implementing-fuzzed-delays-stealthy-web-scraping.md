---
title: Implementing Fuzzed Delays for Stealthy Web Scraping
permalink: /futureproof/implementing-fuzzed-delays-stealthy-web-scraping/
description: I tackled the tricky problem of making `pipulate`'s web scraping stealthier
  by adding fuzzed, randomized delays. This involved threading a new `delay_range`
  parameter across several Python files, from the user-facing Jupyter notebook down
  to the core scraping tools. The 'aha!' moment came from successfully integrating
  the AI's proposed solution after an initial hiccup, confirming the power of iterative
  AI collaboration. This also reinforced my belief that 'context is king' for LLMs,
  echoing the article's broader philosophical theme.
meta_description: 'Master stealthy web scraping: implement fuzzed, randomized delays
  across Python modules for anti-bot measures. From notebooks to core functions, see
  ''Context is King'' in action.'
meta_keywords: web scraping, python, selenium, anti-bot, randomized delay, time.sleep,
  asyncio, undetected-chromedriver, pipulate, jupyter notebook, api, llm, AI, context,
  automation, prompt engineering
layout: post
sort_order: 1
---

## Setting the Stage: Context for the Curious Book Reader

This entry dives into the crucial task of making our `pipulate` project's web scraping capabilities more robust and undetectable. As `pipulate` aims to give AI agents 'eyes' on the web, directly accessing information, we often encounter sophisticated anti-bot systems. This piece documents a specific, iterative solution: introducing fuzzed, randomized delays between requests. It showcases the architectural considerations of threading a new feature across different layers of our Python codebase and highlights the dynamic, collaborative process of problem-solving with an AI, underscoring the vital role of 'context' in LLM interactions.

---

## Technical Journal Entry Begins

The time has come to power-through the Pandas portion of this project... but not
so fast! I have to crawl the site not so fast. I have this wonderful stealth
browser automation now that runs from a Jupyter Notebook on your local machine,
whether your local machine is Mac, Windows or Linux, and I just overcame one of
the stickiest anti-bot systems I've encountered — usually easy to deal with when
crawling from your own desktop because there's not banned IP-ranges and such.

## The Challenge of Anti-Bot Systems

But I don't want to get my home IP banned even temporarily and have to wait it
out or introduce VPN into the mix. If I need VPN fast my contingency plan is to
just switch to the Mac (I'm on NixOS right now) and just run HMA (HideMyAss)
which is basically like NordVPN but I'm familiar with HMA from back in the day
and it's pretty well supported platform-wise and has tons of connection points
and so just haven't switched.

But I shouldn't need that if I just space out the page requests. So not Pandas
just yet. This will probably be the first of my "tomorrow" articles, so hold on,
here we go.

Take a look at my *foo files* and put only what's necessary in context.

## Structuring Context for AI

```python
FILES_TO_INCLUDE_RAW = """\
/home/mike/repos/pipulate/flake.nix
/home/mike/repos/pipulate/pipulate/core.py
/home/mike/repos/pipulate/Notebooks/FAQuilizer.ipynb
/home/mike/repos/pipulate/Notebooks/secretsauce.py
/home/mike/repos/pipulate/tools/scraper_tools.py
/home/mike/repos/pipulate/tools/dom_tools.py
"""
```

The story we tell to Gemini AI today is the one I started above, so this is the
prompt. Funny how it works that way, huh? I'll send it the meta descriptions of
the last few articles too so it has the storytelling arc in addition to the code
from the repo as context. In SEO over the past 20 years or so, content has been
king. But content is now infinite because LLMs are indeed basically those
infinite typing monkeys on typewriters. Every website could now respond to every
user request custom and content could be never repeating. Prompts are already a
lot like page requests and responses are already a lot like serving pages, and
that's how Ollama already works... but that's all another story.

## The Evolving Role of Content and Context

Today I say "Hello, Gemini!" I need to fuzz those requests you see in
`scraper_tools.py`. I certainly don't want to complicate things for the user
with yet more parameters... yet... yet, I see no way around it. Where we support
things like headless and persistent and profile_name we now also need something
like delay_range supporting maybe a tuple (5:10) for 5 to 10 seconds delay
between each request. And you additionally have to make sure the resulting
number is fuzzed in terms of the last millisecond so that it doesn't look like
exact second increments.

## Designing Fuzzed Request Delays

Please and thank you!

...oh yeah, and now that content is infinite, it's CONTEXT that's King. Here's
how we crown ourselves the king of context. ***PROMPT FOO!***

> He's got style, a groovy style  
> And a car that just won't stop  
> When the going gets rough, he's super tough  
> With a Hong Kong Phooey chop (Hi-Ya!)  

```bash
[mike@nixos:~/repos/pipulate]$ python prompt_foo.py -l [-20:]
--- Processing Files ---
  -> Converting notebook: /home/mike/repos/pipulate/Notebooks/FAQuilizer.ipynb

--- Generating Auto-Context ---
Generating codebase tree diagram... (2,128 tokens)
Adding narrative context from articles... (20 articles)
Python file(s) detected. Generating UML diagrams...
  -> Generating for /home/mike/repos/pipulate/apps/820_selenium.py... (263 tokens)
  -> Generating for /home/mike/repos/pipulate/apps/440_browser_automation.py... (401 tokens)
  -> Generating for /home/mike/repos/pipulate/tools/mcp_tools.py... (195 tokens)
  -> Generating for /home/mike/repos/pipulate/pipulate/core.py... (2,225 tokens)
  -> Generating for /home/mike/repos/pipulate/Notebooks/secretsauce.py... (skipped)
  -> Generating for /home/mike/repos/pipulate/tools/scraper_tools.py... (skipped)
  -> Generating for /home/mike/repos/pipulate/tools/dom_tools.py... (431 tokens)
...UML generation complete.

--- Files Included ---
• /home/mike/repos/pipulate/flake.nix (7,226 tokens)
• /home/mike/repos/pipulate/apps/820_selenium.py (3,428 tokens)
• /home/mike/repos/pipulate/apps/440_browser_automation.py (10,285 tokens)
• /home/mike/repos/pipulate/tools/mcp_tools.py (40,480 tokens)
• /home/mike/repos/pipulate/pipulate/core.py (20,823 tokens)
• /home/mike/repos/pipulate/Notebooks/FAQuilizer.ipynb (611 tokens)
• /home/mike/repos/pipulate/Notebooks/secretsauce.py (2,982 tokens)
• /home/mike/repos/pipulate/tools/scraper_tools.py (1,860 tokens)
• /home/mike/repos/pipulate/tools/dom_tools.py (3,333 tokens)

--- Auto-Context Included ---
• Codebase Structure (eza --tree) (2,128 tokens)
• Recent Narrative Context (1,234 tokens)
• UML Class Diagram (ASCII for /home/mike/repos/pipulate/apps/820_selenium.py) (263 tokens)
• UML Class Diagram (ASCII for /home/mike/repos/pipulate/apps/440_browser_automation.py) (401 tokens)
• UML Class Diagram (ASCII for /home/mike/repos/pipulate/tools/mcp_tools.py) (195 tokens)
• UML Class Diagram (ASCII for /home/mike/repos/pipulate/pipulate/core.py) (2,225 tokens)
• UML Class Diagram (ASCII for /home/mike/repos/pipulate/tools/dom_tools.py) (431 tokens)

--- Prompt Summary ---
Total Tokens: 98,947
Total Words:  39,420

--- Size Perspective ---
📚 Equivalent in length to a **Novella or a Master's Dissertation** (Note: With a token/word ratio of 2.51, this content is far denser and more complex than typical prose of this length).

Markdown output copied to clipboard

[mike@nixos:~/repos/pipulate]$
```

While I wait for the implementation plan, I'll yabber on a bit. I'm now used to

## Post-Implementation Reflections
the tedious chain of parameter passing down from the Notebook `FAQuilizer.ipynb`
down to `secretsauce.py` and down again to `pipulate/core.py` and then down yet
again to the tool-call `tools/scraper_tool.py` where the final work is done.
There's a lesson in API exposure there with different levels of customization
from what the Notebook-user sees to what the *Secret Sauce Chef* sees to what
the *Pipulate Architect* sees.

## Orchestrating Parameters Across the Stack

So for things like this, there's always 3 updates for me, the Architect to make.
That's so the end user using the Notebook sees as little *extra noise* as
possible. Many of these things have perfectly functional defaults so the call
can be much shorter than what I currently have in the Notebook. Shorter is
cleaner and less noise (more signal).

Ugh! The process crapped out. Let's help it along on the 2nd go around.

Gemini, this was your thinking:

[Copy/pastes both thought process]

...and this was how far along you were:

[Copy/pastes as much progress as it made before crashing.]

> It was just a drag-copy and `Ctrl`+`c` because the markdown copy icon wasn't there, unfinished as it was.

...and so you literally checked out at the last second! Please try again.

## Iterative Refinement with AI Collaboration

[Re-submits enhanced prompt that has most of the work already done]

**Gemini**: Context verified.

Of course\! Picking up where we left off. Adding a fuzzed, randomized delay is a crucial step for responsible and effective scraping. Your analysis of the parameter-passing chain is spot on; we need to thread the new `delay_range` parameter through each layer of abstraction, from the user-facing notebook down to the tool that performs the action.

Let's complete the implementation. Here are the finished modifications for all the necessary files.

## Gemini's Solution: Code Implementation Details

-----

### 1\. Update `pipulate/core.py`

First, I'll update the `Pipulate.scrape` method. This allows it to accept the `delay_range` parameter and pass it into the `params` dictionary for the underlying scraper tool.

```python
# /home/mike/repos/pipulate/pipulate/core.py
...
    # Add persistent=False and profile_name=None to the function signature
    async def scrape(self, url: str, take_screenshot: bool = False, mode: str = 'selenium', headless: bool = True, verbose: bool = True, persistent: bool = False, profile_name: str = "default", delay_range: tuple = None, **kwargs):
        """
        Gives AI "eyes" by performing browser automation or HTTP requests to scrape a URL.

        This method is the primary entrypoint for scraping and supports multiple modes.
        The default mode is 'selenium' which uses a full browser.

        Args:
            url (str): The URL to scrape.
            take_screenshot (bool): Whether to capture a screenshot (selenium mode only). Defaults to False.
            mode (str): The scraping mode to use ('selenium', 'requests', etc.). Defaults to 'selenium'.
            headless (bool): Whether to run the browser in headless mode (selenium mode only). Defaults to True.
            persistent (bool): Whether to use a persistent browser profile. Defaults to False.
            profile_name (str): The name of the persistent profile to use. Defaults to "default".
            delay_range (tuple): A tuple (min, max) for random delay in seconds between requests.
            **kwargs: Additional parameters to pass to the underlying automation tool.

        Returns:
            dict: The result from the scraper tool, including paths to captured artifacts.
        """
        from tools.scraper_tools import selenium_automation
        from urllib.parse import urlparse, quote
        from datetime import datetime

        logger.info(f"👁️‍🗨️ Initiating scrape for: {url} (Mode: {mode}, Headless: {headless}, Persistent: {persistent})")

        # --- New Directory Logic ---
        parsed_url = urlparse(url)
        domain = parsed_url.netloc
        path = parsed_url.path or '/'
        # Use quote with an empty safe string to encode everything, including slashes
        url_path_slug = quote(path, safe='')

        params = {
            "url": url,
            "domain": domain,
            "url_path_slug": url_path_slug,
            "take_screenshot": take_screenshot,
            "headless": headless,
            "is_notebook_context": self.is_notebook_context, # Pass the context flag
            "verbose": verbose,
            "persistent": persistent,
            "profile_name": profile_name,
            "delay_range": delay_range,
            **kwargs # Pass through any other params
        }

        if mode == 'selenium':
            try:
                result = await selenium_automation(params)
                return result
            except Exception as e:
                logger.error(f"❌ Advanced scrape failed for {url}: {e}")
                return {"success": False, "error": str(e)}
        else:
            logger.warning(f"Scrape mode '{mode}' is not yet implemented.")
            return {"success": False, "error": f"Mode '{mode}' not implemented."}
...
```

-----

### 2\. Update `tools/scraper_tools.py`

Next, I'll add the delay logic to `selenium_automation`. The delay will occur *before* the browser is initialized for each request, effectively spacing out the calls made by the loop in your notebook.

```python
# /home/mike/repos/pipulate/tools/scraper_tools.py
...
import asyncio
import json
import os
import sys
import shutil
import tempfile
from datetime import datetime
from pathlib import Path
from urllib.parse import quote, urlparse
import random
import time

from loguru import logger
import undetected_chromedriver as uc
...
@auto_tool
async def selenium_automation(params: dict) -> dict:
    """
    Performs an advanced browser automation scrape of a single URL using undetected-chromedriver.
    ...
    """
    url = params.get("url")
    domain = params.get("domain")
    url_path_slug = params.get("url_path_slug")
    take_screenshot = params.get("take_screenshot", False)
    headless = params.get("headless", True)
    is_notebook_context = params.get("is_notebook_context", False)
    persistent = params.get("persistent", False)
    profile_name = params.get("profile_name", "default")
    verbose = params.get("verbose", True)
    delay_range = params.get("delay_range")

    if not all([url, domain, url_path_slug is not None]):
        return {"success": False, "error": "URL, domain, and url_path_slug parameters are required."}

    # --- Fuzzed Delay Logic ---
    if delay_range and isinstance(delay_range, (tuple, list)) and len(delay_range) == 2:
        min_delay, max_delay = delay_range
        if isinstance(min_delay, (int, float)) and isinstance(max_delay, (int, float)) and min_delay <= max_delay:
            delay = random.uniform(min_delay, max_delay)
            if verbose:
                logger.info(f"⏳ Waiting for {delay:.3f} seconds before next request...")
            await asyncio.sleep(delay)
        else:
            logger.warning(f"⚠️ Invalid delay_range provided: {delay_range}. Must be a tuple of two numbers (min, max).")


    driver = None
    artifacts = {}
...
```

-----

### 3\. Update `Notebooks/secretsauce.py`

Now, I'll update your `scrape_and_extract` helper function to accept the `delay_range` parameter and pass it to `pip.scrape`. I'll also add logic to skip the delay for the very first URL in the list.

```python
# /home/mike/repos/pipulate/notebooks/secretsauce.py
...
# Add persistent and profile_name to the function signature
async def scrape_and_extract(job: str, headless: bool = True, verbose: bool = False, stealth: bool = True, persistent: bool = False, profile_name: str = "default", delay_range: tuple = (5, 10)):
    """
    Scrapes each URL using pip.scrape() and immediately parses the HTML
    to extract key SEO data. Verbosity is now controllable.
    """
    print("🚀 Starting browser-based scraping and extraction...")
    
    # --- NEW: Read fresh URLs from the notebook and update the state ---
    fresh_urls = _get_urls_from_notebook()
    if fresh_urls:
        print(f"✨ Found {len(fresh_urls)} URLs in the notebook.")
        pip.set(job, URL_LIST_STEP, fresh_urls)
    # --------------------------------------------------------------------

    urls_to_process = pip.get(job, URL_LIST_STEP, [])
    if not urls_to_process:
        print("❌ No URLs to process. Please add them to the 'url-list-input' cell in your notebook.")
        return

    extracted_data = []

    for i, url in enumerate(urls_to_process):
        print(f"  -> 👁️  [{i+1}/{len(urls_to_process)}] Processing: {url}")
        
        # Apply delay only AFTER the first request to avoid an unnecessary initial wait
        current_delay_range = delay_range if i > 0 else None

        try:
            scrape_result = await pip.scrape(
                url=url,
                take_screenshot=True,
                headless=headless,
                verbose=verbose,
                stealth=stealth,
                persistent=persistent,        # Pass persistent flag
                profile_name=profile_name,    # Pass profile name
                delay_range=current_delay_range # Pass the fuzzed delay range
            )

            if not scrape_result.get("success"):
                if verbose:
                    print(f"  -> ❌ Scrape failed: {scrape_result.get('error')}")
                continue

            dom_path = scrape_result.get("looking_at_files", {}).get("rendered_dom")
...
```

-----

### 4\. Update `Notebooks/FAQuilizer.ipynb`

Finally, let's update the notebook to demonstrate how to use the new feature. You can now pass `delay_range` directly to the `scrape_and_extract` function to override the default.

```python
# /home/mike/repos/pipulate/notebooks/faquilizer.ipynb
...
# %% editable=true slideshow={"slide_type": ""}
# This cell now uses a persistent profile, which is great for sites that require logins.
# The session data will be saved in data/uc_profiles/my_session/
await secretsauce.scrape_and_extract(
    job, 
    headless=False, 
    verbose=False, 
    persistent=True, 
    profile_name="my_session",
    delay_range=(7, 15) # Example: wait 7 to 15 seconds between requests
)

# %% [markdown] editable=true slideshow={"slide_type": ""}
# #### You Get the Gist
...
```

These changes create the full chain you envisioned, allowing for easy control over request timing directly from the notebook while keeping the implementation details cleanly abstracted. Let me know if you'd like to proceed with any other modifications\!

**Me**: It's amazing how much faster it is when you give it the solution it
almost just completed the previous attempt.

So first we pin the diffs of the 2 files that are already under git version
control management automatically:

```diff
[mike@nixos:~/repos/pipulate]$ git --no-pager diff
diff --git a/pipulate/core.py b/pipulate/core.py
index f06cc4b0..70c0237c 100644
--- a/pipulate/core.py
+++ b/pipulate/core.py
@@ -1881,8 +1881,7 @@ class Pipulate:
         state = self.read_state(job)
         return state.get(step, default)
 
-    # Add persistent=False and profile_name=None to the function signature
-    async def scrape(self, url: str, take_screenshot: bool = False, mode: str = 'selenium', headless: bool = True, verbose: bool = True, persistent: bool = False, profile_name: str = "default", **kwargs):
+    async def scrape(self, url: str, take_screenshot: bool = False, mode: str = 'selenium', headless: bool = True, verbose: bool = True, persistent: bool = False, profile_name: str = "default", delay_range: tuple = None, **kwargs):
         """
         Gives AI "eyes" by performing browser automation or HTTP requests to scrape a URL.
 
@@ -1896,6 +1895,7 @@ class Pipulate:
             headless (bool): Whether to run the browser in headless mode (selenium mode only). Defaults to True.
             persistent (bool): Whether to use a persistent browser profile. Defaults to False.
             profile_name (str): The name of the persistent profile to use. Defaults to "default".
+            delay_range (tuple): A tuple (min, max) for random delay in seconds between requests.
             **kwargs: Additional parameters to pass to the underlying automation tool.
 
         Returns:
@@ -1924,6 +1924,7 @@ class Pipulate:
             "verbose": verbose,
             "persistent": persistent,
             "profile_name": profile_name,
+            "delay_range": delay_range,
             **kwargs # Pass through any other params
         }
 
diff --git a/tools/scraper_tools.py b/tools/scraper_tools.py
index 140bd298..0023430e 100644
--- a/tools/scraper_tools.py
+++ b/tools/scraper_tools.py
@@ -1,7 +1,4 @@
 # /home/mike/repos/pipulate/tools/scraper_tools.py
-import faulthandler
-faulthandler.enable()
-
 import asyncio
 import json
 import os
@@ -11,6 +8,8 @@ import tempfile
 from datetime import datetime
 from pathlib import Path
 from urllib.parse import quote, urlparse
+import random
+import time
 
 from loguru import logger
 import undetected_chromedriver as uc
@@ -48,17 +47,27 @@ async def selenium_automation(params: dict) -> dict:
     persistent = params.get("persistent", False)
     profile_name = params.get("profile_name", "default")
     verbose = params.get("verbose", True)
+    delay_range = params.get("delay_range")
 
     if not all([url, domain, url_path_slug is not None]):
         return {"success": False, "error": "URL, domain, and url_path_slug parameters are required."}
 
+    # --- Fuzzed Delay Logic ---
+    if delay_range and isinstance(delay_range, (tuple, list)) and len(delay_range) == 2:
+        min_delay, max_delay = delay_range
+        if isinstance(min_delay, (int, float)) and isinstance(max_delay, (int, float)) and min_delay <= max_delay:
+            delay = random.uniform(min_delay, max_delay)
+            if verbose:
+                logger.info(f"⏳ Waiting for {delay:.3f} seconds before next request...")
+            await asyncio.sleep(delay)
+        else:
+            logger.warning(f"⚠️ Invalid delay_range provided: {delay_range}. Must be a tuple of two numbers (min, max).")
+
     driver = None
     artifacts = {}
     profile_path = None
     temp_profile = False
 
-
-
     # --- Find the browser executable path ---
     browser_path = shutil.which("chromium")
     driver_path = shutil.which("undetected-chromedriver")

[mike@nixos:~/repos/pipulate]$
```

And now I make the changes to the 2 files that have to be manually synced to the
git repo. And I just go run it against all the URLs and it works perfectly.

Yup. That's one of those "the world just changed" sort of moments. I love it
when a plan comes together. Now onto the Pandas Excel-spreadheet type work.
Hopefully. There's bound to be a couple more rabbit holes I can anticipate like
walking the folders and... hmmm. I guess exposing just the right amount of API
up through the secret sauce. It's all crammed together in a last step. Well,
I'll hop to it now.

---

## Book Analysis

### Ai Editorial Take
This entry is a strong demonstration of practical AI-assisted software development. It not only documents a specific technical solution (anti-bot scraping delays) but also illustrates the iterative nature of collaborating with an AI, highlighting debugging and refinement. The philosophical interlude about 'context is king' elevates the piece beyond mere technical documentation, giving it broader relevance for understanding the modern AI landscape. It effectively blends a technical 'how-to' with a 'why-it-matters' perspective, making it a valuable addition to a book on AI and automation.

### Title Brainstorm
* **Title Option:** Implementing Fuzzed Delays for Stealthy Web Scraping
  * **Filename:** `implementing-fuzzed-delays-stealthy-web-scraping.md`
  * **Rationale:** This title is direct and clearly states the primary technical problem addressed and its solution. It uses strong keywords for SEO.
* **Title Option:** Context is King: Automating Stealth in Web Scrapers with AI
  * **Filename:** `context-is-king-automating-stealth-web-scrapers-ai.md`
  * **Rationale:** This title connects the technical implementation (stealthy scraping) to the philosophical insight about AI ('Context is King') and highlights the role of AI in the development process.
* **Title Option:** From Jupyter to Core: Threading Anti-Bot Delays in Pipulate
  * **Filename:** `from-jupyter-to-core-threading-anti-bot-delays-pipulate.md`
  * **Rationale:** This title emphasizes the architectural scope of the implementation, showing how a single feature traverses multiple layers of the codebase, and names the project.
* **Title Option:** Overcoming Anti-Bot Barriers: A Collaborative AI Approach
  * **Filename:** `overcoming-anti-bot-barriers-collaborative-ai-approach.md`
  * **Rationale:** This title focuses on the challenge (anti-bot barriers) and positions the solution as a collaborative effort with AI, highlighting the iterative development process.

### Content Potential And Polish
- **Core Strengths:**
  - Demonstrates practical problem-solving in web scraping by addressing common anti-bot measures.
  - Illustrates effective AI-assisted development and the value of iterative refinement in technical projects.
  - Highlights a crucial stealth technique (randomized delays) applicable to various automation tasks.
  - Exemplifies parameter threading across a layered application architecture, from user interface to core logic.
  - Connects a specific technical implementation to a broader philosophical concept ('Context is King' for LLMs), elevating the entry's intellectual value.
- **Suggestions For Polish:**
  - Expand on the initial anti-bot challenges or detection methods encountered *before* the decision to implement randomized delays, to set a more vivid problem context.
  - Provide a concise overview of the `pipulate` project's overarching goal for readers unfamiliar with previous entries.
  - Elaborate on the 'infinite content' versus 'context is king' idea with more specific examples or implications for AI-driven content generation.
  - Briefly explain *why* `undetected-chromedriver` is chosen over standard Selenium for this specific use case, highlighting its advantages.
  - Consider adding a small 'conceptual' diagram or flowchart of the parameter passing chain (Notebook -> secretsauce -> core -> scraper_tools) to visually clarify the architectural points.

### Next Step Prompts
- Analyze the author's stated next steps regarding 'Pandas portion of this project' and 'walking the folders.' Outline a plan for integrating data analysis (Pandas) and local file system content processing into the `pipulate` workflow, detailing potential API exposures and architecture changes needed.
- Given the `secretsauce.py` and `FAQuilizer.ipynb` files, generate a concise API documentation for the `scrape_and_extract` function, including all its parameters, return values, and typical usage examples for the book's audience.
