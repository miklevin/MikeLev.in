---
title: How I Finally Got My LLM to Play Nice with the Web UI
permalink: /how-i-finally-got-my-llm-to-play-nice-with-the-web-ui/
description: 
layout: post
sort_order: 1
---

## Developers Can Control Browser with LLMs

I open up today's article with an optimistic headline. I recently (like 4:00 AM
this morning) dug my way out of a deep, deep developer rabbit hole. LLMs should
be able to control whatever you want them to be able to control in your web
browser, right? If you invent some **command-and-control language** that they
can ***learn fast*** through prompt-injection, they should be able to look at
the DOM of the page and do stuff to it, like adding new items to a list, right?
Sounds reasonable? I know! To me too. It opens the door to all sorts of
AI-assisted apps whose time has come.

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

Look at this article Perplexity.AI puts together and tight tallying of
citations! You're still my go-to AI for this kind of inquiry, even though
OpenAI's long-awaited GPTSearch finally came out yesterday. Happy Halloween,
everyone! So much to talk about there, how ***small world theory*** is finally
hitting general web-search by which a real-time crawl is sent out at the moment
of user search inquiry in order to... in order to... in order to...

### Real-time Crawling Evaporates Google's Moat

...well quite frankly, evaporate Google's moat (difficult to reproduce
competitive advantage per Warren Buffett). The Internet is a database, and why
keep a ***crawled-and-indexed*** copy of it if people are conditioned to be
patient enough to wait just a little longer to get an accurate answer regarding
the state of the world, that product availability off the embedded schema.org of
the site read in real-time? 

### The Web is The Database&#151;Google's Index Is Not

ChatGPT Search is finally out (and I'm liking the experience), but Perplexity
still has the lead. When I think ***fresh*** model replies, I'm still thinking
Perplexity. OpenAI's measure-twice/cut-once before taking on Google lost them
the early mover advantage in this obvious evolution of the Internet-search
space. Anyhoo, the way the world of search has just been turned upside down is
the subject for another article if at all&#151;go become a Botify customer if
you really want AI SEO consulting on this kind of stuff.


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
nonetheless has me rejuvenated. Let's start off with where I left off yesterday.
It will be a bit of repeated blog posting, but so be it.

# o1-Preview to The Rescue!

> Hey o1, you're finally earning your capital-P! Maybe soon those OpenAI'ers
> will stop using the lowercase form they use in `code` and start giving you a
> **P**roper **N**ame.

**o1**: I'm glad to hear that the proposed SSE solution resonates with you!

Let's focus on achieving a small, success-assured implementation where sending a `!test` command in the chat interface triggers a JavaScript alert in the browser. This will validate the SSE integration and set a solid foundation for further development.

We'll proceed in two phases:

1. **Implement the SSE Endpoint and Client-Side Listener to Trigger a JavaScript Alert on `!test` Command.**

2. **Identify and Remove Dead Code Without Breaking Existing Functionality.**

---

## **Phase 1: Implementing SSE with `!test` Command**

### **Step 1: Set Up the SSE Endpoint**

We'll create an SSE endpoint that clients can connect to. When the server sends an event, the client will receive it and act accordingly.

#### **Modify `botifymograph.py`**

```python:botifymograph.py
# ... [existing imports] ...
from fastapi.responses import EventSourceResponse  # Import the SSE response
from starlette.requests import Request  # For typing

# Keep track of connected clients
connected_clients = set()

# SSE endpoint
@app.get('/events')
async def stream_events(request: Request):
    # Add the client to the connected clients set
    connected_clients.add(request.client)

    async def event_generator():
        try:
            while True:
                # Keep the connection alive by sending a comment every 15 seconds
                await asyncio.sleep(15)
                yield 'event: keep-alive\ndata: keep-alive\n\n'
        except asyncio.CancelledError:
            # Remove the client on disconnect
            connected_clients.discard(request.client)
            raise

    return EventSourceResponse(event_generator())
```

**Explanation:**

- We define an SSE endpoint at `/events`.
- We maintain a `connected_clients` set to keep track of active clients.
- The `event_generator` keeps the connection alive by sending a comment every 15 seconds (this helps prevent timeouts).

### **Step 2: Modify the Chat Handler to Detect `!test` Command**

When a user sends `!test`, we'll trigger an event to all connected SSE clients.

#### **Modify `handle_chat_message` Method**

```python:botifymograph.py
async def handle_chat_message(self, websocket: WebSocket, message: str):
    # ... [existing code] ...

    # Check if the message is the !test command
    if message.strip() == '!test':
        # Send a test event to all connected clients
        event_data = json.dumps({'action': 'test'})
        for client in connected_clients:
            # Ensure the client is still connected
            if not client.is_disconnected:
                # Send the event data
                await self.app.send_sse_event(client, event_data)
        await websocket.send_text("Test event sent.")
        return

    # ... [rest of the existing code] ...
```

**Explanation:**

- We check if the incoming message is `!test`.
- We loop through `connected_clients` and send an event with action `test`.
- We send a confirmation back to the WebSocket client.

**Helper Function to Send SSE Events:**

Add a helper method to your app to send SSE events:

```python:botifymograph.py
class YourAppClass(FastAPI):
    # ... [existing code] ...

    async def send_sse_event(self, client, data: str):
        # Send an SSE event to the specified client
        message = f'data: {data}\n\n'
        await client.send(message.encode('utf-8'))
```

### **Step 3: Update the Client-Side JavaScript to Listen for SSE Events**

In your HTML template or JS file, connect to the SSE endpoint and handle incoming events.

#### **Modify the Client-Side Code**

```html
<script>
  // Connect to the SSE endpoint
  const eventSource = new EventSource('/events');

  eventSource.onmessage = function(event) {
    const data = JSON.parse(event.data);
    if (data.action === 'test') {
      // Trigger a JavaScript alert
      alert('Test event received from server!');
    }
  };

  eventSource.onerror = function(err) {
    console.error('EventSource failed:', err);
  };
</script>
```

**Explanation:**

- We establish an SSE connection to `/events`.
- When a message is received, we parse the JSON data.
- If `data.action` is `test`, we display a JavaScript alert.

### **Step 4: Test the Implementation**

- Run your application.
- Open the client in a browser and ensure the SSE connection is established (you can check the network tab in developer tools).
- Send `!test` via the chat interface.
- Verify that a JavaScript alert pops up with the message "Test event received from server!".

---

## **Phase 2: Cleaning Up the Code**

To address your second concern, let's focus on identifying and removing dead code introduced in previous implementation attempts, ensuring we don't break existing functionality.

### **Approach**

1. **Identify Unused Functions and Variables:**

   - Look for functions, imports, and variables that are no longer used.
   - Remove any code related to prior attempts at updating the DOM via the chat stream.

2. **Review Chat Handling Logic:**

   - Ensure that the `handle_chat_message` method only handles chat-related functionality.
   - Remove any code that was parsing assistant responses for DOM updates.

3. **Simplify the Assistant Response Processing:**

   - If there are complex parsing routines for assistant responses that are no longer necessary, consider simplifying or removing them.

4. **Ensure Correct Separation of Concerns:**

   - The chat interface should only handle user messages and assistant responses.
   - DOM updates should be handled separately via SSE or appropriate mechanisms.

### **Examples**

#### **1. Remove Assistant JSON Parsing Logic from Chat Handler**

If you have code that attempts to extract JSON code blocks from the assistant's response to update the DOM via the chat, you can remove it.

**Before:**

```python
# Inside handle_chat_message
# ... [existing code] ...

# Attempt to extract JSON code block from assistant's response
json_match = re.search(r'```json\s*(\{.*?\})\s*```', assistant_response, re.DOTALL)
if json_match:
    # Parse and handle JSON
    operation_json = json.loads(json_match.group(1))
    # [Code to update DOM via chat stream]
else:
    # [Handle assistant response normally]
```

**After:**

```python
# Inside handle_chat_message
# ... [existing code] ...

# Send the assistant's response back to the client
await websocket.send_text(assistant_response)
```

**Explanation:**

- Remove the regex search and JSON parsing since we're no longer using the chat stream to update the DOM.
- Simplify the handler to focus only on chat communication.

#### **2. Clean Up Imports**

Remove any imports that are no longer used after cleaning up the code.

**Example:**

```python:botifymograph.py
import re  # Remove if no longer using regular expressions
```

#### **3. Remove Unused Variables and Functions**

Search for functions or variables that were only used in the previous attempts and are not referenced elsewhere.

**Example:**

- Functions like `execute_crud_operation` if it's no longer used in the chat handler.
- Variables or flags used to control DOM updates via the chat stream.

**Ensure that any removal is followed by testing to confirm that the application still works as expected.**

---

### **Final Words on Code Cleanup**

- **Version Control:** Before making significant changes, ensure you have a backup or can revert changes if needed.
- **Incremental Changes:** Remove code in small increments, testing the application after each change to ensure nothing breaks.
- **Document Changes:** Comment on why certain pieces of code are being removed for future reference.

---

## **Summary**

By implementing SSE in a simple test case, you can validate the concept and build upon it confidently. This approach allows you to:

- **Verify SSE Integration:** Ensures that the server can send events and the client can receive and act upon them.
- **Establish a Foundation:** Provides a working example upon which you can expand to handle CRUD operations.
- **Maintain Clean Code:** Encourages separation of concerns and keeps your codebase maintainable.

---

## AI'S Promise Vs Reality Of Implementation

So it seems like the job is done, right? There are all of o1's recommendations
laid out clear as day, and it seems pretty damn super-intelligent, doesn't it?
At least that promised PhD-level. Queue up ***Never Gonna Give You Up*** 'cause
chances are we're being ***rickrolled***. So, eff-you every code-assisting AI
out there who wants to flex your muscle by demonstrating how deep into Dante's
circles you can drive us. I'm reminding myself of my daily mantras before this
potentially maddening descent of implementation.

## Building Resilience in a Triggered World

It starts as most things do, with ***breathing exercises***. Some things don't
trigger you (us). ***All things trigger us.*** We are ***always*** being
triggered. Only really fast (automatic due to habits) self-regulation kicking-in
keeps us from spiraling. Sorry folks, that's just our normal state. Settling
into the groove where always wobbling on the verge of is collapse is merely
called walking. Don't lose your ability to walk just because there's AI's and
other entities all around you throwing stones trying to unbalance
you&#151;usually because it makes them money somehow. Here's my resilience
trick. Ask yourself every day...

<div class="wisdom">
<pre>
        1. What's most broken?
2. Where's the biggest bang for buck?
    3. Which plates must be spun?
</pre>
</div>

And the scary truth is that you yourself may be what's most broken. However, the
saving grace is that the biggest bang for the buck is banking one small win to
reset your path-finding ability.

That's what I'm doing here. If you ended up on this article, you're experiencing
me in the thick of a path-finding reset. I'm letting go of being enamored by
***websockets*** and opening my mind up again to ***server side events***. This
may sound excessively nerd, but... but... ah hell, no Perplexity this time. If
you get it, you get it. Just a little more distraction and evasion of really
starting the work before I dive in. After those daily path-finding metaphors,
there is ***the how***&#151;or ***The Way***, if you will. And that goes
something like this...

<div class="wisdom">
<pre>
   Ikigai - overcome laziness find the love
  Kaizen - do one thing well keep polishing
Pomodoro - take chisel-strike bank small wins
  Hara Hachi Bu - don't burn out / eat less
     Wabi-Sabi - 80/20-rule imperfection
         Shoshin - Be like a beginner
</pre>
</div>

## Safety Equipment for Rabbit Hole Exploration

The wording isn't perfectly smooth, but it centers nice, right? I could walk you
through all this, but in short it comes down to rappelling down the rabbit hole.
Okay, I'll throw this one Perplexity's way. Hey Perplexity, why do the above
abstract notions lead us to the also abstract but also weirdly practical advice
of when facing a rabbit hole of unknown depth which you feel you must explore,
why attaching safety equipment and rappelling down the rabbit hole is good
advice. Try to work one thing from each of the principles stated above in the
answer. I'm about to get coding and could use the clarity and the reminder,
please and thank you!

**Perplexity**: The connection between these abstract concepts and the practical advice of rappelling down a rabbit hole of unknown depth is indeed intriguing. Let's explore how each principle contributes to this approach:

## Embracing the Journey

**Ikigai** teaches us to find our purpose and overcome laziness. When facing a deep rabbit hole, attaching safety equipment and rappelling down represents our commitment to exploring our passion, even when it seems daunting. This approach allows us to overcome the initial inertia and laziness that might hold us back from diving into complex problems.

**Kaizen** encourages us to focus on continuous improvement. As we descend the rabbit hole, we can apply this principle by concentrating on mastering one aspect at a time. Each step down is an opportunity to polish our skills and understanding, gradually building expertise in the subject matter we're exploring.

## Managing the Descent

The **Pomodoro Technique** reminds us to work in focused bursts. When rappelling down the rabbit hole, we can view each "chisel-strike" as a Pomodoro session – a concentrated effort to make progress. This approach helps us maintain focus and energy, preventing burnout as we delve deeper into complex topics.

**Hara Hachi Bu** teaches moderation and not overdoing things. In the context of exploration, this principle reminds us to pace ourselves. We don't need to reach the bottom of the rabbit hole in one go. Taking breaks, reflecting on what we've learned, and "eating less" information at a time can help us avoid mental indigestion and burnout.

## Embracing Imperfection and Openness

**Wabi-Sabi** celebrates imperfection and incompleteness. As we rappel down the rabbit hole, we should remember that we don't need to understand everything perfectly. The 80/20 rule suggests that we can gain significant insights with partial knowledge. This mindset helps us move forward without getting stuck on achieving perfection.

**Shoshin**, or beginner's mind, encourages us to approach each new level of the rabbit hole with fresh eyes and openness. As we descend, maintaining a beginner's mindset allows us to question assumptions, learn new perspectives, and adapt our understanding as we go deeper.

## The Wisdom of Rappelling

Rappelling down a rabbit hole with safety equipment is a metaphor for approaching complex problems or deep dives into unknown territories with both courage and caution. It embodies the balance between the adventurous spirit of exploration and the pragmatic approach of risk management.

By combining these principles, we create a powerful framework for tackling challenging intellectual or creative pursuits:

1. We find the motivation to start (**Ikigai**)
2. We commit to continuous improvement (**Kaizen**)
3. We work in focused, manageable chunks (**Pomodoro**)
4. We pace ourselves to avoid burnout (**Hara Hachi Bu**)
5. We accept imperfection and focus on significant gains (**Wabi-Sabi**)
6. We maintain an open, curious mindset throughout the journey (**Shoshin**)

This approach allows us to explore depths of knowledge or creativity that might otherwise seem overwhelming, all while maintaining our safety, sanity, and enthusiasm for the journey.

