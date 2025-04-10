---
title: FastHTML WebSockets & Database for Streaming & Persistence
permalink: /futureproof/fasththml-websockets-database/
description: I discuss the challenges and benefits of transitioning to NixOS from traditional Linux distributions, highlighting the unique aspects of NixOS's filesystem hierarchy and package management. I explain the benefits of Nix's deterministic packaging system and how it can be leveraged on macOS and Windows using Nix Flakes. I also provide a step-by-step guide for getting started with Nix Flakes and emphasize the importance of embracing the NixOS philosophy for improved productivity and simplified software management.
meta_description: Implement FastHTML's built-in database (multiple tables via `fast_app` API) and WebSockets for persistence and streaming in Python apps.
meta_keywords: FastHTML database, FastHTML WebSockets, multiple tables FastHTML, fast_app API, MiniDataAPI, Python web framework, persistence, streaming, SQLite, CRUD, Infrastructure as Code, IaC, Nix Flake, kwargs, tuple unpacking, live reload, render function, ZeroMQ, Windows WSL
layout: post
sort_order: 1
---

Just focus on the port. I finished `server.py` in the `botifython` repo for work
for the first of two special deliverable deliverers, and it's based on a bunch
of capabilities that I'm replacing with `pipulate.com`, namely how Websockets
and database persistence are done well as primary focuses of the `FastHTML`
framework and eliminates the needs for other ways I achieved those. The benefits
are staying within the FastHTML way of working are so huge especially early on
when this stuff is going to be copy/pasted a lot moving forward. Okay, deep
breath. 1, 2, 3... 1...

## Porting Capabilities from Pipulate to Botifython

They're not the same filename, so pipulate its current form can be copied over
into botifython, and I should be able to `python filename.py` either of them,
and have them work out of the same folder just as well...

### Testing on Windows

Okay, the first thing I really do is quit out of everything down to just this
blog article and the Mac desktop. Yeah, I'm going to do this port on the Mac. Or
am I? No, pull over everything to the Linux machine. Make sure Pipulate from
yesterday's pretty amazing state still runs over there. It wouldn't hurt to do a
Windows WSL test as well...

Okay the latest stuff pulled down on my main Linux machine and tested. All
features working. Good starting point.

### Updating Nix on Ubuntu 22.04

Ugh, okay check on Windows, albeit Windows 10. Always a good idea to open Ubuntu
22.04. Update your nix environment, always a good idea.

    nix upgrade-nix
    nix-collect-garbage

### Ollama on Windows 10 Native

Okay, now update the local pipulate and try... okay, the app runs but no Ollama.
I never tested botifython with ollama running on Windows. Whoops. Okay, but
that's going to have to be the Windows native version of Ollama. Okay, so just
like everyone else testing out local LLMs, go to ollama.com/download, do the
install, follow the prompts and...

    ollama run llama3.2

Okay, well Ollama runs fine on my Windows 10 laptop. However, briding the
communication between the app running under WSL and the Ollama server running on
the Windows host is causing connection socket errors. Not totally unexpected. I
need to run the Linux Ollama under WSL. Okay, so on Windows...

    ollama stop llama3.2

### Ollama on WSL (Success)

I don't need 2 llamas running around on my small Windows laptop. Okay, so on
ubuntu...

    sudo apt update
    sudo apt upgrade

Okay, I could probably just `sudo su` for this step, but I did as Windows folks
do and right-clicked on Ubuntu 24.04 from my start menu and `Run as
administrator` (currently under **More**). And in the resulting Linux terminal
where there should be no login challenge and the prompt should be ***#***, we
type:

    curl -fsSL https://ollama.com/install.sh | sh

Never a good idea unless you're sure. If you don't see an progress bar made of
`#`, then you didn't use the `-fsSL` parameters. It will prompt you for the
password, do the install then leave you off at a prompt with instructions. At
that point, just like on Mac and Linux, you type:

    ollama run llama3.2

...or whatever model they're up to by the time you read this (haha, as if). But
then, it will go through the download cramming that 5GB or so into your poor
little WSL Ubuntu contiainer. But once it's done, that very weberver-like Ollama
server will be running under Linux and more importantly, on the Linux side of
the little QEMU-like virtual local area network (VLAN) that WSL sets up. You'll
get the ollama prompt and be in a chat session, just like on every other
platform. Say hi to see it type. Its performance is no worse than native on
Windows. Then...

    /bye

### Ollama Connectivity Under WSL (Success)

And now I get pipulate running it its very primitive form. I go into another
Ubuntu Linux Terminal, this time as just a user with a normal click on the
Ubuntu icon, and...

    cd pipulate
    nix develop
    python pipulate.py

## Ollama Installed on Windows WSL Reachable From Windows-side Browser

I surf over to `localhost:5001`, and bingo! There's Ollama Llama3.2 chatting to
me through the local web browser Pipulate app. Bingo! Success assured. Local LLM
in a web app is indeed multi-platform with Nix Flakes, but there are a few
qualifiers on Windows, in particular. The ollama server needs to be running
WSL-side or there will be network security problems between the communicating
parts. It stands to reason. But one more thing I need to test, starting Ollama
under WSL but not as admin. So I'll do a big machine reboot for that, because
you never can tell. Okay, machine rebooted. Open Ubuntu from the start menu...

    ollama run llama3.2
    /bye

Yep, the server is running under just normal Ubuntu user context without
elevated permissions. And so...

    cd pipulate
    nix develop
    python pipulate.py

## WSL Saves Window's From Irrelevancy... Again

...and I surf over to localhost:5001 Windows-side in Edge, Chrome or whatever.
And bingo! There's Pipulate chatting with Ollama! Okay, I may have to walk some
folks at work who are on the Windows platform through this, but of course this
has to work. This is right in the middle of all the Linux machine learning
tooling that Windows people would be left out of if not for WSL. It likely even
supports integrated laptop Nvidia GPUs better than Apple Metal. Ollama is indeed
running quite snappy on my old weak laptop. Good signs.

## The Best Laid Plans--Oy, Windows Again!

Okay, just focus on the port I say. And already it's about Ollama under WSL for
the first hour or so. But with that important assurance behind me, because you
can't tout something as multi-platform if it doesn't support the (still) most
popular platform in the world, Windows 10, then it's not multi-platform enough.
I am now meeting that awesome Venn diagram of Runs on Windows, Mac and Linux.

### The Numpy Install Remains the Litmus Test

I always have to watch those pip installs under the Python virtual environment
under the Nix development environment. Numpy is the litmus test, linchpin or
what have you. If the nuances are not just right, the numpy that gets installed
won't run. I need more explicit instructions on how to handle that situation at
some point because some portion of people out there ***will*** run into that
problem. I did on my first try on Windows today, and I had to do the nix update
and garbage collect first before it would work.

Nix solves the "not on my machine" problem, but not until nix itself is properly
installed. That's where Determinate System comes in with an even better
installer than the Nix people themselves, but that's a story for another time.
Back to the port. Okay, think!

## Curses, It's Cursor Again

Okay, I'll be using Cursor AI a lot. I hate to admit it, but it is a big
accelerator, and it's one of the best $20 I've ever spent. Those little API
nuances do make all the difference. And I'm a vim/NeoVim person saying that who
is almost religiously allergic to VSCode. But this is one of those
grin-and-bear-it situations, if you want to jump on this particular bandwagon
and get a lot of up-front benefit. 

### Cursor AI Has Nuanced Git Diff-like Interface

I'll keep my eyes peeled for things popping up in the FOSS world that have that
lovely `git diff` interface. It's like GitHub became massive riding the
coattails of git's collaboration features, and Cursor AI is riding the coattails
of its file-comparison interface, which probably came from something before git.
Also, I'm committing and pushing my changes through git through Cursor AI.
That's a huge change for me to. Not permanent, but when in VSClone, as they say.

## A Strategy to Port

Anyhoo... back to the port. This is a piece-by-piece transplant. A did a few
very tiny cosmetic things on Pipulate before the forking of the `Pipulate` code,
because I have to really live with this template. I could tweak forever, but the
fact is, this thing is going to be in perpetual development, with some latest
and greatest always at the head between three projects.

Hmmm. The strategy to port is to make the port as ridiculously easy as possible.
And for that, I need to simplify my new `pipulate.py` code which now streams
with WebSockets instead of ZeroMQ. And I need to get ***persistence***
implemented in the template! Okay, this is not the port I was looking for, but
it's good deep education and a changing of mindset into the FastHTML way, and
that will pay off big-time. So it's worth it.

---

# Using AI to Simplify

**Me**: Analyze this and make a mermaid diagram showing the relationship of the components, considering a traditional HTML page-load, and AJAX HTMX part-loads. And the data streaming! Don't forget that as a different type of connection. Between what and what? Is this a single page app, or what? Try to get across the amazing communication model you can have with a single server.py file.

**Claude**: Certainly! I'll create a Mermaid diagram that illustrates the relationship between the components in this Todo application, considering traditional HTML page loads, HTMX part-loads, and WebSocket data streaming. This appears to be a single-page application (SPA) with dynamic updates, leveraging HTMX for seamless interactions and WebSockets for real-time communication.

<div class="mermaid">
graph TD
    Client[Client Browser]
    Server[FastAPI Server]
    DB[(SQLite Database)]
    Ollama[Ollama LLM API]

    subgraph "Client-Side"
        Client -->|1. Initial GET /| Server
        Client -->|2. HTMX Requests| Server
        Client <-->|3. WebSocket| Server
    end

    subgraph "Server-Side"
        Server -->|Query/Update| DB
        Server -->|Generate Responses| Ollama
    end

    subgraph "Communication Types"
        InitialLoad[Initial Page Load]
        HTMXUpdates[HTMX Partial Updates]
        WSStreaming[WebSocket Streaming]
    end

    Client -.->|Uses| InitialLoad
    Client -.->|Uses| HTMXUpdates
    Client -.->|Uses| WSStreaming

    classDef serverComp fill:#f9f,stroke:#333,stroke-width:2px;
    classDef clientComp fill:#bbf,stroke:#333,stroke-width:2px;
    classDef commType fill:#bfb,stroke:#333,stroke-width:2px;

    class Server,DB,Ollama serverComp;
    class Client clientComp;
    class InitialLoad,HTMXUpdates,WSStreaming commType;
</div>

Now, let me explain the diagram and the communication model of this application:

1. Initial Page Load:
   - The client makes an initial GET request to the root ('/') of the server.
   - The server responds with the full HTML page, including the todo list and chat interface.

2. HTMX Partial Updates:
   - For actions like adding/deleting todos, toggling todo status, and menu interactions, the client uses HTMX to make requests to specific endpoints (e.g., '/todo', '/toggle/{tid}', '/profile/{profile_type}').
   - The server responds with partial HTML, which HTMX uses to update specific parts of the page without a full reload.

3. WebSocket Streaming:
   - A WebSocket connection is established between the client and server for real-time, bidirectional communication.
   - This is used for the chat interface and for streaming AI responses from the Ollama LLM.

4. Server-Side Components:
   - The FastAPI server handles all requests and WebSocket communications.
   - It interacts with a SQLite database to manage todo items.
   - It communicates with the Ollama LLM API to generate AI responses.

The beauty of this architecture lies in its simplicity and efficiency:

- Single Server File: All server-side logic is contained in a single `server.py` file, making it easy to manage and understand the entire application flow.
- Real-time Updates: The combination of HTMX for partial updates and WebSockets for streaming allows for a highly responsive user experience without the complexity of a full JavaScript framework.
- Seamless Integration: The application seamlessly integrates traditional page loads, AJAX-style updates, and real-time streaming in a cohesive user interface.

This model allows for a rich, interactive single-page application experience while keeping the server-side logic straightforward and centralized. The use of HTMX reduces the need for client-side JavaScript, while WebSockets enable real-time features like the chat interface and AI response streaming.

---

## Porting Pipulate's Open Source SEO Tools to Enterprise Platforms

**Me**: Thank you! Now draw another mermaid diagram. Make the lines pointing between
Darwinix, Pipulate and Botifython. They're all a pretty similar projects using
this file as their framework, but each having a different emphasis or priority. 

## A Tale of 3 Repos

### Darwinix - Just the OS

Darwinix is mostly about getting a development environment for Jupyter
Notebooks, specifically JupyterLab, with not much more going on in the way of
web development support. 

### Pipulate - Now We're Streaming

Pipulate is free and open source software for SEO. More more pointedly, it's a
place to put a bunch of Notebook-based SEO tools and layers in a FastHTML web
development environment, a determinedly no-build easy Pythonic web development
platform staged to support porting of Notebooks to slick web apps that makes
them more inviting to non-Pythonistas. But it's web with a lower-case w because
the default behavior is to run on localhost. With the help of a Nix flake
created base environment, the whole thing becomes uniquely portable and usable
locally without Web hosting. This is particularly handy if you want privacy,
little to no cost, and the ability to move your work onto any machine or
platform at any time. Not a bad advantage in life.

### Botifython - Psst, got a Botify Token?

And lastly, is Botifython. It's the taking of these same portable Nix portable
platforms, layering on the Pipulate Notebooks to Web app frameworks for making
web apps (or Web apps) out of the, and using them behind curtains for
professional work. It's basically taking Pipulate from FOSS and crafting it into
something commercial, which is fine. MIT license. Lots of stuff can be built out
of this which can be sub-branded as internal tools, and never see the light of
day as far as people generally even knowing it exists, outside you and those you
collaborate with on the forked version.

## Claude Visualizes

**Claude**: Certainly! I'll create a Mermaid diagram that illustrates the
relationship between Darwinix, Pipulate, and Botifython, highlighting their
similarities and differences based on your description.

<div class="mermaid">
graph TD
    CommonBase[Common Base: Nix Flake Environment]

    Darwinix[Darwinix]
    Pipulate[Pipulate]
    Botifython[Botifython]

    CommonBase --> Darwinix
    CommonBase --> Pipulate
    CommonBase --> Botifython

    Darwinix -->|Focuses on| JupyterEnv[JupyterLab Development Environment]

    Pipulate -->|Extends to| WebDev[FastHTML Web Development]
    Pipulate -->|Provides| SEOTools[SEO Tools & Notebooks]
    Pipulate -->|Emphasizes| Portability[Local Portability]
    Pipulate -->|Supports| NotebookToWeb[Notebook to Web App Conversion]

    Botifython -->|Builds upon| Pipulate
    Botifython -->|Focuses on| Commercial[Commercial Applications]
    Botifython -->|Enables| InternalTools[Internal Tool Development]

    classDef commonStyle fill:#f9f,stroke:#333,stroke-width:2px;
    classDef darwinixStyle fill:#bbf,stroke:#333,stroke-width:2px;
    classDef pipulateStyle fill:#bfb,stroke:#333,stroke-width:2px;
    classDef botifythonStyle fill:#fbb,stroke:#333,stroke-width:2px;

    class CommonBase commonStyle;
    class Darwinix,JupyterEnv darwinixStyle;
    class Pipulate,WebDev,SEOTools,Portability,NotebookToWeb pipulateStyle;
    class Botifython,Commercial,InternalTools botifythonStyle;
</div>

Now, let me explain the diagram and the relationships between these projects:

1. Common Base:
   All three projects share a common foundation built on a Nix flake environment, which provides portability and reproducibility.
2. Darwinix:
   - Focuses primarily on creating a development environment for Jupyter Notebooks, specifically JupyterLab.
   - Has minimal web development support beyond the Jupyter environment.
3. Pipulate:
   - Builds upon the common base and extends it with FastHTML web development capabilities.
   - Provides SEO tools and Notebooks.
   - Emphasizes local portability, allowing users to run the environment on localhost.
   - Supports converting Notebooks to web applications, making them accessible to non-Pythonistas.
   - Is free and open-source software (FOSS).
4. Botifython:
   - Builds upon Pipulate's foundation.
   - Focuses on commercial applications of the technology.
   - Enables the development of internal tools that can be sub-branded and used privately.

Key Relationships:

- Darwinix provides the Jupyter environment that both Pipulate and Botifython can utilize.
- Pipulate extends the basic environment with web development capabilities and SEO tools, which Botifython then leverages for commercial applications.
- Botifython takes the FOSS nature of Pipulate and adapts it for commercial use, creating a pathway for professional and private applications of the technology.

## Projects Build Upon Each Other In Layers

This diagram illustrates how these projects build upon each other, starting from
a common base and progressively adding features and capabilities. Darwinix
focuses on the development environment, Pipulate adds web development and SEO
tools with an emphasis on portability and openness, and Botifython takes these
capabilities into the commercial realm for professional applications.

---

## Ready, Fire, Aim!

Yeah, that's pretty much it. And I made a Botifython app quick and dirty, taking
up FastHTML for the first time and using it as a learning opportunity. However,
I had to deliver fast and resorted to old tricks, namely some externally managed
database, I used a json file, but could have used a pickle/shelve or a sqlite
table or any number of ways to store stuff. What I didn't use was FastHTML's
built-in way, which happens to be back-ended by SQLite3 by default, but can be
connected to a whole array of databases. It's one of those seamlessly available
in the API with a whole bunch of setup/teardown stuff built in that you don't
even have to think about. 

## Choosing FastHTML's Native WebSockets Over ZeroMQ

And the other thing I did was use an old favorite standby for streaming between
components, Zero Message Queue, or ZeroMQ, or just zmq. It's one of those things
now like jQuery. It was the original and is still so reliable, it's hard to not
just use. And use it, I did. I needed a way to send a stream of messages back to
the user in a chat-like interface while long-running jobs were being performed
in the background that they need to be kept informed of. And that's another
thing FastHTML happens to have already built-in well. So I grabbed for zmq when
I should have really figured out the WebSocket decorator in FastHTML, where you
can add `@app.ws()` at the top of any function, and you can route requests into,
and then back and forth from this chatty multiplexed bidirectional streaming
data channel. 

### Porting Message Porting

That's WebSockets. The dream since Google first hackish AJAX features in Google
Maps. All that stuff is formalized now. That's why chat is built into everything
now, and was all perfectly ready for the rise of ChatGPT and Bing. It seems like
now everything chats, and that from a developer point of view has to be table
stakes. A common pattern that's no big. And the formal way to do it now is
WebSockets. And it's exposed really well in an API through FastHTML. And so this
message port stuff is the second half of my porting tonight. And it's to make my
first forked-from-Pipulate instance of some custom cool stuff.

---

## ChatQ

I didn't know. I started today's article with "Just finish the port" as my
objective, then I realized I needed to more deeply understand what I was porting
to so that I could do the port. The first half of the work just went into a
great big cleanup of the Pipulate template since that's what I'd be porting into
and it would literally be what I was copy/paste porting into. All the WebSocket
chat communication between webpage parts taht I've been talking about have
become `chatq`, for a sort of Kung Fu, but with ***queuing chat***, thus chat
queue, or just chatq.

## And Now For Something Completely Persistent

I'm a bit ashamed to say that in my first pass of Botifython, I did this:

```python
class PersistentData:
    """
    A class for managing persistent data across requests.

    This class provides a simple key-value store for maintaining data that needs to persist
    between different requests in the application. It's used for storing information like
    the current project URL, selected analysis slug, and other session-specific data.

    Methods:
        get(key: str, default=None): Retrieve a value from the persistent store
        set(key: str, value): Set a value in the persistent store
        clear(): Clear all data from the persistent store
    """

    def __init__(self, filepath: str):
        self.filepath = filepath
        self.data = self.load_data()

    def load_data(self) -> dict:
        try:
            with open(self.filepath, "r") as f:  # Change to 'r' for JSON
                return json.load(f)
        except FileNotFoundError:
            return {}

    def save(self) -> None:
        with open(self.filepath, "w") as f:  # Change to 'w' for JSON
            json.dump(self.data, f)

    def clear(self) -> None:
        self.data = {}
        self.save()

    def get(self, key: str, default=None):
        return self.data.get(key, default)

    def set(self, key: str, value) -> None:
        self.data[key] = value
        self.save()
```

## Using JSON Files for Database-Like Functionality in Web Apps

Hey, if you define it then you ***know*** it, am I right? And when it comes to
something that's meant to be database-like, always there for a web app, and
reachable by different parts of your app without fear of simultaneous
read/writes or not being findable in scope, you can do a lot worse than a `JSON`
file on the hard drive, right? All you need is a `get`, `set` and `clear` method
on ***key/value pairs*** that work vaguely like a Python `dict` and you're good.
I was good.

## Understanding Equivalent Patterns in FastHTML and Flask Development

But then watching those pesky FastHTML tutorials by the guy who changes
everything in his soft-spoken way, I come to realize that when instantiating a
new instance of the ever-present `app` object, the equivalent of doing this
super duper common pattern in Flask...

```python
from flask import Flask

app = Flask(__name__)
```

## FastHTML Factory Class Contains a Wealth of Hidden Optional Choices

Notice what's traditionally the first parameter argument. Now for those not in
the know in Python, something like that `Flask()` ***factory class*** template
you see there can be hiding a ton of potential optional choices between those
parenthesis. If you're in VSCode or one of the forking alternatives, just
right-click and `Go to Definition`. You'll find a ton of stuff defined in the
original function, and in this case, we find an ***optional*** database in the
very first location! And here it is...

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

## Not All Python Function Parameters Are Made Equal (the one)

Every parameter is either ***optional with a default*** or just has a default set
for each parameter. So there's a lot of goodies. Of those goodies, only one has
the special privilege of the first location, meaning that you don't have to
provide the parameter name as the keyword. It's like the fist position of the
`print()` function is the thing you're supposed to print. You don't have to
type:

```python
`len(obj=x)`
```

No, you just have to type:

```python
`len(x)`
```

## The Power of Python Parameter Position Number 1

...and it will tell you the length if it's an object that has a length. And so
the first position in a function definition is very special, because you don't
have to think hard to use it. It's just always there ready to help you make the
function work well for you, very low friction. And look at what the first object
type is in a FastHTML `app` server instance:


```python
def fast_app(
        db_file:Optional[str]=None, # Database file name, if needed
```

## Understanding Scope in FastHTML Web App Database Access

So you're telling me that you just refer to a database name as the first
argument in setting up a FastHTML webserver instance called `app`, that that app
is going to have in its highly pervasive namespace access to a common database?
Now for people who are new to all this, there's something called `scope`, which
is where the variables, objects and other things you use along the way can be
used. And the rules are pretty strict. For things like web apps where it's
likely you'll have some per-user persistence issues, a database is the first
thing you're going to want to grab. And what you grab needs to be cleverly woven
into the scope of the various parts that are going to need it.

## Using FastHTML's Built-in `.xtra()` Database Filter Improves User Data Management

I'm not sure if I've seen this clever pattern before, and it impresses me as
original thinking. It's a very effective way of scratching a very old itch, one
that's been around as long as the fire-and-forget webservers on which the Web
was accidentally built into an application platform have been around. It's a
often solved problem through many complex and compromised techniques. This
technique, especially knowing that it's using SQLite by default and has a...
uhmmm... I'm not exactly sure what to call it. A filter, maybe. Anyway,
databases automatically have a hard-wired filter method `.xtra()` which
scratches the next itch you're going to have, which is ***keeping user data
separate!***

## Separating User Sessions in New Frameworks Can Be Complicated

If the framework doesn't offer up something for that, separate user-sessions and
their related data that can last optionally for longer than the single browser
session is on of the very first things you've got to do, and let me tell you,
that is ***one deep rabbit hole!*** It's just like approaching web development
for the first time, thinking your first JavaScript Hello World was easy and that
web programming must be easy, and then you discover you have to learn React.
Platforms like that take care of this stuff because of years of complex tooling
and business making sure you can buy stuff on their websites. But when you take
up a new framework full of anti-patterns that thumbs its nose at all that, you
need the alternative.

In the case of session variables, user profile information, and the general
longevity of user-provided information, FastHTML offers an instance of a SQLite3
database, courtesy of the Python Standard Library default components, so easily
you could trip over our own feet and have a database.

```sql
CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    JobTitle TEXT,
    Email TEXT UNIQUE
);
```

## The MiniDataAPI Reduces Database Sayings to a Minimum Requirement

...you say? No, you don't say. You apparently never have to say that, not even
when you're changing the "shape" of your database later on, because of this
kooky little 80/20-rule database package FastHTML uses, called
[MiniDataAPI](https://docs.fastht.ml/explains/minidataapi.html).

As easy as SQL, the structured data language behind many modern databases may
be, writing directly in it is hard. The various technology infrastructure things
that need to be true are hard. Setting them up and keeping them running is hard.
Keeping track of the endless differences between one version of SQL and another
is hard. There's almost nothing easy about databases... until Sqlite, based on
the idea that not everything needs to be done the big, expensive way. Sometimes
just enough is plenty. And so SQLite is now highly optimized and baked into
endless products, including Python itself. So when you use this database from
FastHTML, they're just throwing an API-wrapper around SQlite (by default).

## The 80/20 Rule Simplifies Database Use with Core Functions

The 80/20-rule suggests that you can get 80% of the benefit from the first 20%
of the effort, if you just prioritize correctly and are willing to live without
a bit. That's SQLite. That's Python, for that matter and perhaps Linux and the
whole realm of free and open source software (FOSS). So, you can do a lot with
databases. You can join data between different tables and do all kinds of
analysis and reporting tricks. However, if you give up all the shiny bells and
whistles, there's a core set of things they all do, create, (show) records,
update and delete, or CRUD. And if you can throw an easy wrapper around a
database to let you do those things super easy, you're good.

And that's what MiniDataAPI does. It's the 20% of the features that gives you
80% of what you need with web development, right down to making you not have to
think about creating tables. That's like the highest friction part of sitting
down and doing some database stuff. But the new pattern that is being shown off
in the increasingly popular [FastHTML Todo
app](https://docs.fastht.ml/tutorials/by_example.html) is in its conceptually
simplest form to show of the database in the first position:

```python
app, rt, todos, Todo = fast_app("todo.db")
```

## Understanding Database Table Creation in FastHTML

...which shows that merely by having the filename of a database (the .db
extension is just sqlite convention), that database will be created along with
the webserver, presumably if it doesn't already exist from previous runs. Now if
you're dealing with a database, you can't just stop there. There are tables and
fields, and even a primary key that must not be ignored. So instead of having to
know the `CREATE TABLE` command, you merely need to know how to refer to them as
parameter arguments:

```python
app, rt, todos, Todo = fast_app(
    "todo.db",
    id=int,
    pk="id",
    title=str,
    done=bool,
)
```

## FastHTML Creates Persistent Background Data Store for Apps

...and your table is created! I'm new to FastHTML but did the todo app example
already, and I can say that if your database is already there from a previous
run, it just gets used seamlessly. So this is not just a cache or per web
session sort of thing. This is a formal lightweight always there in the
background ready to serve you persistent data-store. It doesn't even have to be
connected to a SQL database in particular, as anything with key/values can work. 

Okay, but we're doing web work and this is likely to end up on a publicly
accessible website, and you don't want anything that can write to our local
folder; the folder the `server.py` file or something like it runs from. Instead,
you have to put it at least into a subfolder, which can be mapped by the web
hosts to pretty much any datastore device. Getting the directory in there is the
important part, and when you do, FastHTML will create the folder for you as
well.

```python
app, rt, todos, Todo = fast_app(
    "data/todo.db",
    live=True,
    render=render,
    id=int,
    pk="id",
    title=str,
    done=bool,
)
```

## Using Render Function in Webserver for Response Formatting

There's 2 more things to notice about the above example. The first is that weird
`render=render` parameter and argument. This uses an already defined function in
your code and passes it into the webserver as something to use to ***format***
the responses to database queries. It's a bit hard for me to wrap my mind
around, but because we're not on a fancy client-side JavaScript framework like
React, we're not sending JSON to stuff that will magically handle it and flow it
into a user interface. That's not how FastHTML, or the HTMX rules it's built on
work.

## Understanding HTMX: Pre-Rendering for Smooth Website Interactions

Rather we are just sort of thunking HTML fragments into the correct place in the
Document Object. Yup. That's HTMX. And when you're thunking frags, you sometimes
have to do a bit of pre-render work to make it fit the look and feel of your
website. The webserver itself needs a chance to polish these data frags into UI
elements, because the client (browser) is not going to.

## Understanding HTMX's Complex Rendering Object Basics

***That's*** what the render object is. And there's an "ahead-of-time" object
preparation workflow required here which takes as much time to grok the how as
the what and why. There's a lot to wrap your head around in the move to HTMX,
but the kookiness requires buying into nothing less than how the Web itself
works, given its foundation tech of http and HTML. The little tricks JavaScript
used to create empires of virtual domains within the DOM can also be used to
just let all the default stuff be a little more powerful, and just like update
parts of the page and stuff. And when you do that, the frag-spewing webserver
needs an inline prettifier. Hence render=render.

Pshwew! At least I know it better. Who knows if this is actually going to help
anyone out there. 

## Using Live Reload in Server-Push Web Development Workflows

The last thing to notice about that example is `live=True`, which I totally
underestimated. That's not just a webserver file-change watchdog. That's also
using the ability to make the page ***reload itself*** when you make a
file-change. That's server-push right there in the web development workflow.
Talk about a no-build workflow, you make a change in your `server.py` file, save
it and watch the change ***just occur*** in your browser, as if it was one of
those 2FA go-away screens that sits there until you authenticate on another
device. It's like a web page is sitting there waiting for you to do something on
some other device, and I think that's cool.

As late as it's getting witht he weekend winding down, there's one more thing I
need to get into the Pipulate template before I fork and customize, and that's
the database stuff with an xtra filter. 

## Separating Users From Each Other Along With Their Data

Alright, so filtering one profile's todo list from another will be simple
enough. I can use that nifty `todos.xtra(profile_id="Profile_1"`, for example
with the site template I'm working on. But how to record the active user that is
selected? In addition to a little data-store per-user that all goes into the
same easily accessible table filtered by a field, which is our todo app, we need
another table for state and session information. In other words, which profile
am I set to, and why is that sticky between requests or even when we connect
back later? That's another table; a session table.

Hmmm, Jeremy Howard, I am following your breadcrumbs. You say it in the YouTube
video [Getting started with FastHTML at
28:26](https://youtu.be/Auqrm7WFc0I?si=T3hi_ZUeK6OsZu-S&t=1706) If you want more
than one table, you can actually uhm pass in a dictionary of all of the tables
that you want, and uhm this is all just like convenience, and you could do this
through any other mechanism you like.

## Using App Scope for Efficient Persistence in Web Applications

But wait, no! I call you out on that, Jeremy. You funnel it through the app
web server object not merely as an API-adjusting helper, but also to keep things
in scope. The `app` **scope** is a very powerful connection between things, say
for opening and closing database connections cleanly, knowing all what's going
on. Yes, you *can* use other mechanisms for persistence, but if you're not
funneling it through app params, you're going to lose features like auto-reload,
because such features rely on clean disconnects. Other mechanisms make other
connects, and that's fubar to be avoided.

Anyhow, that's a long way of saying I'm going to figure out that multiple table
thing now. Need it a lot.

## Understanding Table Data Feed for Tbls Library

When the docs don't cover it, you can follow the open source. I need to
understand how I feed that table dictionary as a argument to the `tbls`. It is
expecting datatype of `dict`, so it's some form of tbls={key: val} pairs. Sweet!
Perplexity made this darn impressive guess of how it is done:

```python
app, rt, todos, Todo, users, User = fast_app(
    "todo.db",
    todos={
        "id": {"type": int, "pk": True},
        "title": {"type": str},
        "done": {"type": bool}
    },
    users={
        "id": {"type": int, "pk": True},
        "username": {"type": str},
        "email": {"type": str}
    }
)
```

...and then it made this second guess...

```python
app, rt = fast_app(
    "todo.db",
    todos={
        "id": {"type": int, "pk": True},
        "title": {"type": str},
        "done": {"type": bool}
    },
    users={
        "id": {"type": int, "pk": True},
        "username": {"type": str},
        "email": {"type": str}
    }
)
```

If in doubt, then go to the source. Sourcecode on GitHub, that is.
[AnswerDotAI/fasthtml/fastapp.py](https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/fastapp.py)
That is this:

```python
"""The `fast_app` convenience wrapper"""

# AUTOGENERATED! DO NOT EDIT! File to edit: ../nbs/api/10_fastapp.ipynb.

# %% ../nbs/api/10_fastapp.ipynb 3
from __future__ import annotations

import inspect,uvicorn
from fastcore.utils import *
from fastlite import *
from .basics import *
from .pico import *
from .starlette import *
from .live_reload import FastHTMLWithLiveReload

# %% auto 0
__all__ = ['fast_app']

# %% ../nbs/api/10_fastapp.ipynb
def _get_tbl(dt, nm, schema):
    render = schema.pop('render', None)
    tbl = dt[nm]
    if tbl not in dt: tbl.create(**schema)
    else: tbl.create(**schema, transform=True)
    dc = tbl.dataclass()
    if render: dc.__ft__ = render
    return tbl,dc

# %% ../nbs/api/10_fastapp.ipynb
def _app_factory(*args, **kwargs) -> FastHTML | FastHTMLWithLiveReload:
    "Creates a FastHTML or FastHTMLWithLiveReload app instance"
    if kwargs.pop('live', False): return FastHTMLWithLiveReload(*args, **kwargs)
    kwargs.pop('reload_attempts', None)
    kwargs.pop('reload_interval', None)
    return FastHTML(*args, **kwargs)

# %% ../nbs/api/10_fastapp.ipynb
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

## Unlocking Persistent Key/Value Pairs for User File Organization

Now this is important because it lets us decipher a less than fully explained
feature, one which I desperately need (to mix todos with session stuff).
We are unlocking arbitrary, persistent key/value pairs that we can use per-user
if we wish. This is file organizations and permissions, we're talking here.

That `_app_factory(` is too much to track down. Too deep a rabbit hole. But
scanning down, we see there's a quick exit if no database stuff is going on.

```python
if not db_file: return app,app.route
```

## Renaming Database File Corrects Todo App Issue Immediately

The next thing is that no matter what, there's a file loaded as the database.
And even though in the todo app, it's named `todo.db`, implying it's a table,
it's not. It's a bundle of tables. You're naming the parent database, not the
table you're manipulating. And so, I go adjust the Pipulate code right now to
rename todo.db to `pipulate.db`. The database is the app. Okay, deep breath.
Delete the old files, check the app...

Still works, okay, check!

Okay, so `tbls=some_dict` has to be used. That magically turns on multiple
databases. If tbls isn't set to anything, then an empty dictionary `{}` is
created for that value. Now, if you get the dictionary format correct, then
dbtbls gets returned and its contents are "splat" back atcha:

```python
return app,app.route,*dbtbls
```

That explains the signature. The FastHTML Todo tutorial has this:

```python
app, rt, todos, Todo = fast_app("todo.db",
                                live=True,
                                id=int,
                                title=str,
                                done=bool,
                                pk="id")
```

## Understanding File Handles Generated by Fast App Generator

And so this explains a lot. `todos, Todo` are arbitrary names returned back in
pairs by the `fast_app()` generator. Pew, pew, pew, it sends back objects that
are the ***file handle*** to the table, and the `namedtuple` signature or
template class of a single record. The stage is set for easy iteration through
todos, knowing it comes out convenient little labeled bundles of predictable
size, arrangement and data types. And we want those juicy file-handles and data
structures for table number 2! Hmmm... We can look at the definition of
`_get_tbl()` and see this:

```python
def _get_tbl(dt, nm, schema):
    render = schema.pop('render', None)
    tbl = dt[nm]
    if tbl not in dt: tbl.create(**schema)
    else: tbl.create(**schema, transform=True)
    dc = tbl.dataclass()
    if render: dc.__ft__ = render
    return tbl,dc
```

**Me to Perplexity**: Do you know anything about FastHTML's _get_tbl() ?

**Perplexity**: Based on the search results and the error message you encountered earlier, I can provide some insights about FastHTML's `_get_tbl()` function:

1. The `_get_tbl()` function is an internal function used by FastHTML's `fast_app()` to process table definitions[1].

2. It appears to be part of the table creation process when setting up a database for a FastHTML application[1].

3. The function expects a dictionary-like structure for each table definition, where it can call the `pop()` method to extract certain attributes, such as 'render'[1].

4. The error you encountered suggests that `_get_tbl()` is trying to process the table definitions passed to `fast_app()`, but it's receiving an unexpected data type (int instead of a dictionary)[1].

5. The correct structure for defining tables in `fast_app()` seems to be a nested dictionary, where each table is a key-value pair, and the value is another dictionary defining the table's columns and their properties[1].

Given this information, when using `fast_app()` to create tables, you should structure your table definitions like this:

```python
app, rt = fast_app(
    "database_name.db",
    table_name={
        "column_name": {"type": data_type, "pk": boolean_value},
        # other columns...
    },
    # other tables...
)
```

This structure allows `_get_tbl()` to properly process the table definitions and set up your database tables. The function likely uses this structure to create the appropriate database schema and table objects for your FastHTML application.

Citations:

    [1] https://eugeneyan.com/writing/web-frameworks/
    [2] https://github.com/AnswerDotAI/fasthtml/blob/main/examples/adv_app.py
    [3] https://fastapi.tiangolo.com/tutorial/handling-errors/
    [4] https://www.youtube.com/watch?v=S8_e8kQ4jvg
    [5] https://fastapi.tiangolo.com
    [6] https://www.youtube.com/watch?v=evAb2x34Jqk
    [7] https://blog.appsignal.com/2024/03/27/track-errors-in-fastapi-for-python-with-appsignal.html
    [8] https://www.youtube.com/watch?v=QqZUzkPcU7A

Hmmm, okay with new information in-hand, I finagle the next suggestion from
Perplexity:

```python
app, rt, todos, Todo, employees, Employee = fast_app(
    "company.db",
    live=True,
    todos={
        "id": {"type": int, "pk": True},
        "title": {"type": str},
        "done": {"type": bool}
    },
    employees={
        "id": {"type": int, "pk": True},
        "name": {"type": str},
        "position": {"type": str},
        "hire_date": {"type": str}  # You might want to use a date type if available
    }
)
```

Nope, nope, and more nope. But after tons of trying, backup up and pivoting and
trying again, I finally got this to work...

```python
# Unpack the returned tuple from fast_app
app, rt, (todos, Todo), (employees, Employee) = fast_app(  # Unpack the tables directly
    "data/pipulate.db",
    ws_hdr=True,
    live=True,
    render=render,
    todos={
        "id": int,
        "title": str,
        "done": bool,
        "pk": "id"
    },
    employees={
        "id": int,
        "name": str,
        "position": str,
        "hire_date": str,
        "pk": "id"
    },
)
```

I figured out your API, Jeremy! I have to include parenthesis! Got it. But my
use case is:

```python
app, rt, (todos, Todo), (sessions, Session) = fast_app(  # Unpack the tables directly
    "data/pipulate.db",
    ws_hdr=True,
    live=True,
    render=render,
    todos={
        "id": int,
        "title": str,
        "done": bool,
        "pk": "id"
    },
    sessions={  # Change from employees to sessions
        "profile_id": str,  # Set profile_id as the primary key
        "organization": str,  # New field
        "project": str,  # New field
        "analysis": str,  # New field
        "pk": "profile_id"  # Set profile_id as the primary key
    },
)
```

Alright, it's stunning that I cracked this nut. 
