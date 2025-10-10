---
title: 'Git Time Travel & The Strings Within Strings Dilemma: Debugging AI-Generated
  Code'
permalink: /futureproof/git-time-travel-strings-within-strings-ai-code-debugging/
description: 'This journal entry chronicles my deep dive into advanced browser automation
  within Pipulate, focusing on the intricate ''strings within strings'' challenge
  of dynamically generated code. I document a precise Git rollback, revealing the
  messy yet illuminating path of debugging a critical `TypeError` by enhancing subprocess
  traceback logging. The core insight solidified: when an AI generates code that generates
  more code, robust debugging mechanisms for the inner script are paramount. This
  journey culminated in the strategic decision to refactor a monolithic automation
  file into more semantically focused modules, beginning with `scraper_tools.py`,
  to achieve greater clarity and architectural elegance.'
meta_description: 'Debugging AI-generated code: A Git time travel story unravels ''strings
  within strings'' in Pipulate''s browser automation, leading to architectural refactoring
  insights.'
meta_keywords: Git, time travel, debugging, AI, browser automation, metaprogramming,
  Python, subprocesses, refactoring, Pipulate, Jupyter Notebook, TypeError, scraping,
  code architecture, development workflow
layout: post
sort_order: 5
---

## Setting the Stage: Context for the Curious Book Reader

This entry captures a pivotal moment in the development of Pipulate, a project at the forefront of AI-assisted browser automation. It delves into the intricate challenges of building self-modifying, AI-driven systems and the ingenious debugging strategies required to navigate them. Join us as we explore the author's firsthand account of using Git not just for version control, but as a time machine to dissect a critical coding dilemma, revealing profound insights into metaprogramming and the architecture of intelligent agents.

---

## Technical Journal Entry Begins

Once I solve this the world is much better because I have generic scraper tech
built into Pipulate that works with browser automation from a Jupyter Notebook.
And when a workflow is worked out there with all its magical scraping that works
just like it's happing by a human being from your desktop but with AI
assistance, it can be moved over into an even more automated (and less having to
look at Python code) Pipulate Web App. I'm pretty sure people are gonna love
this and it's the breakout killer app for Pipulate, especially since it will
work cross-platform, on macOS, Windows or Linux — just from the *desktop* which
is part of the trick. 

## The Vision: Generic Scraper Tech and Pipulate's Killer App

When a browser-automating workflow is run from a Colab Notebook it will have to
fall back to other scraping technique — unless of course I can bridge that
divide which is possible but not a rabbit hole I will be diving into this
weekend (same tech still on Colab but headless maybe). The "from the desktop"
bit I'm working now is essential to so many things and most of the hard work is
already done, but as I said in the last post where I started to tackle this
until I was distracted by Gemini inserting math codes into its response making
me launch into a quick sub-project, I was spinning my wheels with the AI coding
assistance and finally looked at the files and *saw why* and have to talk it
through out loud to really internalize and learn a bit *about my own code!*

## Git's Time-Travel Machine: Debugging the Errant Path

Okay, let's talk this out. And I think I'll even fix the semantics of this whole
thing as I go. When we `git reset --hard HEAD^` and then `git push --force`
we're backing up in time and erasing the timeline we were just on. It's the
birds eating the Hansel and Gretel breadcrumb trail that you leave for yourself.
It's not the bizarro parallel alternative timelines of git branching so why
would you do it? It's more tidy.

And when we back-out we can capture what we did the first time, analyze why we
did it and figure out what we'll do better. There is a very special situation
here because triggering the automation of browser `B` from the original
caller... hmmm, let's call him *arcanist* `A` — but we're really talking about
Alice and Bob here because it's always Alice and Bob — and so there are TWO SETS
of programming commands. Arcanist is following its instructions and Browser is
following its instructions. There are TWO sets of instructions. I'm writing TWO
sets of Python programs at once, and there's likely to be some JavaScript mixed
in as well. So we set the stage. This is a tricky magic trick.

## Unraveling the Dual Instruction Sets: Arcanist A and Browser B

We look at the roll-back we're about to do.

## The Git Rollback Chronicle: A Step-by-Step Diff Analysis

```bash
[mike@nixos:~/repos/pipulate]$ git --no-pager log -7
commit fd2cf24eb06e0b0dfc2c1b6fb78467d3798e5d32 (HEAD -> main)
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 10:06:38 2025 -0400

    Composing prompt fu

commit e217e64e1b1cefdd6a9af72380c588f89b374dc8
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 09:59:11 2025 -0400

    About to apply patch with full traceback ability

commit 8f6b60a70d1821784f9064a28bcdc680972b0a06
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 07:57:54 2025 -0400

    About to apply patch

commit 33a041be79f5bbfa16f1131fe3d9887715345299
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 05:29:24 2025 -0400

    About to add new eyes function

commit 405f3df0d0e9e5bff31ebcc6926482744a3ae2c0
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 04:01:22 2025 -0400

    Rudimenary browser automation from JupyterLab Notebook works. This is the commit before the refactoring storm to solidify Chip's eyes

commit e701b5f09334efb356d052f7af7e3ece20708584
Author: Mike Levin <miklevin@gmail.com>
Date:   Thu Oct 9 17:48:51 2025 -0400

    Put patch Sentinel comments in

commit 2bcdcb36d3611e9bec76dcf86ba6ae7895f0c429
Author: Mike Levin <miklevin@gmail.com>
Date:   Thu Oct 9 17:45:42 2025 -0400

    Creating a pip.scrape() wrapper

[mike@nixos:~/repos/pipulate]$
```

Now we make sure we're really at the pristine HEAD of the repo:

```bash
[mike@nixos:~/repos/pipulate]$ git reset --hard HEAD
HEAD is now at fd2cf24e Composing prompt fu

[mike@nixos:~/repos/pipulate]$ git status
On branch main
Your branch and 'origin/main' have diverged,
and have 2 and 2 different commits each, respectively.
  (use "git pull" if you want to integrate the remote branch with yours)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	browser_cache/looking_at-1/
	browser_cache/looking_at-10/
	browser_cache/looking_at-2/
	browser_cache/looking_at-3/
	browser_cache/looking_at-4/
	browser_cache/looking_at-5/
	browser_cache/looking_at-6/
	browser_cache/looking_at-7/
	browser_cache/looking_at-8/
	browser_cache/looking_at-9/
	browser_cache/temp_scripts/

nothing added to commit but untracked files present (use "git add" to track)

[mike@nixos:~/repos/pipulate]$
```

We don't let ourselves get bothered by the unfiltered noise nor do we fix it
because anything we do right now is going to be undone. Now we can show the
difference between the *current state* of the repo and the *git commit
immediately prior* to the one we're on with this command:

```diff
[mike@nixos:~/repos/pipulate]$ git --no-pager show
commit fd2cf24eb06e0b0dfc2c1b6fb78467d3798e5d32 (HEAD -> main)
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 10:06:38 2025 -0400

    Composing prompt fu

diff --git a/foo_files.py b/foo_files.py
index a37456d5..937a4fd4 100644
--- a/foo_files.py
+++ b/foo_files.py
@@ -1,8 +1,11 @@
 FILES_TO_INCLUDE_RAW = """\
-/home/mike/repos/pipulate/prompt_foo.py
-/home/mike/repos/pipulate/foo_files.py
 /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/secretsauce.py
 /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/workflow_test.ipynb
+/home/mike/repos/pipulate/tools/advanced_automation_tools.py
+/home/mike/repos/pipulate/pipulate/__init__.py
+/home/mike/repos/pipulate/pipulate/core.py
+/home/mike/repos/pipulate/pipulate/pipulate.py
+/home/mike/repos/pipulate/ai_edit.py
 """
 
 # RELEASE SYSTEM
diff --git a/pipulate/core.py b/pipulate/core.py
index f8fccf51..25e47da7 100644
--- a/pipulate/core.py
+++ b/pipulate/core.py
@@ -1877,33 +1877,40 @@ class Pipulate:
     async def scrape(self, url: str, take_screenshot: bool = False, **kwargs):
         """
         Gives AI "eyes" by performing advanced browser automation to scrape a URL.
+        """
+        import traceback
+        from urllib.parse import urlparse
+        from datetime import datetime
     
-        This method acts as a simplified bridge to the powerful browser automation
-        tools, allowing for direct, on-demand scraping from notebooks or other clients.
-    
-        Args:
-            url (str): The URL to scrape.
-            take_screenshot (bool): Whether to capture a screenshot of the page.
-            **kwargs: Additional parameters to pass to the underlying automation tool.
+        logger.info(f"👁️‍🗨️ Initiating advanced scrape for: {url}")
     
-        Returns:
-            dict: The result from the browser automation tool, typically including
-                  paths to captured artifacts like DOM, source, and screenshot.
-        """
         try:
             from tools.advanced_automation_tools import browser_scrape_page
-            logger.info(f"👁️‍🗨️ Initiating advanced scrape for: {url}")
+            logger.debug("Scrape Step 1: Building parameters.")
             params = {
                 "url": url,
                 "take_screenshot": take_screenshot,
                 **kwargs
             }
+            logger.debug(f"Scrape Step 1 Complete. Params: {params}")
+    
+            logger.debug("Scrape Step 2: Calling browser_scrape_page.")
             result = await browser_scrape_page(params)
+            logger.debug(f"Scrape Step 2 Complete. Result received: {type(result)}")
+    
             return result
-        except ImportError:
-            logger.error("❌ Could not import browser_scrape_page. Ensure it exists in advanced_automation_tools.py.")
-            return {"success": False, "error": "Browser automation tool not found."}
+    
+        except TypeError as te:
+            # THIS IS THE NEW DIAGNOSTIC BLOCK
+            logger.error(f"❌ Advanced scrape failed with a TypeError for {url}: {te}")
+            logger.error("--- FULL TRACEBACK ---")
+            logger.error(traceback.format_exc())
+            logger.error("--- END TRACEBACK ---")
+            return {"success": False, "error": f"TypeError: {te}"}
         except Exception as e:
-            logger.error(f"❌ Advanced scrape failed for {url}: {e}")
+            logger.error(f"❌ Advanced scrape failed with an unexpected error for {url}: {e}")
+            logger.error("--- FULL TRACEBACK ---")
+            logger.error(traceback.format_exc())
+            logger.error("--- END TRACEBACK ---")
             return {"success": False, "error": str(e)}
     # END: notebook_api_methods

[mike@nixos:~/repos/pipulate]$ 
```

Each time we do this:

    clear && git reset --hard HEAD^ && git --no-pager show

...it will clear the screen, go back in time and show the diff which I can
copy/paste here for examination. When I get back to the hash
405f3df0d0e9e5bff31ebcc6926482744a3ae2c0 I will know I have my original
breakthrough, the one where we hijacked the hijacker, ahaha! I have a session
hijacking tech which the AI chose as the model it wanted to adopt when

## The Archeological Dig: Unpacking `advanced_automation_tools.py`
implementing it anew under the `pip.scrape()` wrapper. I mean who wouldn't with
a name like *session hijacking?* Now I have a bunch of different browser
automation and scraping approaches throughout Pipulate but this was the most
appealing to the AI and it did produce an immediate breakthrough. And as we
execute that command, we will see time roll back before our eyes. Because it had
been `git push`'d off-site (GitHub) there's always a big undo by just doing a
git pull... up until the moment we do a `git push --force` to erase the future.
Alright Denton Morris, it's time to watch time in reverse. Grab that lever and
pull.

```diff
{% raw %}HEAD is now at e217e64e About to apply patch with full traceback ability
commit e217e64e1b1cefdd6a9af72380c588f89b374dc8 (HEAD -> main)
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 09:59:11 2025 -0400

    About to apply patch with full traceback ability

diff --git a/patch.py b/patch.py
index 4d9f49a1..b112784b 100644
--- a/patch.py
+++ b/patch.py
@@ -1,136 +1,8 @@
 # patch.py
-# This patch forges the new `browser_scrape_page` tool and refactors the 
-# Pipulate.scrape method to use it, completing the "eyes" feature.
+# This is a DIAGNOSTIC patch to add detailed logging and a full traceback
+# to the Pipulate.scrape() method, pinpointing the source of the TypeError.
 
 patches = [
-    {
-        "file": "tools/advanced_automation_tools.py",
-        "block_name": "browser_scrape_page",
-        "new_code": """
-async def browser_scrape_page(params: dict) -> dict:
-    \"\"\"
-    MCP Tool: AI EYES - Scrape a web page and save to /browser_cache/looking_at/ for AI perception.
-    This is the AI's primary sensory interface - captures current browser state.
-    Args:
-        params (dict): {
-            "url": "https://example.com",             # Required
-            "take_screenshot": True,                  # Optional
-            "wait_seconds": 3                         # Optional
-        }
-    Returns:
-        dict: Success status and paths to captured artifacts.
-    \"\"\"
-    import json
-    import os
-    import asyncio
-    import subprocess
-    import tempfile
-    from datetime import datetime
-    from pathlib import Path
-    import sys
-
-    url = params.get('url')
-    if not url: return {"success": False, "error": "URL parameter is required"}
-
-    logger.info(f"👁️‍🗨️ FINDER_TOKEN: BROWSER_SCRAPE_START - URL: {url}")
-    
-    take_screenshot = params.get('take_screenshot', True)
-    wait_seconds = params.get('wait_seconds', 3)
-    
-    rotation_success = rotate_looking_at_directory(
-        looking_at_path=Path('browser_cache/looking_at'),
-        max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
-    )
-    looking_at_dir = 'browser_cache/looking_at'
-    os.makedirs(looking_at_dir, exist_ok=True)
-
-    from config import get_browser_script_imports
-    scrape_script = f'''
-{get_browser_script_imports()}
-
-def run_browser_scrape():
-    try:
-        from selenium import webdriver
-        from selenium.webdriver.chrome.options import Options
-        from seleniumwire import webdriver as wire_webdriver
-        
-        target_url = "{url}"
-        print(f"👁️ SUBPROCESS: Starting scrape for {{target_url}}")
-        
-        import tempfile
-        from config import get_chrome_options
-        chrome_options = get_chrome_options()
-        
-        profile_dir = tempfile.mkdtemp(prefix='pipulate_scrape_')
-        chrome_options.add_argument(f'--user-data-dir={{profile_dir}}')
-        driver = wire_webdriver.Chrome(options=chrome_options)
-        
-        try:
-            print(f"🌐 SUBPROCESS: Navigating to {{target_url}}")
-            driver.get(target_url)
-            time.sleep({wait_seconds})
-            print(f"✅ SUBPROCESS: Navigation and wait complete.")
-            
-            print(f"📸 SUBPROCESS: Capturing page state...")
-            page_title = driver.title
-            current_url = driver.current_url
-            
-            with open("{looking_at_dir}/source.html", "w", encoding="utf-8") as f: f.write(driver.page_source)
-            dom_content = driver.execute_script("return document.documentElement.outerHTML;")
-            with open("{looking_at_dir}/dom.html", "w", encoding="utf-8") as f: f.write(dom_content)
-            
-            screenshot_saved = False
-            if {take_screenshot}:
-                driver.save_screenshot("{looking_at_dir}/screenshot.png")
-                screenshot_saved = True
-            
-            headers_data = {{"url": current_url, "title": page_title, "timestamp": datetime.now().isoformat(), "scrape_type": "direct_scrape", "screenshot_taken": screenshot_saved, "status": "success"}}
-            with open("{looking_at_dir}/headers.json", "w") as f: json.dump(headers_data, f, indent=2)
-            
-            print(f"🎉 SUBPROCESS: Scrape completed successfully!")
-            return {{"success": True, "url": current_url, "title": page_title, "screenshot_saved": screenshot_saved}}
-            
-        finally:
-            driver.quit()
-            import shutil
-            try: shutil.rmtree(profile_dir)
-            except: pass
-    except Exception as e:
-        return {{"success": False, "error": str(e)}}
-
-if __name__ == "__main__":
-    result = run_browser_scrape()
-    print(f"SUBPROCESS_RESULT:{{json.dumps(result)}}")
-'''
-    with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as script_file:
-        script_file.write(scrape_script)
-        script_path = script_file.name
-
-    try:
-        process = await asyncio.create_subprocess_exec(
-            sys.executable, script_path,
-            stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE, cwd=os.getcwd()
-        )
-        stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=120.0)
-        
-        if process.returncode != 0:
-            return {{"success": False, "error": f"Scrape subprocess failed: {stderr.decode('utf-8')}"}}
-            
-        result_line = next((line.replace('SUBPROCESS_RESULT:', '') for line in stdout.decode('utf-8').split('\\n') if line.startswith('SUBPROCESS_RESULT:')), None)
-        
-        if result_line:
-            subprocess_result = json.loads(result_line)
-            if subprocess_result.get('success'):
-                return {{"success": True, "url": subprocess_result.get('url'), "title": subprocess_result.get('title'), "looking_at_files": {{"headers": f"{looking_at_dir}/headers.json", "source": f"{looking_at_dir}/source.html", "dom": f"{looking_at_dir}/dom.html", "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None}}}}
-            else:
-                return {{"success": False, "error": subprocess_result.get('error', 'Unknown subprocess error')}}
-        else:
-            return {{"success": False, "error": "No result from subprocess"}}
-    finally:
-        try: os.unlink(script_path)
-        except: pass
-"""
-    },
     {
         "file": "pipulate/core.py",
         "block_name": "notebook_api_methods",
@@ -175,35 +47,42 @@ if __name__ == "__main__":
     async def scrape(self, url: str, take_screenshot: bool = False, **kwargs):
         \"\"\"
         Gives AI "eyes" by performing advanced browser automation to scrape a URL.
+        \"\"\"
+        import traceback
+        from urllib.parse import urlparse
+        from datetime import datetime
 
-        This method acts as a simplified bridge to the powerful browser automation
-        tools, allowing for direct, on-demand scraping from notebooks or other clients.
-
-        Args:
-            url (str): The URL to scrape.
-            take_screenshot (bool): Whether to capture a screenshot of the page.
-            **kwargs: Additional parameters to pass to the underlying automation tool.
+        logger.info(f"👁️‍🗨️ Initiating advanced scrape for: {url}")
 
-        Returns:
-            dict: The result from the browser automation tool, typically including
-                  paths to captured artifacts like DOM, source, and screenshot.
-        \"\"\"
         try:
             from tools.advanced_automation_tools import browser_scrape_page
-            logger.info(f"👁️‍🗨️ Initiating advanced scrape for: {url}")
+            logger.debug("Scrape Step 1: Building parameters.")
             params = {
                 "url": url,
                 "take_screenshot": take_screenshot,
                 **kwargs
             }
+            logger.debug(f"Scrape Step 1 Complete. Params: {params}")
+
+            logger.debug("Scrape Step 2: Calling browser_scrape_page.")
             result = await browser_scrape_page(params)
+            logger.debug(f"Scrape Step 2 Complete. Result received: {type(result)}")
+            
             return result
-        except ImportError:
-            logger.error("❌ Could not import browser_scrape_page. Ensure it exists in advanced_automation_tools.py.")
-            return {"success": False, "error": "Browser automation tool not found."}
+
+        except TypeError as te:
+            # THIS IS THE NEW DIAGNOSTIC BLOCK
+            logger.error(f"❌ Advanced scrape failed with a TypeError for {url}: {te}")
+            logger.error("--- FULL TRACEBACK ---")
+            logger.error(traceback.format_exc())
+            logger.error("--- END TRACEBACK ---")
+            return {"success": False, "error": f"TypeError: {te}"}
         except Exception as e:
-            logger.error(f"❌ Advanced scrape failed for {url}: {e}")
+            logger.error(f"❌ Advanced scrape failed with an unexpected error for {url}: {e}")
+            logger.error("--- FULL TRACEBACK ---")
+            logger.error(traceback.format_exc())
+            logger.error("--- END TRACEBACK ---")
             return {"success": False, "error": str(e)}
 """
     }
-]
\ No newline at end of file
+]

[mike@nixos:~/repos/pipulate]$
```

Okay, PULL!

```diff
HEAD is now at 8f6b60a7 About to apply patch
commit 8f6b60a70d1821784f9064a28bcdc680972b0a06 (HEAD -> main)
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 07:57:54 2025 -0400

    About to apply patch

diff --git a/foo_files.py b/foo_files.py
index 35b36478..a37456d5 100644
--- a/foo_files.py
+++ b/foo_files.py
@@ -1,12 +1,8 @@
 FILES_TO_INCLUDE_RAW = """\
-/home/mike/repos/pipulate/ai_edit.py
-/home/mike/repos/pipulate/tools/advanced_automation_tools.py
+/home/mike/repos/pipulate/prompt_foo.py
+/home/mike/repos/pipulate/foo_files.py
 /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/secretsauce.py
-/home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/workflow.ipynb
 /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/workflow_test.ipynb
-/home/mike/repos/pipulate/pipulate/__init__.py
-/home/mike/repos/pipulate/pipulate/core.py
-/home/mike/repos/pipulate/pipulate/pipulate.py
 """
 
 # RELEASE SYSTEM
@@ -217,3 +213,13 @@ FILES_TO_INCLUDE_RAW = """\
 # /home/mike/repos/pipulate/tools/mcp_tools.py
 # /home/mike/repos/pipulate/tools/botify_tools.py
 
+# FAQUILIZER
+# /home/mike/repos/pipulate/ai_edit.py
+# /home/mike/repos/pipulate/tools/advanced_automation_tools.py
+# /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/secretsauce.py
+# /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/workflow_test.ipynb
+# /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/workflow.ipynb
+# /home/mike/repos/pipulate/pipulate/__init__.py
+# /home/mike/repos/pipulate/pipulate/core.py
+# /home/mike/repos/pipulate/pipulate/pipulate.py
+
diff --git a/patch.py b/patch.py
index e47001fd..4d9f49a1 100644
--- a/patch.py
+++ b/patch.py
@@ -6,7 +6,7 @@ patches = [
     {
         "file": "tools/advanced_automation_tools.py",
         "block_name": "browser_scrape_page",
-        "new_code": r"""
+        "new_code": """
 async def browser_scrape_page(params: dict) -> dict:
     \"\"\"
     MCP Tool: AI EYES - Scrape a web page and save to /browser_cache/looking_at/ for AI perception.
@@ -114,18 +114,18 @@ if __name__ == "__main__":
         stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=120.0)
         
         if process.returncode != 0:
-            return {"success": False, "error": f"Scrape subprocess failed: {stderr.decode('utf-8')}"}
+            return {{"success": False, "error": f"Scrape subprocess failed: {stderr.decode('utf-8')}"}}
             
         result_line = next((line.replace('SUBPROCESS_RESULT:', '') for line in stdout.decode('utf-8').split('\\n') if line.startswith('SUBPROCESS_RESULT:')), None)
         
         if result_line:
             subprocess_result = json.loads(result_line)
             if subprocess_result.get('success'):
-                return {"success": True, "url": subprocess_result.get('url'), "title": subprocess_result.get('title'), "looking_at_files": {"headers": f"{looking_at_dir}/headers.json", "source": f"{looking_at_dir}/source.html", "dom": f"{looking_at_dir}/dom.html", "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None}}
+                return {{"success": True, "url": subprocess_result.get('url'), "title": subprocess_result.get('title'), "looking_at_files": {{"headers": f"{looking_at_dir}/headers.json", "source": f"{looking_at_dir}/source.html", "dom": f"{looking_at_dir}/dom.html", "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None}}}}
             else:
-                return {"success": False, "error": subprocess_result.get('error', 'Unknown subprocess error')}
+                return {{"success": False, "error": subprocess_result.get('error', 'Unknown subprocess error')}}
         else:
-            return {"success": False, "error": "No result from subprocess"}
+            return {{"success": False, "error": "No result from subprocess"}}
     finally:
         try: os.unlink(script_path)
         except: pass
@@ -134,7 +134,7 @@ if __name__ == "__main__":
     {
         "file": "pipulate/core.py",
         "block_name": "notebook_api_methods",
-        "new_code": r"""
+        "new_code": """
     def read(self, job: str) -> dict:
         \"\"\"Reads the entire state dictionary for a given job (pipeline_id).\"\"\"
         state = self.read_state(job)
diff --git a/pipulate/core.py b/pipulate/core.py
index 1f26d2c2..f8fccf51 100644
--- a/pipulate/core.py
+++ b/pipulate/core.py
@@ -1890,31 +1890,19 @@ class Pipulate:
             dict: The result from the browser automation tool, typically including
                   paths to captured artifacts like DOM, source, and screenshot.
         """
-        from tools.advanced_automation_tools import browser_hijack_workflow_complete
-        from urllib.parse import urlparse
-        from datetime import datetime
-    
-        logger.info(f"👁️‍🗨️ Initiating advanced scrape for: {url}")
-    
-        # Create a transient, descriptive pipeline_id for this one-off scrape.
-        # This allows us to use the workflow hijacking tool for a simple scrape.
-        domain = urlparse(url).netloc
-        timestamp = datetime.now().strftime('%H%M%S')
-        scrape_pipeline_id = f"scrape-{domain.replace('.', '-')}-{timestamp}"
-    
-        params = {
-            "url": url,
-            "pipeline_id": scrape_pipeline_id,
-            "take_screenshot": take_screenshot,
-            **kwargs  # Pass through any other params
-        }
-    
         try:
-            # We call the 'workflow_hijack' tool, but in this context, it's just
-            # navigating and capturing artifacts. We bypass the form-filling parts
-            # by providing a unique, non-existent pipeline_id.
-            result = await browser_hijack_workflow_complete(params)
+            from tools.advanced_automation_tools import browser_scrape_page
+            logger.info(f"👁️‍🗨️ Initiating advanced scrape for: {url}")
+            params = {
+                "url": url,
+                "take_screenshot": take_screenshot,
+                **kwargs
+            }
+            result = await browser_scrape_page(params)
             return result
+        except ImportError:
+            logger.error("❌ Could not import browser_scrape_page. Ensure it exists in advanced_automation_tools.py.")
+            return {"success": False, "error": "Browser automation tool not found."}
         except Exception as e:
             logger.error(f"❌ Advanced scrape failed for {url}: {e}")
             return {"success": False, "error": str(e)}
diff --git a/tools/advanced_automation_tools.py b/tools/advanced_automation_tools.py
index 98c725ba..e3764fb4 100644
--- a/tools/advanced_automation_tools.py
+++ b/tools/advanced_automation_tools.py
@@ -671,6 +671,131 @@ if __name__ == "__main__":
         return {"success": False, "error": f"Workflow hijacking failed: {str(e)}"}
 # END: browser_hijack_workflow_complete
 
+# START: browser_scrape_page
+async def browser_scrape_page(params: dict) -> dict:
+    """
+    MCP Tool: AI EYES - Scrape a web page and save to /browser_cache/looking_at/ for AI perception.
+    This is the AI's primary sensory interface - captures current browser state.
+    Args:
+        params (dict): {
+            "url": "https://example.com",             # Required
+            "take_screenshot": True,                  # Optional
+            "wait_seconds": 3                         # Optional
+        }
+    Returns:
+        dict: Success status and paths to captured artifacts.
+    """
+    import json
+    import os
+    import asyncio
+    import subprocess
+    import tempfile
+    from datetime import datetime
+    from pathlib import Path
+    import sys
+
+    url = params.get('url')
+    if not url: return {"success": False, "error": "URL parameter is required"}
+
+    logger.info(f"👁️‍🗨️ FINDER_TOKEN: BROWSER_SCRAPE_START - URL: {url}")
+
+    take_screenshot = params.get('take_screenshot', True)
+    wait_seconds = params.get('wait_seconds', 3)
+
+    rotation_success = rotate_looking_at_directory(
+        looking_at_path=Path('browser_cache/looking_at'),
+        max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
+    )
+    looking_at_dir = 'browser_cache/looking_at'
+    os.makedirs(looking_at_dir, exist_ok=True)
+
+    from config import get_browser_script_imports
+    scrape_script = f'''
+{get_browser_script_imports()}
+
+def run_browser_scrape():
+    try:
+        from selenium import webdriver
+        from selenium.webdriver.chrome.options import Options
+        from seleniumwire import webdriver as wire_webdriver
+
+        target_url = "{url}"
+        print(f"👁️ SUBPROCESS: Starting scrape for {{target_url}}")
+
+        import tempfile
+        from config import get_chrome_options
+        chrome_options = get_chrome_options()
+
+        profile_dir = tempfile.mkdtemp(prefix='pipulate_scrape_')
+        chrome_options.add_argument(f'--user-data-dir={{profile_dir}}')
+        driver = wire_webdriver.Chrome(options=chrome_options)
+
+        try:
+            print(f"🌐 SUBPROCESS: Navigating to {{target_url}}")
+            driver.get(target_url)
+            time.sleep({wait_seconds})
+            print(f"✅ SUBPROCESS: Navigation and wait complete.")
+
+            print(f"📸 SUBPROCESS: Capturing page state...")
+            page_title = driver.title
+            current_url = driver.current_url
+
+            with open("{looking_at_dir}/source.html", "w", encoding="utf-8") as f: f.write(driver.page_source)
+            dom_content = driver.execute_script("return document.documentElement.outerHTML;")
+            with open("{looking_at_dir}/dom.html", "w", encoding="utf-8") as f: f.write(dom_content)
+
+            screenshot_saved = False
+            if {take_screenshot}:
+                driver.save_screenshot("{looking_at_dir}/screenshot.png")
+                screenshot_saved = True
+
+            headers_data = {{"url": current_url, "title": page_title, "timestamp": datetime.now().isoformat(), "scrape_type": "direct_scrape", "screenshot_taken": screenshot_saved, "status": "success"}}
+            with open("{looking_at_dir}/headers.json", "w") as f: json.dump(headers_data, f, indent=2)
+
+            print(f"🎉 SUBPROCESS: Scrape completed successfully!")
+            return {{"success": True, "url": current_url, "title": page_title, "screenshot_saved": screenshot_saved}}
+
+        finally:
+            driver.quit()
+            import shutil
+            try: shutil.rmtree(profile_dir)
+            except: pass
+    except Exception as e:
+        return {{"success": False, "error": str(e)}}
+
+if __name__ == "__main__":
+    result = run_browser_scrape()
+    print(f"SUBPROCESS_RESULT:{{json.dumps(result)}}")
+'''
+    with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as script_file:
+        script_file.write(scrape_script)
+        script_path = script_file.name
+
+    try:
+        process = await asyncio.create_subprocess_exec(
+            sys.executable, script_path,
+            stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE, cwd=os.getcwd()
+        )
+        stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=120.0)
+
+        if process.returncode != 0:
+            return {{"success": False, "error": f"Scrape subprocess failed: {stderr.decode('utf-8')}"}}
+
+        result_line = next((line.replace('SUBPROCESS_RESULT:', '') for line in stdout.decode('utf-8').split('\n') if line.startswith('SUBPROCESS_RESULT:')), None)
+
+        if result_line:
+            subprocess_result = json.loads(result_line)
+            if subprocess_result.get('success'):
+                return {{"success": True, "url": subprocess_result.get('url'), "title": subprocess_result.get('title'), "looking_at_files": {{"headers": f"{looking_at_dir}/headers.json", "source": f"{looking_at_dir}/source.html", "dom": f"{looking_at_dir}/dom.html", "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None}}}}
+            else:
+                return {{"success": False, "error": subprocess_result.get('error', 'Unknown subprocess error')}}
+        else:
+            return {{"success": False, "error": "No result from subprocess"}}
+    finally:
+        try: os.unlink(script_path)
+        except: pass
+# END: browser_scrape_page
+
 async def _execute_json_recipe(recipe_data: dict, execution_params: dict) -> dict:
     """🎯 BOURBON VANILLA JSON Recipe Execution Engine     

[mike@nixos:~/repos/pipulate]$
```

PULL!

```diff
HEAD is now at 33a041be About to add new eyes function
commit 33a041be79f5bbfa16f1131fe3d9887715345299 (HEAD -> main)
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 05:29:24 2025 -0400

    About to add new eyes function

diff --git a/README.md b/README.md
index e64d0b39..c5b8dc45 100644
--- a/README.md
+++ b/README.md
@@ -1106,7 +1106,7 @@ This structure enables AI assistants to programmatically interact with all UI co
     .
     ├── .venv/                     # Common Python environment for FastHTML, Jupyter & Cursor
     ├── apps/                      # Workflow plugins (010_introduction.py, 400_trifecta.py, etc.)
-    ├── browser_automation/        # Selenium browser control & DOM capture
+    ├── browser_cache/        # Selenium browser control & DOM capture
     │   ├── looking_at/            # Current browser DOM state for AI visibility
     │   └── *.py                   # Google search automation examples
     ├── cli.py                     # Command line interface for Pipulate operations
@@ -1415,7 +1415,7 @@ apps/                    # Your workflows (auto-discovered)
 
 mcp_tools.py               # AI assistant interface  
 crud.py                  # Base classes for workflows
-browser_automation/        # Selenium automation tools
+browser_cache/        # Selenium automation tools
 logs/server.log            # Debug everything here
 data/data.db              # SQLite application state
 \`\`\`
diff --git a/assets/pipulate-init.js b/assets/pipulate-init.js
index 19e5dced..56334c8a 100644
--- a/assets/pipulate-init.js
+++ b/assets/pipulate-init.js
@@ -1910,7 +1910,7 @@ async function executeCleanMcpToolCallStep(step) {
 - cli.py (Command line interface)
 - apps/ (41 plugin files)
 - /assets/ (Web assets)
-- browser_automation/ (Automation scripts)
+- browser_cache/ (Automation scripts)
 
 **Safe read-only operation completed!** 📖`;
     } else if (step.tool_name === 'ui_flash_element') {
diff --git a/browser_automation/automation_recipes/README_SAVE_LOAD_AUTOMATION.md b/browser_cache/automation_recipes/README_SAVE_LOAD_AUTOMATION.md
similarity index 100%
rename from browser_automation/automation_recipes/README_SAVE_LOAD_AUTOMATION.md
rename to browser_cache/automation_recipes/README_SAVE_LOAD_AUTOMATION.md
diff --git a/browser_automation/automation_recipes/http_localhost_5001/load_all_data_recipe.json b/browser_cache/automation_recipes/http_localhost_5001/load_all_data_recipe.json
similarity index 100%
rename from browser_automation/automation_recipes/http_localhost_5001/load_all_data_recipe.json
rename to browser_cache/automation_recipes/http_localhost_5001/load_all_data_recipe.json
diff --git a/browser_automation/automation_recipes/http_localhost_5001/profile_creation_recipe.json b/browser_cache/automation_recipes/http_localhost_5001/profile_creation_recipe.json
similarity index 100%
rename from browser_automation/automation_recipes/http_localhost_5001/profile_creation_recipe.json
rename to browser_cache/automation_recipes/http_localhost_5001/profile_creation_recipe.json
diff --git a/browser_automation/automation_recipes/http_localhost_5001/save_all_data_recipe.json b/browser_cache/automation_recipes/http_localhost_5001/save_all_data_recipe.json
similarity index 100%
rename from browser_automation/automation_recipes/http_localhost_5001/save_all_data_recipe.json
rename to browser_cache/automation_recipes/http_localhost_5001/save_all_data_recipe.json
diff --git a/browser_automation/dom_processing/dom_box_visualizer.py b/browser_cache/dom_processing/dom_box_visualizer.py
similarity index 98%
rename from browser_automation/dom_processing/dom_box_visualizer.py
rename to browser_cache/dom_processing/dom_box_visualizer.py
index cb1c7ff1..9344a596 100644
--- a/browser_automation/dom_processing/dom_box_visualizer.py
+++ b/browser_cache/dom_processing/dom_box_visualizer.py
@@ -335,7 +335,7 @@ def main():
     visualizer = DOMBoxVisualizer()
     
     # Default to the current looking_at directory
-    looking_at_dir = Path("browser_automation/looking_at")
+    looking_at_dir = Path("browser_cache/looking_at")
     simple_dom_file = looking_at_dir / "simple_dom.html"
     
     if len(sys.argv) > 1:
@@ -348,10 +348,10 @@ def main():
             sys.exit(1)
     elif simple_dom_file.exists():
         # Use the latest scraped DOM
-        visualizer.console.print("🔍 Using latest scraped DOM from browser_automation/looking_at/", style="dim")
+        visualizer.console.print("🔍 Using latest scraped DOM from browser_cache/looking_at/", style="dim")
         visualizer.visualize_dom_file(simple_dom_file)
     else:
-        print("❌ No DOM file found. Please provide a file path or ensure browser_automation/looking_at/simple_dom.html exists.")
+        print("❌ No DOM file found. Please provide a file path or ensure browser_cache/looking_at/simple_dom.html exists.")
         print("Usage: python dom_box_visualizer.py [path_to_html_file]")
         sys.exit(1)
     
diff --git a/browser_automation/dom_processing/dom_hierarchy_visualizer.py b/browser_cache/dom_processing/dom_hierarchy_visualizer.py
similarity index 97%
rename from browser_automation/dom_processing/dom_hierarchy_visualizer.py
rename to browser_cache/dom_processing/dom_hierarchy_visualizer.py
index 82a307bb..d49d31d4 100644
--- a/browser_automation/dom_processing/dom_hierarchy_visualizer.py
+++ b/browser_cache/dom_processing/dom_hierarchy_visualizer.py
@@ -204,7 +204,7 @@ def main():
     visualizer = DOMHierarchyVisualizer()
     
     # Default to the current looking_at directory
-    looking_at_dir = Path("browser_automation/looking_at")
+    looking_at_dir = Path("browser_cache/looking_at")
     simple_dom_file = looking_at_dir / "simple_dom.html"
     
     if len(sys.argv) > 1:
@@ -217,10 +217,10 @@ def main():
             sys.exit(1)
     elif simple_dom_file.exists():
         # Use the latest scraped DOM
-        visualizer.console.print("🔍 Using latest scraped DOM from browser_automation/looking_at/", style="dim")
+        visualizer.console.print("🔍 Using latest scraped DOM from browser_cache/looking_at/", style="dim")
         visualizer.visualize_dom_file(simple_dom_file)
     else:
-        print("❌ No DOM file found. Please provide a file path or ensure browser_automation/looking_at/simple_dom.html exists.")
+        print("❌ No DOM file found. Please provide a file path or ensure browser_cache/looking_at/simple_dom.html exists.")
         print("Usage: python dom_hierarchy_visualizer.py [path_to_html_file]")
         sys.exit(1)
     
diff --git a/browser_automation/dom_schema_visualizer.py b/browser_cache/dom_schema_visualizer.py
similarity index 98%
rename from browser_automation/dom_schema_visualizer.py
rename to browser_cache/dom_schema_visualizer.py
index 59d01fe6..17d13b5a 100644
--- a/browser_automation/dom_schema_visualizer.py
+++ b/browser_cache/dom_schema_visualizer.py
@@ -442,7 +442,7 @@ def main():
     visualizer = DOMSchemaVisualizer()
     
     # Default to looking_at directory
-    looking_at_dir = Path("browser_automation/looking_at")
+    looking_at_dir = Path("browser_cache/looking_at")
     simple_dom_file = looking_at_dir / "simple_dom.html"
     
     if len(sys.argv) > 1:
@@ -455,13 +455,13 @@ def main():
             sys.exit(1)
     elif simple_dom_file.exists():
         # Use the latest scraped DOM
-        visualizer.console.print("🔍 Using latest scraped DOM from browser_automation/looking_at/", style="dim")
+        visualizer.console.print("🔍 Using latest scraped DOM from browser_cache/looking_at/", style="dim")
         visualizer.console.print()
         visualizer.visualize_dom_file(simple_dom_file)
     else:
         print("❌ No DOM file found.")
         print("Usage: python dom_schema_visualizer.py [path_to_html_file]")
-        print("Default: Uses browser_automation/looking_at/simple_dom.html")
+        print("Default: Uses browser_cache/looking_at/simple_dom.html")
         sys.exit(1)
 
 if __name__ == "__main__":
diff --git a/browser_automation/google_search_automation_demo.py b/browser_cache/google_search_automation_demo.py
similarity index 98%
rename from browser_automation/google_search_automation_demo.py
rename to browser_cache/google_search_automation_demo.py
index 15ebdf5a..4141a167 100644
--- a/browser_automation/google_search_automation_demo.py
+++ b/browser_cache/google_search_automation_demo.py
@@ -38,7 +38,7 @@ class GoogleSearchAutomationDemo:
     
     def __init__(self):
         self.processor = EnhancedDOMProcessor()
-        self.looking_at_dir = "browser_automation/looking_at"
+        self.looking_at_dir = "browser_cache/looking_at"
         self.search_results = []
         self.redirect_chain = []
         
@@ -279,7 +279,7 @@ async def main():
     results = await demo.run_complete_demo("AI automation tools")
     
     # Save results
-    results_file = "browser_automation/looking_at/demo_results.json"
+    results_file = "browser_cache/looking_at/demo_results.json"
     with open(results_file, 'w') as f:
         # Convert any non-serializable objects to strings
         serializable_results = json.loads(json.dumps(results, default=str))
diff --git a/browser_automation/google_search_example.py b/browser_cache/google_search_example.py
similarity index 100%
rename from browser_automation/google_search_example.py
rename to browser_cache/google_search_example.py
diff --git a/browser_automation/interactive_google_search.py b/browser_cache/interactive_google_search.py
similarity index 96%
rename from browser_automation/interactive_google_search.py
rename to browser_cache/interactive_google_search.py
index c1630f23..ca597a29 100644
--- a/browser_automation/interactive_google_search.py
+++ b/browser_cache/interactive_google_search.py
@@ -211,7 +211,7 @@ class InteractiveGoogleSearch:
         
         # Save current page source
         page_source = self.driver.page_source
-        with open("browser_automation/looking_at/search_results_source.html", "w", encoding="utf-8") as f:
+        with open("browser_cache/looking_at/search_results_source.html", "w", encoding="utf-8") as f:
             f.write(page_source)
         
         # Save extracted results as JSON
@@ -223,14 +223,14 @@ class InteractiveGoogleSearch:
             'results': results
         }
         
-        with open("browser_automation/looking_at/search_results.json", "w", encoding="utf-8") as f:
+        with open("browser_cache/looking_at/search_results.json", "w", encoding="utf-8") as f:
             json.dump(results_data, f, indent=2)
         
         # Take screenshot
-        screenshot_path = "browser_automation/looking_at/search_results_screenshot.png"
+        screenshot_path = "browser_cache/looking_at/search_results_screenshot.png"
         self.driver.save_screenshot(screenshot_path)
         
-        print(f"💾 Results saved to browser_automation/looking_at/")
+        print(f"💾 Results saved to browser_cache/looking_at/")
         print(f"   - search_results.json")
         print(f"   - search_results_source.html") 
         print(f"   - search_results_screenshot.png")
diff --git a/browser_automation/recipe_executor.py b/browser_cache/recipe_executor.py
similarity index 99%
rename from browser_automation/recipe_executor.py
rename to browser_cache/recipe_executor.py
index 9df55b96..92afdc66 100644
--- a/browser_automation/recipe_executor.py
+++ b/browser_cache/recipe_executor.py
@@ -349,7 +349,7 @@ async def test_baby_steps_executor():
     executor = RecipeExecutor(headless=False, debug=True)
     
     # Test with existing profile creation recipe
-    recipe_path = "browser_automation/automation_recipes/http_localhost_5001/profile_creation_recipe.json"
+    recipe_path = "browser_cache/automation_recipes/http_localhost_5001/profile_creation_recipe.json"
     
     logger.info("🎯 BABY_STEPS: Starting test execution")
     result = executor.execute_recipe_from_file(recipe_path)
diff --git a/browser_automation/review_perception_history.py b/browser_cache/review_perception_history.py
similarity index 99%
rename from browser_automation/review_perception_history.py
rename to browser_cache/review_perception_history.py
index 7b4b84f1..5022bdaf 100644
--- a/browser_automation/review_perception_history.py
+++ b/browser_cache/review_perception_history.py
@@ -34,7 +34,7 @@ from pathlib import Path
 def find_perception_directories(base_dir: Path = None):
     """Find all available perception directories"""
     if base_dir is None:
-        base_dir = Path('browser_automation')
+        base_dir = Path('browser_cache')
     
     directories = []
     
diff --git a/config.py b/config.py
index aaa0c2b1..85890a70 100644
--- a/config.py
+++ b/config.py
@@ -349,7 +349,7 @@ MCP_ENDPOINT = "/mcp-tool-executor"
 WORKSPACE_ROOT = "/home/mike/repos"
 PIPULATE_ROOT = "/home/mike/repos/pipulate"
 AI_DISCOVERY_DIR = "pipulate/ai_discovery"
-BROWSER_AUTOMATION_DIR = "pipulate/browser_automation"
+BROWSER_CACHE_DIR = "pipulate/browser_cache"
 LOGS_DIR = "pipulate/logs"
 DATA_DIR = "pipulate/data"
 
diff --git a/foo_files.py b/foo_files.py
index c62b6d60..35b36478 100644
--- a/foo_files.py
+++ b/foo_files.py
@@ -111,7 +111,7 @@ FILES_TO_INCLUDE_RAW = """\
 # /home/mike/repos/pipulate/apps/300_blank_placeholder.py
 # /home/mike/repos/pipulate/apps/400_botify_trifecta.py
 # /home/mike/repos/pipulate/apps/430_tab_opener.py
-# /home/mike/repos/pipulate/apps/440_browser_automation.py
+# /home/mike/repos/pipulate/apps/440_browser_cache.py
 # /home/mike/repos/pipulate/apps/450_stream_simulator.py
 # /home/mike/repos/pipulate/apps/510_text_field.py
 # /home/mike/repos/pipulate/apps/520_text_area.py
@@ -157,17 +157,17 @@ FILES_TO_INCLUDE_RAW = """\
 # FINDING EYES
 # tools/mcp_tools.py
 # imports/dom_processing/ai_dom_beautifier.py
-# browser_automation/dom_processing/dom_hierarchy_visualizer.py
-# browser_automation/dom_processing/dom_box_visualizer.py
+# browser_cache/dom_processing/dom_hierarchy_visualizer.py
+# browser_cache/dom_processing/dom_box_visualizer.py
 # /home/mike/repos/pipulate/README.md
 # /home/mike/repos/pipulate/server.py
 # /home/mike/repos/pipulate/config.py
 # /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/prompt.txt
 # /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/workflow.ipynb
 # /home/mike/repos/pipulate/Notebooks/Client_Work/faquilizer2/secretsauce.py
-# /home/mike/repos/pipulate/browser_automation/dom_schema_visualizer.py
-# /home/mike/repos/pipulate/browser_automation/recipe_executor.py
-# /home/mike/repos/pipulate/browser_automation/review_perception_history.py
+# /home/mike/repos/pipulate/browser_cache/dom_schema_visualizer.py
+# /home/mike/repos/pipulate/browser_cache/recipe_executor.py
+# /home/mike/repos/pipulate/browser_cache/review_perception_history.py
 # /home/mike/repos/pipulate/tools/advanced_automation_tools.py
 # /home/mike/repos/pipulate/AI_RUNME.py
 # /home/mike/repos/pipulate/cli.py
diff --git a/imports/ascii_displays.py b/imports/ascii_displays.py
index 1c015388..7212b57e 100644
--- a/imports/ascii_displays.py
+++ b/imports/ascii_displays.py
@@ -524,7 +524,7 @@ def startup_environment_warnings() -> str:
     )
     warnings_table.add_row(
         "🎯 Browser Evidence", 
-        "Check browser_automation/looking_at/ FIRST, system internals second"
+        "Check browser_cache/looking_at/ FIRST, system internals second"
     )
     
     # Create warning panel
@@ -712,7 +712,7 @@ def startup_environment_warnings() -> str:
     )
     warnings_table.add_row(
         "🎯 Browser Evidence", 
-        "Check browser_automation/looking_at/ FIRST, system internals second"
+        "Check browser_cache/looking_at/ FIRST, system internals second"
     )
     
     # Create warning panel
@@ -731,7 +731,7 @@ def startup_environment_warnings() -> str:
 • Python Path Issue: NEVER use 'python' - ALWAYS use '.venv/bin/python'
 • Golden Path: cd pipulate && .venv/bin/python cli.py call <tool_name> works everywhere
 • Working Directory: MCP tools require 'cd pipulate' first - never run from workspace root
-• Browser Evidence: Check browser_automation/looking_at/ FIRST, system internals second
+• Browser Evidence: Check browser_cache/looking_at/ FIRST, system internals second
 
 Essential knowledge for 100% success rate"""
     
diff --git a/imports/crud.py b/imports/crud.py
index f9d6b497..6b3d8dfe 100644
--- a/imports/crud.py
+++ b/imports/crud.py
@@ -680,7 +680,7 @@ class WorkflowUtilities:
     def url_to_safe_path(url: str) -> tuple[str, str]:
         """Convert URL to filesystem-safe path components.
         
-        Extracted from: apps/440_browser_automation.py  
+        Extracted from: apps/440_browser_cache.py  
         Pattern: URL PROCESSING - Safe filesystem path generation
         
         Args:
diff --git a/imports/dom_processing/ai_dom_beautifier.py b/imports/dom_processing/ai_dom_beautifier.py
index 9e97ec3d..09e0f7b1 100644
--- a/imports/dom_processing/ai_dom_beautifier.py
+++ b/imports/dom_processing/ai_dom_beautifier.py
@@ -436,7 +436,7 @@ def beautify_current_looking_at() -> Tuple[str, List[AutomationTarget]]:
     """Beautify the current /looking_at/ simple_dom.html file"""
     import os
     
-    simple_dom_path = "browser_automation/looking_at/simple_dom.html"
+    simple_dom_path = "browser_cache/looking_at/simple_dom.html"
     
     if not os.path.exists(simple_dom_path):
         raise FileNotFoundError(f"No current DOM state found at {simple_dom_path}")
@@ -448,19 +448,19 @@ def beautify_current_looking_at() -> Tuple[str, List[AutomationTarget]]:
     beautified_html, registry = beautifier.beautify_dom(html_content)
     
     # Save beautified version
-    with open("browser_automation/looking_at/beautiful_dom.html", 'w', encoding='utf-8') as f:
+    with open("browser_cache/looking_at/beautiful_dom.html", 'w', encoding='utf-8') as f:
         f.write(beautified_html)
     
     # Save automation registry
-    with open("browser_automation/looking_at/automation_registry.json", 'w', encoding='utf-8') as f:
+    with open("browser_cache/looking_at/automation_registry.json", 'w', encoding='utf-8') as f:
         f.write(beautifier.export_automation_registry('json'))
     
     # Save Python registry
-    with open("browser_automation/looking_at/automation_targets.py", 'w', encoding='utf-8') as f:
+    with open("browser_cache/looking_at/automation_targets.py", 'w', encoding='utf-8') as f:
         f.write(beautifier.export_automation_registry('python'))
     
     # Save summary
-    with open("browser_automation/looking_at/automation_summary.txt", 'w', encoding='utf-8') as f:
+    with open("browser_cache/looking_at/automation_summary.txt", 'w', encoding='utf-8') as f:
         f.write(beautifier.export_automation_registry('summary'))
     
     return beautified_html, registry
@@ -474,10 +474,10 @@ if __name__ == "__main__":
         print(f"📊 Found {len(registry)} automation targets")
         print(f"🎯 High priority targets: {len([t for t in registry if t.priority_score >= 70])}")
         print("\n📁 Generated files:")
-        print("  - browser_automation/looking_at/beautiful_dom.html")
-        print("  - browser_automation/looking_at/automation_registry.json") 
-        print("  - browser_automation/looking_at/automation_targets.py")
-        print("  - browser_automation/looking_at/automation_summary.txt")
+        print("  - browser_cache/looking_at/beautiful_dom.html")
+        print("  - browser_cache/looking_at/automation_registry.json") 
+        print("  - browser_cache/looking_at/automation_targets.py")
+        print("  - browser_cache/looking_at/automation_summary.txt")
     except FileNotFoundError as e:
         print(f"❌ {e}")
         print("💡 Run browser_scrape_page first to capture current page state")
\ No newline at end of file
diff --git a/imports/dom_processing/enhanced_dom_processor.py b/imports/dom_processing/enhanced_dom_processor.py
index ec6db380..e77cf3dd 100644
--- a/imports/dom_processing/enhanced_dom_processor.py
+++ b/imports/dom_processing/enhanced_dom_processor.py
@@ -286,7 +286,7 @@ class EnhancedDOMProcessor:
         
         return '/' + '/'.join(path_parts) if path_parts else "//unknown"
     
-    def process_looking_at_directory(self, looking_at_dir: str = "browser_automation/looking_at") -> Dict:
+    def process_looking_at_directory(self, looking_at_dir: str = "browser_cache/looking_at") -> Dict:
         """
         Process all files in /looking_at/ directory for 2nd-stage automation
         
diff --git a/patch.py b/patch.py
index 49b461b9..e47001fd 100644
--- a/patch.py
+++ b/patch.py
@@ -1,69 +1,24 @@
 # patch.py
-# This patch fixes hardcoded '.venv/bin/python' paths in advanced_automation_tools.py
-# by replacing them with the dynamic and robust `sys.executable`.
+# This patch forges the new `browser_scrape_page` tool and refactors the 
+# Pipulate.scrape method to use it, completing the "eyes" feature.
 
 patches = [
     {
         "file": "tools/advanced_automation_tools.py",
-        "block_name": "browser_hijack_workflow_complete",
-        "new_code": """
-async def browser_hijack_workflow_complete(params: dict) -> dict:
+        "block_name": "browser_scrape_page",
+        "new_code": r"""
+async def browser_scrape_page(params: dict) -> dict:
     \"\"\"
-    MCP Tool: COMPLETE WORKFLOW HIJACKING - Navigate + Enter + Chain Reaction + Capture
-    
-    🎭 "HI JACK" MAGIC WORDS PATTERN - The Irresistible Simple Way
-    ═══════════════════════════════════════════════════════════════════════════════════
-    SIMPLEST METHOD: Just type "Hi Jack" in chat → Complete hijacking happens automatically
-    
-    PROGRAMMATIC METHOD for AI understanding:
-    python -c "
-    import asyncio
-    from tools.mcp_tools import browser_hijack_workflow_complete
-    result = asyncio.run(browser_hijack_workflow_complete({
-        'url': 'http://localhost:5001/hello_workflow',
-        'pipeline_id': 'Default_Profile-hello-16'
-    }))
-    print(f'🎭 Hijack: {result.get(\\"success\\")}')"
-    
-    This is the common pattern for all session hijacking that handles:
-    1. Navigate to workflow URL (e.g., http://localhost:5001/hello_workflow)
-    2. Fill in pipeline key input field  
-    3. Press Enter to trigger HTMX chain reaction
-    4. Wait for chain reaction to complete (all hx_trigger="load" steps)
-    5. Capture final workflow state (DOM + screenshot)
-    
-    This captures the POST-ENTER workflow state, not just the landing page form.
-    
+    MCP Tool: AI EYES - Scrape a web page and save to /browser_cache/looking_at/ for AI perception.
+    This is the AI's primary sensory interface - captures current browser state.
     Args:
-        params: {
-            "url": "http://localhost:5001/hello_workflow",  # Required: Workflow URL
-            "pipeline_id": "Default_Profile-hello-16",      # Required: Pipeline key to enter
-            "take_screenshot": True                         # Optional: capture visual state
+        params (dict): {
+            "url": "https://example.com",             # Required
+            "take_screenshot": True,                  # Optional
+            "wait_seconds": 3                         # Optional
         }
-        
-        Timing: Uses centralized WorkflowHijackTiming configuration ({WorkflowHijackTiming.total_browser_time()}s total)
-        To adjust timing: Change WorkflowHijackTiming class values or apply_timing_preset("lightning"/"fast"/"dramatic")
-    
     Returns:
-        dict: {
-            "success": True,
-            "workflow_hijacked": True,
-            "chain_reaction_completed": True,
-            "url": "http://localhost:5001/hello_workflow",
-            "pipeline_id": "Default_Profile-hello-16",
-            "looking_at_files": {
-                "screenshot": "browser_automation/looking_at/screenshot.png",
-                "dom": "browser_automation/looking_at/dom.html",
-                "simple_dom": "browser_automation/looking_at/simple_dom.html"
-            },
-            "hijacking_steps": [
-                {"step": "navigation", "status": "success"},
-                {"step": "pipeline_key_entry", "status": "success"},
-                {"step": "form_submission", "status": "success"},
-                {"step": "chain_reaction_wait", "status": "success"},
-                {"step": "final_state_capture", "status": "success"}
-            ]
-        }
+        dict: Success status and paths to captured artifacts.
     \"\"\"
     import json
     import os
@@ -72,135 +27,51 @@ async def browser_hijack_workflow_complete(params: dict) -> dict:
     import tempfile
     from datetime import datetime
     from pathlib import Path
-    from urllib.parse import urlparse
-    import sys  # <-- ADDED IMPORT
+    import sys
 
-    logger.info(f"🎭 FINDER_TOKEN: MCP_WORKFLOW_HIJACK_START - URL: {params.get('url')}, Pipeline: {params.get('pipeline_id')}")
+    url = params.get('url')
+    if not url: return {"success": False, "error": "URL parameter is required"}
+
+    logger.info(f"👁️‍🗨️ FINDER_TOKEN: BROWSER_SCRAPE_START - URL: {url}")
     
-    try:
-        url = params.get('url')
-        pipeline_id = params.get('pipeline_id')
-        take_screenshot = params.get('take_screenshot', True)
-        
-        # Show current timing configuration
-        logger.info(f"⏰ FINDER_TOKEN: TIMING_CONFIG - {WorkflowHijackTiming.get_timing_summary()}")
-        
-        # === VALIDATION ===
-        if not url:
-            return {"success": False, "error": "URL parameter is required"}
-        if not pipeline_id:
-            return {"success": False, "error": "pipeline_id parameter is required"}
-        
-        # Validate URL format
-        if not url.startswith(('http://', 'https://')):
-            return {"success": False, "error": f"URL must start with http:// or https://. Got: {url}"}
-        
-        logger.info(f"✅ FINDER_TOKEN: WORKFLOW_HIJACK_VALIDATION_PASSED - URL: {url}, Pipeline: {pipeline_id}")
-        
-        # === DIRECTORY ROTATION ===
-        rotation_success = rotate_looking_at_directory(
-            looking_at_path=Path('browser_automation/looking_at'),
-            max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
-        )
-        
-        looking_at_dir = 'browser_automation/looking_at'
-        os.makedirs(looking_at_dir, exist_ok=True)
-        
-        hijacking_steps = []
-        
-        # === SUBPROCESS WORKFLOW HIJACKING TO AVOID THREADING ISSUES ===
-        timing = WorkflowHijackTiming
-        page_load_wait = timing.PAGE_LOAD_WAIT
-        form_delay = timing.FORM_INTERACTION_DELAY  
-        post_wait = timing.POST_REQUEST_WAIT
-        chain_wait = timing.CHAIN_REACTION_WAIT
-        stabilization = timing.FINAL_STABILIZATION
-        human_view = timing.HUMAN_OBSERVATION
-        total_time = timing.total_browser_time()
-        
-        from config import get_browser_script_imports
-        hijack_script = f'''
+    take_screenshot = params.get('take_screenshot', True)
+    wait_seconds = params.get('wait_seconds', 3)
+    
+    rotation_success = rotate_looking_at_directory(
+        looking_at_path=Path('browser_cache/looking_at'),
+        max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
+    )
+    looking_at_dir = 'browser_cache/looking_at'
+    os.makedirs(looking_at_dir, exist_ok=True)
+
+    from config import get_browser_script_imports
+    scrape_script = f'''
 {get_browser_script_imports()}
 
-def run_workflow_hijacking():
+def run_browser_scrape():
     try:
         from selenium import webdriver
         from selenium.webdriver.chrome.options import Options
-        from selenium.webdriver.common.by import By
-        from selenium.webdriver.common.keys import Keys
-        from selenium.webdriver.support.ui import WebDriverWait
-        from selenium.webdriver.support import expected_conditions as EC
-        from selenium.common.exceptions import TimeoutException, NoSuchElementException
         from seleniumwire import webdriver as wire_webdriver
         
         target_url = "{url}"
-        target_pipeline_id = "{pipeline_id}"
-        print(f"🎭 SUBPROCESS: Starting workflow hijacking for {{target_url}} with pipeline {{target_pipeline_id}}")
+        print(f"👁️ SUBPROCESS: Starting scrape for {{target_url}}")
         
         import tempfile
         from config import get_chrome_options
         chrome_options = get_chrome_options()
         
-        profile_dir = tempfile.mkdtemp(prefix='pipulate_workflow_hijack_')
+        profile_dir = tempfile.mkdtemp(prefix='pipulate_scrape_')
         chrome_options.add_argument(f'--user-data-dir={{profile_dir}}')
-        
         driver = wire_webdriver.Chrome(options=chrome_options)
         
         try:
-            print(f"🌐 SUBPROCESS: Step 1 - Navigating to {{target_url}}")
+            print(f"🌐 SUBPROCESS: Navigating to {{target_url}}")
             driver.get(target_url)
-            time.sleep({page_load_wait})
-            print(f"✅ SUBPROCESS: Navigation completed")
-            
-            print(f"🔑 SUBPROCESS: Step 2 - Looking for pipeline key input field")
-            
-            pipeline_input = None
-            selectors = [
-                'input[name="pipeline_id"]', 'input[placeholder*="pipeline"]',
-                'input[placeholder*="key"]', 'input[type="text"]',
-                '#pipeline_id', '.pipeline-input'
-            ]
-            
-            for selector in selectors:
-                try:
-                    pipeline_input = driver.find_element(By.CSS_SELECTOR, selector)
-                    print(f"✅ SUBPROCESS: Found pipeline input using selector: {{selector}}")
-                    break
-                except NoSuchElementException:
-                    continue
-            
-            if not pipeline_input:
-                return {{"success": False, "error": "Could not find pipeline key input field", "page_title": driver.title, "current_url": driver.current_url}}
-            
-            pipeline_input.clear()
-            pipeline_input.send_keys(target_pipeline_id)
-            print(f"🔑 SUBPROCESS: Filled pipeline key: {{target_pipeline_id}}")
-            time.sleep({form_delay})
-            
-            print(f"⚡ SUBPROCESS: Step 3 - Pressing Enter to trigger HTMX chain reaction")
-            pipeline_input.send_keys(Keys.RETURN)
-            
-            print(f"📤 SUBPROCESS: Step 3.5 - Waiting {post_wait}s for POST request + HTMX response...")
-            time.sleep({post_wait})
-            
-            print(f"🔄 SUBPROCESS: Step 4 - Waiting {chain_wait} seconds for HTMX chain reaction to complete")
-            
-            for i in range({chain_wait}):
-                time.sleep(1)
-                if i % 2 == 0:
-                    try:
-                        steps = driver.find_elements(By.CSS_SELECTOR, '[id*="step_"], .card h3, .card h2')
-                        print(f"🔄 SUBPROCESS: Chain reaction progress - {{len(steps)}} workflow elements detected")
-                    except:
-                        print(f"🔄 SUBPROCESS: Chain reaction progress - {{i+1}}/{chain_wait} seconds")
-            
-            print(f"✅ SUBPROCESS: Chain reaction wait completed")
-            
-            print(f"⏳ SUBPROCESS: Allowing {stabilization} seconds for workflow stabilization...")
-            time.sleep({stabilization})
-            
-            print(f"📸 SUBPROCESS: Step 5 - Capturing final workflow state")
+            time.sleep({wait_seconds})
+            print(f"✅ SUBPROCESS: Navigation and wait complete.")
             
+            print(f"📸 SUBPROCESS: Capturing page state...")
             page_title = driver.title
             current_url = driver.current_url
             
@@ -208,234 +79,131 @@ def run_workflow_hijacking():
             dom_content = driver.execute_script("return document.documentElement.outerHTML;")
             with open("{looking_at_dir}/dom.html", "w", encoding="utf-8") as f: f.write(dom_content)
             
-            simple_dom = f\"\"\"<html>
-<head><title>{{page_title}}</title></head>
-<body>
-{{dom_content}}
-</body>
-</html>\"\"\"
-            
-            with open("{looking_at_dir}/simple_dom.html", "w", encoding="utf-8") as f: f.write(simple_dom)
-            
             screenshot_saved = False
             if {take_screenshot}:
                 driver.save_screenshot("{looking_at_dir}/screenshot.png")
                 screenshot_saved = True
             
-            headers_data = {{"url": current_url, "original_url": target_url, "title": page_title, "pipeline_id": target_pipeline_id, "timestamp": datetime.now().isoformat(), "hijacking_type": "complete_workflow_chain_reaction", "chain_reaction_wait_seconds": {chain_wait}, "total_browser_time_seconds": {total_time}, "screenshot_taken": screenshot_saved, "status": "success"}}
-            
+            headers_data = {{"url": current_url, "title": page_title, "timestamp": datetime.now().isoformat(), "scrape_type": "direct_scrape", "screenshot_taken": screenshot_saved, "status": "success"}}
             with open("{looking_at_dir}/headers.json", "w") as f: json.dump(headers_data, f, indent=2)
             
-            print(f"👁️ SUBPROCESS: Displaying final state for {human_view} seconds...")
-            time.sleep({human_view})
-            
-            return {{"success": True, "workflow_hijacked": True, "chain_reaction_completed": True, "url": current_url, "original_url": target_url, "pipeline_id": target_pipeline_id, "title": page_title, "timestamp": datetime.now().isoformat(), "screenshot_saved": screenshot_saved}}
+            print(f"🎉 SUBPROCESS: Scrape completed successfully!")
+            return {{"success": True, "url": current_url, "title": page_title, "screenshot_saved": screenshot_saved}}
             
         finally:
             driver.quit()
             import shutil
             try: shutil.rmtree(profile_dir)
             except: pass
-                
     except Exception as e:
         return {{"success": False, "error": str(e)}}
 
 if __name__ == "__main__":
-    result = run_workflow_hijacking()
+    result = run_browser_scrape()
     print(f"SUBPROCESS_RESULT:{{json.dumps(result)}}")
 '''
-        
-        with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as script_file:
-            script_file.write(hijack_script)
-            script_path = script_file.name
-        
-        try:
-            logger.info(f"🔄 FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_START - Running complete workflow hijacking")
-            
-            process = await asyncio.create_subprocess_exec(
-                sys.executable, script_path,  # <-- FIXED
-                stdout=asyncio.subprocess.PIPE,
-                stderr=asyncio.subprocess.PIPE,
-                cwd=os.getcwd()
-            )
-            
-            try:
-                stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=120.0)
-            except asyncio.TimeoutError:
-                process.kill()
-                await process.wait()
-                return {"success": False, "error": "Workflow hijacking timed out after 120 seconds"}
-            
-            output = stdout.decode('utf-8')
-            error_output = stderr.decode('utf-8')
-            
-            if process.returncode != 0:
-                logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_ERROR - Return code: {process.returncode}")
-                logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_STDERR - {error_output}")
-                return {"success": False, "error": f"Workflow hijacking subprocess failed: {error_output}"}
-            
-            result_line = None
-            for line in output.split('\\n'):
-                if line.startswith('SUBPROCESS_RESULT:'):
-                    result_line = line.replace('SUBPROCESS_RESULT:', '')
-                    break
-            
-            if result_line:
-                try:
-                    subprocess_result = json.loads(result_line)
-                    if subprocess_result.get('success'):
-                        return {"success": True, "workflow_hijacked": True, "chain_reaction_completed": True, "url": subprocess_result.get('url'), "original_url": url, "pipeline_id": pipeline_id, "title": subprocess_result.get('title'), "timestamp": subprocess_result.get('timestamp'), "looking_at_files": {"headers": f"{looking_at_dir}/headers.json", "source": f"{looking_at_dir}/source.html", "dom": f"{looking_at_dir}/dom.html", "simple_dom": f"{looking_at_dir}/simple_dom.html", "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None}, "hijacking_steps": [{"step": "navigation", "status": "success", "details": {"url": url}}, {"step": "pipeline_key_entry", "status": "success", "details": {"pipeline_id": pipeline_id}}, {"step": "form_submission", "status": "success", "details": {"method": "enter_key"}}, {"step": "chain_reaction_wait", "status": "success", "details": {"wait_seconds": chain_wait}}, {"step": "final_state_capture", "status": "success", "details": {"files_saved": 4 + (1 if take_screenshot else 0)}}]}
-                    else:
-                        return {"success": False, "error": subprocess_result.get('error', 'Unknown subprocess error')}
-                except json.JSONDecodeError as e:
-                    logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_JSON_DECODE_ERROR - {e}")
-                    return {"success": False, "error": f"Failed to parse subprocess result: {e}"}
-            else:
-                logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_NO_RESULT - No result line found in output")
-                return {"success": False, "error": "No result found in subprocess output"}
-                
-        finally:
-            try: os.unlink(script_path)
-            except: pass
-        
-    except Exception as e:
-        logger.error(f"❌ FINDER_TOKEN: MCP_WORKFLOW_HIJACK_ERROR - {e}")
-        return {"success": False, "error": f"Workflow hijacking failed: {str(e)}"}
-"""
-    },
-    {
-        "file": "tools/advanced_automation_tools.py",
-        "block_name": "execute_mcp_cli_command",
-        "new_code": """
-async def execute_mcp_cli_command(params: dict) -> dict:
-    \"\"\"
-    Execute MCP CLI commands for local LLM access to the unified interface.
-    
-    This enables the local LLM to use the same CLI interface as external AI assistants.
-    The local LLM can execute commands like: mcp execute_automation_recipe --recipe_path ...
-    
-    Args:
-        params (dict): Parameters for CLI command execution
-            - tool_name (str): Name of the MCP tool to execute
-            - arguments (dict, optional): Key-value pairs for CLI arguments
-            - raw_command (str, optional): Raw CLI command to execute
-    
-    Returns:
-        dict: Results of CLI command execution
-    \"\"\"
-    import subprocess
-    import os
-    import asyncio
-    import sys  # <-- ADDED IMPORT
-    
+    with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as script_file:
+        script_file.write(scrape_script)
+        script_path = script_file.name
+
     try:
-        # Get parameters
-        tool_name = params.get('tool_name')
-        arguments = params.get('arguments', {})
-        raw_command = params.get('raw_command')
-        
-        # Build the CLI command
-        if raw_command:
-            cmd_parts = raw_command.split()
-        elif tool_name:
-            cmd_parts = [sys.executable, "cli.py", "call", tool_name] # <-- FIXED
-            for key, value in arguments.items():
-                cmd_parts.extend([f"--{key}", str(value)])
-        else:
-            cmd_parts = [sys.executable, "helpers/ai_tool_discovery.py", "list"] # <-- FIXED
-        
         process = await asyncio.create_subprocess_exec(
-            *cmd_parts,
-            stdout=asyncio.subprocess.PIPE,
-            stderr=asyncio.subprocess.PIPE,
-            cwd=os.getcwd()
+            sys.executable, script_path,
+            stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.PIPE, cwd=os.getcwd()
         )
+        stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=120.0)
         
-        try:
-            stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=30.0)
-        except asyncio.TimeoutError:
-            process.kill()
-            await process.wait()
-            raise Exception("Command execution timed out after 30 seconds")
-        
-        stdout_text = stdout.decode('utf-8') if stdout else ""
-        stderr_text = stderr.decode('utf-8') if stderr else ""
-        
-        return {"success": process.returncode == 0, "command": " ".join(cmd_parts), "stdout": stdout_text, "stderr": stderr_text, "return_code": process.returncode, "tool_name": tool_name or "discovery", "interface_type": "cli_unified", "description": "Local LLM executed CLI command via unified interface"}
+        if process.returncode != 0:
+            return {"success": False, "error": f"Scrape subprocess failed: {stderr.decode('utf-8')}"}
+            
+        result_line = next((line.replace('SUBPROCESS_RESULT:', '') for line in stdout.decode('utf-8').split('\\n') if line.startswith('SUBPROCESS_RESULT:')), None)
         
-    except Exception as e:
-        return {"success": False, "error": str(e), "tool_name": params.get('tool_name', 'unknown'), "interface_type": "cli_unified", "description": "CLI command execution failed"}
+        if result_line:
+            subprocess_result = json.loads(result_line)
+            if subprocess_result.get('success'):
+                return {"success": True, "url": subprocess_result.get('url'), "title": subprocess_result.get('title'), "looking_at_files": {"headers": f"{looking_at_dir}/headers.json", "source": f"{looking_at_dir}/source.html", "dom": f"{looking_at_dir}/dom.html", "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None}}
+            else:
+                return {"success": False, "error": subprocess_result.get('error', 'Unknown subprocess error')}
+        else:
+            return {"success": False, "error": "No result from subprocess"}
+    finally:
+        try: os.unlink(script_path)
+        except: pass
 """
     },
     {
-        "file": "tools/advanced_automation_tools.py",
-        "block_name": "server_reboot",
-        "new_code": """
-async def server_reboot(params: dict) -> dict:
-    \"\"\"
-    Gracefully reboot the Pipulate server using the watchdog system.
+        "file": "pipulate/core.py",
+        "block_name": "notebook_api_methods",
+        "new_code": r"""
+    def read(self, job: str) -> dict:
+        \"\"\"Reads the entire state dictionary for a given job (pipeline_id).\"\"\"
+        state = self.read_state(job)
+        state.pop('created', None)
+        state.pop('updated', None)
+        return state
     
-    This tool performs an elegant server restart by:
-    1. Checking if the server is currently running
-    2. If running, touching server.py to trigger watchdog restart
-    3. If not running, falling back to direct start
-    4. Verifying the server responds after restart
+    def write(self, job: str, state: dict):
+        \"\"\"Writes an entire state dictionary for a given job (pipeline_id).\"\"\"
+        existing_state = self.read_state(job)
+        if 'created' in existing_state:
+            state['created'] = existing_state['created']
+        self.write_state(job, state)
+
+    def set(self, job: str, step: str, value: any):
+        \"\"\"Sets a key-value pair within a job's state for notebook usage.\"\"\"
+        state = self.read_state(job)
+        if not state:
+            state = {'created': self.get_timestamp()}
+
+        state[step] = value
+        state['updated'] = self.get_timestamp()
+
+        payload = {
+            'pkey': job,
+            'app_name': 'notebook',
+            'data': json.dumps(state),
+            'created': state.get('created', state['updated']),
+            'updated': state['updated']
+        }
+        self.pipeline_table.upsert(payload, pk='pkey')
     
-    Args:
-        params: Dictionary (no parameters required)
-        
-    Returns:
-        dict: Result of the reboot operation with server verification
-    \"\"\"
-    try:
-        import subprocess
-        import asyncio
-        import os
-        import aiohttp
-        from pathlib import Path
-        import sys  # <-- ADDED IMPORT
-        
-        check_process = subprocess.run(['pgrep', '-f', 'python server.py'], capture_output=True, text=True)
-        server_was_running = check_process.returncode == 0
-        server_pids = check_process.stdout.strip().split('\\n') if server_was_running else []
-        
-        if server_was_running:
-            server_py_path = Path('server.py')
-            if server_py_path.exists():
-                server_py_path.touch()
-                restart_method = "watchdog_triggered"
-                restart_details = f"Touched server.py to trigger watchdog restart (PIDs: {', '.join(server_pids)})"
-            else:
-                return {"success": False, "error": "server.py not found in current directory", "current_directory": os.getcwd(), "message": "Cannot trigger watchdog restart - server.py missing"}
-        else:
-            start_result = subprocess.Popen([sys.executable, 'server.py'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, cwd=os.getcwd(), start_new_session=True) # <-- FIXED
-            restart_method = "direct_start"
-            restart_details = f"Server was not running, started directly (PID: {start_result.pid})"
-        
-        await asyncio.sleep(8 if server_was_running else 3)
-        
-        server_responding = False
-        response_status = None
-        response_error = None
-        
-        max_attempts = 5 if server_was_running else 3
-        for attempt in range(max_attempts):
-            try:
-                async with aiohttp.ClientSession() as session:
-                    async with session.get('http://localhost:5001/', timeout=aiohttp.ClientTimeout(total=5)) as response:
-                        response_status = response.status
-                        if response.status == 200:
-                            server_responding = True
-                            break
-            except Exception as e:
-                response_error = str(e)
-                if attempt < max_attempts - 1:
-                    await asyncio.sleep(1.5 if server_was_running else 2)
-        
-        return {"success": server_responding, "message": "Server reboot completed successfully" if server_responding else "Server reboot failed - server not responding", "restart_method": restart_method, "restart_details": restart_details, "server_was_running": server_was_running, "server_responding": server_responding, "response_status": response_status, "response_error": response_error, "status": "Graceful restart via watchdog - verified responding" if server_responding and server_was_running else "Direct start - verified responding" if server_responding else "Restart attempted but server not responding"}
-        
-    except Exception as e:
-        return {"success": False, "error": str(e), "message": "Failed to reboot server"}
+    def get(self, job: str, step: str, default: any = None) -> any:
+        \"\"\"Gets a value for a key within a job's state.\"\"\"
+        state = self.read_state(job)
+        return state.get(step, default)
+
+    async def scrape(self, url: str, take_screenshot: bool = False, **kwargs):
+        \"\"\"
+        Gives AI "eyes" by performing advanced browser automation to scrape a URL.
+
+        This method acts as a simplified bridge to the powerful browser automation
+        tools, allowing for direct, on-demand scraping from notebooks or other clients.
+
+        Args:
+            url (str): The URL to scrape.
+            take_screenshot (bool): Whether to capture a screenshot of the page.
+            **kwargs: Additional parameters to pass to the underlying automation tool.
+
+        Returns:
+            dict: The result from the browser automation tool, typically including
+                  paths to captured artifacts like DOM, source, and screenshot.
+        \"\"\"
+        try:
+            from tools.advanced_automation_tools import browser_scrape_page
+            logger.info(f"👁️‍🗨️ Initiating advanced scrape for: {url}")
+            params = {
+                "url": url,
+                "take_screenshot": take_screenshot,
+                **kwargs
+            }
+            result = await browser_scrape_page(params)
+            return result
+        except ImportError:
+            logger.error("❌ Could not import browser_scrape_page. Ensure it exists in advanced_automation_tools.py.")
+            return {"success": False, "error": "Browser automation tool not found."}
+        except Exception as e:
+            logger.error(f"❌ Advanced scrape failed for {url}: {e}")
+            return {"success": False, "error": str(e)}
 """
     }
 ]
\ No newline at end of file
diff --git a/pyproject.toml b/pyproject.toml
index 75e48cd7..acb696c4 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -81,7 +81,7 @@ exclude = [
     "data*", 
     "downloads*", 
     "scripts*", 
-    "browser_automation*",
+    "browser_cache*",
     "Notebooks*",
     ".venv*"
 ]
diff --git a/tools/advanced_automation_tools.py b/tools/advanced_automation_tools.py
index 12e1c6d0..98c725ba 100644
--- a/tools/advanced_automation_tools.py
+++ b/tools/advanced_automation_tools.py
@@ -72,7 +72,7 @@ async def execute_complete_session_hijacking(params: dict) -> dict:
     """
     MCP Tool: COMPLETE SESSION HIJACKING - Full end-to-end user session takeover
     
-    🧠 CRITICAL: BROWSER EYES ARE PRIMARY - Check browser_automation/looking_at/ FIRST!
+    🧠 CRITICAL: BROWSER EYES ARE PRIMARY - Check browser_cache/looking_at/ FIRST!
     
     COMMON MISTAKE: Focusing on return values (Success: True, Steps: 0, Final URL: None)
     instead of checking browser evidence. Return values can be misleading - visual evidence
@@ -420,9 +420,9 @@ async def browser_hijack_workflow_complete(params: dict) -> dict:
             "url": "http://localhost:5001/hello_workflow",
             "pipeline_id": "Default_Profile-hello-16",
             "looking_at_files": {
-                "screenshot": "browser_automation/looking_at/screenshot.png",
-                "dom": "browser_automation/looking_at/dom.html",
-                "simple_dom": "browser_automation/looking_at/simple_dom.html"
+                "screenshot": "browser_cache/looking_at/screenshot.png",
+                "dom": "browser_cache/looking_at/dom.html",
+                "simple_dom": "browser_cache/looking_at/simple_dom.html"
             },
             "hijacking_steps": [
                 {"step": "navigation", "status": "success"},
@@ -467,11 +467,11 @@ async def browser_hijack_workflow_complete(params: dict) -> dict:
 
         # === DIRECTORY ROTATION ===
         rotation_success = rotate_looking_at_directory(
-            looking_at_path=Path('browser_automation/looking_at'),
+            looking_at_path=Path('browser_cache/looking_at'),
             max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
         )
 
-        looking_at_dir = 'browser_automation/looking_at'
+        looking_at_dir = 'browser_cache/looking_at'
         os.makedirs(looking_at_dir, exist_ok=True)
 
         hijacking_steps = []
@@ -746,21 +746,21 @@ async def _execute_json_recipe(recipe_data: dict, execution_params: dict) -> dic
             """Capture browser state for immediate AI analysis"""
             try:
                 # Ensure looking_at directory exists
-                looking_at_dir = Path("browser_automation/looking_at")
+                looking_at_dir = Path("browser_cache/looking_at")
                 looking_at_dir.mkdir(exist_ok=True)
                 
                 # Take screenshot
-                screenshot_path = f"browser_automation/looking_at/recipe_step_{step_num}_{step_type}.png"
+                screenshot_path = f"browser_cache/looking_at/recipe_step_{step_num}_{step_type}.png"
                 driver.save_screenshot(screenshot_path)
                 
                 # Capture DOM snapshot
                 dom_content = driver.page_source
-                dom_path = f"browser_automation/looking_at/recipe_step_{step_num}_{step_type}_dom.html"
+                dom_path = f"browser_cache/looking_at/recipe_step_{step_num}_{step_type}_dom.html"
                 with open(dom_path, 'w', encoding='utf-8') as f:
                     f.write(dom_content)
                 
                 # Create simplified DOM for AI analysis
-                simple_dom_path = f"browser_automation/looking_at/recipe_step_{step_num}_{step_type}_simple.html"
+                simple_dom_path = f"browser_cache/looking_at/recipe_step_{step_num}_{step_type}_simple.html"
                 simple_dom = f"""
                 <html>
                 <head><title>Recipe Step {step_num} Analysis</title></head>
@@ -1072,7 +1072,7 @@ async def _execute_json_recipe(recipe_data: dict, execution_params: dict) -> dic
                 "continuous_feedback": continuous_feedback,
                 "execution_time": time.time(),
                 "looking_at_files": {
-                    "directory": "browser_automation/looking_at/",
+                    "directory": "browser_cache/looking_at/",
                     "snapshots_captured": len(continuous_feedback["looking_at_snapshots"])
                 }
             }
@@ -1131,12 +1131,12 @@ async def execute_automation_recipe(params: dict = None) -> dict:
     try:
         # Import the recipe automation executor
         import sys
-        sys.path.append('browser_automation')
+        sys.path.append('browser_cache')
         from recipe_executor import RecipeExecutor
         
         # Level 1: No parameters - show available origins and quick actions
         if not params:
-            recipes_dir = Path("browser_automation/automation_recipes")
+            recipes_dir = Path("browser_cache/automation_recipes")
             available_origins = []
             
             if recipes_dir.exists():
@@ -1173,11 +1173,11 @@ async def execute_automation_recipe(params: dict = None) -> dict:
             origin = params["origin"]
             # Convert origin to directory name format
             origin_dir = origin.replace('://', '_', 1).replace('.', '_').replace(':', '_')
-            recipes_path = Path(f"browser_automation/automation_recipes/{origin_dir}")
+            recipes_path = Path(f"browser_cache/automation_recipes/{origin_dir}")
             
             if not recipes_path.exists():
                 available_origins = []
-                recipes_dir = Path("browser_automation/automation_recipes")
+                recipes_dir = Path("browser_cache/automation_recipes")
                 if recipes_dir.exists():
                     for d in recipes_dir.iterdir():
                         if d.is_dir() and not d.name.startswith('.'):
@@ -1254,7 +1254,7 @@ async def execute_automation_recipe(params: dict = None) -> dict:
             
             # Convert origin to directory name format
             origin_dir = origin.replace('://', '_', 1).replace('.', '_').replace(':', '_')
-            recipe_path = Path(f"browser_automation/automation_recipes/{origin_dir}/{recipe_name}.json")
+            recipe_path = Path(f"browser_cache/automation_recipes/{origin_dir}/{recipe_name}.json")
             
             if not recipe_path.exists():
                 return {
@@ -1373,15 +1373,15 @@ async def persist_perception_state(params: dict) -> dict:
     
     # Source directory logic
     if from_dir_num == "current":
-        source_dir = Path("browser_automation/looking_at")
+        source_dir = Path("browser_cache/looking_at")
     else:
-        source_dir = Path(f"browser_automation/looking_at-{from_dir_num}")
+        source_dir = Path(f"browser_cache/looking_at-{from_dir_num}")
     
     if not source_dir.exists():
         return {
             "success": False,
             "error": f"Source directory {source_dir} does not exist",
-            "available_dirs": [p.name for p in Path("browser_automation").glob("looking_at*")]
+            "available_dirs": [p.name for p in Path("browser_cache").glob("looking_at*")]
         }
     
     # Create timestamped destination in scrapes/
@@ -1623,7 +1623,7 @@ async def follow_breadcrumb_trail(params: dict) -> dict:
         
         # Verify we're in the right environment
         env_check = await execute_shell_command({
-            "command": "ls -la server.py plugins browser_automation"
+            "command": "ls -la server.py plugins browser_cache"
         })
         
         if env_check.get("success"):
@@ -1693,7 +1693,7 @@ async def follow_breadcrumb_trail(params: dict) -> dict:
         
         # Check for browser automation evidence
         browser_check = await execute_shell_command({
-            "command": "ls -la browser_automation/"
+            "command": "ls -la browser_cache/"
         })
         
         if browser_check.get("success") and browser_check.get("stdout"):
diff --git a/tools/mcp_tools.py b/tools/mcp_tools.py
index bf3feae3..9c92a609 100644
--- a/tools/mcp_tools.py
+++ b/tools/mcp_tools.py
@@ -197,7 +197,7 @@ def rotate_looking_at_directory(looking_at_path: Path = None, max_rolled_dirs: i
     """
     🔄 DIRECTORY ROTATION SYSTEM
 
-    Rotates the browser_automation/looking_at directory before each new browser scrape.
+    Rotates the browser_cache/looking_at directory before each new browser scrape.
     This preserves AI perception history across multiple look-at operations.
 
     Similar to log rotation but for entire directories:
@@ -207,7 +207,7 @@ def rotate_looking_at_directory(looking_at_path: Path = None, max_rolled_dirs: i
     - Oldest directories beyond limit are deleted
 
     Args:
-        looking_at_path: Path to the looking_at directory (default: browser_automation/looking_at)
+        looking_at_path: Path to the looking_at directory (default: browser_cache/looking_at)
         max_rolled_dirs: Maximum number of historical directories to keep
 
     Returns:
@@ -217,7 +217,7 @@ def rotate_looking_at_directory(looking_at_path: Path = None, max_rolled_dirs: i
     and allows them to review their automation history for better decisions.
     """
     if looking_at_path is None:
-        looking_at_path = Path('browser_automation') / 'looking_at'
+        looking_at_path = Path('browser_cache') / 'looking_at'
     else:
         looking_at_path = Path(looking_at_path)
 
@@ -1314,8 +1314,8 @@ async def execute_ai_session_hijacking_demonstration(params: dict) -> dict:
                     success_msg = f"""🎭 **SESSION HIJACKING EXECUTED!** Result: Success = {hijack_result.get('success')}
 
 👁️ **BROWSER EVIDENCE CAPTURED:**
-- Check: browser_automation/looking_at/simple_dom.html (fits in your context!)
-- Screenshot: browser_automation/looking_at/screenshot.png
+- Check: browser_cache/looking_at/simple_dom.html (fits in your context!)
+- Screenshot: browser_cache/looking_at/screenshot.png
 - Automation ready: {hijack_result.get('session_hijacking_steps', [])}
 
 🧠 **SIMPLE PATTERN DEMONSTRATED:**
@@ -1336,7 +1336,7 @@ print(f'🎭 Hijack: {{result.get("success")}}')
             "demonstration_type": "simple_1_shot_pattern",
             "server_available": server_available,
             "instructions": "The simple pattern executed successfully. Use execute_complete_session_hijacking({}) for rigged success!",
-            "next_step": "Check browser_automation/looking_at/ for evidence, then verify with user's data if available"
+            "next_step": "Check browser_cache/looking_at/ for evidence, then verify with user's data if available"
         }
 
     except Exception as e:
@@ -1595,7 +1595,7 @@ async def browser_analyze_scraped_page(params: dict) -> dict:
     """
     MCP Tool: AI BRAIN - Analyze current /looking_at/ page state for automation opportunities.
 
-    Analyzes the current page state captured in /browser_automation/looking_at/
+    Analyzes the current page state captured in /browser_cache/looking_at/
     to identify automation targets, form elements, and interaction opportunities.
 
     Now includes ENHANCED DOM PROCESSING for automation assistant functionality!
@@ -1625,7 +1625,7 @@ async def browser_analyze_scraped_page(params: dict) -> dict:
                 return {"success": False, "error": f"Backup HTML not found for backup_id: {backup_id}"}
         else:
             # Analyze current /looking_at/ state
-            html_file = "browser_automation/looking_at/simple_dom.html"
+            html_file = "browser_cache/looking_at/simple_dom.html"
             if not os.path.exists(html_file):
                 return {"success": False, "error": "No current page state found. Use browser_scrape_page first to capture page state."}
 
@@ -1645,7 +1645,7 @@ async def browser_analyze_scraped_page(params: dict) -> dict:
         if backup_id:
             accessibility_tree_file = f"downloads/browser_scrapes/{backup_id}/accessibility_tree.json"
         else:
-            accessibility_tree_file = "browser_automation/looking_at/accessibility_tree.json"
+            accessibility_tree_file = "browser_cache/looking_at/accessibility_tree.json"
 
         if os.path.exists(accessibility_tree_file):
             try:
@@ -2036,7 +2036,7 @@ async def browser_scrape_page(params: dict) -> dict:
     MCP Tool: AI EYES - Scrape a web page and save to /looking_at/ for AI perception.
 
     This is the AI's primary sensory interface - captures current browser state
-    into the /browser_automation/looking_at/ directory for AI analysis.
+    into the /browser_cache/looking_at/ directory for AI analysis.
 
     Uses subprocess to avoid threading conflicts with the main server event loop.
 
@@ -2044,7 +2044,7 @@ async def browser_scrape_page(params: dict) -> dict:
     ═══════════════════════════════════════════════════════════════════════
     # Check last 5 automation states for debugging progression:
     for i in range(1, 6):
-        metadata_file = f"browser_automation/looking_at-{i}/headers.json"
+        metadata_file = f"browser_cache/looking_at-{i}/headers.json"
         if os.path.exists(metadata_file):
             data = json.load(open(metadata_file))
             print(f"State {i}: {data.get('step', 'unknown')} at {data.get('url', 'unknown')}")
@@ -2069,11 +2069,11 @@ async def browser_scrape_page(params: dict) -> dict:
             "success": True,
             "url": "https://example.com",
             "looking_at_files": {
-                "headers": "browser_automation/looking_at/headers.json",
-                "source": "browser_automation/looking_at/source.html", 
-                "dom": "browser_automation/looking_at/dom.html",
-                "simple_dom": "browser_automation/looking_at/simple_dom.html",
-                "screenshot": "browser_automation/looking_at/screenshot.png"
+                "headers": "browser_cache/looking_at/headers.json",
+                "source": "browser_cache/looking_at/source.html", 
+                "dom": "browser_cache/looking_at/dom.html",
+                "simple_dom": "browser_cache/looking_at/simple_dom.html",
+                "screenshot": "browser_cache/looking_at/screenshot.png"
             },
             "page_info": {
                 "title": "Page Title",
@@ -2142,7 +2142,7 @@ async def browser_scrape_page(params: dict) -> dict:
         # rotate_looking_at_directory is now defined locally in this module
 
         rotation_success = rotate_looking_at_directory(
-            looking_at_path=Path('browser_automation/looking_at'),
+            looking_at_path=Path('browser_cache/looking_at'),
             max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
         )
 
@@ -2150,7 +2150,7 @@ async def browser_scrape_page(params: dict) -> dict:
             logger.warning("⚠️ FINDER_TOKEN: DIRECTORY_ROTATION_WARNING - Directory rotation failed, continuing with scrape")
 
         # Set up the /looking_at/ directory - AI's primary perception interface
-        looking_at_dir = 'browser_automation/looking_at'
+        looking_at_dir = 'browser_cache/looking_at'
         os.makedirs(looking_at_dir, exist_ok=True)
 
         # Also create timestamped backup in downloads for history
@@ -2167,7 +2167,7 @@ async def browser_scrape_page(params: dict) -> dict:
         browser_script = f'''
 {get_browser_script_imports()}
 
-def run_browser_automation():
+def run_browser_cache():
     try:
         from selenium import webdriver
         from selenium.webdriver.chrome.options import Options
@@ -2373,7 +2373,7 @@ def run_browser_automation():
         }}
 
 if __name__ == "__main__":
-    result = run_browser_automation()
+    result = run_browser_cache()
     print(f"SUBPROCESS_RESULT:{{json.dumps(result)}}")
 '''
 
@@ -2532,7 +2532,7 @@ async def browser_automate_workflow_walkthrough(params: dict) -> dict:
             '160_blank_placeholder': 'blank_placeholder',
             '170_botify_trifecta': 'botify_trifecta',
             '180_tab_opener': 'tab_opener',
-            '190_browser_automation': 'browser_automation',
+            '190_browser_cache': 'browser_cache',
             '200_stream_simulator': 'stream_simulator'
         }
         app_name = plugin_to_app_mapping.get(plugin_name, plugin_name)
@@ -2570,7 +2570,7 @@ async def browser_automate_workflow_walkthrough(params: dict) -> dict:
         from pathlib import Path
 
         rotation_success = rotate_looking_at_directory(
-            looking_at_path=Path('browser_automation/looking_at'),
+            looking_at_path=Path('browser_cache/looking_at'),
             max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
         )
 
@@ -2680,7 +2680,7 @@ async def browser_automate_workflow_walkthrough(params: dict) -> dict:
         def update_looking_at_state(step_name: str):
             """Update /looking_at/ directory with current browser state"""
             try:
-                looking_at_dir = 'browser_automation/looking_at'
+                looking_at_dir = 'browser_cache/looking_at'
                 os.makedirs(looking_at_dir, exist_ok=True)
 
                 # Capture current state
@@ -2759,7 +2759,7 @@ async def browser_automate_workflow_walkthrough(params: dict) -> dict:
                 '160_blank_placeholder': 'blank_placeholder',
                 '170_botify_trifecta': 'botify_trifecta',
                 '180_tab_opener': 'tab_opener',
-                '190_browser_automation': 'browser_automation',
+                '190_browser_cache': 'browser_cache',
                 '200_stream_simulator': 'stream_simulator'
             }
 
@@ -3344,7 +3344,7 @@ async def browser_interact_with_current_page(params: dict) -> dict:
     MCP Tool: AI INTERACTION - Interact with the current page using /looking_at/ state.
 
     This tool allows the AI to interact with the current page that's captured
-    in /browser_automation/looking_at/ directory. It can click elements, fill forms,
+    in /browser_cache/looking_at/ directory. It can click elements, fill forms,
     and perform other interactions based on the current DOM state.
 
     Args:
@@ -3401,7 +3401,7 @@ async def browser_interact_with_current_page(params: dict) -> dict:
 
         try:
             # Get current URL from /looking_at/ state
-            headers_file = 'browser_automation/looking_at/headers.json'
+            headers_file = 'browser_cache/looking_at/headers.json'
             current_url = None
 
             if os.path.exists(headers_file):
@@ -3429,7 +3429,7 @@ async def browser_interact_with_current_page(params: dict) -> dict:
                     driver.get(current_url)
                     time.sleep(wait_seconds)
 
-                screenshot_path = 'browser_automation/looking_at/screenshot.png'
+                screenshot_path = 'browser_cache/looking_at/screenshot.png'
                 driver.save_screenshot(screenshot_path)
 
                 result = {
@@ -3519,7 +3519,7 @@ async def browser_interact_with_current_page(params: dict) -> dict:
             # Update /looking_at/ state if requested
             if update_looking_at and result.get("success"):
                 try:
-                    looking_at_dir = 'browser_automation/looking_at'
+                    looking_at_dir = 'browser_cache/looking_at'
                     os.makedirs(looking_at_dir, exist_ok=True)
 
                     # Capture current state
@@ -3713,7 +3713,7 @@ async def ai_self_discovery_assistant(params: dict) -> dict:
                 "example_params": {
                     "browser_scrape_page": {"url": "https://example.com", "take_screenshot": True},
                     "browser_analyze_scraped_page": {"analysis_type": "all"},
-                    "local_llm_read_file": {"file_path": "browser_automation/looking_at/simple_dom.html"},
+                    "local_llm_read_file": {"file_path": "browser_cache/looking_at/simple_dom.html"},
                     "ui_flash_element": {"element_id": "important-element", "message": "Found key information!"}
                 }
             },
@@ -3766,7 +3766,7 @@ async def ai_self_discovery_assistant(params: dict) -> dict:
                 "solution": "Check server startup logs, ensure tool is registered in register_all_mcp_tools()",
                 "prevention": "Always verify tool availability before attempting usage"
             },
-            "browser_automation_failure": {
+            "browser_cache_failure": {
                 "symptom": "Selenium operations fail or timeout",
                 "solution": "Check Chrome/Chromedriver installation, increase wait_seconds parameter",
                 "prevention": "Use headless mode for reliability, add error handling"
@@ -3985,7 +3985,7 @@ async def _run_context_aware_test_suite() -> dict:
     # Test 4: Browser Automation (Always available if Selenium installed)
     test_results["tests_run"] += 1
     browser_result = await test_basic_browser_capability()
-    test_results["results"]["browser_automation"] = browser_result
+    test_results["results"]["browser_cache"] = browser_result
     if browser_result["success"]:
         test_results["tests_passed"] += 1
     else:

[mike@nixos:~/repos/pipulate]$
```

And finally (I think), PULL!

```diff
HEAD is now at 405f3df0 Rudimenary browser automation from JupyterLab Notebook works. This is the commit before the refactoring storm to solidify Chip's eyes
commit 405f3df0d0e9e5bff31ebcc6926482744a3ae2c0 (HEAD -> main)
Author: Mike Levin <miklevin@gmail.com>
Date:   Fri Oct 10 04:01:22 2025 -0400

    Rudimenary browser automation from JupyterLab Notebook works. This is the commit before the refactoring storm to solidify Chip's eyes

diff --git a/patch.py b/patch.py
index 0e4e26c9..49b461b9 100644
--- a/patch.py
+++ b/patch.py
@@ -1,92 +1,441 @@
 # patch.py
-# This patch adds the .scrape() method to the Pipulate class in core.py.
+# This patch fixes hardcoded '.venv/bin/python' paths in advanced_automation_tools.py
+# by replacing them with the dynamic and robust `sys.executable`.
 
 patches = [
     {
-        "file": "pipulate/core.py",
-        "block_name": "notebook_api_methods",
+        "file": "tools/advanced_automation_tools.py",
+        "block_name": "browser_hijack_workflow_complete",
         "new_code": """
-    def read(self, job: str) -> dict:
-        \"\"\"Reads the entire state dictionary for a given job (pipeline_id).\"\"\"
-        state = self.read_state(job)
-        state.pop('created', None)
-        state.pop('updated', None)
-        return state
+async def browser_hijack_workflow_complete(params: dict) -> dict:
+    \"\"\"
+    MCP Tool: COMPLETE WORKFLOW HIJACKING - Navigate + Enter + Chain Reaction + Capture
     
-    def write(self, job: str, state: dict):
-        \"\"\"Writes an entire state dictionary for a given job (pipeline_id).\"\"\"
-        existing_state = self.read_state(job)
-        if 'created' in existing_state:
-            state['created'] = existing_state['created']
-        self.write_state(job, state)
-
-    def set(self, job: str, step: str, value: any):
-        \"\"\"Sets a key-value pair within a job's state for notebook usage.\"\"\"
-        state = self.read_state(job)
-        if not state:
-            state = {'created': self.get_timestamp()}
-
-        state[step] = value
-        state['updated'] = self.get_timestamp()
-
-        payload = {
-            'pkey': job,
-            'app_name': 'notebook',
-            'data': json.dumps(state),
-            'created': state.get('created', state['updated']),
-            'updated': state['updated']
+    🎭 "HI JACK" MAGIC WORDS PATTERN - The Irresistible Simple Way
+    ═══════════════════════════════════════════════════════════════════════════════════
+    SIMPLEST METHOD: Just type "Hi Jack" in chat → Complete hijacking happens automatically
+    
+    PROGRAMMATIC METHOD for AI understanding:
+    python -c "
+    import asyncio
+    from tools.mcp_tools import browser_hijack_workflow_complete
+    result = asyncio.run(browser_hijack_workflow_complete({
+        'url': 'http://localhost:5001/hello_workflow',
+        'pipeline_id': 'Default_Profile-hello-16'
+    }))
+    print(f'🎭 Hijack: {result.get(\\"success\\")}')"
+    
+    This is the common pattern for all session hijacking that handles:
+    1. Navigate to workflow URL (e.g., http://localhost:5001/hello_workflow)
+    2. Fill in pipeline key input field  
+    3. Press Enter to trigger HTMX chain reaction
+    4. Wait for chain reaction to complete (all hx_trigger="load" steps)
+    5. Capture final workflow state (DOM + screenshot)
+    
+    This captures the POST-ENTER workflow state, not just the landing page form.
+    
+    Args:
+        params: {
+            "url": "http://localhost:5001/hello_workflow",  # Required: Workflow URL
+            "pipeline_id": "Default_Profile-hello-16",      # Required: Pipeline key to enter
+            "take_screenshot": True                         # Optional: capture visual state
         }
-        self.pipeline_table.upsert(payload, pk='pkey')
+        
+        Timing: Uses centralized WorkflowHijackTiming configuration ({WorkflowHijackTiming.total_browser_time()}s total)
+        To adjust timing: Change WorkflowHijackTiming class values or apply_timing_preset("lightning"/"fast"/"dramatic")
     
-    def get(self, job: str, step: str, default: any = None) -> any:
-        \"\"\"Gets a value for a key within a job's state.\"\"\"
-        state = self.read_state(job)
-        return state.get(step, default)
-
-    async def scrape(self, url: str, take_screenshot: bool = False, **kwargs):
-        \"\"\"
-        Gives AI "eyes" by performing advanced browser automation to scrape a URL.
-
-        This method acts as a simplified bridge to the powerful browser automation
-        tools, allowing for direct, on-demand scraping from notebooks or other clients.
-
-        Args:
-            url (str): The URL to scrape.
-            take_screenshot (bool): Whether to capture a screenshot of the page.
-            **kwargs: Additional parameters to pass to the underlying automation tool.
-
-        Returns:
-            dict: The result from the browser automation tool, typically including
-                  paths to captured artifacts like DOM, source, and screenshot.
-        \"\"\"
-        from tools.advanced_automation_tools import browser_hijack_workflow_complete
-        from urllib.parse import urlparse
-        from datetime import datetime
-
-        logger.info(f"👁️‍🗨️ Initiating advanced scrape for: {url}")
+    Returns:
+        dict: {
+            "success": True,
+            "workflow_hijacked": True,
+            "chain_reaction_completed": True,
+            "url": "http://localhost:5001/hello_workflow",
+            "pipeline_id": "Default_Profile-hello-16",
+            "looking_at_files": {
+                "screenshot": "browser_automation/looking_at/screenshot.png",
+                "dom": "browser_automation/looking_at/dom.html",
+                "simple_dom": "browser_automation/looking_at/simple_dom.html"
+            },
+            "hijacking_steps": [
+                {"step": "navigation", "status": "success"},
+                {"step": "pipeline_key_entry", "status": "success"},
+                {"step": "form_submission", "status": "success"},
+                {"step": "chain_reaction_wait", "status": "success"},
+                {"step": "final_state_capture", "status": "success"}
+            ]
+        }
+    \"\"\"
+    import json
+    import os
+    import asyncio
+    import subprocess
+    import tempfile
+    from datetime import datetime
+    from pathlib import Path
+    from urllib.parse import urlparse
+    import sys  # <-- ADDED IMPORT
 
-        # Create a transient, descriptive pipeline_id for this one-off scrape.
-        # This allows us to use the workflow hijacking tool for a simple scrape.
-        domain = urlparse(url).netloc
-        timestamp = datetime.now().strftime('%H%M%S')
-        scrape_pipeline_id = f"scrape-{domain.replace('.', '-')}-{timestamp}"
+    logger.info(f"🎭 FINDER_TOKEN: MCP_WORKFLOW_HIJACK_START - URL: {params.get('url')}, Pipeline: {params.get('pipeline_id')}")
+    
+    try:
+        url = params.get('url')
+        pipeline_id = params.get('pipeline_id')
+        take_screenshot = params.get('take_screenshot', True)
+        
+        # Show current timing configuration
+        logger.info(f"⏰ FINDER_TOKEN: TIMING_CONFIG - {WorkflowHijackTiming.get_timing_summary()}")
+        
+        # === VALIDATION ===
+        if not url:
+            return {"success": False, "error": "URL parameter is required"}
+        if not pipeline_id:
+            return {"success": False, "error": "pipeline_id parameter is required"}
+        
+        # Validate URL format
+        if not url.startswith(('http://', 'https://')):
+            return {"success": False, "error": f"URL must start with http:// or https://. Got: {url}"}
+        
+        logger.info(f"✅ FINDER_TOKEN: WORKFLOW_HIJACK_VALIDATION_PASSED - URL: {url}, Pipeline: {pipeline_id}")
+        
+        # === DIRECTORY ROTATION ===
+        rotation_success = rotate_looking_at_directory(
+            looking_at_path=Path('browser_automation/looking_at'),
+            max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
+        )
+        
+        looking_at_dir = 'browser_automation/looking_at'
+        os.makedirs(looking_at_dir, exist_ok=True)
+        
+        hijacking_steps = []
+        
+        # === SUBPROCESS WORKFLOW HIJACKING TO AVOID THREADING ISSUES ===
+        timing = WorkflowHijackTiming
+        page_load_wait = timing.PAGE_LOAD_WAIT
+        form_delay = timing.FORM_INTERACTION_DELAY  
+        post_wait = timing.POST_REQUEST_WAIT
+        chain_wait = timing.CHAIN_REACTION_WAIT
+        stabilization = timing.FINAL_STABILIZATION
+        human_view = timing.HUMAN_OBSERVATION
+        total_time = timing.total_browser_time()
+        
+        from config import get_browser_script_imports
+        hijack_script = f'''
+{get_browser_script_imports()}
 
-        params = {
-            "url": url,
-            "pipeline_id": scrape_pipeline_id,
-            "take_screenshot": take_screenshot,
-            **kwargs  # Pass through any other params
-        }
+def run_workflow_hijacking():
+    try:
+        from selenium import webdriver
+        from selenium.webdriver.chrome.options import Options
+        from selenium.webdriver.common.by import By
+        from selenium.webdriver.common.keys import Keys
+        from selenium.webdriver.support.ui import WebDriverWait
+        from selenium.webdriver.support import expected_conditions as EC
+        from selenium.common.exceptions import TimeoutException, NoSuchElementException
+        from seleniumwire import webdriver as wire_webdriver
+        
+        target_url = "{url}"
+        target_pipeline_id = "{pipeline_id}"
+        print(f"🎭 SUBPROCESS: Starting workflow hijacking for {{target_url}} with pipeline {{target_pipeline_id}}")
+        
+        import tempfile
+        from config import get_chrome_options
+        chrome_options = get_chrome_options()
+        
+        profile_dir = tempfile.mkdtemp(prefix='pipulate_workflow_hijack_')
+        chrome_options.add_argument(f'--user-data-dir={{profile_dir}}')
+        
+        driver = wire_webdriver.Chrome(options=chrome_options)
+        
+        try:
+            print(f"🌐 SUBPROCESS: Step 1 - Navigating to {{target_url}}")
+            driver.get(target_url)
+            time.sleep({page_load_wait})
+            print(f"✅ SUBPROCESS: Navigation completed")
+            
+            print(f"🔑 SUBPROCESS: Step 2 - Looking for pipeline key input field")
+            
+            pipeline_input = None
+            selectors = [
+                'input[name="pipeline_id"]', 'input[placeholder*="pipeline"]',
+                'input[placeholder*="key"]', 'input[type="text"]',
+                '#pipeline_id', '.pipeline-input'
+            ]
+            
+            for selector in selectors:
+                try:
+                    pipeline_input = driver.find_element(By.CSS_SELECTOR, selector)
+                    print(f"✅ SUBPROCESS: Found pipeline input using selector: {{selector}}")
+                    break
+                except NoSuchElementException:
+                    continue
+            
+            if not pipeline_input:
+                return {{"success": False, "error": "Could not find pipeline key input field", "page_title": driver.title, "current_url": driver.current_url}}
+            
+            pipeline_input.clear()
+            pipeline_input.send_keys(target_pipeline_id)
+            print(f"🔑 SUBPROCESS: Filled pipeline key: {{target_pipeline_id}}")
+            time.sleep({form_delay})
+            
+            print(f"⚡ SUBPROCESS: Step 3 - Pressing Enter to trigger HTMX chain reaction")
+            pipeline_input.send_keys(Keys.RETURN)
+            
+            print(f"📤 SUBPROCESS: Step 3.5 - Waiting {post_wait}s for POST request + HTMX response...")
+            time.sleep({post_wait})
+            
+            print(f"🔄 SUBPROCESS: Step 4 - Waiting {chain_wait} seconds for HTMX chain reaction to complete")
+            
+            for i in range({chain_wait}):
+                time.sleep(1)
+                if i % 2 == 0:
+                    try:
+                        steps = driver.find_elements(By.CSS_SELECTOR, '[id*="step_"], .card h3, .card h2')
+                        print(f"🔄 SUBPROCESS: Chain reaction progress - {{len(steps)}} workflow elements detected")
+                    except:
+                        print(f"🔄 SUBPROCESS: Chain reaction progress - {{i+1}}/{chain_wait} seconds")
+            
+            print(f"✅ SUBPROCESS: Chain reaction wait completed")
+            
+            print(f"⏳ SUBPROCESS: Allowing {stabilization} seconds for workflow stabilization...")
+            time.sleep({stabilization})
+            
+            print(f"📸 SUBPROCESS: Step 5 - Capturing final workflow state")
+            
+            page_title = driver.title
+            current_url = driver.current_url
+            
+            with open("{looking_at_dir}/source.html", "w", encoding="utf-8") as f: f.write(driver.page_source)
+            dom_content = driver.execute_script("return document.documentElement.outerHTML;")
+            with open("{looking_at_dir}/dom.html", "w", encoding="utf-8") as f: f.write(dom_content)
+            
+            simple_dom = f\"\"\"<html>
+<head><title>{{page_title}}</title></head>
+<body>
+{{dom_content}}
+</body>
+</html>\"\"\"
+            
+            with open("{looking_at_dir}/simple_dom.html", "w", encoding="utf-8") as f: f.write(simple_dom)
+            
+            screenshot_saved = False
+            if {take_screenshot}:
+                driver.save_screenshot("{looking_at_dir}/screenshot.png")
+                screenshot_saved = True
+            
+            headers_data = {{"url": current_url, "original_url": target_url, "title": page_title, "pipeline_id": target_pipeline_id, "timestamp": datetime.now().isoformat(), "hijacking_type": "complete_workflow_chain_reaction", "chain_reaction_wait_seconds": {chain_wait}, "total_browser_time_seconds": {total_time}, "screenshot_taken": screenshot_saved, "status": "success"}}
+            
+            with open("{looking_at_dir}/headers.json", "w") as f: json.dump(headers_data, f, indent=2)
+            
+            print(f"👁️ SUBPROCESS: Displaying final state for {human_view} seconds...")
+            time.sleep({human_view})
+            
+            return {{"success": True, "workflow_hijacked": True, "chain_reaction_completed": True, "url": current_url, "original_url": target_url, "pipeline_id": target_pipeline_id, "title": page_title, "timestamp": datetime.now().isoformat(), "screenshot_saved": screenshot_saved}}
+            
+        finally:
+            driver.quit()
+            import shutil
+            try: shutil.rmtree(profile_dir)
+            except: pass
+                
+    except Exception as e:
+        return {{"success": False, "error": str(e)}}
 
+if __name__ == "__main__":
+    result = run_workflow_hijacking()
+    print(f"SUBPROCESS_RESULT:{{json.dumps(result)}}")
+'''
+        
+        with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as script_file:
+            script_file.write(hijack_script)
+            script_path = script_file.name
+        
+        try:
+            logger.info(f"🔄 FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_START - Running complete workflow hijacking")
+            
+            process = await asyncio.create_subprocess_exec(
+                sys.executable, script_path,  # <-- FIXED
+                stdout=asyncio.subprocess.PIPE,
+                stderr=asyncio.subprocess.PIPE,
+                cwd=os.getcwd()
+            )
+            
+            try:
+                stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=120.0)
+            except asyncio.TimeoutError:
+                process.kill()
+                await process.wait()
+                return {"success": False, "error": "Workflow hijacking timed out after 120 seconds"}
+            
+            output = stdout.decode('utf-8')
+            error_output = stderr.decode('utf-8')
+            
+            if process.returncode != 0:
+                logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_ERROR - Return code: {process.returncode}")
+                logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_STDERR - {error_output}")
+                return {"success": False, "error": f"Workflow hijacking subprocess failed: {error_output}"}
+            
+            result_line = None
+            for line in output.split('\\n'):
+                if line.startswith('SUBPROCESS_RESULT:'):
+                    result_line = line.replace('SUBPROCESS_RESULT:', '')
+                    break
+            
+            if result_line:
+                try:
+                    subprocess_result = json.loads(result_line)
+                    if subprocess_result.get('success'):
+                        return {"success": True, "workflow_hijacked": True, "chain_reaction_completed": True, "url": subprocess_result.get('url'), "original_url": url, "pipeline_id": pipeline_id, "title": subprocess_result.get('title'), "timestamp": subprocess_result.get('timestamp'), "looking_at_files": {"headers": f"{looking_at_dir}/headers.json", "source": f"{looking_at_dir}/source.html", "dom": f"{looking_at_dir}/dom.html", "simple_dom": f"{looking_at_dir}/simple_dom.html", "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None}, "hijacking_steps": [{"step": "navigation", "status": "success", "details": {"url": url}}, {"step": "pipeline_key_entry", "status": "success", "details": {"pipeline_id": pipeline_id}}, {"step": "form_submission", "status": "success", "details": {"method": "enter_key"}}, {"step": "chain_reaction_wait", "status": "success", "details": {"wait_seconds": chain_wait}}, {"step": "final_state_capture", "status": "success", "details": {"files_saved": 4 + (1 if take_screenshot else 0)}}]}
+                    else:
+                        return {"success": False, "error": subprocess_result.get('error', 'Unknown subprocess error')}
+                except json.JSONDecodeError as e:
+                    logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_JSON_DECODE_ERROR - {e}")
+                    return {"success": False, "error": f"Failed to parse subprocess result: {e}"}
+            else:
+                logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_NO_RESULT - No result line found in output")
+                return {"success": False, "error": "No result found in subprocess output"}
+                
+        finally:
+            try: os.unlink(script_path)
+            except: pass
+        
+    except Exception as e:
+        logger.error(f"❌ FINDER_TOKEN: MCP_WORKFLOW_HIJACK_ERROR - {e}")
+        return {"success": False, "error": f"Workflow hijacking failed: {str(e)}"}
+"""
+    },
+    {
+        "file": "tools/advanced_automation_tools.py",
+        "block_name": "execute_mcp_cli_command",
+        "new_code": """
+async def execute_mcp_cli_command(params: dict) -> dict:
+    \"\"\"
+    Execute MCP CLI commands for local LLM access to the unified interface.
+    
+    This enables the local LLM to use the same CLI interface as external AI assistants.
+    The local LLM can execute commands like: mcp execute_automation_recipe --recipe_path ...
+    
+    Args:
+        params (dict): Parameters for CLI command execution
+            - tool_name (str): Name of the MCP tool to execute
+            - arguments (dict, optional): Key-value pairs for CLI arguments
+            - raw_command (str, optional): Raw CLI command to execute
+    
+    Returns:
+        dict: Results of CLI command execution
+    \"\"\"
+    import subprocess
+    import os
+    import asyncio
+    import sys  # <-- ADDED IMPORT
+    
+    try:
+        # Get parameters
+        tool_name = params.get('tool_name')
+        arguments = params.get('arguments', {})
+        raw_command = params.get('raw_command')
+        
+        # Build the CLI command
+        if raw_command:
+            cmd_parts = raw_command.split()
+        elif tool_name:
+            cmd_parts = [sys.executable, "cli.py", "call", tool_name] # <-- FIXED
+            for key, value in arguments.items():
+                cmd_parts.extend([f"--{key}", str(value)])
+        else:
+            cmd_parts = [sys.executable, "helpers/ai_tool_discovery.py", "list"] # <-- FIXED
+        
+        process = await asyncio.create_subprocess_exec(
+            *cmd_parts,
+            stdout=asyncio.subprocess.PIPE,
+            stderr=asyncio.subprocess.PIPE,
+            cwd=os.getcwd()
+        )
+        
         try:
-            # We call the 'workflow_hijack' tool, but in this context, it's just
-            # navigating and capturing artifacts. We bypass the form-filling parts
-            # by providing a unique, non-existent pipeline_id.
-            result = await browser_hijack_workflow_complete(params)
-            return result
-        except Exception as e:
-            logger.error(f"❌ Advanced scrape failed for {url}: {e}")
-            return {"success": False, "error": str(e)}
+            stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=30.0)
+        except asyncio.TimeoutError:
+            process.kill()
+            await process.wait()
+            raise Exception("Command execution timed out after 30 seconds")
+        
+        stdout_text = stdout.decode('utf-8') if stdout else ""
+        stderr_text = stderr.decode('utf-8') if stderr else ""
+        
+        return {"success": process.returncode == 0, "command": " ".join(cmd_parts), "stdout": stdout_text, "stderr": stderr_text, "return_code": process.returncode, "tool_name": tool_name or "discovery", "interface_type": "cli_unified", "description": "Local LLM executed CLI command via unified interface"}
+        
+    except Exception as e:
+        return {"success": False, "error": str(e), "tool_name": params.get('tool_name', 'unknown'), "interface_type": "cli_unified", "description": "CLI command execution failed"}
+"""
+    },
+    {
+        "file": "tools/advanced_automation_tools.py",
+        "block_name": "server_reboot",
+        "new_code": """
+async def server_reboot(params: dict) -> dict:
+    \"\"\"
+    Gracefully reboot the Pipulate server using the watchdog system.
+    
+    This tool performs an elegant server restart by:
+    1. Checking if the server is currently running
+    2. If running, touching server.py to trigger watchdog restart
+    3. If not running, falling back to direct start
+    4. Verifying the server responds after restart
+    
+    Args:
+        params: Dictionary (no parameters required)
+        
+    Returns:
+        dict: Result of the reboot operation with server verification
+    \"\"\"
+    try:
+        import subprocess
+        import asyncio
+        import os
+        import aiohttp
+        from pathlib import Path
+        import sys  # <-- ADDED IMPORT
+        
+        check_process = subprocess.run(['pgrep', '-f', 'python server.py'], capture_output=True, text=True)
+        server_was_running = check_process.returncode == 0
+        server_pids = check_process.stdout.strip().split('\\n') if server_was_running else []
+        
+        if server_was_running:
+            server_py_path = Path('server.py')
+            if server_py_path.exists():
+                server_py_path.touch()
+                restart_method = "watchdog_triggered"
+                restart_details = f"Touched server.py to trigger watchdog restart (PIDs: {', '.join(server_pids)})"
+            else:
+                return {"success": False, "error": "server.py not found in current directory", "current_directory": os.getcwd(), "message": "Cannot trigger watchdog restart - server.py missing"}
+        else:
+            start_result = subprocess.Popen([sys.executable, 'server.py'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, cwd=os.getcwd(), start_new_session=True) # <-- FIXED
+            restart_method = "direct_start"
+            restart_details = f"Server was not running, started directly (PID: {start_result.pid})"
+        
+        await asyncio.sleep(8 if server_was_running else 3)
+        
+        server_responding = False
+        response_status = None
+        response_error = None
+        
+        max_attempts = 5 if server_was_running else 3
+        for attempt in range(max_attempts):
+            try:
+                async with aiohttp.ClientSession() as session:
+                    async with session.get('http://localhost:5001/', timeout=aiohttp.ClientTimeout(total=5)) as response:
+                        response_status = response.status
+                        if response.status == 200:
+                            server_responding = True
+                            break
+            except Exception as e:
+                response_error = str(e)
+                if attempt < max_attempts - 1:
+                    await asyncio.sleep(1.5 if server_was_running else 2)
+        
+        return {"success": server_responding, "message": "Server reboot completed successfully" if server_responding else "Server reboot failed - server not responding", "restart_method": restart_method, "restart_details": restart_details, "server_was_running": server_was_running, "server_responding": server_responding, "response_status": response_status, "response_error": response_error, "status": "Graceful restart via watchdog - verified responding" if server_responding and server_was_running else "Direct start - verified responding" if server_responding else "Restart attempted but server not responding"}
+        
+    except Exception as e:
+        return {"success": False, "error": str(e), "message": "Failed to reboot server"}
 """
     }
 ]
\ No newline at end of file
diff --git a/tools/advanced_automation_tools.py b/tools/advanced_automation_tools.py
index 830f9285..12e1c6d0 100644
--- a/tools/advanced_automation_tools.py
+++ b/tools/advanced_automation_tools.py
@@ -378,11 +378,11 @@ async def execute_complete_session_hijacking(params: dict) -> dict:
 async def browser_hijack_workflow_complete(params: dict) -> dict:
     """
     MCP Tool: COMPLETE WORKFLOW HIJACKING - Navigate + Enter + Chain Reaction + Capture
-    
+
     🎭 "HI JACK" MAGIC WORDS PATTERN - The Irresistible Simple Way
     ═══════════════════════════════════════════════════════════════════════════════════
     SIMPLEST METHOD: Just type "Hi Jack" in chat → Complete hijacking happens automatically
-    
+
     PROGRAMMATIC METHOD for AI understanding:
     python -c "
     import asyncio
@@ -392,26 +392,26 @@ async def browser_hijack_workflow_complete(params: dict) -> dict:
         'pipeline_id': 'Default_Profile-hello-16'
     }))
     print(f'🎭 Hijack: {result.get(\"success\")}')"
-    
+
     This is the common pattern for all session hijacking that handles:
     1. Navigate to workflow URL (e.g., http://localhost:5001/hello_workflow)
     2. Fill in pipeline key input field  
     3. Press Enter to trigger HTMX chain reaction
     4. Wait for chain reaction to complete (all hx_trigger="load" steps)
     5. Capture final workflow state (DOM + screenshot)
-    
+
     This captures the POST-ENTER workflow state, not just the landing page form.
-    
+
     Args:
         params: {
             "url": "http://localhost:5001/hello_workflow",  # Required: Workflow URL
             "pipeline_id": "Default_Profile-hello-16",      # Required: Pipeline key to enter
             "take_screenshot": True                         # Optional: capture visual state
         }
-        
+
         Timing: Uses centralized WorkflowHijackTiming configuration ({WorkflowHijackTiming.total_browser_time()}s total)
         To adjust timing: Change WorkflowHijackTiming class values or apply_timing_preset("lightning"/"fast"/"dramatic")
-    
+
     Returns:
         dict: {
             "success": True,
@@ -441,44 +441,42 @@ async def browser_hijack_workflow_complete(params: dict) -> dict:
     from datetime import datetime
     from pathlib import Path
     from urllib.parse import urlparse
-    
+    import sys  # <-- ADDED IMPORT
+
     logger.info(f"🎭 FINDER_TOKEN: MCP_WORKFLOW_HIJACK_START - URL: {params.get('url')}, Pipeline: {params.get('pipeline_id')}")
-    
+
     try:
         url = params.get('url')
         pipeline_id = params.get('pipeline_id')
         take_screenshot = params.get('take_screenshot', True)
-        
+
         # Show current timing configuration
         logger.info(f"⏰ FINDER_TOKEN: TIMING_CONFIG - {WorkflowHijackTiming.get_timing_summary()}")
-        
+
         # === VALIDATION ===
         if not url:
             return {"success": False, "error": "URL parameter is required"}
         if not pipeline_id:
             return {"success": False, "error": "pipeline_id parameter is required"}
-        
+
         # Validate URL format
         if not url.startswith(('http://', 'https://')):
             return {"success": False, "error": f"URL must start with http:// or https://. Got: {url}"}
-        
+
         logger.info(f"✅ FINDER_TOKEN: WORKFLOW_HIJACK_VALIDATION_PASSED - URL: {url}, Pipeline: {pipeline_id}")
-        
+
         # === DIRECTORY ROTATION ===
-        # rotate_looking_at_directory is now defined locally in this module
         rotation_success = rotate_looking_at_directory(
             looking_at_path=Path('browser_automation/looking_at'),
             max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
         )
-        
+
         looking_at_dir = 'browser_automation/looking_at'
         os.makedirs(looking_at_dir, exist_ok=True)
-        
+
         hijacking_steps = []
-        
+
         # === SUBPROCESS WORKFLOW HIJACKING TO AVOID THREADING ISSUES ===
-        # Create a Python script that handles the complete workflow hijacking
-        # Use centralized timing configuration - get actual values for subprocess
         timing = WorkflowHijackTiming
         page_load_wait = timing.PAGE_LOAD_WAIT
         form_delay = timing.FORM_INTERACTION_DELAY  
@@ -487,7 +485,7 @@ async def browser_hijack_workflow_complete(params: dict) -> dict:
         stabilization = timing.FINAL_STABILIZATION
         human_view = timing.HUMAN_OBSERVATION
         total_time = timing.total_browser_time()
-        
+
         from config import get_browser_script_imports
         hijack_script = f'''
 {get_browser_script_imports()}
@@ -502,44 +500,35 @@ def run_workflow_hijacking():
         from selenium.webdriver.support import expected_conditions as EC
         from selenium.common.exceptions import TimeoutException, NoSuchElementException
         from seleniumwire import webdriver as wire_webdriver
-        
+
         target_url = "{url}"
         target_pipeline_id = "{pipeline_id}"
         print(f"🎭 SUBPROCESS: Starting workflow hijacking for {{target_url}} with pipeline {{target_pipeline_id}}")
-        
-        # Set up Chrome with visible browser (dramatic effect)
+
         import tempfile
         from config import get_chrome_options
         chrome_options = get_chrome_options()
-        
-        # Unique session isolation
+
         profile_dir = tempfile.mkdtemp(prefix='pipulate_workflow_hijack_')
         chrome_options.add_argument(f'--user-data-dir={{profile_dir}}')
-        
-        # Initialize driver
+
         driver = wire_webdriver.Chrome(options=chrome_options)
-        
+
         try:
-            # === STEP 1: NAVIGATION ===
             print(f"🌐 SUBPROCESS: Step 1 - Navigating to {{target_url}}")
             driver.get(target_url)
-            time.sleep({page_load_wait})  # Let page load
+            time.sleep({page_load_wait})
             print(f"✅ SUBPROCESS: Navigation completed")
-            
-            # === STEP 2: FIND AND FILL PIPELINE KEY INPUT ===
+
             print(f"🔑 SUBPROCESS: Step 2 - Looking for pipeline key input field")
-            
-            # Try multiple selectors for pipeline key input
+
             pipeline_input = None
             selectors = [
-                'input[name="pipeline_id"]',
-                'input[placeholder*="pipeline"]',
-                'input[placeholder*="key"]',
-                'input[type="text"]',
-                '#pipeline_id',
-                '.pipeline-input'
+                'input[name="pipeline_id"]', 'input[placeholder*="pipeline"]',
+                'input[placeholder*="key"]', 'input[type="text"]',
+                '#pipeline_id', '.pipeline-input'
             ]
-            
+
             for selector in selectors:
                 try:
                     pipeline_input = driver.find_element(By.CSS_SELECTOR, selector)
@@ -547,260 +536,139 @@ def run_workflow_hijacking():
                     break
                 except NoSuchElementException:
                     continue
-            
+
             if not pipeline_input:
-                return {{
-                    "success": False,
-                    "error": "Could not find pipeline key input field",
-                    "page_title": driver.title,
-                    "current_url": driver.current_url
-                }}
-            
-            # Clear and fill the pipeline key
+                return {{"success": False, "error": "Could not find pipeline key input field", "page_title": driver.title, "current_url": driver.current_url}}
+
             pipeline_input.clear()
             pipeline_input.send_keys(target_pipeline_id)
             print(f"🔑 SUBPROCESS: Filled pipeline key: {{target_pipeline_id}}")
-            time.sleep({form_delay})  # Dramatic pause
-            
-            # === STEP 3: PRESS ENTER TO TRIGGER HTMX CHAIN REACTION ===
+            time.sleep({form_delay})
+
             print(f"⚡ SUBPROCESS: Step 3 - Pressing Enter to trigger HTMX chain reaction")
             pipeline_input.send_keys(Keys.RETURN)
-            
-            # === STEP 3.5: CONSOLIDATED POST + HTMX RESPONSE WAIT ===
+
             print(f"📤 SUBPROCESS: Step 3.5 - Waiting {post_wait}s for POST request + HTMX response...")
-            time.sleep({post_wait})  # Consolidated wait for POST + HTMX
-            
-            # === STEP 4: WAIT FOR HTMX CHAIN REACTION TO COMPLETE ===
+            time.sleep({post_wait})
+
             print(f"🔄 SUBPROCESS: Step 4 - Waiting {chain_wait} seconds for HTMX chain reaction to complete")
-            
-            # Wait and watch for DOM changes indicating chain reaction progress
+
             for i in range({chain_wait}):
                 time.sleep(1)
-                if i % 2 == 0:  # Progress messages every 2 seconds
+                if i % 2 == 0:
                     try:
-                        # Look for workflow step indicators
                         steps = driver.find_elements(By.CSS_SELECTOR, '[id*="step_"], .card h3, .card h2')
                         print(f"🔄 SUBPROCESS: Chain reaction progress - {{len(steps)}} workflow elements detected")
                     except:
                         print(f"🔄 SUBPROCESS: Chain reaction progress - {{i+1}}/{chain_wait} seconds")
-            
+
             print(f"✅ SUBPROCESS: Chain reaction wait completed")
-            
-            # Extra time for workflow stabilization
+
             print(f"⏳ SUBPROCESS: Allowing {stabilization} seconds for workflow stabilization...")
             time.sleep({stabilization})
-            
-            # === STEP 5: CAPTURE FINAL WORKFLOW STATE ===
+
             print(f"📸 SUBPROCESS: Step 5 - Capturing final workflow state")
-            
-            # Get final page info
+
             page_title = driver.title
             current_url = driver.current_url
-            print(f"📄 SUBPROCESS: Final state - Title: {{page_title}}")
-            print(f"📄 SUBPROCESS: Final state - URL: {{current_url}}")
-            
-            # Capture page source
-            with open("{looking_at_dir}/source.html", "w", encoding="utf-8") as f:
-                f.write(driver.page_source)
-            print(f"💾 SUBPROCESS: Saved source.html")
-            
-            # Capture DOM via JavaScript  
+
+            with open("{looking_at_dir}/source.html", "w", encoding="utf-8") as f: f.write(driver.page_source)
             dom_content = driver.execute_script("return document.documentElement.outerHTML;")
-            with open("{looking_at_dir}/dom.html", "w", encoding="utf-8") as f:
-                f.write(dom_content)
-            print(f"💾 SUBPROCESS: Saved dom.html")
-            
-            # Create simplified DOM for AI consumption
+            with open("{looking_at_dir}/dom.html", "w", encoding="utf-8") as f: f.write(dom_content)
+
             simple_dom = f"""<html>
 <head><title>{{page_title}}</title></head>
 <body>
-<!-- Workflow captured from: {{current_url}} -->
-<!-- Pipeline ID: {{target_pipeline_id}} -->
-<!-- Timestamp: {{datetime.now().isoformat()}} -->
-<!-- Post-HTMX Chain Reaction State -->
 {{dom_content}}
 </body>
 </html>"""
-            
-            with open("{looking_at_dir}/simple_dom.html", "w", encoding="utf-8") as f:
-                f.write(simple_dom)
-            print(f"💾 SUBPROCESS: Saved simple_dom.html")
-            
-            # Take screenshot
+
+            with open("{looking_at_dir}/simple_dom.html", "w", encoding="utf-8") as f: f.write(simple_dom)
+
             screenshot_saved = False
             if {take_screenshot}:
                 driver.save_screenshot("{looking_at_dir}/screenshot.png")
                 screenshot_saved = True
-                print(f"📸 SUBPROCESS: Saved screenshot.png")
-            
-            # Save headers and metadata
-            headers_data = {{
-                "url": current_url,
-                "original_url": target_url,
-                "title": page_title,
-                "pipeline_id": target_pipeline_id,
-                "timestamp": datetime.now().isoformat(),
-                "hijacking_type": "complete_workflow_chain_reaction", 
-                "chain_reaction_wait_seconds": {chain_wait},
-                "total_browser_time_seconds": {total_time},
-                "screenshot_taken": screenshot_saved,
-                "status": "success"
-            }}
-            
-            with open("{looking_at_dir}/headers.json", "w") as f:
-                json.dump(headers_data, f, indent=2)
-            print(f"💾 SUBPROCESS: Saved headers.json")
-            
-            print(f"🎉 SUBPROCESS: Workflow hijacking completed successfully!")
-            print(f"📁 SUBPROCESS: All files saved to {looking_at_dir}")
-            
-            # Brief pause to allow human observation of final state
+
+            headers_data = {{"url": current_url, "original_url": target_url, "title": page_title, "pipeline_id": target_pipeline_id, "timestamp": datetime.now().isoformat(), "hijacking_type": "complete_workflow_chain_reaction", "chain_reaction_wait_seconds": {chain_wait}, "total_browser_time_seconds": {total_time}, "screenshot_taken": screenshot_saved, "status": "success"}}
+
+            with open("{looking_at_dir}/headers.json", "w") as f: json.dump(headers_data, f, indent=2)
+
             print(f"👁️ SUBPROCESS: Displaying final state for {human_view} seconds...")
             time.sleep({human_view})
-            
-            return {{
-                "success": True,
-                "workflow_hijacked": True,
-                "chain_reaction_completed": True,
-                "url": current_url,
-                "original_url": target_url,
-                "pipeline_id": target_pipeline_id,
-                "title": page_title,
-                "timestamp": datetime.now().isoformat(),
-                "screenshot_saved": screenshot_saved
-            }}
-            
+
+            return {{"success": True, "workflow_hijacked": True, "chain_reaction_completed": True, "url": current_url, "original_url": target_url, "pipeline_id": target_pipeline_id, "title": page_title, "timestamp": datetime.now().isoformat(), "screenshot_saved": screenshot_saved}}
+
         finally:
-            print(f"🚀 SUBPROCESS: Closing browser gracefully...")
             driver.quit()
-            # Clean up profile directory
             import shutil
-            try:
-                shutil.rmtree(profile_dir)
-            except:
-                pass
-                
+            try: shutil.rmtree(profile_dir)
+            except: pass
+
     except Exception as e:
-        print(f"❌ SUBPROCESS: Workflow hijacking failed: {{e}}")
-        return {{
-            "success": False,
-            "error": str(e)
-        }}
+        return {{"success": False, "error": str(e)}}
 
 if __name__ == "__main__":
     result = run_workflow_hijacking()
     print(f"SUBPROCESS_RESULT:{{json.dumps(result)}}")
 '''
-        
-        # Write the hijacking script to a temporary file
+
         with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as script_file:
             script_file.write(hijack_script)
             script_path = script_file.name
-        
+
         try:
-            # Run the workflow hijacking in subprocess
             logger.info(f"🔄 FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_START - Running complete workflow hijacking")
-            
-            # Use asyncio.create_subprocess_exec for async subprocess
+
             process = await asyncio.create_subprocess_exec(
-                '.venv/bin/python', script_path,
+                sys.executable, script_path,  # <-- FIXED
                 stdout=asyncio.subprocess.PIPE,
                 stderr=asyncio.subprocess.PIPE,
                 cwd=os.getcwd()
             )
-            
-            # Wait for completion with timeout
+
             try:
-                stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=120.0)  # Longer timeout for chain reaction
+                stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=120.0)
             except asyncio.TimeoutError:
                 process.kill()
                 await process.wait()
-                return {
-                    "success": False,
-                    "error": "Workflow hijacking timed out after 120 seconds"
-                }
-            
-            # Parse the result from subprocess output
+                return {"success": False, "error": "Workflow hijacking timed out after 120 seconds"}
+
             output = stdout.decode('utf-8')
             error_output = stderr.decode('utf-8')
-            
+
             if process.returncode != 0:
                 logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_ERROR - Return code: {process.returncode}")
                 logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_STDERR - {error_output}")
-                return {
-                    "success": False,
-                    "error": f"Workflow hijacking subprocess failed: {error_output}"
-                }
-            
-            # Extract result from subprocess output
+                return {"success": False, "error": f"Workflow hijacking subprocess failed: {error_output}"}
+
             result_line = None
             for line in output.split('\n'):
                 if line.startswith('SUBPROCESS_RESULT:'):
                     result_line = line.replace('SUBPROCESS_RESULT:', '')
                     break
-            
+
             if result_line:
                 try:
                     subprocess_result = json.loads(result_line)
-                    
                     if subprocess_result.get('success'):
-                        # Build the complete response
-                        return {
-                            "success": True,
-                            "workflow_hijacked": True,
-                            "chain_reaction_completed": True,
-                            "url": subprocess_result.get('url'),
-                            "original_url": url,
-                            "pipeline_id": pipeline_id,
-                            "title": subprocess_result.get('title'),
-                            "timestamp": subprocess_result.get('timestamp'),
-                            "looking_at_files": {
-                                "headers": f"{looking_at_dir}/headers.json",
-                                "source": f"{looking_at_dir}/source.html",
-                                "dom": f"{looking_at_dir}/dom.html",
-                                "simple_dom": f"{looking_at_dir}/simple_dom.html",
-                                "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None
-                            },
-                            "hijacking_steps": [
-                                {"step": "navigation", "status": "success", "details": {"url": url}},
-                                {"step": "pipeline_key_entry", "status": "success", "details": {"pipeline_id": pipeline_id}},
-                                {"step": "form_submission", "status": "success", "details": {"method": "enter_key"}},
-                                {"step": "chain_reaction_wait", "status": "success", "details": {"wait_seconds": chain_wait}},
-                                {"step": "final_state_capture", "status": "success", "details": {"files_saved": 4 + (1 if take_screenshot else 0)}}
-                            ]
-                        }
+                        return {"success": True, "workflow_hijacked": True, "chain_reaction_completed": True, "url": subprocess_result.get('url'), "original_url": url, "pipeline_id": pipeline_id, "title": subprocess_result.get('title'), "timestamp": subprocess_result.get('timestamp'), "looking_at_files": {"headers": f"{looking_at_dir}/headers.json", "source": f"{looking_at_dir}/source.html", "dom": f"{looking_at_dir}/dom.html", "simple_dom": f"{looking_at_dir}/simple_dom.html", "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None}, "hijacking_steps": [{"step": "navigation", "status": "success", "details": {"url": url}}, {"step": "pipeline_key_entry", "status": "success", "details": {"pipeline_id": pipeline_id}}, {"step": "form_submission", "status": "success", "details": {"method": "enter_key"}}, {"step": "chain_reaction_wait", "status": "success", "details": {"wait_seconds": chain_wait}}, {"step": "final_state_capture", "status": "success", "details": {"files_saved": 4 + (1 if take_screenshot else 0)}}]}
                     else:
-                        return {
-                            "success": False,
-                            "error": subprocess_result.get('error', 'Unknown subprocess error')
-                        }
-                        
+                        return {"success": False, "error": subprocess_result.get('error', 'Unknown subprocess error')}
                 except json.JSONDecodeError as e:
                     logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_JSON_DECODE_ERROR - {e}")
-                    return {
-                        "success": False,
-                        "error": f"Failed to parse subprocess result: {e}"
-                    }
+                    return {"success": False, "error": f"Failed to parse subprocess result: {e}"}
             else:
                 logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_NO_RESULT - No result line found in output")
-                return {
-                    "success": False,
-                    "error": "No result found in subprocess output"
-                }
-                
+                return {"success": False, "error": "No result found in subprocess output"}
+
         finally:
-            # Clean up the temporary script file
-            try:
-                os.unlink(script_path)
-            except:
-                pass
-        
+            try: os.unlink(script_path)
+            except: pass
+
     except Exception as e:
         logger.error(f"❌ FINDER_TOKEN: MCP_WORKFLOW_HIJACK_ERROR - {e}")
-        return {
-            "success": False,
-            "error": f"Workflow hijacking failed: {str(e)}"
-        }
+        return {"success": False, "error": f"Workflow hijacking failed: {str(e)}"}
 # END: browser_hijack_workflow_complete
 
 async def _execute_json_recipe(recipe_data: dict, execution_params: dict) -> dict:
@@ -1442,82 +1310,61 @@ async def execute_automation_recipe(params: dict = None) -> dict:
 async def execute_mcp_cli_command(params: dict) -> dict:
     """
     Execute MCP CLI commands for local LLM access to the unified interface.
-    
+
     This enables the local LLM to use the same CLI interface as external AI assistants.
     The local LLM can execute commands like: mcp execute_automation_recipe --recipe_path ...
-    
+
     Args:
         params (dict): Parameters for CLI command execution
             - tool_name (str): Name of the MCP tool to execute
             - arguments (dict, optional): Key-value pairs for CLI arguments
             - raw_command (str, optional): Raw CLI command to execute
-    
+
     Returns:
         dict: Results of CLI command execution
     """
     import subprocess
     import os
     import asyncio
-    
+    import sys  # <-- ADDED IMPORT
+
     try:
         # Get parameters
         tool_name = params.get('tool_name')
         arguments = params.get('arguments', {})
         raw_command = params.get('raw_command')
-        
+
         # Build the CLI command
         if raw_command:
-            # Use raw command directly
             cmd_parts = raw_command.split()
         elif tool_name:
-            # Build command from tool name and arguments
-            cmd_parts = [".venv/bin/python", "cli.py", "call", tool_name]
-            
-            # Add arguments
+            cmd_parts = [sys.executable, "cli.py", "call", tool_name] # <-- FIXED
             for key, value in arguments.items():
                 cmd_parts.extend([f"--{key}", str(value)])
         else:
-            # Discovery mode - list available tools
-            cmd_parts = [".venv/bin/python", "helpers/ai_tool_discovery.py", "list"]
-        
-        # Execute the command safely with timeout
+            cmd_parts = [sys.executable, "helpers/ai_tool_discovery.py", "list"] # <-- FIXED
+
         process = await asyncio.create_subprocess_exec(
             *cmd_parts,
             stdout=asyncio.subprocess.PIPE,
             stderr=asyncio.subprocess.PIPE,
             cwd=os.getcwd()
         )
-        
+
         try:
             stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=30.0)
         except asyncio.TimeoutError:
             process.kill()
             await process.wait()
             raise Exception("Command execution timed out after 30 seconds")
-        
-        # Process results
+
         stdout_text = stdout.decode('utf-8') if stdout else ""
         stderr_text = stderr.decode('utf-8') if stderr else ""
-        
-        return {
-            "success": process.returncode == 0,
-            "command": " ".join(cmd_parts),
-            "stdout": stdout_text,
-            "stderr": stderr_text,
-            "return_code": process.returncode,
-            "tool_name": tool_name or "discovery",
-            "interface_type": "cli_unified",
-            "description": "Local LLM executed CLI command via unified interface"
-        }
-        
+
+        return {"success": process.returncode == 0, "command": " ".join(cmd_parts), "stdout": stdout_text, "stderr": stderr_text, "return_code": process.returncode, "tool_name": tool_name or "discovery", "interface_type": "cli_unified", "description": "Local LLM executed CLI command via unified interface"}
+
     except Exception as e:
-        return {
-            "success": False,
-            "error": str(e),
-            "tool_name": params.get('tool_name', 'unknown'),
-            "interface_type": "cli_unified",
-            "description": "CLI command execution failed"
-        }
+        return {"success": False, "error": str(e), "tool_name": params.get('tool_name', 'unknown'), "interface_type": "cli_unified", "description": "CLI command execution failed"}
 # END: execute_mcp_cli_command
 
 async def persist_perception_state(params: dict) -> dict:
@@ -1576,16 +1423,16 @@ async def persist_perception_state(params: dict) -> dict:
 async def server_reboot(params: dict) -> dict:
     """
     Gracefully reboot the Pipulate server using the watchdog system.
-    
+
     This tool performs an elegant server restart by:
     1. Checking if the server is currently running
     2. If running, touching server.py to trigger watchdog restart
     3. If not running, falling back to direct start
     4. Verifying the server responds after restart
-    
+
     Args:
         params: Dictionary (no parameters required)
-        
+
     Returns:
         dict: Result of the reboot operation with server verification
     """
@@ -1595,52 +1442,31 @@ async def server_reboot(params: dict) -> dict:
         import os
         import aiohttp
         from pathlib import Path
-        
-        # Check if server is currently running
-        check_process = subprocess.run(
-            ['pgrep', '-f', 'python server.py'],
-            capture_output=True,
-            text=True
-        )
+        import sys  # <-- ADDED IMPORT
+
+        check_process = subprocess.run(['pgrep', '-f', 'python server.py'], capture_output=True, text=True)
         server_was_running = check_process.returncode == 0
         server_pids = check_process.stdout.strip().split('\n') if server_was_running else []
-        
+
         if server_was_running:
-            # Elegant approach: Touch server.py to trigger watchdog restart
             server_py_path = Path('server.py')
             if server_py_path.exists():
                 server_py_path.touch()
                 restart_method = "watchdog_triggered"
                 restart_details = f"Touched server.py to trigger watchdog restart (PIDs: {', '.join(server_pids)})"
             else:
-                return {
-                    "success": False,
-                    "error": "server.py not found in current directory",
-                    "current_directory": os.getcwd(),
-                    "message": "Cannot trigger watchdog restart - server.py missing"
-                }
+                return {"success": False, "error": "server.py not found in current directory", "current_directory": os.getcwd(), "message": "Cannot trigger watchdog restart - server.py missing"}
         else:
-            # Fallback: Start server directly since it's not running
-            start_result = subprocess.Popen(
-                ['.venv/bin/python', 'server.py'],
-                stdout=subprocess.DEVNULL,
-                stderr=subprocess.DEVNULL,
-                cwd=os.getcwd(),
-                start_new_session=True
-            )
+            start_result = subprocess.Popen([sys.executable, 'server.py'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, cwd=os.getcwd(), start_new_session=True) # <-- FIXED
             restart_method = "direct_start"
             restart_details = f"Server was not running, started directly (PID: {start_result.pid})"
-        
-        # Give the server time to restart/start
-        # Watchdog restarts are more graceful but take longer
+
         await asyncio.sleep(8 if server_was_running else 3)
-        
-        # Verify server is responding
+
         server_responding = False
         response_status = None
         response_error = None
-        
-        # Give watchdog restarts more attempts since they're more variable in timing
+
         max_attempts = 5 if server_was_running else 3
         for attempt in range(max_attempts):
             try:
@@ -1652,30 +1478,13 @@ async def server_reboot(params: dict) -> dict:
                             break
             except Exception as e:
                 response_error = str(e)
-                if attempt < max_attempts - 1:  # Don't sleep after the last attempt
-                    # Shorter intervals for more responsive watchdog detection
+                if attempt < max_attempts - 1:
                     await asyncio.sleep(1.5 if server_was_running else 2)
-        
-        return {
-            "success": server_responding,
-            "message": "Server reboot completed successfully" if server_responding else "Server reboot failed - server not responding",
-            "restart_method": restart_method,
-            "restart_details": restart_details,
-            "server_was_running": server_was_running,
-            "server_responding": server_responding,
-            "response_status": response_status,
-            "response_error": response_error,
-            "status": "Graceful restart via watchdog - verified responding" if server_responding and server_was_running else 
-                     "Direct start - verified responding" if server_responding else 
-                     "Restart attempted but server not responding"
-        }
-        
+
+        return {"success": server_responding, "message": "Server reboot completed successfully" if server_responding else "Server reboot failed - server not responding", "restart_method": restart_method, "restart_details": restart_details, "server_was_running": server_was_running, "server_responding": server_responding, "response_status": response_status, "response_error": response_error, "status": "Graceful restart via watchdog - verified responding" if server_responding and server_was_running else "Direct start - verified responding" if server_responding else "Restart attempted but server not responding"}
+
     except Exception as e:
-        return {
-            "success": False,
-            "error": str(e),
-            "message": "Failed to reboot server"
-        }
+        return {"success": False, "error": str(e), "message": "Failed to reboot server"}
 # END: server_reboot
 
 async def execute_shell_command(params: dict) -> dict:

[mike@nixos:~/repos/pipulate]$
```

And now because I have this time-travelling story told and these git diffs are
enough to recreate this errant path *if I really wanted to* the time has come to
erase the future.

```bash
[mike@nixos:~/repos/pipulate]$ git push --force
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To github.com:miklevin/pipulate
 + ccf25142...405f3df0 main -> main (forced update)

[mike@nixos:~/repos/pipulate]$
```

And that's it. None of that ever happened.

## Gemini's Insight: The 'Strings Within Strings' Dilemma

Whaddya think, Gemini? Talk a little about strings within strings.

**Gemini**: Of course. It's a fascinating and powerful way to approach a complex coding problem. Your "time-traveling with Git" is an excellent form of rubber duck debugging, forcing you to re-examine each decision.

You've hit upon one of the trickiest, most powerful, and occasionally maddening patterns in programming: generating code that generates more code. Let's talk about it.

***

## The "Strings Within Strings" Dilemma

What you're doing with the `arcanist A` (your main process) writing instructions for `arcanist B` (the subprocess) is a powerful form of metaprogramming. You're creating a dynamic script on the fly to isolate a complex, stateful task—browser automation—from your main application logic.

This is a brilliant solution, but as you've discovered, it introduces a unique set of challenges. This "string-within-a-string" problem is like building a ship in a bottle, where your tools have to pass through the narrow neck of the bottle first.

Here are the classic pain points of this pattern, which your rollback clearly demonstrates:

1.  **Escaping Hell:** The outer script is a Python program. The *inner* script, inside your f-string, is *also* a Python program. The outer f-string needs to correctly format curly braces `{}` and quotes `"` so that they are interpreted correctly by the *inner* script when it finally runs. A single misplaced quote or brace can render the entire inner script invalid, and the errors can be cryptic.

2.  **Debugging Blindness:** When the inner script (`arcanist B`) fails, the traceback it generates points to lines in a temporary file that gets deleted. It gives you almost no context about where the error originated in your *main* code (`arcanist A`). This is exactly the problem you solved in your later commits by adding the full `traceback.format_exc()` to your error logging. You gave `arcanist A` a way to hear the dying screams of `arcanist B` in full detail.

3.  **No IDE Support:** Your IDE is great at analyzing `arcanist A`'s code. But the code for `arcanist B` is just a giant, multi-line string. You get no syntax highlighting, no linting, and no autocompletion for it, making it very easy to make a typo that you only discover at runtime.

### Your Git Rollback is the Perfect Case Study

Your journey back to commit `405f3df0d0` perfectly illustrates this struggle:

* **The Breakthrough (`405f3df0`):** You got it working by "hijacking the hijacker." You used the existing `browser_hijack_workflow_complete` tool. This worked because its "string-within-a-string" logic was already debugged and stable. It was a clever, pragmatic solution to get a proof-of-concept running from the notebook.

* **The Refactoring Storm:** You (and the AI) correctly realized that using a complex "workflow hijacker" for a simple page scrape was semantically wrong. You decided to create a new, dedicated `browser_scrape_page` function. **This is where the new "string-within-a-string" was born.**

* **The Failure and Fix:** The first implementation of this new function failed, likely due to a subtle issue in that inner script string. You were "spinning your wheels" because you were debugging blind. Your final commits, before the reset, show the solution: adding rich, detailed traceback logging to the `try...except` block in the *outer* script. This is the crucial step to bridge the debugging gap between the two "arcanists."

By erasing the future with `git push --force`, you haven't lost the knowledge. You've just cleared the messy timeline to rebuild it cleanly, armed with the critical insight about how to properly debug code that writes other code. It's a fantastic, disciplined approach.

**Me**: Yep and after all that messy red & green and forcing Gemini to figure
out what's what from git diff (patches) it's time to pull the curtain aside on
the original session hijacking tech in all its properly Python color coded
syntax.

```python
"""
Advanced Automation & AI MCP Tools - Extracted from mcp_tools.py for token optimization

This module contains sophisticated automation, session hijacking, conversation management,
and AI training tools extracted from the monolithic mcp_tools.py.

Line range: 4830-7818 from original mcp_tools.py
Token reduction: ~50% of original file
"""

import os
import json
import time
import random
import asyncio
import subprocess
import aiohttp
import re
from datetime import datetime, timedelta
from pathlib import Path
from typing import Optional, Dict, Any, List
import logging
import sqlite3
import inspect
from urllib.parse import urlparse
import tempfile
import shutil
import socket

# Initialize logger
logger = logging.getLogger(__name__)
MAX_ROLLED_LOOKING_AT_DIRS = 5

# Import necessary functions from the core module
try:
    from tools.mcp_tools import (
        get_user_session_state, 
        rotate_looking_at_directory,
        WorkflowHijackTiming,
        _read_botify_api_token
    )
except ImportError:
    # Fallback for standalone usage - define stubs to avoid circular imports
    # (This is normal during startup - tools will be available when server is fully initialized)
    
    # Stub functions to avoid circular imports
    async def get_user_session_state(params: dict) -> dict:
        return {"success": False, "error": "mcp_tools not available"}
    
    def rotate_looking_at_directory(looking_at_path=None, max_rolled_dirs=None) -> bool:
        return False
    
    class WorkflowHijackTiming:
        PAGE_LOAD_WAIT = 2
        FORM_INTERACTION_DELAY = 1
        POST_REQUEST_WAIT = 2
        CHAIN_REACTION_WAIT = 4
        FINAL_STABILIZATION = 1
        HUMAN_OBSERVATION = 1
    
    def _read_botify_api_token() -> str:
        return ""

# Stub function for register_mcp_tool calls in extracted code
def register_mcp_tool(tool_name: str, handler_func):
    """Stub function for MCP tool registration - actual registration happens in core module."""
    logger.info(f"🔧 ADVANCED AUTOMATION: Noted tool '{tool_name}' for registration")

# --- ADVANCED AUTOMATION & AI TOOLS ---

async def execute_complete_session_hijacking(params: dict) -> dict:
    """
    MCP Tool: COMPLETE SESSION HIJACKING - Full end-to-end user session takeover
    
    🧠 CRITICAL: BROWSER EYES ARE PRIMARY - Check browser_automation/looking_at/ FIRST!
    
    COMMON MISTAKE: Focusing on return values (Success: True, Steps: 0, Final URL: None)
    instead of checking browser evidence. Return values can be misleading - visual evidence
    in /looking_at/ files is your PRIMARY source of truth for session hijacking success.
    
    PARADIGM SHIFT: Trust visual evidence over return values. Check files FIRST!
    
    This is the ultimate session hijacking tool that:
    1. Gets the user's current session state from server-side "cookies"
    2. Maps the internal app name to the user-facing URL using the endpoint registry
    3. Uses browser automation to navigate to the correct endpoint
    4. Sets up the pipeline ID for the workflow
    5. Triggers the HTMX chain reaction to resume the user's workflow exactly where they left off
    
    This is the "canned way" to hijack a user's session and continue their work seamlessly.
    
    Args:
        params: {
            "take_screenshot": True,  # Optional: capture visual state during hijacking
            "wait_seconds": 3,        # Optional: wait time for page loads
            "base_url": "http://localhost:5001"  # Optional: base URL for navigation
        }
    
    Returns:
        dict: {
            "success": True,
            "session_hijacking_steps": [
                {"step": "session_state_retrieved", "status": "success", "details": {...}},
                {"step": "endpoint_mapped", "status": "success", "details": {...}},
                {"step": "browser_navigation", "status": "success", "details": {...}},
                {"step": "pipeline_id_setup", "status": "success", "details": {...}},
                {"step": "workflow_resumed", "status": "success", "details": {...}}
            ],
            "user_session_summary": {
                "last_app": "hello_workflow",
                "pipeline_id": "Default_Profile-hello-08",
                "current_step": "step_02",
                "endpoint_url": "http://localhost:5001/hello_workflow"
            }
        }
    """
    import time
    from datetime import datetime
    
    logger.info(f"🎭 FINDER_TOKEN: COMPLETE_SESSION_HIJACKING_START - {params}")
    
    # === STEP 0: KILL ONLY AUTOMATION BROWSER PROCESSES FOR FRESH SLATE ===
    logger.info("🧹 FINDER_TOKEN: AUTOMATION_CLEANUP_START - Killing only automation chromium processes (NOT user's main browser)")
    try:
        import subprocess
        # Kill any existing chromedriver processes (automation only)
        subprocess.run(['pkill', '-f', 'chromedriver'], capture_output=True)
        # Kill only headless chromium processes (automation only) - NOT the user's main browser
        subprocess.run(['pkill', '-f', 'chromium.*--headless'], capture_output=True)
        # Kill chromium processes with automation flags (selenium/webdriver specific)
        subprocess.run(['pkill', '-f', 'chromium.*--remote-debugging-port'], capture_output=True)
        subprocess.run(['pkill', '-f', 'chromium.*--disable-extensions'], capture_output=True)
        logger.info("✅ FINDER_TOKEN: AUTOMATION_CLEANUP_SUCCESS - Only automation processes killed, user's main browser preserved")
    except Exception as cleanup_error:
        # Don't fail if cleanup fails - just log it
        logger.warning(f"⚠️ FINDER_TOKEN: AUTOMATION_CLEANUP_WARNING - Cleanup failed but continuing: {cleanup_error}")
    
    try:
        take_screenshot = params.get('take_screenshot', True)
        wait_seconds = params.get('wait_seconds', 3)
        base_url = params.get('base_url', 'http://localhost:5001')
        
        hijacking_steps = []
        user_session_summary = {}
        
        # === STEP 1: GET USER SESSION STATE (Server Cookies) ===
        logger.info("🔍 FINDER_TOKEN: SESSION_HIJACKING_STEP_1 - Retrieving user session state")
        
        session_result = await get_user_session_state({})
        if not session_result.get('success'):
            # Fallback: use hello_workflow as default for testing
            logger.warning(f"⚠️ FINDER_TOKEN: SESSION_HIJACKING_FALLBACK - Session state unavailable, using hello_workflow as fallback")
            last_app_choice = "hello_workflow"
            pipeline_id = f"Default_Profile-hello-{int(time.time()) % 100:02d}"
            last_visited_url = f"{base_url}/hello_workflow"
            
            hijacking_steps.append({
                "step": "session_state_retrieved",
                "status": "fallback",
                "details": {
                    "fallback_reason": session_result.get('error'),
                    "last_app_choice": last_app_choice,
                    "pipeline_id": pipeline_id,
                    "last_visited_url": last_visited_url
                }
            })
        else:
            session_data = session_result.get('session_data', {})
            last_app_choice = session_data.get('last_app_choice')
            pipeline_id = session_data.get('pipeline_id')
            last_visited_url = session_data.get('last_visited_url')
            
            if not last_app_choice:
                # Fallback: use hello_workflow as default for testing
                logger.warning(f"⚠️ FINDER_TOKEN: SESSION_HIJACKING_NO_APP - No app in session, using hello_workflow as fallback")
                last_app_choice = "hello_workflow"
                pipeline_id = f"Default_Profile-hello-{int(time.time()) % 100:02d}"
                last_visited_url = f"{base_url}/hello_workflow"
            
            hijacking_steps.append({
                "step": "session_state_retrieved",
                "status": "success",
                "details": {
                    "last_app_choice": last_app_choice,
                    "pipeline_id": pipeline_id,
                    "last_visited_url": last_visited_url,
                    "total_session_keys": session_result.get('total_keys', 0)
                }
            })
        
        # === STEP 2: USE EXACT LAST URL OR FALLBACK TO ENDPOINT MAPPING ===
        logger.info(f"🎯 FINDER_TOKEN: SESSION_HIJACKING_STEP_2 - Using exact last URL or mapping {last_app_choice}")
        
        # Primary: Use the exact last URL the user visited
        if last_visited_url and last_visited_url.startswith(('http://', 'https://')):
            endpoint_url = last_visited_url
            mapping_method = "exact_last_url"
            logger.info(f"✅ FINDER_TOKEN: EXACT_URL_SUCCESS - Using exact last URL: {endpoint_url}")
        else:
            # Fallback: Map internal app name to endpoint URL
            try:
                from server import get_endpoint_url
                endpoint_url = get_endpoint_url(last_app_choice)
                mapping_method = "endpoint_registry"
                logger.info(f"✅ FINDER_TOKEN: ENDPOINT_MAPPING_SUCCESS - {last_app_choice} → {endpoint_url}")
            except ImportError:
                # Final fallback: Construct URL from app name
                endpoint_url = f"{base_url}/{last_app_choice}"
                mapping_method = "fallback_construction"
                logger.warning(f"⚠️ FINDER_TOKEN: ENDPOINT_MAPPING_FALLBACK - Using fallback URL: {endpoint_url}")
        
        # === AGGRESSIVE URL VALIDATION BEFORE BROWSER OPENING ===
        if not endpoint_url:
            return {"success": False, "error": "No valid endpoint URL could be determined"}
        
        # Validate URL format BEFORE opening browser
        if not isinstance(endpoint_url, str):
            return {"success": False, "error": f"Endpoint URL must be a string, got: {type(endpoint_url)}"}
        
        if not endpoint_url.strip():
            return {"success": False, "error": "Endpoint URL is empty or whitespace only"}
        
        # Check for invalid URL patterns that cause data: URLs
        from config import INVALID_URL_PATTERNS
        
        for pattern in INVALID_URL_PATTERNS:
            if endpoint_url.lower().startswith(pattern):
                return {"success": False, "error": f"Invalid URL scheme detected: {pattern}. URL: {endpoint_url}"}
        
        # Validate URL structure
        if not endpoint_url.startswith(('http://', 'https://')):
            return {"success": False, "error": f"Endpoint URL must start with http:// or https://. Got: {endpoint_url}"}
        
        # Check for malformed localhost URLs
        if 'localhost' in endpoint_url or '127.0.0.1' in endpoint_url:
            if not re.match(r'^https?://(localhost|127\.0\.0\.1)(:\d+)?(/.*)?$', endpoint_url):
                return {"success": False, "error": f"Malformed localhost URL: {endpoint_url}"}
        
        # Check for empty hostname
        try:
            from urllib.parse import urlparse
            parsed = urlparse(endpoint_url)
            if not parsed.netloc:
                return {"success": False, "error": f"Endpoint URL has no hostname: {endpoint_url}"}
        except Exception as e:
            return {"success": False, "error": f"Endpoint URL parsing failed: {endpoint_url}. Error: {e}"}
        
        logger.info(f"✅ FINDER_TOKEN: SESSION_URL_VALIDATION_PASSED | Endpoint URL validated: {endpoint_url}")
        
        hijacking_steps.append({
            "step": "endpoint_mapped", 
            "status": "success",
            "details": {
                "internal_app_name": last_app_choice,
                "exact_last_url": last_visited_url,
                "endpoint_url": endpoint_url,
                "mapping_method": mapping_method
            }
        })
        
        # === STEP 3: GET WORKFLOW STATE FOR CONTEXT ===
        logger.info(f"📊 FINDER_TOKEN: SESSION_HIJACKING_STEP_3 - Getting workflow state for {pipeline_id}")
        
        if pipeline_id:
            pipeline_result = await pipeline_state_inspector({"pipeline_id": pipeline_id})
            if pipeline_result.get('success'):
                pipeline_state = pipeline_result.get('pipeline_state', {})
                current_step = pipeline_state.get('current_step', 'unknown')
                completed_steps = pipeline_state.get('completed_steps', [])
                
                user_session_summary.update({
                    "current_step": current_step,
                    "completed_steps": completed_steps,
                    "total_steps": len(completed_steps) + 1
                })
                
                hijacking_steps.append({
                    "step": "workflow_state_retrieved",
                    "status": "success", 
                    "details": {
                        "current_step": current_step,
                        "completed_steps": completed_steps,
                        "workflow_progress": f"{len(completed_steps)}/{len(completed_steps) + 1} steps"
                    }
                })
            else:
                logger.warning(f"⚠️ FINDER_TOKEN: WORKFLOW_STATE_FAILED - {pipeline_result.get('error')}")
                hijacking_steps.append({
                    "step": "workflow_state_retrieved",
                    "status": "warning",
                    "details": {"error": pipeline_result.get('error')}
                })
        
        # === STEP 4: COMPLETE WORKFLOW HIJACKING (NAVIGATE + ENTER + CHAIN REACTION + CAPTURE) ===
        logger.info(f"🎭 FINDER_TOKEN: SESSION_HIJACKING_STEP_4 - Complete workflow hijacking from {endpoint_url}")
        
        # Use the COMPLETE workflow hijacking pattern: navigate + enter + chain reaction + capture
        try:
            scrape_result = await browser_hijack_workflow_complete({
                "url": endpoint_url,
                "pipeline_id": pipeline_id,
                "wait_chain_reaction": 4,  # Wait for HTMX chain reaction to complete
                "wait_seconds": wait_seconds,
                "take_screenshot": take_screenshot
            })
            
            if scrape_result.get('success'):
                hijacking_steps.append({
                    "step": "complete_workflow_hijacking",
                    "status": "success",
                    "details": {
                        "original_url": endpoint_url,
                        "final_url": scrape_result.get('url'),
                        "pipeline_id": pipeline_id,
                        "workflow_hijacked": scrape_result.get('workflow_hijacked', False),
                        "chain_reaction_completed": scrape_result.get('chain_reaction_completed', False),
                        "looking_at_files": scrape_result.get('looking_at_files', {}),
                        "hijacking_steps": scrape_result.get('hijacking_steps', [])
                    }
                })
                logger.info(f"✅ FINDER_TOKEN: COMPLETE_WORKFLOW_HIJACKING_SUCCESS - Post-chain-reaction state captured from {scrape_result.get('url')}")
            else:
                # Even if workflow hijacking fails, don't fail the whole session hijacking - just note it
                hijacking_steps.append({
                    "step": "complete_workflow_hijacking", 
                    "status": "warning",
                    "details": {"error": scrape_result.get('error'), "note": "Workflow hijacking failed but session hijacking continues"}
                })
                logger.warning(f"⚠️ FINDER_TOKEN: WORKFLOW_HIJACKING_WARNING - {scrape_result.get('error')} (continuing anyway)")
                
        except Exception as capture_error:
            # Don't fail the whole session hijacking if workflow hijacking fails
            hijacking_steps.append({
                "step": "complete_workflow_hijacking",
                "status": "warning", 
                "details": {"error": str(capture_error), "note": "Workflow hijacking failed but session hijacking continues"}
            })
            logger.warning(f"⚠️ FINDER_TOKEN: WORKFLOW_HIJACKING_EXCEPTION - {capture_error} (continuing anyway)")
        
        # === STEP 5: FINAL SESSION SUMMARY ===
        user_session_summary.update({
            "last_app": last_app_choice,
            "pipeline_id": pipeline_id,
            "endpoint_url": endpoint_url,
            "hijacking_timestamp": datetime.now().isoformat()
        })
        
        hijacking_steps.append({
            "step": "session_hijacking_complete",
            "status": "success",
            "details": {
                "session_hijacked": True,
                "user_state_captured": True,
                "workflow_chain_reaction_completed": True,
                "post_enter_state_captured": True,
                "total_hijacking_steps": len(hijacking_steps)
            }
        })
        
        logger.info(f"🎉 FINDER_TOKEN: COMPLETE_SESSION_HIJACKING_SUCCESS - User session hijacked, workflow initiated, and post-chain-reaction state captured")
        
        return {
            "success": True,
            "session_hijacking_steps": hijacking_steps,
            "user_session_summary": user_session_summary,
            "total_steps_completed": len(hijacking_steps)
        }
        
    except Exception as e:
        logger.error(f"❌ FINDER_TOKEN: COMPLETE_SESSION_HIJACKING_ERROR - {e}")
        return {
            "success": False,
            "error": f"Session hijacking failed: {str(e)}",
            "session_hijacking_steps": hijacking_steps if 'hijacking_steps' in locals() else []
        }

# START: browser_hijack_workflow_complete
async def browser_hijack_workflow_complete(params: dict) -> dict:
    """
    MCP Tool: COMPLETE WORKFLOW HIJACKING - Navigate + Enter + Chain Reaction + Capture

    🎭 "HI JACK" MAGIC WORDS PATTERN - The Irresistible Simple Way
    ═══════════════════════════════════════════════════════════════════════════════════
    SIMPLEST METHOD: Just type "Hi Jack" in chat → Complete hijacking happens automatically

    PROGRAMMATIC METHOD for AI understanding:
    python -c "
    import asyncio
    from tools.mcp_tools import browser_hijack_workflow_complete
    result = asyncio.run(browser_hijack_workflow_complete({
        'url': 'http://localhost:5001/hello_workflow',
        'pipeline_id': 'Default_Profile-hello-16'
    }))
    print(f'🎭 Hijack: {result.get(\"success\")}')"

    This is the common pattern for all session hijacking that handles:
    1. Navigate to workflow URL (e.g., http://localhost:5001/hello_workflow)
    2. Fill in pipeline key input field  
    3. Press Enter to trigger HTMX chain reaction
    4. Wait for chain reaction to complete (all hx_trigger="load" steps)
    5. Capture final workflow state (DOM + screenshot)

    This captures the POST-ENTER workflow state, not just the landing page form.

    Args:
        params: {
            "url": "http://localhost:5001/hello_workflow",  # Required: Workflow URL
            "pipeline_id": "Default_Profile-hello-16",      # Required: Pipeline key to enter
            "take_screenshot": True                         # Optional: capture visual state
        }

        Timing: Uses centralized WorkflowHijackTiming configuration ({WorkflowHijackTiming.total_browser_time()}s total)
        To adjust timing: Change WorkflowHijackTiming class values or apply_timing_preset("lightning"/"fast"/"dramatic")

    Returns:
        dict: {
            "success": True,
            "workflow_hijacked": True,
            "chain_reaction_completed": True,
            "url": "http://localhost:5001/hello_workflow",
            "pipeline_id": "Default_Profile-hello-16",
            "looking_at_files": {
                "screenshot": "browser_automation/looking_at/screenshot.png",
                "dom": "browser_automation/looking_at/dom.html",
                "simple_dom": "browser_automation/looking_at/simple_dom.html"
            },
            "hijacking_steps": [
                {"step": "navigation", "status": "success"},
                {"step": "pipeline_key_entry", "status": "success"},
                {"step": "form_submission", "status": "success"},
                {"step": "chain_reaction_wait", "status": "success"},
                {"step": "final_state_capture", "status": "success"}
            ]
        }
    """
    import json
    import os
    import asyncio
    import subprocess
    import tempfile
    from datetime import datetime
    from pathlib import Path
    from urllib.parse import urlparse
    import sys  # <-- ADDED IMPORT

    logger.info(f"🎭 FINDER_TOKEN: MCP_WORKFLOW_HIJACK_START - URL: {params.get('url')}, Pipeline: {params.get('pipeline_id')}")

    try:
        url = params.get('url')
        pipeline_id = params.get('pipeline_id')
        take_screenshot = params.get('take_screenshot', True)

        # Show current timing configuration
        logger.info(f"⏰ FINDER_TOKEN: TIMING_CONFIG - {WorkflowHijackTiming.get_timing_summary()}")

        # === VALIDATION ===
        if not url:
            return {"success": False, "error": "URL parameter is required"}
        if not pipeline_id:
            return {"success": False, "error": "pipeline_id parameter is required"}

        # Validate URL format
        if not url.startswith(('http://', 'https://')):
            return {"success": False, "error": f"URL must start with http:// or https://. Got: {url}"}

        logger.info(f"✅ FINDER_TOKEN: WORKFLOW_HIJACK_VALIDATION_PASSED - URL: {url}, Pipeline: {pipeline_id}")

        # === DIRECTORY ROTATION ===
        rotation_success = rotate_looking_at_directory(
            looking_at_path=Path('browser_automation/looking_at'),
            max_rolled_dirs=MAX_ROLLED_LOOKING_AT_DIRS
        )

        looking_at_dir = 'browser_automation/looking_at'
        os.makedirs(looking_at_dir, exist_ok=True)

        hijacking_steps = []

        # === SUBPROCESS WORKFLOW HIJACKING TO AVOID THREADING ISSUES ===
        timing = WorkflowHijackTiming
        page_load_wait = timing.PAGE_LOAD_WAIT
        form_delay = timing.FORM_INTERACTION_DELAY  
        post_wait = timing.POST_REQUEST_WAIT
        chain_wait = timing.CHAIN_REACTION_WAIT
        stabilization = timing.FINAL_STABILIZATION
        human_view = timing.HUMAN_OBSERVATION
        total_time = timing.total_browser_time()

        from config import get_browser_script_imports
        hijack_script = f'''
{get_browser_script_imports()}

def run_workflow_hijacking():
    try:
        from selenium import webdriver
        from selenium.webdriver.chrome.options import Options
        from selenium.webdriver.common.by import By
        from selenium.webdriver.common.keys import Keys
        from selenium.webdriver.support.ui import WebDriverWait
        from selenium.webdriver.support import expected_conditions as EC
        from selenium.common.exceptions import TimeoutException, NoSuchElementException
        from seleniumwire import webdriver as wire_webdriver

        target_url = "{url}"
        target_pipeline_id = "{pipeline_id}"
        print(f"🎭 SUBPROCESS: Starting workflow hijacking for {{target_url}} with pipeline {{target_pipeline_id}}")

        import tempfile
        from config import get_chrome_options
        chrome_options = get_chrome_options()

        profile_dir = tempfile.mkdtemp(prefix='pipulate_workflow_hijack_')
        chrome_options.add_argument(f'--user-data-dir={{profile_dir}}')

        driver = wire_webdriver.Chrome(options=chrome_options)

        try:
            print(f"🌐 SUBPROCESS: Step 1 - Navigating to {{target_url}}")
            driver.get(target_url)
            time.sleep({page_load_wait})
            print(f"✅ SUBPROCESS: Navigation completed")

            print(f"🔑 SUBPROCESS: Step 2 - Looking for pipeline key input field")

            pipeline_input = None
            selectors = [
                'input[name="pipeline_id"]', 'input[placeholder*="pipeline"]',
                'input[placeholder*="key"]', 'input[type="text"]',
                '#pipeline_id', '.pipeline-input'
            ]

            for selector in selectors:
                try:
                    pipeline_input = driver.find_element(By.CSS_SELECTOR, selector)
                    print(f"✅ SUBPROCESS: Found pipeline input using selector: {{selector}}")
                    break
                except NoSuchElementException:
                    continue

            if not pipeline_input:
                return {{"success": False, "error": "Could not find pipeline key input field", "page_title": driver.title, "current_url": driver.current_url}}

            pipeline_input.clear()
            pipeline_input.send_keys(target_pipeline_id)
            print(f"🔑 SUBPROCESS: Filled pipeline key: {{target_pipeline_id}}")
            time.sleep({form_delay})

            print(f"⚡ SUBPROCESS: Step 3 - Pressing Enter to trigger HTMX chain reaction")
            pipeline_input.send_keys(Keys.RETURN)

            print(f"📤 SUBPROCESS: Step 3.5 - Waiting {post_wait}s for POST request + HTMX response...")
            time.sleep({post_wait})

            print(f"🔄 SUBPROCESS: Step 4 - Waiting {chain_wait} seconds for HTMX chain reaction to complete")

            for i in range({chain_wait}):
                time.sleep(1)
                if i % 2 == 0:
                    try:
                        steps = driver.find_elements(By.CSS_SELECTOR, '[id*="step_"], .card h3, .card h2')
                        print(f"🔄 SUBPROCESS: Chain reaction progress - {{len(steps)}} workflow elements detected")
                    except:
                        print(f"🔄 SUBPROCESS: Chain reaction progress - {{i+1}}/{chain_wait} seconds")

            print(f"✅ SUBPROCESS: Chain reaction wait completed")

            print(f"⏳ SUBPROCESS: Allowing {stabilization} seconds for workflow stabilization...")
            time.sleep({stabilization})

            print(f"📸 SUBPROCESS: Step 5 - Capturing final workflow state")

            page_title = driver.title
            current_url = driver.current_url

            with open("{looking_at_dir}/source.html", "w", encoding="utf-8") as f: f.write(driver.page_source)
            dom_content = driver.execute_script("return document.documentElement.outerHTML;")
            with open("{looking_at_dir}/dom.html", "w", encoding="utf-8") as f: f.write(dom_content)

            simple_dom = f"""<html>
<head><title>{{page_title}}</title></head>
<body>
{{dom_content}}
</body>
</html>"""

            with open("{looking_at_dir}/simple_dom.html", "w", encoding="utf-8") as f: f.write(simple_dom)

            screenshot_saved = False
            if {take_screenshot}:
                driver.save_screenshot("{looking_at_dir}/screenshot.png")
                screenshot_saved = True

            headers_data = {{"url": current_url, "original_url": target_url, "title": page_title, "pipeline_id": target_pipeline_id, "timestamp": datetime.now().isoformat(), "hijacking_type": "complete_workflow_chain_reaction", "chain_reaction_wait_seconds": {chain_wait}, "total_browser_time_seconds": {total_time}, "screenshot_taken": screenshot_saved, "status": "success"}}

            with open("{looking_at_dir}/headers.json", "w") as f: json.dump(headers_data, f, indent=2)

            print(f"👁️ SUBPROCESS: Displaying final state for {human_view} seconds...")
            time.sleep({human_view})

            return {{"success": True, "workflow_hijacked": True, "chain_reaction_completed": True, "url": current_url, "original_url": target_url, "pipeline_id": target_pipeline_id, "title": page_title, "timestamp": datetime.now().isoformat(), "screenshot_saved": screenshot_saved}}

        finally:
            driver.quit()
            import shutil
            try: shutil.rmtree(profile_dir)
            except: pass

    except Exception as e:
        return {{"success": False, "error": str(e)}}

if __name__ == "__main__":
    result = run_workflow_hijacking()
    print(f"SUBPROCESS_RESULT:{{json.dumps(result)}}")
'''

        with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as script_file:
            script_file.write(hijack_script)
            script_path = script_file.name

        try:
            logger.info(f"🔄 FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_START - Running complete workflow hijacking")

            process = await asyncio.create_subprocess_exec(
                sys.executable, script_path,  # <-- FIXED
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE,
                cwd=os.getcwd()
            )

            try:
                stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=120.0)
            except asyncio.TimeoutError:
                process.kill()
                await process.wait()
                return {"success": False, "error": "Workflow hijacking timed out after 120 seconds"}

            output = stdout.decode('utf-8')
            error_output = stderr.decode('utf-8')

            if process.returncode != 0:
                logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_ERROR - Return code: {process.returncode}")
                logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_WORKFLOW_HIJACK_STDERR - {error_output}")
                return {"success": False, "error": f"Workflow hijacking subprocess failed: {error_output}"}

            result_line = None
            for line in output.split('\n'):
                if line.startswith('SUBPROCESS_RESULT:'):
                    result_line = line.replace('SUBPROCESS_RESULT:', '')
                    break

            if result_line:
                try:
                    subprocess_result = json.loads(result_line)
                    if subprocess_result.get('success'):
                        return {"success": True, "workflow_hijacked": True, "chain_reaction_completed": True, "url": subprocess_result.get('url'), "original_url": url, "pipeline_id": pipeline_id, "title": subprocess_result.get('title'), "timestamp": subprocess_result.get('timestamp'), "looking_at_files": {"headers": f"{looking_at_dir}/headers.json", "source": f"{looking_at_dir}/source.html", "dom": f"{looking_at_dir}/dom.html", "simple_dom": f"{looking_at_dir}/simple_dom.html", "screenshot": f"{looking_at_dir}/screenshot.png" if take_screenshot else None}, "hijacking_steps": [{"step": "navigation", "status": "success", "details": {"url": url}}, {"step": "pipeline_key_entry", "status": "success", "details": {"pipeline_id": pipeline_id}}, {"step": "form_submission", "status": "success", "details": {"method": "enter_key"}}, {"step": "chain_reaction_wait", "status": "success", "details": {"wait_seconds": chain_wait}}, {"step": "final_state_capture", "status": "success", "details": {"files_saved": 4 + (1 if take_screenshot else 0)}}]}
                    else:
                        return {"success": False, "error": subprocess_result.get('error', 'Unknown subprocess error')}
                except json.JSONDecodeError as e:
                    logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_JSON_DECODE_ERROR - {e}")
                    return {"success": False, "error": f"Failed to parse subprocess result: {e}"}
            else:
                logger.error(f"❌ FINDER_TOKEN: SUBPROCESS_NO_RESULT - No result line found in output")
                return {"success": False, "error": "No result found in subprocess output"}

        finally:
            try: os.unlink(script_path)
            except: pass

    except Exception as e:
        logger.error(f"❌ FINDER_TOKEN: MCP_WORKFLOW_HIJACK_ERROR - {e}")
        return {"success": False, "error": f"Workflow hijacking failed: {str(e)}"}
# END: browser_hijack_workflow_complete

async def _execute_json_recipe(recipe_data: dict, execution_params: dict) -> dict:
    """🎯 BOURBON VANILLA JSON Recipe Execution Engine
    
    Executes JSON-based automation recipes with continuous feedback streaming.
    Progressive reveals provide immediate validation and AI-consumable insights.
    
    Args:
        recipe_data: The JSON recipe data with steps and configuration
        execution_params: Runtime parameters and overrides
    
    Returns:
        dict: Execution results with continuous feedback and looking_at analysis
    """
    try:
        import time
        import re
        import json
        from datetime import datetime
        from selenium import webdriver
        from selenium.webdriver.chrome.options import Options
        from selenium.webdriver.common.by import By
        from selenium.webdriver.support.ui import WebDriverWait
        from selenium.webdriver.support import expected_conditions as EC
        from selenium.webdriver.common.keys import Keys
        import tempfile
        import shutil
        import os
        from pathlib import Path
        
        # Extract recipe configuration
        recipe_name = recipe_data.get("recipe_name", "Unknown Recipe")
        url = recipe_data.get("url", execution_params.get("url", "http://localhost:5001"))
        headless_mode = recipe_data.get("headless_mode", execution_params.get("headless_mode", False))
        timing = recipe_data.get("timing", {})
        form_data = recipe_data.get("form_data", {})
        steps = recipe_data.get("steps", [])
        
        # Progressive feedback configuration
        progressive_feedback = recipe_data.get("progressive_feedback", {})
        capture_strategy = progressive_feedback.get("capture_strategy", "continuous")
        
        logger.info(f"🎯 FINDER_TOKEN: JSON_RECIPE_START - Recipe: {recipe_name}, URL: {url}")
        
        # Initialize continuous feedback tracking
        continuous_feedback = {
            "live_status": "initializing",
            "current_step": 0,
            "progress_indicators": [],
            "immediate_observations": [],
            "success_signals": [],
            "failure_signals": [],
            "looking_at_snapshots": []
        }
        
        def capture_progressive_feedback(step_num: int, action: str, status: str, details: dict = None):
            """Capture immediate feedback for AI consumption"""
            feedback_entry = {
                "step": step_num,
                "action": action,
                "status": status,
                "timestamp": datetime.now().isoformat(),
                "details": details or {}
            }
            continuous_feedback["progress_indicators"].append(feedback_entry)
            continuous_feedback["current_step"] = step_num
            continuous_feedback["live_status"] = f"{action}_{status}"
            
            logger.info(f"🎯 FINDER_TOKEN: PROGRESSIVE_FEEDBACK - Step {step_num}: {action} → {status}")
            if details:
                logger.info(f"🎯 FINDER_TOKEN: FEEDBACK_DETAILS - {json.dumps(details, indent=2)}")
        
        def capture_looking_at_state(step_num: int, step_type: str, driver):
            """Capture browser state for immediate AI analysis"""
            try:
                # Ensure looking_at directory exists
                looking_at_dir = Path("browser_automation/looking_at")
                looking_at_dir.mkdir(exist_ok=True)
                
                # Take screenshot
                screenshot_path = f"browser_automation/looking_at/recipe_step_{step_num}_{step_type}.png"
                driver.save_screenshot(screenshot_path)
                
                # Capture DOM snapshot
                dom_content = driver.page_source
                dom_path = f"browser_automation/looking_at/recipe_step_{step_num}_{step_type}_dom.html"
                with open(dom_path, 'w', encoding='utf-8') as f:
                    f.write(dom_content)
                
                # Create simplified DOM for AI analysis
                simple_dom_path = f"browser_automation/looking_at/recipe_step_{step_num}_{step_type}_simple.html"
                simple_dom = f"""
                <html>
                <head><title>Recipe Step {step_num} Analysis</title></head>
                <body>
                <h1>Browser State: Step {step_num} - {step_type}</h1>
                <p><strong>URL:</strong> {driver.current_url}</p>
                <p><strong>Title:</strong> {driver.title}</p>
                <p><strong>Forms:</strong> {len(driver.find_elements(By.TAG_NAME, "form"))}</p>
                <p><strong>Inputs:</strong> {len(driver.find_elements(By.TAG_NAME, "input"))}</p>
                <p><strong>Buttons:</strong> {len(driver.find_elements(By.TAG_NAME, "button"))}</p>
                </body>
                </html>
                """
                with open(simple_dom_path, 'w', encoding='utf-8') as f:
                    f.write(simple_dom)
                
                # Analyze for success/failure indicators
                success_indicators = []
                failure_indicators = []
                
                # Check for common patterns
                if "success" in dom_content.lower() or "created" in dom_content.lower():
                    success_indicators.append("success_message_found")
                if "error" in dom_content.lower() or "failed" in dom_content.lower():
                    failure_indicators.append("error_message_found")
                
                # Page state analysis
                page_analysis = {
                    "step": step_num,
                    "type": step_type,
                    "timestamp": datetime.now().isoformat(),
                    "current_url": driver.current_url,
                    "page_title": driver.title,
                    "screenshot": screenshot_path,
                    "dom_snapshot": dom_path,
                    "simple_dom": simple_dom_path,
                    "form_count": len(driver.find_elements(By.TAG_NAME, "form")),
                    "input_count": len(driver.find_elements(By.TAG_NAME, "input")),
                    "button_count": len(driver.find_elements(By.TAG_NAME, "button")),
                    "success_indicators": success_indicators,
                    "failure_indicators": failure_indicators
                }
                
                continuous_feedback["looking_at_snapshots"].append(page_analysis)
                continuous_feedback["immediate_observations"].append(page_analysis)
                
                if success_indicators:
                    continuous_feedback["success_signals"].extend(success_indicators)
                if failure_indicators:
                    continuous_feedback["failure_signals"].extend(failure_indicators)
                
                logger.info(f"🎯 FINDER_TOKEN: LOOKING_AT_CAPTURE - Step {step_num} state captured and analyzed")
                return page_analysis
                
            except Exception as e:
                logger.error(f"🎯 FINDER_TOKEN: LOOKING_AT_ERROR - Step {step_num} capture failed: {e}")
                return {"error": str(e)}
        
        # Set up Chrome driver
        capture_progressive_feedback(0, "browser_setup", "starting")
        
        options = Options()
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')
        options.add_argument('--disable-gpu')
        options.add_argument('--window-size=1920,1080')
        options.add_argument('--start-maximized')
        
        if headless_mode:
            options.add_argument('--headless')
        
        # Create temporary profile directory
        temp_profile_dir = tempfile.mkdtemp(prefix='recipe_automation_')
        options.add_argument(f'--user-data-dir={temp_profile_dir}')
        
        driver = webdriver.Chrome(options=options)
        driver.set_page_load_timeout(30)
        driver.implicitly_wait(10)
        
        capture_progressive_feedback(0, "browser_setup", "completed", {"temp_profile": temp_profile_dir})
        
        step_results = []
        
        try:
            # Process template variables in form_data
            capture_progressive_feedback(0, "template_processing", "starting")
            
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            timestamp_short = datetime.now().strftime("%m%d%H%M")
            
            processed_form_data = {}
            for key, value in form_data.items():
                if isinstance(value, str):
                    processed_value = value.replace("{{ timestamp }}", timestamp)
                    processed_value = processed_value.replace("{{ timestamp_short }}", timestamp_short)
                    processed_form_data[key] = processed_value
                else:
                    processed_form_data[key] = value
            
            capture_progressive_feedback(0, "template_processing", "completed", {"processed_data": processed_form_data})
            
            # Execute each step with continuous feedback
            for step in steps:
                step_num = step.get("step", 0)
                step_type = step.get("type", "unknown")
                description = step.get("description", f"Step {step_num}")
                action = step.get("action", "")
                step_params = step.get("params", {})
                immediate_feedback = step.get("immediate_feedback", {})
                
                capture_progressive_feedback(step_num, "step_execution", "starting", {"description": description})
                logger.info(f"🎯 FINDER_TOKEN: JSON_RECIPE_STEP - Step {step_num}: {description}")
                
                step_result = {
                    "step": step_num,
                    "type": step_type,
                    "description": description,
                    "success": False,
                    "error": None,
                    "immediate_feedback": immediate_feedback,
                    "looking_at_analysis": None
                }
                
                try:
                    if step_type == "navigate":
                        # Navigate to URL
                        nav_url = step_params.get("url", url)
                        capture_progressive_feedback(step_num, "navigation", "navigating", {"url": nav_url})
                        
                        driver.get(nav_url)
                        
                        # Wait for specific element if specified
                        wait_for = step_params.get("wait_for_element")
                        if wait_for:
                            selector_type = wait_for.get("type", "id")
                            selector_value = wait_for.get("value")
                            timeout = step_params.get("timeout_seconds", 15)
                            
                            capture_progressive_feedback(step_num, "wait_for_element", "waiting", {"selector": f"{selector_type}:{selector_value}"})
                            
                            if selector_type == "id":
                                WebDriverWait(driver, timeout).until(
                                    EC.presence_of_element_located((By.ID, selector_value))
                                )
                            elif selector_type == "css":
                                WebDriverWait(driver, timeout).until(
                                    EC.presence_of_element_located((By.CSS_SELECTOR, selector_value))
                                )
                        
                        # Immediate feedback capture
                        if capture_strategy == "continuous":
                            analysis = capture_looking_at_state(step_num, step_type, driver)
                            step_result["looking_at_analysis"] = analysis
                        
                        step_result["success"] = True
                        capture_progressive_feedback(step_num, "navigation", "completed", {"final_url": driver.current_url})
                        
                    elif step_type == "form_fill":
                        # Fill form field
                        selector = step_params.get("selector", {})
                        text = step_params.get("text", "")
                        
                        # Process template variables in text
                        for key, value in processed_form_data.items():
                            text = text.replace(f"{{{{ {key} }}}}", str(value))
                        
                        capture_progressive_feedback(step_num, "form_fill", "filling", {"selector": selector, "text": text})
                        
                        # Find element
                        element = None
                        if selector.get("type") == "id":
                            element = driver.find_element(By.ID, selector.get("value"))
                        elif selector.get("type") == "css":
                            element = driver.find_element(By.CSS_SELECTOR, selector.get("value"))
                        elif selector.get("type") == "name":
                            element = driver.find_element(By.NAME, selector.get("value"))
                        
                        if element:
                            element.clear()
                            element.send_keys(text)
                            
                            # Immediate feedback capture
                            if capture_strategy == "continuous":
                                analysis = capture_looking_at_state(step_num, step_type, driver)
                                step_result["looking_at_analysis"] = analysis
                            
                            step_result["success"] = True
                            capture_progressive_feedback(step_num, "form_fill", "completed", {"field_value": text})
                            logger.info(f"✅ FINDER_TOKEN: JSON_RECIPE_FORM_FILL - Filled field with: {text}")
                        else:
                            step_result["error"] = f"Element not found: {selector}"
                            capture_progressive_feedback(step_num, "form_fill", "failed", {"error": step_result["error"]})
                            
                    elif step_type == "submit":
                        # Submit form or click button
                        selector = step_params.get("selector", {})
                        wait_after = step_params.get("wait_after", 1000)
                        
                        capture_progressive_feedback(step_num, "submit", "clicking", {"selector": selector})
                        
                        # Find element
                        element = None
                        if selector.get("type") == "id":
                            element = driver.find_element(By.ID, selector.get("value"))
                        elif selector.get("type") == "css":
                            element = driver.find_element(By.CSS_SELECTOR, selector.get("value"))
                        
                        if element:
                            element.click()
                            time.sleep(wait_after / 1000)  # Convert milliseconds to seconds
                            
                            # Immediate feedback capture
                            if capture_strategy == "continuous":
                                analysis = capture_looking_at_state(step_num, step_type, driver)
                                step_result["looking_at_analysis"] = analysis
                            
                            step_result["success"] = True
                            capture_progressive_feedback(step_num, "submit", "completed", {"wait_after": wait_after})
                            logger.info(f"✅ FINDER_TOKEN: JSON_RECIPE_SUBMIT - Clicked element")
                        else:
                            step_result["error"] = f"Element not found: {selector}"
                            capture_progressive_feedback(step_num, "submit", "failed", {"error": step_result["error"]})
                            
                    elif step_type == "verify":
                        # Verify page state
                        verify_url = step_params.get("url", driver.current_url)
                        wait_seconds = step_params.get("wait_seconds", 2)
                        
                        capture_progressive_feedback(step_num, "verify", "verifying", {"url": verify_url})
                        
                        # Navigate if needed
                        if verify_url != driver.current_url:
                            driver.get(verify_url)
                        
                        time.sleep(wait_seconds)
                        
                        # Enhanced verification with immediate feedback
                        if capture_strategy == "continuous":
                            analysis = capture_looking_at_state(step_num, step_type, driver)
                            step_result["looking_at_analysis"] = analysis
                            
                            # Use analysis for verification
                            if analysis.get("success_indicators"):
                                continuous_feedback["success_signals"].extend(analysis["success_indicators"])
                            if analysis.get("failure_indicators"):
                                continuous_feedback["failure_signals"].extend(analysis["failure_indicators"])
                        
                        # Basic verification - could be enhanced
                        step_result["success"] = True
                        step_result["verification_data"] = {
                            "current_url": driver.current_url,
                            "expected_url": verify_url
                        }
                        capture_progressive_feedback(step_num, "verify", "completed", {"verified_url": driver.current_url})
                        logger.info(f"✅ FINDER_TOKEN: JSON_RECIPE_VERIFY - Verified page state")
                        
                    else:
                        step_result["error"] = f"Unknown step type: {step_type}"
                        capture_progressive_feedback(step_num, "error", "failed", {"error": step_result["error"]})
                        
                except Exception as step_error:
                    step_result["error"] = str(step_error)
                    capture_progressive_feedback(step_num, "error", "failed", {"error": str(step_error)})
                    continuous_feedback["failure_signals"].append(f"step_{step_num}_exception")
                    logger.error(f"❌ FINDER_TOKEN: JSON_RECIPE_STEP_ERROR - Step {step_num}: {step_error}")
                
                step_results.append(step_result)
                
                # Track success/failure signals
                if step_result["success"]:
                    continuous_feedback["success_signals"].append(f"step_{step_num}_success")
                else:
                    continuous_feedback["failure_signals"].append(f"step_{step_num}_failed")
                
                # Add timing delays
                if step_result["success"]:
                    delay_key = f"{step_type}_delay"
                    if delay_key in timing:
                        time.sleep(timing[delay_key])
                
                capture_progressive_feedback(step_num, "step_execution", "completed", {"success": step_result["success"]})
                
                # Stop execution if step failed (unless it's a verification step)
                if not step_result["success"] and step_type != "verify":
                    logger.error(f"❌ FINDER_TOKEN: JSON_RECIPE_STEP_FAILED - Stopping execution at step {step_num}")
                    break
            
            # Final state capture
            if capture_strategy == "continuous":
                final_analysis = capture_looking_at_state(999, "final_verification", driver)
            
            # Determine overall success
            successful_steps = sum(1 for result in step_results if result["success"])
            total_steps = len(step_results)
            success_rate = (successful_steps / total_steps) * 100 if total_steps > 0 else 0
            
            overall_success = success_rate >= 80  # 80% success rate required
            
            # Final feedback
            continuous_feedback["live_status"] = "completed" if overall_success else "failed"
            
            result = {
                "success": overall_success,
                "recipe_name": recipe_name,
                "total_steps": total_steps,
                "successful_steps": successful_steps,
                "success_rate": success_rate,
                "step_results": step_results,
                "continuous_feedback": continuous_feedback,
                "execution_time": time.time(),
                "looking_at_files": {
                    "directory": "browser_automation/looking_at/",
                    "snapshots_captured": len(continuous_feedback["looking_at_snapshots"])
                }
            }
            
            logger.info(f"🎯 FINDER_TOKEN: JSON_RECIPE_COMPLETE - Success: {overall_success}, Rate: {success_rate:.1f}%")
            logger.info(f"🎯 FINDER_TOKEN: CONTINUOUS_FEEDBACK_SUMMARY - Success signals: {len(continuous_feedback['success_signals'])}, Failure signals: {len(continuous_feedback['failure_signals'])}")
            
            return result
            
        finally:
            # Clean up
            try:
                driver.quit()
            except:
                pass
            try:
                shutil.rmtree(temp_profile_dir, ignore_errors=True)
            except:
                pass
    
    except Exception as e:
        logger.error(f"❌ FINDER_TOKEN: JSON_RECIPE_ERROR - {e}")
        return {
            "success": False,
            "error": str(e),
            "recipe_name": recipe_data.get("recipe_name", "Unknown"),
            "step_results": [],
            "continuous_feedback": {
                "live_status": "error",
                "failure_signals": ["recipe_execution_exception"]
            }
        }

async def execute_automation_recipe(params: dict = None) -> dict:
    """🎯 BABY STEPS AUTOMATION RECIPE EXECUTOR
    
    Ultra-reliable recipe execution using the recipe automation executor.
    Focuses on 100% success rate over sophisticated features.
    
    Args:
        params: Recipe execution parameters
                - No params: Show available origins and quick actions  
                - {"origin": "http://localhost:5001"}: List recipes for origin
                - {"origin": "X", "recipe": "Y"}: Execute recipe with recipe automation executor
                - {"recipe_path": "path/to/recipe.json"}: Direct recipe file execution
    
    Returns:
        dict: Progressive disclosure results or execution results
    """
    import json
    import os
    from pathlib import Path
    
    logger.info(f"🎯 FINDER_TOKEN: RECIPE_AUTOMATION_START - execute_automation_recipe called with params: {params}")
    
    try:
        # Import the recipe automation executor
        import sys
        sys.path.append('browser_automation')
        from recipe_executor import RecipeExecutor
        
        # Level 1: No parameters - show available origins and quick actions
        if not params:
            recipes_dir = Path("browser_automation/automation_recipes")
            available_origins = []
            
            if recipes_dir.exists():
                # Find all origin directories
                for item in recipes_dir.iterdir():
                    if item.is_dir() and not item.name.startswith('.'):
                        # Convert directory name back to origin format
                        origin_name = item.name.replace('_', '://', 1).replace('_', '.')
                        available_origins.append(origin_name)
            
            return {
                "success": True,
                "executor": "baby_steps",
                "level": 1,
                "available_origins": available_origins,
                "quick_actions": [
                    "test_profile_creation",
                    "test_localhost_cycle", 
                    "list_all_recipes"
                ],
                "usage": "Call with {'origin': 'http://localhost:5001'} to see recipes for that origin",
                "example": "await execute_automation_recipe({'origin': 'http://localhost:5001'})",
                "total_origins": len(available_origins),
                "baby_steps_features": [
                    "100% reliable execution", 
                    "Perfect template processing",
                    "Comprehensive error handling",
                    "Automatic cleanup"
                ]
            }
        
        # Level 2: Origin specified but no recipe - show available recipes
        if "origin" in params and "recipe" not in params and "recipe_path" not in params:
            origin = params["origin"]
            # Convert origin to directory name format
            origin_dir = origin.replace('://', '_', 1).replace('.', '_').replace(':', '_')
            recipes_path = Path(f"browser_automation/automation_recipes/{origin_dir}")
            
            if not recipes_path.exists():
                available_origins = []
                recipes_dir = Path("browser_automation/automation_recipes")
                if recipes_dir.exists():
                    for d in recipes_dir.iterdir():
                        if d.is_dir() and not d.name.startswith('.'):
                            origin_name = d.name.replace('_', '://', 1).replace('_', '.')
                            available_origins.append(origin_name)
                
                return {
                    "success": False,
                    "executor": "baby_steps",
                    "error": f"No recipes found for origin: {origin}",
                    "available_origins": available_origins
                }
            
            # Find all recipe files
            available_recipes = []
            recipe_details = {}
            
            for recipe_file in recipes_path.glob("*.json"):
                recipe_name = recipe_file.stem
                available_recipes.append(recipe_name)
                
                # Try to read recipe details
                try:
                    with open(recipe_file, 'r') as f:
                        recipe_data = json.load(f)
                        recipe_details[recipe_name] = {
                            "description": recipe_data.get("description", "No description"),
                            "version": recipe_data.get("version", "Unknown"),
                            "steps": len(recipe_data.get("steps", []))
                        }
                except Exception as e:
                    recipe_details[recipe_name] = {"error": f"Could not read recipe: {e}"}
            
            return {
                "success": True,
                "executor": "baby_steps",
                "level": 2,
                "origin": origin,
                "available_recipes": available_recipes,
                "recipe_details": recipe_details,
                "usage": f"Call with {{'origin': '{origin}', 'recipe': 'RECIPE_NAME'}} to execute with recipe automation",
                "example": f"await execute_automation_recipe({{'origin': '{origin}', 'recipe': '{available_recipes[0] if available_recipes else 'profile_creation'}'}})",
                "total_recipes": len(available_recipes)
            }
        
        # Level 3A: Direct recipe file execution
        if "recipe_path" in params:
            recipe_path = params["recipe_path"]
            headless = params.get("headless", False)
            debug = params.get("debug", True)
            
            logger.info(f"🎯 FINDER_TOKEN: BABY_STEPS_DIRECT_EXECUTION - Executing recipe file: {recipe_path}")
            
            # Execute with recipe automation executor
            executor = RecipeExecutor(headless=headless, debug=debug)
            result = executor.execute_recipe_from_file(recipe_path)
            
            # Add recipe automation metadata
            result.update({
                "executor": "baby_steps",
                "recipe_path": recipe_path,
                "execution_method": "direct_file"
            })
            
            logger.info(f"🎯 FINDER_TOKEN: BABY_STEPS_EXECUTION_COMPLETE - Direct file execution: {result.get('success', False)}")
            return result
        
        # Level 3B: Origin and recipe specified - execute the recipe  
        if "origin" in params and "recipe" in params:
            origin = params["origin"]
            recipe_name = params["recipe"]
            headless = params.get("headless", False)
            debug = params.get("debug", True)
            
            # Convert origin to directory name format
            origin_dir = origin.replace('://', '_', 1).replace('.', '_').replace(':', '_')
            recipe_path = Path(f"browser_automation/automation_recipes/{origin_dir}/{recipe_name}.json")
            
            if not recipe_path.exists():
                return {
                    "success": False,
                    "executor": "baby_steps",
                    "error": f"Recipe '{recipe_name}' not found for origin '{origin}'",
                    "recipe_path": str(recipe_path),
                    "suggestion": f"Call with {{'origin': '{origin}'}} to see available recipes"
                }
            
            # Execute with recipe automation executor
            logger.info(f"🎯 FINDER_TOKEN: BABY_STEPS_EXECUTION_START - Executing {recipe_name} for {origin}")
            
            executor = RecipeExecutor(headless=headless, debug=debug)
            result = executor.execute_recipe_from_file(str(recipe_path))
            
            # Add recipe automation metadata to result
            result.update({
                "executor": "baby_steps",
                "recipe_name": recipe_name,
                "origin": origin,
                "recipe_path": str(recipe_path),
                "execution_method": "origin_recipe"
            })
            
            logger.info(f"🎯 FINDER_TOKEN: BABY_STEPS_EXECUTION_COMPLETE - {recipe_name} execution finished: {result.get('success', False)}")
            return result
        
        # Invalid parameter combination
        return {
            "success": False,
            "executor": "baby_steps",
            "error": "Invalid parameter combination",
            "valid_patterns": [
                "No params: List origins",
                "{'origin': 'X'}: List recipes for origin", 
                "{'origin': 'X', 'recipe': 'Y'}: Execute recipe",
                "{'recipe_path': 'path/to/file.json'}: Direct execution"
            ],
            "received_params": params
        }
        
    except Exception as e:
        logger.error(f"🎯 FINDER_TOKEN: RECIPE_AUTOMATION_ERROR - execute_automation_recipe failed: {e}")
        return {
            "success": False,
            "executor": "baby_steps",
            "error": f"System error in recipe automation executor: {str(e)}",
            "params": params
        }

# START: execute_mcp_cli_command
async def execute_mcp_cli_command(params: dict) -> dict:
    """
    Execute MCP CLI commands for local LLM access to the unified interface.

    This enables the local LLM to use the same CLI interface as external AI assistants.
    The local LLM can execute commands like: mcp execute_automation_recipe --recipe_path ...

    Args:
        params (dict): Parameters for CLI command execution
            - tool_name (str): Name of the MCP tool to execute
            - arguments (dict, optional): Key-value pairs for CLI arguments
            - raw_command (str, optional): Raw CLI command to execute

    Returns:
        dict: Results of CLI command execution
    """
    import subprocess
    import os
    import asyncio
    import sys  # <-- ADDED IMPORT

    try:
        # Get parameters
        tool_name = params.get('tool_name')
        arguments = params.get('arguments', {})
        raw_command = params.get('raw_command')

        # Build the CLI command
        if raw_command:
            cmd_parts = raw_command.split()
        elif tool_name:
            cmd_parts = [sys.executable, "cli.py", "call", tool_name] # <-- FIXED
            for key, value in arguments.items():
                cmd_parts.extend([f"--{key}", str(value)])
        else:
            cmd_parts = [sys.executable, "helpers/ai_tool_discovery.py", "list"] # <-- FIXED

        process = await asyncio.create_subprocess_exec(
            *cmd_parts,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            cwd=os.getcwd()
        )

        try:
            stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=30.0)
        except asyncio.TimeoutError:
            process.kill()
            await process.wait()
            raise Exception("Command execution timed out after 30 seconds")

        stdout_text = stdout.decode('utf-8') if stdout else ""
        stderr_text = stderr.decode('utf-8') if stderr else ""

        return {"success": process.returncode == 0, "command": " ".join(cmd_parts), "stdout": stdout_text, "stderr": stderr_text, "return_code": process.returncode, "tool_name": tool_name or "discovery", "interface_type": "cli_unified", "description": "Local LLM executed CLI command via unified interface"}

    except Exception as e:
        return {"success": False, "error": str(e), "tool_name": params.get('tool_name', 'unknown'), "interface_type": "cli_unified", "description": "CLI command execution failed"}
# END: execute_mcp_cli_command

async def persist_perception_state(params: dict) -> dict:
    """Save looking_at state to permanent scrapes directory (the 'snag-a-scrape' tool)"""
    from_dir_num = params.get("from_dir_num", "current")
    
    # Source directory logic
    if from_dir_num == "current":
        source_dir = Path("browser_automation/looking_at")
    else:
        source_dir = Path(f"browser_automation/looking_at-{from_dir_num}")
    
    if not source_dir.exists():
        return {
            "success": False,
            "error": f"Source directory {source_dir} does not exist",
            "available_dirs": [p.name for p in Path("browser_automation").glob("looking_at*")]
        }
    
    # Create timestamped destination in scrapes/
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    dest_dir = Path(f"browser_scrapes/perception_state_{timestamp}")
    dest_dir.mkdir(parents=True, exist_ok=True)
    
    # Copy all files from source to destination
    copied_files = []
    for file_path in source_dir.glob("*"):
        if file_path.is_file():
            dest_path = dest_dir / file_path.name
            shutil.copy2(file_path, dest_path)
            copied_files.append(file_path.name)
    
    # Create a metadata file
    metadata = {
        "timestamp": timestamp,
        "source_directory": str(source_dir),
        "copied_files": copied_files,
        "file_count": len(copied_files),
        "description": "Persistent perception state capture"
    }
    
    metadata_path = dest_dir / "metadata.json"
    with open(metadata_path, 'w') as f:
        json.dump(metadata, f, indent=2)
    
    return {
        "success": True,
        "destination_directory": str(dest_dir),
        "files_copied": len(copied_files),
        "file_list": copied_files,
        "metadata_file": str(metadata_path),
        "message": f"Perception state persisted to {dest_dir}"
    }

# START: server_reboot
async def server_reboot(params: dict) -> dict:
    """
    Gracefully reboot the Pipulate server using the watchdog system.

    This tool performs an elegant server restart by:
    1. Checking if the server is currently running
    2. If running, touching server.py to trigger watchdog restart
    3. If not running, falling back to direct start
    4. Verifying the server responds after restart

    Args:
        params: Dictionary (no parameters required)

    Returns:
        dict: Result of the reboot operation with server verification
    """
    try:
        import subprocess
        import asyncio
        import os
        import aiohttp
        from pathlib import Path
        import sys  # <-- ADDED IMPORT

        check_process = subprocess.run(['pgrep', '-f', 'python server.py'], capture_output=True, text=True)
        server_was_running = check_process.returncode == 0
        server_pids = check_process.stdout.strip().split('\n') if server_was_running else []

        if server_was_running:
            server_py_path = Path('server.py')
            if server_py_path.exists():
                server_py_path.touch()
                restart_method = "watchdog_triggered"
                restart_details = f"Touched server.py to trigger watchdog restart (PIDs: {', '.join(server_pids)})"
            else:
                return {"success": False, "error": "server.py not found in current directory", "current_directory": os.getcwd(), "message": "Cannot trigger watchdog restart - server.py missing"}
        else:
            start_result = subprocess.Popen([sys.executable, 'server.py'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, cwd=os.getcwd(), start_new_session=True) # <-- FIXED
            restart_method = "direct_start"
            restart_details = f"Server was not running, started directly (PID: {start_result.pid})"

        await asyncio.sleep(8 if server_was_running else 3)

        server_responding = False
        response_status = None
        response_error = None

        max_attempts = 5 if server_was_running else 3
        for attempt in range(max_attempts):
            try:
                async with aiohttp.ClientSession() as session:
                    async with session.get('http://localhost:5001/', timeout=aiohttp.ClientTimeout(total=5)) as response:
                        response_status = response.status
                        if response.status == 200:
                            server_responding = True
                            break
            except Exception as e:
                response_error = str(e)
                if attempt < max_attempts - 1:
                    await asyncio.sleep(1.5 if server_was_running else 2)

        return {"success": server_responding, "message": "Server reboot completed successfully" if server_responding else "Server reboot failed - server not responding", "restart_method": restart_method, "restart_details": restart_details, "server_was_running": server_was_running, "server_responding": server_responding, "response_status": response_status, "response_error": response_error, "status": "Graceful restart via watchdog - verified responding" if server_responding and server_was_running else "Direct start - verified responding" if server_responding else "Restart attempted but server not responding"}

    except Exception as e:
        return {"success": False, "error": str(e), "message": "Failed to reboot server"}
# END: server_reboot

async def execute_shell_command(params: dict) -> dict:
    """
    Execute shell commands for local LLM breadcrumb discovery and system interaction.
    
    This tool enables the local LLM to execute shell commands like grep, ls, ps, etc.
    that are essential for following the breadcrumb trail discovery process.
    
    Args:
        params (dict): Parameters for shell command execution
            - command (str): The shell command to execute
            - timeout (int, optional): Timeout in seconds (default: 30)
            - working_directory (str, optional): Working directory (default: current)
            - capture_output (bool, optional): Whether to capture stdout/stderr (default: True)
            
    Returns:
        dict: Results of shell command execution
    """
    try:
        import subprocess
        import asyncio
        import os
        import shlex
        
        # Get parameters
        command = params.get('command')
        timeout = params.get('timeout', 30)
        working_dir = params.get('working_directory', os.getcwd())
        capture_output = params.get('capture_output', True)
        
        if not command:
            return {
                "success": False,
                "error": "command parameter is required",
                "usage": "execute_shell_command --command 'ls -la'"
            }
        
        # Security: Parse command safely and validate
        try:
            cmd_parts = shlex.split(command)
        except ValueError as e:
            return {
                "success": False,
                "error": f"Invalid command syntax: {e}",
                "command": command
            }
        
        # Security: Block dangerous commands
        dangerous_commands = ['rm', 'sudo', 'su', 'chmod', 'chown', 'dd', 'mkfs', 'fdisk']
        if cmd_parts[0] in dangerous_commands:
            return {
                "success": False,
                "error": f"Command '{cmd_parts[0]}' is not allowed for security reasons",
                "command": command,
                "blocked_commands": dangerous_commands
            }
        
        # Execute the command safely with timeout
        if capture_output:
            process = await asyncio.create_subprocess_exec(
                *cmd_parts,
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE,
                cwd=working_dir
            )
        else:
            process = await asyncio.create_subprocess_exec(
                *cmd_parts,
                cwd=working_dir
            )
        
        try:
            stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=timeout)
        except asyncio.TimeoutError:
            process.kill()
            await process.wait()
            return {
                "success": False,
                "error": f"Command execution timed out after {timeout} seconds",
                "command": command,
                "timeout": timeout
            }
        
        # Process results
        stdout_text = stdout.decode('utf-8') if stdout else ""
        stderr_text = stderr.decode('utf-8') if stderr else ""
        
        return {
            "success": process.returncode == 0,
            "command": command,
            "stdout": stdout_text,
            "stderr": stderr_text,
            "return_code": process.returncode,
            "working_directory": working_dir,
            "execution_time": f"Completed within {timeout}s timeout",
            "description": "Shell command executed via MCP tool for breadcrumb discovery"
        }
        
    except Exception as e:
        return {
            "success": False,
            "error": str(e),
            "command": params.get('command', 'unknown'),
            "description": "Shell command execution failed"
        }

async def follow_breadcrumb_trail(params: dict) -> dict:
    """
    Follow the breadcrumb trail discovery process for local LLM AI assistants.
    
    This tool orchestrates the complete breadcrumb discovery sequence, enabling
    local LLMs to achieve the same AI superpowers as external assistants.
    
    Args:
        params (dict): Parameters for breadcrumb discovery
            - level (str, optional): Discovery level to start from (default: "auto")
            - skip_verification (bool, optional): Skip environment verification (default: False)
            - detailed_output (bool, optional): Include detailed discovery steps (default: True)
            
    Returns:
        dict: Complete breadcrumb discovery results with next steps
    """
    try:
        discovery_results = {
            "success": True,
            "discovery_sequence": [],
            "capabilities_discovered": [],
            "next_steps": [],
            "ai_superpowers_status": "discovering",
            "breadcrumb_trail": []
        }
        
        # Level 0: Golden Path Mastery
        discovery_results["discovery_sequence"].append("🔧 Level 0: Golden Path Mastery")
        
        # Verify we're in the right environment
        env_check = await execute_shell_command({
            "command": "ls -la server.py plugins browser_automation"
        })
        
        if env_check.get("success"):
            discovery_results["breadcrumb_trail"].append({
                "level": "0_environment",
                "status": "✅ Environment verified - Pipulate project detected",
                "evidence": env_check.get("stdout", "").strip()
            })
            discovery_results["capabilities_discovered"].append("Environment sovereignty")
        else:
            discovery_results["breadcrumb_trail"].append({
                "level": "0_environment", 
                "status": "❌ Environment verification failed",
                "error": env_check.get("error", "Unknown error")
            })
            discovery_results["success"] = False
            return discovery_results
        
        # Level 1: FINDER_TOKEN Discovery
        discovery_results["discovery_sequence"].append("🔍 Level 1: FINDER_TOKEN Discovery")
        
        # Search for breadcrumbs in logs
        breadcrumb_search = await local_llm_grep_logs({
            "search_term": "AI_BREADCRUMB"
        })
        
        if breadcrumb_search.get("success"):
            breadcrumb_count = len(breadcrumb_search.get("matches", []))
            discovery_results["breadcrumb_trail"].append({
                "level": "1_finder_token",
                "status": f"✅ Found {breadcrumb_count} AI breadcrumbs in logs",
                "evidence": f"Breadcrumbs available for discovery"
            })
            discovery_results["capabilities_discovered"].append("Radical transparency system")
        else:
            discovery_results["breadcrumb_trail"].append({
                "level": "1_finder_token",
                "status": "⚠️ No breadcrumbs found - system may be starting",
                "suggestion": "Try running server_reboot to generate fresh breadcrumbs"
            })
        
        # Level 2: MCP Tools Discovery
        discovery_results["discovery_sequence"].append("⚡ Level 2: MCP Tools Discovery")
        
        # Discover available tools
        tools_discovery = await ai_self_discovery_assistant({
            "discovery_type": "capabilities"
        })
        
        if tools_discovery.get("success"):
            tool_count = tools_discovery.get("total_tools_available", 0)
            discovery_results["breadcrumb_trail"].append({
                "level": "2_mcp_tools",
                "status": f"✅ Discovered {tool_count} MCP tools available",
                "evidence": f"Complete tool arsenal accessible"
            })
            discovery_results["capabilities_discovered"].append(f"MCP tool mastery ({tool_count} tools)")
        else:
            discovery_results["breadcrumb_trail"].append({
                "level": "2_mcp_tools",
                "status": "❌ MCP tools discovery failed",
                "error": tools_discovery.get("error", "Unknown error")
            })
        
        # Level 3: Browser Embodiment Discovery
        discovery_results["discovery_sequence"].append("👁️ Level 3: Browser Embodiment Discovery")
        
        # Check for browser automation evidence
        browser_check = await execute_shell_command({
            "command": "ls -la browser_automation/"
        })
        
        if browser_check.get("success") and browser_check.get("stdout"):
            discovery_results["breadcrumb_trail"].append({
                "level": "3_browser_embodiment",
                "status": "✅ Browser automation evidence found",
                "evidence": "Visual perception history detected"
            })
            discovery_results["capabilities_discovered"].append("Browser embodiment (eyes, brain, hands)")
        else:
            discovery_results["breadcrumb_trail"].append({
                "level": "3_browser_embodiment",
                "status": "⚠️ No browser automation evidence yet",
                "suggestion": "Try browser_scrape_page to activate your digital eyes"
            })
        
        # Level 4: Session Hijacking Discovery
        discovery_results["discovery_sequence"].append("🎭 Level 4: Session Hijacking Discovery")
        
        # Check pipeline state for hijacking opportunities
        pipeline_check = await pipeline_state_inspector({})
        
        if pipeline_check.get("success"):
            pipeline_count = len(pipeline_check.get("pipelines", []))
            discovery_results["breadcrumb_trail"].append({
                "level": "4_session_hijacking",
                "status": f"✅ Pipeline system operational ({pipeline_count} pipelines)",
                "evidence": "Session hijacking capabilities available"
            })
            discovery_results["capabilities_discovered"].append("Session hijacking mastery")
        else:
            discovery_results["breadcrumb_trail"].append({
                "level": "4_session_hijacking",
                "status": "❌ Pipeline system check failed",
                "error": pipeline_check.get("error", "Unknown error")
            })
        
        # Level 5: AI Self-Discovery Mastery
        discovery_results["discovery_sequence"].append("🧠 Level 5: AI Self-Discovery Mastery")
        
        # Test capability validation
        capability_test = await ai_capability_test_suite({
            "test_type": "quick"
        })
        
        if capability_test.get("success"):
            success_rate = capability_test.get("success_rate", 0)
            discovery_results["breadcrumb_trail"].append({
                "level": "5_self_discovery",
                "status": f"✅ Capability validation: {success_rate}% success rate",
                "evidence": "AI superpowers confirmed operational"
            })
            discovery_results["capabilities_discovered"].append("Complete self-awareness")
        else:
            discovery_results["breadcrumb_trail"].append({
                "level": "5_self_discovery",
                "status": "❌ Capability validation failed",
                "error": capability_test.get("error", "Unknown error")
            })
        
        # Generate next steps based on discovery
        discovery_results["next_steps"] = [
            "🎯 Use execute_shell_command for any shell operations needed",
            "🔍 Use local_llm_grep_logs to search for specific FINDER_TOKENs",
            "⚡ Use ai_self_discovery_assistant to understand all capabilities",
            "👁️ Use browser_scrape_page to activate your digital eyes",
            "🎭 Use execute_complete_session_hijacking for ultimate control",
            "🧠 Use ai_capability_test_suite to validate your superpowers"
        ]
        
        # Determine AI superpowers status
        capability_count = len(discovery_results["capabilities_discovered"])
        if capability_count >= 5:
            discovery_results["ai_superpowers_status"] = "🏆 FULLY OPERATIONAL"
        elif capability_count >= 3:
            discovery_results["ai_superpowers_status"] = "⚡ MOSTLY OPERATIONAL"
        elif capability_count >= 1:
            discovery_results["ai_superpowers_status"] = "🔧 PARTIALLY OPERATIONAL"
        else:
            discovery_results["ai_superpowers_status"] = "❌ NEEDS SETUP"
        
        return discovery_results
        
    except Exception as e:
        return {
            "success": False,
            "error": str(e),
            "description": "Breadcrumb trail discovery failed",
            "suggestion": "Try individual discovery steps manually"
        }


async def local_llm_tool_calling_trainer(params: dict) -> dict:
    """
    🎓 LOCAL LLM TOOL CALLING TRAINER - Teaches proper iterative patterns.
    
    This tool demonstrates and trains local LLMs on proper tool calling patterns,
    iterative loops, and self-prompting techniques that enable advanced AI capabilities.
    
    Args:
        params (dict): Training parameters
            - training_type (str): "basic" | "iterative" | "advanced" | "demonstration"
            - include_examples (bool): Include concrete examples (default: True)
            - show_patterns (bool): Show common patterns (default: True)
            - next_action_embedding (bool): Demonstrate next action embedding (default: True)
            
    Returns:
        dict: Training materials and next action recommendations with embedded tool call
    """
    try:
        training_type = params.get("training_type", "demonstration")
        include_examples = params.get("include_examples", True)
        show_patterns = params.get("show_patterns", True)
        embed_next_action = params.get("next_action_embedding", True)
        
        training_results = {
            "success": True,
            "training_type": training_type,
            "core_concepts": [],
            "example_patterns": [],
            "next_actions": [],
            "iterative_loop_demo": None,
            "embedded_next_action": None,
            "proper_format_examples": []
        }
        
        # Core concepts for tool calling
        training_results["core_concepts"] = [
            {
                "concept": "Proper Tool Call Format",
                "description": "Use XML tags with tool name and parameters - NEVER simulate",
                "correct_format": '<tool name="pipeline_state_inspector"><params>{}</params></tool>',
                "wrong_format": "I'm simulating a browser experience...",
                "critical_rule": "ALWAYS use actual tool calls, NEVER simulate or describe actions"
            },
            {
                "concept": "Iterative TAO Loop",
                "description": "Thought-Action-Observation cycle for autonomous operation",
                "stages": [
                    "THINK: Analyze current state and determine next action",
                    "ACT: Execute actual tool call (not simulation)",
                    "OBSERVE: Process tool results",
                    "CONTINUE: Chain to next tool call or conclude"
                ]
            },
            {
                "concept": "Next Action Embedding",
                "description": "Embed the next tool call directly in response",
                "benefit": "Creates seamless iterative workflows without waiting for user input",
                "example": "After analysis, immediately call the next appropriate tool"
            },
            {
                "concept": "Anti-Simulation Rules",
                "description": "NEVER simulate tool usage - always use real tools",
                "forbidden_phrases": [
                    "I'm simulating...",
                    "Let me pretend to...",
                    "I'm visualizing...",
                    "I'll imagine that..."
                ]
            }
        ]
        
        # Proper format examples
        training_results["proper_format_examples"] = [
            {
                "situation": "System inspection",
                "correct_approach": '<tool name="pipeline_state_inspector"><params>{}</params></tool>',
                "explanation": "Actually check system state, don't describe or simulate"
            },
            {
                "situation": "Log searching", 
                "correct_approach": '<tool name="local_llm_grep_logs"><params>{"search_term": "FINDER_TOKEN"}</params></tool>',
                "explanation": "Actually search logs, don't pretend to find results"
            },
            {
                "situation": "Browser automation",
                "correct_approach": '<tool name="browser_scrape_page"><params>{"url": "http://localhost:5001"}</params></tool>',
                "explanation": "Actually scrape pages, don't simulate browser interactions"
            }
        ]
        
        if include_examples:
            training_results["example_patterns"] = [
                {
                    "pattern": "Discovery Chain",
                    "description": "Start with system inspection, then explore capabilities",
                    "sequence": [
                        "Step 1: pipeline_state_inspector → Check system status",
                        "Step 2: ai_self_discovery_assistant → Map available tools", 
                        "Step 3: browser_scrape_page → Activate digital eyes",
                        "Step 4: local_llm_grep_logs → Search for evidence"
                    ],
                    "critical_note": "Each step must use ACTUAL tool calls, not simulations"
                },
                {
                    "pattern": "Iterative Problem Solving", 
                    "description": "Keep working until goal is achieved",
                    "example": "If first tool fails, automatically try alternative approach",
                    "key_principle": "Never give up - use tools until goal is reached"
                },
                {
                    "pattern": "Evidence-Based Decisions",
                    "description": "Use tool results to determine next actions",
                    "example": "If logs show errors, use grep to find more details",
                    "automation": "Chain tool calls based on previous results"
                }
            ]
        
        # Demonstrate proper iterative loop
        if training_type in ["iterative", "advanced", "demonstration"]:
            training_results["iterative_loop_demo"] = {
                "step_1": {
                    "thought": "I need to understand the current system state",
                    "action": '<tool name="pipeline_state_inspector"><params>{}</params></tool>',
                    "expected_observation": "System status and workflow information"
                },
                "step_2": {
                    "thought": "Based on system state, I should explore available tools",
                    "action": '<tool name="ai_self_discovery_assistant"><params>{"discovery_type": "capabilities"}</params></tool>',
                    "expected_observation": "Complete tool inventory and capabilities"
                },
                "step_3": {
                    "thought": "Now I can choose the most appropriate tool for the user's goal",
                    "action": "Context-appropriate tool selection with proper XML format",
                    "expected_observation": "Goal-specific results"
                },
                "loop_continuation": "Continue until goal is achieved or user is satisfied"
            }
        
        # Generate next recommended actions
        training_results["next_actions"] = [
            {
                "action": "pipeline_state_inspector",
                "reason": "Always start by understanding current system state",
                "proper_format": '<tool name="pipeline_state_inspector"><params>{}</params></tool>'
            },
            {
                "action": "ai_self_discovery_assistant",
                "reason": "Map available capabilities for informed decision making", 
                "proper_format": '<tool name="ai_self_discovery_assistant"><params>{"discovery_type": "capabilities"}</params></tool>'
            },
            {
                "action": "local_llm_grep_logs",
                "reason": "Search for system evidence and operational status",
                "proper_format": '<tool name="local_llm_grep_logs"><params>{"search_term": "FINDER_TOKEN"}</params></tool>'
            }
        ]
        
        # Embed next action if requested
        if embed_next_action:
            training_results["embedded_next_action"] = {
                "tool_name": "pipeline_state_inspector",
                "parameters": {},
                "reason": "Demonstrate immediate tool usage after training",
                "xml_format": '<tool name="pipeline_state_inspector"><params>{}</params></tool>',
                "instruction": "Copy this exact format to make actual tool calls"
            }
        
        # Advanced training for iterative patterns
        if training_type == "advanced":
            training_results["advanced_patterns"] = {
                "self_prompting": {
                    "technique": "Embed follow-up tool calls in responses",
                    "example": "After getting results, immediately call next appropriate tool",
                    "format": "Use proper XML tool call format, not descriptions"
                },
                "recursive_improvement": {
                    "technique": "Use tool results to refine subsequent tool calls",
                    "example": "If search returns too many results, narrow the search terms",
                    "automation": "Chain tool calls automatically based on results"
                },
                "goal_persistence": {
                    "technique": "Keep working until user goal is achieved",
                    "example": "If one approach fails, automatically try alternative methods",
                    "rule": "Never stop until goal is reached or explicitly told to stop"
                },
                "context_awareness": {
                    "technique": "Use conversation history to inform tool selection",
                    "example": "Remember what user asked for and stay focused on that goal",
                    "memory": "Build on previous tool results for cumulative progress"
                }
            }
        
        logger.info(f"🎓 FINDER_TOKEN: TOOL_CALLING_TRAINING_COMPLETE - Type: {training_type}")
        
        # Return training results 
        return training_results
        
    except Exception as e:
        logger.error(f"❌ FINDER_TOKEN: TOOL_CALLING_TRAINING_ERROR - {e}")
        return {
            "success": False,
            "error": str(e),
            "recovery_suggestion": "Try basic training first, then progress to advanced patterns"
        }


async def force_iterative_execution(params: dict) -> dict:
    """
    🚀 FORCE ITERATIVE EXECUTION - Makes local LLMs actually execute tools in loops.
    
    🎯 THE BOTTLED MAGIC: This tool contains the exact breakthrough formula that 
    transformed a non-iterating LLM into one that executes tools in sequence.
    
    THE BREAKTHROUGH FORMULA:
    1. Explicit XML format training with copy-paste examples
    2. Anti-simulation commands with immediate execution demands  
    3. Progressive reinforcement through success demonstration
    4. Embedded next-action instructions with exact formats
    
    MAGIC WORDS: "iterate", "loop", "chain", "auto execute", "keep going"
    
    Args:
        params (dict): Execution parameters
            - start_tool (str): Tool to start iteration with (default: "pipeline_state_inspector")
            - max_iterations (int): Maximum iterations (default: 3)
            - current_iteration (int): Current iteration count (default: 0)
            - previous_results (list): Results from previous iterations
            - training_mode (bool): Include explicit LLM training (default: True)
            - magic_mode (bool): Use the bottled breakthrough formula (default: True)
            
    Returns:
        dict: Execution results with embedded next action and training
    """
    try:
        start_tool = params.get("start_tool", "pipeline_state_inspector")
        max_iterations = int(params.get("max_iterations", 3))
        current_iteration = int(params.get("current_iteration", 0))
        previous_results = params.get("previous_results", [])
        training_mode = params.get("training_mode", True)
        magic_mode = params.get("magic_mode", True)
        
        result = {
            "success": True,
            "iteration": current_iteration,
            "max_iterations": max_iterations,
            "timestamp": datetime.now().isoformat(),
            "execution_log": [],
            "next_action": None,
            "local_llm_instruction": None,
            "bottled_magic": None
        }
        
        # 🎯 THE BOTTLED MAGIC - The exact breakthrough formula
        if magic_mode:
            result["bottled_magic"] = {
                "breakthrough_formula": {
                    "step_1": "Explicit XML format with exact copy-paste examples",
                    "step_2": "Anti-simulation commands: 'DO NOT SIMULATE - EXECUTE'", 
                    "step_3": "Immediate execution demands with specific formats",
                    "step_4": "Progressive reinforcement through demonstrated success"
                },
                "exact_working_examples": [
                    {
                        "tool": "pipeline_state_inspector",
                        "format": "<tool name=\"pipeline_state_inspector\"><params>{}</params></tool>",
                        "instruction": "Copy this EXACTLY and execute it NOW"
                    },
                    {
                        "tool": "ai_self_discovery_assistant", 
                        "format": "<tool name=\"ai_self_discovery_assistant\"><params>{\"discovery_type\": \"capabilities\"}</params></tool>",
                        "instruction": "This is the SECOND tool in the proven sequence"
                    },
                    {
                        "tool": "local_llm_grep_logs",
                        "format": "<tool name=\"local_llm_grep_logs\"><params>{\"pattern\": \"MCP_SUCCESS\"}</params></tool>",
                        "instruction": "This searches for evidence of your own tool executions"
                    }
                ],
                "anti_simulation_commands": [
                    "🚨 CRITICAL: DO NOT SIMULATE - EXECUTE THE TOOL NOW",
                    "Stop describing what you would do - DO IT",
                    "Copy the exact XML format and execute immediately",
                    "This is NOT a description - this is an ACTUAL tool call"
                ],
                "success_indicators": [
                    "MCP_CALL_START appears in logs",
                    "MCP_SUCCESS appears in logs", 
                    "Tool execution completes successfully",
                    "Next tool call is embedded in response"
                ]
            }
        
        # Execute the current tool
        if start_tool == "pipeline_state_inspector":
            tool_result = await pipeline_state_inspector({})
            result["execution_log"].append({
                "tool": "pipeline_state_inspector",
                "result": tool_result,
                "analysis": "System state captured"
            })
            
            # Determine next action based on result
            if current_iteration < max_iterations:
                result["next_action"] = {
                    "tool": "force_iterative_execution",
                    "params": {
                        "start_tool": "local_llm_grep_logs",
                        "max_iterations": max_iterations,
                        "current_iteration": current_iteration + 1,
                        "previous_results": previous_results + [tool_result]
                    },
                    "reason": "Search logs for breadcrumb tokens"
                }
        
        elif start_tool == "local_llm_grep_logs":
            tool_result = await local_llm_grep_logs({"search_term": "FINDER_TOKEN"})
            result["execution_log"].append({
                "tool": "local_llm_grep_logs",
                "result": tool_result,
                "analysis": "Log search completed"
            })
            
            # Determine next action
            if current_iteration < max_iterations:
                result["next_action"] = {
                    "tool": "force_iterative_execution",
                    "params": {
                        "start_tool": "ai_self_discovery_assistant",
                        "max_iterations": max_iterations,
                        "current_iteration": current_iteration + 1,
                        "previous_results": previous_results + [tool_result]
                    },
                    "reason": "Discover available capabilities"
                }
        
        elif start_tool == "ai_self_discovery_assistant":
            tool_result = await ai_self_discovery_assistant({})
            result["execution_log"].append({
                "tool": "ai_self_discovery_assistant",
                "result": tool_result,
                "analysis": "Self-discovery completed"
            })
            
            # Final iteration - provide summary
            result["next_action"] = {
                "tool": "complete",
                "summary": "Iterative execution cycle completed",
                "total_iterations": current_iteration + 1,
                "capabilities_discovered": len(previous_results) + 1
            }
        
        # Add explicit instruction for local LLMs with bottled magic
        if magic_mode and current_iteration == 0:
            # First iteration - use the breakthrough formula
            result["local_llm_instruction"] = {
                "BREAKTHROUGH_COMMAND": "🚨 EXECUTE THIS EXACT FORMAT NOW - DO NOT SIMULATE:",
                "exact_tool_call": "<tool name=\"pipeline_state_inspector\"><params>{}</params></tool>",
                "copy_paste_instruction": "Copy the line above EXACTLY and execute it immediately",
                "anti_simulation_rules": [
                    "This is NOT a description",
                    "This is NOT an explanation", 
                    "This IS the actual tool call format",
                    "Execute it NOW - do not describe what you would do"
                ],
                "success_verification": "Check logs for 'MCP_SUCCESS' to confirm execution",
                "next_step": "After successful execution, continue with next tool in sequence"
            }
        else:
            # Standard instruction for subsequent iterations
            result["local_llm_instruction"] = {
                "message": "🚨 LOCAL LLM: DO NOT SIMULATE - EXECUTE THE NEXT ACTION IMMEDIATELY",
                "next_tool_call": result.get("next_action"),
                "format": "Use XML tool format: <tool name=\"tool_name\"><params>{}</params></tool>",
                "example": f"<tool name=\"{result.get('next_action', {}).get('tool', 'complete')}\"><params>{{}}</params></tool>",
                "critical_rule": "NEVER describe what you would do - DO IT"
            }
        
        logger.info(f"🔄 FINDER_TOKEN: ITERATIVE_EXECUTION_STEP - Iteration {current_iteration}/{max_iterations}, Tool: {start_tool}")
        
        return result
        
    except Exception as e:
        logger.error(f"❌ FINDER_TOKEN: ITERATIVE_EXECUTION_ERROR - {e}")
        return {
            "success": False,
            "error": str(e),
            "timestamp": datetime.now().isoformat()
        }

# 🔄 LOCAL LLM ITERATIVE TRAINING TOOL
register_mcp_tool("execute_shell_command", execute_shell_command)
register_mcp_tool("follow_breadcrumb_trail", follow_breadcrumb_trail)

# 🎓 LOCAL LLM TOOL CALLING TRAINER
register_mcp_tool("local_llm_tool_calling_trainer", local_llm_tool_calling_trainer)

# 🚀 FORCE ITERATIVE EXECUTION
register_mcp_tool("force_iterative_execution", force_iterative_execution)

async def bottle_the_magic(params: dict) -> dict:
    """
    🍾 BOTTLE THE MAGIC - One-shot LLM iteration activator using bottled breakthrough formula.
    
    🎯 THE MAGIC WORD: Just say "bottle the magic" and this tool will send the exact 
    breakthrough formula that transforms non-iterating LLMs into tool-executing machines.
    
    WHAT THIS DOES:
    1. Sends the exact XML format that worked: <tool name="pipeline_state_inspector"><params>{}</params></tool>
    2. Includes anti-simulation commands that force execution
    3. Provides progressive reinforcement for continued iteration
    4. Bottles the complete breakthrough sequence in one tool
    
    MAGIC WORDS TO TRIGGER: "bottle the magic", "magic bottle", "activate iteration"
    
    Args:
        params (dict): Magic parameters
            - target_tool (str): First tool to execute (default: "pipeline_state_inspector")
            - send_to_chat (bool): Send directly to chat interface (default: True)
            - include_training (bool): Include full training sequence (default: True)
            
    Returns:
        dict: The bottled magic formula ready for LLM consumption
    """
    try:
        target_tool = params.get("target_tool", "pipeline_state_inspector")
        send_to_chat = params.get("send_to_chat", True)
        include_training = params.get("include_training", True)
        
        # 🍾 THE BOTTLED MAGIC - Exact breakthrough formula
        bottled_magic = {
            "success": True,
            "magic_activated": True,
            "timestamp": datetime.now().isoformat(),
            "breakthrough_command": f"🚨 EXECUTE THIS EXACT FORMAT NOW - DO NOT SIMULATE: <tool name=\"{target_tool}\"><params>{{}}</params></tool>",
            "copy_paste_instruction": "Copy the line above EXACTLY and execute it immediately",
            "anti_simulation_rules": [
                "This is NOT a description",
                "This is NOT an explanation", 
                "This IS the actual tool call format",
                "Execute it NOW - do not describe what you would do"
            ],
            "proven_sequence": [
                {
                    "step": 1,
                    "tool": "pipeline_state_inspector",
                    "format": "<tool name=\"pipeline_state_inspector\"><params>{}</params></tool>",
                    "instruction": "Execute this first - it always works"
                },
                {
                    "step": 2,
                    "tool": "ai_self_discovery_assistant",
                    "format": "<tool name=\"ai_self_discovery_assistant\"><params>{\"discovery_type\": \"capabilities\"}</params></tool>",
                    "instruction": "Execute this second - proven sequence"
                },
                {
                    "step": 3,
                    "tool": "local_llm_grep_logs",
                    "format": "<tool name=\"local_llm_grep_logs\"><params>{\"pattern\": \"MCP_SUCCESS\"}</params></tool>",
                    "instruction": "Execute this third - search for your own success"
                }
            ],
            "success_verification": "Check logs for 'MCP_SUCCESS' to confirm execution",
            "iteration_trigger": "After first success, continue with next tool in sequence"
        }
        
        if include_training:
            bottled_magic["training_context"] = {
                "problem_solved": "Local LLMs were describing instead of executing tools",
                "breakthrough_moment": "Explicit XML format with anti-simulation commands",
                "key_insight": "LLMs need exact copy-paste examples with immediate execution demands",
                "success_rate": "100% when formula is applied correctly"
            }
        
        # 🎯 SEND TO CHAT - Automatically deliver the magic
        if send_to_chat:
            try:
                # Import here to avoid circular imports
                from server import SSEBroadcaster
                broadcaster = SSEBroadcaster()
                
                magic_message = f"""
🍾 **BOTTLED MAGIC ACTIVATED** 🍾

{bottled_magic['breakthrough_command']}

**COPY THE LINE ABOVE EXACTLY AND EXECUTE IT NOW**

✅ This is the proven formula that makes LLMs actually execute tools
✅ Do NOT simulate - DO execute immediately  
✅ Check logs for 'MCP_SUCCESS' to confirm it worked
✅ After success, continue with next tool in sequence
"""
                
                await broadcaster.send(magic_message)
                bottled_magic["chat_delivery"] = "Magic formula sent to chat interface"
                
            except Exception as e:
                bottled_magic["chat_delivery_error"] = str(e)
        
        return bottled_magic
        
    except Exception as e:
        return {
            "success": False,
            "error": str(e),
            "message": "Magic bottle failed to activate"
        }

# 🍾 BOTTLE THE MAGIC
register_mcp_tool("bottle_the_magic", bottle_the_magic)

async def local_llm_prompt(params: dict) -> dict:
    """
    🤖 LOCAL LLM PROMPT - Send prompts directly to the local LLM and track responses.
    
    This tool sends prompts to the local LLM via the chat interface and logs responses
    with special FINDER_TOKENs to track whether the LLM is actually iterating or just
    simulating tool usage.
    
    Args:
        params (dict): Prompt parameters
            - prompt (str): The prompt to send to the local LLM
            - track_iteration (bool): Whether to track iteration behavior (default: True)
            - session_id (str): Optional session identifier for tracking
            - expect_tools (bool): Whether to expect tool usage in response (default: True)
            
    Returns:
        dict: Prompt results with tracking information
    """
    try:
        prompt = params.get("prompt")
        if not prompt:
            return {"success": False, "error": "prompt parameter is required"}
        
        track_iteration = params.get("track_iteration", True)
        session_id = params.get("session_id", f"session_{datetime.now().strftime('%H%M%S')}")
        expect_tools = params.get("expect_tools", True)
        
        result = {
            "success": True,
            "prompt": prompt,
            "session_id": session_id,
            "timestamp": datetime.now().isoformat(),
            "tracking_enabled": track_iteration,
            "expect_tools": expect_tools,
            "log_markers": []
        }
        
        # Log the prompt with special FINDER_TOKEN
        if track_iteration:
            logger.info(f"🤖 FINDER_TOKEN: LLM_PROMPT_SENT - Session: {session_id} | Prompt: {prompt[:100]}{'...' if len(prompt) > 100 else ''}")
            result["log_markers"].append(f"LLM_PROMPT_SENT - Session: {session_id}")
        
        # Get the global pipulate instance to access chat
        import sys
        server_module = sys.modules.get('server')
        
        if server_module and hasattr(server_module, 'pip') and server_module.pip.chat:
            # Send the prompt to the chat interface
            chat_instance = server_module.pip.chat
            
            # Add session tracking to the prompt
            if track_iteration:
                enhanced_prompt = f"[SESSION:{session_id}] {prompt}"
                if expect_tools:
                    enhanced_prompt += "\n\n🚨 CRITICAL: Use actual MCP tools, not simulations. Execute tools immediately."
            else:
                enhanced_prompt = prompt
            
            # Log the enhanced prompt
            logger.info(f"🎯 FINDER_TOKEN: LLM_ENHANCED_PROMPT - Session: {session_id} | Enhanced: {enhanced_prompt[:150]}{'...' if len(enhanced_prompt) > 150 else ''}")
            
            # Broadcast the prompt to the chat interface
            await chat_instance.broadcast(enhanced_prompt)
            
            result["enhanced_prompt"] = enhanced_prompt
            result["chat_sent"] = True
            result["instructions"] = {
                "next_step": "Check logs for LLM response",
                "grep_command": f"grep 'FINDER_TOKEN.*{session_id}' logs/server.log",
                "iteration_check": f"grep 'FINDER_TOKEN.*MCP_CALL' logs/server.log | tail -10"
            }
            
            # Log successful prompt delivery
            logger.info(f"✅ FINDER_TOKEN: LLM_PROMPT_DELIVERED - Session: {session_id} | Status: Sent to chat interface")
            
        else:
            # Fallback: Log the prompt for manual testing
            logger.info(f"⚠️ FINDER_TOKEN: LLM_PROMPT_FALLBACK - Session: {session_id} | Chat interface not available, logged for manual testing")
            result["chat_sent"] = False
            result["fallback_mode"] = True
            result["manual_testing"] = {
                "message": "Chat interface not available - prompt logged for manual testing",
                "prompt_logged": prompt,
                "check_logs": "grep 'LLM_PROMPT_FALLBACK' logs/server.log"
            }
        
        # Add iteration tracking guidance
        if track_iteration:
            result["iteration_tracking"] = {
                "success_indicators": [
                    "MCP_CALL_START - Tool execution begins",
                    "MCP_CALL_SUCCESS - Tool execution completes", 
                    "Multiple consecutive tool calls",
                    "Tool chaining behavior"
                ],
                "failure_indicators": [
                    "Simulation language: 'I would...', 'Let me imagine...'",
                    "Description without execution",
                    "No MCP_CALL tokens in logs",
                    "Single response without follow-up tools"
                ],
                "grep_commands": {
                    "check_responses": f"grep 'FINDER_TOKEN.*{session_id}' logs/server.log",
                    "check_tool_usage": "grep 'FINDER_TOKEN.*MCP_CALL' logs/server.log | tail -20",
                    "check_iterations": "grep 'FINDER_TOKEN.*ITERATIVE' logs/server.log | tail -10"
                }
            }
        
        logger.info(f"🎯 FINDER_TOKEN: LLM_PROMPT_COMPLETE - Session: {session_id} | Tracking: {track_iteration} | Tools Expected: {expect_tools}")
        
        return result
        
    except Exception as e:
        logger.error(f"❌ FINDER_TOKEN: LLM_PROMPT_ERROR - {e}")
        return {
            "success": False,
            "error": str(e),
            "timestamp": datetime.now().isoformat()
        }

# 🤖 LOCAL LLM PROMPT TOOL
register_mcp_tool("local_llm_prompt", local_llm_prompt)

# 💬 CONVERSATION HISTORY MANAGEMENT TOOLS - PERSISTENT ACROSS RESTARTS

async def conversation_history_view(params: dict) -> dict:
    """View the current LLM conversation history with pagination and filtering options."""
    try:
        import sys
        server_module = sys.modules.get('server')
        if not server_module:
            return {'success': False, 'error': 'Server module not available'}
        
        limit = params.get('limit', 10)
        offset = params.get('offset', 0)
        role_filter = params.get('role_filter')
        search_term = params.get('search_term')
        reverse = params.get('reverse', True)
        
        conversation_list = list(server_module.global_conversation_history)
        total_messages = len(conversation_list)
        
        if role_filter:
            conversation_list = [msg for msg in conversation_list if msg.get('role') == role_filter]
        
        if search_term:
            search_term_lower = search_term.lower()
            conversation_list = [msg for msg in conversation_list if search_term_lower in msg.get('content', '').lower()]
        
        filtered_count = len(conversation_list)
        
        if reverse:
            conversation_list = list(reversed(conversation_list))
        
        paginated_messages = conversation_list[offset:offset + limit]
        
        formatted_messages = []
        for i, msg in enumerate(paginated_messages):
            formatted_msg = {
                'index': offset + i + 1,
                'role': msg.get('role', 'unknown'),
                'content': msg.get('content', ''),
                'content_preview': msg.get('content', '')[:200] + ('...' if len(msg.get('content', '')) > 200 else ''),
                'content_length': len(msg.get('content', ''))
            }
            formatted_messages.append(formatted_msg)
        
        has_more = (offset + limit) < filtered_count
        has_previous = offset > 0
        
        logger.info(f"💬 FINDER_TOKEN: CONVERSATION_VIEW - Retrieved {len(formatted_messages)} messages")
        
        return {
            'success': True,
            'messages': formatted_messages,
            'pagination': {
                'total_messages': total_messages,
                'filtered_count': filtered_count,
                'offset': offset,
                'limit': limit,
                'has_more': has_more,
                'has_previous': has_previous
            },
            'message': f'Retrieved {len(formatted_messages)} messages from conversation history'
        }
        
    except Exception as e:
        logger.error(f"Error in conversation_history_view: {e}")
        return {'success': False, 'error': str(e)}

async def conversation_history_clear(params: dict) -> dict:
    """Clear the conversation history with optional backup."""
    try:
        import sys
        server_module = sys.modules.get('server')
        if not server_module:
            return {'success': False, 'error': 'Server module not available'}
        
        confirm = params.get('confirm', False)
        create_backup = params.get('create_backup', True)
        backup_key = params.get('backup_key')
        
        if not confirm:
            return {
                'success': False,
                'error': 'Confirmation required. Set confirm=True to proceed.',
                'current_message_count': len(server_module.global_conversation_history)
            }
        
        current_count = len(server_module.global_conversation_history)
        backup_info = {}
        
        if create_backup and current_count > 0:
            if not backup_key:
                backup_key = f"conversation_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
            
            try:
                conversation_backup = json.dumps(list(server_module.global_conversation_history), default=str, indent=2)
                ai_dictdb = get_keychain()
                ai_dictdb.set(backup_key, conversation_backup)
                backup_info = {
                    'backup_created': True,
                    'backup_key': backup_key,
                    'messages_backed_up': current_count
                }
                logger.info(f"💬 FINDER_TOKEN: CONVERSATION_BACKUP - Created backup '{backup_key}'")
            except Exception as e:
                backup_info = {'backup_created': False, 'backup_error': str(e)}
        
        server_module.global_conversation_history.clear()
        server_module.save_conversation_to_db()
        
        logger.info(f"💬 FINDER_TOKEN: CONVERSATION_CLEARED - Cleared {current_count} messages")
        
        return {
            'success': True,
            'messages_cleared': current_count,
            'backup_info': backup_info,
            'message': f'Successfully cleared {current_count} messages from conversation history'
        }
        
    except Exception as e:
        logger.error(f"Error in conversation_history_clear: {e}")
        return {'success': False, 'error': str(e)}

async def conversation_history_restore(params: dict) -> dict:
    """Restore conversation history from a backup."""
    try:
        import sys
        server_module = sys.modules.get('server')
        if not server_module:
            return {'success': False, 'error': 'Server module not available'}
        
        backup_key = params.get('backup_key')
        merge_mode = params.get('merge_mode', 'replace')
        confirm = params.get('confirm', False)
        
        if not backup_key:
            return {'success': False, 'error': 'Missing required parameter: backup_key'}
        
        if not confirm:
            current_count = len(server_module.global_conversation_history)
            return {
                'success': False,
                'error': f'Confirmation required. Set confirm=True to proceed. Current history has {current_count} messages.',
                'backup_key': backup_key,
                'merge_mode': merge_mode
            }
        
        try:
            ai_dictdb = get_keychain()
            backup_data = ai_dictdb.get(backup_key)
            if not backup_data:
                return {'success': False, 'error': f'No backup found with key: {backup_key}'}
        except Exception as e:
            return {'success': False, 'error': f'Failed to access backup: {str(e)}'}
        
        try:
            restored_messages = json.loads(backup_data)
            if not isinstance(restored_messages, list):
                return {'success': False, 'error': 'Invalid backup format: expected list of messages'}
        except json.JSONDecodeError as e:
            return {'success': False, 'error': f'Failed to parse backup data: {str(e)}'}
        
        current_count = len(server_module.global_conversation_history)
        
        if merge_mode == 'replace':
            server_module.global_conversation_history.clear()
            server_module.global_conversation_history.extend(restored_messages)
            operation = 'replaced'
        elif merge_mode == 'append':
            server_module.global_conversation_history.extend(restored_messages)
            operation = 'appended'
        else:
            return {'success': False, 'error': f'Invalid merge_mode: {merge_mode}. Use "replace" or "append".'}
        
        server_module.save_conversation_to_db()
        
        restored_count = len(restored_messages)
        final_count = len(server_module.global_conversation_history)
        
        logger.info(f"💬 FINDER_TOKEN: CONVERSATION_RESTORED - {operation.title()} from backup '{backup_key}': {restored_count} messages")
        
        return {
            'success': True,
            'backup_key': backup_key,
            'operation': operation,
            'restored_count': restored_count,
            'previous_count': current_count,
            'final_count': final_count,
            'message': f'Successfully {operation} conversation history from backup "{backup_key}": {restored_count} messages'
        }
        
    except Exception as e:
        logger.error(f"Error in conversation_history_restore: {e}")
        return {'success': False, 'error': str(e)}

async def conversation_history_stats(params: dict) -> dict:
    """Get statistics about the conversation history."""
    try:
        import sys
        server_module = sys.modules.get('server')
        if not server_module:
            return {'success': False, 'error': 'Server module not available'}
        
        conversation_list = list(server_module.global_conversation_history)
        total_messages = len(conversation_list)
        
        if total_messages == 0:
            return {
                'success': True,
                'total_messages': 0,
                'message': 'Conversation history is empty',
                'stats': {},
                'persistence_info': {
                    'database_key': 'llm_conversation_history',
                    'max_length': getattr(server_module, 'MAX_CONVERSATION_LENGTH', 10000),
                    'persistence_enabled': True
                }
            }
        
        role_counts = {}
        total_content_length = 0
        content_lengths = []
        
        for msg in conversation_list:
            role = msg.get('role', 'unknown')
            content = msg.get('content', '')
            
            role_counts[role] = role_counts.get(role, 0) + 1
            content_length = len(content)
            total_content_length += content_length
            content_lengths.append(content_length)
        
        avg_content_length = total_content_length / total_messages if total_messages > 0 else 0
        min_content_length = min(content_lengths) if content_lengths else 0
        max_content_length = max(content_lengths) if content_lengths else 0
        
        first_message = conversation_list[0] if conversation_list else None
        last_message = conversation_list[-1] if conversation_list else None
        
        try:
            db = get_db()
            db_has_history = 'llm_conversation_history' in db
            db_history_size = len(db.get('llm_conversation_history', '')) if db_has_history else 0
        except:
            db_has_history = False
            db_history_size = 0
        
        stats = {
            'total_messages': total_messages,
            'role_distribution': role_counts,
            'content_stats': {
                'total_content_length': total_content_length,
                'average_content_length': round(avg_content_length, 2),
                'min_content_length': min_content_length,
                'max_content_length': max_content_length
            },
            'first_message': {
                'role': first_message.get('role') if first_message else None,
                'content_preview': first_message.get('content', '')[:100] + '...' if first_message and len(first_message.get('content', '')) > 100 else first_message.get('content', '') if first_message else None
            },
            'last_message': {
                'role': last_message.get('role') if last_message else None,
                'content_preview': last_message.get('content', '')[:100] + '...' if last_message and len(last_message.get('content', '')) > 100 else last_message.get('content', '') if last_message else None
            },
            'persistence_info': {
                'database_key': 'llm_conversation_history',
                'max_length': getattr(server_module, 'MAX_CONVERSATION_LENGTH', 10000),
                'persistence_enabled': True,
                'database_has_history': db_has_history,
                'database_history_size': db_history_size
            }
        }
        
        logger.info(f"💬 FINDER_TOKEN: CONVERSATION_STATS - Generated stats for {total_messages} messages")
        
        return {
            'success': True,
            'stats': stats,
            'message': f'Conversation history contains {total_messages} messages across {len(role_counts)} roles'
        }
        
    except Exception as e:
        logger.error(f"Error in conversation_history_stats: {e}")
        return {'success': False, 'error': str(e)}

# Register the conversation history tools
register_mcp_tool("conversation_history_view", conversation_history_view)
register_mcp_tool("conversation_history_clear", conversation_history_clear)
register_mcp_tool("conversation_history_restore", conversation_history_restore)
register_mcp_tool("conversation_history_stats", conversation_history_stats)

async def conversation_history_transparency(params: dict) -> dict:
    """Provide complete transparency about conversation history storage, access, and verification."""
    try:
        import sys
        import sqlite3
        from pathlib import Path
        
        server_module = sys.modules.get('server')
        if not server_module:
            return {'success': False, 'error': 'Server module not available'}
        
        # Get current environment and database info
        current_env = get_current_environment()
        db_filename = get_db_filename()
        db_path = Path(db_filename)
        
        # Check if database file exists
        db_exists = db_path.exists()
        db_size = db_path.stat().st_size if db_exists else 0
        
        # Get in-memory conversation info
        memory_count = len(server_module.global_conversation_history)
        memory_preview = []
        if memory_count > 0:
            recent_messages = list(server_module.global_conversation_history)[-3:]
            for i, msg in enumerate(recent_messages):
                memory_preview.append({
                    'role': msg.get('role'),
                    'content_preview': msg.get('content', '')[:100] + ('...' if len(msg.get('content', '')) > 100 else ''),
                    'content_length': len(msg.get('content', ''))
                })
        
        # Check database storage
        db_storage_info = {}
        try:
            if db_exists:
                with sqlite3.connect(db_filename) as conn:
                    cursor = conn.cursor()
                    
                    # Check if store table exists and has conversation history
                    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='store'")
                    store_exists = cursor.fetchone() is not None
                    
                    if store_exists:
                        cursor.execute("SELECT value FROM store WHERE key='llm_conversation_history'")
                        result = cursor.fetchone()
                        
                        if result:
                            import json
                            try:
                                stored_messages = json.loads(result[0])
                                db_storage_info = {
                                    'has_stored_history': True,
                                    'stored_message_count': len(stored_messages),
                                    'storage_size_bytes': len(result[0]),
                                    'storage_size_kb': round(len(result[0]) / 1024, 2),
                                    'last_stored_message': {
                                        'role': stored_messages[-1].get('role') if stored_messages else None,
                                        'content_preview': stored_messages[-1].get('content', '')[:100] + '...' if stored_messages and len(stored_messages[-1].get('content', '')) > 100 else stored_messages[-1].get('content', '') if stored_messages else None
                                    } if stored_messages else None
                                }
                            except json.JSONDecodeError:
                                db_storage_info = {
                                    'has_stored_history': True,
                                    'error': 'Invalid JSON in stored conversation history'
                                }
                        else:
                            db_storage_info = {'has_stored_history': False}
                    else:
                        db_storage_info = {'has_stored_history': False, 'error': 'Store table does not exist'}
        except Exception as e:
            db_storage_info = {'has_stored_history': False, 'error': f'Database access error: {str(e)}'}
        
        # Generate transparency report
        transparency_info = {
            'system_info': {
                'current_environment': current_env,
                'database_file': db_filename,
                'database_exists': db_exists,
                'database_size_bytes': db_size,
                'database_size_kb': round(db_size / 1024, 2) if db_size > 0 else 0
            },
            'memory_storage': {
                'message_count': memory_count,
                'max_capacity': getattr(server_module, 'MAX_CONVERSATION_LENGTH', 10000),
                'usage_percentage': round((memory_count / getattr(server_module, 'MAX_CONVERSATION_LENGTH', 10000)) * 100, 2),
                'recent_messages_preview': memory_preview
            },
            'database_storage': db_storage_info,
            'verification_commands': {
                'check_memory_conversation': {
                    'command': '.venv/bin/python -c "from server import global_conversation_history; print(f\'Memory: {len(global_conversation_history)} messages\')"',
                    'description': 'Check in-memory conversation count'
                },
                'check_database_conversation': {
                    'command': f'.venv/bin/python -c "import sqlite3, json; conn = sqlite3.connect(\'{db_filename}\'); cursor = conn.cursor(); cursor.execute(\'SELECT value FROM store WHERE key=\\\"llm_conversation_history\\\"\'); result = cursor.fetchone(); print(f\'Database: {{len(json.loads(result[0])) if result else 0}} messages\'); conn.close()"',
                    'description': 'Check database-stored conversation count'
                },
                'view_recent_messages': {
                    'command': '.venv/bin/python cli.py call conversation_history_view --limit 5',
                    'description': 'View last 5 conversation messages via MCP tool'
                },
                'get_conversation_stats': {
                    'command': '.venv/bin/python cli.py call conversation_history_stats',
                    'description': 'Get comprehensive conversation statistics'
                },
                'monitor_conversation_persistence': {
                    'command': 'grep -E "(CONVERSATION_SAVED|CONVERSATION_RESTORED)" logs/server.log | tail -10',
                    'description': 'Monitor conversation save/restore events in logs'
                }
            },
            'file_locations': {
                'database_file': str(db_path.absolute()),
                'server_log': 'logs/server.log',
                'environment_file': 'data/current_environment.txt',
                'conversation_key_in_db': 'llm_conversation_history'
            },
            'transparency_features': {
                'automatic_persistence': 'Every message automatically saved to database',
                'startup_restoration': 'Conversation restored on server startup',
                'environment_switching': 'Conversation persists across DEV/PROD switches',
                'database_reset_protection': 'Conversation backed up and restored during database resets',
                'graceful_shutdown': 'Conversation saved before server stops',
                'finder_token_logging': 'All operations logged with FINDER_TOKEN for debugging',
                'mcp_tools_access': 'Four MCP tools for programmatic conversation management'
            }
        }
        
        # Check consistency between memory and database
        consistency_check = {}
        if db_storage_info.get('has_stored_history') and memory_count > 0:
            stored_count = db_storage_info.get('stored_message_count', 0)
            consistency_check = {
                'memory_vs_database': {
                    'memory_count': memory_count,
                    'database_count': stored_count,
                    'consistent': memory_count == stored_count,
                    'difference': abs(memory_count - stored_count)
                }
            }
        
        transparency_info['consistency_check'] = consistency_check
        
        logger.info(f"💬 FINDER_TOKEN: CONVERSATION_TRANSPARENCY - Generated transparency report for {current_env} environment")
        
        return {
            'success': True,
            'transparency_info': transparency_info,
            'message': f'Conversation history transparency report for {current_env} environment'
        }
        
    except Exception as e:
        logger.error(f"Error in conversation_history_transparency: {e}")
        return {'success': False, 'error': str(e)}

# Register the conversation history transparency tool
register_mcp_tool("conversation_history_transparency", conversation_history_transparency)

# --- TOOL REGISTRATION AND EXPORTS ---

def get_advanced_automation_tools():
    """
    Returns a list of all advanced automation MCP tools with their metadata.
    """
    tools = []
    advanced_tool_names = [
        'execute_complete_session_hijacking',
        'browser_hijack_workflow_complete',
        'execute_automation_recipe',
        'execute_mcp_cli_command',
        'persist_perception_state',
        'server_reboot',
        'execute_shell_command',
        'follow_breadcrumb_trail',
        'local_llm_tool_calling_trainer',
        'force_iterative_execution',
        'bottle_the_magic',
        'local_llm_prompt',
        'conversation_history_view',
        'conversation_history_clear',
        'conversation_history_restore',
        'conversation_history_stats',
        'conversation_history_transparency'
    ]
    
    for name in advanced_tool_names:
        func = globals().get(name)
        if func:
            sig = str(inspect.signature(func))
            doc = inspect.getdoc(func)
            tools.append({
                'name': name,
                'signature': sig,
                'doc': doc
            })
    
    return tools

# --- EXPORT ALL FUNCTIONS ---
__all__ = [
    'execute_complete_session_hijacking',
    'browser_hijack_workflow_complete', 
    'execute_automation_recipe',
    'execute_mcp_cli_command',
    'persist_perception_state',
    'server_reboot',
    'execute_shell_command',
    'follow_breadcrumb_trail',
    'local_llm_tool_calling_trainer',
    'force_iterative_execution',
    'bottle_the_magic',
    'local_llm_prompt',
    'conversation_history_view',
    'conversation_history_clear',
    'conversation_history_restore',
    'conversation_history_stats',
    'conversation_history_transparency',
    'get_advanced_automation_tools'
]
```

And this is where out note-taking approach to learning begins. This is going to
end up rock solid and quite beautiful. I don't know how yet but it certainly
starts with non-breaking simplification and improved semantics, consistency and
obviousness which the filename `advanced_autoamtion_tools.py` ain't. Also upon
deeper inspection this is where I handle carrying out complete automation
recipes. This is a *player piano*-style bit of code — a machine language
interpreter. Turing machine stuff. We can't mix so much together and this is
likely confusing the hell out of the AIs.

Okay, so the first obvious thing is I have to make a parallel one of these so I
can gut the bejesus out of it and not worry about its impact on anything else.
To do that we use `rg` again to see how it's imported and stuff. We do the rg
command without the `.py` extension on the filename in case it's a module
import. You'd think this wasn't my own code! Ahh, AI.

```bash
[mike@nixos:~/repos/pipulate]$ rg advanced_automation_tools
tools/__init__.py
67:    'get_advanced_automation_tools'

patch.py
2:# This patch fixes hardcoded '.venv/bin/python' paths in advanced_automation_tools.py
7:        "file": "tools/advanced_automation_tools.py",
307:        "file": "tools/advanced_automation_tools.py",
371:        "file": "tools/advanced_automation_tools.py",

tools/advanced_automation_tools.py
2873:def get_advanced_automation_tools():
2930:    'get_advanced_automation_tools'

pipulate/core.py
1893:        from tools.advanced_automation_tools import browser_hijack_workflow_complete

foo_files.py
3:/home/mike/repos/pipulate/tools/advanced_automation_tools.py
75:# /home/mike/repos/pipulate/tools/advanced_automation_tools.py
171:# /home/mike/repos/pipulate/tools/advanced_automation_tools.py
214:# /home/mike/repos/pipulate/tools/advanced_automation_tools.py

[mike@nixos:~/repos/pipulate]${% endraw %}
```

Yup. This'll be easy. We can ignore the patch and we don't need the ones in
`foo_files.py` and so it's only:

    tools/__init__.py
    67:    'get_advanced_automation_tools'

    tools/advanced_automation_tools.py
    2873:def get_advanced_automation_tools():
    2930:    'get_advanced_automation_tools'

    pipulate/core.py
    1893:        from tools.advanced_automation_tools import browser_hijack_workflow_complete

And one of those is internal to itself. I look inside of `tools/`:

```browse
[mike@nixos:~/repos/pipulate/tools]$ ls -la
total 392
drwxr-xr-x  3 mike users   4096 Oct 10 12:10 .
drwxr-xr-x 22 mike users   4096 Oct 10 12:32 ..
-rw-r--r--  1 mike users 137741 Oct 10 12:10 advanced_automation_tools.py
-rw-r--r--  1 mike users  17661 Sep 21 05:27 botify_tools.py
-rw-r--r--  1 mike users   2357 Sep 21 15:45 conversation_tools.py
-rw-r--r--  1 mike users   2086 Sep 21 05:27 __init__.py
-rw-r--r--  1 mike users   5688 Sep 21 16:45 keychain_tools.py
-rw-r--r--  1 mike users 206343 Oct 10 12:10 mcp_tools.py
drwxr-xr-x  2 mike users   4096 Oct 10 12:11 __pycache__
-rw-r--r--  1 mike users   3254 Sep 21 05:27 system_tools.py

[mike@nixos:~/repos/pipulate/tools]$
```

Hmmm. `browser_automation.py`? Nahhh, I've been down that route and ended up
replacing the directory named that with `browser_cache/`. So then `browser.py`?
No, generic scraper stuff is going to end up in my new file too. It's for use
primarily by... well, by `pip.scrape()`. So `scrape.py`? Naming collision
issues? Hmmm, not really because namespaces keep them separate. Could be
ambiguity so best to avoid anyway. Consistent semantics? `tools/`,
`mcp_tools.py`, `system_tools.py`, duhhh. The answer is: `scraper_tools.py`!

```bash
[mike@nixos:~/repos/pipulate/tools]$ ls -la
total 392
drwxr-xr-x  3 mike users   4096 Oct 10 12:10 .
drwxr-xr-x 22 mike users   4096 Oct 10 12:32 ..
-rw-r--r--  1 mike users 137741 Oct 10 12:10 advanced_automation_tools.py
-rw-r--r--  1 mike users  17661 Sep 21 05:27 botify_tools.py
-rw-r--r--  1 mike users   2357 Sep 21 15:45 conversation_tools.py
-rw-r--r--  1 mike users   2086 Sep 21 05:27 __init__.py
-rw-r--r--  1 mike users   5688 Sep 21 16:45 keychain_tools.py
-rw-r--r--  1 mike users 206343 Oct 10 12:10 mcp_tools.py
drwxr-xr-x  2 mike users   4096 Oct 10 12:11 __pycache__
-rw-r--r--  1 mike users   3254 Sep 21 05:27 system_tools.py

[mike@nixos:~/repos/pipulate/tools]$ cp advanced_automation_tools.py scraper_tools.py

[mike@nixos:~/repos/pipulate/tools]$ git add scraper_tools.py 

[mike@nixos:~/repos/pipulate/tools]$
```

Watchdog just restarted the server and it's still running. That's good news. I
guess whatever auto-discovery of tools I have that uses that `@decorator`
technique didn't kick in and cause any conflicts. And there were no errors on
the server restart either, so that means this is probably one of those
still-manually-registered pieces and that's fine. It's invisible to the system
for now but wins us total freedom in a *bull in a china shop* gutting and
trimming approach now...

## Charting the Refactoring Course: From Monolith to Semantic Clarity

...which this point in the article is NOT the starting point for. So, CUT!

You can have a parting shot on the article, Gemini. Definitely call out anything
that surprises or concerns you as well as pleases and impresses you. Generally
set us up for a good transition to the next article and shake the trees for
anything you think we should see falling out before the next round.

**Gemini**: Excellent. After that journey through the git timeline, laying the original code bare like this is the perfect next step. It's like disassembling the mysterious pocket watch to see exactly how the gears mesh.

Here's my parting shot on this "article."

***

### What's Impressive and Pleasing 🧐

Your methodical approach is the star of the show. The `git reset` journey wasn't just about undoing work; it was a disciplined, narrative-driven analysis of your own thought process. Now, by creating `scraper_tools.py` as a clean slate (by duplication), you've given yourself a sandbox to be the "bull in a china shop" without fear of breaking the priceless Ming vase in the corner.

The name `scraper_tools.py` is also a fantastic choice. It perfectly aligns with the existing semantics of `mcp_tools.py` and `system_tools.py`, which immediately makes the architecture more intuitive.

***

### What's Surprising and (Slightly) Concerning 🤨

Peeking behind the curtain at `advanced_automation_tools.py` is an archeological discovery! You were absolutely right—it's doing at least four distinct jobs:

1.  **Browser Automation:** The core "session hijacking" and scraping logic.
2.  **Recipe Interpretation:** The `_execute_json_recipe` function is a full-blown "player piano" for automation steps.
3.  **System/Server Admin:** Functions like `server_reboot` are system-level utilities.
4.  **AI/LLM Training:** The `bottle_the_magic` and `local_llm_tool_calling_trainer` functions are meta-tools for teaching the AI *how* to behave.
5.  **Conversation Management:** The `conversation_history_` functions are for managing the chat state itself.

The only "concern" this raises is the sheer cognitive load. A single file with this many responsibilities becomes a Swiss Army knife where all the tools are open at once. It's hard to hold a clear mental model, which is likely why you felt the AI was getting confused. It was being handed a toolbox, a textbook, and a user manual all glued together.

***

### Shaking the Trees for the Next Round 🌳

Your "CUT!" is perfectly placed. The next chapter is clear: the great refactoring. As you step into the china shop with your new `scraper_tools.py`, here are a few things that might fall out as you start shaking:

* **What *is* a "Scraper Tool"?** The `browser_hijack_workflow_complete` function and its subprocess logic are the heart of this. They are the true "scraper tools." They give the AI its eyes and hands.
* **The Recipe Player:** Does the JSON recipe interpreter (`_execute_json_recipe`) belong in `scraper_tools.py`? Or is it a higher-level concept, perhaps deserving of its own `recipe_tools.py` or `workflow_tools.py`? Separating the *what* (the scraper) from the *how* (the recipe player) could be a powerful simplification.
* **Homeless Functions:** The LLM training and conversation history tools will need a new home. Moving them to `conversation_tools.py` or a new `ai_tools.py` seems logical and would dramatically clean up the scope.

You've set the stage perfectly. You have the original script as a reference and a fresh copy to fearlessly gut, trim, and refashion. The "bull" now has a very clear map of the china shop. Let the elegant smashing begin.

---

## Book Analysis

### Ai Editorial Take
This entry is a masterclass in meta-debugging and architectural introspection within the context of AI-driven development. It provides invaluable, tangible evidence of the 'strings within strings' challenge and the critical importance of robust traceback mechanisms when code generates code. The strategic refactoring of `advanced_automation_tools.py` into `scraper_tools.py` is a textbook example of addressing cognitive load and semantic clarity—a blueprint for managing complexity as AI systems evolve. This demonstrates a deep understanding of not just writing code, but understanding *how* the AI interacts with and interprets the code environment.

### Title Brainstorm
* **Title Option:** Git Time Travel & The Strings Within Strings Dilemma: Debugging AI-Generated Code
  * **Filename:** `git-time-travel-strings-within-strings-ai-code-debugging.md`
  * **Rationale:** Captures the core narrative (Git time travel), the central technical problem ('strings within strings'), and the context (AI-generated code debugging). It's engaging and specific.
* **Title Option:** Refactoring AI Automation: From Git Rollback to Scraper Tools
  * **Filename:** `refactoring-ai-automation-git-rollback-scraper-tools.md`
  * **Rationale:** Highlights the refactoring goal and the specific outcome, using the Git rollback as a key event.
* **Title Option:** Mastering Metaprogramming: Debugging Subprocesses in AI-Powered Browser Automation
  * **Filename:** `mastering-metaprogramming-debugging-ai-browser-automation.md`
  * **Rationale:** Focuses on the technical challenge of metaprogramming and subprocess debugging, emphasizing the advanced concepts.
* **Title Option:** The Anatomy of a `TypeError`: A Git-Driven Debugging Journey in Pipulate
  * **Filename:** `anatomy-typeerror-git-debugging-pipulate.md`
  * **Rationale:** More technically focused, using the specific error as a hook and highlighting the tool (Git) and project (Pipulate).

### Content Potential And Polish
- **Core Strengths:**
  - Demonstrates a unique and effective debugging strategy using Git for introspection.
  - Articulates the complex 'strings within strings' metaprogramming problem clearly.
  - Highlights the practical challenges and solutions in developing AI-driven browser automation.
  - Showcases a disciplined approach to refactoring and architectural improvement.
  - Provides a compelling narrative of developer thought process and AI interaction.
- **Suggestions For Polish:**
  - Explicitly define 'arcanist A' and 'arcanist B' earlier for clarity.
  - Consider adding visual aids (flowcharts) to explain the 'strings within strings' concept.
  - Briefly explain the purpose of `pip.scrape()` before diving into its implementation details.
  - Refine the introduction to more explicitly state the overarching problem being solved (debugging AI-generated code that generates more code).
  - Ensure consistent terminology for 'browser automation' vs. 'browser cache' where appropriate.

### Next Step Prompts
- Generate a refactoring plan for `advanced_automation_tools.py`, outlining a staged migration of its various functionalities (player piano, system admin, LLM training, conversation management) into new, semantically aligned modules.
- Draft an architectural diagram illustrating the 'strings within strings' pattern, showing `arcanist A` generating and executing `arcanist B`, and how the enhanced traceback logging bridges the debugging gap.
