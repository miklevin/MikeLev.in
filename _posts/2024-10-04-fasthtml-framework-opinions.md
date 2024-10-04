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

Anyhow, fast-forward some 2 decades, and the most love-worthy thing in tech that
I've found is a language which it itself is most of the framework. And it's
love-worthy, because most of its opinions are ones I agree with, or at least can
live with. And that of course is Python itself. Python is a framework. But it
doesn't go all the way, and you still have to layer other frameworks on top of
it, to get a web development system for example. Many people love the Flask
microframework for web development when it came out, because it was mostly just
Python. It didn't do much but route web requests into Python functions with
clever syntactical sugar called a decorator. 

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

I am frankly staggered by the opinions that FastHTML is stating but slyly
understating, in Jeremy Howard's signature way. If you don't know this guy, go
check out his YouTube and Fast.AI tutorials. He was the big thing in AI before
ChatGPT hit. It was more about machine learning and image recognition than it
was about chatbots back then, and Jeremy used his penchant for simplifying APIs
in that uniquely Pythonic way that Requests did to the HTTP library to do to the
PyTorch library. Some might call it the Pytorcher library. Hmmm. What's that
history on the Python HTTP libraries?

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
