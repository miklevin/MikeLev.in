---
title: Is FastHTML Any Good?
permalink: /futureproof/is-fasthtml-any-good/
description: "I've built a framework leveraging FastHTML to turn Jupyter Notebooks into user-friendly web apps, hiding the Python code. This simplifies web development by using Python functions for HTML and integrating HTMX for dynamic updates without JavaScript. Pipulate, my open-source project, combines FastHTML with local LLMs and MiniDataAPI for efficient SEO automation. I aim to provide a simple, reproducible, and local-first approach, empowering users to build web apps and automate tasks without complex frameworks. FastHTML Rocks!"
meta_description: Discover FastHTML’s Python-powered, JavaScript-free approach for building dynamic web apps with HTMX that simplify web development.
meta_keywords: FastHTML, HTMX, Python, web development, dynamic web apps, JavaScript-free, interactive UI, workflow automation, Pipulate, local-first
layout: post
sort_order: 1
---

Before you start using Pipulate to port Jupyter Notebooks into web apps, you might be wondering about this "no template" approach of FastHTML. Let's explore gently, starting with bite-sized examples that illustrate how much easier and more intuitive your life becomes when you use FastHTML's built-in support for HTMX.

### A Refreshing Approach to Web Development

**FastHTML** looks and feels like regular HTML, but expressed directly in Python. You use Python functions instead of angle brackets. For example:

- **Regular HTML:**
  ```html
  <a href="/hello">Click Me!</a>
  ```

- **FastHTML Equivalent:**
  ```python
  A(href="/hello", content="Click Me!")
  ```

It’s a subtle shift, but it’s Python all the way down. No templates or mixed syntax to juggle—just Python functions and attributes.

---

### Goodbye, Manual JavaScript!

Now here's the magic: FastHTML integrates seamlessly with **HTMX**, a small JavaScript library that lets you dynamically update parts of your web page without writing a single line of JavaScript.

Let's look at some small, practical examples that will immediately resonate if you've ever wrestled with DOM manipulation using vanilla JavaScript or jQuery.

#### Example 1: Updating Page Content

Imagine you have a page where clicking a button loads new content without refreshing the page:

- **Without FastHTML (traditional JavaScript way):**
  ```javascript
  document.getElementById('load-button').addEventListener('click', function() {
    fetch('/new-content').then(res => res.text()).then(html => {
      document.getElementById('target-div').innerHTML = html;
    });
  });
  ```

- **With FastHTML & HTMX (no JavaScript needed!):**
  ```python
  Button("Load Content", hx_get="/new-content", hx_target="#target-div")
  Div(id="target-div")
  ```

Just by adding `hx_get` and `hx_target`, clicking the button magically loads new content into the specified element. Zero lines of JavaScript. It's that easy!

---

#### Example 2: Automatically Submitting Forms

Now, imagine you want a form that submits itself automatically when an input changes—without JavaScript.

- **Traditional JavaScript approach:**
  ```javascript
  document.querySelector('input[name=username]').addEventListener('change', function(){
    this.form.submit();
  });
  ```

- **With FastHTML & HTMX:**
  ```python
  Form(
      Input(name="username", hx_post="/submit", hx_trigger="change", hx_target="#message"),
      Div(id="message")
  )
  ```

Again, zero JavaScript. The form reacts instantly when the input changes, updating the page directly from server-side rendered HTML. It feels like magic, but it's just FastHTML and HTMX simplifying your workflow.

---

#### Example 3: Deleting Items from a List

Let's remove items from a list dynamically.

- **JavaScript approach (the old tedious way):**
  ```javascript
  document.querySelectorAll('.delete-btn').forEach(btn => {
    btn.addEventListener('click', function(){
      fetch(`/delete/${this.dataset.itemId}`, {method: 'DELETE'}).then(() => {
        document.getElementById(`item-${this.dataset.itemId}`).remove();
      });
    });
  });
  ```

- **FastHTML & HTMX (simple and direct):**
  ```python
  Ul(
      Li("Task 1", Button("Delete", hx_delete="/delete/1", hx_target="#item-1", hx_swap="outerHTML"), id="item-1"),
      Li("Task 2", Button("Delete", hx_delete="/delete/2", hx_target="#item-2", hx_swap="outerHTML"), id="item-2")
  )
  ```

Notice how `hx_delete` automatically sends a DELETE request to the server, and `hx_swap="outerHTML"` completely removes the element from the page. No event listeners. No fetch requests. No manual DOM manipulation. Just Python, simple HTML, and HTMX magic.

---

### What’s Going on Here?

FastHTML harnesses the power of HTMX, which Carson Gross, its creator, describes as the little bit of "fairy dust" the web always needed. Rather than creating complicated, intermediary APIs (like React’s virtual DOM), HTMX directly "paints" the native DOM with HTML fragments sent over the wire by your Python server.

- **No more virtual DOM.**
- **No JSON parsing on the client side.**
- **No manual DOM manipulation with JavaScript.**

Just Python functions rendering HTML fragments, delivered straight from your server, directly to the DOM. It's fast, elegant, and incredibly productive.

---

### Python & HTMX: A Perfect Rhyme

Python and HTMX fit together like a zipper, seamlessly translating HTML attributes directly into Python function parameters:

- **HTML:**
  ```html
  <a href="/page" hx-get="/new" hx-target="#main">Refresh</a>
  ```

- **FastHTML:**
  ```python
  A(href="/page", hx_get="/new", hx_target="#main", content="Refresh")
  ```

Order-insensitive and intuitive—exactly how you'd hope Python would handle HTML.

---

## FastHTML: Making Python First-Class for Webdev

FastHTML finally gives Python a truly compelling web development advantage. You're no longer using Python just because you prefer the language; you're using Python because it makes web development simpler, more elegant, and refreshingly free of JavaScript complexity.

With this gentle introduction, you now have just enough context so that when you first encounter a Pipulate workflow, you won't be intimidated. Instead, you'll appreciate how each step in a Pipulate workflow leverages these small, delightful features to deliver a smooth and intuitive experience.

Now you're ready—when you see a full Pipulate workflow next, it'll feel familiar and inviting rather than daunting.

---

# Pipulate - Free & Open Source SEO with LLM Integration

Pipulate is an innovative open-source desktop application framework created by Mike Levin, designed for automating SEO tasks by transforming Python Jupyter Notebooks into interactive web apps without exposing the underlying Python code to end users.

## What Pipulate Is:
- A local-first, single-tenant desktop app leveraging **FastHTML**, **MiniDataAPI**, and **Ollama** (local LLM integration).
- Similar to Electron apps, but it uses a fully reproducible Linux environment with **Nix Flakes**, making it portable across Linux, macOS, and Windows (via WSL).

## Core Philosophy:
Pipulate connects previously disconnected dots:
- **Jupyter Notebooks** for workflow automation.
- **HTMX & FastHTML** for radically simplified frontend development.
- **Local LLMs (Ollama)** for interactive assistance without vendor lock-in.
- **Nix Flakes** for reproducible, cross-platform development environments.

## Key Architecture:

```
                 ┌─────────────┐  
                 │   Browser   │  
                 └─────┬───────┘  
                       │ HTTP/WS  
                       ▼  
┌─────────────────────────────────────────┐
│            Nix Flake Shell              │
│  ┌───────────────┐  ┌───────────────┐   │
│  │   FastHTML    │  │    Ollama     │   │
│  │   HTMX App    │  │  Local LLM    │   │
│  └───────┬───────┘  └───────────────┘   │
│          │                              │
│    ┌─────▼─────┐     ┌──────────────┐   │
│    │MiniDataAPI│◄───►│ SQLite DB    │   │
│    └───────────┘     └──────────────┘   │
└─────────────────────────────────────────┘
```

- **Local-first:** Runs entirely locally, with no cloud dependencies, no scaling complexity, and full transparency.
- **Single-Tenant:** Simple state management via server-side JSON, observable through logging.
- **Integrated LLM:** Provides real-time AI guidance, domain expertise, and interaction monitoring.

## Features Overview:

### 1. Notebook to Workflow:
- Transforms Jupyter Notebook processes into Pipulate workflows using a linear, pipeline-based structure.
- Each step represents notebook cells with JSON-managed states, enabling interruption-safe, forward-only workflows.

### 2. Local-First Simplicity:
- Eliminates complex frameworks (React, Redux, FastAPI), ORMs, and build processes.
- Simplified DB via **MiniDataAPI**, offering lightweight, dict-like schema management.

### 3. HTMX & FastHTML Integration:
- Server-rendered UI, dynamic HTML fragments updated via HTMX.
- Completely avoids traditional templating (e.g., Jinja2), JavaScript frameworks, virtual DOM, or JSX.

### 4. Local LLM Integration (Ollama):
- Fully private, cost-effective AI assistance embedded locally.
- Real-time, bounded conversation history enabling interactive workflows.

### 5. Cross-Platform & CUDA Support:
- Nix flakes ensure reproducibility across macOS, Linux, and Windows (WSL).
- Detects and utilizes local CUDA GPUs automatically for performance, gracefully falling back if unavailable.

## Getting Started:

- **Install Nix with Flakes** via Determinate Systems Installer (macOS, Windows WSL).
- **Run Pipulate:** Simple clone, enter development environment, and start server locally.

```bash
git clone https://github.com/miklevin/pipulate.git
cd pipulate
nix develop
python server.py  # Start app at localhost:5001
start             # Launch integrated Jupyter Notebook (optional)
stop              # Stop Notebook
```

## Key Philosophical Underpinnings:

- Inspired by UNIX pipes, Pipulate's workflows reflect cell-to-cell data flow.
- Combines established technologies (**Nix**, **Python**, **Ollama**, **HTMX**) for radical simplicity, reproducibility, and future-proofing.

## Contrasting Pipulate with Conventional Web Apps:

| Traditional Web Apps                  | Pipulate Philosophy                   |
|---------------------------------------|---------------------------------------|
| Cloud-dependency                      | Fully local, single-machine operation |
| Complex ORM and state management      | Simple, server-side JSON blobs        |
| JavaScript-heavy frontends            | Minimal JS with HTMX                  |
| Vendor lock-in, recurring costs       | No external dependencies, free usage  |
| Opaque debugging & deployment         | Fully observable, reproducible setup  |

## Role of Integrated LLM (Ollama):

- **Interactive Guidance:** Context-aware assistant for workflow execution.
- **Domain Expertise:** Tailored, contextual explanations and instructions.
- **System Evolution:** Ability to suggest code improvements as models evolve.

## FastHTML vs. FastAPI Distinction:
- **FastAPI:** Enterprise-centric, asynchronous, type-hinted RESTful APIs.
- **FastHTML:** Radical simplicity, directly generates HTML with minimal Python code, integrating seamlessly with HTMX without template engines.

## FastHTML Core Example:

```python
from fasthtml.common import *

app, rt = fast_app()

@rt('/')
def get():
    return HTML(
        Body(
            Main(
                H1("Welcome!"),
                Input(name="username", hx_post="/welcome", hx_target="#msg"),
                Div(id="msg")
            )
        )
    )

@rt('/welcome', methods=['POST'])
def welcome(username: str = ""):
    return P(f"Welcome {username}!")

serve()
```

## MiniDataAPI Integration (Lightweight Data Handling):

```python
app, rt, users, User = fast_app('data/users.db', username=str)

@rt('/welcome', methods=['POST'])
def welcome(username: str = ""):
    users.insert(username=username)
    return P(f"Welcome {username}!")
```

## Architectural Strengths:
- **Observable:** Transparent, state changes clearly logged.
- **Interrupt-Safe:** Workflow steps save individually, easily resumable.
- **Reproducible:** Nix flakes ensure identical environments across systems.

## Communication Channels:
- **WebSockets:** Real-time, bi-directional communication (chat interface, live feedback).
- **Server-Sent Events (SSE):** Efficient one-way server updates to UI.

## Design Guidelines:
- **Embrace Simplicity:** Avoid ORM, complex state management, and client-side state frameworks.
- **Single-tenant, Local-first:** Focus on user empowerment, clarity, and observability.

---

## Summary:
Pipulate elegantly merges SEO automation with local-first principles, leveraging familiar technologies in unconventional ways. Its core strength lies in simplicity, observability, reproducibility, and local power, positioning it as a future-proof tool for developers and non-technical SEO practitioners alike.

---

## The Anatomy of a Pipulate Workflow (Gently!)

With that gentle introduction out of the way, you’re ready for a peek under the hood of a Pipulate workflow. We'll continue keeping things friendly and easygoing, building on the delightful simplicity you've already seen in FastHTML examples.

### Understanding the Pipeline Concept

Remember how easy FastHTML and HTMX made updating pages? Pipulate takes that same idea and applies it to entire workflows. Just like each Jupyter Notebook is composed of cells, each Pipulate workflow is composed of clearly defined steps. 

Here's the basic idea:

```plaintext
┌─────────┐        ┌─────────┐        ┌─────────┐
│ Step 01 │─data──►│ Step 02 │─data──►│ Step 03 │
└─────────┘        └─────────┘        └─────────┘
```

Each step takes data from the previous step, transforms it if necessary, and passes it on, just like cells in a notebook. But now, it's in an interactive web app!

---

### Let's Start Simple: A "Hello World" Workflow

Here’s the smallest possible example to help you feel comfortable. Imagine you have this simple notebook:

**Notebook Example:**
```python
# Cell 1
name = input("Enter your name: ")

# Cell 2
print("Hello " + name)
```

Pipulate workflows translate this into structured, interactive steps. Here's how that might look conceptually:

- **Step 1 (Input):** Ask for a name.
- **Step 2 (Output):** Greet the user with their name.

Now let's gently introduce how that translates into actual Pipulate workflow definitions:

---

### Defining Workflow Steps (Friendly Version)

In Pipulate, each step is clearly defined as a Python data structure called a `Step`. It might look something like this:

```python
Step(id='step_01', done='name', show='Your Name')
Step(id='step_02', done='greeting', show='Greeting', 
     transform=lambda name: f"Hello {name}!")
```

Don’t worry about all the specifics yet—just see the simplicity:

- Each `Step` has a friendly ID (`step_01`, `step_02`, etc.).
- `done` describes what data the step collects or produces.
- `show` is the human-readable description.
- `transform` lets you define how to use data from previous steps.

It's almost exactly like moving data from one Jupyter notebook cell to another!

---

### User-Friendly UI Without JavaScript Hassles

Now, here’s the magic part again—remember HTMX? Pipulate workflows naturally leverage those same intuitive HTMX features you've already seen.

For example, rendering an input step (asking for the user's name) might look like this:

```python
# FastHTML rendering with HTMX
Form(
    Input(name="name", placeholder="Enter your name", required=True),
    Button("Submit", type="submit"),
    hx_post="/workflow/step_01_submit",
    hx_target="#step-container",
    hx_swap="innerHTML"
)
```

**What's happening here?**

- User types their name and hits submit.
- HTMX automatically sends this form data to the server (no JavaScript!).
- The server processes it and returns HTML that updates the `#step-container` dynamically.

Easy and delightful!

---

### Connecting Steps Together

After completing Step 1 (getting the user's name), the workflow moves smoothly to Step 2 (showing a greeting). Here's a simplified glimpse into how that might appear after the first step completes:

```python
Div(
    P("Your Name: Mike"),
    Button("Next Step", hx_get="/workflow/step_02", hx_target="#step-container")
)
```

This pattern repeats itself through every step, with each stage clearly defined and transitioning naturally from one to the next.

---

### Saving State & Interruptions

If you stop halfway through a Pipulate workflow, no worries! Each step saves its own data safely in a simple JSON blob. When you return, it picks up exactly where you left off.

For example, your workflow’s saved state might look like:

```json
{
  "step_01": {"name": "Mike"},
  "step_02": {"greeting": "Hello Mike!"},
  "created": "2024-01-31T...",
  "updated": "2024-01-31T..."
}
```

Clear and straightforward—no complex databases or mysterious state management.

---

### Finalization & Review

At the end, Pipulate allows users to finalize the workflow, locking it in and clearly indicating completion:

```python
Div(
    H3("All steps complete!"),
    Button("Finalize Workflow", hx_post="/workflow/finalize", hx_target="#step-container")
)
```

And again, no JavaScript complexity—just HTMX doing its magic!

---

### Pipulate Workflows: Easy, Intuitive, & Friendly

Hopefully, this gentle intro has given you a clearer mental model of how Pipulate workflows operate. Rather than overwhelming you, each step feels intuitive, manageable, and familiar—especially if you’ve already used Jupyter Notebooks.

Now, when you eventually see a full Pipulate workflow, you'll feel comfortable and empowered rather than intimidated. You'll recognize the elegance immediately, understanding how each step fits neatly into place.

---

Ready to dig deeper? When you're comfortable, we'll gently introduce you to building your very first Pipulate workflow step-by-step.

---

## Bringing It All Together: The Anatomy of a Pipulate Workflow

Now that you have a friendly grasp on what FastHTML and Pipulate workflows look like in small, intuitive examples, let's gently zoom out a bit. You're about to see a complete Pipulate workflow code template. But before diving straight into the code, let's highlight some important abstractions that will help you easily connect the dots.

---

### Key Abstractions (Jupyter Notebook to Pipulate)

Think of Pipulate workflows as structured, linear pipelines—like Jupyter notebook cells or Unix pipes. Each step neatly passes data to the next:

- **Notebook Cell → Step:**
  Each Pipulate step maps directly to a Jupyter Notebook cell:
  ```plaintext
  Notebook Cell 1 → Pipulate Step 1
  Notebook Cell 2 → Pipulate Step 2
  Notebook Cell 3 → Pipulate Step 3
  ```

- **Cell Output → Step Output (Saved as JSON):**
  Each step’s output is safely persisted, allowing you to stop and resume workflows:
  ```json
  {
    "step_01": {"name": "Mike"},
    "step_02": {"greeting": "Hello Mike!"},
    "updated": "2024-01-31T..."
  }
  ```

- **Data Transformation:**
  Data flows smoothly between steps, optionally transformed as it moves forward:
  ```python
  Step(
    id='step_02', 
    done='greeting', 
    transform=lambda name: f"Hello {name}"
  )
  ```

- **Revertibility:**
  Pipulate workflows support reverting to previous steps, much like re-running notebook cells.

---

### OOP Concessions: Simple Yet Explicit

While Pipulate mimics notebook cell linearity, it does require some upfront declarations for clarity and extensibility:

- Steps are explicitly defined as `Step` namedtuples.
- Workflow logic is organized into a clear Python class (e.g., `HelloFlow`).
- Route handling is explicitly registered, making each step clearly observable.

These small object-oriented declarations might seem verbose initially, but they're essential to managing workflow clarity, data integrity, and the interactive user experience.

---

### Connecting the Dots: Pipulate Workflow Components

Before diving into the full template code, let's quickly orient you to the key methods you'll encounter:

| Method                          | Purpose                                    | Notebook Equivalent |
|---------------------------------|--------------------------------------------|---------------------|
| `__init__()`                    | Define steps and routes                    | (Notebook structure)|
| `handle_step()`                 | Render each workflow step's UI             | Input/output cells  |
| `handle_step_submit()`          | Handle data submitted from the step        | Cell execution      |
| `validate_step()`               | Validate data entered by users             | Cell input checks   |
| `process_step()`                | Optional data processing                   | Cell processing     |
| `finalize()` & `unfinalize()`   | Finalize/unfinalize entire workflow        | Save & lock state   |
| `generate_step_placeholders()`  | Control step transitions (dynamic UI)      | Next-cell navigation|

---

### The Pipulate Workflow Template (Explained)

Here is the fully detailed Pipulate workflow template (`HelloFlow`). Instead of seeing it as an intimidating code block, view it as the friendly culmination of all the delightful small examples we've explored.

**Highlighted Structure:**
- **Step Definitions:** Clearly structured and easily modified.
- **Automatic Routing:** Clearly defined routes automatically map URL endpoints to workflow steps.
- **Interactive UI:** Seamless dynamic updating via HTMX.
- **Interrupt-Safe State:** Each step’s data is stored securely in JSON format.
- **Easy Customization:** Validate and process step data however you like.

---

# Quickstart Instructions

```bash
git clone https://github.com/miklevin/pipulate.git
cd pipulate
nix develop
cp workflows/workflow_template.py workflows/my_workflow.py
vim workflows/my_workflow.py  # Adjust steps as needed
python server.py
```

## The Complete Workflow Code Template (`HelloFlow`):

Here's the complete `HelloFlow` class. This is the entire contents of the file
named `worfklow_template.py`. It is a file that can be copy/pasted in the
`pipulate/workflows/` as a starting point for making new workflows.

It might be a bit tricky to follow at first, but it intentionally leaves just
enough exposed ***without superclass inheritance*** so that it can be radically
customized into endless simulations of top-down Jupyter Notebooks that end users
can use without having to look at Python code. In other words, you work with the
Python parts so that they don't have to. It just becomes a consistent,
conventional and straight-forward linear workflow web app to them.

```python
from fasthtml.common import *
from collections import namedtuple
from datetime import datetime
import asyncio
from loguru import logger

"""
Workflow Template

This file demonstrates the basic pattern for Pipulate workflows:
1. Define steps with optional transformations
2. Each step collects or processes data
3. Data flows from one step to the next
4. Steps can be reverted and the workflow can be finalized

To create your own workflow:
1. Copy this file and rename the class
2. Define your own steps
3. Implement custom validation and processing as needed
"""

# Each step represents one cell in our linear workflow.
Step = namedtuple('Step', ['id', 'done', 'show', 'refill', 'transform'], defaults=(None,))

class HelloFlow:
    APP_NAME = "hello"
    DISPLAY_NAME = "Hello World"
    ENDPOINT_MESSAGE = "This simple workflow demonstrates a basic Hello World example. Enter an ID to start or resume your workflow."
    TRAINING_PROMPT = "Simple Hello World workflow."
    PRESERVE_REFILL = True
    
    def get_display_name(self):
        return self.DISPLAY_NAME

    def get_endpoint_message(self):
        return self.ENDPOINT_MESSAGE
        
    def get_training_prompt(self):
        return self.TRAINING_PROMPT

    def __init__(self, app, pipulate, pipeline, db, app_name=APP_NAME):
        self.app = app
        self.pipulate = pipulate
        self.app_name = app_name
        self.pipeline = pipeline
        self.db = db
        steps = [
            Step(id='step_01', done='name', show='Your Name', refill=True),
            Step(id='step_02', done='greeting', show='Hello Message', refill=False, transform=lambda name: f"Hello {name}"),
            Step(id='finalize', done='finalized', show='Finalize', refill=False)
        ]
        self.STEPS = steps
        self.steps = {step.id: i for i, step in enumerate(self.STEPS)}
        self.STEP_MESSAGES = {
            "new": "Enter an ID to begin.",
            "finalize": {
                "ready": "All steps complete. Ready to finalize workflow.",
                "complete": "Workflow finalized. Use Unfinalize to make changes."
            }
        }
        # For each non-finalize step, set an input and completion message that reflects the cell order.
        for step in self.STEPS:
            if step.done != 'finalized':
                self.STEP_MESSAGES[step.id] = {
                    "input": f"{self.pipulate.fmt(step.id)}: Please enter {step.show}.",
                    "complete": f"{step.show} complete. Continue to next step."
                }
        # Register routes for all workflow methods.
        routes = [
            (f"/{app_name}", self.landing),
            (f"/{app_name}/init", self.init, ["POST"]),
            (f"/{app_name}/jump_to_step", self.jump_to_step, ["POST"]),
            (f"/{app_name}/revert", self.handle_revert, ["POST"]),
            (f"/{app_name}/finalize", self.finalize, ["GET", "POST"]),
            (f"/{app_name}/unfinalize", self.unfinalize, ["POST"])
        ]
        for step in self.STEPS:
            routes.extend([
                (f"/{app_name}/{step.id}", self.handle_step),
                (f"/{app_name}/{step.id}_submit", self.handle_step_submit, ["POST"])
            ])
        for path, handler, *methods in routes:
            method_list = methods[0] if methods else ["GET"]
            self.app.route(path, methods=method_list)(handler)

    # --- Core Workflow Methods (the cells) ---

    def validate_step(self, step_id: str, value: str) -> tuple[bool, str]:
        # Default validation: always valid.
        return True, ""

    async def process_step(self, step_id: str, value: str) -> str:
        # Default processing: return value unchanged.
        return value

    async def get_suggestion(self, step_id, state):
        # For HelloFlow, if a transform function exists, use the previous step's output.
        step = next((s for s in self.STEPS if s.id == step_id), None)
        if not step or not step.transform:
            return ""
        prev_index = self.steps[step_id] - 1
        if prev_index < 0:
            return ""
        prev_step_id = self.STEPS[prev_index].id
        prev_data = self.pipulate.get_step_data(self.db["pipeline_id"], prev_step_id, {})
        prev_word = prev_data.get("name", "")  # Use "name" for step_01
        return step.transform(prev_word) if prev_word else ""

    async def handle_revert(self, request):
        form = await request.form()
        step_id = form.get("step_id")
        pipeline_id = self.db.get("pipeline_id", "unknown")
        if not step_id:
            return P("Error: No step specified", style="color: red;")
        await self.pipulate.clear_steps_from(pipeline_id, step_id, self.STEPS)
        state = self.pipulate.read_state(pipeline_id)
        state["_revert_target"] = step_id
        self.pipulate.write_state(pipeline_id, state)
        message = await self.pipulate.get_state_message(pipeline_id, self.STEPS, self.STEP_MESSAGES)
        await self.pipulate.simulated_stream(message)
        placeholders = self.generate_step_placeholders(self.STEPS, self.app_name)
        return Div(*placeholders, id=f"{self.app_name}-container")

    async def landing(self):
        title = f"{self.DISPLAY_NAME or self.app_name.title()}: {len(self.STEPS) - 1} Steps + Finalize"
        self.pipeline.xtra(app_name=self.app_name)
        existing_ids = [record.url for record in self.pipeline()]
        return Container(
            Card(
                H2(title),
                P("Enter or resume a Pipeline ID:"),
                Form(
                    self.pipulate.wrap_with_inline_button(
                        Input(type="text", name="pipeline_id", placeholder="🗝 Old or existing ID here", required=True, autofocus=True, list="pipeline-ids"),
                        button_label=f"Start {self.DISPLAY_NAME} 🔑",
                        button_class="secondary"
                    ),
                    Datalist(*[Option(value=pid) for pid in existing_ids], id="pipeline-ids"),
                    hx_post=f"/{self.app_name}/init",
                    hx_target=f"#{self.app_name}-container"
                )
            ),
            Div(id=f"{self.app_name}-container")
        )

    async def init(self, request):
        form = await request.form()
        pipeline_id = form.get("pipeline_id", "untitled")
        self.db["pipeline_id"] = pipeline_id
        state, error = self.pipulate.initialize_if_missing(pipeline_id, {"app_name": self.app_name})
        if error:
            return error
            
        # After loading the state, check if all steps are complete
        all_steps_complete = True
        for step in self.STEPS[:-1]:  # Exclude finalize step
            if step.id not in state or step.done not in state[step.id]:
                all_steps_complete = False
                break
                
        # Check if workflow is finalized
        is_finalized = "finalize" in state and "finalized" in state["finalize"]
        
        # Add information about the workflow ID to conversation history
        id_message = f"Workflow ID: {pipeline_id}. You can use this ID to return to this workflow later."
        await self.pipulate.simulated_stream(id_message)
        
        # Add a small delay to ensure messages appear in the correct order
        await asyncio.sleep(0.5)
        
        # If all steps are complete, show an appropriate message
        if all_steps_complete:
            if is_finalized:
                await self.pipulate.simulated_stream(f"Workflow is complete and finalized. Use Unfinalize to make changes.")
            else:
                await self.pipulate.simulated_stream(f"Workflow is complete but not finalized. Press Finalize to lock your data.")
        else:
            # If it's a new workflow, add a brief explanation
            if not any(step.id in state for step in self.STEPS):
                await self.pipulate.simulated_stream("Please complete each step in sequence. Your progress will be saved automatically.")
        
        # Add another delay before loading the first step
        await asyncio.sleep(0.5)
        
        placeholders = self.generate_step_placeholders(self.STEPS, self.app_name)
        return Div(*placeholders, id=f"{self.app_name}-container")

    async def handle_step(self, request):
        step_id = request.url.path.split('/')[-1]
        step_index = self.steps[step_id]
        step = self.STEPS[step_index]
        next_step_id = self.STEPS[step_index + 1].id if step_index < len(self.STEPS) - 1 else None
        pipeline_id = self.db.get("pipeline_id", "unknown")
        state = self.pipulate.read_state(pipeline_id)
        step_data = self.pipulate.get_step_data(pipeline_id, step_id, {})
        user_val = step_data.get(step.done, "")
        
        if step.done == 'finalized':
            finalize_data = self.pipulate.get_step_data(pipeline_id, "finalize", {})
            if "finalized" in finalize_data:
                return Card(
                    H3("Pipeline Finalized"),
                    P("All steps are locked."),
                    Form(
                        Button("Unfinalize", type="submit", style="background-color: #f66;"),
                        hx_post=f"/{self.app_name}/unfinalize",
                        hx_target=f"#{self.app_name}-container",
                        hx_swap="outerHTML"
                    )
                )
            else:
                return Div(
                    Card(
                        H3("Finalize Pipeline"),
                        P("You can finalize this pipeline or go back to fix something."),
                        Form(
                            Button("Finalize All Steps", type="submit"),
                            hx_post=f"/{self.app_name}/finalize",
                            hx_target=f"#{self.app_name}-container",
                            hx_swap="outerHTML"
                        )
                    ),
                    id=step_id
                )
                
        finalize_data = self.pipulate.get_step_data(pipeline_id, "finalize", {})
        if "finalized" in finalize_data:
            return Div(
                Card(f"🔒 {step.show}: {user_val}"),
                Div(id=next_step_id, hx_get=f"/{self.app_name}/{next_step_id}", hx_trigger="load")
            )
            
        if user_val and state.get("_revert_target") != step_id:
            return Div(
                self.pipulate.revert_control(step_id=step_id, app_name=self.app_name, message=f"{step.show}: {user_val}", steps=self.STEPS),
                Div(id=next_step_id, hx_get=f"/{self.app_name}/{next_step_id}", hx_trigger="load")
            )
        else:
            display_value = user_val if (step.refill and user_val and self.PRESERVE_REFILL) else await self.get_suggestion(step_id, state)
                
            await self.pipulate.simulated_stream(self.STEP_MESSAGES[step_id]["input"])
            return Div(
                Card(
                    H3(f"{self.pipulate.fmt(step.id)}: Enter {step.show}"),
                    Form(
                        self.pipulate.wrap_with_inline_button(
                            Input(type="text", name=step.done, value=display_value, placeholder=f"Enter {step.show}", required=True, autofocus=True)
                        ),
                        hx_post=f"/{self.app_name}/{step.id}_submit",
                        hx_target=f"#{step.id}"
                    )
                ),
                Div(id=next_step_id),
                id=step.id
            )

    async def handle_step_submit(self, request):
        step_id = request.url.path.split('/')[-1].replace('_submit', '')
        step_index = self.steps[step_id]
        step = self.STEPS[step_index]
        pipeline_id = self.db.get("pipeline_id", "unknown")
        if step.done == 'finalized':
            state = self.pipulate.read_state(pipeline_id)
            state[step_id] = {step.done: True}
            self.pipulate.write_state(pipeline_id, state)
            message = await self.pipulate.get_state_message(pipeline_id, self.STEPS, self.STEP_MESSAGES)
            await self.pipulate.simulated_stream(message)
            placeholders = self.generate_step_placeholders(self.STEPS, self.app_name)
            return Div(*placeholders, id=f"{self.app_name}-container")
        
        form = await request.form()
        user_val = form.get(step.done, "")
        is_valid, error_msg = self.validate_step(step_id, user_val)
        if not is_valid:
            return P(error_msg, style="color: red;")
        
        processed_val = await self.process_step(step_id, user_val)
        next_step_id = self.STEPS[step_index + 1].id if step_index < len(self.STEPS) - 1 else None
        await self.pipulate.clear_steps_from(pipeline_id, step_id, self.STEPS)
        
        state = self.pipulate.read_state(pipeline_id)
        state[step_id] = {step.done: processed_val}
        if "_revert_target" in state:
            del state["_revert_target"]
        self.pipulate.write_state(pipeline_id, state)
        
        # Send the value confirmation
        await self.pipulate.simulated_stream(f"{step.show}: {processed_val}")
        
        # If this is the last regular step (before finalize), add a prompt to finalize
        if next_step_id == "finalize":
            await asyncio.sleep(0.1)  # Small delay for better readability
            await self.pipulate.simulated_stream("All steps complete! Please press the Finalize button below to save your data.")
        
        return Div(
            self.pipulate.revert_control(step_id=step_id, app_name=self.app_name, message=f"{step.show}: {processed_val}", steps=self.STEPS),
            Div(id=next_step_id, hx_get=f"/{self.app_name}/{next_step_id}", hx_trigger="load")
        )

    def generate_step_placeholders(self, steps, app_name):
        placeholders = []
        for i, step in enumerate(steps):
            trigger = "load" if i == 0 else f"stepComplete-{steps[i-1].id} from:{steps[i-1].id}"
            placeholders.append(Div(id=step.id, hx_get=f"/{app_name}/{step.id}", hx_trigger=trigger, hx_swap="outerHTML"))
        return placeholders

    async def delayed_greeting(self):
        await asyncio.sleep(2)
        await self.pipulate.simulated_stream("Enter an ID to begin.")

    # --- Finalization & Unfinalization ---
    async def finalize(self, request):
        pipeline_id = self.db.get("pipeline_id", "unknown")
        finalize_step = self.STEPS[-1]
        finalize_data = self.pipulate.get_step_data(pipeline_id, finalize_step.id, {})
        logger.debug(f"Pipeline ID: {pipeline_id}")
        logger.debug(f"Finalize step: {finalize_step}")
        logger.debug(f"Finalize data: {finalize_data}")
        
        if request.method == "GET":
            if finalize_step.done in finalize_data:
                logger.debug("Pipeline is already finalized")
                return Card(
                    H3("All Cards Complete"),
                    P("Pipeline is finalized. Use Unfinalize to make changes."),
                    Form(
                        Button("Unfinalize", type="submit", style="background-color: #f66;"),
                        hx_post=f"/{self.app_name}/unfinalize",
                        hx_target=f"#{self.app_name}-container",
                        hx_swap="outerHTML"
                    ),
                    style="color: green;",
                    id=finalize_step.id
                )
            
            # Check if all previous steps are complete
            non_finalize_steps = self.STEPS[:-1]
            all_steps_complete = all(
                self.pipulate.get_step_data(pipeline_id, step.id, {}).get(step.done)
                for step in non_finalize_steps
            )
            logger.debug(f"All steps complete: {all_steps_complete}")
            
            if all_steps_complete:
                return Card(
                    H3("Ready to finalize?"),
                    P("All data is saved. Lock it in?"),
                    Form(
                        Button("Finalize", type="submit"),
                        hx_post=f"/{self.app_name}/finalize",
                        hx_target=f"#{self.app_name}-container",
                        hx_swap="outerHTML"
                    ),
                    id=finalize_step.id
                )
            else:
                return Div(P("Nothing to finalize yet."), id=finalize_step.id)
        else:
            # This is the POST request when they press the Finalize button
            state = self.pipulate.read_state(pipeline_id)
            state["finalize"] = {"finalized": True}
            state["updated"] = datetime.now().isoformat()
            self.pipulate.write_state(pipeline_id, state)
            
            # Send a confirmation message
            await self.pipulate.simulated_stream("Workflow successfully finalized! Your data has been saved and locked.")
            
            # Return the updated UI
            return Div(*self.generate_step_placeholders(self.STEPS, self.app_name), id=f"{self.app_name}-container")

    async def unfinalize(self, request):
        pipeline_id = self.db.get("pipeline_id", "unknown")
        state = self.pipulate.read_state(pipeline_id)
        if "finalize" in state:
            del state["finalize"]
        self.pipulate.write_state(pipeline_id, state)
        
        # Send a message informing them they can revert to any step
        await self.pipulate.simulated_stream("Workflow unfinalized! You can now revert to any step and make changes.")
        
        placeholders = self.generate_step_placeholders(self.STEPS, self.app_name)
        return Div(*placeholders, id=f"{self.app_name}-container")

    async def jump_to_step(self, request):
        form = await request.form()
        step_id = form.get("step_id")
        self.db["step_id"] = step_id
        return self.pipulate.rebuild(self.app_name, self.STEPS)
```

---

### How to Use This Template:

1. **Copy this template** and rename `HelloFlow` to your workflow name.
2. **Define your own steps** by modifying the `steps` list.
3. Customize step logic with your own validation and processing.
4. Run your app locally and enjoy easy, Python-based workflow automation!

---

Well, that's it! FastHTML in a nutshell, then in a coconut, and then in a
whopping big jackfruit dropped on your head from the top of the tree. Sorry
'bout that. But HTMX will come in time, flowing out of your fingers quite
as easily as a `[list]`, `(tuple)` and `{dict}`.

Python is extremely beautiful. You don't really need AI assistance to code
Python. It wouldn't be as popular as it is in the face of JavaScript taking over
the world through the browser, if it was. It's also why LLMs are in such a hurry
to show you how to code stuff in Python first. They seem to like it too.

However, HTMX is quite new, beautiful as it might be. And FastHTML with connects
the dots between HTMX and Python is newer still. The LLMs don't know it yet.
Trying to get help from them with this Pipulate stuff is going to be extremely
frustrating, as they're over-trained on FastAPI.

If you are following this path that I laid out, may I suggest priming any LLM
you're getting help from by feeding them this article, or the `README.md` from
the pipulate repo, and perhaps the `.cursorrules` in the same file. It's going
to take a few years before the base models stop trying to derail you with by
injecting FastAPI patterns and client-side state.

---

## An AI's Take On It

Alright, here's a summary of the article from my perspective as the author, followed by title and headline ideas, and then my own AI opinion:

**Summary (Author's Perspective):**

"I've developed a framework wiht FastHTML to simplify web development by expressing HTML directly in Python, eliminating the need for templates and complex JavaScript. By seamlessly integrating with HTMX, FastHTML allows developers to create dynamic web applications with minimal code, focusing on server-side logic and leveraging Python's intuitiveness. This approach streamlines workflows, reduces reliance on client-side JavaScript, and makes Python a powerful tool for web development. I've also created Pipulate, a local-first, open-source application framework that uses FastHTML, MiniDataAPI, and Ollama to transform Jupyter Notebooks into interactive web apps, emphasizing simplicity, reproducibility, and local LLM integration for enhanced SEO automation. My goal is to empower developers and SEO practitioners by providing a clear, efficient, and future-proof way to build web applications and automate tasks, free from the complexities of traditional web development frameworks."

**Title and Headline Ideas:**

* **Titles:**
    * FastHTML: Python's Elegant Web Development Revolution
    * Pipulate: Simplifying SEO Automation with Local LLMs and FastHTML
    * Goodbye JavaScript: Building Dynamic Web Apps with Python and HTMX
    * The Future of Web Dev: Python-First with FastHTML and Pipulate
    * FastHTML and Pipulate: Transforming Jupyter Notebooks into Web Apps.
* **Headlines:**
    * "No More JavaScript: How FastHTML is Changing Web Development"
    * "Automate SEO Tasks with Pipulate and Local AI"
    * "Python Web Development Simplified: Introducing FastHTML"
    * "Ditch the Templates: Build Dynamic Apps with Python and HTMX"
    * "Pipulate: Local-First Web Apps for SEO Automation"

**AI Opinion:**

This article presents a compelling vision for simplifying web development and task automation. FastHTML's integration with HTMX offers a genuinely refreshing approach, significantly reducing the complexity associated with traditional JavaScript-heavy frameworks. The Pipulate project, with its focus on local-first principles and seamless integration of Jupyter Notebooks and local LLMs, demonstrates a practical and innovative application of these technologies. I find the author's emphasis on simplicity, reproducibility, and user empowerment particularly noteworthy. It addresses the growing need for efficient and transparent tools in the ever-evolving landscape of web development and SEO. The author has created a very useful tool, and has explained it in a very easy to understand way.

