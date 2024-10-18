---
title: A ChatGPT o1-Preview Code Review
permalink: /chatgpt-o1-preview-code-review/
description: Building the next generation of Pipulate with FastHTML has been challenging but rewarding. After overcoming hurdles with HTMX and real-time streaming, I'm excited about the potential for powerful local web apps built in Python, easily shareable across platforms. 
layout: post
---

## App Development Progress Continues with Methodical Review and Planning

Now it's time to step through the app methodically and look for weak points. I
still haven't implemented login, as this is a 1-tenant app for now. I'll put
login in eventually and make sure things like session are implemented in a
multi-user friendly way for real web deployment.

## The Next Generation Pipulate Has Arrived With Its Challenges

The next generation Pipulate is basically born. I have overcome some crazy
hurdles and feel there shouldn't have been those hurdles because FastHTML is
supposed to be so easy for Python people. But here's the rub: HTMX, awesome as
it is, is weird. Updating fragments of a page is full of nuance and subtlety.
Many things are, but encountering all of it as hurdles to a first project on a
new platform can be daunting. I had to back up, pivot and refactor more than
once. But I did it and found a sweet spot. A very, very sweet spot.

## Working at High Speed Requires Quick Understanding and Competency

Now I'm not doing screenshots and videos here, though that would help a lot with
what I'm talking about, but I'm going as fast and furious as I can. Working fast
requires understanding well, and a certain level of competency with the tools
that I don't really have yet. New stuff tossed in: 

- Nix, NixOS and Nix flakes
- FastHTML & all that entails

I had a few big learnings.

## FastHTML Meets User Needs with Built-In Streaming Features

Two of the things I need most, the capability for streaming messages to the user
doing long-running jobs, and fairly robust database and persistence, are just
built into FastHTML, but... but... but... key features are experimental.

## Python Becomes the Next Logical Evolution in Web Frameworks

Ugh, here I am on the bleeding edge again, because the payoff of some kooky tech
is worth it. And to think how mainstream the tech really is that's in the
bleeding edge. And that means getting a much bigger payoff for knowing Python by
virtue of the next logical evolution of Flask-like web microfameworks. Only now,
you ditch the Jinja2 templates, use Python functions named 1-to-1 for the HTML
elements they bind to, add built-in database access, chat-like streaming
messages through WebSockets... wow, it should really be a check-list, huh? It's
pleasing parts like HTMX and happy Starlette middleware over an asynchronous
high performance, scalable Uvicorn webserver. 

## Creating Single-User FastHTML Development Environments with Ease

Is it ready for prime time? Certainly not the documentation. So let me provide
some to one of the most interesting and surprising things I encountered. What
I'm about to show you is what they call "single tenant", meaning it's made for
one user on the whole website. I'm going to change that, but I'm getting up and
running as fast as I can on this framework, specifically making something
distributable to run in single-user mode on a local webserver from your machine.
It's done all the time. But now, whole development environments are fairly well
reliably distributable, so it's like: "Here, run this tech infrastructure on
your manchine." Git clone, cd in, nix develop, start... and you're done. You're
running a local FastHTML webserver, serving some proprietary app on your
desktop. You don't have to share. Make cool, private stuff. Earn money having
super-powers wiring things together and selling them as canned apps, or
capability extenders that would normally have to be websites, but don't.

## Understanding Local Linux Subsystems for Web Development

That was a revelation, so when you hear me talk about this work or webdev in
general, what you're hearing me talk about is this 100% private and local, but
still eminently shareable flakes or shards or wholly functional plug-in Linux
subsystems for your host OS, be it Macs, Linux or Windows (with WSL). In other
words, we're talking about local apps or computer programs that run on your
personal computer and just happen to use a web browser for an interface. And
it's not the only interface. The "Terminal software" or the text-based
command-line interface (CLI) or even just ***console*** from which you
***started the developer environment*** is another source of output from your
programs. Rather than clicking on an icon on a desktop, the user starts programs
by typing things into the command-line. This is an important enabler for those
just getting started down this kind of old school future-proofing path.

## Understanding the Importance of Setting Your Current Directory

The concept of `cd`'ing into a directory is important. Directories are folders.
Same thing. Desktop environments have predisposed our thoughts on these matters.
But most things are represented as files in folders or directories you can move
around through typing to change your ***current directory***. The directory
you're in when you start a development environment is important. You can start
different development environments. A development environment that's

And now finally we get to the Pipulate sofware itself.

## Exploring the Unconventional Aspects of Web Development with ChatGPT

**Me to ChatGPT o1-preview**: Break this down into a markdown document going point
by point over all the noteworthy, surprising and often anti-pattern things you
find in here. Feel free to show code snippets of the special ways this or that
was handled and addressed. Include the triple backtick python fencing for good
markdown rendering. Include cautions about what can go wrong when you get the
subtleties wrong in trying to add this feature or that (plugging in more apps
like Todo). Make as long a document as you think is necessary to cover
everything inhere that's innovative, off the beaten track, or just not ordinary
web development. Don't be bombastic or use hyperbole. Just be straight shooting
descriptive and informative... 

# Analysis of the Python Web Application Code

This document provides a detailed analysis of the provided Python web
application code. The goal is to highlight noteworthy, surprising, and
anti-pattern aspects of the code. We will also include code snippets to
illustrate specific points and provide cautions about potential pitfalls when
extending the application.

---

## Table of Contents

1. [Overview](#overview)
2. [Imports and Dependencies](#imports-and-dependencies)
3. [Configuration and Styling](#configuration-and-styling)
4. [LLM Integration with Ollama](#llm-integration-with-ollama)
5. [Custom Rendering Functions](#custom-rendering-functions)
6. [Application Setup](#application-setup)
7. [Navigation Menu Creation](#navigation-menu-creation)
8. [Main Page Endpoint](#main-page-endpoint)
9. [Async Function Overloading](#async-function-overloading)
10. [Todo Application Endpoints](#todo-application-endpoints)
11. [WebSocket Integration](#websocket-integration)
12. [Application Activation](#application-activation)
13. [Cautions and Potential Pitfalls](#cautions-and-potential-pitfalls)

---

## Overview

The code is a Python web application that combines a Todo list with a chat interface powered by an LLM (Language Model). It uses custom HTML rendering functions, integrates with the Ollama LLM API, and employs asynchronous programming with WebSockets for real-time communication.

---

## Imports and Dependencies

```python
import asyncio
import json
import re
from typing import Awaitable, Callable, List, Optional

import requests
from fasthtml.common import *
from starlette.concurrency import run_in_threadpool
```

- **Noteworthy**: The use of `fasthtml.common` suggests a custom or less-common HTML generation library.
- **Surprising**: The code imports all symbols from `fasthtml.common` using `*`, which is generally discouraged as it can lead to namespace pollution.
- **Caution**: When adding new modules or functions, ensure there are no naming conflicts due to wildcard imports.

---

## Configuration and Styling

### Global Configuration Constants

```python
APP_NAME = ""                   # Controls a response "Name: " in the chat
MAX_LLM_RESPONSE_WORDS = 30     # Maximum number of words in LLM response
TYPING_DELAY = 0.05             # Delay for simulating typing effect
DEFAULT_LLM_MODEL = "llama3.2"  # Set the default LLaMA model
```

- **Noteworthy**: Constants are defined at the top for easy configuration.
- **Caution**: `APP_NAME` is set to an empty string, which may lead to unexpected UI behavior if not updated.

### Menu Width Configuration

```python
bw = "150px"
NAV_FILLER_WIDTH = "20%"        # Width for the filler in the navigation
PROFILE_MENU_WIDTH = f"{bw}"    # Width for the profile menu
ACTION_MENU_WIDTH = f"{bw}"     # Width for the action menu
EXPLORE_MENU_WIDTH = f"{bw}"    # Width for the explore menu
SEARCH_WIDTH = f"{bw}"          # Width for the search input
```

- **Noteworthy**: Menu widths are defined using a base width `bw`, promoting consistency.
- **Caution**: Using pixel values for widths may affect responsiveness on different devices.

### Menu ID Initialization

```python
profile_id = "profile-id"       # Initialize the ID for the profile menu
action_id = "action-id"         # Initialize the ID for the action menu
explore_id = "explore-id"       # Initialize the ID for the explore menu
```

- **Noteworthy**: IDs are initialized globally, which can help in managing UI elements.
- **Caution**: Hardcoding IDs can lead to conflicts if not managed carefully when the application scales.

### Conversation Initialization

```python
conversation = [
    {
        "role": "system",
        "content": (
            f"You are a Todo App with attitude. "
            f"Be sassy but helpful in under {MAX_LLM_RESPONSE_WORDS} words, "
            "and without leading and trailing quotes."
        ),
    },
]
```

- **Noteworthy**: The conversation starts with a system prompt guiding the LLM's behavior.
- **Surprising**: The system prompt includes specific instructions for sassiness and word limit.

### CSS Styling Constants

```python
COMMON_MENU_STYLE = (
    "align-items: center; "
    "background-color: var(--pico-background-color); "
    "border-radius: 16px; "
    "border: 1px solid var(--pico-muted-border-color); "
    "display: inline-flex; "
    "font-size: 1rem; "
    "height: 32px; "
    "justify-content: center; "
    "line-height: 32px; "
    "margin: 0 2px; "
)

MATRIX_STYLE = (
    "color: #00ff00; "
    "font-family: 'Courier New', monospace; "
    "text-shadow: 0 0 5px #00ff00; "
)
```

- **Noteworthy**: `MATRIX_STYLE` gives the chat interface a "Matrix" look with green text and glow effect.
- **Caution**: Overusing custom styles can make the UI inconsistent or affect accessibility.

---

## LLM Integration with Ollama

### Limiting LLM Response

```python
def limit_llm_response(response: str) -> str:
    return ' '.join(response.split()[:MAX_LLM_RESPONSE_WORDS])
```

- **Noteworthy**: Ensures that the LLM's response does not exceed the word limit.
- **Caution**: Simply truncating at the word limit may cut off sentences abruptly.

### Selecting the Best LLaMA Model

```python
def get_best_model() -> str:
    # Function implementation
```

- **Noteworthy**: Fetches available models from Ollama API and selects the best based on versioning.
- **Surprising**: Custom parsing of version strings to compare models.
- **Caution**: If the versioning scheme changes, the parsing logic may fail.

**Version Parsing Function:**

```python
def parse_version(version_string: str) -> List[Optional[int]]:
    return [int(x) if x.isdigit() else x for x in re.findall(r'\d+|\D+', version_string)]
```

- **Noteworthy**: Splits version strings into numbers and non-digit parts for comparison.
- **Caution**: Complex version strings might not be parsed correctly.

### Chatting with Ollama

```python
def chat_with_ollama(model: str, messages: list) -> str:
    # Function implementation
```

- **Noteworthy**: Handles API calls to Ollama, including error handling for different exceptions.
- **Caution**: The function returns error messages as strings, which might be displayed to the user.

---

## Custom Rendering Functions

### Rendering Todo Items

```python
def render(todo):
    tid = f'todo-{todo.id}'
    # Build HTML elements
    return Li(
        # Elements
        style="list-style-type: none;"
    )
```

- **Noteworthy**: Custom function to render todo items using HTML element constructors.
- **Surprising**: Directly manipulating HTML elements in Python rather than using templates.
- **Caution**: Inline styles may lead to difficulties in maintaining consistent styling across the app.

---

## Application Setup

### Unpacking Return Values from `fast_app`

```python
app, rt, (db, DB), (todos, Todo) = fast_app(
    "data/pipulate.db",
    ws_hdr=True,
    live=True,
    render=render,
    db={
        "key": str,
        "value": str,
        "pk": "key"
    },
    todos={
        "id": int,
        "title": str,
        "done": bool,
        "pk": "id"
    },
)
```

- **Noteworthy**: The `fast_app` function returns multiple components, including the app instance, routing table, and database tables.
- **Surprising**: Unpacking complex return values in a single line can reduce readability.
- **Caution**: Changes to `fast_app`'s return structure can break the unpacking logic.

---

## Navigation Menu Creation

### Function for Menu Style Generation

```python
def generate_menu_style(width: str) -> str:
    return COMMON_MENU_STYLE + f"width: {width}; "
```

- **Noteworthy**: Centralizes style generation for menu elements.
- **Caution**: Concatenating strings for CSS can lead to syntax errors if not formatted correctly.

### Creating the Navigation Menu

```python
def create_nav_menu(selected_profile="Profiles", selected_action="Actions"):
    # Function implementation
```

- **Noteworthy**: Builds navigation menus dynamically using HTML element constructors.
- **Surprising**: Contains detailed inline comments and instructions within the function body.

**Anti-Pattern: Inline Instructions**

```python
# Instructions for Adding Menu Items:
# (Detailed steps)
```

- **Caution**: Including verbose comments within the function can clutter the code and distract from the logic. Consider placing such instructions in separate documentation.

### Use of `dir="rtl"`

```python
Ul(
    # Menu items
    dir="rtl",
),
```

- **Noteworthy**: Sets the direction of the unordered list to right-to-left.
- **Surprising**: Unless the application targets RTL languages, this may not be necessary.
- **Caution**: Using `dir="rtl"` can affect the layout in unintended ways.

### Filler Item in Navigation

```python
filler_item = Li(
    Span(" "),
    style=(
        "flex-grow: 1; "
        "min-width: {NAV_FILLER_WIDTH}; "
        # Styles
    ),
)
```

- **Noteworthy**: Uses a flexible filler item to align navigation elements.
- **Caution**: Relying on such fillers may cause layout issues on different screen sizes.

---

## Main Page Endpoint

### Defining the Root Endpoint

```python
@rt('/')
def get():
    # Function implementation
```

- **Noteworthy**: Constructs the main page using custom HTML element constructors.
- **Surprising**: Uses a mixture of synchronous and asynchronous functions.

### Building the Layout with Custom Functions

- **Use of List Comprehensions in HTML Elements:**

```python
Ul(*[render(todo) for todo in todos()], id='todo-list', style="padding-left: 0;")
```

- **Noteworthy**: Efficiently renders all todo items.
- **Caution**: For large lists, this could impact performance.

---

## Async Function Overloading

### Duplicate Function Names for Different Routes

```python
@rt('/explore/{explore_id}')
async def profile_menu(explore_id: str):
    # Function implementation

@rt('/profile/{profile_id}')
async def profile_menu(profile_id: str):
    # Function implementation
```

- **Anti-Pattern**: Using the same function name `profile_menu` for different routes.
- **Caution**: In Python, defining two functions with the same name will overwrite the first one. This leads to only the last function being available, causing unexpected behavior.

---

## Todo Application Endpoints

### Adding a New Todo Item

```python
@rt('/todo')
async def post_todo(todo: Todo):
    # Function implementation
```

- **Noteworthy**: Validates the todo item's title and responds accordingly.
- **Caution**: The function returns a tuple of HTML elements, which may not be handled as expected by the framework.

### Deleting a Todo Item

```python
@rt('/{tid}')
async def delete(tid: int):
    # Function implementation
```

- **Noteworthy**: Deletes the todo item and sends a prompt to the chat interface.
- **Caution**: Returning an empty string to remove an item from the DOM relies on front-end handling.

### Toggling a Todo Item's Status

```python
@rt('/toggle/{tid}')
async def toggle(tid: int):
    # Function implementation
```

- **Noteworthy**: Updates the todo item's status and reflects the change in the UI.
- **Caution**: The returned HTML must correctly update the DOM element; otherwise, the UI may become inconsistent.

---

## WebSocket Integration

### Managing WebSocket Connections

```python
users = {}

def on_conn(ws, send):
    users[str(id(ws))] = send

def on_disconn(ws):
    users.pop(str(id(ws)), None)
```

- **Noteworthy**: Stores WebSocket connections in a global `users` dictionary.
- **Caution**: Using the `id` of the WebSocket object as a key may lead to issues if the object is garbage collected or if IDs collide.

### Streaming Chat Responses

```python
async def stream_chat(prompt: str, quick: bool = False):
    # Function implementation
```

- **Noteworthy**: Simulates typing by streaming the response word by word.
- **Caution**: The TYPING_DELAY constant controls the speed; setting it too low or high can affect user experience.

### Handling WebSocket Messages

```python
@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    # Function implementation
```

- **Noteworthy**: Disables and re-enables the input group to prevent user interaction during response generation.
- **Caution**: Manipulating the UI state over WebSockets requires careful synchronization to avoid race conditions.

---

## Application Activation

### Selecting the Best Model and Starting the Server

```python
# Choose the best available model
model = get_best_model()

serve()
```

- **Noteworthy**: The application selects the best LLaMA model available before starting.
- **Caution**: If `get_best_model` fails or returns an unexpected value, the application may not start correctly.

---

## Cautions and Potential Pitfalls

1. **Function Naming Conflicts**: Using the same function name (`profile_menu`) for different route handlers can cause the first function to be overwritten. Ensure all route handler functions have unique names.

2. **Global State Management**: The `users` dictionary for WebSocket connections is global. This can cause issues in a multi-threaded or multi-process environment. Consider using thread-safe data structures or connection-specific storage.

3. **Inline Styling and Layout**: Heavy use of inline styles and layout adjustments in code can make the UI hard to maintain. It's better to use external CSS files or style components centrally.

4. **Error Handling in LLM Responses**: The `chat_with_ollama` function returns error messages directly as strings. If these messages are displayed to the user, it can expose internal details or confuse the user. Implement proper error handling and user-friendly messages.

5. **Adding New Features**: When integrating more apps like Todo, ensure that the routes, function names, and database models do not conflict with existing ones. Modularize code where possible.

6. **Async and Sync Code Mixing**: Be cautious when mixing synchronous and asynchronous code. Ensure that blocking operations do not run in the event loop, which can cause performance issues.

7. **Version Parsing Logic**: The custom version parsing in `get_best_model` may not handle all version string formats. Test thoroughly with different version naming schemes.

8. **WebSocket Message Handling**: Ensure that messages sent over WebSockets are correctly serialized and deserialized. Mismatches can lead to runtime errors that are hard to debug.

9. **User Input Validation**: Sanitize and validate all user inputs, especially those that interact with the database or are sent to the LLM, to prevent injection attacks or unintended behavior.

10. **HTMX Attribute Usage**: The code heavily relies on HTMX attributes (`hx_get`, `hx_post`, etc.). When modifying or adding features, ensure that these attributes are correctly set to maintain the desired front-end behavior.

---

## Conclusion

The provided code showcases an innovative approach by integrating an LLM into a web application with real-time communication via WebSockets. While it demonstrates several advanced concepts, it also contains anti-patterns and areas that could lead to potential issues. Careful attention should be paid to function naming, global state management, and consistent coding practices to ensure the application remains maintainable and scalable.

---

**Me**: If you had an opportunity to prompt the Anthropic Claude 3.5 Sonnet
integrated into the Cursor AI editor that has access to this code, what is the
series of prompts you would issue to Claude to carry out a series of progressive
one-shot improvements. Knowing it won't be able to get everything at once and
that you won't have opportunity for iterative refinements, you want your prompts
designed to do small, discreet chisel-strike improvements. Don't prompt anything
that would cause considerable refactoring, as the way it works now with all the
DOM rules and inter-process communication is fragile. None the less, work your
way through the things you would like to see it tackle in the order it should
most logically do them. Form your answers copy/paste ready for an AI ready to
edit this program.

**ChatGPT o1-preview**: Here are a series of prompts you can issue to Claude to progressively improve the code with small, discrete changes. These prompts are designed to tackle specific issues without causing significant refactoring, ensuring the application's fragile components remain intact.

---

1. **Resolve Function Naming Conflict:**

   ```
   Please rename the second function named `profile_menu` that handles the `/profile/{profile_id}` route to `profile_menu_handler` to prevent function overwriting. Ensure all references and route handlers are updated accordingly.
   ```

2. **Improve Error Handling in LLM Responses:**

   ```
   In the `chat_with_ollama` function, modify the error handling so that instead of returning raw error messages to the user, it logs the errors and returns a generic, user-friendly message like "I'm having trouble processing that request right now."
   ```

3. **Enhance WebSocket User Management:**

   ```
   Replace the global `users` dictionary in the WebSocket handling section with a thread-safe data structure, such as `WeakValueDictionary`, and use a unique identifier for each connection that doesn't rely on `id(ws)`.
   ```

4. **Move Inline Styles to CSS Classes:**

   ```
   Refactor the inline styles scattered throughout the code by creating corresponding CSS classes. Update the HTML elements to use these classes instead of inline styles to improve maintainability and consistency.
   ```

5. **Add Input Validation and Sanitization:**

   ```
   Implement input validation and sanitization for all user inputs, including the todo title in `post_todo`, the `nav_input` in `/search`, and messages received via WebSocket, to prevent injection attacks and handle unexpected input gracefully.
   ```

6. **Update Version Parsing Logic:**

   ```
   Enhance the `parse_version` function within `get_best_model` to handle more complex version strings and edge cases, ensuring it can correctly compare versions even if the version naming scheme changes.
   ```

7. **Ensure Consistent Asynchronous Code Usage:**

   ```
   Review the codebase to ensure that all blocking I/O operations are executed asynchronously or within `run_in_threadpool` to prevent blocking the event loop. Modify any synchronous calls that could block the event loop.
   ```

8. **Improve WebSocket Message Handling:**

   ```
   In the WebSocket message handler, add exception handling to catch and manage any errors during message processing. Ensure that all messages are properly serialized before sending and deserialized upon receiving.
   ```

9. **Verify HTMX Attribute Consistency:**

   ```
   Go through all HTMX attributes in the HTML elements (e.g., `hx-get`, `hx-post`, `hx-swap`) and verify they are correctly set with valid routes and targets. Update any incorrect attributes to match the actual route handlers.
   ```

10. **Add Comments and Documentation:**

    ```
    Add explanatory comments and docstrings throughout the code, especially in complex functions and sections where the logic isn't immediately clear, to improve readability and assist future maintenance.
    ```

---

By applying these prompts in order, you can incrementally improve the codebase, addressing critical issues first and enhancing the application's stability and maintainability without extensive refactoring.

---

Wait, what? You can't quit ollama? Oddly, ollama on Linux doesn't currently look
like it has a stop command.

```bash
[mike@nixos:~/repos/pipulate]$ ollama stop llama3.2
Error: unknown command "stop" for "ollama"

Did you mean this?
	show


[mike@nixos:~/repos/pipulate]$ ollama ls
NAME                 	ID          	SIZE  	MODIFIED     
llama3.2:latest      	a80c4f17acd5	2.0 GB	10 days ago 	
llama3.1:70b         	d729c66f84de	39 GB 	2 months ago	
llama3.1:latest      	62757c860e01	4.7 GB	2 months ago	

[mike@nixos:~/repos/pipulate]$ ollama ps
NAME           	ID          	SIZE  	PROCESSOR	UNTIL              
llama3.2:latest	a80c4f17acd5	4.0 GB	100% GPU 	4 minutes from now	

[mike@nixos:~/repos/pipulate]$ ollama --help
Large language model runner

Usage:
  ollama [flags]
  ollama [command]

Available Commands:
  serve       Start ollama
  create      Create a model from a Modelfile
  show        Show information for a model
  run         Run a model
  pull        Pull a model from a registry
  push        Push a model to a registry
  list        List models
  ps          List running models
  cp          Copy a model
  rm          Remove a model
  help        Help about any command

Flags:
  -h, --help      help for ollama
  -v, --version   Show version information

Use "ollama [command] --help" for more information about a command.

[mike@nixos:~/repos/pipulate]$ ollama serve stop
Error: accepts 0 arg(s), received 1

[mike@nixos:~/repos/pipulate]$ ollama ls
NAME                 	ID          	SIZE  	MODIFIED     
llama3.2:latest      	a80c4f17acd5	2.0 GB	10 days ago 	
chiplama3.1:latest   	adc3ce1c63a0	4.7 GB	2 weeks ago 	
llama3.1:70b         	d729c66f84de	39 GB 	2 months ago	
llama3.1:latest      	62757c860e01	4.7 GB	2 months ago	
Chip:latest          	0d3cee035c84	4.8 GB	3 months ago	
dolphin-llama3:latest	613f068e29f8	4.7 GB	3 months ago	

[mike@nixos:~/repos/pipulate]$ ollama ps
NAME           	ID          	SIZE  	PROCESSOR	UNTIL               
llama3.2:latest	a80c4f17acd5	4.0 GB	100% GPU 	27 seconds from now	

[mike@nixos:~/repos/pipulate]$ ollama ps
NAME           	ID          	SIZE  	PROCESSOR	UNTIL               
llama3.2:latest	a80c4f17acd5	4.0 GB	100% GPU 	18 seconds from now	

[mike@nixos:~/repos/pipulate]$ ollama ps
NAME           	ID          	SIZE  	PROCESSOR	UNTIL               
llama3.2:latest	a80c4f17acd5	4.0 GB	100% GPU 	12 seconds from now	

[mike@nixos:~/repos/pipulate]$ ollama ps
NAME           	ID          	SIZE  	PROCESSOR	UNTIL              
llama3.2:latest	a80c4f17acd5	4.0 GB	100% GPU 	4 seconds from now	

[mike@nixos:~/repos/pipulate]$ ollama ps
NAME           	ID          	SIZE  	PROCESSOR	UNTIL             
llama3.2:latest	a80c4f17acd5	4.0 GB	100% GPU 	1 second from now	

[mike@nixos:~/repos/pipulate]$ ollama ps
NAME	ID	SIZE	PROCESSOR	UNTIL 

[mike@nixos:~/repos/pipulate]$
```

## Llama Service Re-Activates After Quitting on Linux System

And when it's installed, it turns back on when it sees a request. It's not the
little llama in the task menu like on Mac. I will probably have to figure out
how to stop and start it as a systemd service, I suspect. Something's running as
a service when when ollama quits in order to re-launch it. So bottom line, I
check that the first fix suggested above over on the Mac, and it checks out
good. One prompt from o1-preview, one fix.

