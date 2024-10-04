---
title: Understanding FastHTML's Framework Opinions
permalink: /fast-html-framework-opinions/
description: 
layout: post
---

Every day is a discovery process. I'm recalibrating myself to a new tech
reality. The fact everything has become so complex, unreproducible, and driving
you into vendor dependency and paying for everything drove me to discover NixOS
and Nix flakes. That's been a lot of this blog so far, and that provides a
foundation to build on. Now, it's time for a framework to build with. The Nix
hardware and low-level system components you define once up-front, and hopefully
they don't change much throughout the project, but for a very occasional adding
of something like I did recently with tmux for monitoring things that will
eventually run as a service but for now I want to monitor in terminals that are
okay to close without stopping the service. That belongs in the foundation
system, but the actual things running as the services, that we write with a
programming framework.

## The Problem with Using Frameworks on Top of Programming Languages

Having to use frameworks on top of programming languages is actually a position
of weakness. It means your programming language didn't come out-of-the-box ready
to do whatever you needed it to do, so maybe your time should be spent picking a
better foundational programming language than some grab-bag of conveniences,
which is what a framework really is. They just modify and extend the underlying
language so that you can actually do the things you want to do without
reinventing the wheel every time. And so, Python itself is both a language and a
framework due to how many little conveniences it builds in, such as the way its
primary data structures of lists, tuples and dicts work. Python provides these
so that figuring out how to satisfy these common needs isn't the first thing you
have to do. It's a very opinionated thing to do, and that's what frameworks are.
If you're going to make something easier, you have to have an opinion how to do
it.

## The Importance of Framework Opinions in Software Development

And strong framework opinions are not things everybody agrees with. If you
disagree with the opinion, you're not going to like the framework. This is why
passions run so deep surrounding things like React. You have to accept a way of
thinking, and if you don't, it's gear-grinding suffering to abide by it, or even
just to "switch modes" into that framework's method of thinking when you get
into parts of the project that require it. The way separation of concerns has
broken up into front-end and back-end parts makes this a common situation, with
the people who work on each end being specialists. Ruby on Rails popularized the
MVC (model, view, controller) separation, and when the JavaScript frameworks
matured from their wild west pre-JavaScript ES6 days, they embraced this
approach with a fury.

## Framworks are Cookie-Cutters with Signatures

Ugh! Non-JavaScript frameworks that have been around forever, like Python's
Django on which Instagram was built, continued to work just fine. But even
Django was so laden with framework opinions and excessively burdensome
configurations, which combined with the very rigid rails they put you on, they
lost appeal to me. Frameworks are often so opinionated that they come off like
cookie-cutters. In other words, everything you build with that framework looks,
and more importantly ***functions*** the same. They have a certain "signature"
to them. You can usually tell a Django site just by looking at it. It's your
typical corporate intranet, which only makes sense because at the time it came
out, it was replacing a lot of VisualBasic type of consulting work.

## Python Decorators Take Over Pythonic Web Frameworks

Anyhow, fast-forward some 2 decades, and the most love-worthy thing in tech that
I've found is a language which it itself is most of the framework. And it's
love-worthy, because most of its opinions are ones I agree with, or at least can
live with. And that of course is Python itself. Python is a framework. But it
doesn't go all the way, and you still have to layer other frameworks on top of
it, to get a web development system for example. Many people love the Flask
microframework for web development when it came out, because it was mostly just
Python. It didn't do much but route web requests into Python functions with
clever syntactical sugar called a decorator. 

## Flask Added PHP-like HTML Templates in Python

Decorators are those @something directives you sometimes see ***above***
function definitions in Python. It is literally calling an outer-function
(declared by the decorator) before calling the inner-function (the visible one
defined by the def statement). And then Flask gives you a PHP-like template
language called Jinja2 to do the HTML stuff and gets out of your way. This
simplicity and intuitive interface drove Flask to enormous popularity. However,
it's opinion still included: "...and use this HTML templating system", which in
the end made you still have to look at a whole lot of messy code with
HTML/Python "mode-switching" friction. While it had the benefit of being Python,
it wasn't tremendously better than just using PHP. If you want to be looking at
HTML most of the time and just sprinkle programming into it, then use PHP.

## FastHTML Builds upon Flask with Similar Structure and Approach

FastHTML picks up where Flask left off, inserting a few more rather strong
opinions. And that is the onus for today's blog post. At quick glance, it's a
lot like Flask with those @decorator routers. Okay, good. It does that Pythonic
thing of using the winning API in subsequent implementations of packages that
are in the same neighborhood. You see that with Pandas and Polars. You see it
with Requests and httpx. And you see it with Flask and FastHTML. If you know the
former king-of-the-hill, you know the new-kid-on-the-block. Good. That's a huge
accelerator in picking up a new framework in Python, way better than say
switching from AngularJS to ReactJS to Svelte. Ugh! Okay, Flask to FastHTML, no
problem... but wait!

## FastHTML is Designed For Chat-like Features & Long-running Tasks

Now that you've got a Web framework, there are some very traditional problems
you need to address, like persistence (database, sessions, etc.), styling, and
in my case in particular right now, the ability to communicate with the Web app
with streams of communication outside the normal page-loading model. In other
words, the ability to implement chat-like features on a webpage. So on my first
pass taking up FastHTML, I implemented my own persistence mechanism and I
grabbed my old reliable way of doing interprocess communication, ZeroMQ, and
got it to work. But the complexity was too much, and the idea that FastHTML
actually simplified these things kept nagging at me. So I re-scanned the
documentation and re-watched Jeremy Howard's introductory videos, and I'm
floored by just how secretly opinionated FastHTML is, and how I can use that to
simplify my code.

## Jeremy Howard's Understating Signature

I am frankly staggered by the opinions that FastHTML is stating but slyly
understating, in Jeremy Howard's signature way. If you don't know this guy, go
check out his YouTube and Fast.AI tutorials. He was the big thing in AI before
ChatGPT hit. It was more about machine learning and image recognition than it
was about chatbots back then, and Jeremy used his penchant for simplifying APIs
in that uniquely Pythonic way to do with FastAI to the PyTorch(er) library what
whatRequests did to Python's HTTP libraries 

Python has a long, sordid history with its http libraries. What's that history?
This looks like a job for Perplexity!

---

Me: Tell me the background on the Python http library. Why so many libraries and
numbers in their names? And how does Requests fit in? 

Perplexity.AI: The Python HTTP ecosystem has evolved over time, leading to multiple libraries with different names and version numbers. Here's some background on the situation:

## Standard Library HTTP Modules

Python's standard library includes several HTTP-related modules:

- **urllib**: The original URL handling library, split into multiple submodules in Python 3 (urllib.request, urllib.error, etc.).
- **http.client**: A low-level HTTP protocol client (formerly httplib in Python 2).
- **http.server**: A basic HTTP server implementation.

These modules provide core HTTP functionality but can be verbose and cumbersome to use for common tasks.

## Third-Party Libraries

To address limitations of the standard library, several third-party libraries emerged:

- **urllib3**: A powerful HTTP client that adds features like connection pooling and thread safety. It's widely used as a dependency for other libraries.

- **Requests**: Built on top of urllib3, Requests provides a much simpler and more intuitive API for making HTTP requests. It's become the de facto standard for HTTP in Python due to its ease of use[1].

## Why "Requests"?

Requests was created to simplify HTTP interactions in Python. Its name reflects its goal of making HTTP requests as straightforward as possible for developers. The library's tagline is "HTTP for Humans," emphasizing its focus on usability[1].

## Version Numbers

The various version numbers (like urllib, urllib2, urllib3) can be confusing:

- urllib and urllib2 were part of Python's standard library evolution.
- urllib3, despite its name, is a separate third-party library, not a successor to urllib2.

Requests, while using urllib3 internally, presents its own API and version numbering scheme.

## How Requests Fits In

Requests has become the most popular way to make HTTP requests in Python because:

1. It provides a much simpler API than the standard library modules.
2. It handles many low-level details automatically (like connection pooling, SSL verification, and cookie handling).
3. It supports both synchronous and asynchronous requests.

While the standard library modules and urllib3 are still used directly in some cases, Requests is often recommended as the first choice for most Python developers needing to make HTTP requests[1].

Citations:

    [1] https://requests.readthedocs.io/en/latest/
    [2] https://docs.python.org/ko/3.10/library/http.client.html
    [3] https://pypi.org/project/requests/0.9.3/
    [4] https://www.scrapingbee.com/blog/best-python-http-clients/
    [5] https://docs.python.org/ja/3.10/library/http.html
    [6] https://www.reddit.com/r/learnpython/comments/q9v6hh/help_how_to_run_python_httpserver_in_the/
    [7] https://realpython.com/python-requests/
    [8] https://stackoverflow.com/questions/67921957/python-requests-http-call-throwing-error-in-background-mode

---

## The Evolution Of HTTP Libraries In Python

I do believe the key takeaway there was the evidence being enough that a
researching AI chose to characterize the HTTP libraries before Requests as
verbose and cumbersome. Oh, what to import to do what? OMG, I thought Python was
supposed to be easy! And so it is. We layer on the APIs. And sometimes, we peel
away old traditional APIs and layer on new ones. This is not done often, and
this is not done without Earth-shattering raging debates and flame wars. I mean
they were bad enough to make Guido Van Rossum, the creator and benevolent
dictator for life, of Python step down. The time has come the walrus said to not
talk of his operator, or else this article will go down one enormous rabbit
hole. Okay, deep breath... so...

## The Importance of Concurrency in Modern Programming Languages

So, the foundation programming language matters, and in our case this is Python
with its sufferable warts. Warts intrude because standards evolve and the
priorities at the time the core programming language was designed may be
different than the prevailing priorities today. The Web should maybe have HTML
supported natively by browsers, maybe. But here we are. Python is not the only
set of otherwise awesome rules plagued but the new common use-case outlier, as
it was when concurrency became popular. Concurrency was always around, even to
unbelievable degrees at the hardware-level, as old fans of Digital Equipment
Systems old clustering VAX systems will attest to. As will people who use the
Ericsson Erlang language which allowed not only concurrency, but hot-swapping of
hardware while you did it. I mean, the stuff that actually exists goes way
beyond what has become popular and mainstream. But now that it has, we've got
languages built with concurrency in mind from the ground-up, like Erlang or
Google's Go Lang. 

## Python's Adoption of Async and Await Keywords Was Late in The Game

Python got its async and await keywords late in the game, and it's sometimes
difficult to think concurrently with Python; just as it is difficult (for me) to
think Object Oriented in Python as well. Start combining the two, and my mind
explodes. But combine them, we must. And one ripping-apart event that tore the
Python world was how webservers were affected by the protocol changes of HTTP to
formally support all those AJAX hacks websites could now use to stream, like
Server Side Events (sse) and WebSockets. Webservers changed, and the old...
well, let me let Perplexity explain.

---

Me: Can you explain to me Pyton's WSGI and now ASGI? And what's uvicorn, and
what did it replace, and why is it suddenly now so popular? And for that matter,
what's Starlette, and what happened to Flask?

Perplexity AI:

Python's web application ecosystem has evolved significantly over the years, with WSGI, ASGI, and various frameworks and servers emerging to address different needs. Let's break this down:

## WSGI (Web Server Gateway Interface)

WSGI is a specification that defines how web servers communicate with Python web applications. It was introduced in 2003 (PEP 333) to standardize the interface between web servers and Python web applications[1].

Key points about WSGI:
- It's synchronous and designed for Python 2 and 3
- Widely supported by most Python web frameworks
- Handles one request at a time

## ASGI (Asynchronous Server Gateway Interface)

ASGI is the asynchronous successor to WSGI, designed to support asynchronous Python web applications[4].

Key points about ASGI:
- Supports asynchronous operations
- Handles WebSocket connections and long-polling
- Allows handling multiple requests concurrently

## Uvicorn

Uvicorn is an ASGI server implementation, known for its speed and lightweight nature[4]. It has gained popularity due to:

- High performance
- Support for both HTTP/1.1 and WebSockets
- Easy integration with popular ASGI frameworks

Uvicorn didn't directly replace any specific server, but it has become a popular choice over traditional WSGI servers like Gunicorn for ASGI applications.

## Starlette

Starlette is a lightweight ASGI framework/toolkit for building high-performance asyncio services[4]. It's often used as a foundation for other frameworks (like FastAPI) and offers:

- High performance
- WebSocket support
- GraphQL support
- In-process background tasks

## Flask

Flask is still widely used and hasn't been replaced. It's a popular WSGI micro-framework known for its simplicity and flexibility. However, for applications requiring high concurrency or WebSocket support, developers might choose ASGI frameworks like FastAPI (built on Starlette) or Quart (an ASGI reimplementation of Flask).

## The Shift in Popularity

The increasing popularity of ASGI, Uvicorn, and Starlette can be attributed to:

1. Growing demand for real-time applications and WebSockets
2. Need for higher concurrency and performance
3. Rise of asynchronous programming in Python (asyncio)
4. Simplicity and speed offered by these newer tools

While WSGI and frameworks like Flask are still relevant and widely used, the Python web development landscape is evolving to embrace asynchronous patterns and higher performance solutions.

Citations:

    [1] https://builtin.com/data-science/wsgi
    [2] https://wsgi.tutorial.codepoint.net
    [3] https://www.toptal.com/python/pythons-wsgi-server-application-interface
    [4] https://www.fullstackpython.com/wsgi-servers.html
    [5] https://peps.python.org/pep-0333/
    [6] https://csguide.cs.princeton.edu/software/python-wsgi
    [7] https://www.reddit.com/r/django/comments/qv4lvk/good_place_to_read_about_wsgi_how_it_works_how_it/
    [8] https://www.scrapingbee.com/blog/best-python-http-clients/

---

## Replacing Flask API with Starlette for Concurrent Development

Yeah, okay. So replacing the API of Flask to me is like replacing the Request or
Pandas API. Mikey no likey. But these are the changes we make to stay relevant.
The concurrent world isn't going away, and those long-running tasks in the
background that need to chat back to the browser that initiated them, is exactly
what I need to do. So, Starlette instead of Flask. And uvicorn is down there
somewhere, but we need not think about it. APIs are simplified, and we can get
to work.

## Using HTML Element Names as Python Function Names

But wait. There's more! We want to keep things Pythonic. We want to dodge having
to use HTML tags all through our Python code. We also want to avoid that whole
code-behind concept that plagued ASP.NET, where every page-with-logic needed a
page-with-template and the two had to somehow turn that disjointedness into
union. Blech! Even if you use one file for it, there's HTML here and there's
Programming Code there. For years now, I wrote my Jupyter Notebooks with this
magical 1-liner to give he H1 through H4 functions: H1(), H2(), H3() and H4(). I
started giving that up when I realized Markdown headlines controlled Jupyer's
Table of Contents view that let you jump around cells. But the idea never left
me that Python function names should just literally map 1-to-1 to their HTML
equivalents. H1() is an `<h1>`, and so on.

## FastHTML Simplifies Flask Development Through Templating Elimination

And that's FastHTML! The template system is eliminated. Everything blends
together and comes into focus as single-Python-file Flask-like routes where the
templating layer is dehydrated down to its tightest Python skin. With such a
stripping away of everything not necessary for you to look at (yet, still
cleverly hidden), we can use the extra slice of cognitive capacity that gets
freed-up by not having to deal with such extraneous information to tackle the
problems of concurrency, long-running tasks, and most surprising to me lately,
what appears to be a per-user database for generic persistence work.

## Exploring Simpler WebSockets Implementation with FastHTML Decorator

Pshwew! This concept right here is what drove me to start this article. On my
first pass with FastHTML, I did an end-run of both FastHTML's built-in
`@app.ws()` decorator function for WebSockets and used instead my old ZeroMQ
(zmq) approach people used for this sort of thing before WebSockets become so
widely standardized and supported. So, the fact there was just a decorator for
that floored me. I think my code could be so much simpler. But that's a major
refactoring of what's already a small miracle that it's working. But if I just
do the work now, everything forever forward will be that much simpler too,
making it worth it. A rabbit hole worth going down, because the end is clearly
defined, not that far off, and worth it.

## FastHTML Framework Supports WebSockets with Key Features Exposed

This is a quick building up from scratch of everything past the multi-platform
Nix flake that was the end-state of my GitHub `Darwinux` repo. And the beginning
state of my `Pipulate` repo is this. Python is foundational. We build upon it,
but with precisely what brings us to FastHTML and the new opinionated framework
assumptions I'm just internalizing now truly for the first time. Let's
enumerate, as the geeks would say.

- FastHTML supports WebSockets better than I expected
- The implementation accounts for separate user streams!
- This is how it gets turned on `rt = fast_app(ws_hdr=True)`
- Look at fast_app() optional parameters! There's a lot there.
- The first position is an optional database, so a db is assumed!
- The last position is is `**kwargs` for arbitrary app attribute loading!

## Jeremy Howard Has the Art of 80/20-rule API Design

Uh, there's some opinions here. This is a much more loaded framework than the
sparse code you actually have to look at would make it appear. This framework I
get the feeling is like Jeremy Howard himself. This is quite soft-spoken, but if
you look deeper, there's something there that I would categorize with Guido van
Rossum. There's a certain knack for building application program interfaces
(APIs) that gets out of your way, and when you do need to override its well
chose default behavior, there's another well-chosen way to do it. It won't
satisfy all of the people all of the time, but there is a lot of attention paid
to the 80/20-rule use cases. That is, satisfying 80% of the likely to encounter
problems with only 20% of the complexity that you could weigh it down with.

## Understanding Database Creation in Fast App Framework

And so, there will be a certain amount of yielding to the opinions of the
framework, as there always is. For insight as to what those opinions are, look
at the definition of `fast_app()`. In VSCode or Code AI, that's just a matter of
right-clicking on it and selecting `Go to Definition`, which is what Jeremy more
or less does in [the
video](https://youtu.be/Auqrm7WFc0I?si=9S6u3fInrvfxJnPO&t=1655). And the fact
that creating a database right in the first optional position of an `app` object
you'll be creating from `fast_app()` ***strongly*** implies creating a little
database is just something you do. Now whether this is per-user, single database
per user, one database across all users with the user data isolation unaddressed
at the simplest example, I'm not sure yet and have to discover.

## Asynchronous Communication in Single-Page Applications Explained

One thing I can see, is that it's the answer to the persistence, and even to
some degree, communication between components. Even though the entire server app
is going to live in one `server.py` file, they don't always share information
like variable values with each other so easily. That's because of the
asynchronous (concurrent) behavior of things. Like a single-page-application
(SPA), one part of the page could "talk to" another part of the page as if many
page-loads occurred, but only 1 actual page-load occurred and all the back-end
communication occurred with what we would have once called AJAX calls. And it's
the same file serving it all! And thus, a database can be useful for sharing
data between those parts.

## FastHTML Replaces sqlitedict for Persistent Data Storage

Anyway, I used to use `sqlitedict` for generic database work like this in the
past. Both sqlitedict and fasthtml use `SQLite` (sqlite3), but with fasthtml,
it's a default that can be changed. There's also differences in the API. The big
appeal of sqlitedict to me was that it mapped database actions to standard
Python `dict` datatype, albeit with some file opening and closing (or
alternatively the context manager) required. However, in FastHTML, the API for
this persistent data-store so front-and-center to the framework (the least
hidden of many hidden things) is bound to replace that off-the-beaten-track
sqlitedict PyPI package I use.

## Will FastHTML Automatically Sort Out Multi-User Database Issues?

I'm wondering if the database is going to automatically sort out the per-user
issues of persistent database stores on the web. Otherwise, the app is
single-tenant (single-user) until you take steps to make it multi-tenant. In
other words, I wonder wither the basic todo app Jeremy shows us how to write a
separate todo list for everyone, or one todo list for all. If it's separate per
user, it would likely only be temporary lasting as long as a session, however
FastHTML handles sessions (so much to discover).

## Minimal Todo App Creates Duplicate Items on Reload

But an even less-than barebones version of the todo app looks like this. It
inserts a new todo item, identically named, for each page reload. Not idea, but
it's the CR of CRUD...

```python
from fasthtml.common import *

app, rt, todos, Todo = fast_app("todo.db", live=True,
                                id=int, title=str, done=bool, pk="id")

@rt("/")
def get():

    todos.insert(Todo(title='Todo per page-load', done=False)

    items = [Li(o) for o in todos()]
    return Titled('Todos', 
                  Ul(*items),
                )

serve()
```

---

## Understanding CRUD Operations in Software Applications

CRUD? Hey, Perplexity...

CRUD is an acronym that stands for Create, Read, Update, and Delete[1][2][3]. These are the four basic operations that can be performed on persistent data in most software applications and database systems:

1. Create: This operation is used to create new records or entries in a database
   or system[1]. In SQL, this is typically done using the INSERT statement[2].
2. Read: This operation allows for retrieving or viewing existing data[1]. In
   SQL, the SELECT statement is used for reading data[2].
3. Update: This operation is used to modify or edit existing records[1]. The
   UPDATE statement in SQL is used for this purpose[2].
4. Delete: This operation removes existing records from the database or
   system[1]. In SQL, the DELETE statement is used to delete data[2].

These four operations form the foundation of data manipulation in many software applications and database systems. They provide a standardized way to interact with stored data, whether it's in a relational database, NoSQL database, or even in file systems[1][3].

CRUD operations are fundamental in building many types of applications, from simple data entry systems to complex enterprise software. They are often mapped to standard HTTP methods in RESTful APIs:

- Create: POST
- Read: GET
- Update: PUT or PATCH
- Delete: DELETE[2]

Understanding CRUD operations is essential for developers working with databases or building applications that involve data persistence and manipulation.

Citations:

    [1] https://www.freecodecamp.org/news/crud-operations-explained/
    [2] https://en.wikipedia.org/wiki/Create,_read,_update_and_delete
    [3] https://www.codecademy.com/article/what-is-crud
    [4] https://www.crowdstrike.com/cybersecurity-101/observability/crud/
    [5] https://stackify.com/what-are-crud-operations/
    [6] https://stackoverflow.com/questions/22135222/the-meaning-of-crud
    [7] https://www.reddit.com/r/webdev/comments/15lwnym/what_do_people_mean_by_a_simple_crud_app/
    [8] https://budibase.com/blog/crud-app/

---

## Understanding FastAPI's NamedTuple Renderer Example

Okay, wow. So creating records and reading them is that simple? Well, almost. To
my eyes, the output of that program:

```
Todos

    Items(id=1, title='Todo per page-load', done=0)
    Items(id=2, title='Todo per page-load', done=0)
    Items(id=3, title='Todo per page-load', done=0)
    Items(id=4, title='Todo per page-load', done=0)
    Items(id=5, title='Todo per page-load', done=0)
```

...looks like namedtuples. Interesting! There's a built-in renderer. It's
bending my mind to get this, but it's a great example where you just have to
know. You have to follow the tutorials, see it done, and learn by example. I
can't just learn this from documentation. There's an optional parameter on the
`fast_api()` object called `render`, and if set it equal to a function name that
knows how to render the type of `namedtuple` you pass it, then you can simplify
displaying it elsewhere. Here's a slight re-work of the todo app tutorial per
Jeremy's video:

```python
from fasthtml.common import *

def render(todo):
    return Li(todo.title)

app, rt, todos, Todo = fast_app("todo.db", live=True, render=render,
                                id=int, title=str, done=bool, pk="id")

@rt("/")
def get():

    todos.insert(Todo(title='Todo per page-load', done=False))

    return Titled('Todos', 
                  Ul(*todos()),
                )

serve()
```

Okay, so following the tutorial's next step, I took out the automatic insert on
every page reload, and put in a toggle of the `done` field. That's an `update`,
so our CR application has become a RU app.

```python
from fasthtml.common import *

def render(todo):
    tid = f'todo-{todo.id}'
    toggle = A('Toggle', hx_get=f'/toggle/{todo.id}', target_id=tid)
    return Li(toggle, 
              todo.title + (' (Done)' if todo.done else ''),
              id=tid)

app, rt, todos, Todo = fast_app("todo.db", live=True, render=render,
                                id=int, title=str, done=bool, pk="id")

@rt("/")
def get():
    # todos.insert(Todo(title='Todo per page-load', done=False))
    return Titled('Todos', 
                  Ul(*todos()),
                )

@rt('/toggle/{tid}')
def get(tid:int):
    todo = todos[tid]
    todo.done = not todo.done
    return todos.update(todo)

serve()
```

And the output now looks like:

```
Todos

- ToggleTodo per page-load
- ToggleTodo per page-load
- ToggleTodo per page-load (Done)
- ToggleTodo per page-load
- ToggleTodo per page-load
- ToggleTodo per page-load (Done)
- ToggleTodo per page-load (Done)
- ToggleTodo per page-load (Done)
- ToggleTodo per page-load
- ToggleTodo per page-load
- ToggleTodo per page-load
```

## Understanding HTMX Core Attributes for Client-Side Scripting.

Okay, it's important at this point that I start to understand the HTMX core
attributes:

- hx-get: issues a GET to the specified URL
- hx-post: issues a POST to the specified URL
- hx-on*: handle events with inline scripts on elements
- hx-push-url: push a URL into the browser location bar to create history
- hx-select: select content to swap in from a response
- hx-select-oob: select content to swap in from a response, somewhere other than the target (out of band)
- hx-swap: controls how content will swap in (outerHTML, beforeend, afterend, …)
- hx-swap-oob: mark element to swap in from a response (out of band)
- hx-target: specifies the target element to be swapped
- hx-trigger: specifies the event that triggers the request
- hx-vals: add values to submit with the request (JSON format)

And even though they don't list it in core attributes, in the list of Additional
Attribute Reference, there is also:

- hx-delete: issues a DELETE to the specified URL

In Python, these attributes always appear with underscores because they get used
as parameters to functions, and parameters don't support hyphens. 

## FastHTML Routing Invocation Methods Naming Conventions

Okay, so the next step in our CRUDdy journey is the D. This step bends my mind a
bit, because even though we could fix on one conventional way of doing the "what
happens when you click" routing, Jeremy introduces a new approach. Which
approach you use he says is arbitrary. But let's take a look at what the two
approaches actually are below. The `Toggle` action take us through a `/toggle/`
endpoint and enters us into a `get()` function. You can see that a function
named **get** is repeated 2 times. Now in normal Python, that's a no-no. But
apparently this router decoration technique makes it somehow work.

## HTMX Method Implications for Toggle and Delete Actions Defined

The thing to notice is that the HTMX method implied in the calling function
parameter seems like it has to match the name of the function. So if it's an
`hx_get=`, then it's got to be a `get()` function it connects to. Now in the
case of a `Toggle` action, there's really no HTMX attribute that clearly maps to
a toggle, so we might as well use `get`. However, when it comes to `delete`,
while not part of the core HTMX attributes, delete does exist in the additional
ones, so it's semantically correct to recycle a call to the root page `/`,
simply with the `DELETE` method with an todo-item id. And I believe it's just by
convention, but when you do this, you change the function name under the router
to match the invocation method, and so the `delete()` function.

In terms of CRUD, this version is the RUD version.

```python
from fasthtml.common import *

def render(todo):
    tid = f'todo-{todo.id}'

    toggle = A('Toggle', hx_get=f'/toggle/{todo.id}', target_id=tid)

    delete = A('Delete', hx_delete=f'/{todo.id}', 
               hx_swap='outerHTML', target_id=tid)

    return Li(toggle, delete,
              todo.title + (' (Done)' if todo.done else ''),
              id=tid)

app, rt, todos, Todo = fast_app("todo.db", live=True, render=render,
                                id=int, title=str, done=bool, pk="id")

@rt('/')
def get():
    # todos.insert(Todo(title='Todo per page-load', done=False))
    return Titled('Todos', 
                  Ul(*todos()),
                )


@rt('/{tid}')
def delete(tid:int): todos.delete(tid)
    

@rt('/toggle/{tid}')
def get(tid:int):
    todo = todos[tid]
    todo.done = not todo.done
    return todos.update(todo)

serve()
```

## Understanding HTMX's Element Deletion Behavior with Conventions

There's other subtleties here to notice that Jeremy just skims over in the
video, but I guess it's meant to be stopped and studied like I'm doing. Okay, so
when the `delete` route is taken, there's no `return` value specified. That
means Python's going to return `None`. And by convention, HTMX is going to
replace the entire calling element with `None`, effectively deleting it from the
calling object. But in this case, the calling object is an `Li` and the default
delete would only delete the inner HTML text node, leaving an empty line item in
place. To delete the outer HTML of the calling element, inducing it to delete
the `<li>` itself, an HTMX attribute `hx_swap='outerHTML'` needs to be added to
the very calling element. It's a "please destroy me up to the top" sort of
directive.

## HTMX Delivers Clean and Efficient Pythonic Web Programming Experience

HTMX takes awhile to wrap your head around. But then HTMX under a brand new
framework that maneuvers one new API into another is... well, mind-bending as I
pointed out. If the payoff wasn't worth it, I totally wouldn't be doing this.
But the payoff is nothing less than clean Pythonic web programming that in some
ways exceeds the capabilities of the giant JavaScript frameworks, while being
easier. Yeah, that's the way to look at it. The alternative is React.


## Understanding CRUD Operations with POST Method Introduction

Okay, so this next step brings it up to full CRUD by putting an `insert` back
into the picture. There's lots of subtlety here because it's our first
introduction of the `POST` method which is traditionally used for forms on the
web. The main page-load here now has a `Form()` with a `Group()` with an
`Input()` with a placeholder argument.

## How Forms Work with Pedantically Typed Objects

Next to the `Input()` field, there's an add button `Button('Add')` which does
the form submit. Because it's using the post method, even though it targets the
root route '/', it reaches a different function. There's a lot to wrap your mind
around in terms of how pedantically type-defined objects are passed in functions
here. There's a `todo` object of `Todo` data-type fed to a function that
immediately returns by calling the `.insert()` method of the `todos` object with
the value of the posted `todo` item.

Kapeesh? I'm surprised, because I hardly do. But this is very little code,
decipherable syntax, and within the realm of Pythonic... just barely. So, it's
better than most of the alternatives.

```python
from fasthtml.common import *

def render(todo):
    tid = f'todo-{todo.id}'
    toggle = A('Toggle', hx_get=f'/toggle/{todo.id}', target_id=tid)
    delete = A('Delete', hx_delete=f'/{todo.id}', 
               hx_swap='outerHTML', target_id=tid)
    return Li(toggle, ' | ', delete, ' ',
              todo.title + (' (Done)' if todo.done else ''),
              id=tid)

app, rt, todos, Todo = fast_app("todo.db", live=True, render=render,
                                id=int, title=str, done=bool, pk="id")

@rt('/')
def get():
    frm = Form(Group(Input(placeholder='Add a new item', name='title'),
               Button('Add')),
               hx_post='/', target_id='todo-list', hx_swap="beforeend")
    return Titled('Todos', 
                  Card(
                  Ul(*todos(), id='todo-list'),
                  header=frm)
                )


@rt('/')
def post(todo:Todo): return todos.insert(todo)


@rt('/{tid}')
def delete(tid:int): todos.delete(tid)
    

@rt('/toggle/{tid}')
def get(tid:int):
    todo = todos[tid]
    todo.done = not todo.done
    return todos.update(todo)

serve()
```

Okay, now the finishing touch of blanking the input field when the Add button is
pressed, but more important than that, the pattern for doing more than one thing
in response to a single HTMX call. We're going to do this in a couple of steps.
I know it's gratuitous, but for the sake of really understanding it, I'm first
breaking out a little piece of the form construction into an external function:

```python
from fasthtml.common import *


def render(todo):
    tid = f'todo-{todo.id}'
    toggle = A('Toggle', hx_get=f'/toggle/{todo.id}', target_id=tid)
    delete = A('Delete', hx_delete=f'/{todo.id}', 
               hx_swap='outerHTML', target_id=tid)
    return Li(toggle, ' | ', delete, ' ',
              todo.title + (' (Done)' if todo.done else ''),
              id=tid)


app, rt, todos, Todo = fast_app("todo.db", live=True, render=render,
                                id=int, title=str, done=bool, pk="id")


def mk_input(): return Input(placeholder='Add a new item', name='title')


@rt('/')
def get():
    frm = Form(Group(mk_input(),
               Button('Add')),
               hx_post='/', target_id='todo-list', hx_swap="beforeend")
    return Titled('Todos', 
                  Card(
                  Ul(*todos(), id='todo-list'),
                  header=frm)
                )


@rt('/')
def post(todo:Todo): return todos.insert(todo)


@rt('/{tid}')
def delete(tid:int): todos.delete(tid)
    

@rt('/toggle/{tid}')
def get(tid:int):
    todo = todos[tid]
    todo.done = not todo.done
    return todos.update(todo)


serve()
```

## HTMX Swap OOB Calling Method to Update Multiple Targets

Okay, and now we implement and HTMX calling method called `hx-swap-oob`. Out of
bounds, that is. Imagine a game of catch. Somebody throws a ball. The catcher
throws 2 balls back. Only the first ball goes to the original thrower. The
second is sent to someone else out in the field, or "out of bounds". The balls
being thrown back are chunks of HTML, in this case having 2 fragments:

```html
<li id="todo-9">
    <a href="#" hx-get="/toggle/9" hx-target="#todo-9">Toggle</a>
    | <a href="#" hx-swap="outerHTML" hx-delete="/9" hx-target="#todo-9">Delete</a>
    foo 
</li>
<input placeholder="Add a new item" hx-swap-oob="true" id="title" name="title">
```

## We Complete Simple CRUD Application with FastHTML

The first ne works like normal, adding the new line item to the end of the
unordered list, which I'm assuming is part of what `todos.insert(todo)` does.
There's a few parts of FastHTML that are still opaque to me. But the second
fragment, which is the way the input field gets blanked, by being replaced by
this one, targets the element by that ID and swaps it out. Presumably, you could
chain them up to update things all over a dashboard, for example.

I believe that could have been done without breaking it out into a new function
just by parameter-loading. I think Jeremy broke it out to keep it from getting
too jumbled.

Anyway, this is now a simple but complete CRUD application. Jeremy followes
through by showing how to deploy it and in the process encounters a web host's
restrictions about saving files to where the code executes from. Not a bad
security precaution. All he does is add `data` to the `todo.db` path:

```python
from fasthtml.common import *


def render(todo):
    tid = f'todo-{todo.id}'
    toggle = A('Toggle', hx_get=f'/toggle/{todo.id}', target_id=tid)
    delete = A('Delete', hx_delete=f'/{todo.id}', 
               hx_swap='outerHTML', target_id=tid)
    return Li(toggle, ' | ', delete, ' ',
              todo.title + (' (Done)' if todo.done else ''),
              id=tid)


app, rt, todos, Todo = fast_app("data/todo.db", live=True, render=render,
                                id=int, title=str, done=bool, pk="id")


def mk_input(): return Input(placeholder='Add a new item', 
                             id='title', hx_swap_oob='true')


@rt('/')
def get():
    frm = Form(Group(mk_input(),
               Button('Add')),
               hx_post='/', target_id='todo-list', hx_swap="beforeend")
    return Titled('Todos', 
                  Card(
                  Ul(*todos(), id='todo-list'),
                  header=frm)
                )


@rt('/')
def post(todo:Todo): return todos.insert(todo), mk_input()


@rt('/{tid}')
def delete(tid:int): todos.delete(tid)
    

@rt('/toggle/{tid}')
def get(tid:int):
    todo = todos[tid]
    todo.done = not todo.done
    return todos.update(todo)


serve()
```

Pshwew! I've got to internalize this a bit.
