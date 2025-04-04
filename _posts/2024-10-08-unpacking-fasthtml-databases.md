---
title: Unpacking FastHTML Databases
permalink: /futureproof/unpacking-fasthtml-databases/
description: I explore the complexities of the FastHTML framework and its layered architecture, built on Python and Starlette. I discuss the challenges of adapting to new conventions while developing a Pythonic API wrapper and highlight the importance of understanding evolving frameworks for effective web development. I also delve into the intricacies of FastHTML's database features, including table creation, persistence, and user data management, emphasizing the importance of understanding these concepts for building robust web applications.
layout: post
---

> If you're just here to learn the basics of FastHTML without hearing about me
> rediscovering the love for webdev, visit my [Introduction to FastHTML](/fasthtml/) page. It covers:

1. Eliminating template languages like Jina2
2. Eliminating JavaScript in most cases (using HTMX)
3. Eliminating code bloat from CSS classes
4. Eliminating all complex databases stuff

While this article has proven popular and I encourage you to read it, I think
most people want the bottom line. Anyone who is interested in the journey, read on!

---

## Getting Back into Web Development with FastHTML Framework

I dove deep into FastHTML building a framework on a framework on a framework, as
Pipulate is built on FastHTML which is built on Starlette, which is built on
Python (built on C, and so on). That sounds risky and fragile, but it's the
smallest price of getting back into web development that I could find, and that
requires a lot of buy-in. This article is quite literally about unpacking the
database components of that buy-in, and why it's worth taking up as a new thing
in my 50s that I think will last for the rest of my life.

## Avoiding the Giant Reset Button of Tech

This article covers those parts of FastHTML that I have to learn and
internalize--***FAST***. With the birth of a new framework (FastHTML, in this
case), new conventions spring into being. You just have to learn them. This is
why examples and tutorials are so important up-front.

### There Goes My Precious Muscle Memory Again

New patterns, ugh! New things to train your brain to do. New muscle memory to
learn to type. Ugh, it's a huge buy-in and investment and after some 30 to 40
years of the giant reset button of tech in the sky coming down to crush me, I
approach it with caution.

## Wrapping Python Functions Changes the Interface

So we stay as close as possible to now timeless Python patterns. The heart of
this thing isn't going away, and it's just how we finagle new framework patterns
out of Python that we have to worry about. And on such a new framework, that can
be both difficult and a moving target. The best tutorial I've found on YouTube
on the deep inner workings of FastHTML is [FastHTML advapp.py
walkthru](https://www.youtube.com/watch?v=kfEpk6njb4s) which Jeremy did wwith a
new employee, and even there he's doing things one way and stuff has changed a
bit since. Those tutorials have databases being created out of sort of a magic
nothingness from the `from fasthtml.common import *` in the
[examples/adv_app.py](https://github.com/AnswerDotAI/fasthtml/blob/main/examples/adv_app.py)
example. There, he creates a new database object from an amorphous name space
out of thin air...

### The Old FastHTML Interface

```python
db = database('data/todos.db')

# Then you get your tables with
todos,users = db.t.todos,db.t.users

# Then you create dataclasses with
Todo,User = todos.dataclass(),users.dataclass()
```

### Go to Defninition of FastHTML

That was the old way. This is a heck of a lot to remember for a databases system
"built into" a framework. This apparently bothers other people as much as me, so
now there's this one wrapper class `fast_app` which is the only one you ***have
to remember*** if you splat **fasthtml.common** into global namespace.

```python
def fast_app(
        db_file:Optional[str]=None, # Database file name, if needed
        render:Optional[callable]=None, # Function used to render default database class
        hdrs:Optional[tuple]=None, # Additional FT elements to add to <HEAD>
        ftrs:Optional[tuple]=None, # Additional FT elements to add to end of <BODY>
        tbls:Optional[dict]=None, # Experimental mapping from DB table names to dict table definitions
        before:Optional[tuple]|Beforeware=None, # Functions to call prior to calling handler
        middleware:Optional[tuple]=None, # Standard Starlette middleware
        live:bool=False, # Enable live reloading
        debug:bool=False, # Passed to Starlette, indicating if debug tracebacks should be returned on errors
        routes:Optional[tuple]=None, # Passed to Starlette
        exception_handlers:Optional[dict]=None, # Passed to Starlette
        on_startup:Optional[callable]=None, # Passed to Starlette
        on_shutdown:Optional[callable]=None, # Passed to Starlette
        lifespan:Optional[callable]=None, # Passed to Starlette
        default_hdrs=True, # Include default FastHTML headers such as HTMX script?
        pico:Optional[bool]=None, # Include PicoCSS header?
        surreal:Optional[bool]=True, # Include surreal.js/scope headers?
        htmx:Optional[bool]=True, # Include HTMX header?
        ws_hdr:bool=False, # Include HTMX websocket extension header?
        secret_key:Optional[str]=None, # Signing key for sessions
        key_fname:str='.sesskey', # Session cookie signing key file name
        session_cookie:str='session_', # Session cookie name
        max_age:int=365*24*3600, # Session cookie expiry time
        sess_path:str='/', # Session cookie path
        same_site:str='lax', # Session cookie same site policy
        sess_https_only:bool=False, # Session cookie HTTPS only?
        sess_domain:Optional[str]=None, # Session cookie domain
        htmlkw:Optional[dict]=None, # Attrs to add to the HTML tag
        bodykw:Optional[dict]=None, # Attrs to add to the Body tag
        reload_attempts:Optional[int]=1, # Number of reload attempts when live reloading
        reload_interval:Optional[int]=1000, # Time between reload attempts in ms
        static_path:str=".",  # Where the static file route points to, defaults to root dir
        **kwargs)->Any:
    "Create a FastHTML or FastHTMLWithLiveReload app."
    h = (picolink,) if pico or (pico is None and default_hdrs) else ()
    if hdrs: h += tuple(hdrs)

    app = _app_factory(hdrs=h, ftrs=ftrs, before=before, middleware=middleware, live=live, debug=debug, routes=routes, exception_handlers=exception_handlers,
                  on_startup=on_startup, on_shutdown=on_shutdown, lifespan=lifespan, default_hdrs=default_hdrs, secret_key=secret_key,
                  session_cookie=session_cookie, max_age=max_age, sess_path=sess_path, same_site=same_site, sess_https_only=sess_https_only,
                  sess_domain=sess_domain, key_fname=key_fname, ws_hdr=ws_hdr, surreal=surreal, htmx=htmx, htmlkw=htmlkw,
                  reload_attempts=reload_attempts, reload_interval=reload_interval, **(bodykw or {}))
    app.static_route_exts(static_path=static_path)
    if not db_file: return app,app.route

    db = database(db_file)
    if not tbls: tbls={}
    if kwargs:
        if isinstance(first(kwargs.values()), dict): tbls = kwargs
        else:
            kwargs['render'] = render
            tbls['items'] = kwargs
    dbtbls = [_get_tbl(db.t, k, v) for k,v in tbls.items()]
    if len(dbtbls)==1: dbtbls=dbtbls[0]
    return app,app.route,*dbtbls
```

## Unpacking Factory Class that Instantiates Multiple Objects

And so there's a new database pattern born because this has morphed into
something ***"wrapped"*** by `fast_app` like so:

### The New FastHTML Interface

```python
# Unpack the returned tuple from fast_app
app, rt, (users, User), (todos, Todo) = fast_app(
    "data/pipulate.db",
    ...
)
```

So, uh yeah this took me a long time to... unpack.

## The Weirdness of Complexity In Software Design

Every system has its weirdness, and that weirdness comes into being in order to
crack difficult problems. Complexity rarely goes away. It's just shoved around
to different locations where it's least damaging to the overall endeavor. And
here, Jeremy has chosen to use a convenient wrapper class called `fast_app` very
reminiscent of the super famous Flask pattern in the Python world...

### The Flask Pattern

```python
app = create_app()
```

## FastHTML Defines New `fast_app` Convenience Wrapper

...but now in FastHTML, it's a `fast_app` instead of just an app, and it returns
multiple things. This is where convention kicks into overdrive. Remember, these
are convenience wrappers for you the user and your hint-seeking code editor that
wants to color-code and make pop-ups for you (Go to Definition), so `import *`
is a tad less offensive. If you have no database, this pattern becomes:

### The FastHTML Pattern

```python
rt, app = fast_app()
```

And now if you look at the *return signature* of fast_app (with the
aforementioned "Go to Definition" feature in your editor), you can see the
reason for this...

### Jeremy Splats Tables... *and I Must Care*

```python
return app,app.route,*dbtbls
```

If you stamp out an instance of the fast_app ***factory class***, you always at
least get an ***instance*** of that class named `app`, thus mimicking the Flask
API (as these things do), but also always ***an instance of an `rt` route***
class. This is so you can *route*, often to *root*. It's a root router. Oh,
Jeremy.

### If You Had More Time, Would You Have Made It Shorter?

```python
@rt('/')
def get():
    ...
```

## Single Quotes Yield Maximum Descriptive Power in Code

It's clearly a poetic exercise for this framework developer, how to get the
maximum descriptiveness out of the least code. He also seems to be an advocate
of single-quotes over double because it's less to type, less to look at, yadda
yadda. 

### I'll Gladly Pay with Complexity Now For Simplicity Later

The thing to understand is that this is sparing you, the developer, from having
to look at lots of extraneous information. Jeremy is in pursuit of pure idioms.
The `app` instance does more than just routing, so why look at it every time?
Hence, returning both app and rt instead of forever forward making the user have
to look at, think about, use and maintain `app.route()`.

### Unconventional Conventions

Yet, it's still a lot to grok, especially how it splats back optional database
tables (`*dbtbls`). But we at least now have the `fast_app` factory class to
examine the Definition of and explore. All that ***convention*** of a
convention-driven framework are moved up-front for examination to counter the
argument that `from [package] import *` is bad form. 

It never hurts to `import this` and remind ones self...

### The Zen of Python, by Tim Peters

    Beautiful is better than ugly.
    Explicit is better than implicit.
    Simple is better than complex.
    Complex is better than complicated.
    Flat is better than nested.
    Sparse is better than dense.
    Readability counts.
    Special cases aren't special enough to break the rules.
    Although practicality beats purity.
    Errors should never pass silently.
    Unless explicitly silenced.
    In the face of ambiguity, refuse the temptation to guess.
    There should be one-- and preferably only one --obvious way to do it.
    Although that way may not be obvious at first unless you're Dutch.
    Now is better than never.
    Although never is often better than *right* now.
    If the implementation is hard to explain, it's a bad idea.
    If the implementation is easy to explain, it may be a good idea.
    Namespaces are one honking great idea -- let's do more of those!

And so, there's almost a violent reaction to `from fasthtml.core import *`.

## Creating Idiomatic Frameworks with Shorter Namespace Namespaces

But Jeremy nullifies this argument with the `import fasthtml.common as ft` to
keep your namespaces short and branded like panda's `pd` and numpy's `np`. Fine,
but I'm with Jeremy on this. As honking good of an idea namespaces are, a truly
Python/HTML idiomatic framework where your paragraph tags are `P()` and your div
tags are `Div()` is even better.

## Iterable Database Object (via MiniDataAPI Spec)

Back to splatting database table tuples. If you're going to splat database
tables, it might as well be tuples of tables, am I right? Each tuple packs an
iterable ORM object in lower-case plural form, giving you your...

```python
[x for x in todos()]
```

...magical list comprehension pattern, which you'll see more often as:

```python
[todo for x in todos()]
```

## Can You Tell A Callable From a... uh... Not Callable?

Notice the necessity to use parenthesis `()` on the todos object. That means it
has to be called to get an itterable list. It's a `callable` but not an
`iterable` until it's called (the use of parenthesis) with its default
invocation method (the lack of anything in the parenthesis).

It takes groking, but is very convenient once you do, especially given how
something called a `render` object comes into play later to accomodate for
`HTMX`'s delightful anti-patterns that will infuriate full-stack webdevs.

### CRUD Without the Cruft

Anyone who has stepped through database records in a CRUD (create, record,
update, delete) will appreciate this convenience. It's a righteous union of
Python list comprehensions with databases. Everything you have to do, you can
pretty much do with `todos`, the object mapped to the actual records within the
database. 

But what about the field types? How do you ***know*** what the fields in the
database are?

### todos, todo and Todo... Oh My!

```python
# Unpack the returned tuple from fast_app
app, rt, (users, User), (todos, Todo) = fast_app(
    "data/pipulate.db",
    ...
)
```

## Understanding Python's Dataclass... a Todo Item

The ***second item in each tuple*** is what I previously thought was a
**namedtuple** but I'm now coming to understand is the incredibly similar but
somewhat more capable ***dataclass*** of a single record from the todo database.
It defines everything about a single record, so you can actually ***use those
records*** different ways with your tooling knowing a lot about what to expect
form a single instance of todo item, which will "fit" the `Todo` dataclass
template.

You can always look at one of these ***dataclasses*** by `print(Todo)`'ing it
out, but it will just look like a function with field definitions. Those field
definitions are the point.

### Todo Dataclass Barely Used in FastHTML

Now you can almost get away without using the upper-case singular dataclass
`Todo` in the entire app, were it not for the pedantic type-casting movement
that has for better or for worse swept through the Python community. So now if
you want to build something that's going to do stuff with a database and you
want it to go through at least ***some sanitizing***, you can define your router
endpoints using the dataclass on your parameter type definition.

```python
@rt('/todo')
async def post_todo(todo: Todo):
    ### stuff...
```

### Why The Red Squiggly?

Your editor like VSCode or Cursor AI is not going to like these FastHTML
database dataclasses splat back from fast_app. What's a `Todo`, it's going to
ask. It can't find it in any of the type definitions, so it's going to get rid
squigglies from the Pylance plugin, or whatever. They don't yet know the
FastHTML conventions.

### Pulling Back the Curtains to Reveal Conventions

You can imagine what a surprise it is to discover and fully internalize the
meaning of this at the top of the fast_app definition:

```python
db_file:Optional[str]=None, # Database file name, if needed
```

...***IN PARAMETER POSITION #1***. And further down the fast_app definition, we
find:

```python
tbls:Optional[dict]=None, # Experimental mapping from DB table names to dict table definitions
```

...and then finally, this at the bottom:

```python
return app,app.route,*dbtbls
```

## Identifying Creative Pass-through Use of `**kwargs`

There's some missing parts where the `tbls` dict provided becomes tuples of
dbtbls. And there's some talk about `**kwargs` that have similar table
definition capabilities as tbls, and that's what I had success with, for my
final fast_app instantiation with the table schema...

```python
app, rt, (store, Store), (todos, Todo) = fast_app(  # Unpack the tables directly
    "data/pipulate.db",  # Database file path
    ws_hdr=True,  # Enable WebSocket headers
    live=True,  # Enable live updates
    render=render,  # Set the render function for todos
    store={
        "key": str,
        "value": str,
        "pk": "key"  # Primary key for the store
    },
    todos={
        "id": int,
        "title": str,
        "done": bool,
        "profile_id": str,  # Added profile_id to todos
        "pk": "id"  # Primary key for todos
    },
)
```

## Table Definitions Use Arbitrary Parameter Names In Fast HTML

The words being used as parameter names `store` and `todo` are arbitrary. They
come in at the end of the fast_html defined parameters, and thus by convention
get recognized and parsed in this case as table definitions. The ***field
names*** are used as ***dict keys*** and ***field types*** as ***dict values***.

## Live on the Fault Line, But Understand The Geology

Experimental, he says. Ugh! Okay, be ready for the API to change, but at least
understand it well. FastHTML is a grab-back of goodies, and the most common ones
are put in `fasthtml.common` which get imported into global namespace for Python
functions that look like HTML tags. 

```python
app, rt, (user, Users), (todos, Todo) = fast_app('data/data.db',  
    ...
    )
```

## Starlette and Others Bring A Wealth of Features to Your App

After that, the creation of an `app`, `rt`, and optional (`db_handle`,
`Field_definitions`) database tuples occurs. And the `app` instance is
chock-full-o-goodies twisting stuff from Starlette, HTMX, PicoCSS and unlimited
potential other places this way and that for conventional convenience that may
take a lifetime to understand if you're not Jeremy.

But even if it is experimental and the API changes on us, we understand the
overarching framework, Python, that much better... plus how Jeremy things and
can guess at surprise refinements.

## FastHTML Builds on Established Python Tricks and Principles

At least all the Python tricks FastHTML is built on is not experimental. The
experimental part is massaging an API into place to be the most idiomatic Python
API for HTML... so you can work ***fast*** as Jeremy likes to use in his project
naming conventions. So, live on the fault line but understand the geology.

---

## Help Your Friends or Learn The Force?

Enough is enough! I am prepared. Time to leave Yoda and go off to Dagobah. My
friends need me.

### The 80/20-Rule & Rabbit Hole Evaluation

The rabbit holes I'm ignoring for now is login, as I will program this web app
in signle-tenant mode for simplicy getting out of the starting gate. I will
leave the wedges for it in there. I believe a cookie/dict-like persistent object
is available in session if you log in, but I went and made my own persistence
table. That's the data store:

```python
store={
    "key": str,
    "value": str,
    "pk": "key"  # Primary key for the store
},
```

## How A Dict Handles MiniDataAPI Like Operations

...and I gave it a very literal dict API which I expect I'll map to the formal
built-in sessions one in the future. But for now, here's how a SQL-like row and
column database that gets the `MiniDataAPI` API becomes a `dict` handling such
classics as knowing whether to insert or update on a `db["key"] = value`
assignment:

```python
# *******************************
# DictLikeDB Persistence Convenience Wrapper
# *******************************
class DictLikeDB:
    """A wrapper class for a dictionary-like database to simplify access."""
    
    def __init__(self, store, Store):
        self.store = store  # Store reference
        self.Store = Store  # Store class reference

    def __getitem__(self, key):
        """Retrieve an item from the store by key."""
        try:
            return self.store[key].value  # Return the value associated with the key
        except NotFoundError:
            raise KeyError(key)  # Raise KeyError if not found

    def __setitem__(self, key, value):
        """Set an item in the store by key."""
        try:
            # Try to update existing item
            self.store.update({"key": key, "value": value})
        except NotFoundError:
            # If it doesn't exist, insert a new item
            self.store.insert({"key": key, "value": value})

    def __delitem__(self, key):
        """Delete an item from the store by key."""
        try:
            self.store.delete(key)  # Delete the item
        except NotFoundError:
            raise KeyError(key)  # Raise KeyError if not found

    def __contains__(self, key):
        """Check if a key exists in the store."""
        return key in self.store

    def __iter__(self):
        """Iterate over the keys in the store."""
        for item in self.store():
            yield item.key  # Yield each key

    def items(self):
        """Return key-value pairs in the store."""
        for item in self.store():
            yield item.key, item.value  # Yield key-value pairs

    def keys(self):
        """Return a list of keys in the store."""
        return list(self)

    def values(self):
        """Return values in the store."""
        for item in self.store():
            yield item.value  # Yield each value

    def get(self, key, default=None):
        """Get an item from the store, returning default if not found."""
        try:
            return self[key]  # Attempt to retrieve the item
        except KeyError:
            return default  # Return default if not found

# Create the wrapper
db = DictLikeDB(store, Store)
```

## Simplifying Code Development by Avoiding Overthinking and Evasion

It's a big hunk of code to put into my own framework on a framework on a
framework that probably has it somewhere already, but for now... well, that's
part of ***80/20-rule solutions*** and ***chasing rabbits down rabbit hole
evaluations***. You may not be happy with the answers from either if you're a
purist, but get on with it already! Enough dodging the critical next step of
making the app that the framework exists to simplify making!

### Persistence, But Only To a Point

So I'm forsaking multi-user tenant stuff on the first iteration of this to move
forward fast, but I have cookie-like name/value-pair persistence through anther
mechanism (still within FastHTML framework) that I can map back later.

### Deferring Todo Drag-and-Drop List Sorting

I am also forsaking re-ordering Todo lists. That reordering will be critical
later, but I am confident I can layer it in later. Here, let me put a priority
int field in the todo table for using later...

```python
todos={
    "id": int,
    "title": str,
    "done": bool,
    "priority": int,
    "profile_id": str,  # Added profile_id to todos
    "pk": "id"  # Primary key for todos
},
```

### Understanding Sortable Fields Without Recreating Tables Completely

There, I won't have to recreate or transform all my tables, and the field will
just be invisibly there until I implement drag-and-drop sorting with the
SortableJS library like in the tutorial. Rabbit hole noted, put on the
explore-later map and not jumped into!

### Preparing for Port Challenge Ahead with Innovative Tools

Once again this article was going to be about the port, but it was about making
sure I don't screw it up. And so, we cut this article here as I take a deep
breath and prepare myself to lay out to Claude 3.5 Sonnet and OpenAI ChatGPT
o1-Preview the porting challange before me.

### The Importance Of Learning To Code Yourself Always Is Key

I'm not going to ask it to explicitly do the work for me, as it will likely get
it wrong and results in me losing control of the code. Rather... well, that's
for the next article. To be continued...

Oh, and I must not forget to check out the [FastHTML
Gallery](https://gallery.fastht.ml/)

---

## Gemini 2.5 Experimental's Take

> I like Gemini 2.5's article summation so much that as the mood strikes me, I
> go back to older articles like this (Gemini wasn't up to 2.5 when I wrote
> this) and fill in the below stuff. I think it will help readers and LLMs
> alike, as well as help with the auto-book rollup project.

Okay, here's the breakdown you requested:

**First-Person Summary (Author's Perspective):**

Getting back into web development after years away, I'm diving into the FastHTML framework, built atop Python and Starlette; this article chronicles my deep exploration, specifically focusing on understanding its evolving database conventions centered around the `fast_app` factory function. I unpack the shift from older patterns to this new wrapper, examining how it returns the application instance, routing object, and uniquely, tuples containing iterable database table objects and their corresponding dataclasses, weighing the framework's ambitious goal of idiomatic Pythonic HTML against the inherent complexity and learning curve of its new patterns, ultimately showing how I defined my database schema using `**kwargs` and made pragmatic choices, like deferring login features and list sorting, to accelerate actual application development.

**Title and Headline Ideas:**

* Decoding FastHTML: Unpacking the `fast_app` Database Conventions
* My Journey Back to Web Dev with FastHTML's Evolving API
* FastHTML Databases Explained: From `database()` to `fast_app` Tuples
* Navigating FastHTML's `fast_app`: A Developer's Deep Dive
* Pythonic Web Dev? Exploring FastHTML's Database Patterns and Pitfalls
* Getting Started with FastHTML Databases: Understanding the Core Wrappers
* Complexity vs. Convention: A Look Inside FastHTML's `fast_app`
* FastHTML: Living on the Experimental Edge (Database Edition)
* Pragmatic Progress: Building with FastHTML While Navigating Rabbit Holes
* Why `fast_app` Returns More Than You Expect in FastHTML

**Article Strengths:**

1.  **Deep Technical Dive:** It provides specific code examples and traces the evolution of the FastHTML database API, offering concrete insights.
2.  **Relatable Perspective:** The first-person narrative captures the genuine experience of learning a new framework, including the frustrations and epiphanies.
3.  **Explains the "Why":** It attempts to understand the framework designer's rationale behind certain choices (like the `fast_app` signature, comparison to Flask).
4.  **Practical Application:** The author shows their own working code for defining tables and implementing a temporary persistence layer (`DictLikeDB`), demonstrating real-world adaptation.
5.  **Honesty about Challenges:** It openly discusses the difficulties, the "experimental" nature of APIs, and the trade-offs made (80/20 rule, deferring features).

**Article Weaknesses:**

1.  **Niche Focus:** The content is highly specific to the FastHTML framework and its particular database implementation, limiting the audience.
2.  **Potential for Obsolescence:** Focusing heavily on an "experimental" and evolving API means parts of the article could become outdated quickly.
3.  **Assumes Prior Knowledge:** It presumes familiarity with Python, web frameworks (like Starlette/Flask), database concepts (ORM, dataclasses), and Python idioms.
4.  **Slightly Meandering Structure:** The personal journey narrative sometimes loops back or introduces concepts slightly out of a strict linear order.
5.  **Complexity:** While explaining complexity, the detailed explanation itself requires significant concentration from the reader.

**AI Opinion of the Article:**

This article serves as a valuable, albeit highly specific, resource for developers considering or actively using the FastHTML framework. The author effectively documents their learning process, particularly the nuances of the framework's database handling via the `fast_app` function. The strength lies in its detailed, code-driven exploration combined with a relatable narrative of tackling new technology and its conventions. However, its narrow focus on a relatively new and potentially volatile API, coupled with the assumption of significant background knowledge in Python web development, might limit its broader appeal. It reads like a detailed developer's log, offering practical insights and a realistic portrayal of the challenges involved in adopting bleeding-edge tools, making it useful for its target audience but potentially dense for others.
