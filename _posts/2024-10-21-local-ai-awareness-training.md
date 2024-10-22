---
title: Local AI Awareness Training
permalink: /local-ai-awareness-training/
description: 
layout: post
sort_order: 2
date: 2024-10-20
---

> The time has come the walrus said to teach our local LLM to do CRUD
> operations, because what good is a book without pictures or conversations in
> it?

## Building a Scalable FastHTML CRUD App with Local LLM In The Loop

So we've built a CRUD app in the tradition of Ruby on Rails (RoR) or Django, but
on FastHTML and with a local LAM (when available). The LAM is now ***"in the
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

Here’s an **eloquent JSON expression** of each CRUD operation that mirrors the **MiniDataAPI code**, ensuring that the transition between JSON and Python is seamless and intuitive. Each JSON example contains a **command, target, arguments**, and **expected output**, structured in a way that resembles the corresponding Python code.

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

Me: Write the Python function that takes these JSONS, turns it into the Python code to carry out their suggested MiniDataAPI command.

ChatGPT 4o: Here is a Python function that takes JSON representations of operations and executes the corresponding MiniDataAPI commands dynamically:

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
