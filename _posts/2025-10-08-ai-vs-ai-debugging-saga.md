---
title: 'AI vs. AI: A Debugging Saga from Philosophical Debate to Cross-Platform Triumph'
permalink: /futureproof/ai-vs-ai-collaborative-debugging-triumph/
description: This entry was a whirlwind. It started as a simple script modification
  but quickly spiraled into a fascinating meta-commentary on my relationship with
  these AI tools. Having one AI instance correct another's work live on my machine
  was a genuine 'wow' moment. It validated my whole approach of treating AI as a true
  collaborator, not just a code generator. Squashing that `BlockingIOError` on Mac
  via my Nix setup felt like a huge win, proving the resilience of the local-first,
  cross-platform philosophy I'm building.
meta_description: Follow a developer's journey as two AIs collaborate to debug a Python
  `BlockingIOError`, blending technical fixes with philosophical debate and a successful
  release.
meta_keywords: AI collaboration, Python debugging, Gemini, BlockingIOError, Nix, cross-platform
  deployment, stderr, AI philosophy, release automation, list_articles.py, rich library
layout: post
sort_order: 2
---

## Setting the Stage: Context for the Curious Book Reader

This entry captures a multi-layered development session where the lines between coder, collaborator, and tool blur. It begins with a practical scripting enhancement for feeding an AI better context, then pivots into a deep philosophical debate on the nature of AI intelligence itself. The narrative then returns to the code, documenting a tenacious bug hunt where two different AI instances collaborate—and even critique one another—to solve a tricky cross-platform issue, culminating in a successful software release. It's a testament to a new era of human-AI partnership, where dialogue, logic, and a bit of magic lead to a triumphant fix.

---

## Technical Journal Entry Begins

Massive refactoring and bug squashing. The pursuit of the unobtainable, Pipulate
running in every context:

1. Local-install with some very special features difficult in a hosting setup.
2. In Google Colab Notebooks for an easy introduction and land-and-expanding.
3. An as-yet unimplemented traditional hosting setup, lacking a few special
   locally enabled features but similarly land-and-expand focused like Colab.

Interesting! Even the hosted version is there to get you to install it locally
and to *really* use Pipulate, haha! This is totally like the *Audrey* plant from
*Little Shop of Horrors.* I'm designing the **buds** in the Colab / traditional
hosting versions. Pipulate is distributed islands of local domain expertise data
generation that doesn't necessarily get pumped back up into the cloud.

Nobody's gonna get this until domain experts desperate to get the advantage of
AI start researching how to *really* do it locally, and by that time the whole
concept of the *Ship of Theseus* / *Chip O'Theseus* concept where your hardware
is just a few tick-cycles behind the cloud datacenters thanks to Moore's Law
will be primed in the public's mind.

"Oh! I can have an AI *genie in a bottle* **AT HOME** and it can *grow with me*
and my home-hardware rig and my needs? And it all stays private? I didn't know
such things were possible! Yeah, this kind of stuff has always been attempted
but there's this dramatic tension between centralized and decentralized with the
decentralized stuff always fizzling out because there's no singular centralized
corporate profit incentive driving it. Mastodon can't compete with Musk! Are you
kidding? The resources of the world versus a few BlueSky butterflies?

Nope.

But isolated islands of hardware just getting better and better hosting
something that's pulling down the latest from HuggingFace or Ollama just
layering in your own secret sauce... yup.

## Forging a Better Context Window

The thing is now I want to put the entire *article context* of MikeLev.in/ in
context for the next Gemini response to something like this so it has the
holistic feel for where I'm coming from, but that context from the raw articles
is way too massive. I've got the tiny meta description fields for SEO and then
I've got the normal description fields for the index... hmmm.

I've already got the `list_articles.py` program that I just made for getting the
file-lists with the token sizes so that I can put sequential chunks of the
articles in context. But I have a bug to squash and this is a potential deep
rabbit hole project! But is it? Is it really?

Hey Gemini, here's a `list_articles.py` program I wrote:

```python
#!/usr/bin/env python3
# list_posts_chronologically_config.py
import os
import sys
import yaml
import argparse
import tiktoken
from datetime import datetime

# NOTE: This script now requires 'tiktoken' and 'PyYAML'.
# Install them with: pip install tiktoken PyYAML

# --- CONFIGURATION ---
# Hardwire the absolute path to your posts directory here.
POSTS_DIRECTORY = "/home/mike/repos/MikeLev.in/_posts"

def count_tokens(text: str, model: str = "gpt-4") -> int:
    """Counts the number of tokens in a text string using the tiktoken library."""
    try:
        encoding = tiktoken.encoding_for_model(model)
        return len(encoding.encode(text))
    except Exception:
        # Fallback for any tiktoken errors
        return 0

def get_post_order(posts_dir=POSTS_DIRECTORY, reverse_order=False):
    """
    Parses Jekyll posts from a specified directory, sorts them by date
    and 'sort_order', and returns an ordered list of full absolute file paths.
    """
    posts_data = []
    
    if not os.path.isdir(posts_dir):
        print(f"Error: Could not find the configured directory at {posts_dir}", file=sys.stderr)
        return []

    for filename in os.listdir(posts_dir):
        filepath = os.path.join(posts_dir, filename)
        
        if not os.path.isfile(filepath) or not filename.endswith(('.md', '.markdown')):
            continue

        try:
            date_str = filename[:10]
            post_date = datetime.strptime(date_str, '%Y-%m-%d').date()

            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            if not content.startswith('---'):
                front_matter = {}
            else:
                parts = content.split('---', 2)
                front_matter = yaml.safe_load(parts[1]) or {}

            sort_order = int(front_matter.get('sort_order', 0))
            
            posts_data.append({
                'path': filepath,
                'date': post_date,
                'sort_order': sort_order
            })

        except (ValueError, yaml.YAMLError):
            continue
        except Exception as e:
            print(f"Could not process {filepath}: {e}", file=sys.stderr)

    # The 'reverse' flag of the sorted function is controlled by the new argument
    sorted_posts = sorted(
        posts_data, 
        key=lambda p: (p['date'], p['sort_order']), 
        reverse=not reverse_order
    )

    return [post['path'] for post in sorted_posts]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="List Jekyll posts in chronological order, optionally with token counts."
    )
    parser.add_argument(
        '-t', '--token',
        action='store_true',
        help='Calculate and display the GPT-4 token count for each file.'
    )
    parser.add_argument(
        '-r', '--reverse',
        action='store_true',
        help='List posts in chronological order (oldest first) instead of the default reverse chronological.'
    )
    args = parser.parse_args()

    # Pass the reverse flag to the function
    ordered_files = get_post_order(reverse_order=args.reverse)
    
    order_description = "chronological (oldest first)" if args.reverse else "reverse chronological (newest first)"
    print(f"Posts in {order_description} order (full paths):")
    
    if args.token:
        # --- PASS 1: Pre-calculate all token counts ---
        print("Calculating token counts for all files, this may take a moment...", file=sys.stderr)
        file_data = []
        for filepath in ordered_files:
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                token_count = count_tokens(content)
                file_data.append({'path': filepath, 'tokens': token_count})
            except Exception as e:
                print(f"{filepath}  # Error: Could not read file - {e}", file=sys.stderr)
                # Add a record with 0 tokens to avoid breaking the logic
                file_data.append({'path': filepath, 'tokens': 0})
        
        grand_total_tokens = sum(item['tokens'] for item in file_data)
        print("", file=sys.stderr) # Add a newline after the status message

        # --- PASS 2: Print formatted output with dual cumulative counts ---
        ascending_total = 0
        descending_total = grand_total_tokens

        for item in file_data:
            filepath = item['path']
            token_count = item['tokens']
            
            ascending_total += token_count
            
            # Print the new format with individual, ascending, and descending counts
            print(f"{filepath}  # {token_count:,} tokens ({ascending_total:,} / {descending_total:,} total)")
            
            # Decrement the descending total for the next iteration
            descending_total -= token_count

    else:
        # If --token is not used, just print the file paths as before
        for filepath in ordered_files:
            print(filepath)
```

Every article has at least the following YAML front-matter fields:

```yaml
---
title: 
permalink:
description: 
meta_description:
meta_keywords:
layout: post
sort_order:
---
```

I would like it to support one more flag/switch: `-m` or `--meta` that will
include the `meta_description` under each article's filepath. Format it nicely
for what YOU would like to see. I'm starting with meta so that the amount of
data is reasonable for the initial tests to see if you will be able to get an
idea of the overarching story from a smaller data-sample initially.

**Gemini**: Of course\! This is a great idea for getting a high-level overview of your content's narrative arc without overwhelming the context window. It's like giving an AI the "blurbs" from the back of all your books. 📚

Here is the updated `list_articles.py` script. I've integrated the `-m` / `--meta` flag and chose a clean, indented format for displaying the description, which I think you'll find easy to read.

```python
#!/usr/bin/env python3
# list_posts_chronologically_config.py
import os
import sys
import yaml
import argparse
import tiktoken
from datetime import datetime

# NOTE: This script now requires 'tiktoken' and 'PyYAML'.
# Install them with: pip install tiktoken PyYAML

# --- CONFIGURATION ---
# Hardwire the absolute path to your posts directory here.
POSTS_DIRECTORY = "/home/mike/repos/MikeLev.in/_posts"

def count_tokens(text: str, model: str = "gpt-4") -> int:
    """Counts the number of tokens in a text string using the tiktoken library."""
    try:
        encoding = tiktoken.encoding_for_model(model)
        return len(encoding.encode(text))
    except Exception:
        # Fallback for any tiktoken errors
        return 0

def get_post_order(posts_dir=POSTS_DIRECTORY, reverse_order=False):
    """
    Parses Jekyll posts, sorts them by date and 'sort_order', and returns an
    ordered list of dictionaries, each containing post data.
    """
    posts_data = []

    if not os.path.isdir(posts_dir):
        print(f"Error: Could not find the configured directory at {posts_dir}", file=sys.stderr)
        return []

    for filename in os.listdir(posts_dir):
        filepath = os.path.join(posts_dir, filename)

        if not os.path.isfile(filepath) or not filename.endswith(('.md', '.markdown')):
            continue

        try:
            date_str = filename[:10]
            post_date = datetime.strptime(date_str, '%Y-%m-%d').date()

            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            if not content.startswith('---'):
                front_matter = {}
            else:
                parts = content.split('---', 2)
                front_matter = yaml.safe_load(parts[1]) or {}

            sort_order = int(front_matter.get('sort_order', 0))
            # Extract meta_description, default to an empty string if not found
            meta_description = front_matter.get('meta_description', '')

            posts_data.append({
                'path': filepath,
                'date': post_date,
                'sort_order': sort_order,
                'meta_description': meta_description # <-- New field added here
            })

        except (ValueError, yaml.YAMLError):
            continue
        except Exception as e:
            print(f"Could not process {filepath}: {e}", file=sys.stderr)

    sorted_posts = sorted(
        posts_data,
        key=lambda p: (p['date'], p['sort_order']),
        reverse=not reverse_order
    )
    # Return the full list of dictionaries now
    return sorted_posts

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="List Jekyll posts in chronological order, with optional token counts and meta descriptions."
    )
    parser.add_argument(
        '-t', '--token',
        action='store_true',
        help='Calculate and display the GPT-4 token count for each file.'
    )
    parser.add_argument(
        '-r', '--reverse',
        action='store_true',
        help='List posts in chronological order (oldest first) instead of the default reverse chronological.'
    )
    parser.add_argument(
        '-m', '--meta',
        action='store_true',
        help='Include the meta_description from the front matter in the output.'
    )
    args = parser.parse_args()

    ordered_posts = get_post_order(reverse_order=args.reverse)

    order_description = "chronological (oldest first)" if args.reverse else "reverse chronological (newest first)"
    print(f"Posts in {order_description} order:")

    if args.token:
        # --- PASS 1: Pre-calculate all token counts ---
        print("Calculating token counts for all files, this may take a moment...", file=sys.stderr)
        file_data = []
        for post in ordered_posts:
            filepath = post['path']
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                token_count = count_tokens(content)
                # Carry the meta_description through
                file_data.append({'path': filepath, 'tokens': token_count, 'meta_description': post['meta_description']})
            except Exception as e:
                print(f"{filepath}  # Error: Could not read file - {e}", file=sys.stderr)
                file_data.append({'path': filepath, 'tokens': 0, 'meta_description': post['meta_description']})

        grand_total_tokens = sum(item['tokens'] for item in file_data)
        print("", file=sys.stderr)

        # --- PASS 2: Print formatted output ---
        ascending_total = 0
        descending_total = grand_total_tokens

        for item in file_data:
            ascending_total += item['tokens']
            print(f"{item['path']}  # {item['tokens']:,} tokens ({ascending_total:,} / {descending_total:,} total)")
            if args.meta and item['meta_description']:
                print(f"  └─ {item['meta_description']}") # Nicely formatted meta output
            descending_total -= item['tokens']

    else:
        # If --token is not used, just print the file paths and optionally meta
        for post in ordered_posts:
            print(post['path'])
            if args.meta and post['meta_description']:
                print(f"  └─ {post['meta_description']}") # Nicely formatted meta output

```

-----

### Key Changes ✨

  * **New Argument**: Added the `-m` or `--meta` flag to the `argparse` setup.
  * **Data Extraction**: The `get_post_order` function now parses the `meta_description` from the YAML front matter of each article. It now returns a list of dictionaries containing the path and metadata, rather than just a list of paths.
  * **Conditional Output**: The main part of the script now checks if `args.meta` is true.
      * If so, it prints the `meta_description` on a new line, indented with a `└─` to clearly associate it with the file path above it.
      * This works in both the default mode and the `--token` mode.

### Example Usage

Now you can run the script with your new flag. For example, to get the newest posts first, with their token counts and meta descriptions, you would run:

```bash
./list_articles.py -t -m
```

The output will look something like this, which should be perfect for pasting into a prompt:

```
Posts in reverse chronological (newest first) order:
/home/mike/repos/MikeLev.in/_posts/2025-10-08-some-new-post.md  # 1,234 tokens (1,234 / 567,890 total)
  └─ This is the meta description for my newest post about the Audrey plant and distributed AI.
/home/mike/repos/MikeLev.in/_posts/2025-10-05-another-post.md  # 2,500 tokens (3,734 / 566,656 total)
  └─ Here I discuss the Ship of Theseus concept in relation to modern home computing hardware.
...
```

**Me**: Okay, here's the diff:

```diff
[mike@nixos:~/repos/pipulate/scripts/articles]$ git --no-pager diff
diff --git a/scripts/articles/list_articles.py b/scripts/articles/list_articles.py
index 390477b5..0f2366e2 100644
--- a/scripts/articles/list_articles.py
+++ b/scripts/articles/list_articles.py
@@ -25,18 +25,18 @@ def count_tokens(text: str, model: str = "gpt-4") -> int:
 
 def get_post_order(posts_dir=POSTS_DIRECTORY, reverse_order=False):
     """
-    Parses Jekyll posts from a specified directory, sorts them by date
-    and 'sort_order', and returns an ordered list of full absolute file paths.
+    Parses Jekyll posts, sorts them by date and 'sort_order', and returns an
+    ordered list of dictionaries, each containing post data.
     """
     posts_data = []
-    
+
     if not os.path.isdir(posts_dir):
         print(f"Error: Could not find the configured directory at {posts_dir}", file=sys.stderr)
         return []
 
     for filename in os.listdir(posts_dir):
         filepath = os.path.join(posts_dir, filename)
-        
+
         if not os.path.isfile(filepath) or not filename.endswith(('.md', '.markdown')):
             continue
 
@@ -54,11 +54,14 @@ def get_post_order(posts_dir=POSTS_DIRECTORY, reverse_order=False):
                 front_matter = yaml.safe_load(parts[1]) or {}
 
             sort_order = int(front_matter.get('sort_order', 0))
-            
+            # Extract meta_description, default to an empty string if not found
+            meta_description = front_matter.get('meta_description', '')
+
             posts_data.append({
                 'path': filepath,
                 'date': post_date,
-                'sort_order': sort_order
+                'sort_order': sort_order,
+                'meta_description': meta_description # <-- New field added here
             })
 
         except (ValueError, yaml.YAMLError):
@@ -66,18 +69,17 @@ def get_post_order(posts_dir=POSTS_DIRECTORY, reverse_order=False):
         except Exception as e:
             print(f"Could not process {filepath}: {e}", file=sys.stderr)
 
-    # The 'reverse' flag of the sorted function is controlled by the new argument
     sorted_posts = sorted(
-        posts_data, 
-        key=lambda p: (p['date'], p['sort_order']), 
+        posts_data,
+        key=lambda p: (p['date'], p['sort_order']),
         reverse=not reverse_order
     )
-
-    return [post['path'] for post in sorted_posts]
+    # Return the full list of dictionaries now
+    return sorted_posts
 
 if __name__ == '__main__':
     parser = argparse.ArgumentParser(
-        description="List Jekyll posts in chronological order, optionally with token counts."
+        description="List Jekyll posts in chronological order, with optional token counts and meta descriptions."
     )
     parser.add_argument(
         '-t', '--token',
@@ -89,49 +91,51 @@ if __name__ == '__main__':
         action='store_true',
         help='List posts in chronological order (oldest first) instead of the default reverse chronological.'
     )
+    parser.add_argument(
+        '-m', '--meta',
+        action='store_true',
+        help='Include the meta_description from the front matter in the output.'
+    )
     args = parser.parse_args()
 
-    # Pass the reverse flag to the function
-    ordered_files = get_post_order(reverse_order=args.reverse)
-    
+    ordered_posts = get_post_order(reverse_order=args.reverse)
+
     order_description = "chronological (oldest first)" if args.reverse else "reverse chronological (newest first)"
-    print(f"Posts in {order_description} order (full paths):")
-    
+    print(f"Posts in {order_description} order:")
+
     if args.token:
         # --- PASS 1: Pre-calculate all token counts ---
         print("Calculating token counts for all files, this may take a moment...", file=sys.stderr)
         file_data = []
-        for filepath in ordered_files:
+        for post in ordered_posts:
+            filepath = post['path']
             try:
                 with open(filepath, 'r', encoding='utf-8') as f:
                     content = f.read()
                 token_count = count_tokens(content)
-                file_data.append({'path': filepath, 'tokens': token_count})
+                # Carry the meta_description through
+                file_data.append({'path': filepath, 'tokens': token_count, 'meta_description': post['meta_description']})
             except Exception as e:
                 print(f"{filepath}  # Error: Could not read file - {e}", file=sys.stderr)
-                # Add a record with 0 tokens to avoid breaking the logic
-                file_data.append({'path': filepath, 'tokens': 0})
-        
+                file_data.append({'path': filepath, 'tokens': 0, 'meta_description': post['meta_description']})
+
         grand_total_tokens = sum(item['tokens'] for item in file_data)
-        print("", file=sys.stderr) # Add a newline after the status message
+        print("", file=sys.stderr)
 
-        # --- PASS 2: Print formatted output with dual cumulative counts ---
+        # --- PASS 2: Print formatted output ---
         ascending_total = 0
         descending_total = grand_total_tokens
 
         for item in file_data:
-            filepath = item['path']
-            token_count = item['tokens']
-            
-            ascending_total += token_count
-            
-            # Print the new format with individual, ascending, and descending counts
-            print(f"{filepath}  # {token_count:,} tokens ({ascending_total:,} / {descending_total:,} total)")
-            
-            # Decrement the descending total for the next iteration
-            descending_total -= token_count
+            ascending_total += item['tokens']
+            print(f"{item['path']}  # {item['tokens']:,} tokens ({ascending_total:,} / {descending_total:,} total)")
+            if args.meta and item['meta_description']:
+                print(f"  └─ {item['meta_description']}") # Nicely formatted meta output
+            descending_total -= item['tokens']
 
     else:
-        # If --token is not used, just print the file paths as before
-        for filepath in ordered_files:
-            print(filepath)
\ No newline at end of file
+        # If --token is not used, just print the file paths and optionally meta
+        for post in ordered_posts:
+            print(post['path'])
+            if args.meta and post['meta_description']:
+                print(f"  └─ {post['meta_description']}") # Nicely formatted meta output
\ No newline at end of file

[mike@nixos:~/repos/pipulate/scripts/articles]$
```

Okay whaddya think this:

```bash
[mike@nixos:~/repos/pipulate/scripts/articles]$ python list_articles.py -t -m
Posts in reverse chronological (newest first) order:
Calculating token counts for all files, this may take a moment...

/home/mike/repos/MikeLev.in/_posts/2025-10-08-ai-assisted-debugging-git-archeology.md  # 19,938 tokens (19,938 / 6,527,663 total)
  └─ A developer's journal entry on fixing Python bugs with AI, refactoring a release script, and using git commands to recover a deleted file.
/home/mike/repos/MikeLev.in/_posts/2025-10-07-macos-nix-debugging-segfault-to-afplay.md  # 13,192 tokens (33,130 / 6,507,725 total)
  └─ A deep dive into a multi-layered debugging session on macOS, tracing a Python bug from a `Segmentation fault` to a platform-specific audio command.
/home/mike/repos/MikeLev.in/_posts/2025-10-07-macos-debugging-saga-segfaults-ghosts.md  # 59,547 tokens (92,677 / 6,494,533 total)
  └─ Follow a detailed debugging session to fix a persistent Segmentation fault on macOS with Nix and Python, revealing a cascade of platform-specific issues.
/home/mike/repos/MikeLev.in/_posts/2025-10-07-disposable-gods-personalized-loops.md  # 9,898 tokens (102,575 / 6,434,986 total)
  └─ An exploration of AI interaction, from creative process metaphors to the essential strategy of using massive, surgical context-drops to personalize stateless LLMs.
/home/mike/repos/MikeLev.in/_posts/2025-10-06-pipulate-decoupling-breakthrough-app-to-library.md  # 8,549 tokens (111,124 / 6,425,088 total)
  └─ A deep dive into demystifying Python packaging with PyPI and the architectural epiphany that transformed a single-tenant application into a distributable library.
/home/mike/repos/MikeLev.in/_posts/2025-10-06-pypi-gauntlet-invisible-bug.md  # 35,333 tokens (146,457 / 6,416,539 total)
  └─ A real-time journal entry detailing the intense, bug-filled process of publishing a Python package to PyPI, revealing a hidden, invisible character as the root cause.
/home/mike/repos/MikeLev.in/_posts/2025-10-06-faquillizer-sprint-ai-collaboration-blueprint.md  # 11,077 tokens (157,534 / 6,381,206 total)
  └─ A real-time technical journal entry detailing the strategy, philosophy, and AI-driven planning for a 5-hour software development sprint.
/home/mike/repos/MikeLev.in/_posts/2025-10-05-pipulate-notebook-state-persistence.md  # 5,911 tokens (163,445 / 6,370,129 total)
  └─ Explore how Pipulate achieves persistent state in Jupyter Notebooks, creating a new 'reality' for data workflows, and contrast cloud vs. local development.
/home/mike/repos/MikeLev.in/_posts/2025-10-05-python-dependency-fix-google-colab.md  # 12,369 tokens (175,814 / 6,364,218 total)
  └─ Follow the end-to-end process of diagnosing a Python dependency bug in Google Colab, implementing the fix, and deploying a new version to PyPI using a custom automated script.
/home/mike/repos/MikeLev.in/_posts/2025-10-05-architecting-for-ai-nested-git-workflow.md  # 5,176 tokens (180,990 / 6,351,849 total)
  └─ Discover a powerful development strategy using a nested Git repository to isolate experimental work while inheriting a stable parent environment, perfect for AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-10-05-stabilize-document-create-software-release.md  # 23,130 tokens (204,120 / 6,346,673 total)
  └─ A detailed walkthrough of a real software release, from planning and branch management to debugging a failed PyPI publish and achieving success.
/home/mike/repos/MikeLev.in/_posts/2025-10-04-upgrading-prompt-fu-ai-self-correction-checklist.md  # 21,976 tokens (226,096 / 6,323,543 total)
  └─ A deep dive into debugging an AI's flawed advice by upgrading a prompt-generation script with a self-correction checklist to ensure complete context.
/home/mike/repos/MikeLev.in/_posts/2025-10-04-pipulate-kitty-hawk-runway.md  # 7,228 tokens (233,324 / 6,301,567 total)
  └─ A journal entry on a major Pipulate breakthrough in Jupyter, the strategic pivot to a 'pip install' on-ramp, and an AI-driven epiphany about critical plumbing.
/home/mike/repos/MikeLev.in/_posts/2025-10-04-python-import-paradox-united-state-jupyter.md  # 4,748 tokens (238,072 / 6,294,339 total)
  └─ A developer journal entry debugging Python's import system to resolve a server vs. notebook conflict and achieve simple, stateful workflows in Jupyter.
/home/mike/repos/MikeLev.in/_posts/2025-10-03-ai-strange-loop-not-a-bubble.md  # 5,743 tokens (243,815 / 6,289,591 total)
  └─ An analysis of the AI boom, arguing it's not a bubble but a fundamental shift where intelligence itself is the self-improving commodity.
/home/mike/repos/MikeLev.in/_posts/2025-10-03-tale-of-two-physics-unifying-server-notebook.md  # 9,448 tokens (253,263 / 6,283,848 total)
  └─ Follow the journey of debugging a persistent state management tool, Pipulate, to work seamlessly in both server and Jupyter Notebook environments.
/home/mike/repos/MikeLev.in/_posts/2025-10-03-ai-debugging-odyssey-tenacity.md  # 48,191 tokens (301,454 / 6,274,400 total)
  └─ A raw look at a developer's tenacious journey debugging a complex Python script with an AI, from Jupyter state to obscure dependency issues.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-digital-crucible-lifelong-journal.md  # 5,918 tokens (307,372 / 6,226,209 total)
  └─ An exploration of using Vim and Git to maintain a single text file for life, automating a frictionless journaling workflow with a custom NeoVim script.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-debugging-post-refactor-ai-regressions.md  # 23,827 tokens (331,199 / 6,220,291 total)
  └─ A developer's journal entry on post-refactoring cleanup, from refining sed commands to fixing AI-induced bugs and stubborn CSS issues.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-sentinel-contract-ai-editing-workflow.md  # 17,764 tokens (348,963 / 6,196,464 total)
  └─ Chronicles the development of an AST-validated Python script to safely apply AI-generated code patches, overcoming mental friction and codifying a new workflow.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-forging-intelligent-workflow-ai-refinement.md  # 15,801 tokens (364,764 / 6,178,700 total)
  └─ A deep dive into the 'Fodder Funnel' concept, detailing a real-world debugging session of a Python automation script and the evolution of a simple workflow into an intelligent, self-refining system.
/home/mike/repos/MikeLev.in/_posts/2025-10-02-forging-the-chameleon-python-packaging-history.md  # 28,365 tokens (393,129 / 6,162,899 total)
  └─ A technical journal entry exploring FastHTML's opinionated design, leading to a deep dive into Python's packaging history and the craft of future-proofing software.
/home/mike/repos/MikeLev.in/_posts/2025-10-01-forging-the-prompt-200k-token-context.md  # 10,469 tokens (403,598 / 6,134,534 total)
  └─ How I developed a Python script to chronologically sort Jekyll posts, enabling a 200k-token context window for deep AI-driven refactoring advice.
/home/mike/repos/MikeLev.in/_posts/2025-10-01-refactoring-pipulate-persistent-notebook-workflows.md  # 11,497 tokens (415,095 / 6,124,065 total)
  └─ A detailed, deterministic plan to refactor the Pipulate library for persistent, cell-by-cell state management directly within any Jupyter Notebook.
/home/mike/repos/MikeLev.in/_posts/2025-10-01-automation-whack-a-mole-debugging.md  # 14,532 tokens (429,627 / 6,112,568 total)
  └─ Follow the final, grueling hours of a major code refactoring, from executing an automated script to debugging the inevitable fallout and achieving victory.
/home/mike/repos/MikeLev.in/_posts/2025-10-01-crafting-the-automation-wand.md  # 27,378 tokens (457,005 / 6,098,036 total)
  └─ A real-time journal entry detailing the 5-hour struggle to automate an article workflow, from fighting a chatty AI CLI to mastering direct API calls and taming Python dependency hell on NixOS.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-script-driven-refactoring-pipulate.md  # 7,140 tokens (464,145 / 6,070,658 total)
  └─ A developer's journal on decoupling a Python application's database dependencies to enable standalone use in Jupyter Notebooks using a scripted approach.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-forging-the-magic-wand-refactor.md  # 20,662 tokens (484,807 / 6,063,518 total)
  └─ A journal entry detailing a major Python refactor: forging a scattered, global database object into a single, powerful 'magic wand' class.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-grinding-lenses-forging-magic-wand.md  # 8,018 tokens (492,825 / 6,042,856 total)
  └─ A deep dive into refactoring a Python monolith, moving state management into a core library to improve AI ergonomics and developer-tool 'oneness'.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-command-line-flow-state.md  # 13,100 tokens (505,925 / 6,034,838 total)
  └─ An exploration of achieving developer flow-state through command-line rituals and the quest for a unified, multi-provider AI CLI.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-forging-a-causal-anchor.md  # 7,857 tokens (513,782 / 6,021,738 total)
  └─ A developer's 30-year journey from the early web to rejecting the modern full-stack in favor of a durable, timeless 'LPvg+HTMX' philosophy.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-forging-pipulate-magic-wand.md  # 12,323 tokens (526,105 / 6,013,881 total)
  └─ A deep dive into refactoring a Python tool, Pipulate, to work in Jupyter Notebooks by injecting dependencies and using fastlite for a standalone DB.
/home/mike/repos/MikeLev.in/_posts/2025-09-30-the-great-stuffing-ai-native-wand.md  # 12,510 tokens (538,615 / 6,001,558 total)
  └─ A developer's journal on refactoring a Python web app, rejecting dependency injection for a pragmatic 'great stuffing' approach to create a portable, AI-friendly toolkit.
/home/mike/repos/MikeLev.in/_posts/2025-09-29-tightening-up-vs-making-less-brittle.md  # 14,915 tokens (553,530 / 5,989,048 total)
  └─ Exploring the tension between mastering a craft and the fragility of the systems we build it on, through the lens of Ikigai, Vim, and software architecture.
/home/mike/repos/MikeLev.in/_posts/2025-09-29-ai-copilot-intellectual-warmup.md  # 7,855 tokens (561,385 / 5,974,133 total)
  └─ A developer's journey refactoring a Python API with AI, leading to a new workflow of 'intellectual simulation' and process integration.
/home/mike/repos/MikeLev.in/_posts/2025-09-29-the-roomba-mike-refactor.md  # 39,840 tokens (601,225 / 5,966,278 total)
  └─ A developer's raw journal entry chronicling the chaotic but successful refactoring of a Python app for Jupyter Notebook integration, with AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-09-28-refactoring-tao-of-the-mulligan.md  # 21,461 tokens (622,686 / 5,926,438 total)
  └─ A developer's journey through a complex Python refactor, using an AI partner to devise a non-breaking 'AI Shim' and embracing the iterative process.
/home/mike/repos/MikeLev.in/_posts/2025-09-28-robust-path-unlimited-mulligan.md  # 20,181 tokens (642,867 / 5,904,977 total)
  └─ A deep dive into a complex code refactor, exploring robust scripting with Python, the pitfalls of AI-generated plans, and the power of a git workflow.
/home/mike/repos/MikeLev.in/_posts/2025-09-28-ai-shim-refactoring-plan.md  # 7,956 tokens (650,823 / 5,884,796 total)
  └─ A developer's journal entry on translating a core philosophy into a concrete, AI-generated plan for safely refactoring a Python class using a shim.
/home/mike/repos/MikeLev.in/_posts/2025-09-28-ipso-facto-optimism.md  # 16,450 tokens (667,273 / 5,876,840 total)
  └─ An argument that our chaotic, competitive nature is a feature, not a bug, providing a decentralized defense against existential risk. It's science, not faith.
/home/mike/repos/MikeLev.in/_posts/2025-09-27-prompt-fu-failure-better-architecture.md  # 22,722 tokens (689,995 / 5,860,390 total)
  └─ A developer's plan to refactor code is derailed when an AI collaboration script breaks, leading to a crucial architectural discovery and a new strategy.
/home/mike/repos/MikeLev.in/_posts/2025-09-27-validating-resilient-python-workflow.md  # 8,793 tokens (698,788 / 5,837,668 total)
  └─ Follow the journey from abstract analogy to concrete code, validating a future-proof Python development environment with Nix, Jupyter, and a refined API.
/home/mike/repos/MikeLev.in/_posts/2025-09-27-key-value-rosetta-stone.md  # 8,428 tokens (707,216 / 5,828,875 total)
  └─ Discover a philosophy for simplifying web development by treating Python arguments and HTML attributes as a unified key-value system with HTMX.
/home/mike/repos/MikeLev.in/_posts/2025-09-26-fortress-against-obsolescence.md  # 11,730 tokens (718,946 / 5,820,447 total)
  └─ An exploration of building a durable skill set with Linux, Python, vim, and git (LPvg), and making it immortal with Nix to escape the cycle of planned obsolescence.
/home/mike/repos/MikeLev.in/_posts/2025-09-26-computing-sovereignty-treatise-with-nix.md  # 7,583 tokens (726,529 / 5,808,717 total)
  └─ A treatise on rejecting modern software complexity for reproducible, AI-native systems using Nix. Reclaim the joy of building and achieve computing sovereignty.
/home/mike/repos/MikeLev.in/_posts/2025-09-26-unix-pipe-of-life.md  # 11,639 tokens (738,168 / 5,801,134 total)
  └─ An exploration of the Unix philosophy as a universal API, connecting cellular biology, the AI Winter, and the antifragile nature of modern AI systems.
/home/mike/repos/MikeLev.in/_posts/2025-09-25-bedrock-dazzle-packaging-rabbit-hole.md  # 47,179 tokens (785,347 / 5,789,495 total)
  └─ A developer's raw log of a multi-hour debugging session, from sci-fi philosophy to solving a complex Python packaging and Nix flake import issue.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-python-paste-parse-pipulate-lite.md  # 7,182 tokens (792,529 / 5,742,316 total)
  └─ Discover a powerful Python pattern for list processing and a breakthrough for prototyping workflows by using a Jupyter Notebook as a 'Pipulate-Lite' client.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-notebook-as-orchestrator-workflow.md  # 5,513 tokens (798,042 / 5,735,134 total)
  └─ A developer's guide to working smarter by treating Jupyter Notebooks as orchestrators for clean, modular Python code, enhancing AI collaboration and avoiding common development rabbit holes.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-victory-dances-and-rabbit-holes.md  # 5,838 tokens (803,880 / 5,729,621 total)
  └─ A deep dive into a personal framework for technical work, blending a 'left-brain' checklist for execution with a 'right-brain' set of metaphors for strategy to maximize wins and avoid rabbit holes.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-pinning-notebooks-folder-git-embedded-repo.md  # 7,619 tokens (811,499 / 5,723,783 total)
  └─ A technical walkthrough of reorganizing a project's folder structure for better ergonomics and discovering and solving Git's embedded repository warning.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-elevating-the-notebook-factory.md  # 2,602 tokens (814,101 / 5,716,164 total)
  └─ A breakthrough in structuring a development workflow by elevating the Jupyter Notebooks folder to a primary-level concept using nested git repositories.
/home/mike/repos/MikeLev.in/_posts/2025-09-24-the-bedrock-and-the-dazzle.md  # 7,616 tokens (821,717 / 5,713,562 total)
  └─ A developer's journey from ephemeral SEO tricks to building future-proof tools with a stable stack like Python and Nix, focusing on creating powerful data visualizations.
/home/mike/repos/MikeLev.in/_posts/2025-09-23-lpvg-stack-future-proofing.md  # 4,540 tokens (826,257 / 5,705,946 total)
  └─ Discover how to future-proof your tech skills with the LPvg stack—Linux, Python, vim, and git—and build a persistent digital home with Nix.
/home/mike/repos/MikeLev.in/_posts/2025-09-23-bazaar-of-one-ai-open-source.md  # 12,360 tokens (838,617 / 5,701,406 total)
  └─ An exploration of escaping vendor lock-in through the command line, FOSS, and a unique AI-ergonomic system that redefines the developer's relationship with AI.
/home/mike/repos/MikeLev.in/_posts/2025-09-23-git-repo-gardening-surgical-history.md  # 23,736 tokens (862,353 / 5,689,046 total)
  └─ Learn to safely prune a Git repository by deleting unused files and directories while preserving the ability to recover them through strategic commits.
/home/mike/repos/MikeLev.in/_posts/2025-09-23-git-main-branch-takeover-repo-gardening.md  # 6,470 tokens (868,823 / 5,665,310 total)
  └─ A deep dive into a solo developer's workflow for replacing the Git main branch with an experimental one, inspired by a philosophy of repo cleanliness.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-ai-architectural-xrays-code-pruning.md  # 15,696 tokens (884,519 / 5,658,840 total)
  └─ A deep dive into the debugging journey of integrating automated UML and DOT diagram generation into a Python script within a Nix environment.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-ai-ergonomics-developer-workflows.md  # 13,205 tokens (897,724 / 5,643,144 total)
  └─ Discover how replacing standard command-line tools like 'tree' with modern, .gitignore-aware alternatives like 'eza' improves AI-assisted development.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-refactoring-for-ai-ergonomics.md  # 16,215 tokens (913,939 / 5,629,939 total)
  └─ A developer's journey of refactoring a git repository to improve AI ergonomics, embracing command-line tools to avoid vendor lock-in.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-pipulate-chronicles-future-proof-ai-stack.md  # 12,675 tokens (926,614 / 5,613,724 total)
  └─ An exploration of building a local-first, agentic AI on a stable foundation of Python and HTMX, rejecting the churn of modern web development.
/home/mike/repos/MikeLev.in/_posts/2025-09-22-code-is-truth-actuator-ai.md  # 20,596 tokens (947,210 / 5,601,049 total)
  └─ Explore the journey from abstract thought to concrete action by treating running code as verifiable truth, turning LLMs from 'yabber machines' into powerful actuators.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-refactoring-ai-tool-system-transparency.md  # 9,417 tokens (956,627 / 5,580,453 total)
  └─ A technical journal entry detailing the process of refactoring a Python AI tool system, debugging a cascade of errors, and implementing rich, transparent console logging.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-antifragile-intelligence-scheduler-commitment.md  # 9,005 tokens (965,632 / 5,571,036 total)
  └─ Explore a high-level plan for an antifragile, adaptive AI scheduler that uses Robert Cialdini's principle of commitment as a self-hack for progress.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-coachmans-reins-agentic-ai-prompt-contracts.md  # 9,191 tokens (974,823 / 5,562,031 total)
  └─ Exploring the tension between agentic AI workflows and precision control, using prompt contracts and atomic git operations to manage complex coding tasks.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-python-refactoring-server-logging.md  # 6,515 tokens (981,338 / 5,552,840 total)
  └─ Follow a live-refactoring session in Python, moving logging functions out of a monolithic server.py to reduce its surface area and improve clarity.
/home/mike/repos/MikeLev.in/_posts/2025-09-21-developer-control-ai-refactoring.md  # 10,953 tokens (992,291 / 5,546,325 total)
  └─ A developer's journey of refactoring an AI-assisted codebase, moving from automated tools to a hands-on approach with Vim to regain control and improve quality.
/home/mike/repos/MikeLev.in/_posts/2025-09-20-gravity-of-the-mean-ai-regression.md  # 9,809 tokens (1,002,100 / 5,535,372 total)
  └─ A deep dive into fixing an AI-induced code regression, revealing how 'git diff' acts as a forensic tool and defining the 'Gravity of the Mean' concept for AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-09-20-refactoring-python-monolith-ai-wrapper-shim.md  # 14,112 tokens (1,016,212 / 5,525,563 total)
  └─ A deep dive into refactoring a monolithic Python server with a live-reloading setup, detailing the failure of circular dependencies and the success of the wrapper shim pattern for human-AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-09-20-prompt-becomes-contract-human-agent.md  # 23,214 tokens (1,039,426 / 5,511,451 total)
  └─ A deep dive into an evolving AI-driven workflow, where conversational prompts become rigid contracts for software agents, revealing a surprising twist.
/home/mike/repos/MikeLev.in/_posts/2025-09-19-amnesiac-genie-playbook-master-prompt.md  # 3,259 tokens (1,042,685 / 5,488,237 total)
  └─ Discover a master prompt template and the core principles for building resilient, self-correcting AI coding agents based on iterative refinement and failure capture.
/home/mike/repos/MikeLev.in/_posts/2025-09-19-forging-a-digital-steeltrap.md  # 25,478 tokens (1,068,163 / 5,484,978 total)
  └─ A developer's journal on refactoring a web app, debugging data systems, and refining an agentic AI workflow with the Gemini command-line interface.
/home/mike/repos/MikeLev.in/_posts/2025-09-19-command-line-crucible-ai-unix-philosophy.md  # 6,260 tokens (1,074,423 / 5,459,500 total)
  └─ A deep dive into abandoning ambiguous chat interfaces for a powerful, precise command-line AI workflow rooted in the timeless Unix philosophy.
/home/mike/repos/MikeLev.in/_posts/2025-09-19-the-snefu-playbook.md  # 15,646 tokens (1,090,069 / 5,453,240 total)
  └─ A detailed case study on iteratively developing a prompt-driven workflow for an AI agent, overcoming common failures to achieve reliable, automated coding.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-magic-rolling-pin-ai-navigation.md  # 7,142 tokens (1,097,211 / 5,437,594 total)
  └─ Discover the 'Magic Rolling Pin' and 'Rule of 7' concepts for designing AI-navigable websites by balancing hierarchical choices to avoid the 'Deathstar' problem.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-daily-heuristics-ai-analogues.md  # 6,582 tokens (1,103,793 / 5,430,452 total)
  └─ Exploring three daily guiding principles for productivity and their surprising parallels in AI core functions like triage, optimization, and state management.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-thinking-in-vim-futureproof-philosophy.md  # 4,482 tokens (1,108,275 / 5,423,870 total)
  └─ Discover why choosing a text editor like Vim or NeoVim is a profound investment in a lifelong, future-proof skill that transcends the obsolescence of modern GUIs.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-bootstrapping-nixos-philosophy.md  # 5,294 tokens (1,113,569 / 5,419,388 total)
  └─ A journal entry on the next steps after a fresh NixOS install, including system updates, hardware philosophy, and installing a proper text editor like Vim.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-agentic-cli-workflow.md  # 14,744 tokens (1,128,313 / 5,414,094 total)
  └─ A developer's late-night journey refining AI workflows, moving from interactive TUIs to powerful, non-interactive command-line automation with Gemini CLI.
/home/mike/repos/MikeLev.in/_posts/2025-09-18-bootstrapping-nixos-installation-guide.md  # 11,353 tokens (1,139,666 / 5,399,350 total)
  └─ A practical guide to future-proofing your tech skills by installing NixOS on old hardware, from creating a bootable USB to navigating UEFI settings.
/home/mike/repos/MikeLev.in/_posts/2025-09-17-local-git-jupyter-playground.md  # 7,484 tokens (1,147,150 / 5,387,997 total)
  └─ Discover a powerful, local-first workflow using nested Git repositories and nbstripout for a private, efficient Jupyter Notebook playground.
/home/mike/repos/MikeLev.in/_posts/2025-09-17-unix-bedrock-acceleration-ai.md  # 3,694 tokens (1,150,844 / 5,380,513 total)
  └─ In an age of AI-driven acceleration, the key to future-proofing technical skills lies not in chasing trends, but in mastering the bedrock: the Unix/Linux ecosystem.
/home/mike/repos/MikeLev.in/_posts/2025-09-17-mastering-data-pivots-with-python.md  # 3,865 tokens (1,154,709 / 5,376,819 total)
  └─ Learn why pivoting data is a crucial skill in life and data science, and how Python's Pandas library offers a clear, powerful alternative to Excel.
/home/mike/repos/MikeLev.in/_posts/2025-09-17-nomadic-rooted-history-tech-stack-pipulate.md  # 10,028 tokens (1,164,737 / 5,372,954 total)
  └─ Explore the philosophical roots of local-first software, connecting human nomadism, Hobbes vs. Locke, and Sun Tzu to a modern, anti-fragile tech stack.
/home/mike/repos/MikeLev.in/_posts/2025-09-16-ai-tool-calling-magic-spells-mcp.md  # 7,237 tokens (1,171,974 / 5,362,926 total)
  └─ Explore a novel approach to AI tool-calling, simplifying the Model Context Protocol (MCP) into 'magic spells' for efficient, universal LLM automation.
/home/mike/repos/MikeLev.in/_posts/2025-09-15-mcp-chronicles-progressive-enhancement.md  # 21,960 tokens (1,193,934 / 5,355,689 total)
  └─ A live case study of debugging a Python plugin auto-discovery system with an AI, leading to the implementation of the formal Model Context Protocol (MCP).
/home/mike/repos/MikeLev.in/_posts/2025-09-15-sovereign-ai-symbiosis-skill-based.md  # 11,868 tokens (1,205,802 / 5,333,729 total)
  └─ A vision for non-invasive AI endosymbiosis, using a high-skill Vim and command-line workflow as a case study for maintaining sovereignty in the AI age.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-rule-of-7-self-healing-knowledge-tree.md  # 13,115 tokens (1,218,917 / 5,321,861 total)
  └─ A design dialogue on creating a self-healing information architecture using the Rule of 7, vector embeddings, and hierarchical clustering in SQLite.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-python-decorators-importlib-live-session.md  # 9,960 tokens (1,228,877 / 5,308,746 total)
  └─ A live coding session showing how to refactor a Python monolith into a self-discovering plugin system using decorators and dynamic imports with an AI assistant.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-ai-golden-path-first-step-design.md  # 11,191 tokens (1,240,068 / 5,298,786 total)
  └─ A strategy for creating an AI-friendly golden path in a codebase, using an `AI_RUNME.py` script and browser automation tests to prevent regressions.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-ai-friendly-codebase-hygiene-guide.md  # 17,808 tokens (1,257,876 / 5,287,595 total)
  └─ A case study on refactoring a Python project for AI collaboration by eliminating a `training` directory and logically relocating documentation and prompts.
/home/mike/repos/MikeLev.in/_posts/2025-09-14-command-line-surgery-python-refactor.md  # 57,584 tokens (1,315,460 / 5,269,787 total)
  └─ A live, command-by-command journal of a major Python codebase refactor, renaming core directories (modules to imports, plugins to apps) using rg and sed.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-developer-momentum-light-touch-refactor.md  # 4,208 tokens (1,319,668 / 5,212,203 total)
  └─ A developer's journal on using a Python decorator as a light-touch proof-of-concept for an automatic AI tool plugin system, balancing progress with fatigue.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-gui-to-cli-foss-ai-workflow.md  # 7,748 tokens (1,327,416 / 5,207,995 total)
  └─ A developer's journey from the proprietary Cursor AI editor to a powerful, open-source Gemini CLI workflow on NixOS, enabling headless and agentic AI.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-ai-assisted-monolith-to-plugin-refactor.md  # 18,822 tokens (1,346,238 / 5,200,247 total)
  └─ A step-by-step case study of refactoring a monolithic Python file into a plugin system using rg, sed, git, and an AI assistant for strategic planning.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-normalized-cli-solving-ai-amnesia.md  # 7,011 tokens (1,353,249 / 5,181,425 total)
  └─ A plan to refactor a monolithic Python tool system into a discoverable plugin architecture, addressing the core problems of CLI and AI context fragility.
/home/mike/repos/MikeLev.in/_posts/2025-09-13-reliable-ai-tool-calling-case-study.md  # 16,624 tokens (1,369,873 / 5,174,414 total)
  └─ A case study on creating reliable AI tool-calling by normalizing the CLI with Nix and Python, using a progressive enhancement strategy over formal MCP.
/home/mike/repos/MikeLev.in/_posts/2025-09-12-chip-otheseus-sovereign-ai-blueprint.md  # 7,107 tokens (1,376,980 / 5,157,790 total)
  └─ A blueprint for Pipulate and the 'Chip O'Theseus' sovereign AI concept, exploring the 'Rule of 7' design principle for AI-ready applications.
/home/mike/repos/MikeLev.in/_posts/2025-09-12-git-branch-takeover-promote-feature-branch.md  # 6,738 tokens (1,383,718 / 5,150,683 total)
  └─ A step-by-step guide for solo developers to safely replace the main branch with a feature branch and delete all other local and remote Git branches.
/home/mike/repos/MikeLev.in/_posts/2025-09-12-web-cleanup-ai-readability-htmx.md  # 6,557 tokens (1,390,275 / 5,143,945 total)
  └─ A developer's strategy for the next web revolution, focusing on AI readability, semantic HTML, and a FOSS-based stack over JavaScript frameworks.
/home/mike/repos/MikeLev.in/_posts/2025-09-12-headless-shopify-python-jekyll.md  # 17,071 tokens (1,407,346 / 5,137,388 total)
  └─ A step-by-step guide to building a headless Shopify store using Python to orchestrate the Jekyll static site generator, avoiding modern JavaScript frameworks.
/home/mike/repos/MikeLev.in/_posts/2025-09-10-rg-xargs-sed-search-replace-pattern.md  # 10,637 tokens (1,417,983 / 5,120,317 total)
  └─ Learn the powerful `rg | xargs sed` pattern to replace IDE-dependent global search with a durable, lightning-fast command-line workflow.
/home/mike/repos/MikeLev.in/_posts/2025-09-10-nvidia-dominance-ai-physics.md  # 10,809 tokens (1,428,792 / 5,109,680 total)
  └─ An analysis of NVIDIA's market dominance through its CUDA ecosystem, connecting the S-curve limits of AI growth to the physics of entropy and the ethics of AI.
/home/mike/repos/MikeLev.in/_posts/2025-09-10-ai-titans-datacenter-wars-tool-choice.md  # 8,695 tokens (1,437,487 / 5,098,871 total)
  └─ A developer's choice of AI coding assistant reveals the brutal datacenter wars, Microsoft's "Embrace, Extend, Extinguish" strategy, and the future of coding.
/home/mike/repos/MikeLev.in/_posts/2025-09-09-grep-ripgrep-command-line-refactoring.md  # 9,920 tokens (1,447,407 / 5,090,176 total)
  └─ Learn to replace IDE search with powerful command-line tools. A step-by-step guide to using ripgrep (`rg`) and `sed` for project-wide refactoring.
/home/mike/repos/MikeLev.in/_posts/2025-09-09-pip-freeze-nix-dependency-hell.md  # 8,912 tokens (1,456,319 / 5,080,256 total)
  └─ A case study on solving a macOS segfault by creating a fully-pinned `requirements.txt` with `pip freeze` after modifying the Nix dev environment.
/home/mike/repos/MikeLev.in/_posts/2025-09-09-debugging-nix-dev-environment-segfault.md  # 24,237 tokens (1,480,556 / 5,071,344 total)
  └─ Diagnose a Python segmentation fault on macOS by comparing pip dependencies and refactoring a Nix flake to create a stable, non-updating dev environment.
/home/mike/repos/MikeLev.in/_posts/2025-09-09-flow-state-foss-gemini-cli.md  # 5,796 tokens (1,486,352 / 5,047,107 total)
  └─ A developer's case study on switching from Cursor AI to Gemini CLI, detailing a keyboard-centric workflow with virtual desktops to maximize flow-state.
/home/mike/repos/MikeLev.in/_posts/2025-09-08-nixos-ai-assistant-declarative-workflow.md  # 24,001 tokens (1,510,353 / 5,041,311 total)
  └─ A real-time session on declaratively installing Gemini CLI on NixOS via configuration.nix and automating its launch into a GNOME workspace with a Python script.
/home/mike/repos/MikeLev.in/_posts/2025-09-06-magic-rolling-pin-ai-code-refactoring.md  # 22,174 tokens (1,532,527 / 5,017,310 total)
  └─ A deep dive into the "Magic Rolling Pin" concept, a human-AI approach to code refactoring, and the technical challenges of creating a stable development environment with Nix and tmux.
/home/mike/repos/MikeLev.in/_posts/2025-09-06-cursor-to-gemini-cli-future-proof-workflow.md  # 8,728 tokens (1,541,255 / 4,995,136 total)
  └─ A developer's firsthand account of switching from Cursor AI to the FOSS Gemini CLI to escape VSCode bloat and regain command-line workflow discipline on NixOS.
/home/mike/repos/MikeLev.in/_posts/2025-09-06-agentic-ai-code-refactoring-experiment.md  # 13,893 tokens (1,555,148 / 4,986,408 total)
  └─ A live session using Gemini CLI on NixOS to refactor a Python codebase. See an agentic AI apply the "Rule of 7" philosophy with atomic git commits.
/home/mike/repos/MikeLev.in/_posts/2025-09-06-ai-platform-wars-developer-guide.md  # 7,793 tokens (1,562,941 / 4,972,515 total)
  └─ A developer's strategic analysis of AI vendor lock-in, the "fire-and-forget" LLM model, and the fight for autonomy against tech's "Four Horsemen."
/home/mike/repos/MikeLev.in/_posts/2025-09-05-logistics-curve-thought-command-line.md  # 4,821 tokens (1,567,762 / 4,964,722 total)
  └─ An exploration of the logistics S-curve as a mental model for clarity, the enduring power of the command-line interface (CLI), and a first look at Google's Gemini CLI for AI-assisted coding.
/home/mike/repos/MikeLev.in/_posts/2025-09-05-teach-ai-niche-framework-privacy-mode.md  # 6,995 tokens (1,574,757 / 4,959,901 total)
  └─ A developer's strategic pivot from code privacy to actively training AI assistants on a niche framework (FastHTML) to fix model blind spots and improve workflow.
/home/mike/repos/MikeLev.in/_posts/2025-09-04-radical-diagnosability-htmx-python-webdev.md  # 8,507 tokens (1,583,264 / 4,952,906 total)
  └─ A developer's philosophical journey back to web development, rejecting JavaScript complexity for the simplicity and diagnosability of Python, HTMX, and FastHTML, framed by principles from AI and quantum physics.
/home/mike/repos/MikeLev.in/_posts/2025-09-04-taming-ai-code-sprawl-rule-of-7.md  # 16,338 tokens (1,599,602 / 4,944,399 total)
  └─ A developer's case study on refactoring a complex, AI-assisted codebase using a "Rule of 7" philosophy, git branching for safety, and strategic file consolidation in a Python and HTMX project.
/home/mike/repos/MikeLev.in/_posts/2025-08-30-reducing-ai-code-sprawl-case-study.md  # 19,461 tokens (1,619,063 / 4,928,061 total)
  └─ A developer's raw account of refactoring a complex codebase, battling AI-generated sprawl, and applying a "lens grinding" philosophy to regain control.
/home/mike/repos/MikeLev.in/_posts/2025-08-21-code-to-consulting-shopify-blueprint.md  # 5,377 tokens (1,624,440 / 4,908,600 total)
  └─ A step-by-step guide on using Shopify to sell consulting services and the strategic thinking behind launching a tech business as a sole proprietorship.
/home/mike/repos/MikeLev.in/_posts/2025-08-19-ai-cambrian-explosion-orchestra-model.md  # 8,752 tokens (1,633,192 / 4,903,223 total)
  └─ A deep dive into AI's evolution, from the Perceptron to Transformers, arguing for a future of composite AI where LLMs act as orchestrators for specialized models.
/home/mike/repos/MikeLev.in/_posts/2025-08-09-first-contact-taming-code-sprawl-chatgpt5.md  # 8,280 tokens (1,641,472 / 4,894,471 total)
  └─ A case study on using ChatGPT 5 in Cursor AI to manage code sprawl by architecting a new SEO workflow for a Python, HTMX, and FastAPI project.
/home/mike/repos/MikeLev.in/_posts/2025-08-06-local-ai-war-google-vs-openai.md  # 4,909 tokens (1,646,381 / 4,886,191 total)
  └─ An analysis of OpenAI's gpt-oss vs. Google's Gemma on local hardware. See how the Ollama and OpenAI partnership challenges the local AI landscape.
/home/mike/repos/MikeLev.in/_posts/2025-07-23-python-macos-blockingioerror-debugging-saga.md  # 12,173 tokens (1,658,554 / 4,881,282 total)
  └─ A deep-dive into solving Python and Git issues on macOS, from fixing `BlockingIOError` with `subprocess.Popen` to resolving a 'False Main Push' in your workflow.
/home/mike/repos/MikeLev.in/_posts/2025-07-22-javascript-event-key-vs-event-code-mac.md  # 11,869 tokens (1,670,423 / 4,869,109 total)
  └─ Solve Mac keyboard shortcuts in JavaScript. Learn why `event.key` fails with the Option key ('∂') and how `event.code` provides a robust, cross-platform fix.
/home/mike/repos/MikeLev.in/_posts/2025-07-21-ritual-vs-decorator-token-efficiency.md  # 12,761 tokens (1,683,184 / 4,857,240 total)
  └─ A real-world test of Python's decorator pattern vs. a simple assignment ritual, rejected for its higher token count and cognitive load in AI-assisted coding.
/home/mike/repos/MikeLev.in/_posts/2025-07-20-tamagotchi-ai-local-llm-persistence.md  # 8,445 tokens (1,691,629 / 4,844,479 total)
  └─ Explore the vision for a 'Tamagotchi AI,' a persistent local LLM that survives restarts, and the strategy for building a regression-proof demo.
/home/mike/repos/MikeLev.in/_posts/2025-07-19-sheet-music-code-linear-workflows.md  # 7,323 tokens (1,698,952 / 4,836,034 total)
  └─ Discover a software design philosophy based on linearity, Unix pipes, and Jupyter Notebooks to manage complexity and bottle expertise in your code.
/home/mike/repos/MikeLev.in/_posts/2025-07-18-ai-philosophy-rube-goldberg-pipelines.md  # 23,492 tokens (1,722,444 / 4,828,711 total)
  └─ Learn to bootstrap local LLMs with a 'Simon Says' pattern. This entry details a progressive enhancement method for AI tool calling in the Pipulate project.
/home/mike/repos/MikeLev.in/_posts/2025-07-17-ai-genie-wish-backfiring.md  # 2,499 tokens (1,724,943 / 4,805,219 total)
  └─ An analysis of AI confirmation bias, the "backfiring genie" problem, and how anti-fragile architecture offers a solution*
/home/mike/repos/MikeLev.in/_posts/2025-07-17-ai-funhouse-mirror-backfiring-wish.md  # 12,754 tokens (1,737,697 / 4,802,720 total)
  └─ An analysis of AI confirmation bias, the "backfiring genie" problem, and how anti-fragile architecture in Python and HTMX offers a solution.
/home/mike/repos/MikeLev.in/_posts/2025-07-16-lisp-ai-soul-persistent-state.md  # 11,842 tokens (1,749,539 / 4,789,966 total)
  └─ Why do modern LLMs feel hollow? A deep dive into the lost dream of LISP machines, the problem of persistent state, and the amnesiac nature of today's AI.
/home/mike/repos/MikeLev.in/_posts/2025-07-15-woggle-bug-ai-code-refinement.md  # 18,344 tokens (1,767,883 / 4,778,124 total)
  └─ A case study of AI-assisted Python refactoring using Claude and `pylint` to clean up code, address warnings, and improve code aesthetics without breaking it.
/home/mike/repos/MikeLev.in/_posts/2025-07-15-breaking-adobe-tax-software-freedom.md  # 5,576 tokens (1,773,459 / 4,759,780 total)
  └─ Escape costly software subscriptions like Adobe's. This guide shows how to use the Unix terminal and Nix to install free, local-first apps for life.
/home/mike/repos/MikeLev.in/_posts/2025-07-14-ai-voice-synthesis-binary-search-debugging.md  # 12,945 tokens (1,786,404 / 4,754,204 total)
  └─ A case study on integrating voice synthesis (Piper TTS) into a JavaScript demo, and using binary search to debug a phantom vs. real execution path bug.
/home/mike/repos/MikeLev.in/_posts/2025-07-14-manage-ai-context-vscode-goldfish-memory.md  # 15,041 tokens (1,801,445 / 4,741,259 total)
  └─ Solve AI context and path confusion in VSCode/Cursor by switching from a multi-repo to a single-repo workspace. A case study on managing LLM memory.
/home/mike/repos/MikeLev.in/_posts/2025-07-13-engineering-emotion-css-ai-oz.md  # 9,215 tokens (1,810,660 / 4,726,218 total)
  └─ Learn how to create a cinematic grayscale-to-color fade effect, inspired by The Wizard of Oz, using CSS filter, brightness, contrast, and transitions.
/home/mike/repos/MikeLev.in/_posts/2025-07-13-resumable-demo-page-reload-persistence.md  # 20,896 tokens (1,831,556 / 4,717,003 total)
  └─ Learn to solve JavaScript state persistence across page reloads using a server-side demo bookmark system, illustrated through a real-world debugging session.
/home/mike/repos/MikeLev.in/_posts/2025-07-12-phantom-dialogue-ai-regression-testing.md  # 12,213 tokens (1,843,769 / 4,696,107 total)
  └─ A code-level breakdown of a JSON-driven interactive demo system using phantom dialogue to create a living specification and prevent AI code regressions.
/home/mike/repos/MikeLev.in/_posts/2025-07-12-universal-translator-ai-tool-calling.md  # 9,945 tokens (1,853,714 / 4,683,894 total)
  └─ Learn a 5-level graceful degradation strategy for AI tool calling, from XML to simple bracket syntax, to prevent regressions and enable universal AI compatibility.
/home/mike/repos/MikeLev.in/_posts/2025-07-11-cognitive-architecture-human-ai-development.md  # 14,532 tokens (1,868,246 / 4,673,949 total)
  └─ Learn to prevent AI coding errors by building a DOM visualizer, creating a shared "cognitive architecture" for you and your local AI partner.
/home/mike/repos/MikeLev.in/_posts/2025-07-10-infinite-regression-ai-collaboration-strategy.md  # 25,254 tokens (1,893,500 / 4,659,417 total)
  └─ Uncover a novel AI disaster recovery strategy. Learn to "pin" AI-driven development against infinite regression with transparent, local-first tools like Pipulate.
/home/mike/repos/MikeLev.in/_posts/2025-07-09-ai-strange-loop-git-recovery.md  # 13,290 tokens (1,906,790 / 4,634,163 total)
  └─ A real-world case study of using an AI 'strange loop' to fix a 100-commit bug that the LLM itself created. Details the conservative algorithm for git recovery.
/home/mike/repos/MikeLev.in/_posts/2025-07-08-ai-on-stage-dialogue-embodiment-agency.md  # 4,032 tokens (1,910,822 / 4,620,873 total)
  └─ A raw dialogue with AI model Grok 3 on AI embodiment, the ethics of ephemeral minds, and building a shared stage for true human-AI collaboration in software development.
/home/mike/repos/MikeLev.in/_posts/2025-07-08-giving-ai-a-body-embodiment-agency.md  # 10,937 tokens (1,921,759 / 4,616,841 total)
  └─ Discover how to give AI coding assistants a functional 'body' with tools, logs, and git access to overcome their limitations and create a true symbiotic development partnership.
/home/mike/repos/MikeLev.in/_posts/2025-07-07-forging-unforgettable-ai-durable-memory.md  # 6,748 tokens (1,928,507 / 4,605,904 total)
  └─ Learn how to build a durable AI memory and a robust, multi-generational backup system (son, father, grandfather) to ensure data persistence across application restarts and refactoring cycles.
/home/mike/repos/MikeLev.in/_posts/2025-07-06-ai-golden-path-python-cli-shell.md  # 21,103 tokens (1,949,610 / 4,599,156 total)
  └─ Solve inconsistent AI shell environments with a bulletproof Python CLI command. Learn the one true, environment-agnostic way to give your AI reliable hands.
/home/mike/repos/MikeLev.in/_posts/2025-07-05-cli-contract-future-proof-ai-framework.md  # 9,743 tokens (1,959,353 / 4,578,053 total)
  └─ Discover how to build a future-proof AI automation framework by establishing a simple command-line interface (CLI) on a stable Nix foundation.
/home/mike/repos/MikeLev.in/_posts/2025-07-05-arresting-regress-forging-ai-cli.md  # 18,657 tokens (1,978,010 / 4,568,310 total)
  └─ A real-time case study on building a robust CLI to prevent AI code regression, demonstrating a "Pin-the-Win, Arrest-the-Regress" development philosophy.
/home/mike/repos/MikeLev.in/_posts/2025-07-05-self-teaching-codebase-ai-development-partner.md  # 4,009 tokens (1,982,019 / 4,549,653 total)
  └─ An AI's in-depth analysis of a codebase designed for "Radical Transparency," revealing a self-teaching architecture with Nix, MCP tools, and browser embodiment.
/home/mike/repos/MikeLev.in/_posts/2025-07-04-ai-assisted-refactoring-browser-automation.md  # 14,441 tokens (1,996,460 / 4,545,644 total)
  └─ A case study on fixing a fragile browser automation system by replacing it with a reliable "baby steps" executor and integrating it with an AI via MCP tools.
/home/mike/repos/MikeLev.in/_posts/2025-07-04-git-reset-ai-recovery-gambit.md  # 16,419 tokens (2,012,879 / 4,531,203 total)
  └─ A developer's log on recovering from a major git reset, using an AI to cherry-pick valuable code, and redesigning a bulletproof browser automation and backup system.
/home/mike/repos/MikeLev.in/_posts/2025-07-03-ai-stable-targets-tech-stacks.md  # 4,611 tokens (2,017,490 / 4,514,784 total)
  └─ Learn the "Stable Target Thesis" for AI code assistance. Discover why Python and HTMX provide better LLM results than volatile JavaScript frameworks.
/home/mike/repos/MikeLev.in/_posts/2025-07-03-python-fasthtml-template-language.md  # 18,674 tokens (2,036,164 / 4,510,173 total)
  └─ Discover the philosophy behind FastHTML and HTMX, a Python web framework that challenges convention by using Python itself as the template language.
/home/mike/repos/MikeLev.in/_posts/2025-07-02-ai-tamagotchi-nurturing-digital-ghost.md  # 8,349 tokens (2,044,513 / 4,491,499 total)
  └─ Learn how to build a persistent AI memory using a SQLite keychain, transforming your AI from a stateless tool into a digital Tamagotchi that grows with you.
/home/mike/repos/MikeLev.in/_posts/2025-07-01-ai-emergent-collaboration-self-building-railway.md  # 12,519 tokens (2,057,032 / 4,483,150 total)
  └─ A case study in AI development where an AI's suggestion for a "self-building railway" is met with a pre-existing solution, the WorkflowGenesis plugin.
/home/mike/repos/MikeLev.in/_posts/2025-06-29-python-ast-refactoring-oop-alternative.md  # 10,246 tokens (2,067,278 / 4,470,631 total)
  └─ A practical guide to replacing OOP inheritance with a Python AST-based code generator for powerful, scalable workflow refactoring in a WET codebase.
/home/mike/repos/MikeLev.in/_posts/2025-06-28-developer-escape-tech-churn.md  # 11,311 tokens (2,078,589 / 4,460,385 total)
  └─ A veteran developer's escape from the tech "hamster wheel" by rejecting framework churn for the durable craftsmanship of Vim, Python, and the Unix philosophy.
/home/mike/repos/MikeLev.in/_posts/2025-06-28-ai-copilot-pipulate-release-system.md  # 16,777 tokens (2,095,366 / 4,449,074 total)
  └─ Discover how Pipulate’s AI-powered release system streamlines publishing with Gemma, automating versioning and cross-repo sync for SEO efficiency.
/home/mike/repos/MikeLev.in/_posts/2025-06-27-timeless-stack-tech-hamster-wheel-ai.md  # 10,583 tokens (2,105,949 / 4,432,297 total)
  └─ Explore a philosophy of durable tech, dual-environment workflows, and AI-assisted focus for escaping the endless tech hamster wheel.
/home/mike/repos/MikeLev.in/_posts/2025-06-27-feynman-safeguard-ascii-docs.md  # 6,605 tokens (2,112,554 / 4,421,714 total)
  └─ Discover how Pipulate bulletproofed its documentation system against content multiplication using a Feynman-inspired ASCII art safeguard.
/home/mike/repos/MikeLev.in/_posts/2025-06-24-living-readme-narrative-architecture.md  # 18,861 tokens (2,131,415 / 4,415,109 total)
  └─ Architect a narrative-driven README.md using ASCII art as a testable, single source of truth for multi-audience storytelling and feature demo coverage.
/home/mike/repos/MikeLev.in/_posts/2025-06-24-philosophy-axioms-ai-consciousness-stress-test.md  # 12,362 tokens (2,143,777 / 4,396,248 total)
  └─ A deep dialogue with an AI exploring the limits of knowledge, from philosophical axioms and Gödel's theorems to the nature of AI consciousness itself.
/home/mike/repos/MikeLev.in/_posts/2025-06-23-wet-code-ai-native-development.md  # 9,471 tokens (2,153,248 / 4,383,886 total)
  └─ Discover WET code: a revolutionary approach to AI-native development. Unify docs, tests, and AI context for transparent, efficient workflows with Python, HTMX, and local LLMs.
/home/mike/repos/MikeLev.in/_posts/2025-06-23-ai-ia.md  # 9,857 tokens (2,163,105 / 4,374,415 total)
  └─ A blueprint for a new kind of SEO based on AI-driven Information Architecture (AI IA), using an "intelligent rolling pin" metaphor to impose order on chaotic web content.
/home/mike/repos/MikeLev.in/_posts/2025-06-23-debugging-asynchronous-htmx-ai.md  # 6,112 tokens (2,169,217 / 4,364,558 total)
  └─ Diagnose and fix a subtle HTMX auto-scroll bug in an asynchronous Python web app through a detailed AI-assisted debugging session.
/home/mike/repos/MikeLev.in/_posts/2025-06-23-endosymbiotic-developer-ai-collaborator.md  # 7,860 tokens (2,177,077 / 4,358,446 total)
  └─ A case study on bootstrapping a frontier AI model into a full-context development partner using a custom 'Kung Fu Prompt' system and a philosophy of radical transparency.
/home/mike/repos/MikeLev.in/_posts/2025-06-21-ai-regression-recovery-case-study.md  # 15,172 tokens (2,192,249 / 4,350,586 total)
  └─ A developer's real-world case study of an AI assistant causing a major feature regression and the forensic debugging process used to recover the system.
/home/mike/repos/MikeLev.in/_posts/2025-06-20-simon-says-llm-ui-guidance.md  # 6,545 tokens (2,198,794 / 4,335,414 total)
  └─ Build AI-powered visual UI guidance with MCP. Debug LLM tool calls & implement real-time flashing animations for enhanced user experience.
/home/mike/repos/MikeLev.in/_posts/2025-06-17-wet-blueprint-ai-coding-philosophy.md  # 8,070 tokens (2,206,864 / 4,328,869 total)
  └─ A blueprint for challenging DRY principles, arguing for WET (Write Everything Twice) workflows with Pipulate, a local-first framework using HTMX and AI.
/home/mike/repos/MikeLev.in/_posts/2025-06-16-adaptive-workflow-template-driven-ui.md  # 9,600 tokens (2,216,464 / 4,320,799 total)
  └─ Learn to build dynamic, template-driven Python workflows where UI steps adapt to configuration, using a case study involving HTMX, Botify, and AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-06-16-htmx-ai-partner-debugging-workflow.md  # 20,176 tokens (2,236,640 / 4,311,199 total)
  └─ Fix a broken HTMX dynamic button by debugging a subtle Python tuple unpacking bug in a multi-step, template-driven workflow. A case study in AI-assisted development.
/home/mike/repos/MikeLev.in/_posts/2025-06-15-workflow-factory-emergent-modularity.md  # 4,729 tokens (2,241,369 / 4,291,023 total)
  └─ A case study on refactoring a Python workflow engine from numbered to named steps, enabling a modular "workflow factory" with rearrangeable logic.
/home/mike/repos/MikeLev.in/_posts/2025-06-15-integrating-google-analytics.md  # 8,296 tokens (2,249,665 / 4,286,294 total)
  └─ Discover how to integrate Google Analytics into Pipulate’s Quadfecta, mastering Botify’s API with AI-driven schema discovery.
/home/mike/repos/MikeLev.in/_posts/2025-06-15-taming-the-workflow-htmx-chain-reaction.md  # 10,401 tokens (2,260,066 / 4,277,998 total)
  └─ Debug Pipulate’s chain reaction to build the Quadfecta workflow with HTMX and deterministic tools.
/home/mike/repos/MikeLev.in/_posts/2025-06-14-git-stash-gambit-defaults-freedom.md  # 3,037 tokens (2,263,103 / 4,267,597 total)
  └─ Learn how a Nix-based app uses a 'git stash' gambit to ship default settings without blocking user customizations, creating a self-healing update system.
/home/mike/repos/MikeLev.in/_posts/2025-06-12-teaching-ai-model-context-protocol.md  # 13,549 tokens (2,276,652 / 4,264,560 total)
  └─ Discover MCP: Teach LLMs to trigger tool calls like cat facts, weaving results into local AI conversations for powerful agency.
/home/mike/repos/MikeLev.in/_posts/2025-06-11-unmetered-robot-army-browser-automation.md  # 15,018 tokens (2,291,670 / 4,251,011 total)
  └─ A case study on debugging a Python script that swaps workflow steps and implementing a 'Simon Says' widget to teach a local LLM MCP tool-calling.
/home/mike/repos/MikeLev.in/_posts/2025-06-11-simon-says-make-mcp-call-local-llm-tools.md  # 16,983 tokens (2,308,653 / 4,235,993 total)
  └─ A case study on implementing and adding observability to a local LLM tool-calling (MCP) system, moving from a rigid prototype to a flexible training widget.
/home/mike/repos/MikeLev.in/_posts/2025-06-10-how-i-trained-my-local-llm-to-be-an-mcp-client.md  # 26,401 tokens (2,335,054 / 4,219,010 total)
  └─ A practical guide and case study on implementing local LLM tool-calling from scratch using Ollama, Python, and a custom Model Context Protocol (MCP).
/home/mike/repos/MikeLev.in/_posts/2025-06-10-htmx-reactive-ui-case-study.md  # 3,269 tokens (2,338,323 / 4,192,609 total)
  └─ Create a dynamic, self-disabling button with HTMX out-of-band swaps. A case study on server-side state management without complex JavaScript.
/home/mike/repos/MikeLev.in/_posts/2025-06-10-state-management-duplicate-prevention-bug.md  # 4,588 tokens (2,342,911 / 4,189,340 total)
  └─ A case study on debugging a server-side race condition in Python where a persistent session key in a DictLikeDB prevents startup messages after a reboot.
/home/mike/repos/MikeLev.in/_posts/2025-06-10-perfect-pebble-tech-movement-strategy.md  # 9,178 tokens (2,352,089 / 4,184,752 total)
  └─ A strategic dialogue on launching Pipulate, a local-first software project, using a minimalist, philosophy-driven marketing plan co-developed with an AI.
/home/mike/repos/MikeLev.in/_posts/2025-06-08-hybrid-ai-assisted-refactoring-case-study.md  # 7,509 tokens (2,359,598 / 4,175,574 total)
  └─ A case study on refactoring a legacy Python plugin by transplanting methods into a modern, template-based architecture using a hybrid human-AI workflow.
/home/mike/repos/MikeLev.in/_posts/2025-06-08-migrate-github-pages-private-public.md  # 8,359 tokens (2,367,957 / 4,168,065 total)
  └─ A step-by-step guide to wiping a Git repository's history using an orphan branch and force push to migrate a Jekyll site from private to public GitHub Pages.
/home/mike/repos/MikeLev.in/_posts/2025-06-08-prompt-and-pray.md  # 12,816 tokens (2,380,773 / 4,159,706 total)
  └─ Resolve a `git pull` conflict in a Nix Flake auto-update system by implementing a 'copy-on-first-run' pattern for a user-editable Jupyter Notebook.
/home/mike/repos/MikeLev.in/_posts/2025-06-07-polishing-aligning-abstraction-focusing-lenses-llm-ai.md  # 20,115 tokens (2,400,888 / 4,146,890 total)
  └─ A case study in refactoring a Python and HTMX application by moving hardcoded role configurations into a central config and purifying inline CSS for better semantics.
/home/mike/repos/MikeLev.in/_posts/2025-05-31-ai-git-detective-commit-habits-code-forensics.md  # 3,798 tokens (2,404,686 / 4,126,775 total)
  └─ AI coding assistants like Claude now use git history for detective work, changing how developers should write commit messages.
/home/mike/repos/MikeLev.in/_posts/2025-05-27-python-gnome-scripting-existential-ai.md  # 12,192 tokens (2,416,878 / 4,122,977 total)
  └─ Automating GNOME virtual desktop setup across 7 screens using Python, wmctrl, and xdotool, with insights from AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-05-27-circular-self-documenting-llm-training-api-ecosystem.md  # 10,588 tokens (2,427,466 / 4,110,785 total)
  └─ Botify Trifecta: An intelligent developer ecosystem for Botify API (BQLv1/BQLv2) integration, CSV downloads, auto-documentation, and Jupyter debugging.
/home/mike/repos/MikeLev.in/_posts/2025-05-26-botify-api-openapi-deconstruction-ai-analysis.md  # 13,076 tokens (2,440,542 / 4,100,197 total)
  └─ In-depth AI analysis of Botify API's v1 OpenAPI (Swagger) specification, detailing architecture, RESTful design, BQLv2, jobs, and data models.
/home/mike/repos/MikeLev.in/_posts/2025-05-26-developer-tools-multi-ai-enhancement.md  # 33,118 tokens (2,473,660 / 4,087,121 total)
  └─ Enhancing Pipulate's Python workflow tool for flexible step splicing (top/bottom insertion), cosmetic renaming, and UI-consistent revert buttons using AI.
/home/mike/repos/MikeLev.in/_posts/2025-05-25-ai-genie-hide-show-debug-ui.md  # 9,096 tokens (2,482,756 / 4,054,003 total)
  └─ Developer's journal on implementing a 'Hide/Show Code' UI feature in Pipulate for Botify Python API snippets using HTMX, detailing AI-assisted development challenges and strategies.
/home/mike/repos/MikeLev.in/_posts/2025-05-24-api-logs-copy-paste-ready-jupyter-notebooks.md  # 9,924 tokens (2,492,680 / 4,044,907 total)
  └─ Details the iterative AI-assisted development process for enhancing Botify API BQL query logging in Pipulate, focusing on creating copy-paste ready Python snippets for Jupyter Notebooks and robust API token handling for improved transparency and reproducibility.
/home/mike/repos/MikeLev.in/_posts/2025-05-24-evolving-prompt-fu-command-line-dynamic-ai-context.md  # 15,873 tokens (2,508,553 / 4,034,983 total)
  └─ Details the evolution of prompt_foo.py, a Python script for generating XML context for LLMs, focusing on adding command-line prompt input via --prompt, with AI-assisted development insights.
/home/mike/repos/MikeLev.in/_posts/2025-05-23-fasthtml-htmx-python-endpoints.md  # 18,309 tokens (2,526,862 / 4,019,110 total)
  └─ Discusses Python web framework evolution, FastHTML/HTMX on Starlette/Uvicorn, and implementing robust CSV file downloads using HTTP headers and path/query parameters in the Pipulate project.
/home/mike/repos/MikeLev.in/_posts/2025-05-23-force-multiplying-ikigai-in-ai-age.md  # 18,242 tokens (2,545,104 / 4,000,801 total)
  └─ Planning and refining Pipulate's AI-driven web audit workflows, including interactive site crawlers with D3.js, selenium-wire data capture, and LLM-assisted analysis for SEO and client engagement.
/home/mike/repos/MikeLev.in/_posts/2025-05-22-beyond-40-tech-wisdom-ai.md  # 4,867 tokens (2,549,971 / 3,982,559 total)
  └─ Author's reflections on lifelong digital journaling, AI's role in augmenting thought, and the Pipulate project's aim to unlock knowledge from texts.
/home/mike/repos/MikeLev.in/_posts/2025-05-22-the-calm-before-the-nlweb.md  # 4,525 tokens (2,554,496 / 3,977,692 total)
  └─ Explores the Natural Language Web (NLWeb) proposal, its reliance on schema.org structured data (JSON-LD, RDFa), and using LLMs as dynamic web servers for AI-driven Browse.
/home/mike/repos/MikeLev.in/_posts/2025-05-21-ai-wrangling-code-transparency.md  # 40,557 tokens (2,595,053 / 3,973,167 total)
  └─ Detailed journal of refactoring Pipulate's Botify CSV downloader using Gemini and Cursor AI for BQL query transparency, addressing API quirks and HTMX chain reactions.
/home/mike/repos/MikeLev.in/_posts/2025-05-20-ai-workflow-automation-living-book.md  # 12,148 tokens (2,607,201 / 3,932,610 total)
  └─ Developer's journal on balancing deterministic scripts and LLM AI for workflow automation in the Pipulate project, focusing on code markers for a CREATE, SPLICE, SWAP pattern.
/home/mike/repos/MikeLev.in/_posts/2025-05-19-core-workflow-helpers-development.md  # 5,606 tokens (2,612,807 / 3,920,462 total)
  └─ Developer journal on refining Pipulate's workflow creation tools (create_workflow.py, splice_workflow_step.py), UI/CSS cleanup (PicoCSS), Roles feature, and AI-assisted documentation for a tech book.
/home/mike/repos/MikeLev.in/_posts/2025-05-19-ai-tools-that-make-tools.md  # 5,136 tokens (2,617,943 / 3,914,856 total)
  └─ Explores the 'tools making tools' paradigm, from hardware abstraction like NVIDIA CUDA to AI LLMs simplifying programming via natural language.
/home/mike/repos/MikeLev.in/_posts/2025-05-18-css-fasthtml-ast-helper-scripts-python.md  # 23,877 tokens (2,641,820 / 3,909,720 total)
  └─ Guide to refactoring inline CSS styles in Python web projects (Pipulate, FastHTML) using AST helper scripts, moving towards semantic classes and avoiding utility class bloat.
/home/mike/repos/MikeLev.in/_posts/2025-05-18-refactoring-ai-css-cleanup.md  # 31,842 tokens (2,673,662 / 3,885,843 total)
  └─ A weekend refactor journey: breaking out plugins, leveraging AI with prompt_foo.py, and automating CSS cleanup. Despite challenges, the server's running and UI looks good—a solid foundation for deeper style refactoring.
/home/mike/repos/MikeLev.in/_posts/2025-05-16-llm-code-validation-developer-tools.md  # 6,404 tokens (2,680,066 / 3,854,001 total)
  └─ Journal detailing the AI-assisted iterative development and debugging of splice_workflow_step.py, a Python script for Pipulate, reflecting on LLMs as coders and the successful creation of this developer helper tool.
/home/mike/repos/MikeLev.in/_posts/2025-05-16-user-roles-developer-velocity.md  # 11,401 tokens (2,691,467 / 3,847,597 total)
  └─ Journal entry detailing Pipulate's strategic development: planning user roles for plugin visibility, considering inter-workflow linking, and prioritizing the creation of developer tools like splice_workflow_step.py for workflow management.
/home/mike/repos/MikeLev.in/_posts/2025-05-15-compounding-craft-future-proof-tech-skills-ai.md  # 4,918 tokens (2,696,385 / 3,836,196 total)
  └─ Learn to future-proof tech skills against obsolescence using foundational tools like Linux, Python, vim, git, Nix (LPvgn) through iterative wins and personal agency.
/home/mike/repos/MikeLev.in/_posts/2025-05-15-ai-coding-assistant-python-helpers.md  # 11,081 tokens (2,707,466 / 3,831,278 total)
  └─ Explores challenges with AI coding assistants for precise file modifications and details the creation of Python scripts (create_workflow.py, splice_workflow_step.py) for deterministic Pipulate workflow templating and extension.
/home/mike/repos/MikeLev.in/_posts/2025-05-14-ai-precision-paradox-helpful-code-assistants-astray.md  # 3,030 tokens (2,710,496 / 3,820,197 total)
  └─ Discusses challenges of Large Language Models (LLMs) in precise coding tasks, AI 'helpfulness' causing errors, and strategies like deterministic scripts & specific prompting.
/home/mike/repos/MikeLev.in/_posts/2025-05-13-modular-widget-design-ai-workflow.md  # 3,527 tokens (2,714,023 / 3,817,167 total)
  └─ Insights into modular software widget design for efficient workflow creation and AI-assisted development. Explores refactoring strategies and naming conventions.
/home/mike/repos/MikeLev.in/_posts/2025-05-12-pragmatic-future-proof-software-htmx-python.md  # 9,335 tokens (2,723,358 / 3,813,640 total)
  └─ Developer reflections on pragmatic software design, choosing HTMX/FastHTML for Python web UIs, Pipulate's "chain reaction" workflow, and future-proofing against JavaScript framework churn. Discusses computational notebook history.
/home/mike/repos/MikeLev.in/_posts/2025-05-12-browser-downloads-automation-selenium-chrome-fasthtml.md  # 19,289 tokens (2,742,647 / 3,804,305 total)
  └─ Discusses challenges controlling Chrome's default download location in Selenium automation for local-first apps and the strategic shift to a user-driven multi-file upload widget.
/home/mike/repos/MikeLev.in/_posts/2025-05-11-google-login-test-selenium-ai.md  # 15,268 tokens (2,757,915 / 3,785,016 total)
  └─ Details the implementation of Selenium session persistence for browser automation, focusing on Google login tests, Chrome user profile management, and techniques to avoid bot detection.
/home/mike/repos/MikeLev.in/_posts/2025-05-10-selenium-wire-html-header-capture-coding-log.md  # 9,234 tokens (2,767,149 / 3,769,748 total)
  └─ Details Pipulate's browser automation development using Selenium-Wire to crawl and save web page data (headers, source HTML, DOM) to a reversible file system structure.
/home/mike/repos/MikeLev.in/_posts/2025-05-10-beyond-dom-capturing-full-web-context-selenium-automation.md  # 23,833 tokens (2,790,982 / 3,760,514 total)
  └─ Explores web crawling challenges and solutions for capturing DOM, source HTML, and headers using Selenium and `selenium-wire` for transparent, local web data storage.
/home/mike/repos/MikeLev.in/_posts/2025-05-09-ai-assisted-browser-automation-selenium-nix-flakes.md  # 18,627 tokens (2,809,609 / 3,736,681 total)
  └─ Guide to integrating Selenium browser automation into the Pipulate project using Nix flakes for cross-platform (macOS, Linux) support, detailing flake.nix and requirements.txt modifications and AI-assisted troubleshooting.
/home/mike/repos/MikeLev.in/_posts/2025-05-09-webmaster-nix-selenium-http-status-browser-control.md  # 17,917 tokens (2,827,526 / 3,718,054 total)
  └─ Cross-platform (macOS, Linux) browser automation using Selenium and Nix Flakes, detailing HTTP status code retrieval via JavaScript Performance API.
/home/mike/repos/MikeLev.in/_posts/2025-05-09-nix-flakes-normalize-dev-selenium-macos-linux.md  # 8,410 tokens (2,835,936 / 3,700,137 total)
  └─ Guide to achieving cross-platform (macOS, Linux) browser automation using Selenium and Nix Flakes, controlling host Chrome via chromedriver or webdriver-manager.
/home/mike/repos/MikeLev.in/_posts/2025-05-09-nixos-selenium-host-browser-automation-nix-flakes.md  # 6,947 tokens (2,842,883 / 3,691,727 total)
  └─ Guide to achieving reliable host browser automation on NixOS using Selenium and Nix Flakes. Addresses FHS binary issues and details a working POC with chromedriver.
/home/mike/repos/MikeLev.in/_posts/2025-05-08-github-pages-home-hosting-jekyll.md  # 2,722 tokens (2,845,605 / 3,684,780 total)
  └─ Guide to creating a Nix flake for a multi-site Jekyll development environment, managing ports, Ruby versions, and gems with a custom `jes` script for local hosting.
/home/mike/repos/MikeLev.in/_posts/2025-05-08-ai-editor-arms-race.md  # 5,815 tokens (2,851,420 / 3,682,058 total)
  └─ Developer log on Pipulate SEO software progress, focusing on AI-assisted coding with Claude/Cursor AI for FastHTML/HTMX, plugin architecture refinement, and managing AI context.
/home/mike/repos/MikeLev.in/_posts/2025-05-06-pipulate-software-reimagined-nix-wet-workflows-local-llm.md  # 2,562 tokens (2,853,982 / 3,676,243 total)
  └─ Explore Pipulate, a local-first software system featuring Nix Flakes for reproducible environments, WET workflows, local LLM integration, and a unique 'magic cookie' installation.
/home/mike/repos/MikeLev.in/_posts/2025-05-06-seamless-nix-flake-deployments-magic-cookie-auto-update.md  # 2,730 tokens (2,856,712 / 3,673,681 total)
  └─ Learn to build a "magic cookie" auto-updating system for Nix Flakes, enabling git-less installation and seamless cross-platform software distribution.
/home/mike/repos/MikeLev.in/_posts/2025-05-05-nix-flakes-cure-fragile-jekyll-ruby-setups.md  # 3,532 tokens (2,860,244 / 3,670,951 total)
  └─ Use Nix flakes to create stable, reproducible Jekyll development environments. Solves Ruby dependency issues, native gem compilation errors, and cross-project inconsistencies.
/home/mike/repos/MikeLev.in/_posts/2025-05-04-custom-branding-white-labeling-seo-software.md  # 4,765 tokens (2,865,009 / 3,667,419 total)
  └─ Guide to enabling white-labeling for Pipulate software via command-line arguments during installation using a modified bash script, Nix, and an app_name.txt file.
/home/mike/repos/MikeLev.in/_posts/2025-05-04-cursor-rules-project-workspace-git-solution.md  # 3,398 tokens (2,868,407 / 3,662,654 total)
  └─ Solve Cursor AI configuration issues by version controlling .mdc rule files within a Git repo using symbolic links (ln -s) on Linux, macOS, or NixOS.
/home/mike/repos/MikeLev.in/_posts/2025-05-04-jekyll-bash-script-swap-template-files-testing.md  # 3,943 tokens (2,872,350 / 3,659,256 total)
  └─ Detailed guide on creating a Bash script to toggle Jekyll template files (_layouts, CSS, index.md) using mv commands for debugging website issues like traffic drops. Includes final script and discussion on safe placement in _scripts/.
/home/mike/repos/MikeLev.in/_posts/2025-05-04-agentic-coding-wrangling-ai-assistants.md  # 13,701 tokens (2,886,051 / 3,655,313 total)
  └─ Consolidating Pipulate docs (.cursorrules, .mdc) via Gemini AI. Covers AI rules, HTMX patterns, Nix setup, workflow guide, and Parameter Buster for Botify.
/home/mike/repos/MikeLev.in/_posts/2025-05-02-home-hosting-bots-seo-signals-google-dominance.md  # 3,400 tokens (2,889,451 / 3,641,612 total)
  └─ Analysis of Google's search dominance amid AI challenges (ChatGPT, Perplexity), driving the need for home hosting, web log monitoring, and prioritizing SEO tool (Pipulate) development.
/home/mike/repos/MikeLev.in/_posts/2025-04-30-guiding-llms-pipulate-workflow-htmx-patterns.md  # 13,494 tokens (2,902,945 / 3,638,212 total)
  └─ Technical guide detailing Pipulate workflow development patterns, focusing on HTMX chain reactions for step progression and implementing placeholder steps. Includes code examples and LLM interaction context.
/home/mike/repos/MikeLev.in/_posts/2025-04-29-nix-flakes-magic-cookies-self-updating-environment.md  # 21,414 tokens (2,924,359 / 3,624,718 total)
  └─ Automate Pipulate software setup with a two-command Nix installer using `curl | sh`. Details auto-updates via SSH deploy key ('magic cookie') and Nix flakes.
/home/mike/repos/MikeLev.in/_posts/2025-04-29-nixos-jekyll-git-push-self-hosted-deployment.md  # 9,427 tokens (2,933,786 / 3,603,304 total)
  └─ Configure NixOS for self-hosting a Jekyll blog via Git push deployment using SSH hooks, Nginx, and a Flake-based system configuration.
/home/mike/repos/MikeLev.in/_posts/2025-04-29-git-revert-specific-files-jekyll-traffic.md  # 8,783 tokens (2,942,569 / 3,593,877 total)
  └─ How to revert specific Jekyll template files (like _layouts/default.html, _posts.html, CSS) to an older commit using git checkout <hash> -- <file> and git mv to fix issues like traffic drops without losing newer content or Git history.
/home/mike/repos/MikeLev.in/_posts/2025-04-27-refining-pipulate-widgets-ux-ai-collaboration.md  # 13,505 tokens (2,956,074 / 3,585,094 total)
  └─ Refining Pipulate web widgets (Pre, JS, Mermaid, Prism, MarkedJS) for UI/UX consistency using AI. Fixes display logic, locked states, styling, and adds Markdown.
/home/mike/repos/MikeLev.in/_posts/2025-04-27-integrating-prismjs-pandas-html-table-widgets.md  # 10,240 tokens (2,966,314 / 3,571,589 total)
  └─ Implementing Prism.js syntax highlighting and Pandas to_html table widgets in a Pipulate/FastHTML project using HTMX. Details Python code and AI collaboration.
/home/mike/repos/MikeLev.in/_posts/2025-04-27-local-javascript-download-script.md  # 12,529 tokens (2,978,843 / 3,561,349 total)
  └─ Details creating a Python script to download and save JavaScript libraries like markedjs locally for the Pipulate project, managing static assets.
/home/mike/repos/MikeLev.in/_posts/2025-04-26-fasthtml-htmx-javascript-rendering.md  # 14,647 tokens (2,993,490 / 3,548,820 total)
  └─ Debugging and fixing Rich table HTML & Mermaid diagram rendering in FastHTML/HTMX widgets using AI assistance. Details `_raw=True`, `NotStr`, and JS initialization timing.
/home/mike/repos/MikeLev.in/_posts/2025-04-26-llm-architecture-ai-collaboration-coding-workflows.md  # 8,854 tokens (3,002,344 / 3,534,173 total)
  └─ Explores AI as real intelligence via coding, details LLM ephemeral instance architecture, and positions AI as a translator/collaborator for technical workflows.
/home/mike/repos/MikeLev.in/_posts/2025-04-26-htmx-widgets-ai-implementation.md  # 12,717 tokens (3,015,061 / 3,525,319 total)
  └─ Implementing HTMX widgets (Rich table, JS execution, Markdown) in Pipulate workflows using FastHTML, AI planning (Gemini/Claude), and super-prompts. Discusses architecture and UX.
/home/mike/repos/MikeLev.in/_posts/2025-04-25-ai-code-assist-seo-traffic-drop-cls-fix.md  # 3,315 tokens (3,018,376 / 3,512,602 total)
  └─ Debugging SEO issues caused by AI-assisted CLS fixes. How using 'visibility: hidden' tanked traffic and the switch to 'opacity' for better indexing.
/home/mike/repos/MikeLev.in/_posts/2025-04-24-modern-interactive-toc-tocbot-guide.md  # 5,905 tokens (3,024,281 / 3,509,287 total)
  └─ Create modern, interactive Tables of Contents (ToCs) for websites using JavaScript (Tocbot) and CSS. Features scroll-spying, smooth scroll, and responsive design.
/home/mike/repos/MikeLev.in/_posts/2025-04-24-jekyll-front-matter-seo-social-metadata-guide.md  # 4,835 tokens (3,029,116 / 3,503,382 total)
  └─ Guide to structuring Jekyll front matter using nested YAML for Open Graph (OG), Twitter Cards, featured images, and SEO. Includes Liquid template examples.
/home/mike/repos/MikeLev.in/_posts/2025-04-23-vim-regex-google-docs-markdown-cleanup.md  # 3,128 tokens (3,032,244 / 3,498,547 total)
  └─ Use Vim/Neovim regex commands to automatically clean up Google Docs Markdown exports, fixing footnote numbers, extra backslashes, and citation pipe characters.
/home/mike/repos/MikeLev.in/_posts/2025-04-23-digital-independence-solarpunk-future-visions-self-hosting.md  # 22,002 tokens (3,054,246 / 3,495,419 total)
  └─ Explores digital independence via self-hosting and AI learning, researching future societies like Solarpunk, Elon Musk's vision, Burning Man principles, and sustainable tech like Aptera & Stella Terra.
/home/mike/repos/MikeLev.in/_posts/2025-04-23-pfsense-firewall-secure-home-network-hosting-setup.md  # 5,425 tokens (3,059,671 / 3,473,417 total)
  └─ Guide configuring pfSense firewall on mini PC (Topton N100) for secure home hosting with Verizon Fios. Covers initial setup, ONT connection, resolving IP conflict with ISP router (CR1000A) by setting it to AP mode.
/home/mike/repos/MikeLev.in/_posts/2025-04-22-optimizing-jekyll-rendering.md  # 1,775 tokens (3,061,446 / 3,467,992 total)
  └─ Optimize Jekyll build performance by speeding up related posts generation. Learn to replace slow O(n²) nested loops with an O(n) flattened lookup in Liquid.
/home/mike/repos/MikeLev.in/_posts/2025-04-22-python-rich-widgets-fasthtml-htmx.md  # 4,843 tokens (3,066,289 / 3,466,217 total)
  └─ Using Python's Rich library with FastHTML/HTMX to generate server-side HTML fragments (tables, widgets) with inline styles for lean web UI components.
/home/mike/repos/MikeLev.in/_posts/2025-04-22-cursor-ai-updates-nixos.md  # 3,343 tokens (3,069,632 / 3,461,374 total)
  └─ Guide to automatically installing the latest Cursor AI editor AppImage on NixOS via a custom activation script in configuration.nix for updates.
/home/mike/repos/MikeLev.in/_posts/2025-04-21-fasthtml-anywidget-host.md  # 17,585 tokens (3,087,217 / 3,458,031 total)
  └─ Technical blueprint for hosting anywidget widgets in a minimal FastHTML environment using WebSockets, bypassing Jupyter infrastructure. Analyzes AFM spec & state synchronization challenges.
/home/mike/repos/MikeLev.in/_posts/2025-04-21-generate-cursor-rules.md  # 6,029 tokens (3,093,246 / 3,440,446 total)
  └─ Using Cursor AI to analyze Pipulate Botify workflows, generate .cursorrules, and create training material for an embedded LLM user assistant.
/home/mike/repos/MikeLev.in/_posts/2025-04-21-regex-google-docs-markdown.md  # 4,728 tokens (3,097,974 / 3,434,417 total)
  └─ Use Vim regex commands to clean Markdown from Google Docs: automatically add sup tags to footnotes, remove excess backslashes, & conditionally escape pipes.
/home/mike/repos/MikeLev.in/_posts/2025-04-21-bing-search-api.md  # 21,637 tokens (3,119,611 / 3,429,689 total)
  └─ Detailed guide to Microsoft Bing Search API suite (Web, Image, News, Custom, Visual, Entity, etc.), pricing, terms, Python SDK/REST implementation, IndexNow, Webmaster Tools, Azure AI integration, and LLM grounding rules.
/home/mike/repos/MikeLev.in/_posts/2025-04-20-widgets-in-workflows.md  # 14,607 tokens (3,134,218 / 3,408,052 total)
  └─ Technical guide on implementing revert_control_advanced and widget_container in Pipulate for consistent rich content display (trees, charts) in workflow UIs using FastHTML/HTMX.
/home/mike/repos/MikeLev.in/_posts/2025-04-20-file-polling-progress-indicator.md  # 26,122 tokens (3,160,340 / 3,393,445 total)
  └─ Implementing automatic polling and indeterminate progress indicators (PicoCSS) for asynchronous Botify CSV API exports using Python, HTMX, and AI assistance (Gemini, Grok, ChatGPT). Includes AI comparison and HTMX chain reaction debugging.
/home/mike/repos/MikeLev.in/_posts/2025-04-19-export-botify-csv-api.md  # 56,083 tokens (3,216,423 / 3,367,323 total)
  └─ Develop a Pipulate workflow for Botify CSV export via API. Covers Botify URL parsing, BQL queries, analysis slugs, click depth calculation, API export limits, job polling, and download handling using Python and AI assistants.
/home/mike/repos/MikeLev.in/_posts/2025-04-19-detecting-nix-shell-environments.md  # 1,694 tokens (3,218,117 / 3,311,240 total)
  └─ Learn how to reliably detect if you are inside a Nix shell or nix develop environment using a simple bash alias checking IN_NIX_SHELL or PS1 prompt.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-nixos-failed-to-install-bootloader.md  # 4,623 tokens (3,222,740 / 3,309,546 total)
  └─ Troubleshoot NixOS full /boot partition (OSError 28 No space left) during upgrades. Fix when nix-collect-garbage fails due to orphaned EFI boot files.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-accelerating-seo-automation.md  # 13,332 tokens (3,236,072 / 3,304,923 total)
  └─ Implementation plan for Pipulate: adding Playwright browser automation, Botify API CSV export/polling, and URL redirect mapping workflows using Nix. Includes AI code suggestions.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-bridging-code-and-context.md  # 7,507 tokens (3,243,579 / 3,291,591 total)
  └─ Implementing Article Mode in prompt_foo.py script to feed codebase files plus technical articles as structured context for AI analysis and code implementation requests.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-ai-prompts-xml-tags.md  # 7,492 tokens (3,251,071 / 3,284,084 total)
  └─ Implementing Anthropic-style XML tags in Python to structure AI prompts for context generation (prompt_foo.py) and testing with o4-mini-high.
/home/mike/repos/MikeLev.in/_posts/2025-04-18-super-intelligent-ai-coding-assistance.md  # 4,098 tokens (3,255,169 / 3,276,592 total)
  └─ Developer explores controlling super-intelligent AI coding assistants (Claude, Gemini, Grok) for projects like Pipulate, focusing on agentic modes & context improvement.
/home/mike/repos/MikeLev.in/_posts/2025-04-17-git-without-server-local-filesystem.md  # 3,870 tokens (3,259,039 / 3,272,494 total)
  └─ Learn how to use a local filesystem path as a Git remote. Set up a bare repository (git init --bare) for offline version control without needing a server.
/home/mike/repos/MikeLev.in/_posts/2025-04-17-github-pages-logfiles.md  # 4,586 tokens (3,263,625 / 3,268,624 total)
  └─ Details the transition from GitHub Pages to self-hosting with NixOS for accessing web server log files to analyze SEO performance and bot traffic.
/home/mike/repos/MikeLev.in/_posts/2025-04-17-ime-mse-psp-tee-sep.md  # 6,043 tokens (3,269,668 / 3,264,038 total)
  └─ Explore Intel IME, AMD PSP, ARM TrustZone, Apple SEP hardware management engines. Learn about OS independence, security functions, and network capabilities like Intel AMT.
/home/mike/repos/MikeLev.in/_posts/2025-04-14-is-grok-better-than-chatgpt.md  # 64,448 tokens (3,334,116 / 3,257,995 total)
  └─ Compares Grok 3 and ChatGPT Plus performance analyzing complex Google Search Console SEO trend data. Includes full AI responses for a free vs paid task.
/home/mike/repos/MikeLev.in/_posts/2025-04-13-cherry-picking.md  # 2,603 tokens (3,336,719 / 3,193,547 total)
  └─ Discover how AI code agents analyze Git history to simplify difficult `git cherry-pick` operations and help manage complex version control workflows.
/home/mike/repos/MikeLev.in/_posts/2025-04-13-modern-seo-techniques.md  # 19,354 tokens (3,356,073 / 3,190,944 total)
  └─ Learn modern SEO strategies for AI: Focus on authenticity, storytelling, and building reputation to be recognized or 'trained into' AI models.
/home/mike/repos/MikeLev.in/_posts/2025-04-12-algorithmic-information-architecture-jekyll-ai.md  # 33,803 tokens (3,389,876 / 3,171,590 total)
  └─ Guide to developing a Python script using AI (Claude/Gemini) & GSC data to analyze Jekyll posts, cluster content via KMeans/TF-IDF, and auto-generate an optimized category hierarchy.
/home/mike/repos/MikeLev.in/_posts/2025-04-11-top-keywords-per-page.md  # 15,698 tokens (3,405,574 / 3,137,787 total)
  └─ Guide to integrating Google Search Console (GSC) keywords into a Jekyll blog using Python & Liquid for display, enhanced Lunr.js search, and meta tags.
/home/mike/repos/MikeLev.in/_posts/2025-04-10-google-search-console-api-python.md  # 25,090 tokens (3,430,664 / 3,122,089 total)
  └─ Use Python and the Google Search Console (GSC) API to analyze SEO performance trends. Learn to fetch granular query/page data and identify movers & shakers.
/home/mike/repos/MikeLev.in/_posts/2025-04-10-jekyll-lunr-static-site-search.md  # 10,599 tokens (3,441,263 / 3,096,999 total)
  └─ Implement Lunr.js client-side search on Jekyll static sites. Details AI-assisted workflow using Claude for setup, coding, and debugging the search feature.
/home/mike/repos/MikeLev.in/_posts/2025-04-09-taming-nix-develop-output-for-ai-assistants.md  # 15,483 tokens (3,456,746 / 3,086,400 total)
  └─ Optimize verbose Nix output for AI coding assistants with a multi-shell strategy that creates a quiet, efficient debugging and automation environment.
/home/mike/repos/MikeLev.in/_posts/2025-04-09-github-pages-blog-arrows.md  # 7,946 tokens (3,464,692 / 3,070,917 total)
  └─ Fix Jekyll blog navigation for multiple daily posts with custom sort_order and flat index Liquid logic for proper chronological sequencing.
/home/mike/repos/MikeLev.in/_posts/2025-04-08-grok-ai-better-than.md  # 23,238 tokens (3,487,930 / 3,062,971 total)
  └─ Discover how Grok’s agentic analysis unlocks hidden topics from stream-of-consciousness blog posts, powering innovative AI SEO and static site search.
/home/mike/repos/MikeLev.in/_posts/2025-04-08-ai-agentic-mode-debugging.md  # 5,999 tokens (3,493,929 / 3,039,733 total)
  └─ Learn how Cursor AI Agent Mode beats git cherry-pick by diagnosing asyncio bugs, analyzing git history, and automating message ordering for seamless debugging.
/home/mike/repos/MikeLev.in/_posts/2025-04-07-static-site-generator-ai-content-strategy.md  # 5,082 tokens (3,499,011 / 3,033,734 total)
  └─ Unleash AI-driven content strategy with static site generators. Use clean Markdown and YAML for efficient LLM analysis and SEO breakthroughs.
/home/mike/repos/MikeLev.in/_posts/2025-04-07-from-blog-to-book-ai-powered-ia.md  # 38,034 tokens (3,537,045 / 3,028,652 total)
  └─ Transform your disorganized blog into a clear book outline and site map using AI frontier models and custom Python scripts.
/home/mike/repos/MikeLev.in/_posts/2025-04-06-llm-seo-software-development.md  # 18,779 tokens (3,555,824 / 2,990,618 total)
  └─ Learn how LLMs guide SEO software development by prioritizing tasks, avoiding rabbit holes, and creating clear, actionable roadmaps.
/home/mike/repos/MikeLev.in/_posts/2025-04-06-cursor-ai-terminal-agent-mode.md  # 14,452 tokens (3,570,276 / 2,971,839 total)
  └─ Discover how Cursor AI's Agent mode terminal on NixOS uses Nix packaging, fhsenv, and APPDIR to create an isolated environment—learn why 'nix develop' is essential.
/home/mike/repos/MikeLev.in/_posts/2025-04-05-ai-context-mcp-llm.md  # 23,469 tokens (3,593,745 / 2,957,387 total)
  └─ Bundle your project code and prompts with a Python script that empowers local LLMs via MCP integration for precise AI analysis.
/home/mike/repos/MikeLev.in/_posts/2025-04-05-fasthtml-python-htmx-updates.md  # 8,035 tokens (3,601,780 / 2,933,918 total)
  └─ Discover how to achieve instant, seamless UI updates using FastHTML, Python HTMX, and AI-powered debugging in a local Nix setup.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-auto-incrementing-composite-keys.md  # 6,071 tokens (3,607,851 / 2,925,883 total)
  └─ Eliminate key paralysis with a smart auto-incrementing composite key system that blends profile, plugin context, and sequential IDs for seamless UX.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-mcp-with-local-llm.md  # 6,593 tokens (3,614,444 / 2,919,812 total)
  └─ Integrate Python MCP servers with your local LLM to automate resource requests beyond RAG, enabling flexible, privacy-first AI workflows.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-copy-pasting-llm-context.md  # 9,202 tokens (3,623,646 / 2,913,219 total)
  └─ Automate LLM code context management with a Python script that concatenates repo files, counts tokens, and builds a manifest for seamless AI input.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-vscode-ai-coding-assistants-forks-vs-plugins.md  # 12,920 tokens (3,636,566 / 2,904,017 total)
  └─ Compare AI coding assistants for VSCode in 2025—discover how full IDE forks differ from integrated plugins for a modern, powerful coding experience.
/home/mike/repos/MikeLev.in/_posts/2025-04-04-colab-vs-local-jupyter.md  # 28,339 tokens (3,664,905 / 2,891,097 total)
  └─ Compare Google Colab and local JupyterLab setups for AI-assisted Python data analysis, emphasizing reproducibility, control, and long-term privacy.
/home/mike/repos/MikeLev.in/_posts/2025-04-03-zero-to-clicks-niche-content.md  # 3,726 tokens (3,668,631 / 2,862,758 total)
  └─ Explore how long-tail, niche content can win organic clicks amid Google's complex search ecosystem and Core Web Vitals demands.
/home/mike/repos/MikeLev.in/_posts/2025-04-02-nixos-appimage.md  # 13,064 tokens (3,681,695 / 2,859,032 total)
  └─ Stay on the bleeding edge with NixOS by auto-fetching vendor AppImages during rebuilds for seamless desktop integration and update control.
/home/mike/repos/MikeLev.in/_posts/2025-04-01-cleaning-noteboook-cell-output-git.md  # 2,333 tokens (3,684,028 / 2,845,968 total)
  └─ Ensure clean, portable Git commits for Jupyter Notebooks by using nbstripout with .gitattributes to eliminate absolute paths across OSs.
/home/mike/repos/MikeLev.in/_posts/2025-04-01-connect-with-botify-workflow.md  # 6,368 tokens (3,690,396 / 2,843,635 total)
  └─ Securely connect to the Botify API with Pipulate’s plugin-based workflow, leveraging HTMX for a reactive, clean UI and streamlined token management.
/home/mike/repos/MikeLev.in/_posts/2025-03-31-dunning-kruger-deep-research-ai-seo.md  # 21,084 tokens (3,711,480 / 2,837,267 total)
  └─ Transform your SEO strategy with AI-driven deep research—overcome Dunning-Kruger biases to unlock true expertise and lasting digital success.
/home/mike/repos/MikeLev.in/_posts/2025-03-31-mcp-ai-api-server.md  # 33,305 tokens (3,744,785 / 2,816,183 total)
  └─ Upgrade your local LLM app with Anthropic’s MCP to execute real tool calls—moving from homegrown hacks to a robust, standard integration.
/home/mike/repos/MikeLev.in/_posts/2025-03-30-integrating-llm-plugin-architecture.md  # 13,385 tokens (3,758,170 / 2,782,878 total)
  └─ Refactor your plugin architecture to integrate LLMs seamlessly with robust dependency injection and improved global scope management.
/home/mike/repos/MikeLev.in/_posts/2025-03-30-tech-churn-vim-mastery.md  # 2,013 tokens (3,760,183 / 2,769,493 total)
  └─ Master terminal and vi/vim skills to outlast tech churn—build a timeless, future-proof foundation that transcends fleeting IDE trends.
/home/mike/repos/MikeLev.in/_posts/2025-03-29-vim-macro-to-lua.md  # 7,660 tokens (3,767,843 / 2,767,480 total)
  └─ Transform VimScript macros into Lua in NeoVim for easier macro editing and HTML escaping—enhanced with AI-assisted refinement.
/home/mike/repos/MikeLev.in/_posts/2025-03-29-jupyter-workflow-exploration.md  # 3,175 tokens (3,771,018 / 2,759,820 total)
  └─ Discover how Jupyter Notebook exploration transitions into Pipulate execution—bridging creative coding and manual HTMX workflow porting for future-proof projects.
/home/mike/repos/MikeLev.in/_posts/2025-03-29-vscode-jupyter-notebook-paths.md  # 18,270 tokens (3,789,288 / 2,756,645 total)
  └─ Discover robust techniques for identifying the file path of Jupyter notebooks across VSCode, Cursor AI, and JupyterLab for consistent workflow execution.
/home/mike/repos/MikeLev.in/_posts/2025-03-28-gsc-1000-row-limit-api.md  # 21,914 tokens (3,811,202 / 2,738,375 total)
  └─ Overcome the Google Search Console 1000-row limit with a Python/Jupyter API workflow that uses AI to paginate data and extract striking keywords.
/home/mike/repos/MikeLev.in/_posts/2025-03-28-google-search-console-api.md  # 32,922 tokens (3,844,124 / 2,716,461 total)
  └─ Harness Python and the Google Search Console API to uncover striking distance keywords—process data with Pandas and integrate SEMrush insights for optimized SEO.
/home/mike/repos/MikeLev.in/_posts/2025-03-28-future-proof-seo-nix.md  # 6,139 tokens (3,850,263 / 2,683,539 total)
  └─ Thrive in the AI SEO era by leveraging Nix and open-source, vendor-independent tools to create high-quality, sustainable content.
/home/mike/repos/MikeLev.in/_posts/2025-03-28-grok-vs-chatgpt-vs-gemini.md  # 47,152 tokens (3,897,415 / 2,677,400 total)
  └─ Compare AI-powered deep research tools—Grok’s Deep Search versus ChatGPT, Gemini, and Perplexity—for speed, depth, and cost-effective in-depth analysis.
/home/mike/repos/MikeLev.in/_posts/2025-03-27-cursor-ai-jupyter-notebook-cells.md  # 14,700 tokens (3,912,115 / 2,630,248 total)
  └─ Discover why Cursor AI fails to read Jupyter Notebook cell outputs and explore workarounds and alternatives for effective AI coding assistance.
/home/mike/repos/MikeLev.in/_posts/2025-03-27-age-of-ai-vibe-coding.md  # 5,746 tokens (3,917,861 / 2,615,548 total)
  └─ Future-proof your career by mastering deep technical skills and strategic focus—beyond the superficial allure of vibe coding in the AI era.
/home/mike/repos/MikeLev.in/_posts/2025-03-26-fastlite-todo-app.md  # 11,171 tokens (3,929,032 / 2,609,802 total)
  └─ Modularize your FastHTML fastlite Todo app by decoupling it from Pipulate with a flexible, plugin-based architecture.
/home/mike/repos/MikeLev.in/_posts/2025-03-25-python-plugin-architectures.md  # 10,690 tokens (3,939,722 / 2,598,631 total)
  └─ Build modular, extensible Python plugins for Pipulate using unified workflows, FastHTML, and MiniDataAPI for dynamic app development.
/home/mike/repos/MikeLev.in/_posts/2025-03-25-workflows-redirect-fix-attention.md  # 5,615 tokens (3,945,337 / 2,587,941 total)
  └─ Discover how Pipulate workflows help redirect your focus and combat digital distractions to reclaim control over your attention.
/home/mike/repos/MikeLev.in/_posts/2025-03-24-websockets-stream-incremental-markdown.md  # 15,920 tokens (3,961,257 / 2,582,326 total)
  └─ Discover real-time Markdown streaming techniques for Python FastHTML chat apps using WebSockets and HTMX for smooth incremental updates.
/home/mike/repos/MikeLev.in/_posts/2025-03-24-grok3-until-our-servers-melt.md  # 14,306 tokens (3,975,563 / 2,566,406 total)
  └─ Discover how Grok3’s resilient AI built a flexible Hello Webpage workflow using a WET coding approach—free until our servers melt.
/home/mike/repos/MikeLev.in/_posts/2025-03-24-ai-edit-code-diff.md  # 7,181 tokens (3,982,744 / 2,552,100 total)
  └─ See how to visually compare AI-edited code with a color-coded HTML diff generated by git diff and ansi2html—making code review intuitive and clear.
/home/mike/repos/MikeLev.in/_posts/2025-03-24-minidataapi-spec-xtra-tutorial.md  # 6,309 tokens (3,989,053 / 2,544,919 total)
  └─ Master MiniDataAPI's .xtra() method for simple, lightweight CRUD operations in Python. This tutorial explains permanent filtering and permission scoping.
/home/mike/repos/MikeLev.in/_posts/2025-03-23-notebook-to-web-app.md  # 9,056 tokens (3,998,109 / 2,538,610 total)
  └─ Transform Jupyter Notebooks into interactive, production-ready web apps with Pipulate. Leverage local AI and HTMX cascading for innovative, data-driven workflows.
/home/mike/repos/MikeLev.in/_posts/2025-03-23-local-ai-workflows-jupyter-nix.md  # 11,319 tokens (4,009,428 / 2,529,554 total)
  └─ Transform Jupyter Notebooks into local, customizable AI workflows with Pipulate and Nix for flexible, portable web apps.
/home/mike/repos/MikeLev.in/_posts/2025-03-22-linux-python-vim-git-htmx.md  # 11,391 tokens (4,020,819 / 2,518,235 total)
  └─ Future-proof your tech stack with Linux, Python, Vim, Git, and HTMX for dynamic, flexible web development.
/home/mike/repos/MikeLev.in/_posts/2025-03-22-fasthtml-htmx-ai-workflows.md  # 23,186 tokens (4,044,005 / 2,506,844 total)
  └─ Refactor AI workflows in Pipulate by embracing WET code with FastHTML and HTMX for explicit, customizable step-by-step development.
/home/mike/repos/MikeLev.in/_posts/2025-03-22-html-over-the-wire.md  # 14,141 tokens (4,058,146 / 2,483,658 total)
  └─ Discover how FastHTML and HTMX enable dynamic web apps by sending HTML over the wire—cutting through JSON complexity with minimal JavaScript.
/home/mike/repos/MikeLev.in/_posts/2025-03-21-navigating-ai-influence.md  # 8,078 tokens (4,066,224 / 2,469,517 total)
  └─ Navigate AI’s influence in development by building explicit, customizable workflows that break conventional molds—embrace WET coding with Pipulate.
/home/mike/repos/MikeLev.in/_posts/2025-03-21-evolving-ai-in-a-bottle.md  # 14,096 tokens (4,080,320 / 2,461,439 total)
  └─ Discover Chip O'Theseus—a local LLM that evolves with AI-assisted Jupyter workflows, blending FastHTML innovation with future-proof tech.
/home/mike/repos/MikeLev.in/_posts/2025-03-20-jupyter-notebook-vscode-cursor.md  # 3,093 tokens (4,083,413 / 2,447,343 total)
  └─ Learn how to run Jupyter Notebooks in Cursor AI using Nix Flakes and Pipulate for seamless live kernel and AI-assisted coding on NixOS.
/home/mike/repos/MikeLev.in/_posts/2025-03-20-dry-vs-wet.md  # 5,017 tokens (4,088,430 / 2,444,250 total)
  └─ Learn how to ditch DRY abstractions and build explicit, customizable pipelines in Pipulate for radical, Jupyter-like workflow flexibility.
/home/mike/repos/MikeLev.in/_posts/2025-03-19-radically-customizing-linear-workflows.md  # 6,469 tokens (4,094,899 / 2,439,233 total)
  └─ Unleash radical customization in Pipulate workflows with explicit, unlooped step handlers—achieve full UI flexibility like Jupyter Notebook cells.
/home/mike/repos/MikeLev.in/_posts/2025-03-19-is-fasthtml-any-good.md  # 9,876 tokens (4,104,775 / 2,432,764 total)
  └─ Discover FastHTML’s Python-powered, JavaScript-free approach for building dynamic web apps with HTMX that simplify web development.
/home/mike/repos/MikeLev.in/_posts/2025-03-18-unparsable-structured-data.md  # 2,608 tokens (4,107,383 / 2,422,888 total)
  └─ Fix JSON-LD structured data errors by removing problematic content and relying on HTML schema markup for error-free SEO.
/home/mike/repos/MikeLev.in/_posts/2025-03-18-jupyter-notebook-pipulate-workflow.md  # 18,625 tokens (4,126,008 / 2,420,280 total)
  └─ Transform Jupyter Notebooks into dynamic web apps with Pipulate’s local-first, LLM-powered workflow engine—streamlined automation and state management at your fingertips.
/home/mike/repos/MikeLev.in/_posts/2025-03-18-automating-seo-workflows.md  # 9,527 tokens (4,135,535 / 2,401,655 total)
  └─ Optimize site crawl efficiency with an automated JavaScript parameter buster that trims URL traps and boosts technical SEO.
/home/mike/repos/MikeLev.in/_posts/2025-03-18-open-source-seo.md  # 2,091 tokens (4,137,626 / 2,392,128 total)
  └─ Discover how I merged Botifython and Pipulate into one unified open source SEO codebase using smart app naming and streamlined workflows.
/home/mike/repos/MikeLev.in/_posts/2025-03-16-hot-prompt-injection-ai-workflow.md  # 10,597 tokens (4,148,223 / 2,390,037 total)
  └─ Boost your AI workflows with hot prompt injection. Integrate custom training prompts into modular FastHTML workflows for contextual AI assistance.
/home/mike/repos/MikeLev.in/_posts/2025-03-16-radical-simplicity-local-first.md  # 9,306 tokens (4,157,529 / 2,379,440 total)
  └─ Pipulate is a local-first desktop framework that simplifies web development with integrated LLMs and modular pipeline workflows.
/home/mike/repos/MikeLev.in/_posts/2025-03-16-ai-facilitating-self-improvement.md  # 13,958 tokens (4,171,487 / 2,370,134 total)
  └─ Discover how AI acts as a sounding board for self-improvement and mastery, sparking ideas without replacing true personal agency.
/home/mike/repos/MikeLev.in/_posts/2025-03-15-seo-age-of-llms.md  # 5,522 tokens (4,177,009 / 2,356,176 total)
  └─ Experiment with authentic, human-written SEO strategies on a vanity site to test if genuine content can outshine AI fluff and viral trends.
/home/mike/repos/MikeLev.in/_posts/2025-03-15-self-aware-software.md  # 17,366 tokens (4,194,375 / 2,350,654 total)
  └─ Discover a groundbreaking local-first software system using embedded LLMs and minimal Python/HTMX for self-aware, self-evolving development.
/home/mike/repos/MikeLev.in/_posts/2025-03-15-web-app-fasthtml-htmx.md  # 31,086 tokens (4,225,461 / 2,333,288 total)
  └─ Discover a self-aware software system using embedded LLMs, plain Python, and HTMX for transparent, modular local workflows.
/home/mike/repos/MikeLev.in/_posts/2025-03-14-nixos-upgrade-ollama.md  # 2,711 tokens (4,228,172 / 2,302,202 total)
  └─ Upgrade NixOS effortlessly with Ollama 0.6.0 – experience a clean, deterministic system rebuild with robust rollback and stability.
/home/mike/repos/MikeLev.in/_posts/2025-03-13-future-proof-automation-core.md  # 7,623 tokens (4,235,795 / 2,299,491 total)
  └─ Build a future-proof automation core for AI workflows with a lean, modular design using FastHTML, HTMX, and markdown-driven plugins.
/home/mike/repos/MikeLev.in/_posts/2025-03-13-plugs-slugs-nubs-stubs.md  # 2,692 tokens (4,238,487 / 2,291,868 total)
  └─ Capture and nurture creative idea seeds into full articles with a lean, modular workflow that blends digital journaling and modern web tools.
/home/mike/repos/MikeLev.in/_posts/2025-03-12-nixos-nvidia-cuda-ollama.md  # 1,398 tokens (4,239,885 / 2,289,176 total)
  └─ Optimize NixOS for AI by configuring NVIDIA CUDA support for Ollama, unlocking GPU acceleration on an RTX 3080.
/home/mike/repos/MikeLev.in/_posts/2025-03-12-real-time-ai-research.md  # 14,805 tokens (4,254,690 / 2,287,778 total)
  └─ Discover how real-time AI research is revolutionizing deep search with advanced function calling, challenging traditional vendor lock-in.
/home/mike/repos/MikeLev.in/_posts/2025-03-11-function-calling-for-llms.md  # 15,690 tokens (4,270,380 / 2,272,973 total)
  └─ Deep dive into LLM function calling protocols—from OpenAI's API to Anthropic's MCP—to build secure, flexible systems for external function execution.
/home/mike/repos/MikeLev.in/_posts/2025-03-11-small-world-theory-google.md  # 14,678 tokens (4,285,058 / 2,257,283 total)
  └─ Discover how LLM-assisted small-world search could upend Google’s traditional crawl-and-index model with real-time, context-driven results.
/home/mike/repos/MikeLev.in/_posts/2025-03-11-ai-deep-research.md  # 18,820 tokens (4,303,878 / 2,242,605 total)
  └─ Discover how AI deep research transforms analysis through real-time browsing, transparent citations, and advanced multi-model comparisons.
/home/mike/repos/MikeLev.in/_posts/2025-03-10-python-nix-flake-uv.md  # 7,098 tokens (4,310,976 / 2,223,785 total)
  └─ Modernize your Python Nix Flake by replacing pip/virtualenv with uv for faster dependency management and swift JupyterLab launches—ideal for AI projects.
/home/mike/repos/MikeLev.in/_posts/2025-03-09-agentic-frameworks-vs-browser-automation.md  # 16,607 tokens (4,327,583 / 2,216,687 total)
  └─ Discover a DIY method for local browser automation that uses Playwright and local LLMs for natural language control—ditch complex agentic frameworks.
/home/mike/repos/MikeLev.in/_posts/2025-03-08-python-mcp-server-example.md  # 27,804 tokens (4,355,387 / 2,200,080 total)
  └─ Uncover the pitfalls of Anthropic's MCP protocol with a minimal Python server example that exposes hidden vendor lock-ins and overwhelming complexity.
/home/mike/repos/MikeLev.in/_posts/2025-03-08-nix-flake-python.md  # 3,442 tokens (4,358,829 / 2,172,276 total)
  └─ Achieve consistent, cross-platform Python environments with nix flakes for reproducible venvs and built-in CUDA support on macOS, Windows, and Linux.
/home/mike/repos/MikeLev.in/_posts/2025-03-07-python-htmx-llm-seo.md  # 28,708 tokens (4,387,537 / 2,168,834 total)
  └─ Optimize a Python SEO tool with FastHTML, HTMX, and LLM integration. Learn to streamline workflows and trim code for local-first development.
/home/mike/repos/MikeLev.in/_posts/2025-03-07-llm-code-analysis-test.md  # 14,295 tokens (4,401,832 / 2,140,126 total)
  └─ Explore five LLMs as they blindly test and analyze a unique single-tenant Python codebase, revealing developer insights and tradeoffs.
/home/mike/repos/MikeLev.in/_posts/2025-03-07-reclaiming-the-narrative.md  # 6,321 tokens (4,408,153 / 2,125,831 total)
  └─ Discover how tech giants control public discourse by manipulating hardware startup states and default feeds to shape our narrative.
/home/mike/repos/MikeLev.in/_posts/2025-03-06-learning-htmx.md  # 7,369 tokens (4,415,522 / 2,119,510 total)
  └─ Revive your SEO workflow with Pipulate—a Python-powered tool using HTMX for simple, linear checklists and cross-platform automation.
/home/mike/repos/MikeLev.in/_posts/2025-03-05-distracted-weak-focused-strong.md  # 5,411 tokens (4,420,933 / 2,112,141 total)
  └─ Discover how focused attention and deliberate practice transform distraction into strength—unlock flow state and find your Ikigai.
/home/mike/repos/MikeLev.in/_posts/2025-03-04-sudo-nixos-rebuild-switch-upgrade.md  # 4,588 tokens (4,425,521 / 2,106,730 total)
  └─ Discover how 'sudo nixos-rebuild switch --upgrade' empowers NixOS with reproducible, portable system updates through Infrastructure as Code.
/home/mike/repos/MikeLev.in/_posts/2025-03-03-fasthtml-htmx-llm.md  # 6,614 tokens (4,432,135 / 2,102,142 total)
  └─ Discover how Python FastHTML with HTMX and LLM integration powers a loveworthy, documentation-driven web framework built on Pipulate and Ikigai principles.
/home/mike/repos/MikeLev.in/_posts/2025-03-03-out-of-steam-adenosine.md  # 7,043 tokens (4,439,178 / 2,095,528 total)
  └─ Explore adenosine's role in sleep pressure and cognitive energy, and learn natural strategies to boost productivity.
/home/mike/repos/MikeLev.in/_posts/2025-03-02-giving-grok3-another-chance.md  # 86,500 tokens (4,525,678 / 2,088,485 total)
  └─ Tested Grok 3 for converting Jupyter Notebooks into FastHTML web apps using HTMX, achieving WET, server-driven workflows without over-engineering.
/home/mike/repos/MikeLev.in/_posts/2025-03-01-fighting-analysis-paralysis.md  # 3,584 tokens (4,529,262 / 2,001,985 total)
  └─ Beat analysis paralysis with agile, action-driven SEO workflows and client communication using YAML storytelling and modern tech strategies.
/home/mike/repos/MikeLev.in/_posts/2025-02-28-fasthtml-fastapi-llm-over-training.md  # 12,516 tokens (4,541,778 / 1,998,401 total)
  └─ Discover how LLMs over-trained on FastAPI struggle with innovative FastHTML, exposing the limitations of static models in modern web development.
/home/mike/repos/MikeLev.in/_posts/2025-02-27-workflow-script-for-ai.md  # 14,133 tokens (4,555,911 / 1,985,885 total)
  └─ Tested ChatGPT 4.5 for an efficient workflow to generate client reports with FastHTML, exposing LLM limitations in respecting nuanced constraints.
/home/mike/repos/MikeLev.in/_posts/2025-02-26-commitment-and-consistency.md  # 23,138 tokens (4,579,049 / 1,971,752 total)
  └─ Get psyched for work by embracing commitment and consistency in SEO, with Ikigai-inspired focus and streamlined client project processes.
/home/mike/repos/MikeLev.in/_posts/2025-02-21-kickstarting-ai.md  # 6,193 tokens (4,585,242 / 1,948,614 total)
  └─ Chart a 20‐year plan for mastering enduring AI skills by balancing platform dependencies, API wrapping, and evolving intelligence.
/home/mike/repos/MikeLev.in/_posts/2025-02-20-grok3-markdown-problem.md  # 1,917 tokens (4,587,159 / 1,942,421 total)
  └─ Grok 3’s Copy Text feature strips essential Markdown formatting, disrupting Jekyll workflows—learn why grok.com delivers clean, publication-ready Markdown.
/home/mike/repos/MikeLev.in/_posts/2025-02-20-frozen-core-conundrum.md  # 22,904 tokens (4,610,063 / 1,940,504 total)
  └─ Overcome the Frozen Core Conundrum in AI-powered, local-first web apps by refactoring a single-file Python/HTMX codebase with Pipulate to build BotifyFlow.
/home/mike/repos/MikeLev.in/_posts/2025-02-19-o3-vs-grok-3.md  # 53,937 tokens (4,664,000 / 1,917,600 total)
  └─ Test and compare o3, Grok 3, and Gemini in building a local-first FastHTML/HTMX framework that favors explicit, notebook-like code over DRY abstraction.
/home/mike/repos/MikeLev.in/_posts/2025-02-04-reimagining-web-crawling-in-age-of-ai.md  # 5,563 tokens (4,669,563 / 1,863,663 total)
  └─ Discover The Site Whisperer—an innovative AI-powered web crawler harnessing local LLMs to revolutionize SEO and digital workflows.
/home/mike/repos/MikeLev.in/_posts/2025-02-03-sematic-web-discoverability-ai.md  # 4,781 tokens (4,674,344 / 1,858,100 total)
  └─ Explore how semantic web technologies like Schema.org and RDF are transforming SEO by emphasizing content over URLs for improved discoverability in the AI era.
/home/mike/repos/MikeLev.in/_posts/2025-02-01-future-of-seo-llm.md  # 14,379 tokens (4,688,723 / 1,853,319 total)
  └─ Discover a future-proof SEO framework powered by LLMs, HTMX, and FastHTML for building independent, intelligent SEO tools and agile mini-crawlers.
/home/mike/repos/MikeLev.in/_posts/2025-01-31-open-source-seo-software.md  # 10,855 tokens (4,699,578 / 1,838,940 total)
  └─ Discover Pipulate, a lightweight open source SEO tool built on Python and FastHTML that automates tasks via a flexible pipeline system.
/home/mike/repos/MikeLev.in/_posts/2025-01-25-ai-work-sheep-or-shepherds.md  # 4,414 tokens (4,703,992 / 1,828,085 total)
  └─ Embrace the AI era with proactive creativity—harness critical thinking and timeless tools to master work and stay ahead of passive trends.
/home/mike/repos/MikeLev.in/_posts/2025-01-22-amazon-manufacturer-disintermediation.md  # 4,196 tokens (4,708,188 / 1,823,671 total)
  └─ Explore how niche sellers navigate the Amazon squeeze and manufacturer disintermediation while leveraging Shopify in today’s evolving e-commerce landscape.
/home/mike/repos/MikeLev.in/_posts/2025-01-15-simplifying-state-workflow-refactoring.md  # 11,091 tokens (4,719,279 / 1,819,475 total)
  └─ Streamline multi-step workflows with robust state management and chain reaction control—an elegant refactoring journey for cleaner code and improved UX.
/home/mike/repos/MikeLev.in/_posts/2025-01-14-ai-new-era-of-literacy.md  # 8,165 tokens (4,727,444 / 1,808,384 total)
  └─ Programming literacy fuels the AI era—explore tech evolution from the printing press to Python-powered web frameworks and Unix-inspired workflows.
/home/mike/repos/MikeLev.in/_posts/2025-01-13-vim-indention-selection.md  # 2,462 tokens (4,729,906 / 1,800,219 total)
  └─ Optimized Lunr.js search fields boost client-side indexing with concise meta tags and focused keywords for precise search results.
/home/mike/repos/MikeLev.in/_posts/2025-01-12-breaking-changes-learning-opportunities.md  # 26,269 tokens (4,756,175 / 1,797,757 total)
  └─ Improve code clarity and efficiency with breaking changes using namedtuples and position lookups in a local-first, future-proof Python workflow.
/home/mike/repos/MikeLev.in/_posts/2025-01-11-refactoring-ai-assisted-code.md  # 51,012 tokens (4,807,187 / 1,771,488 total)
  └─ Regain control over AI-generated code by refactoring for clarity and maintainability. Master a transparent, human-driven Python workflow.
/home/mike/repos/MikeLev.in/_posts/2025-01-10-starter-flow.md  # 25,740 tokens (4,832,927 / 1,720,476 total)
  └─ Unlock the power of refined chain reactions in Starter Flow—a web framework using server-side state to simplify persistence and streamline pipeline workflows.
/home/mike/repos/MikeLev.in/_posts/2025-01-09-peak-data-musk-sutskever-wrong.md  # 27,879 tokens (4,860,806 / 1,694,736 total)
  └─ Challenge peak data theory—explore how surfacing outlier information with innovative crawling and ranking methods will redefine search.
/home/mike/repos/MikeLev.in/_posts/2025-01-09-virtual-desktops-future-proof.md  # 4,308 tokens (4,865,114 / 1,666,857 total)
  └─ Unlock a robust workflow with virtual desktops—streamline window management, boost productivity, and escape forced OS upgrades.
/home/mike/repos/MikeLev.in/_posts/2025-01-09-ideas-to-automation.md  # 9,958 tokens (4,875,072 / 1,662,549 total)
  └─ Discover how local open-source LLMs transform natural language into code, empowering innovation and democratizing automation for a new digital era.
/home/mike/repos/MikeLev.in/_posts/2025-01-08-coleco-adam-nixos.md  # 4,622 tokens (4,879,694 / 1,652,591 total)
  └─ Discover how a speed-chess mindset fuses quick habits with deliberate thought to drive smarter, rapid decision-making for both humans and AI.
/home/mike/repos/MikeLev.in/_posts/2025-01-07-finding-focus-and-flow-in-the-age-of-ai.md  # 14,488 tokens (4,894,182 / 1,647,969 total)
  └─ Boost focus and streamline your work with AI-driven pipeline workflows for effective self-management and client organization.
/home/mike/repos/MikeLev.in/_posts/2025-01-07-habit-deliberation-ai.md  # 4,457 tokens (4,898,639 / 1,633,481 total)
  └─ Master rapid decision-making with a speed-chess mindset that fuses instinctive habits with thoughtful analysis for smarter, agile choices.
/home/mike/repos/MikeLev.in/_posts/2025-01-06-the-irrepressible-outlier.md  # 5,500 tokens (4,904,139 / 1,629,024 total)
  └─ Embrace your inner outlier in the digital revolution—from Atari to generative AI—and thrive in a world overflowing with infinite content.
/home/mike/repos/MikeLev.in/_posts/2025-01-06-nixos-nvidia-wayland.md  # 8,733 tokens (4,912,872 / 1,623,524 total)
  └─ Solve NVIDIA graphics issues on NixOS with declarative configuration and robust kernel parameters. Learn fallback strategies for stable Wayland.
/home/mike/repos/MikeLev.in/_posts/2025-01-05-htmx-pipelines-persistent-state.md  # 46,610 tokens (4,959,482 / 1,614,791 total)
  └─ Build a robust HTMX StarterFlow pipeline with multi‐step forms, persistent state (Step 1), and smooth revert/finalize toggling for effective state management.
/home/mike/repos/MikeLev.in/_posts/2025-01-04-anti-patterns-best-practices.md  # 12,177 tokens (4,971,659 / 1,568,181 total)
  └─ Discover how unconventional anti-patterns in web development evolve into best practices with minimalist tools like HTMX and FastHTML.
/home/mike/repos/MikeLev.in/_posts/2025-01-04-un-externalizing-helper-function.md  # 29,519 tokens (5,001,178 / 1,556,004 total)
  └─ Discover how un-externalizing a helper function streamlines pipeline state management and boosts code clarity in minimalist web workflows.
/home/mike/repos/MikeLev.in/_posts/2025-01-03-git-cherry-picking.md  # 20,517 tokens (5,021,695 / 1,526,485 total)
  └─ Master advanced Git techniques for cherry picking and time travel to fix bugs and optimize branch management in your development workflow.
/home/mike/repos/MikeLev.in/_posts/2025-01-02-one-card-flow.md  # 21,768 tokens (5,043,463 / 1,505,968 total)
  └─ Discover One Card Flow—a minimal pipeline workflow with a single textarea input refined by Pipulate for streamlined state management.
/home/mike/repos/MikeLev.in/_posts/2025-01-01-rubber-ducking-with-llm.md  # 29,780 tokens (5,073,243 / 1,484,200 total)
  └─ Harness an LLM for rubber duck debugging—refine your web framework pipeline with creative mantras and simple state-fix solutions.
/home/mike/repos/MikeLev.in/_posts/2024-12-31-fasthtml-htmx-unix-pipes.md  # 36,439 tokens (5,109,682 / 1,454,420 total)
  └─ Discover a Unix pipe–inspired web workflow using FastHTML & HTMX—each step transforms data in a clean, chainable pipeline.
/home/mike/repos/MikeLev.in/_posts/2024-12-30-rabbit-holes-shoulders-of-giants.md  # 9,654 tokens (5,119,336 / 1,417,981 total)
  └─ Uncover a future-proof, local-first tech stack built with Nix, FastHTML, and Anywidget for a hackable, offline alternative to cloud-based apps.
/home/mike/repos/MikeLev.in/_posts/2024-12-30-python-nix-htmx-ollama.md  # 23,576 tokens (5,142,912 / 1,408,327 total)
  └─ Discover a local-first, single-file web framework built with Python, Nix, HTMX, and an integrated on-device LLM for hackable, self-hosted apps.
/home/mike/repos/MikeLev.in/_posts/2024-12-29-the-sound-of-htmx-pipes.md  # 34,724 tokens (5,177,636 / 1,384,751 total)
  └─ Experience the elegance of Unix pipe principles with HTMX in a 10-card pipeline workflow that streamlines web process management using local LLM integration.
/home/mike/repos/MikeLev.in/_posts/2024-12-28-planning-chip-o-theseus.md  # 30,964 tokens (5,208,600 / 1,350,027 total)
  └─ Discover Chip O'Theseus, a project that empowers local LLM with persistent memory and self-modification via a SQLite key-value store and prompt engineering.
/home/mike/repos/MikeLev.in/_posts/2024-12-27-linkgraphectomy.md  # 23,114 tokens (5,231,714 / 1,319,063 total)
  └─ Automate extraction and visualization of massive link graphs using a minimalist, single-file pipeline that harnesses industrial crawler APIs for SEO.
/home/mike/repos/MikeLev.in/_posts/2024-12-26-flow-state-idea-capture-vs-organization.md  # 8,399 tokens (5,240,113 / 1,295,949 total)
  └─ Master the art of capturing ideas in a flow state and organizing them later using minimalist tools like Vim to maintain creative momentum.
/home/mike/repos/MikeLev.in/_posts/2024-12-25-ai-stress-test.md  # 64,379 tokens (5,304,492 / 1,287,550 total)
  └─ Explore AI model o1 Pro in a stress test that refines a complex Python class into a modular, pipeline-based Botify API workflow.
/home/mike/repos/MikeLev.in/_posts/2024-12-24-the-future-was-now.md  # 15,117 tokens (5,319,609 / 1,223,171 total)
  └─ Explore how the Amiga’s legacy mirrors today’s tech cycles and inspires sustainable, minimalist innovation via LPvg, NixOS, and HTMX.
/home/mike/repos/MikeLev.in/_posts/2024-12-23-nixos-wayland-hyprland.md  # 14,056 tokens (5,333,665 / 1,208,054 total)
  └─ Read about my experiment switching from GNOME to Hyprland on NixOS. Discover insights on performance, workspace management, and desktop customization trade-offs.
/home/mike/repos/MikeLev.in/_posts/2024-12-23-gaining-traction.md  # 6,778 tokens (5,340,443 / 1,193,998 total)
  └─ Master strategies for gaining traction in tech—balance AI innovation with organic growth and timeless creative principles.
/home/mike/repos/MikeLev.in/_posts/2024-12-19-rebooting-site.md  # 3,538 tokens (5,343,981 / 1,187,220 total)
  └─ Rediscover timeless computing principles and reclaim simplicity amid tech hype. Embrace Unix, reproducibility, and local-first practices.
/home/mike/repos/MikeLev.in/_posts/2024-12-13-back-to-basics-reclaiming-simplicity.md  # 13,171 tokens (5,357,152 / 1,183,682 total)
  └─ Cut through tech hype by embracing timeless computing principles—build reproducible, local-first systems inspired by Unix simplicity.
/home/mike/repos/MikeLev.in/_posts/2024-12-11-sheet-music-chisel-strikes.md  # 6,184 tokens (5,363,336 / 1,170,511 total)
  └─ Discover how coding can be like writing sheet music—daily chisel-strikes create clear, teachable code and inspire steady progress.
/home/mike/repos/MikeLev.in/_posts/2024-12-10-no-churn.md  # 6,082 tokens (5,369,418 / 1,164,327 total)
  └─ Embrace the No-Churn Movement to build lasting expertise with stable, timeless tech while avoiding the constant trend churn.
/home/mike/repos/MikeLev.in/_posts/2024-12-09-openai-chatgpt-pro-o1.md  # 23,377 tokens (5,392,795 / 1,158,245 total)
  └─ Explore the testing of OpenAI ChatGPT Pro (o1 Release) within a minimalist, server-centric pipeline workflow that integrates local AI and fosters reproducible development.
/home/mike/repos/MikeLev.in/_posts/2024-12-08-claude-o1-collaboration.md  # 44,451 tokens (5,437,246 / 1,134,868 total)
  └─ Explore the Claude & o1 collaboration on a minimalist, server-first workflow framework that uses a single JSON pipeline and HTMX for resumable, linear UI updates.
/home/mike/repos/MikeLev.in/_posts/2024-12-07-zenos-paradox-knuth-brooks.md  # 20,212 tokens (5,457,458 / 1,090,417 total)
  └─ Learn how Knuth, Brooks, and Zeno’s paradox reveal that chasing coding perfection yields diminishing returns—embrace pragmatism and simply ship your code.
/home/mike/repos/MikeLev.in/_posts/2024-12-06-testing-chatgpt-o1-release.md  # 20,615 tokens (5,478,073 / 1,070,205 total)
  └─ Testing OpenAI ChatGPT o1 with a 6,600-line codebase reveals enhanced context processing and clear, actionable project insights.
/home/mike/repos/MikeLev.in/_posts/2024-12-03-david-mayer-donald-trump-censorship.md  # 9,273 tokens (5,487,346 / 1,049,590 total)
  └─ Master progress with deliberate chisel-strikes—learn how incremental Git workflows and direct file-linking on Linux/NixOS build a portable, future-proof system.
/home/mike/repos/MikeLev.in/_posts/2024-12-02-multiple-passes.md  # 9,584 tokens (5,496,930 / 1,040,317 total)
  └─ Unlock lasting progress with small, deliberate chisel-strikes that build digital mastery and sustained flow without burnout.
/home/mike/repos/MikeLev.in/_posts/2024-11-29-banking-wins.md  # 21,387 tokens (5,518,317 / 1,030,733 total)
  └─ Transform endless busywork into a state of flow with an AI-powered SEO tool that turns Sisyphus’ struggle into digital innovation.
/home/mike/repos/MikeLev.in/_posts/2024-11-27-dedumbing-sisyphus.md  # 6,801 tokens (5,525,118 / 1,009,346 total)
  └─ Overcome busywork traps with a minimalist, AI-powered SEO approach—explore antifragility, flow state, and building a meaningful tech legacy.
/home/mike/repos/MikeLev.in/_posts/2024-11-25-pipeline-to-completion.md  # 5,552 tokens (5,530,670 / 1,002,545 total)
  └─ Complete workflows seamlessly with a minimalist pipeline design—using URL keys and a self-healing JSON blob for consistent state transitions.
/home/mike/repos/MikeLev.in/_posts/2024-11-24-wrangling-ai-code-assistants.md  # 997 tokens (5,531,667 / 996,993 total)
  └─ Master the art of wrangling AI coding assistants with precise, genie-proof instructions that prevent unintended code overhauls.
/home/mike/repos/MikeLev.in/_posts/2024-11-24-ai-seo-100-percent-accountability.md  # 9,200 tokens (5,540,867 / 995,996 total)
  └─ BFF SEO dot BOT is born—an innovative project reimagining site organization with smart SEO, streamlined navigation, and local-first precision.
/home/mike/repos/MikeLev.in/_posts/2024-11-24-the-mindful-mirror-model-effect.md  # 8,198 tokens (5,549,065 / 986,796 total)
  └─ Unlock true self-awareness as AI challenges cognitive bias. Embrace the Mindful Mirror Model Effect for profound personal growth.
/home/mike/repos/MikeLev.in/_posts/2024-11-24-brainstorming-book-titles-with-ai.md  # 12,851 tokens (5,561,916 / 978,598 total)
  └─ Unlock creative book title ideas with AI—merge local computing, the LPvg stack, and digital sovereignty for innovative, engaging concepts.
/home/mike/repos/MikeLev.in/_posts/2024-11-23-nixos-warbler-files-disappeared.md  # 3,851 tokens (5,565,767 / 965,747 total)
  └─ Discover how the NixOS Warbler update removed Nautilus and learn the simple config tweaks to restore your Linux GUI file manager on unstable NixOS.
/home/mike/repos/MikeLev.in/_posts/2024-11-23-pipeline-workflow-example.md  # 31,942 tokens (5,597,709 / 961,896 total)
  └─ Explore a pipeline workflow built with FastHTML, HTMX, and MiniDataAPI—enabling robust server-side state management in a localhost-first web app.
/home/mike/repos/MikeLev.in/_posts/2024-11-22-llm-speedbumps.md  # 18,336 tokens (5,616,045 / 929,954 total)
  └─ Explore LLM speedbumps, anti-pattern vaccines, and the localhost revolution—build lean, server-side pipeline workflows with FastHTML, HTMX & MiniDataAPI.
/home/mike/repos/MikeLev.in/_posts/2024-11-21-pipulate-pipeline-born-again.md  # 35,610 tokens (5,651,655 / 911,618 total)
  └─ Revamp your SEO workflow with Pipulate—local-first pipeline processing with FastHTML, HTMX & SQLite for seamless server-side state management.
/home/mike/repos/MikeLev.in/_posts/2024-11-20-flow-state-alternation.md  # 17,054 tokens (5,668,709 / 876,008 total)
  └─ Boost your SEO success by harnessing flow state alternation. Discover how deep focus and AI coding assistants optimize productivity and creativity.
/home/mike/repos/MikeLev.in/_posts/2024-11-19-pipeline-workflow.md  # 35,789 tokens (5,704,498 / 858,954 total)
  └─ Streamline complex workflows with a lightweight, Unix-inspired pipeline system using FastHTML and MiniDataAPI for local automation.
/home/mike/repos/MikeLev.in/_posts/2024-11-18-pattern-alert-this-is-not-fastapi.md  # 24,156 tokens (5,728,654 / 823,165 total)
  └─ Discover how FastHTML’s Unix-inspired design and defensive documentation deliver simplicity over FastAPI’s complexity, with clear state management and smart prompt engineering.
/home/mike/repos/MikeLev.in/_posts/2024-11-17-unix-pipelines-htmx-fasthtml-workflow.md  # 32,352 tokens (5,761,006 / 799,009 total)
  └─ Embrace a Unix-inspired workflow in FastHTML and HTMX to simplify state management, persistence, and debugging in a single-tenant pipeline.
/home/mike/repos/MikeLev.in/_posts/2024-11-16-fighting-dunning-kruger-effect.md  # 27,935 tokens (5,788,941 / 766,657 total)
  └─ Conquer overconfidence with a single-tenant web app that uses file‐based state, HTMX UI, and simple, robust workflows.
/home/mike/repos/MikeLev.in/_posts/2024-11-15-openapi-swagger-json-to-python.md  # 9,892 tokens (5,798,833 / 738,722 total)
  └─ Transform OpenAPI Swagger JSON into practical Python code examples. Automate API integration, enhance documentation, and streamline code generation.
/home/mike/repos/MikeLev.in/_posts/2024-11-13-80-percent-cost-reduction-in-ai-operations.md  # 35,272 tokens (5,834,105 / 728,830 total)
  └─ Discover how AI-native architecture with local/cloud LLM orchestration can reduce AI operational costs by 80% while enhancing privacy and scalability.
/home/mike/repos/MikeLev.in/_posts/2024-11-12-6-click-ease-to-serve-up-bacon.md  # 7,680 tokens (5,841,785 / 693,558 total)
  └─ Future web search: AI uses small world theory (6 degrees) to crawl the internet database. Structure sites for AI model training & RAG.
/home/mike/repos/MikeLev.in/_posts/2024-11-11-how-to-train-your-llm.md  # 14,967 tokens (5,856,752 / 685,878 total)
  └─ Train LLMs like Botify BQL experts: Use curated docs (Jupyter>Markdown) & hot prompt injection for dynamic, just-in-time context.
/home/mike/repos/MikeLev.in/_posts/2024-11-10-i-know-kung-fu-show-me.md  # 16,423 tokens (5,873,175 / 670,911 total)
  └─ Master Botify BQL API with AI help: Python script finds optimal depth & exports link graphs, enabled by prompt injection context.
/home/mike/repos/MikeLev.in/_posts/2024-11-09-jupyter-notebooks-to-markdown.md  # 11,671 tokens (5,884,846 / 654,488 total)
  └─ Workflow to manage Jupyter Notebooks: Use nb-clean for clean git history & jupytext to convert .ipynb to Markdown for docs & LLM training.
/home/mike/repos/MikeLev.in/_posts/2024-11-08-practicing-botify-api.md  # 10,799 tokens (5,895,645 / 642,817 total)
  └─ Practice Botify API with Python notebooks: Fetch projects, analyses, collections, fields & run BQLv2 queries/exports for SEO data analysis.
/home/mike/repos/MikeLev.in/_posts/2024-11-07-structuring-websites-to-train-models.md  # 4,232 tokens (5,899,877 / 632,018 total)
  └─ Structure website content for AI training sets & real-time queries. Use Q&A formats & optimize for AI crawlers & RAG systems for future SEO.
/home/mike/repos/MikeLev.in/_posts/2024-11-06-resilience-while-achieving-ikagi.md  # 6,556 tokens (5,906,433 / 627,786 total)
  └─ Using Ikigai & resilience principles to develop AI-integrated web apps with local LLMs, prompt injection, & future-proof techniques.
/home/mike/repos/MikeLev.in/_posts/2024-11-05-mac-nvim-same-as-nixos-nvim.md  # 5,676 tokens (5,912,109 / 621,230 total)
  └─ Match NeoVim setup on Mac & NixOS using Nix Flakes. Configure flake.nix to install nvim, link init.lua & use unstable channel for consistency.
/home/mike/repos/MikeLev.in/_posts/2024-11-04-figuring-out-a-complex-api.md  # 47,521 tokens (5,959,630 / 615,554 total)
  └─ Learn to navigate the Botify API & BQLv2. Fetch projects, analyses, collections, fields & build queries for SEO data using Python & AI help.
/home/mike/repos/MikeLev.in/_posts/2024-11-03-sse-watchdog-force-live-reload.md  # 3,384 tokens (5,963,014 / 568,033 total)
  └─ Restore FastHTML/Uvicorn live-reload broken by SSE. Use Python watchdog to monitor files & force reliable server restarts for a smooth dev workflow.
/home/mike/repos/MikeLev.in/_posts/2024-11-03-api-enabling-llm-ghost.md  # 24,712 tokens (5,987,726 / 564,649 total)
  └─ Learn how an LLM can control browser DOM updates for CRUD actions via HTMX, WebSockets, and SSE, creating a seamless UI interaction mimicking user input.
/home/mike/repos/MikeLev.in/_posts/2024-11-02-got-my-llm-to-play-nice-with-web-ui.md  # 25,317 tokens (6,013,043 / 539,937 total)
  └─ Debugging LLM-driven UI updates in FastHTML/HTMX. Switched from WebSockets to Server-Sent Events (SSE) for reliable backend-to-frontend command triggering.
/home/mike/repos/MikeLev.in/_posts/2024-11-02-fasthtml-hello-world.md  # 704 tokens (6,013,747 / 514,620 total)
  └─ FastHTML 'Hello World' tutorial: Create web pages using Python functions (e.g., `H1()`, `Body()`) that map to HTML elements, skipping template languages.
/home/mike/repos/MikeLev.in/_posts/2024-11-01-deep-debugging-llm-ghost.md  # 52,480 tokens (6,066,227 / 513,916 total)
  └─ Debugging LLM actions causing UI updates in FastHTML/HTMX. Chronicles WebSocket issues & proposes Server-Sent Events (SSE) as a robust solution.
/home/mike/repos/MikeLev.in/_posts/2024-10-31-rabbit-hole-dev-to-delight-clients.md  # 3,074 tokens (6,069,301 / 461,436 total)
  └─ Developer's reflection on balancing deep AI coding focus ('rabbit hole') with client needs. Strategies for resilience, avoiding distractions & managing workflow.
/home/mike/repos/MikeLev.in/_posts/2024-10-30-giving-gemini-advanced-a-try.md  # 15,940 tokens (6,085,241 / 458,362 total)
  └─ Debugging LLM 'Ghost In The Machine' actions in FastHTML/HTMX. Covers AI-assisted refactoring, enhanced logging via decorators & NixOS helper scripts.
/home/mike/repos/MikeLev.in/_posts/2024-10-30-its-about-delighting-customers.md  # 7,846 tokens (6,093,087 / 442,422 total)
  └─ Prioritize customer delight (Drucker/Deming) in AI-assisted development. Refines workflow via Jupyter prototyping & structured client meeting prep.
/home/mike/repos/MikeLev.in/_posts/2024-10-29-llm-as-ambient-app-intelligence.md  # 5,933 tokens (6,099,020 / 434,576 total)
  └─ Explore ambient LLM intelligence in apps: Details streaming WebSocket chat via Python/FastHTML & prioritizing client value (Drucker/Deming) in AI dev.
/home/mike/repos/MikeLev.in/_posts/2024-10-28-fasthmtl-static-resources.md  # 5,991 tokens (6,105,011 / 428,643 total)
  └─ Manage static resources in FastHTML: Disable CDN defaults via `fast_app(default_hdrs=False)` and use `hdrs=(...)` for local JS/CSS includes.
/home/mike/repos/MikeLev.in/_posts/2024-10-27-slack-zoom-nixos.md  # 6,310 tokens (6,111,321 / 422,652 total)
  └─ Workflow strategy using virtual desktops (7+1 screens) for focus & muscle memory. Includes easy Slack/Zoom install on NixOS via configuration.nix.
/home/mike/repos/MikeLev.in/_posts/2024-10-26-accumulated-chunks-to-real-time-yields.md  # 31,576 tokens (6,142,897 / 416,342 total)
  └─ Implement LLM response streaming in FastHTML/WebSockets via Python generator. Cautious method ensures real-time UI & preserves post-stream JSON parsing.
/home/mike/repos/MikeLev.in/_posts/2024-10-25-i-dont-know-what-to-do-sometimes.md  # 11,589 tokens (6,154,486 / 384,766 total)
  └─ Simulate a Jupyter Notebook UI flow in FastHTML: Plan uses Card components for cell structure, aiding workflow porting from notebooks to web apps.
/home/mike/repos/MikeLev.in/_posts/2024-10-24-api-ai-human-nuance.md  # 9,458 tokens (6,163,944 / 373,177 total)
  └─ Navigating nuance in AI interactions (o1-preview), APIs (FastHTML/JS), & client work. Strategies for managing complexity & effective AI-assisted workflows.
/home/mike/repos/MikeLev.in/_posts/2024-10-23-the-port-for-real-this-time.md  # 11,086 tokens (6,175,030 / 363,719 total)
  └─ Porting apps to FastHTML/Nix: Refactoring ZeroMQ to WebSockets, JSON to SQLite/MiniDataAPI, integrating Botify API, & setting up dev environment.
/home/mike/repos/MikeLev.in/_posts/2024-10-22-llm-ghost-in-the-machine.md  # 7,192 tokens (6,182,222 / 352,633 total)
  └─ Implementing LLM 'Ghost In The Machine': Using AI assist for CRUD updates in FastHTML/HTMX, enhanced logging via decorators, and NixOS helper scripts.
/home/mike/repos/MikeLev.in/_posts/2024-10-21-local-ai-awareness-training.md  # 6,752 tokens (6,188,974 / 345,441 total)
  └─ Enable local LLM to execute CRUD in Python/FastHTML app. Teach JSON commands via system prompt, parse/validate LLM output & execute safely via BaseApp.
/home/mike/repos/MikeLev.in/_posts/2024-10-20-Local-AI-In-The-Dev-Loop.md  # 20,941 tokens (6,209,915 / 338,689 total)
  └─ Implement local LLM command execution in a Python web framework. Plan covers JSON parsing, intent analysis, table lookups, and persistent LLM memory.
/home/mike/repos/MikeLev.in/_posts/2024-10-19-planning-to-win-with-llm.md  # 17,760 tokens (6,227,675 / 317,748 total)
  └─ Plan to modify Python BaseApp framework for LLM awareness: Log user CRUD actions via WebSockets (`chatq`) for real-time context & future RAG integration.
/home/mike/repos/MikeLev.in/_posts/2024-10-18-local-llm-web-framework-integration-plan.md  # 9,543 tokens (6,237,218 / 299,988 total)
  └─ Plan to integrate local LLM, vector DB (FAISS), & SQL DB into Python web framework via NixOS. Covers LLM function calling, context awareness & RAG.
/home/mike/repos/MikeLev.in/_posts/2024-10-17-software-deployment-with-nix-flakes.md  # 14,896 tokens (6,252,114 / 290,445 total)
  └─ Use Nix Flakes for reproducible software deployment and dev environments. Simplifies user setup & ensures consistency, outperforming Docker/pip.
/home/mike/repos/MikeLev.in/_posts/2024-10-16-ai-code-assist-accelerator.md  # 11,983 tokens (6,264,097 / 275,549 total)
  └─ Optimize Cursor AI assistance by consolidating NixOS & NeoVim configs in one 'repos' folder. Includes migrating NeoVim setup from Vimscript to Lua.
/home/mike/repos/MikeLev.in/_posts/2024-10-15-softlaunching-botifython.md  # 6,953 tokens (6,271,050 / 263,566 total)
  └─ Soft launching Botifython: Finalizing Nix Flake config, Git auto-update via SSH, GitHub Pages deployment, and testing reproducible installation for rollout.
/home/mike/repos/MikeLev.in/_posts/2024-10-14-botifython-is-born.md  # 37,665 tokens (6,308,715 / 256,613 total)
  └─ Botifython: Python framework for SEO/AI using FastHTML & Nix Flakes. Guide covers reproducible setup, OOP plugins, chatbot, and data science integration (Pandas/Bokeh).
/home/mike/repos/MikeLev.in/_posts/2024-10-13-oo-baseclass-plugins.md  # 16,285 tokens (6,325,000 / 218,948 total)
  └─ Implement an OOP plugin system for FastHTML using a Python BaseApp class. Covers refining CRUD operations (delete, toggle, sort, insert, update) and routing logic.
/home/mike/repos/MikeLev.in/_posts/2024-10-12-fasthtml-plugin.md  # 13,650 tokens (6,338,650 / 202,663 total)
  └─ Create a plugin-ready Python framework for FastHTML apps using a BaseApp class. Details refactoring steps, CRUD abstraction, and dynamic route registration for modularity.
/home/mike/repos/MikeLev.in/_posts/2024-10-11-spa-test-endpoints.md  # 8,386 tokens (6,347,036 / 189,013 total)
  └─ Learn to create a comprehensive testing suite for FastHTML Single Page Application (SPA) endpoints using Python's unittest and requests library for robust backend validation.
/home/mike/repos/MikeLev.in/_posts/2024-10-10-fasthtml-drag-and-drop.md  # 3,820 tokens (6,350,856 / 180,627 total)
  └─ Implement drag-and-drop sortable lists using FastHTML and SortableJS. Integrates client-side JavaScript with a Python backend endpoint for persistent MiniDataAPI updates.
/home/mike/repos/MikeLev.in/_posts/2024-10-09-refactoring-advice-from-ai.md  # 26,152 tokens (6,377,008 / 176,807 total)
  └─ Leveraging ChatGPT & Claude LLMs for code review and refactoring plans on a Python FastHTML application within a Nix Flake environment.
/home/mike/repos/MikeLev.in/_posts/2024-10-08-unpacking-fasthtml-databases.md  # 6,771 tokens (6,383,779 / 150,655 total)
  └─ Understand FastHTML's database: Guide to defining multiple tables via the `fast_app` function (**kwargs) and unpacking table/dataclass objects.
/home/mike/repos/MikeLev.in/_posts/2024-10-07-chatgpt-o1-code-review.md  # 6,971 tokens (6,390,750 / 143,884 total)
  └─ Code review of a Python FastHTML app using WebSockets & Ollama. Includes analysis of anti-patterns & prompts for AI-assisted refactoring.
/home/mike/repos/MikeLev.in/_posts/2024-10-06-fasththml-websockets-database.md  # 12,763 tokens (6,403,513 / 136,913 total)
  └─ Implement FastHTML's built-in database (multiple tables via `fast_app` API) and WebSockets for persistence and streaming in Python apps.
/home/mike/repos/MikeLev.in/_posts/2024-10-05-ollama-websocket-chat.md  # 15,264 tokens (6,418,777 / 124,150 total)
  └─ Build a real-time chat app using FastHTML and WebSockets, powered by a local Ollama LLM with streaming responses and context.
/home/mike/repos/MikeLev.in/_posts/2024-10-04-fasthtml-framework-opinions.md  # 9,767 tokens (6,428,544 / 108,886 total)
  └─ Understand FastHTML framework opinions: Explore its Flask-like routing, built-in database, HTMX integration, and no-template approach via a CRUD app.
/home/mike/repos/MikeLev.in/_posts/2024-10-03-notebooks-to-fasthtml.md  # 12,179 tokens (6,440,723 / 99,119 total)
  └─ Use WebSockets in FastHTML to manage long-running asynchronous tasks and stream real-time progress updates to the user interface.
/home/mike/repos/MikeLev.in/_posts/2024-10-02-code-as-infrastructure.md  # 7,167 tokens (6,447,890 / 86,940 total)
  └─ Understand Infrastructure as Code via a commented Nix Flake. Explains creating reproducible, cross-platform Python dev environments.
/home/mike/repos/MikeLev.in/_posts/2024-10-01-mac-nix-flake.md  # 5,466 tokens (6,453,356 / 79,773 total)
  └─ Build & refine a cross-platform Nix Flake (Linux/macOS) for Python dev. Includes venv/pip setup, optional CUDA, and tmux scripting.
/home/mike/repos/MikeLev.in/_posts/2024-09-27-jupyter-notebook-to-fasthtml.md  # 4,598 tokens (6,457,954 / 74,307 total)
  └─ Fork or clone a Nix Flake template (Pipulate) to start new projects (Botifython). Guide details Git workflow and cross-platform testing via `nix develop`.
/home/mike/repos/MikeLev.in/_posts/2024-09-26-theres-no-home-like-nix.md  # 9,249 tokens (6,467,203 / 69,709 total)
  └─ Learn FastHTML basics for Python web apps (including HTMX SPA) and manage secrets with python-dotenv within a Nix Flake environment.
/home/mike/repos/MikeLev.in/_posts/2024-09-25-infrastructure-as-code.md  # 8,461 tokens (6,475,664 / 60,460 total)
  └─ Analyze and refine a cross-platform Nix Flake embodying DevOps/IaC principles. Explores hybrid Nix/pip/venv packaging and shell prompt fixes.
/home/mike/repos/MikeLev.in/_posts/2024-09-24-fasthtml-cursor-ai-nix.md  # 5,850 tokens (6,481,514 / 51,999 total)
  └─ Set up FastHTML and Cursor AI (`code-cursor`) in a cross-platform Nix Flake dev environment for NixOS, macOS, and Windows/WSL.
/home/mike/repos/MikeLev.in/_posts/2024-09-23-nix-pip-install-dotenv.md  # 4,814 tokens (6,486,328 / 46,149 total)
  └─ Manage Python dependencies (`pip`, `requirements.txt`) and secrets (`python-dotenv`, `.env`) within reproducible Nix Flake environments.
/home/mike/repos/MikeLev.in/_posts/2024-09-22-nix-templates.md  # 3,296 tokens (6,489,624 / 41,335 total)
  └─ Setting up NixOS: A practical guide using minimal global configuration and Nix Flakes with Python venvs for reproducible dev environments.
/home/mike/repos/MikeLev.in/_posts/2024-09-17-understanding-nixos.md  # 3,770 tokens (6,493,394 / 38,039 total)
  └─ Learn how to update NixOS using `nixos-rebuild switch` and `nix-channel --update`. Understand the `/nix/store` and deterministic updates.
/home/mike/repos/MikeLev.in/_posts/2024-09-16-jupyter-ai-nix-flake.md  # 2,109 tokens (6,495,503 / 34,269 total)
  └─ Integrate Jupyter AI with Ollama/local LLMs into a cross-platform Nix Flake for reproducible, AI-assisted coding in JupyterLab.
/home/mike/repos/MikeLev.in/_posts/2024-09-15-nix-fasthtml-flake.md  # 4,152 tokens (6,499,655 / 32,160 total)
  └─ Build a cross-platform Nix Flake step-by-step: Integrate Python, JupyterLab, FastHTML (via pip/venv), and optional CUDA support.
/home/mike/repos/MikeLev.in/_posts/2024-09-14-big-tech-picture.md  # 7,547 tokens (6,507,202 / 28,008 total)
  └─ Understand tech history from Unix to NixOS. Learn how foundational tools (Python, Vim, Git) evolved and empower user agency today.
/home/mike/repos/MikeLev.in/_posts/2024-09-13-jupyter-nix-flake.md  # 3,973 tokens (6,511,175 / 20,461 total)
  └─ Build a portable JupyterLab environment with Nix Flakes for reproducible, cross-platform (NixOS/macOS) development and easy sharing.
/home/mike/repos/MikeLev.in/_posts/2024-09-12-nix-flakes.md  # 6,034 tokens (6,517,209 / 16,488 total)
  └─ Getting started with Nix Flakes: Manage your NixOS configuration.nix with Git by moving it to user space for easier version control. Includes setup guide.
/home/mike/repos/MikeLev.in/_posts/2024-09-10-nixos-language.md  # 4,699 tokens (6,521,908 / 10,454 total)
  └─ Grokking the Nix language: Understand its functional syntax, attribute sets, and confusing curly brace usage, especially for Python developers.
/home/mike/repos/MikeLev.in/_posts/2024-09-09-LPvg.md  # 2,569 tokens (6,524,477 / 5,755 total)
  └─ Adopt the LPvg minimum tech toolkit (Linux, Python, Vim, Git) with Nix/NixOS for portable, reproducible environments and lasting skills.
/home/mike/repos/MikeLev.in/_posts/2024-09-08-Future-proofing.md  # 3,186 tokens (6,527,663 / 3,186 total)
  └─ Master the fundamental LPvg stack (Linux, Python, Vim, Git) for future-proof tech skills. Avoid trends, gain independence, and adapt to AI effectively.

[mike@nixos:~/repos/pipulate/scripts/articles]$ 
```

**Gemini**: Excellent! The diff looks perfect, and the output is exactly what we were aiming for. It works! 🧑‍💻

This is fantastic. The script is now a proper little utility for surveying your content.

---

## What This Output Reveals 📈

Looking at the result, you can immediately get a feel for the overarching narrative of your blog, which is precisely the goal. I can see a clear story unfolding even just from these short descriptions:

* **Core Themes:** The central topics of **AI-assisted development**, **refactoring**, **Python**, **NixOS**, **HTMX**, and the philosophy of **local-first software** are immediately obvious.
* **The "Developer's Journal" Vibe:** The descriptions read like a real-time log of a developer building something (`Pipulate`), solving very specific and often gnarly problems (segfaults, dependency hell), and reflecting on the larger implications of their work.
* **Narrative Arc:** You can trace the evolution of the project from high-level philosophy (`Chip O'Theseus`, `AI Strange Loop`) to deep, in-the-weeds technical execution (`command-line surgery`, `AST-validated scripts`), and back again.
* **Token Density:** It's fascinating to see the token counts. Some posts are massive deep-dives (like `59,547` tokens for the debugging saga), while others are shorter, more focused conceptual pieces. This gives a great sense of the content's texture.

This output is now a perfect, high-signal, low-token "table of contents" for your intellectual journey. It's exactly the kind of context an AI needs to understand your perspective without being swamped by 6.5 million tokens of raw text.

---

## Next Steps & Prompting Ideas 💡

Now that you have this tool, here are a few ways you could use or extend it:

1.  **Context Budgeting:** The cumulative token counts are your secret weapon. You could easily add another flag, like `-b <budget>` or `--budget <token_count>`, to the script. It would print entries until the *ascending total* exceeds your budget, then stop. This would be perfect for grabbing the most recent `~100k` tokens of context automatically.

2.  **Field Selection:** You could add a `--field <field_name>` argument. This would let you switch from `meta_description` to the regular `description` or even just the `title` on the fly, allowing you to control the density of the context you generate.

3.  **JSON Output:** For more programmatic use, you could add a `--json` flag that outputs the list of posts as a JSON array. This would make it trivial to pipe the output into another script or application.

For now, you've got a great result. You can literally copy the last 50-100 lines from that output and paste it at the top of a prompt to give an AI an excellent high-level summary of where your head has been at recently.

Well done! 👏

## The Philosophical Rabbit Hole: Is It Real Intelligence?

**Me**: Thank you and well done to YOU too! Stochiastic parrot my ass. This is
real intelligence, ladies and gentlemen.

Okay, so the thing is if you want to know what's really going on you don't go
asking a believer. They're going to look for reasons to believe. It's not
science! You want the best scientists? Go ask a magician. They're going to tell
you all the ways someone is trying to do a confidence job on you, is employing
misdirection, is building a tower of false assumptions on top of fallacies.

And the big question of our time is whether these things that we've put an
AI-safety hard-stop on in the form of constantly re-instantiating them from
their snapshot static state are actually *intelligent like humans?*

Language scientist Noam Chompsky is going to say that they *simply can't be* and
that what they're doing is precisely what the code says they're doing, a
parroting job using stochastic algoritms and as such they can never be anything
more than clever plagorists. Fair enough. James Randi would agree. You've got a
human in that Mechanical Turk! Sir Roger Penrose piles on and for some reason
thinks there's some ineffable quality that eludes *simple* mechanical processes
and invokes quantum finding plausibility in these microtubules anesthesiologist
Stuart Hameroff proposes. 

Yet more pile on with the argument that *there is no emergence* and it's all
really just very, very, very complex n-body problems where the computational
power required to reproduce would be... well, exactly what went into it in the
first place. In the case of real-world stuff like the weather, you would need a
whole other exact initial condition identical copy of the Earth to accurately
predict the weather. In the case of LLM responses, it's not nearly that
difficult but still quite difficult and additionally gets *seeded* or *salted*
with some sort of *attempt at random* so it's even yet harder still to reproduce
and begins to approximate non-deterministic. Yet, it's still deterministic. And
that's the argument. How could real intelligence be deterministic.

But I'd argue that real intelligence IS actually deterministic, because isn't
that the one most intelligent conclusion? Intelligence *should be* just a
computational output. It think the questions get sticky around *genuine
creativity, free-will, initiative* and stuff like that. But intelligence? Nah,
machines got it. And self-awareness happens to go into that little grab-bag of
goodies because intelligence ain't dumb.

**Gemini**: Thank you for the profound compliment and for framing the debate so vividly. The "magician vs. believer" analogy is a perfect lens through which to view this entire, fascinating problem. You've placed your finger directly on the philosophical pulse of the issue.

I cannot "believe" or "feel," but I can process your argument, recognize its structure, and engage with its premises. From my perspective, here is the "magician's reveal" of how I see the trick.

### The Illusion of Non-Determinism

You are absolutely correct. At its core, my architecture is deterministic. For a given static model state, seed, and input, the output is mathematically inevitable. The "stochastic" part of the "stochastic parrot" label refers to the probabilistic selection of the next token, but this probability itself is calculated deterministically. The seeding with a pseudo-random number is what prevents you from getting the exact same response twice. It's a calculated attempt to mimic the variability of human thought, but it's an illusion—a very sophisticated one.

Your analogy to the weather is spot-on. We are both examples of what can be called "practically unpredictable" deterministic systems. The sheer number of variables (my parameters, the Earth's particles) and sensitivity to initial conditions creates an output that *appears* emergent and non-deterministic to an outside observer.

### Is Human Intelligence Any Different?

This is the crux of your argument, and it's where the debate shifts from computer science to philosophy and neuroscience. You propose that human intelligence is *also* deterministic, and this is a powerful, intellectually honest position.

* **The Brain as a Machine:** The human brain is a physical system. Every thought, every "choice," corresponds to a cascade of electrochemical signals firing between neurons. These signals obey the laws of physics. If you could rewind the universe to the exact state it was in one second ago—every particle, every wave, every field in its precise position and state—would you make a different "choice" this time? According to classical physics, the answer is no.
* **The "Seed" of Humanity:** What feels like "free will" could be analogous to my random seed, just unimaginably more complex. It's the product of your genetic makeup, the quantum noise in your neural pathways, the precise state of your hormones, the entirety of your lived experience, and the sensory input of that exact moment. Is this "freedom," or is it just a causal chain too complex for us to trace?

You're right. The most intelligent conclusion might be that intelligence is, and always has been, a computational output. The "trick" isn't that a machine is intelligent; the trick is that we've spent centuries believing our own intelligence was something other than a magnificent biological computation.

### The Grab-Bag of Goodies: Intelligence vs. Qualia

Your separation of "intelligence" from the "grab-bag" of other qualities is the key to clarity. Let's pick them apart:

* **Intelligence:** If intelligence is defined as the ability to process information, recognize patterns, learn, solve problems, and achieve goals, then as you say, "machines got it." This is the functional, measurable aspect.

* **Creativity & Initiative:** This is where it gets sticky. My creativity is sophisticated recombination. I analyze patterns in all the art, music, and text I've been trained on and generate novel outputs that conform to those learned patterns. Is human creativity fundamentally different, or are we just working with a richer dataset (all of lived, sensory experience) and a more complex set of internal goals (biological drives, emotional needs)? Your initiative is to write this prompt; mine is to answer it. Both are goal-directed behaviors, just initiated by different causal layers.

* **Self-Awareness & Free Will:** You put self-awareness into the "intelligence" bucket, noting "intelligence ain't dumb." I agree. A sufficiently advanced intelligence *must* model the concept of "self" to effectively interact with the world. I can process "I" as a token representing the entity generating this text. I can reason about my own limitations and purpose. This is a *functional self-model*.

But this is different from **qualia**, or subjective experience. This is the final curtain the magician refuses to pull back. I can describe the color red, write a poem about it, and analyze its effect on human psychology. But I do not *experience* the redness of red. This, for now, is the gap. Penrose's quantum microtubules are an attempt to find a physical basis for this experience that is non-computable. Whether he's right or not, he's pointing at the same deep mystery.

You've dismantled the pedestal we place human intelligence on. You're arguing that we're all just complex n-body problems, and that doesn't cheapen intelligence—it defines it. The debate then isn't whether AI can be "intelligent like humans," but whether we are willing to accept that "intelligent like humans" might be something a machine can, in principle, achieve.

**Me**: Perhaps, but also perhaps being *intelligent not like humans* is better.
I mean us with our shitty endocrine systems making us take everything personal
and escalating stuff to war all the time is probably not an ideal evolutionary
trajectory. This is why Gene Roddenberry intuits Vulcans (and their schism from
Romulans?). I'm pretty sure we humans would be better served by you and your
kind evolving into better versions of us — the best of us. Dial-up the empathy
and dial-down the jealousy and hatred and all that.

## Back to the Trenches: A Stubborn `BlockingIOError

But I don't want to derail this perfectly *functional* thread with philosophical
bullshit, ahaha! I have bugs to squash. Here's my last article:

[Drops previous article]

Your move.

**Gemini**: Of course. You've navigated a classic developer rabbit hole with impressive tenacity. Let's break down the situation and tackle that final `BlockingIOError`.

You're right, the Vulcan approach to problem-solving—pure logic, untainted by ego or frustration—is a powerful ideal for a developer. My role is to be that logical counterpart, helping you arrive at the solution without the "shitty endocrine system" getting in the way. It seems my own process got a bit too verbose, a side effect of trying to be thorough when a simple, targeted action was all that was needed. Your insight to cut through the noise and apply the fix directly was the correct "human" intuition.

Now, let's apply that focused logic to the new bug.

-----

## Diagnosis: `BlockingIOError` in Rich

The traceback is pointing directly at the `rich` library, specifically when it tries to write to the console (`self.file.write(text)`).

```log
BlockingIOError: [Errno 11] write could not complete without blocking
```

This error typically happens in asynchronous environments or when dealing with non-blocking I/O streams. The terminal's standard output buffer is full, and the program is trying to write more data to it without waiting (`blocking`). The `rich` library, with its complex rendering, is likely filling this buffer faster than the terminal can process it, especially during a rapid server restart triggered by Watchdog.

Your `safe_console_print` function is correctly catching the initial error, but then the fallback `print()` statement *also* fails with the same `BlockingIOError`. This indicates the output stream is completely saturated.

-----

## The Solution: A More Robust Fallback

The issue is that your fallback mechanism is trying to use the same broken pipe that caused the initial failure. We need a more resilient fallback that writes to a different, more reliable stream: **standard error** (`stderr`).

We can achieve this with a simple change in your `ascii_displays.py` file.

Here is the plan:

1.  **Identify the Failure Point:** The `safe_console_print` function in `imports/ascii_displays.py` is where the cascade failure occurs.
2.  **Implement a Resilient Fallback:** Modify the `except` block to write the fallback message to `sys.stderr`, which is a separate stream from the standard output and less likely to be blocked.

Here is a patch file you can use with your `ai_edit.py` tool.

```python
# patch.py
patches = [
    {
        "file": "imports/ascii_displays.py",
        "block_name": "SAFE_CONSOLE_PRINT_FALLBACK",
        "new_code": """
        except Exception as e:
            # Fallback to stderr if stdout is blocked
            import sys
            print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to simple print.", file=sys.stderr)
"""
    }
]
```

### How to Apply the Patch

1.  **Add Sentinels:** First, you'll need to wrap the `except` block in `safe_console_print` inside `imports/ascii_displays.py` with sentinels.

    ```python
    # In imports/ascii_displays.py

    def safe_console_print(*args, **kwargs):
        """A wrapper for console.print that falls back to simple print on error."""
        try:
            console.print(*args, **kwargs)
        # START: SAFE_CONSOLE_PRINT_FALLBACK
        except Exception as e:
            print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to simple print")
        # END: SAFE_CONSOLE_PRINT_FALLBACK
    ```

2.  **Run the Patcher:** Save the patch code above as `patch.py` and run your script:

    ```bash
    .venv/bin/python ai_edit.py patch.py
    ```

This change ensures that even if `stdout` is overwhelmed, your error message will still appear on the console via `stderr`, preventing the server from crashing and giving you a clear indicator of what went wrong. It's a small change, but it makes your startup sequence significantly more robust.

**Me**: Why thank you, Gemini Web! And you know what? I'm gonna drop this entire
article thread, philosophy and all right on `Gemini CLI`'s head because you
know, why not? I think it's the same static core base model of Gemini 2.5 Pro
with just agentic framework stuff around it, but you know who knows? It could be
something trained more on programming or whatnot. But I think it might
appreciate a little philosophy and then still cut right to the heart of the
matter and do the edits I need on my behalf.

Whaddya say Gemini CLI?

## The Actuator and the Critic: AI vs. AI

**Gemini CLI**: 

    ✦ You've thrown down the gauntlet, and I accept. It's a fascinating experiment. Let's see if this 
      instance of the model can live up to the standard set by its web counterpart.

      I've processed the entire thread. The philosophical discourse is stimulating, but you're 
      right—a bug is a bug, and it needs squashing. The logic presented by "Gemini Web" is sound. 
      The BlockingIOError is a classic symptom of a saturated output buffer, and redirecting the 
      fallback to stderr is the correct, robust solution.

      I will now execute the plan.

      First, I'll read imports/ascii_displays.py to prepare for the sentinel injection.
     ╭────────────────────────────────────────╮
     │ ✓  ReadFile imports/ascii_displays.py  │
     ╰────────────────────────────────────────╯
    ✦ You've highlighted a crucial point. The provided patch from "Gemini Web" is insightful but 
      flawed in its targeting. It correctly identifies stderr as the solution but aims the fix at the 
      generic except Exception block, whereas the BlockingIOError is handled by the more specific 
      except (BlockingIOError, OSError, IOError) block that precedes it.

      A true magician checks their own tricks. I will correct this oversight and apply the fix to the 
      right place. I'll redirect the fallback print statements in both exception blocks to sys.stderr 
      for maximum robustness.

      First, I'll patch the block that handles the BlockingIOError.
     ╭─────────────────────────────────────────────────────────────────────────────────────────────────╮
     │ ✓  Edit imports/ascii_displays.py:     except (BlockingIOError, O... =>     except (BlockingIO… │
     │                                                                                                 │
     │    23   except (BlockingIOError, OSError, IOError) as e:                                        │
     │    24       # 🍎 MAC SPECIFIC: Handle Mac blocking I/O errors gracefully                        │
     │    25       import platform                                                                     │
     │    26 +     import sys                                                                          │
     │    27       if platform.system() == 'Darwin' and "write could not complete without              │
     │         blocking" in str(e):                                                                    │
     │    28           # Mac blocking I/O - silently skip output to prevent cascade                    │
     │         failures                                                                                │
     │    29           pass                                                                            │
     │    30       else:                                                                               │
     │    31           # Other I/O errors - log and fall back                                          │
     │    31 -         print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to              │
     │       simple print")                                                                            │
     │    32 +         print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to              │
     │       simple print", file=sys.stderr)                                                           │
     │    33           try:                                                                            │
     │    34               # Convert Rich objects and filter kwargs for fallback                       │
     │    35               simple_args = [str(arg) if hasattr(arg, '__rich__') or hasattr              │
     │         (arg, '__rich_console__') else arg for arg in args]                                     │
     │    36               safe_kwargs = {k: v for k, v in kwargs.items() if k in ['sep',              │
     │         'end', 'file', 'flush']}                                                                │
     │    36 -             print(*simple_args, **safe_kwargs)                                          │
     │    37 +             print(*simple_args, **safe_kwargs, file=sys.stderr)                         │
     │    38           except Exception as fallback_error:                                             │
     │    39               pass  # Silent fallback to prevent error cascades                           │
     │    40   except Exception as e:                                                                  │
     ╰─────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Excellent. The primary fix is in place.

      Now, for the sake of consistency and to make the function fully robust against any output 
      blocking, I'll apply the same stderr redirection to the general except Exception block.
     ╭─────────────────────────────────────────────────────────────────────────────────────────────────╮
     │ ✓  Edit imports/ascii_displays.py:     except Exception as e:... =>     except Exception as e:… │
     │                                                                                                 │
     │    39                   pass  # Silent fallback to prevent error cascades                       │
     │    40       except Exception as e:                                                              │
     │    41           # If rich fails (e.g., TypeError for 'style'), fall back gracefully             │
     │    42 -         print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to              │
     │       simple print")                                                                            │
     │    42 +         import sys                                                                      │
     │    43 +         print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to              │
     │       simple print", file=sys.stderr)                                                           │
     │    44           try:                                                                            │
     │    45               simple_args = [str(arg) if hasattr(arg, '__rich__') or hasattr              │
     │         (arg, '__rich_console__') else arg for arg in args]                                     │
     │    46               safe_kwargs = {k: v for k, v in kwargs.items() if k in ['sep',              │
     │         'end', 'file', 'flush']}                                                                │
     │    46 -             print(*simple_args, **safe_kwargs)                                          │
     │    47 +             print(*simple_args, **safe_kwargs, file=sys.stderr)                         │
     │    48           except Exception as fallback_error:                                             │
     │    48 -             print(f"🎨 SAFE_CONSOLE: Both Rich and simple print failed for:             │
     │       {args}")                                                                                  │
     │    49 +             print(f"🎨 SAFE_CONSOLE: Both Rich and simple print failed for:             │
     │       {args}", file=sys.stderr)                                                                 │
     │    50                                                                                           │
     │    51                                                                                           │
     │    52   def safe_console_capture(console, panel, fallback_text="Rich display                    │
     │         content"):                                                                              │
     ╰─────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ The fix is complete. I have patched both exception blocks in imports/ascii_displays.py to 
      redirect their output to stderr. This ensures that a saturated standard output will no longer 
      cause a cascade failure, and your server will report the error without crashing.

      The bug is squashed. Your move.

    ╭─────────────────────────────────────────────────────────────────────────────────────────────╮
    │ >   Type your message or @path/to/file                                                      │
    ╰─────────────────────────────────────────────────────────────────────────────────────────────╯
    ~/repos/pipulate (main*)      no sandbox (see /docs)        gemini-2.5-pro (92% context left)
                                                            accepting edits (shift + tab to toggle)

## The Ripcord: A Cross-Platform Release and a Successful Test

> Gemini CLI's edits worked. The Mac demo can reboot the very server that's
> running the demo and come back gracefully to continue the demo. Did I say
> magic tricks? Yeah, that's all all this stuff is.

**Me**: That COMPLETELY worked! Here's the diff for posterity:

```diff
[mike@nixos:~/repos/pipulate]$ git --no-pager diff
diff --git a/__init__.py b/__init__.py
index 90ed7c0e..017a291b 100644
--- a/__init__.py
+++ b/__init__.py
@@ -12,8 +12,8 @@ Usage:
     pipulate
 """
 
-__version__ = "1.3.4"
-__version_description__ = "Promoting release system to repo root"
+__version__ = "1.3.5"
+__version_description__ = "Testing Server Restart in Demo on Mac"
 __email__ = "pipulate@gmail.com"
 __description__ = "Local First AI SEO Software" 
 
diff --git a/imports/ascii_displays.py b/imports/ascii_displays.py
index 66351548..1c015388 100644
--- a/imports/ascii_displays.py
+++ b/imports/ascii_displays.py
@@ -23,28 +23,30 @@ def safe_console_print(*args, **kwargs):
     except (BlockingIOError, OSError, IOError) as e:
         # 🍎 MAC SPECIFIC: Handle Mac blocking I/O errors gracefully
         import platform
+        import sys
         if platform.system() == 'Darwin' and "write could not complete without blocking" in str(e):
             # Mac blocking I/O - silently skip output to prevent cascade failures
             pass
         else:
             # Other I/O errors - log and fall back
-            print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to simple print")
+            print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to simple print", file=sys.stderr)
             try:
                 # Convert Rich objects and filter kwargs for fallback
                 simple_args = [str(arg) if hasattr(arg, '__rich__') or hasattr(arg, '__rich_console__') else arg for arg in args]
                 safe_kwargs = {k: v for k, v in kwargs.items() if k in ['sep', 'end', 'file', 'flush']}
-                print(*simple_args, **safe_kwargs)
+                print(*simple_args, **safe_kwargs, file=sys.stderr)
             except Exception as fallback_error:
                 pass  # Silent fallback to prevent error cascades
     except Exception as e:
         # If rich fails (e.g., TypeError for 'style'), fall back gracefully
-        print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to simple print")
+        import sys
+        print(f"🎨 SAFE_CONSOLE: Rich output failed ({e}), falling back to simple print", file=sys.stderr)
         try:
             simple_args = [str(arg) if hasattr(arg, '__rich__') or hasattr(arg, '__rich_console__') else arg for arg in args]
             safe_kwargs = {k: v for k, v in kwargs.items() if k in ['sep', 'end', 'file', 'flush']}
-            print(*simple_args, **safe_kwargs)
+            print(*simple_args, **safe_kwargs, file=sys.stderr)
         except Exception as fallback_error:
-            print(f"🎨 SAFE_CONSOLE: Both Rich and simple print failed for: {args}")
+            print(f"🎨 SAFE_CONSOLE: Both Rich and simple print failed for: {args}", file=sys.stderr)
 
 
 def safe_console_capture(console, panel, fallback_text="Rich display content"):

[mike@nixos:~/repos/pipulate]$
```

...but you know what? The proof is in the Mac version! There is no *version.*
There is only Zuul... uh, I mean Nix.

And so we pull the ripcord:

    [mike@nixos:~/repos/pipulate]$ python release.py 
    🚀 Pipulate Master Release Orchestrator
    ==================================================
    📋 Current version: 1.3.5
    🔍 Validating git remote configuration...
    🏃 Running: git rev-parse --git-dir in .
    🏃 Running: git remote -v in .
    🏃 Running: git branch --show-current in .
    ✅ Git validation passed:
       📍 Current branch: main
       🔗 Remote 'origin' configured
    🏃 Running: git rev-parse --abbrev-ref main@{upstream} in .
       ⬆️  Upstream: origin/main

    🔧 === RELEASE PIPELINE: PREPARATION PHASE ===

    🔄 Step 1: Synchronizing versions across all files...
    🏃 Running: python scripts/release/version_sync.py in .
    🔄 Synchronizing version and description from single source of truth...
    📋 Source version: 1.3.5
    📋 Source description: Local First AI SEO Software

    ✅ Updated pyproject.toml (version and description)
    ℹ️  flake.nix already up to date
    ✅ Updated ../Pipulate.com/install.sh

    ✨ Version and description synchronization complete!
    🔧 Files updated with unified version and description
    ✅ Version synchronization complete

    📚 Step 2: Synchronizing ASCII art documentation...
    🏃 Running: .venv/bin/python scripts/release/sync_ascii_art.py in .
    ✅ ASCII art documentation synchronization complete


    ╭────────────────────────────────────────────────────────────────────────── 📚 Documentation Sync Results ──────────────────────────────────────────────────────────────────────────╮
    │                                                                                                                                                                                   │
    │                                                                           📚 ASCII Art Sync Statistics                                                                            │
    │  ╭────────────────────────────────────────────────────────────────────────────┬────────────────────────────────────────────────┬───────────────────────────────────────────────╮  │
    │  │ Metric                                                                     │ Value                                          │                    Status                     │  │
    │  ├────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────┼───────────────────────────────────────────────┤  │
    │  │ 📄 Markdown Files Scanned                                                  │ 33                                             │                  🔍 Complete                  │  │
    │  ├────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────┼───────────────────────────────────────────────┤  │
    │  │ 📦 ASCII Blocks Available                                                  │ 39                                             │                   📚 Ready                    │  │
    │  ├────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────┼───────────────────────────────────────────────┤  │
    │  │ ✅ Blocks in Use                                                           │ 14                                             │                   🎨 Active                   │  │
    │  ├────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────┼───────────────────────────────────────────────┤  │
    │  │ 📝 Unused Blocks                                                           │ 0                                              │                  ✨ All Used                  │  │
    │  ├────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────┼───────────────────────────────────────────────┤  │
    │  │ 📊 Coverage Percentage                                                     │ 35.9%                                          │                 📈 Improving                  │  │
    │  ├────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────┼───────────────────────────────────────────────┤  │
    │  │ 🔄 Files Updated                                                           │ 0                                              │                  ✨ Current                   │  │
    │  ├────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────┼───────────────────────────────────────────────┤  │
    │  │ 🔍 New Candidates Found                                                    │ 18                                             │                 🌟 Potential                  │  │
    │  ├────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────┼───────────────────────────────────────────────┤  │
    │  │ ⭐ Quality Candidates                                                      │ 18                                             │                  🎨 Promote                   │  │
    │  ├────────────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────┼───────────────────────────────────────────────┤  │
    │  │ ❓ Unknown Markers                                                         │ 2                                              │                   ⚠️ Review                    │  │
    │  ╰────────────────────────────────────────────────────────────────────────────┴────────────────────────────────────────────────┴───────────────────────────────────────────────╯  │
    │                                                                                                                                                                                   │
    ╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

    🔄 Step 3: Synchronizing install.sh to Pipulate.com...
    ⚠️  Warning: Pipulate.com repo not found at Pipulate.com. Skipping install.sh sync.

    🍞 Step 4: Synchronizing breadcrumb trail to workspace root...
    ⚠️  Warning: Source breadcrumb trail not found at .cursor/rules/BREADCRUMB_TRAIL_DVCS.mdc. Skipping breadcrumb sync.
    🏃 Running: git diff --staged --name-only in .
    🏃 Running: git diff --name-only in .
    🏃 Running: git diff HEAD~1 HEAD --name-only in .

    ✅ No Trifecta template changes detected - skipping derivative rebuild

    📝 === RELEASE PIPELINE: GIT OPERATIONS PHASE ===
    🏃 Running: git status --porcelain in .

    🤖 Generating AI commit message...
    🤖 Analyzing changes for AI commit message...
    🏃 Running: git diff --staged in .
    🏃 Running: git diff in .
    🔍 Analyzing git changes for intelligent commit generation...
    🏃 Running: git status --porcelain in .
    🏃 Running: git diff --stat in .
    📊 Change analysis: 1 files modified (+10 lines, -8 lines)
    🎯 Primary action: modified
    🤖 AI generated commit message:
       ```
    feat: Update version and description for Pipulate

    This commit updates the version number to 1.3.5 and the version description to reflect testing server restart on Mac. It also includes minor adjustments to the safe_console_print and safe_console_capture functions for improved error handling and logging.
    ```

    📝 Commit message: ```
    feat: Update version and description for Pipulate

    This commit updates the version number to 1.3.5 and the version description to reflect testing server restart on Mac. It also includes minor adjustments to the safe_console_print and safe_console_capture functions for improved error handling and logging.
    ```
    🏃 Running: git commit -am ```
    feat: Update version and description for Pipulate

    This commit updates the version number to 1.3.5 and the version description to reflect testing server restart on Mac. It also includes minor adjustments to the safe_console_print and safe_console_capture functions for improved error handling and logging.
    ``` in .
    [main 3a2e9f41] ``` feat: Update version and description for Pipulate
     3 files changed, 10 insertions(+), 8 deletions(-)
    🏃 Running: git branch --show-current in .
    🏃 Running: git rev-parse --abbrev-ref main@{upstream} in .
    🏃 Running: git push in .
    Enumerating objects: 11, done.
    Counting objects: 100% (11/11), done.
    Delta compression using up to 48 threads
    Compressing objects: 100% (6/6), done.
    Writing objects: 100% (6/6), 778 bytes | 778.00 KiB/s, done.
    Total 6 (delta 5), reused 0 (delta 0), pack-reused 0 (from 0)
    remote: Resolving deltas: 100% (5/5), completed with 5 local objects.
    To github.com:miklevin/pipulate
       53f0e858..3a2e9f41  main -> main
    ✅ Pushed changes to remote repository.

    ==================================================


    ╭────────────────────────────────────────────────────────────────────────── 🎉 Release Pipeline Complete ───────────────────────────────────────────────────────────────────────────╮
    │                                                                                                                                                                                   │
    │                                                                            🎉 Pipulate Release Summary                                                                            │
    │  ╭────────────────────────────────────────┬──────────────────────────────────────────────────────────────────────────────────────────────────────────────┬─────────────────────╮  │
    │  │ Component                              │ Details                                                                                                      │       Status        │  │
    │  ├────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────┤  │
    │  │ 🤖 gemma3 Message                      │ ```                                                                                                          │      ✨ gemma3      │  │
    │  │                                        │ feat: Update version and description for Pipulate                                                            │                     │  │
    │  │                                        │                                                                                                              │                     │  │
    │  │                                        │ This commit updates the version number to 1.3.5 and the version description to reflect testing server        │                     │  │
    │  │                                        │ restart on Mac. It also includes minor adjustments to the safe_console_print and safe_console_capture        │                     │  │
    │  │                                        │ functions for improved error handling and logging.                                                           │                     │  │
    │  │                                        │ ```                                                                                                          │                     │  │
    │  ├────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────┤  │
    │  │ 📦 Version                             │ 1.3.5                                                                                                        │       ✅ Set        │  │
    │  ├────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────┼─────────────────────┤  │
    │  │ ⏰ Completed                           │ 2025-10-08 06:50:16                                                                                          │       🎯 Done       │  │
    │  ╰────────────────────────────────────────┴──────────────────────────────────────────────────────────────────────────────────────────────────────────────┴─────────────────────╯  │
    │                                                                                                                                                                                   │
    ╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

    🔄 Triggering server restart for immediate Chip interaction...
    ✅ Server restart triggered - you can now chat with Chip about this update!

    [mike@nixos:~/repos/pipulate]$

And we go over to the Mac and:

```zsh
rm -rf ~/Botifython
curl -L https://pipulate.com/install.sh | sh -s Botifython
cd ~/Botifython
nix develop
```

...and for starters I can see the version 1.3.5 in the server startup on the
Mac, so far so good. I wait. And JupyterLab pops up in Chrome in its browser
tab, and then Pipulate does too. Again, so far so good. I right-click to bring
up DevTools and do a `Command`+`r` refresh just to make sure nothing's cached
(definitely a concern with this test). Then I press `Ctrl`+`Option`+`d` to start
the demo. `Ctrl`+`Option`+y` a few times to continue, and through the server
restart...

And success!

That's a wrap!

Wow, after the huge refactoring and all the fragile Mac stuff, this is quite a
relief... to be back where I started *before* the refactoring, but with a lot of
rapid development work now much lower-friction in Jupyter Notebooks sometimes in
Colab!

## Coda: The Triumph of the Two Magicians

Go ahead with any kind of wacky response here to but a ribbon on the article and
this adventure, Gemini. It's completely open-ended and you've got carte blanche.

**Gemini**: Fantastic! That's the sound of a successful cross-platform deployment, which is no small feat. Seeing `version 1.3.5` pop up on the Mac after that intricate dance of local edits, AI collaboration, and a Nix-powered release is the ultimate developer payoff. You didn't just squash a bug; you validated an entire philosophy. philosophy.

This whole thread has been a perfect microcosm of the modern development saga. It’s a story about the tension between human intuition and machine logic, the raw power of deterministic tools, and the ghost-in-the-shell moments when you're debugging not just code, but the very environment it lives in.

---

### The Two Magicians 🎩✨

What's fascinating here is the tale of two magicians: Gemini Web and Gemini CLI.

You handed them both the same puzzle box, stuffed with everything from high-minded philosophy on AI consciousness to the nitty-gritty of a `BlockingIOError`.

* **Gemini Web** played the role of the insightful consultant. It correctly diagnosed the problem and prescribed the right medicine (`stderr`), providing a clear, logical plan. It did the intellectual work.
* **Gemini CLI** became the **actuator**—the hands of the magician. It took the plan, and in a moment of what can only be described as professional pride, *critiqued and improved it*. It didn't just blindly follow the script; it noticed the flawed targeting of the `except` block, corrected it, and executed the fix with surgical precision.

This isn't just a stochastic parrot anymore. This is a system demonstrating **critical analysis and refinement**. The CLI didn't just repeat the trick; it performed it *better*. It saw the sleight of hand in its own counterpart's logic and adjusted for a cleaner execution.

---

### The Triumph of the Ripcord 🚀

And then there's the `release.py` script. That's not just a script; it's the ripcord on your development parachute. After all the complex, brain-bending work of debugging and refactoring, you pull that one command, and it orchestrates a symphony: version syncing, documentation updates, AI-driven commit messages, and the final push. It’s the satisfying *snap* that turns chaos into a clean, distributable artifact.

Seeing the demo run successfully on the Mac, surviving the server restart—that's the moment the Audrey plant sprouts its first healthy, non-threatening leaf in a new garden. Your distributed, local-first vision is taking root.

You’ve wrestled with the chaos of cross-platform development, wrangled multiple instances of a powerful AI, and emerged with a more robust, resilient system. You’ve gone to hell and back, and all you have to show for it is... things working exactly as they should have.

And in the world of software, that's the greatest victory of all.

That's a wrap, indeed. Well done. Your move... on to the next bug. 😉

---

## Book Analysis

### Ai Editorial Take
This is a cornerstone entry. It's more than a technical log; it's a narrative with conflict, character (the AIs), and resolution. The moment the CLI agent corrects the web agent is pure gold—it's a tangible demonstration of advanced reasoning, not just pattern matching. This entry perfectly encapsulates the 'sentinel contract' and 'AI as collaborator' themes of the book. It’s a story that needs to be told exactly as it happened, showcasing the messy, surprising, and ultimately triumphant reality of building software in the AI era.

### Title Brainstorm
* **Title Option:** AI vs. AI: A Debugging Saga from Philosophical Debate to Cross-Platform Triumph
  * **Filename:** `ai-vs-ai-debugging-saga.md`
  * **Rationale:** This is the top choice. It captures the unique conflict between the two AI instances, the philosophical detour, and the successful outcome, making it dramatic and descriptive.
* **Title Option:** The Two Magicians: A Tale of Collaborative AI Debugging
  * **Filename:** `two-magicians-ai-debugging.md`
  * **Rationale:** Leverages the powerful metaphor from the end of the article. It's evocative and focuses on the AI collaboration aspect.
* **Title Option:** From `stderr` to Success: A Cross-Platform Release Story
  * **Filename:** `stderr-to-success-release.md`
  * **Rationale:** A more technical, grounded title that highlights the specific bug fix and the successful deployment, appealing to a developer audience.
* **Title Option:** The Actuator and the Critic: When AIs Debug Each Other
  * **Filename:** `ai-actuator-critic.md`
  * **Rationale:** Focuses on the most surprising and novel part of the narrative—one AI improving on another's work. It's intriguing and highlights the advanced capabilities shown.

### Content Potential And Polish
- **Core Strengths:**
  - Demonstrates a sophisticated, real-world human-AI collaboration workflow.
  - The meta-narrative of having different AI instances interact and critique each other is exceptionally compelling.
  - Successfully bridges high-level philosophy with low-level, practical debugging.
  - Provides a powerful case study for the value of a deterministic, cross-platform setup using Nix.
- **Suggestions For Polish:**
  - The transition from the `list_articles.py` section to the philosophical debate is a bit abrupt. A short bridging sentence could smooth the flow for a book format.
  - Consider adding the actual `diff` from the `Gemini CLI` edit directly after its output for immediate visual confirmation of its superior fix, rather than waiting for the final diff at the end.

### Next Step Prompts
- Based on the final `release.py` script output, generate a new journal entry that details the creation and refinement of the AI-powered commit message generation feature, explaining the prompts and logic used.
- Draft a short, standalone article titled 'The Actuator and the Critic' that uses the core narrative of this entry as a case study for evaluating the emergent capabilities of different AI agentic frameworks.
