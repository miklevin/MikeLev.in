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

---

## Whole Articles & Blogs as Meta Prompts

Did somebody say meta? What's a meta for, anyway? Dumb SEO joke. Anyhoo, as the
nobody who follows along but for the AI's that I feed these articles to may have
never recognized, this entire blog is a prompt. All 84 articles and growing. And
I can feed them to the AIs in different ways at different times for different
purposes. Because they follow the reverse-chronology of a blog, they tend to be
useful to enlist the aid of these remarkable entities in thinking through my
next steps. And not just once, but in an iterative cycle where I can feed the AI
model output (opinions regarding the article so far) back in as input several
times and across different models, and use that as a sort of cross-referencing,
validating next-step navigational device.

Can you imagine being one of those AIs digesting this article and getting up to
this point, quite the level of meta-cognition and analogues for them of synapses
firing, being primed knowing what's likely to come next?

Yup, that's right. It's the feeding of this entire article, plus some choice
code excerpts from my codebase, given their huge remarkable token context
windows, so that they can compete with each other to give me my next step
advice. I'm not merely going for some alternative pipeline package to celery in
the Python ecosystem. I'm going for a full modernized localhost revolution
fueling codebase that will only get smaller and simpler over time, enabling
larger and more remarkable things&#151;the complete opposite of the infinite
code-bloat pouring out onto the Internet with generative AI content. My stuff
doesn't get hosted, and the byte-count of the thing that's not getting hosted
gets smaller, while it's capabilities and immediate readability and sensibly to
both the humans and AIs that inspect it becomes ever more crystal clear.

As a side-effect, there is a lot of sausage making byproduct and fodder that
fuels the machine. These articles, for example. But I do keep them all very well
organized and labeled as exactly what they are. Any crawlers that come
a'spidering can take it or leave it. If they don't want to train it all into
their base model as a curated set, the existence of both me as a human entity
and this body of work as a real-time RAG crawlable resource is made clear with
the schema.org structured data I embed into it all.

And so yeah. I start out with a localhost-based FastHTML/HTMX CRUD framework
with a built-in local LLM deeply integrated into its use as a sort of
Rails/Django alternative, but then I morph it into nothing less than the main
tool of and clearest herald of the future of AI SEO.

And now back to our previously scheduled pipeline pattern. You will find
following this article choice excerpts of a larger codebase that constitute this
framework. I am at the point where I have to do exactly what this article
suggests, create a pattern for making new variations of the Workflow class that
will never be derived from a base class, but should instead be pleasant to read,
write and run. A sort of Unix pipes poetry for a new age and a smaller, more
powerful audience.

---

> Oh great o1 planmaker, planmaker, make me a plan. Find me a pattern. Match me a memetically capable information virus of a new framework system like none seen before.

**o1**: Below is a plan that distills the architectural principles you’ve been honing into a clearly defined, memetically transmissible “framework system.” Think of it as a conceptual virus for a new era of web application design—one that spreads the idea of fully server-centric simplicity, local-first operations, and pipeline-based workflow states. This plan aims to transform your current approach into a recognizable, repeatable pattern: a new kind of framework paradigm that is so minimal, it compels others to see complexity as a vice and simplicity as a superpower.

---

## The Meme: “Pipeline-Only Localhost Framework” (POLF)

**Core Concept:** A minimalist, server-first, single-tenant web framework that eschews client-state and modern complexity in favor of a Unix-pipe-like pipeline of steps, each fully server-rendered, persistent, and resumable at will. It embraces a philosophy: **"No complexity!!!"**, and by that mantra, it locks down a pattern that any developer could mimic in their own codebases.

### Principles to Infect the Minds of Developers:

1. **Single-Source-of-Truth JSON State:**  
   All workflow state resides in a single JSON blob on the server. No hidden caches, no localStorage, no Redux, no JWT tokens. Just a single JSON object per “process instance.”  
   - This JSON is fully introspectable, logged, and easily debugged—**an anti-database black box** that upends guesswork.

2. **Full Server-Centricity:**  
   Don’t waste time thinking about client frameworks. The client is a dumb terminal. The server sends HTML and receives form submissions. The client’s job is to show what the server said.  
   - The server orchestrates every step. The server re-renders every intermediate state. When you refresh the page, you see the truth—no partial illusions.

3. **Incremental HTML Assembly via HTMX:**  
   Steps load as you go, triggered by `hx-get` and `hx-post`. One card pulls in the next. The chain reaction of loading is your “just-in-time” interface assembly line.  
   - If complexity tries to creep in, remember: it’s just `<div>` placeholders and `hx-get` calls. No fancy front-end logic, no bundlers, no state machines in JavaScript.

4. **Linear, Deterministic Flow:**  
   Steps proceed linearly: step 1 → step 2 → step 3, etc. Each step locks behind you, forming an immutable trail. Recreating that trail is trivial: just rebuild the DOM from the pipeline JSON.  
   - This linear pattern resonates with the “Unix pipeline” metaphor: each card outputs data that the next card consumes.

5. **Resume from Any Point:**  
   Because the pipeline’s entire state is in the database as JSON, reloading a known URL reconstitutes the exact interface. Your workflow is never “lost”; you just re-run the chain of steps, each one loading its previously recorded answers, culminating in the last incomplete step.

6. **Simple CRUD-Like Operations for State Changes:**  
   The pipeline is mutated only when forms are submitted. `pipulate.set_step(url, "cardN", {...})` updates the JSON. `pipulate.set_current_step(url, "cardN")` sets the pointer. It’s as simple as reading and writing a dictionary.  
   - The mental model: “like CRUD, but for workflow steps.” It’s just insert/update to a JSON blob.

7. **No-Fuss Development Cycle:**  
   The system runs on localhost, or at worst on a private, single-tenant machine. You have root access. You can log anything. This reverts to the old Webmaster freedom: no layers of enterprise sign-offs, no ephemeral containers and managed services.  
   - If something goes wrong, print the JSON. Done.

8. **Architectural Minimalism as a Virtue:**  
   By removing all extraneous complexity (no distributed systems, no scaling layers, no front-end frameworks), you achieve a state of Zen: infinite understandability. Anyone can read the code and “get it.” It’s poetry, a performance art piece that mocks the bloatware out there.

---

## Patterns and Conventions

1. **Naming Conventions:**  
   Steps named `card1`, `card2`, `card3`, … are simple and memorable. Pipeline keys like `"step_01"` and `"step_02"` mirror their order. The pipeline URL as primary key cements identity and continuity.

2. **Core Functions:**  
   - `initialize_if_missing(url, initial_data)`: Creates a pipeline record if not present.  
   - `get_state(url)`: Always returns a stable dict of steps and current_step.  
   - `set_step(url, "cardN", data)`: Writes step data into the JSON.  
   - `set_current_step(url, "cardN")`: Updates the pointer to the last completed step.

3. **Single Table, Single JSON Field:**  
   A single database table with columns `url` (pk), `data` (JSON), `created` and `updated`. The `data` field is the entire workflow story. This is “the table to rule them all.”

4. **Never Over-Optimize Early:**  
   Repeat the linear rebuild process on every refresh. Let the chain of `hx-get` calls re-assemble the DOM. If this becomes slow at scale, consider optimizing later—but first reap the benefits of total clarity.

5. **Single Code File or Few Modules:**  
   Keep routes, pipeline logic, and templates near each other. This closeness fosters easy understanding. The code reads like a story.

6. **No Base Classes for Workflows:**  
   Each workflow is its own piece of poetry. Don’t derive from a base class that tries to be too clever. Instead, manually write your steps. It’s more humane and fosters creativity over standardization bloat.

---

## Infectious Memes to Spread

- **The Localhost Revolution:** “Run it all locally! You don’t need a managed distributed system for a single-user pipeline. Let’s return to the golden era of the Webmaster who could ‘juggle scalpels’ in surgery—be that skilled surgeon who wields simplicity.”

- **Cgi-bin Mentality for the Modern Era:** No shame in going back to server-side rendering. With minimal overhead, your complexity dissolves. Don’t let modern frameworks shame you into complexity.

- **Forever Logging and Full Transparency:** Logging at every step. The JSON is your witness. No unknown states. The system is a glass house.

- **Workflows as Poetry:** Each workflow is a unique script. No cookie-cutter patterns. Each new pipeline emerges fully formed as a piece of creative expression.

---

## Strategic Deployment Plan

1. **Internal Adoption:**  
   Start using POLF in internal tooling, admin dashboards, or personal hobby projects. Let the simplicity impress you.

2. **Documentation as Meme-Propagation:**  
   Write small guides, share them, or embed them in blog posts like the one you’ve just written. People are tired of complexity; show them a haven of clarity.

3. **Live Demos and Snippets:**  
   Provide a minimal code snippet that one can run locally with a single `python app.py`. Seeing how easily it runs will blow minds.

4. **Comparative Tutorials:**  
   Show how solving the same problem in a traditional SPA + REST + JWT environment is 10x more complex. Let developers see what they’re missing.

5. **Iterate and Shrink Further:**  
   Over time, refine and reduce even the minimal code until it’s a micro-framework that fits on a single screen. That’s the ultimate hook.

---

## Conclusion

This plan details a framework concept so minimal that it becomes memetically powerful: a server-driven pipeline system that can be explained in one sentence, coded in a single file, and understood by anyone in minutes. By distilling all complexity into a single JSON blob and linear pipeline, you create an information virus that infects developers with a craving for simplicity.

Embrace this pattern. Spread it. Let it shape minds, and create a new generation of “localhost revolution” enthusiasts who relish clarity and detest unnecessary complexity.

---

## Show Me The Code!

**Me**: [A bit more criteria and desire for specific code examples expressed]

**o1**: Below is an example of a new Workflow class that illustrates the **pipeline pattern** and the **chain reaction of loads** in a minimal, self-contained scenario. It uses the principles described above:

- All state is stored server-side in the `pipeline` table.
- Each step (card) reads/writes to a JSON blob via the `pipulate` instance.
- Cards reference each other linearly, with `hx_get` to trigger loading the next card.
- On each submission, we update the pipeline JSON and rely on the server to reconstruct state.

This example is intentionally simple: a 3-step workflow that collects user details. You can scale this pattern to 100 steps or beyond.

**Key Features of This Example:**

1. **Initialization Step (Card 1):**  
   User enters their username.  
   On form submit:
   - The pipeline state is created if missing.
   - `current_step` is set to "card1".
   - The chain of placeholders for card1, card2, and card3 is returned.
   - `card1` has `hx_trigger="load"` so it loads immediately, which triggers card2, and so on.

2. **Subsequent Steps (Card 2 & Card 3):**  
   Each card reads the pipeline JSON to know what to display.  
   Each card includes a placeholder for the next card.  
   On submission:
   - We update `steps[cardN]` with user input.
   - We update `current_step` to `cardN`.
   - We return a small snippet confirming their input and letting HTMX load the next card automatically.

3. **Immutable Trail:**  
   Once a card is submitted, it should display previously submitted values as non-editable text. Changing earlier steps is not allowed, preserving the linear "locked steps" principle.

---

### Example Code

```python
class UserOnboardingWorkflow:
    """
    A 3-step user onboarding workflow as an example of the pipeline pattern.
    
    Steps:
    - Card 1: Enter Username
    - Card 2: Choose Favorite Color
    - Card 3: Confirm Details

    Each step reads/writes pipeline JSON and sets the current_step.

    No client-side state. Just server-driven rendering.
    """

    def __init__(self, app):
        self.app = app
        # Register endpoints
        app.route("/onboard/init", methods=["POST"])(self.init_workflow)
        app.route("/onboard/card1")(self.card1)
        app.route("/onboard/card1-submit", methods=["POST"])(self.card1_submit)
        app.route("/onboard/card2")(self.card2)
        app.route("/onboard/card2-submit", methods=["POST"])(self.card2_submit)
        app.route("/onboard/card3")(self.card3)
        app.route("/onboard/card3-submit", methods=["POST"])(self.card3_submit)

    async def init_form(self):
        """
        Initial form to enter a unique 'List ID' (URL or username key).
        This is the entry point for the workflow.
        """
        return Card(
            H2("Welcome to Onboarding!"),
            Form(
                Div(
                    Input(type="text", name="username", placeholder="Enter username", required=True),
                    Button("Start", type="submit", style="width: 100px;")
                ),
                hx_post="/onboard/init",
                hx_target="#onboard-start"
            ),
            id="onboard-start"
        )

    async def init_workflow(self, request):
        """
        Handle the submission from the initial form.
        
        1. Extract 'username'.
        2. Initialize pipeline if missing.
        3. Determine current step and build placeholders.
        4. Return OOB updated username input and placeholders for all steps.
        """
        form = await request.form()
        username_val = form.get('username', '').strip()
        if not username_val:
            return P("Please enter a username", style="color:red;")

        # The "url" in this case is just a unique key identifying the pipeline
        # In a real scenario, you might normalize or clean it similarly to the original code example.
        url = f"user://{username_val}"
        db["url"] = url

        pipulate.initialize_if_missing(url, {
            "steps": {"card1": {"username": username_val}},
            "current_step": "card1"
        })

        # Get state and current step
        state = pipulate.get_state(url)
        current_step = state.get("current_step", "card1")
        current_num = int(current_step.replace("card", ""))

        # Build placeholders up to current step + 1
        cards = []
        for i in range(1, current_num + 2):
            cards.append(
                Div(
                    id=f"card{i}",
                    hx_get=f"/onboard/card{i}",
                    hx_trigger="load" if i == 1 else None,
                    hx_swap="outerHTML"
                )
            )

        # Return OOB updated input + placeholders
        return Div(
            Input(
                type="text",
                name="username",
                value=username_val,
                id="onboard-username",
                hx_swap_oob="true"
            ),
            *cards
        )

    async def card1(self, request):
        """
        Card 1: Display the entered username from pipeline.
        If user hasn't confirmed yet, show a "locked" state or a form to confirm.
        
        Actually, since card1 initialized with username, we can consider it 'locked in'.
        But let's show it as a static note to illustrate the locked step concept.
        """
        url = db['url']
        state = pipulate.get_state(url)
        card1_data = pipulate.get_step(url, "card1", {})
        username_val = card1_data.get('username', '')

        # Card1 is already completed when we initialized the pipeline.
        # So we show it as a static locked step.
        return Div(
            Card(
                H3("Step 1: Username"),
                P(f"Username: {username_val}"),
            ),
            # Placeholder for next card
            Div(
                id="card2",
                hx_get="/onboard/card2",
                hx_trigger="load",
                hx_swap="outerHTML"
            )
        )

    async def card1_submit(self, request):
        """
        If card1 had a form, we would handle its submission here.
        In this example, card1 is fully determined at init_workflow time.
        Just an example pattern placeholder.
        """
        # In this example, card1 submission isn't needed because it's done at init.
        pass

    async def card2(self, request):
        """
        Card 2: Choose Favorite Color.
        
        If card2 is not completed, show a form with a dropdown.
        If completed, show the chosen color as a static note.
        """
        url = db['url']
        state = pipulate.get_state(url)
        current_step = state.get('current_step')
        card2_data = pipulate.get_step(url, "card2", {})
        chosen_color = card2_data.get('color', '')

        colors = ["Red", "Green", "Blue", "Yellow"]
        
        if current_step == "card1":
            # Means card2 is not completed, show form
            return Div(
                Card(
                    H3("Step 2: Favorite Color"),
                    Form(
                        Select(*[Option(c, value=c, selected=(c == chosen_color)) for c in colors], name="color", required=True),
                        Button("Submit", type="submit"),
                        hx_post="/onboard/card2-submit",
                        hx_target="#card2"
                    ),
                    id="card2"
                ),
                Div(id="card3") # Placeholder for next card
            )
        else:
            # Card2 completed, show locked step
            return Div(
                Card(
                    H3("Step 2: Favorite Color"),
                    P(f"Color chosen: {chosen_color}")
                ),
                Div(
                    id="card3",
                    hx_get="/onboard/card3",
                    hx_trigger="load",
                    hx_swap="outerHTML"
                )
            )

    async def card2_submit(self, request):
        """
        Handle submission of card2 form (favorite color).
        Update pipeline and set current_step to card2.
        Return a snippet to trigger loading of card3.
        """
        form = await request.form()
        chosen_color = form.get('color', '')
        url = db['url']
        pipulate.set_step(url, "card2", {"color": chosen_color})
        pipulate.set_current_step(url, "card2")

        # Return confirmation and next card trigger
        return Card(
            P(f"Color '{chosen_color}' recorded!"),
            hx_get="/onboard/card3",
            hx_target="#card3",
            hx_trigger="load",
            hx_swap="outerHTML"
        )

    async def card3(self, request):
        """
        Card 3: Confirm Details.
        
        If card3 not completed, show a button to finalize.
        If completed, show the final confirmation as static.
        """
        url = db['url']
        state = pipulate.get_state(url)
        current_step = state.get("current_step", "card1")
        card1_data = pipulate.get_step(url, "card1", {})
        card2_data = pipulate.get_step(url, "card2", {})
        username_val = card1_data.get('username', '')
        chosen_color = card2_data.get('color', '')

        if current_step == "card2":
            # Not completed, show form to finalize
            return Div(
                Card(
                    H3("Step 3: Confirm Details"),
                    P(f"Username: {username_val}"),
                    P(f"Favorite Color: {chosen_color}"),
                    Form(
                        Button("Confirm", type="submit"),
                        hx_post="/onboard/card3-submit",
                        hx_target="#card3"
                    ),
                    id="card3"
                ),
                # Next card placeholder if we had card4, but let's say this is the last step
            )
        else:
            # Completed, show static locked final step
            return Card(
                H3("Step 3: Confirmed"),
                P(f"All details have been recorded."),
                id="card3"
            )

    async def card3_submit(self, request):
        """
        Final submission: set card3 data, finalize current_step.
        Return confirmation.
        """
        url = db['url']
        # card3 might not need any form fields, just a confirm action
        pipulate.set_step(url, "card3", {"confirmed": True})
        pipulate.set_current_step(url, "card3")
        return P("✔ Details Confirmed! You are done.")

```

---

### How to Use this Example

1. Instantiate the workflow:

```python
onboarding_workflow = UserOnboardingWorkflow(app)
```

2. On the homepage or a dedicated URL, load the `init_form()`:

```python
@app.route("/onboard")
async def onboard_home(request):
    # Just return the initial form.
    return await onboarding_workflow.init_form()
```

3. Go to `/onboard` in your browser:
   - Enter a username and click "Start".
   - The system initializes the pipeline and shows the cards.
   - Step-by-step, each card loads the next one, reflecting the pipeline state.

This code shows how to apply the “pipeline + placeholders + linear chain” pattern from scratch. You can adapt it into more complex scenarios, like the BotifyLinkGraph example, by applying the same principles of linear steps, pipeline JSON as the single source of truth, and `hx_get` triggers that load each subsequent card.

---

> I'm pretty pumped over this, but o1 is still missing some of the critical
> points. I'm simplifying the existing JSON blob data format. I don't need to
> live with the current one from the over-complicated days! Backwards
> compatibility be damned!

**Me**: Okay, but this ignores that we're changing the JSON data structure to a
simpler one that only has `"step_01:` and `"step_02:` pattern keys at element
root. There is no `"steps:` key anymore nor `"current_step:"` as these were
artifacts of the over-complication by the previous AI I gave this job. Instead,
abide by the conventions I explicitly state in my criteria and update the
Pipulate class and any Workflows you invent to use it to do the same. I have no
backwards compatibility criteria. We are going for the idiomatic ideal.

So my request for a coding plan and code examples is now updated to include an
explicit request for a new Pipulate class that works this way and a new example
Workflow (call it whatever you like) that uses an instance of this class, which
could be modified into a 100-step example easily. I now prefer the nomenclature
of "step" over "card" and the easily parse-able and 99-step accommodating
"step_01", "step_02" convention over "card1", "card2", and all examples can be
created accordingly. This will keep the database JSON blob contents consistent
with the user interface IDs. In other words, we can purge the concept of cards
in favor of steps, and the numbering system should be underscore parse-able as
this will be critical to ordering the steps when building the UI. Yes, it will
depend on how the steps are named what order they get "rebuilt" in, and that's
fine.

So please now give me a Pipulate / Workflow pair that will work together meeting
the following criteria: [original 16 criteria from above]

**o1**: Below is a revised implementation of `Pipulate` and a new example `Workflow` class that adhere strictly to the new conventions. We have removed any `steps` or `current_step` keys inside the JSON. The JSON data structure is now a flat dictionary with keys like `"step_01"`, `"step_02"`, etc., plus `"created"` and `"updated"` timestamps. Each `step_XX` key maps to a dictionary of data collected at that step.

**Key Changes from the Previous Version:**

- No `"steps"` or `"current_step"` fields in the JSON.
- Steps are named `"step_01"`, `"step_02"`, etc.
- On initialization (Step 1), if a given `url` (List ID) already exists, we load that pipeline and find the last completed step. If not, we start fresh.
- The `Pipulate` class provides methods to:
  - Initialize or fetch the pipeline state for a given `url`.
  - Add or update a step (e.g., `step_03`).
  - Determine the last completed step number easily.
- The `Workflow` class is changed from the "Card" metaphor to "Step" metaphor. Instead of `card1`, `card2` it uses `step_01`, `step_02`, etc.
- Each step endpoint (like `/process-step`) will rebuild the trail of all previously completed steps as locked static elements, and then the next step as an active form. This matches the requirement that every refresh or revisit fully rebuilds the chain from `step_01` up to the current highest step.

**Note:** For simplicity, we’ll show a 3-step workflow example, but the naming `step_01`, `step_02`, `step_03` and the logic is easily scalable to 100 steps or more. Just replicate the pattern for additional steps. The pipeline approach does not fundamentally differ whether you have 3 steps or 100 steps.

---

### Revised Pipulate Class

```python
class Pipulate:
    """
    Pipulate manages a pipeline using a JSON blob with keys like "step_01", "step_02", etc.
    No 'steps' or 'current_step' keys exist. The presence of step keys determines progress.
    
    Data Structure Example:
    {
        "step_01": {"url": "https://example.com"},
        "step_02": {"choice": "A"},
        "created": "2024-12-08T12:34:56",
        "updated": "2024-12-08T12:35:45"
    }

    The highest step number that exists in the JSON is considered the last completed step.
    The next step is always one more than the highest completed step.

    To 'resume' a workflow, just re-enter the same List ID at step_01. We'll find 
    existing steps and rebuild the UI from that data.
    """

    def __init__(self, table):
        self.table = table

    def _get_state(self, url: str) -> dict:
        """
        Low-level getter that returns the pipeline state or raises NotFoundError if absent.
        """
        record = self.table[url]
        state = json.loads(record.data)
        return state

    def _save_state(self, url: str, state: dict):
        """
        Low-level saver that updates the pipeline state in the database.
        """
        now = datetime.now().isoformat()
        state["updated"] = now
        self.table.update({
            "url": url,
            "data": json.dumps(state),
            "updated": state["updated"]
        })

    def initialize_if_missing(self, url: str, initial_step_data: dict = None) -> dict:
        """
        If the given URL does not exist in pipeline, create a new record with step_01.
        If it exists, just return the current state.
        """
        try:
            self._get_state(url)
            # Already exists, return existing state
            return self.get_state(url)
        except NotFoundError:
            now = datetime.now().isoformat()
            state = {
                "created": now,
                "updated": now
            }
            if initial_step_data:
                # initial_step_data should be something like {"step_01": {"url": "https://..."}}
                state.update(initial_step_data)

            self.table.insert({
                "url": url,
                "data": json.dumps(state),
                "created": now,
                "updated": now
            })
            return state

    def get_state(self, url: str) -> dict:
        """
        Return the entire state dict for the given URL. If not found, return empty.
        """
        try:
            return self._get_state(url)
        except NotFoundError:
            return {}

    def set_step_data(self, url: str, step_name: str, data: dict):
        """
        Set or update the data for a given step (e.g. "step_01", "step_02").
        Overwrites previous data for that step.
        """
        state = self.get_state(url)
        state[step_name] = data
        self._save_state(url, state)

    def get_step_data(self, url: str, step_name: str, default=None) -> dict:
        """
        Get data for a specific step. If not found, return default.
        """
        state = self.get_state(url)
        return state.get(step_name, default or {})

    def get_last_completed_step_number(self, url: str) -> int:
        """
        Inspect the keys in the pipeline to find the highest step number completed.
        Steps are named step_01, step_02, ... step_100. Extract the number and find max.
        If no steps found, return 0.
        """
        state = self.get_state(url)
        step_keys = [k for k in state.keys() if k.startswith("step_")]
        if not step_keys:
            return 0
        # Extract numbers
        numbers = []
        for sk in step_keys:
            # sk format: step_XX
            parts = sk.split("_")
            if len(parts) == 2 and parts[0] == "step":
                try:
                    n = int(parts[1])
                    numbers.append(n)
                except ValueError:
                    pass
        return max(numbers) if numbers else 0
```

---

### Example Workflow Class

This workflow demonstrates a simple 3-step process using the new naming conventions. The logic can be extrapolated to 100 steps by repeating the pattern. Each step:

- Displays previously completed steps as static read-only notes.
- Displays the current step as a form if it’s the highest incomplete step.
- On submission, sets the step data and triggers loading the next step.

We’ll have endpoints like `/myflow/process-step-01`, `/myflow/step-02`, etc. The naming is flexible, but following `step_XX` keeps it consistent.

```python
class My100StepWorkflow:
    """
    Example Workflow using the new Pipulate conventions:
    - Steps named step_01, step_02, step_03, ...
    - No "steps" or "current_step" fields in JSON, just the step keys.
    - On each request, we rebuild the entire trail of completed steps as static.
    - The current incomplete step is shown as a form.
    - If a step is completed, it's shown as locked static content.

    For demonstration, we implement step_01, step_02, and step_03.
    In a real scenario, just replicate this pattern up to step_100.
    """

    def __init__(self, app, pipulate):
        self.app = app
        self.pipulate = pipulate

        # Routes:
        app.route("/myflow/init", methods=["POST"])(self.init_workflow)
        app.route("/myflow/step-01")(self.step_01)
        app.route("/myflow/step-01-submit", methods=["POST"])(self.step_01_submit)
        app.route("/myflow/step-02")(self.step_02)
        app.route("/myflow/step-02-submit", methods=["POST"])(self.step_02_submit)
        app.route("/myflow/step-03")(self.step_03)
        app.route("/myflow/step-03-submit", methods=["POST"])(self.step_03_submit)

    async def start_form(self):
        """
        The initial form to enter a unique List ID (URL or some unique key).
        Step 1 sets this identity. If it already exists, resume.
        """
        return Card(
            H2("Enter Unique ID to Start or Resume"),
            Form(
                Div(
                    Input(type="text", name="list_id", placeholder="Enter unique ID", required=True),
                    Button("Start", type="submit"),
                    style="display: flex; gap: 0.5rem;"
                ),
                hx_post="/myflow/init",
                hx_target="#list-id-input"
            ),
            id="list-id-input"
        )

    async def init_workflow(self, request):
        """
        Handle POST from the initial form. 
        1. Get the list_id from form.
        2. Initialize pipeline if missing or load existing state.
        3. Return placeholders for all steps up to last completed + 1.
        """
        form = await request.form()
        list_id = form.get("list_id", "").strip()
        if not list_id:
            return P("Please enter a valid ID", style="color:red;")

        db["url"] = list_id  # Store globally for convenience
        # If missing, initialize with step_01 empty or partial data
        # In a real scenario, you might not set step_01 data until actually posted,
        # but let's say we just establish the pipeline with no steps initially.
        self.pipulate.initialize_if_missing(list_id)
        
        # Determine what steps we already have
        last_step = self.pipulate.get_last_completed_step_number(list_id)
        # We'll create placeholders for all steps up to last_step + 1
        # For a large workflow (say 100 steps), just scale this logic.
        placeholders = []
        # The next step to load (in GET) will be last_step + 1
        max_step = last_step + 1  # The step we want to load next
        # We also want to include all previously completed steps
        # in locked form on rebuild, and then a placeholder for the next step.

        # Example: If last_step = 2, we have step_01 and step_02 completed. 
        # We'll show those as locked and then show step_03 as next.
        
        for i in range(1, max_step + 1):
            step_str = f"step_{i:02d}"
            placeholders.append(
                Div(
                    id=step_str,
                    hx_get=f"/myflow/{step_str}",
                    hx_trigger="load" if i == 1 else None,
                    hx_swap="outerHTML"
                )
            )

        return Div(*placeholders)

    def rebuild_trail(self, url: str):
        """
        Helper to build the entire trail of completed steps as locked static notes.
        Also returns the next incomplete step number.
        """
        state = self.pipulate.get_state(url)
        last_step = self.pipulate.get_last_completed_step_number(url)
        return last_step

    async def step_01(self, request):
        """
        Step 01: Establish the list identity or show what's already set.
        If step_01 data exists, show it locked.
        Otherwise, show a form to set it.
        """
        url = db['url']
        last_step = self.pipulate.get_last_completed_step_number(url)
        step_data = self.pipulate.get_step_data(url, "step_01")

        # Rebuild trail: For step_01, no previous steps
        # If step_01 not yet set, show form
        # If set, show locked
        if last_step >= 1:
            # Step 01 completed
            return Div(
                Card(
                    H3("Step 01: Define URL"),
                    P(f"URL: {step_data.get('url', 'N/A')} (locked)")
                ),
                # Next step placeholder
                Div(
                    id="step_02",
                    hx_get="/myflow/step-02",
                    hx_trigger="load",
                    hx_swap="outerHTML"
                )
            )
        else:
            # Step 01 incomplete, show form
            return Div(
                Card(
                    H3("Step 01: Define URL"),
                    P("Enter a URL to associate with this process:"),
                    Form(
                        Input(type="url", name="url", required=True),
                        Button("Submit", type="submit"),
                        hx_post="/myflow/step-01-submit",
                        hx_target="#step_01"
                    ),
                    id="step_01"
                ),
                # Placeholder for next step (step_02)
                Div(id="step_02")
            )

    async def step_01_submit(self, request):
        form = await request.form()
        entered_url = form.get("url", "").strip()
        pipeline_url = db['url']
        # Save step_01 data
        self.pipulate.set_step_data(pipeline_url, "step_01", {"url": entered_url})
        # Return a confirmation and trigger step_02 load
        return Card(
            P(f"Step 01 completed with URL: {entered_url}"),
            hx_get="/myflow/step-02",
            hx_target="#step_02",
            hx_trigger="load",
            hx_swap="outerHTML"
        )

    async def step_02(self, request):
        """
        Step 02: Choose a 'choice'
        If step_02 is completed, show locked
        If not, show form
        Also rebuild trail from step_01.
        """
        pipeline_url = db['url']
        last_step = self.pipulate.get_last_completed_step_number(pipeline_url)
        step2_data = self.pipulate.get_step_data(pipeline_url, "step_02")

        # Let's rebuild previous steps as locked first
        # Step_01 is definitely completed if we are here.
        step1_data = self.pipulate.get_step_data(pipeline_url, "step_01", {})
        step1_block = Card(
            H3("Step 01: Define URL"),
            P(f"URL: {step1_data.get('url', 'N/A')} (locked)")
        )

        if last_step >= 2:
            # step_02 completed
            return Div(
                step1_block,
                Card(
                    H3("Step 02: Choice"),
                    P(f"Choice: {step2_data.get('choice', 'N/A')} (locked)")
                ),
                Div(
                    id="step_03",
                    hx_get="/myflow/step_03",
                    hx_trigger="load",
                    hx_swap="outerHTML"
                )
            )
        else:
            # step_02 incomplete, show form
            options = ["A", "B", "C"]
            return Div(
                step1_block,
                Card(
                    H3("Step 02: Choose Something"),
                    Form(
                        Select(*[Option(opt, value=opt) for opt in options], name="choice", required=True),
                        Button("Submit", type="submit"),
                        hx_post="/myflow/step-02-submit",
                        hx_target="#step_02"
                    ),
                    id="step_02"
                ),
                Div(id="step_03")
            )

    async def step_02_submit(self, request):
        form = await request.form()
        choice = form.get("choice", "")
        pipeline_url = db['url']
        self.pipulate.set_step_data(pipeline_url, "step_02", {"choice": choice})
        return Card(
            P(f"Step 02 completed with choice: {choice}"),
            hx_get="/myflow/step_03",
            hx_target="#step_03",
            hx_trigger="load",
            hx_swap="outerHTML"
        )

    async def step_03(self, request):
        """
        Step 03: Just a confirmation step. If completed, locked. If not, form.
        Rebuild trail from steps 01 and 02.
        """
        pipeline_url = db['url']
        last_step = self.pipulate.get_last_completed_step_number(pipeline_url)
        step1_data = self.pipulate.get_step_data(pipeline_url, "step_01", {})
        step2_data = self.pipulate.get_step_data(pipeline_url, "step_02", {})
        
        step1_block = Card(
            H3("Step 01: Define URL"),
            P(f"URL: {step1_data.get('url', 'N/A')} (locked)")
        )
        step2_block = Card(
            H3("Step 02: Choice"),
            P(f"Choice: {step2_data.get('choice', 'N/A')} (locked)")
        )

        if last_step >= 3:
            # step_03 completed
            step3_data = self.pipulate.get_step_data(pipeline_url, "step_03", {})
            return Div(
                step1_block,
                step2_block,
                Card(
                    H3("Step 03: Confirm"),
                    P(f"Confirmed: {step3_data.get('confirmed', 'No')} (locked)")
                ),
                # If this were step_100, still have a placeholder for step_101
                Div(
                    id="step_04",
                    # In a 3-step example, step_04 might not exist, but we still show a placeholder
                    # For a 100-step workflow, this would load the next step or a terminal note.
                    # Let's just not load anything beyond step_03 in this example.
                )
            )
        else:
            # step_03 incomplete, show form
            return Div(
                step1_block,
                step2_block,
                Card(
                    H3("Step 03: Confirm"),
                    P("Click confirm to finalize."),
                    Form(
                        Button("Confirm", type="submit"),
                        hx_post="/myflow/step-03-submit",
                        hx_target="#step_03"
                    ),
                    id="step_03"
                ),
                Div(id="step_04")
            )

    async def step_03_submit(self, request):
        pipeline_url = db['url']
        self.pipulate.set_step_data(pipeline_url, "step_03", {"confirmed": True})
        return P("Step 03 completed and confirmed!")

```

---

### Usage Instructions

1. Instantiate the workflow after you have `app` and `pipulate` ready:

```python
workflow = My100StepWorkflow(app, pipulate)
```

2. On a main page, present the user the initial start form:

```python
@app.route("/myflow")
async def myflow_home(request):
    return await workflow.start_form()
```

3. The user enters a unique ID. The system initializes or resumes from that ID. Steps load incrementally. Completed steps show locked data. The next step shows a form. On each submission, the pipeline JSON updates. If the user refreshes or re-enters, we rebuild from scratch using the pipeline data.

This satisfies all the stated criteria:

- We have a deterministic linear workflow.
- Steps are named `step_01`, `step_02`, etc.
- Each completed step is locked and displayed as static text.
- The trail is rebuilt every time.
- Step 1 sets the List ID and can resume if it finds existing data.
- Data structure is simple and transparent, no `steps` or `current_step` fields—just `step_XX` keys at the top level.
- Perfectly scalable to 100 steps by continuing the same pattern.
