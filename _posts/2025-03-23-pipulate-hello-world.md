---
title: Pipulate Hello World
permalink: /futureproof/pipulate-hello-world/
description: 
layout: post
sort_order: 2
---

# Pipulate Workflow Template Guide

## Core Concepts

Pipulate transforms Jupyter Notebooks into web applications by:
- Converting each notebook cell into a workflow step
- Maintaining state between steps
- Providing a consistent UI pattern
- Allowing data to flow from one step to the next

## Structure of a Workflow

Each workflow consists of:
1. A class with configuration constants (APP_NAME, DISPLAY_NAME, etc.)
2. Step definitions using the Step namedtuple
3. Route handlers for each step
4. Helper methods for workflow management

## Key Components

4. Implementation Details:
- Each Notebook cell maps to two methods:
  - step_xx: Handles the step logic
  - step_xx_submit: Processes step submissions

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
