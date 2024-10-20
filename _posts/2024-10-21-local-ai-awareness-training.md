---
title: Local AI Awareness Training
permalink: /local-ai-awareness-training/
description: 
layout: post
sort_order: 2
date: 2004-10-20
---

Me: Finalize the JSON Schema: Adjust it based on the specific needs and data
structures of your application. Implement Command Processing: Write a method to
receive JSON commands, validate them, and dispatch them to the appropriate
methods. Provide extremely clear and full code examples ready to copy/paste into
the app...

o1-preview: Certainly! Below, I'll guide you through finalizing the JSON schema based on your application and provide full code examples for implementing the command processing method. The code is designed to be directly integrated into your app.

---

## **1. Finalize the JSON Schema**

Based on your application's structure and data models (`TodoApp`, `ProfileApp`, etc.), we'll adjust the JSON schema to reflect the specific needs.

### **Adjusted JSON Schema**

```python
import jsonschema

COMMAND_SCHEMA = {
    "type": "object",
    "properties": {
        "action_type": {
            "type": "string",
            "enum": ["insert", "update", "delete", "toggle", "sort", "profile_switch"]
        },
        "table": {
            "type": "string",
            "enum": ["todo", "profile"]
        },
        "item_id": {"type": ["integer", "null"]},
        "details": {"type": ["object", "null"]}
    },
    "required": ["action_type", "table"]
}
```

- **`action_type`**: Specifies the action to perform.
- **`table`**: Indicates which table (`todo` or `profile`) the action applies to.
- **`item_id`**: The ID of the item (required for update, delete, toggle).
- **`details`**: Additional data needed for the action (e.g., fields for insert/update).

---

## **2. Implement Command Processing**

We'll create a method to receive JSON commands, validate them, and dispatch them to the appropriate methods.

### **Step-by-Step Implementation**

### **Step 1: Install `jsonschema` Library**

Ensure you have the `jsonschema` library installed:

```bash
pip install jsonschema
```

### **Step 2: Import Necessary Modules**

Add the following imports at the top of your script:

```python
import json
import jsonschema
from jsonschema import validate
```

### **Step 3: Define the JSON Schema**

Include the `COMMAND_SCHEMA` definition in your code:

```python
COMMAND_SCHEMA = {
    # (Schema as defined above)
}
```

### **Step 4: Implement the `process_command` Method**

Add the `process_command` method to your `BaseApp` class:

```python
class BaseApp:
    # Existing methods...

    async def process_command(self, command_json):
        """
        Process a JSON command: validate and dispatch it.
        """
        try:
            # Parse the JSON command
            command = json.loads(command_json)

            # Validate the command against the schema
            jsonschema.validate(instance=command, schema=COMMAND_SCHEMA)

            # Extract action details
            action_type = command.get('action_type')
            table_name = command.get('table')
            item_id = command.get('item_id')
            details = command.get('details', {})

            # Dispatch to the appropriate method
            if action_type == 'insert':
                await self.insert_item_from_command(table_name, details)
            elif action_type == 'update':
                await self.update_item_from_command(table_name, item_id, details)
            elif action_type == 'delete':
                await self.delete_item_from_command(table_name, item_id)
            elif action_type == 'toggle':
                await self.toggle_item_from_command(table_name, item_id)
            elif action_type == 'sort':
                await self.sort_items_from_command(table_name, details)
            elif action_type == 'profile_switch':
                await self.profile_switch_from_command(item_id)
            else:
                raise ValueError(f"Unsupported action_type: {action_type}")
        except jsonschema.exceptions.ValidationError as ve:
            logger.error(f"Command validation error: {ve}")
            # Handle validation error appropriately
        except Exception as e:
            logger.error(f"Error processing command: {e}")
            # Handle other errors
```

### **Step 5: Implement Dispatch Methods**

#### **Helper Method to Get Table by Name**

```python
def get_table_by_name(self, table_name):
    if table_name == 'todo':
        return todos
    elif table_name == 'profile':
        return profiles
    else:
        return None
```

#### **Insert Item from Command**

```python
async def insert_item_from_command(self, table_name, details):
    table = self.get_table_by_name(table_name)
    if not table:
        raise ValueError(f"Invalid table name: {table_name}")

    new_item_data = details
    new_item = table.insert(new_item_data)
    logger.debug(f"Inserted new item into {table_name}: {new_item}")
```

#### **Update Item from Command**

```python
async def update_item_from_command(self, table_name, item_id, details):
    table = self.get_table_by_name(table_name)
    if not table or not item_id:
        raise ValueError("Invalid table name or missing item_id")

    item = table[item_id]
    for key, value in details.items():
        setattr(item, key, value)
    updated_item = table.update(item)
    logger.debug(f"Updated item {item_id} in {table_name}: {updated_item}")
```

#### **Delete Item from Command**

```python
async def delete_item_from_command(self, table_name, item_id):
    table = self.get_table_by_name(table_name)
    if not table or not item_id:
        raise ValueError("Invalid table name or missing item_id")

    table.delete(item_id)
    logger.debug(f"Deleted item {item_id} from {table_name}")
```

#### **Toggle Item from Command**

```python
async def toggle_item_from_command(self, table_name, item_id):
    table = self.get_table_by_name(table_name)
    if not table or not item_id:
        raise ValueError("Invalid table name or missing item_id")

    item = table[item_id]
    toggle_field = 'done' if table_name == 'todo' else 'active'
    current_status = getattr(item, toggle_field)
    setattr(item, toggle_field, not current_status)
    updated_item = table.update(item)
    logger.debug(f"Toggled {toggle_field} for item {item_id} in {table_name}")
```

#### **Sort Items from Command**

```python
async def sort_items_from_command(self, table_name, details):
    table = self.get_table_by_name(table_name)
    if not table:
        raise ValueError(f"Invalid table name: {table_name}")

    sort_field = 'priority'
    items = details.get('items', [])
    for item in items:
        item_id = item.get('id')
        priority = item.get('priority')
        table.update(id=item_id, **{sort_field: priority})
    logger.debug(f"Sorted items in {table_name}")
```

#### **Profile Switch from Command**

```python
async def profile_switch_from_command(self, item_id):
    if not item_id:
        raise ValueError("Missing item_id for profile switch")

    db["last_profile_id"] = item_id
    logger.debug(f"Switched to profile {item_id}")
```

### **Step 6: Integrate Command Processing**

Modify your WebSocket handler to include command processing:

```python
@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    try:
        conn_id = getattr(ws, 'conn_id', str(uuid4()))
        ws.conn_id = conn_id

        # Try to parse the message as JSON command
        try:
            json.loads(msg)
            # If valid JSON, process as command
            await base_app.process_command(msg)
        except json.JSONDecodeError:
            # If not JSON, treat as chat message
            await chatq(msg)
    except WebSocketDisconnect:
        logger.debug(f"WebSocket disconnected for connection {conn_id}")
        conversation_histories.pop(conn_id, None)
    except Exception as e:
        logger.error(f"Error in WebSocket handler: {str(e)}")
```

**Note**: Replace `base_app` with your actual `BaseApp` instance.

---

## **Full Code Examples**

### **Add Imports**

At the top of your script:

```python
import json
import jsonschema
from jsonschema import validate
```

### **Define the JSON Schema**

```python
COMMAND_SCHEMA = {
    "type": "object",
    "properties": {
        "action_type": {
            "type": "string",
            "enum": ["insert", "update", "delete", "toggle", "sort", "profile_switch"]
        },
        "table": {
            "type": "string",
            "enum": ["todo", "profile"]
        },
        "item_id": {"type": ["integer", "null"]},
        "details": {"type": ["object", "null"]}
    },
    "required": ["action_type", "table"]
}
```

### **Implement Command Processing in `BaseApp`**

```python
class BaseApp:
    # Existing methods...

    async def process_command(self, command_json):
        """
        Process a JSON command: validate and dispatch it.
        """
        try:
            command = json.loads(command_json)
            jsonschema.validate(instance=command, schema=COMMAND_SCHEMA)

            action_type = command.get('action_type')
            table_name = command.get('table')
            item_id = command.get('item_id')
            details = command.get('details', {})

            if action_type == 'insert':
                await self.insert_item_from_command(table_name, details)
            elif action_type == 'update':
                await self.update_item_from_command(table_name, item_id, details)
            elif action_type == 'delete':
                await self.delete_item_from_command(table_name, item_id)
            elif action_type == 'toggle':
                await self.toggle_item_from_command(table_name, item_id)
            elif action_type == 'sort':
                await self.sort_items_from_command(table_name, details)
            elif action_type == 'profile_switch':
                await self.profile_switch_from_command(item_id)
            else:
                raise ValueError(f"Unsupported action_type: {action_type}")
        except jsonschema.exceptions.ValidationError as ve:
            logger.error(f"Command validation error: {ve}")
        except Exception as e:
            logger.error(f"Error processing command: {e}")

    # Helper method to get the correct table
    def get_table_by_name(self, table_name):
        if table_name == 'todo':
            return todos
        elif table_name == 'profile':
            return profiles
        else:
            return None

    # Implement all dispatch methods as shown earlier
    # insert_item_from_command, update_item_from_command, etc.
```

### **Implement Dispatch Methods**

**Insert Item from Command**

```python
async def insert_item_from_command(self, table_name, details):
    table = self.get_table_by_name(table_name)
    if not table:
        raise ValueError(f"Invalid table name: {table_name}")

    # Prepare insert data based on table
    if table_name == 'todo':
        new_item_data = {
            "name": details.get("name", "").strip(),
            "done": details.get("done", False),
            "priority": details.get("priority", 0),
            "profile_id": db.get("last_profile_id", 1),
        }
    elif table_name == 'profile':
        new_item_data = {
            "name": details.get("name", "").strip(),
            "address": details.get("address", ""),
            "code": details.get("code", ""),
            "active": details.get("active", True),
            "priority": details.get("priority", 0),
        }
    else:
        new_item_data = details

    new_item = table.insert(new_item_data)
    logger.debug(f"Inserted new item into {table_name}: {new_item}")
```

**Update Item from Command**

```python
async def update_item_from_command(self, table_name, item_id, details):
    table = self.get_table_by_name(table_name)
    if not table or not item_id:
        raise ValueError("Invalid table name or missing item_id")

    item = table[item_id]
    for key, value in details.items():
        setattr(item, key, value)
    updated_item = table.update(item)
    logger.debug(f"Updated item {item_id} in {table_name}: {updated_item}")
```

**Delete Item from Command**

```python
async def delete_item_from_command(self, table_name, item_id):
    table = self.get_table_by_name(table_name)
    if not table or not item_id:
        raise ValueError("Invalid table name or missing item_id")

    table.delete(item_id)
    logger.debug(f"Deleted item {item_id} from {table_name}")
```

**Toggle Item from Command**

```python
async def toggle_item_from_command(self, table_name, item_id):
    table = self.get_table_by_name(table_name)
    if not table or not item_id:
        raise ValueError("Invalid table name or missing item_id")

    item = table[item_id]
    toggle_field = 'done' if table_name == 'todo' else 'active'
    current_status = getattr(item, toggle_field)
    setattr(item, toggle_field, not current_status)
    updated_item = table.update(item)
    logger.debug(f"Toggled {toggle_field} for item {item_id} in {table_name}")
```

**Sort Items from Command**

```python
async def sort_items_from_command(self, table_name, details):
    table = self.get_table_by_name(table_name)
    if not table:
        raise ValueError(f"Invalid table name: {table_name}")

    sort_field = 'priority'
    items = details.get('items', [])
    for item in items:
        item_id = item.get('id')
        priority = item.get('priority')
        table.update(id=item_id, **{sort_field: priority})
    logger.debug(f"Sorted items in {table_name}")
```

**Profile Switch from Command**

```python
async def profile_switch_from_command(self, item_id):
    if not item_id:
        raise ValueError("Missing item_id for profile switch")

    db["last_profile_id"] = item_id
    logger.debug(f"Switched to profile {item_id}")
```

### **Modify WebSocket Handler**

Ensure your WebSocket handler can process JSON commands:

```python
@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    try:
        conn_id = getattr(ws, 'conn_id', str(uuid4()))
        ws.conn_id = conn_id

        # Try to parse the message as JSON command
        try:
            json.loads(msg)
            # If valid JSON, process as command
            await base_app.process_command(msg)
        except json.JSONDecodeError:
            # If not JSON, treat as chat message
            await chatq(msg)
    except WebSocketDisconnect:
        logger.debug(f"WebSocket disconnected for connection {conn_id}")
        conversation_histories.pop(conn_id, None)
    except Exception as e:
        logger.error(f"Error in WebSocket handler: {str(e)}")
```

---

## **3. Example Usage**

### **Sending a Command**

**Insert a New Todo Item**

```json
{
  "action_type": "insert",
  "table": "todo",
  "details": {
    "name": "Buy milk",
    "done": false,
    "priority": 1
  }
}
```

**Update a Profile**

```json
{
  "action_type": "update",
  "table": "profile",
  "item_id": 2,
  "details": {
    "name": "John Doe",
    "address": "123 Main St",
    "code": "US"
  }
}
```

**Delete a Todo Item**

```json
{
  "action_type": "delete",
  "table": "todo",
  "item_id": 5
}
```

---

## **Additional Notes**

- **Error Handling**: Ensure you handle exceptions appropriately, possibly sending error messages back to the client.
- **Security**: Validate and sanitize all inputs to prevent injection attacks.
- **Feedback**: Optionally, send responses back to the client confirming actions.

---

By integrating the above code into your application, you now have a robust system for processing JSON commands. The code is designed to be clear, modular, and ready for direct use in your app.

Feel free to copy and paste the provided code, and adjust as necessary to fit your application's specific architecture and requirements. If you have any questions or need further clarification on any part, don't hesitate to ask!
