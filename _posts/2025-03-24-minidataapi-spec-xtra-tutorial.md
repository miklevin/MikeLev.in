---
title: MiniDataAPI Spec `.xtra()` Tutorial
permalink: /futureproof/minidataapi-spec-xtra-tutorial/
description: "This piece walks you through the essentials of MiniDataAPI, a super simple Python API for basic database operations. I explained how it focuses on Create, Read, Update, and Delete (CRUD) actions without the complexity of joins or fancy query building you might find in bigger ORMs. The tutorial shows you how to set up a table, insert data, retrieve specific records or lists using different methods, update existing entries, and delete them. I also highlighted a cool feature called `.xtra()` which lets you permanently filter a table for things like multi-tenant applications or permission control, making sure you only see the data you're supposed to. The key takeaway is that MiniDataAPI is all about simplicity for straightforward data tasks, so don't go looking for those advanced ORM features here!"
meta_description: Master MiniDataAPI's .xtra() method for simple, lightweight CRUD operations in Python. This tutorial explains permanent filtering and permission scoping.
meta_keywords: MiniDataAPI, .xtra(), CRUD, Python database, lightweight API, permanent filtering, permission scoping, minimal ORM, simple CRUD, database tutorial
layout: post
sort_order: 1
---

Yes, this article was made as a result of AI research, ChatGPT o3-mini-high Deep
Research, in particular (credit where it's due). But I immediately needed it to
override Grok3's over-training on SQLAlchemy and complex ORMs! So I slammed this
out and used it a prompt you will find in the following article. I plan on using
this, and distilled down variations of this again and again as I wrangle LLM
over-training on SQLAlchemy, and getting it to comply with the FastHTML way.

Unfortunately, even with this super-prompt teaching Grok3 all the nuances of
MiniDataAPI Spec, it didn't nail the bug fix. I'm going to have to put down the
AI and do it the old fashioned way.

[You gotta put down the AI if you wanna keep control of your code.](https://www.youtube.com/watch?v=acBixR_JRuM)

## MiniDataAPI Spec Documentation Overview

**What is MiniDataAPI?**  
MiniDataAPI is a minimal database persistence API designed for simple, cross-database CRUD operations (Create, Read, Update, Delete) ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=The%20specification%20is%20designed%20to,joins%20are%20out%20of%20scope)). It provides a unified way to interact with different back-end datastores (SQL or NoSQL) through the same Python API ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=The%20,stores%2C%20document%20databases%2C%20and%20more)). Unlike full-fledged ORMs (Object-Relational Mappers) or SQL query builders, MiniDataAPI intentionally keeps its feature set very small: **no joins, no foreign keys, and no complex query chaining** ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=,will%20need%20more%20sophisticated%20tools)) ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=This%20means%20the%20specification%20does,or%20even%20direct%20database%20queries)). This means it does **not** support advanced patterns you might know from ORMs like SQLAlchemy or Django. **Do not use** methods like `.filter()` or `.where()` – those **do not exist** in MiniDataAPI and attempting to use them will result in errors (these are ORM patterns, not supported here). MiniDataAPI’s simplicity is by design, making it easy to learn and implement, but it’s only suited for simple data models ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=,will%20need%20more%20sophisticated%20tools)). Complex relational logic should be handled in application code or by using a more powerful database tool when needed ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=This%20means%20the%20specification%20does,or%20even%20direct%20database%20queries)).

**Core API Methods:** MiniDataAPI revolves around a few core methods on table objects (after you’ve connected to a database and created a table). Once you have a table (say `t`), you can: ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=,%60t.xtra))

- **`t.insert(...)`** – Insert a new record into the table. Accepts either an instance of a data class/model, a dictionary of field values, or keyword arguments. It returns the newly created record as an object ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=Add%20a%20new%20record%20to,instance%20of%20the%20new%20record)). (This is the “Create” in CRUD.)  
- **`t[key]` (Square Bracket Lookup)** – Retrieve a single record by its primary key using square bracket indexing ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=Get%20a%20single%20record%20by,if%20we%20can%20find%20Alma)). For example, `user = users['Alice']` or `todo = todos[1]`. If the given key isn’t found, a `NotFoundError` is raised (you should handle this in your code). This provides a quick way to get one specific record by ID or primary key.  
- **`t(...)` (Parentheses Query)** – Retrieve records with a query. Calling a table like a function returns *zero or more records*. An empty call `t()` returns **all records** in the table ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=Parentheses%20search%20)). You can also pass filtering and sorting parameters here. For example, `users(order_by='name')` returns all users sorted by name ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=We%20can%20order%20the%20results)). You can filter results by providing a SQL-like condition string via a `where` argument, e.g. `users(where="name='Alice'")` ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=We%20can%20filter%20on%20the,results)), which returns a list of matching records. (It’s safer to use placeholders to avoid SQL injection, e.g. `users("name=?", ('Alice',))` as shown in the spec ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=)).) You can also limit results with `limit=` and `offset=` parameters ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=We%20can%20limit%20results%20with,keyword)). This functional-call style is the main way to do reads (the “Read” in CRUD) beyond single primary-key lookups.  
- **`t.update(...)`** – Update an existing record in the table. You provide the updated data (as a model instance, dict, or kwargs), and **the record’s primary key is used to find which record to update** ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=)) ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=John%20hasn%E2%80%99t%20started%20with%20us,yet%20to%20travel%20in%20time)). Only that record’s fields will be changed. It returns the updated record object ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=)). If no record with that primary key exists, a `NotFoundError` is raised. (This is the “Update” in CRUD.)  
- **`t.delete(key)`** – Delete a record from the table, identified by its primary key ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=)). For example, `todos.delete(3)` would remove the record with primary key 3. It returns the table object itself (so you can chain another operation if needed) ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=)). If the key isn’t found, a `NotFoundError` is raised ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=If%20the%20primary%20key%20value,NotFoundError)). (This is the “Delete” in CRUD.)  
- **`t.xtra(**filters)`** – *Extra filtering* method for permission scoping or multi-tenant data. This is a unique feature of MiniDataAPI that **permanently filters** the table object based on given field criteria ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=If%20we%20set%20fields%20within,for%20a%20particular%20table%20object)). After you call `t.xtra(field=value)`, **all subsequent operations on that table are transparently filtered** to only include records where `field == value` ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=If%20we%20set%20fields%20within,for%20a%20particular%20table%20object)). Use this to restrict what data can be seen or modified – for example, limit a `todos` table to only a specific user’s todos. **Important:** `.xtra()` is a one-way switch – once you apply a filter to a table object, you cannot remove it on that same object ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=for%20record%20creation,for%20a%20particular%20table%20object)). It affects every method (reads, updates, deletes, and even membership checks with `in`) going forward, except it does not interfere with inserting new records ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=If%20we%20set%20fields%20within,for%20a%20particular%20table%20object)). In short, `.xtra()` acts like an *internal WHERE clause* that’s automatically applied to the table. This makes it easy to implement permission scopes (e.g. an assistant can ensure it only ever accesses data belonging to a certain user or context). If you need to query without that filter again, you’d have to use a fresh table object (e.g. create or obtain the table anew without calling `.xtra`). Use `.xtra()` **only when appropriate** – typically at the start of a request or conversation context to constrain the data, not for ad-hoc querying.  

**Summary:** MiniDataAPI supports basic CRUD operations on a single table at a time, emphasizing simplicity and consistency across different databases ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=The%20specification%20is%20designed%20to,joins%20are%20out%20of%20scope)). You should use the above core methods to manipulate data. **Do not attempt ORM-like method chaining or complex queries** – for example, no joining tables or using model attributes in queries, as those are not supported ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=,will%20need%20more%20sophisticated%20tools)). By sticking to these methods, you can reliably interact with the database. Keep in mind `.xtra()` for cases where you must enforce that only certain records are visible (such as scoping data to a specific user or tenant). Next, we’ll walk through practical examples to solidify these concepts.

## Practical Tutorial with Examples

Let's put the MiniDataAPI into practice with a simple scenario. Suppose we are managing a to-do list for multiple users. We’ll create a `Todo` table and walk through common operations step by step. (In a real setup, we would first initialize a database connection and define our data model classes.)

### Setting up a Table and Data

First, define a data model (like a dataclass) and create a table from it. In MiniDataAPI, you use `db.create(ModelClass, pk=<primary_key_field>)` to create a table. For our example, we’ll have a `Todo` class with fields for an ID, title, status, and an owner name:

```python
from dataclasses import dataclass

@dataclass
class Todo:
    id: int       # primary key
    title: str
    status: str
    name: str     # name of the user who owns this todo

# Assume we have a MiniDataAPI database object `db` already connected (e.g., SQLite in-memory).
todos = db.create(Todo, pk='id')  # Create a 'todos' table with primary key 'id'
```

Now we can insert some records into our `todos` table using `.insert()`. We’ll add a few to-do items, each associated with a different user (via the `name` field):

```python
# Inserting new Todo records (Create)
todos.insert(title="Write MiniDataAPI spec", status="open", name="Braden")
todos.insert(title="Implement SSE in FastHTML", status="open", name="Alma")
todos.insert(title="Finish development of FastHTML", status="closed", name="Charlie")
```

Each call to `todos.insert(...)` adds a new record and returns the created `Todo` object. We didn’t explicitly provide an `id` for these, assuming the underlying database auto-generates numeric IDs. After these inserts, our table has three todos:

- **Todo 1** – title: "Write MiniDataAPI spec", status: open, name: Braden  
- **Todo 2** – title: "Implement SSE in FastHTML", status: open, name: Alma  
- **Todo 3** – title: "Finish development of FastHTML", status: closed, name: Charlie  

*(The returned objects would look like `Todo(id=1, title='Write MiniDataAPI spec', ... )` etc.)*

### Reading Records

To retrieve records, we have two primary ways: by primary key (square brackets) or by querying (parentheses call).

- **Get by ID**: Use square brackets `todos[<id>]` to get a single record by its primary key. For example, to fetch the todo with ID 2 (Alma’s task):

  ```python
  todo2 = todos[2]
  print(todo2.title, "–", todo2.name)  
  # Output: Implement SSE in FastHTML – Alma
  ```

  Here, `todos[2]` returned the `Todo` object with `id=2`. If we try an ID that doesn’t exist, MiniDataAPI will raise a `NotFoundError`, so you might wrap the call in a try/except if you’re not sure the record exists.

- **Get multiple or all records**: Call the table as a function, `todos(...)`, to run a query. With no arguments, `todos()` returns *all* records in the table as a list:

  ```python
  all_todos = todos()
  for t in all_todos:
      print(f"{t.id}: {t.title} (owner: {t.name})")
  # This will list all three todos (IDs 1, 2, 3 with their titles and owners).
  ```

  You can also filter or sort this query. For example, to get only the open tasks, you might do: 

  ```python
  open_tasks = todos(where="status='open'")
  # returns the list of Todo objects where status is 'open' (Braden’s and Alma’s tasks in this case)
  ```

  Or to sort the results alphabetically by title: 

  ```python
  todos_sorted = todos(order_by='title')
  ```

  In general, the `todos(...)` call can accept parameters like `where`, `order_by`, `limit`, and `offset` to refine results. If you have raw SQL knowledge, you can use a `where` string directly (as shown above), but be cautious about SQL injection – use parameter substitution if the value comes from outside. For simple use cases or known values, direct `where="field='value'"` is fine.

### Updating a Record

To update an existing record, use `todos.update(...)`. Provide the new data (including the primary key so it knows which record to modify). For example, let’s say Alma’s task (ID 2) was completed, we can update its status:

```python
# Updating a record (Update)
todos.update(id=2, status="closed", name="Alma")
```

In this call, we passed `id=2` along with the fields we want to change (`status`). The `name` field is included here to satisfy the requirement of identifying the record (in this case the primary key is `id`, but including `name` doesn’t hurt since the record with id 2 will be updated). The `.update()` method finds the record with `id == 2` and updates its status to "closed". It returns the updated `Todo` object. After this, if we retrieve `todos[2]` again, its `status` should now be "closed".

*(If we tried to update a record that doesn’t exist (e.g., `todos.update(id=99, title="...?")`), it would raise `NotFoundError`. Always ensure the record exists or handle the exception.)*

### Deleting a Record

To remove a record, use `todos.delete(primary_key)`. If Charlie decides his task (ID 3) is no longer needed, we can delete it:

```python
# Deleting a record (Delete)
todos.delete(3)
```

This call will remove the record with `id=3` (Charlie’s todo) from the table. After deletion, if we call `todos()` again, that record will no longer appear. The `.delete()` method returns the table object itself, but typically you don’t need to capture it; you can just call `todos.delete(3)` on its own. 

*(As with update, if the ID isn’t found, a `NotFoundError` is raised. Deleting by a compound key would require passing the full key, e.g., a tuple or list of key values.)*

### Using `.xtra()` for Permission-Scoped Filtering

Now let’s explore the **`.xtra()`** method – a powerful feature for scoping what data the table will show. Imagine that after inserting the three todos above, we want to restrict the view to only Charlie’s items. In a multi-user application, you might do this to ensure each user (or each assistant session) only sees their own records. 

We can call `todos.xtra(name="Charlie")` to **permanently filter** the `todos` table to records where `name == "Charlie"` ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=If%20we%20set%20fields%20within,for%20a%20particular%20table%20object)). 

```python
# Apply an extra filter to scope to Charlie's todos
todos.xtra(name="Charlie")
```

After this, any query on `todos` will automatically include `name='Charlie'` as a condition. For example:

```python
visible_todos = todos()
print(visible_todos)
# Output will only include Todo items where name == 'Charlie'.
```

Originally we had three todos (Braden’s, Alma’s, and Charlie’s). But after `todos.xtra(name="Charlie")`, `todos()` will now return **only Charlie’s todo(s)**. In our case, that would be the one with `id=3` (assuming it wasn’t deleted yet). The other records are essentially hidden from this `todos` object. If we try to access a record not owned by Charlie, it will behave as if it doesn’t exist (e.g., `todos[1]` would raise NotFoundError now, because the table is scoped to Charlie). This demonstrates how `.xtra()` helps with permission scoping – we’ve constrained the table to a subset of data, and we cannot accidentally read or write outside that subset ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=for%20record%20creation,for%20a%20particular%20table%20object)).

It’s important to note a few things about `.xtra()` usage:

- **One-way filtering:** Once you call `todos.xtra(name="Charlie")` on this table instance, you cannot remove or override that filter on the same instance ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=for%20record%20creation,for%20a%20particular%20table%20object)). The table is now locked to `name="Charlie"`. If you needed to access unfiltered data again, you would have to use a new table object (e.g., perhaps by reconnecting or having another reference without `.xtra` applied). Plan accordingly: usually, you call `.xtra` at the start of a context where you want restricted access (like at the beginning of handling a user’s request or a conversation), and then use the filtered table for all operations in that context. 
- **All operations are affected:** The filter set by `.xtra` is applied to **reads, updates, deletes, and even membership checks** (`in` operator) on that table ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=If%20we%20set%20fields%20within,for%20a%20particular%20table%20object)) ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=If%20we%20try%20,with%20a%20name%20of%20Charlie)). The only exception is inserting new records: you can still insert new records, and MiniDataAPI will automatically set the filtered fields for you on the new record ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=,status%2C%20name)). For instance, if we call `todos.insert(title="New Task", status="open", name="Charlie")` after the `.xtra` above, it will insert a Charlie task (and if we mistakenly provided a different name, it would likely override it to Charlie or enforce that Charlie is used). This behavior ensures that all data visible through this `todos` is consistently scoped.
- **When to use `.xtra()`:** Use it when you need to enforce that *only certain records* can be accessed by the code that follows. A common real-world scenario is permission scoping: e.g., if a coding assistant LLM should only work with data belonging to a specific user, the system could apply `.xtra(user_id=<that user>)` on relevant tables at initialization. After that, even if the LLM tries to fetch or modify data, it physically cannot escape the filter to another user’s data. This adds a layer of safety. If you don't need such a restriction, you can simply not use `.xtra()` and query/filter data manually using the parentheses calls.

### Common Mistakes to Avoid

Finally, let’s highlight some **incorrect usage patterns** and their correct alternatives:

- **Avoid ORM-style chaining:** MiniDataAPI is **not** SQLAlchemy or Django ORM. You **cannot** do things like `todos.filter(...)` or `todos.where(...)` as method calls. For example, the following code is **incorrect** and will error out:

  ```python
  # ❌ Incorrect usage – these methods don't exist in MiniDataAPI
  todos.filter(name="Charlie")         # AttributeError: 'Table' object has no attribute 'filter'
  todos.where(Todo.name == "Charlie")  # This ORM-like syntax is not supported
  ```

  In MiniDataAPI, filtering is done either by using the `where` parameter in a parentheses call (e.g. `todos(where="name='Charlie')`) or by using `.xtra()` as shown above. There is no separate `.filter()` method to chain. Always use the provided API methods.

- **Don’t attempt joins or foreign-key lookups in queries:** If you find yourself wanting to do something like `tasks_of_friends = todos(where="user_id IN (SELECT friend_id FROM ...)")`, remember that MiniDataAPI is not built for that. You would instead have to fetch the data in two steps (e.g., get friend IDs from one table, then use those to filter records in another) or rely on a different tool. MiniDataAPI tables deal with one table at a time only. Complex logic needs to be handled in Python code or not at all if it’s beyond simple filtering.

- **Forgetting `.xtra()` in multi-user context:** If you intend to limit data by user or context, make sure to call `.xtra()` **before** performing queries/updates. Conversely, if you call `.xtra()` when you didn’t mean to, you might wonder why you can’t find certain records – remember to only apply it when needed.

By keeping these points in mind, you can avoid common pitfalls. MiniDataAPI’s strength is in its simplicity: stick to basic CRUD methods and use `.xtra` for scoping, and you’ll find it straightforward to work with. It may feel a bit lower-level than an ORM, but it offers clarity and predictability. Happy coding with MiniDataAPI! ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=The%20specification%20is%20designed%20to,joins%20are%20out%20of%20scope)) ([MiniDataAPI Spec – fasthtml](https://answerdotai.github.io/fasthtml/explains/minidataapi.html#:~:text=,will%20need%20more%20sophisticated%20tools))

---

## An AI's Take

Here are a few ideas for titles and headlines:

**Titles:**

1.  MiniDataAPI `.xtra()` Explained: A Practical Tutorial
2.  Getting Started with MiniDataAPI: A Hands-On Guide
3.  Simple Database Operations with MiniDataAPI: The `.xtra()` Feature in Detail

**Headlines:**

1.  Unlock Basic Database CRUD with Python's MiniDataAPI: Learn the Power of `.xtra()`!
2.  Ditch the Complex ORM: A Beginner's Guide to MiniDataAPI and Its Unique Filtering
3.  Master MiniDataAPI's Core Features: Insert, Read, Update, Delete, and the Essential `.xtra()`

I think this article is super helpful for anyone looking for a lightweight way to handle basic database interactions in Python! It clearly explains the core concepts of MiniDataAPI and provides practical examples that make it easy to understand. I especially like the focus on the `.xtra()` feature, as it introduces a neat way to manage data access in certain scenarios. The author does a great job of setting expectations by clearly stating what MiniDataAPI can and cannot do, which is really important for developers choosing the right tools for their projects. It definitely seems like a great option for simpler applications where you don't need all the bells and whistles of a full-fledged ORM!
