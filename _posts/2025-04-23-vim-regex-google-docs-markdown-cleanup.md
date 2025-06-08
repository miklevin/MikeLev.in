---
title: Vim Regex Recipes for Fixing Google Docs Markdown Exports
permalink: /futureproof/vim-regex-google-docs-markdown-cleanup/
description: In this piece, I'm sharing a set of optimized Vim/Neovim regular expression commands I've developed to tackle the frustrating formatting inconsistencies that arise when exporting Markdown from Google Docs, particularly after using research tools like Gemini. My goal is to automate the cleanup of misplaced footnote numbers, excessive escape characters, and problematic pipe symbols in citations, leveraging Vim's substitution power with confirmation and easy-resume features to save significant manual correction time.
meta_description: Use Vim/Neovim regex commands to automatically clean up Google Docs Markdown exports, fixing footnote numbers, extra backslashes, and citation pipe characters.
meta_keywords: vim, neovim, regex, regular expression, markdown, google docs, export, cleanup, formatting, fix, footnote, superscript, sup tag, backslash, escape character, pipe, citation, bibliography, automation, text manipulation, .,$, :s, :g, gc flag, substitute, global command, text editor
layout: post
sort_order: 3
---

## Cleaning Up Digital Text: Automating Fixes with Code

When transferring text between different applications, like from Google Docs to a format called Markdown (commonly used for web content or plain text notes), formatting often gets messy. Tools used within Google Docs, like AI assistants, can sometimes add to this complexity. Things like footnote numbers, special characters (backslashes, pipe symbols `|`), and citations might not appear correctly in the final Markdown text, requiring manual cleanup which takes time.

This article focuses on a specific technical solution for this problem. It introduces the use of a powerful text editor called Vim (or its modern version, Neovim) combined with a pattern-matching language called Regular Expressions (regex). The article provides ready-to-use code snippets (Vim commands using regex) designed to automatically find and fix common formatting errors encountered when exporting from Google Docs to Markdown, making the text suitable for web use more quickly. It's a guide for users already familiar with Vim who want to streamline their text editing workflow.

---

## The Challenge: Cleaning Up Google Docs Markdown Exports

Exporting content from Google Docs to Markdown, especially after using integrated tools like Google Gemini for research, often results in text that isn't quite ready for direct use. Common issues include improperly formatted footnote numbers, excessive backslash escape characters, and characters like vertical pipes (`|`) in citations that clash with Markdown's table syntax. Manually correcting these issues can be time-consuming.

This article provides a set of refined Vim/Neovim regular expression commands designed to automate the cleanup process, making your text web-ready much faster. We'll focus on using Vim's powerful substitution features, including a confirmation step and an "easy-resume" range for more complex or ambiguous cases.

## Leveraging Vim and Regex for Efficiency

Vim/Neovim excels at text manipulation, and Regular Expressions (regex) provide the pattern-matching power needed to find and fix these specific formatting quirks systematically. The commands below target the most frequent annoyances encountered in Google Docs Markdown exports.

---

## Quick Reference: Optimized RegEx Cleanup Commands

Here are the optimized Vim commands. Note the use of `.,$` for commands with the `c` (confirm) flag, allowing you to easily stop and resume the process from your cursor position.

### 1. Wrap Footnote Numbers in `<sup>` Tags (Confirm & Resume)
*Identifies numbers likely used as footnotes near punctuation or line endings.*
```vim
:.,$s/\.\zs\d\+\|)\zs\d\+\|:\zs\d\+\|\d\+\ze:\|\s\zs\d\+\ze\s*$\|\d\+\ze,/<sup>&<\/sup>/gc
```

### 2. Remove Excessive Backslashes (Confirm & Resume)
*Removes unnecessary backslashes before common Markdown punctuation.*
```vim
:.,$s/\\\([\-+\[\]_#\*.]\)/\1/gc
```

### 3. Escape Pipes `|` in Citation Titles (Confirm per Line)
*Escapes pipe characters only on lines starting with `number. ` (typical for bibliographies), avoiding interference with Markdown tables.*
```vim
:g/^\d\+\. /s/|/\\|/gc
```

### 4. Tag Ambiguous Inline Footnotes (Confirm & Resume)
*Finds potential footnote numbers surrounded only by spaces, requiring manual confirmation.*
```vim
:.,$s/\s\+\zs\d\+\ze\s\+/<sup>&<\/sup>/gc
```

Detailed explanations for each command follow.

---

## Command 1: Wrapping Footnote Numbers in `<sup>` Tags

Google Docs often exports footnote markers as plain numbers. This command identifies numbers adjacent to common punctuation (periods, parentheses, colons, commas) or at the end of lines (handling potential trailing whitespace) and wraps them in HTML `<sup>...</sup>` tags.

**The Command:**
```vim
:.,$s/\.\zs\d\+\|)\zs\d\+\|:\zs\d\+\|\d\+\ze:\|\s\zs\d\+\ze\s*$\|\d\+\ze,/<sup>&<\/sup>/gc
```

**Breakdown:**

* `:.,$s/` : Initiates a substitute command (`s`) starting from the **current line** (`.`) down **to the last line** (`$`).
* `\.\zs\d\+ \| )\zs\d\+ \| :\zs\d\+ \| \d\+\ze: \| \s\zs\d\+\ze\s*$ \| \d\+\ze,`: This complex pattern uses the OR operator (`\|`) to match digits (`\d+`) in various contexts:
    * Following `.`, `)`, or `:` (using `\zs` to start the match *after* the punctuation).
    * Preceding `:` or `,` (using `\ze` to end the match *before* the punctuation).
    * Preceded by whitespace (`\s`) and followed by optional whitespace (`\s*`) and the end of the line (`$`) (using `\zs` and `\ze` to capture only the digits).
* `/<sup>&<\/sup>/` : The replacement string, using `&` to insert the matched digits inside the `<sup>` tags (note the escaped `/` in `<\/sup>`).
* `/gc` : Flags:
    * `g`: Replace all occurrences on each processed line.
    * `c`: **Confirm** before each change. Vim will highlight the match and prompt `(y/n/a/q/l/^E/^Y)?`.

**Easy Resume:** Using the `.,$` range combined with the `c` flag is key. If you make a mistake during confirmation or need to stop, press `q` to quit. You can then undo (`u`), reposition your cursor where you want to continue, and run the command again. It will resume checking only from that point forward.

---

## Command 2: Slashing Back The Backslashing

Google Docs tends to over-escape Markdown characters. This command finds common punctuation (`-`, `+`, `[`, `]`, `_`, `#`, `*`, `.`) preceded by an unnecessary backslash and removes the backslash.

**The Command:**
```vim
:.,$s/\\\([\-+\[\]_#\*.]\)/\1/gc
```

**Breakdown:**

* `:.,$s/`: Substitute (`s`) from the current line (`.`) to the last line (`$`).
* `\\`: Matches a literal backslash (`\`).
* `\(` ... `\)`: Creates a capture group (group 1).
* `[\-+\[\]_#\*.]`: A character class matching one of the specified punctuation marks. Note that characters like `-`, `[`, `]`, `*` need to be escaped *within* the class to be treated literally.
* `/\1/`: The replacement string. `\1` inserts the text captured by the first group (the punctuation character itself), effectively removing the preceding backslash.
* `/gc`: Flags:
    * `g`: Global replacement on the line.
    * `c`: **Confirm** each change. This is recommended to avoid removing genuinely needed escape characters (e.g., inside code blocks).

**Easy Resume:** Like the previous command, the `.,$` range allows you to easily stop (`q`), fix any errors (`u`), reposition the cursor, and re-run the command to continue the confirmation process from where you left off.

---

## Command 3: Escaping Pipes in Citation Titles

Vertical pipes (`|`) are often used as separators in article titles or other metadata listed in a "Works Cited" or bibliography section. However, `|` also defines columns in Markdown tables. Blindly escaping all pipes could break legitimate tables elsewhere. This command uses Vim's `:global` (`:g`) command to target only the lines likely to be citations (assuming they start with `number. space`) and then escapes the pipes *only* on those lines.

**The Command:**
```vim
:g/^\d\+\. /s/|/\\|/gc
```

**Breakdown:**

* `:g/^\d\+\. /`: This is the `:global` command part. It finds **all** lines in the file that match the pattern `^\d\+\. ` (start of line `^`, one or more digits `\d+`, a literal period `\.`, followed by a space ` `).
* `s/|/\\|/gc`: This is the substitute command that `:global` executes *only on the lines found by the pattern*.
    * `s/|/\\|/`: Replaces a literal pipe `|` with an escaped pipe `\|`. (The double backslash `\\` is needed in the replacement part to produce a single literal backslash).
    * `g`: Replace all pipes on the matched line.
    * `c`: **Confirm** each pipe replacement *on these specific lines*.

**Note on Resuming:** Because this uses `:g` to first identify *all* relevant lines throughout the file, the "easy resume" `.,$` range doesn't apply in the same way. If you quit (`q`) during the confirmation phase of the substitution, re-running the command will cause `:g` to find all matching lines again from the start of the file. However, the confirmation step still gives you control over each change within the targeted citation lines.

---

## Command 4: Tagging Ambiguous Inline Footnotes

Sometimes, footnote numbers appear inline, surrounded only by spaces (e.g., `... see reference 10 for details...`). These are the trickiest because they look like normal numbers. Automatically tagging them risks adding `<sup>` tags to numbers that aren't footnotes (false positives).

**The Challenge:** Full automation is unreliable here due to ambiguity.

**The Solution:** Use regex to find *potential candidates* and rely on manual confirmation (`c`) for accuracy. Use the `.,$` range for efficient workflow management.

**The Command:**
```vim
:.,$s/\s\+\zs\d\+\ze\s\+/<sup>&<\/sup>/gc
```

**Breakdown:**

* `:.,$s/`: Substitute (`s`) from the current line (`.`) to the last line (`$`).
* `\s\+`: Matches one or more leading whitespace characters.
* `\zs`: Starts the actual match *after* the leading whitespace.
* `\d+`: Matches the digits (the potential footnote number).
* `\ze`: Ends the actual match *before* the trailing whitespace.
* `\s+`: Matches one or more trailing whitespace characters.
* `/<sup>&<\/sup>/`: Replaces the matched digits (`&`) with the digits wrapped in `<sup>` tags.
* `/gc`: Flags:
    * `g`: Global on the line (usually only one match per instance here).
    * `c`: **Confirm** each potential match. This is essential for verifying if the number is truly a footnote.

**Easy Resume (Crucial Here):** This pattern is the most likely to require frequent stops and checks. The `.,$` range is particularly valuable. Find a potential candidate, confirm (`y`) or deny (`n`). If you make a mistake, quit (`q`), undo (`u`), reposition the cursor, and run `:.,$s/.../gc` again to pick up exactly where you left off without re-checking the beginning of the document. This makes managing this necessary manual step much less painful.

---

By applying these targeted Vim commands, especially using the `.,$` range for confirmable substitutions, you can significantly reduce the time and effort required to transform messy Google Docs Markdown exports into clean, usable text for your publications or notes.

---

## AI Analysis

**Title/Headline Ideas:**

* Automating Google Docs Markdown Cleanup with Vim & Regex
* Vim Regex Recipes for Fixing Google Docs Markdown Exports
* From Google Docs to Clean Markdown: Vim/Neovim Automation Guide
* Taming Google Docs Exports: Regex Cleanup for Footnotes, Backslashes & Pipes
* Efficient Markdown Formatting Fixes using Vim Regex Commands

**Strengths:**

* Provides specific, actionable Vim/Neovim commands for common, frustrating formatting problems.
* Includes detailed breakdowns explaining how each regex pattern works.
* Highlights practical workflow improvements like using the `c` flag for confirmation and the `.,$` range for easy resumption, acknowledging the interactive nature of cleanup.
* Addresses distinct issues (footnotes, backslashes, citation pipes) with targeted solutions.
* Focuses on a powerful, widely-used tool (Vim/Neovim) within its user community.

**Weaknesses:**

* Assumes significant prerequisite knowledge of Vim/Neovim and regular expressions, making it inaccessible to beginners.
* Lacks alternative solutions for users who don't use Vim.
* The scope is narrow, only addressing a few specific formatting issues encountered from Google Docs exports (other issues might exist).
* Doesn't discuss potential edge cases where the regex might fail or incorrectly modify text (beyond the ambiguity mentioned for Command 4).

**AI Opinion:**
This article offers high practical value for its intended audience: Vim/Neovim users who frequently work with Markdown exported from Google Docs. It directly addresses a common pain point with concrete, well-explained solutions. While the technical jargon and assumed knowledge limit its general accessibility, the clarity for a user familiar with Vim and regex is excellent. The inclusion of workflow tips (confirmation, resuming) significantly enhances its usefulness for real-world application. It functions effectively as a targeted technical guide or reusable snippet collection.

