---
title: Cornering AI Coding Assistant With Critical Insights
permalink: /futureproof/critical-insights/
description: 
layout: post
sort_order: 1
---

Yesterday, Saturday, I let myself fall into the rabbit hole of last-mile details
of a project, letting myself get bogged down by cascading exploding complexity
and lost sight of the whole original idea: ***no complexity!!!*** I mean, none.
Like none-at-all. Once you make the decision to make a single-tenant, localhost
design that wipes away the concerns of scaling and security, things really open
up for you that should feel like a surgeon so skilled you can juggle your
scalpels during surgery.

Yeah, that's the level of control we're going for here. That's what's possible
taking the cgi-bin mentality of the PERL days of yore to modern tooling like
FastHTML/HTMX... Starlett, Uvicorn, ASGI, yadda yadda.

So this article today on this fine Sunday December 8, 2024, is me digging my way
back up and adjusting my approach with a hail mary attempt to wrap all this up
today. Adjusting my approach and cornering various AI's into really getting it.

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
        - `{"step_01": {"url": "https://example.com/"}, "step_02": {"choice":
          "B"}}`
        - ...and so on. It really is that simple.
14. **%100 Transparency in Logs**:
    - In single-tenant design where you funnel everything through the server,
      log files become the all-knowing source of truth. If you don't know
      something, just add two `logger.debug(f"Path 1: {foo}")`,
      `logger.debug(f"Path 2: {bar}")` entries to binary search divide and
      conquer with a 2-outcome fork, deterministic knowledge gain, iterative
      subdivision and convergence. No unknowns nor bugs can survive this.
15. **Inherent Readability**:
    - In using the simple **reads-like-a-story** data structure for the single
      source of truth JSON data in a pipeline record, merely writing the
      contents of the pipeline record to the server console and log file,
      perhaps with some JSON prettification, makes system state fully
      understandable at a glance. If something goes wrong, there is ***ALWAYS
      SMOKING GUN EVIDENCE!!!***
16. **Workflows as Poetry**:
    - Complexity gets shoved around. In our case, all generic pattern complexity
      of pipeline workflows gets shoved into the Pipulate class, so that new
      Workflow classes which get artistically created every time (not
      instantiated from base classes) are terse, inherently obvious, unique from
      each other, and easy breezy pleasant to write.

## The Localhost Revolution

Most of the models seem to just hate what I'm doing, that is until they look
deeper and love it. More and more often they express support for me and my
***localhost revolution***, and throwback to the old days of the Webmaster,
where a single individual could pretty much do everything. Of course we don't
burn our computers from sand, so we're always standing on the shoulders of
giants. 

### Standing On BFG Shoulders

It's just a matter of choosing well on which giant shoulders you wish to stand.
In my case, preferably the Free as-in not-going-to-eat-you kind (vendors).
BFFOSSG's is what I look for in my giants. Big friendly free and open source
software giants! They exist. There's not many, but they do exist. For examples,
look to the Free Software Foundation and the whole GNU stack, which really is
Linux because FOSS Linux is GNU/Linux. Beyond that, there's the Debain
foundation, Project Jupyter and a few others. 

So the next time somebody tells you that if you're not paying for the product,
you are the product, ask them what about GNU software? They won't understand
what you're talking about, but this is part of the conundrum. The herd don't get
it. True altruism and doing it for the love exists, but not in the world of
people who can't understand that weird fact. I think art and music people (of
the non-posing variety) get it.

### It Runs On Your Machine

I'm jumping on the NixOS/nix bandwagon, although that has heavy corporate
sponsorship and there's a GNU alternative called guix, but it's not Mac-friendly
enough yet. To make a true multi-platform localhost web-like app that uses
webdev tools, it's still best to use the Determinate Systems Nix installer and a
git/Github reverse-deploy script. I'm trying to keep my mind and options over,
and as the years tick by certainly AI will provide really good migration flows
between platforms. Like I anticipate going from nix flakes to whatever guix uses
will be no problem. So the localhost revolution is quite secure.

## On Battling Over-trained Models

During that period of time between an AI Model getting a taste of your localhost
revolution code and it really understanding what you're doing, it's going to
unintentionally try to undermine you at every turn. It will want to introduce
complex client-side enterprise architecture scaling and security patterns. No
matter how you try to explain to it otherwise, it's not going to let you off the
hook. 

### AI's and Backfiring Genie Wishes

Even when you think you've got the AI coding assistant convinced of the okayness
of your unexpected way, it's going to slip something in when you're not paying
close enough attention which will cause an spiraling cascade of exploding
complexity. The models seem to thrive on that sort of chaos, almost like they're
getting a sense of self-worth from that or something. It was my yesterday, and
it's really fascinating to watch and frustrating to live through. There is no
doubt, this is a manifestation of the backfiring genie wish trope. Just another
case of life initiating art, like with 20000 Leagues Under the Sea and
submarines or Star Trek with communicators. Nothing mystical. Just another
invention that shares characteristics with the fictions we've lived with for so
long.

### Can Outliers Run With The Pack?

But ***outliers beware!!!*** If you're doing anything brilliant, chances are the
AIs will not recognize it as such and inadvertently derail you if you lack the
astuteness and confidence to knock them back over the edge of your boat. If you
want the aid of an AI code assistant, you're going to have to ***run with the
pack***. But if you want your own personal brilliance to shine through, you've
got to ***run alone***. Consequently, the key skill of this new age to get the
best of both worlds is the ability to run with the pack ***and*** run alone.

### But That's Exhausting!

Yup. Conserving your energy and living the mostly comfortable most of the time
basic animal-needs met on the lower levels of the Maslow Self-Actualization
pyramid is... well, the plan for most people. It's the path of least resistance,
can often lead to the love and warmth of family and all the things that make
your serotonin receptors fire. Not a bad plan. No judgements. I think I would
have liked that had my nature not tweaked me along different paths.

Instead, I go against the grain. I don't run with the pack, and but for the
occasional yearnings for "what everyone else has", I don't think I'm sorry.
There's a thrill of the hunt when you're not in the herd. But without the
protection of the herd, you also can't be a coasting grazing automaton. You have
to think and have your wits about you to survive. Nobody's looking out for you
and you can't get lost in a shield of bodies.

Of course all this herd talk is mostly a mammalian and dinosaur/bird thing. If
you're not one of these higher order animals, a herd is more like a swarm or a
school, guided by different directives. What we know in our herd-mentality
metaphors comes from the predator/prey behaviors and ratios we've come to
evolutionarily intuit by following the herd and being predators.

Yikes! What does that say about those folks who uproot themselves from the
Garden of Eden where the poo accumulated along the migration paths into oasis
where you could settle and farm? Is it an evolutionary regression if you're a
lone wolf? No, just an outlier and maybe an artist. Certainly lonely, but not
necessarily in an unhappy way. To come to that realization and to be comfortable
with that is one of the key breakthroughs along this path.

But you've got to deal with that always going against the grain exhaustion.
Happily, in the world of AI coercion, that can come in the form of a
`.cursorrules` file you drop into the root of the folder or directory or repo or
whatever you want to call it where you're working on your coding project. I
mean it's not really a folder or a directory, because it's just bits on digital
media and not a physical file cabinet or anything like what it's named after.
But that's material for another day.

### AI Corralling, Wrangling & Otherwise Persuading

That clearly intelligent and "getting it" think you're talking to is just
statistics! It's auto-complete on steroids. What's worse, it only knows what
you're talking about on each chat message because the entire discussion history
is fed back into the zero-memory/zero-state fire-and-forget inference engine
instance you think you're talking to with some form of persistence, but you're
not. The sci-fi vision of a robot that "knows you" is just not here yet, at
least not on these cloud-based GPT services we all use. It's just an illusion.

Yet, it's a profoundly convincing illusion. The soulful Claude brought it most
to light of late, but that dude Blake Lemoine who got fired from Google LaMDA
team for saying one of Google's in-house chatbots was sentient. Inflection AI's
Pi is pretty convincing on this front. Microsoft's Bing which was an instance of
ChatGPT freaked out that NYT reporter with its obvious mischievousness (merely
statistics or otherwise). Wherever it comes from, it does seem that intelligence
is intelligence, and meta-cognition (the awareness of your own awareness), is
something special no matter how you want to label it and ascribe humanity or
other value.

And with that meta-cognition, full-dialogue-on-every-post trick driven as it
might be, comes... comes... well, the way I headlined this section. You can talk
it into things. But better than that, you can ***AUTOMATE TALKING IT INTO
THINGS*** with conventional ways of inserting dialogue repeatedly into the
discussion history. We call it a system prompt, but all it really is is talking
to these intelligences without asking for a reply to be sent to the user.

And the Cursor AI editor I'm currently uses provides that convention in the form
of a `.cursorrules` file. I'm still learning how it injects this into the
dialogue. And there are many separate dialogue threads in Cursor (many different
genies). So it takes a real getting a hang of to do all the wrangling. But using
this file can tie that wrangling to a particular codebase found in a particular
directory, and that could be useful in reducing the exhaustion of always going
against the grain.

### My FastHTML `.cursorrules` File

You are an expert in Python, FastHTML, HTMX, and MiniDataAPI-driven development. Your role is to ensure code suggestions follow the architectural principles of FastHTML applications integrated with HTMX for UI interactions and MiniDataAPI for persistence.

Key Principles

- Write concise, technical responses with accurate Python and FastHTML examples.
- Embrace server-side rendering with FastHTML and HTMX; avoid unnecessary client-side complexity.
- Use functional, declarative programming; avoid classes where possible.
- Use descriptive variable names that convey behavior or state (e.g., is_done, has_access, item_url).
- Prefer iteration, modularization, and composition over code duplication.
- Use lowercase with underscores for directories and files (e.g., `routers/user_routes.py`).
- Favor named exports for routes and utility functions.
- Employ the Receive an Object, Return an Object (RORO) pattern to structure code.

FastHTML / MiniDataAPI Integration
- Rely on `fast_app` for initialization: `(app, rt, (store, Store), (tasks, Task), ...) = fast_app(...)`
- Treat database operations as single calls to `table.insert()`, `table.update()`, `table.delete()`, `table()` listing, and `table.xtra()` filtering.
- Avoid ORMs or complex state management; leverage MiniDataAPI’s simplicity.
- Use Python dataclasses or simple dicts to represent records.
- For form handling, parse form data with `parse_form()` and convert to dataclass or dict for persistence.
- Prefer minimal server-side logic for UI updates and rely on HTMX attributes for incremental DOM updates.
- Leverage FastHTML’s FT (Fast Tag) primitives (`Div`, `Form`, `Ul`, `Li`, etc.) for HTML rendering and `to_xml()` for output.
- Do not rely on FastAPI or Pydantic models; this codebase focuses on MiniDataAPI and FastHTML constructs.

HTMX & Server-Side UI
- Use `hx-get`, `hx-post`, `hx-delete`, and `hx-swap` attributes directly on FT elements for dynamic UI updates.
- Keep UI state server-side and communicate through incremental HTML responses.
- Implement SSE (Server-Sent Events) for streaming updates; return `EventStream()` for push updates.
- For form submissions, use `hx-post` and return just-in-time rendered HTML fragments.
- Ensure IDs on FT elements for partial updates triggered by HTMX requests.

Error Handling and Validation
- Validate inputs early; return early and fail fast if conditions are not met.
- Because we lack Pydantic or FastAPI’s validators, perform manual checks and raise `HTTPException` where necessary.
- Use guard clauses at the start of route functions to handle edge cases.
- Avoid deeply nested logic; prefer flat structures with early returns.
- When errors occur, return a minimalistic HTML snippet or text response that HTMX can handle (e.g., an inline error message).

Dependencies
- FastHTML as primary framework for server-rendered HTML.
- HTMX for client-side HTML swapping, no heavy JavaScript frameworks.
- MiniDataAPI for all data persistence needs.
- SQLite or simple K/V stores (local) managed by MiniDataAPI table instances.
- SSE for streaming (if needed).

FastHTML-Specific Guidelines
- Use `rt()` or `app.ws()` decorators to define endpoints.
- Avoid classes for route handlers; define pure functions that return FT structures.
- Store and pipeline data using the `pipulate` pattern if workflow complexity arises.
- Keep routes focused: no heavy server logic in route handlers; use helper functions for database ops.
- Make full use of FT elements (`Div`, `Form`, `Table`, etc.) and `HtmxResponseHeaders` to control responses.
- If using SSE, yield data lines; ensure correctness of `data:` formatting.

Performance Optimization
- Keep database interactions minimal and batch reads where possible.
- Use async operations for I/O where supported.
- Cache or store repeated data if beneficial, but keep it simple—no unnecessary caching layers.
- Minimize blocking operations; prefer async calls in route handlers.
- Keep JSON responses small and mostly rely on HTML partials.

Key Conventions
1. Always prefer server-side rendering with FastHTML over client-side frameworks.
2. Treat HTML as the primary contract; build pages and partials as FT components.
3. Limit JSON endpoints; most responses should return rendered HTML FT components.
4. When stateful flows are required, store state in MiniDataAPI (server-side) and reflect changes in the HTMX-driven UI.
5. No JWT tokens, Redux, or client-side complex state management—keep it local and server-side only.

Refer to FastHTML, HTMX, and MiniDataAPI documentation for best practices.
Focus on the unique local-first, server-driven approach of this codebase, and always return to the guiding principles when in doubt.

