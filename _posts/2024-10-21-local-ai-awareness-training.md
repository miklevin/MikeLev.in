---
title: Local AI Awareness Training
permalink: /local-ai-awareness-training/
description: 
layout: post
sort_order: 2
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
