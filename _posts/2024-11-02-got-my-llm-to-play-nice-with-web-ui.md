---
title: How I Finally Got My LLM to Play Nice with the Web UI
permalink: /how-i-finally-got-my-llm-to-play-nice-with-the-web-ui/
description: 
layout: post
sort_order: 1
---

## Developers Can Control Browser with LLMs

I open up today's article with a profoundly optimistic headline. I recently
(like 4:00 AM this morning) dug my way out of a deep, deep developer rabbit
hole. LLMs should be able to control whatever you want them to be able to
control in your web browser, right? If you invent some **command-and-control
language** that they can ***learn fast*** through prompt-injection, they should
be able to look at the DOM of the page and do stuff to it, like adding new items
to a list, right? Sounds reasonable? I know! To me too. It opens the door to all
sorts of AI-assisted apps whose time has come.

## Is AI Chat Speed Simulated or Real?

Have you asked yourself whether that pace of words being revealed when you chat
with an LLM is the actual response-rate of the AI or a simulated effect to sell
the chat-experience, and that it might actually be that much faster&#151;slowing
itself down for the sake of us humans? Yeah, me too! This is especially poignant
when you're running the LLM local on your machine and the slowness is likely to
be genuine. Why simulate when the real response-rate of the LLM is incredibly
valuable even just in terms of benchmarking which one you want to use by really
***feeling how fast it is*** right there in browser interaction? Right? Right!

## WebSockets Stream LLMs at Speed of Thought

Well the new kid on the block enabling chat-features in everything, WebSockets,
is totally the way to do this and I switched over my LLM streaming chat response
from a simulated effect, because yes starting with `llama3.1`, responses were so
fast even on a Macbook, slowing them down made sense. That's not to say how
smart it was. As I experimented with different models I realized how
wrong-headed a simulated typing effect was. WebSockets is ***made to preserve
streams*** just like this, and not doing so was stupid. So I bit the bullet and
brute-forced my way through my WebSocket education and implementation. Now my
LLMs stream their output as fast as they think.

## Python Generators Mangle Payloads

This made a previously reliable delivery mechanism for larger payloads&#151;like
JSON objects with embedded instructions about what to do once recognized,
snagged from the data-stream, parsed and carried out&#151;much more difficult.
The main data-stream is now a chunky yielding generator. Python terminology
doesn't get better than this, and if you have a Ruby on Rails-lover in your
life, it's going to get interesting when you start ***talking generators***,
because it means totally different things. In RoR-land a generator is a way to
spew out you scaffolding framework to start customizing your app. In Python, a
generator is a memory-effect way of working through more data than your computer
was ever designed to handle, by trickling it out like a drippy water faucet. But
the price of such real-time streaming is Python dicing your data up like... what
kind of chef? Perplexity?

**Perplexity**: Python generators are indeed a powerful feature for handling large datasets efficiently. They allow you to work with data in a memory-efficient manner, processing items one at a time rather than loading everything into memory at once. This can be particularly useful when dealing with large payloads or data streams.

## Generator Basics

Generators in Python are created using functions with the `yield` keyword. When called, they return a generator object that can be iterated over[2]. Here's a simple example:

```python
def simple_generator():
    yield 1
    yield 2
    yield 3

gen = simple_generator()
print(next(gen))  # Output: 1
print(next(gen))  # Output: 2
print(next(gen))  # Output: 3
```

## Advantages of Generators

1. **Memory Efficiency**: Generators produce values on-the-fly, allowing you to work with large datasets without loading everything into memory[2].

2. **Lazy Evaluation**: Values are generated only when requested, which can lead to performance improvements[2].

3. **Infinite Sequences**: Generators can represent infinite sequences, which is not possible with regular lists.

## Generators for Payload Processing

When dealing with large payloads or data streams, generators can be particularly useful:

```python
def payload_processor(data_stream):
    for chunk in data_stream:
        # Process the chunk
        processed_chunk = process(chunk)
        yield processed_chunk

# Usage
for processed_data in payload_processor(large_data_stream):
    # Do something with the processed data
    pass
```

This approach allows you to process large payloads in chunks, which is especially useful when dealing with network streams or large files.

## Advanced Generator Techniques

1. **Generator Expressions**: Similar to list comprehensions but for generators[4].

```python
gen = (x*2 for x in range(1000000))
```

2. **Sending Values to Generators**: The `send()` method allows you to pass values into the generator[3].

```python
def echo_generator():
    while True:
        received = yield
        print(f"Received: {received}")

gen = echo_generator()
next(gen)  # Prime the generator
gen.send("Hello")  # Output: Received: Hello
```

3. **Asynchronous Generators**: In Python 3.6+, you can create asynchronous generators using `async def` and `yield`[4].

## Challenges with Generators

While generators offer many benefits, they can introduce challenges when working with certain types of payloads:

1. **Non-sequential Access**: Generators are forward-only iterators, making it difficult to access previous items.

2. **Stateful Processing**: If your payload processing requires maintaining state across the entire dataset, generators may complicate this.

3. **Debugging**: Debugging generator-based code can be more challenging due to their lazy evaluation nature.

In conclusion, Python generators are like a skilled sushi chef, carefully slicing your data into manageable pieces, allowing you to process large payloads efficiently without overwhelming your system's memory. However, like any powerful tool, they require careful consideration and proper application to fully leverage their benefits.

Citations:

    [1] https://github.com/klezVirus/deser-py
    [2] https://wiki.python.org/moin/Generators
    [3] https://stackoverflow.com/questions/19302530/what-is-the-purpose-of-the-send-function-on-python-generators/19302694
    [4] https://docs.python.org/pt-br/3.7/reference/expressions.html
    [5] https://www.youtube.com/watch?v=ZY6uHybLoZA
    [6] https://github.com/A-poc/RedTeam-Tools
    [7] https://posthog.com
    [8] https://www.youtube.com/watch?v=yPh7ZJr-A0E

---

## Perplexity Still Top Dog in Search Revolution (sorry, OpenAI Search)

### That's it, like a skilled ***sushi chef***. Thanks, Perplexity!

Look at this article it puts together and tight tallying of citations! You're
still my go-to AI for this kind of inquiry, even though OpenAI's long-awaited
GPTSearch finally came out yesterday. Happy Halloween, everyone! So much to talk
about there, how ***small world theory*** is finally hitting general web-search
by which a real-time crawl is sent out at the moment of user search inquiry in
order to... in order to... in order to...

...well quite frankly, evaporate Google's moat (difficult to reproduce
competitive advantage per Warren Buffett). The Internet is a database, and why
keep a ***crawled-and-indexed*** copy of it if people are conditioned to be
patient enough to wait just a little longer to get an accurate answer regarding
the state of the world, that product availability off the embedded schema.org of
the site read in real-time? Anyhoo, the way the world of search has just been
turned upside down is the subject for another article if at all&#151;go become a
Botify customer if you really want AI SEO consulting on this kind of stuff.

## New App Combines Three Communication Methods

And so I ramble and meander here in the warm-up for this article, because it'
going to be a doozy&#151;hopefully in all the good ways. Whereas yesterday's was
long, rambling and soul-sucking, morale-draining and generally a shit-show of
experimentation and discovery, today's ought to be a few well thought-through
chisel-strikes to reveal the beautiful sculpture right underneath the rock's
rough exterior. Today, we reveal the vision within as a tactical combination of
3 communication methods in one app:

- Traditional `http` where stuff works like a webserver
- Cool-kid 2-way `websockets` where anything can stream and chats
- Push-only `server side events` (or SSE) for stock-ticker-like stuff

## SSE Revelation a Bittersweet Journey

Pretty much nobody's going to make it to the bottom of yesterday's article, but
there's a pretty big o1-preview provided revelation there. I say revelation, but
honestly I was using SSE (along with ZeroMQ) in my first rough attempt at a
FastHTML web app, but I did everything in the non-FastHTML way. It looks and
works great, but I redid the whole damn thing anyway, mostly to get the good
streaming WebSocket implementation and to use databases their way. However, I
lost the SSE-advantage, and being led back to it now after this long journey is
a bit... a bit... a bit... what's the world I'm looking for Perplexity?

**Perplexity**: The word you might be looking for to describe your feelings about returning to the advantages of Server-Sent Events (SSE) after a long journey could be **"nostalgic."** This term captures a sense of longing or affection for something from the past, especially if it represents a return to a previously appreciated method or technology. 

Alternatively, if you're feeling a mix of frustration and realization about the benefits you overlooked, you might consider **"bittersweet,"** which conveys both positive and negative emotions regarding the experience. 

If neither of these fits, other possibilities might include **"rejuvenated,"** if you're excited about rediscovering SSE, or **"reflective,"** if you're contemplating your journey and the lessons learned along the way.

Yeah, you get me, Perplexity. Let's get on with this bittersweet task, which
nonetheless has me rejuvenated.
