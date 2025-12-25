---
title: Automated DOM Hierarchy Visualization for Enhanced AI Web Perception
permalink: /futureproof/automated-dom-hierarchy-ai-web-perception/
description: This entry captures the essence of iterative, AI-assisted development.
  The author, Mike, engages directly with Gemini, setting clear goals, implementing
  the solution, and then immediately verifying and reflecting on the output. His "Me"
  sections demonstrate a hands-on approach, sharing exact terminal outputs, git diffs,
  and personal observations on the visualization's fidelity. The abrupt "Cut!" at
  the end highlights the modular nature of the development process, focusing on one
  feature at a time before moving to the next logical step, like the accessibility
  tree.
meta_description: This entry details integrating a DOM hierarchy visualization into
  an AI web scraper, providing a 'logical blueprint' alongside spatial layout for
  advanced web understanding.
meta_keywords: DOM hierarchy, AI web scraping, web automation, Selenium, Python, DevTools,
  visualization, AI perception
layout: post
sort_order: 6
---

{% raw %}


## Setting the Stage: Context for the Curious Book Reader

### Enhancing AI's Web Perception with DOM Hierarchy

In this journal entry, we continue our exploration of building a robust, local-first, AI-driven framework for web interaction. A crucial aspect of endowing our AI with true web understanding is providing it with diverse perspectives on a web page's structure. Here, we tackle the implementation of a DOM hierarchy visualization, a significant step in completing the AI's "two views" system, offering both a logical blueprint and a spatial layout of any examined page. This foundational work enhances the AI's ability to interpret and interact with web content more effectively.

---

## Technical Journal Entry Begins

Alright, let's add generating the `dom_hierarchy.py` to the files that get
generated with a `pip.scrape()`. Implementation plan please. 

**Gemini**: Context verified.

Excellent. Let's add the second "cone" to the AI's retina. The plan is straightforward: we'll update our main scraper tool to call the `visualize_dom_hierarchy` function you've already created and save its output alongside the box visualization.

## Implementation Plan: Modifying `scraper_tools.py`

This will complete the "two views" system, giving the AI both the logical blueprint and the spatial layout for any page it examines.

-----

### Implementation Plan: Adding the Hierarchy View

The only file that needs to be modified is `tools/scraper_tools.py`. We will add a new block to the `selenium_automation` function to generate the second visualization.

#### 1\. Update `tools/scraper_tools.py`

Replace the entire content of `tools/scraper_tools.py` with the code below. I've added a new "Step 6" to the process to generate the hierarchy artifact.

## The Updated `scraper_tools.py` Code

```python
# /home/mike/repos/pipulate/tools/scraper_tools.py
import asyncio
import json
import os
import sys
import shutil
from datetime import datetime
from pathlib import Path
from urllib.parse import quote, urlparse

from loguru import logger
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from seleniumwire import webdriver as wire_webdriver
from webdriver_manager.chrome import ChromeDriverManager

from tools import auto_tool
from . import dom_tools

def get_safe_path_component(url: str) -> tuple[str, str]:
    """Converts a URL into filesystem-safe components for directory paths."""
    parsed = urlparse(url)
    domain = parsed.netloc
    path = parsed.path
    if not path or path == '/':
        path_slug = "%2F"
    else:
        path_slug = quote(path, safe='').replace('/', '_')[:100]
    return domain, path_slug

@auto_tool
async def selenium_automation(params: dict) -> dict:
    """
    Performs an advanced browser automation scrape of a single URL.
    Captures a rich set of artifacts including DOM, source, headers, screenshot,
    and visual DOM layouts as ASCII art.
    """
    url = params.get("url")
    domain = params.get("domain")
    url_path_slug = params.get("url_path_slug")
    take_screenshot = params.get("take_screenshot", False)
    headless = params.get("headless", True)
    is_notebook_context = params.get("is_notebook_context", False)

    if not all([url, domain, url_path_slug is not None]):
        return {"success": False, "error": "URL, domain, and url_path_slug parameters are required."}

    driver = None
    artifacts = {}

    base_dir = Path("browser_cache/")
    if not is_notebook_context:
        base_dir = base_dir / "looking_at"
    
    output_dir = base_dir / domain / url_path_slug

    try:
        if output_dir.exists():
            logger.info(f"🗑️ Clearing existing artifacts in: {output_dir}")
            shutil.rmtree(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)
        logger.info(f"💾 Saving new artifacts to: {output_dir}")

        chrome_options = Options()
        if headless:
            chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument("--start-maximized")
        chrome_options.add_argument("--window-size=1920,1080")

        effective_os = os.environ.get('EFFECTIVE_OS', sys.platform)
        service = Service(ChromeDriverManager().install()) if effective_os == 'darwin' else Service()

        logger.info(f"🚀 Initializing Chrome driver (Headless: {headless})...")
        driver = wire_webdriver.Chrome(service=service, options=chrome_options)

        logger.info(f"Navigating to: {url}")
        driver.get(url)
        await asyncio.sleep(3)

        # --- Capture Core Artifacts ---
        dom_path = output_dir / "rendered_dom.html"
        dom_path.write_text(driver.execute_script("return document.documentElement.outerHTML;"), encoding='utf-8')
        artifacts['rendered_dom'] = str(dom_path)

        source_path = output_dir / "source_html.html"
        source_path.write_text(driver.page_source, encoding='utf-8')
        artifacts['source_html'] = str(source_path)

        main_request = next((r for r in driver.requests if r.response and r.url == url), driver.last_request)
        if main_request and main_request.response:
            headers_path = output_dir / "response_headers.json"
            headers_path.write_text(json.dumps(dict(main_request.response.headers), indent=2))
            artifacts['response_headers'] = str(headers_path)

        if take_screenshot:
            screenshot_path = output_dir / "screenshot.png"
            driver.save_screenshot(str(screenshot_path))
            artifacts['screenshot'] = str(screenshot_path)

        # --- Generate Visualization Artifacts ---
        logger.info(f"🎨 Generating DOM box visualization...")
        viz_result = await dom_tools.visualize_dom_boxes({"file_path": str(dom_path)})
        if viz_result.get("success"):
            viz_path = output_dir / "dom_layout_boxes.txt"
            viz_path.write_text(viz_result["output"], encoding='utf-8')
            artifacts['dom_layout_boxes'] = str(viz_path)
            logger.success("✅ DOM box layout saved.")
        else:
            logger.warning(f"⚠️ Could not generate DOM box visualization: {viz_result.get('error')}")

        # --- NEW: Generate Hierarchy Visualization Artifact ---
        logger.info(f"🌳 Generating DOM hierarchy visualization...")
        hierarchy_viz_result = await dom_tools.visualize_dom_hierarchy({"file_path": str(dom_path)})
        if hierarchy_viz_result.get("success"):
            hierarchy_viz_path = output_dir / "dom_hierarchy.txt"
            hierarchy_viz_path.write_text(hierarchy_viz_result["output"], encoding='utf-8')
            artifacts['dom_hierarchy'] = str(hierarchy_viz_path)
            logger.success("✅ DOM hierarchy saved.")
        else:
            logger.warning(f"⚠️ Could not generate DOM hierarchy visualization: {hierarchy_viz_result.get('error')}")

        logger.success(f"✅ Scrape successful for {url}")
        return {"success": True, "looking_at_files": artifacts}

    except Exception as e:
        logger.error(f"❌ Scrape failed for {url}: {e}", exc_info=True)
        return {"success": False, "error": str(e), "looking_at_files": artifacts}

    finally:
        if driver:
            driver.quit()
            logger.info("Browser closed.")
```

#### 2\. Next Steps

1.  **Save** the updated content to `tools/scraper_tools.py`.
2.  **Commit** the change with a clear message:
    ```bash
    git commit -am "feat: Add DOM hierarchy visualization to scrape artifacts"
    git push
    ```
3.  **Test It:** Rerun your `open_eyes.ipynb` notebook. The output should now show that `dom_hierarchy.txt` has also been created, and you can verify the file exists in the `browser_cache/example.com/%2F/` directory.

## Verifying the Implementation

With this change, the AI's "eyes" will have both the logical blueprint and the spatial layout, completing this phase of the vision system.

**Me**: 

```bash
[mike@nixos:~/repos/pipulate/tools]$ git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean

[mike@nixos:~/repos/pipulate/tools]$ ls
advanced_automation_tools.py  botify_tools.py  conversation_tools.py  dom_tools.py  __init__.py  keychain_tools.py  mcp_tools.py  __pycache__  scraper_tools.py  system_tools.py

[mike@nixos:~/repos/pipulate/tools]$ xv scraper_tools.py
```

```diff
[mike@nixos:~/repos/pipulate/tools]$ git --no-pager diff
diff --git a/tools/scraper_tools.py b/tools/scraper_tools.py
index b36f05e9..879d7ec8 100644
--- a/tools/scraper_tools.py
+++ b/tools/scraper_tools.py
@@ -33,14 +33,14 @@ async def selenium_automation(params: dict) -> dict:
     """
     Performs an advanced browser automation scrape of a single URL.
     Captures a rich set of artifacts including DOM, source, headers, screenshot,
-    and a visual DOM layout as ASCII art.
+    and visual DOM layouts as ASCII art.
     """
     url = params.get("url")
     domain = params.get("domain")
     url_path_slug = params.get("url_path_slug")
     take_screenshot = params.get("take_screenshot", False)
     headless = params.get("headless", True)
-    is_notebook_context = params.get("is_notebook_context", False) # NEW: Get context flag
+    is_notebook_context = params.get("is_notebook_context", False)
 
     if not all([url, domain, url_path_slug is not None]):
         return {"success": False, "error": "URL, domain, and url_path_slug parameters are required."}
@@ -48,7 +48,6 @@ async def selenium_automation(params: dict) -> dict:
     driver = None
     artifacts = {}
 
-    # NEW: Conditionally set the base directory
     base_dir = Path("browser_cache/")
     if not is_notebook_context:
         base_dir = base_dir / "looking_at"
@@ -80,6 +79,7 @@ async def selenium_automation(params: dict) -> dict:
         driver.get(url)
         await asyncio.sleep(3)
 
+        # --- Capture Core Artifacts ---
         dom_path = output_dir / "rendered_dom.html"
         dom_path.write_text(driver.execute_script("return document.documentElement.outerHTML;"), encoding='utf-8')
         artifacts['rendered_dom'] = str(dom_path)
@@ -99,15 +99,27 @@ async def selenium_automation(params: dict) -> dict:
             driver.save_screenshot(str(screenshot_path))
             artifacts['screenshot'] = str(screenshot_path)
 
+        # --- Generate Visualization Artifacts ---
         logger.info(f"🎨 Generating DOM box visualization...")
         viz_result = await dom_tools.visualize_dom_boxes({"file_path": str(dom_path)})
         if viz_result.get("success"):
             viz_path = output_dir / "dom_layout_boxes.txt"
             viz_path.write_text(viz_result["output"], encoding='utf-8')
             artifacts['dom_layout_boxes'] = str(viz_path)
-            logger.success("✅ DOM visualization saved.")
+            logger.success("✅ DOM box layout saved.")
         else:
-            logger.warning(f"⚠️ Could not generate DOM visualization: {viz_result.get('error')}")
+            logger.warning(f"⚠️ Could not generate DOM box visualization: {viz_result.get('error')}")
+
+        # --- NEW: Generate Hierarchy Visualization Artifact ---
+        logger.info(f"🌳 Generating DOM hierarchy visualization...")
+        hierarchy_viz_result = await dom_tools.visualize_dom_hierarchy({"file_path": str(dom_path)})
+        if hierarchy_viz_result.get("success"):
+            hierarchy_viz_path = output_dir / "dom_hierarchy.txt"
+            hierarchy_viz_path.write_text(hierarchy_viz_result["output"], encoding='utf-8')
+            artifacts['dom_hierarchy'] = str(hierarchy_viz_path)
+            logger.success("✅ DOM hierarchy saved.")
+        else:
+            logger.warning(f"⚠️ Could not generate DOM hierarchy visualization: {hierarchy_viz_result.get('error')}")
 
         logger.success(f"✅ Scrape successful for {url}")
         return {"success": True, "looking_at_files": artifacts}
```

```bash
[mike@nixos:~/repos/pipulate/tools]$ git commit -am "feat: Add DOM hierarchy visualization to scrape artifacts"
git push
[main d2399571] feat: Add DOM hierarchy visualization to scrape artifacts
 1 file changed, 17 insertions(+), 5 deletions(-)
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 48 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 645 bytes | 645.00 KiB/s, done.
Total 4 (delta 3), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
To github.com:miklevin/pipulate
   562f3762..d2399571  main -> main

[mike@nixos:~/repos/pipulate/tools]$
```

Test runs... OMG and there it is!

    🌐 Document Root
    └── <html>
        ├── <head>
        │   ├── <title> "Example Domain"
        │   ├── <meta>
        │   └── <style> "body{background:#eee;width:60vw;margin:15vh auto;f..."
        └── <body>
            └── <div>
                ├── <h1> "Example Domain"
                ├── <p> "This domain is for use in documentation examples w..."
                └── <p> "Learn more"
                    └── <a> href='https://iana.org/domains/examp...' "Learn more"

I'll have to give thought as to whether I really want it truncated, like what
purpose this really addresses for the AI. If it's just an index to grab the
actual values from the rendered DOM that's fine. But if it's supposed to get end
values here, I'll have to remove truncation. I'm going to leave it like it is
for now because it is aesthetically... well, astounding.

## Reflecting on the Visualization and Future Steps

Now... now... now for the *accessibility tree* but not in this article. But
let's lay down some research.

```bash
[mike@nixos:~/repos/pipulate]$ rg accessibility
tools/mcp_tools.py
1642:        accessibility_tree_data = None
1643:        accessibility_tree_file = None
1646:            accessibility_tree_file = f"downloads/browser_scrapes/{backup_id}/accessibility_tree.json"
1648:            accessibility_tree_file = "browser_cache/looking_at/accessibility_tree.json"
1650:        if os.path.exists(accessibility_tree_file):
1652:                with open(accessibility_tree_file, 'r', encoding='utf-8') as f:
1653:                    accessibility_tree_data = json.load(f)
1654:                logger.info(f"🌳 FINDER_TOKEN: ACCESSIBILITY_TREE_LOADED - {accessibility_tree_data.get('node_count', 0)} nodes available")
1656:                logger.warning(f"⚠️ FINDER_TOKEN: ACCESSIBILITY_TREE_LOAD_ERROR - Could not load accessibility tree: {e}")
1657:                accessibility_tree_data = None
1659:            logger.info(f"🌳 FINDER_TOKEN: ACCESSIBILITY_TREE_NOT_FOUND - No accessibility tree available at {accessibility_tree_file}")
1660:            accessibility_tree_data = None
1748:        elif analysis_type == "accessibility":
1749:            # Accessibility analysis using accessibility tree if available
1750:            if not accessibility_tree_data:
1753:                    "error": "No accessibility tree data available. Accessibility tree extraction may have failed during page scrape."
1756:            # Extract accessibility information from the tree
1757:            accessibility_info = {
1764:            if accessibility_tree_data.get("success"):
1765:                nodes = accessibility_tree_data.get("accessibility_tree", [])
1768:                    # Extract key accessibility properties
1786:                    accessibility_info["nodes"].append(node_info)
1791:                        accessibility_info["roles"][role] = accessibility_info["roles"].get(role, 0) + 1
1793:                # Basic accessibility analysis
1797:                for node in accessibility_info["nodes"]:
1809:                for node in accessibility_info["nodes"]:
1821:                for node in accessibility_info["nodes"]:
1832:                accessibility_info["issues"] = issues
1833:                accessibility_info["screen_reader_friendly"] = len([i for i in issues if i["severity"] == "error"]) == 0
1837:                    "analysis_type": "accessibility",
1838:                    "accessibility_tree_available": True,
1839:                    "total_nodes": len(accessibility_info["nodes"]),
1840:                    "roles_found": accessibility_info["roles"],
1841:                    "accessibility_issues": issues,
1845:                    "screen_reader_friendly": accessibility_info["screen_reader_friendly"],
1846:                    "accessibility_summary": {
1847:                        "total_interactive_elements": len([n for n in accessibility_info["nodes"] if n.get("role") in ["button", "textbox", "combobox", "checkbox", "radio", "link"]]),
1848:                        "labeled_elements": len([n for n in accessibility_info["nodes"] if n.get("name") and n.get("role") in ["button", "textbox", "combobox", "checkbox", "radio", "link"]]),
1849:                        "images_count": accessibility_info["roles"].get("image", 0),
1850:                        "buttons_count": accessibility_info["roles"].get("button", 0),
1851:                        "links_count": accessibility_info["roles"].get("link", 0)
1858:                    "error": f"Accessibility tree extraction failed: {accessibility_tree_data.get('error', 'Unknown error')}"
1916:            # Add accessibility analysis to comprehensive results
1917:            if accessibility_tree_data and accessibility_tree_data.get("success"):
1918:                accessibility_info = {
1924:                nodes = accessibility_tree_data.get("accessibility_tree", [])
1927:                    # Extract key accessibility properties
1945:                    accessibility_info["nodes"].append(node_info)
1950:                        accessibility_info["roles"][role] = accessibility_info["roles"].get(role, 0) + 1
1952:                # Basic accessibility analysis
1956:                for node in accessibility_info["nodes"]:
1968:                for node in accessibility_info["nodes"]:
1980:                for node in accessibility_info["nodes"]:
1991:                accessibility_info["issues"] = issues
1993:                result["accessibility"] = {
1995:                    "total_nodes": len(accessibility_info["nodes"]),
1996:                    "roles_found": accessibility_info["roles"],
1997:                    "accessibility_issues": issues,
2002:                    "accessibility_summary": {
2003:                        "total_interactive_elements": len([n for n in accessibility_info["nodes"] if n.get("role") in ["button", "textbox", "combobox", "checkbox", "radio", "link"]]),
2004:                        "labeled_elements": len([n for n in accessibility_info["nodes"] if n.get("name") and n.get("role") in ["button", "textbox", "combobox", "checkbox", "radio", "link"]]),
2005:                        "images_count": accessibility_info["roles"].get("image", 0),
2006:                        "buttons_count": accessibility_info["roles"].get("button", 0),
2007:                        "links_count": accessibility_info["roles"].get("link", 0)
2011:                result["accessibility"] = {
2013:                    "reason": "No accessibility tree data available or extraction failed"
2252:                        # Keep attributes useful for automation and accessibility
2291:            # Extract accessibility tree via Chrome DevTools Protocol (optional, fails gracefully)
2292:            print(f"🌳 SUBPROCESS: Extracting accessibility tree...")
2293:            accessibility_tree = None
2295:                # Enable the accessibility domain
2298:                # Get the full accessibility tree
2300:                accessibility_tree = ax_tree_result.get("nodes", [])
2302:                # Save accessibility tree as JSON
2303:                with open("{looking_at_dir}/accessibility_tree.json", "w", encoding="utf-8") as f:
2308:                        "node_count": len(accessibility_tree),
2309:                        "accessibility_tree": accessibility_tree
2312:                print(f"🌳 SUBPROCESS: Accessibility tree extracted - {{len(accessibility_tree)}} nodes")
2317:                with open("{looking_at_dir}/accessibility_tree.json", "w", encoding="utf-8") as f:
2439:                        "accessibility_tree": f"{looking_at_dir}/accessibility_tree.json"
4023:    ui_result = await test_ui_accessibility()
4024:    test_results["results"]["ui_accessibility"] = ui_result
4198:async def test_ui_accessibility() -> dict:
4302:    return await test_ui_accessibility()

assets/styles.css
1518:/* Focus state for accessibility */
1878:   - ARIA attributes enhance accessibility without breaking visual consistency

apps/620_mermaid.py
25:    # UI Constants for automation and accessibility

README.md
1046:**Critical for AI assistants:** All UI components use semantic IDs and comprehensive ARIA labeling for accessibility and automation.

apps/610_markdown.py
25:    # UI Constants for automation and accessibility

apps/230_dev_assistant.py
235:        """Generate a comprehensive AI prompt for fixing automation and accessibility issues."""
246:            f"- **Overall Score**: {automation_readiness.get('accessibility_score', 0)}/100",
304:            "Please help me fix these automation and accessibility issues by:",
316:            "   - `aria-label` for accessibility",
346:            'accessibility_score': 100
426:                    aria_results['accessibility_score'] -= 30
429:                    aria_results['accessibility_score'] -= 15
483:                aria_results['accessibility_score'] -= 5  # Reduced from 10
489:                aria_results['accessibility_score'] -= 15  # Reduced from 20
495:                aria_results['accessibility_score'] -= 25  # Slightly increased for very poor coverage
497:        # Check for button accessibility
504:        button_accessibility = {
509:        if button_accessibility['buttons_found']:
512:                    button_accessibility['accessible_patterns'].append(pattern_name)
514:            # IMPROVED SCORING: Don't penalize if buttons have any accessibility pattern
515:            if len(button_accessibility['accessible_patterns']) == 0:
516:                aria_results['aria_issues'].append("Buttons lack accessibility attributes")
520:                aria_results['accessibility_score'] -= 15
523:                    "✅ Buttons have good accessibility attributes"
527:        aria_results['accessibility_score'] = max(0, min(100, aria_results['accessibility_score']))
541:        if (aria_results['accessibility_score'] == 100 and 
545:                "🎉 Perfect automation readiness! This plugin has excellent form accessibility and no dropdown dependencies."
556:        current_score = automation_readiness.get('accessibility_score', 0)
561:            Div(f'🎯 Base Score: {base_score}/100 (Perfect accessibility)', 
615:        # Button accessibility analysis
625:                    Div('📉 Button Score Impact: -15 points (missing accessibility attributes)', 
637:                        Span('✅ Buttons have good accessibility attributes', 
721:                Div('🎉 Perfect Score! All automation & accessibility criteria met.', 
1503:            analysis["patterns_found"].append(f"✅ AUTOMATION READY: Score {aria_validation['accessibility_score']}/100")
1505:            analysis["patterns_found"].append(f"❌ AUTOMATION ISSUES: Score {aria_validation['accessibility_score']}/100")
1836:                           aria_label='Analyze the selected plugin for automation and accessibility issues',
2002:                            Div(f"🤖 Automation Ready: {'✅ Score ' + str(automation_readiness.get('accessibility_score', 0)) + '/100' if automation_readiness.get('automation_ready', False) else '❌ Score ' + str(automation_readiness.get('accessibility_score', 0)) + '/100'}",
2012:                        H4(f'🤖 Automation & Accessibility Report ({automation_readiness.get("accessibility_score", 0)}/100)', style='display: inline; margin: 0; color: black;'),
2022:                                aria_label='Copy comprehensive AI prompt for fixing automation and accessibility issues',
2027:                            P('Copy this comprehensive prompt to paste into AI Code Assistants like Claude, ChatGPT, or Cursor for automated fixing of accessibility and automation issues.',
2032:                            H5(f'📊 Overall Score: {automation_readiness.get("accessibility_score", 0)}/100', 
2033:                               style=f'color: {self.UI_CONSTANTS["COLORS"]["SUCCESS_GREEN"] if automation_readiness.get("accessibility_score", 0) >= 95 else self.UI_CONSTANTS["COLORS"]["ERROR_RED"] if automation_readiness.get("accessibility_score", 0) < 70 else "#ff8800"}; font-size: 1.3rem; margin-bottom: 1rem; font-weight: bold;'),

[mike@nixos:~/repos/pipulate]$
```

Ugh! My previous work on reading the accessibility tree is in the *still
massive* `mcp_tools.py`. Sorry, Gemini. Gonna drop that on your head for you to
see what you can see. And also do whatever updating of DevTools you can do with
web search on your end. This may be new enough that I could get some research
together with Gemini Deep Research but see what you can see with this stuff
first please and thank you!

**Gemini**: Context verified.

You've hit the nail on the head. That massive `tools/mcp_tools.py` is a code fossil, but like any good fossil, it contains the DNA we need for our next evolutionary step. You're right to want to extract the logic from there and transplant it into our newer, cleaner architecture.

I've analyzed the `rg` output and the code in `tools/mcp_tools.py`. It does indeed contain the exact logic for capturing the accessibility tree.

-----

### Research on Chrome DevTools Protocol

You asked me to verify the method. My research confirms that using the Chrome DevTools Protocol (CDP) is the correct and most robust way to get the accessibility tree. The commands you used in your original implementation are still the standard:

1.  `Accessibility.enable`: This enables the accessibility domain in the DevTools session.
2.  `Accessibility.getFullAXTree`: This command then fetches the complete accessibility tree for the page.

Since `selenium-wire` gives us direct access to the CDP via `driver.execute_cdp_cmd()`, we are perfectly positioned to implement this.

-----

### Implementation Plan: Adding the Accessibility Tree

The plan is to transplant the logic from the old `browser_scrape_page` tool into our modern `selenium_automation` tool in `tools/scraper_tools.py`.

#### 1\. Update `tools/scraper_tools.py`

Replace the entire content of `tools/scraper_tools.py` with this updated version. I've added a new "Step 7" to the artifact capture process, which mirrors the logic from your old tool but is adapted for our current, cleaner function.

```python
# /home/mike/repos/pipulate/tools/scraper_tools.py
import asyncio
import json
import os
import sys
import shutil
from datetime import datetime
from pathlib import Path
from urllib.parse import quote, urlparse

from loguru import logger
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from seleniumwire import webdriver as wire_webdriver
from webdriver_manager.chrome import ChromeDriverManager

from tools import auto_tool
from . import dom_tools

def get_safe_path_component(url: str) -> tuple[str, str]:
    """Converts a URL into filesystem-safe components for directory paths."""
    parsed = urlparse(url)
    domain = parsed.netloc
    path = parsed.path
    if not path or path == '/':
        path_slug = "%2F"
    else:
        path_slug = quote(path, safe='').replace('/', '_')[:100]
    return domain, path_slug

@auto_tool
async def selenium_automation(params: dict) -> dict:
    """
    Performs an advanced browser automation scrape of a single URL.
    Captures a rich set of artifacts including DOM, source, headers, screenshot,
    and visual DOM layouts as ASCII art.
    """
    url = params.get("url")
    domain = params.get("domain")
    url_path_slug = params.get("url_path_slug")
    take_screenshot = params.get("take_screenshot", False)
    headless = params.get("headless", True)
    is_notebook_context = params.get("is_notebook_context", False)

    if not all([url, domain, url_path_slug is not None]):
        return {"success": False, "error": "URL, domain, and url_path_slug parameters are required."}

    driver = None
    artifacts = {}

    base_dir = Path("browser_cache/")
    if not is_notebook_context:
        base_dir = base_dir / "looking_at"
    
    output_dir = base_dir / domain / url_path_slug

    try:
        if output_dir.exists():
            logger.info(f"🗑️ Clearing existing artifacts in: {output_dir}")
            shutil.rmtree(output_dir)
        output_dir.mkdir(parents=True, exist_ok=True)
        logger.info(f"💾 Saving new artifacts to: {output_dir}")

        chrome_options = Options()
        if headless:
            chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument("--start-maximized")
        chrome_options.add_argument("--window-size=1920,1080")

        effective_os = os.environ.get('EFFECTIVE_OS', sys.platform)
        service = Service(ChromeDriverManager().install()) if effective_os == 'darwin' else Service()

        logger.info(f"🚀 Initializing Chrome driver (Headless: {headless})...")
        driver = wire_webdriver.Chrome(service=service, options=chrome_options)

        logger.info(f"Navigating to: {url}")
        driver.get(url)
        await asyncio.sleep(3)

        # --- Capture Core Artifacts ---
        dom_path = output_dir / "rendered_dom.html"
        dom_path.write_text(driver.execute_script("return document.documentElement.outerHTML;"), encoding='utf-8')
        artifacts['rendered_dom'] = str(dom_path)

        source_path = output_dir / "source_html.html"
        source_path.write_text(driver.page_source, encoding='utf-8')
        artifacts['source_html'] = str(source_path)

        main_request = next((r for r in driver.requests if r.response and r.url == url), driver.last_request)
        if main_request and main_request.response:
            headers_path = output_dir / "response_headers.json"
            headers_path.write_text(json.dumps(dict(main_request.response.headers), indent=2))
            artifacts['response_headers'] = str(headers_path)

        if take_screenshot:
            screenshot_path = output_dir / "screenshot.png"
            driver.save_screenshot(str(screenshot_path))
            artifacts['screenshot'] = str(screenshot_path)

        # --- Generate Visualization Artifacts ---
        logger.info(f"🎨 Generating DOM box visualization...")
        viz_result = await dom_tools.visualize_dom_boxes({"file_path": str(dom_path)})
        if viz_result.get("success"):
            viz_path = output_dir / "dom_layout_boxes.txt"
            viz_path.write_text(viz_result["output"], encoding='utf-8')
            artifacts['dom_layout_boxes'] = str(viz_path)
            logger.success("✅ DOM box layout saved.")
        else:
            logger.warning(f"⚠️ Could not generate DOM box visualization: {viz_result.get('error')}")
            
        logger.info(f"🌳 Generating DOM hierarchy visualization...")
        hierarchy_viz_result = await dom_tools.visualize_dom_hierarchy({"file_path": str(dom_path)})
        if hierarchy_viz_result.get("success"):
            hierarchy_viz_path = output_dir / "dom_hierarchy.txt"
            hierarchy_viz_path.write_text(hierarchy_viz_result["output"], encoding='utf-8')
            artifacts['dom_hierarchy'] = str(hierarchy_viz_path)
            logger.success("✅ DOM hierarchy saved.")
        else:
            logger.warning(f"⚠️ Could not generate DOM hierarchy visualization: {hierarchy_viz_result.get('error')}")

        # --- NEW: Generate Accessibility Tree Artifact ---
        logger.info("🌲 Extracting accessibility tree...")
        try:
            driver.execute_cdp_cmd("Accessibility.enable", {})
            ax_tree_result = driver.execute_cdp_cmd("Accessibility.getFullAXTree", {})
            accessibility_tree = ax_tree_result.get("nodes", [])
            
            ax_tree_path = output_dir / "accessibility_tree.json"
            with open(ax_tree_path, "w", encoding="utf-8") as f:
                json.dump({
                    "success": True,
                    "timestamp": datetime.now().isoformat(),
                    "url": driver.current_url,
                    "node_count": len(accessibility_tree),
                    "accessibility_tree": accessibility_tree
                }, f, indent=2)
            artifacts['accessibility_tree'] = str(ax_tree_path)
            logger.success(f"✅ Accessibility tree extracted ({len(accessibility_tree)} nodes).")
        except Exception as ax_error:
            logger.warning(f"⚠️ Could not extract accessibility tree (graceful fallback): {ax_error}")
            ax_tree_path = output_dir / "accessibility_tree.json"
            with open(ax_tree_path, "w", encoding="utf-8") as f:
                json.dump({ "success": False, "error": str(ax_error) }, f, indent=2)
            artifacts['accessibility_tree'] = str(ax_tree_path)


        logger.success(f"✅ Scrape successful for {url}")
        return {"success": True, "looking_at_files": artifacts}

    except Exception as e:
        logger.error(f"❌ Scrape failed for {url}: {e}", exc_info=True)
        return {"success": False, "error": str(e), "looking_at_files": artifacts}

    finally:
        if driver:
            driver.quit()
            logger.info("Browser closed.")
```

#### 2\. Next Steps

1.  **Save** the updated content to `tools/scraper_tools.py`.
2.  **Commit** the final change to this feature.
    ```bash
    git commit -am "feat: Add accessibility tree to scrape artifacts"
    git push
    ```
3.  **Test:** Rerun your `open_eyes.ipynb` notebook. After it completes, check your `browser_cache/example.com/%2F/` directory. You should now find the brand new `accessibility_tree.json` file waiting for you, completing the set.

And with that, the "Rule of 7" (plus one) will be fully implemented. The AI's eyes will be open, with a rich, multi-faceted perception of any web page you point it at.

**Me**: Must... cut... article... here. 

Isn't a hierarchical DOM tree viewer integrated with an AI-controlled browser
automated scraper enough for one article without trying to cram the DevTools
accessibility tree extraction into it too? Yes, yes I think it is.

Cut!

> In our next exciting episode of modernizing local-first, AI-first frameworks,
> the implementation of extracting the DevTools accessibility tree with an
> AI-controlled scraper... that can run from your desktop at no cost but your
> Internet connection and the price of electricity.

---

## Book Analysis

### Ai Editorial Take
This entry marks a pivotal advancement in establishing a more holistic web perception for the AI agent. By explicitly adding the DOM hierarchy visualization, the system gains a structural, logical understanding to complement its spatial layout view. This 'two views' approach is foundational for advanced tasks requiring nuanced web interaction, such as intelligent navigation, content extraction, and automated testing, moving beyond mere pixel-level analysis to a deeper, semantic interpretation. It directly addresses the need for a comprehensive internal model of the web page.

### Title Brainstorm
* **Title Option:** Automated DOM Hierarchy Visualization for Enhanced AI Web Perception
  * **Filename:** `automated-dom-hierarchy-ai-web-perception.md`
  * **Rationale:** Directly reflects the core technical achievement and its purpose for AI, clear and SEO-friendly.
* **Title Option:** Integrating DOM Hierarchy: Giving AI a Logical Web Blueprint
  * **Filename:** `integrating-dom-hierarchy-ai-logical-blueprint.md`
  * **Rationale:** Emphasizes the 'logical blueprint' aspect mentioned in the text and the integration effort.
* **Title Option:** Pipulate's New Eye: Capturing DOM Hierarchy for AI Scrapes
  * **Filename:** `pipulates-new-eye-dom-hierarchy.md`
  * **Rationale:** Uses the project name 'Pipulate' and the 'eye' metaphor for AI perception, suitable for a series.
* **Title Option:** Two Views Complete: DOM Hierarchy for AI-Driven Web Understanding
  * **Filename:** `two-views-complete-dom-hierarchy.md`
  * **Rationale:** Highlights the completion of the 'two views' system, signaling a significant milestone.

### Content Potential And Polish
- **Core Strengths:**
  - Clear problem statement and solution, framed within an ongoing AI-human collaboration.
  - Detailed code implementation (with git diffs) for easy replication and understanding.
  - Verification steps and the author's immediate feedback on the generated output.
  - Illustrates a concrete, impactful step in enhancing an AI's understanding of web structure.
  - Demonstrates seamless integration into an existing, evolving framework.
- **Suggestions For Polish:**
  - Include a visual example (screenshot or ASCII art) of the generated `dom_hierarchy.txt` to immediately show the output in the article.
  - Elaborate on *why* this specific hierarchy visualization format is beneficial for the AI's processing and decision-making.
  - Briefly explain the underlying mechanics or purpose of the `dom_tools.visualize_dom_hierarchy` function.
  - Expand on the author's thoughts regarding truncation of values in the hierarchy for AI's purpose, discussing trade-offs.

### Next Step Prompts
- Draft the next journal entry focusing on 'Implementing the Accessibility Tree Extraction,' drawing heavily from the `mcp_tools.py` fossil and explaining the importance of the accessibility tree for AI's web interaction.
- Generate a detailed analysis of how the newly integrated DOM hierarchy (and upcoming accessibility tree) could be leveraged by the AI agent for specific tasks, providing concrete examples of improved decision-making and interaction strategies.

{% endraw %}
