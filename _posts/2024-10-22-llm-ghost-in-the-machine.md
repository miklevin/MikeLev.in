---
title: LLM Ghost In The Machine
permalink: /llm-ghost-in-the-machine/
description: 
layout: post
sort_order: 1
---

## OpenAI's Newest Models Sometimes Help with Code Refactoring

Sometimes you can dump a codebase into OpenAI o1-preview and it will give you
great advice you can copy/paste over to Code AI where Claude 3.5 sonnet will
sort it all out; from one AI's mouth to another's ears. And sometimes it doesn't
quite work out that way. Getting the magical updates to appear on the page after
the LLM does some back-end CRUD manipulation is one of those times.

## Old AI Models Don't Know New Technology

It seems the problem is everything's new. The FastHTML web framework I'm using
is new. The HTMX way of updating a page without page reloading is new. Well, the
AJAX technique isn't new, but the very structured syntax for doing it under the
new HTML standard is. It's both new and incredibly nuanced with these OOB (out
of bounds) parallel track bit chucking. I'm chucking bits all over the place. I
have to learn to control it.

## A Simpler Approach to Updating with HTMX Philosophy

With this HTMX everything can be updated by anything philosophy, you can "paint"
updates onto the screen. However, there's a lot of record keeping and very
precise targeting involved, or you're going to mangle your DOM. There's so
frustrating as mangling your DOM beyond recognition through careless bit
chucking. Consequently, I'm going for a much more simplified approach which
should be both an umbrella solution for all situations, and a nice stopgap until
I learn how to chuck those bits with greater precision. And lastly, because HTMX
is capable of doing a page refresh without a full round-trip page-reload (as if
hitting F5/refresh), it actually promises to be a snappy solution that nobody
will know from bits hitting their bullseye.

The problem is that I hardly even know HTMX enough to pull off this more
simplified approach.


