---
title: LLM Ghost In The Machine
permalink: /llm-ghost-in-the-machine/
description: 
layout: post
sort_order: 1
---

## OpenAI's Newest Models Sometimes Help with Code Refactoring

Sometimes you can dump a codebase into OpenAI o1-preview and it will give you
great advice you can copy/paste over to ***Cursor AI*** where Claude 3.5 sonnet
will sort it all out; from one AI's mouth to another's ears. And sometimes it
doesn't quite work out that way. Getting the magical updates to appear on the
page after the LLM does some back-end CRUD manipulation is one of those times.

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

## Would That Be Red Herring or Wild Goose Chase?

After losing almost a day on trying to get the ghost in the machine (GITM)
effect with a blanket HTMX-style redirect, I'm learning that just doing the
painterly thing and updating this and that through HTMX at the key moment it
occurs is much easier and a better effect than the blanket redirect. "Painting"
granular HTMX changes onto the screen is ironically both easier to achieve with
AI-guidance and a better effect. Sheesh! I spun my wheels on that one.

Anyhow, I have a few big take-aways. I learned to `import functools` and use it
to create a wrapper class to cut down debugging log statements. I did this on my
DictLikeDB:

```python
# Color map for easy customization
COLOR_MAP = {
    "key": "yellow",
    "value": "white",
    "error": "red",
    "warning": "yellow",
    "success": "green",
    "debug": "blue"
}

def db_operation(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        method_name = func.__name__
        color = "magenta"
        logger.debug(f"COOKIE Begin: <{color}>{method_name}</{color}>")
        try:
            result = func(*args, **kwargs)
            return result
        finally:
            logger.debug(f"COOKIE End: <{color}>{method_name}</{color}>")
    return wrapper

class DictLikeDB:
    """
    A robust wrapper for dictionary-like persistent storage.

    This class provides a familiar dict-like interface to interact with
    various types of key-value stores, including databases and file systems.
    It emphasizes the power and flexibility of key-value pairs as a
    fundamental data structure in programming and system design.

    Key features:
    1. Persistence: Data survives beyond program execution.
    2. Dict-like API: Familiar Python dictionary operations.
    3. Adaptability: Can wrap different storage backends.
    4. Logging: Built-in logging for debugging and monitoring.

    By abstracting the underlying storage mechanism, this class allows
    for easy swapping of backends without changing the client code.
    This demonstrates the power of Python's duck typing and the
    universality of the key-value paradigm across different storage solutions.
    """

    def __init__(self, store, Store):
        self.store = store
        self.Store = Store
        logger.debug("DictLikeDB initialized.")

    @db_operation
    def __getitem__(self, key):
        try:
            value = self.store[key].value
            logger.debug(f"Retrieved from DB: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}> = <{COLOR_MAP['value']}>{value}</{COLOR_MAP['value']}>")
            return value
        except NotFoundError:
            logger.error(f"Key not found: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>")
            raise KeyError(key)

    @db_operation
    def __setitem__(self, key, value):
        try:
            self.store.update({"key": key, "value": value})
            logger.debug(f"Updated persistence store: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}> = <{COLOR_MAP['value']}>{value}</{COLOR_MAP['value']}>")
        except NotFoundError:
            self.store.insert({"key": key, "value": value})
            logger.debug(f"Inserted new item in persistence store: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}> = <{COLOR_MAP['value']}>{value}</{COLOR_MAP['value']}>")

    @db_operation
    def __delitem__(self, key):
        try:
            self.store.delete(key)
            logger.warning(f"Deleted key from persistence store: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>")
        except NotFoundError:
            logger.error(f"Attempted to delete non-existent key: <{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>")
            raise KeyError(key)

    @db_operation
    def __contains__(self, key):
        exists = key in self.store
        logger.debug(f"Key '<{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>' exists: <{COLOR_MAP['value']}>{exists}</{COLOR_MAP['value']}>")
        return exists

    @db_operation
    def __iter__(self):
        for item in self.store():
            yield item.key

    @db_operation
    def items(self):
        for item in self.store():
            yield item.key, item.value

    @db_operation
    def keys(self):
        return list(self)

    @db_operation
    def values(self):
        for item in self.store():
            yield item.value

    @db_operation
    def get(self, key, default=None):
        try:
            return self[key]
        except KeyError:
            logger.debug(f"Key '<{COLOR_MAP['key']}>{key}</{COLOR_MAP['key']}>' not found. Returning default: <{COLOR_MAP['value']}>{default}</{COLOR_MAP['value']}>")
            return default


# Create the wrapper
db = DictLikeDB(store, Store)
logger.debug("Database wrapper initialized.")
```

## Debugging Output Becomes More Informative with Syntax Coloring

...and the output is amazing! I'm even syntax color-coding key/value pairs. It
makes the debugging output on the server console eminently readable, informative
and frankly more fun to look at. This is the process of tightening the
constraints around potential bugs and to clarify the hierarchical operation of
the function visually. I see when functions are entered and exited. It's like
nesting and un-nesting tables in HTML to see proper opening and closing of
objects. If object don't open and close correctly, bugs happen.

## The Ghost in the Machine Effect Comes to Life

This is particularly important with this ghost in the machine effect, because of
all the HTMX painting it turns out I'm going to be doing. I only really achieved
the effect on the Insert (aka Create of CRUD) action so far, but that alone is
eerily impressive to see. I can't wait until I can tell the LLM to toggle, sort
(change priority), and update. I'm not sure if I'm going to give it the ability
to delete, haha! But because it's laborious thought-work, I'm going to defer it.
But the good news is the concept is proven and I've pinned up the insert example
in my code so that I have a great starting point when I can revisit those
ghostly LLM operations. Appropriate for Halloween, haha!

## Regret Over Rolled-Back AI Teaching Functionality

One of the things I'm sorry about is that I had to roll back some of the
callback "teaching the AI" functions. That is, when one of these ghost in the
machine function-calls fails, I took the error message right down to the
detailed traceback and feed it back into the LLM as a system message so that it
could make another try and fix its mistake. However, the complexity exploded and
as excited as I was about that, I basically gutted those features since the last
time I discussed them here. The idea is solid, just my implementation lacked.

## LLMs Don't Like Python Traceback Error Messages Any More Than You Do

See, LLMs are going to really take to hart the latest info in the conversation
history and if it's ugly debugging messages, it's going to start talking
gobbledygook back to you&#151;especially when it gets a taste of those
indecipherable Python traceback messages, haha! No, it's not just you. Those
things are confusing as hell and it even makes LLMs start talking nonsense. The
answer is to control the error message that gets fed back into the LLM with
precision and clarity. It's got to be like a teacher or college professor
breaking down the problem, where it went wrong, how it could do better next
time, giving an example directly related to the given attempt and an explicit
command to try again.

## Maintaining Control in AI-Assisted Code Editing: A Delicate Balance

Which brings us up to the current state of the project. I'm going to leave
full-fledged GITM effect for later, happy I have insert implemented, and focus
more on the now long-overdue application ports into the system, along with
really tight debugging output and maintaining incredibly tight grips on the
reins of this wild careening wagon of an application. AI-assisted code editing
is wild. It knows so much&#151;inhumanly so, but sometimes in a ***too smart for
its own good*** (or for ours) way. It will jump at the opportunity to take you
down the rabbit hole of adding functions and exploding complexity for the best
practices of the industry that led us to ReactJS. Not good.

## Forcing AI to Focus on Specific Code Snippets in Large Projects

This is where I feel compelled to write a Cursor AI tips and tricks article in
particular about forcing the AI to anchor on and focus on and apply its
recommended edits to the exact right part of your code, especially when the
codebase gets big. That whole "apply to entire file" thing gets old after a few
thousand lines of code, and the difference between `Ctrl+Shift+K` and `Ctrl+L`
for either inline help or chat-interface help is enormous. You'd think it's the
same, but it's not. It's all this API-nuance stuff. You can have global context
and terrible targeting, or you can have laserbeam targeting and loss of global
context. I'm sure this will get better with bigger token context window models
like Gemini, but I'm thinking maybe it shouldn't have to. 

## The Choice Between Global Context and Bullseye Nailing Aim

If you have good programming skills and don't fall victim to the
dependency-inducing sirens song of a superintelligent coding entity there to
help, then the choice between diffuse global context with no aim and
bullseye-nailing aim but no big picture makes total sense. It's the same issues
as with global variables being bad and side-effects being the enemy of
predictability that makes "functional" programming so appealing. If you don't
see it going in and out of the function's interface, it doesn't exist. No side
effects. No global objects being tweaked this way and that as a sort of
configuration. You won't know about them. The AI won't know about them. It's a
mess. But you can't get away from them because... well, Python. The idea is to
just wrangle it effectively. There's a lot of 80/20-rule solutions to use.

So I said I'm ***not*** going to write that Cursor AI 
