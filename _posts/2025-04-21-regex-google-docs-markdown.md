---
title: "Vim & Regex Kung Fu: Cleaning Google Docs Markdown Exports"
permalink: /futureproof/regex-google-docs-markdown/
description: "I frequently need to clean up Markdown generated via Google Docs after using Gemini Deep Research, as the direct export isn't clean. This post documents the specific Vim regex commands I've refined to tackle the three main annoyances: automatically wrapping footnote numbers in `<sup>` tags while handling edge cases like trailing whitespace, removing the excessive backslashes Google Docs adds before punctuation, and correctly escaping vertical pipe characters used in citation titles (found in my 'Works cited' section) without messing up actual Markdown tables elsewhere in the document."
meta_description: "Use Vim regex commands to clean Markdown from Google Docs: automatically add sup tags to footnotes, remove excess backslashes, & conditionally escape pipes."
meta_keywords: vim, neovim, regex, regular expression, markdown, cleanup, sanitize, format, google docs, export, footnote, superscript, sup tag, html tag, backslash, escape character, pipe character, vertical bar, table formatting, citation, works cited, vim colon global, vim colon s, substitute, text editor, text manipulation, pattern matching, gemini research, trailing whitespace, automation
layout: post
sort_order: 2
---

## Addressing Digital Text Format Challenges

This article addresses a practical challenge faced when working with digital text formats, specifically cleaning up text exported from one system (Google Docs, potentially used with AI research tools like Google Gemini) for use in another (web publication using Markdown). Markdown is a popular lightweight language for formatting plain text, often used for websites, documentation, and notes. However, automated exports can sometimes introduce formatting errors or inconsistencies.

## Utilizing Regular Expressions in Vim/Neovim

The author focuses on using Regular Expressions (regex), a powerful tool for finding and replacing patterns in text, within the context of the Vim/Neovim text editors. These editors are known for their efficiency and powerful text manipulation capabilities, especially popular among programmers and technical writers.

### Specific Regex Patterns for Common Issues

The article details specific regex patterns developed to automatically fix common issues like improperly formatted footnote numbers, unnecessary escape characters (backslashes), and characters that conflict with Markdown's table syntax, thereby streamlining the workflow for preparing technical content for publication.

---

## Quick Reference: The Three Essential RegEx Patterns

Here are the three main RegEx patterns that solve the most common Google Docs Markdown export issues:

### 1. Wrapping Footnote Numbers in `<sup>` Tags
```vim
:%s/\.\zs\d\+\|)\zs\d\+\|:\zs\d\+\|\d\+\ze:\|\s\zs\d\+\ze\s*$\|\d\+\ze,/<sup>&<\/sup>/gc
```

### 2. Removing Excessive Backslashes
```vim
:%s/\\\([\-+\[\]_#\*.]\)/\1/gc
```

### 3. Escaping Pipes in Citation Titles
```vim
:g/^\d\+\. /s/|/\\|/gc
```

### 4. Catch Superscript Outliers (with easy-resume)
```vim
:.,$s/\s\+\zs\d\+\ze\s\+/<sup>&<\/sup>/gc
```

Each pattern is explained in detail in the sections below.

---

## The Google Docs Markdown Export Challenge

Psst! Wanna publish some research? Well, you SOL if you want to get clean
markdown from Google Docs, which is what you have to do if you use Google Gemini
Deep Research (now run by Gemini 2.5 - yay!), because it doesn't give you clean
markdown directly. So you have to "Export to Docs" and get markdown from there.
But even that doesn't export cleanly, full of backslashes and misplaced pipes.

## My Personal Research Workflow

I often want to format markdown from Google Deep Research for web publication.
It's mostly for my own benefit because I need to perform the research for my own
education and I want to be able to find it again easily. Also, it might benefit
someone else and I want to put it into the same base I'll be mining as fodder
for the future-proofing tech book.

## Leveraging LLMs for Regex Mastery

One of the early discoveries about LLMs was just how good they are at Regular
Expression matching (aka regex), and I couldn't agree more. Many patterns that
were just far beyond my reach are now a prompt away. And so I've practiced some
RegEx Kung Fu to get docs like the immediately prior one about the Microsoft
Search API and it's fresh on my mind, so I'll just put this here.

## The Three Main Markdown Formatting Issues

It breaks down to 3 offenders. 

- There's a whole lot of backslashing going on `\`
- Vertical pipes `|` are frequently used in title tags, but they're also critical
  for markdown table formatting
- Footnote numbers scattered throughout document that should really be enclosed
  in HTML superscript tags `<sup>`.

---

# Efficiently Tagging Markdown Footnotes in Vim/Neovim

When working with Markdown documents, particularly those converted from other formats or manually edited, you might find footnote markers represented simply as numbers rather than being correctly enclosed in HTML superscript tags (`<sup>...</sup>`). Manually finding and tagging each footnote can be tedious, especially in longer documents. Fortunately, the powerful search and replace capabilities of Vim/Neovim, combined with regular expressions, offer an efficient solution.

This guide walks through the process of developing a Vim regex pattern to automatically wrap footnote numbers in `<sup>` tags, based on common patterns observed in a sample Markdown document.

## RegEx Case 1: Identifying Footnote Numbers for Superscript

The first step is to identify where footnote numbers typically appear. In the examined document, several patterns emerged:

1.  Immediately following a period (`.`), like `...services.1`
2.  Immediately following a closing parenthesis (`)`), like `... )8` (though less common in the sample)
3.  Adjacent to a colon (`:`), either before or after, like `types 1:` or `:1`
4.  At the end of a line, preceded by a space, like in list items:
    * `* Java 1`
    * `* Go 1`

The goal is to create a single Vim command that finds *only* these footnote numbers and wraps them in `<sup>` tags, without accidentally tagging other numbers (like version numbers, e.g., `API 2.0`, or numbers within dates).

### Developing the Regex Pattern: An Iterative Approach

**Attempt 1: Targeting Punctuation**

Based on the initial observations (points 1-3 above), a pattern can be constructed using Vim's regex syntax:

* `\.\zs\d\+`: Matches digits (`\d\+`) that follow a period (`\.`), starting the actual match (`\zs`) *after* the period.
* `)\zs\d\+`: Matches digits following a closing parenthesis (`)`).
* `:\zs\d\+`: Matches digits following a colon (`:`).
* `\d\+\ze:`: Matches digits that are followed by a colon, ending the match (`\ze`) *before* the colon.

Combining these with the OR operator (`\|`) gives: `\.\zs\d\+\|)\zs\d\+\|:\zs\d\+\|\d\+\ze:`

This pattern successfully handles cases where footnotes are adjacent to the specified punctuation.

**Attempt 2: Handling End-of-Line Numbers and Trailing Whitespace**

Testing revealed that the first pattern missed footnotes appearing at the end of lines, like in lists. A new condition was needed: `\s\zs\d\+\ze$`. This attempts to match digits (`\d\+`) preceded by whitespace (`\s`) and followed immediately by the end of the line (`$`).

However, this second attempt initially failed for some list items. The reason? **Trailing whitespace.** If a line had invisible spaces after the final digit (e.g., `* Java 1 `), the `$` anchor wouldn't match directly after the digit, causing the pattern to fail for that line.

**The Final Pattern: Accounting for Trailing Whitespace**

To fix this, the end-of-line pattern was refined to `\s\zs\d\+\ze\s*$`:

* `\s`: Matches the space before the number.
* `\zs`: Starts the match after the space.
* `\d\+`: Matches the footnote number digits.
* `\ze`: Ends the match *immediately* after the digits.
* `\s*`: Matches *zero or more* whitespace characters (handling trailing spaces or no spaces).
* `$`: Matches the end of the line.

This ensures that the digits are matched correctly even if trailing spaces exist, and crucially, the `\ze` ensures those trailing spaces are *not* included in the text to be wrapped by the tags.

### The Final Vim Command

Combining all conditions gives the final, robust pattern. The complete Vim substitute command is (note: added support for "number before comma"):

```vim
:%s/\.\zs\d\+\|)\zs\d\+\|:\zs\d\+\|\d\+\ze:\|\s\zs\d\+\ze\s*$\|\d\+\ze,/<sup>&<\/sup>/gc
```

**Command Breakdown:**

* `:%s/` : Initiates a substitute command (`s`) across the entire file (`%`).
* `\.\zs\d\+\|)\zs\d\+\|:\zs\d\+\|\d\+\ze:\|\s\zs\d\+\ze\s*$` : This is the final pattern, combining all identified cases using the OR (`\|`) operator.
    * `\.` , `)` , `:` , `\s` : Match preceding punctuation or space.
    * `\d\+` : Match the footnote number.
    * `\s*$` , `:` : Match trailing context (optional whitespace and end-of-line, or a colon).
    * `\zs` , `\ze` : Precisely define the start and end of the text to be replaced (ensuring only digits are captured).
* `/<sup>&<\/sup>/` : The replacement string.
    * `<sup>` and `</sup>` : The HTML tags (note the escaped `/` in `<\/sup>`).
    * `&` : Represents the matched text (the digits captured by `\d\+`).
* `/gc` : Flags for the command.
    * `g` (Global): Replace all occurrences on each line.
    * `c` (Confirm): Prompt before making each change (recommended for verification; omit if you prefer automatic replacement).

### Conclusion

By carefully observing patterns and iteratively refining the regular expression to handle edge cases like trailing whitespace, we arrived at a single Vim command capable of accurately finding and tagging diverse footnote number formats within a Markdown document. This significantly speeds up the process compared to manual editing, ensuring consistency and correctness in the final markup.

---

## RegEx Case 2: Slashing Back The Backslashing

The next major headache when saving markdown from Google Docs is all the backslash escaping. Here's the command:

```vim
:%s/\\\([\-+\[\]_#\*.]\)/\1/gc
```

**Explanation:**

1.  `:%`: This prefix tells Vim to apply the following command to all lines in the file.
2.  `s/`: Starts the substitute command.
3.  `\\`: Matches the literal backslash you want to remove.
4.  `\(` ... `\)`: This creates a capture group (group 1).
5.  `[\-+\[\]_#\*.]`: This character class matches a single character that is one of the following:
    * `\-` (hyphen)
    * `+` (plus)
    * `\[` (opening square bracket)
    * `\]` (closing square bracket)
    * `_` (underscore)
    * `#` (hash/pound)
    * `\*` (asterisk)
    * `.` (period)
    * *(Note: The characters `-`, `[`, `]`, `*` are escaped with a backslash within the `[]` character class to ensure they are treated as literal characters)*
6.  `/`: Separates the search pattern from the replacement string.
7.  `\1`: This is the replacement. It inserts the text captured by the first capture group (`\(`...`\)`), which is just the punctuation character without the preceding backslash.
8.  `/gc`: These are the flags:
    * `g` (Global): Replace all occurrences on each line processed.
    * `c` (Confirm): Ask for confirmation before each replacement. This is often useful for "cleanup" patterns like this, just in case an escape character was intentional and necessary (e.g., inside a code block). You can omit the `c` if you prefer it to run automatically.

Running this command will search the entire file for any instances where `\`, `+`, `[`, `]`, `_`, `#`, `*`, or `.` are preceded by a backslash and will remove that backslash, leaving only the character itself.

---

## RegEx Case 3: When a Vertical Bar Is Not a Markdown Table

### AKA Escaping Title Tags Pipes

The last regex to format Google Doc markdown exports is a classic case where you want to apply a change, but only within a specific context or on lines matching a certain structure. That's because vertical bars are used all over the place in markdown to format tables, but they're also widely used in HTML title tags as a delineater like a comma or a slash. Unfortunately, this wreaks havoc on markdown rendering. Thankfully, this is mostly only a concern in the **Works cited** section of the research documents which always have line numbering at the start of the line.

Applying `s/|/\\|/gc` globally would break Markdown tables.

So the idea to use the line's starting pattern (`number. space`) as a condition. I used to do this with visual select to constrain it to **Works cited** but now instead of trying to combine everything into one complex `:s` command, you can use Vim's `:global` command (`:g`) to first find the lines I care about and *then* run the substitution command only on those lines.

Here's the command structure:

```vim
:g/^\d\+\. /s/|/\\|/gc
```

**Let's break this down:**

1.  `:g`: This invokes the `:global` command. It tells Vim to find all lines matching the following pattern.
2.  `/^\d\+\. /`: This is the pattern for the `:global` command. It finds lines that:
    * `^`: Start at the beginning of the line.
    * `\d\+`: Have one or more digits.
    * `\.`: Followed by a literal period.
    * ` `: Followed by a space.
    * This pattern precisely matches the start of your numbered "Works cited" lines.
3.  `s/|/\\|/gc`: This is the command that `:global` will execute *only* on the lines that matched the pattern `^\d\+\. `.
    * `s/|/\\|/`: Your substitution, replacing a literal pipe `|` with an escaped pipe `\|`. (Note the double backslash `\\` is needed in the replacement part to get a literal backslash).
    * `g`: The global flag for the `s` command ensures *all* pipes on that specific line are replaced.
    * `c`: The confirm flag asks before each replacement on the matched lines.

**In essence:**

This command says: "Globally find all lines starting with `number. space`. On each of those lines (and *only* those lines), substitute all occurrences of `|` with `\|`, asking for confirmation each time."

This neatly solves the problem by restricting the pipe escaping to only the citation lines, leaving our Markdown tables elsewhere untouched.

---
Okay, here's an addendum to the article that explains the challenge of these inline numbers and the reasoning behind the confirmation-based approach, including the use of the `.,$` range for managing the process.

---

## Addendum: Handling the Ambiguous Case – Inline Footnote Numbers

While the three main regex patterns address the most common and predictable formatting issues from Google Docs Markdown exports, there's often one lingering, more ambiguous outlier: **footnote numbers appearing inline within the text, surrounded only by spaces.**

Consider a sentence like: `...as shown in the previous study 10 which detailed...`

Unlike footnotes next to punctuation (`study.10`) or at specific line endings (`* List item 10`), this `10` looks structurally identical to any other number that might naturally occur in the text (e.g., `...we need 10 widgets...`).

### The Challenge: Ambiguity and False Positives

This ambiguity makes reliable, fully automated replacement extremely difficult. A regex pattern broad enough to catch ` 10 ` in the first example would *also* incorrectly catch ` 10 ` in the second example, potentially wrapping regular numbers in `<sup>` tags throughout your document. The risk of these "false positives" is too high for a simple, automatic search-and-replace across the entire file.

### The Solution: Semi-Automation with Confirmation

Since we can't trust full automation, we adopt a semi-automated approach. We use a regex pattern designed to find *potential* candidates, but we rely on manual verification for accuracy. This is where the following command comes in:

```vim
:%s/\s\+\zs\d\+\ze\s\+/<sup>&<\/sup>/gc
```

* The pattern `\s\+\zs\d\+\ze\s\+` specifically looks for digits surrounded by one or more spaces, ensuring the spaces themselves aren't part of the match (`\zs`, `\ze`).
* The crucial element is the `c` flag (confirm). Vim finds each potential candidate matching the pattern, highlights it, and pauses, asking you to confirm (`y`) or deny (`n`) the replacement.

This allows you to leverage Vim's pattern-matching speed to find the candidates while retaining human judgment to decide if each specific number is truly a footnote requiring `<sup>` tags.

### Managing the Workflow: Interruptions and Resuming

This confirmation process, while necessary for accuracy, can be tedious, especially in long documents. It's easy to get into a rhythm and accidentally press `y` when you meant `n`, or vice-versa. You might realize a mistake several steps later, or simply need to take a break.

Constantly restarting the check from the beginning of the file (`:%s`) after every interruption or correction is inefficient. This is why we refine the command further by specifying a range:

```vim
:.,$s/\s\+\zs\d\+\ze\s\+/<sup>&<\/sup>/gc
```

By replacing `%` (whole file) with `.,$` (current line to last line), we gain essential flexibility:

1.  **Stop Anytime:** If you make a mistake or need to pause, simply press `q` during the confirmation prompt to quit the substitution process.
2.  **Fix Mistakes:** Use Vim's undo (`u`) or other editing commands to correct any erroneous replacements.
3.  **Resume Efficiently:** Place your cursor back on the line where you want to continue checking (or the line immediately after your last fix).
4.  **Run the Command Again:** Execute `:.,$s/.../gc` once more. Vim will now *only* search from your current position down to the end of the file, skipping the parts you've already verified.

This `.,$` range significantly streamlines the handling of this necessary but often interrupted manual verification step, making the cleanup of these ambiguous inline footnotes manageable without forcing you to re-review the entire document repeatedly. It acknowledges the practical reality that sometimes, perfect automation isn't feasible, and provides an efficient way to manage the required manual intervention.

---

## AI Analysis

**Title/Headline Ideas:**

* Vim & Regex Kung Fu: Cleaning Google Docs Markdown Exports
* Automating Markdown Cleanup: Fixing Footnotes, Backslashes, and Pipes in Vim
* From Messy Export to Clean Markdown: A Vim Regex Guide
* Efficient Markdown Sanitization with Vim Regex
* Solving Google Docs Markdown Issues: Footnotes, Escaping, and Conditional Edits in Vim

**Strengths:**

* **Practical Problem-Solving:** Addresses a specific, real-world workflow issue.
* **Detailed Regex Explanation:** Thoroughly breaks down the development and logic of the regex patterns, including the iterative process and handling of edge cases (like trailing whitespace).
* **Actionable Code:** Provides complete, ready-to-use Vim commands.
* **Contextual Application:** Demonstrates the use of Vim's `:global` command for applying changes contextually (only on specific lines), which is a valuable technique.

**Weaknesses:**

* **Niche Audience:** Primarily relevant to users of Vim/Neovim who also experience these specific Google Docs Markdown export problems.
* **Assumed Knowledge:** Requires significant prerequisite knowledge of both Vim commands and regular expression syntax to fully understand the explanations.
* **Lack of Alternatives:** Focuses solely on Vim regex, without mentioning or comparing other potential scripting or tool-based solutions.
* **Initial Rambling:** The introductory paragraphs, while providing personal context, are somewhat unstructured and might deter readers looking for immediate technical solutions if this were a formal article.

**AI Opinion:**

This article serves as a valuable, practical guide for a specific technical audience: Vim/Neovim users who need to clean up Markdown generated or exported from Google Docs, particularly concerning footnotes, escape characters, and citation formatting. Its strength lies in the detailed breakdown of the regex solutions and the clear presentation of the final Vim commands. While the clarity is high for those familiar with the tools and concepts involved, it would likely be challenging for newcomers to Vim or regex due to the assumed knowledge. The journal-like introduction provides personal context but could be streamlined for broader appeal. Overall, it's a useful piece of targeted technical documentation solving a specific, recurring problem.
