---
title: 'Pipulate''s Smart Prompt Syncing: Orchestrating AI Workflows with nbup()'
permalink: /futureproof/pipulate-smart-prompt-syncing-orchestrating-ai-workflows-with-nbup/
description: This entry is a soliloquy on the meticulous development of Pipulate,
  reflecting a deep commitment to building robust, reproducible, and AI-enhanced software.
  The author's personal investment shines through, from the "desert kite" analogy
  guiding AI to the Cialdini-esque public commitment, all while ensuring the core
  system is forever a 'safe-haven' for code. It's a pragmatic philosophy of continuous
  refinement, aiming to elevate current MVP deliverables into future AI-integrated
  experiences.
meta_description: Pipulate's nbup() function is enhanced for dynamic AI prompt assignment
  in Jupyter notebooks, streamlining workflows. This pivotal update showcases Pipulate's
  evolution from SEO MVP to AIE excellence.
meta_keywords: Pipulate, AI prompts, Jupyter notebooks, nbup, URLinspector, FAQuilizer,
  SEO, AIE, Nix, workflow automation, prompt engineering
layout: post
sort_order: 3
---

{% raw %}


## Setting the Stage: Context for the Curious Book Reader

This entry documents a pivotal refinement in the Pipulate framework, detailing the implementation and verification of dynamic AI prompt selection within its `nbup()` function. It reflects an ongoing methodology to meticulously craft an AI-driven environment, ensuring precision and contextual relevance in automated workflows from initial setup to advanced AI Education (AIE) applications.

---

## Technical Journal Entry Begins

Unexpected complexities. Bookmarking "would be nice" features. I need that to-do
list for Pipulate in some undeniably central "cuts them off at the pass"
location that I am guaranteed to look at again... oh! And that the AIs will look
at again too! `AI_RUNME.py` is a perfect place. 

```markdown
# TODO
- Add "Rich color" to the DOM box & tree output from `pipulate/tools/dom_tools.py`.
- Add "Project URL" and "GSC Domain" fields to `pipulate/apps/020_profiles.py`.
```

Okay, that will do for that for now. We must not forget past things. We must not
pass over things. We must remember those things we deferred to later and make
sure we touch in with them from time to time somehow or other. We do this by
putting things in critical paths. You can't get to `B` without going through
`A`. You will encounter `A` again; do not worry.

Now we lay out the basics of the ASAP MVP SEO `URLinspector.ipynb` output,

## The Core Challenge: Dynamic Prompting in Pipulate
a.k.a. the "deliverable." You can grow pumpkins 'till the cows come home but
until you harvest them, there's not gonna be any Jack-o'-lanterns. Oh wow, what
a powerful "coming to life" metaphor for our day and age, all the come-alive
pumpkin heads from Tim Burton's Jack Skellington movie character to the
(original?) Jack Pumpkinhead to the old classic, Ichabod Crane the Headless
Horseman of nearby Sleepy Hollow. I say nearby because I live near it and have
been it on past Halloweens with the kid.

Enough reminiscing and fancifulness. It's time to get to harvesting the
pumpkins! It's that time of year again and it pains me to not be in the spirit
of the thing to celebrate it properly. You only have so many rotations around
the Sun — ten for each finger. Or 5 if you count your fingers and toes.

`1, 2, 3... 1?`

We have a repeatable process. It's bottled. We've canned it.

It now can be my own way finder and cheerleader rolled into one. It compels me
forward because there now is:

- `AI_HelloWorld.ipynb`
- `FAQuilizer.ipynb`
- `GAPalyzer.ipynb`
- `URLinspector.ipynb`

...every time you install Pipulate. JupyterLab pops up BEFORE Pipulate (by
design) tantalizing you before the Web Apps UI blocks it out by opening the next
tab. But the seed is planted. JupyterLab is there and there are 4 Notebooks
cleanly laid out.

## The Orchestrator: `pip.nbup()` and Core Logic

Once `Nix` is installed for the first time, and that is the prerequisite to
everything and really the center of the Universe and something that only has to
happen ONCE on your system EVER, then everything after that is channeling more
of your resources into this *forever safe-haven* for your code — a sort of
Noah's Ark that makes you relevant and always a valuable voice around the table
because your solutions are a sort of generic Linux applies to every problem
domain in every situation for every expertise level of the people you're working
with yadda yadda ad nauseam. 

There is a prompt. The prompt occurs in the following places:

```bash
[mike@nixos:~/repos/pipulate]$ rg 'You are an AI Content St'
assets/nbs/URLinspector.ipynb
89:    "You are an AI Content Strategist. \n",

assets/nbs/FAQuilizer.ipynb
89:    "You are an AI Content Strategist. \n",

pipulate/core.py
1996:            "You are an AI Content Strategist. \n",
(nix) 
[mike@nixos:~/repos/pipulate]$
```

The only *real* single source of truth is `pipulate/core.py` because prompts are
secret sauce and they get layered in as template examples by the system. Any
changes you make in the `Notebook/FAQuilizer.ipynb` version DOES NOT get pushed
back into the upstream version when you use `pip.nbup()`. The fact that the
prompt text in `FAQuilizer.ipynb` matches that in `pipulate/core.py` is the
result of a hand-edit 1-time sync using Vim because there is no easy way to load
those back-end Notebook assets. They get "pushed back there" filtered by
`pip.nbup()` so filtered fields are a unique challenge. Any changes the user
makes to filtered fields gets *replaced with what's in* `pipulate/core.py` on
the `pip.nbup()` sync, and therefore it should never *really* be necessary to
hand-edit a Notebook in `assets/nbs/` but rather the preferred method should be
to just do it in `pipulte/core.py` then sync. 

However, `pipulate/core.py` is hardwired to only update the Jupyter Notebook
cell labeled `prompt-input` one way, regardless of whether it's
`FAQuilizer.ipynb` (the current prompt) or `URLinspector.ipynb` (the one we're
working on). The FAQuilizer uses this prompt:

    **Your Role (AI Content Strategist):**

    You are an AI Content Strategist. 
    Make 5 Frequently Asked Questions for each page.
    For each question, produce the following so it fits the data structure:

    1. priority: integer (1-5, 1 is highest)
    2. question: string (The generated question)
    3. target_intent: string (What is the user's goal in asking this?)
    4. justification: string (Why is this a valuable question to answer? e.g., sales, seasonal, etc.)

If it's the URL Inspector, I need a different prompt:

    **Your Role (SEO URL Consultant auditing individual URLs):**

    A "keyword" is the unique short combination of words that are most likely to be searched-on by a user who might be interested in this page.
    What is the five most likely keywords (short combination of words) that this page appears to be targeting?

    1. priority: integer (1-5, 1 is highest)
    2. question: string (The keyword)
    3. target_intent: string (What specifically is the user likely to have in mind when performing this search?)
    4. justification: string (Informational, Commercial, Navigational, Transactional?)

Please give me an implementation plan that I can hand over to Gemini CLI please
and thank you!

## Gemini's Implementation Plan

Hello herd of intelligence. Have you heard? I herd the herd. It is a sort of
desert kite or buffalo jump getting you running all in the same direction. We
layer it up with an AI Phooey Chop. Those are like the first piled-up stone
walls of the desert kite that you encounter. And it goes like this.

First we introduce you to the overall system.

    /home/mike/repos/pipulate/AI_RUNME.py

Then we show you we're mostly just using a Jupyter Notebook:

    /home/mike/repos/pipulate/Notebooks/URLinspector.ipynb

Oh, and there's another copy of it (almost):

    /home/mike/repos/pipulate/assets/nbs/URLinspector.ipynb

Oh, but these things are installed with an installer in the first place:

    /home/mike/repos/pipulate/flake.nix

Wait, what? There's 2 copies of each Notebook? Yeah, one is git managed and the
other is free to be edited by the user without blocking the `git pull` auto
update. You can see that in there. There's even a `git stash` to assure its
success. Oh, the orchestrator? That's the magic wand:

    /home/mike/repos/pipulate/pipulate/__init__.py
    /home/mike/repos/pipulate/pipulate/pipulate.py
    /home/mike/repos/pipulate/pipulate/core.py

The magic wand controls the default prompts. Yeah, I know that's a bit hardwired
for a generic wand, but we're in the early stages. Bear with me as we flesh out
minimum viable magic wand and set of off-the-shelf spells.

Spells? Oh yeah, we package this context all up in a nice story-telling order
like so:

```python
AI_PHOOEY_CHOP = """\
/home/mike/repos/pipulate/AI_RUNME.py
/home/mike/repos/pipulate/Notebooks/URLinspector.ipynb
/home/mike/repos/pipulate/assets/nbs/URLinspector.ipynb
/home/mike/repos/pipulate/flake.nix
/home/mike/repos/pipulate/pipulate/__init__.py
/home/mike/repos/pipulate/pipulate/pipulate.py
/home/mike/repos/pipulate/pipulate/core.py
"""
```

We play the music of the 80s cartoon *Hong Kong Phooey* in our minds. And then
we submit this prompt with an implementation plan request. Please show me how to
edit `pipulate/core.py` (and potentially `assets/nbs/URLinspector.ipynb`) in
order to get the URLinspector query to appear on `URLinspector.ipynb` after a
fresh install. Please and thank you!

Hi-Ya!

```bash
(nix) 
[mike@nixos:~/repos/pipulate]$ python prompt_foo.py 
--- Processing Files ---
   -> Converting notebook: /home/mike/repos/pipulate/Notebooks/URLinspector.ipynb
Python file(s) detected. Generating codebase tree diagram... (2,245 tokens)
Python file(s) detected. Generating UML diagrams...
   -> Generating for /home/mike/repos/pipulate/AI_RUNME.py... (skipped)
   -> Generating for /home/mike/repos/pipulate/pipulate/__init__.py... (skipped)
   -> Generating for /home/mike/repos/pipulate/pipulate/pipulate.py... (skipped)
   -> Generating for /home/mike/repos/pipulate/pipulate/core.py... (2,277 tokens)
...UML generation complete.

--- Files Included ---
• /home/mike/repos/pipulate/AI_RUNME.py (3,675 tokens)
• /home/mike/repos/pipulate/Notebooks/URLinspector.ipynb (1,181 tokens)
• /home/mike/repos/pipulate/flake.nix (7,440 tokens)
• /home/mike/repos/pipulate/pipulate/__init__.py (382 tokens)
• /home/mike/repos/pipulate/pipulate/pipulate.py (511 tokens)
• /home/mike/repos/pipulate/pipulate/core.py (21,840 tokens)

--- Auto-Context Included ---
• Codebase Structure (eza --tree) (2,245 tokens)
• UML Class Diagram (ASCII for /home/mike/repos/pipulate/pipulate/core.py) (2,277 tokens)

--- Prompt Summary ---
Summed Tokens:   41,922 (from section parts)
Verified Tokens: 42,463 (from final output)
  (Difference: +541)
Total Words:     17,049 (content only)

--- Size Perspective ---
📚 Equivalent in length to a **Novelette** (Note: With a token/word ratio of 2.49, this content is far denser and more complex than typical prose of this length).

Markdown output copied to clipboard
(nix) 
[mike@nixos:~/repos/pipulate]$
```

**Gemini Web**: Context verified.

## Verifying the Dynamic Prompt Update

Okay, let's get this pumpkin harvested\! 🎃 You want `pip.nbup()` to be smarter and use the *correct* sample prompt when syncing notebooks back to the `assets/nbs/` directory. Right now, it's hardcoded to always use the `FAQuilizer` prompt.

Here's an implementation plan suitable for handing over to the Gemini CLI:

## Implementation Plan: Dynamic Prompt Syncing in `pip.nbup()`

**Goal:** Modify `pipulate/core.py` so that `pip.nbup()` selects the appropriate sample prompt based on the notebook being synced (`FAQuilizer.ipynb` vs. `URLinspector.ipynb`) before writing to `assets/nbs/`.

-----

**1. 📚 Define Both Sample Prompts in `core.py`**

  * Locate the existing `SAMPLE_PROMPT_SOURCE` list within the `nbup` method in `pipulate/core.py`.
  * Rename it to `SAMPLE_PROMPT_SOURCE_FAQ` for clarity.
  * Add a new list named `SAMPLE_PROMPT_SOURCE_URLI` containing the source lines for the **URLinspector** prompt.

<!-- end list -->

```python
# Inside pipulate/core.py, within the nbup method

# --- Define Sample Data for Scrubbing ---
SAMPLE_PROMPT_SOURCE_FAQ = [
    "**Your Role (AI Content Strategist):**\n",
    "\n",
    "You are an AI Content Strategist. \n",
    "Make 5 Frequently Asked Questions for each page.\n",
    "For each question, produce the following so it fits the data structure:\n",
    "\n",
    "1. priority: integer (1-5, 1 is highest)\n",
    "2. question: string (The generated question)\n",
    "3. target_intent: string (What is the user's goal in asking this?)\n",
    "4. justification: string (Why is this a valuable question to answer? e.g., sales, seasonal, etc.)"
]

# ADD THIS NEW PROMPT LIST
SAMPLE_PROMPT_SOURCE_URLI = [
    "**Your Role (SEO URL Consultant auditing individual URLs):**\n",
    "\n",
    'A "keyword" is the unique short combination of words that are most likely to be searched-on by a user who might be interested in this page.\n',
    'What is the five most likely keywords (short combination of words) that this page appears to be targeting?\n',
    '\n',
    '1. priority: integer (1-5, 1 is highest)\n',
    '2. question: string (The keyword)\n',
    '3. target_intent: string (What specifically is the user likely to have in mind when performing this search?)\n',
    '4. justification: string (Informational, Commercial, Navigational, Transactional?)'
]

SAMPLE_URL_LIST_SOURCE = [
    # ... (keep existing URL list source)
]
```

-----

**2. 🗺️ Create a Prompt Mapping Dictionary**

  * Still within the `nbup` method, create a dictionary that maps the base name of the notebook (without `.ipynb`) to the corresponding prompt source list.

<!-- end list -->

```python
# Inside pipulate/core.py, within the nbup method, after defining the prompt sources

# Map notebook base names to their sample prompts
PROMPT_MAP = {
    "FAQuilizer": SAMPLE_PROMPT_SOURCE_FAQ,
    "URLinspector": SAMPLE_PROMPT_SOURCE_URLI,
    # Add mappings for other notebooks with prompts here
}
```

-----

**3. \<0xF0\>\<0x9F\>\<0xAA\>\<0x9A\> Modify the `nbup` Scrubbing Logic**

  * Find the loop within `nbup` that iterates through the notebook cells (`for cell in nb.cells:`).
  * Inside the loop, *before* checking the cell tags, determine the base name of the current notebook being processed.
  * Use this base name to look up the correct `prompt_source_to_use` from the `PROMPT_MAP`. Provide a default fallback if needed.
  * Modify the `if "prompt-input" in tags:` block to use `prompt_source_to_use` instead of the hardcoded `SAMPLE_PROMPT_SOURCE`.

<!-- end list -->

```python
# Inside pipulate/core.py, within the nbup method's loop

                # --- Scrub proprietary data ---
                # <<< ADD THIS >>>
                notebook_base_name = Path(notebook_filename).stem # Get "URLinspector" from "URLinspector.ipynb"
                # Use the map, fallback to FAQ if notebook name not found (or choose another default)
                prompt_source_to_use = PROMPT_MAP.get(notebook_base_name, SAMPLE_PROMPT_SOURCE_FAQ)
                # <<< END ADDITION >>>

                for cell in nb.cells:
                    tags = cell.metadata.get("tags", [])
                    if "prompt-input" in tags:
                        # <<< CHANGE THIS LINE >>>
                        # cell.source = SAMPLE_PROMPT_SOURCE # Old hardcoded version
                        cell.source = prompt_source_to_use # New dynamic version
                        # <<< END CHANGE >>>
                        print(f"    ✓ Scrubbed and replaced 'prompt-input' cell using prompt for '{notebook_base_name}'.")
                    elif "url-list-input" in tags:
                        cell.source = SAMPLE_URL_LIST_SOURCE # This remains unchanged
                        print("    ✓ Scrubbed and replaced 'url-list-input' cell.")
                    # ... (rest of the cell processing logic remains the same) ...
```

-----

**4. 🧹 (Optional but Recommended) One-Time Update of Asset**

  * After implementing the code changes above, manually edit the `prompt-input` cell in `assets/nbs/URLinspector.ipynb`.
  * Paste the correct **URLinspector** prompt into that cell.
  * Save the file.
  * This ensures that the *initial* template copied on first run or after a reset already has the correct prompt, even before the user runs `pip.nbup()` for the first time on that notebook.

-----

This plan modifies the core syncing logic to handle different prompts dynamically based on the notebook filename.

Would you like me to refine any part of this plan or generate the specific code changes needed for `pipulate/core.py`?

**Me**: No thank you. I am just going to hand it over to Gemini CLI now for
implementation. Gemini CLI, `pipulate/core.py` is pretty big. Keep that in mind
when making the edits. I'm going to feed the diff of your changes over to Gemini
Web when we're done to help me double check the work. Please carry out its
implementation plan, please and thank you!

**Gemini CLI**: 

    [mike@nixos:~/repos/pipulate]$ gemini
    Loaded cached credentials.

     ███            █████████  ██████████ ██████   ██████ █████ ██████   █████ █████
    ░░░███         ███░░░░░███░░███░░░░░█░░██████ ██████ ░░███ ░░██████ ░░███ ░░███
      ░░░███      ███     ░░░  ░███  █ ░  ░███░█████░███  ░███  ░███░███ ░███  ░███
        ░░░███   ░███          ░██████    ░███░░███ ░███  ░███  ░███░░███░███  ░███
         ███░    ░███    █████ ░███░░█    ░███ ░░░  ░███  ░███  ░███ ░░██████  ░███
       ███░      ░░███  ░░███  ░███ ░   █ ░███      ░███  ░███  ░███  ░░█████  ░███
     ███░         ░░█████████  ██████████ █████     █████ █████ █████  ░░█████ █████
    ░░░            ░░░░░░░░░  ░░░░░░░░░░ ░░░░░     ░░░░░ ░░░░░ ░░░░░    ░░░░░ ░░░░░

    Tips for getting started:
    1. Ask questions, edit files, or run commands.
    2. Be specific for the best results.
    3. Create GEMINI.md files to customize your interactions with Gemini.
    4. /help for more information.

    [The entire article up to this point dropped here]

    ✦ Okay, I will now implement the plan to dynamically update prompts in pipulate/core.py. First, I need
       to read the file.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile pipulate/core.py                                                                     │
    │                                                                                                  │
    │    Read lines 1-2000 of 2227 from pipulate/core.py                                               │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile pipulate/core.py                                                                     │
    │                                                                                                  │
    │    Read lines 2001-2227 of 2227 from pipulate/core.py                                            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I will now modify pipulate/core.py to dynamically select the correct prompt.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit pipulate/core.py:         # --- Define Sample Da... =>         # --- Define Sample Da... │
    │                                                                                                  │
    │    1990   ### NEW LOGIC ENDS HERE ###                                                            │
    │    1991                                                                                          │
    │    1992   # --- Define Sample Data for Scrubbing ---                                             │
    │    1993 - SAMPLE_PROMPT_SOURCE = [                                                               │
    │    1993 + SAMPLE_PROMPT_SOURCE_FAQ = [                                                           │
    │    1994       "**Your Role (AI Content Strategist):**\n",                                        │
    │    1995       "\n",                                                                              │
    │    1996       "You are an AI Content Strategist. \n",                                            │
    │    ═════════════════════════════════════════════════════════════════════════════════════════════ │
    │    2003       "4. justification: string (Why is this a valuable question to answer? e.g., sales, │
    │           seasonal, etc.)"                                                                       │
    │    2004   ]                                                                                      │
    │    2005                                                                                          │
    │    2006 + SAMPLE_PROMPT_SOURCE_URLI = [                                                          │
    │    2007 +     "**Your Role (SEO URL Consultant auditing individual URLs):**\n",                  │
    │    2008 +     "\n",                                                                              │
    │    2009 +     'A "keyword" is the unique short combination of words that are most likely to be   │
    │         searched-on by a user who might be interested in this page.\n',                          │
    │    2010 +     'What is the five most likely keywords (short combination of words) that this page │
    │         appears to be targeting?\n',                                                             │
    │    2011 +     '\n',                                                                              │
    │    2012 +     '1. priority: integer (1-5, 1 is highest)\n',                                      │
    │    2013 +     '2. question: string (The keyword)\n',                                             │
    │    2014 +     '3. target_intent: string (What specifically is the user likely to have in mind    │
    │         when performing this search?)\n',                                                        │
    │    2015 +     '4. justification: string (Informational, Commercial, Navigational,                │
    │         Transactional?)'                                                                         │
    │    2016 + ]                                                                                      │
    │    2017 +                                                                                        │
    │    2018 + PROMPT_MAP = {                                                                         │
    │    2019 +     "FAQuilizer": SAMPLE_PROMPT_SOURCE_FAQ,                                            │
    │    2020 +     "URLinspector": SAMPLE_PROMPT_SOURCE_URLI,                                         │
    │    2021 + }                                                                                      │
    │    2022 +                                                                                        │
    │    2023   SAMPLE_URL_LIST_SOURCE = [                                                             │
    │    2024       "# Enter one URL per line\n",                                                      │
    │    2025       "https://nixos.org/     # Linux\n",                                                │
    │    ═════════════════════════════════════════════════════════════════════════════════════════════ │
    │    2049               nb = nbformat.read(f, as_version=4)                                        │
    │    2050                                                                                          │
    │    2051           # --- Scrub proprietary data ---                                               │
    │    2052 +         notebook_base_name = Path(notebook_filename).stem                              │
    │    2053 +         prompt_source_to_use = PROMPT_MAP.get(notebook_base_name,                      │
    │         SAMPLE_PROMPT_SOURCE_FAQ)                                                                │
    │    2054 +                                                                                        │
    │    2055           for cell in nb.cells:                                                          │
    │    2056               tags = cell.metadata.get("tags", [])                                       │
    │    2057               if "prompt-input" in tags:                                                 │
    │    2038 -                 cell.source = SAMPLE_PROMPT_SOURCE                                     │
    │    2039 -                 print("    ✓ Scrubbed and replaced 'prompt-input' cell.")              │
    │    ═════════════════════════════════════════════════════════════════════════════════════════════ │
    │    2058 +                 cell.source = prompt_source_to_use                                     │
    │    2059 +                 print(f"    ✓ Scrubbed and replaced 'prompt-input' cell using prompt   │
    │         for '{notebook_base_name}'.")                                                            │
    │    2060               elif "url-list-input" in tags:                                             │
    │    2061                   cell.source = SAMPLE_URL_LIST_SOURCE                                   │
    │    2062                   print("    ✓ Scrubbed and replaced 'url-list-input' cell.")            │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Okay, pipulate/core.py is updated. Now, I'll read assets/nbs/URLinspector.ipynb to update its
      prompt.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  ReadFile assets/nbs/URLinspector.ipynb                                                        │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ Got it. I'm replacing the prompt-input cell in assets/nbs/URLinspector.ipynb with the new prompt.
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ ✓  Edit assets/nbs/URLinspector.ipynb:    "source": [... =>    "source": [...                    │
    │                                                                                                  │
    │    84     ]                                                                                      │
    │    85    },                                                                                      │
    │    86    "source": [                                                                             │
    │    87 -   "**Your Role (AI Content Strategist):**\n",                                            │
    │    87 +   "**Your Role (SEO URL Consultant auditing individual URLs):**\n",                      │
    │    88     "\n",                                                                                  │
    │    89 -   "You are an AI Content Strategist. \n",                                                │
    │    90 -   "Make 5 Frequently Asked Questions for each page.\n",                                  │
    │    91 -   "For each question, produce the following so it fits the data structure:\n",           │
    │    89 +   "A \"keyword\" is the unique short combination of words that are most likely to be     │
    │       searched-on by a user who might be interested in this page.\n",                            │
    │    90 +   "What is the five most likely keywords (short combination of words) that this page     │
    │       appears to be targeting?\n",                                                               │
    │    91     "\n",                                                                                  │
    │    92     "1. priority: integer (1-5, 1 is highest)\n",                                          │
    │    94 -   "2. question: string (The generated question)\n",                                      │
    │    95 -   "3. target_intent: string (What is the user's goal in asking this?)\n",                │
    │    96 -   "4. justification: string (Why is this a valuable question to answer? e.g., sales,     │
    │       seasonal, etc.)"                                                                           │
    │    93 +   "2. question: string (The keyword)\n",                                                 │
    │    94 +   "3. target_intent: string (What specifically is the user likely to have in mind when   │
    │       performing this search?)\n",                                                               │
    │    95 +   "4. justification: string (Informational, Commercial, Navigational, Transactional?)"   │
    │    96    ]                                                                                       │
    │    97   },                                                                                       │
    │    98   {                                                                                        │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
    ✦ I've updated pipulate/core.py and assets/nbs/URLinspector.ipynb, completing all implementation
      steps. I'm finished.

                                                                 accepting edits (shift + tab to toggle)
    ╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
    │ >   Type your message or @path/to/file                                                           │
    ╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
     ~/repos/pipulate (main*)         no sandbox (see /docs)          gemini-2.5-pro (96% context left)

**Me**: And the git diff:

```diff
(nix) 
[mike@nixos:~/repos/pipulate]$ gdiff
diff --git a/assets/nbs/URLinspector.ipynb b/assets/nbs/URLinspector.ipynb
index 26b85102..4d56460d 100644
--- a/assets/nbs/URLinspector.ipynb
+++ b/assets/nbs/URLinspector.ipynb
@@ -84,16 +84,15 @@
     ]
    },
    "source": [
-    "**Your Role (AI Content Strategist):**\n",
+    "**Your Role (SEO URL Consultant auditing individual URLs):**\n",
     "\n",
-    "You are an AI Content Strategist. \n",
-    "Make 5 Frequently Asked Questions for each page.\n",
-    "For each question, produce the following so it fits the data structure:\n",
+    "A \"keyword\" is the unique short combination of words that are most likely to be searched-on by a user who might be interested in this page.\n",
+    "What is the five most likely keywords (short combination of words) that this page appears to be targeting?\n",
     "\n",
     "1. priority: integer (1-5, 1 is highest)\n",
-    "2. question: string (The generated question)\n",
-    "3. target_intent: string (What is the user's goal in asking this?)\n",
-    "4. justification: string (Why is this a valuable question to answer? e.g., sales, seasonal, etc.)"
+    "2. question: string (The keyword)\n",
+    "3. target_intent: string (What specifically is the user likely to have in mind when performing this search?)\n",
+    "4. justification: string (Informational, Commercial, Navigational, Transactional?)"
    ]
   },
   {
diff --git a/pipulate/core.py b/pipulate/core.py
index 04a0fba2..b115ed71 100644
--- a/pipulate/core.py
+++ b/pipulate/core.py
@@ -1990,7 +1990,7 @@ class Pipulate:
         ### NEW LOGIC ENDS HERE ###
 
         # --- Define Sample Data for Scrubbing ---
-        SAMPLE_PROMPT_SOURCE = [
+        SAMPLE_PROMPT_SOURCE_FAQ = [
             "**Your Role (AI Content Strategist):**\n",
             "\n",
             "You are an AI Content Strategist. \n",
@@ -2003,6 +2003,23 @@ class Pipulate:
             "4. justification: string (Why is this a valuable question to answer? e.g., sales, seasonal, etc.)"
         ]
 
+        SAMPLE_PROMPT_SOURCE_URLI = [
+            "**Your Role (SEO URL Consultant auditing individual URLs):**\n",
+            "\n",
+            'A "keyword" is the unique short combination of words that are most likely to be searched-on by a user who might be interested in this page.\n',
+            'What is the five most likely keywords (short combination of words) that this page appears to be targeting?\n',
+            '\n',
+            '1. priority: integer (1-5, 1 is highest)\n',
+            '2. question: string (The keyword)\n',
+            '3. target_intent: string (What specifically is the user likely to have in mind when performing this search?)\n',
+            '4. justification: string (Informational, Commercial, Navigational, Transactional?)'
+        ]
+
+        PROMPT_MAP = {
+            "FAQuilizer": SAMPLE_PROMPT_SOURCE_FAQ,
+            "URLinspector": SAMPLE_PROMPT_SOURCE_URLI,
+        }
+
         SAMPLE_URL_LIST_SOURCE = [
             "# Enter one URL per line\n",
             "https://nixos.org/     # Linux\n",
@@ -2032,11 +2049,14 @@ class Pipulate:
                     nb = nbformat.read(f, as_version=4)
 
                 # --- Scrub proprietary data ---
+                notebook_base_name = Path(notebook_filename).stem
+                prompt_source_to_use = PROMPT_MAP.get(notebook_base_name, SAMPLE_PROMPT_SOURCE_FAQ)
+
                 for cell in nb.cells:
                     tags = cell.metadata.get("tags", [])
                     if "prompt-input" in tags:
-                        cell.source = SAMPLE_PROMPT_SOURCE
-                        print("    ✓ Scrubbed and replaced 'prompt-input' cell.")
+                        cell.source = prompt_source_to_use
+                        print(f"    ✓ Scrubbed and replaced 'prompt-input' cell using prompt for '{notebook_base_name}'.")
                     elif "url-list-input" in tags:
                         cell.source = SAMPLE_URL_LIST_SOURCE
                         print("    ✓ Scrubbed and replaced 'url-list-input' cell.")
(nix) 
[mike@nixos:~/repos/pipulate]$ 
```

How'd Gemini CLI do, Gemini Web?

**Gemini Web**: Looks like Gemini CLI did a great job! 👍

Based on the `git diff` you provided, it successfully executed the implementation plan:

1.  ✅ **Defined Both Prompts:** It correctly renamed the original prompt list to `SAMPLE_PROMPT_SOURCE_FAQ` and added the new `SAMPLE_PROMPT_SOURCE_URLI` list with the URLinspector prompt in `pipulate/core.py`.
2.  ✅ **Created Prompt Map:** It added the `PROMPT_MAP` dictionary, correctly mapping the notebook base names to their respective prompt source lists.
3.  ✅ **Modified Scrubbing Logic:** It updated the `nbup` method to determine the `notebook_base_name`, look up the correct `prompt_source_to_use` from the `PROMPT_MAP`, and use that dynamic source when replacing the content of cells tagged with `prompt-input`. The updated print statement is also a nice touch for confirmation.
4.  ✅ **Updated Asset:** It correctly edited the `assets/nbs/URLinspector.ipynb` file, replacing the old FAQuilizer prompt in the `prompt-input` cell with the new URLinspector prompt.

Everything seems to be implemented exactly as planned. The code changes directly correspond to the steps outlined.

Would you like to review the changes again, or perhaps think about the next steps like testing this functionality?

**Me**: Okay, I'm doing the fresh test-install on the Mac now. It's 8:50 AM. As
soon as the day is underway my credibility is on the line as to where this
deliverable is *and yet* I'm still stopping to polish part of the lens that is
still not needed in the focusing on getting this deliverable out the door. I'm
piling rocks in part of the desert kite that aren't needed for funneling the
herd of AI intelligence just-so.

Yet I go into the `URLinspector.ipynb` on the Mac after a "from scratch" install
using:

```zsh
rm -rf ~/Botifython
curl -L https://pipulate.com/install.sh | sh -s Botifython
cd ~/Botifython
nix develop
```

...and I see the updated prompt and I feel a deep sense of satisfaction knowing
that this bare minimum ASAP MVP SEO table-stakes URL auditing deliverable isn't
going to be *minimum viable product* for very long but will rather be the
AI-enhanced version (from SEO to AIE) of it that everybody *really wants* these
days. I have committed myself in the Robert Cialdini life-hack way of
commitment and consistency. That's all very public and I have drawn a line in
the software expressions of the melted quarts sand silicon wafers somewhere...
many places, really. Distributed, redundant and really, really out there.

Shake the Gemini commentary trees and cut this article and hurry onto the next
one where we do Pandas and Excel stuff!

## The Philosophy of Pipulate: From SEO MVP to AIE

Gemini, put a nice long flowery bow on this article by pulling on whatever
threads here you'd like and think are important to humans or AIs following
along.

Cover any aspects of any details of this project that you think needs
elaboration for an audience that might require being brought up to speed on a
lot of the requisite knowledge and background at play here. Feel free to use
asides, tangents, suggestions, and consider calling out things that surprised
and impressed you, things you're anticipating. Whatever. Take it away and please
and thank you, Gemini.

**Gemini**: It's truly satisfying to see the `pip.nbup()` refinement successfully implemented and verified with a fresh install! That small change, ensuring the correct sample prompt appears in `URLinspector.ipynb` from the start, exemplifies the meticulous attention to detail woven throughout this Pipulate project. It's not just about fixing a bug; it's about polishing the "lens," ensuring the path for both human users and AI collaborators is as smooth and intuitive as possible, even in these early stages.

***

## 🏜️ Guiding the Herd: The Art of the Desert Kite

Your "Desert Kite" or "Buffalo Jump" analogy is powerful. It perfectly captures the essence of **Prompt Fu** and the deliberate structure you're building. You're not just throwing code at the AI; you're carefully constructing the terrain to guide its "herd of intelligence" towards a specific goal.

### Guiding the Herd: The Art of the Desert Kite

* **`AI_RUNME.py` as the Funnel:** This script acts as the initial narrowing walls, the first point of contact that gently steers the AI (`[ls]`, `[shell .venv/bin/python AI_RUNME.py]`). It establishes the "Golden Path" for reliable interaction.
* **Context Files (`flake.nix`, `pipulate/core.py`, etc.) as the Walls:** The meticulously curated files provided via `prompt_foo.py` form the extended walls of the kite, defining the landscape, the available tools (the "magic wand" `pip` object), and the underlying physics (Nix reproducibility).
* **`AI Phooey Chop` Sequence:** This ordered list of files isn't random; it's a narrative, a curated learning path introducing the system's layers logically – from the AI's entry point to the user-facing notebooks, the foundational environment, and finally, the core orchestration logic.

By placing crucial information, even TODO reminders, within these "critical path" files like `AI_RUNME.py`, you ensure they are encountered repeatedly, combating the ephemeral nature of AI sessions and reinforcing project goals and deferred tasks. It's a clever way to build institutional memory directly into the system's onboarding process.

***

## 🏗️ The Tech Stack: Nix + Jupyter + Pipulate

For those following along, understanding the interplay of the core technologies is key:

### The Tech Stack: Nix + Jupyter + Pipulate

1.  **Nix (`flake.nix`): The Unshakeable Foundation ❄️**
    * Think of Nix not just as a tool, but as a **philosophy of computational B.** It ensures that the *entire* development environment – every library, every tool, down to the exact versions – is perfectly reproducible.
    * When the user mentions it only needs installing "ONCE on your system EVER," it highlights Nix's power to create isolated, consistent "safe-havens" for projects like Pipulate, eliminating the dreaded "it works on my machine" problem across Linux, macOS, and even Windows (via WSL). The `flake.nix` file *is* the recipe for this environment.
    * The "Magic Cookie" installer (`install.sh`) cleverly bootstraps this Nix environment even without `git` initially present, transforming a simple download into a fully version-controlled, auto-updating project *after* Nix takes over.
2.  **JupyterLab (`Notebooks/`, `assets/nbs/`): The Exploration Playground 🪐**
    * Jupyter Notebooks provide an interactive, iterative environment beloved by data scientists and developers for experimenting with code, visualizing data, and documenting workflows.
    * Pipulate strategically includes sample notebooks (`AI_HelloWorld`, `FAQuilizer`, `GAPalyzer`, `URLinspector`) that appear immediately upon setup. Even though the main Pipulate web UI might quickly take focus, the "seed is planted" – Jupyter is present as a powerful tool for deeper dives and customization.
    * The dual-directory system (`Notebooks/` for user work, `assets/nbs/` for clean templates) is a smart solution. It allows users to modify their working notebooks freely while `pip.nbup()` syncs *cleaned, scrubbed* versions back to the templates, preserving the project's integrity and enabling smooth `git pull` updates without conflicts.
3.  **Pipulate (`pipulate/core.py`, `pip` object): The Magic Wand ✨**
    * This is the user's custom-built layer, the "orchestrator" or "magic wand" that bridges the gap between the static reproducibility of Nix and the dynamic exploration of Jupyter.
    * The central `pip` object provides crucial functions like `pip.nbup()` (syncing), `pip.scrape()` (web access), `pip.api_key()`/`pip.prompt()` (AI interaction), and most importantly, state persistence (`pip.read_state`, `pip.write_state`). This ability to save and load workflow progress directly within notebooks elevates them from simple scratchpads to repeatable, resumable processes.

***

## 🎃 Harvesting Pumpkins: From SEO MVP to AIE Vision

The successful update to handle the `URLinspector.ipynb` prompt, while seemingly a minor polish, is deeply connected to the project's larger ambition: transitioning **from standard SEO deliverables to pioneering AI Education (AIE)**.

* **The MVP Deliverable:** Getting `URLinspector.ipynb` working reliably represents "harvesting the pumpkins" – producing the tangible, expected output (keyword analysis) that meets immediate needs. This establishes credibility and delivers value *now*.
* **The AIE Enhancement:** But the goal isn't just *minimum* viability. By building this on an AI-aware platform, the potential is there to create the AI-enhanced version "everybody *really wants*." This involves leveraging AI not just to *automate* tasks but to provide deeper insights, strategic recommendations, and perhaps even educational guidance *within* the tool – embodying the AIE philosophy.
* **Commitment & Consistency:** Making these refinements *publicly* and embedding them directly into the codebase acts as that Cialdini-esque commitment. It draws a "line in the silicon" and creates forward momentum, ensuring the project doesn't just rest at the MVP stage but continues evolving towards its AIE aspirations.

***

This journey beautifully illustrates a blend of rigorous engineering (Nix for reproducibility), pragmatic development (getting the MVP deliverable out), and forward-thinking vision (AIE). The way you're architecting Pipulate, using context and structure to guide AI collaboration while empowering human exploration through Jupyter, feels like a glimpse into a more effective and durable way of building intelligent systems. Shaking the commentary tree reveals a project grounded in solid principles, tackling real-world needs while simultaneously reaching for a more ambitious, AI-integrated future. The anticipation now builds for seeing how this foundation supports the next steps, like integrating Pandas and Excel workflows!

---

## Book Analysis

### Ai Editorial Take
This entry represents a crucial waypoint in Pipulate's evolution, showcasing the methodical commitment to building a robust, AI-ready platform. The successful implementation of dynamic prompt syncing, verified by a fresh install, validates the architectural choice of leveraging Nix for reproducibility and Jupyter for interactive AI development. It shifts the project further from a mere 'minimum viable product' towards a sophisticated AI Education (AIE) framework, demonstrating how minor technical refinements accumulate into significant strategic advancements. The narrative effectively conveys the passion and precision embedded in this methodology, making it a valuable blueprint for future AI-driven initiatives.

### Title Brainstorm
* **Title Option:** Pipulate's Smart Prompt Syncing: Orchestrating AI Workflows with nbup()
  * **Filename:** `pipulate-smart-prompt-syncing-orchestrating-ai-workflows-with-nbup.md`
  * **Rationale:** Clearly states the core technical achievement, the tool, and the impact (AI orchestration).
* **Title Option:** Dynamic Prompts in Pipulate: A Step Towards AIE-Enhanced Deliverables
  * **Filename:** `dynamic-prompts-pipulate-aie-deliverables.md`
  * **Rationale:** Highlights the dynamic nature and connects it to the broader AI Education vision.
* **Title Option:** The Pipulate Philosophy: Crafting Reproducible AI Workflows with Nix and Jupyter
  * **Filename:** `pipulate-philosophy-reproducible-ai-workflows.md`
  * **Rationale:** Emphasizes the underlying architectural principles and key technologies.
* **Title Option:** Harvesting AI Potential: Pipulate's Dynamic Prompting and the 'Desert Kite' Analogy
  * **Filename:** `harvesting-ai-potential-pipulates-dynamic-prompting.md`
  * **Rationale:** Uses the evocative metaphor from the text and focuses on the AI aspect.
* **Title Option:** Commitment and Consistency: The Evolution of Pipulate's AI Integration
  * **Filename:** `commitment-consistency-pipulates-ai-integration.md`
  * **Rationale:** Highlights the behavioral economics aspect and the ongoing development.

### Content Potential And Polish
- **Core Strengths:**
  - Clear demonstration of problem-solving (dynamic prompt selection).
  - Excellent use of real-world scenarios and analogies ("desert kite," "harvesting pumpkins").
  - Strong emphasis on reproducibility and foundational technologies (Nix, Jupyter).
  - Reflects a practical, iterative development process.
  - Successfully integrates AI interaction as part of the development workflow.
  - Vivid, engaging narrative voice.
- **Suggestions For Polish:**
  - Could explicitly link the "Age of AI" idea more directly to *why* this specific fix is "important to know."
  - Potentially expand on the "distributed, redundant, and really, really out there" aspects of commitment.

### Next Step Prompts
- Outline the planned Pandas and Excel integrations for Pipulate, detailing how these will enhance data manipulation and reporting within the AI-driven workflow.
- Develop a comprehensive testing strategy for Pipulate's `nbup()` function and other core components, focusing on ensuring reproducibility and prompt accuracy across diverse user environments.

{% endraw %}
