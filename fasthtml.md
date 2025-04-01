---
title: FastHTML is not FastAPI
description: 
author: Mike Levin AI SEO
permalink: /fasthtml/
group: home
---

# FastHTML is not FastAPI

## FastHTML Examples

> FastHTML and FastAPI are two very different things. One fits your vibe and the
> doesn't. I can't tell you which is which, but I can show you. At least, I can
> show you FastHTML. Examples for FastAPI abound elsewhere.

I know you're curious about FastHTML databases. Here's how they work:

```python
app, rt, users, User = fast_app('folder/filename.db', users=dict(username=str))
```

## Understanding the MiniDataAPI Spec

In short, [MiniDataAPI spec](/futureproof/minidataapi-spec-xtra-tutorial/), a
database API made specifically for FastHTML, is being used through the
`fast_app()` convenience wrapper. `fast_app` always returns the *flask-like*
webserver connection object `app` first and the shortcut for `app.route()`
second. The returned `users` object is a MiniDataAPI database table with methods
like `.insert()` and `.delete()`, and `User` is a `dataclass()` description of a
single record used for hinting and validation. That's it. There's no special
setup. A whole table schema can go as a Python `dict` where `dict(username=str)`
appears. That's databases in FastHTML.

## Going Beyond the Basics

Yes, of course it goes deeper like how to set up more tables, or how to do this
without the helper-class, or why use such a simple database API when you could
be using SQLAlchemy and PostgreSQL. The short answer is that it's all rigged to
"just work", leaning into powerful defaults that leverage the fact that SQLlite
is always there. If you want more, you just go past the defaults and make it as
powerful as you like.

I'll address these questions and more throughout the site, but I know many of you are here because you're trying to understand what makes FastHTML different from FastAPI. It's a common source of confusion - even Large Language Models struggle to tell them apart!

### Building from Flask's Foundation

So below, I build the explanation up from Flask because FastHTML looks a lot
like Flask, but isn't. Fast***HTML*** starts where Flask left off, but goes in a
different direction than Fast***API*** -- elevating Python to a 1st-class web
development platform for the first time. Python might even be a better choice
for web development now than JavaScript.

If you're not interested in the history lesson and are just here for the
FastHTML examples, then scroll down!

## The Flask Foundation

Flask is a Python microframework that has profoundly influenced web development since its release in April 2010. Created by Armin Ronacher as part of the Pocoo project, Flask began as an April Fool's joke but quickly gained widespread adoption due to its elegant simplicity and flexibility. While inspired by Ruby's Sinatra framework (which itself was a response to Rails' complexity), Flask brought these minimalist principles to Python, building on earlier microframeworks like `itty` and `bottle.py`.

What set Flask apart was its thoughtful balance between minimalism and functionality. While other microframeworks like itty and bottle were extremely bare-bones, Flask provided just enough structure through the Werkzeug WSGI toolkit and Jinja2 templating engine (both also from the Pocoo team) without imposing unnecessary constraints. This "batteries included but removable" philosophy proved to be exactly what developers needed.

The way Flask creates an `app` object became so influential that you'll see its echo in many modern frameworks, including FastHTML as shown in the example above. This simple but powerful pattern demonstrates Flask's lasting impact on Python web development.

```python
from flask import flask

app = flask(__name__)
```

Flask popularized a key innovation: the use of Python decorators for routing web
requests to specific functions. Instead of maintaining a separate routing table,
developers could simply add a `@route` decorator above any function to specify
which URL path should trigger that function. This elegant approach made the
connection between URLs and their handling functions immediately clear in the
code.

Here's a simple example:

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello, World!"
```

Since its debut, Flask has set a standard for Python web frameworks, inspiring
many others to follow its lightweight and extensible approach. Frameworks like
CherryPy and Pylons have integrated similar routing mechanisms while adding
their unique spins. FastAPI, for example, builds on Flask's decorator-based
routing but enhances it with asynchronous capabilities and type validation using
Python type hints.

You can see Flask's influence on frameworks such as FastAPI, which create an
`app` object in a very similar way.

```python
from fastapi import FastAPI

app = FastAPI()
```


## The Rise of FastAPI (Flask for the Enterprise)

FastAPI's rise to popularity can be traced through a series of key developments
in Python and web frameworks:

1. Python introduced asynchronous support with the async/await keywords in
   version 3.5, released in 2015.
2. The Asynchronous Server Gateway Interface (ASGI) was developed as an upgrade
   to the Web Server Gateway Interface (WSGI) to support asynchronous Python web
   applications.
3. FastAPI was created and released in 2018, built on ASGI and supporting
   asynchronous programming out of the box.
4. FastAPI required the use of Python's static typing option, MyPy, which was
   first released in 2012 but gained significant traction in the following
   years.
5. FastAPI has become a popular choice for building high-performance, scalable
   web applications, particularly in fields like fintech where real-time data
   processing is crucial.

### Performance Through Modern Features

The combination of asynchronous support, ASGI compatibility, and static typing
allowed FastAPI to offer significant performance improvements over Flask, which
was slower to adopt these new technologies. This timing and feature set
positioned FastAPI as a modern, efficient alternative to Flask, especially for
applications requiring high concurrency and I/O-heavy operations.

### A Different Path with FastHTML

While FastAPI addresses important performance needs, its approach doesn't align
with my vision for web development. The requirement for optional static typing,
in particular, diverges from my preferred style. Simply adding asynchronous
capabilities to Flask wouldn't have been sufficient to reignite my interest in
web development. Instead, my goal is to strip away complexity and move towards
greater simplicity. Rather than layering on additional features, I aim to
distill web development to its essence while still being Python. I hungered for
a framework that embodies simplicity and ease of use without sacrificing
functionality.

## The Radical Simplicity of FastHTML (Flask for the Webmaster)

Enter FastHTML, a framework that rethinks Python web development while still
being Fask-ish by stripping away everything extra, reducing cognitive overhead
by making just one place to look and one language to learn. Here's how FastHTML
achieves this:

### Eliminating the Need for Templating Languages

FastHTML does away with traditional templating languages, allowing developers to
work directly with Python objects to generate HTML. This approach simplifies the
development process by removing the need to learn and use a separate templating
syntax. Instead, developers can leverage their existing Python knowledge to
create dynamic web content.

#### FastAPI Example *(the ugly way we're doing away with)*

Jinja templates or equivalent are required for FastAPI. Here's how it works:

1. You create regular HTML files in a "templates" directory *(cognitive overhead)*.
2. In these HTML files, you can use Jinja2 syntax for dynamic content *(mixed context)*. For example:

```html
{% raw %}<html>
<head>
    <title>Item Details</title>
    <link href="{{ url_for('static', path='/styles.css') }}" rel="stylesheet">
</head>
<body>
    <h1><a href="{{ url_for('read_item', id=id) }}">Item ID: {{ id }}</a></h1>
</body>
</html>{% endraw %}
```

Now, we're up to ***three*** languages, all mishmashed together.

{:start="3"}
3. In your FastAPI application, you set up Jinja2Templates (more noise) and use it to render these templates:

```python
from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates

app = FastAPI()
templates = Jinja2Templates(directory="templates")

@app.get("/items/{id}")
async def read_item(request: Request, id: str):
    return templates.TemplateResponse("item.html", {"request": request, "id": id})
```

And you're going to need JavaScript and CSS, making languages 4 and 5. It's no
wonder so many people throw up their arms and say "just use JavaScript!"

The Flask/FastAPI claim is that this approach allows you to separate your HTML
presentation from your Python logic, making your code more maintainable and
easier to understand. But yuck! So first you have one file. Then you have a
second file, which is sort of HTML. But it's actually yet another language
blended in in mixed context. The cognative overhead between the directory-diving
and the language-mixing is off the charts. No thanks.

You weigh this against hopping on the JavaScript bandwagon, where you get
one-language-to-rule them all: JavaScript client-side and server-side using
NodeJS. Then you get the super-optimized performance of Web Assembly (WASM) and
the all the developer tools pushed by Google and Microsoft geared towards
JavaScript! The strongest argument for Python as a web development platform
prior to FastHTML was that people just love using Python.

Well, what if I told you that there is a better way? What if I told you with one
light little magic trick, Python is not merely as good for Web development as
JavaScript, but better?

FastHTML has no templates. FastHTML has no mixed context. There's no directory
diving. And even though JavaScript and CSS are really still in the picture, you
almost never have to look at it. So what does this miracle spin on webdev in
Python look like?

#### FastHTML Example

```python
from fasthtml.common import *
app, rt = fast_app()

@rt('/')
def get():
    return Div(
        H1("Hello, World!"),
        P("This is a simple page.")
    )

serve()
```

That's it. As an added bonus, I made it a complete program throwing in
`serve()`, hahaha! What's more, unlike traditional frameworks, FastHTML
integrates HTMX for interactivity, which you can see in more complex examples,
but our simple example focuses on static content for clarity.

### Minimizing JavaScript Dependency with HTMX

By incorporating HTMX, FastHTML significantly reduces the need for custom
JavaScript code. HTMX is a lightweight library that allows for dynamic,
AJAX-powered web applications using simple HTML attributes. This integration
enables developers to create interactive web applications using primarily Python
and HTML, without extensive JavaScript knowledge.

Ah ha! A 2nd language you have to learn, you say! Ah, you caught me. But HTMX is
almost all these `hx_[name]=value` attributes that look suspiciously like HTML
attributes. So... yeah, another language. But it sort of fits in without much
cognitive overhead. HTMX disappears into the Python params.

### Simplifying Styling with PicoCSS

FastHTML embraces minimalist CSS frameworks like PicoCSS to streamline the
styling process. These lightweight CSS solutions provide a set of sensible
defaults and utility classes, allowing developers to create visually appealing
websites with minimal custom CSS. This approach reduces the complexity of
managing styles while still offering flexibility for customization.

### Streamlined Development Experience

FastHTML's design philosophy centers around providing a straightforward,
Python-centric development experience. By eliminating the need for multiple
languages and complex toolchains, FastHTML allows developers to focus on
building functionality rather than juggling different syntaxes and technologies.

For old-school webmasters like that, that means edit, save, go look what you
did, edit, save, go look again. There's *no "build"* procedure.

### Powerful Yet Simple

Despite its emphasis on simplicity, FastHTML remains powerful enough to build
advanced, interactive web applications. It leverages the full power of the
Python ecosystem while providing a more intuitive and streamlined development
process.

By addressing these key areas, FastHTML offers a refreshing alternative to
traditional web frameworks, making Python web development more accessible and
efficient for developers seeking a simpler, more Python-centric approach. Hey,
that's me! I'd rather not do webdev at all than to be on the JavaScript
framework hamster wheel.

In fact, I'm using it as a local-app UI-language the way you'd use QT, TK or
Electron. Put your local web-app on a Nix Flake and you've got a nifty little
universal app-packager that works on your machine.

### FastHTML Minimal Example 

Notice there is no templating language like jinja2 being used here. There is no
mixed-context languages. The Python functions are named for the HTML elements
they generate. CSS is also being avoided using the default import of PicoCSS.
Eliminating the need for a template language and CSS classes is half the genius.

```python
from fasthtml.common import *

app, rt = fast_app()

@rt('/')
def get():
    return HTML(
        Body(
            Main(
                H1("Welcome to FastHTML!"),
                P("Creating clean web pages with minimal Python code.")
            )
        )
    )

serve()
```

So why doesn't it look like *normal* Python? Because FastHTML makes heavy use of
how Python allows line-breaks in function calls. Look carefully. That whole
fraggin frag of HTML is on the function's *`return` call.* Keep that in mind,
because that's the gist of *over the wire HTML* -- using HTML instead of JSON
for partial page-builds🤯!

### FastHTML with HTMX

The other half of the genius is how we eliminate the need for JavaScript. Here
we have the above example simply adding a paragraph element welcoming you to the
page.

```python
from fasthtml.common import *

app, rt = fast_app()

@rt('/')
def get():
    return HTML(
        Body(
            Main(
                H1("Welcome to FastHTML!"),
                P("Creating clean web pages with minimal Python code."),
                Input(name="username", placeholder="Enter your name", hx_post="/welcome", hx_target="#welcome-msg", hx_swap="innerHTML"),
                Div(id="welcome-msg")
            )
        )
    )


@rt('/welcome', methods=['POST'])
def welcome(username: str = ""):
    return P(f"Welcome {username}!")

serve()
```

### Explanation:

- **Input Element with HTMX**:
  - `hx_post="/welcome"`: Submits the entered value to `/welcome` without writing any JavaScript.
  - `hx_target="#welcome-msg"`: Updates the HTML inside the `Div` with `id="welcome-msg"`.
  - `hx_swap="innerHTML"`: Replaces the inner HTML of the target element with the response.

- **Dynamic Content Handling**:
  - The server-side function `welcome` receives the input and returns a new paragraph with the personalized welcome message.

This example shows how FastHTML leverages HTMX to create interactive web pages with minimal Python code and without any direct JavaScript.

### FastHTML Database

> And here we see the third half of the genius. In other words, the elimination
> of template languages and most need for JavaScript weren't enough, most
> complexity of dealing with databases is eliminated in FastHTML by using sqlite
> as the default for most things, through the radically simple MiniDataAPI spec.

Now let's say we also wanted to define a database that keeps records of everyone
who has entered their name. Notice the `fast_app()` convenience function we've
been using? That provides the `@rt()` shortcut notation for routers. It can also
return a set of database objects we can use (sqlite by default) to help us with
database tasks like this...

```python
from fasthtml.common import *

# Setting up FastHTML with a SQLite database to store usernames
app, rt, users, User = fast_app('folder/filename.db', users=dict(username=str))

@rt('/')
def get():
    return HTML(
        Body(
            Main(
                H1("Welcome to FastHTML with Database!"),
                P("Creating clean web pages with minimal Python code."),
                Input(name="username", placeholder="Enter your name", hx_post="/welcome", hx_target="#welcome-msg", hx_swap="innerHTML"),
                Div(id="welcome-msg"),
                H2("Visitors:"),
                Ul(*[Li(user.username) for user in users()])
            )
        )
    )


@rt('/welcome', methods=['POST'])
def welcome(username: str = ""):
    users.insert(username=username)
    return P(f"Welcome {username}!")

serve()
```

### Explanation:

- **Database Setup**:
  - `fast_app()` initializes an SQLite database automatically.
  - `users.insert(username=username)` adds the input to the database seamlessly without manual SQL commands.

- **HTMX Integration**:
  - The submitted username is stored instantly, and the page dynamically updates with the new user's welcome message.

This example elegantly showcases how FastHTML's `fast_app()` greatly simplifies database interactions while keeping the interaction clean and efficient.

## FastHTML In a Nutshell

In essence, FastHTML champions a return to simplicity in web development. By
discarding traditional templating languages, minimizing JavaScript reliance
through HTMX, and streamlining database interactions with SQLite, FastHTML
allows developers to focus on the core logic of their applications. This
approach not only reduces the cognitive load but also accelerates the
development process, making web development more accessible and enjoyable.
FastHTML embodies a philosophy of powerful simplicity, proving that
sophisticated web applications can be built without unnecessary complexity.

---

# Defining a Todo Table in FastHTML: Two Equivalent Approaches

> You'll be scratching your head pretty soon about whether and how to use the
> `fast_app` helper class to construct database connections on the same call
> that creates the `app` object in the online examples. It's a convenience
> wrapper alternative to the `fastlite` library as described here.

Below are two equivalent minimal examples showing how to set up a persistent SQLite-backed **`task`** table (with fields **id, name, done, priority, profile_id**) in a FastHTML web app. Both approaches yield a FastHTML-compatible app connected to the same SQLite database and schema. The first uses FastHTML's `fast_app` convenience helper with inline MiniDataAPI specs, and the second uses the **fastlite** library directly to define the schema and integrate it into FastHTML.

## Approach 1: Using `fast_app` with inline MiniDataAPI specs

In this approach, we use FastHTML’s `fast_app` helper. We pass the table definitions as dictionaries (`store=...`, `task=...`) directly into `fast_app`. This function returns the Starlette app, a route decorator (`rt`), and for each table a tuple of (table_object, dataclass_type). We capture these for the `store` and `task` tables. The table schemas are defined in the dicts with field names and types, plus a `"pk"` for the primary key field. FastHTML (via **fastlite** under the hood) will create the SQLite tables if they don't exist and generate corresponding dataclass models.

```python
from fasthtml.common import fast_app

# fast_app creates the FastHTML app and sets up tables from MiniDataAPI specs.
# It returns: app, route_decorator, (store_table, StoreClass), (tasks_table, TaskClass), ...
app, rt, (store, Store), (tasks, Task) = fast_app(
    db_file="data/tasks.db",   # SQLite file for persistence
    # Define 'store' table schema via dict (MiniDataAPI spec)
    store={
        "key": str,
        "value": str,
        "pk": "key"            # 'key' is primary key
    },
    # Define 'task' table schema via dict (MiniDataAPI spec)
    task={
        "id": int,
        "name": str,
        "done": bool,
        "priority": int,
        "profile_id": int,
        "pk": "id"             # 'id' is primary key
    }
)

# Now 'tasks' is a table object (backed by SQLite), and 'Task' is the dataclass model.
# We can use them in route handlers. For example:
@rt("/")  # FastHTML route decorator for the root URL
def list_tasks():
    all_tasks = tasks()       # Query all rows in the 'task' table (returns list of Task instances)
    return all_tasks          # FastHTML will render the list of Task dataclass objects as HTML
```

**Explanation:** In the code above, `fast_app` automatically opens/creates the SQLite database `data/tasks.db`, defines the **task** table with the given schema, and does the same for a simple **store** table. It returns the `tasks` table object and its corresponding `Task` dataclass (plus the `store` table and `Store` dataclass). These can be used directly in the app. For instance, `tasks()` performs a query (returning `List[Task]`), and `tasks.create(...)` could insert a new task, etc., without additional setup.

## Approach 2: Using `fastlite` to manually create and register the schema

This approach does not use `fast_app`. Instead, we manually create the FastHTML app and use **fastlite** (which implements the MiniDataAPI) to define the same tables. We then integrate those tables with the app. The result is functionally the same: a FastHTML app with a persistent SQLite-backed `task` table (and `store` table) available for use in routes. 

```python
from fasthtml.common import FastHTML        # Import FastHTML app class
from fastlite import Database               # Import fastlite's Database

# Manually create a FastHTML app (equivalent to what fast_app() does internally)
app = FastHTML()
rt = app.route  # Route decorator (same as returned by fast_app)

# Connect to the same SQLite database file
db = Database("data/tasks.db")

# Define or retrieve the 'task' table
tasks = db.t.task                             # Table handle (table name 'task')
if tasks not in db.t:                         # If the 'task' table doesn't exist yet:
    tasks.create(                             # create it with the given schema
        id=int,
        name=str,
        done=bool,
        priority=int,
        profile_id=int,
        pk="id"                               # set 'id' as primary key
    )

# Define or retrieve the 'store' table (for completeness, as above)
store = db.t.store
if store not in db.t:
    store.create(
        key=str,
        value=str,
        pk="key"                              # 'key' is primary key for store table
    )

# Generate dataclass models for each table (for convenient use in FastHTML)
Task = tasks.dataclass()   # dataclass for 'task' rows (class named 'Task')
Store = store.dataclass()  # dataclass for 'store' rows (class named 'Store')

# Now we have the same objects as in Approach 1: 'tasks' table and 'Task' dataclass.
# They can be used in FastHTML route handlers in the same way:
@rt("/")  # Define a route on the FastHTML app
def list_tasks():
    all_tasks = tasks()                      # Query all tasks (returns list of Task instances)
    return all_tasks                         # FastHTML will render the Task list as HTML
```

**Explanation:** Here we explicitly create a `FastHTML` app and then use `fastlite.Database` to open `data/tasks.db`. We access `db.t.task` to get a reference to the **task** table, and if it doesn't exist we call `tasks.create(...)` with the same field definitions and primary key as before. We do the same for a **store** table. We then call `tasks.dataclass()` to produce a `Task` dataclass (and similarly `Store` for the store table). At this point, `tasks` (table) and `Task` (dataclass) are equivalent to those provided by `fast_app` in Approach 1. We attach route handlers using `@app.route` (here referenced as `rt` for consistency), and within those handlers we can query or modify `tasks` just like in Approach 1. The FastHTML framework will handle rendering of the returned dataclass instances to HTML.

## Equivalence of the Two Approaches

Both approaches above result in a FastHTML web application with a persistent SQLite-backed `task` table (and a `store` table in our example) that can be used through FastHTML’s routing and rendering system. The difference is purely in setup:

- **Using `fast_app`:** Simplifies configuration by accepting table schemas as dictionaries and returning ready-to-use table objects and dataclasses.
- **Using `fastlite` directly:** Gives more manual control by explicitly creating the database and tables, but requires a few extra lines of code.

In both cases, the `task` table has the same schema (id, name, done, priority, profile_id with `id` as primary key) and uses the same SQLite database file. Thus, they are interchangeable in terms of functionality — you could use either method to build a FastHTML app that manages Todo tasks with the given schema. The route handlers and other parts of the app would interact with the `tasks`/`Task` in exactly the same way for both setups.

---

# MiniDataAPI Spec

## What is MiniDataAPI Spec?

MiniDataAPI is a minimalist persistence API for cross-database CRUD operations,
intentionally stripped down: no joins, no foreign keys, and no complex query
chaining. Why would it be so stripped down? Future proofing! You can connect any
database to it with some mapping. Use Python's default SQLite initially, and as
your needs grow, connect it to PostgreSQL or whatever. Your code doesn't change!

It provides straightforward methods for basic data interactions:

- **`t.insert(...)`** – Add new records.
- **`t[key]`** – Retrieve by primary key.
- **`t(...)`** – Query lists of records with optional conditions.
- **`t.update(...)`** – Update existing records by primary key.
- **`t.delete(key)`** – Remove records by primary key.

## The Special `.xtra()` Method

`.xtra()` sets persistent filters on a table instance, ideal for permission scoping or multi-tenant applications. Once applied, all subsequent operations on that table respect the filter automatically:

```python
todos.xtra(user_id=42)  # Now all queries, updates, and deletes only affect user_id=42's data
```

- **One-way filter:** Can't be removed once set; create a fresh table instance if needed.
- **Universal enforcement:** Applies to all queries, updates, deletes; inserts respect and enforce the filter criteria.

## Common Pitfalls

- **No ORM-like chaining:** Avoid `.filter()`, `.where()`, or joins—these aren’t supported.
- **Use `.xtra()` intentionally:** Apply only when scoping is necessary, typically at request start.

## Practical Example Summary

Define a Todo table:

```python
@dataclass
class Todo:
    id: int
    title: str
    status: str
    name: str

todos = db.create(Todo, pk='id')
```

Basic CRUD examples:

- **Create:** `todos.insert(title="Task", status="open", name="Alice")`
- **Read:** Single `todos[1]`, multiple `todos(where="status='open'")`
- **Update:** `todos.update(id=1, status="done")`
- **Delete:** `todos.delete(1)`
- **Scoped:** `todos.xtra(name="Alice")`

MiniDataAPI keeps database interactions simple and predictable—perfect when clarity and straightforward CRUD operations matter most.


