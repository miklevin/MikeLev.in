---
title: 'Pipulate: AI''s Sausage Factory & Persistent Notebooks'
permalink: /futureproof/pipulate-ai-sausage-factory-persistent-notebooks/
description: As the author, my journey with Pipulate is about relentlessly reducing
  friction in the developer workflow. I'm building a system that embraces the messy
  "sausage factory" of iterative development while providing tools to transform it
  into polished, persistent applications. My collaboration with Gemini in this entry
  highlights my commitment to rapid iteration, centralizing core functionalities,
  and preparing the framework for a more generic, future-proof AI integration, all
  while leveraging the power of Nix Flakes for robust infrastructure.
meta_description: Explore Pipulate's innovative approach to Jupyter Notebooks, blending
  messy 'sausage factory' development with polished, persistent AI-powered web apps
  and streamlined workflows.
meta_keywords: Pipulate, Jupyter Notebooks, AI, persistent notebooks, Nix Flakes,
  Infrastructure as Code, CI/CD, automation, Python, generative AI, developer workflow
layout: post
sort_order: 10
---

## Setting the Stage: Context for the Curious Book Reader

This entry details a critical evolution in the Pipulate project: the creation of a seamless, low-friction workflow for Jupyter Notebook development. It introduces the "sausage factory" philosophy—embracing the iterative, messy process of creation—while building robust tools to publish polished, persistent AI-powered applications. Follow the author's collaborative journey with Gemini to implement automated notebook cleanup, module syncing, and integrated AI API access, showcasing a practical approach to modern development challenges.

---

## Technical Journal Entry Begins

### The Corpus Callosum: Bridging Development Modes

Gemini called that last project a Corpus Callosum between the sausage factory
where we mock-up fast and furious in Jupyter Notebooks keeping it out of the
Pipulate git repo, because ya' know, Notebooks. But when things are polished
just-so, you the developer — though yes I know it will just be me for a while
still — can just drop in `pip.nbup("File_Name.ipynb")` and run the cell and it
will push the cleaned-up version into where the Pipulate git repo *will* track
it (in `assets/nbs/`).

### Reducing Friction: The Power of `pip.nbup()`

This is about dramatic reduction of friction now, because we enter a new phase.
This is the phase of the 3 ideal Notebook examples. I can't ask or expect people
to look at so much. I have to have less noise and more signal. Not here in these
articles of course, haha! But in the app itself. Certain places are sausage
factory and other places are polished finished products.

We must allow one to to have the other.

But the real Corpus Callosum of this project is whatever connective stuff there
is between the Pipulate `server.py` proper, which is a FastHTML / Starlette /
Uvicorn `app` that runs locally on your machine like an Electron app (like VS
Code, Slack, Discord, Zoom), but under Nix and in a normal browser. That's where
the cleaned-up notebooks are ported to as Web Apps that present like Notebooks
but you don't have to look at the Python code at all. It's all very much on
rigid rails. THAT'S the Left hemisphere. The whole JupyterLab environment is the
Right lobe... the guts. The sausage factory.

And in this Age of AI we are now in, the most valuable thing is the sausage
factory. They're interested in knowing *process* — what it took to get there,
everything that ended up on the cutting room floor. THAT'S where all the
intelligence resides. That's what makes a model smarter, getting from here to
there — not the fully baked finished product pulled out with a ta-da! That's why
the models training on GitHub is so effective. It's not just the current HEAD of
the repo, no it's commit by commit back through all that messy history.

## Embracing the Sausage Factory: Intelligence in Process

And so I don't hold back my tendency to be verbose here. This is the untold
story even beyond those git commits. In fact because of real-life datestamps I
can coordinate every commit in the Pipulate history to articles here, and that's
a future project of mine, and of course now ELPGD: Every Little Project Gets
Done... because AI.

We lower friction here at MikeLev.in/, the sausage factory part of Project
Pipulate. This is all too messy to actually get hosted on Pipulate.com... or is
it. I should never be dogmatic about any of those decisions. The time may come,
and of course this whole concept of manipulating icebergs from your fingertips
makes playing the shell-game with what's hosted how and where all the easier.
Nix Flakes basically decouple everything from everything — except for a nice,
generic Linux normalization layer down there somewhere being all mathematically
deterministic in its builds from declarative server definitions.

## Nix Flakes and Immutable Infrastructure

Docker? Pishaw! We don't need no stinkin black boxes. Let the AI know the recipe
and I'm not talking about some Docker manifest that may or may not be there, and
could even be *Twistlocked* for proprietary nose-thumbing at people who don't
like black boxes. No, with Nix the manifest isn't optional because without it
the server doesn't get built. That's what a Nix Flake is and the `flake.nix`
file actually gets bound to the git repo for the ideal ACIDIC Atomic unit of IaC
(**I**nfrastructure **a**s **C**ode).

9:45 PM you say? Yeah, getting a good night's sleep is not optional. It's
non-negotiable so I will be wrapping up soon. But before I do I'm going to put
all that lowered friction to the test.

With everything I just said, get this awful noisy bit of markdown down to the
ideal essence of somebody's first exposure to this stuff at the top of
`Hello_AI.ipynb`:

```markdown
# The United States of Jupyter Notebooks

Pipulate lets you resume any job in a Notebook mid-completion *even after a kernel restart.* It is modeled after Unix pipes.

* **The Unix Pipe:** The `ls | grep | wc` command is a real-time data assembly line. The data flows from one command to the next instantly.
* **The Notebook's "Pipe":** The `pipulate` library in your notebook creates a similar step-by-step process. In the notebook, you first set a `first_name`, then a `last_name`, and finally assemble the `full_name`. Each cell acts like a "worker" in the pipeline.
* **The "Persistence" Difference:** Unlike a Unix pipe that vanishes when done, `pipulate` **saves the result of each step**. This is why you can restart the kernel (which is like stopping the assembly line) and still retrieve the `first_name` to continue the job where you left off.

## Cell 1: Setup Job
```

**Gemini**: You've perfectly articulated the mission. This isn't just about code; it's about philosophy, ergonomics, and creating a clear signal in a world of noise. You need the "welcome mat" for `Hello_AI.ipynb` to be as clean and powerful as the ideas behind it.

Here is the distilled essence of that introduction, rewritten for your target audience.

## Crafting the `Hello_AI.ipynb` Welcome Mat

    # Hello, AI! Welcome to Persistent Notebooks

    Ever lose your work when a Jupyter kernel dies? Pipulate is the antidote.

    It brings the elegant power of **Unix pipes** to your notebook, but with a crucial difference: a built-in **safety net**. While a normal pipe's data vanishes when the job is done, Pipulate **persists the result of every single cell**.

This simple change transforms your workflow:
* **Stop and Resume Freely:** Restart the kernel anytime without losing state.
* **No More Re-runs:** Pick up your process exactly where you left off.

Let's see how this "sausage factory with a save button" works.

---
## Cell 1: Setup Job

**Me**: Okay, that's a good start. And I got `pip.nbup()` at the bottom of each
example notebook. Now let's test *Prompt Fu* with this system.

Okay, now we are reaching the point where I can get some serious help from you
on these Notebooks and I can enter the low-friction fast iteration cycle. About
the last thing that occurs to me is that I need an equally convenient way of
syncing `secretsauce.py` back to `assets/nbs/`. I'd love to be able to do that
FROM a Notebook in the same step as `pip.nbup("FAQuilizer.ipynb")` perhaps,
which is the one that uses it. Maybe an 

```python
modules = ("secretsauce")
pip.nbup("FAQuilizer.ipynb", modules)
```

And then modules could be a multi-element tuple.

**Gemini**: Context verified.

That's a fantastic idea and the perfect next step. You've identified the next point of friction: the developer having to manually sync helper files like `secretsauce.py`. Extending `pip.nbup()` to handle associated modules is the logical and elegant solution.

Your proposed syntax is perfect. Here is the implementation plan and the updated code to make it happen.

-----

## Implementation Plan

We'll modify the `nbup` method in `pipulate/core.py` to accept an optional `modules` tuple. If the argument is provided, the function will loop through the module names and perform a direct file copy for each one, syncing them from `Notebooks/` to `assets/nbs/` alongside the main notebook.

Since `.py` files don't contain outputs or metadata, we don't need to clean them; a simple, robust copy is all that's required.

-----

## The Updated Code

Replace the existing `nbup` method in `pipulate/core.py` with this complete, enhanced version.

```python
# In pipulate/core.py, inside the Pipulate class

def nbup(self, notebook_filename: str, modules: tuple = None):
    """
    Cleans and syncs a notebook and optionally its associated Python modules
    from the working 'Notebooks/' directory back to the version-controlled
    'assets/nbs/' template directory.
    """
    # Import necessary libraries inside the function
    import nbformat
    from pathlib import Path
    import os
    import shutil

    # 1. Find the project root in a portable way
    project_root = self._find_project_root(os.getcwd())
    if not project_root:
        print("❌ Error: Could not find project root (flake.nix). Cannot sync.")
        return

    # --- Notebook Sync Logic ---
    print(f"🔄 Syncing notebook '{notebook_filename}'...")
    notebook_source_path = project_root / "Notebooks" / notebook_filename
    notebook_dest_path = project_root / "assets" / "nbs" / notebook_filename

    if not notebook_source_path.exists():
        print(f"❌ Error: Source notebook not found at '{notebook_source_path}'")
        # Continue to module sync even if notebook is missing, in case that's all the user wants
    else:
        try:
            with open(notebook_source_path, 'r', encoding='utf-8') as f:
                nb = nbformat.read(f, as_version=4)

            original_cell_count = len(nb.cells)
            pruned_cells = [
                cell for cell in nb.cells if 'pip.nbup' not in cell.source
            ]
            
            if len(pruned_cells) < original_cell_count:
                print("✂️  Auto-pruned the 'pip.nbup()' command cell from the template.")
            
            nb.cells = pruned_cells

            for cell in nb.cells:
                if cell.cell_type == 'code':
                    cell.outputs.clear()
                    cell.execution_count = None
                    if 'metadata' in cell and 'execution' in cell.metadata:
                        del cell.metadata['execution']

            with open(notebook_dest_path, 'w', encoding='utf-8') as f:
                nbformat.write(nb, f)

            print(f"✅ Success! Notebook '{notebook_filename}' has been cleaned and synced.")

        except Exception as e:
            print(f"❌ An error occurred during the notebook sync process: {e}")

    # --- NEW: Module Sync Logic ---
    if modules:
        print("\n--- Syncing Associated Modules ---")
        # Ensure modules is iterable even if a single string is passed
        if isinstance(modules, str):
            modules = (modules,)

        for module_name in modules:
            module_filename = f"{module_name}.py"
            module_source_path = project_root / "Notebooks" / module_filename
            module_dest_path = project_root / "assets" / "nbs" / module_filename

            if module_source_path.exists():
                try:
                    shutil.copy2(module_source_path, module_dest_path)
                    print(f"🧬 Synced module: '{module_filename}'")
                except Exception as e:
                    print(f"❌ Error syncing module '{module_filename}': {e}")
            else:
                print(f"⚠️ Warning: Module file not found, skipping sync: '{module_source_path}'")

```

-----

## How to Use It

Your proposed syntax will now work exactly as you designed it. From within `FAQuilizer.ipynb`, you can run:

```python
# Syncs both the notebook and its helper module in one command
pip.nbup("FAQuilizer.ipynb", modules=("secretsauce",))
```

This makes `pip.nbup()` a complete "workspace sync" command, further reducing friction and keeping you in the creative flow of your sausage factory.

**Me**: Added and it worked.

I am running out of steam but everything is *perfectly staged* for rapid
iteration tomorrow. I think the next thing to think through is the Google Gemini
Authentication like is built into FAQuilizer already through `secretsauce.py`
getting built into `Hello_AI.ipynb` because if you're not saying hello to an AI,
what's the point of naming it that way, ahaha! So the API key is going to have
to be asked for but I have to make some generic API thing. Think!

The way we do it in FAQuilizer is:

```python
secretsauce.setup_google_ai(job)
```

So maybe generically, it can be:

```python
pip.api_key(job)
```

...and we just rig it for success with the 80/20-rule right now. We hard-wire it
to work with `gemini-2.5-flash` in the Hello AI example. We can soft-wire it
through the `pip install llm` package later. But for now a "Hello, AI!" example
without connecting to an AI can't stand. Let's do a light touch lifting whatever
we can from the FAQuilizer example and incorporating as little as possible in
`core.py` to get the job done.

**Gemini**: Context verified.

Excellent plan. To make `Hello_AI.ipynb` live up to its name, we need a light-touch way to handle authentication. Your idea to lift the logic from `FAQuilizer` and create a generic `pip.api_key(job)` is the perfect 80/20 solution. It keeps the core logic centralized while making AI access simple from any notebook.

Here is the implementation plan to get the job done with a minimal, clean chisel-strike.

-----

## The Plan

We will create a new method, `api_key`, inside the `Pipulate` class in `pipulate/core.py`. This method will almost directly mirror the logic from `secretsauce.setup_google_ai`, but it will be a generic part of the `pip` object.

1.  **Check for an existing key** in the current `job`'s state.
2.  If not found, use the `getpass` library to **securely prompt the user** for their key.
3.  **Store the key** in the `job`'s state using `self.set()`.
4.  **Configure the `google.generativeai` library** so it's ready to use.

This keeps the implementation minimal and reuses the exact patterns you've already established as effective.

-----

## The Code

Here are the code changes needed.

### 1\. Add the `api_key` method to `pipulate/core.py`

Add the following imports to the top of `pipulate/core.py`, and then add the `api_key` method inside the `Pipulate` class.

```python
# Add these imports to the top of pipulate/core.py
import getpass
try:
    import google.generativeai as genai
    GOOGLE_AI_AVAILABLE = True
except ImportError:
    GOOGLE_AI_AVAILABLE = False


# Add this method inside the Pipulate class in pipulate/core.py
def api_key(self, job: str, service: str = 'google'):
    """
    Handles getting, storing, and configuring an API key for a given service.
    For now, it's hard-wired for Google AI as an 80/20 solution.
    """
    if service.lower() != 'google':
        print(f"⚠️ Service '{service}' not yet supported. Only 'google' is currently configured.")
        return

    if not GOOGLE_AI_AVAILABLE:
        print("❌ Error: The 'google-generativeai' package is not installed.")
        print("   Please run: pip install google-generativeai")
        return

    # Use a specific key in the job's state to store the API key
    api_key_step = "google_api_key"

    api_key = self.get(job, api_key_step)

    if not api_key:
        try:
            prompt_message = "Enter your Google AI API Key: "
            api_key = getpass.getpass(prompt_message)
            self.set(job, api_key_step, api_key)
            print("✅ API Key received and stored for this job session.")
        except Exception as e:
            # getpass can fail in some environments like Google Colab without TTY
            print(f"❌ Could not prompt for API key in this environment: {e}")
            return

    if api_key:
        try:
            genai.configure(api_key=api_key)
            print("✅ Google AI configured successfully.")
        except Exception as e:
            print(f"❌ Failed to configure Google AI. Is the key correct? Error: {e}")
```

### 2\. Update `Hello_AI.ipynb`

Now, add a new cell in your `Hello_AI.ipynb` notebook to call this new function. A good place is right after the setup cell.

```python
# Add this as a new cell in Hello_AI.ipynb
# This will prompt for a key if one isn't already stored for this 'job'
pip.api_key(job)
```

-----

That's it. This light-touch approach gives `Hello_AI.ipynb` its purpose, proves out the generic API pattern, and perfectly stages you for the next iteration of your work.

**Me**: Excellent, that totally worked. Now I would like to update FAQuilizer to
work the same way and take the dead function out of secretsauce.py for
consistency. Again, longer term this will switch over to `pip install llm` so we
will make it generic. This is just bootstrapping the process front-loading a win
and something I can demonstrate and use right away.

**Gemini**: Of course. We'll refactor `FAQuilizer.ipynb` to use the new `pip.api_key(job)` method and remove the redundant function from `secretsauce.py`. This is the perfect next step for consistency.

-----

## 1\. Update `FAQuilizer.ipynb`

In your `FAQuilizer.ipynb` notebook, find the cell responsible for authentication and replace the call to `secretsauce.setup_google_ai(job)` with the new, direct call to `pip.api_key(job)`.

**Find this cell:**

```python
# Cell 2: Authentication
secretsauce.setup_google_ai(job)
```

**And replace it with this:**

```python
# Cell 2: Authentication
pip.api_key(job)
```

-----

## 2\. Clean Up `secretsauce.py`

Now that the authentication logic is centralized in `pipulate/core.py`, you can remove the old function and its specific import from `Notebooks/secretsauce.py`.

**In `Notebooks/secretsauce.py`, remove the following:**

1.  **The `import getpass` line:**

    ```python
    # At the top of the file
    import getpass # <- Delete this line
    ```

2.  **The entire `setup_google_ai` function:**

    ```python
    # Delete this entire function block
    def setup_google_ai(job: str):
        """Handles getting, storing, and configuring the Google AI API key."""
        api_key = pip.get(job, API_KEY_STEP)
        if not api_key:
            try:
                api_key = getpass.getpass("Enter your Google AI API Key: ")
                pip.set(job, API_KEY_STEP, api_key)
                print("✅ API Key received and stored for this session.")
            except Exception as e:
                print(f"❌ Could not get API key: {e}")
                return
        if api_key:
            genai.configure(api_key=api_key)
            print("✅ Google AI configured successfully.")
    ```

These two changes will align your `FAQuilizer` workflow with the new, centralized authentication method, making your examples cleaner and more consistent.

**Me**: Okay, that all went perfectly and tested well through a kernel reset. So
now I will need the bare minimum Google API-calling wise. I suppose we should
build a prompt using the first and last name that was collected in the pipeline
and instead of this cell:

```python
from pipulate import pip

job = "hello_ai"
full_name = f"Hello, {pip.get(job, 'first_name')} {pip.get(job, 'last_name')}!"
print(full_name)
print("\nFinal job state:")
print(pip.read(job))
```

...it should do something like:

```python
prompt = f"Google, tell me something about {pip.get(job, 'first_name')} {pip.get(job, 'last_name')}"
response = pip.prompt(prompt)
print(response)
```

Or something like that. Make it sensible and best 80/20-Rule close to best
practices. It's just to have said hi to an AI and not build a chat system or
anything. And again, we're planning ahead for the `llm` package, so it's fine to
to hardware it to `gemini-2.5-flash` for now and again lift the implementation
from `secretsauce.py` though this time we'll be leaving that one there for
bespoke reasons.

## Streamlining AI Integration: API Keys and Prompting

**Gemini**: Excellent. This is the perfect "chisel-strike" to end the night on—a high-impact win that makes `Hello_AI.ipynb` truly deliver on its promise.

Your proposed `pip.prompt()` is the ideal 80/20 solution. We'll lift the core logic from `secretsauce.py`, generalize it, and place it right where it belongs: inside the `Pipulate` "magic wand."

Here is the complete implementation plan.

-----

## 1\. Add the `prompt()` Method to `pipulate/core.py`

First, we need to equip the `pip` object with the new `prompt()` capability. This involves adding the method to the `Pipulate` class.

**Action:** Add the following code inside the `Pipulate` class in your `pipulate/core.py` file. A good place is right after the `nbup` method you just added.

```python
# In pipulate/core.py, inside the Pipulate class

def prompt(self, prompt_text: str, model_name: str = 'gemini-2.5-flash'):
    """
    Sends a simple, one-shot prompt to the configured AI model and returns the response.
    This is a bare-minimum implementation for demonstration, not a chat system.
    """
    if not GOOGLE_AI_AVAILABLE:
        error_msg = "❌ Error: The 'google-generativeai' package is not installed."
        print(error_msg)
        return error_msg

    print(f"🤖 Sending prompt to {model_name}...")

    try:
        # Instantiate the model for this specific call
        model = genai.GenerativeModel(model_name)
        
        # Send the prompt and get the response
        response = model.generate_content(prompt_text)
        
        # Extract and return the text
        response_text = response.text.strip()
        print("✅ AI response received.")
        return response_text

    except Exception as e:
        # Catch common errors like authentication failure or model not found
        error_msg = f"❌ AI prompt failed: {e}"
        print(error_msg)
        print("   Did you remember to run pip.api_key(job) in a previous cell?")
        return error_msg
```

-----

## 2\. Update `Hello_AI.ipynb`

Now, you can replace the final, anti-climactic cell in `Hello_AI.ipynb` with one that actually uses this new function to talk to an AI.

**Action:** Replace the entire final code cell of your `Hello_AI.ipynb` notebook with the following code.

```python
# In the final cell of Hello_AI.ipynb

from pipulate import pip
job = "hello_ai"

# 1. Construct a fun prompt using the data that persisted across kernel restarts
first_name = pip.get(job, 'first_name')
last_name = pip.get(job, 'last_name')
prompt = f"Write a short, one-sentence, upbeat tagline for a fictional adventure company run by {first_name} {last_name}."

print(f"💬 Sending the following prompt to the AI:\n   '{prompt}'")

# 2. Call the new pip.prompt() method
response = pip.prompt(prompt)

# 3. Print the AI's creative response!
print("\n--- AI Response ---")
print(response)
print("-------------------")
```

-----

That's it. You've successfully front-loaded a win. Your "Hello, AI\!" notebook now has a legitimate, satisfying payoff. It demonstrates persistence, it interacts with an AI, and it does so through a clean, reusable method that paves the way for the more generic `llm` package integration in the future. A perfect end to a productive day.

**Me**: Confirmed. "Hello, AI!" is now really API-connecting with an AI and also
demonstrates the Notebook persistence per the original objective.

---

## Book Analysis

### Ai Editorial Take
This entry is a compelling example of agile development and AI-driven collaboration in action. It effectively documents the organic evolution of core functionalities within the Pipulate project, illustrating how friction is identified and systematically removed. The philosophical underpinning of valuing the 'sausage factory' process is a powerful and timely message for modern software development, especially in the age of AI. The structured dialogue with Gemini makes the problem-solving transparent and highly educational, showcasing best practices in iterative design and code refactoring. This piece offers high educational value for developers seeking to optimize their workflow and build resilient, AI-integrated systems.

### Title Brainstorm
* **Title Option:** Pipulate: AI's Sausage Factory & Persistent Notebooks
  * **Filename:** `pipulate-ai-sausage-factory-persistent-notebooks.md`
  * **Rationale:** Captures the core philosophy (sausage factory), the main tool (Pipulate), and the key outcome (persistent notebooks) with AI as a modern context.
* **Title Option:** Building Pipulate: From Messy Notebooks to Polished AI Apps
  * **Filename:** `building-pipulate-messy-notebooks-polished-ai-apps.md`
  * **Rationale:** Highlights the transformation process and the end goal, emphasizing the journey from raw development to finished product.
* **Title Option:** The Frictionless Dev Workflow: Pipulate's AI-Powered Evolution
  * **Filename:** `frictionless-dev-workflow-pipulates-ai-powered-evolution.md`
  * **Rationale:** Focuses on the benefit (frictionless), the tool (Pipulate), and the driving technology (AI).
* **Title Option:** Nix, Jupyter, and Gemini: Automating the AI Development Pipeline
  * **Filename:** `nix-jupyter-gemini-automating-ai-dev-pipeline.md`
  * **Rationale:** Highlights the key technologies and collaborators, framing the content as an automation blueprint.

### Content Potential And Polish
- **Core Strengths:**
  - Demonstrates real-time, iterative development with AI collaboration (Gemini).
  - Clearly articulates complex technical concepts (Corpus Callosum, sausage factory, Nix Flakes) with accessible analogies.
  - Showcases practical, immediately usable code snippets and implementation plans.
  - Focuses on developer friction reduction and workflow improvement.
  - Highlights the value of process and history in AI training, a modern and relevant insight.
  - Effectively breaks down the evolution of a feature (from manual to automated sync, from specific to generic API calls).
- **Suggestions For Polish:**
  - Consider adding visual diagrams or flowcharts for complex concepts like "Corpus Callosum" or the `pip.nbup` workflow.
  - Perhaps a brief initial context-setting for readers unfamiliar with "Pipulate" before diving into specific features.
  - While the 80/20 rule is explained, some readers might benefit from a clearer roadmap for the "future proofing" (e.g., how `llm` package will integrate).
  - Ensure consistency in explaining which parts are "sausage factory" vs. "polished" as the project evolves; the current article does this well, but it's a theme to maintain.
  - Adding a concluding thought that explicitly ties all the disparate threads together into a grand vision for Pipulate could reinforce the overarching goal.

### Next Step Prompts
- Develop a comprehensive architecture diagram for Project Pipulate, illustrating the interplay between JupyterLab, `server.py` (FastHTML/Starlette/Uvicorn), Nix Flakes, `pip.nbup()`, and the AI integration points, clearly distinguishing between 'sausage factory' and 'polished product' zones.
- Draft a tutorial-style article that walks a new user through setting up a `Hello_AI.ipynb` environment from scratch, emphasizing the persistence feature and the streamlined AI API interaction introduced in this entry.
