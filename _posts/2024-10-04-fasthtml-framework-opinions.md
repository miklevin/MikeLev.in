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



