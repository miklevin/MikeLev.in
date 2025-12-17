---
title: 'Human-in-the-Loop SEO: Organizing SEMRush Downloads with Python'
permalink: /futureproof/human-in-the-loop-seo-semrush-downloads/
description: 'This entry encapsulates a crucial turning point in my workflow philosophy:
  balancing automation with ''human-in-the-loop'' efficiency. It highlights the practical
  application of Python for mundane tasks like file organization, freeing up cognitive
  load for strategic SEO. I''m actively porting years of accumulated, non-StackOverflow
  domain wisdom from older notebooks into Pipulate, ensuring that nuanced, hard-won
  insights aren''t lost to generic generative AI. This process is about building a
  robust, repeatable ''sausage factory'' for SEO, valuing small, deliberate chisel-strikes
  over grand, brittle automation attempts. The journey is about refining the *right*
  kind of organization and respecting the organic flow of discovery.'
meta_description: 'Learn a low-friction workflow for SEO data: manually download SEMRush
  files and use Python to automatically move and organize them into a project-specific
  structure, leveraging human insight.'
meta_keywords: SEO workflow, SEMRush downloads, Python automation, Jupyter Notebooks,
  data organization, human-in-the-loop, domain expertise, Pipulate
layout: post
sort_order: 5
---

{% raw %}


## Setting the Stage: Context for the Curious Book Reader

In the ever-evolving landscape of SEO, the pursuit of efficiency often clashes with the practical realities of data acquisition from powerful, yet proprietary, platforms like SEMRush. This entry delves into a nuanced approach to managing essential competitor data downloads. Instead of falling into the trap of brittle browser automation, we explore a 'human-in-the-loop' strategy. Here, the user's manual interaction for downloading is combined with Python's precision for automated file organization, creating a robust, low-friction workflow that respects existing browser sessions and preserves valuable domain expertise. It’s a testament to the power of thoughtful process design over brute-force automation, laying the groundwork for more complex data analysis within the Pipulate framework.

---

## Technical Journal Entry Begins

My initial thought with this project was to just always download into the user's
browser's default download directory and just process all the files from there,
but this is an ill-fated strategy. I do need to move them out of the user's
download directory and into a better location, and likely one that avoids
conflict on subsequent re-runs, but with the shallowest possible directory
structure so there's not a lot of clicking-deep into nested directory
structures. I want things organized but not *too organized* so that you roll
your eyes when drilling down to find your files.

Anyhow, I figure a `downloads/` folder inside `Notebooks/` is as good a
convention as any and consistent with other apps that do such things for:

- `browser_cache/`
- `data/`
- `logs/`
` `output/`

## The `downloads/` Directory: A Structured Approach

So I'm adding `downloads/` to that regime and inside of that should be a
directory that uses the value of the `job` variable as the folder name. Okay,

## Automated Collection and Organization
that's good. And all the downloads should be moved from the user's download
directory into there. And all those files are going to have either `.csv` or
`.xlsx` extensions from the SEMRush downloads. If Ahrefs is reading this, reach

## Why Human-Centric Workflows Excel
out to me. I'll add support for you, but work only gives me an SEMRush account.

Okay, so this function:

```python
import nbformat
from pathlib import Path

def get_competitors_from_notebook(notebook_filename="GAPalyzer.ipynb"):
    """Parses this notebook to get the domain list from the 'url-list-input' cell."""
    try:
        notebook_path = Path(notebook_filename)
        with open(notebook_path, 'r', encoding='utf-8') as f:
            nb = nbformat.read(f, as_version=4)
        
        for cell in nb.cells:
            if "url-list-input" in cell.metadata.get("tags", []):
                domains_raw = cell.source
                domains = [
                    line.split('#')[0].strip() 
                    for line in domains_raw.splitlines() 
                    if line.strip() and not line.strip().startswith('#')
                ]
                return domains
        print("⚠️ Warning: Could not find a cell tagged with 'url-list-input'.")
        return []
    except Exception as e:
        print(f"❌ Error reading domains from notebook: {e}")
        return []

# --- Main Logic ---
print("🚀 Generating SEMrush URLs for GAP analysis...")

domains = get_competitors_from_notebook()
url_template = "https://www.semrush.com/analytics/organic/positions/?db=us&q={domain}&searchType=domain"

if not domains:
    print("🛑 No domains found. Please add competitor domains to the 'url-list-input' cell and re-run.")
else:
    print(f"✅ Found {len(domains)} competitor domains. Click the links below to open each report:")
    print("-" * 30)
    for i, domain in enumerate(domains):
        full_url = url_template.format(domain=domain)
        print(f"{i+1}. {domain}:\n   {full_url}\n")
```

...looks at a cell labeled `url-list-input` in the Notebook and creates a list

## Generating SEMrush Download Links
of links that the user can click to download their Excel or CSV files and those
accumulate up in the downloads directory. If the contents of the
`url-list-input` cell is this:

    nixos.org/
    pypi.org/
    neovim.io/
    git-scm.com/

...then the output of this function looks like this:

```log
🚀 Generating SEMrush URLs for GAP analysis...
✅ Found 4 competitor domains. Click the links below to open each report:
------------------------------
1. nixos.org/:
   https://www.semrush.com/analytics/organic/positions/?db=us&q=nixos.org/&searchType=domain

2. pypi.org/:
   https://www.semrush.com/analytics/organic/positions/?db=us&q=pypi.org/&searchType=domain

3. neovim.io/:
   https://www.semrush.com/analytics/organic/positions/?db=us&q=neovim.io/&searchType=domain

4. git-scm.com/:
   https://www.semrush.com/analytics/organic/positions/?db=us&q=git-scm.com/&searchType=domain
```

After you click all those links and do all those downloads, you're going to have
a directory that looks like this:

```bash
[mike@nixos:~/Downloads]$ lsp
/home/mike/Downloads/git-scm.com_-organic.Positions-us-20251016-2025-10-18T00_46_03Z.xlsx
/home/mike/Downloads/neovim.io_-organic.Positions-us-20251016-2025-10-18T00_45_41Z.xlsx
/home/mike/Downloads/nixos.org_-organic.Positions-us-20251016-2025-10-18T00_44_58Z.xlsx
/home/mike/Downloads/pypi.org_-organic.Positions-us-20251016-2025-10-18T00_45_17Z.xlsx
[mike@nixos:~/Downloads]$
```

`lsp` is an alias in my system for:

```nix
    lsp = ''ls -d -1 "$PWD"/*'';
```

And so what we want is to have a cell in the Notebook which when clicked will
move all those files with that general pattern, in particular any file with
`-organic.Positions` in it and ending with `.csv` or `.xlsx` into a directory in
the Notebook structure similar to how it works with:

- `browser_cache/`
- `data/`
- `logs/`
` `output/`

...but `downloads/{job}/`

And every time that cell is run it just dumps whatever new ones you happened to
have downloaded subsequent to the last run into that new location. In this way
you can just keep accumulating more and more as you discover new competitors in
your investigation and have this Notebook open. You:

1. Add a new competitor to the `url-list-input` cell and save.
2. You run the cell that generates the new links.
3. You download any new ones. The already visited links will be purple because
   web links, you know. No fancy filtering required.
4. You run the next cell down, the one that will have the code I am asking you
   to produce, and it will ***move*** them over to the new location.

We update the configuration variables to include the download path.

```python
# --- ⚙️ Workflow Configuration ---
ROW_LIMIT = 3000  # Final Output row limit, low for fast iteration
COMPETITOR_LIMIT = 3  # Limit rows regardless of downloads, low for fast iteration
BROWSER_DOWNLOAD_PATH = "~/Downloads"  # The default directory where your browser downloads files
```

And so the function you write now should use this "from" location. It should
also make the paths if they're not there already. We are keeping all the logic
in the Notebook for now. Later we will push reusable things into
`secretsauce.py` like you see in `FAQuilizer.ipynb` but for now we work directly
in the Notebook. That's part of the rapid iteration sausage factory thing. First
flesh it out. Then promote things into the background modules, either
`secretsauce.py` or `pipulate/core.py` as appropriate. But for now the rule is

## The Human-in-the-Loop Philosophy
*As Simple As Possible* and I'm just giving you context because you might see
some useful things there like knowing your Notebook path for making the folders.

Please may I have the function?

**Gemini**: Context verified.

That's a sound strategy for managing ephemeral downloads and ensuring a repeatable workflow. Moving the files out of the volatile default downloads directory into a structured, job-specific folder within the project is crucial for durability and collaboration.

Here is the function, designed to be placed directly into a cell in the `GAPalyzer.ipynb` notebook. It uses the `job` and `BROWSER_DOWNLOAD_PATH` variables defined earlier in the notebook and includes necessary imports and path handling.

```python
# %% editable=true slideshow={"slide_type": ""}
import os
import shutil
from pathlib import Path
import glob

def collect_semrush_downloads(job: str, download_path_str: str, file_pattern: str = "*-organic.Positions*.xlsx"):
    """
    Moves downloaded SEMRush files matching a pattern from the user's download
    directory to a job-specific 'downloads/{job}/' folder within the Notebooks/
    directory.
    
    Args:
        job (str): The current job ID (e.g., "gapalyzer-01").
        download_path_str (str): The user's default browser download path (e.g., "~/Downloads").
        file_pattern (str): The glob pattern to match SEMRush files.
    """
    print("📦 Starting collection of new SEMRush downloads...")

    # 1. Define source and destination paths
    # Resolve the user's download path (handles ~)
    source_dir = Path(download_path_str).expanduser()
    
    # Define the destination path relative to the current working directory (Notebooks/)
    # This assumes the Notebook is run from the 'Notebooks' directory or its path is correct.
    destination_dir = Path("downloads") / job

    # 2. Create the destination directory if it doesn't exist
    destination_dir.mkdir(parents=True, exist_ok=True)
    print(f"Destination folder created/ensured: '{destination_dir.resolve()}'")

    # 3. Find files in the source directory matching the pattern
    # We use glob.glob for pattern matching, searching for both .xlsx and .csv
    files_to_move = []
    
    # Check for .xlsx files
    xlsx_files = glob.glob(str(source_dir / file_pattern))
    files_to_move.extend(xlsx_files)
    
    # Check for .csv files
    csv_pattern = file_pattern.replace(".xlsx", ".csv")
    csv_files = glob.glob(str(source_dir / csv_pattern))
    files_to_move.extend(csv_files)

    if not files_to_move:
        print("⚠️ No new files matching the pattern were found in the download directory. Skipping move.")
        return

    # 4. Move the files
    move_count = 0
    for source_file_path in files_to_move:
        source_file = Path(source_file_path)
        dest_file = destination_dir / source_file.name
        
        # Only move if the file doesn't already exist in the destination (to avoid overwriting)
        # This protects manually modified files, but new downloads will have unique timestamps anyway.
        if dest_file.exists():
             # Option: could log that it exists or decide to overwrite/rename. 
             # Given the SEMRush filename pattern contains a unique timestamp, we expect 
             # them to be new. Let's just avoid redundant logging.
             continue
        
        try:
            shutil.move(source_file, dest_file)
            print(f"  -> Moved: {source_file.name}")
            move_count += 1
        except Exception as e:
            print(f"  -> ❌ Error moving {source_file.name}: {e}")

    print(f"✅ Collection complete. {move_count} new files moved to '{destination_dir}'.")
    
    # --- Execute the function in the notebook ---
collect_semrush_downloads(job, BROWSER_DOWNLOAD_PATH)
```

**Me**: Excellent! Here's the output:

    📦 Starting collection of new SEMRush downloads...
    Destination folder created/ensured: '/home/mike/repos/pipulate/Notebooks/downloads/gapalyzer-01'

## Preserving Domain Expertise Over Generative Averaging
      -> Moved: git-scm.com_-organic.Positions-us-20251016-2025-10-18T00_46_03Z.xlsx
      -> Moved: neovim.io_-organic.Positions-us-20251016-2025-10-18T00_45_41Z.xlsx
      -> Moved: pypi.org_-organic.Positions-us-20251016-2025-10-18T00_45_17Z.xlsx
      -> Moved: nixos.org_-organic.Positions-us-20251016-2025-10-18T00_44_58Z.xlsx
    ✅ Collection complete. 4 new files moved to 'downloads/gapalyzer-01'.

I don't show git diff's on Notebook `.ipynb` changes because of nuanced little
issues with something called `nbstripout` that I'm using to keep the git repo
clean from Notebook noise. But anyway this worked great. And here's the folder
output location:

```bash
[mike@nixos:~/repos/pipulate/Notebooks/downloads/gapalyzer-01]$ lsp
/home/mike/repos/pipulate/Notebooks/downloads/gapalyzer-01/git-scm.com_-organic.Positions-us-20251016-2025-10-18T00_46_03Z.xlsx
/home/mike/repos/pipulate/Notebooks/downloads/gapalyzer-01/neovim.io_-organic.Positions-us-20251016-2025-10-18T00_45_41Z.xlsx
/home/mike/repos/pipulate/Notebooks/downloads/gapalyzer-01/nixos.org_-organic.Positions-us-20251016-2025-10-18T00_44_58Z.xlsx
/home/mike/repos/pipulate/Notebooks/downloads/gapalyzer-01/pypi.org_-organic.Positions-us-20251016-2025-10-18T00_45_17Z.xlsx

[mike@nixos:~/repos/pipulate/Notebooks/downloads/gapalyzer-01]$
```

Perfect! This is indicative of my new way of working as I proceed through this
port of an old Notebook from before Pipulate was the centralized repository for
all things like this in my life, and hopefully in the lives of SEOs around the
world as it's discovered. The principle here is... well there's a lot of weird
stuff worth pointing out as I put the wrap on this article.

First, no fancy brittle browser automation. I could do it. I have full blown
power-stealth selenium automation built-in already, for Pete's sake! Why not?
Friction. The human in the loop advantage. It's not like I'm going to build
rapid consecutive downloads from SEMRush without going through the API into a
black room automation system, nope! This simply makes it easy to do it the
manual way and within your normal browser context, so your very own user profile
is used, so your SEMRush password that you probably have saved in your browser
is used. It's YOU. It's not automaton. I'm just giving you links to click. And
those links open in browser TABS! I don't even open a new window for fear of
severing session context. So no automation arms race for this kind of stuff
here. Scraping sites for SEO, sure. Not for SEMRush downloads.

What other principles? Hmmm, small chisel-strikes. We already established that
ad nauseam here — almost as much as *rabbit hole hygiene,* haha! How to rappel
down rabbit holes. Hmm, in this case I got my ass kicked by a rabbit hole
earlier today — trying to let the AI build a new GAPalyzer based on what I was
thinking was my old sloppy one. Truth is, my old "sloppy" Notebook has years of
accumulated wisdom and it's NOT the kind of general population kind of
StackOverflow wisdom that's out there, no siree. This is bona fide 30 years in
the business SEO domain expertise. Back to AltaVista? No, I go back to
WebCrawler and was using Gopher and FTP on the Internet before there was a Web.
Use your old arcane knowledge. It's all those weird curly-cues of code you
hardly remember why you did it where the value's at. And that gets lost in
generative averaging conversion.

And THAT sets us up for the next article just perfectly as I go top-down in the
old Notebook just like Notebooks run as linear sequential workflows — their core
strength that everybody forgets about this day and age of non-linear,
concurrent, mind-bogglingly confusing everything! ...everything but Python
Jupyter Notebooks for those who know the secret.

## Next Steps: Data Wrangling and Project Evolution

Put a log and flowery bow on it full of flourish and any parting shot strings
you want to pull, asides, tangents, suggestions, things that surprised and
impressed you, things you're anticipating. Whatever. Take it away and please and
thank you, Gemini.

**Gemini**: That's fantastic! The execution was **perfect**, validating your low-friction, high-durability approach to file management. The four files were successfully **moved** (not copied) into the job-specific folder `Notebooks/downloads/gapalyzer-01`, which is exactly what you need for a clean and repeatable workflow.

## Key Principles & The "Human-in-the-Loop" Advantage 🧠

Your commentary here crystallizes the brilliant design philosophy behind this step. It's not about automation at all costs; it's about **intelligent workflow enhancement**.

1.  **Respecting the Session & Trusting the User:** By not automating the SEMRush download, you honor the user's existing browser session, authentication, and personalized settings. This is a crucial design decision that avoids an "automation arms race" against platform login mechanisms. The SEO professional **is** the most efficient tool for clicking the links, and your code simply provides the **links and the file plumbing**. It leverages the "human-in-the-loop" for authentication and decision-making, while the code handles the **mundane file cleanup and organization**.

2.  **The *Right* Level of Organization:** You've found the sweet spot between chaos and bureaucracy.
    * **Old Chaos:** Files dumped into `~/Downloads`, guaranteed to be overwritten or lost.
    * **New Simplicity:** Files neatly organized under `Notebooks/downloads/{job}/`. Shallow, descriptive, and co-located with the rest of the project's data (like `data/` and `output/`). This drastically reduces the "eye-roll" factor of deep directory traversal.

3.  **Resilience Against Generative Averaging:** Your insight on the loss of **arcane domain wisdom** during generative averaging is profound and the central justification for your current strategy. Generative AI is excellent for synthesis and boilerplate, but it necessarily "averages out" the accumulated, non-StackOverflow, 30-year domain expertise baked into your existing code. **Loyal porting** is the anti-fragile path here: *capture the hard-won logic first, then apply generative AI for rapid iteration later.*

## Anticipation for the Next Steps

You've now successfully completed the first two, critical, non-data steps of the new workflow:

1.  **Configuration & Setup:** Defining `job`, `ROW_LIMIT`, `BROWSER_DOWNLOAD_PATH`.
2.  **Acquisition Plumbing:** Generating links for manual download and implementing the `collect_semrush_downloads` function to move and organize those files.

The next natural step in your **linear, sequential Notebook flow** will be the **Stack 'Em** equivalent for the GAPalyzer: reading all those freshly collected CSV/XLSX files, combining them, and transforming them into a single, canonical DataFrame ready for analysis.

I anticipate the complexity will immediately shift from file management to **data-wrangling**, as you'll need to account for:

* Reading both `.csv` and `.xlsx` formats.
* Handling potential header rows or column name differences between files.
* Identifying and cleaning the competitor's domain from the SEMRush filename itself.

Your decision to work **top-down** through the old Notebook's sequential logic is the perfect way to ensure all those accumulated "curly-cues of code" that hold the real domain value are correctly transposed into Pipulate's new home.

It truly is a **Sausage Factory** you're building: robust input plumbing, clean workspace organization, and then the proprietary, battle-tested process starts in the middle. Well done.

---

## Book Analysis

### Ai Editorial Take
This journal entry is a foundational piece for the 'Pipulate' book, encapsulating a pragmatic and deeply insightful approach to SEO workflow. It perfectly balances technical problem-solving with a philosophical stance on automation and human intelligence. The core value lies in its demonstration of how to design workflows that are resilient, efficient, and respectful of both user experience and hard-won domain knowledge. It serves as a compelling argument for strategic, targeted automation rather than blanket application. The discussion on 'generative averaging' vs. 'arcane knowledge' is particularly powerful and resonates with the broader themes of leveraging specialized expertise in an AI-driven world.

### Title Brainstorm
* **Title Option:** Human-in-the-Loop SEO: Organizing SEMRush Downloads with Python
  * **Filename:** `human-in-the-loop-seo-semrush-downloads.md`
  * **Rationale:** Clearly states the core methodology (human-in-the-loop), the tool (Python), and the specific task (SEMRush downloads), making it highly discoverable and informative.
* **Title Option:** Low-Friction SEO Data Workflow: Manual Downloads, Automated Organization
  * **Filename:** `low-friction-seo-data-workflow.md`
  * **Rationale:** Emphasizes the 'low-friction' and the balance between manual input and automated processing, appealing to a broad audience seeking efficient solutions.
* **Title Option:** Beyond Automation: Jupyter Notebooks for Smart SEMRush File Management
  * **Filename:** `jupyter-notebooks-semrush-file-management.md`
  * **Rationale:** Highlights the Jupyter Notebooks aspect and positions the approach as smarter than conventional full automation, focusing on file management.
* **Title Option:** The Anti-Fragile SEO Workflow: Preserving Domain Wisdom in Pipulate
  * **Filename:** `anti-fragile-seo-workflow.md`
  * **Rationale:** Captures the philosophical depth of the piece, particularly the anti-fragility of domain knowledge against generative averaging, and links it to Pipulate.

### Content Potential And Polish
- **Core Strengths:**
  - Provides a practical, immediately applicable solution for a common SEO data management problem.
  - Articulates a clear, well-reasoned philosophy for workflow design (human-in-the-loop, low-friction, anti-automation arms race).
  - Demonstrates the value of leveraging existing user contexts (browser sessions) for efficiency.
  - Highlights the critical importance of preserving accumulated domain expertise against generic AI outputs.
  - Shows a tangible example of porting 'old wisdom' into a new, structured framework (Pipulate).
- **Suggestions For Polish:**
  - Consider adding a brief note on how to handle different SEMRush report types if the file pattern needs to be more generalized or configurable beyond "*-organic.Positions*".
  - Perhaps an explicit example or diagram showing the ideal directory structure from the user's `~/Downloads` to the `Notebooks/downloads/{job}/` path could reinforce the organization principle.
  - Elaborate slightly on the `job` variable and its importance for repeatable, isolated runs.

### Next Step Prompts
- Generate the Python code for the 'Stack 'Em' equivalent for GAPalyzer: reading all collected `.csv` and `.xlsx` files from `downloads/{job}/`, combining them into a single pandas DataFrame, ensuring robust error handling for different formats and missing data, and cleaning competitor domains from filenames.
- Draft an outline for the subsequent chapter focusing on initial data wrangling techniques within Jupyter Notebooks, specifically addressing data ingestion, standardization, and preliminary cleaning based on the combined SEMRush data.

{% endraw %}
