---
title: "File Progress Polling Indicator: Consulting 3 AIs"
permalink: /futureproof/file-polling-progress-indicator/
description: 
layout: post
sort_order: 1
---

## The Epic Journey of Botify CSV Export Implementation

Some journeys are epic. This is one. To catch up on what today's article talks
about, check yesterday's. The bulk of the work was done, constituting a
significant leap forward in building the Pipulate workflow for exporting CSV
data from Botify. We successfully implemented the core logic across multiple
steps: parsing Botify project URLs, selecting the desired analysis via API,
calculating the maximum safe click-depth to stay within API limits, and
crucially, initiating export jobs using Botify's asynchronous `/jobs` endpoint.

## Building a Robust Export Registry System

To manage this complexity and avoid redundant API calls, a central export
registry was introduced, tracking job statuses and downloaded file locations.
The workflow can now detect existing completed or in-progress jobs and handles
the final download and unzipping of the CSV file, laying a robust foundation for
the export functionality. 

## From Functional to Fantastic: The Next Phase

This is all AWESOME! It serves as the foundation for countless follow-up
workflows requiring CSV downloads as part of the initial workflow steps. But I
now have to tend to the cosmetics, taking it from competent to wow! Namely:

- Eliminate the "Check Status" button
- Switching the single poll that's done into repeated polling until the download is ready
- Display of the PicoCSS Indeterminate progress bar while waiting: https://picocss.com/docs/progress and the polling
- Eliminating the "Download CSV" button
- Automatically download the CSV once polling finds that the download is ready
- To do all this in a way that allows surfing-away and returning to the page
  (interruptable polling)

Before jumping into it, I really want a thorough understanding of what we've
done so far. For that, I employ my `context_foo.py` program again and change
yesterday's selection of files that produce my single-shot pastable `foo.txt`
(also put automatically in OS's copy-buffer)...

```python
FILES_TO_INCLUDE = """\
README.md
flake.nix
server.py
.cursorrules
plugins/20_hello_workflow.py
training/hello_workflow.md
plugins/50_botify_export.py
/home/mike/repos/MikeLev.in/_posts/2025-04-19-export-botify-csv-api.md
/home/mike/repos/pipulate/downloads/export_registry.json
""".splitlines()[:-1]  # Remove the last empty line
```

The above bit of code picks files from the git repo comprising the project, plus
reaching out into another repo, picking yesterday's article. The prompt is
actually going to have 2 articles in it: yesterday's as the file-includer
indicates, and today's (this one) which I'll include on context-foo's
command-line.

```bash
python context_foo.py --article-mode --article-path /home/mike/repos/MikeLev.in/_posts/2025-04-20-file-polling-progress-indicator.md
```

## Understanding the Single-Shot Prompt Strategy

All that effectively turns my code-base, at least all the bits relevant to what
I'm asking AI, into a single-shot prompt, right down to multi-day project
context from yesterday's article into today's. Today's article (this one)
actually serves as the final instruction prompt because all that stuff at the
top is prefaced by instructions to get familiar with the codebase in
preparation for what it finds here at the end of the prompt in the form of this
article.

## Enhancing User Experience with Download Cosmetics

And so today, we're layering on the cosmetics to keep the user entertained and
improve the user experience during the download. I've had enough
over-engineering with the whole registry thing. I'm going to keep it for now,
because I do like the explicitness. It gives the ability to surf away and back
to this point in the workflow during a download. Downloads are effectively
interruptable so long as you don't revert steps. There will be edge cases and we
don't have to address them all at the price of simplicity. We want to retain any
simplicity that still may be in the system, haha!

## Future-Proofing with Progress Bar Architecture

Case in point, I actually have some spectacular long-running progress bar gauge
logic in the wings ready for when I'm up for the integration challenge, which
instead of being the generic indeterminate style `<progress />`, it's actually
deliberately progressed with JavaScript controlling `<progress value="68" max="100" />` 
values, but I'm keeping that complexity out of it for now. I just want to bank
the win of getting the progress element in there with the default indeterminate
behavior while I get down the polling and auto-download logic.

## Implementing Incremental Changes

But for right now, I want to build this up in a series of tiny chisel-strike
non-breaking steps outlined above, with the initial focus being on the removal
of the "Check Status" button. Let's start by getting polling in. Every 2
seconds, it should check to see if the download is ready. When it finds the
download is ready, we should switch the button to "Download CSV". That is the
totality of the initial request so that I can `git commit` it and bank the small
chisel-strike win before we move onto causing the download to occur
automatically, adding the progress bar, etc.

## Requesting Implementation Understanding

Is that all clear? Provide an article continuation demonstrating that you have a
deep understanding of the work we've done, the work ahead of us, and the initial
baby-steps we will be doing to bank our initial win.

Here's more or less what the AI coding assistant is going to see (with the "big"
files filled-in with XML wrapping):

```plaintext
=== Prompt Structure ===

--- Pre-Prompt ---
System Information:
  
You are about to review a codebase in preparation for implementing changes requested in an article.
Please study and understand the codebase thoroughly, as you will need this context
to provide meaningful implementation suggestions based on the article's requirements.

Key things to know about this codebase:
- It uses a hybrid approach with Nix for system dependencies and virtualenv for Python packages
- Always run `nix develop` before any commands in a new terminal
- FastHTML objects must be converted with to_xml() before returning responses
- The project is organized as a server with plugin-based workflows

Key Points:
  • Focus on understanding how the codebase currently implements related functionality
  • Note any existing patterns that could be leveraged for the requested changes
  • Consider how the requested changes would integrate with the current architecture

--- Files Included ---
• README.md (10,705 tokens)
• flake.nix (2,000 tokens)
• server.py (23,976 tokens)
• plugins/20_hello_workflow.py (7,173 tokens)
• training/hello_workflow.md (911 tokens)
• plugins/50_botify_export.py (21,318 tokens)
• .cursorrules (688 tokens)
• /home/mike/repos/MikeLev.in/_posts/2025-04-19-export-botify-csv-api.md (56,045 tokens)
• /home/mike/repos/MikeLev.in/_posts/2025-04-20-file-polling-progress-indicator.md (1,173 tokens)

--- Post-Prompt ---
Introduction:

Now that you understand the codebase, please review the article's requirements and provide
specific implementation suggestions. Focus on how to modify the codebase to meet these requirements
while maintaining its architectural integrity and existing patterns.

Implementation Areas:
  • Required Changes
  • Integration Strategy
  • Implementation Plan

Focus Areas:
  • Practical implementation of the article's requirements
  • Maintenance of codebase integrity and patterns
  • Clear, actionable implementation steps

--- Token Summary ---
Total tokens: 124,481 tokens (≈$3.73 at GPT-4 rates)
Maximum allowed: 2,087,152 tokens (≈$62.61 at GPT-4 rates)
Remaining: 1,962,671 tokens (≈$58.88 at GPT-4 rates)

=== End Prompt Structure ===
```

---

## Three AI Opinions

> Why get the feedback from just one AI when you can get the opinion of three? 

My current routine is to go to Gemini 2.5, Grok 3 and ChatGPT o4-mini-high. All
three can astoundingly handle a prompt this big. Gemini 2.5 and Grok 3 handled
it handily with a paste into their prompt text-field. ChatGPT o4-mini-high was
not so graceful, but did handle it when I gave the super-prompt as a file-upload
(with no other prompt instructions) instead.

---

## Gemini 2.5 Responds to Super-Prompt

**Gemini 2.5**: Okay, let's refine the Botify CSV export workflow to incorporate automatic polling and download initiation, replacing the manual buttons and enhancing the user experience.

## Understanding the Journey So Far and the Path Ahead

We've successfully built a multi-step Pipulate workflow (`plugins/50_botify_export.py`) that goes significantly beyond the initial "Hello World" template. It now:

1.  **Parses & Stores Botify URLs:** Takes any project URL, extracts key components (org, project), canonicalizes the URL, and stores all pieces in the workflow state for `step_01`.
2.  **Selects Analysis:** Fetches available analysis slugs via the Botify API for the specified project and allows the user to select one using a dropdown menu in `step_02`.
3.  **Calculates Safe Export Depth:** Queries the Botify API to determine URL counts per click depth and calculates the maximum depth (`step_03`) that keeps the total URL count under the 1-million export limit, presenting this to the user.
4.  **Initiates Export Jobs:** Allows configuration of included fields (title, meta description, H1) and initiates an asynchronous export job via the Botify `/jobs` API endpoint (`step_04`).
5.  **Manages Job State:** Uses a central JSON registry (`downloads/export_registry.json`) to track submitted jobs, their parameters (org, project, analysis, depth), status (PROCESSING, DONE), and download URLs/local file paths. This allows for idempotency and resuming workflows.
6.  **Handles Downloads:** Includes logic to download the completed export file from the provided URL, save it to an organized local directory structure (`downloads/org/project/analysis/`), and even unzip `.zip` or `.gz` archives.

However, as identified, the user experience around the asynchronous export job in Step 4 needs improvement. The current reliance on manual "Check Status" and "Download CSV" buttons is functional but clunky.

**The Goal:** Transition to a smoother, more automated experience:

1.  **Remove Manual Buttons:** Eliminate the "Check Status" and "Download CSV" buttons.
2.  **Implement Automatic Polling:** After initiating an export, the UI should automatically poll the Botify API every few seconds to check the job status.
3.  **Display Progress:** While polling, show the user an indeterminate progress indicator (using `<progress />` from PicoCSS).
4.  **Trigger Automatic Download:** Once polling detects the job is "DONE" and provides a download URL, automatically initiate the server-side download process.
5.  **Update Final Status:** After the download (and potential unzipping) completes successfully, update the UI to show the final "Download Complete" status with the local file path.
6.  **Maintain Interruptibility:** Ensure this process works correctly even if the user navigates away and returns later (leveraging the state and registry).

We will achieve this using HTMX's polling capabilities and refining the logic within the `step_04` GET handler and the `/download_csv` POST handler.

---

## Implementation Plan: Automatic Polling & Download

Here's the refined plan, focusing on the first small step: implementing polling and automatically switching to a "Download CSV" button (we'll remove the button entirely in the *next* step).

**Step 1: Implement Polling and Button Switch**

1.  **Modify `step_04_submit`:**
    * After successfully initiating the export job and registering it, return the initial "Processing" UI.
    * Crucially, embed a `div` within this UI that will trigger the polling via HTMX. This `div` will target the `step_04` *GET* endpoint itself.

2.  **Modify `step_04` (GET Handler):**
    * Enhance this method to handle different states based on the `pipeline_id`'s data in the state/registry.
    * **If Job is PROCESSING:**
        * Perform a `poll_job_status` check.
        * If *still* PROCESSING: Return the "Processing" card, including the polling `div` (with `hx-trigger="every 2s"`) and the indeterminate `<progress />`.
        * If now DONE: Update the state/registry with the download URL. Return the "Ready for Download" card, which *for this intermediate step* will include the "Download CSV" button (but *not* the polling div).
        * If FAILED: Return an error card.
    * **If Job is DONE (and `download_url` exists but `local_file` doesn't):** Return the "Ready for Download" card with the "Download CSV" button.
    * **If Job is DONE (and `local_file` exists):** Return the final "Download Complete" card using `pip.revert_control`.
    * **If No Job Started Yet / Reverted To:** Return the initial export configuration form.

3.  **Refine Polling Trigger:** The polling `div` embedded in the "Processing" card will look like this:
    ```html
     <div id="step_04_poller"
         hx-get="/botify_csv/step_04"
         hx-trigger="load, every 2s"
         hx-target="#step_04"
         hx-swap="outerHTML">
         <progress></progress> Checking Status...
     </div>
    ```
    * `hx-get="/botify_csv/step_04"`: It calls the main GET handler for the step.
    * `hx-trigger="load, every 2s"`: It triggers immediately on load and then every 2 seconds.
    * `hx-target="#step_04"`: It targets the *entire* Step 4 container div.
    * `hx-swap="outerHTML"`: It replaces the entire Step 4 container with the response from the GET handler.

**Why this approach for Step 1?**

* It introduces polling without drastically changing the existing download flow yet.
* The `step_04` GET handler becomes the central point for checking status and rendering the correct UI state.
* It replaces the manual "Check Status" button with automatic checks.
* When the job completes, the polling `div` is naturally removed because the GET handler will return the "Ready for Download" card *without* the polling `div`.

This sets the stage perfectly for the next step: removing the "Download CSV" button and triggering the download automatically.

Let's proceed with implementing this first polling stage.

---

## Grok 3 Responds to Super-Prompt

**Grok 3**: 

Below is a complete and self-contained response to your query, focusing on implementing the initial polling requirement from your article "Pipulate Workflow: File Polling Progress Indicator" within the `plugins/50_botify_export.py` file of the Pipulate codebase. The response addresses the removal of the "Check Status" button and introduces automatic polling every 2 seconds until the download is ready, switching to a "Download CSV" button when complete. This aligns with your request for a small, incremental "chisel-strike" change to bank an initial win, while maintaining the architectural integrity of the codebase and following its established patterns.

---

# Implementation Suggestions for File Polling in Botify Export Workflow

## Required Changes

### What specific code changes are needed to implement the article's requirements?

To implement automatic polling every 2 seconds in Step 4 of the Botify Export workflow, replacing the "Check Status" button with a seamless transition to "Download CSV" when the export is ready, we need to modify the `step_04_submit` method in `plugins/50_botify_export.py`. The key changes involve:

1. **Removing Manual Status Check Logic:**
   - Eliminate the explicit "Check Status" button and its associated form, which currently requires user interaction to trigger the `check_export_status` endpoint.

2. **Introducing HTMX Polling:**
   - Use HTMX's polling capability (`hx-trigger="every 2s"`) to repeatedly call a status-checking endpoint until the export job completes.

3. **Updating UI Dynamically:**
   - Modify the UI to show a "Processing" state initially, then switch to a "Download CSV" button when polling detects job completion.

Here’s the specific code change:

```python
# In plugins/50_botify_export.py, replace the existing step_04_submit method with:
async def step_04_submit(self, request):
    """Handle the submission of the CSV export options and start the export job"""
    pip, db, steps, app_name = self.pipulate, self.db, self.steps, self.app_name
    step_id = "step_04"
    step_index = self.steps_indices[step_id]
    step = steps[step_index]
    pipeline_id = db.get("pipeline_id", "unknown")
    
    # Handle finalized state using helper
    if step.done == 'finalized':
        return await pip.handle_finalized_step(pipeline_id, step_id, steps, app_name, self)

    # Get form data
    form = await request.form()
    include_title = form.get("include_title") == "true"
    include_meta_desc = form.get("include_meta_desc") == "true"
    include_h1 = form.get("include_h1") == "true"
    
    # Get data from previous steps
    state = pip.read_state(pipeline_id)
    step_01_data = pip.get_step_data(pipeline_id, "step_01", {})
    step_02_data = pip.get_step_data(pipeline_id, "step_02", {})
    step_03_data = pip.get_step_data(pipeline_id, "step_03", {})
    
    org = step_01_data.get('org')
    project = step_01_data.get('project')
    analysis = step_02_data.get('analysis')
    depth = step_03_data.get('depth')
    
    # Check if we have all required data
    if not all([org, project, analysis, depth]):
        return P("Missing required data from previous steps.", style=pip.get_style("error"))
    
    # Check if there's already an export job with these parameters
    existing_jobs = self.find_export_jobs(org, project, analysis, depth)
    completed_jobs = [job for job in existing_jobs if job['status'] == 'DONE' and job.get('download_url')]
    processing_jobs = [job for job in existing_jobs if job['status'] == 'PROCESSING']
    
    # Handle completed jobs
    if completed_jobs:
        job = completed_jobs[0]
        job_id = job['job_id']
        download_url = job['download_url']
        
        if step_id not in state:
            state[step_id] = {}
        
        state[step_id].update({
            'job_url': job['job_url'],
            'job_id': job_id,
            'org': org,
            'project': project,
            'analysis': analysis,
            'depth': depth,
            'download_url': download_url,
            'status': 'DONE',
            'include_fields': {
                'title': include_title,
                'meta_desc': include_meta_desc,
                'h1': include_h1
            }
        })
        state[step_id][step.done] = job['job_url']
        pip.write_state(pipeline_id, state)
        
        await self.message_queue.add(
            pip, 
            f"Using existing export job (ID: {job_id}).\nThe export is ready for download.", 
            verbatim=True
        )
        
        return Div(
            Card(
                H4("Export Status: Complete ✅"),
                P(f"Job ID: {job_id}", style="margin-bottom: 0.5rem;"),
                P(f"The export with your requested parameters is ready for download.", 
                  style="margin-bottom: 1rem;"),
                Form(
                    Button("Download CSV", type="submit", cls="primary"),
                    hx_post=f"/{app_name}/download_csv",
                    hx_target=f"#{step_id}",
                    {% raw %}hx_vals=f'{{"pipeline_id": "{pipeline_id}"}}'{% endraw %}
                )
            ),
            pip.create_step_navigation(step_id, step_index, steps, app_name, job['job_url']),
            id=step_id
        )
    
    # Handle processing jobs or start new export
    job_url = None
    job_id = None
    
    if processing_jobs:
        job = processing_jobs[0]
        job_url = job['job_url']
        job_id = job['job_id']
        
        created = job.get('created', 'Unknown')
        try:
            created_dt = datetime.fromisoformat(created)
            created_str = created_dt.strftime("%Y-%m-%d %H:%M:%S")
        except:
            created_str = created
        
        await self.message_queue.add(
            pip, 
            f"Using existing export job (ID: {job_id}).\n"
            f"Started: {created_str}", 
            verbatim=True
        )
    else:
        # Prepare fields to include
        include_fields = {
            'title': include_title,
            'meta_desc': include_meta_desc,
            'h1': include_h1
        }
        
        try:
            api_token = self.read_api_token()
            download_dir = await self.create_download_directory(org, project, analysis)
            
            job_url, error = await self.initiate_export_job(
                org, project, analysis, depth, include_fields, api_token
            )
            
            if error:
                return P(f"Error initiating export: {error}", style=pip.get_style("error"))
            
            job_id = job_url.split("/")[-1]
            self.register_export_job(org, project, analysis, depth, job_url, job_id)
            
            await self.message_queue.add(
                pip, 
                f"Export job started with Job ID: {job_id}\n"
                f"The export is processing and may take several minutes.", 
                verbatim=True
            )
        except Exception as e:
            logger.error(f"Error in export submission: {str(e)}")
            return P(f"An error occurred: {str(e)}", style=pip.get_style("error"))
    
    # Store initial job info in state
    if step_id not in state:
        state[step_id] = {}
    
    state[step_id].update({
        'job_url': job_url,
        'job_id': job_id,
        'org': org,
        'project': project,
        'analysis': analysis,
        'depth': depth,
        'status': 'PROCESSING',
        'include_fields': {
            'title': include_title,
            'meta_desc': include_meta_desc,
            'h1': include_h1
        }
    })
    state[step_id][step.done] = job_url
    pip.write_state(pipeline_id, state)
    
    # Return UI with polling
    return Div(
        Card(
            H4("Export Status: Processing ⏳"),
            P(f"Job ID: {job_id}", style="margin-bottom: 0.5rem;"),
            P(f"Exporting URLs up to depth {depth}", style="margin-bottom: 0.5rem;"),
            P(f"Including fields: " + 
              ", ".join([k for k, v in include_fields.items() if v]),
              style="margin-bottom: 1rem;"),
            P("Checking status...", style="color: #666;")
        ),
        hx_get=f"/{app_name}/check_export_status",
        hx_trigger="every 2s",
        hx_target=f"#{step_id}",
        hx_swap="outerHTML",
        {% raw %}hx_vals=f'{{"pipeline_id": "{pipeline_id}", "job_url": "{job_url}", "job_id": "{job_id}"}}',{% endraw %}
        id=step_id,
        *pip.create_step_navigation(step_id, step_index, steps, app_name, job_url)
    )
```

### Which existing components need to be modified or extended?

- **Modified Component:**
  - `step_04_submit`: The primary change occurs here, replacing the static "Check Status" button with an HTMX polling mechanism that updates the UI dynamically.

- **Extended Component:**
  - `check_export_status`: This existing method will be reused as the polling endpoint, but its output will be adjusted to return the full step UI rather than just a status update, allowing seamless replacement of the card.

No other core components (e.g., `Pipulate` class, registry functions) require modification for this initial step.

### What new components or patterns need to be introduced?

- **No New Components:** This change leverages existing methods (`check_export_status`) and doesn’t require new helper functions.
- **New Pattern:** Introduction of HTMX polling (`hx-trigger="every 2s"`) as a lightweight mechanism to check job status without adding complex background tasks or WebSocket infrastructure, aligning with the WET philosophy of keeping logic explicit within the step.

## Integration Strategy

### How should these changes be integrated with existing functionality?

- **Leverage HTMX:** Use HTMX’s built-in polling feature to call `check_export_status` every 2 seconds, replacing the entire Step 4 card (`#step_04`) with the updated UI when the job completes.
- **Reuse Existing Endpoint:** Extend the `check_export_status` method to handle the polling logic, ensuring it returns either a "Processing" card or a "Download" card based on the job status.
- **Maintain State Management:** Continue using the existing registry and state system to track job progress, ensuring idempotency and consistency.

### What existing patterns or conventions should be followed?

- **WET Workflow Pattern:** Keep the polling logic within the step’s submit handler, avoiding external abstractions or superclasses, consistent with the explicit, self-contained nature of Pipulate workflows.
- **FastHTML Rendering:** Return `Div` and `Card` objects with proper HTMX attributes, adhering to the server-side rendering pattern where `to_xml()` is handled by the framework.
- **Pipulate Helpers:** Use `pip.create_step_navigation`, `pip.get_step_data`, and `pip.write_state` for navigation and state management, preserving the established workflow structure.

### How can we ensure backward compatibility?

- **Isolate Changes:** Modify only `step_04_submit` and rely on the existing `check_export_status`, avoiding changes to core components like `Pipulate` or other workflow steps.
- **Preserve Registry:** The export registry remains intact, ensuring existing job tracking continues to work as before.
- **Maintain UI Flow:** The step progression and navigation remain unchanged, only enhancing the user interaction within Step 4.

## Implementation Plan

### What’s the recommended order for implementing these changes?

1. **Backup Current State:**
   - Commit the current working version (`git commit -m "Pre-polling baseline"`) to preserve the functional state.

2. **Modify `step_04_submit`:**
   - Replace the "Check Status" form with an HTMX polling attribute (`hx-trigger="every 2s"`).
   - Update the UI to return a "Processing" card with polling enabled.

3. **Adjust `check_export_status`:**
   - Modify it to return the full Step 4 UI (`Div` with `Card`) rather than just a status update, ensuring it can replace the polling card with a "Download CSV" card when complete.

4. **Test the Polling:**
   - Start an export job and verify that polling occurs every 2 seconds until completion, then switches to the download button.

### What are the key milestones or checkpoints?

- **Milestone 1: Polling Initiated**
  - After clicking "Start Export", the UI shows "Processing" and begins polling every 2 seconds (visible in browser network requests).
- **Milestone 2: Automatic Transition**
  - When the job completes (simulated or real), the UI switches to show "Download CSV" without manual intervention.
- **Milestone 3: Commit Point**
  - Successful test of the polling-to-download flow, committed as a stable change (`git commit -m "Add polling to Step 4"`).

### What potential challenges or risks need to be addressed?

- **Polling Overhead:**
  - **Risk:** Frequent polling (every 2s) could strain the server or hit Botify API rate limits.
  - **Mitigation:** Start with 2s as specified, but test with longer intervals (e.g., 5s) if performance issues arise. The registry ensures no duplicate jobs, reducing API load.
- **UI Flicker:**
  - **Risk:** Rapid HTMX updates might cause visual flicker or inconsistent rendering.
  - **Mitigation:** Use `hx-swap="outerHTML"` to replace the entire card smoothly, and test in multiple browsers.
- **Job Status Sync:**
  - **Risk:** Polling might miss updates if the Botify API response lags or if the registry isn’t updated promptly.
  - **Mitigation:** Rely on the registry as the source of truth and ensure `poll_job_status` updates it consistently.

---

This implementation introduces automatic polling as a small, non-breaking change, replacing the manual "Check Status" button with a seamless transition to "Download CSV" when ready. It maintains the WET workflow’s simplicity, leverages HTMX for polling, and builds on the existing registry system without requiring complex new infrastructure. Once this is committed, we can layer on the progress indicator and auto-download features in subsequent steps, banking this win as requested.

---

## ChatGPT o4-mini-high Responds to Super-Prompt

> The prompt has grown to a size where it can no longer be pasted into the
> text-field for o4-mini-high but had to be added as a file-attachment. It was
> interesting watching it parse the file with Python and handle it with grace.

**ChatGPT o4-mini-high**: 

Below is a concrete, step‑by‑step proposal for weaving in automatic polling, an indeterminate PicoCSS progress bar, and auto‑download logic into the existing Botify export workflow—all while preserving the current patterns and minimizing disruption citeturn1file0.

---

## 1. Required Changes

1. **Remove “Check Status” / “Download CSV” buttons**  
   - In `step_04_submit`, instead of rendering a manual “Check Status” or “Download CSV” button, return a single container that:  
     - Shows the PicoCSS indeterminate progress bar  
     - Includes an HTMX-enabled `<div>` with `hx-get`/`hx-trigger="every 2s"` pointing at a new `download_progress` endpoint  

2. **Register two new endpoints** in `plugins/50_botify_export.py`’s `__init__`:  
   ```python
   # inside BotifyExport.__init__(…)
   rt(f"/{app_name}/download_progress")(self.download_progress)
   rt(f"/{app_name}/download_csv", methods=['POST'])(self.download_csv)
   ```

3. **Implement `download_progress` handler**  
   - Read pipeline state (`pip.read_state(pipeline_id)`)  
   - If job is still processing:  
     ```html
     <Div id="download-status"
          hx-get="/{app_name}/download_progress"
          hx-trigger="every 2s"
          hx-swap="outerHTML">
       <progress></progress>  <!-- PicoCSS indeterminate -->
       <P>Export in progress…</P>
     </Div>
     ```
   - If job is done and file not yet downloaded: render a hidden form that immediately POSTS to `download_csv` via JavaScript (or use `hx-trigger="load"` on a zero‑pixel auto‑submit button)  
   - If file already downloaded: show the “CSV downloaded” message with `pip.revert_control`  

4. **Implement `download_csv` handler**  
   - Pull the `download_url` from state, stream it to the client using the existing streaming/download pattern in `BaseCrud` (i.e. generate a streaming response or trigger browser download via a temporary redirect)  
   - Update state to mark the file as downloaded  

---

## 2. Integration Strategy

- **Follow existing HTMX/`to_xml` conventions**  
  - Always return FastHTML components and wrap with `to_xml(…)` before sending  
  - Keep new endpoints in the same plugin class and register via `rt(...)` as shown in other routes  

- **Leverage the pipeline state model**  
  - Store `job_url`, `download_url`, and a new `downloaded` flag in the JSON blob under `step_04`  
  - That way, if the user navigates away and returns, `download_progress` will pick up where it left off and immediately serve the correct UI  

- **Ensure backward compatibility**  
  - Preserve the existing `find_export_jobs` logic for idempotency  
  - If someone still calls the old “Check Status” route, you can have it redirect (or delegate) to `download_progress` so nothing breaks  

---

## 3. Implementation Plan

| Milestone                      | Description                                        | Checkpoint                          |
|--------------------------------|----------------------------------------------------|-------------------------------------|
| **A. Polling endpoint**        | Add `download_progress` route and handler          | HTMX‑polling `<div>` appears        |
| **B. Progress bar integration**| Render PicoCSS `<progress>` in polling UI          | Indeterminate bar spins             |
| **C. Auto‑download trigger**   | Implement `download_csv`, auto‑POST on completion  | Browser download prompt appears     |
| **D. Surf‑away support**       | Verify state persists when navigating away/back    | Polling resumes and finishes        |
| **E. Clean‑up & polish**       | Remove legacy buttons, update docs/training MD     | No “Check Status” buttons remain    |

**Potential Risks & Mitigations**  
- **Over‑polling**: HTMX `every 2s` is light, but ensure your `download_progress` handler is O(1) and reads only minimal state.  
- **Race conditions**: As soon as `download_url` appears, immediately switch to `download_csv` to avoid duplicate downloads.  
- **Styling quirks**: PicoCSS’s `<progress>` is minimal—test its appearance in both light/dark modes.

---

By layering these changes as small, non‑breaking steps—first introducing the polling endpoint, then the progress bar, then the auto‑download trigger—we “bank” each win without regressing existing functionality citeturn1file0. Let me know if you’d like code samples for any of these handlers or further details on integrating with the HTMX triggers!

---

## Analyzing Similarities & Differences In 3 Approaches

> Please review this article and provide me an in-depth analysis of the
> similarities and differences between the approaches taken by each of the 3 AI
> models. Conclude with the recommended "best-of" implementation.

Which Model Do I Ask? Well, all 3 of course! Gemini favors Gemini's solution.
Grok favors Grok's solution. And ChatGPT is the diplomat saying use the best
from each.

---

# Google Gemini 2.5 Comparison

**Gemini 2.5**: Okay, let's break down the responses from Gemini 2.5, Grok 3, and ChatGPT o4-mini-high regarding the implementation of the file polling and progress indication for the Botify CSV export workflow.

## Analysis of AI Approaches

All three AI models demonstrated a strong grasp of the project's context, the existing codebase (FastHTML, HTMX, state management, plugin structure), and the specific requirements outlined in the article for enhancing Step 4 of the `botify_export` plugin. They all understood the need to move from manual buttons to automatic polling and eventually automatic download, while maintaining interruptibility via the state/registry system.

### Similarities

1.  **Core Goal:** All correctly identified the primary objective: replace manual "Check Status" and "Download CSV" buttons with an automated polling mechanism using HTMX, display progress, and eventually trigger the download automatically.
2.  **HTMX for Polling:** All converged on using HTMX's polling capability (`hx-trigger="load, every 2s"` or similar) as the appropriate client-side mechanism to periodically check the job status.
3.  **State/Registry Reliance:** All recognized that the existing `pipeline_id`-based state and the `export_registry.json` are crucial for tracking job status and enabling the workflow to be interruptible (surf-away and return).
4.  **Incremental Approach:** All acknowledged the request to implement this in small, "chisel-strike" steps, focusing first on getting the polling working to replace the "Check Status" button and display the "Download CSV" button upon completion.
5.  **PicoCSS Progress Bar:** All understood the requirement to display the indeterminate `<progress>` element during the polling phase.
6.  **UI Updates:** All proposed solutions involve the server dynamically returning different HTML fragments (cards) based on the current job status retrieved during polling.

### Differences

The main divergence lies in *which* server-side endpoint the HTMX poller should target and *how* the UI updates should be structured:

1.  **Polling Endpoint Strategy:**
    * **Gemini 2.5:** Suggests reusing the main **`step_04` GET handler**. The `div` with `hx-get="/botify_csv/step_04"` would repeatedly call the same endpoint that's responsible for rendering the entire Step 4 UI based on the current state. This handler would need added logic to check the job status if it's processing.
    * **Grok 3:** Suggests reusing the existing **`check_export_status` endpoint** (`hx-get=f"/{app_name}/check_export_status"`). This requires modifying `check_export_status` to return the *entire* Step 4 card HTML (not just a status message), including the navigation, so it can replace the previous card via `hx-swap="outerHTML"`. It provided a full code example for `step_04_submit` embedding this polling logic.
    * **ChatGPT o4-mini-high:** Proposes creating a **new, dedicated endpoint** like `/{app_name}/download_progress`. This new endpoint would specifically handle the polling logic and return the appropriate UI fragment (progress bar or download trigger).

2.  **Focus of Initial Implementation:**
    * **Gemini & Grok:** Strictly adhered to the request for the *first* baby step: implement polling that results in showing the "Download CSV" button when the job is done.
    * **ChatGPT:** While outlining incremental steps, its initial proposal immediately discussed the full solution, including the auto-download trigger mechanism (e.g., auto-submitting form), going slightly beyond the scope of the immediate request.

3.  **Code Detail:**
    * **Grok:** Provided the most concrete initial implementation by offering a fully rewritten `step_04_submit` Python function incorporating the FastHTML/HTMX for polling.
    * **Gemini:** Provided conceptual HTML/HTMX snippets for the polling trigger and described the necessary logic changes in the GET handler.
    * **ChatGPT:** Provided conceptual HTML snippets and endpoint registration code, focusing more on the overall structure with new endpoints.

### Evaluation of Differences

* **Endpoint Strategy:**
    * *Gemini (Reuse `step_04` GET):*
        * **Pro:** Conceptually clean, as `step_04` GET is already the canonical way to render Step 4's UI based on state. Keeps logic centralized for this step.
        * **Con:** Might slightly overload the `step_04` GET handler, mixing initial rendering logic with polling status checks.
    * *Grok (Reuse `check_export_status`):*
        * **Pro:** Leverages an existing endpoint named for status checking. Clear code example provided.
        * **Con:** Requires significantly changing the *return type* of `check_export_status` from a simple status to the full step UI, which might feel like repurposing it beyond its original intent.
    * *ChatGPT (New `download_progress` endpoint):*
        * **Pro:** Clear separation of concerns; the polling logic is isolated.
        * **Con:** Introduces a new endpoint, slightly increasing complexity compared to reusing existing ones.
* **Initial Step Focus:** Gemini and Grok's stricter adherence to the immediate baby step is preferable for ensuring a non-breaking, committable change as requested.

## Recommended "Best-of" Implementation (for the first step)

Based on the analysis and the goal of minimizing changes while maintaining clarity for the *initial* step (polling leading to the "Download CSV" button):

1.  **Adopt Gemini's Endpoint Strategy:** Reuse the main **`step_04` GET handler**. This feels the most consistent with the existing pattern where the step's GET handler is responsible for rendering the step's UI based on the current state.
2.  **Modify `step_04_submit` (POST):**
    * Remove the logic that renders the "Check Status" button.
    * After successfully initiating the job (or finding an existing PROCESSING job) and updating the state/registry, return the "Processing" card.
    * Embed the **polling `div`** inside this card, as suggested by Gemini/Grok/ChatGPT:
        ```html
         <Div id="step_04_poller"
             hx-get="/botify_csv/step_04"  hx-trigger="load, every 2s"
             hx-target="#step_04"         hx-swap="outerHTML">         <progress></progress> Checking Status...
         </Div>
        ```
    * Ensure the card includes the standard step navigation (`pip.create_step_navigation`).
3.  **Modify `step_04` (GET Handler):**
    * Add logic at the beginning to check if `pipeline_id` exists and load the state.
    * Check the job status associated with this step in the state/registry.
    * **If `status == 'PROCESSING'`:**
        * Call `poll_job_status` to get the *latest* status from Botify API and update the registry/state.
        * If it's *still* PROCESSING: Return the "Processing" card containing the polling `div` (as described above).
        * If it's now `DONE`: Update state/registry with `download_url`. Fall through to the DONE logic below.
        * If it FAILED: Return an error card.
    * **If `status == 'DONE'` (and `download_url` exists but `local_file` doesn't):**
        * Return the "Ready for Download" card. This card *must* include the **"Download CSV" button** (pointing to the existing `/download_csv` POST endpoint) but *must not* include the polling `div`.
    * **If `status == 'DONE'` (and `local_file` exists):**
        * Return the final "Download Complete" card using `pip.revert_control`.
    * **If no job started / initial state:**
        * Return the initial export configuration form.

**Why this approach for the first step?**

* It directly addresses the request: replaces "Check Status" with polling, uses the indeterminate progress bar, and ends by showing the "Download CSV" button.
* It centralizes the UI rendering logic for Step 4 within its own GET handler, aligning with existing patterns.
* It modifies existing components minimally.
* It leverages HTMX effectively for the dynamic updates.
* It produces a clear, committable "chisel-strike" win before tackling the automatic download in the next iteration.

This plan integrates the best elements: Gemini's logical endpoint choice, the clear HTMX polling pattern identified by all, and Grok/Gemini's focus on the exact scope of the initial request.

---

# xAI Grok 3 Comparison

**Grok 3**: Below is an in-depth analysis of the similarities and differences between the approaches proposed by Gemini 2.5, Grok 3, and ChatGPT o4-mini-high for implementing automatic polling and download initiation in the Botify CSV export workflow. Following the analysis, I provide a recommended "best-of" implementation that synthesizes the strengths of each approach.

## Analysis of Similarities

### Objective Alignment
All three AI models align with the goal of enhancing the user experience by automating the polling and download processes in the Botify CSV export workflow. They aim to:
- Eliminate manual buttons ("Check Status" and "Download CSV").
- Transition from single-shot polling to repeated polling until the download is ready.
- Provide a seamless, interruptible workflow that supports navigating away and returning.

### Use of HTMX
Each model leverages HTMX for asynchronous UI updates:
- **Gemini 2.5**: Uses `hx-get` on the `step_04` GET handler with `hx-trigger="every 2s"`.
- **Grok 3**: Employs `hx-get` on the existing `check_export_status` endpoint with `hx-trigger="every 2s"`.
- **ChatGPT o4-mini-high**: Proposes `hx-get` on a new `download_progress` endpoint with `hx-trigger="every 2s"`, and uses `hx-trigger="load"` for auto-download.

HTMX attributes like `hx-target` and `hx-swap` are consistently used to update the UI without full page reloads.

### State Management
The models emphasize maintaining state via the pipeline system (`pip.read_state`, `pip.write_state`):
- All store job-related data (e.g., `job_url`, `download_url`) in the pipeline state.
- This ensures the workflow can resume correctly after interruptions, a key requirement from the user query.

### Polling Mechanism
A polling interval of 2 seconds is universally adopted:
- Each model suggests checking job status every 2 seconds until completion, aligning with the user's initial request.

### UI Feedback
All approaches prioritize user feedback:
- They propose a "Processing" UI during polling and a transition to a download-related UI upon completion.
- The PicoCSS indeterminate progress bar is either explicitly included (ChatGPT) or implied (Gemini, Grok) as part of the polling UI.

### Idempotency
The existing export registry is respected:
- All models use it to avoid redundant API calls and manage job states, ensuring consistency with the current architecture.

---

## Analysis of Differences

### Implementation Details
- **Gemini 2.5**:
  - Modifies the `step_04` GET handler to handle all states (processing, done, error) and returns the appropriate UI.
  - Embeds polling within a `div` that calls `step_04` every 2 seconds.
  - Initially retains the "Download CSV" button, planning to automate it later.
- **Grok 3**:
  - Updates `step_04_submit` to return a polling UI that targets the existing `check_export_status` endpoint.
  - Reuses `check_export_status` to return the full step UI, switching to a "Download CSV" button when complete.
  - Focuses on leveraging existing components.
- **ChatGPT o4-mini-high**:
  - Introduces two new endpoints: `download_progress` for polling and `download_csv` for downloading.
  - Uses a hidden form or `hx-trigger="load"` to auto-download immediately upon job completion.

### UI Update Strategy
- **Gemini 2.5**:
  - Centralizes UI logic in the `step_04` GET handler, replacing the entire step container with each poll.
  - Offers a unified state machine approach.
- **Grok 3**:
  - Relies on `check_export_status` to return the full UI, replacing the card seamlessly.
  - Keeps changes localized to `step_04_submit` and reuses existing endpoints.
- **ChatGPT o4-mini-high**:
  - Separates polling (`download_progress`) and downloading (`download_csv`) into distinct endpoints.
  - Provides a modular design with clear separation of concerns.

### Download Triggering
- **Gemini 2.5**:
  - Switches to a "Download CSV" button when the job is done, deferring full automation to a later step.
- **Grok 3**:
  - Similarly transitions to a "Download CSV" button, with automation as a future enhancement.
- **ChatGPT o4-mini-high**:
  - Immediately triggers an auto-download using a hidden form or HTMX `load` event, fully eliminating the button.

### Progress Indicator
- **Gemini 2.5**: Implies the progress bar’s inclusion in the polling `div`.
- **Grok 3**: Mentions it implicitly within the "Processing" UI.
- **ChatGPT o4-mini-high**: Explicitly includes the PicoCSS `<progress>` tag in the polling UI.

### Endpoint Usage
- **Gemini 2.5**: Enhances the existing `step_04` GET handler, avoiding new endpoints.
- **Grok 3**: Reuses `check_export_status`, modifying its output to fit the polling needs.
- **ChatGPT o4-mini-high**: Adds new endpoints (`download_progress`, `download_csv`), increasing modularity but adding complexity.

---

## Recommended "Best-of" Implementation

The recommended implementation combines the simplicity and reuse focus of Grok 3, the state-driven approach of Gemini 2.5, and the immediate auto-download innovation of ChatGPT o4-mini-high. It adheres to the user’s request for incremental, non-breaking changes while delivering a polished, automated experience.

### Key Components
1. **Modify `step_04_submit`**:
   - After initiating the job, return a UI with an HTMX polling `div` targeting a new `check_job_status` endpoint.
   - Include the PicoCSS progress bar for visual feedback.

2. **Add `check_job_status` Endpoint**:
   - Poll the Botify API for job status every 2 seconds.
   - Return a "Processing" UI with the progress bar if still processing, or trigger the download if done.

3. **Automatic Download**:
   - When the job completes, return a hidden form that auto-submits to `download_csv` using `hx-trigger="load"`.
   - Eliminate the "Download CSV" button entirely.

4. **State Management**:
   - Update the pipeline state with `job_url` and `download_url`, ensuring interruptibility.

### Solution Code
```python
# In plugins/50_botify_export.py

# Register new endpoint in __init__
def __init__(self, pip, db, steps, app_name):
    # ... existing code ...
    rt(f"/{app_name}/check_job_status")(self.check_job_status)
    rt(f"/{app_name}/download_csv", methods=['POST'])(self.download_csv)

# Modified step_04_submit
async def step_04_submit(self, request):
    # ... existing code to initiate job ...
    pipeline_id = db.get("pipeline_id", "unknown")
    state = self.pip.read_state(pipeline_id)
    job_id = "extracted_job_id"  # Replace with actual extraction
    job_url = state["step_04"]["job_url"]

    return Div(
        Card(
            H4("Export Status: Processing ⏳"),
            P(f"Job ID: {job_id}"),
            P("Checking status..."),
            Progress()  # PicoCSS indeterminate progress bar
        ),
        hx_get=f"/{app_name}/check_job_status",
        hx_trigger="every 2s",
        hx_target="#step_04",
        hx_swap="outerHTML",
        {% raw %}hx_vals=f'{{"pipeline_id": "{pipeline_id}"}}',{% endraw %}
        id="step_04_poller"
    )

# New check_job_status endpoint
async def check_job_status(self, request):
    pipeline_id = request.query.get("pipeline_id")
    state = self.pip.read_state(pipeline_id)
    job_url = state["step_04"]["job_url"]
    job_id = state["step_04"]["job_id"]

    status, download_url = await self.poll_job_status(job_url)

    if status == "PROCESSING":
        return Div(
            Card(
                H4("Export Status: Processing ⏳"),
                P(f"Job ID: {job_id}"),
                P("Checking status..."),
                Progress()
            ),
            hx_get=f"/{app_name}/check_job_status",
            hx_trigger="every 2s",
            hx_target="#step_04",
            hx_swap="outerHTML",
            {% raw %}hx_vals=f'{{"pipeline_id": "{pipeline_id}"}}',{% endraw %}
            id="step_04_poller"
        )
    elif status == "DONE":
        state["step_04"]["download_url"] = download_url
        self.pip.write_state(pipeline_id, state)
        return Div(
            Form(
                Button("Download CSV", type="submit", style="display: none;"),
                hx_post=f"/{app_name}/download_csv",
                hx_trigger="load",
                hx_target="#step_04",
                hx_swap="outerHTML",
                {% raw %}hx_vals=f'{{"pipeline_id": "{pipeline_id}"}}'{% endraw %}
            ),
            id="step_04"
        )
    else:
        return P("An error occurred.", style="color: red;")

# Existing download_csv (simplified example)
async def download_csv(self, request):
    pipeline_id = (await request.form()).get("pipeline_id")
    state = self.pip.read_state(pipeline_id)
    download_url = state["step_04"]["download_url"]
    # Logic to stream/download file
    return Div(P("Download complete!"), id="step_04")
```

### Explanation
- **Incremental Step**: Starts with polling (Grok’s reuse ethos), adds the progress bar, and finishes with auto-download (ChatGPT’s innovation).
- **Simplicity**: Uses a single new endpoint (`check_job_status`) like Gemini’s centralized approach, avoiding excessive endpoint sprawl.
- **User Experience**: The progress bar and auto-download provide immediate feedback and automation, meeting all cosmetic goals.
- **Interruptibility**: State updates ensure the workflow resumes seamlessly, as per the user’s requirements.

This "best-of" solution banks the initial polling win, then layers on the progress bar and auto-download in subsequent commits, maintaining simplicity and leveraging existing patterns effectively.

---

# ChatGPT o4-mini-high Comparison

**o1-mini-high**: Below is a structured comparison of how Gemini 2.5, Grok 3, and ChatGPT o4‑mini‑high approached the “initial polling” change in the Botify CSV export workflow, followed by a synthesized “best‑of” recommendation.

### 1. Overall Structure & Focus

| Aspect                | Gemini 2.5                                                                                                                                       | Grok 3                                                                                                                                                                                                                                                        | ChatGPT o4‑mini‑high                                                                                                                                                |
|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **High‑Level Summary**| Lays out existing workflow steps, then clearly enumerates the goal (“Remove buttons → Poll → Download”) before diving into code.               | Provides a concise “Implementation Suggestions” section, splitting into Required Changes, Integration Strategy, and an Implementation Plan with milestones.                                                                                                   | Gives a three‑phase breakdown (Required Changes, Integration Strategy, Implementation Plan) along with a mini‑roadmap table; highlights PicoCSS progress bar sooner. |
| **Depth of Explanation** | Very thorough—walks through every branch (existing DONE jobs, processing jobs, new jobs), shows full replacement of `step_04_submit` with code. | Balanced depth—outlines only the `step_04_submit` diff, leans on existing `check_export_status`, and focuses on minimal new code.                                                                                                                              | Mid‑level depth—introduces new endpoints (`download_progress`, `download_csv`), touches on UI details (auto‑POST trick), and presents a milestone matrix.            |
| **Code vs. Narrative**| ~80% code, 20% narrative. Excellent for “drop‑in” ready patch, but can feel overwhelming if you just want the gist.                              | ~50/50 mix of narrative and code sketch. Gives enough to implement without drowning in lines.                                                                                                                                                                 | ~30% code snippet, 70% narrative. Emphasizes architecture and UX flow, deferring detailed code to follow‑up.                                                         |

---

### 2. Similarities

1. **Incremental, Non‑Breaking Change**  
   All three stress: keep it small, remove only the “Check Status” button for now, and leverage HTMX polling to replace that UI element.

2. **Reuse of Existing Patterns**  
   Each approach builds on the existing `step_04` GET handler or `check_export_status` endpoint, writes back into the export registry JSON state, and uses HTMX attributes (`hx-trigger="every 2s"`, `hx-swap="outerHTML"`, etc.).

3. **Clear Next Steps**  
   They all outline that after polling works and shows the “Download CSV” button, subsequent tasks (real‐time progress bar, automatic download, surf‑away resilience) will follow in further small commits.

---

### 3. Key Differences

- **Scope of Code Provided**  
  - **Gemini 2.5** gives a nearly complete `step_04_submit` implementation, handling every status branch in one shot.  
  - **Grok 3** shows only the diff within `step_04_submit` and refers to reusing `check_export_status` rather than rewriting it.  
  - **o4‑mini‑high** instead introduces two new endpoints, pushing the polling logic into a separate `download_progress` route and deferring download handling to `download_csv`.

- **UX Elements**  
  - Gemini 2.5 uses a basic `<progress>` in the polling div but keeps the “Download CSV” button until the next step.  
  - Grok 3 leaves the progress bar out entirely in this first round (focuses solely on polling and button switch).  
  - o4‑mini‑high immediately integrates the PicoCSS indeterminate `<progress>` in the polling view, signaling forward‑thinking.

- **Error & Edge‑Case Handling**  
  - Gemini 2.5 checks for existing “FAILED” jobs and surfaces an error card.  
  - Grok 3 mentions rate‑limit concerns and suggests testing slower intervals but doesn’t show error UI.  
  - o4‑mini‑high calls out race conditions and over‑polling but leaves UI details to follow‑up.

- **Planning & Milestones**  
  - Gemini 2.5 embeds its “plan” in narrative form under “Integration Strategy.”  
  - Grok 3 lays out clear A–E milestones in a bullet list.  
  - o4‑mini‑high uses a table of five checkpoints, making it very explicit and trackable.

---

### 4. Recommended “Best‑of” Implementation

**Synthesize** the strengths of all three:

1. **Endpoint Organization (from o4‑mini‑high):**  
   - Keep polling and download logic in dedicated `download_progress` and `download_csv` routes. This clean separation simplifies testing and future extension.

2. **In‑Context Polling (from Grok 3):**  
   - Use HTMX’s `hx-get="/download_progress"` on a small `<div>` wrapper, with `hx-trigger="load, every 2s"`, targeting the outer step container. Defer progress bar styling to the next round.

3. **Complete Status Branching (from Gemini 2.5):**  
   - In `download_progress`, handle all three states—PROCESSING (show polling div), DONE + no local file (render hidden auto-submit form or visible “Download CSV” button), DONE + file present (call `pip.revert_control`). Surface failures explicitly.

4. **UX Polishing Roadmap (from o4‑mini‑high’s milestones):**  
   - After verifying polling works, commit a second change to swap in the PicoCSS `<progress>` bar and then a third to auto‑POST the `download_csv` handler when complete.

5. **Documentation & Testing:**  
   - Annotate each endpoint with docstrings; add a simple integration test that mocks a “processing → done” transition to verify HTMX swaps and final download flow.

---

**Next Steps:**  
1. **PR #1:** Add `download_progress` & `download_csv` routes, wire up HTMX polling div.  
2. **PR #2:** Flesh out `download_progress` logic with full status‑branch handling and error cards.  
3. **PR #3:** Introduce PicoCSS `<progress>` styling and auto‑trigger for the download.  
4. **PR #4:** Update docs/training to remove legacy buttons and describe new UX.

This phased, componentized plan borrows the clean route structure from ChatGPT o4‑mini‑high, the minimal HTMX pattern from Grok 3, and the exhaustive state‑handling logic from Gemini 2.5—giving you a robust, maintainable, and user‑friendly initial polling implementation.
