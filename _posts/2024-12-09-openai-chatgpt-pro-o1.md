---
title: Testing OpenAI ChatGPT Pro o1
permalink: /futureproof/testing-openai-chatgpt-pro-o1/
description: 
layout: post
sort_order: 1
---

**Me**: Tell me everything you can about this codebase: [codebase pasted]

**o1**: Below is a comprehensive, in-depth explanation of the provided codebase. We will break it down into conceptual layers and walk through its purpose, structure, modules, classes, and functionalities. This detailed analysis covers:

1. **Project Overview and Philosophy**  
2. **Key Technologies and Components**  
3. **Data Structures and Persistence**  
4. **LLM Integration (Ollama and Chat Handling)**  
5. **User Interface Design (FastHTML, HTMX, SSE, WebSockets)**  
6. **Plugins (Profile, Todo, Link Graph, Streams, Workflows)**  
7. **Pipeline Pattern (Pipulate)**  
8. **Code Infrastructure and Middleware**  
9. **JSON Extraction and CRUD Operations**  
10. **Developer Experience and Real-Time Reloading**  
11. **Navigation, Menus, and Endpoint Management**  
12. **Additional Notes on Design Choices**

---

### 1. Project Overview and Philosophy

This code defines a single-tenant local web application framework using a stack of Python-based libraries: **FastHTML**, **MiniDataAPI**, **uvicorn**, and local LLM infrastructure via **Ollama**. The guiding philosophy is about local sovereignty—running everything on `localhost`—and avoiding cloud vendor lock-ins. It emphasizes simplicity, visibility of state, and directness of control, all in a single file.

**Key points:**
- The code is intentionally unconventional, single-tenant, and not enterprise-oriented.
- It avoids complex frontend frameworks, leaning heavily on server-side rendering with incremental updates using HTMX and SSE.
- LLM integration is done locally through Ollama, demonstrating "just in time" prompt injection, much like "downloading new skills" instantly.

---

### 2. Key Technologies and Components

- **FastHTML**: A Pythonic, no-template approach for building HTML. It allows inline creation of HTML elements (e.g., `Div`, `Form`, `Button`) and pairs well with HTMX.
- **HTMX**: Provides partial page updates (AJAX-like) triggered by HTML attributes. This is heavily used for dynamic UI updates without a complex frontend stack.
- **WebSockets & SSE**: 
  - **WebSockets** allow interactive, bidirectional communication with the browser.
  - **SSE (Server-Sent Events)** enable one-way streaming from server to client, suitable for real-time updates, progress tracking, and chat streaming.
  
- **Ollama**: Local LLM runtime. The code queries Ollama at `http://localhost:11434/api` endpoints to run chat completions and streaming responses.
- **MiniDataAPI**: A minimal data persistence mechanism. Defines tables from Python dict schemas and provides `.insert()`, `.update()`, `.delete()`, and `.xtra()` methods for simplified CRUD and filtering.
- **Local Infrastructure**: Everything runs locally. No external services are strictly required except for Ollama.

---

### 3. Data Structures and Persistence

The code uses `fast_app(...)` to set up a local SQLite database and create typed tables as `(table, Dataclass)` pairs. For example:

- **`store`**: A key-value store used like a server-side session or cookie.
- **`task`**: Represents todo items with fields `id`, `name`, `done`, `priority`, `profile_id`.
- **`client`**: Renamed in logic to "profile". Each profile corresponds to a client configuration.
- **`pipeline`**: A key-value store for workflow states, keyed by a `url`.

`db` is a `DictLikeDB` wrapper around `store`. It acts as a simple persistent dictionary, making application state visible and introspectable.

---

### 4. LLM Integration (Ollama and Chat Handling)

The code integrates a local LLM model (LLaMA variants) through Ollama. It:

- Maintains a conversation history (`append_to_conversation`) that logs user and assistant messages.
- Uses `chat_with_llm(model, messages)` to stream responses from Ollama. The streaming approach sends chunks of the LLM response to the frontend live.
- **Prompt Injection System**: The application dynamically injects prompts based on menu navigation. When a user switches a menu item, the LLM's "behavior" changes instantly, as if new domain knowledge is inserted.
- Maximum word count constraints, tone specification, and system prompts are included.

---

### 5. User Interface Design (FastHTML, HTMX, SSE, WebSockets)

**Layout:**  
A two-column layout:  
- Left column: main application content (depending on active plugin).  
- Right column: persistent chat interface powered by WebSockets.

**HTMX and SSE Integration:**
- HTMX attributes (`hx-post`, `hx-get`, `hx-target`) are attached to form elements and buttons for async updates.
- SSE endpoint (`/sse`) streams data to the client at intervals or event triggers.
- WebSockets (`/ws`) handle real-time bi-directional communication, allowing the user to send messages and the server to respond dynamically.

**The "poke" button and "help" link** at the bottom show how the UI can trigger simple server actions (like streaming a message).

**Navigation Menus**:
- A top navigation bar with dropdown menus for profiles and apps.
- Selecting profiles or apps triggers internal logic to switch active state, reflect it in the LLM prompt, and rebuild UI fragments.

---

### 6. Plugins (Profile, Todo, Link Graph, Streams, Workflows)

The code uses a `BaseApp` class and plugin patterns for modularity:

- **ProfileApp**: Manages client profiles. CRUD operations on `profile` records.  
- **TodoApp**: Manages todo items linked to a profile. Demonstrates sorting, toggling, and dynamic insertion.  
- **ConnectWithBotify** / **BotifyLinkGraph**: Integration with Botify API to download and visualize link graphs. Introduces complexity of external APIs and data exports.  
- **StreamSimulator**: Simulates a long-running server-side task to test SSE progress updates.  
- **Workflow (Pipeline)**: "Pipulate" pattern for multi-step workflows. Users can start a workflow (via a URL), and the pipeline logic determines which step to render next based on previously stored state.

**Notable Patterns:**  
- Each plugin defines routes (CRUD endpoints) and a `render_item()` method to display its data.
- Menus are updated dynamically to include these plugin endpoints.

---

### 7. Pipeline Pattern (Pipulate)

The pipeline concept is introduced as a simplified workflow engine:
- Uses a single record in the `pipeline` table keyed by a URL.
- Each step in the workflow (`step_01`, `step_02`, ...) is recorded as JSON in a single pipeline record.
- The code can "resume" a workflow by reading the pipeline state from the table and deciding which step's UI to render next.

This approach replaces more complex state machines or external queues with a simple JSON store and step logic.

---

### 8. Code Infrastructure and Middleware

**DOMSkeletonMiddleware**:  
A custom Starlette middleware that logs requests and prints the current `db` and `pipeline` states in a pretty-printed table after each request. This provides "transparency" and debuggability.

**File Watching and Auto-Restart**:  
A watchdog-based file watcher (`ServerRestartHandler`) restarts the server if the source file changes. Encourages rapid iteration during development.

**Logging with loguru and rich**:  
Colorful, structured logs, plus ASCII banners (via `figlet`) decorate the debugging output, reinforcing the idea of a local dev-oriented environment.

---

### 9. JSON Extraction and CRUD Operations

**JSON Extraction from LLM Output:**  
The code attempts to parse LLM responses as JSON using regex. If a recognized CRUD action JSON is found:
- Executes the action on the MiniDataAPI tables.
- If successful, broadcasts the updated DOM element over SSE or WebSocket to instantly reflect changes in the UI.

**CRUD flows**:
- `insert` -> Add new item
- `read` -> Retrieve an item (not often used directly in UI)
- `update` -> Change fields of an existing record
- `delete` -> Remove a record
- `toggle` -> Flip a boolean field (like `done` for a todo)
- `sort` -> Reorder items by priority

---

### 10. Developer Experience and Real-Time Reloading

The code is structured to:
- Make changes visible immediately (Hot reload via watchdog).
- Provide inline debugging with logs and tables after each request.
- Minimal overhead for trying out new UI changes or adding new plugins.

**No build step**: Just Python and a local server. Simple and direct.

---

### 11. Navigation, Menus, and Endpoint Management

The app organizes its navigation through `MENU_ITEMS` and has logic to "redirect" routes and store `last_app_choice` and `last_profile_id` in `db`. By changing `db["last_app_choice"]`, the LLM prompt and displayed UI content changes instantly.

Endpoints are dynamically added for each plugin and for home (`/`), `profile_app.name`, `todo_app.name`, etc. The code prints a route table at startup for easy reference.

---

### 12. Additional Notes on Design Choices

- Everything is done in a single file, focusing on "local single-user only" simplicity.
- Avoids complexity of client-side frameworks: The front-end is mostly HTML + HTMX attributes + SSE streaming.
- No advanced build pipelines or bundling steps. Just Python code generating HTML and streaming responses.
- Demonstrates a "just-in-time" prompt injection system: The LLM is guided by dynamically changed system messages whenever users switch apps. This simulates switching LLM "contexts" instantly.
- Uses minimal styling and theming with `pico.css`.

---

**In Conclusion:**

This codebase shows a unique local web framework that merges server-side HTML generation, HTMX partial updates, SSE/WebSocket streaming, local database persistence, and local LLM capabilities. It eschews conventional enterprise patterns for a more direct, introspectable, and flexible approach. It’s a sandbox environment ideal for experimenting with interactive UIs, real-time feedback loops, LLM-based assistant logic, and pipeline-driven workflows—all on the developer’s local machine.

---

**Me**: Here is the flake.nix that creates the environment: [file pasted] ...continue telling me about this app/codebase.

**o1**: The provided `flake.nix` file is a **Nix Flake configuration** that defines a reproducible development environment for the application. It is closely tied to the philosophical and technical approach described earlier, ensuring that every team member (or future user) can get an identical environment—same versions of packages, same initial scripts—no matter their operating system or machine setup.

Let’s delve deeper into the `flake.nix` and how it fits into the broader codebase and development workflow:

### What is a Nix Flake?

Nix Flakes are a newer feature in the Nix ecosystem that provide:
1. **Pinning of Dependencies**: Ensures that your environment’s dependencies (Linux packages, Python, Git, etc.) do not change unpredictably over time.
2. **Reproducibility**: Anyone with Nix and access to this `flake.nix` file can recreate the exact development environment on their machine.
3. **Declarative Environment Setup**: Instead of manually installing packages or running setup commands, everything is declared in this file. Just `nix develop` (or `nix shell`) gets you a fully set environment.

### Flake Structure and Key Points

1. **Inputs**:  
   - `nixpkgs`: The main Nix package repository pinned to `nixos-24.05`. This ensures all packages and their versions are stable and known.
   - `flake-utils`: Provides convenience functions for writing simpler flakes.

2. **Outputs**:  
   Uses `flake-utils` to produce outputs for each system (Linux, Darwin) through `eachDefaultSystem`.

   Within `outputs`, a shell environment (`devShell`) is defined, which is what developers will use.

3. **System-Aware Configuration**:
   The code uses:
   ```nix
   isDarwin = pkgs.stdenv.isDarwin;
   isLinux = pkgs.stdenv.isLinux;
   ```
   This allows it to conditionally install different sets of packages or run different shell hooks depending on whether it’s macOS or Linux. This multi-OS flexibility is essential, given the code often references “Macs are Unix” and tries to handle WSL/Linux seamlessly.

4. **Common Packages**:
   A list of `commonPackages` ensures that, regardless of OS, you have:
   - Python 3.11 and tools (`pip`, `virtualenv`)
   - figlet, tmux, zlib, git, curl, wget, cmake, htop, etc.

   On Linux, it also includes `gcc` and standard C libraries. This is important for compiling Python packages from source or dealing with native code.

5. **Allowing Unfree Packages & CUDA**:
   Setting `allowUnfree = true` in the Nixpkgs config is critical if you need proprietary binaries like CUDA drivers or other non-free packages. This is required if the project involves machine learning workloads that use GPU acceleration.

   For Linux systems, if `nvidia-smi` exists, it detects CUDA hardware and sets environment variables accordingly.

6. **Run Script and Setup**:
   The `runScript` block is a Nix-built shell script that runs automatically when you enter the development shell:
   - It prints a welcome message (using `figlet`).
   - It uses the `projectName` variable (`botifython`) to:
     - Potentially clone/update a Git repository.
     - Set up a Python virtual environment and install packages from `requirements.txt`.
   - Creates convenience scripts (`bf`, `start`, `stop`, and one named after the project) inside the `.venv/bin/` directory.  
     These scripts make it easy to start the Python app, open a browser to `http://localhost:5001`, or manage JupyterLab sessions via `tmux`.

   This is the step that ensures when you type `nix develop`, you don’t just get packages, you get a fully prepped environment with Python dependencies installed, ready to run code or start Jupyter with a single command.

7. **Virtual Environment Management**:
   The shell hook ensures a Python virtual environment is created if it doesn’t exist, and updates `PATH` to include `.venv/bin`. This merges the deterministic nature of Nix’s system packages with the flexibility of a Python virtual environment for your PyPI dependencies.

8. **Scripts and Commands**:
   After everything sets up:
   - `bf` or `projectName` command runs the Python file (`botifython.py`).
   - `start` and `stop` manage JupyterLab in a detached `tmux` session.
   - The environment tries to open `http://localhost:5001` after running the `projectName` command, which is a neat UX touch.

9. **Browser and OS Integration**:
   The script tries to open the browser differently depending on if you’re on macOS (`open` command) or Linux (`xdg-open` or Windows Subsystem for Linux via `powershell.exe /c start`). This is a small but important detail that improves the developer experience across platforms.

---

### How This Relates to the Rest of the Codebase

From the previous explanation of the codebase, we know that the entire environment is about local sovereignty and flexibility. The `flake.nix`:

- Ensures that every developer gets the same versions of Python, CMake, Git, and so forth.  
- Bootstraps Python dependencies in a way that still allows you to use `pip` for dynamic updates, though that introduces some non-determinism, it’s a convenient tradeoff for a development environment.
- Integrates with the `botifython.py` application by providing a consistent environment where all needed tools are available from day one.

Essentially, while the rest of the code (the Python `botifython.py`, the `fast_app` configuration, tasks, plugins, and LLM integration) define the functionality of the app, this `flake.nix` defines the *operational* environment in which that code runs. It’s a crucial piece of the puzzle to make the “works on my machine” problem vanish, ensuring that you can clone this repo, run `nix develop`, and start coding or testing without manually installing anything.

### Summary of the Flake Setup

- **Declarative**: All environment details are in the `flake.nix`.
- **Multi-OS**: Handles differences between Linux and macOS gracefully.
- **Pre-Configured Tools**: Python and essential build tools are readily available.
- **Project Setup**: Clones/updates the Git repo and sets up Python packages on shell entry.
- **Convenience Scripts**: Offers simple commands to run the project, start/stop JupyterLab, and handle environment configuration.

This `flake.nix` file is a perfect example of how Nix Flakes can provide a foundation of reproducibility, allowing the rest of the codebase to focus on logic rather than environment quirks.

**Me**: Document the Workflow process for creating new workflows.

**o1**: Below is a conceptual guide to creating new workflows in the provided codebase. The codebase already contains three examples of workflows (`Workflow`, `Petiteflow`, and `Poetflow`) that demonstrate the pipeline-based UI pattern. By following these guidelines, you can create your own custom workflow that fits neatly into the existing structure.

---

### What is a Workflow in This Codebase?

A "workflow" is a sequence of steps or "cards" that the user progresses through, with each step potentially capturing data or performing logic. Each step is represented by a server-side route that returns only its own card plus a placeholder for the next step. The workflow uses state tracked in a JSON blob stored in the `pipeline` table. This ensures that:

1. You can re-enter the workflow at any time using the same key (URL or name).
2. Completed steps remain completed, and locked/checked states are preserved.
3. Progress is linear and controlled by server-side logic—no complex client-side state is needed.

---

### Core Concepts

1. **Pipeline Table & Pipulate Class**:  
   The `pipeline` table stores one JSON record per workflow key (e.g., a URL or a name). The `Pipulate` class provides methods to:
   - Initialize the workflow state if missing
   - Retrieve and store data for each step
   - Determine if a step is completed and if it can advance to the next step

2. **Steps as Server Routes**:  
   Each step of the workflow is a separate HTTP GET or POST route that:
   - Returns the current step's card (UI)
   - Returns a placeholder `<div>` for the next step, which HTMX automatically loads

3. **Linear Chain of Steps**:  
   Workflows chain steps like: Step 01 -> Step 02 -> Step 03.  
   Each completed step is replaced with a locked/completed state. Each incomplete step returns a form or input UI. Once a step is submitted, the server updates the pipeline state, and loads the next step.

4. **Resumability**:  
   Because the entire workflow's state is captured in one JSON blob, returning to the first step with the same key reconstructs the entire chain reaction of all steps, showing completed states and continuing where you left off.

---

### Steps to Create a New Workflow

1. **Define Your Workflow Class**:  
   Create a new class similar to `Workflow`, `Petiteflow`, or `Poetflow`. For example, let's call it `MyFlow`:
   ```python
   class MyFlow:
       def __init__(self, app, pipulate):
           self.app = app
           self.pipulate = pipulate
           self.prefix = "/myflow"

           # Register your steps here
           app.route(f"{self.prefix}/init", methods=["POST"])(self.init)
           app.route(f"{self.prefix}/step_01")(self.step_01)
           app.route(f"{self.prefix}/step_02")(self.step_02)
           app.route(f"{self.prefix}/step_02_submit", methods=["POST"])(self.step_02_submit)
           # Add as many steps as you want following the pattern

   ```

2. **Initialize the Workflow (init endpoint)**:  
   The `init` route handles the form submission that starts or resumes the workflow.  
   - Use `self.pipulate.initialize_if_missing(key)` to ensure state exists.
   - Set step_01 data if missing.
   - Return a chain of `<div id="step_01" ...>`, `<div id="step_02">`, etc., with `hx_get` and `hx_trigger="load"` to start the chain reaction.

   ```python
   async def init(self, request):
       form = await request.form()
       key = form.get("unique_key")  # e.g. a URL or a name

       # Initialize workflow state
       self.pipulate.initialize_if_missing(key)
       if not self.pipulate.get_step_data(key, "step_01"):
           self.pipulate.set_step_data(key, "step_01", {"initial": "data"})

       # Return placeholders for all steps
       return Div(
           Div(id="step_01", hx_get=f"{self.prefix}/step_01", hx_trigger="load"),
           Div(id="step_02"),
           # ... more steps if needed
       )
   ```

3. **Implement Each Step Route**:  
   Each step route:
   - Reads state from `pipulate.get_step_data(key, "step_X")`.
   - If step data exists, show the locked/completed state and load the next step's `<div>`.
   - If it doesn't, show a form or selection UI.
   - On form submission, set the step data and return the next step placeholder.

   ```python
   async def step_01(self, request):
       key = ... # Retrieve from db or form
       step1_data = self.pipulate.get_step_data(key, "step_01")
       if step1_data:
           # Completed
           return Div(
               Card("Step 01 Completed ✓"),
               Div(id="step_02", hx_get=f"{self.prefix}/step_02", hx_trigger="load")
           )
       else:
           # Not completed: show form
           return Div(
               Card(
                   H3("Step 01: Enter Your Name"),
                   Form(
                       Input(name="name", required=True),
                       Button("Submit"),
                       hx_post=f"{self.prefix}/step_01_submit",
                       hx_target="#step_01",
                   )
               ),
               Div(id="step_02")
           )

   async def step_01_submit(self, request):
       form = await request.form()
       name_value = form.get("name")
       key = ... # The same key used during init
       self.pipulate.set_step_data(key, "step_01", {"name": name_value})
       # Return locked card + load next step
       return Div(
           Card(f"Hello, {name_value} ✓"),
           Div(id="step_02", hx_get=f"{self.prefix}/step_02", hx_trigger="load")
       )
   ```

4. **Advancing Conditions (should_advance)**:  
   If some steps depend on verifying conditions from previously stored data, use `self.pipulate.should_advance(key, "step_X", {"field":"*"})`.

   This allows you to check if the step is fully completed before continuing.

5. **Final Step**:  
   The last step can show a final "Completion" card if `finalized` is set in `step_last`. If the user re-initializes the workflow with the same key and `finalized` is `True`, skip directly to the final card.

   ```python
   async def step_02(self, request):
       key = ...
       step2_data = self.pipulate.get_step_data(key, "step_02")
       if "finalized" in step2_data:
           # Show final card
           return Card("✨ Workflow Complete ✨")
       else:
           # Show preview and finalize form
           return Div(
               Card(
                   H3("Review and Finalize"),
                   Form(
                       Button("Finalize", type="submit"),
                       hx_post=f"{self.prefix}/step_02_submit",
                       hx_target="#step_02"
                   )
               )
           )

   async def step_02_submit(self, request):
       key = ...
       self.pipulate.set_step_data(key, "step_02", {"finalized": True})
       return Card("✨ Workflow Complete ✨")
   ```

6. **Adding the Workflow to the Main App**:  
   Once you’ve defined your workflow class:
   ```python
   my_flow = MyFlow(app, pipulate)
   ```
   Add its main endpoint (like `/myflow`) to the `MENU_ITEMS` or handle it in `ALL_ROUTES`. This ensures it appears as a navigable option.

---

### Key Takeaways

- **Minimal client-side state**: All logic resides server-side with simple HTML and HTMX.
- **Resumable and persistent**: The pipeline table stores all state in JSON.
- **Easily extensible**: Just define new steps, set their data, and connect them with `Div` placeholders and `hx_get` triggers.
- **Linear and predictable**: Each step returns only its content and the next step placeholder, preventing UI complexity.

By following this pattern and using the existing `Workflow`, `Petiteflow`, and `Poetflow` classes as references, you can create new workflows that fit seamlessly into the codebase.

**Me**: Are there any lurking bugs that you can spot?

**o1**: Yes, there are a few issues scattered throughout the code. Here are some notable ones:

1. **Mismatched Variable Names in Export Polling**:  
   In the `BotifyLinkGraph` class, the `poll_export` method references `self.job_url` and `self.export_path` to check the export status. However, when starting the export in `start_links_export`, it sets `self.links_job_url` instead of `self.job_url`. There's no place in the provided code that sets `self.job_url` or `self.export_path`. This inconsistency will lead to an `AttributeError` if `poll_export` is ever called, since `self.job_url` and `self.export_path` don't exist.

2. **Incorrect File Writing Call**:  
   In the same `poll_export` method, the code attempts to write downloaded chunks to a file using `write(chunk)` directly. Normally, you'd write `f.write(chunk)` where `f` is the file object obtained from the `with open(...) as f:` block. Using `write(chunk)` without referencing the file handle `f` will raise a `NameError` or `UnboundLocalError`.

3. **Undefined Method Calls**:  
   Within `execute_crud_operation`, there's a snippet of code that calls `todo_app_instance.redirect_url(profile_id)`. No `redirect_url` method is defined on `todo_app_instance` or similar classes. This will cause an `AttributeError` when the code tries to execute that branch.

4. **Unmatched Attributes and Logic in Polling for Meta/Links**:  
   The `poll_meta_export` and `poll_links_export` methods rely on attributes like `self.meta_job_url` and `self.links_job_url`, respectively. Although these are set in `start_links_export` and `start_meta_export`, the overall logic in `poll_export` (which tries to access `self.job_url` and `self.export_path`) doesn't align with how these are named and handled. There’s a need for consistent attribute naming and usage across all export/poll methods.

---

**Summary of Bugs:**

- **Bug 1**: `poll_export` references `self.job_url` and `self.export_path` but only `self.links_job_url` is ever assigned, not `self.job_url`.
- **Bug 2**: `poll_export` tries `write(chunk)` instead of `f.write(chunk)` when writing file data.
- **Bug 3**: `execute_crud_operation` calls `todo_app_instance.redirect_url(profile_id)` even though `redirect_url` doesn't exist.
- **Bug 4**: Inconsistent naming and logic between `start_links_export`, `start_meta_export`, `poll_links_export`, and `poll_export` methods. They need a consistent approach to track job URLs and paths.

Fixing these issues involves renaming variables consistently, ensuring all attributes exist before use, correctly using `f.write(chunk)` for file I/O, and removing or implementing the missing `redirect_url` method.

**Me**: These are good bugs because the entire BotifyLinkGraph class is going to be replaced by a Workflow under the new Pipulate pipeline system. Does that make sense? And can you make an implementation plan?

**o1**: Yes, it makes sense. If the BotifyLinkGraph class is going to be replaced by a new Workflow integrated into the Pipulate pipeline system, then the issues mentioned become less critical since that entire code path will be removed. Instead of investing time fixing bugs in a component that is being deprecated, the effort should go into designing and integrating the new Workflow.

**Implementation Plan for Replacing BotifyLinkGraph with a Pipulate-Based Workflow:**

1. **Define the New Workflow’s Purpose and Steps**  
   - Clearly specify what the new workflow needs to do:
     - Example: A multi-step process to retrieve Botify project data, select analyses, export link graphs, and finalize the results.
     - Identify each step’s input, output, and completion criteria.
   - Make sure each step is small, testable, and clearly tied to pipeline states (e.g., `step_01`, `step_02`, etc.).

2. **Map Out the Pipeline State Structure**  
   - Decide how pipeline state data will be stored in `pipeline` table’s JSON blob.
   - For instance:
     ```json
     {
       "created": "2024-XX-XXTXX:XX:XX",
       "updated": "2024-XX-XXTXX:XX:XX",
       "step_01": {"org": "myorg", "project": "myproject"},
       "step_02": {"analysis_selected": "analysis_slug"},
       "step_03": {"exports_initiated": true},
       "step_04": {"finalized": true}
     }
     ```
   - Ensure each step can be resumed, and that `should_advance` conditions are well-defined.

3. **Integrate Workflow into Pipulate**  
   - Create a new Workflow class (similar to Petiteflow or Poetflow) dedicated to Botify link graph export logic.
   - In `__init__`, define routes for each step (e.g., `/mybotifyflow/step_01`, `/mybotifyflow/step_02_submit`, etc.).
   - Use the `pipulate` instance to store and retrieve step data, ensuring no external state is needed.

4. **Replace BotifyLinkGraph UI with the New Workflow Cards**  
   - Instead of showing a BotifyLinkGraph form, your `step_01` in the new workflow will:
     - Prompt user for API token if missing (or redirect to a token verification step if integrated),
     - Show org/project selection UI as a card return,
     - Store the result in `pipulate.set_step_data(url, "step_01", {...})`.
   - Each subsequent step (analysis selection, export triggering, polling, finalization) also returns cards or forms as Div/Card structures. This ensures a chain reaction:
     - `step_01` sets org and project,
     - `step_02` sets analysis,
     - `step_03` triggers export (just like the `start_...` methods did before),
     - `step_04` finalizes and shows links to results.

5. **Asynchronous Steps and SSE Integration**  
   - If streaming updates (SSE) or long-running tasks are required, integrate them the same way you did for the `StreamSimulator`.
   - The SSE endpoint can report progress (like the number of edges exported) as part of a separate step or triggered action. The workflow step that starts an export might just return an SSE-subscription link plus a card that updates over time.

6. **Cleanup and Remove Old BotifyLinkGraph Code**  
   - Once the new workflow is operational, remove the entire `BotifyLinkGraph` class, its routes, and references.
   - Update navigation menus and any references in `MENU_ITEMS` to point to the new workflow instead of BotifyLinkGraph.

7. **Testing & Validation**  
   - Test each workflow step in isolation:
     - Make sure `step_01` can resume if interrupted,
     - Confirm `should_advance` works correctly to load `step_02` once conditions are met,
     - Validate that pipeline data is updated correctly after each step submit.
   - Test SSE streaming (if used) by simulating slow exports or large data sets.
   - Confirm that final output (CSV files and their display links) appear correctly at the last step.

8. **Documentation and Code Comments**  
   - Document each step’s logic in code comments and possibly in a separate markdown file.
   - Include instructions on how to re-run or resume workflows by plugging the URL (pipeline key) back into the first step’s form.

**Outcome:**
- A clean, Pipulate-powered Workflow replaces the BotifyLinkGraph code.
- Steps become small, maintainable, and testable.
- The entire BotifyLinkGraph logic (with its known bugs) is removed, making the codebase cleaner and aligned with the new pipeline-based approach.
