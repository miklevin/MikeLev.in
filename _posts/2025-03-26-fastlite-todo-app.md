---
title: Extracting FastHTML fastlite Todo App
permalink: /futureproof/fastlite-todo-app/
description: 
layout: post
sort_order: 1
---

FastHTML, fastcore, fastlite... Oh MY! Jeremy Howard likes it fast, and one of
these days I'm sure I'll be taking up his premiere offering Fast.AI given I'm
such a fan of his previous hits such as `nbdev`. Spiritually, Jeremy Howard took
the baton from Kenneth Reitz, the author of the profoundly popular http ***for
humans*** Requests library who wrote the very opinionated *Hitchhiker's Guide to
Python* that spelled out what it was to be *Pythonic*.

There has recently been a counter-spiritual movement in the Python community
undermining Python called Pydantic. Many people think that forced static typing
for performance and bug-free code is the best thing to ever happen to Python,
and I'll tell you those people should just be using Java. Not even JavaScript
because that requires TypeScript the way Python requires MyPy -- the optional
library behind Pydantic that allows rigid static variable typing. But...

> Pydantic's not Pythonic  
> If you have to ask me why  
> I'll tell you that duck-typing  
> Is Pythonic -- Not MyPy!  

The Python way is generally lazy, and Jeremy enthusiastically takes up this
tradition in his beautiful ***for humans*** *fast* Python packages. He's got a
bunch of them, but none of them are FastAPI -- that's something else entirely.
Oh, and FastAPI is awful as Jeremy's fast libraries are lovely. In other words,
FastAPI is the most Pedantic Pydantic Python package to ever pollute our
presumptions. It's gonna take years to purge FastAPI bias out of LLMs.

Fully expounding on this is not the article I'm here to write about. Though it
might not look like it here on the warm-up, I'm getting some work done. That's
what these articles that frame the context of my currently at-hand work is all
about. It's the warm-up and the super-prompt context for any AIs I might tap for
coding assistance. So, I  can't help but pontificate on the issues swimming
around in my head as I get underway.

So, what's that work?

I'm ***extracting a Todo app*** from a FastHTML app that did things Jeremy's way
-- through the `[fast_app](https://raw.githubusercontent.com/AnswerDotAI/fasthtml/refs/heads/main/fasthtml/fastapp.py]` convenience factory constructor class. There's so much
to absorb here that's covered in other articles, I would I guess suggest you
look at how a typical Python Flask web micro-framework app creates its
connection to the webserver, often Uvicorn these days:

```python
# app.py (or whatever your main Flask app file is)
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, World! This is my Flask app."

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

This is the code that ruled the Python web-serving world there for awhile. But
the basic trick is so universal, it basically got re-used by everyone including
the current king of the hill, FastAPI whose corresponding pattern looks like:

```python
# main.py (or whatever your main FastAPI file is)
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, World! This is my FastAPI app."}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

Seeing the pattern? They all return an `app` object, which very much is the
physical connection to the webserver in a similar way to opening a connection
to a file or database for reading and writing. This is what's known in other
more uptight languages as a factory class. We are creating an instance of a
webserver application object `app`, and this pattern rules Python frameworks.

The new kid on the block which is making waves for how it virtually eliminates
the need to look at JavaScript and CSS, FastHTML, has a similar core pattern
(THIS IS **NOT** THE WAY YOU WANT TO DO IT WITH FASTHTML):

```python
# main.py (or whatever your main FastHTML file is)
from fast_html import FastHTML

app = FastHTML()  # Directly instantiate the FastHTML class

@app.route("/")
def index():
    return "<h1>Hello, World! This is my FastHTML app.</h1>"


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

But this is not how it's done in FastHTML because there's too much ugly stuff
there. It's not lovely. It's not brief. It requires ***just have to know***
Python indoctrination stuff. There's that ugly `if __name__ == "__main__":` ugh!
And what's a uvicorn? And why all the `@app.route()` noise when `@rt()` would
suffice? HTML tags? I thought we only had to look at Python with FastHTML!

And so we slide in a ***"helper function"*** for all those framework
conveniences. Instead of calling `FastHTML()` directly, we go through `fast_app`
and import a few selective things. Notice how HTML tag usage goes away in favor
of Python functions that just happen to have the same names as the HTML elements
they're going to generate. Also notice how simple the line to start serving the
website is, reduced from that cryptic hodgepodge above to just `serve()`. *For
humans,* see?

```python
# main.py or whatever your main FastHTML file is
from fasthtml.common import fast_app, serve, Div, P

app, rt = fast_app()  # Get the application and router objects

@rt("/")
def index():
    return Div(P("Hello, World! This is my FastHTML app."))

serve() # Start the FastHTML server
```

But wait! There's MORE!

You see this building up? And it does indeed build up with some pretty wacky
stuff. Let's just say it straight away. There's a `from [something] import *`
below, and this is one of Jeremy Howard's great anti-patterns. You know,
sometimes you just gotta be a bad boy to change Python web development forever.

There's gonna be a bunch of people saying this makes FastHTML, or at least this
way of using it, completely inappropriate for scalable enterprise apps. To them
I say I'm making an Electron-like single-user web app that's run locally and
fully portable between Mac and Windows using Nix Flakes. So to these pedantic
nattering nabobs of Conway's Law, I say their concerns are not my concerns. This
is Python named after Monty Python after all, so now go away or I shall taunt
you a second time.

Framework features layered-in at this point include:

- Database support
- WebSocket support
- Live re-load (for development)
- A bunch of *default* 3rd-party JavaScript libraries loaded through CDNs
- A chance to insert your own standard HTML header tags

And I use all of them in this example! And when I say databases support, I mean
the whole friggn schema. It takes some time to wrap your head around the
integrated database support in FastHTML, but when I put these database schemas
in the same statement that crates the `app` object, it will CREATE the database,
TABLES and all if they're not there yet. And in either case, it will give you a
couple of objects per table to let you do all your Create, Read, Update and
Delete (CRUD) options super-duper easy. Way easier than SQLAlchemy.

```python
from fasthtml.common import *

app, rt, (store, Store), (tasks, Task), (profiles, Profile), (pipeline, Pipeline) = fast_app(
    "data/data.db",
    exts='ws',
    live=True,
    default_hdrs=False,
    hdrs=(
        Meta(charset='utf-8'),
        Link(rel='stylesheet', href='/static/pico.css'),
        Script(src='/static/htmx.js'),
        Script(src='/static/fasthtml.js'),
        Script(src='/static/surreal.js'),
        Script(src='/static/script.js'),
        Script(src='/static/Sortable.js'),
        create_chat_scripts('.sortable'),
        Script(type='module')
    ),
    store={
        "key": str,
        "value": str,
        "pk": "key"
    },
    task={
        "id": int,
        "name": str,
        "done": bool,
        "priority": int,
        "profile_id": int,
        "pk": "id"
    },
    profile={
        "id": int,
        "name": str,
        "menu_name": str,
        "address": str,
        "code": str,
        "active": bool,
        "priority": int,
        "pk": "id"
    },
    pipeline={
        "url": str,
        "app_name": str,
        "data": str,
        "created": str,
        "updated": str,
        "pk": "url"
    }
)
```

And I built all of Pipulate around these FastHTML `fast_app` framework
conveniences. Some of these tables are integral to the Pipulate app, like the
`store` is for server-side cookies (yes, you heard me right), and `pipeline` is
for state-maintenance in workflows. Even Profile is for the tiny concession I
make to different user-profiles in a single-user app (like profiles in a web
browser). But the `task` table gets wired to the Todo app and is completely
externalize-able. The overall Pipulate app works just as well with or without
it, and it's the perfect template to slam out other CRUD apps -- basic adding
rows to a table sort of stuff. So many apps are just fancy todo-lists.

But you can see the issue? It's what we call ***tightly coupled*** to the
FastHTML way of doing things. I can't tear out the todo app and still have it
somehow still be there in the web app... or can I?

You may wonder why so much thought and effort goes into a piece of work like
this. It's because when you design something as a plugin, it's the gift that
keeps on giving. Need another version? Copy/paste the plugin file, change a few
configuration values, and you have another version of the app. Need to track
`Competitors` per `Profile`? No problem! Copy/paste the `Todo` app and ***call
it competitors.*** Over time, you've bent, twisted and molded the framework into
your own... whatever. Custom SEO suite of software and tools. Business analysis
software. A day-trading system. Whatever. This is the opening of the floodgates,
the cutting the catapult ropes, the pulling the trigger... if I can only get it
done.

---

## Super-prompt Complete! Over to Claude 3.7!

> And so there you have it. That's the super-prompt. All the bit-thinking is
> done. I tapped Grok3, ChatGPT o3 and even Gemini 2.5 there at the end. The
> rest is up to Claude 3.7 that's built into Cursor AI. Let's get it thinking...

&lt;think&gt;
I'm looking at code and documentation for a project called "Pipulate", which appears to be a local-first, single-tenant web application framework built with FastHTML, MiniDataAPI, and local LLM integration via Ollama.

From the code snippets and README, I can see that Pipulate has two types of extensions:
1. CRUD Apps - These inherit from a BaseApp class and are used for database operations (Create, Read, Update, Delete)
2. Workflows - These are linear, step-based applications that don't use inheritance

There's a section in the documentation that states "CRUD is DRY and Workflows are WET", indicating that CRUD apps follow the "Don't Repeat Yourself" principle while Workflows tend to have more repetitive code ("Write Everything Twice").

The task appears to be about creating a new type of plugin called "CompetitorPlugin" which seems to be following the CRUD pattern. I see a CompetitorApp class that inherits from BaseApp, and a CompetitorPlugin class that wraps it.

The code shows the implementation of a competitor management interface where users can add, edit, toggle status, and delete competitors. The plugin has methods for rendering competitors, preparing data for insertion and updates, and a landing page that displays the list of competitors.

The workflow_template.py shows the structure of a workflow plugin, which has a different pattern from the CRUD apps. Workflows have steps with IDs, and each step can collect or process data. The data flows from one step to the next, and steps can be reverted and finalized.

According to the blog post excerpts, the author was trying to unify these two extension systems (CRUD apps and Workflows) into a single plugin architecture. The challenge was to externalize the TodoApp (a CRUD app) without modifying the core code, while working within the constraints of the FastHTML framework.

The author ended up adapting the existing workflow discovery pattern instead of creating a new plugin system, which simplified the approach and made it more maintainable. The CompetitorPlugin serves as a proof of concept for this unified plugin architecture.
&lt;/think&gt;

# Understanding Pipulate's Plugin Architecture

Based on the code and documentation provided, I can see that Pipulate is a local-first, single-tenant web application framework built with FastHTML, MiniDataAPI, and local LLM integration (via Ollama). It has an interesting plugin architecture that you're working with.

## Key Concepts

Pipulate has two main types of extensibility:

1. **CRUD Apps** (DRY): Database-focused applications that inherit from `BaseApp` class
   - Follow "Don't Repeat Yourself" principles with reusable code patterns
   - Handle Create, Read, Update, Delete operations on database tables
   - Examples: ProfileApp and TodoApp

2. **Workflows** (WET): Linear, step-based process applications
   - "Write Everything Twice" - more repetitive code as each workflow may have unique steps
   - Process data in sequential steps with potential transformations between steps
   - Can be reverted and finalized
   - Example: HelloFlow from workflow_template.py

## CompetitorPlugin Implementation

What I'm seeing is a `CompetitorPlugin` implementation that follows the CRUD pattern. It consists of:

1. **CompetitorApp class** - Inherits from BaseApp and handles CRUD operations:
   - Rendering competitor items
   - Preparing data for insertion
   - Preparing data for updates
   - Linked to database operations

2. **CompetitorPlugin class** - Wrapper class that:
   - Contains metadata (NAME, DISPLAY_NAME)
   - Provides landing page rendering
   - Has render methods to display competitors
   - Integrates with the server's discovery mechanism

The design demonstrates how external plugins can be developed for Pipulate by placing them in the `plugins` directory without modifying the core codebase.

## The Unified Plugin Architecture

According to the blog post snippets, the author was trying to unify Pipulate's two extension systems (CRUD apps and Workflows) into a single plugin architecture. The challenge was working within the constraints of the FastHTML framework.

Rather than creating a complex new plugin registry system, the approach was to adapt the existing, working workflow discovery pattern. The CompetitorPlugin serves as a proof of concept for this unified approach.

This approach has several benefits:
- Consistency: All extensions follow the same pattern
- Simplicity: Developers only need to learn one extension mechanism
- Maintainability: Easier to understand codebase
- Extensibility: Straightforward pattern for adding new plugins

---

&lt;think&gt;
This message contains a lot of exposition about Python frameworks, FastHTML, and programming philosophy. Let me extract the key points:

1. The author admires Jeremy Howard's approach to Python libraries (Fast.AI, fastcore, fastlite, etc.) which prioritize being "for humans" and simple over rigid type enforcement like in Pydantic.

2. The author is against forced static typing (Pydantic, MyPy) as being un-Pythonic, preferring duck-typing.

3. The author walks through the evolution of Python web frameworks:
   - Flask pattern (app = Flask())
   - FastAPI pattern (app = FastAPI())
   - FastHTML raw pattern (app = FastHTML())
   - FastHTML preferred pattern with fast_app() factory function

4. The author is working on extracting a Todo app from a FastHTML app that was built using the fast_app convenience factory approach.

5. The author shows the Pipulate app initialization with fast_app(), which sets up:
   - Database connection and schemas
   - WebSocket support
   - Live reload
   - Custom headers/scripts
   - Multiple database tables (store, task, profile, pipeline)

6. The key challenge: The Todo app is tightly coupled to the FastHTML framework via the fast_app() configuration. The author wants to make it a plugin that can be externalized without losing functionality.

7. The motivation: Building a plugin architecture allows for easy extensibility - just copy/paste the plugin file, change config values, and you have new functionality without modifying core code.

The author is looking for advice on how to extract the Todo app while keeping it integrated with the main application, essentially converting it from being hardcoded into the app to being a plugin.
&lt;/think&gt;

# Extracting a Todo App: From FastHTML Coupling to Plugin Architecture

I appreciate your thoughtful exploration of Python frameworks and Jeremy Howard's "for humans" philosophy. Your comparison of different web framework patterns provides excellent context for understanding the challenge at hand.

## Understanding the Challenge

You've built Pipulate using FastHTML's `fast_app()` factory pattern, which creates a tightly coupled system where:

1. Database schemas are defined directly in the app initialization
2. Table handles (like `tasks` and `Task`) are returned through tuple unpacking
3. App classes (like `TodoApp`) are instantiated with these specific table handles

```python
# The tight coupling issue:
app, rt, (store, Store), (tasks, Task), (profiles, Profile), (pipeline, Pipeline) = fast_app(
    "data/data.db",
    # ... configuration ...
    task={
        "id": int,
        "name": str,
        "done": bool,
        "priority": int,
        "profile_id": int,
        "pk": "id"
    },
    # ... other schemas ...
)

todo_app = TodoApp(table=tasks)
todo_app.register_routes(rt)
```

And your goal is to externalize `TodoApp` as a plugin without modifying this core initialization.

## The CompetitorPlugin Solution

Looking at your `competitor_plugin.py` implementation, you've successfully created a pattern that works around this coupling:

```python
# ... existing code ...

class CompetitorPlugin:
    NAME = "competitor"
    DISPLAY_NAME = "Competitors"
    # ... other metadata ...

    def __init__(self, app, pipulate, pipeline, db_dictlike):
        self.app = app
        # ... initialization ...
        
        # Create the table directly using fastlite
        self.plugin_db = fastlite.database(db_path)
        competitor_schema = {
            "id": int,
            "name": str,
            "done": bool,
            "priority": int,
            "profile_id": int,
            "pk": "id"  
        }
        
        # Get table handle
        competitor_table_handle = self.plugin_db.t.competitor
        self.competitors_table = competitor_table_handle.create(
            **schema_fields,
            pk=primary_key,
            if_not_exists=True
        )
        self.competitors_table.dataclass()
        
        # Create app instance and register routes
        self.competitor_app_instance = CompetitorApp(table=self.competitors_table)
        self.register_plugin_routes()
```

This approach is elegant because:

1. It bypasses the `fast_app()` function for table creation
2. It directly uses `fastlite` to create a table with the same schema pattern
3. It manually registers routes using `app.route()` instead of `register_routes(rt)`
4. It follows the same workflow discovery pattern already used in Pipulate

## Why This Works Well

Your solution unifies the two extension systems (CRUD apps and Workflows) under a single plugin architecture by:

1. **Database Independence**: Using MiniDataAPI (fastlite) directly instead of depending on the `fast_app()` factory
2. **Route Registration**: Handling route registration manually through the plugin
3. **Discovery Mechanism**: Leveraging the existing file-based discovery system from workflows

This keeps the best of both worlds - the DRY patterns from CRUD apps and the extensibility of the workflow system.

## Next Steps

To fully extract the Todo app using this pattern:

1. Create a `todo_plugin.py` in the plugins directory based on your competitor plugin
2. Modify the class names and schema to match your existing Todo app
3. Copy over the rendering logic from your current implementation
4. Remove the Todo-specific code from your main server.py (but keep the table definition if it's needed elsewhere)

This will effectively decouple the Todo app from the core initialization while maintaining all functionality.

The plugin approach gives you exactly what you described - the ability to easily create new variations of your CRUD apps by copying and tweaking plugin files without touching the core code.

