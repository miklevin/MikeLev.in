---
date: 2023-08-25
title: Adding WebDev to MyKoz.AI with uvicorn ASGI Python Webserver
headline: I Just Added WebDev to MyKoz.AI with uvicorn ASGI Python Webserver!
description: I added webdev to MyKoz.AI with uvicorn ASGI Python webserver. Follow the steps I used to add another monitorable service running through GNU screen that opens new possibilities. This sets the stage for writing a sample HTMX app.
keywords: webdev, HTML, HTMX, JavaScript, ReactJS, DOM, AlpineJS, WSGI, ASGI, gunicorn, uvicorn, WSL, Flask, FastAPI, Python, webserver, HTTP, virtualenv, systemd, GNU, screen
categories: html, python, virtualenv, gnu, systemd, wsl, javascript
permalink: /blog/adding-webdev-to-mykoz-ai-with-uvicorn-asgi-python-webserver/
layout: post
group: blog
---


Okay, MyKoz.AI really needs ***webdev*** as a part of it. Even for projects
that I want to start. There's only one viable long-term user interface sort of
development to take up, and that's web development. However, the same can not
be said about the JavaScript frameworks like ReactJS. They come and go too
quickly and are the definition of what you want to stay away from to resist
obsolescence. You know what's not? ***HTML.*** And that makes ***HTMX*** the
webdev approach to use. 

With HTMX, you keep most everything on the server. Only leverage client-side
JavaScript frameworks to ease the difficulty of HTML div-replacement and such.
Just swap out rectangular regions of HTML code on events. Bammo whammo, it's
not really webdev. It's timeless HTML. Oh yeah, the Web and JavaScript happens
to be there, but it need not ruin your 10-years and 10,000 hours. And what is
HTMX? Some library to download? No, not quite. You will need a lightweight
JavaScript framework like AlpineJS to do the dirtywork. But besides that, it's
just the use of vanilla HTML and some coding discipline.

That's the beauty of it. HTMX is just a way of working with HTML that assumes
you have just enough JavaScript control to swap out DOM components. The rest is
up to you.

Yup. That's the kind of WebDev I want in MyKoz.AI.

Okay, so we need a lightweight Python webserver. Just to remind folks, this is
at a lower level even than Python web frameworks like Flask or FastAPI. Either
of those technologies can probably be used here too, but before you even talk
about ***yet another framework***, albeit Python server-side as Flask and
FastAPI are, they're not the beginning of this discussion. The beginning of the
discussion is choosing your WSGI, or more modern ASGI, server you're going to
use. 

Historically, the no-brainer was something called `gunicorn`. I guess you can
think of it like ye old Apache, but respecting Python conventions. But since
everything went to asynchronous mode, WSGI won't cut it anymore and many
gnuicorn users have moved to `uvicorn`. It's really just a Python-friendly
gnuicorn WSGI server updated to ASGI for faster performance.

Okay, so how do we install it? With a `pip install uvicorn` of course! But
wait! There's more. And I think I will need some of that more, because I'll be
running this under `WSL` and that means it has special considerations for that
nifty source monitoring feature where you can just ***change files*** and have
the webserver pick up the changes without having to stop and start it.

Okay, so we do a test install:

```bash
pip install 'uvicorn[standard]'
```

and then we make a file using their `quickstart` example:

```python
async def app(scope, receive, send):
    assert scope['type'] == 'http'

    await send({
        'type': 'http.response.start',
        'status': 200,
        'headers': [
            (b'content-type', b'text/plain'),
        ],
    })
    await send({
        'type': 'http.response.body',
        'body': b'hello, world!',
    })
```

and then we run it:

```bash
uvicorn example:app
```

Yup, `Hello World` is being served as promised. For those who are still
wondering why no `Flask` or `FastAPI` at this point, it's because the example
they provide is so low-level that it's writing out the http response codes
explicitly. This is the kind of overhead that Flask and FastAPI do for you. But
wow! What a great introduction to WebDev!

I ***need*** to build this into MyKoz.AI as fast as possible. Then move onto
the other stuff you want to do today.

This should be a ***third*** service that's visible to the MyKoz.AI user the
same way the JuptyerLab and `yourservice` service are using the GNU `screen
-ls` command. It should be fully visible and able to be ***poked around*** once
you know gnu screen a bit.

Hmmm. Steps? 1, 2, 3... 1? Get it installed! 

Okay, it's odd but i can add this line to `mykoz/requirements.txt` that's used
with the `pip install -r requirements.txt` command.

```
uvicorn[standard]
```

Okay, and it's tested. now let's see if we can precision scalpel this in. i did
it recently with the `your.service` daemon, so just shadow that. 1, 2, 3... 1?

Create the `uvicorn.service` file. done.

Add it to the giant curl command in `install_wsl.sh`. done.

Okay, make a github repo named `webdev` with the uvicorn example in it. done.

Don't do too many steps (like starting the service) yet. commit, push and
install MyKoz.AI again on this machine and make sure everything's in place.
delete the webdev repo ahead of time.

Okay, wow. I just re-ran the MyKoz.AI install procedure on this machine. I only
had to make tiny adjustments to my workflow now to be re-settled onto this
new-again hardware. It's a laptop that's been out of commission for months
because of a catastrophic crash. It got me on Windows 11 for long enough to
know that I hate it. The metal is hot! I could really push MyKoz.AI on the
inevitable Windows 12 push.

But don't get distracted. The whole install process worked getting the new
webdev repo and all. So test-start uvicorn again without going though gnu sceen
yet. Change directories into the webdev repo and run:

```bash
uvicorn example:app
```

Okay, confirmed! We want to model how this starts and stops on how the
JupyterLab and yourservice both start and stop, and that's with a bash script
that goes into ~/pyenv/bin/` which is a brilliant way to beat the eternal path
issues. `virtualenv`, the Python tool for making ***virtual Python
environments*** goes to considerable lengths to make sure you can issue Python
commands as if they were built-in operating system commands. And we can
piggyback off that same trick to run new bash scripts we need the same way.
That's what uvicorn itself is doing. So the above command could really be
re-written as:

```bash
/home/ubuntu/pyenv/bin/uvicorn example:app
```

And so the new `uvicorn.service` file I'm creating contains this:

```bash
#! /usr/bin/env bash

source /home/ubuntu/pyenv/bin/activate

# Run through GNUY screen and prevent double-running
cd /home/ubuntu/repos/webdev
screen -wipe >/dev/null 2>&1
if ! screen -list | grep -q "uvicorn"; then
    screen -dmS uvicorn /home/ubuntu/pyenv/bin/uvicorn example:app
fi
```

Alright so add `startuvicorn` to the mykoz repo and to the giant curl command.
Okay, so now both the systemd file and the pyenv bin file are made and part of
the repo. Now I just need to make sure the file permissions are correct and the
service is enabled and started. Okay, done. Do a MyKoz.AI install and check if
the Hello World website is running.
















<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/going-back-to-windows-10-from-windows-11/">Going Back to Windows 10 From Windows 11</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/re-defining-seo-the-impending-tech-flood-and-how-to-survive-it/">Re-Defining SEO: The Impending Tech Flood and How To Survive It</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/virtualenv/'>virtualenv</a></h4></li>
<li><h4><a href='/gnu/'>GNU</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li></ul>