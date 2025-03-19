---
title: Reinvigorating Project
permalink: /futureproof/reinvigorating-project/
description: 
layout: post
sort_order: 1
---

The purpose of today's post is crystal clear: to re-invigorate this project.
Things stall out. Life happens and momentum gets broken. There's nothing like
trying to refactor some code while other parts are in motion to make everything
explode in complexity and drain motivation. Everything we do costs some decision
fatigue, and we only have so much to divvy out every day among the things we
want to get done. And that's assuming we have the clarity about what we want to
get done, the figuring out of which costs even m ore decision fatigue, until
before you know it you've spent everything you've got for the day before even
getting started, and that's what we're battling.

So there's knowing what to do and why. And then there's the 80/20-rule
organizing of the work so we get the 80% of the benefit from the front-loaded
first 20% of the effort we believe we are going to be able to put into it. That
way, even if you have to stop when you're only 1/5th done, you could have
stopped and still have won. That's what we're doing right now.

I have two project names for my current work: Pipulate and Botifython. That's
because Pipulate is my FOSS SEO software that's been out there in one form or
another for years. Not quite decades, but long enough to have established the
fact. But now I work for Botify, and I'm pushing my tools into the AI future
with a keen eye towards future-proofing, while keeping as much as possible
Python, thus Botifython. There will be proprietary bits to the Botifython
"version" which won't reach Pipulate, but not much. As little as possible
really, considering everything I do in public with the Botify API only uses
knowledge that's available in the public Botify API documentation, and
practicing it public could only help existing Botify customers, and perchance
maybe even win a few new ones.

That being said, there are still bits to the system where... well, where there's
going to be training material on processes and workflows that I'm going to want
to keep secret. Think of it as the AI future-proofing bit. Things are going to
change fast and furious over the coming years. So much of what we know today
will be obsolete tomorrow, but not everything. One of the things you can rely on
is the basic notion of learning things from text files. The better you prepare
and organize those text files for LLM training, the more future-proof you are.
You can train today's models using such documentation, or you can train future
models. So if you keep folders of organized documentation, that can be used
today, tomorrow and long into the future. And that training material is the
proprietary bit.

Okay, so back to the practical stuff. I have a private repo called Botifython
with two git branches: main and magic. Magic is quite recent, in which I
searched through my git log to find the magical state where almost everything
that was a working behavioral specification was actually working. And I used it
to great effect, showing the company the potential of what I've built at a
recent event. But it's all based on older versions of the code before I made a
BaseFlow class. I resisted a base class for workflows for the longest time due
to how they complicated everything, throwing off the linear-reading of code. It
presumes prior knowledge and familiarity with custom code, and then you get in
this mode of overwriting default behavior for the advantage of not repeating
yourself. But that's only one approach. If what you would repeat flows naturally
and is exactly the right amount of expressiveness, then repeating yourself is
not tedious. It's explicit and expressive!

I want my code to live at that ideally explicit and expressive vibrating edge
where it's not too much to look at, and everything you look at is exactly what
you need to understand what's happening, and even fine-tune and tweak the
behavior this way and that without needing to look at the pedantic internals.

Okay... so I think I am achieving that. But my codebase has split in the
attempt. I got it to the point where a BaseFlow can make a workflow of simple
Form input fields with minimal code. And this whole article is really to get
the LLMs up to speed on where I am at and what I'm trying to do, so that they
can help me. Here's a bunch of stuff that may be of interest to you, but which
they definitely need to hear to help me get through the next step.

Yes, what I'm making is yet another web framework very roughly in the spirit of
Rails or Django, but its a bit different in the following ways.

It's designed to run locally on the user's machine, using nix to create a
unified normalized underlying Linux platform, something the user hardly need
concern themselves with, suffice to say it achieves something similar to the
Electron development platform, without any of Electron's platform-specific
installation story. Nix takes care of all the underlying platform issues, and
also provides all the access to the local machine's storage, bandwidth, GPUs and
other resources nix can provide.

The entire codebase that is not part of standard well known libraries that the
LLM is likely already aware of through its training resides in merely 3 files:
flake.nix (which establishes the platform) and a server.py file (likely named
botifython.py or pipulate.py). There is also a requirements.txt file for pip.
And that's all. The beautiful thing here is that there is no question of where
to look or what's in or out of context. It's always those two files, and really
since there's hardly any changes to the execution environment, it's just the one
file.

You might ask what about the styles.css file or the JavaScript file. But the
answer is that with FastHTML, the Python package on which this is based, there
is no external styles.css file or .js files either. It's all in the server.py
file. This seems almost absurd to most LLMs over-trained on what's sometimes
called the web full stack, with is NodeJS, WebAssembly and build-process
oriented. But that's not the only way, and there's a revolution afoot for those
who are willing to trade compiled C performance for highly readable, casual
no-build workflow. And FastHTML's use of HTMX wins back a lot of the performance
it looses by not being WASM by not having a build process, virtual DOM,
heavyweight 3rd party components, or really much beyond the standard HTML spec.

Specifically, the static components available to the server at the time of this
writing are:

- JavaScript & CSS Libraries:
- HTMX https://unpkg.com/htmx.org@2.0.4/dist/htmx.js
- HTMX WebSockets Extension https://unpkg.com/htmx-ext-ws@2.0.1/ws.js
- FastHTML 1.0.12 https://github.com/AnswerDotAI/fasthtml-js/blob/main/fasthtml.js
- Surreal 1.3.2 https://github.com/gnat/surreal/blob/main/surreal.js
- CSS Scope Inline https://github.com/gnat/css-scope-inline/blob/main/script.js
- PicoCSS 2.0.6 https://github.com/picocss/pico/blob/main/css/pico.css
- SortableJS 1.15.6 https://github.com/SortableJS/Sortable/blob/master/Sortable.js

All these components are popular and mainstream enough that LLMs should
typically already be trained on. They are the components that are normally just
loaded from their conventional CDN locations. All the custom code for the app is
in just one .py file, including containing any CSS or JavaScript customization
using FastHTML's attributes and inline approach. This file, often named
botifython.py or pipulate.py (depending on the git repo you're working from) is
usually only from 6K to 10K lines of code, fitting easily in the increasingly
common million token window of LLMs. And so there is one context to rule them
all. LLMs might need to be pointed to where in the code it should focus, but
there is never any question of anything not being known. It's all right there.
Do you know how much cognitive overhead it takes to go directory diving and
searching across files? Spare both yourself and the LLMs the grief. There's an
easier way.

There is also a flake.nix file that establishes the execution platform --
Infrastructure as Code (IaC) that solves the "not on my machine" problem, and
technically there is also a requirements.txt file, because instead of defining
all the Python dependencies in the flake.nix file, a Python virtualenv is
created and the dependencies are pip installed into there, keeping the
environment more flexible and Data Science-friendly than is typical under a
deterministic nix flake. In other words, the majority of the code execution
environment is set by nix, and the Python components are installed under
Python's own pip package manager, so that the user can freely pip install as
they would in the native host OS or any other environment hosting Python.

