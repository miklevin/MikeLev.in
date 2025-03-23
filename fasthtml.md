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

In short, MiniDataAPI spec, a database API made specifically for FastHTML, is
being used through the `fast_app()` convenience wrapper. `fast_app` always
returns the *flask-like* webserver connection object `app` first and the
shortcut for `app.route()` second. The returned `users` object is a MiniDataAPI
database table with methods like `.insert()` and `.delete()`, and `User` is a
`dataclass()` description of a single record used for hinting and validation.
That's it. There's no special setup. A whole table schema can go as a Python
`dict` where `dict(username=str)` appears. That's databases in FastHTML.

## Going Beyond the Basics

Yes, of course it goes deeper like how to set up more tables, or how to do this
without the helper-class, or why use such a simple database API when you could
be using SQLAlchemy and PostgreSQL. The short answer is that it's all rigged to
"just work", leaning into powerful defaults that leverage the fact that SQLlite
is always there. If you want more, you just go past the defaults and make it as
powerful as you like.

This and more I answer here and throughout the website, but a lot of folks are
here to understand how FastHTML is something different from FastAPI. Even the
LLMs don't get it.

### Building from Flask's Foundation

So below, I build the explanation up from Flask because it looks a lot like
Flask, but isn't. It's FastHTML creating one of the easiest and best
abstractions for databases in web development. If you're not interested in the
background, just scroll down!

## The Flask Foundation

Flask is a Python microframework that has profoundly influenced the development
of web frameworks in Python since its release in April 2010. Created by Armin
Ronacher as part of the Pocoo project, Flask was initially conceived as an April
Fool's joke but quickly gained traction due to its simplicity, flexibility, and
minimalist design philosophy. Unlike full-stack frameworks, Flask does not
impose specific tools or libraries, allowing developers to choose their
components. It is built on the Werkzeug WSGI toolkit and Jinja2 template engine,
both of which were also developed by the Pocoo team.

The massively popular way that Flask creates an `app` object is why the FastHTML
example above looks so familiar.

```python
from flask import flask

app = flask(__name__)
```

Flask popularized a key innovation: the use of Python decorators for routing web
requests to specific functions. This approach simplified web development by
allowing developers to define routes directly above their view functions using
the `@route` decorator. This feature became a defining characteristic of Flask
and has been widely adopted by other frameworks such as FastAPI and CherryPy,
albeit with their own variations.

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

While FastAPI addresses important performance needs, its approach doesn't align
with my vision for web development. The requirement for optional static typing,
in particular, diverges from my preferred style. Simply adding asynchronous
capabilities to Flask wouldn't have been sufficient to reignite my interest in
web development. Instead, my goal is to strip away complexity and move towards
greater simplicity. Rather than layering on additional features, I aim to
distill web development to its essence while still being Python. I hungered for
a framework that embodies simplicity and ease of use without sacrificing
functionality.

## The Radical Simplicity of FastHTML

Enter FastHTML, a framework that revolutionizes Python web development by
stripping away complexity and embracing simplicity. FastHTML takes a radically
different approach compared to its predecessors, focusing on streamlining the
development process and reducing cognitive overhead. Here's how FastHTML
achieves this:

### Eliminating the Need for Templating Languages

FastHTML does away with traditional templating languages, allowing developers to
work directly with Python objects to generate HTML. This approach simplifies the
development process by removing the need to learn and use a separate templating
syntax. Instead, developers can leverage their existing Python knowledge to
create dynamic web content.

### Minimizing JavaScript Dependency with HTMX

By incorporating HTMX, FastHTML significantly reduces the need for custom
JavaScript code. HTMX is a lightweight library that allows for dynamic,
AJAX-powered web applications using simple HTML attributes. This integration
enables developers to create interactive web applications using primarily Python
and HTML, without extensive JavaScript knowledge.

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

### Powerful Yet Simple

Despite its emphasis on simplicity, FastHTML remains powerful enough to build
advanced, interactive web applications. It leverages the full power of the
Python ecosystem while providing a more intuitive and streamlined development
process.

By addressing these key areas, FastHTML offers a refreshing alternative to
traditional web frameworks, making Python web development more accessible and
efficient for developers seeking a simpler, more Python-centric approach.

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
