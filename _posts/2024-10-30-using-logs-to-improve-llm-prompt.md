---
title: Using Logs to Improve LLM Prompt
permalink: /using-logs-to-improve-llm-prompt/
description: Becomes your meta description.
layout: post
sort_order: 1
---

What's happening here is I have my web logs set to start fresh every time. In
this way, I do some interaction with the user then I copy the logfile into my
OS copy buffer like so:

```bash
xclip -selection clipboard -i < webserver.log
```

...and then I paste it onto the end of a prompt like this:

**Me**: Use the log files to improve the API_SYNTAX_TEMPLATES so the
instructions to the LLM are even better and there's no misunderstanding on how
to do these JSON commands with sample data. For example, the pointy brackets are
sometimes a source of confusion. Go for clarity. Go for lack of ambiguity. Use
what you discover in this log file to propose a refinement to setting up the
system prompt. Before:

```python
API_SYNTAX_TEMPLATES = {
    "list": {
        "operation": "list",
        "target": "task"
    },
    "insert": {
        "operation": "insert",
        "target": "task",
        "args": {
            "name": "<task_name_or_emoji>",
            "done": 0,
            "priority": 0
        }
    },
    "read": {
        "operation": "read",
        "target": "task",
        "args": {"id": "<task_id>"}
    },
    "update": {
        "operation": "update",
        "target": "task",
        "args": {
            "id": "<task_id>",
            "name": "<new_task_name>",
            "done": "<true/false>",
            "priority": "<new_priority_value>",
        }
    },
    "delete": {
        "operation": "delete",
        "target": "task",
        "args": {"id": "<task_id>"}
    },
    "toggle": {
        "operation": "toggle",
        "target": "task",
        "args": {
            "id": "<task_id>",
            "field": "done",
            "new_value": "<new_boolean_value>"
        }
    },
    "sort": {
        "operation": "sort",
        "target": "task",
        "args": {
            "items": [
                {"id": "<task_id>", "priority": "<new_priority_value>"},
                {"id": "<task_id2>", "priority": "<new_priority_value2>"}
            ]
        }
    },
}
```

...and I get out a response like this:

**Claude**: Based on the log files, I can suggest several improvements to make the API_SYNTAX_TEMPLATES clearer and less ambiguous. Here's a refined version:

```python
API_SYNTAX_TEMPLATES = {
    "list": {
        "operation": "list",
        "target": "task"
    },
    "insert": {
        "operation": "insert",
        "target": "task",
        "args": {
            "name": "Sample Task Name",  # Can include emoji like "🎯 Important Task"
            "done": 0,  # 0 for incomplete, 1 for complete
            "priority": 0  # Lower number = higher priority (0 is highest)
        }
    },
    "read": {
        "operation": "read",
        "target": "task",
        "args": {
            "id": "123"  # Replace with actual task ID
        }
    },
    "update": {
        "operation": "update",
        "target": "task",
        "args": {
            "id": "123",  # Replace with actual task ID
            "name": "Updated Task Name",  # Optional: new name
            "done": 1,    # Optional: 0 or 1
            "priority": 2 # Optional: new priority
        }
    },
    "delete": {
        "operation": "delete",
        "target": "task",
        "args": {
            "id": "123"  # Replace with actual task ID
        }
    },
    "toggle": {
        "operation": "toggle",
        "target": "task",
        "args": {
            "id": "123",  # Replace with actual task ID
            "field": "done"  # Field to toggle (usually "done")
        }
    },
    "sort": {
        "operation": "sort",
        "target": "task",
        "args": {
            "items": [
                {"id": "123", "priority": 0},  # First item (highest priority)
                {"id": "456", "priority": 1},  # Second item
                {"id": "789", "priority": 2}   # Third item
            ]
        }
    }
}
```

Key improvements:

1. Replaced all `<placeholder>` syntax with actual example values
2. Added clear comments explaining the values and their meanings
3. Included examples of emoji usage in the name field
4. Clarified the priority system (0 = highest)
5. Made optional fields explicit in update operation
6. Added more realistic example IDs
7. Included multiple items in sort example to show ordering

For the system message generation, I'd suggest adding these clarifications:

```python
def generate_system_message():
    # ... existing code ...

    syntax_instructions = (
        "You can use the following JSON syntax to perform operations on the database.\n"
        "Important notes:\n"
        "1. All IDs should be strings (e.g. \"123\")\n"
        "2. Priority values are numbers (lower = higher priority)\n"
        "3. The 'done' field uses 0 for incomplete, 1 for complete\n"
        "4. Task names can include emojis (e.g. \"🎯 Important Task\")\n"
        "5. All operations use 'task' as the target\n\n"
    )

    # ... rest of the code ...
```

These changes make the templates more concrete and less ambiguous, while also providing clear examples that show exactly how to format the JSON for each operation.

---

...and it worked like a charm! The LLM is that much smarter the moment after a
contextually appropriate system-prompt is injected. I do this at initialization
of the conversation so that it just knows how to do database work from the
outset, but in case it forgets along the way, I just drop the above into another
system prompt, and we have on-the-fly retrained our LLM to do CRUD operations.

Oh, but I just noticed something:

**Me**: This is great, but the wonderful comments you inserted actually get lost because of the way I build API_SYNTAX_TEMPLATES as an actual dict. Is there any way for you to rework this so the LLM sees your comments?

**Claude**: Ah yes! We can modify how we present the templates in the system message by creating a separate documentation string for each operation. Here's how to modify the code:

```python
def generate_system_message():
    # ... existing intro and emoji_instructions ...

    operation_docs = {
        "list": """
        # List all tasks
        {
            "operation": "list",
            "target": "task"
        }""",
        
        "insert": """
        # Create a new task
        # - name: Can include emoji (e.g. "🎯 Important Task")
        # - done: 0 for incomplete, 1 for complete
        # - priority: Lower number = higher priority (0 is highest)
        {
            "operation": "insert",
            "target": "task",
            "args": {
                "name": "🎯 Sample Task",
                "done": 0,
                "priority": 0
            }
        }""",
        
        "read": """
        # Retrieve a specific task by ID
        {
            "operation": "read",
            "target": "task",
            "args": {
                "id": "123"    # Must be a string
            }
        }""",
        
        "update": """
        # Update an existing task
        # All fields are optional except id
        {
            "operation": "update",
            "target": "task",
            "args": {
                "id": "123",           # Required: task ID as string
                "name": "📝 New Name",  # Optional: new task name
                "done": 1,             # Optional: 0=incomplete, 1=complete
                "priority": 2          # Optional: new priority
            }
        }""",
        
        "delete": """
        # Delete a task by ID
        {
            "operation": "delete",
            "target": "task",
            "args": {
                "id": "123"    # Must be a string
            }
        }""",
        
        "toggle": """
        # Toggle a task's status (usually the 'done' field)
        {
            "operation": "toggle",
            "target": "task",
            "args": {
                "id": "123",        # Must be a string
                "field": "done"     # Field to toggle
            }
        }""",
        
        "sort": """
        # Reorder tasks by priority
        # Lower priority number = higher in list
        {
            "operation": "sort",
            "target": "task",
            "args": {
                "items": [
                    {"id": "123", "priority": 0},    # First item
                    {"id": "456", "priority": 1},    # Second item
                    {"id": "789", "priority": 2}     # Third item
                ]
            }
        }"""
    }

    # Modify how we build syntax_instructions
    for i, (operation_name, operation_key) in enumerate(operations, 1):
        doc = operation_docs.get(operation_key, "")
        syntax_instructions += (
            f"{i}. {operation_name}\n\n"
            f"```json\n{doc}\n```\n\n"
        )

    # ... rest of the function remains the same ...
```

This approach:
1. Keeps the actual `API_SYNTAX_TEMPLATES` dict clean for operational use
2. Creates a separate documentation version that includes comments and explanations
3. Uses markdown-style comments that will be visible to the LLM
4. Provides clear examples with explanatory notes
5. Maintains all the helpful context we want to give the LLM

The LLM will now see the comments as part of the code blocks, making the instructions much clearer while keeping the operational templates clean.

---

Alright, I LOVE that! This is so interesting! A big cloud frontier model like
Claude 3.5 Sonnet teaching me how to educate a smaller locally running
gemma2:2b, and it works!

There's actually one more deep technical precision strike I want to make, and it
doesn't warrant its whole own article. After an LLM does an insert, update, 

**Me**: Figure out how when an insert occurs on the TodoApp or ProfileApp, the
rendered display is immediately updated HTMX-style. It's already in there. Find
it.

**Claude**: Looking at the code, the HTMX updates are already implemented in these key places:

1. In `BaseApp.insert_item()`, it returns the rendered new item:
```python
async def insert_item(self, request):
    try:
        # ... insert logic ...
        new_item = await self.create_item(**new_item_data)
        # ... logging and chat updates ...
        return self.render_item(new_item)  # Returns rendered HTML for HTMX to insert
```

2. The rendering is handled by the specific app implementations:

```python
class TodoApp(BaseApp):
    def render_item(self, todo):
        return render_todo(todo)

class ProfileApp(BaseApp):
    def render_item(self, profile):
        return render_profile(profile)
```

The HTMX update works because:
1. The form submission is handled by HTMX (hx-post attribute)
2. The response from `insert_item()` returns rendered HTML
3. HTMX automatically inserts the returned HTML into the target element

This is a clean implementation that leverages HTMX's built-in behavior to handle the updates automatically without needing additional JavaScript or manual DOM manipulation.

---

> Gotcha! It's OO methods that ***also*** get called along with an ***insert*** or
> whatever. But I want to **see** the HTMX...

**Me**: And so the actual htmx directive is in here somehwere? And it gets called through the object API?

**Claude**: Yes! The HTMX directives are embedded in several places in the `render_todo` function. Here are the key HTMX attributes:

1. In the checkbox for toggling completion:
```python
checkbox = Input(
    type="checkbox",
    # ...
    hx_post=toggle_url,      # Makes a POST request when clicked
    hx_swap="outerHTML",     # Replaces the entire element with the response
    hx_target=f"#{tid}",     # Targets the Li element with id=tid
)
```

2. In the delete button:
```python
delete = A(
    '🗑',
    hx_delete=delete_url,    # Makes a DELETE request when clicked
    hx_swap='outerHTML',     # Replaces the entire element
    hx_target=f"#{tid}",     # Targets the Li element
)
```

3. In the update form:
```python
update_form = Form(
    # ...
    hx_post=f"/{todo_app.name}/{todo.id}",  # POST request to update endpoint
    hx_target=f"#{tid}",                     # Targets the Li element
    hx_swap="outerHTML",                     # Replaces entire element
)
```

These HTMX directives work with the BaseApp API because:
1. The URLs are generated using `todo_app.get_action_url()`
2. The responses from the API endpoints return rendered HTML using `render_todo()`
3. HTMX automatically handles the DOM updates based on the `hx-swap` and `hx-target` attributes

This creates a seamless cycle:
1. User interaction triggers HTMX request
2. Server processes request and returns new HTML
3. HTMX updates the DOM automatically
4. UI stays in sync with database state

---

> Ahh, this is music to my ears. But it's easy to forget for the very reason
> that it's so seamless. Now I need it to occur when the LLM does an insert or
> whatever as well.

Me: Alright, with that in mind, do you see how I monitor the chat stream to allow the LLM to do CRUD operations with JSON commands (the ones you helped me with earlier). So now the thing is, when the LLM does a CRUD operation throough execute_crud_operation, it has to be  able to call the same htmx follow-up to make the rendering update on the screen in the web ui. Can you please make that happen right now only on the insert. I know you can do it everywhere, but I want to bank one small win here on the insert without risking exploding complexity and the rabbit hole of doom. Do a very small step if you have to.

Claude: Yes! Looking at the code, we can connect the LLM-triggered inserts to the WebSocket update system. The key pieces are:

1. We already have `insert_item_to_list()` for WebSocket updates
2. We already get a rendered item in `execute_crud_operation`

Here's the small change needed in `execute_crud_operation`:

```python
# ... existing code ...
                # Render the new item for the web interface
                rendered_item = base_app_instance.render_item(new_item)
                # Add this line to push update through WebSocket
                await insert_item_to_list(rendered_item, f"{base_app_instance.name}-list")
                return_val = ({"new_item": rendered_item, "operation": "insert"}, get_filtered_table())
```

This single line addition will:

1. Use the existing WebSocket infrastructure
2. Send the rendered item to all connected clients
3. Use HTMX's out-of-band swap to insert it at the correct location
4. Keep the existing return value structure intact

The magic happens because `insert_item_to_list` already wraps the content in a Div with `hx_swap_oob="beforeend:#{list_name}"`, which tells HTMX to append it to the correct list container.

This is a minimal change that ensures LLM-triggered inserts appear immediately in the UI, just like user-triggered ones.

---

And now I'm debugging this allegedly simple light touch to recover this feature
that regressed when I added ***true*** LLM streaming. Is that ChatBot streaming
real at the tokens-being-generated level or is it simulated to "feel" more like
chat? It's at the tokens-being-generated level! And at switching to that is when
I lost this feature, but look at this Claude confidence getting it back after we
cornered the bug with debug statements.

**Claude**: Looking at the logs, I can see exactly where the issue is occurring. The item is being created and rendered correctly, but the WebSocket broadcast is failing. Here's the sequence:

1. ✅ Item creation works:
```
[RENDER DEBUG] New item created: Task(id=22, name='🤪 Make me laugh 😜', done=0, priority=2, profile_id=4)
```

2. ✅ Rendering works:
```
[RENDER DEBUG] TodoApp.render_item called with: Task(id=22...)
[RENDER DEBUG] render_todo returned type: <class 'fastcore.xml.FT'>
```

3. ❌ WebSocket broadcast fails:
```
[RENDER DEBUG] insert_item_to_list called with:
[RENDER DEBUG] - rendered_item type: <class 'fastcore.xml.FT'>
[RENDER DEBUG] - target_id: task-list
[RENDER DEBUG] Converting FT/tuple to HTML
```

Let's add more detailed logging in the WebSocket broadcast function:

```python
async def insert_item_to_list(rendered_item, target_id):
    """Insert a rendered item into a list via WebSocket."""
    logger.debug(f"[RENDER DEBUG] insert_item_to_list called with:")
    logger.debug(f"[RENDER DEBUG] - rendered_item type: {type(rendered_item)}")
    logger.debug(f"[RENDER DEBUG] - rendered_item: {rendered_item}")
    logger.debug(f"[RENDER DEBUG] - target_id: {target_id}")

    if isinstance(rendered_item, (FT, tuple)):
        # Convert FT elements to HTML string
        logger.debug("[RENDER DEBUG] Converting FT/tuple to HTML")
        content = to_xml(rendered_item)
        logger.debug(f"[RENDER DEBUG] Converted content: {content}")
    elif isinstance(rendered_item, dict):
        # Handle dictionary responses
        logger.debug("[RENDER DEBUG] Handling dictionary response")
        content = rendered_item.get('rendered_item', '')
        logger.debug(f"[RENDER DEBUG] Extracted content: {content}")
    else:
        # Assume it's already a string
        logger.debug("[RENDER DEBUG] Using direct string conversion")
        content = str(rendered_item)
        logger.debug(f"[RENDER DEBUG] String content: {content}")

    logger.debug(f"[RENDER DEBUG] Broadcasting to {len(users)} websocket users")
    for u in users.values():
        await u(
            Div(
                content,
                _="this.innerHTML = this.innerHTML + event.detail.innerHTML; "
                  "htmx.process(this.lastElementChild);",
                hx_swap_oob=f"beforeend:#{target_id}"
            )
        )
        logger.debug("[RENDER DEBUG] Broadcast complete")
```

This will help us see:
1. The exact HTML content being sent
2. How many WebSocket users are connected
3. Whether the broadcast is actually completing

The issue appears to be that either:
1. The WebSocket connection isn't established when the LLM makes the insert
2. The HTML content isn't being properly formatted for the WebSocket message
3. The target ID mismatch ("task-list" vs expected format)

Can you run this with the additional logging and show me what happens?

---

## Several Hours Later, Climbing Out of Rabbit Hole

Ugh! Couldn't trace down this issue. It's really persisting. It's HTMX WebSocket
nuance. Anyway, I'm just starting to talk with Gemini Advanced.

**Gemini**: This is a fascinating piece of code for a single-tenant web app framework! It seems like you're building a sophisticated system with a local LLM (likely running on Ollama) and a web UI powered by FastHTML. Here's a breakdown of what I see, along with some thoughts and potential improvements:

**Core Components and Functionality**

* **FastHTML for UI**:  FastHTML provides the foundation for the web interface, handling routing, rendering, and basic UI elements. It's designed for speed and simplicity, which aligns well with a single-tenant application.
* **Local LLM Integration**: The app interacts with a local LLM (like those provided by Ollama) for natural language processing and potential "agentic" behavior. This is a powerful feature, enabling interactive conversations and potentially automating tasks.
* **WebSocket Communication**: WebSockets facilitate real-time, bi-directional communication between the client and server, crucial for a chat interface and dynamic UI updates.
* **Plugin Architecture**: The `BaseApp` class provides a solid foundation for building plugins (like `TodoApp` and `ProfileApp`), promoting modularity and extensibility.
* **Persistent Storage**: The `DictLikeDB` class abstracts away the underlying storage mechanism (likely a database), allowing for easy swapping of backends.
* **CRUD Operations**: The framework supports basic CRUD operations on data, which is essential for managing application state and user data.
* **Rich Logging and Debugging**:  The use of `loguru` and `rich` libraries provides colorful, informative logs and debugging output, making it easier to understand the app's behavior.
* **Botify Integration**:  The `BotifyLinkGraph` class suggests integration with Botify, an SEO analysis platform, likely for fetching link graph data.
* **Stream Simulator**: This component simulates long-running tasks with streaming updates, a useful feature for demonstrating progress and keeping users engaged.
* **Chat Playground**: This provides a dedicated space for interacting with the LLM, likely for testing and experimentation.

**Potential Improvements and Considerations**

* **Security**:  Since the app runs on a local machine and interacts with an LLM, security should be a top priority. Consider implementing authentication, authorization, and input sanitization to prevent unauthorized access and malicious attacks.
* **LLM Prompt Engineering**: The system prompt plays a crucial role in shaping the LLM's behavior. Experiment with different prompts and guidelines to optimize the LLM's responses and ensure they align with your application's goals.
* **Error Handling**: While the code includes some error handling, it could be further improved. Consider adding more specific error messages and recovery mechanisms to enhance the user experience.
* **State Management**:  The app uses a `DictLikeDB` for persistence, but it could benefit from a more structured state management approach, especially if the application grows in complexity. Consider using a state management library or framework to manage application state more effectively.
* **UI/UX Enhancements**: The UI could be further refined to improve user experience. Consider using a more modern CSS framework or library to enhance the visual appeal and responsiveness of the interface.
* **Documentation**:  While the code includes some comments, more comprehensive documentation would be beneficial for maintainability and collaboration. Consider adding docstrings, README files, and potentially a dedicated documentation site.
* **Testing**:  Implementing unit and integration tests would help ensure the reliability and stability of the framework and its plugins.

**Overall Impression**

This is a well-structured and ambitious project. The combination of FastHTML and a local LLM offers a powerful foundation for building interactive and potentially intelligent applications. By addressing the potential improvements and continuing to refine the framework, you can create a truly unique and valuable tool.

I'm ready to help you with specific coding tasks, debugging issues, or understanding any part of this code in more detail. Just let me know what you'd like to work on!

