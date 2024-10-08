---
title: Putting It All Together
permalink: /putting-it-all-together/
description: 
layout: post
---

I have dove deep into FastHTML. Talk about all-in. I'm building a framwork on a
framwork on a framework, as Pipulate is built on FastHTML which is built on
Starlette, which is built on Python (built on C, and so on). That sounds risky
and fragile, but it's the smallest price of getting back into web development
that I could find, and that requires a lot of buy-in.

Here's what I need to really learn and internalize. I the birth of a new
framework (FastHTML, in this case) new conventions spring into being and you
just have to learn them. New patterns, ugh! New things to train your brain to
do. New muscle memory to learn to type. Ugh, it's a huge buy-in and investment
and after some 30 to 40 years of the giant reset button of tech in the sky
coming down to crush me, I approach it with caution.

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
db = database('data/utodos.db')

# Then you get your tables with
todos,users = db.t.todos,db.t.users

# Then you create dataclasses with
Todo,User = todos.dataclass(),users.dataclass()
```

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

And so there's a new database pattern born because this has morphed into
something ***"wrapped"*** by `fast_app` like so:

```python
# Unpack the returned tuple from fast_app
app, rt, (users, User), (todos, Todo) = fast_app(
    "data/pipulate.db",
    ...
)

So, uh yeah this took me a long time to... unpack.




