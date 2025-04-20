---
title: 
permalink: /futureproof/file-polling-progress-indicator/
description: 
layout: post
sort_order: 1
---

Some journeys are epic. This is one. To catch up on what today's article talks
about, check yesterday's. The bulk of the work was done, constituting a
significant leap forward in building the Pipulate workflow for exporting CSV
data from Botify. We successfully implemented the core logic across multiple
steps: parsing Botify project URLs, selecting the desired analysis via API,
calculating the maximum safe click-depth to stay within API limits, and
crucially, initiating export jobs using Botify's asynchronous `/jobs` endpoint.

To manage this complexity and avoid redundant API calls, a central export
registry was introduced, tracking job statuses and downloaded file locations.
The workflow can now detect existing completed or in-progress jobs and handles
the final download and unzipping of the CSV file, laying a robust foundation for
the export functionality. 

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

All that effectively turns my code-base, at least all the bits relevant to what
I'm asking AI, into a single-shot prompt, right down to multi-day project
context from yesterday's article into today's. Today's article (this one)
actually serves as the final instruction prompt because all that stuff at the
top is prefaced by instructions to get familiar with the codebase in
preparation for what it finds here at the end of the prompt in the form of this
article.

And so today, we're layering on the cosmetics to keep the user entertained and
improve the user experience during the download. I've had enough
over-engineering with the whole registry thing. I'm going to keep it for now,
because I do like the explicitness. It gives the ability to surf away and back
to this point in the workflow during a download. Downloads are effectively
interruptable so long as you don't revert steps. There will be edge cases and we
don't have to address them all at the price of simplicity. We want to retain any
simplicity that still may be in the system, haha!

Case in point, I actually have some spectacular long-running progress bar gauge
logic in the wings ready for when I'm up for the integration challenge, which
instead of being the generic indeterminate style `<progress />`, it's actually
deliberately progressed with JavaScript controlling `<progress value="68" max="100" />` 
values, but I'm keeping that complexity out of it for now. I just want to bank
the win of getting the progress element in there with the default indeterminate
behavior while I get down the polling and auto-download logic.

But for right now, I want to build this up in a series of tiny chisel-strike
non-breaking steps outlined above, with the initial focus being on the removal
of the "Check Status" button. Let's start by getting polling in. Every 2
seconds, it should check to see if the download is ready. When it finds the
download is ready, we should switch the button to "Download CSV". That is the
totality of the initial request so that I can `git commit` it and bank the small
chisel-strike win before we move onto causing the download to occur
automatically, adding the progress bar, etc.

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
Total tokens: 1,432 tokens (≈$0.04 at GPT-4 rates)
Maximum allowed: 2,087,152 tokens (≈$62.61 at GPT-4 rates)
Remaining: 2,085,720 tokens (≈$62.57 at GPT-4 rates)

=== End Prompt Structure ===
```

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

**Grok 3**: Below is a complete and self-contained response to your query, focusing on implementing the initial polling requirement from your article "Pipulate Workflow: File Polling Progress Indicator" within the `plugins/50_botify_export.py` file of the Pipulate codebase. The response addresses the removal of the "Check Status" button and introduces automatic polling every 2 seconds until the download is ready, switching to a "Download CSV" button when complete. This aligns with your request for a small, incremental "chisel-strike" change to bank an initial win, while maintaining the architectural integrity of the codebase and following its established patterns.

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

**ChatGPT o4-mini-high**: Below is a complete and self-contained response to your query, focusing on implementing the initial polling requirement from your article "Pipulate Workflow: File Polling Progress Indicator" within the `plugins/50_botify_export.py` file of the Pipulate codebase. The response addresses the removal of the "Check Status" button and introduces automatic polling every 2 seconds until the download is ready, switching to a "Download CSV" button when complete. This aligns with your request for a small, incremental "chisel-strike" change to bank an initial win, while maintaining the architectural integrity of the codebase and following its established patterns.

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
