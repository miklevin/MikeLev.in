---
title: LLM Ghost In The Machine
permalink: /llm-ghost-in-the-machine/
description: 
layout: post
sort_order: 1
---

After yesterday's chasing the rabbit down the rabbit hole, the local LLM is now
full context aware coverage of the actions the user does in the software. As
long as I make the LLM comment on everything the user does, I know it's going
into the discussion history.

## The Todo App Concept at the Heart of Ghost In The Machine

Most of the ghost in the machine features are surrounding the word "task", which
while a bit hardwired (right now), was the best choice because I can turn it
into a parameter eventually, and it's the same approach as with the plugin apps,
which are often going to be modeled after the task (aka todo) app. As Jeremy
Howard says, everything is sort of the todo-app, right? Right! Linked lists.

## Planning to Avoid Rabbit Hole Binge in Task Implementation Today

Anyhow, planning today is about rabbit hole avoidance. It's about final critical
touches necessary to complete the *ghost in the machine* effect. The LLM fairly
reliably inserts tasks upon request, but a page refresh is needed to see it.
I've got to solve that pronto, and WITHOUT the chasing rabbits too deep into
Wonderland. I'm going to start with just implementing an HTMX-style page
refresh. I have to figure out if that's the same as a full page reload, and how
much is actually required for a catch-all that will show me what the LLM just
did, be it an insert, update, toggle, sort or whatever. There's more
sophisticated ways of doing this with HTMX "painting" this and that on the
screen after an action, and I'll get there. Just not today.

