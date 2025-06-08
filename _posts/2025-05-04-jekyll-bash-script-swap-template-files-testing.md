---
title: How I Created a Bash Script to Swap Jekyll Template Files for Testing
permalink: /futureproof/jekyll-bash-script-swap-template-files-testing/
description: I ran into a half-expected drop in my Jekyll blog's Google Search traffic and initially suspected my recent template updates. This post details my process of creating parallel template files (`-new`, `-old`) and then building a Bash script (`swap-templates.sh`) to easily toggle between these versions for testing, including figuring out the correct file paths and where to safely store the script (`_scripts/`) in a Jekyll project, even though the templates ultimately weren't the root cause of the traffic issue.
meta_description: Detailed guide on creating a Bash script to toggle Jekyll template files (_layouts, CSS, index.md) using mv commands for debugging website issues like traffic drops. Includes final script and discussion on safe placement in _scripts/.
meta_keywords: Jekyll, bash, script, toggle, swap, files, template, layout, css, index.md, mv, rename, debug, debugging, traffic drop, Google Search Console, _scripts, relative path, command line, shell script, automation, website, blog, troubleshooting, utility, _config.yml, exclude, Battle Duck Data, mv command
layout: post
sort_order: 2
---

## Understanding Jekyll Site Debugging

This article delves into the practical process of troubleshooting a common but stressful problem for website owners: a sudden drop in search engine traffic. The author uses a popular tool called Jekyll, a "static site generator," which takes templates and content files to build a complete website made of simple HTML, CSS, and JavaScript files. When their Jekyll site's traffic unexpectedly plummeted, the author suspected recent changes to the site's template files (`.html`, `.css`) might be the cause.

The core of the article documents the author's methodical approach to testing this hypothesis. This involved creating duplicate versions of template files and developing a command-line script (using Bash, a common scripting language for Linux/macOS) to easily switch between the "old" and "new" versions. This allows for controlled testing to see if the templates were indeed the issue, while also showcasing a useful technique for managing different versions of site components during development or debugging. The narrative captures the real-world, sometimes messy, process of technical problem-solving.

---

## A Jekyll Puzzle: Debugging a Mysterious Traffic Drop with Template Toggling and "Battle Duck" Debugging

It's a familiar feeling for anyone running a website: that stomach-dropping moment when you check your analytics and see a nosedive. In my case, Google Search Console delivered the grim news – traffic to my Jekyll-powered blog had inexplicably tanked. This wasn't a gradual decline; it was a cliff edge.

Panic sets in. What changed? The most immediate suspect was recent template work I'd done. Had I inadvertently introduced some SEO-unfriendly code? Broken schema? Offended the Google gods with semantic impurity?

### The Context: A Rapidly Growing Blog

My blog documents my development process, often involving explorations with AI tools – not as a spam engine, mind you, but as a genuine chronicle of using AI in coding, debugging, and learning. It had been growing steadily, recently crossing the 250-article threshold, up from around 200 in a relatively short burst. A key feature (or perhaps, culprit?) is the homepage: a single, monolithic index listing *every single article*. Could this rapid expansion and massive index page be the issue?

### Hypothesis #1: Blame the Templates! (The First Wrong Turn)

Ignoring the potential scale issues for a moment, my developer instincts screamed "recent changes first!" I decided the most immediate action was to isolate the template changes. To do this systematically, I needed a way to quickly revert *and* re-apply the newer templates.

This led to the creation of parallel file sets for the core templates and styles I'd modified:

1.  **Layouts:**
    * `_layouts/default.html` (The active file)
    * `_layouts/default-new.html` (The newer version I suspected)
    * `_layouts/default-old.html` (Where the previously active version would be saved)
    * *(Repeated for `_layouts/post.html`)*
2.  **Styles:**
    * `assets/css/styles.css` (Active)
    * `assets/css/styles-new.css` (Newer)
    * `assets/css/styles-old.css` (Backup)
3.  **Homepage Content:**
    * `index.md` (Active)
    * `index-new.md` (Newer)
    * `index-old.md` (Backup)

The idea was simple: rename the active file to `-old`, then rename the `-new` file to become the active one. To revert, rename the active file back to `-new`, and rename the `-old` file back to active.

### Manual Swapping: The Command-Line Shuffle

Doing this manually required pairs of `mv` (move/rename) commands, chained with `&&` to ensure the second command only runs if the first succeeds. For each pair, the command to activate the "new" version looked like this (using `index.md` as the example, which resides in the project root):

```bash
# Activate the 'new' version of index.md
mv index.md index-old.md && mv index-new.md index.md
```

And similarly for the others, adjusting paths as needed:

```bash
# Activate new default layout
mv _layouts/default.html _layouts/default-old.html && mv _layouts/default-new.html _layouts/default.html

# Activate new post layout
mv _layouts/post.html _layouts/post-old.html && mv _layouts/post-new.html _layouts/post.html

# Activate new styles
mv assets/css/styles.css assets/css/styles-old.css && mv assets/css/styles-new.css assets/css/styles.css
```

I swapped back to the presumed "old" (stable) templates using the reverse logic (e.g., `mv index.md index-new.md && mv index-old.md index.md`). I waited. The traffic did not recover. Hypothesis #1 was likely wrong.

### Hypothesis #2: Scale, Links, and Growth Rate

With the templates seemingly exonerated, suspicion fell on the other factors:
* The sheer number of links on the homepage index (>250).
* The rapid rate of adding new content.
* Potentially some interaction between these and how Google crawls/indexes large, rapidly changing sites.

Addressing these requires more involved changes (pagination, smarter indexing strategies), which take time away from other priorities. However, I still needed the *ability* to toggle the templates easily for future testing or if I changed my mind again. Doing the four pairs of `mv` commands manually was tedious and error-prone. Automation was needed.

### Enter the Toggle Script: `swap-templates.sh`

The goal: a single script that, when run, would detect the current state (original or new templates active) and automatically perform all the necessary swaps to switch to the *other* state.

**The Logic:** The script determines the state by checking for the existence of one of the `-old` files. If `_layouts/default-old.html` exists, it means the "new" set is currently active, and the script should swap back to the original. If it *doesn't* exist, the original set is active, and the script should swap to the new set.

**The Script:** After some iteration (and correcting paths when deciding where the script should live!), here is the final version, designed to be placed in a `_scripts` directory:

```bash
#!/bin/bash

# SCRIPT LOCATION: _scripts/swap-templates.sh
# BASE PROJECT DIR: ../ (relative to this script)

# --- Configuration ---
# Directories relative to the script's location (_scripts)
# We need to go one level up to find these folders/files
BASE_DIR=".."
LAYOUTS_DIR="$BASE_DIR/_layouts" # Now ../_layouts
CSS_DIR="$BASE_DIR/assets/css"   # Now ../assets/css

# File paths (now constructed relative to ../)
DEFAULT_HTML="$LAYOUTS_DIR/default.html" # ../_layouts/default.html
DEFAULT_NEW="$LAYOUTS_DIR/default-new.html"
DEFAULT_OLD="$LAYOUTS_DIR/default-old.html"

POST_HTML="$LAYOUTS_DIR/post.html" # ../_layouts/post.html
POST_NEW="$LAYOUTS_DIR/post-new.html"
POST_OLD="$LAYOUTS_DIR/post-old.html"

STYLES_CSS="$CSS_DIR/styles.css" # ../assets/css/styles.css
STYLES_NEW="$CSS_DIR/styles-new.css"
STYLES_OLD="$CSS_DIR/styles-old.css"

# Index Markdown file in the base directory (../)
INDEX_MD="$BASE_DIR/index.md" # ../index.md
INDEX_NEW="$BASE_DIR/index-new.md" # ../index-new.md
INDEX_OLD="$BASE_DIR/index-old.md" # ../index-old.md


# --- Helper Function for Swapping ---
# Usage: swap_files "description" "current" "new" "old"
swap_files() {
  local description="$1"
  local current_file="$2"
  local new_file="$3"
  local old_file="$4"
  local error_occurred=0

  echo "Attempting to swap $description files..."

  # Check if we are swapping TO the 'new' state (current -> old, new -> current)
  # This state is identified by the ABSENCE of the 'old' file
  if [ ! -f "$old_file" ]; then
    # Check if the required source files exist at their expected locations
    if [ -f "$current_file" ] && [ -f "$new_file" ]; then
      echo "  - Moving '$current_file' to '$old_file'"
      mv "$current_file" "$old_file"
      if [ $? -ne 0 ]; then echo "  ERROR: Failed to move '$current_file' to '$old_file'."; error_occurred=1; fi

      if [ $error_occurred -eq 0 ]; then
         echo "  - Moving '$new_file' to '$current_file'"
         mv "$new_file" "$current_file"
         if [ $? -ne 0 ]; then echo "  ERROR: Failed to move '$new_file' to '$current_file'."; error_occurred=1; fi
      fi

      if [ $error_occurred -eq 0 ]; then
         echo "  SUCCESS: $description swapped to NEW version."
      else
         echo "  ERROR: $description swap TO NEW failed. Files might be in an inconsistent state!"
      fi
    else
      # Added more specific error message about *which* files might be missing
      echo "  ERROR: Cannot swap $description to new. Missing source files ('$current_file' or '$new_file')."
      error_occurred=1
    fi
  # Check if we are swapping BACK FROM the 'new' state (current -> new, old -> current)
  # This state is identified by the PRESENCE of the 'old' file
  elif [ -f "$old_file" ]; then
     # Check if the required source files exist at their expected locations
     if [ -f "$current_file" ] && [ -f "$old_file" ]; then
        echo "  - Moving '$current_file' to '$new_file'"
        mv "$current_file" "$new_file"
        if [ $? -ne 0 ]; then echo "  ERROR: Failed to move '$current_file' to '$new_file'."; error_occurred=1; fi

        if [ $error_occurred -eq 0 ]; then
            echo "  - Moving '$old_file' to '$current_file'"
            mv "$old_file" "$current_file"
            if [ $? -ne 0 ]; then echo "  ERROR: Failed to move '$old_file' to '$current_file'."; error_occurred=1; fi
        fi

        if [ $error_occurred -eq 0 ]; then
            echo "  SUCCESS: $description swapped back to ORIGINAL version."
        else
            echo "  ERROR: $description swap BACK failed. Files might be in an inconsistent state!"
        fi
     else
        # Added more specific error message about *which* files might be missing
        echo "  ERROR: Cannot swap $description back. Missing source files ('$current_file' (the active one) or '$old_file')."
        error_occurred=1
     fi
  fi
    return $error_occurred
}


# --- Main Logic ---
echo "Starting file toggle script from _scripts directory..."
overall_status=0

# Determine state by checking for ONE of the '-old' files (using default layout as the key)
# The path $DEFAULT_OLD now correctly points to ../_layouts/default-old.html
if [ -f "$DEFAULT_OLD" ]; then
  echo "Detected '$DEFAULT_OLD' exists. Assuming NEW versions are active. Swapping back to ORIGINAL."
else
  echo "Did not detect '$DEFAULT_OLD'. Assuming ORIGINAL versions are active. Swapping to NEW."
fi
echo "---"


# Perform swaps for all pairs using the updated paths
swap_files "Default Layout" "$DEFAULT_HTML" "$DEFAULT_NEW" "$DEFAULT_OLD"
if [ $? -ne 0 ]; then overall_status=1; fi
echo "---"

swap_files "Post Layout" "$POST_HTML" "$POST_NEW" "$POST_OLD"
if [ $? -ne 0 ]; then overall_status=1; fi
echo "---"

swap_files "Styles CSS" "$STYLES_CSS" "$STYLES_NEW" "$STYLES_OLD"
if [ $? -ne 0 ]; then overall_status=1; fi
echo "---"

swap_files "Index Markdown" "$INDEX_MD" "$INDEX_NEW" "$INDEX_OLD"
if [ $? -ne 0 ]; then overall_status=1; fi
echo "---"


# --- Final Status ---
if [ $overall_status -eq 0 ]; then
  echo "Toggle script finished successfully."
else
  echo "Toggle script finished with ERRORS. Please check file states manually."
fi

exit $overall_status

```

### Integrating the Script Safely into Jekyll

A crucial detail: where should this utility script live within the Jekyll project structure? We need it version-controlled and easily accessible, but absolutely *not* copied into the final `_site` directory during the build process.

After considering putting it in `_data` (semantically wrong) or using a regular `scripts/` directory and adding it to `_config.yml`'s `exclude` list (requires config change), the best practice emerged:

**Use a directory prefixed with an underscore: `_scripts/`**

Jekyll automatically ignores any directory starting with `_` that isn't one of its special, recognized directories. This means creating a `_scripts/` folder in the project root provides perfect organization for utility scripts while guaranteeing they stay out of the build output, all without touching `_config.yml`.

So, the script now resides at `_scripts/swap-templates.sh`. To run it, navigate to the project root directory in the terminal and execute:

```bash
chmod +x _scripts/swap-templates.sh # Make executable (only needed once)
./_scripts/swap-templates.sh     # Run the toggle
```

### The Journey Continues: Embracing "Battle Duck" Data

So, the traffic mystery isn't fully solved. The prime suspects are now site scale and index structure. But this entire debugging journey – the initial misdiagnosis, the creation of parallel files, the iterative development of shell commands, the automation into a robust toggle script, and the research into proper Jekyll project structure for utilities – is valuable in itself.

It's a perfect example of what happens in real-world development. It's messy, iterative, and involves correcting course. Documenting this, perhaps with the help of AI like in our conversation, produces something more valuable than purely synthetic examples. It's data refined by actual use, by troubleshooting, by hitting dead ends. It's not just "rubber ducking" – explaining the problem to an inanimate object (or AI). It's data hardened by the process. Maybe we should call it **"Battle Duck" Data**? Tested in the trenches, refined by reality.

For now, I have a handy script to toggle my templates should I need it again, and a clearer path forward investigating the impact of my blog's scale. And, of course, another pedantically detailed post for the blog – hopefully, this one doesn't break anything!

---

## AI Analysis

**Title/Headline Ideas & Filenames:**

* Title: Debugging a Jekyll Traffic Drop: Building a Template Toggle Script
    Filename: `jekyll-debug-traffic-drop-template-toggle-script.md`
* Title: How I Created a Bash Script to Swap Jekyll Template Files for Testing
    Filename: `jekyll-bash-script-swap-template-files-testing.md`
* Title: Jekyll Troubleshooting: A Step-by-Step Guide to Creating a File Toggle Utility
    Filename: `jekyll-troubleshooting-file-toggle-utility-guide.md`
* Title: From Traffic Nosedive to Toggle Script: A Jekyll Debugging Story
    Filename: `jekyll-traffic-nosedive-toggle-script-debugging-story.md`
* Title: Using Bash `mv` and Relative Paths for a Jekyll Template Swapper
    Filename: `bash-mv-relative-paths-jekyll-template-swapper.md`

**Strengths:**

* Provides a detailed, real-world account of a common debugging scenario.
* Includes complete, functional code for the Bash script.
* Explains the reasoning behind technical decisions (e.g., using `&&`, relative paths, `_scripts` directory).
* Offers practical advice on integrating utility scripts into a Jekyll project safely.
* Captures the iterative nature of problem-solving.

**Weaknesses:**

* The core problem (traffic drop) remains unsolved, which might leave readers looking for *that* specific solution unsatisfied.
* The "Battle Duck Data" concept, while interesting, feels slightly tacked on and might be confusing without more context or development.
* Minor formatting issues in the raw input's code blocks (some commands run together without line breaks).

**AI Opinion:**
This article provides significant value as a practical case study in debugging and developer tooling within the context of Jekyll. Its strength lies in the meticulous documentation of the process for creating the template-toggling script, including path considerations and best practices for script placement. While the underlying traffic issue isn't resolved, the script itself is a useful artifact, and the troubleshooting thought process is instructive. The clarity is good for its likely target audience (developers, Jekyll users), though the narrative style makes it more of a "journey log" than a concise tutorial. The "Battle Duck" idea adds personality but slightly detracts from the technical focus at the end.
