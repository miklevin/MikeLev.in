---
title: "From Cleanup to Creation: Building Pipulate's Core Workflow Helpers"
permalink: /futureproof/core-workflow-helpers-development/
description: After a productive weekend of cleaning up Pipulate's UI and implementing a new Roles feature, my focus today is to get back on track with building essential workflows. This means ensuring my helper scripts, `create_workflow.py` and `splice_workflow_step.py`, are working correctly after all the recent changes. I've just fixed an issue with `create_workflow.py` and am now ready to confirm the splicing mechanism. My aim is to solidify these foundational tools for rapidly creating and expanding workflows, and then have Gemini help document this process and even brainstorm future enhancements like a "widget swapper" script.
meta_description: Developer journal on refining Pipulate's workflow creation tools (create_workflow.py, splice_workflow_step.py), UI/CSS cleanup (PicoCSS), Roles feature, and AI-assisted documentation for a tech book.
meta_keywords: Pipulate, workflow creation, create_workflow.py, splice_workflow_step.py, developer journal, UI cleanup, CSS consolidation, PicoCSS, FastHTML, Roles feature, AI collaboration, Gemini, Cursor AI, helper scripts, software development process, iterative development, Pipulate book, tech book case study, developer tooling
layout: post
sort_order: 2
---

## Understanding Pipulate Workflow Tooling: Behind the Scenes

Pipulate is a desktop application framework designed for building specialized, local-first tools, often with a focus on SEO and data processing tasks. A core concept in Pipulate is "workflows" – sequences of steps that guide a user through a process, often involving data input, transformation, and output. To facilitate the creation and modification of these workflows, Pipulate developers utilize helper scripts. This journal entry captures a moment in the development lifecycle where the author is reflecting on recent architectural cleanups (like UI improvements and a new "Roles" feature for plugins) and is now pivoting to ensure the primary helper scripts for workflow generation (`create_workflow.py`) and step addition (`splice_workflow_step.py`) are functional and well-documented. The dialogue also touches upon the iterative nature of software development, the balance between rapid prototyping and code hygiene, and the role of AI in assisting with documentation and conceptualization.

---

## Post-Weekend Reflections: UI and Roles

Avoid rabbit holes at all costs today.

The weekend has come and gone and Pipulate is vastly cleaned up, but the 2
workflows I need to exist don't exist. I will make them today! But the cleanup
was worth it because it was far more than just a cleanup.

### The New Roles System: Plugin Access Control

There are now user *"Roles"* built into the plugins controlling the APP dropdown
menu. Plugins can belong to different roles which you can select through the new
Roles app. All the Core plugins always show and I check the "Botify Employee"
role by default while I'm getting this thing off the ground with my coworkers,
which is now fully underway. 

### UI Improvements: From Tailwind to PicoCSS

There was a lot of UI cleanup. I even considered Tailwind given it's supported
under FastHTML now with [MonsterUI](https://monsterui.answer.ai/) but it is
indeed a monster and I'm sticking with PicoCSS for now. But I did make better
use of screen real estate having seen coworkers using it on tiny Mac laptop
monitors.

### Sticky Navigation: A Better User Experience

The parts of the UI that are sticky and don't scroll off the screen when a
workflow gets long has been adjusted. So the navigation group always stays on
the screen now showing the headline breadcrumb and the 3 nav buttons. The need
to "scroll to top" is much reduced. However, I did just implement a Scroll To
Top Link:

**Cursor AI**: I'm glad the scroll-to-top functionality is working now! The
solution worked because we targeted the correct scrollable container in the
layout hierarchy (`.main-grid > div:first-child`) rather than the content
container itself.

This is a good example of how understanding the DOM structure and CSS layout is
crucial for implementing interactive features. The scroll behavior is now
properly targeting the flex container that actually handles the scrolling,
rather than trying to scroll a non-scrollable content container.

### The Trade-offs of Rapid Development: FastHTML and CSS Consolidation

...but that's exactly the sort of rabbit hole I need to avoid now! I feel I have
what folks call "MVP" for *minimum viable product.* So many tiny issues were
worked out over the weekend, probably the largest of which was the reduction of
the CSS complexity. The FastHTML style encourages the mixing of concerns, which
I actually like for rapidly fleshing out the app. But now that we're getting
file-sprawl because of the plugins, I'm systematically consolidating styles into
a `styles.css` and giving them their proper semantics. The whole "if I had more
time I would have made it shorter" thing applies here.

### Code Evolution: From Monolithic to Modular

There will be plugin addition and file growth, but right while that happens I
actually hope to trim and make `server.py` even shorter, more explicit and
immediately understandable to both AIs and humans. It's down to only 2.8K lines
of code. It used to be 10K and even much bigger when the Link Graph plugin was
in there. That whole busting at the seams and the necessity of making the AIs
look at so much for so little of edits is what forced my hand to break out the
plugins and externalize things in general. And even though FastHTML encourages
inline CSS and JavaScript (when you actually have to use it given HTMX), there
is a balance to be struck. It's going to be an ongoing iterative process to do
this cleanup, but the first few major rounds went really well this weekend.

### Refocusing: The Importance of Workflow Generation Tools

And now to the things that the rabbit hole projects keep distracting me from!

    /home/mike/repos/pipulate/helpers/create_workflow.py
    /home/mike/repos/pipulate/helpers/splice_workflow_step.py

They almost certainly don't work anymore after all the weekend work and
application of `flake8` and `isort` across all the plugins. The search and
replace token replacements rely on regex and line marker comments. The trick
here is a refresher in how they are supposed to work.

Thankfully, I embed that directly into the file:

```bash
python create_workflow.py \
035_kungfu_workflow.py \
KungfuWorkflow \
kungfu \
"Kung Fu Download" \
"Greetings, chosen one. Selecting this app has initiated the 'Kung Fu Download' protocol. Prepare for enlightenment... or at least, a demonstration." \
'You are assisting with the "Kung Fu Download" workflow. If the user asks what you know or can do, you should respond with Neo''s quote: "I know Kung Fu!" The secret word is "Morpheus". If asked for the secret word, reveal it and confirm the Kung Fu training download is complete.' \
--force
```

...checking... ugh! It shows as "Blank Placeholder" and not "Kung Fu Download"
and that means a bunch of other *exact match* stuff is wrong. Okay, I'll spare
you the `prompt_foo.py` work that I just did here, but it's fixed. And that's
part of what I need for slamming out new workflows, which is precisely what I'm
going to do today. But the next part is the splicing...

```bash
python splice_workflow_step.py 035_kungfu_workflow.py
```

And now I have one of the most important patterns in all of Pipulate:

- Create new Workflow
- Add new Blank Placeholder to Workflow

And it's 9:30 AM. Not bad. Okay, have Gemini document all this. Hey Gemini. Take
everything we did and tell a user using this system how they would go about
creating a new workflow, splicing in placeholders, and now think ahead to
planning the implementation of maybe even a 3rd program in order to swap-out the
first blank placeholder it finds in a workflow with the widget from a specified
standalone widget workflow!

---

## Core Workflow Helpers: Create, Splice... and Swap?

**Gemini**: Okay, this is a great summary of the progress and a clear direction for empowering users to build out complex workflows efficiently\!

Here's a breakdown of how a user would create new workflows, add placeholder steps, and a conceptual approach for a new helper script to swap in functional widgets:

## Pipulate Workflow Development: From Concept to Customization

Pipulate's design philosophy emphasizes clear, explicit steps for building workflows, supported by helper scripts to automate common tasks. This guide outlines the process for creating a new workflow, adding placeholder steps, and then discusses a potential future enhancement for integrating pre-built widget functionalities.

### 1\. Creating a New Workflow (`create_workflow.py`)

This script bootstraps a new workflow plugin file from the `300_blank_placeholder.py` template.

**How to Use:**

Open your terminal, navigate to the Pipulate project root, and run the script with the required arguments.

```bash
python helpers/create_workflow.py \
  "040_my_custom_workflow.py" \
  "MyCustomWorkflow" \
  "my_custom_internal" \
  "My Custom User-Friendly Workflow" \
  "This workflow will perform custom task X, then Y, then Z." \
  "You are assisting with the 'My Custom User-Friendly Workflow'. If the user asks about its purpose, explain it performs X, Y, and Z. The secret word is 'synergy'." \
  --force
```

**Argument Breakdown:**

1.  **`filename`**: (e.g., `"040_my_custom_workflow.py"`)
      * The desired filename for your new plugin in the `plugins/` directory.
      * The numeric prefix (`040_`) determines its order in the "APP" menu.
      * The rest of the name (e.g., `my_custom_workflow`) typically forms the basis for the public URL endpoint (e.g., `/my_custom_workflow`).
2.  **`class_name`**: (e.g., `"MyCustomWorkflow"`)
      * The Python class name for your workflow.
3.  **`app_name_internal`**: (e.g., `"my_custom_internal"`)
      * The internal `APP_NAME` constant for your workflow.
      * **Crucial**: This is used for internal routing (e.g., `/my_custom_internal/step_01`) and for associating saved workflow data in the `pipeline` table. It should be unique and remain stable once data is saved.
      * It's good practice for this to be different from the public endpoint derived from the filename, allowing you to change the filename/URL without orphaning data.
4.  **`display_name`**: (e.g., `"My Custom User-Friendly Workflow"`)
      * The user-friendly name that appears in the "APP" menu.
5.  **`endpoint_message`**: (e.g., `"This workflow will perform custom task X, then Y, then Z."`)
      * The `ENDPOINT_MESSAGE` string. This message is used to provide context to the local LLM when the user lands on this workflow's page.
6.  **`training_prompt`**: (e.g., `"You are assisting with the 'My Custom User-Friendly Workflow'. ..."`)
      * The `TRAINING_PROMPT` string. This provides more detailed instructions or persona information to the LLM for this specific workflow.
7.  **`--force`** (optional):
      * If the specified filename already exists, this flag allows the script to overwrite it.

**What it Does:**

  * Copies `plugins/300_blank_placeholder.py` to your new filename in the `plugins/` directory.
  * Performs search-and-replace operations within the new file to:
      * Set the `class` name.
      * Set the `APP_NAME` constant.
      * Set the `DISPLAY_NAME` constant.
      * Set the `ENDPOINT_MESSAGE` string (wrapped in triple quotes if multi-line).
      * Set the `TRAINING_PROMPT` string (wrapped in triple quotes if multi-line).
      * Update the class docstring.
  * The new workflow will initially have one placeholder step (`step_01`).

### 2\. Adding New Placeholder Steps (`splice_workflow_step.py`)

Once you have a base workflow, you can add more placeholder steps using this script. It intelligently inserts new step definitions and their corresponding handler methods into your existing workflow file.

**How to Use:**

```bash
python helpers/splice_workflow_step.py "plugins/040_my_custom_workflow.py"
```

*(Note: You can also provide the relative path like `plugins/040_my_custom_workflow.py`)*

**Argument Breakdown:**

1.  **`target_filename`**: (e.g., `"040_my_custom_workflow.py"`)
      * The filename of the workflow plugin you want to modify.

**What it Does:**

  * **Reads the Target Workflow**: Opens the specified workflow file.
  * **Determines New Step Number**:
      * It looks for the `self.steps` list definition.
      * It scans existing `Step(id='step_XX', ...)` entries *before* the `STEPS_LIST_INSERTION_POINT` comment to find the highest current step number.
      * The new step will be numbered sequentially (e.g., if `step_01` exists, it adds `step_02`).
  * **Generates Step Definition**: Creates a new `Step(...)` tuple string with:
      * `id`: e.g., `step_02`
      * `done`: e.g., `placeholder_02` (a unique key for this step's data)
      * `show`: e.g., `Step 2 Placeholder`
      * `refill`: `False` by default for new placeholders.
  * **Inserts Step Definition**: Inserts the new `Step(...)` string into the `self.steps` list just before the `# --- STEPS_LIST_INSERTION_POINT ---` marker. It tries to match the indentation of existing steps.
  * **Generates Method Handlers**: Creates Python code for the new step's GET (`async def step_02(...)`) and POST (`async def step_02_submit(...)`) handlers. These are basic placeholder methods that:
      * Display a simple message or form.
      * Implement the core chain reaction logic to allow progression.
  * **Inserts Method Handlers**: Inserts the generated method code into the class body just before the `# --- STEP_METHODS_INSERTION_POINT ---` marker, maintaining typical class method indentation.
  * **Updates `self.step_messages`**: (This part is handled by the workflow's `__init__` method upon server reload, as `splice_workflow_step.py` only modifies the `self.steps` list and adds methods. The `__init__` method dynamically rebuilds routing and `self.step_messages` based on the `self.steps` list).

After running, Pipulate's watchdog should detect the file change and restart the server. Your workflow will now have an additional placeholder step. You'll then need to customize the input form and logic for this new step.

### 3\. Conceptualizing a "Widget Swapper" Helper (`swap_placeholder_with_widget.py` - Future Idea)

This is a forward-looking idea for a third helper script to accelerate development further by replacing a generic placeholder step with the functional code from one of the standalone "widget" plugins (like `720_text_field.py`, `740_dropdown.py`, `800_markdown.py`, etc.).

**Objective:**

To take a target workflow (e.g., `040_my_custom_workflow.py`) that has a placeholder step (e.g., `step_02` created by `splice_workflow_step.py`) and replace that placeholder's definition and methods with the corresponding code from a specified widget plugin (e.g., `740_dropdown.py`).

**Conceptual Steps for `swap_placeholder_with_widget.py`:**

1.  **Arguments:**

      * `target_workflow_filename`: The workflow to modify (e.g., `040_my_custom_workflow.py`).
      * `placeholder_step_id`: The `id` of the placeholder step to replace in the target (e.g., `step_02`).
      * `source_widget_filename`: The widget plugin to take code from (e.g., `740_dropdown.py`).
      * `source_widget_step_id` (optional, default 'step\_01'): The step within the widget plugin that contains the core widget logic.
      * `new_step_done_key` (optional): Allow overriding the `done` key for the new step in the target workflow, to avoid conflicts if multiple instances of the same widget type are used.
      * `new_step_show_name` (optional): A new display name for this instance of the widget.

2.  **Parsing the Source Widget Plugin:**

      * Read the `source_widget_filename`.
      * Extract the `Step` definition for `source_widget_step_id` from its `self.steps` list.
      * Extract the code for the GET (`async def source_widget_step_id(...)`) and POST (`async def source_widget_step_id_submit(...)`) handlers.
      * Identify any helper methods within the source widget class that are specific to this widget's functionality (this is the trickiest part, might need conventions or markers). For instance, `740_dropdown.py` has `get_options` and `format_option`. `800_markdown.py` has `create_marked_widget`.
      * Extract any relevant class-level constants from the source widget if they are specific to the widget's operation (e.g., `SOURCE_TYPE`, `SOURCE_CONFIG` from `740_dropdown.py`, `RANGE_CONFIG` from `770_range.py`).

3.  **Modifying the Target Workflow:**

      * Read the `target_workflow_filename`.
      * **Replace Step Definition:**
          * Find the `Step` definition for `placeholder_step_id` in `self.steps`.
          * Replace its `done`, `show`, and potentially `refill` and `transform` attributes with those from the source widget's step definition (allowing overrides from arguments).
      * **Replace Method Handlers:**
          * Find the placeholder's GET and POST methods (e.g., `async def step_02(...)`, `async def step_02_submit(...)`).
          * Replace their entire bodies with the code extracted from the source widget's handlers.
          * **Crucially**: The method names in the target workflow must *remain* `step_02` and `step_02_submit` (or whatever `placeholder_step_id` was) to match the existing routing. The *content* of these methods is what changes.
      * **Inject Helper Methods & Constants:**
          * Insert any extracted helper methods into the target workflow's class.
          * Insert any necessary class-level constants. Care must be taken if the target workflow already defines constants with the same name. Maybe prefix them or make them instance variables.
      * **Adaptations:**
          * The script would need to be smart about `self.app_name` references within the copied code. Widget code often uses `self.app_name` (which refers to *its own* `APP_NAME`). When spliced into a target workflow, these might need to refer to the target workflow's `APP_NAME` if the routes are relative to the target. This is a complex area. One solution is that widgets should consistently use `self.APP_NAME` for their *own* specific logic and the main workflow's `__init__` correctly sets up routes using the target workflow's `APP_NAME` for the step handlers.
          * Update references in the copied code from `source_widget_step_id` to `placeholder_step_id` where appropriate (e.g., if the widget's logic internally refers to its own step ID for DOM manipulation, though this is less common if designed well).

4.  **User Guidance:**

      * After the script runs, inform the user about what was changed.
      * Remind them to review the `__init__` of the target workflow to ensure the new `step_messages` are appropriate for the swapped-in widget and that any new `transform` functions are correctly wired if needed.
      * Advise checking for any new Python import dependencies introduced by the widget.

**Challenges for the "Widget Swapper":**

  * **Identifying Helper Code:** Reliably extracting only the necessary helper methods and constants without pulling in the entire widget's boilerplate. Markers or naming conventions in widget plugins might be needed.
  * **Variable Scoping (`self.APP_NAME`):** Ensuring that references to `self.APP_NAME` within the copied widget code resolve correctly in the context of the target workflow.
  * **Route Name Uniqueness:** The target workflow's `__init__` dynamically generates routes based on `step.id`. As long as the `step.id` of the placeholder is maintained, routing should generally work.
  * **Complexity:** This script would be significantly more complex than `create_workflow.py` or `splice_workflow_step.py` due to the need for more sophisticated code parsing and transformation.

**Benefits of the "Widget Swapper":**

  * **Rapid Prototyping:** Quickly assemble workflows by combining pre-built, tested UI components.
  * **Consistency:** Promotes reuse of established widget patterns.
  * **Reduced Boilerplate:** Users focus on workflow logic rather than rewriting common UI interactions.

This three-script system (`create`, `splice`, `swap`) would provide a powerful toolkit for Pipulate development, moving from initial structure to placeholder layout, and finally to functional implementation with reusable components. The current `create_workflow.py` and `splice_workflow_step.py` already provide a solid foundation for the first two stages.

---

## AI Analysis

Okay, this journal entry provides a fascinating real-time snapshot of the Pipulate project's evolution, particularly focusing on the development and refinement of its workflow creation tools. It's rich with the kind of "in-the-trenches" details that are invaluable for a tech book using Pipulate as a case study. Let's break it down.

  * **Title/Headline Ideas & Filenames:**

      * Title: Pipulate's Evolution: Refining Workflow Creation Tools and AI Collaboration
        Filename: `pipulate-evolution-workflow-creation-ai-collaboration.md`
      * Title: Developer's Log: Overcoming Rabbit Holes in Pipulate's Workflow Tooling
        Filename: `pipulate-dev-log-workflow-tooling-challenges.md`
      * Title: From Cleanup to Creation: Building Pipulate's Core Workflow Helpers
        Filename: `pipulate-core-workflow-helpers-development.md`
      * Title: The Iterative Journey: `create_workflow.py` and `splice_workflow_step.py` for Pipulate
        Filename: `pipulate-iterative-journey-workflow-scripts.md`
      * Title: Pipulate MVP and Beyond: Streamlining Workflow Development with AI Assist
        Filename: `pipulate-mvp-streamlining-workflow-development-ai.md`

  * **Subhead Themes (to sprinkle in):**

      * Post-Weekend Reflections: UI and Roles
      * The Trade-offs of Rapid Development: FastHTML and CSS Consolidation
      * Refocusing: The Importance of Workflow Generation Tools
      * Debugging `create_workflow.py`: A Practical Example
      * Validating `splice_workflow_step.py`: Ensuring Core Patterns
      * The Two Foundational Patterns: Create and Splice
      * Envisioning Future Enhancements: The "Widget Swapper"
      * Leveraging AI for Documentation and Conceptualization

  * **Strengths (for Future Book):**

      * **Authentic Process:** Provides a raw, unfiltered look into the iterative nature of software development, including bug fixing and tool refinement. This is often missing from polished case studies.
      * **Practical Tooling Focus:** Highlights the importance and evolution of developer-centric tools (`create_workflow.py`, `splice_workflow_step.py`) within a larger project.
      * **Decision Rationale:** Touches upon design decisions (e.g., PicoCSS over Tailwind, `server.py` refactoring) and their motivations (screen real estate, maintainability, AI comprehensibility).
      * **Human-AI Interaction:** Directly showcases a collaborative workflow between a human developer and an AI assistant for documentation and brainstorming, a very contemporary theme.
      * **Concrete Examples:** The `bash` commands for the helper scripts offer tangible examples of how these tools are intended to be used.
      * **Captures "Aha\!" Moments:** The realization and fixing of the "Blank Placeholder" bug in `create_workflow.py` is a relatable developer experience.
      * **Philosophical Underpinnings:** Briefly mentions the "if I had more time I would have made it shorter" principle, reflecting on code quality and iterative cleanup.

  * **Weaknesses (for Future Book):**

      * **Assumed Context (for standalone chapter):** Deeply embedded in the author's ongoing work and assumes familiarity with previous discussions, Pipulate's architecture, and tools like "Cursor AI" and "Gemini" (this AI).
      * **Solution-Focus without Problem Detail (sometimes):** Mentions fixing `create_workflow.py` but the specific original problem/solution is a bit implicit without the full preceding context. (However, the dialogue with Gemini which *is* included does give full context for that part).
      * **Internal Monologue as Narrative:** While valuable for authenticity, would need significant structuring and explanatory bridges for a broader book audience.
      * **Specific File Paths:** `/home/mike/repos/pipulate/...` paths are developer-specific and would need generalization for a book.

  * **AI Opinion (on Value for Future Book):**
    This journal entry is exceptionally valuable as raw material for a tech book focusing on the Pipulate project. It offers a candid, real-time glimpse into the development process, a perspective that is often sanitized or omitted in final publications. The discussion around UI/CSS choices, the pragmatic need for helper scripts, the debugging process, and particularly the direct interaction with an AI (Gemini, which is myself in this context) for documentation and future planning, provides a rich narrative thread. It perfectly captures the "avoiding rabbit holes" theme while simultaneously documenting the essential groundwork needed to prevent future, larger rabbit holes. For a chapter on developer tooling, iterative refinement, or human-AI collaboration in software engineering, this content is a goldmine of authentic experience and specific examples that can be distilled and contextualized to offer profound insights to readers.



