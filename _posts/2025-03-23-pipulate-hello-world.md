---
title: Pipulate Hello World
permalink: /futureproof/pipulate-hello-world/
description: 
layout: post
sort_order: 2
---

CONTEXT:
You are learning about a system that converts Jupyter Notebooks into web applications.

QUESTION:
What is Pipulate and how does it convert Jupyter Notebooks into web applications?

ANSWER:
Pipulate is a system that transforms Jupyter Notebooks into web applications with the following key characteristics:

1. Conversion Capabilities:
- Any functionality expressible in a Jupyter Notebook can be converted to a web app
- The underlying Python code remains hidden from end users
- Each Notebook cell becomes a step in the web app workflow

2. Technical Architecture:
- Web apps run locally with full system access
- Integrates with a local LLM running under Ollama
- LLM maintains context of the entire web app in its discussion history
- Built using FastHTML and HTMX
- Uses a strict template-based approach

3. Design Philosophy:
- Manual conversion process following a template
- Template does not use inheritance (no superclass)
- Uses WET (Write Everything Twice) approach instead of DRY
- Prioritizes customization flexibility over code reuse
- Avoids override complexity

4. Implementation Details:
- Each Notebook cell maps to two methods:
  - step_xx: Handles the step logic
  - step_xx_submit: Processes step submissions

---

CONTEXT:
You are learning about how Pipulate workflows differ from standard Jupyter Notebooks.

QUESTION:
How does a basic Jupyter Notebook workflow get transformed into a Pipulate workflow and what key differences are there?

ANSWER:
Let's compare a basic Jupyter Notebook workflow with how it would be handled in Pipulate:

1. Standard Jupyter Notebook Version:

```python
#!/usr/bin/env python
# coding: utf-8

# In[1]:

a = input("Enter Your Name:")

# In[2]:

print("Hello " + a)

# In[ ]:
```

{:start="2"}
2. Pipulate Workflow Version (`workflows/workflow_template.py`):

## From Jupyter Notebook to Web App

Let's compare how a simple Jupyter Notebook gets transformed into a Pipulate workflow:

### Original Jupyter Notebook
```python
# In[1]:
a = input("Enter Your Name:")

# In[2]:
print("Hello " + a)
```

### Pipulate Workflow Implementation

This is how the same functionality is implemented as a Pipulate workflow:

```python
import asyncio
from collections import namedtuple
from datetime import datetime

from fasthtml.common import *
from loguru import logger

# Each step represents one cell in our linear workflow
Step = namedtuple('Step', ['id', 'done', 'show', 'refill', 'transform'], defaults=(None,))

class HelloFlow:
    APP_NAME = "hello"
    DISPLAY_NAME = "Hello World"
    ENDPOINT_MESSAGE = "This simple workflow demonstrates a basic Hello World example."
    TRAINING_PROMPT = "Simple Hello World workflow."
    PRESERVE_REFILL = True

    def __init__(self, app, pipulate, pipeline, db, app_name=APP_NAME):
        self.app = app
        self.app_name = app_name
        self.pipulate = pipulate
        self.pipeline = pipeline
        self.db = db
        pip = self.pipulate

        # Define steps that correspond to Jupyter cells
        steps = [
            Step(id='step_01', done='name', show='Your Name', refill=True),
            Step(id='step_02', done='greeting', show='Hello Message', refill=False, 
                 transform=lambda name: f"Hello {name}"),
            Step(id='finalize', done='finalized', show='Finalize', refill=False)
        ]

        self.steps = steps
        self.steps_indices = {step.id: i for i, step in enumerate(steps)}
        
        # Define messages for each step
        self.step_messages = {
            "new": "Enter an ID to begin.",
            "finalize": {
                "ready": "All steps complete. Ready to finalize workflow.",
                "complete": "Workflow finalized. Use Unfinalize to make changes."
            }
        }
        
        # Register routes for all workflow methods
        # ... (route registration code)
```

### Key Components

1. **Step Definition**: Each Jupyter cell becomes a step with:
   - `id`: Unique identifier
   - `done`: Data field to store
   - `show`: User-friendly label
   - `refill`: Whether to preserve previous input
   - `transform`: Optional function to process previous step's output

2. **Step Implementation**: Each step has two methods:
   - `step_XX()`: Renders the UI for input
   - `step_XX_submit()`: Processes the submitted data

3. **Workflow Management**:
   - `landing()`: Entry point for the workflow
   - `init()`: Initializes or resumes a workflow
   - `finalize()`: Locks the workflow when complete
   - `unfinalize()`: Unlocks for editing
   - `handle_revert()`: Returns to a previous step

4. **Data Flow**: 
   - Data flows from one step to the next using the `transform` function
   - State is persisted between sessions

The full implementation includes UI rendering with FastHTML, form handling, validation, and state management - all working together to create a web application from what was originally a simple Jupyter Notebook.


