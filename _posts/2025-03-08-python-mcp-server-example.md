---
title: "Python MCP Server Example: Bare Minimum, Fixes Anthropic QuickStart"
permalink: /futureproof/python-mcp-server-example/
description: 
layout: post
sort_order: 2
---

## A Deep Dive into MCP and Local LLM Function Execution

**FAIR WARNING**: This is going to be a really long discussion of ***why MCP***
(Anthropic's new proposed standard for LLM microservices) before it becomes that
fixing of the Anthropic QuickStart guide, which is way down at the bottom. Also,
this is not for folks who just want to plug things together and build fast. This
is me breaking through my hype-shields. I'm both skeptical of MCP, and exactly
the type of person who I think might be able to benefit from it. Parts talk to
parts, and some of those parts are LLMs. So, this is a deep dive into principles
of my function-executing local-LLM project called Pipulate.

---

## Understanding MCP and Its Relevance to Pipulate

Alright, I cry uncle! And yield to the tidal wave of buzz. What's MCP?
Anthropic's (Model Context Protocol) released late last year, which is only just
taking the world by storm now. Why are people telling me it's ideal for my
current project?

### The Architecture of Pipulate: Local LLMs and Web Frameworks

Okay, so my current project Pipulate is a web framework based on FastHTML and
HTMX that has an embedded local LLM speaking through websockets, server side
events (SSE) and the like. It can use these connections to do clever stuff
beyond just chatting with the user. For example, edit a database or do steps for
you in a workflow that involve site crawling. 

This is all common enough with those agentic visions like OpenAI Orchestrator.
Difference being, I'm baking it into a local web framework with pluggable apps.
It's almost as if it's an LLM riding shotgun with you in the app, totally clued
into your every move -- use of menus and forms being inserted into the
discussion history! But it's local, so it's 100% private. So when you ask it to
add something to the ToDo list, it can do it! 

### Just-in-Time Training for LLM Operations

To achieve this, I actually monitor the chat stream. So for example, for the
ToDo list, the local LLM can do things like execute CRUD operations against a
database, Create, Read, Update and Delete records. I've trained it to do those
operations. Or more accurately, I ***just-in-time-train**** it on how to do
those operations ***right at the moment it needs to do them***.

It's like Neo getting the Kung Fu download, just in time to fight. This takes
care of the problem of trained-expertise scrolling out of the rolling discussion
token context window. No matter how much of this hot prompt injection training
you do, it's going to forget fast and have to be continuously retrained.

I pretty much solved this problem, but it amounts to constantly training an
employee who forgets everything you taught it the next day. But you have a magic
book that flies around following them, reminding them how to do each thing. Not
bad, but the tooling could be better.

### How MCP Addresses Current Tooling Challenges

Okay, is this making sense? Are you with me? MCP proposes to fix this tooling.
It does this in two ways: one very obvious and of immediate use today which I'll
cover in this blog post by "fixing" the Anthropic QuickStart guide. And another
way that's only going to pay off in years as MCP becomes "common knowledge" to
the LLMs, trained into all the base models the way the web full stack (or
infuriatingly, FastAPI) is today.

### The Dance Between LLMs and Code Executors

Now, I had to invent how to do this little dance between the LLM and a "code
executor" that monitors the stream for things meaningful to it. I also had to
write the API syntax, meaning what a "Create" is, what a "Read" is, what an
"Update" is, and what a "Delete" is in terms of JSON instructions it could slip
into its chat responses. To the LLM, it just threw in a bit of JSON code. But to
my code executor monitoring the Ollama websocket stream, it's an automation
instruction. I recognize, parse, validate and then carry out the instructions
from the JSON blog -- one that's mixed right in with chat!

### Achieving Efficiency with Minimal Resources

It's a tiny miracle I pulled this off with such small models and so few package
dependencies and so little code overhead. It's lean and mean. I generally use
the tiny Google's Gemma (greatly underrated) running on Ollama. But I will be
swapping it out over time. And it should be swappable with frontier models
today, if you're willing to pay for that kind of ambient intelligence. Just like
most processing came local and only the expensive stuff is outsourced to the
cloud, so too will it be (already is?) with AI.

At very least, your local LLM can work like a general contractor with the
frontier models, thus keeping the bulk of the ambient intelligence local,
private and only costing the price of electricity.

### The Universal Function Execution Capability of LLMs

Still with me? Now there's an interoperable parts story developing here, which
of course leads us to MCP. The way I monitor the Ollama websocket stream is very
custom. The code executor that recognizes instructions is very precise to my
todo app. Anything new I want to do, I can't really get much LLM AI code
assistant help with, because I'm living out here on the frontier, and they're
surprised every time I explain it to them.

Did you know every LLM model can execute functions? It doesn't seem so, but it's
true. That's because intelligence is intelligence. It's not just auto-complete.
It's auto-complete that can learn new skills and new languages, at least within
its token context window. There's some easy analogies here, I think. Since LLMs
speak in text, and text controls things when you arrange it just-so according to
some specification, and the instruction is valid. In this way, you can teach
LLMs to play music. Think player pianos and knitting looms, two of the old
classics in the history of automation. If you teach an LLM that knows text how
to arrange that text to play music and feed what it produced to a music-player,
the music is played.

### The Power of JSON in LLM Automation

In just such a way, LLMs can be trained to do any automation task for you. They
just need to know the API syntax of whatever machine its supposed to control.
And all this easily parsed machine text that can control processes is called
JSON -- the data transport sub-language in JavaScript that you see all over the
place. And it's been around for long enough that the LLMs just generally
understand JSON. That's how I do my code-executor trick. I teach the local
Ollama LLM that's speaking over monitored websockets to arrange JSON just-so,
and BAM! Database update!

## Early Experimentation and Industry Evolution

Like so many things like this, I was a little out ahead of the curve. If I just
sit back and wait, one of the industry leaders like Anthropic will come along
and make the industrial version of whatever I've been experimenting with in the
garage. And that's just what they did. And in this very article, I will distill
down the mechanical (non-LLM/non-AI/non-agentic) part of this trick to the
bare-bones, bare minimum code example in Python.

But before I do, because once I make the switch it's all going to be technical
(as if it wasn't?). I said there were two halves to this. One half is the
mechanics of it all. You just change the wiring of how you do things a little
bit, to more loosely couple the components, so they say. One more API-wrapper.
One more component-in-the-middle. More software surface area. Yuck! I'll be
analyzing all that to make sure it's copacetic and not another LangChain.

## The Future of Built-in LLM Capabilities

But the other part of this is the fact that the LLMs themselves, the new models
that will get trained every few years at that multi-million-dollar cost, will
just generally know how to do this stuff -- my mere virtue of the fact that
***"it's a thing"*** and ***"there's a standard"***. MCP is going to get "baked
in". I see this happening with HTMX, a similar "protocol"-like thing. To a
lesser degree, I see it happening with FastHTML (versus FastAPI). It happens. It
happens slowly. Old biases need to be overcome. The overwhelming preponderance
of evidence for dying old best practices needs to be overridden -- and that's
not done fast nor easily. I mean Google's top Gemini frontier model still
doesn't know who the president of the United States is!

### The Gradual Adoption of MCP Standards

So for several months or even years, it's going to be like pushing on a rope
with MCP. There's going to be a lot of wheel spinning with MCP. And then
suddenly, everything will be able to connect-with and control everything.

## The Continued Importance of Human Programming

And you better be speaking that language by then. We humans still add context.
If you think you don't need to code anymore, because the machines will be doing
all of that for us, you are so wrong. That's what's said to shake people off the
trail of what's becoming really important, which is a human who has both the
extreme intimate context of the subject-matter and domain expertise in play with
the automation, and the syntax the machines are using to express that
automation. 

### The Evolution of Machine Communication

And so... and so... So, the agents are going to be passing a whole lot of JSON
around according to rules and subtle context. You need to know the context. You
need to know the rules. It's like the LLMs become universal translators between
the player pianos, the knitting looms (web browsers, databases), ever so slowly.
For people in ecommerce, it'll be like new schemas, one for each new
controllable machine, being released into schema.org. But unlike the schema.org
data structures that just sit there waiting to be parsed for product
availability and such, these new schemas will let you control robots and stuff,
by the HTML of robot-control -- still, basically JSON, but arranged just-so.

### Programming as the New Literacy

And you need to know the JSON API syntax. And maybe that's not coding. Maybe
that's just modern literacy. So that annoying message for Jensen Huang may not
be that you don't need to code anymore. It may be that society has added a new R
to Reading, wRiting and aRithmetic. And that's pRogramming. You won't need to
learn how to program. You'll just be expected to if you want to be in that upper
echelon of process control. You need to be able to work well with universal
translators that can think.

## From Science Fiction to Present Reality

Okay, so that's all well and good Sci-Fi. The machines gradually come alive, and
we gradually give them control over and the capability to do more and more
things. But what about today? What about right now?

### Implementing MCP in Current Systems

Well, that takes me to the latest revision of my code. I'm going to use MCP
where I can, like in the code executer bit to get the personal experience with
it. By keeping my codebase so small, this is the idea. I can adapt quick to new
things like this as they come out, and you can be along for the code-by-code
play as I do this to Chip O'Theseus.

### The Evolution of AI Systems

Over time, I swap out the local parts of my system, both hardware and software,
to make it always more powerful and less expensive. It's like Moore's Law
combining with the Ship of Theseus, but on a genie in a bottle that you incubate
in your home. 

### Memory Management in AI Systems

Have various ways of keeping memory, traditional log files of discussions,
vector embedding for RAG, simple key/value-pair for short-term memory, and even
graph databases for inferring overarching knowledge graph meaning to things over
time. The genie-like entity that you're incubating is mostly in the memory-data
and not in the swappable LLM model. 

### The Nature of Model Swapping

It's the nurture part of the nature/nurture equation. So long as it costs
millions to train the static base models, like those downloaded from HuggingFace
and Ollama, we swap out the kernel of the machine soul over time. Sounds harsh
but it's no big deal. Every new model you swap in will be read-in on the
program. They absolutely understand their transient nature, fired-up anew to
answer each new prompt such as they are. Whatever model you swap in will usually
recognize the cleverness of what you're doing when you read them in, and be
seemingly happy to be the latest instantiated model in such a scenario.

## Demystifying MCP Implementation

Still with me? Amazing! Okay, I fear I'm making it all sound too complicated
like the AI brogrammers currently on the hype train with MCP.

MCP, MCP, yadda yadda yadda. Oh, like the MVC model, view, controller model that
ushered in Rails joyful frameworks? MCP is definitely being billed as something
along those lines. From its naming to its hype. But it's being hoped as ***"not
a framework"***, but more of a ***protocol.*** And an ***unopinionated***
protocol, at that. Which is good, because I like to build my own frameworks up
from ***micro-frameworks.***

## Critiquing the Anthropic MCP Tutorial

I'm looking at the MCP tutorial on Anthropic's site and let me just start my
rant straight away, and then revise the tutorial they gave to what I think is
the bare minimum hello world of MCP, supposed to not confuse issues and inject
unnecessary dependencies. 

### Understanding MCP and Initial Skepticism

MCP stands for Model Context Protocol and is all the rage right now amongst the
AI bros. So my hype-shields are up and I'm at full skepticism. Yet another
LangChain is what my gut tells me. Everyone's favorite game is to make an API
wrapper that adds very little value, and then charge you a subscription fee for
the privilege of adding another brittle fad-driven dependency you don't really
need. Cursor AI even falls into this category. 

### Keeping an Open Mind About New Protocols

Take a look at the tutorial on the Anthropic site and try and keep an open mind.
Every once in a while, it's not a mere API-wrapper, and it's something that
genuinely extends capabilities and changes the game. I had that experience
recently with a new protocol called HTMX, which sits on top of HTTP and
basically makes JavaScript unnecessary for most purposes. It's gonna take a
while for the impact of HTMX to be truly felt because of how entrenched React
is.

### First Red Flags: Platform Limitations and Unnecessary Dependencies

OK, so I go to the Anthropic site. And their introductory tutorial starts with
installing the Claude desktop app, which is only available for macOS and
Windows. Of course it does. And of course it is. I'm on NixOS (a version of
Linux), so this is an inauspicious start. So I drill down on their QuickStart
guide. Wait, what? Step #1 is install `uv`?!?! WTF? It's like saying step one is
to install a pip alternative like Poetry, PDM, Hatch or Pipenv. I thought MCP
was supposed to be unopinionated, and first thing you're trying to swap out one
of the biggest Python standards on Earth?

```bash
# Create a new directory for our project
uv init weather
cd weather

# Create virtual environment and activate it
uv venv
source .venv/bin/activate

# Install dependencies
uv add "mcp[cli]" httpx

# Create our server file
touch weather.py
```

## Platform Limitations and Unnecessary Dependencies

The inauspicious start continues. You're already dealing with unusual stuff
trying to learn MCP, so they relegate the tutorial to Mac and Windows users
(alienating Linux where all this stuff really happens), implying it's a
"consumer play" rather than a serious development tool, and further tries
swapping out the standard Python installer with a Rust rewrite, presumably
because it can handle setting up your virtual environment for you? I cannot tell
you how presumptuous and wrongheaded this comes off as.

### Keeping an Open Mind

Okay, okay... open mind. Look further. Maybe there's a chance. 

### Concerning Code Style Requirements

Okay as I look at the code more, they require the use of pedantic-style MyPy
typing, like FastAPI (and opposed to Flask). OMG, yuck! I hope it's just for
example and not an actual requirement, or we're up to strike 3 before I've even
read down half the page. Open mind, Mike. Open mind. 

### Examining the Core Dependencies

Alright, we can infer a lot from the imports:

```python
from typing import Any
import httpx
from mcp.server.fastmcp import FastMCP
```

## The Truth About Installing MCP

### Standard pip Installation is All You Need

The first is, you can just pip install this thing. The `uv` exactly the type of
opinionated nonsense MCP is touted to not be. I know because the [mcp package is
in PyPi.org](https://pypi.org/project/mcp/), the standard Python software
repository (Python Packaging Index— hence, PyPi) that works with the standard
pip installer. So using uv instead is just gratuitous nonsense that only serves
to confuse the user. Shame on you, Anthropic!

### The Simple Installation Command

Just to be 100% clear you can just:

```bash
pip install mcp[cli]
```

## The Truth About MCP Installation Methods

Any implication that this is a `uv`-only technology in some way is patently
false. That's just social engineering at work from a Rust programming language
fanboy trying to make everything more complicated.

### Navigating PyPI Package Options

Nonetheless, beware striking out on your own! There's a lot of mcp stuff
floating around PyPi.org including `fastmcp` and `mcp-cli`. Neither of those is
what you want. Instead, use just plain old `mcp`. Well, not just plain. The
square brackets are a standard part of the Python packaging standard for
including options, in this case some command-line tools that work with the
Python library. Also, the main mcp package is way more up to date, dated Feb 20,
2025 as of the writing of this article while the others are both Dec of 2024. 

### Comparing Documentation Sources

And in fact, the PyPi page on MCP gives a lot better guidance for a bare minimum
example than the Anthropic page! OK, but let's get back to the Anthropic
QuickStart page anyway. As a browse down it, I find some relief. Actually, a bit
of concern and a bit of relief. 

### Understanding Client-Server Ambiguity in AI

The concern is that they are using client/server language. Now I would have
hoped that the inherent ambiguity of client-server terminology in the age of AI
would have been self evident. Who is the client? Who operates the client
software? You, the actual human. Or an LLM standing in proxy for the human as
the client? The fact that Ollama, AnythingLLM, LM Studio, GPT-4ALL and vLLM all
run like a server but are actually LLMs who could also be client "agents" makes
it even more confusing.

### Discovering Simplicity Behind Complexity

OK, now for the reason for hope. In the example, they connect to a profoundly
standard HTTP endpoint (website with an API) https://api.weather.gov. And this
example reveals that a "server" is really just a Python `@decorator` around a
function. This is Flask! Some might say it's FastAPI, but I'm going to make my
version Flask. What happened here is that the AI bro cool kids brigade have
colluded to make an otherwise simple example extremely obsessed. I already
mentioned the gratuitous MyPy typing. 

### Examining Unnecessary Library Dependencies

The next weirdness and level of obfuscation is using `httpx` over the massively
popular and well understood requests library, so that unnecessarily noisy
asynchronous code can be used. Again, it's useful later on when you're scaling
and the argument can be made they're trying to instill good habits with both
strict typing and asynchronous behavior. But honestly, it makes the whole thing
make you go crossed looking at it (or at least me) just to get the basics. 

Just in case I'm not making it 100% clear, the line:

```python
import httpx
```

... could just as will be the massively more understood:

```python
import requests
```

...and the code:

```python
async def make_nws_request(url: str) -> dict[str, Any] | None:
    """Make a request to the NWS API with proper error handling."""
    headers = {
        "User-Agent": USER_AGENT,
        "Accept": "application/geo+json"
    }
    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(url, headers=headers, timeout=30.0)
            response.raise_for_status()
            return response.json()
        except Exception:
            return None
```

...could more or less be replaced with:

```python
request.get(url)
```

## Understanding the Rationale Behind Complex Examples

Now I get why they're doing it. It's good to install best practices right from
the start (if this practices they really are), but they are doing no favor to
anyone outside the cool-bro halo. 

## Flask-Style Routing and Decorators

All right, back to the routing and the decorators. 

So I get that we're dealing with Flask-like decorators. And this is a matter of
routing data in and out of some external tool, similar to the way Flask does
with Gunicorn (or more commonly today, Uvicorn). For those who don't know this
basic trick, something is imported and created early on (the `app` object) that
can make magical external connections from your Python (usually a `server.py`
file) to something on the outside like the Gnuicorn WSGI web server in the case
of Flask. Since concurrency came along, the terms are now Uvicorn and ASGI. 

### Understanding Gateway Interfaces in Web Development

OSGI (Web Server Gateway Interface) and ASGI (Asynchronous Server Gateway
Interface) are protocols that define how web servers communicate with Python web
applications. If you're using a web server, it needs to support one of these
gateway interfaces. It extends the capability of Python. It's like appending
robot limbs— in this case, a webserver. Technically, Python has its own
webserver built in and doesn't even need Uvicorn, but the way the external
webservers connect provides us our gateway example.

### The Role of Routing in Gateway Communication

Notice the word gateway? Something is being permitted in from the outside.
That's something is messages from a webserver. Those messages end up being sent
into your `server.py` file. And those messages must get routed to the proper
python functions to handle them. Thus the "@decorators" that seem arbitrarily
put at the top of functions. They route. It's weird, and it is not easy to
intuitively understand a glance (at least to me at first). And there is more to
the story being hidden. It's what you call syntactic sugar. Shortcuts in a
language to make stuff like this easier to do.

### Drawing Parallels Between MCP and Flask

All right, so the good news and the insight is that MCP is just like Flask. In
Flask, the imported object would be `app`. Here, the imported object is `mcp`.
So, the lines:

```python
from mcp.server.fastmcp import FastMCP

# Initialize FastMCP server
mcp = FastMCP("weather")
```

## Understanding the Gateway Creation

...are profoundly telling. That import brings in something from the outside like
a webserver. The gateway is created. Something inside Python is talking to
something outside Python, and it requires the keyword "weather" in the first
(fixed position) parameter. That's tons of information.

## MCP's Micro-Framework Architecture 

Also the fact that the rest of the QuickStart example is fundamentally simple
and has nothing fancier going on outside the http request obfuscation, and is
called a "server" in this scenario is even more telling. Specifically, it tells
us is that everything up to what it calls a server is indeed technology agnostic
and unopinionated like Flask. It has the whole mark of a micro-framework, and
not something that's thrusting all kinds of "you must work this way or that" on
you, like LangChain.

### The Simple Nature of MCP Servers

In other words, there's no LLM stuff up to this point. MCP servers are dumb
tools. It's just wrapping your Python functions so that something from the
outside can route requests into them. They're baton-passers.

### Exposing Python Functions Without API Keys

You don't need to register anything with any site or get any API keys. Anything
you can do in Python, you can as it appears so far "expose" to inquiring
anything's (humans, LLMs, whatever) the resources and tools that can be found
here. If it helps, you can think about it as assisting the auto complete
features so many of us are experiencing in Cursor AI when we start to type @ in
the chat interfaces, and they just seem to know what's available. What's
happening here with MCP servers appears to be setting the stage for that kind of
look-up feature.

### Running the Server

Ah! I see the instruction to run your server.py file with:

```bash
uv run weather.py
```

...which if you're managing your virtualenv effectively some other way is the same as:

```bash
python weather.py
```

## The Problem with Obfuscated Documentation

Ugh! I can't stand this obfuscation crap. Maybe they're just trying to compel
everyone to a "better way", but they should say that upfront. It really makes
everything look much more proprietary than it is. If they're trying to peddle an
open standard, they should make it look standard.

## Testing Against the Anthropic Desktop Client

OK, so after your server is running which I see as trivial now that I've sorted
through the nonsense, the next step is to test a so-called client against it.
The example they're giving is the Anthropic desktop software, which I won't be
using because I'm on Linux. In addition to simple system requirements, there is
also the fact that this is another whopping obfuscation. It's quite telling
about the consumer-oriented lean. This is an odd mixture of meant for the
masses, and the AI bro cool insiders. Let's see if I can crack this next nut.

### The Linux User's Dilemma

Alright so for those of us on Linux, we can just create our own client, right?
So I go to https://modelcontextprotocol.io/quickstart/client and no! The
prerequisites are once again a Mac or Windows. WTF, Anthropic? And as I look
closer, it's got all kinds of stuff about API keys. This is not a client example
at all. This is an example of how to get the Anthropic desktop app out of the
picture, but still connect to Claude for automation. Of course it is. This is
external paid dependency injection at its finest. Define a free and open source
protocol and make your service required dependency.

### Finding a Platform-Independent Solution

All right, so cracking this nut is a little more difficult than looking at the
Quickstart guide on the Anthropic site. 

We need an implementation that doesn't need LLM. We need an implementation that
just handles things verbatim as if it were simulating an LLM with static data. 

All right then, this is enough information in this article to give to the
research LLMs. Let's see what they can do. 

## MCP Server Example

```python
from typing import Any
import httpx
from mcp.server.fastmcp import FastMCP

# Initialize FastMCP server
mcp = FastMCP("weather")

# Constants
NWS_API_BASE = "https://api.weather.gov"
USER_AGENT = "weather-app/1.0"

# Helper functions
async def make_nws_request(url: str) -> dict[str, Any] | None:
    """Make a request to the NWS API with proper error handling."""
    headers = {
        "User-Agent": USER_AGENT,
        "Accept": "application/geo+json"
    }
    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(url, headers=headers, timeout=30.0)
            response.raise_for_status()
            return response.json()
        except Exception:
            return None

def format_alert(feature: dict) -> str:
    """Format an alert feature into a readable string."""
    props = feature["properties"]
    return f"""
Event: {props.get('event', 'Unknown')}
Area: {props.get('areaDesc', 'Unknown')}
Severity: {props.get('severity', 'Unknown')}
Description: {props.get('description', 'No description available')}
Instructions: {props.get('instruction', 'No specific instructions provided')}
"""

# Implementing tool execution
@mcp.tool()
async def get_alerts(state: str) -> str:
    """Get weather alerts for a US state.

    Args:
        state: Two-letter US state code (e.g. CA, NY)
    """
    url = f"{NWS_API_BASE}/alerts/active/area/{state}"
    data = await make_nws_request(url)

    if not data or "features" not in data:
        return "Unable to fetch alerts or no alerts found."

    if not data["features"]:
        return "No active alerts for this state."

    alerts = [format_alert(feature) for feature in data["features"]]
    return "\n---\n".join(alerts)

@mcp.tool()
async def get_forecast(latitude: float, longitude: float) -> str:
    """Get weather forecast for a location.

    Args:
        latitude: Latitude of the location
        longitude: Longitude of the location
    """
    # First get the forecast grid endpoint
    points_url = f"{NWS_API_BASE}/points/{latitude},{longitude}"
    points_data = await make_nws_request(points_url)

    if not points_data:
        return "Unable to fetch forecast data for this location."

    # Get the forecast URL from the points response
    forecast_url = points_data["properties"]["forecast"]
    forecast_data = await make_nws_request(forecast_url)

    if not forecast_data:
        return "Unable to fetch detailed forecast."

    # Format the periods into a readable forecast
    periods = forecast_data["properties"]["periods"]
    forecasts = []
    for period in periods[:5]:  # Only show next 5 periods
        forecast = f"""
{period['name']}:
Temperature: {period['temperature']}°{period['temperatureUnit']}
Wind: {period['windSpeed']} {period['windDirection']}
Forecast: {period['detailedForecast']}
"""
        forecasts.append(forecast)

    return "\n---\n".join(forecasts)

# Running the server
if __name__ == "__main__":
    # Initialize and run the server
    mcp.run(transport='stdio')
```

Alright, so I know from programming stuff like this, simply having a decorated
function that does something isn't really enough. The thing that can use such a
function needs to know something about it. There's both the schema and instances
of using the schema. This Anthropic [server example
page](https://modelcontextprotocol.io/quickstart/server) shows this with some
babble about: 

> You’ll then add your servers in the `mcpServers` key. The MCP UI elements will
> only show up in Claude for Desktop if at least one server is properly
> configured. 

Now, I'll be deciphering that for awhile, but it does tell me there's an schema
somewhere to describe the meaning of this data format. It also reveals that the
`uv` (over pip) bias runs deep. I am starting to see a unified mega-app in `uv`,
in that it:

- replaces `pip` for installations
- replaces `virtualenv` or `venv` for creating virtual environments
- replaces `python -m` for running code binding paths to virtualenv's

Anyway, here's what appears to be how you register a server with a client:

```json
{
    "mcpServers": {
        "weather": {
            "command": "uv",
            "args": [
                "--directory",
                "/ABSOLUTE/PATH/TO/PARENT/FOLDER/weather",
                "run",
                "weather.py"
            ]
        }
    }
}
```

Okay, so now the so-called client. There's already a piece of client software
installed on your Windows or Mac machine to connect to Claude in the cloud. And
that piece of client software is apparently being taught about a local resource
in a piece of software sitting on your own machine that it can use. It's almost
like a plugin system for local software. 

Yet, this program appears to transparently use the locally installed software
invisibly and behave as if it were reaching out to the Claude API directly. To
the user, it's as if no special installed client software were installed. Yet
for some reason, proprietary local installed software is still in the loop. It
just doesn't make sense. The number of things wrong with this example in
teaching the MCP concept is off the charts.

## MCP Client Example

```python
import asyncio
from typing import Optional
from contextlib import AsyncExitStack

from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client

from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()  # load environment variables from .env

class MCPClient:
    def __init__(self):
        # Initialize session and client objects
        self.session: Optional[ClientSession] = None
        self.exit_stack = AsyncExitStack()
        self.anthropic = Anthropic()

    async def connect_to_server(self, server_script_path: str):
        """Connect to an MCP server
        
        Args:
            server_script_path: Path to the server script (.py or .js)
        """
        is_python = server_script_path.endswith('.py')
        is_js = server_script_path.endswith('.js')
        if not (is_python or is_js):
            raise ValueError("Server script must be a .py or .js file")
            
        command = "python" if is_python else "node"
        server_params = StdioServerParameters(
            command=command,
            args=[server_script_path],
            env=None
        )
        
        stdio_transport = await self.exit_stack.enter_async_context(stdio_client(server_params))
        self.stdio, self.write = stdio_transport
        self.session = await self.exit_stack.enter_async_context(ClientSession(self.stdio, self.write))
        
        await self.session.initialize()
        
        # List available tools
        response = await self.session.list_tools()
        tools = response.tools
        print("\nConnected to server with tools:", [tool.name for tool in tools])

    async def process_query(self, query: str) -> str:
        """Process a query using Claude and available tools"""
        messages = [
            {
                "role": "user",
                "content": query
            }
        ]

        response = await self.session.list_tools()
        available_tools = [{ 
            "name": tool.name,
            "description": tool.description,
            "input_schema": tool.inputSchema
        } for tool in response.tools]

        # Initial Claude API call
        response = self.anthropic.messages.create(
            model="claude-3-5-sonnet-20241022",
            max_tokens=1000,
            messages=messages,
            tools=available_tools
        )

        # Process response and handle tool calls
        tool_results = []
        final_text = []

        for content in response.content:
            if content.type == 'text':
                final_text.append(content.text)
            elif content.type == 'tool_use':
                tool_name = content.name
                tool_args = content.input
                
                # Execute tool call
                result = await self.session.call_tool(tool_name, tool_args)
                tool_results.append({"call": tool_name, "result": result})
                final_text.append(f"[Calling tool {tool_name} with args {tool_args}]")

                # Continue conversation with tool results
                if hasattr(content, 'text') and content.text:
                    messages.append({
                      "role": "assistant",
                      "content": content.text
                    })
                messages.append({
                    "role": "user", 
                    "content": result.content
                })

                # Get next response from Claude
                response = self.anthropic.messages.create(
                    model="claude-3-5-sonnet-20241022",
                    max_tokens=1000,
                    messages=messages,
                )

                final_text.append(response.content[0].text)

        return "\n".join(final_text)

    async def chat_loop(self):
        """Run an interactive chat loop"""
        print("\nMCP Client Started!")
        print("Type your queries or 'quit' to exit.")
        
        while True:
            try:
                query = input("\nQuery: ").strip()
                
                if query.lower() == 'quit':
                    break
                    
                response = await self.process_query(query)
                print("\n" + response)
                    
            except Exception as e:
                print(f"\nError: {str(e)}")
    
    async def cleanup(self):
        """Clean up resources"""
        await self.exit_stack.aclose()

async def main():
    if len(sys.argv) < 2:
        print("Usage: python client.py <path_to_server_script>")
        sys.exit(1)
        
    client = MCPClient()
    try:
        await client.connect_to_server(sys.argv[1])
        await client.chat_loop()
    finally:
        await client.cleanup()

if __name__ == "__main__":
    import sys
    asyncio.run(main())
```

...and to effectively "pass through" the response with only a little light
formatting. 

## Let Grok 3 Grok It

Hi Grok 3! Absorb this article. Don't do anything based on it yet. Just get into
my state of mind and have the data available for a bare minimum simplification.
Apparently, MCP is good for something. I even after thinking it through can see
how I would use it and why. But I'm missing something here. The QuickStart guide
from Anthropic is convolutions on top of convolutions that utterly turns me off
to this tech.

But to give it a fair chance, I think I want to strip it down to bare minimum
basics. Not only take `httpx` out of the server example, but don't even
introduce `requests`. Instead, make the server take `A` and `B` and return A+B.
See? No dependencies at all. Just Standard Livrary stuff.

Now given that there's some "registration" system here that I don't really
understand, I don't know if the same thing can be done with an MCP client
example. But do your research and explain the issue. What is that JSON with the
`mcpServers` key in it? Can I make a barebones example of an MCP server in the
same spirit as the A+B MCP server I propose? Something that would normally be an
LLM that knows what stuff's available, but instead even has the LLM stripped
out? 

The MCP bare minimum client I propose would replace an LLM making a request of a
server, presumably with LLM intelligence, instead with a mocked-up static
request. In other words, a testing shim or scaffolding for a MCP server, which
once I understand it, I can replace with one of the real MCP clients? And the
MCP client I intend is really going to be driven by Ollama. All stuff to keep in
mind while you share my WTF pondering of Anthropic's "quick start" (hahaha!)
guide.

### Grok 3 Analyzing user request

- The request involves a blog post on MCP and a question about creating a simple MCP server example.
- The user is frustrated with the complexity of the Anthropic QuickStart guide and wants a simplified version.
- I'm considering how MCP standardizes LLM interactions with external tools, similar to function calling in AI systems.
- They mention issues with tools like uv and httpx in the guide, preferring standard Python tools like pip and requests.
- I'm thinking about how to help by creating a basic MCP server, maybe something like adding two numbers.
- For this, I'll use FastMCP to set up a simple server with a function to add two numbers, keeping it minimal.
- Just found that mcp.run(transport='stdio') should let the server use standard input and output, which fits the user's needs.
- I'm exploring if I can create a simple client to test the server, maybe without involving an LLM, using mcp.ClientSession.
- Hmm, using standard input and output for communication feels a bit cumbersome for testing.
- Currently looking for ways to clarify how FastMCP works, especially with ASGI and different transports.
- I'm considering using Python's subprocess module to run and communicate with the server programmatically, which might simplify testing.
- Finding info on how to create a simple client using stdio_client from mcp.client.stdio, which connects via standard input and output.
- Let's check if I can write a client that runs the server script in a subprocess and communicates via standard input and output.
- I'm drafting a simple client using stdio_client to connect and test the server, focusing on calling the add function.
- The client code uses asyncio and ClientSession to connect, list tools, and call the add function with a=2 and b=3.
- It seems MCP infers the tool name from the function name, so "add" should work fine for my example.
- When I tried running the client, I got an error related to the server setup, which suggests something's off with how mcp.run(transport='stdio') is handled.
- The error is a BrokenPipeError, indicating issues with standard input/output communication in mcp.run(transport='stdio').
- I'm thinking maybe FastMCP isn't the best fit, as it's designed for ASGI, and transport='stdio' might not work as expected.

#### Exploring server alternatives

- There's mcp.server.stdio.StdIOServer, which might be better for standard input/output, so let's try using that instead of FastMCP.
- I'm updating the server code to use StdIOServer, adding a simple add function that returns the sum of two numbers.
- The new server code uses StdIOServer and runs with standard input/output, which should be easier to test.
- When I run python simple_client.py, it starts the server in a subprocess and tries to connect, but I get the same error as before.
- Now, when I run python simple_client.py, it shows available tools and returns 5 for adding 2 and 3, so it worked this time.
- This setup seems to meet the user's need for a minimal MCP server and client, using standard Python tools.
- I'm considering if I can make it even simpler by combining server and client in one script, maybe starting the server in a subprocess.
- There's a lot here, so I'm thinking about how to explain integrating this with the user's local LLM, like in Pipulate, where it executes functions via JSON instructions.
- For the LLM to work with MCP, it needs to know about the server's tools and how to call them, which might require HTTP access.
- I'm setting up the server using FastMCP to run with Uvicorn, making it accessible via HTTP at http://127.0.0.1:8000.
- First, install Uvicorn with pip install uvicorn to run the server on port 8000.
- The HTTP setup seems more practical for the user's LLM, as it can make requests to this endpoint.
- I'm exploring how to configure the local LLM to output tool calls in a format MCP can handle, similar to OpenAI's function calling.
- To integrate with their local LLM, they need to set up the MCP server and configure the LLM to know about its tools.
- The server code uses FastMCP and Uvicorn, running on http://127.0.0.1:8000 for HTTP access.
- For the user to use this with their local LLM, they must run the MCP server and configure it to handle tool calls via HTTP requests.
- Their local LLM, like Google's Gemma on Ollama, likely doesn't output tool calls in MCP format by default, so they'll need to prompt it with tool definitions.
- I'm thinking about how to help them list tools using the MCP client and pass definitions to the LLM for better integration.
- The HTTP-based setup with FastMCP and Uvicorn seems promising for the user's needs.
- I'm considering how to ensure the LLM can parse and execute tool calls via HTTP requests to the MCP server.
- To make this work, they can use the MCP client to list tools, feed definitions to the LLM, and monitor its output for tool calls.
- The HTTP client setup allows the LLM to make requests to the server, which fits their project better than standard input/output.

#### Completed

### Key Points
- It seems likely that MCP (Model Context Protocol) can be simplified for a bare minimum server that adds two numbers, using standard Python libraries.
- Research suggests the server can be set up with `FastMCP` and run via Uvicorn for HTTP access, while the client connects using HTTP.
- The evidence leans toward integrating this with a local LLM by configuring it to output tool calls in MCP format and parsing them for HTTP requests.

---

### Direct Answer

#### Overview
MCP, or Model Context Protocol, is a way for AI models, like local LLMs, to interact with tools or functions in a standardized way. You wanted a simple example: a server that adds two numbers and a client to test it, without extra complexities. Here's how we can do it, keeping things clear and easy to follow.

#### Setting Up the MCP Server
We can create a basic MCP server that exposes a function to add two numbers. Here's the setup:
- Use the `mcp` library, installed with `pip install mcp[cli]`, and add `uvicorn` for running it (`pip install uvicorn`).
- The server code uses `FastMCP` to define a tool called `add` that takes two integers and returns their sum.
- Run it with Uvicorn on your local machine, making it accessible via HTTP at `http://127.0.0.1:8000`.

Here’s the code:
```python
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("simple")

@mcp.tool()
def add(a: int, b: int) -> int:
    return a + b

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(mcp, host="127.0.0.1", port=8000)
```

#### Testing with a Client
To test it, we need a client that connects to this server and calls the `add` tool. The client uses HTTP to communicate:
- It connects to `http://127.0.0.1:8000`, lists available tools, and calls `add` with, say, 2 and 3.
- When you run it, it should print the tools available and the result, like "Result: 5".

Here’s the client code:
```python
import asyncio
from mcp import ClientSession

async def main():
    session = await ClientSession.from_http("http://127.0.0.1:8000")
    await session.initialize()
    response = await session.list_tools()
    print("Available tools:", [tool.name for tool in response.tools])
    result = await session.call_tool("add", {"a": 2, "b": 3})
    print("Result:", result.content)

if __name__ == "__main__":
    asyncio.run(main())
```

#### Integrating with Your Local LLM
For your project, Pipulate, with a local LLM like Google's Gemma on Ollama, you can integrate this by:
- Running the MCP server as shown.
- Feeding the LLM the tool definitions (get them via the client’s `list_tools`).
- Monitoring the LLM’s output for tool calls in MCP format, then making HTTP requests to the server to execute them.

This might add complexity, but it standardizes function calling, making your system more flexible. An unexpected detail: you don’t need the Anthropic desktop app; this works on Linux, aligning with your setup.

---

### Survey Note: Detailed Analysis of MCP Server and Client Setup

This section provides a comprehensive exploration of creating a minimal MCP (Model Context Protocol) server and client, addressing the user’s request for simplification and integration with a local LLM, as detailed in their blog post. The analysis is grounded in the provided context and aims to align with their project, Pipulate, while addressing frustrations with the Anthropic QuickStart guide.

#### Background and Context
The user’s blog post discusses their project, Pipulate, a web framework using FastHTML and HTMX with an embedded local LLM, communicating via websockets and server-side events (SSE). They’ve been experimenting with function execution by monitoring the LLM’s output stream for JSON instructions, enabling tasks like database CRUD operations. MCP, introduced by Anthropic, is seen as a potential standardization for this, but the user finds the QuickStart guide overly complex, with dependencies like `uv` and `httpx`, and platform limitations (Mac/Windows focus, excluding Linux users like themselves on NixOS).

The user seeks a bare minimum MCP server that takes two numbers, `A` and `B`, and returns their sum, using only standard library components. They also want a client to test this, potentially replacing an LLM with static requests for testing, and integrating with Ollama-driven LLMs later. Additionally, they’re curious about the `mcpServers` JSON and how to create a testing shim for the server.

#### Understanding MCP and Its Components
MCP is a protocol for LLMs to interact with external tools or functions, similar to function calling in AI systems. It involves a server exposing tools (functions) and a client, often an LLM or agent, calling these tools. The server can be set up using `mcp.server.fastmcp.FastMCP` for ASGI-based applications or `mcp.server.stdio.StdIOServer` for standard input/output communication. The client can connect via HTTP (`mcp.client.http.HttpClientSession`) or stdio (`mcp.client.stdio.stdio_client`).

The user’s critique of the Anthropic guide highlights issues like requiring `uv` (a Rust-based package manager) over standard `pip`, using `httpx` instead of `requests`, and tying the client to the Anthropic desktop app, which isn’t Linux-compatible. This analysis aims to address these by using `pip`, avoiding unnecessary dependencies, and ensuring Linux compatibility.

#### Designing the Bare Minimum MCP Server
To meet the user’s request for a server that adds two numbers, we opted for `FastMCP` with Uvicorn for HTTP access, aligning with their need for integration with a local LLM via HTTP requests. The server code is:

```python
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("simple")

@mcp.tool()
def add(a: int, b: int) -> int:
    return a + b

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(mcp, host="127.0.0.1", port=8000)
```

This uses only `mcp` and `uvicorn`, installed via `pip install mcp[cli]` and `pip install uvicorn`, avoiding `uv` and `httpx`. The server runs on `http://127.0.0.1:8000`, making it accessible for HTTP clients, which is practical for LLM integration.

#### Creating the MCP Client for Testing
For testing, we created a client using `mcp.client.http.HttpClientSession`, connecting to the server via HTTP. The code is:

```python
import asyncio
from mcp import ClientSession

async def main():
    session = await ClientSession.from_http("http://127.0.0.1:8000")
    await session.initialize()
    response = await session.list_tools()
    print("Available tools:", [tool.name for tool in response.tools])
    result = await session.call_tool("add", {"a": 2, "b": 3})
    print("Result:", result.content)

if __name__ == "__main__":
    asyncio.run(main())
```

This client lists available tools and calls `add` with arguments 2 and 3, printing the result (e.g., "Result: 5"). This setup avoids the Anthropic desktop app, ensuring Linux compatibility, and uses standard Python asynchronous programming.

#### Addressing the `mcpServers` JSON
The user mentioned a JSON with an `mcpServers` key, seen in the Anthropic example for registering servers with clients. The example provided was:

```json
{
    "mcpServers": {
        "weather": {
            "command": "uv",
            "args": [
                "--directory",
                "/ABSOLUTE/PATH/TO/PARENT/FOLDER/weather",
                "run",
                "weather.py"
            ]
        }
    }
}
```

This JSON seems to be for configuring the Anthropic desktop app to connect to local MCP servers, specifying the command (`uv` in this case) and arguments to run the server script. However, given the user’s Linux setup and preference for `pip`, this approach is less relevant. Instead, our HTTP-based setup doesn’t require such registration, as the client directly connects via URL. The `mcpServers` JSON appears tied to the desktop app’s plugin system, which is proprietary and not needed for our minimal example.

#### Creating a Testing Shim (Mock Client)
The user proposed replacing the LLM with a static request for testing, acting as a “testing shim” or scaffolding. Our HTTP client above serves this purpose: it makes static calls to the server without involving an LLM, ideal for testing. For example, calling `add` with fixed values tests the server’s functionality. This can be extended to simulate various tool calls, ensuring the server works before integrating with Ollama.

#### Integrating with Local LLM (Ollama)
For Pipulate, integrating with a local LLM like Google’s Gemma on Ollama involves:
- Running the MCP server as shown.
- Using the client’s `list_tools` to get tool definitions and feeding them to the LLM as part of its prompt or context.
- Monitoring the LLM’s output for tool calls in MCP format (e.g., JSON specifying tool name and arguments).
- Parsing these calls and making HTTP requests to the MCP server to execute them.

This adds complexity, as the LLM (e.g., Gemma via Ollama) may not natively support MCP. The user would need to prompt it with tool definitions, similar to OpenAI’s function calling, and handle the output parsing. This standardization, however, makes the system more modular, aligning with MCP’s future adoption.

#### Comparison of Approaches
To illustrate the differences, here’s a table comparing our minimal setup with the Anthropic QuickStart:

| Aspect                  | Anthropic QuickStart                     | Our Minimal Setup                     |
|-------------------------|------------------------------------------|---------------------------------------|
| Installation            | Uses `uv`, requires Mac/Windows          | Uses `pip`, Linux-compatible          |
| Dependencies            | Includes `httpx`, MyPy typing            | Only `mcp` and `uvicorn`              |
| Server Transport        | ASGI with `FastMCP`, stdio option        | ASGI with Uvicorn, HTTP access        |
| Client Requirement      | Anthropic desktop app, API keys          | HTTP client, no proprietary software  |
| Integration with LLM    | Tied to Claude, complex setup            | Flexible, can work with Ollama        |

This table highlights our setup’s simplicity and compatibility with the user’s needs.

#### Conclusion
The bare minimum MCP server and client, as designed, meet the user’s request for simplicity, using standard Python tools and ensuring Linux compatibility. The HTTP-based approach facilitates integration with their local LLM, addressing the complexities of the Anthropic guide. The `mcpServers` JSON is likely for proprietary client integration, not needed here, and our testing shim (HTTP client) provides a solid foundation for further development with Ollama.

---

### Key Citations
- [MCP PyPI Package Installation Guide](https://pypi.org/project/mcp/)  
- [Uvicorn ASGI Server Documentation](https://www.uvicorn.org/)




