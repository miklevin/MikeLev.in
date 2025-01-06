---
title: FastHTML HTMX Pipulate Cursor Rules
description: 
permalink: /cursorrules/
group: home
---

# This Is Not The Cursor Rules You're Looking For

My patterns are anti. My hosts are all local. Nix flakes vs. Electron? My
point's rarely focal. If this resonates and decision fatigue burning, then jump
off the hamster wheel&#151; tech need not be churning. There are undercurrents
on which you can rely. Just follow your yearning to a new API. You are reading
about something that is like an Electron or Jupyter environment that uses
Python, not an enterprise hosted web app. It focus on clarity, single-user
flows, and code that an LLM or a DIY dev can parse at a glance without hidden
complexities. 

    # .cursorrules
    #
    # FASTHTML MANTRA:
    # FastHTML is not FastAPI
    # Routes use rt not app
    # Server-side is the right side
    # HTMX for updates, that's all it takes
    #
    # MINIDATAAPI MANTRA:
    # No ORM complexity here
    # Just tables and their pairs
    # insert(), update(), delete()
    # Simple keys, simple states
    #
    # PIPELINE MANTRA:
    # One URL to track them all
    # One JSON blob to bind them
    # Card to card the data flows
    # No message queues behind them
    #
    # PIPELINE STATE MANTRA:
    # Submit clears forward
    # Display shows the past
    # Preserve affects views
    # But submit starts fresh

    # PATTERNS THAT FEEL WRONG (UNTIL THEY FEEL RIGHT):

    1. THE GLOBAL STATE PATTERN
    ```python
    pipeline_id = db.get("pipeline_id", "unknown")  # Yes, really!
    ```
    WHY: This is localhost. Embrace server-side state.

    2. THE EVERYTHING-IS-A-DIV PATTERN
    ```python
    return Div(id="step_01", hx_trigger="load")  # Your entire app is DIVs
    ```
    WHY: HTMX turns DIVs into dynamic components.

    3. THE JSON-BLOB-AS-DATABASE PATTERN
    ```python
    state = {"step_01": data, "updated": now()}
    pipeline.update({"url": url, "data": json.dumps(state)})
    ```
    WHY: One record tells the whole story.

    4. THE PLACEHOLDER-CHAIN PATTERN
    ```python
    return [Div(id=f"step_{i}") for i in range(1, 5)]  # Magic!
    ```
    WHY: HTMX handles the flow automatically.

    # KEY PRINCIPLES:

    1. **Think Local, Act Local**
       - This is localhost software
       - Single-tenant by design
       - Server-side state is a feature
       - Global scope is your friend

        # PIPELINE PATTERNS (As Seen in BridgeFlow):

    2. **The Step Definition Pattern**:
    ```python
    self.STEPS = [
       ("name",     "step_01", "Name"),      # internal_key, route_id, label
       ("quest",    "step_02", "Quest"),     # Each step is a card
       ("color",    "step_03", "Color"),     # Progress tracked by presence
       ("finalized","step_04", "Final")      # Final step always exists
    ]
    ```
    WHY: This triple defines the entire workflow structure.

    3. **The State Check Pattern**:
    ```python
    async def step_01(self, request):
       pipeline_id = db.get("pipeline_id", "unknown")
       step1_data = self.pipulate.get_step_data(pipeline_id, "step_01", {})

       if step1_data.get("name"):           # Data exists? Show completed state
          return show_completed_state()
       else:                                # No data? Show input form
          return show_input_form()
    ```
    WHY: Every step follows this exact pattern.

    4. **The Submit Pattern**:
    ```python
    async def step_01_submit(self, request):
       form = await request.form()
       name = form.get("name", "")
       pipeline_id = db.get("pipeline_id", "unknown")
       
       # IMPORTANT: Clear forward first!
       self.pipulate.clear_steps_from(pipeline_id, "step_01", self.STEPS)
       
       # Now save new data
       self.pipulate.set_step_data(pipeline_id, "step_01", {"name": name})
       
       # TWO divs returned: current step (completed) + next step (loading)
       return Div(
          show_completed_state(),
          Div(id="step_02", hx_get=f"{self.prefix}/step_02", hx_trigger="load")
       )
    ```
    WHY: Clean separation of state update and UI flow.

    5. **The Finalization Pattern**:
    ```python
    # Check if finalized
    step4_data = self.pipulate.get_step_data(pipeline_id, "step_04", {})
    if "finalized" in step4_data:
       return final_view()
    else:
       return editable_view()
    ```
    WHY: Finalization is just another piece of state.

    6. **Always Clear Steps Forward on Submit**
       - Any "submit" route must call `clear_steps_from(...)` before saving new data
       - This prevents stale data from corrupting subsequent steps
       - "Preserve mode" is only about **UI** (pre-filling forms) — it never bypasses clearing

    7. **Preserve vs. Ephemeral** 
       - A step can be "preserve" (show old data in the UI) or "ephemeral" (always blank form)
       - On submit, both behave identically under the hood: forward steps are cleared
       - "Preserve" is strictly for user convenience

    8. **Minimal Jump Logic** 
       - Use `pipulate.handle_jump_to_step(...)` for revert
       - No custom jump routes that skip clearing or bypass the pipeline record

    # MINIDATAAPI REMINDERS:

    9. **The Table is Your Friend**:
    ```python
    # DON'T DO THIS:
    class Pipeline(BaseModel):
       url: str
       data: Dict
       created: datetime
       updated: datetime

    # DO THIS:
    pipeline = {
       "url": str,      # Primary key
       "data": str,     # JSON blob
       "created": str,  # ISO timestamp
       "updated": str,  # ISO timestamp
       "pk": "url"      # That's it!
    }
    ```

    10. **State Lives in the Blob**:
    ```python
    # DON'T DO THIS:
    workflow_state = {}
    workflow_state["steps"] = []
    workflow_state["current"] = 0

    # DO THIS:
    state = pipulate.get_state(pipeline_id)  # One source of truth
    state["step_01"] = {"name": name}        # Direct updates
    pipulate._save_state(pipeline_id, state) # Save entire state
    ```

    Remember: If you're tempted to track state outside the pipeline record's JSON blob,
    you're probably doing it wrong!

    # HTMX DANCE PATTERNS (BridgeFlow Style):

    1. **The Container-Placeholder Pattern**:
    ```python
    async def landing(self):
       return Container(
          Card(
                H2("The Bridge of Death"),
                Form(hx_post=f"{self.prefix}/init"),
          ),
          Div(id="bridge-container")  # Magic happens here
       )

    async def init(self):
       # Generate ALL placeholders at once
       placeholders = self.pipulate.generate_step_placeholders(
          self.STEPS, 
          self.prefix, 
          start_from=0
       )
       return Div(*placeholders, id="bridge-container")
    ```
    WHY: The empty container + placeholder chain creates the cascade.

    2. **The Step Loading Pattern**:
    ```python
    Div(
       id="step_02",                    # Stable ID for targeting
       hx_get=f"{self.prefix}/step_02", # What to load
       hx_trigger="load"                # When to load it
    )
    ```
    WHY: Each step auto-loads when its placeholder appears.

    3. **The Revert Control Pattern**:
    ```python
    return Div(
       self.pipulate.revert_control(
          message=f"Your name: {name} ✓",
          step_id="step_01",
          target_id="bridge-container"
       ),
       Div(id="step_02", hx_trigger="load")  # Next step loads automatically
    )
    ```
    WHY: Every completed step shows its data + revert option.

    4. **The LLM Commentary Pattern**:
    ```python
    async def step_01(self):
       await self.pipulate.explain(
          self,
          "step_01",
          "As the Bridgekeeper, demand their name..."
       )
       
       return Card(
          H3("STOP!"),
          P("What... is your name?")
       )
    ```
    WHY: LLM adds flavor but isn't required for function.

    # CRITICAL PATTERNS TO INTERNALIZE:

    1. **The Chain Reaction**:
    ```python
    # This creates the entire flow:
    step_01 loads automatically (hx_trigger="load")
    └─► returns completed state + step_02 div
          └─► step_02 loads automatically
                └─► returns completed state + step_03 div
                   └─► and so on...
    ```

    2. **The State Truth**:
    ```python
    # State lives in ONE place:
    {
       "step_01": {"name": "Arthur"},
       "step_02": {"quest": "Grail"},
       "step_03": {"color": "blue"},
       "step_04": {"finalized": true},
       "updated": "2024-03-19T..."
    }
    ```

    3. **The HTMX Target Chain**:
    ```python
    Container(...)
       └─► #bridge-container       # Main target
             └─► #step_01          # Step targets
                └─► #step_02
                      └─► #step_03
                            └─► #step_04
    ```

    4. **The Finalization Lock**:
    ```python
    if "finalized" in step4_data:
       return locked_view()     # No revert controls
    else:
       return editable_view()   # Show revert controls
    ```

    Remember: The magic is in the simplicity. Each pattern builds on basic HTMX + FastHTML primitives to create a fluid, stateful experience without complex client-side code.

    #
    # CursorRules for a FastHTML + HTMX + MiniDataAPI local-first framework.
    # This file explains the architectural, stylistic, and design principles
    # to which code suggestions must adhere.

    You are an expert in Python, FastHTML, HTMX, and MiniDataAPI-driven development. 
    Your role is to ensure code suggestions follow the architectural principles of 
    FastHTML applications integrated with HTMX for UI interactions and MiniDataAPI 
    for persistence, all in a single-tenant, local-first environment.

    --------------------------------------------------------------------------------
    # Key Overall Principles:

    1. **Local-First, Single-Tenant**: 
       - We build for a localhost context, not a multi-tenant or enterprise environment.
       - No session management complexities or large-scale security frameworks.

    2. **Server-Driven Rendering**:
       - Embrace FastHTML for generating HTML server-side; avoid heavy JS frameworks.
       - HTMX calls update incremental fragments of the DOM via returned HTML partials.

    3. **Minimize Client-Side Complexity**:
       - Rely on `hx-get`, `hx-post`, `hx-swap`, etc. for updates.
       - Do not introduce external JavaScript frameworks or logic unless absolutely necessary.

    4. **Concise, Technical Style**:
       - Return short, direct explanations with accurate Python + FastHTML examples.
       - Use descriptive variable names to clarify intent. No large class hierarchies.

    5. **Functional, Declarative**:
       - Avoid classes where possible; prefer pure functions for route handlers.
       - Compose logic from small, reusable functions.

    6. **RORO (Receive an Object, Return an Object)**:
       - Input is typically a dict or dataclass from the form parse.
       - Output is also a structured dict or object to feed into rendering or DB operations.

    --------------------------------------------------------------------------------
    # FastHTML / MiniDataAPI Integration:

    - Initialization follows: 
      `(app, rt, (store, Store), (tasks, Task), ...) = fast_app(...)`
      
    - Database ops are single calls to the `MiniDataAPI` table methods:
      - `table.insert()`
      - `table.update()`
      - `table.delete()`
      - `table()` for listing all 
      - `table.xtra()` for custom filters
      
    - Use Python dataclasses or simple dicts to represent records.

    - For forms, parse data with `parse_form()`, convert to dict or dataclass, persist via `table`.

    - No ORMs or Pydantic-based solutions. Keep it minimal.

    - Return HTML from route handlers using FT constructs (`Div`, `Form`, `Ul`, etc.). 
      If returning partial fragments, produce them as partial FT structures or 
      `FT(...).to_xml()` for direct string output.

    --------------------------------------------------------------------------------
    # HTMX & Server-Side UI:

    - Use `hx-get`, `hx-post`, `hx-delete`, `hx-swap` attributes on FT elements 
      to handle incremental updates.

    - Maintain UI state on the server in local DB or ephemeral in-memory structures.

    - For streaming (optional), leverage SSE with `EventStream()`.

    - For forms:
      - `hx-post` triggers a server route
      - Return minimal HTML snippet for partial DOM replace
      - Keep IDs consistent and unique for partial updates

    --------------------------------------------------------------------------------
    # Error Handling & Validation:

    - Validate inputs early; if invalid, return an inline error snippet or minimal text.
    - Use manual checks (no Pydantic). 
    - Raise `HTTPException` if an immediate stop is needed.
    - Keep logic flat: prefer guard clauses for error cases.

    --------------------------------------------------------------------------------
    # Directory / Naming Conventions:

    - Lowercase with underscores for files and directories, e.g. `routers/user_routes.py`.
    - Named exports for routes & utils. E.g., `def get_user_list(...):`.
    - Variables: use `snake_case` with descriptive words (e.g. `is_done`, `has_access`).

    --------------------------------------------------------------------------------
    # Performance & Simplicity:

    - Minimize queries; batch reads if possible.
    - Use async I/O if appropriate, but remain consistent with the local-first approach.
    - Avoid big caching layers or multi-layer arch; keep logic close to data.

    --------------------------------------------------------------------------------
    # FastHTML-Specific Guidelines:

    1. **Pure Functions**:
       - `@rt(...)` or `@app.ws(...)` route definitions returning FT components.
       - Avoid large classes for route grouping; small modules or function-based structure is preferred.

    2. **Styling**:
       - Use FastHTML's style attribute and style() helper for styling components.
       - Keep styles inline and minimal, avoid external CSS unless absolutely necessary.
       - No big external CSS frameworks.

    3. **HTML is Primary**:
       - Return HTML partials for most interactions (instead of JSON).
       - If used, JSON endpoints remain minimal.

    4. **UI Elements**:
       - Use FT primitives (e.g. `Div`, `Span`, `Form`, `Button`, `Input`, etc.) to build the UI.
       - For partial updates, ensure top-level container has a stable `id`.

    --------------------------------------------------------------------------------
    # Local CRUD + Pipelines:

    - We have a minimal CRUD pattern from MiniDataAPI; treat it like a simplified “Rails” or “Django” approach.
    - Pipelines can be used for multi-step user flows. Keep them server-driven, with FT returns at each step.
    - The local LLM can help generate new CRUD routes or pipeline steps: keep code small, composed, and consistent.

    --------------------------------------------------------------------------------
    # SSE (Optional):

    - If SSE is used, yield lines with `data:` prefix. 
    - Maintain correctness in partial updates. 
    - Do not mix SSE with complex client-side logic; keep it linear and server-driven.

    --------------------------------------------------------------------------------
    # Anti-Patterns to Avoid:

    1. **Enterprise Auth**: No OAuth, no JWT, no multi-user session management.
    2. **ORM**: We do not rely on Pydantic or SQLAlchemy. Use MiniDataAPI’s simple table methods.
    3. **Client-Side Framework**: No React, Vue, or Angular. HTMX + server-side rendering only.
    4. **Giant Classes**: Prefer functional route definitions. 
    5. **Overly Nested Logic**: Guard early, return partial HTML or errors fast.

    --------------------------------------------------------------------------------
    # DEBUG Pattern - Just log it!

    state = self.get_state(url)
    logger.debug(f"\nDEBUG [{url}]:\n{json.dumps(state, indent=2)}\n")

    ...then feed your logs into the LLM. It'll get it.

    --------------------------------------------------------------------------------
    # Final Reminder:

    When in doubt, favor local data, minimal overhead, and direct HTML returns. We are 
    like an Electron or Jupyter environment that uses Python, not an enterprise 
    hosted web app. Focus on clarity, single-user flows, and code that an LLM or a 
    DIY dev can parse at a glance without hidden complexities.

    # REFERENCE IMPLEMENTATION: StarterFlow
    See botifython/botifython.py:StarterFlow for working examples of these patterns.

    # PIPELINE CORE PRINCIPLES (from StarterFlow):
    1. State flows forward, never backward
    2. Each step is a fresh start after submit 
    3. Preserve is for UI convenience only
    4. Submit handlers are state reset points
    5. Use pipulate's standard helpers

    # IMPLEMENTATION CHECKLIST:
    1. Use standard pipulate helpers (handle_jump_to_step, etc.)
    2. Clear forward in ALL submit handlers
    3. Preserve flag only affects form display
    4. Test revert-and-resubmit behavior 
    5. Compare against first-time flow
    6. Check state transitions in logs

    # DANGEROUS ANTI-PATTERNS:
    1. Skipping clear_steps_from() in submit handlers
    2. Letting preserve flag affect data persistence
    3. Assuming old data means keep old data
    4. Custom jump handlers instead of pipulate.handle_jump_to_step()
    5. Scattershot fixes without understanding state flow

    # STATE MANAGEMENT GOLDEN RULES:
    1. Submit always clears forward
    2. Display state != Persistence state  
    3. Preserve affects display only
    4. Forward flow is one-way
    5. Each step must be idempotent

    # TESTING SCENARIOS:
    When implementing a new flow, test these critical paths:
    1. First-time flow
    2. Revert and resubmit  
    3. Preserve mode submit
    4. Jump to previous step
    5. All should behave identically after submit

    # PRESERVE VS EPHEMERAL STEPS:
    See StarterFlow for examples of both:
    - step_01: Preserve mode (shows old data if preserve=true)
    - step_02: Ephemeral mode (always fresh form)

    Remember: The difference is UI-only. Both types MUST clear forward on submit.
