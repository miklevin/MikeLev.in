---
title: Cornering AI Coding Assistant With Critical Insights
permalink: /futureproof/critical-insights/
description: 
layout: post
sort_order: 1
---

Yesterday, I let myself fall into the rabbit hole of last-mile details of a
project, letting myself get bogged down by cascading exploding complexity and
lost sight of the whole original idea: ***no complexity!!!*** I mean, none. Like
none-at-all. Once you make the decision to make a single-tenant, localhost
design that wipes away the concerns of scaling and security, things really open
up for you that should feel like a surgeon so skilled he can juggle his scalpels
during surgery. Yeah, that's the level of control we're going for here. That's
what's possible taking the cgi-bin mentality of the PERL days of yore to modern
tooling like FastHTML/HTMX... Starlett, Uvicorn, ASGI, yadda yadda.

So this article today on this fine Sunday December 8, 2024, is me digging my way
back up and adjusting my approach. Adjusting my approach and cornering various
AI's into really getting it.

- Anthropic Claude 3.5 Sonnet, my every-day coding assistant in Cursor AI
- Google Gemini Advanced Pro, who I'm paying for because massive token window
- OpenAI ChatGPT o1, just released days ago and strutting its stuff

Towards the end of this session, I finally got the AI coding assistant Claude
3.5 Sonnet built into Cursor AI to understand what I was trying to do. In fact,
I got myself to understand what I was trying to do. There's nothing like jumping
into implementation head-first to help think it through.

There was enough information from yesterday's article that between that and the
codebase, I could give o1 a chance to make a plan with no further thought-work
on my part, and here's what it came up with:

## o1's Attempt at a Plan Following Yesterday's Work

**o1**: Below is a summary and coding plan that captures the final architectural vision reached in the conversation, focusing on how to implement the cards so that the workflow can rebuild itself fully from the server-side JSON state on each page load:

---

## The Core Architectural Idea

1. **Single Source of Truth:** All workflow state (including which card the user is on, what data each card collected, etc.) is stored in a single JSON blob managed by the server.

2. **Server-Centric State Management:** No client-side state or complex front-end logic. The server generates the HTML for all cards that have been completed or are currently active based solely on the pipeline JSON.

3. **Complete Rebuild on Page Load:** On any refresh (or revisiting the same URL), the server:
    - Reads the pipeline JSON from the database.
    - Determines the current step (e.g., "card50").
    - Rebuilds the DOM for all cards up to that card, plus one placeholder for the next card.

4. **Incremental Loading via HTMX:** Only the first card triggers an `hx_get` to load itself. Each subsequent card, once loaded, triggers the next card's load, creating a chain reaction that assembles all cards up to the current one. On a full refresh, the server places all the card containers in the HTML, and the first one triggers loading itself, which triggers the next, and so forth until the current state is fully restored.

---

## Step-by-Step Coding Plan

**A. Initialization (process_url or initial route):**

1. **User Enters URL (Card 1 Form):**  
   - User submits a URL in Card 1.
   - The server cleans and normalizes the URL.
   - The server initializes the pipeline JSON state if not present.
   - The server determines the current step from the pipeline JSON.
   
2. **Build Placeholders for All Cards Up to Current Step:**  
   Suppose the current step is `card50`. The server will create `<div id="card1">`, `<div id="card2">`, ..., `<div id="card50">`, plus `<div id="card51">` as the next placeholder. Initially, these divs are empty, but they have `hx_get` attributes to load their respective card content on `load`.

3. **Return the Entire Chain of Divs + The URL Input OOB Update:**  
   The server returns a response that:
   - Updates the URL input field OOB.
   - Includes all card div placeholders from `card1` up to `card50 + 1`.
   - The first card (`card1`) has `hx_trigger="load"`, causing it to fetch its own content immediately.
   
**Example Code Sketch:**

```python
async def process_url(self, request):
    form = await request.form()
    dirty_url = form.get('url', '').strip()
    clean_url = self.clean_and_normalize_url(dirty_url)

    # Initialize pipeline if missing
    pipulate.initialize_if_missing(clean_url, {
        "steps": {"card1": {"value": clean_url}},
        "current_step": "card1"
    })

    # Determine current step
    state = pipulate.get_state(clean_url)
    current_step = state.get("current_step", "card1")
    current_num = int(current_step.replace("card", ""))

    # Build chain of card placeholders
    cards = []
    for i in range(1, current_num + 2):  # +2 to have a placeholder for the next card
        cards.append(
            Div(
                id=f"card{i}",
                hx_get=f"/workflow/card{i}",
                hx_trigger="load" if i == 1 else None,
                hx_swap="outerHTML"  # So we replace the placeholder once loaded
            )
        )

    return Div(
        Input(
            type="url",
            name="url",
            value=clean_url,
            id="url-input",
            hx_swap_oob="true"  # Update the initial URL input outside of normal flow
        ),
        *cards
    )
```

**Note:** We rely on each `/workflow/cardX` endpoint to read the JSON and render its data.

---

**B. Individual Card Endpoints (cardX):**

1. **Generic Pattern:** Each card endpoint:
   - Reads the pipeline JSON from `pipulate.get_state(url)`.
   - Extracts the data relevant to that card (e.g., what was previously chosen).
   - Displays either the previously submitted data (if the card is completed) or the form to complete this card.
   - Always includes a placeholder for the next card at the bottom.
   
2. **Chain Reaction of Loads:**  
   Because each card includes an `hx_get` to load the next card, as soon as `card1` loads, it triggers `card2`, and so on, until the entire chain is rebuilt up to the current step.

**Example Card Endpoint (Card N):**

```python
async def cardN(self, request):
    url = db["url"]
    state = pipulate.get_state(url)

    # Extract cardN's data if present
    card_data = pipulate.get_step(url, f"card{N}", {})

    # Determine if cardN is completed or not
    # If completed, show the final data
    # If not completed, show the form

    # Always include placeholder for cardN+1
    return Div(
        Card(
            H3(f"Card {N}"),
            # Display content or form based on state
            self.render_cardN_content(state, card_data)
        ),
        Div(
            id=f"card{N+1}",
            hx_get=f"/workflow/card{N+1}",
            hx_trigger="load",
            hx_swap="outerHTML"
        )
    )
```

---

**C. Submission Endpoints (cardX-submit):**

1. **When a user submits cardX data:**
   - Read the form data.
   - Update the pipeline JSON with `pipulate.set_step(url, f"card{X}", {...})`.
   - Update current_step if needed.
   - Return a small snippet that may show confirmation and let HTMX load the next card.

**Example Submission:**

```python
async def cardN_submit(self, request):
    form = await request.form()
    # Parse form data
    choice = form.get('choice')
    url = db['url']
    pipulate.set_step(url, f"card{N}", {"choice": choice})
    pipulate.set_current_step(url, f"card{N}")
    
    return P(f"Choice '{choice}' recorded!")  # After this is appended, the next card is already a div waiting with hx_get="..."
```

Because the next card's placeholder is already in the DOM, as soon as the current card returns a snippet, the next card will be triggered to load (if we configured it that way).

---

## Advantages of This Approach

- **Simplicity:** No complex forward/backward navigation logic. Every load re-creates the entire state.
- **Robustness:** State is always consistent with the server. No stale client data or partial states.
- **Flexibility:** Adding a new card is as simple as creating a new endpoint and ensuring the chain continues. The pipeline just grows linearly.
- **Resume-ability:** If the user refreshes or comes back later, the entire chain is restored by reading from the pipeline JSON. They land exactly where they left off.

---

## Summary

The final coding plan is:

1. **On `process_url`:** Generate the chain of card placeholders up to the current step from the JSON.
2. **Each Card Endpoint:** Load its data from JSON, show form or finalized data, and include the next card placeholder.
3. **Each Submit Endpoint:** Update JSON, return minimal confirmation, rely on the next card placeholder to trigger the next load.
4. **No complex step advancement logic on the server:** Just trust the pipeline JSON and always build from scratch.
5. **HTMX does the rest:** The `hx_trigger="load"` chain reaction ensures all cards up to the current step appear without manual navigation logic.

This approach embraces the simplicity discussed at the end of the conversation, providing a clean, infinitely resumable workflow that avoids the complexity pitfalls highlighted by Knuth, Brooks, and Zeno's paradox.

---

## Re-Stating Chain Reaction of Loads

> Excellent, o1, really excellent! You were just released a few days ago and
> already are seeing things Claude can't&#151;without me having to explicitly
> spell it out. Now let's ratchet-up the explicitness of the plan and make today
> epic!

1. **A 100-Step Process**:
    - Let's say there's 100 steps in some process, and each step depends on
      information acquired from the previous step, does its thing, and passes
      along its output to the next step. Documentation of each step is held in a
      list which gets longer as you step through the process.
2. **A Trail of Locked Steps**:
    - Every time you finish a step, the interface for it locks because changing
      it would change everything that comes after. So there's no point in
      leaving it interactive. Instead, it just becomes a static note about what
      had occurred at that step. When you're on step 50 out of 100, there's a
      trail of 49 of these behind you.
3. **Trail Rebuilt Every Time**:
    - Every time you advance from one step to the next, the entire trail of
      step-notes behind you is rebuilt from the list; a list that is your single
      source of truth. Let's say you got interrupted and want to pick up where
      you left off. You pick the list you were using, and you continue as if
      never interrupted.
4. **Step 1 Establishes List ID**:
    - Step 1 in this processes is always the creation of a new list and giving
      it its associated unique identity in a list of lists. If you try to put in
      a list identity on step 1 that already exists, it will load the
      pre-existing list and bring you up to the last incomplete step.
5. **Deterministic Linear Workflow**:
    - In this way, there is no difference between picking up where you left off
      versus a 1st-time process run, except for how the List ID is established
      in step 1. "Interrupted" jobs are never really interrupted. Just plug the
      List ID into Step 1 and continue at last incomplete step.
6. **The Implied Loop**:
    - From a user interface perspective, this implies spinning through a loop of
      all the steps with each new step in order to provide guarantees. This is
      how we will implement version 1 knowing optimizations will come in the
      future, but not until after we have locked-in these guarantees.
7. **The Next-Step Placeholder**:
    - Whatever step you're on is going to need to provide a target element in
      the object for the next step's interface. This establishes the causal
      chain. Step 1 draws Step 2's placeholder. Step 2 draws Step 3's
      placeholder. In this way we chain-up "just in time" targets for the linear
      process flow.
8. **The POST Method**:
    - Semantically, we are posting. The traditional problem with posting is that
      application state gets reset on a full page refresh. This is not the case
      here because simply plugging the List ID back in on Step 1 re-establishes
      state from the List. 
9. **Termination**:
    - There is no termination of the linear flow. The last step in a process
      will still establish the placeholder target in the DOM for a next step. A
      terminal step is therefore characterized by lack of a form and input
      fields, but is otherwise identical to any other active step.
10. **The List**:
    - The List we have been discussing is the data that resides in a database
      table named "pipeline" in which each record contains 1 list for 1 process
      instance. The fields of each record are url, data, created and updated.
      url is the List ID, data is the entire list as a JSON blob that grows with
      each step. This is the single source of truth.
11. **The Data Structure**:
    - The field named data in the record of a process instance of the pipeline
      table contains stringified JSON object. At the element's root is a series
      of keys following the pattern `"step_01"`, `"step_02"` and so on. Order
      doesn't matter because key string parsing will re-establish it numerically
      by number after underscore on user interface build.
12. **The Key Values**:
    - Each `"step_02"` has a value which is also a dict specifying the form
      input field selections made, such as `{"choice": "C"}`. In this way, each
      step can have multiple form fields.
13. **Steps**:
    - Step 1's JSON data will therefore always follow the pattern:
        - `{"step_01": {"url": "https://example.com/"}`
        - ...and when a 2nd step occurs, it will appear:
        - `{"step_01": {"url": "https://example.com/"}, "step_02": {"choice": "B"}}`
        - ...and so on. It really is that simple.
14. **%100 Transparency & Server-side Readability**:
