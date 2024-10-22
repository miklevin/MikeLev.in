---
title: Local AI Awareness Training
permalink: /local-ai-awareness-training/
description: Learn how to integrate local language models with FastHTML to build scalable CRUD applications, enhancing user interactions and managing conversation histories effectively. Aka how to train your local Llama.
layout: post
sort_order: 1
---

> The time has come the walrus said to teach our local LLM to do CRUD
> operations, because what good is a book without pictures or conversations in
> it?

## Building a Scalable FastHTML CRUD App with Local LLM In The Loop

So we've built a CRUD app in the tradition of Ruby on Rails (RoR) or Django, but
on FastHTML and with a local LLM (when available). The LLM is now ***"in the
loop"*** on all user actions with it getting dumped into the conversation
history stream. 

That's "the hook" for dumping into a local SQL database as a full
text-searchable log, and into Faiss or Milvus for vector embedding similarity
searches. These are the two biggest projects I've deferred, but they're totally
"pluggable". The components are loosely coupled, and I've focused on clear ways
to change the wiring under the covers. So, it's okay to defer that stuff.

## Improving Conversation History Display for the Server Console Output

What I haven't differed is having the LLM in the loop on all things in the first
place, and that was the majority of yesterday's work, although it was so
in-the-weeds there is no way its documentation is going to make it into these
articles. It essentially involved rounding up all ***discussion streaming***
features and using that as a choke-point to update conversation history in a
global object that can be parsed and digested elsewhere when the time arrives.

Instead of showing complete discussion history in the (now very entertaining)
server console output (which amounts to a parallel interface to the app), I show
summary statistics of conversation history, so you can see a histogram with
number of interactions with each role, system, user and assistant, go up.

## Teaching AI Apps: A Day of Trial and Discovery

And so it is with that background I show just a few snippets of conversation
with mostly ChatGPT o1-preview and (now plain old) 4o to give a sense of
teaching an LLM what it can do in an app. It was indeed a rabbit-hole that
consumed the whole day more-or-less. But it was worth it for a few reasons.

- It pumps-up the ***"ghost in the machine"*** feeling
- It demonstrates even small local LLMs can execute functions
- It creates the data-stream to teach the LLM how to use the app

## Preparing for a Future Where AI Can Take Over Software Tasks

Remember, an ultimate goal here is not just to have an LLM in the loop to assist
the human user with using the software. It is to prepare for when (whatever LLM
you plug in, local or not) is smart enough to take over using the software to
achieve what you're trying to achieve on any request merely by asking it to do
so. After watching users use the software for a few thousand hours, what won't
it be able to do better than the human?

---

**Me**: Some random prompting about keeping the LLM's attempts in-sync with
permitted commands in the system.

**o1-preview**: Here’s an **eloquent JSON expression** of each CRUD operation that mirrors the **MiniDataAPI code**, ensuring that the transition between JSON and Python is seamless and intuitive. Each JSON example contains a **command, target, arguments**, and **expected output**, structured in a way that resembles the corresponding Python code.

---

## **1. Create an Item**

### **Python Code:**
```python
new_item = table.insert({"name": "New Item", "priority": 1})
```

### **JSON Representation:**
```json
{
  "operation": "insert",
  "target": "table",
  "args": {
    "name": "New Item",
    "priority": 1
  },
  "output": {
    "id": 1,
    "name": "New Item",
    "priority": 1
  }
}
```

---

## **2. Read an Item**

### **Python Code:**
```python
item = table[1]
```

### **JSON Representation:**
```json
{
  "operation": "read",
  "target": "table",
  "args": {
    "id": 1
  },
  "output": {
    "id": 1,
    "name": "Existing Item",
    "priority": 2
  }
}
```

---

## **3. Update an Item**

### **Python Code:**
```python
table.update(id=1, name="Updated Item", priority=3)
```

### **JSON Representation:**
```json
{
  "operation": "update",
  "target": "table",
  "args": {
    "id": 1,
    "name": "Updated Item",
    "priority": 3
  },
  "output": {
    "id": 1,
    "name": "Updated Item",
    "priority": 3
  }
}
```

---

## **4. Delete an Item**

### **Python Code:**
```python
table.delete(1)
```

### **JSON Representation:**
```json
{
  "operation": "delete",
  "target": "table",
  "args": {
    "id": 1
  },
  "output": {
    "message": "Item deleted successfully"
  }
}
```

---

## **5. Toggle an Item Field**

### **Python Code:**
```python
item = table[1]
new_status = not item['status']
table.update(id=1, status=new_status)
```

### **JSON Representation:**
```json
{
  "operation": "toggle",
  "target": "table",
  "args": {
    "id": 1,
    "field": "status"
  },
  "output": {
    "id": 1,
    "status": true
  }
}
```

---

## **6. Sort Items**

### **Python Code:**
```python
for item in [{"id": 1, "priority": 2}, {"id": 2, "priority": 1}]:
    table.update(id=item["id"], priority=item["priority"])
```

### **JSON Representation:**
```json
{
  "operation": "sort",
  "target": "table",
  "args": {
    "items": [
      {"id": 1, "priority": 2},
      {"id": 2, "priority": 1}
    ]
  },
  "output": {
    "message": "Items sorted successfully"
  }
}
```

---

## **7. List All Records**

### **Python Code:**
```python
records = table()
```

### **JSON Representation:**
```json
{
  "operation": "list",
  "target": "table",
  "args": {},
  "output": [
    {"id": 1, "name": "Item 1"},
    {"id": 2, "name": "Item 2"}
  ]
}
```

---

## **8. Redirect to Profile URL**

### **Python Code:**
```python
db["last_profile_id"] = 1
new_profile = table[1]
new_url = f"/{table.name}/{1}"
```

### **JSON Representation:**
```json
{
  "operation": "redirect",
  "target": "profile",
  "args": {
    "id": 1
  },
  "output": {
    "redirect_url": "/table/1"
  }
}
```

---

## **How to Flip between JSON and Python Code**

This structure allows easy transformation between JSON and Python by following these steps:

1. **Operation** → MiniDataAPI Method (e.g., `insert`, `update`, `delete`).
2. **Target** → Database table or object (`table`, `profile`).
3. **Args** → Arguments passed to the operation (e.g., `id`, `name`, `priority`).
4. **Output** → Expected output from the operation, ensuring it matches Python's behavior.

---

### **Python Code from JSON Example (Automated Parser Idea):**
Given the JSON example for **Create**:
```json
{
  "operation": "insert",
  "target": "table",
  "args": {
    "name": "New Item",
    "priority": 1
  }
}
```

A Python function could parse this JSON into executable code:
```python
def execute_operation(json_data):
    operation = json_data["operation"]
    target = globals()[json_data["target"]]
    args = json_data["args"]

    if operation == "insert":
        return target.insert(args)
    elif operation == "update":
        return target.update(**args)
    elif operation == "delete":
        return target.delete(args["id"])
    elif operation == "read":
        return target[args["id"]]
    elif operation == "list":
        return target()
```

This parser would enable **one-to-one flip-flopping** between JSON and Python.

---

## **Conclusion**

This JSON format mirrors MiniDataAPI operations closely, ensuring clarity and consistency between **JSON expressions and Python code**. By following this structure, anyone reading the JSON will immediately understand the corresponding Python code, creating a seamless development and debugging experience.

**Me**: Write the Python function that takes these JSONS, turns it into the Python code to carry out their suggested MiniDataAPI command.

**ChatGPT 4o**: Here is a Python function that takes JSON representations of operations and executes the corresponding MiniDataAPI commands dynamically:

### **Python Function to Execute MiniDataAPI Commands from JSON**

```python
def execute_minidataapi_command(json_data):
    """
    Executes a MiniDataAPI command based on the given JSON input.

    Args:
        json_data (dict): The JSON representation of the operation.
    
    Returns:
        The result of the MiniDataAPI operation, or an error message if the operation fails.
    """
    # Extract operation details
    operation = json_data["operation"]
    target_name = json_data["target"]
    args = json_data.get("args", {})
    
    # Retrieve the target table or object from the global scope
    target = globals().get(target_name)

    if target is None:
        raise ValueError(f"Target '{target_name}' not found.")

    try:
        # Perform the corresponding MiniDataAPI operation
        if operation == "insert":
            return target.insert(args)

        elif operation == "read":
            return target[args["id"]]

        elif operation == "update":
            return target.update(**args)

        elif operation == "delete":
            return target.delete(args["id"])

        elif operation == "toggle":
            item = target[args["id"]]
            field = args["field"]
            new_status = not getattr(item, field)
            return target.update(id=args["id"], **{field: new_status})

        elif operation == "sort":
            for item in args["items"]:
                target.update(id=item["id"], priority=item["priority"])
            return {"message": "Items sorted successfully"}

        elif operation == "list":
            return list(target())

        elif operation == "redirect":
            db["last_profile_id"] = args["id"]
            new_profile = target[args["id"]]
            return {"redirect_url": f"/{target.name}/{args['id']}"}

        else:
            raise ValueError(f"Unsupported operation: {operation}")

    except KeyError as e:
        return {"error": f"Missing key: {str(e)}"}
    except Exception as e:
        return {"error": str(e)}
```

---

### **How It Works**

1. **Operation Parsing:** 
   - The function reads the `operation` from the JSON and matches it with the corresponding MiniDataAPI operation (e.g., `insert`, `update`).
2. **Target Retrieval:** 
   - It looks for the `target` (table or profile) in the global scope.
3. **Executing Commands:** 
   - The appropriate MiniDataAPI command is executed based on the provided `operation` and `args`.

---

### **Example Usage**

#### **JSON for Inserting an Item**
```json
{
  "operation": "insert",
  "target": "table",
  "args": {
    "name": "New Item",
    "priority": 1
  }
}
```

#### **Python Execution**
```python
result = execute_minidataapi_command({
    "operation": "insert",
    "target": "table",
    "args": {
        "name": "New Item",
        "priority": 1
    }
})
print(result)
```

---

#### **JSON for Reading an Item**
```json
{
  "operation": "read",
  "target": "table",
  "args": {
    "id": 1
  }
}
```

#### **Python Execution**
```python
result = execute_minidataapi_command({
    "operation": "read",
    "target": "table",
    "args": {
        "id": 1
    }
})
print(result)
```

---

### **Error Handling**

- If the `target` is not found in the global scope, a `ValueError` is raised.
- If a required argument is missing, a `KeyError` is returned in the response.
- Other exceptions are caught and returned as error messages.

---

### **Conclusion**

This function makes it easy to **flip between JSON and MiniDataAPI Python code**, providing a clean, dynamic way to execute CRUD operations directly from structured JSON input.

---

After much haranguing, one of the most interesting things I did was the
reworking of the system prompt to have all these API syntax instructions
embedded into it.

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
            "name": "<task_name>",
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


def generate_system_message():
    operations = [
        ("List All Records", "list"),
        ("Insert (Create)", "insert"),
        ("Read (Retrieve)", "read"),
        ("Update", "update"),
        ("Delete", "delete"),
        ("Toggle Field (e.g., Status)", "toggle"),
        ("Sort Records", "sort"),
    ]

    message = (
        f"Your name is {APP_NAME} if asked. "
        f"Keep your responses under {MAX_LLM_RESPONSE_WORDS} words. "
        "When a user asks you to do something in JSON, follow the API syntax rules exactly. "
        "Here are the API syntax rules for each CRUD operation:\n\n"
    )

    for i, (operation_name, operation_key) in enumerate(operations, 1):
        template = API_SYNTAX_TEMPLATES.get(operation_key, {})
        message += (
            f"{i}. {operation_name}\n\n"
            f"```json\n{json.dumps(template, indent=2)}\n```\n\n"
        )

    message += (
        f"Keep responses under {MAX_LLM_RESPONSE_WORDS} words. "
        "Use emojis where appropriate to enhance responses. "
    )

    return message


conversation = [
    {
        "role": "system",
        "content": generate_system_message()
    }
]

VALID_CRUD_OPERATIONS = {"insert", "read", "update", "delete", "toggle", "sort", "list"}

CRUD_PROMPT_PREFIXES = {
    action: f"Make an under {MAX_LLM_RESPONSE_WORDS} words sassy comment to the user letting them know you know "
    for action in VALID_CRUD_OPERATIONS
}
CRUD_SUFFIX = " The user might query about this.\n"
```

## The Art of Crafting Effective System Prompt Guidelines

Pshew! I'm sure they teach this stuff in schools these days, but there's a real
art and science to this ***system prompt establishing the ground rules*** thing.
And the LLM is going to lose grip on it as the conversation history gets longer
and this initializing goodness gets diluted. Consequently, it has to be
constructed in such a way that you can inject its best bits here and there as
the conversation evolves and it forgets. 

## Implementing Self-Correcting Callbacks in Large Language Models

For example, if it forgets the API syntax to do CRUD operations and it starts
doing things that looks like its going to corrupt your database (defensively
sanitize against that as if they're a user by the way), you can recognize such
faux pas, snag that `API_SYNTAX_TEMPLATE` and inject it into the conversation as
a gentle system prompt on the failed-action rebound. 

You essentially program in self-correcting callbacks. That way you don't clutter
the conversation history with reminders to the LLM unless it needs it, and this
keeps it appropriate for any LLM moving forward, even as they get smarter.
Gentle reminders on screw-ups rather then helicopter parenting.

Psst! Wanna see some code? You thought eval was evil? Wait until you see this.
But no really, I do a whole bunch of sanitizing, not the least of which is going
through the `BaseApp` ***base class*** for all operations, so any system-wide
defenses I put in against the user also gets applied to the LLM.

## OpenAI Is Not The Only LLM Capable of Execution

First, we have to recognize attempts to execute actions against the system by
looking for JSON embedded into the LLM's response. Anyone who thinks the ability
to execute functions is some magical vendor-provided OpenAI-only thing, think
again. Any LLM can execute functions if you teach it how.

### Extract the JSON from LLM Response

```python
def extract_json_objects(text):
    """
    Extract JSON objects from a given text string.

    This function searches for JSON-like structures in the input text and attempts to parse them into Python objects.
    It handles nested JSON structures and Unicode escape sequences.

    Args:
        text (str): The input text containing potential JSON objects.

    Returns:
        list: A list of successfully parsed JSON objects.

    Notes:
        - The function uses a regex pattern to identify potential JSON structures.
        - It attempts to handle Unicode escape sequences before parsing.
        - Any JSON parsing errors are caught and logged, but do not halt the extraction process.
    """
    json_objects = []
    # Find all JSON-like structures in the text
    json_pattern = r'\{(?:[^{}]|(?:\{(?:[^{}]|(?:\{[^{}]*\})*)*\}))*\}'
    matches = re.finditer(json_pattern, text)

    for match in matches:
        try:
            json_str = match.group()
            # Replace Unicode escape sequences
            json_str = json_str.encode('utf-8').decode('unicode_escape')
            json_obj = json.loads(json_str)
            json_objects.append(json_obj)
        except json.JSONDecodeError as e:
            print(f"Failed to parse JSON: {e}")
            print(f"Problematic JSON string: {json_str}")

    return json_objects
```

## Validating JSON Against Safe and Permitted Rules Before Execution

Okay, so now we have some JSON. What are we going to do with it? Well before
attempting to execute it or anything silly like that, we're going to examine it
and see what it's trying to do. We'll validate it against our rules for what's
safe and permitted. And we'll make a list of everything that passes the muster
and hand it along as a list to the ***command-executor***, a completely separate
function to do the dirty-work. This is just a pattern-matcher and list
generator.

### Validating JSON

```python
async def detect_embedded_crud_json(text, base_app):
    """
    Detect and execute CRUD operations from JSON objects embedded in text.

    This function extracts JSON objects from the input text, validates them for CRUD operations,
    and executes these operations using the provided base_app instance.

    Args:
        text (str): The input text containing potential JSON objects with CRUD operations.
        base_app (BaseApp): An instance of the BaseApp class or its subclass to execute CRUD operations.

    Returns:
        list: A list of tuples, each containing:
            - The original JSON object
            - The result of the CRUD operation (or an error message)
            - The updated table data after the operation (or an empty list if an error occurred)

    Raises:
        No exceptions are raised directly by this function. All exceptions are caught and logged.

    Notes:
        - JSON objects are extracted using the extract_json_objects function.
        - Each JSON object is validated for the required 'operation' and 'target' keys.
        - CRUD operations are executed using the execute_crud_operation function.
        - Any errors during processing are logged and included in the return list.
    """
    detected_patterns = []
    json_objects = extract_json_objects(text)

    for json_obj in json_objects:
        try:
            # Validate the JSON object
            if not isinstance(json_obj, dict):
                raise ValueError(f"Invalid JSON object type: {type(json_obj)}")
            if 'operation' not in json_obj or 'target' not in json_obj:
                raise ValueError(f"Missing 'operation' or 'target' in JSON: {json_obj}")

            # Execute the CRUD operation
            result, table_data = await execute_crud_operation(base_app, json_obj)
            detected_patterns.append((json_obj, result, table_data))
        except Exception as e:
            # If there's an error, append it to the detected patterns
            error_message = f"Error processing JSON object: {str(e)}\nJSON: {json.dumps(json_obj, indent=2)}"
            logger.error(error_message)
            detected_patterns.append((json_obj, error_message, []))

    return detected_patterns
```

## A JSON Machine Code List Is Provided for Safe Execution

Okay, so now we have a list of extracted and validated JSON for turning into
actual executed commands. Now this isn't a list of arbitrary Python code for
those people finding this article worried about AI becoming self-aware and
hacking the system, although I'm sure a superintelligent AI could find a way to
exploit this. 

### Defending Against Code Execution with Rigid Class Constraints

No, rather this is just a bunch of JSON machine instructions for putting through
an instruction interpreter. It's exactly as safe as you program the following
bit to be. And hopefully you can see the defenses I took of using the original
***base class*** that the user themselves use to ***"execute"*** the code,
meaning it's on some pretty rigid rails. It can only do what `BaseApp` is
allowed to do...

### The Command Executer

```python
async def execute_crud_operation(base_app_instance, operation_data):
    """
    Execute a CRUD operation on the given BaseApp instance using the provided operation data.

    This function interprets and executes various CRUD (Create, Read, Update, Delete) operations
    on a BaseApp instance. It supports operations like insert, read, update, delete, toggle, sort,
    list, and redirect.

    Args:
        base_app_instance (BaseApp): An instance of the BaseApp class or its subclass on which
                                     to perform the operation.
        operation_data (dict): A dictionary containing the operation details. It must include
                               'operation' and 'target' keys, and may include an 'args' key
                               with operation-specific arguments.

    Returns:
        tuple: A tuple containing two elements:
            - The result of the operation (varies based on the operation type)
            - A list of filtered table data after the operation

    Raises:
        ValueError: If the operation data is invalid or if an unsupported operation is requested.

    Notes:
        - The function uses a persistent database to get the current profile_id.
        - It includes error handling and logging for various scenarios.
        - The function supports the following operations:
          insert, read, update, delete, toggle, sort, list, and redirect.
        - Each operation has specific requirements for the 'args' dictionary.

    Example:
        operation_data = {
            "operation": "insert",
            "target": "todo",
            "args": {"name": "New Task", "done": False, "priority": 1}
        }
        result, updated_table = await execute_crud_operation(todo_app, operation_data)
    """
    try:
        # Extract operation details
        operation = operation_data.get('operation')
        target = operation_data.get('target')
        args = operation_data.get('args', {})

        # Ensure the operation targets the correct table in BaseApp
        if not operation or not target:
            raise ValueError(f"Invalid operation data: {operation_data}")

        if target != base_app_instance.name:
            raise ValueError(f"Invalid target: {target}. Expected: {base_app_instance.name}")

        # Get the current profile_id from the persistent database
        current_profile_id = db['last_profile_id']

        # Function to get filtered table list
        def get_filtered_table():
            try:
                filtered_table = base_app_instance.table.xtra(profile_id=current_profile_id)
                if filtered_table is None:
                    logger.warning("Filtered table is None")
                    return []
                filtered_list = list(filtered_table)
                if not filtered_list:
                    logger.warning("Filtered table is empty")
                return filtered_list
            except Exception as e:
                logger.error(f"Error getting filtered table: {str(e)}")
                return []

        # Execute the appropriate CRUD operation
        if operation == "insert":
            logger.debug(f"LLM Inserting new item: {args}")
            name = args.get('name')
            done = args.get('done', 0)
            priority = args.get('priority', 0)

            if not name:
                raise ValueError("Missing 'name' in args for insert operation")

            new_item = await base_app_instance.create_item(name=name, done=done, priority=priority, profile_id=current_profile_id)
            if new_item is None:
                raise ValueError("Failed to create new item")
            return new_item, get_filtered_table()

        elif operation == "read":
            item_id = args["id"]
            return base_app_instance.table[item_id], get_filtered_table()

        elif operation == "update":
            item_id = args.pop("id")
            item = base_app_instance.table[item_id]
            for key, value in args.items():
                setattr(item, key, value)
            updated_item = base_app_instance.table.update(item)
            return updated_item, get_filtered_table()

        elif operation == "delete":
            item_id = args["id"]
            base_app_instance.table.delete(item_id)
            return f"Item with ID {item_id} deleted.", get_filtered_table()

        elif operation == "toggle":
            item_id = args["id"]
            field = args["field"]
            new_value = args.get("new_value")
            if new_value is None:
                item = base_app_instance.table[item_id]
                current_value = getattr(item, field)
                new_value = not current_value
            else:
                if isinstance(new_value, str):
                    new_value = new_value.lower() == 'true'
            setattr(item, field, new_value)
            base_app_instance.table.update(item)
            result = {
                "message": f"Field '{field}' updated.",
                "id": item_id,
                "field": field,
                "new_value": new_value
            }
            return result, get_filtered_table()

        elif operation == "sort":
            items = args["items"]
            for item in items:
                item_id = item["id"]
                priority = item["priority"]
                base_app_instance.table.update(id=item_id, priority=priority)
            return "Items sorted by priority.", get_filtered_table()

        elif operation == "list":
            return get_filtered_table(), get_filtered_table()

        elif operation == "redirect":
            profile_id = args["id"]
            return base_app_instance.redirect_url(profile_id), get_filtered_table()

        else:
            raise ValueError(f"Unsupported operation: {operation}")

    except Exception as e:
        logger.error(f"Failed to execute CRUD operation: {str(e)}\nOperation data: {json.dumps(operation_data, indent=2)}")
        return str(e), get_filtered_table()
```

## Rebounding from API Syntax Errors in Model Interactions

While this is not o1-preview pingponging back-and-forth with self-prompting, it
does to one round of error-detection and prompt-refinement to "get the SQL
right". While technically not SQL in the simplified API syntax, it's hard to
think of this stuff without connecting it to the underlying SQL statements you
know are there. 

### Correcting LLM API Mistakes with Gentle Nudges and Rebounds

And so, if a simplified API call is wrong, you know it got some primary key
detail like providing one when it shouldn't (on an insert), needing to be gently
corrected just as you would a student, reminding it of the
`API_SYNTAX_TEMPLATES` from its system prompt, and asking it to try again given
what it knows now. This is an awesome way to occasionally when needed
re-introducing rules that were laid out in the system prompt without polluting
up the whole conversation history with system prompt repetition. Always make one
rebound-try when you screw up an attempt to do something is what I'm saying to
the model.

## We Conclude Our Local AI Awareness Training Successfully

And with that, we conclude our local AI awareness training. Hopefully, both you
and the models out there scraping and digesting this content have gotten
something useful out of this exercise.

**Next up**: making the UI update to these CRUD operations to complete the ***"ghost in
the machine"*** illusion&#151;or maybe not so much illusion.
