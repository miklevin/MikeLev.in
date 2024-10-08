---
title: Unpacking FastHTML Databases
permalink: /unpacking-fasthtml-databases/
description: The article explores the complexities and nuances of the FastHTML framework, emphasizing its layered architecture built on Python and Starlette. It discusses the challenges of adapting to new conventions while developing a Pythonic API wrapper, highlighting the importance of understanding evolving frameworks for effective web development.
layout: post
---

I have dove deep into FastHTML. Talk about all-in. I'm building a framwork on a
framwork on a framework, as Pipulate is built on FastHTML which is built on
Starlette, which is built on Python (built on C, and so on). That sounds risky
and fragile, but it's the smallest price of getting back into web development
that I could find, and that requires a lot of buy-in.

## Avoiding the Giant Reset Button of Tech

Here's what I need to really learn and internalize. I the birth of a new
framework (FastHTML, in this case) new conventions spring into being and you
just have to learn them. New patterns, ugh! New things to train your brain to
do. New muscle memory to learn to type. Ugh, it's a huge buy-in and investment
and after some 30 to 40 years of the giant reset button of tech in the sky
coming down to crush me, I approach it with caution.

## The Birth of a Pythonic API Wrapper

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

```python
# Unpack the returned tuple from fast_app
app, rt, (users, User), (todos, Todo) = fast_app(
    "data/pipulate.db",
    ...
)

So, uh yeah this took me a long time to... unpack.

Every system has its weirdness, and that weirdness comes into being in order to
crack difficult problems. Complexity rarely goes away. It's just shoved around
to different locations where it's least damaging to the overall endeavor. And
here, Jeremy has chosen to use a convenient wrapper class called `fast_app` very
reminiscent of the super famous Flask pattern in the Python world...

### The Flask Pattern

```python
app = create_app()
```

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

### Jeremy Splats Tables, And I Must Care

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

Anyone who has stepped through database records in a CRUD (create, record,
update, delete) will appreciate this convenience. It's a righteous union of
Python list comprehensions with databases. Everything you have to do, you can
pretty much do with `todo`, the object mapped to the actual records within the
database. But what about the field types?

### todos, todo and Todo... Oh My!

But the second item in the returned tuple is what I previously thought was a
**namedtuple** but I'm now coming to understand is the incredibly similar but
somewhat more capable ***dataclass*** of a single record from the todo database.
It defines everything about a single record, so you can actually ***use those
records*** different ways with your tooling knowing a lot about what to expect
form a single instance of todo item, which will "fit" the `Todo` dataclass
template.

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

The words being used as parameter names `store` and `todo` are arbitrary. The
"come in at the end" of the fast_html defined parameters, and so get recognized
and parsed at the end, and in this case, finds and uses table definitions as
Python dictionaries in which the name of the dictionary is the table (again,
arbitrary as the unpacking names them later), and the field names as keys and
the field data-types as the dict values.

## Live on the Fault Line, But Understand The Geology

Experimental, he says. Ugh! Okay, be ready for the API to change, but at least
understand it well. And even if the API changes on us, we understand the
overarching framework, Python, that much better.

At least all the stuff it's built on is not experimental. The experimental part
is massaging an API into place to be the most idiomatic Python API for HTML...
so you can work ***fast*** as Jeremy likes to use in his project naming
conventions. So, live on the fault line but understand the geology.

---

Enough is enough! I am prepared. Time to leave Yoda and go off to Dagobah. My
friends need me.

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

It's a big hunk of code to put into my own framework on a framework on a
framework that probably has it somewhere already, but for now... well, that's
part of ***80/20-rule solutions*** and ***chasing rabbits down rabbit hole
evaluations***. You may not be happy with the answers from either if you're a
purist, but get on with it already! Enough dodging the critical next step of
making the app that the framework exists to simplify making!
