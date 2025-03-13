---
title: FastHTML is not FastAPI
description: 
author: Mike Levin AI SEO
permalink: /fasthtml/
group: home
---

# FastHTML is not FastAPI

> FastHTML and FastAPI are two very different things. One will fit your vibe and
> the other one won't. This page is to first tell you the difference, and then
> to tell you the key things to know about FastHTML (my vibe).

## The Flask Foundation

Flask is the Python web microframework that set the standard on Python. Most
things in the Python web framework arena has been copying Flask ever since,
making their own little spin on it (CherryPy, Pylons, etc). The basic Flask
trick is to use `@decorators` at the top of functions to route web requests from
a server into that Python function. Both FastAPI and FastHTML do this. That's
where the similarity ends.

## The Rise of FastAPI

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

That is an important itch to scratch, for sure. However, it does not suit my
vibe, particularly in how it requires the optional static typing. However, Flask
with mere asynchronous behavior wouldn't have been enough to get me back into
WebDev. I want to strip things out towards greater simplicity, and not layer
them on for complexity.

## The Radical Simplicity of FastHTML

Enter FastHTML. But before you can appreciate how radically different FastHTML
is, you need to know a bit about HTML templating languages like jinja2 (the one
included with Flask), and something called HTMX which greatly reduces the need
for JavaScript. FastHTML strips away a lot of the cognitive overhead and
friction of using Python for web development by:

- Eliminating the need for a templating language like jinja2
- Eliminating most of the need JavaScript using HTMX
- Eliminating most of the need for CSS using PicoCSS (and things like it)

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
app, rt, users, User = fast_app('data/users.db', username=str)

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
