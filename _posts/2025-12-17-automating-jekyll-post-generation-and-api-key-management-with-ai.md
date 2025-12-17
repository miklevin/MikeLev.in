---
title: Automating Jekyll Post Generation and API Key Management with AI
permalink: /futureproof/automating-jekyll-post-generation-and-api-key-management-with-ai/
description: My ongoing work is less about building singular 'empires' and more about
  crafting a resilient, distributed way of working with AI. I'm deeply motivated by
  the challenge of creating systems that remove friction, allowing me to focus on
  ideas and implementation rather than administrative overhead. This latest iteration
  of the `articleizer` script, with its refined Jekyll integration and flexible API
  key management, is a prime example of this philosophy in action. It's about empowering
  the creative process by systematically eliminating technical debt and optimizing
  the development loop.
meta_description: This article details the iterative process of refining an AI-powered
  articleizer script, focusing on ensuring Jekyll compatibility, managing API quotas,
  and enhancing an automated content publishing workflow.
meta_keywords: Jekyll, AI, automation, API key management, Gemini API, Python scripting,
  content publishing, front matter, liquid templates, technical journal
layout: post
sort_order: 3
---

{% raw %}
## Setting the Stage: Context for the Curious Book Reader

This entry documents an important phase in the evolution of our automated content publication system, focusing on resolving persistent Liquid template parsing issues in Jekyll and building a robust API key management solution. It's a testament to the iterative nature of software development, where seemingly small technical debts can lead to significant friction if not addressed systemically. We explore the implementation of global `{% raw %}` tags, the subtle pitfalls of API model selection, and the critical need for flexible API key handling in an environment where resource exhaustion is a common challenge in the Age of AI.

---

## Technical Journal Entry Begins

Quoting the *Gemini 3 API* articleizer "final-polish Editor" from the last
article in regard to the latest refinements to our *context-painting* archival
and assembly system:

> This is not just about giving AI more context, but about creating an
> intelligent, self-curating system that remembers its own assembly
> instructions. 

Amen to that! As we go, we're telling stories and world-building. This is the
same way generational knowledge gets passed down from parent to child, from
teachers to students, from media to everybody. This is the glue that holds
society together, reinforced by static indexed archives like books and libraries
where you can go and *look up* anything you need to fill in the blanks.

## The Imperative of Context Isolation

The idea is with a 1-million token context window with many AIs today which is
enough to flood... hmmm, what?

**Me**: Would *War and Peace* fit into a 1-million token context window of gpt4
(o200k_base)?

**Google AI Overviews**: Yes, the entirety of War and Peace would fit within a 1-million token context window. 

- War and Peace by Leo Tolstoy contains approximately 587,287 words. 
- Using a general rule of thumb for English text where 1,000 tokens is roughly 750 words, the book translates to an estimated 750,000 tokens. [2, 3, 4]  

A 1-million token context window can process the entire novel, with capacity remaining for the model's response or extra instructions. This larger context window, available in models like GPT-4.1 and Gemini 1.5 Pro via API, enables detailed analysis and reasoning over large amounts of text that were previously impossible in a single prompt. [1, 5, 6, 7, 8]  

AI responses may include mistakes.

    [1] https://www.dailybot.com/blog/openai-releases-gpt-4-1-api
    [2] https://x.com/sreeraman/status/1814980471366774868
    [3] https://criticalmynd.medium.com/understanding-llm-token-counts-what-1-000-128-000-and-1-million-tokens-actually-mean-9751131ac197
    [4] https://milliontokens.vercel.app/
    [5] https://news.ycombinator.com/item?id=36039119
    [6] https://azaddjan.com/exploring-war-and-peace-with-googles-gemini-1-5-pro-a-neo4j-graph-representation-e6349c656caa
    [7] https://community.openai.com/t/gpt-4-1-supports-1m-token-context-chatgpt-still-capped-at-32k/1269979
    [8] https://x.com/edwinarbus/status/1916902605705646503

There you have it. So if your context window is that big, with just a little bit
of organizing smarts there's no reason you can't fit everything that's necessary
and exactly what's necessary into the context window of Gemini 3 today and
models like it tomorrow to get nearly zero pollution from the GitHub/Stack
Overflow fat middle normal distribution curve over-training and over-fitting
that used to make it impossible from keeping FastAPI patterns out of a FastHTML
project. Now it's no longer even an issue.

The combination of the models getting smarter and my codebase getting cleaner
and better organized into mix-and-match digestible chunks that I can *"paint"*
into the context window is... well, transformative. I am regularly hitting at
above my weight class coding-wise from the unique combination of:

1. Being the so-called "idea man". Ideas are cheap. Brilliant fall from the sky
   like a light trickle of rain on everyone. The trick is idea-capture.
2. I'm a vimmer. I no longer think about *in what* am I going to type. It's vim
   in 1-long-file for life. The trick is implementation.
3. If you're a competent technician, you can assemble almost any parts, the
   contents of which might be beyond you. The trick is getting those parts.
4. A competent idea-capturing technician who is good at assembling parts and can
   also visualize the entire machine can recruit AI-help to fill-in the details.

Again, my mind goes to being a pop-fly king all my life, always being 5 to 10
years out ahead of where everyone else is, but because I didn't have the
knowledge to build the inside of those black-box components, nor did I have that
desire to *build empires* because... because... Hmm. I want to use those
platitudes like *the journey is the reward* or *everything is win when the goal
is to experience.* I guess part of what's going on is that it's way too easy to
become a servant to your own creation, going from the fun, inventive part of
building a machine to being on the hook for keeping it running and dealing with
the problems when people rely on it and it stops working. Ugh, the mere thought
of that gives me chills. 

That's probably why I'm so into *distributed local systems* rather than
centralized hosting systems. Empire-builders I think love that control of the
centralized hosted systems. Fix something in one place, fix it for everybody.
Watch the flow of data as it comes through a globally observable choke-point.
Distributed systems on the other hand can now have the same "fix it one place,
fix for everyone" because of how git and things like it work. There's still some
centralized place where the new code gets pulled from, but there's no
choke-point of globally observable data of what's running on each and everyone's
individual machines — the localhost that git pulled the updates down to.
  
You cat to be that free-spirited inventor making *real machines* that have *real
meaningful impact on peoples' live* in all the ways that matter — helping them
do what they need to do, helping them improve their skills, etc. — without being
on the leash of centralized-serving nor having any of that stress. You just need
to statistically beat the "not on my machine" problem which the Nix DSL (domain
specific language) / software repository system that provides a *normalized*
Linux on any Mac, Windows (WSL) or other Linux system. Solved. Things that
previously had to be hosted on the cloud or bundled with the inefficient and
overly opinionated Electron platform can now just be whatever and it'll still
just run wherever.

There's a new *Forever Machine* in town and that makes all the difference
because when you think of some little thing to do, you do it once and the good
work of that will resonate forward through time... well, forever or at least for
the rest of your life that you want to be in the field of tech or do anything
developer-wise with technology. It's a Noah's Ark but way better because you're
not just carrying around a seed bank. It's as if you had Dr. Who's Tardis or if
you're a Harry Potter fan, the Weasley's tent from the Quidditch World Cup and
could fit a whole continent of running code in that Ark. And maybe beyond your
life too because such bottled environments can be gotten running forever forward
in time because of the way the `/nix/store/` works, automatically archiving
and pinning versions locally so you don't even need the Internet if your app
doesn't.

## Building the 'Forever Machine': Distributed Systems and Nix

Anyway, I mentioned articleizer at the begging of this thing and I always like
to show these things working. You already saw the Prompt Fu process so you've
got a good idea of the world we're living in here, and I've got another process
called Articleizer that works off of these 2 files:

    scripts/articles/articleizer.py
    scripts/articles/editing_prompt.txt

Now it will take "raw" article input like the following. It's normally named
`article.txt` but I renamed it so that the one I'm working on right now won't
override it.

    scripts/articles/article.txt.bak

This is the last article I wrote which is already published now. But I had to
publish it like this:

    /home/mike/repos/MikeLev.in/_posts/2025-12-17-context-recapture-saving-ais-cognitive-state.md.bak

...and not in the original form that `articleizer.py` output which his this:

    /home/mike/repos/MikeLev.in/_posts/2025-12-17-context-recapture-saving-ais-cognitive-state.md

As you see I had to manually insert the Liquid Template `raw` and `endraw` tags
near the top and at the bottom of the file so as to render it properly under the
Jekyll static site generator system. Now I very well could put those tags
directly in the Jekyll site's templates or output it into the file that way from
the articleizer process, but I'm also going to be potentially using liquid
templates in my articles and don't want to be so presumptuous... or no... no,
maybe I'm not. I think maybe I do want them to be inserted globally. However,
look at this:

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ rg endraw
[Removing stuff I think is breaking the API-call]
```

And it's not always even consistent in how I put the raw and endraw tags in.
They always work so the syntax is good. But sometimes it was 1 per article way
at the top and bottom like the sample I showed you. And sometimes it's scattered
throughout on a per-line basis or at the top and bottom of blocks.

So I need to clean up this mess and consolidate on an *always use them* approach
and assume that I'll never actually want to embed working liquid tempalates in
my article content.

## The Problem: Inconsistent Liquid Tag Handling

This is going to be a several-step procedure. And the search and replace
challenge is going to be formidable. Seed has multi-line problems and the
mixed-context of doing it with a Python script is challenging too. So think
through what *you think* is the best approach to what I assume is going to be:

1. Scrubbing them all out of the existing article markdown in `_posts/`
2. Adding them back in across-the-board with the liquid template system that
   builds the site.

I know they could be added with the `articleizer.py` file itself, but all the
articles have already been generated and it's unreasonable to regenerate them
all from source. But we don't want the process to choke... ahh! No, not in the
Jekyll site generation process, but a second follow-on 1-time Python script to
process all the articles in location in an idempotent way after the scrubbing
has occurred! So see, I'm thinking it through out loud being the idea-man and
also envisioning the machine. But the black-box components of those machines
which I now envision as one Python script to scrub and another script to update.

The update is a global wrap beneath the YAML frontmatter with at least that 1
space it needs after the `---` and at the bottom of the page.

Can I have the 2 python scripts and instructions on how to use them? The site
uses the Jekyll live regenerate feature so after the first script runs I'll see
all the red appear. And after the 2nd script runs, all the red should disappear.
And also everything's under git so it's completely safe. I could always revert.
Please and thank you!

## The Solution: Surgical Python Scripts

**Gemini**: Context verified.

Here is the "cleanup crew" for your Jekyll repository.

You are absolutely right to consolidate strategies. Having mixed `raw/endraw` tags—sometimes at the file level, sometimes inline, sometimes wrapping blocks—is a recipe for "git noise" and parsing errors.

We will do this in two precise surgical strikes.

### The Plan

1. **Script 1 (`scrub_tags.py`):** Iterate through every markdown file. Ruthlessly strip out every existing instance of `{% raw %}` and `{% endraw %}`. This returns the codebase to "Pure Markdown" (and will likely break your local Jekyll build temporarily).
2. **Script 2 (`wrap_tags.py`):** Iterate through every markdown file. Identify the YAML front matter. Wrap the entire body content (everything after the second `---`) in a single global `{% raw %} ... {% endraw %}` block.

### 1. The Scrubber Script

Save this as `scrub_tags.py` in your `scripts/articles/` directory (or root).

```python
import os
import argparse
from pathlib import Path

def scrub_files(directory, dry_run=True):
    target_dir = Path(directory).resolve()
    print(f"--- 🧹 Scrubbing Liquid Tags in: {target_dir} ---")
    if dry_run:
        print("⚠️  DRY RUN MODE: No files will be modified.\n")

    count = 0
    for file_path in target_dir.glob("**/*.md"):
        try:
            original_content = file_path.read_text(encoding="utf-8")
            
            # The removal logic
            new_content = original_content.replace("{% raw %}", "")
            new_content = new_content.replace("{% endraw %}", "")
            
            # Clean up potential double empty lines left behind? 
            # Optional, but keeping it simple is safer for now.
            
            if original_content != new_content:
                print(f"found tags in: {file_path.name}")
                if not dry_run:
                    file_path.write_text(new_content, encoding="utf-8")
                count += 1
        except Exception as e:
            print(f"Error reading {file_path}: {e}")

    action = "Would have modified" if dry_run else "Modified"
    print(f"\n✨ {action} {count} files.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Remove all {% raw %} tags from markdown files.")
    parser.add_argument("dir", help="Directory to scan (e.g., _posts)")
    parser.add_argument("--do-it", action="store_true", help="Actually perform the changes (disable dry run)")
    args = parser.parse_args()

    scrub_files(args.dir, dry_run=not args.do_it)

```

### 2. The Wrapper Script

Save this as `wrap_tags.py`. This script is idempotent; it checks if the raw tag is already present immediately after the front matter to avoid double-wrapping if you run it twice.

```python
import os
import argparse
from pathlib import Path

def wrap_files(directory, dry_run=True):
    target_dir = Path(directory).resolve()
    print(f"--- 🎁 Wrapping Posts in Liquid Raw Tags: {target_dir} ---")
    if dry_run:
        print("⚠️  DRY RUN MODE: No files will be modified.\n")

    count = 0
    for file_path in target_dir.glob("**/*.md"):
        try:
            content = file_path.read_text(encoding="utf-8")
            
            # Check for Valid Front Matter
            if not content.startswith("---"):
                print(f"Skipping (no front matter): {file_path.name}")
                continue

            parts = content.split("---", 2)
            
            # parts[0] is empty (before first ---)
            # parts[1] is the YAML content
            # parts[2] is the body
            if len(parts) < 3:
                print(f"Skipping (malformed front matter): {file_path.name}")
                continue

            yaml_block = parts[1]
            body = parts[2]

            # Idempotency Check: Don't wrap if it already looks wrapped
            # We check the trimmed start of the body
            if body.strip().startswith("{% raw %}"):
                # print(f"Skipping (already wrapped): {file_path.name}")
                continue

            # Construct the new content
            # We ensure there is a newline after the YAML block, then the raw tag
            new_body = f"\n\n{{% raw %}}\n{body}\n{{% endraw %}}\n"
            
            # Reassemble
            final_content = f"---{yaml_block}---{new_body}"

            print(f"Wrapping: {file_path.name}")
            if not dry_run:
                file_path.write_text(final_content, encoding="utf-8")
            count += 1

        except Exception as e:
            print(f"Error processing {file_path}: {e}")

    action = "Would have modified" if dry_run else "Modified"
    print(f"\n✨ {action} {count} files.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Wrap markdown bodies in {% raw %} tags.")
    parser.add_argument("dir", help="Directory to scan (e.g., _posts)")
    parser.add_argument("--do-it", action="store_true", help="Actually perform the changes (disable dry run)")
    args = parser.parse_args()

    wrap_files(args.dir, dry_run=not args.do_it)

```

### Instructions for Use

Since you are on NixOS, just drop into your shell where python is available.

**Step 1: The Scrub (Watch the world burn)**
Run the scrubber in Dry Run mode first to see what it hits.

```bash
python scripts/articles/scrub_tags.py _posts

```

If the output looks correct (it should list files containing tags), run it for real:

```bash
python scripts/articles/scrub_tags.py _posts --do-it

```

*At this point, check your local Jekyll server. If you have posts with curly braces `{{ like_this }}`, they might be causing build errors or rendering weirdly. This is expected.*

**Step 2: The Wrap (Restore order)**
Run the wrapper. It will identify any file with valid front matter that isn't already wrapped.

```bash
python scripts/articles/wrap_tags.py _posts --do-it

```

*Check your Jekyll server again. The errors should vanish, and your code blocks containing curly braces should render perfectly.*

**Step 3: Future Proofing**
Update your `articleizer.py` or whatever generates new posts to include this wrapping pattern by default, so you don't have to run this script periodically (though `wrap_tags.py` is safe to run whenever because it checks for existence).

### Final Verdict: The "Raw" Reality

#### 1. The Definition

We have executed a **Global Context Isolation** strategy for the blog. Instead of micromanaging Liquid template conflicts on a line-by-line basis, we have established a new architectural rule: The Markdown body of a post is *data*, not code. By wrapping the entire body in `{% raw %}`, we decouple the content creation process (writing about code) from the rendering engine (Jekyll/Liquid).

#### 2. The Monday Morning Test

Next Monday, you write a blog post about Python f-strings or Jinja2 templates. You type `{{ variable }}` directly into your article. You don't have to escape it. You don't have to pause and think "Will Jekyll eat this?" You just write. The system handles the isolation. Your flow state remains unbroken.

#### 3. The Shift

The shift here is from **Syntax Evasion** to **Syntax Encapsulation**.

* *Old Way:* We tried to "dodge" the Liquid parser every time we wrote a curly brace, treating it like a minefield.
* *New Way:* We built a fence around the minefield. We treat the entire article body as a "Safe Zone" where Liquid logic does not apply.

#### 4. Before vs. After

| The Old Way (Mixed Context) | The New Way (Global Isolation) |
| --- | --- |
| **Inconsistent:** Tags scattered randomly throughout files. | **Uniform:** Every file follows the exact same pattern. |
| **Fragile:** A missed `endraw` breaks the site build. | **Robust:** Automated wrapping ensures closure. |
| **High Maintenance:** Creating new posts requires manual tag insertion. | **Zero Maintenance:** The wrapper script handles it (or the generator does). |
| **Readability:** Source markdown is cluttered with template tags. | **Readability:** Source markdown is clean (except for top/bottom tags). |

#### 5. The Warning

The risk of ignoring this is **Parser Paranoia**. If you don't solve this globally, you will subconsciously avoid writing about certain topics (like templating languages) because the friction of formatting the blog post is too high. You limit your expression to fit your tool's limitations.

#### 6. The Bottom Line

**Let the Writer Write.**
The job of the "Forever Machine" is to get out of the way. By automating the technical debt of static site generation (escaping characters), you free up mental RAM for the actual ideas. This simple cleanup allows your blog to contain *any* text sequence without fear of breaking the build.

### AI Reflection

This was a satisfyingly "janitorial" task. While high-concept architecture is fun, there is a visceral pleasure in taking a messy, inconsistent directory of files and normalizing them with a regex-powered broom. It reinforces the idea that **regularity is a prerequisite for automation**. You can't effectively automate the `Prompt Fu` context building if the source files are full of inconsistent noise. This cleanup makes every subsequent AI interaction slightly cleaner.

---

### Context Recapture

```python
# # PURPOSE OF CONTEXT: Scrub and Wrap Jekyll Liquid Tags
# AI_PHOOEY_CHOP = """\
# scripts/articles/scrub_tags.py
# scripts/articles/wrap_tags.py
# """

```

**Me**: Okay, so first we run it:

```bash
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ xv scrub_tags.py
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ python scrub_tags.py 
usage: scrub_tags.py [-h] [--do-it] dir
scrub_tags.py: error: the following arguments are required: dir
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ python scrub_tags.py /home/mike/repos/MikeLev.in/_posts
--- 🧹 Scrubbing Liquid Tags in: /home/mike/repos/MikeLev.in/_posts ---
⚠️  DRY RUN MODE: No files will be modified.

found tags in: 2025-10-03-ai-debugging-odyssey-tenacity.md
found tags in: 2025-04-27-integrating-prismjs-pandas-html-table-widgets.md
found tags in: 2025-10-19-context-artist-storytelling-tokens-ai-accountability-prompt-fu.md
found tags in: 2025-10-20-context-is-king-prompt-fu-mastery-webopps-devolveneer.md
found tags in: 2025-10-11-master-ai-emissary-mu-puzzle-digital-corpus-callosum.md
found tags in: 2025-11-04-jekyll-nix-flakes-mathjax-liquid-templates.md
found tags in: 2025-06-07-polishing-aligning-abstraction-focusing-lenses-llm-ai.md
found tags in: 2025-10-16-context-king-human-ai-symbiosis-prompt-fu.md
found tags in: 2025-09-20-refactoring-python-monolith-ai-wrapper-shim.md
found tags in: 2025-04-12-algorithmic-information-architecture-jekyll-ai.md
found tags in: 2025-10-12-surgical-ai-context-narrative-time-machine.md
found tags in: 2025-12-15-automating-jekyll-hub-pages-navgraph.md
found tags in: 2024-11-03-api-enabling-llm-ghost.md
found tags in: 2025-10-10-ai-ergonomics-browser-cache-refactor.md
found tags in: 2024-12-08-claude-o1-collaboration.md
found tags in: 2025-01-15-simplifying-state-workflow-refactoring.md
found tags in: 2025-10-09-ai-python-jupyter-browser-automation-fixes.md
found tags in: 2025-12-08-context-telemetry-mastering-ai-prompt-size-limits.md
found tags in: 2024-09-26-theres-no-home-like-nix.md
found tags in: 2024-10-10-fasthtml-drag-and-drop.md
found tags in: 2025-05-21-ai-wrangling-code-transparency.md
found tags in: 2025-12-10-context-saturation-semantic-compression-fractal-blog-navigation.md
found tags in: 2025-12-13-forever-actualizer-machine-sovereign-ai-llm-self-aware-prompts.md
found tags in: 2025-04-22-optimizing-jekyll-rendering.md
found tags in: 2025-05-18-css-fasthtml-ast-helper-scripts-python.md
found tags in: 2025-01-11-refactoring-ai-assisted-code.md
found tags in: 2025-10-04-upgrading-prompt-fu-ai-self-correction-checklist.md
found tags in: 2025-10-10-forging-ais-eyes-async-coroutine-errors.md
found tags in: 2025-01-09-peak-data-musk-sutskever-wrong.md
found tags in: 2025-07-04-ai-assisted-refactoring-browser-automation.md
found tags in: 2025-04-11-top-keywords-per-page.md
found tags in: 2025-12-17-prompt-fu-absolute-path-certainty-ai-context.md
found tags in: 2025-04-24-modern-interactive-toc-tocbot-guide.md
found tags in: 2025-06-16-htmx-ai-partner-debugging-workflow.md
found tags in: 2025-04-20-file-polling-progress-indicator.md
found tags in: 2025-04-09-github-pages-blog-arrows.md
found tags in: 2025-10-01-forging-the-prompt-200k-token-context.md
found tags in: 2025-04-26-llm-architecture-ai-collaboration-coding-workflows.md
found tags in: 2024-12-11-sheet-music-chisel-strikes.md
found tags in: 2025-02-20-frozen-core-conundrum.md
found tags in: 2025-03-18-unparsable-structured-data.md
found tags in: 2024-11-17-unix-pipelines-htmx-fasthtml-workflow.md
found tags in: 2025-10-10-surgical-refactoring-selenium-scraping.md
found tags in: 2025-03-02-giving-grok3-another-chance.md
found tags in: 2025-09-27-prompt-fu-failure-better-architecture.md
found tags in: 2024-11-04-figuring-out-a-complex-api.md
found tags in: 2025-10-09-token-transparency-ai-prompt-generation.md
found tags in: 2024-11-16-fighting-dunning-kruger-effect.md
found tags in: 2025-02-26-commitment-and-consistency.md
found tags in: 2025-09-30-forging-the-magic-wand-refactor.md
found tags in: 2025-10-12-pipulate-sovereign-software-nix-local-ai-electron-alternative.md
found tags in: 2025-11-07-navigating-ai-client-work-seo-strategy.md
found tags in: 2024-10-20-Local-AI-In-The-Dev-Loop.md
found tags in: 2025-04-24-jekyll-front-matter-seo-social-metadata-guide.md
found tags in: 2025-10-10-ai-workflow-debugging-git-reset.md
found tags in: 2025-03-15-web-app-fasthtml-htmx.md
found tags in: 2024-10-13-oo-baseclass-plugins.md
found tags in: 2025-10-13-idempotent-architect-prompt-sqlite-workflow.md
found tags in: 2024-11-13-80-percent-cost-reduction-in-ai-operations.md
found tags in: 2025-09-22-pipulate-chronicles-future-proof-ai-stack.md
found tags in: 2025-04-08-grok-ai-better-than.md
found tags in: 2024-10-18-local-llm-web-framework-integration-plan.md
found tags in: 2025-12-13-gemini-api-key-rotation-scalable-ai-web-navigation.md
found tags in: 2025-12-17-context-recapture-saving-ais-cognitive-state.md
found tags in: 2025-09-20-gravity-of-the-mean-ai-regression.md
found tags in: 2025-09-22-ai-architectural-xrays-code-pruning.md
found tags in: 2025-06-20-simon-says-llm-ui-guidance.md
found tags in: 2024-11-02-got-my-llm-to-play-nice-with-web-ui.md
found tags in: 2025-04-19-export-botify-csv-api.md
found tags in: 2025-04-10-jekyll-lunr-static-site-search.md
found tags in: 2025-10-10-git-time-travel-strings-within-strings-ai-code-debugging.md
found tags in: 2025-02-27-workflow-script-for-ai.md
found tags in: 2025-10-10-forging-ais-eyes-collaborative-debugging-saga.md
found tags in: 2024-10-26-accumulated-chunks-to-real-time-yields.md
found tags in: 2025-03-07-python-htmx-llm-seo.md
found tags in: 2025-03-25-python-plugin-architectures.md
found tags in: 2024-10-12-fasthtml-plugin.md
found tags in: 2025-10-02-forging-the-chameleon-python-packaging-history.md
found tags in: 2025-09-12-headless-shopify-python-jekyll.md
found tags in: 2025-03-12-real-time-ai-research.md
found tags in: 2025-01-10-starter-flow.md
found tags in: 2024-10-05-ollama-websocket-chat.md
found tags in: 2024-10-14-botifython-is-born.md
found tags in: 2025-12-11-cracking-google-gemini-hidden-20-rpd-free-tier-limit-python.md
found tags in: 2024-11-01-deep-debugging-llm-ghost.md
found tags in: 2025-03-18-automating-seo-workflows.md
found tags in: 2024-12-30-rabbit-holes-shoulders-of-giants.md

✨ Would have modified 87 files.
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$
```

The output looks good, so we run it with the `--do-it` parameter to change from
*dry run* to *for real.* And I see the live-reload feature immediately kick in.
And I check git both status and diff and it looks good.

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ git commit -am "raw and endraw liquid template tags stripped out"
[main f5c134a72] raw and endraw liquid template tags stripped out
 87 files changed, 384 insertions(+), 384 deletions(-)

[mike@nixos:~/repos/MikeLev.in/_posts]$
```

And now I run `wrap_tags.py`:

```bash
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ python wrap_tags.py /home/mike/repos/MikeLev.in/_posts --do-it
--- 🎁 Wrapping Posts in Liquid Raw Tags: /home/mike/repos/MikeLev.in/_posts ---
Wrapping: 2024-10-30-giving-gemini-advanced-a-try.md
[And many more like this]
Wrapping: 2025-01-01-rubber-ducking-with-llm.md

✨ Modified 743 files.
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$
```

That touches every file on the site so it's one of those (now rare) site
rebuilds. Even though I use the Jekyll live-reload feature I have it set up to
only work on the file that just changed, which is great for articles. Whenever I
edit global template files like
`/home/mike/repos/MikeLev.in/_layouts/default.html` it re-generates the entire
site, and that's pretty much like the effect I'm seeing now which I can watch as
it goes and I'm not seeing any red warnings in the terminal console output.

It's pretty funny that Gemini used the article-closing protocol before this
article and project is even finished. We'll get to test it right away because
THIS article will be full of curly braces and will have red warnings if we don't
fix it in `articleizer.py`. And so I'll archive the context-bundle that let us
do this fix per Gemini's gentle prodding adding it to `foo_files.py` which frees
me to change the active Chop Phooey to:

```python
AI_PHOOEY_CHOP = """\
scripts/articles/articleizer.py
"""
```

...setting the stage for me to ask Gemini for the updated `articleizer.py` file
to bring this project to completion... almost. I'll be testing it on *this
article* for another one of those wonderful meta moments.

**Gemini**: Context verified.

You are closing the loop perfectly. By integrating the wrapping logic directly into `articleizer.py`, you eliminate the need for the manual cleanup step on future articles. The system becomes self-healing by design.

The strategy is straightforward: in `create_jekyll_post`, before assembling the final content string, we will check if the `article_body` (which contains your markdown content) already has the raw tags. If not, we wrap it. This ensures that any `{{ curly_braces }}` within your technical journal entries—like the ones in this very conversation—are treated as text, not Liquid code.

Here is the updated `articleizer.py`.

```python
# scripts/articles/articleizer.py
import os
import sys
import json
import yaml
import re
from datetime import datetime
import getpass
from pathlib import Path
import google.generativeai as genai
import argparse
import time # NEW: Import time for the retry delay

# --- CONFIGURATION ---
CONFIG_DIR = Path.home() / ".config" / "articleizer"
API_KEY_FILE = CONFIG_DIR / "api_key.txt"
TARGETS_FILE = CONFIG_DIR / "targets.json"

ARTICLE_FILENAME = "article.txt"
PROMPT_FILENAME = "editing_prompt.txt"
PROMPT_PLACEHOLDER = "[INSERT FULL ARTICLE]"
INSTRUCTIONS_CACHE_FILE = "instructions.json"

# Safe default if config is missing (keeps the public repo functional but private)
DEFAULT_TARGETS = {
    "1": {
        "name": "Local Project (Default)",
        "path": "./_posts"
    }
}

def load_targets():
    """Loads publishing targets from external config or falls back to default."""
    if TARGETS_FILE.exists():
        try:
            with open(TARGETS_FILE, 'r') as f:
                return json.load(f)
        except json.JSONDecodeError:
            print(f"⚠️ Warning: {TARGETS_FILE} is corrupt. Using defaults.")
    return DEFAULT_TARGETS

PROJECT_TARGETS = load_targets()
# --------------------------------

def get_api_key():
    """
    Gets the API key by first checking a local config file, and if not found,
    securely prompting the user and offering to save it.
    """
    if API_KEY_FILE.is_file():
        print(f"Reading API key from {API_KEY_FILE}...")
        return API_KEY_FILE.read_text().strip()

    print("Google API Key not found.")
    print("Please go to https://aistudio.google.com/app/apikey to get one.")
    key = getpass.getpass("Enter your Google API Key: ")

    save_key_choice = input(f"Do you want to save this key to {API_KEY_FILE} for future use? (y/n): ").lower().strip()
    if save_key_choice == 'y':
        try:
            CONFIG_DIR.mkdir(parents=True, exist_ok=True)
            API_KEY_FILE.write_text(key)
            API_KEY_FILE.chmod(0o600)
            print(f"✅ Key saved securely.")
        except Exception as e:
            print(f"⚠️ Could not save API key. Error: {e}")
    return key

def create_jekyll_post(article_content, instructions, output_dir):
    """
    Assembles and writes a Jekyll post file from the article content and
    structured AI-generated instructions.
    
    Auto-increments 'sort_order' based on existing posts for the current date.
    Wraps content in Liquid {% raw %} tags to prevent template errors.
    """
    print("Formatting final Jekyll post...")

    # 1. Determine Date and Auto-Increment Sort Order
    current_date = datetime.now().strftime('%Y-%m-%d')
    next_sort_order = 1
    
    try:
        target_path = Path(output_dir)
        if target_path.exists():
            # Find all markdown files for today
            todays_posts = list(target_path.glob(f"{current_date}-*.md"))
            
            max_order = 0
            for post_file in todays_posts:
                try:
                    # Read content to parse front matter
                    content = post_file.read_text(encoding='utf-8')
                    if content.startswith('---'):
                        # Split to isolate YAML block (between first two ---)
                        parts = content.split('---', 2)
                        if len(parts) >= 3:
                            front_matter = yaml.safe_load(parts[1])
                            if front_matter and 'sort_order' in front_matter:
                                try:
                                    order = int(front_matter['sort_order'])
                                    if order > max_order:
                                        max_order = order
                                except (ValueError, TypeError):
                                    continue
                except Exception as e:
                    print(f"Warning checking sort_order in {post_file.name}: {e}")
            
            if max_order > 0:
                next_sort_order = max_order + 1
                print(f"📅 Found {len(todays_posts)} posts for today. Auto-incrementing sort_order to {next_sort_order}.")
            else:
                print(f"📅 First post of the day. sort_order set to 1.")
                
    except Exception as e:
        print(f"⚠️ Could not calculate auto-increment sort_order: {e}. Defaulting to 1.")

    # 2. Prepare Data
    editing_instr = instructions.get("editing_instructions", {})
    analysis_content = instructions.get("book_analysis_content", {})
    yaml_updates = editing_instr.get("yaml_updates", {})

    new_yaml_data = {
        'title': yaml_updates.get("title"),
        'permalink': yaml_updates.get("permalink"),
        'description': analysis_content.get("authors_imprint"),
        'meta_description': yaml_updates.get("description"),
        'meta_keywords': yaml_updates.get("keywords"),
        'layout': 'post',
        'sort_order': next_sort_order  # <--- Now uses the dynamic value
    }
    
    # 3. Assemble Content
    final_yaml_block = f"---\n{yaml.dump(new_yaml_data, Dumper=yaml.SafeDumper, sort_keys=False, default_flow_style=False)}---"

    article_body = article_content.strip()
    article_body = f"## Technical Journal Entry Begins\n\n{article_body}"

    subheadings = editing_instr.get("insert_subheadings", [])
    for item in reversed(subheadings):
        snippet = item.get("after_text_snippet", "")
        subheading = item.get("subheading", "## Missing Subheading")
        if not snippet:
            print(f"Warning: Skipping subheading '{subheading}' due to missing snippet.")
            continue

        words = re.findall(r'\w+', snippet.lower())
        pattern_text = r'.*?'.join(re.escape(word) for word in words)

        match = re.search(pattern_text, article_body, re.IGNORECASE | re.DOTALL)
        if match:
            # SAFETY FIX: Force insertion to the nearest paragraph break (double newline).
            # This prevents headlines from splitting sentences or paragraphs mid-stream.
            match_end = match.end()
            
            # Find the next double newline starting from the end of the match
            insertion_point = article_body.find('\n\n', match_end)
            
            # If no paragraph break is found (end of document), append to the very end.
            if insertion_point == -1:
                insertion_point = len(article_body)
            
            # Insert the subheading surrounded by newlines.
            # If insertion_point finds an existing '\n\n', this logic adds another '\n\n'
            # effectively creating: [End of Para]\n\n[Subheading]\n\n[Start of Next Para]
            article_body = (
                article_body[:insertion_point] +
                f"\n\n{subheading}" +
                article_body[insertion_point:]
            )
        else:
            print(f"Warning: Snippet not found for subheading '{subheading}': '{snippet}'")

    prepend_text = editing_instr.get("prepend_to_article_body", "")
    if prepend_text:
        intro_section = f"## Setting the Stage: Context for the Curious Book Reader\n\n{prepend_text}\n\n---"
        article_body = f"{intro_section}\n\n{article_body}"

    # --- WRAPPING LOGIC START ---
    # Wrap the entire body in {% raw %} ... {% endraw %} to prevent Liquid processing errors
    # only if it's not already wrapped.
    if not article_body.strip().startswith("{% raw %}"):
        article_body = f"{{% raw %}}\n{article_body}\n{{% endraw %}}"
    # --- WRAPPING LOGIC END ---

    analysis_markdown = "\n## Book Analysis\n"
    if 'ai_editorial_take' in analysis_content:
        analysis_markdown += f"\n### Ai Editorial Take\n{analysis_content['ai_editorial_take']}\n"
    for key, value in analysis_content.items():
        if key in ['authors_imprint', 'ai_editorial_take']:
            continue
        title = key.replace('_', ' ').title()
        analysis_markdown += f"\n### {title}\n"
        if isinstance(value, list):
            for item in value:
                if isinstance(item, dict):
                    analysis_markdown += f"* **Title Option:** {item.get('title', 'N/A')}\n"
                    analysis_markdown += f"  * **Filename:** `{item.get('filename', 'N/A')}`\n"
                    analysis_markdown += f"  * **Rationale:** {item.get('rationale', 'N/A')}\n"
                else:
                    analysis_markdown += f"- {item}\n"
        elif isinstance(value, dict):
            for sub_key, sub_value in value.items():
                analysis_markdown += f"- **{sub_key.replace('_', ' ').title()}:**\n"
                if isinstance(sub_value, list):
                    for point in sub_value:
                        analysis_markdown += f"  - {point}\n"
                else:
                    analysis_markdown += f"  - {sub_value}\n"
        else:
            analysis_markdown += f"{value}\n"

    final_content = f"{final_yaml_block}\n\n{article_body}\n\n---\n{analysis_markdown}"

    # 4. Generate Filename
    slug = "untitled-article"
    title_brainstorm = analysis_content.get("title_brainstorm", [])
    if title_brainstorm and title_brainstorm[0].get("filename"):
        slug = os.path.splitext(title_brainstorm[0]["filename"])[0]

    output_filename = f"{current_date}-{slug}.md"
    output_path = os.path.join(output_dir, output_filename)
    os.makedirs(output_dir, exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(final_content)

    print(f"✨ Success! Article saved to: {output_path}")

def main():
    parser = argparse.ArgumentParser(description="Process an article with the Gemini API and format it for Jekyll.")
    parser.add_argument(
        '-l', '--local',
        action='store_true',
        help=f"Use local '{INSTRUCTIONS_CACHE_FILE}' cache instead of calling the API."
    )
    args = parser.parse_args()

    # --- NEW: INTERACTIVE TARGET SELECTION ---
    print("Please select a publishing target:")
    for key, target in PROJECT_TARGETS.items():
        print(f"  [{key}] {target['name']}")

    choice = input("Enter choice (1 or 2): ").strip()

    if choice not in PROJECT_TARGETS:
        print("Invalid choice. Exiting to prevent mis-publishing.")
        return

    selected_target = PROJECT_TARGETS[choice]
    output_dir = selected_target['path']
    print(f"✅ Publishing to: {selected_target['name']} ({output_dir})\n")
    # --- END NEW SECTION ---

    if not os.path.exists(ARTICLE_FILENAME):
        print(f"Error: Article file '{ARTICLE_FILENAME}' not found.")
        return
    with open(ARTICLE_FILENAME, 'r', encoding='utf-8') as f:
        article_text = f.read()

    instructions = None

    if args.local:
        print(f"Attempting to use local cache file: {INSTRUCTIONS_CACHE_FILE}")
        if not os.path.exists(INSTRUCTIONS_CACHE_FILE):
            print(f"Error: Cache file not found. Run without --local to create it.")
            return
        try:
            with open(INSTRUCTIONS_CACHE_FILE, 'r', encoding='utf-8') as f:
                instructions = json.load(f)
            print("Successfully loaded instructions from local cache.")
        except json.JSONDecodeError:
            print("Error: Could not parse the local instructions cache file. It may be corrupt.")
            return
    else:
        api_key = get_api_key()
        if not api_key:
            print("API Key not provided. Exiting.")
            return
        genai.configure(api_key=api_key)

        if not os.path.exists(PROMPT_FILENAME):
            print(f"Error: Prompt file '{PROMPT_FILENAME}' not found.")
            return
        with open(PROMPT_FILENAME, 'r', encoding='utf-8') as f:
            prompt_template = f.read()

        full_prompt = prompt_template.replace(PROMPT_PLACEHOLDER, article_text)

        print("Calling the Gemini API directly...")
        max_retries = 5
        retry_delay = 2
        for attempt in range(max_retries):
            try:
                # Use a free-tier compatible model.
                model = genai.GenerativeModel('gemini-2.5-flash')
                response = model.generate_content(full_prompt)
                gemini_output = response.text
                print("Successfully received response from API.")
                
                json_match = re.search(r'```json\s*([\s\S]*?)\s*```', gemini_output)
                json_str = json_match.group(1) if json_match else gemini_output
                instructions = json.loads(json_str)
                print("Successfully parsed JSON instructions.")
                
                with open(INSTRUCTIONS_CACHE_FILE, 'w', encoding='utf-8') as f:
                    json.dump(instructions, f, indent=4)
                print(f"✅ Instructions saved to '{INSTRUCTIONS_CACHE_FILE}' for future use.")
                break  # Exit the loop on success
            
            except Exception as e:
                # Check for retriable server-side or rate-limit errors
                error_str = str(e)
                if ("429" in error_str and "Quota" in error_str) or \
                   ("504" in error_str and "timed out" in error_str) or \
                   ("503" in error_str) or \
                   ("500" in error_str):
                    
                    print(f"Retriable API Error: {e}")
                    print(f"Retrying in {retry_delay} seconds... (Attempt {attempt + 1}/{max_retries})")

                    time.sleep(retry_delay)
                    retry_delay *= 2  # Exponential backoff
                else:
                    print(f"\nAn unrecoverable error occurred while calling the API: {e}")
                    if 'gemini_output' in locals():
                        print("--- API Raw Output ---\n" + gemini_output)
                    return
        else: # This block runs if the loop completes without a break
            print("Error: Max retries exceeded. Failed to get a successful response from the API.")
            return

    if instructions:
        create_jekyll_post(article_text, instructions, output_dir)

if __name__ == '__main__':
    main()
```

And the all-important diff:

```diff
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ xv articleizer.py
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ git --no-pager diff
diff --git a/scripts/articles/articleizer.py b/scripts/articles/articleizer.py
index a72b788b..ac396379 100644
--- a/scripts/articles/articleizer.py
+++ b/scripts/articles/articleizer.py
@@ -71,6 +71,7 @@ def create_jekyll_post(article_content, instructions, output_dir):
     structured AI-generated instructions.
     
     Auto-increments 'sort_order' based on existing posts for the current date.
+    Wraps content in Liquid {% raw %} tags to prevent template errors.
     """
     print("Formatting final Jekyll post...")
 
@@ -174,6 +175,13 @@ def create_jekyll_post(article_content, instructions, output_dir):
         intro_section = f"## Setting the Stage: Context for the Curious Book Reader\n\n{prepend_text}\n\n---"
         article_body = f"{intro_section}\n\n{article_body}"
 
+    # --- WRAPPING LOGIC START ---
+    # Wrap the entire body in {% raw %} ... {% endraw %} to prevent Liquid processing errors
+    # only if it's not already wrapped.
+    if not article_body.strip().startswith("{% raw %}"):
+        article_body = f"{{% raw %}}\n{article_body}\n{{% endraw %}}"
+    # --- WRAPPING LOGIC END ---
+
     analysis_markdown = "\n## Book Analysis\n"
     if 'ai_editorial_take' in analysis_content:
         analysis_markdown += f"\n### Ai Editorial Take\n{analysis_content['ai_editorial_take']}\n"
@@ -325,4 +333,4 @@ def main():
         create_jekyll_post(article_text, instructions, output_dir)
 
 if __name__ == '__main__':
-    main()
+    main()
\ No newline at end of file
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$
```

And the test. If it worked, this will be the last thing you see because Gemini
already prematurely put a bow on the article above, ahaha!

Surprise. Murphy's Law. I ran out of quota on the API key I'm using for the
model I'm using for the project I'm using for the user login I'm using. I have a
file: `/home/mike/.config/articleizer/keys.json` in the following format:

```json
{
  "default": "foo",
  "pipulate": "bar",
  "work": "baz"
}
```

I need `articleizer.py` to take an optional key parameter to let me pick which
API key I'm using, please and thank you.

## Pinpointing the API Quota Quagmire

**Gemini**: Context verified.

Ah, the inevitable quota wall. A classic sign of progress! Let's get that multi-key support implemented immediately so you can switch gears without missing a beat.

Here is the updated `articleizer.py`.

**Changes Implemented:**

1. **Key Loading:** Added `load_keys()` to read from `~/.config/articleizer/keys.json` if it exists.
2. **Arguments:** Added a `-k` / `--key` argument to `argparse`.
* If you pass a name (e.g., `-k work`), it looks up that key in `keys.json`.
* If you pass a raw key string (e.g., `-k AIza...`), it uses it directly.
* If you omit it, it defaults to the `default` key in `keys.json`, or falls back to the old `api_key.txt` method.


3. **Fallback Logic:** It creates a robust hierarchy: Argument > `keys.json` (default) > `api_key.txt` > Interactive Prompt.

```python
# scripts/articles/articleizer.py
import os
import sys
import json
import yaml
import re
from datetime import datetime
import getpass
from pathlib import Path
import google.generativeai as genai
import argparse
import time # NEW: Import time for the retry delay

# --- CONFIGURATION ---
CONFIG_DIR = Path.home() / ".config" / "articleizer"
API_KEY_FILE = CONFIG_DIR / "api_key.txt"
KEYS_JSON_FILE = CONFIG_DIR / "keys.json"
TARGETS_FILE = CONFIG_DIR / "targets.json"

ARTICLE_FILENAME = "article.txt"
PROMPT_FILENAME = "editing_prompt.txt"
PROMPT_PLACEHOLDER = "[INSERT FULL ARTICLE]"
INSTRUCTIONS_CACHE_FILE = "instructions.json"

# Safe default if config is missing (keeps the public repo functional but private)
DEFAULT_TARGETS = {
    "1": {
        "name": "Local Project (Default)",
        "path": "./_posts"
    }
}

def load_targets():
    """Loads publishing targets from external config or falls back to default."""
    if TARGETS_FILE.exists():
        try:
            with open(TARGETS_FILE, 'r') as f:
                return json.load(f)
        except json.JSONDecodeError:
            print(f"⚠️ Warning: {TARGETS_FILE} is corrupt. Using defaults.")
    return DEFAULT_TARGETS

def load_keys():
    """Loads API keys from keys.json if it exists."""
    if KEYS_JSON_FILE.exists():
        try:
            with open(KEYS_JSON_FILE, 'r') as f:
                return json.load(f)
        except json.JSONDecodeError:
            print(f"⚠️ Warning: {KEYS_JSON_FILE} is corrupt.")
    return {}

PROJECT_TARGETS = load_targets()
AVAILABLE_KEYS = load_keys()
# --------------------------------

def get_api_key(key_arg=None):
    """
    Resolves the API key based on arguments, config files, or user input.
    Hierarchy:
    1. CLI Argument (mapped name or raw key)
    2. 'default' key in keys.json
    3. content of api_key.txt
    4. Interactive Prompt
    """
    # 1. Check CLI Argument
    if key_arg:
        # Check if it's a key name in our config
        if key_arg in AVAILABLE_KEYS:
            print(f"🔑 Using API key: '{key_arg}' from keys.json")
            return AVAILABLE_KEYS[key_arg]
        # Assume it's a raw key
        print("🔑 Using API key provided via argument.")
        return key_arg

    # 2. Check keys.json for 'default'
    if 'default' in AVAILABLE_KEYS:
        print("🔑 Using 'default' API key from keys.json")
        return AVAILABLE_KEYS['default']

    # 3. Check legacy api_key.txt
    if API_KEY_FILE.is_file():
        print(f"🔑 Reading API key from {API_KEY_FILE}...")
        return API_KEY_FILE.read_text().strip()

    # 4. Interactive Prompt
    print("Google API Key not found.")
    print("Please go to https://aistudio.google.com/app/apikey to get one.")
    key = getpass.getpass("Enter your Google API Key: ")

    save_key_choice = input(f"Do you want to save this key to {API_KEY_FILE} for future use? (y/n): ").lower().strip()
    if save_key_choice == 'y':
        try:
            CONFIG_DIR.mkdir(parents=True, exist_ok=True)
            API_KEY_FILE.write_text(key)
            API_KEY_FILE.chmod(0o600)
            print(f"✅ Key saved securely.")
        except Exception as e:
            print(f"⚠️ Could not save API key. Error: {e}")
    return key

def create_jekyll_post(article_content, instructions, output_dir):
    """
    Assembles and writes a Jekyll post file from the article content and
    structured AI-generated instructions.
    
    Auto-increments 'sort_order' based on existing posts for the current date.
    Wraps content in Liquid {% raw %} tags to prevent template errors.
    """
    print("Formatting final Jekyll post...")

    # 1. Determine Date and Auto-Increment Sort Order
    current_date = datetime.now().strftime('%Y-%m-%d')
    next_sort_order = 1
    
    try:
        target_path = Path(output_dir)
        if target_path.exists():
            # Find all markdown files for today
            todays_posts = list(target_path.glob(f"{current_date}-*.md"))
            
            max_order = 0
            for post_file in todays_posts:
                try:
                    # Read content to parse front matter
                    content = post_file.read_text(encoding='utf-8')
                    if content.startswith('---'):
                        # Split to isolate YAML block (between first two ---)
                        parts = content.split('---', 2)
                        if len(parts) >= 3:
                            front_matter = yaml.safe_load(parts[1])
                            if front_matter and 'sort_order' in front_matter:
                                try:
                                    order = int(front_matter['sort_order'])
                                    if order > max_order:
                                        max_order = order
                                except (ValueError, TypeError):
                                    continue
                except Exception as e:
                    print(f"Warning checking sort_order in {post_file.name}: {e}")
            
            if max_order > 0:
                next_sort_order = max_order + 1
                print(f"📅 Found {len(todays_posts)} posts for today. Auto-incrementing sort_order to {next_sort_order}.")
            else:
                print(f"📅 First post of the day. sort_order set to 1.")
                
    except Exception as e:
        print(f"⚠️ Could not calculate auto-increment sort_order: {e}. Defaulting to 1.")

    # 2. Prepare Data
    editing_instr = instructions.get("editing_instructions", {})
    analysis_content = instructions.get("book_analysis_content", {})
    yaml_updates = editing_instr.get("yaml_updates", {})

    new_yaml_data = {
        'title': yaml_updates.get("title"),
        'permalink': yaml_updates.get("permalink"),
        'description': analysis_content.get("authors_imprint"),
        'meta_description': yaml_updates.get("description"),
        'meta_keywords': yaml_updates.get("keywords"),
        'layout': 'post',
        'sort_order': next_sort_order  # <--- Now uses the dynamic value
    }
    
    # 3. Assemble Content
    final_yaml_block = f"---\n{yaml.dump(new_yaml_data, Dumper=yaml.SafeDumper, sort_keys=False, default_flow_style=False)}---"

    article_body = article_content.strip()
    article_body = f"## Technical Journal Entry Begins\n\n{article_body}"

    subheadings = editing_instr.get("insert_subheadings", [])
    for item in reversed(subheadings):
        snippet = item.get("after_text_snippet", "")
        subheading = item.get("subheading", "## Missing Subheading")
        if not snippet:
            print(f"Warning: Skipping subheading '{subheading}' due to missing snippet.")
            continue

        words = re.findall(r'\w+', snippet.lower())
        pattern_text = r'.*?'.join(re.escape(word) for word in words)

        match = re.search(pattern_text, article_body, re.IGNORECASE | re.DOTALL)
        if match:
            # SAFETY FIX: Force insertion to the nearest paragraph break (double newline).
            # This prevents headlines from splitting sentences or paragraphs mid-stream.
            match_end = match.end()
            
            # Find the next double newline starting from the end of the match
            insertion_point = article_body.find('\n\n', match_end)
            
            # If no paragraph break is found (end of document), append to the very end.
            if insertion_point == -1:
                insertion_point = len(article_body)
            
            # Insert the subheading surrounded by newlines.
            # If insertion_point finds an existing '\n\n', this logic adds another '\n\n'
            # effectively creating: [End of Para]\n\n[Subheading]\n\n[Start of Next Para]
            article_body = (
                article_body[:insertion_point] +
                f"\n\n{subheading}" +
                article_body[insertion_point:]
            )
        else:
            print(f"Warning: Snippet not found for subheading '{subheading}': '{snippet}'")

    prepend_text = editing_instr.get("prepend_to_article_body", "")
    if prepend_text:
        intro_section = f"## Setting the Stage: Context for the Curious Book Reader\n\n{prepend_text}\n\n---"
        article_body = f"{intro_section}\n\n{article_body}"

    # --- WRAPPING LOGIC START ---
    # Wrap the entire body in {% raw %} ... {% endraw %} to prevent Liquid processing errors
    # only if it's not already wrapped.
    if not article_body.strip().startswith("{% raw %}"):
        article_body = f"{{% raw %}}\n{article_body}\n{{% endraw %}}"
    # --- WRAPPING LOGIC END ---

    analysis_markdown = "\n## Book Analysis\n"
    if 'ai_editorial_take' in analysis_content:
        analysis_markdown += f"\n### Ai Editorial Take\n{analysis_content['ai_editorial_take']}\n"
    for key, value in analysis_content.items():
        if key in ['authors_imprint', 'ai_editorial_take']:
            continue
        title = key.replace('_', ' ').title()
        analysis_markdown += f"\n### {title}\n"
        if isinstance(value, list):
            for item in value:
                if isinstance(item, dict):
                    analysis_markdown += f"* **Title Option:** {item.get('title', 'N/A')}\n"
                    analysis_markdown += f"  * **Filename:** `{item.get('filename', 'N/A')}`\n"
                    analysis_markdown += f"  * **Rationale:** {item.get('rationale', 'N/A')}\n"
                else:
                    analysis_markdown += f"- {item}\n"
        elif isinstance(value, dict):
            for sub_key, sub_value in value.items():
                analysis_markdown += f"- **{sub_key.replace('_', ' ').title()}:**\n"
                if isinstance(sub_value, list):
                    for point in sub_value:
                        analysis_markdown += f"  - {point}\n"
                else:
                    analysis_markdown += f"  - {sub_value}\n"
        else:
            analysis_markdown += f"{value}\n"

    final_content = f"{final_yaml_block}\n\n{article_body}\n\n---\n{analysis_markdown}"

    # 4. Generate Filename
    slug = "untitled-article"
    title_brainstorm = analysis_content.get("title_brainstorm", [])
    if title_brainstorm and title_brainstorm[0].get("filename"):
        slug = os.path.splitext(title_brainstorm[0]["filename"])[0]

    output_filename = f"{current_date}-{slug}.md"
    output_path = os.path.join(output_dir, output_filename)
    os.makedirs(output_dir, exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(final_content)

    print(f"✨ Success! Article saved to: {output_path}")

def main():
    parser = argparse.ArgumentParser(description="Process an article with the Gemini API and format it for Jekyll.")
    parser.add_argument(
        '-l', '--local',
        action='store_true',
        help=f"Use local '{INSTRUCTIONS_CACHE_FILE}' cache instead of calling the API."
    )
    parser.add_argument(
        '-k', '--key',
        type=str,
        default=None,
        help="Specify which API key to use (name from keys.json or raw key string). Defaults to 'default' in keys.json."
    )
    args = parser.parse_args()

    # --- NEW: INTERACTIVE TARGET SELECTION ---
    print("Please select a publishing target:")
    for key, target in PROJECT_TARGETS.items():
        print(f"  [{key}] {target['name']}")

    choice = input("Enter choice (1 or 2): ").strip()

    if choice not in PROJECT_TARGETS:
        print("Invalid choice. Exiting to prevent mis-publishing.")
        return

    selected_target = PROJECT_TARGETS[choice]
    output_dir = selected_target['path']
    print(f"✅ Publishing to: {selected_target['name']} ({output_dir})\n")
    # --- END NEW SECTION ---

    if not os.path.exists(ARTICLE_FILENAME):
        print(f"Error: Article file '{ARTICLE_FILENAME}' not found.")
        return
    with open(ARTICLE_FILENAME, 'r', encoding='utf-8') as f:
        article_text = f.read()

    instructions = None

    if args.local:
        print(f"Attempting to use local cache file: {INSTRUCTIONS_CACHE_FILE}")
        if not os.path.exists(INSTRUCTIONS_CACHE_FILE):
            print(f"Error: Cache file not found. Run without --local to create it.")
            return
        try:
            with open(INSTRUCTIONS_CACHE_FILE, 'r', encoding='utf-8') as f:
                instructions = json.load(f)
            print("Successfully loaded instructions from local cache.")
        except json.JSONDecodeError:
            print("Error: Could not parse the local instructions cache file. It may be corrupt.")
            return
    else:
        api_key = get_api_key(args.key)
        if not api_key:
            print("API Key not provided. Exiting.")
            return
        genai.configure(api_key=api_key)

        if not os.path.exists(PROMPT_FILENAME):
            print(f"Error: Prompt file '{PROMPT_FILENAME}' not found.")
            return
        with open(PROMPT_FILENAME, 'r', encoding='utf-8') as f:
            prompt_template = f.read()

        full_prompt = prompt_template.replace(PROMPT_PLACEHOLDER, article_text)

        print("Calling the Gemini API directly...")
        max_retries = 5
        retry_delay = 2
        for attempt in range(max_retries):
            try:
                # Use a free-tier compatible model.
                model = genai.GenerativeModel('gemini-2.5-flash')
                response = model.generate_content(full_prompt)
                gemini_output = response.text
                print("Successfully received response from API.")
                
                json_match = re.search(r'```json\s*([\s\S]*?)\s*```', gemini_output)
                json_str = json_match.group(1) if json_match else gemini_output
                instructions = json.loads(json_str)
                print("Successfully parsed JSON instructions.")
                
                with open(INSTRUCTIONS_CACHE_FILE, 'w', encoding='utf-8') as f:
                    json.dump(instructions, f, indent=4)
                print(f"✅ Instructions saved to '{INSTRUCTIONS_CACHE_FILE}' for future use.")
                break  # Exit the loop on success
            
            except Exception as e:
                # Check for retriable server-side or rate-limit errors
                error_str = str(e)
                if ("429" in error_str and "Quota" in error_str) or \
                   ("504" in error_str and "timed out" in error_str) or \
                   ("503" in error_str) or \
                   ("500" in error_str):
                    
                    print(f"Retriable API Error: {e}")
                    print(f"Retrying in {retry_delay} seconds... (Attempt {attempt + 1}/{max_retries})")

                    time.sleep(retry_delay)
                    retry_delay *= 2  # Exponential backoff
                else:
                    print(f"\nAn unrecoverable error occurred while calling the API: {e}")
                    if 'gemini_output' in locals():
                        print("--- API Raw Output ---\n" + gemini_output)
                    return
        else: # This block runs if the loop completes without a break
            print("Error: Max retries exceeded. Failed to get a successful response from the API.")
            return

    if instructions:
        create_jekyll_post(article_text, instructions, output_dir)

if __name__ == '__main__':
    main()
```

And this is the look of *pin-and-win* chisel-strike methodology:

```bash
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ git commit -am "Making articleizer wrap all articles in raw and endraw liquid template tags"
[main 42d6191f] Making articleizer wrap all articles in raw and endraw liquid template tags
 1 file changed, 9 insertions(+), 1 deletion(-)
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ git push
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 48 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 727 bytes | 727.00 KiB/s, done.
Total 5 (delta 4), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (4/4), completed with 4 local objects.
To github.com:miklevin/pipulate
   52e44bd0..42d6191f  main -> main
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ xv articleizer.py
(nix) 
```

```diff
[mike@nixos:~/repos/pipulate/scripts/articles]$ git --no-pager diff
diff --git a/scripts/articles/articleizer.py b/scripts/articles/articleizer.py
index ac396379..02800214 100644
--- a/scripts/articles/articleizer.py
+++ b/scripts/articles/articleizer.py
@@ -13,6 +13,7 @@ import time # NEW: Import time for the retry delay
 # --- CONFIGURATION ---
 CONFIG_DIR = Path.home() / ".config" / "articleizer"
 API_KEY_FILE = CONFIG_DIR / "api_key.txt"
+KEYS_JSON_FILE = CONFIG_DIR / "keys.json"
 TARGETS_FILE = CONFIG_DIR / "targets.json"
 
 ARTICLE_FILENAME = "article.txt"
@@ -38,18 +39,50 @@ def load_targets():
             print(f"⚠️ Warning: {TARGETS_FILE} is corrupt. Using defaults.")
     return DEFAULT_TARGETS
 
+def load_keys():
+    """Loads API keys from keys.json if it exists."""
+    if KEYS_JSON_FILE.exists():
+        try:
+            with open(KEYS_JSON_FILE, 'r') as f:
+                return json.load(f)
+        except json.JSONDecodeError:
+            print(f"⚠️ Warning: {KEYS_JSON_FILE} is corrupt.")
+    return {}
+
 PROJECT_TARGETS = load_targets()
+AVAILABLE_KEYS = load_keys()
 # --------------------------------
 
-def get_api_key():
+def get_api_key(key_arg=None):
     """
-    Gets the API key by first checking a local config file, and if not found,
-    securely prompting the user and offering to save it.
+    Resolves the API key based on arguments, config files, or user input.
+    Hierarchy:
+    1. CLI Argument (mapped name or raw key)
+    2. 'default' key in keys.json
+    3. content of api_key.txt
+    4. Interactive Prompt
     """
+    # 1. Check CLI Argument
+    if key_arg:
+        # Check if it's a key name in our config
+        if key_arg in AVAILABLE_KEYS:
+            print(f"🔑 Using API key: '{key_arg}' from keys.json")
+            return AVAILABLE_KEYS[key_arg]
+        # Assume it's a raw key
+        print("🔑 Using API key provided via argument.")
+        return key_arg
+
+    # 2. Check keys.json for 'default'
+    if 'default' in AVAILABLE_KEYS:
+        print("🔑 Using 'default' API key from keys.json")
+        return AVAILABLE_KEYS['default']
+
+    # 3. Check legacy api_key.txt
     if API_KEY_FILE.is_file():
-        print(f"Reading API key from {API_KEY_FILE}...")
+        print(f"🔑 Reading API key from {API_KEY_FILE}...")
         return API_KEY_FILE.read_text().strip()
 
+    # 4. Interactive Prompt
     print("Google API Key not found.")
     print("Please go to https://aistudio.google.com/app/apikey to get one.")
     key = getpass.getpass("Enter your Google API Key: ")
@@ -233,6 +266,12 @@ def main():
         action='store_true',
         help=f"Use local '{INSTRUCTIONS_CACHE_FILE}' cache instead of calling the API."
     )
+    parser.add_argument(
+        '-k', '--key',
+        type=str,
+        default=None,
+        help="Specify which API key to use (name from keys.json or raw key string). Defaults to 'default' in keys.json."
+    )
     args = parser.parse_args()
 
     # --- NEW: INTERACTIVE TARGET SELECTION ---
@@ -272,7 +311,7 @@ def main():
             print("Error: Could not parse the local instructions cache file. It may be corrupt.")
             return
     else:
-        api_key = get_api_key()
+        api_key = get_api_key(args.key)
         if not api_key:
             print("API Key not provided. Exiting.")
             return
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$
```

Okay, that was a good change but the error is something else! Is it clear from
the error message or is the program eating the clues?

```bash
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ python articleizer.py -k pipulate
Please select a publishing target:
  [1] MikeLev.in (Public)
  [2] Pipulate.com (Future)
Enter choice (1 or 2): 1
✅ Publishing to: MikeLev.in (Public) (/home/mike/repos/MikeLev.in/_posts)

🔑 Using API key: 'pipulate' from keys.json
Calling the Gemini API directly...
Retriable API Error: 429 You exceeded your current quota, please check your plan and billing details. For more information on this error, head to: https://ai.google.dev/gemini-api/docs/rate-limits. To monitor your current usage, head to: https://ai.dev/usage?tab=rate-limit. 
* Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-2.5-flash
Please retry in 24.73685959s. [links {
  description: "Learn more about Gemini API quotas"
  url: "https://ai.google.dev/gemini-api/docs/rate-limits"
}
, violations {
  quota_metric: "generativelanguage.googleapis.com/generate_content_free_tier_requests"
  quota_id: "GenerateRequestsPerMinutePerProjectPerModel-FreeTier"
  quota_dimensions {
    key: "model"
    value: "gemini-2.5-flash"
  }
  quota_dimensions {
    key: "location"
    value: "global"
  }
  quota_value: 5
}
, retry_delay {
  seconds: 24
}
]
Retrying in 2 seconds... (Attempt 1/5)
Retriable API Error: 429 You exceeded your current quota, please check your plan and billing details. For more information on this error, head to: https://ai.google.dev/gemini-api/docs/rate-limits. To monitor your current usage, head to: https://ai.dev/usage?tab=rate-limit. 
* Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-2.5-flash
Please retry in 22.532006656s. [links {
  description: "Learn more about Gemini API quotas"
  url: "https://ai.google.dev/gemini-api/docs/rate-limits"
}
, violations {
  quota_metric: "generativelanguage.googleapis.com/generate_content_free_tier_requests"
  quota_id: "GenerateRequestsPerMinutePerProjectPerModel-FreeTier"
  quota_dimensions {
    key: "model"
    value: "gemini-2.5-flash"
  }
  quota_dimensions {
    key: "location"
    value: "global"
  }
  quota_value: 5
}
, retry_delay {
  seconds: 22
}
]
Retrying in 4 seconds... (Attempt 2/5)
Retriable API Error: 429 You exceeded your current quota, please check your plan and billing details. For more information on this error, head to: https://ai.google.dev/gemini-api/docs/rate-limits. To monitor your current usage, head to: https://ai.dev/usage?tab=rate-limit. 
* Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-2.5-flash
Please retry in 18.314772452s. [links {
  description: "Learn more about Gemini API quotas"
  url: "https://ai.google.dev/gemini-api/docs/rate-limits"
}
, violations {
  quota_metric: "generativelanguage.googleapis.com/generate_content_free_tier_requests"
  quota_id: "GenerateRequestsPerMinutePerProjectPerModel-FreeTier"
  quota_dimensions {
    key: "model"
    value: "gemini-2.5-flash"
  }
  quota_dimensions {
    key: "location"
    value: "global"
  }
  quota_value: 5
}
, retry_delay {
  seconds: 18
}
]
Retrying in 8 seconds... (Attempt 3/5)
^CTraceback (most recent call last):
  File "/home/mike/repos/pipulate/scripts/articles/articleizer.py", line 335, in main
    response = model.generate_content(full_prompt)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/generativeai/generative_models.py", line 248, in generate_content
    response = self._client.generate_content(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/ai/generativelanguage_v1beta/services/generative_service/client.py", line 566, in generate_content
    response = rpc(
               ^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/gapic_v1/method.py", line 131, in __call__
    return wrapped_func(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_unary.py", line 294, in retry_wrapped_func
    return retry_target(
           ^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_unary.py", line 156, in retry_target
    next_sleep = _retry_error_helper(
                 ^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_base.py", line 214, in _retry_error_helper
    raise final_exc from source_exc
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_unary.py", line 147, in retry_target
    result = target()
             ^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/timeout.py", line 130, in func_with_timeout
    return func(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/grpc_helpers.py", line 77, in error_remapped_callable
    raise exceptions.from_grpc_error(exc) from exc
google.api_core.exceptions.ResourceExhausted: 429 You exceeded your current quota, please check your plan and billing details. For more information on this error, head to: https://ai.google.dev/gemini-api/docs/rate-limits. To monitor your current usage, head to: https://ai.dev/usage?tab=rate-limit. 
* Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-2.5-flash
Please retry in 18.314772452s. [links {
  description: "Learn more about Gemini API quotas"
  url: "https://ai.google.dev/gemini-api/docs/rate-limits"
}
, violations {
  quota_metric: "generativelanguage.googleapis.com/generate_content_free_tier_requests"
  quota_id: "GenerateRequestsPerMinutePerProjectPerModel-FreeTier"
  quota_dimensions {
    key: "model"
    value: "gemini-2.5-flash"
  }
  quota_dimensions {
    key: "location"
    value: "global"
  }
  quota_value: 5
}
, retry_delay {
  seconds: 18
}
]

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/mike/repos/pipulate/scripts/articles/articleizer.py", line 375, in <module>
    main()
  File "/home/mike/repos/pipulate/scripts/articles/articleizer.py", line 360, in main
    time.sleep(retry_delay)
KeyboardInterrupt

(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ 
```

Something else is going on here. I'm using keys that I haven't touched yet today
and it still does this:

```bash
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ python articleizer.py -k mlseo
Please select a publishing target:
  [1] MikeLev.in (Public)
  [2] Pipulate.com (Future)
Enter choice (1 or 2): 1
✅ Publishing to: MikeLev.in (Public) (/home/mike/repos/MikeLev.in/_posts)

🔑 Using API key: 'mlseo' from keys.json
Calling the Gemini API directly...
Retriable API Error: 504 The request timed out. Please try again.
Retrying in 2 seconds... (Attempt 1/5)
Retriable API Error: 429 You exceeded your current quota, please check your plan and billing details. For more information on this error, head to: https://ai.google.dev/gemini-api/docs/rate-limits. To monitor your current usage, head to: https://ai.dev/usage?tab=rate-limit. 
* Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-2.5-flash
Please retry in 12.812149838s. [links {
  description: "Learn more about Gemini API quotas"
  url: "https://ai.google.dev/gemini-api/docs/rate-limits"
}
, violations {
  quota_metric: "generativelanguage.googleapis.com/generate_content_free_tier_requests"
  quota_id: "GenerateRequestsPerMinutePerProjectPerModel-FreeTier"
  quota_dimensions {
    key: "model"
    value: "gemini-2.5-flash"
  }
  quota_dimensions {
    key: "location"
    value: "global"
  }
  quota_value: 5
}
, retry_delay {
  seconds: 12
}
]
Retrying in 4 seconds... (Attempt 2/5)
^CTraceback (most recent call last):
  File "/home/mike/repos/pipulate/scripts/articles/articleizer.py", line 335, in main
    response = model.generate_content(full_prompt)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/generativeai/generative_models.py", line 248, in generate_content
    response = self._client.generate_content(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/ai/generativelanguage_v1beta/services/generative_service/client.py", line 566, in generate_content
    response = rpc(
               ^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/gapic_v1/method.py", line 131, in __call__
    return wrapped_func(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_unary.py", line 294, in retry_wrapped_func
    return retry_target(
           ^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_unary.py", line 156, in retry_target
    next_sleep = _retry_error_helper(
                 ^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_base.py", line 214, in _retry_error_helper
    raise final_exc from source_exc
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_unary.py", line 147, in retry_target
    result = target()
             ^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/timeout.py", line 130, in func_with_timeout
    return func(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/grpc_helpers.py", line 77, in error_remapped_callable
    raise exceptions.from_grpc_error(exc) from exc
google.api_core.exceptions.ResourceExhausted: 429 You exceeded your current quota, please check your plan and billing details. For more information on this error, head to: https://ai.google.dev/gemini-api/docs/rate-limits. To monitor your current usage, head to: https://ai.dev/usage?tab=rate-limit. 
* Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-2.5-flash
Please retry in 12.812149838s. [links {
  description: "Learn more about Gemini API quotas"
  url: "https://ai.google.dev/gemini-api/docs/rate-limits"
}
, violations {
  quota_metric: "generativelanguage.googleapis.com/generate_content_free_tier_requests"
  quota_id: "GenerateRequestsPerMinutePerProjectPerModel-FreeTier"
  quota_dimensions {
    key: "model"
    value: "gemini-2.5-flash"
  }
  quota_dimensions {
    key: "location"
    value: "global"
  }
  quota_value: 5
}
, retry_delay {
  seconds: 12
}
]

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/mike/repos/pipulate/scripts/articles/articleizer.py", line 375, in <module>
    main()
  File "/home/mike/repos/pipulate/scripts/articles/articleizer.py", line 360, in main
    time.sleep(retry_delay)
KeyboardInterrupt

(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$
```

So consequently there's something really wrong with the article source that's
making it fail silently and burn through it's daily quota on retries, or the
edits we just did recently to wrap everything in raw/endraw caused this. I need
to do an easy control so I'm making a minimal article to test it.

```bash
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ xv article.txt
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ python articleizer.py -k c1
Please select a publishing target:
  [1] MikeLev.in (Public)
  [2] Pipulate.com (Future)
Enter choice (1 or 2): 1
✅ Publishing to: MikeLev.in (Public) (/home/mike/repos/MikeLev.in/_posts)

🔑 Using API key: 'c1' from keys.json
Calling the Gemini API directly...
Retriable API Error: 429 You exceeded your current quota, please check your plan and billing details. For more information on this error, head to: https://ai.google.dev/gemini-api/docs/rate-limits. To monitor your current usage, head to: https://ai.dev/usage?tab=rate-limit. 
* Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-2.5-flash
Please retry in 59.08473145s. [links {
  description: "Learn more about Gemini API quotas"
  url: "https://ai.google.dev/gemini-api/docs/rate-limits"
}
, violations {
  quota_metric: "generativelanguage.googleapis.com/generate_content_free_tier_requests"
  quota_id: "GenerateRequestsPerMinutePerProjectPerModel-FreeTier"
  quota_dimensions {
    key: "model"
    value: "gemini-2.5-flash"
  }
  quota_dimensions {
    key: "location"
    value: "global"
  }
  quota_value: 5
}
, retry_delay {
  seconds: 59
}
]
Retrying in 2 seconds... (Attempt 1/5)
Retriable API Error: 429 You exceeded your current quota, please check your plan and billing details. For more information on this error, head to: https://ai.google.dev/gemini-api/docs/rate-limits. To monitor your current usage, head to: https://ai.dev/usage?tab=rate-limit. 
* Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-2.5-flash
Please retry in 56.957755093s. [links {
  description: "Learn more about Gemini API quotas"
  url: "https://ai.google.dev/gemini-api/docs/rate-limits"
}
, violations {
  quota_metric: "generativelanguage.googleapis.com/generate_content_free_tier_requests"
  quota_id: "GenerateRequestsPerMinutePerProjectPerModel-FreeTier"
  quota_dimensions {
    key: "model"
    value: "gemini-2.5-flash"
  }
  quota_dimensions {
    key: "location"
    value: "global"
  }
  quota_value: 5
}
, retry_delay {
  seconds: 56
}
]
Retrying in 4 seconds... (Attempt 2/5)
^CTraceback (most recent call last):
  File "/home/mike/repos/pipulate/scripts/articles/articleizer.py", line 335, in main
    response = model.generate_content(full_prompt)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/generativeai/generative_models.py", line 248, in generate_content
    response = self._client.generate_content(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/ai/generativelanguage_v1beta/services/generative_service/client.py", line 566, in generate_content
    response = rpc(
               ^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/gapic_v1/method.py", line 131, in __call__
    return wrapped_func(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_unary.py", line 294, in retry_wrapped_func
    return retry_target(
           ^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_unary.py", line 156, in retry_target
    next_sleep = _retry_error_helper(
                 ^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_base.py", line 214, in _retry_error_helper
    raise final_exc from source_exc
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/retry/retry_unary.py", line 147, in retry_target
    result = target()
             ^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/timeout.py", line 130, in func_with_timeout
    return func(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/home/mike/repos/pipulate/.venv/lib/python3.12/site-packages/google/api_core/grpc_helpers.py", line 77, in error_remapped_callable
    raise exceptions.from_grpc_error(exc) from exc
google.api_core.exceptions.ResourceExhausted: 429 You exceeded your current quota, please check your plan and billing details. For more information on this error, head to: https://ai.google.dev/gemini-api/docs/rate-limits. To monitor your current usage, head to: https://ai.dev/usage?tab=rate-limit. 
* Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-2.5-flash
Please retry in 56.957755093s. [links {
  description: "Learn more about Gemini API quotas"
  url: "https://ai.google.dev/gemini-api/docs/rate-limits"
}
, violations {
  quota_metric: "generativelanguage.googleapis.com/generate_content_free_tier_requests"
  quota_id: "GenerateRequestsPerMinutePerProjectPerModel-FreeTier"
  quota_dimensions {
    key: "model"
    value: "gemini-2.5-flash"
  }
  quota_dimensions {
    key: "location"
    value: "global"
  }
  quota_value: 5
}
, retry_delay {
  seconds: 56
}
]

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/mike/repos/pipulate/scripts/articles/articleizer.py", line 375, in <module>
    main()
  File "/home/mike/repos/pipulate/scripts/articles/articleizer.py", line 360, in main
    time.sleep(retry_delay)
KeyboardInterrupt

(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ cat article.txt
This is a test article. I know it won't make sense to edit it, but I'm testing
the system so just play along.
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$
```

There you go. It's something about our new work wrapping things in liquid
template tags which I think is making bad API calls that report no errors and
retry so use up all my daily quota that's happening here.

## The Invisible Wall: Model Selection Matters

**Gemini**: Context verified.

You hit the "Invisible Wall." The traceback confirms a `429 ResourceExhausted` error, but the key detail is in the violation message from Google:

`quota_dimensions { key: "model" value: "gemini-2.5-flash" }`

**Here is the diagnosis:**

1. **The Culprit:** The script was requesting `gemini-2.5-flash`. While the API technically recognized the string, it likely categorized it as an experimental or restricted model with a punishingly low limit of **5 Requests Per Minute**.
2. **The Red Herring:** The Liquid tag wrapping logic (`{% raw %}`) is **innocent**. That wrapping happens locally in Python *after* the API call returns. It never touches the API.
3. **The Fix:** I have switched the default model to the stable workhorse `gemini-1.5-flash` (or you can use `gemini-2.0-flash` if preferred), which typically has much higher limits.

Here is the robust `articleizer.py` with the model fix and the `keys.json` selection logic fully implemented.

```python:scripts/articles/articleizer.py
import os
import sys
import json
import yaml
import re
from datetime import datetime
import getpass
from pathlib import Path
import google.generativeai as genai
import argparse
import time

# --- CONFIGURATION ---
CONFIG_DIR = Path.home() / ".config" / "articleizer"
API_KEY_FILE = CONFIG_DIR / "api_key.txt"
KEYS_JSON_FILE = CONFIG_DIR / "keys.json"
TARGETS_FILE = CONFIG_DIR / "targets.json"

ARTICLE_FILENAME = "article.txt"
PROMPT_FILENAME = "editing_prompt.txt"
PROMPT_PLACEHOLDER = "[INSERT FULL ARTICLE]"
INSTRUCTIONS_CACHE_FILE = "instructions.json"

# Model Selection - Use a stable model to avoid low quotas
DEFAULT_MODEL = 'gemini-1.5-flash' 

# Safe default if config is missing (keeps the public repo functional but private)
DEFAULT_TARGETS = {
    "1": {
        "name": "Local Project (Default)",
        "path": "./_posts"
    }
}

def load_targets():
    """Loads publishing targets from external config or falls back to default."""
    if TARGETS_FILE.exists():
        try:
            with open(TARGETS_FILE, 'r') as f:
                return json.load(f)
        except json.JSONDecodeError:
            print(f"⚠️ Warning: {TARGETS_FILE} is corrupt. Using defaults.")
    return DEFAULT_TARGETS

def load_keys():
    """Loads API keys from keys.json if it exists."""
    if KEYS_JSON_FILE.exists():
        try:
            with open(KEYS_JSON_FILE, 'r') as f:
                return json.load(f)
        except json.JSONDecodeError:
            print(f"⚠️ Warning: {KEYS_JSON_FILE} is corrupt.")
    return {}

PROJECT_TARGETS = load_targets()
AVAILABLE_KEYS = load_keys()
# --------------------------------

def get_api_key(key_arg=None):
    """
    Resolves the API key based on arguments, config files, or user input.
    Hierarchy:
    1. CLI Argument (mapped name or raw key)
    2. 'default' key in keys.json
    3. content of api_key.txt
    4. Interactive Prompt
    """
    # 1. Check CLI Argument
    if key_arg:
        # Check if it's a key name in our config
        if key_arg in AVAILABLE_KEYS:
            print(f"🔑 Using API key alias: '{key_arg}'")
            return AVAILABLE_KEYS[key_arg]
        # Assume it's a raw key
        print("🔑 Using raw API key provided via argument.")
        return key_arg

    # 2. Check keys.json for 'default'
    if 'default' in AVAILABLE_KEYS:
        print("🔑 Using 'default' API key from keys.json")
        return AVAILABLE_KEYS['default']

    # 3. Check legacy api_key.txt
    if API_KEY_FILE.is_file():
        print(f"🔑 Reading API key from {API_KEY_FILE}...")
        return API_KEY_FILE.read_text().strip()

    # 4. Interactive Prompt
    print("Google API Key not found.")
    print("Please go to https://aistudio.google.com/app/apikey to get one.")
    key = getpass.getpass("Enter your Google API Key: ")

    save_key_choice = input(f"Do you want to save this key to {API_KEY_FILE} for future use? (y/n): ").lower().strip()
    if save_key_choice == 'y':
        try:
            CONFIG_DIR.mkdir(parents=True, exist_ok=True)
            API_KEY_FILE.write_text(key)
            API_KEY_FILE.chmod(0o600)
            print(f"✅ Key saved securely.")
        except Exception as e:
            print(f"⚠️ Could not save API key. Error: {e}")
    return key

def create_jekyll_post(article_content, instructions, output_dir):
    """
    Assembles and writes a Jekyll post file from the article content and
    structured AI-generated instructions.
    
    Auto-increments 'sort_order' based on existing posts for the current date.
    Wraps content in Liquid {% raw %} tags to prevent template errors.
    """
    print("Formatting final Jekyll post...")

    # 1. Determine Date and Auto-Increment Sort Order
    current_date = datetime.now().strftime('%Y-%m-%d')
    next_sort_order = 1
    
    try:
        target_path = Path(output_dir)
        if target_path.exists():
            # Find all markdown files for today
            todays_posts = list(target_path.glob(f"{current_date}-*.md"))
            
            max_order = 0
            for post_file in todays_posts:
                try:
                    # Read content to parse front matter
                    content = post_file.read_text(encoding='utf-8')
                    if content.startswith('---'):
                        # Split to isolate YAML block (between first two ---)
                        parts = content.split('---', 2)
                        if len(parts) >= 3:
                            front_matter = yaml.safe_load(parts[1])
                            if front_matter and 'sort_order' in front_matter:
                                try:
                                    order = int(front_matter['sort_order'])
                                    if order > max_order:
                                        max_order = order
                                except (ValueError, TypeError):
                                    continue
                except Exception as e:
                    print(f"Warning checking sort_order in {post_file.name}: {e}")
            
            if max_order > 0:
                next_sort_order = max_order + 1
                print(f"📅 Found {len(todays_posts)} posts for today. Auto-incrementing sort_order to {next_sort_order}.")
            else:
                print(f"📅 First post of the day. sort_order set to 1.")
                
    except Exception as e:
        print(f"⚠️ Could not calculate auto-increment sort_order: {e}. Defaulting to 1.")

    # 2. Prepare Data
    editing_instr = instructions.get("editing_instructions", {})
    analysis_content = instructions.get("book_analysis_content", {})
    yaml_updates = editing_instr.get("yaml_updates", {})

    new_yaml_data = {
        'title': yaml_updates.get("title"),
        'permalink': yaml_updates.get("permalink"),
        'description': analysis_content.get("authors_imprint"),
        'meta_description': yaml_updates.get("description"),
        'meta_keywords': yaml_updates.get("keywords"),
        'layout': 'post',
        'sort_order': next_sort_order  # <--- Now uses the dynamic value
    }
    
    # 3. Assemble Content
    final_yaml_block = f"---\n{yaml.dump(new_yaml_data, Dumper=yaml.SafeDumper, sort_keys=False, default_flow_style=False)}---"

    article_body = article_content.strip()
    article_body = f"## Technical Journal Entry Begins\n\n{article_body}"

    subheadings = editing_instr.get("insert_subheadings", [])
    for item in reversed(subheadings):
        snippet = item.get("after_text_snippet", "")
        subheading = item.get("subheading", "## Missing Subheading")
        if not snippet:
            print(f"Warning: Skipping subheading '{subheading}' due to missing snippet.")
            continue

        words = re.findall(r'\w+', snippet.lower())
        pattern_text = r'.*?'.join(re.escape(word) for word in words)

        match = re.search(pattern_text, article_body, re.IGNORECASE | re.DOTALL)
        if match:
            # SAFETY FIX: Force insertion to the nearest paragraph break (double newline).
            # This prevents headlines from splitting sentences or paragraphs mid-stream.
            match_end = match.end()
            
            # Find the next double newline starting from the end of the match
            insertion_point = article_body.find('\n\n', match_end)
            
            # If no paragraph break is found (end of document), append to the very end.
            if insertion_point == -1:
                insertion_point = len(article_body)
            
            # Insert the subheading surrounded by newlines.
            # If insertion_point finds an existing '\n\n', this logic adds another '\n\n'
            # effectively creating: [End of Para]\n\n[Subheading]\n\n[Start of Next Para]
            article_body = (
                article_body[:insertion_point] +
                f"\n\n{subheading}" +
                article_body[insertion_point:]
            )
        else:
            print(f"Warning: Snippet not found for subheading '{subheading}': '{snippet}'")

    prepend_text = editing_instr.get("prepend_to_article_body", "")
    if prepend_text:
        intro_section = f"## Setting the Stage: Context for the Curious Book Reader\n\n{prepend_text}\n\n---"
        article_body = f"{intro_section}\n\n{article_body}"

    # --- WRAPPING LOGIC START ---
    # Wrap the entire body in {% raw %} ... {% endraw %} to prevent Liquid processing errors
    # only if it's not already wrapped.
    if not article_body.strip().startswith("{% raw %}"):
        article_body = f"{{% raw %}}\n{article_body}\n{{% endraw %}}"
    # --- WRAPPING LOGIC END ---

    analysis_markdown = "\n## Book Analysis\n"
    if 'ai_editorial_take' in analysis_content:
        analysis_markdown += f"\n### Ai Editorial Take\n{analysis_content['ai_editorial_take']}\n"
    for key, value in analysis_content.items():
        if key in ['authors_imprint', 'ai_editorial_take']:
            continue
        title = key.replace('_', ' ').title()
        analysis_markdown += f"\n### {title}\n"
        if isinstance(value, list):
            for item in value:
                if isinstance(item, dict):
                    analysis_markdown += f"* **Title Option:** {item.get('title', 'N/A')}\n"
                    analysis_markdown += f"  * **Filename:** `{item.get('filename', 'N/A')}`\n"
                    analysis_markdown += f"  * **Rationale:** {item.get('rationale', 'N/A')}\n"
                else:
                    analysis_markdown += f"- {item}\n"
        elif isinstance(value, dict):
            for sub_key, sub_value in value.items():
                analysis_markdown += f"- **{sub_key.replace('_', ' ').title()}:**\n"
                if isinstance(sub_value, list):
                    for point in sub_value:
                        analysis_markdown += f"  - {point}\n"
                else:
                    analysis_markdown += f"  - {sub_value}\n"
        else:
            analysis_markdown += f"{value}\n"

    final_content = f"{final_yaml_block}\n\n{article_body}\n\n---\n{analysis_markdown}"

    # 4. Generate Filename
    slug = "untitled-article"
    title_brainstorm = analysis_content.get("title_brainstorm", [])
    if title_brainstorm and title_brainstorm[0].get("filename"):
        slug = os.path.splitext(title_brainstorm[0]["filename"])[0]

    output_filename = f"{current_date}-{slug}.md"
    output_path = os.path.join(output_dir, output_filename)
    os.makedirs(output_dir, exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(final_content)

    print(f"✨ Success! Article saved to: {output_path}")

def main():
    parser = argparse.ArgumentParser(description="Process an article with the Gemini API and format it for Jekyll.")
    parser.add_argument(
        '-l', '--local',
        action='store_true',
        help=f"Use local '{INSTRUCTIONS_CACHE_FILE}' cache instead of calling the API."
    )
    parser.add_argument(
        '-k', '--key',
        type=str,
        default=None,
        help="Specify which API key to use (name from keys.json or raw key string). Defaults to 'default' in keys.json."
    )
    args = parser.parse_args()

    # --- NEW: INTERACTIVE TARGET SELECTION ---
    print("Please select a publishing target:")
    for key, target in PROJECT_TARGETS.items():
        print(f"  [{key}] {target['name']}")

    choice = input("Enter choice (1 or 2): ").strip()

    if choice not in PROJECT_TARGETS:
        print("Invalid choice. Exiting to prevent mis-publishing.")
        return

    selected_target = PROJECT_TARGETS[choice]
    output_dir = selected_target['path']
    print(f"✅ Publishing to: {selected_target['name']} ({output_dir})\n")
    # --- END NEW SECTION ---

    if not os.path.exists(ARTICLE_FILENAME):
        print(f"Error: Article file '{ARTICLE_FILENAME}' not found.")
        return
    with open(ARTICLE_FILENAME, 'r', encoding='utf-8') as f:
        article_text = f.read()

    instructions = None

    if args.local:
        print(f"Attempting to use local cache file: {INSTRUCTIONS_CACHE_FILE}")
        if not os.path.exists(INSTRUCTIONS_CACHE_FILE):
            print(f"Error: Cache file not found. Run without --local to create it.")
            return
        try:
            with open(INSTRUCTIONS_CACHE_FILE, 'r', encoding='utf-8') as f:
                instructions = json.load(f)
            print("Successfully loaded instructions from local cache.")
        except json.JSONDecodeError:
            print("Error: Could not parse the local instructions cache file. It may be corrupt.")
            return
    else:
        api_key = get_api_key(args.key)
        if not api_key:
            print("API Key not provided. Exiting.")
            return
        genai.configure(api_key=api_key)

        if not os.path.exists(PROMPT_FILENAME):
            print(f"Error: Prompt file '{PROMPT_FILENAME}' not found.")
            return
        with open(PROMPT_FILENAME, 'r', encoding='utf-8') as f:
            prompt_template = f.read()

        full_prompt = prompt_template.replace(PROMPT_PLACEHOLDER, article_text)

        print(f"Calling the Gemini API directly (using {DEFAULT_MODEL})...")
        max_retries = 5
        retry_delay = 2
        for attempt in range(max_retries):
            try:
                # Use a free-tier compatible model.
                model = genai.GenerativeModel(DEFAULT_MODEL)
                response = model.generate_content(full_prompt)
                gemini_output = response.text
                print("Successfully received response from API.")
                
                json_match = re.search(r'```json\s*([\s\S]*?)\s*```', gemini_output)
                json_str = json_match.group(1) if json_match else gemini_output
                instructions = json.loads(json_str)
                print("Successfully parsed JSON instructions.")
                
                with open(INSTRUCTIONS_CACHE_FILE, 'w', encoding='utf-8') as f:
                    json.dump(instructions, f, indent=4)
                print(f"✅ Instructions saved to '{INSTRUCTIONS_CACHE_FILE}' for future use.")
                break  # Exit the loop on success
            
            except Exception as e:
                # Check for retriable server-side or rate-limit errors
                error_str = str(e)
                if ("429" in error_str and "Quota" in error_str) or \
                   ("504" in error_str and "timed out" in error_str) or \
                   ("503" in error_str) or \
                   ("500" in error_str):
                    
                    print(f"Retriable API Error: {e}")
                    print(f"Retrying in {retry_delay} seconds... (Attempt {attempt + 1}/{max_retries})")

                    time.sleep(retry_delay)
                    retry_delay *= 2  # Exponential backoff
                else:
                    print(f"\nAn unrecoverable error occurred while calling the API: {e}")
                    if 'gemini_output' in locals():
                        print("--- API Raw Output ---\n" + gemini_output)
                    return
        else: # This block runs if the loop completes without a break
            print("Error: Max retries exceeded. Failed to get a successful response from the API.")
            return

    if instructions:
        create_jekyll_post(article_text, instructions, output_dir)

if __name__ == '__main__':
    main()

```

**Me**: Pinning the diff:

```diff
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ xv articleizer.py
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$ git --no-pager diff
diff --git a/scripts/articles/articleizer.py b/scripts/articles/articleizer.py
index 02800214..4b821b30 100644
--- a/scripts/articles/articleizer.py
+++ b/scripts/articles/articleizer.py
@@ -8,7 +8,7 @@ import getpass
 from pathlib import Path
 import google.generativeai as genai
 import argparse
-import time # NEW: Import time for the retry delay
+import time
 
 # --- CONFIGURATION ---
 CONFIG_DIR = Path.home() / ".config" / "articleizer"
@@ -21,6 +21,9 @@ PROMPT_FILENAME = "editing_prompt.txt"
 PROMPT_PLACEHOLDER = "[INSERT FULL ARTICLE]"
 INSTRUCTIONS_CACHE_FILE = "instructions.json"
 
+# Model Selection - Use a stable model to avoid low quotas
+DEFAULT_MODEL = 'gemini-1.5-flash' 
+
 # Safe default if config is missing (keeps the public repo functional but private)
 DEFAULT_TARGETS = {
     "1": {
@@ -66,10 +69,10 @@ def get_api_key(key_arg=None):
     if key_arg:
         # Check if it's a key name in our config
         if key_arg in AVAILABLE_KEYS:
-            print(f"🔑 Using API key: '{key_arg}' from keys.json")
+            print(f"🔑 Using API key alias: '{key_arg}'")
             return AVAILABLE_KEYS[key_arg]
         # Assume it's a raw key
-        print("🔑 Using API key provided via argument.")
+        print("🔑 Using raw API key provided via argument.")
         return key_arg
 
     # 2. Check keys.json for 'default'
@@ -325,13 +328,13 @@ def main():
 
         full_prompt = prompt_template.replace(PROMPT_PLACEHOLDER, article_text)
 
-        print("Calling the Gemini API directly...")
+        print(f"Calling the Gemini API directly (using {DEFAULT_MODEL})...")
         max_retries = 5
         retry_delay = 2
         for attempt in range(max_retries):
             try:
                 # Use a free-tier compatible model.
-                model = genai.GenerativeModel('gemini-2.5-flash')
+                model = genai.GenerativeModel(DEFAULT_MODEL)
                 response = model.generate_content(full_prompt)
                 gemini_output = response.text
                 print("Successfully received response from API.")
(nix) 
[mike@nixos:~/repos/pipulate/scripts/articles]$
```

**Me**: Okay, that finally worked. I had to change the model from
gemini-1.5-flash to gemini-2.5-flash which may have been the problem for the
whole (recent) time. It may have been one of those regressions slipping in based
on the model training cut-off date. I'm testing it with the current article. If
you see this, it worked.
{% endraw %}

---

## Book Analysis

### Ai Editorial Take
This journal entry provides a fascinating blueprint for developing a truly resilient, AI-assisted content pipeline. The deep dive into resolving Jekyll's Liquid tag challenges and the robust handling of API keys exemplify an advanced methodology for building 'future-proof' technical systems. The ability to gracefully handle common friction points like quota limits and model-specific nuances is paramount. This article serves as an excellent case study in how a thoughtful content architect can leverage AI not just for generation, but for systemic automation and problem resolution, creating a more seamless and less fragile publishing experience.

### Title Brainstorm
* **Title Option:** Automating Jekyll Post Generation and API Key Management with AI
  * **Filename:** `automating-jekyll-post-generation-and-api-key-management-with-ai.md`
  * **Rationale:** This title is comprehensive, clearly stating the technical focus on Jekyll, AI automation, and API key management, encompassing the core problem and solution presented.
* **Title Option:** From Context Painting to Quota Walls: A Deep Dive into AI-Powered Publishing
  * **Filename:** `context-painting-to-quota-walls-ai-publishing.md`
  * **Rationale:** This title uses evocative language ('Context Painting,' 'Quota Walls') to hint at the journey and challenges faced, appealing to a broader technical audience.
* **Title Option:** The Self-Healing Blog: Global Raw Tagging and Dynamic API Keys for Jekyll
  * **Filename:** `self-healing-blog-jekyll-raw-tags-api-keys.md`
  * **Rationale:** This title emphasizes the 'self-healing' aspect of the solution and highlights the two main technical fixes: raw tagging and dynamic API keys.
* **Title Option:** Mastering AI Workflows: Unlocking Seamless Jekyll Publishing and API Access
  * **Filename:** `mastering-ai-workflows-jekyll-api-access.md`
  * **Rationale:** This title focuses on the 'mastery' aspect of the workflow, indicating a comprehensive approach to both publishing and API interactions.

### Content Potential And Polish
- **Core Strengths:**
  - Clearly articulates a common technical problem (Liquid tag conflicts in Jekyll) and provides a practical, multi-stage solution.
  - Demonstrates a sophisticated understanding of AI integration into a publishing workflow, moving beyond simple API calls to architectural considerations.
  - The iterative problem-solving narrative, including the quota issue and model selection, is engaging and relatable for developers.
  - Highlights the importance of robust configuration management (API keys, publishing targets) for automated systems.
  - The meta-commentary on 'Forever Machines' and distributed systems adds philosophical depth to the technical details.
- **Suggestions For Polish:**
  - While the technical dialogue is excellent, adding a brief, high-level summary paragraph at the very beginning of the article (beyond the JSON intro) could help immediately hook readers less familiar with the specific context.
  - Visually representing the 'Before vs. After' for Liquid tags or the API key hierarchy could further enhance clarity.
  - Consider expanding on the 'Why distributed local systems' vs. 'centralized hosting' for those unfamiliar with the Nix DSL, as it's an important philosophical underpinning.
  - Ensure consistent naming for configuration files and directory paths where referenced within the article for absolute clarity.
  - Briefly explain `xv` for readers who may not be familiar with that shell alias/command.

### Next Step Prompts
- Brainstorm a 'next-generation' `editing_prompt.txt` for `articleizer.py` that leverages the increased context window to perform more sophisticated content analysis, such as identifying potential factual inaccuracies or suggesting external research links.
- Develop a conceptual framework or a small utility to monitor Gemini API usage across different keys and provide proactive warnings or suggestions for model switching before quotas are exhausted, integrating with `articleizer.py`.
