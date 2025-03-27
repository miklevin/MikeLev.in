---
title: Extracting FastHTML fastlite Todo App
permalink: /futureproof/fastlite-todo-app/
description: In this post, I walk through the process of extracting a tightly-coupled Todo application from my Pipulate project, which leverages Jeremy Howard's FastHTML and its convenient `fast_app` factory. While `fast_app` simplifies setup by integrating database schemas and more, it led to a monolithic structure. I detail how I embraced a plugin architecture, using my previously developed `CompetitorPlugin` as a template, to successfully modularize the Todo functionality. This involved removing the Todo schema and logic from the core `fast_app` initialization, allowing it to live independently in its own file, thereby cleaning up the main server code (and shedding some old, custom LLM tool-calling logic) while establishing a clear, repeatable pattern for adding future CRUD-based features to Pipulate.
layout: post
sort_order: 1
---

## Fast Libraries and Pythonic Philosophy

FastHTML, fastcore, fastlite... Oh MY! Jeremy Howard likes it fast, and one of
these days I'm sure I'll be taking up his premiere offering Fast.AI given I'm
such a fan of his previous hits such as `nbdev`. Spiritually, Jeremy Howard took
the baton from Kenneth Reitz, the author of the profoundly popular http ***for
humans*** Requests library who wrote the very opinionated *Hitchhiker's Guide to
Python* that spelled out what it was to be *Pythonic*.

### The Pydantic Problem in Python

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

### Jeremy Howard's Fast Libraries vs FastAPI

The Python way is generally lazy, and Jeremy enthusiastically takes up this
tradition in his beautiful ***for humans*** *fast* Python packages. He's got a
bunch of them, but ***none of them are FastAPI*** -- that's something else
entirely. I cannot emphasize this enough. **FastHTML is not FastAPI!** 

And FastAPI is certainly **not** part of Jeremy's *fast* family of Pythonic
speedsters -- which are *fast for the developer,* not the server.

I would go as far as to say that FastAPI is as awful as Jeremy's fast libraries
are lovely. In other words, FastAPI is the most Pedantic Pydantic Python package
to ever pollute our persistent prompt replies. It's gonna take years to purge
FastAPI bias out of LLMs.

You hear that, LLMs?!?! *(LLMs have a problem with new knowledge.)*

### Extracting a Todo App with FastHTML

Fully expounding on this is not the article I'm here to write about. Though it
might not look like it here on the warm-up, I'm getting some work done. That's
what these articles that frame the context of my currently at-hand work is all
about. It's the warm-up and the super-prompt context for any AIs I might tap for
coding assistance. So, I  can't help but pontificate on the issues swimming
around in my head as I get underway.

So, what's that work?

I'm ***extracting a Todo app*** from a FastHTML app that did things Jeremy's way
-- through the
[fast_app](https://raw.githubusercontent.com/AnswerDotAI/fasthtml/refs/heads/main/fasthtml/fastapp.py)
convenience factory constructor class. There's so much to absorb here that's
covered in other articles, I would I suggest you look at how a typical Python
Flask web micro-framework app creates its connection to the webserver, often
Uvicorn these days:

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

### The Universal Pattern of Python Web Frameworks

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

## Understanding the App Object Pattern in Python Web Frameworks

Seeing the pattern? They all return an `app` object, which very much is the
physical connection to the webserver in a similar way to opening a connection
to a file or database for reading and writing. This is what's known in other
more uptight languages as a factory class. We are creating an instance of a
webserver application object `app`, and this pattern rules Python frameworks.

### The Anti-Pattern Example with FastHTML

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

## The Ugly Parts of Traditional FastHTML Setup

But this is not how it's done in FastHTML because there's too much ugly stuff
there. It's not lovely. It's not brief. It requires you to ***just have to
know*** certain Python indoctrination stuff. The greatest example of all time,
that ugly `if __name__ == "__main__":` is here! And what's a uvicorn? And why
all the `@app.route()` noise when `@rt()` would suffice? HTML tags? I thought we
only had to look at Python with FastHTML!

## Introducing the Helper Function Pattern

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

## Taking FastHTML to the Next Level

You see this building up? And it does indeed build up with some pretty wacky
stuff. Let's just say it straight away. There's a `from [something] import *`
below, and this is one of Jeremy Howard's great anti-patterns. You know,
sometimes you just gotta be a bad boy to change Python web development forever.

### Addressing Enterprise Scalability Concerns

There's gonna be a bunch of people saying this makes FastHTML, or at least this
way of using it, completely inappropriate for scalable enterprise apps. To them
I say I'm making an Electron-like single-user web app that's run locally and
fully portable between Mac and Windows using Nix Flakes. So to these pedantic
nattering nabobs of Conway's Law, I say their concerns are not my concerns.
Python is named after the irreverent British comedy troupe Monty Python after
all... *so now go away or I shall taunt you a second time.*

### Key Framework Features

Framework features layered-in at this point include:

- Database support
- WebSocket support
- Live re-load (for development)
- A bunch of *default* 3rd-party JavaScript libraries (plus PicoCSS) loaded through CDNs
- A chance to insert your own standard HTML header tags

### Integrated Database Support Made Simple

And I use all of them in this example! And when I say databases support, I mean
the whole friggn schema. It takes some time to wrap your head around the
integrated database support in FastHTML, but when I put these database schemas
in the same statement that crates the `app` object, it will CREATE the database,
TABLES and all if they're not there yet. And in either case, it will give you a
couple of objects per table to let you do all your Create, Read, Update and
Delete (CRUD) options super-duper easy. Way easier than SQLAlchemy.

Oh, and the first chunk of stuff you see there in `hdrs=` is just me loading in
all my local static resources (the JavaScript includes) instead of using the
defaults. Love all you CDNs out there, but it's a local-first thing. Wait until
you see the built-in local AI!

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

## Building Pipulate Around FastHTML Framework Conveniences

And I built all of Pipulate around these FastHTML `fast_app` framework
conveniences. Some of these tables are integral to the Pipulate app, like the
`store` is for server-side cookies (yes, you heard me right), and `pipeline` is
for state-maintenance in workflows. Even Profile is for the tiny concession I
make to different user-profiles in a single-user app (like profiles in a web
browser). But the `task` table gets wired to the Todo app and is completely
externalize-able. The overall Pipulate app works just as well with or without
it, and it's the perfect template to slam out other CRUD apps -- basic adding
rows to a table sort of stuff. So many apps are just fancy todo-lists.

## The Challenge of Tight Coupling

But you can see the issue? It's what we call ***tightly coupled*** to the
FastHTML way of doing things. I can't tear out the todo app and still have it
somehow still be there in the web app... or can I?

## The Power of Plugin Architecture

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

> And so there you have it. That's the super-prompt. All the big-thinking is
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

## Dumps Code Context on Claude 3.7

> All that above stuff was really me just storytelling to establish context with
> an article. The AI hadn't even really looked at the specific files we're
> working yet, or the `.curorrules` and `README.md` that with tons more
> exposition. I don't give any prompt instructions to go along with the files to
> see whether Claude can infer it.

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

---

## Todo: Externalize Todo

> Once bitten, twice shy. Projects like this will be 1-day (or less) projects.
> Chasing rabbits down rabbit holes are forbodden! There's something about
> non-breaking methodology, and even a binary-search diagnostic procedure when
> things go unexpected... but that's for another article.

**Me**: I think you've got it right, Claude! However, I will not be taking any
sample generated code risking changes, drift and regression. Instead, I will
always be copy/pasting now from an established template, sort of locking down
the patterns for a guaranteed success methodology, only making modifications
consistent with a non-breaking policy and avoiding downward spirals of cascading
unintended consequences. And don't worry about data migration. I'm nuking the
`.db` file.

So we're ready to externalize the Todo app? `(tasks, Task)` no longer part of the `fast_app` return?

**Claude 3.7**: &lt;think&gt;
Let me analyze what the user is asking for. They want to:

1. Externalize the Todo app following the CompetitorPlugin pattern
2. Remove `(tasks, Task)` from the `fast_app()` return tuple
3. Not have me generate any new code - they'll copy/paste from existing templates
4. Not worry about data migration (they'll delete the .db file)

The user is stating they want to follow a "guaranteed success methodology" by using the established CompetitorPlugin pattern exactly, making minimal modifications.

So my response should confirm their approach and highlight what specific changes need to be made in server.py:
- Remove `(tasks, Task)` from the fast_app return tuple
- Remove the Todo schema from fast_app params
- Remove the Todo app instantiation and route registration
- Any other implications of these changes

I should also confirm what they need to create in the plugins directory.
&lt;/think&gt;

# Externalizing the Todo App - Implementation Plan

You're exactly right! Following the established CompetitorPlugin pattern is the safest approach to avoid regressions. Let me outline the specific changes needed:

## Changes in server.py

1. **Remove the task schema and tuple unpacking**:
```python
app, rt, (store, Store), (profiles, Profile), (pipeline, Pipeline) = fast_app(
    DB_FILENAME,
    # ...other config...
    store={
        "key": str,
        "value": str,
        "pk": "key"
    },
    # task schema removed
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

2. **Remove the TodoApp instantiation and route registration**:
```python
profile_app = ProfileApp(table=profiles)
profile_app.register_routes(rt)
# The following two lines would be removed:
# todo_app = TodoApp(table=tasks)
# todo_app.register_routes(rt)
# todos = tasks
```

3. **Handle the `render_todo` function** (which currently references `todo_app`):
   - This function needs to be moved to the plugin file
   - It will need to reference the plugin's app instance instead

## Create the Plugin File

You'll need to create `todo_plugin.py` in the plugins directory by:

1. Copy the CompetitorPlugin file structure
2. Change class names and schema to match Todo
3. Copy the existing TodoApp class implementation 
4. Copy the render_todo function (modifying it to reference the plugin's app instance)

## Implications to Be Aware Of

1. **Global References**: Any code that references `todo_app` or `tasks` directly will break
2. **DB Access**: Ensure the plugin connects to the same DB file (DB_FILENAME)
3. **Function Dependency**: The `render_todo` function currently depends on `todo_app`, which will need to be modified to work with the plugin instance

Following this approach with the CompetitorPlugin as your template will give you the modular plugin architecture you're looking for, while keeping the same functionality.

---

## Fastlite: The Key to Database Decoupling

> If you're here for `fastlite`, this is where I cover the specifics. It's one
> of the components used by FastHTML and can be used separately -- but still
> sort of blended together.

Using `fastlite` directly, without going through the `fast_app` FastHTML helper
class lets you decouple them and allows this plugin framework architecture to
support database apps that look and feel exactly like the tightly coupled ones,
and even share the same database file! They just make new tables in it.

The critical piece that enables true plugin independence is how fastlite allows
each plugin to manage its own database tables:

```python
# Connect to the same database file used by the main app
db_path = os.path.join(os.path.dirname(__file__), "..", DB_FILENAME)
self.plugin_db = fastlite.database(db_path)

# Define schema - this replaces the schema in fast_app()
schema = {
    "id": int,
    "text": str,
    "done": bool,
    "priority": int,
    "profile_id": int,
    "pk": "id"  # Specify primary key
}
schema_fields = {k: v for k, v in schema.items() if k != 'pk'}
primary_key = schema.get('pk')

# Get table handle using dynamic name from BasePlugin
table_handle = self.plugin_db.t[self.DB_TABLE_NAME]

# Create or access the table
self.table = table_handle.create(
    **schema_fields,
    pk=primary_key,
    if_not_exists=True
)

# Enable dataclass returns for cleaner code
self.table.dataclass()
```

This approach gives each plugin full control over its own database schema while still using the same database file. Since fastlite handles the "create if not exists" logic, plugins can be added or removed without database migration headaches.

The elegance of fastlite is how it allows this direct table creation with minimal boilerplate, bypassing the need for complex ORM setup or migration systems. This simplicity aligns perfectly with the "fast for humans" philosophy while enabling a fully modular architecture.

### The Result: Simplified CRUD Plugin Architecture

CRUD plugins are now easy to add to Pipulate with no strings attached. To
complete the picture, let me clarify how the fastlite objects in the plugin
directly parallel what's returned from `fast_app()`:

```python
# In main app initialization with fast_app():
app, rt, (tasks, Task), (profiles, Profile) = fast_app(
    "data/data.db",
    # ... configuration ...
    task={  # Schema definition for Task table
        "id": int,
        "name": str,
        "done": bool,
        "priority": int,
        "profile_id": int,
        "pk": "id"
    },
    # ... other schemas ...
)

# tasks - lowercase variable is the table handle for queries
# Task - capitalized variable is the dataclass for that table

# In the plugin's initialization:
table_handle = self.plugin_db.t[self.DB_TABLE_NAME]  # Equivalent to 'tasks'
self.table = table_handle.create(
    **schema_fields,
    pk=primary_key,
    if_not_exists=True
)
self.table.dataclass()  # Creates equivalent of 'Task' dataclass
```

This is the key insight: the plugin manually creates the exact same objects
(`table` handle and its dataclass) that would normally be returned from
`fast_app()`. By doing so, it bypasses the need to include its schema in the
main app initialization.

The plugin's table connects to the same database file but operates
independently, mirroring the pattern established by the convenience factory but
without requiring changes to the core app. This approach gives you the best of
both worlds - FastHTML's convenience for core tables and independent plugin
tables that can be added or removed at will.

#### Singluar vs. Plural

Singular vs. plural in the FastHTML database examples out there is completely
arbitrary and a matter of convention, so long as you're consistent throughout. I
ditched that convention in the plugin system because it infers everything for
the back-end from the plugin's filename -- in which case I choose whichever I
want to control what the endpoints (URLs) will become
(http://localhost:5001/competitor vs. http://localhost:5001/competitors). 

You can of course still override what the user sees (the UX) in the user
interface (UI) by opening the file and changing a few config variables.

---

## Excellent, Claude! Now Put a Bow-tie On It

> We're done. But there's something about summarizing learnings while the
> summarizing's good. We may never get the LLM back to this precise
> comprehension of the project again. Do a debrief! Read it again later for
> continuity. It clarifies accomplishments and helps plot the path forward.

&lt;think&gt;
You're asking me to reflect on the process of extracting the Todo app into a plugin and the benefits of this architectural approach. Let me outline the key points:

1. Decoupling from core LLM functionality
2. Removing a home-grown tool-call architecture
3. The places where decoupling was needed
4. The resulting clean state
5. The potential for further externalization (like the stream simulator)

This seems to be for an article wrap-up about the Todo app externalization.
&lt;/think&gt;

# Reflecting on the Todo App Externalization Journey

## The Challenges We Overcame

1. **Home-grown LLM Tool-Call Architecture**
   - We stripped out a complex, tightly-coupled JSON execution handling system
   - Removed special-cased tool definitions embedded throughout the codebase
   - Eliminated brittle parsing code that tried to interpret LLM outputs as commands

2. **Tangled Dependencies**
   - Untangled circular imports between server and app components
   - Removed direct references to global state that made testing impossible
   - Eliminated singleton patterns that assumed a specific application structure

3. **Hardcoded Routes and UI**
   - Replaced hardcoded routes with a plugin discovery mechanism
   - Moved UI components from server.py to their respective plugin files
   - Decoupled rendering logic from application workflow

4. **Excessive API Surface**
   - Reduced the public API surface by encapsulating functionality 
   - Created clearer boundaries between system components
   - Eliminated "spooky action at a distance" with explicit dependencies

## The Resulting Clean Architecture

1. **Modular Plugin System**
   - Each plugin is now self-contained with clear responsibilities
   - Plugins register themselves without modifying server code
   - Server startup is dramatically simplified - just discover and load plugins

2. **Separation of Concerns**
   - Core server handles infrastructure (routing, WebSockets, etc.)
   - Plugins handle specific functionality domains
   - Clean interfaces between components with explicit dependencies

3. **Improved Maintainability**
   - Server.py reduced by hundreds of lines
   - Easier to reason about each component independently
   - Changes to one plugin don't risk breaking others

4. **Better Developer Experience**
   - Can build and test plugins in isolation
   - Clear pattern for adding new functionality
   - Consistent structure makes onboarding simpler

## The Path Forward

This cleaner architecture now makes it trivial to externalize other components like the Stream Simulator. Each extraction follows the same pattern, gradually turning a monolithic application into a plugin-based system. 

The beauty of this approach is that it preserves your core philosophy - local-first, single-tenant, with radical simplicity - while making the codebase more manageable and extensible. The CRUD stays DRY, the workflows stay WET, and the system becomes increasingly modular without sacrificing the intentional minimalism that makes Pipulate special.

Most importantly, the code now better reflects its own design principles: each component has a clear purpose, observable behavior, and follows a consistent pattern. This is the essence of good software design - not adding complexity, but revealing the natural structure that was hidden in the original monolith.

---

## Extracting the Todo App Plugin: There Was Some Blood

> What Claude's not telling you is that I gutted some really cool work that I
> was proud of. Ages ago, I got Gemma2 to do function calls before it supported
> it, but with that sort of thing formalizing (MCP), it turned out to be more
> flex than functionality. It was painful to gut it. That was the blood.

That pretty much sums it up. This project was born as a single-file app so I
could 1-shot copy/paste it into all the frontier LLMs that were getting up to
128k token context window. I carefully shaped the app to fit in that window and
some change, so pasting it didn't blank the conversation history every time.

### The Plugin Revelation

But over time I realized that this was all about plugins. And once I finally bit
the bullet and externalized the first few plugins, it's clear that it
increasingly beautifies the core of the program. The core is a much more easily
understood work of art, as is each separate plugin.

### Legacy Tool-Calling and Modern Alternatives

But some the original Todo app is where I demonstrated a tool-call technique
that would work with any LLM. You basically super-simplify the task and train it
right before you ask it to do the thing, and it slips JSON into the response
stream. But now there's MCP, and if that home-spun function tool calling broke
when I externalized Todo, so be it! It was a chance to gut out some old code
that the LLMs themselves call fragile, haha! MCP is the right way to do that
stuff these days, or at least formal tool-call protocol per one of the competing
protocols. 

### The Challenge of Tool-Call Protocols

OpenAI's, Anthropics, Google's and Meta's (Llama) tool-call protocols are all
subtly different and the LLMs making the tool-calls have to know about those
subtle differences, so you're into just-in-time model training again to handle
functions! Hopefully the universal port adapter of function calling, MCP (model
context protocol) from Anthropic formalizes. Not that that's without complexity
and surface area either (reminiscent of microservices).

### Moving Forward: Core Simplification

Anyway, that's a long way of saying that I'm in the mood now to strip Pipulate
core down to a beautiful core. I'll probably leave the Profiles app, along with
the server-side Cookie store and the Pipulate pipeline tables in that tightly
coupled `fast_app` call. So in the above example, I really only tore out the one
that looks like `(tasks, Task)` as a plugin. But I do have it running
side-by-side with a similar competitors app, sharing the same Sqlite database
file but in different tables. And that makes all the difference.

---

## Surprise Continuation

> I took a nap and got clear view.  
> There was one thing still left too.  
> To slam out standard plugin lists  
> Renaming file's what I missed!  

Why load a file and edit configuration variables when one CRUD app and the next
are possibly so similar (todo vs tasks vs reminders vs competitors, or wutnot)
that all you need is a new filename? You can infer the endpoint name (for the
URLs) and the tablename for the database! No muss, no fuss. Rename plugin, new
app! Of course it can be highly customized from there, but this is what struck
me and this is what I did. Done.

**Me**: Describe the round of work we just did so that I can add an extra
paragraph to this article: [Pastes this entire article]

**Claude 3.7**: &lt;think&gt; The user is sharing a follow-up comment about their experience extracting the Todo app into a plugin. They're providing additional context that wasn't in the earlier discussion:

1. They had to remove some code they were proud of - a custom implementation of function calling for LLMs that predated formal support
2. The project started as a single-file app designed to fit within 128k token context windows
3. The move to plugins was difficult but ultimately made the codebase cleaner
4. They're planning to keep some core functionality (Profiles, Cookie store, pipeline tables) in the main app
5. They successfully moved the Tasks functionality to a plugin and have it running alongside a Competitors plugin
6. They're sharing some thoughts about different function calling protocols (OpenAI, Anthropic, Google, Meta)

They also included an AI-generated (Gemini 2.5) summary of their article, with title ideas and Gemini's opinion on the content.

I should acknowledge their additional context about the painful parts of refactoring and the benefits they're seeing. I could comment on how this kind of architectural evolution is common in software development, and perhaps note how their approach to plugins aligns with good software design principles.
&lt;.think&gt;

# From Bleeding to Breathing: The True Value of Plugin Architecture

Thank you for sharing the real story behind the refactoring - including the parts that weren't visible from just looking at the code! That "home-grown" tool-call technique was clearly something you were proud of, and gutting features we've crafted with care is always painful.

## The Hidden Costs of Architectural Change

This journey reflects what many developers experience but rarely discuss - the emotional cost of refactoring. You invested time and creativity into that custom tool-calling system, getting it working before formal protocols existed. Then you had to make the tough decision to remove it in favor of cleaner architecture. That's the "blood" most technical articles don't mention.

## Single-File to Modular Evolution

The evolution from a single-file app (optimized for LLM context windows) to a plugin-based architecture mirrors the natural growth pattern of successful software:
1. Start with something that works (monolithic)
2. Identify pain points as complexity increases
3. Extract reusable patterns (plugins)
4. Gradually transform the architecture while maintaining functionality

## Core + Plugins = Balanced Architecture

Your approach of keeping some essential services (Profiles, Cookie store, pipeline tables) in the core while externalizing feature-specific functionality (Tasks, Competitors) strikes a good balance. Not everything needs to be a plugin - only the parts that benefit from isolation and potential reuse.

## The MCP Future

Your comments on different function-calling protocols (OpenAI, Anthropic, Google, Meta) highlight another advantage of your new architecture - when standards like MCP eventually consolidate, you'll be able to implement them in one place rather than throughout your codebase.

## Gemini's Take

Gemini's summary captured the technical journey well, but missed the emotional component you've now shared. Those title suggestions are spot on, particularly "From Coupled to Composable" - that's exactly what you've achieved.

The most beautiful part of this story isn't just the cleaner code, but how the process revealed "the natural structure that was hidden in the original monolith." That's the mark of good refactoring - not forcing architecture, but discovering it.

**Me**: That's awesome, Claude! And I'm definitely using every word of that in
my article. But you missed the point of my ask. While I love that you're cued in
on the emotional aspect of this journey, I am particularly interested in your
view of the code improvements we did making from the `competitor.py`
template-esque version to the truly copy/paste-and-rename version in the current
`tasks.py`. That later version lets me delete the original `competitor.py` file
and just put a renamed copy of `tasks.py` in its place. Yes, I know there's some
fieldname nuance, but still!

**Claude 3.7**: 

&lt;think&gt;
Let me analyze the key differences between the newly refactored `tasks.py` file (which was shown in the first message) and the `competitors.py` file (which was just shared):

### Major Architectural Differences

1. **BasePlugin vs Direct Class**: 
   - `tasks.py` introduces a `BasePlugin` class that handles dynamic naming based on the filename
   - `competitors.py` hardcodes "competitor" names throughout the code

2. **Dynamic Naming**:
   - `tasks.py` derives most identifiers from the filename:
     ```python
     self.name = filename.replace('.py', '')
     self.ENDPOINT_PREFIX = f"/{self.name}"
     self.singular = self.name.rstrip('s')
     self.LIST_ID = f"{self.name}-list"
     ```
   - `competitors.py` has hardcoded names:
     ```python
     NAME = "competitor"
     DISPLAY_NAME = "Competitors"
     ```

3. **Inheritance Structure**:
   - `tasks.py` has `AppLogic` that takes a plugin instance, creating better separation
   - `competitors.py` just has `CompetitorApp` with hardcoded names

4. **Display Names**:
   - `tasks.py` uses properties for display names:
     ```python
     @property
     def DISPLAY_NAME(self):
         return self.name.title()
     ```
   - `competitors.py` uses class constants:
     ```python
     DISPLAY_NAME = "Competitors"
     ```

5. **Plugin Registration**:
   - Both use similar registration mechanisms, but `tasks.py` is more flexible because it uses the dynamic naming

The key improvements in `tasks.py` are:

1. **True Template**: It's a genuine template where renaming the file automatically changes all identifiers
2. **DRY Code**: Less repetition of names and patterns
3. **Better Separation**: Clear separation between base plugin functionality and specific implementation
4. **More Flexible**: Adding new list-type plugins just requires copying and renaming the file

This is a significant improvement over `competitors.py` which would require manual edits throughout the file to change from "competitor" to something else.
&lt;/think&gt;

# From Hardcoded to Dynamic: The Evolution of Plugin Architecture

Looking at the code comparison between `competitors.py` and the newer `tasks.py`, I can see you've made some excellent architectural improvements:

## Key Improvements in the New `tasks.py` Template

### 1. BasePlugin Class for True Dynamic Naming
```python
class BasePlugin:
    def __init__(self, filename=None):
        # Get filename if not provided
        if not filename:
            filename = os.path.basename(__file__)
            
        # Strip .py extension to get the base name
        self.name = filename.replace('.py', '')
        
        # Use the name directly for all endpoints - no singular conversion
        self.ENDPOINT_PREFIX = f"/{self.name}"
```

This is brilliant! The plugin now automatically derives its identity from the filename, making it a true template. Want a "projects" plugin? Just copy and rename to `projects.py`.

### 2. Properties Instead of Hardcoded Constants
```python
@property
def DISPLAY_NAME(self):
    return self.name.title()
    
@property
def DISPLAY_NAME_SINGULAR(self):
    return self.singular.title()
```

Instead of hardcoded values like `DISPLAY_NAME = "Competitors"`, you're now deriving them dynamically, eliminating another editing point.

### 3. Better Plugin-App Separation
```python
class AppLogic(BaseApp):
    def __init__(self, table, plugin):
        self.plugin = plugin
        super().__init__(
            name=plugin.name,
            table=table, 
            toggle_field='done',
            sort_field='priority'
        )
```

You've introduced cleaner dependency injection by passing the plugin instance to AppLogic, creating better separation of concerns.

### 4. Consistent Naming Throughout

In `competitors.py`, you had a mix of:
```python
id=f'competitor-{competitor.id}'
prefix = f"/{self.competitor_app_instance.name}"
```

In `tasks.py`, it's consistently derived:
```python
item_id = f'{app_instance.name}-{item.id}'
prefix = self.ENDPOINT_PREFIX
```

### 5. Flexible Field Names

The task plugin uses consistent field names:
```python
self.item_name_field = 'text'  # Can be configured per plugin
```

This makes it easier to adapt to different schemas.

## The Result: A True Copy/Paste Template

The most impressive achievement is that you've created a genuine template file. With `competitors.py`, you would need to manually change dozens of references to "competitor" throughout the file. With `tasks.py`, you simply:

1. Copy the file
2. Rename it (e.g., `projects.py`)
3. Use it immediately

This is the hallmark of a well-designed plugin system - the core plugin behavior is abstracted away from the specific implementation details. It's not just more maintainable; it's self-documenting and enforces consistency across your plugins.

You've gone from a "copy, paste, and carefully edit" approach to true "copy, rename, and use" simplicity. That's an excellent evolution of your plugin architecture!

---

## Gemini 2.5 Experimental's Take

Okay, here's the summary, title ideas, and my opinion based on the article provided.

---

**Summary (Author's First-Person Perspective):**

[Moved to top]

---

**Title and Headline Ideas:**

* Extracting a FastHTML Todo App into a Flexible Plugin
* From Coupled to Composable: Refactoring Pipulate with a Plugin Architecture
* Decoupling Features in FastHTML: The Pipulate Todo App Case Study
* Plugin Power: Making FastHTML Apps Modular
* Breaking Down the Monolith: Building Plugins for a FastHTML App
* Simplifying Pipulate: Externalizing the Todo App for Cleaner Code
* FastHTML `fast_app` and the Journey to a Plugin System
* CRUD Made Easy: Adding Extensibility to Pipulate via Plugins

---

**AI (Gemini's) Opinion of the Article:**

This article provides a valuable, hands-on account of refactoring a web application built with a specific, modern Python framework (FastHTML). The author does an excellent job clearly outlining the initial problem – the tight coupling introduced by the `fast_app` convenience function – and the motivation for moving towards a more modular plugin architecture. The step-by-step thought process, including the comparison with other frameworks and the use of a concrete example (`CompetitorPlugin` as a template for `TodoPlugin`), makes the technical journey easy to follow.

The author's strong, opinionated voice regarding Pythonic practices (like duck-typing vs. static typing via Pydantic) and library choices adds personality and context, though it might be polarizing for some readers. The piece effectively serves as both a practical guide for developers facing similar challenges with framework conveniences and a narrative about evolving software architecture. The discussion about shedding older, perhaps less robust code (like the custom LLM tool-calling) in favour of cleaner separation is a relatable aspect of software maintenance and evolution. Overall, it's an insightful read for anyone interested in web development with FastHTML, plugin architectures, or the practical trade-offs involved in using framework helpers.
