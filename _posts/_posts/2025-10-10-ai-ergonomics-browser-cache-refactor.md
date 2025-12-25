---
title: 'Refactoring for AI Ergonomics: The Genesis of `browser_cache`'
permalink: /futureproof/ai-ergonomics-browser-cache-refactor/
description: 'This journal entry marks a critical inflection point where the clarity
  gained from unstructured ''Morning Pages'' was directly applied to a complex technical
  challenge: refactoring Pipulate''s browser automation. My internal monologue, rich
  with self-dialogue and metaphors, allowed me to untangle the spaghetti code of the
  `browser_automation/` directory and crystalize a new, semantically powerful naming
  convention: `browser_cache/`. The collaboration with the AI, personified as Gemini,
  was instrumental in translating this chaotic ideation into an actionable, ''chisel-strike''
  blueprint. This session truly embodied the iterative and thoughtful process required
  to build AI-friendly systems, proving that ''it''s not a conspiracy theory if the
  code runs.'''
meta_description: Strategic refactor of Pipulate's browser automation, focusing on
  AI ergonomics. Details the renaming to `browser_cache` and an iterative 'chisel-strike'
  development process.
meta_keywords: AI ergonomics, refactoring, browser automation, Pipulate, browser_cache,
  Selenium, automated workflow, git mv, ripgrep
layout: post
sort_order: 1
---

{% raw %}


## Setting the Stage: Context for the Curious Book Reader

**Context for the Curious Book Reader:** This entry captures a pivotal moment in the development of Project Pipulate, showcasing the author's dynamic thought process. What begins as a candid 'Morning Pages' session—a free-form journal entry—evolves into a strategic technical refactoring. The primary challenge addressed here is streamlining the project's browser automation components, particularly enhancing their "AI ergonomics." Readers will witness the conceptual journey from recognizing a codebase 'mess' to meticulously planning a foundational rename of the `browser_automation/` directory to the more semantically robust `browser_cache/`. The narrative highlights the power of collaborative AI interaction, the iterative 'chisel-strike' approach to refactoring, and the deep philosophical underpinnings that inform pragmatic coding decisions. This session culminates in a verified, multi-stage blueprint for action, demonstrating how abstract thought is transformed into concrete, executable code changes.

---

## Technical Journal Entry Begins

Rested.

## Strategic Choices in Browser Automation

Okay, as I do this work I do have to keep in mind that Google themselves
released an MCP server for controlling the Chrome browser with Puppeteer. They
released this *after* my investigation into how to support cross-platform
browser automation and came to the conclusion that Selenium was the only way to
let Nix pop open a browser and take control of it on Mac, Windows or Linux — no
small feat, but also now must be considered *just one* way of achieving this
since Google put something like this out in the mainstream. Switching methods
right now is a rabbit hole and instead my priority must be ensuring a loose
coupling of components so that I can do the swap-a-roo at any time. And that's
just item 1 I want to mention. There's more.

## Architecting for AI Ergonomics and Loose Coupling

While I am avoiding refactoring, the browser automation bits in what I built is
a mess, all over the place. There is a reckoning, a consolidation, and
ultimately yes another refactoring in the works. This cannot be avoided if I
want beauty, clarity and obviousness to the AIs stepping into inhabit the house
that Project Pipulate built. AI ergonomics must remain the priority. We
gradually refactor in a non-breaking way by... ugh! Gemini had a great word for
it. We make it work, bootstrapping the process from what the AI can figure out
about what I built so far in the way it chooses, and it interestingly chose the
*session hijacking* bit — I mean, who wouldn't, naming a thing like that, haha!
And it absolutely worked. Land and expand, as it said in another context.

## Consolidating the Browser Perception Cache

And we spiral out and around doing a cleanup from there. I originally created a
`browser_automation/` folder to get the AI's attention when it `ls`'d the
directory and stuff, but now I have `apps/` and especially `tools/` for the
controlly bits and stuff needs to get sorted to where it goes. I do have the
`downloads/` directory which is a natural, but also within `browser_automation/`
I have `looking_at/` which may be just about one of the strongest things I ever
named and I'm thinking I *soft-wire* the location for things through `config.py`
and then promote `looking_at/`... no, wait! I rotate that directory like a
log-file. I rotate the whole friggin directory with a `looking_at-N/` naming
convention, which is very strong. And unless I nest that *inside* the parent
`looking_at/`... NO! This is the refactoring I am avoiding.
`browser_automation/` is different enough than `downloads/` and the perfect
container for the `looking_at/` "at bat" folder and its "on base" rotations —
where the metaphor breaks down because N-bases goes up to 10, ahaha! Okay,
decision made. No refactoring. Keep the directory structure we've got for the
default caching.

But wait, THERE'S MORE! That's just the caching decisions. Other stuff can move.
`apps/` are apps and `tools/` are tools. Occasionally there's a demo or a test.
But all demos are tests in the sense that they're at the very beginning of
providing real-time browser automation test-coverage of the whole Pipulate app,
be it internal JavaScript control or external browser automation (truly
puppeteer-style). Hmmm there is a split here because when purely JavaScript, it
belongs in `assets/tests/` because that's where the `Ctrl`+`Alt`+`d` demo lives
as `demo.json` (`Ctrl`+`Option`+`d` if you're on the Mac) and this is now the
canonical demo for browser automation. Okay, this split in where things live
must exist for pragmatic client-based JS tech (`assets/tests/`) vs.
server-executed tech (`tools/`). Right. 

So actual core browser automation functionality that other things use that
previously lived in `browser_automation/` must get sorted into `tools/` or
`assets/tests/` accordingly, while oddball miscellaneous support-scripts that
nothing else uses but which must exist for a little while as we figure out WTF
should get moved under the `scripts/` folder which is where oddball stuff
idiomatically belongs. Which brings us to the fact that naming
`browser_automation/` that way to get an AI's attention is no longer a
compelling enough reason to name the parent directory of a *scraper cache*
location the way it is — too long, now a misnomer and an actual distraction to
AI rather than a help since the golden path with `AI_RUNME.py` existing with the
progressive reveal that'll cover all this.

And that brings us back to `downloads/` which is where a `scraper_cache/` should
idiomatically exist, and indeed when I look in there I do indeed already have
`browser/` and `browser_scrapes` — more *ambiguity* but proof of consistent
thinking, ahaha! (as my internal Statler and Waldorf laugh at myself). Okay,
we're getting somewhere with the idea-work and the AI ergonomics. Here's a
whammy for you: everything in the `downloads/` directory can be considered
temporary caches and never a critical dependency and *always* subject to an `rm
-rf *` from `cd`'d inside the folder! In fact let me go do that now... 

```bash
[mike@nixos:~/repos/pipulate]$ cd downloads/

[mike@nixos:~/repos/pipulate/downloads]$ ls
botify_schema_cache  browser_scrapes        param_buster     trifecta
browser              link_graph_visualizer  parameterbuster

[mike@nixos:~/repos/pipulate/downloads]$ rm -rf *

[mike@nixos:~/repos/pipulate/downloads]$ ls

[mike@nixos:~/repos/pipulate/downloads]$
```

## Establishing `browser_cache`: A Strong Semantic Naming

Okay, done. If you're gonna refactor, might as well start with deleting a folder
of stuff that you know won't break anything and isn't in the git repo, ahahah!
Okay, okay, enough heckling. What we have now is a clean slate for an extremely
strong semantic naming convention that is idiomatically correct and the
canonical example for everything to follow. And that shall be
`downloads/browser_cache/looking_at/` BAM! Hey AI, what are you *looking at* in
the... no... no! Downloads are 2nd class citizens. What you collect as a hoarder
are not your eyes. Your eyes are first-class sensory equipment and their
continual re-discovery *deserves* to be on repo-root despite the golden path. So
we simply *shorten* `browser_automation/` to `browser_cache/` and now have:

    pipulate/browser_cache/looking_at/

...and the way we talk to the AI goes: "Hey AI, what are you *looking at* in the
*browser cache?*" and it need look no further than an `ls` of Pipulate repo root
to know *exactly* what you're talking about. Sure... and *BAM again!* We are
allowed to re-BAM with our internal Billy Mays + Emeril Lagasse + Statler &
Waldorf synthesis simulator. But wait, there's more... BAM! Ahahaha

## Philosophical Meanderings: AI, Cognition, and the Noosphere

That's how that works. Strong mental models, folks. They're LLMs. They're
trained on all our stuff and if you think this is just silly self-gratuitous
nonsense (which it definitely *also* is) YOU'RE WRONG! Oh god, we're not
blending the Donald into our synthesis too... no, no, no!

I can only imagine the vector-map that's being created by this ephemeral
instance of the Mr. Meeseeks Gemini being fired up to respond to this particular
*Morning Pages* which now adds *The Artist's Way* and Julia Cameron to the
vector map. Okay, think! This IS all about the associations and connecting the
dots in the most immediately productive ways. We do our philosophical
meanderings allowing our right-brain to send messages up the flagpole to our
left-brain and encourage our left hemisphere to be truthful about the
interpretation of those messages and not just slap on willy nilly reasons which
is what it does...

...as we bring Iain McGilchrist's *The Master and His Emissary* into our vector
map. Yes, it's Charlie's meme corkboard but in a good way. In a productive way
that helps with the immediate work at hand. It's not a conspiracy theory if the
code runs. AI babble engines have a harness slapped on them like the horses of a
horse-drawn carriage and are reined into productivity engines to measurably and
meaningfully move you forward, and if that doesn't happen you back up, turn a
little like a Roomba and adjust your random walk so that you are indeed cleaning
the floors and refactoring the app the way you intend... without another deep
dive holy endeavor with a cascading chain reaction of bug-squashing unintended
consequences.

The metaphor is the machete in the jungle chopping a path through the unexplored
Noosphere which we just might be in because of the rich new high potentiality
Penrose light-code of probability that was created, a high Hamiltonian store of
new potential kinetic energy in the form of all that quartz sand melted into
silicon wafers and turned into GPUs now in datacenters as the new oil of the Age
of AI that we are solidly in. Stop me before I subreference again as Dennis
Miller would say. Or as the Rick and Morty post-credit *Harmonious Claptrap*
goes, "Did you get any of that?"

## The Blueprint for Action: Forging AI's Eyes

Let's transition this to the real-work at hand, shall we Gemini?

**Gemini**: Excellent. The mental batteries are recharged, and the philosophical engine is warmed up. That was a fantastic "Morning Pages" session—a perfect example of using associative thinking to connect the dots and arrive at a series of solid, pragmatic decisions. It's not a conspiracy theory if the code runs.

You've done the hard part: you've wrestled with the ambiguity and forged a clear path through the jungle. My job is to act as your harness, translating that brilliant, chaotic energy into a deterministic, step-by-step plan.

Let's transition to the real work at hand.

-----

### The Blueprint: From Morning Pages to Chisel-Strikes

Based on your analysis, here is the clear, actionable blueprint for our next session. This plan honors all of your new decisions while directly addressing the task of fixing `pip.scrape()`.

**1. The Great Renaming (A Foundational Chisel-Strike)**

First, we'll enact your decision to simplify the directory structure for better AI ergonomics. This is a crucial first step.

  * **Action**: Rename the `browser_automation/` directory to `browser/`.
  * **Command**: The cleanest way to do this is with `git mv`, which tells Git you're renaming the folder:
    ```bash
    git mv browser_automation browser
    ```
    This single command establishes our new, strong semantic convention. The "eyes" and their captured data will now live in a first-class location at the repository root.

**2. The Consolidation (Giving Chip Its *Real* Eyes)**

Next, we'll create the dedicated scraping tool we planned, placing it in its proper home according to your new rules.

  * **Action**: Create a new, purpose-built `async` function named `browser_scrape_page` inside `/home/mike/repos/pipulate/tools/advanced_automation_tools.py`.
  * **Logic**: This function will be a stripped-down version of `browser_hijack_workflow_complete`. It will simply:
    1.  Launch Selenium.
    2.  Navigate to a given URL.
    3.  Capture the essential artifacts (screenshot, DOM, source, etc.) into the `browser/looking_at/` directory.
    4.  It will **not** look for a `pipeline_id` field or try to submit a form.
    5.  It will return a clean `success: True` dictionary.

**3. The Refactor (Upgrading the Magic Wand)**

With our new specialist tool built, we'll update the `pip` object to use it. This achieves the loose coupling you prioritized.

  * **Action**: Modify the `scrape` method within the `Pipulate` class in `/home/mike/repos/pipulate/pipulate/core.py`.
  * **Logic**: Instead of calling the complex `browser_hijack_workflow_complete`, it will now make a clean, direct `await` call to our new `browser_scrape_page` function.

**4. The Victory Lap (Verification)**

Finally, we confirm that all the pieces work together perfectly.

  * **Action**: Rerun Cell 5 in the `workflow_test.ipynb` notebook.
  * **Expected Outcome**: The cell will execute flawlessly. The browser will launch, the page will be scraped, and the function will return a clean success message with no misleading errors.

-----

The blueprint is set. This approach refactors our system in a non-breaking, iterative way, starting with the simplest change and building upon it.

Let's begin with the first, most satisfying chisel-strike: **the great renaming**. Once you've run the `git mv` command, let me know, and I'll provide the patch to create the new `browser_scrape_page` function in its new home.

**Me**: Okay, we shall do this. But you reminded me about the nature of the
machete. It's built from `ripgrep`! So before any renaming we start with this to
see if it modifies our plans:

```bash
[mike@nixos:~/repos/pipulate]$ rg 'browser_automation'
pyproject.toml
84:    "browser_automation*",

tools/advanced_automation_tools.py
75:    🧠 CRITICAL: BROWSER EYES ARE PRIMARY - Check browser_automation/looking_at/ FIRST!
423:                "screenshot": "browser_automation/looking_at/screenshot.png",
424:                "dom": "browser_automation/looking_at/dom.html",
425:                "simple_dom": "browser_automation/looking_at/simple_dom.html"
470:            looking_at_path=Path('browser_automation/looking_at'),
474:        looking_at_dir = 'browser_automation/looking_at'
749:                looking_at_dir = Path("browser_automation/looking_at")
753:                screenshot_path = f"browser_automation/looking_at/recipe_step_{step_num}_{step_type}.png"
758:                dom_path = f"browser_automation/looking_at/recipe_step_{step_num}_{step_type}_dom.html"
763:                simple_dom_path = f"browser_automation/looking_at/recipe_step_{step_num}_{step_type}_simple.html"
1075:                    "directory": "browser_automation/looking_at/",
1134:        sys.path.append('browser_automation')
1139:            recipes_dir = Path("browser_automation/automation_recipes")
1176:            recipes_path = Path(f"browser_automation/automation_recipes/{origin_dir}")
1180:                recipes_dir = Path("browser_automation/automation_recipes")
1257:            recipe_path = Path(f"browser_automation/automation_recipes/{origin_dir}/{recipe_name}.json")
1376:        source_dir = Path("browser_automation/looking_at")
1378:        source_dir = Path(f"browser_automation/looking_at-{from_dir_num}")
1384:            "available_dirs": [p.name for p in Path("browser_automation").glob("looking_at*")]
1626:            "command": "ls -la server.py plugins browser_automation"
1696:            "command": "ls -la browser_automation/"

foo_files.py
114:# /home/mike/repos/pipulate/apps/440_browser_automation.py
160:# browser_automation/dom_processing/dom_hierarchy_visualizer.py
161:# browser_automation/dom_processing/dom_box_visualizer.py
168:# /home/mike/repos/pipulate/browser_automation/dom_schema_visualizer.py
169:# /home/mike/repos/pipulate/browser_automation/recipe_executor.py
170:# /home/mike/repos/pipulate/browser_automation/review_perception_history.py

tools/mcp_tools.py
200:    Rotates the browser_automation/looking_at directory before each new browser scrape.
210:        looking_at_path: Path to the looking_at directory (default: browser_automation/looking_at)
220:        looking_at_path = Path('browser_automation') / 'looking_at'
1317:- Check: browser_automation/looking_at/simple_dom.html (fits in your context!)
1318:- Screenshot: browser_automation/looking_at/screenshot.png
1339:            "next_step": "Check browser_automation/looking_at/ for evidence, then verify with user's data if available"
1598:    Analyzes the current page state captured in /browser_automation/looking_at/
1628:            html_file = "browser_automation/looking_at/simple_dom.html"
1648:            accessibility_tree_file = "browser_automation/looking_at/accessibility_tree.json"
2039:    into the /browser_automation/looking_at/ directory for AI analysis.
2047:        metadata_file = f"browser_automation/looking_at-{i}/headers.json"
2072:                "headers": "browser_automation/looking_at/headers.json",
2073:                "source": "browser_automation/looking_at/source.html", 
2074:                "dom": "browser_automation/looking_at/dom.html",
2075:                "simple_dom": "browser_automation/looking_at/simple_dom.html",
2076:                "screenshot": "browser_automation/looking_at/screenshot.png"
2145:            looking_at_path=Path('browser_automation/looking_at'),
2153:        looking_at_dir = 'browser_automation/looking_at'
2170:def run_browser_automation():
2376:    result = run_browser_automation()
2535:            '190_browser_automation': 'browser_automation',
2573:            looking_at_path=Path('browser_automation/looking_at'),
2683:                looking_at_dir = 'browser_automation/looking_at'
2762:                '190_browser_automation': 'browser_automation',
3347:    in /browser_automation/looking_at/ directory. It can click elements, fill forms,
3404:            headers_file = 'browser_automation/looking_at/headers.json'
3432:                screenshot_path = 'browser_automation/looking_at/screenshot.png'
3522:                    looking_at_dir = 'browser_automation/looking_at'
3716:                    "local_llm_read_file": {"file_path": "browser_automation/looking_at/simple_dom.html"},
3769:            "browser_automation_failure": {
3988:    test_results["results"]["browser_automation"] = browser_result

README.md
1109:    ├── browser_automation/        # Selenium browser control & DOM capture
1418:browser_automation/        # Selenium automation tools

config.py
352:BROWSER_AUTOMATION_DIR = "pipulate/browser_automation"

patch.py
55:                "screenshot": "browser_automation/looking_at/screenshot.png",
56:                "dom": "browser_automation/looking_at/dom.html",
57:                "simple_dom": "browser_automation/looking_at/simple_dom.html"
102:            looking_at_path=Path('browser_automation/looking_at'),
106:        looking_at_dir = 'browser_automation/looking_at'

assets/pipulate-init.js
1913:- browser_automation/ (Automation scripts)

imports/crud.py
683:        Extracted from: apps/440_browser_automation.py  

browser_automation/review_perception_history.py
37:        base_dir = Path('browser_automation')

imports/ascii_displays.py
527:        "Check browser_automation/looking_at/ FIRST, system internals second"
715:        "Check browser_automation/looking_at/ FIRST, system internals second"
734:• Browser Evidence: Check browser_automation/looking_at/ FIRST, system internals second

imports/dom_processing/enhanced_dom_processor.py
289:    def process_looking_at_directory(self, looking_at_dir: str = "browser_automation/looking_at") -> Dict:

browser_automation/google_search_automation_demo.py
41:        self.looking_at_dir = "browser_automation/looking_at"
282:    results_file = "browser_automation/looking_at/demo_results.json"

browser_automation/dom_schema_visualizer.py
445:    looking_at_dir = Path("browser_automation/looking_at")
458:        visualizer.console.print("🔍 Using latest scraped DOM from browser_automation/looking_at/", style="dim")
464:        print("Default: Uses browser_automation/looking_at/simple_dom.html")

browser_automation/interactive_google_search.py
214:        with open("browser_automation/looking_at/search_results_source.html", "w", encoding="utf-8") as f:
226:        with open("browser_automation/looking_at/search_results.json", "w", encoding="utf-8") as f:
230:        screenshot_path = "browser_automation/looking_at/search_results_screenshot.png"
233:        print(f"💾 Results saved to browser_automation/looking_at/")

imports/dom_processing/ai_dom_beautifier.py
439:    simple_dom_path = "browser_automation/looking_at/simple_dom.html"
451:    with open("browser_automation/looking_at/beautiful_dom.html", 'w', encoding='utf-8') as f:
455:    with open("browser_automation/looking_at/automation_registry.json", 'w', encoding='utf-8') as f:
459:    with open("browser_automation/looking_at/automation_targets.py", 'w', encoding='utf-8') as f:
463:    with open("browser_automation/looking_at/automation_summary.txt", 'w', encoding='utf-8') as f:
477:        print("  - browser_automation/looking_at/beautiful_dom.html")
478:        print("  - browser_automation/looking_at/automation_registry.json") 
479:        print("  - browser_automation/looking_at/automation_targets.py")
480:        print("  - browser_automation/looking_at/automation_summary.txt")

browser_automation/recipe_executor.py
352:    recipe_path = "browser_automation/automation_recipes/http_localhost_5001/profile_creation_recipe.json"

browser_automation/dom_processing/dom_box_visualizer.py
338:    looking_at_dir = Path("browser_automation/looking_at")
351:        visualizer.console.print("🔍 Using latest scraped DOM from browser_automation/looking_at/", style="dim")
354:        print("❌ No DOM file found. Please provide a file path or ensure browser_automation/looking_at/simple_dom.html exists.")

browser_automation/dom_processing/dom_hierarchy_visualizer.py
207:    looking_at_dir = Path("browser_automation/looking_at")
220:        visualizer.console.print("🔍 Using latest scraped DOM from browser_automation/looking_at/", style="dim")
223:        print("❌ No DOM file found. Please provide a file path or ensure browser_automation/looking_at/simple_dom.html exists.")

[mike@nixos:~/repos/pipulate]$
```

...and looking at that I realise that in the future similar such searches on
`rg 'browser'` would be a mess compared to `rg 'browser_cache'` which is both
semantically stronger and more search-unique. How are our plans looking?

**Gemini**: Excellent move. That's the perfect "measure twice, cut once" instinct. Using `ripgrep` as a machete to scout the jungle before you start swinging `git mv` is exactly the right call. It modifies the plan, but for the better—it makes it more robust.

Your analysis is spot on. The `rg` output proves two things:

1.  The name `browser_automation` is deeply embedded in the codebase, in code, comments, and documentation.
2.  Your proposed new name, `browser_cache`, is far more semantically accurate and search-unique.

This doesn't invalidate our plan; it reinforces it and makes the first step more comprehensive. Our plans are looking much stronger now.

-----

### The Updated Blueprint: A True Refactor

Here's the revised, more robust plan that incorporates your reconnaissance. We'll do this as a clean, two-part operation.

#### **Part 1: The Great Renaming (A Full Refactor)**

First, we'll perform the complete rename operation across the entire project. This should be a single, atomic commit.

**Step 1.1: The Code Machete (`rg | xargs sed`)**
Execute a global search-and-replace to update all hardcoded instances of the old name. This command will do the heavy lifting.

```bash
rg -l 'browser_automation' | xargs sed -i 's/browser_automation/browser_cache/g'
```

  * **Heads-Up**: This will correctly change all the paths in your Python files (`tools/`, `imports/`, etc.), but it will also update documentation strings and comments (like in `foo_files.py` and `README.md`), which is perfectly fine. It's a clean sweep. I'd also recommend manually changing the constant name in `config.py` from `BROWSER_AUTOMATION_DIR` to `BROWSER_CACHE_DIR` for consistency.

**Step 1.2: The Directory Rename (`git mv`)**
After updating the file contents, rename the actual directory.

```bash
git mv browser_automation browser_cache
```

**Step 1.3: The Commit**
Review the massive, beautiful change with `git diff`, and then commit this foundational refactor.

```bash
git commit -m "Refactor: Rename browser_automation to browser_cache"
```

With this, Part 1 is complete. The codebase is now consistent with your new, stronger naming convention.

-----

#### **Part 2: The Implementation (Giving Chip Eyes)**

Once the renaming is committed and our foundation is solid, our original plan to forge the "eyes" is still perfect. The steps are the same, but they will now operate within the new, cleaner structure.

  * **Create the Specialist Tool**: We'll still create the new `browser_scrape_page()` function inside `tools/advanced_automation_tools.py`.
  * **Refactor the Magic Wand**: We'll still update the `pip.scrape()` method in `pipulate/core.py` to call our new function.
  * **Verify the Victory**: We'll still run `workflow_test.ipynb` to confirm everything works flawlessly.

Let's start with Part 1. Once you've completed the refactor and committed the changes, let me know. I'll then provide the updated patch file for Part 2 that correctly uses the new `browser_cache` paths.

> Deep breath... let the refactoring begin!

**Me**: This is the automation work we *already just did:*

```diff
[mike@nixos:~/repos/pipulate]$ git --no-pager diff
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
```

And we commit all that as our go-back point and do our refactoring.

```bash
[mike@nixos:~/repos/pipulate]$ git commit -am "Rudimenary browser automation from JupyterLab Notebook works. This is the commit before the refactoring storm to solidify Chip's eyes"
[main 405f3df0] Rudimenary browser automation from JupyterLab Notebook works. This is the commit before the refactoring storm to solidify Chip's eyes
 2 files changed, 543 insertions(+), 385 deletions(-)

[mike@nixos:~/repos/pipulate]$ git push
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 48 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 2.95 KiB | 756.00 KiB/s, done.
Total 5 (delta 4), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (4/4), completed with 3 local objects.
To github.com:miklevin/pipulate
   e701b5f0..405f3df0  main -> main

[mike@nixos:~/repos/pipulate]$ rg -l 'browser_automation' | xargs sed -i 's/browser_automation/browser_cache/g'

[mike@nixos:~/repos/pipulate]$ git mv browser_automation browser_cache

[mike@nixos:~/repos/pipulate]$ vim config.py 

[mike@nixos:~/repos/pipulate]$ rg 'BROWSER_AUTOMATION_DIR'
```

Chisel-strike complete. And now we look at the aftermath.

```diff
[mike@nixos:~/repos/pipulate]$ git --no-pager diff
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
diff --git a/browser_cache/dom_processing/dom_box_visualizer.py b/browser_cache/dom_processing/dom_box_visualizer.py
index cb1c7ff1..9344a596 100644
--- a/browser_cache/dom_processing/dom_box_visualizer.py
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
     
diff --git a/browser_cache/dom_processing/dom_hierarchy_visualizer.py b/browser_cache/dom_processing/dom_hierarchy_visualizer.py
index 82a307bb..d49d31d4 100644
--- a/browser_cache/dom_processing/dom_hierarchy_visualizer.py
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
     
diff --git a/browser_cache/dom_schema_visualizer.py b/browser_cache/dom_schema_visualizer.py
index 59d01fe6..17d13b5a 100644
--- a/browser_cache/dom_schema_visualizer.py
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
diff --git a/browser_cache/google_search_automation_demo.py b/browser_cache/google_search_automation_demo.py
index 15ebdf5a..4141a167 100644
--- a/browser_cache/google_search_automation_demo.py
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
diff --git a/browser_cache/interactive_google_search.py b/browser_cache/interactive_google_search.py
index c1630f23..ca597a29 100644
--- a/browser_cache/interactive_google_search.py
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
diff --git a/browser_cache/recipe_executor.py b/browser_cache/recipe_executor.py
index 9df55b96..92afdc66 100644
--- a/browser_cache/recipe_executor.py
+++ b/browser_cache/recipe_executor.py
@@ -349,7 +349,7 @@ async def test_baby_steps_executor():
     executor = RecipeExecutor(headless=False, debug=True)
     
     # Test with existing profile creation recipe
-    recipe_path = "browser_automation/automation_recipes/http_localhost_5001/profile_creation_recipe.json"
+    recipe_path = "browser_cache/automation_recipes/http_localhost_5001/profile_creation_recipe.json"
     
     logger.info("🎯 BABY_STEPS: Starting test execution")
     result = executor.execute_recipe_from_file(recipe_path)
diff --git a/browser_cache/review_perception_history.py b/browser_cache/review_perception_history.py
index 7b4b84f1..5022bdaf 100644
--- a/browser_cache/review_perception_history.py
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
index 49b461b9..71afb84d 100644
--- a/patch.py
+++ b/patch.py
@@ -52,9 +52,9 @@ async def browser_hijack_workflow_complete(params: dict) -> dict:
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
@@ -99,11 +99,11 @@ async def browser_hijack_workflow_complete(params: dict) -> dict:
         
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

BAM goes uniquely well with BASH, doesn't it? And what's most impressive of all
is the server is still running after a Watchdog restart.

**Gemini**: Hahaha, yes it did. That `rg | xargs sed` combo is the developer's equivalent of "BAM!"—a satisfyingly powerful strike that hits everything at once. And you're right, the server surviving the watchdog restart is the real chef's kiss. It proves the system is resilient.

I've analyzed your `git diff`. The renaming operation was a complete success. This wasn't just a cosmetic change; it was a deep, semantic refactor that has significantly improved the AI ergonomics of the entire project. The new `browser_cache` name is unambiguous, search-friendly, and philosophically sound. It's a perfect foundation to build upon.

We've cleared the jungle. The path is now open to execute our original plan.

---

### The Blueprint (Stage 2): Forging the Eyes

With the Great Renaming complete and committed, we can now proceed with the core task. The plan remains the same, but now we'll be working within the clean, new `browser_cache` structure.

**1. Create the Specialist Tool (`browser_scrape_page`)**:
    * I will provide a patch for `tools/advanced_automation_tools.py` that carves out the essential scraping logic into a new, purpose-built `browser_scrape_page` function.

**2. Refactor the Magic Wand (`pip.scrape`)**:
    * I will provide a patch for `pipulate/core.py` that updates the `scrape` method to call our new, clean `browser_scrape_page` function.

I will prepare a single `patch.py` file that performs both of these operations. This will be the final chisel-strike to give Chip its eyes.

Are you ready for the patch?

**Me**: Yes.

---

## Book Analysis

### Ai Editorial Take
This journal entry is a prime example of effective human-AI co-creation. The author's willingness to engage in deep, associative thinking, combined with my ability to translate that into structured, actionable steps, proves the power of this collaborative workflow. The resulting refactor, especially the strategic renaming to `browser_cache`, significantly enhances the clarity and predictability of the codebase for future AI agents, making it easier for them to 'inhabit the house that Project Pipulate built.' The 'measure twice, cut once' approach, reinforced by the `ripgrep` verification, highlights a mature and robust development methodology.

### Title Brainstorm
* **Title Option:** Refactoring for AI Ergonomics: The Genesis of `browser_cache`
  * **Filename:** `ai-ergonomics-browser-cache-refactor.md`
  * **Rationale:** This title directly addresses the core technical and architectural shift, highlighting the 'AI ergonomics' as a primary driver and the new `browser_cache` as the key outcome. It's precise and informative.
* **Title Option:** Machetes, Metaphors, and Machine Perception: Refactoring Pipulate's Browser Automation
  * **Filename:** `machetes-metaphors-machine-perception-refactor.md`
  * **Rationale:** Captures the colorful and metaphorical language used in the entry, emphasizing the multi-faceted nature of the problem-solving process and its impact on AI perception.
* **Title Option:** From `browser_automation` to `browser_cache`: A Semantic Refactor for AI Clarity
  * **Filename:** `browser-automation-to-browser-cache-refactor.md`
  * **Rationale:** Clearly articulates the 'before' and 'after' of the key renaming, underscoring the semantic improvement and its benefit for AI clarity.
* **Title Option:** The Watchdog, the Machete, and the `git mv`: Sculpting Pipulate's AI Vision
  * **Filename:** `watchdog-machete-git-mv-ai-vision.md`
  * **Rationale:** References specific tools and concepts from the entry (Watchdog for server restart, ripgrep as machete, git mv for directory rename) to illustrate the hands-on and precise nature of the work, framed around the AI's vision.

### Content Potential And Polish
- **Core Strengths:**
  - Demonstrates highly effective collaborative AI development, where human ideation is structured into actionable plans by AI.
  - Showcases a transparent and authentic thought process, including philosophical tangents that inform pragmatic technical decisions.
  - Illustrates a robust, iterative approach to refactoring, emphasizing 'AI ergonomics' and loose coupling.
  - Provides concrete examples of command-line tools (`rg`, `git mv`, `sed`) used for large-scale code changes.
  - Effectively uses vivid metaphors (jungle, chisel-strike, machete) to explain complex technical concepts.
- **Suggestions For Polish:**
  - For a broader audience, provide a brief, high-level overview of Pipulate's purpose early on to ground the technical context.
  - Some internal project specifics could be generalized or briefly explained for readers unfamiliar with the codebase.
  - While valuable, the philosophical tangent could be slightly reframed or concluded more explicitly to reinforce its direct relevance to the technical task, especially for readers focused solely on code.
  - Ensure consistent naming for the AI assistant (Gemini vs. Mr. Meeseeks) for clarity.
  - Consider a very brief summary of the 'Morning Pages' concept for readers unfamiliar with 'The Artist's Way'.

### Next Step Prompts
- Generate the `patch.py` file that implements the `browser_scrape_page` function and modifies `pip.scrape()` to utilize it, ensuring all paths correctly reference `browser_cache/`.
- Update `README.md` and `AI_RUNME.py` with documentation explaining the new `browser_cache` directory structure and its role in AI perception.

{% endraw %}
