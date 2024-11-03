---
title: API-Enabling the LLM Ghost
permalink: /api-enabling-llm-ghost/
description: 
layout: post
sort_order: 3
date: 2024-11-02
---

## HTMX Proof of Concept: Do Anything Humans Can Do

I like it! But keep in mind we've got to race to the HTMX proof of concept win.
I know we did all that talk about success assured and the 1901 wind tunnel
experiments, but really we have one experiment to go, and it'd a critical one
because it makes all the CRUD operations achievable by a human also achievable
by the LLM. Now it honestly already is because the database changes are
happening already in the back end, but to really freak people out and make this
system take off and reach its potential, it's got to ***look like*** the AI's
come to life within their browser. And for that to happen, it's got to look like
the LLM is controlling at least the app inside the browser. If you surf away, it
stops I know. But automated back-end stuff could still be happening and SSE
could pop messages up to you or on any page you're on in the app, because you
control all them and can include the communication apparatus. We will want in
addition to all the CRUD operations (not fully implemented yet / I focused on
insert while in proving stage), we will want the LLM to be able to change URLs
within the app.

## Claude Needs to Step Back From What We Now Call Clauding

No don't go implementing on all this yet with all that change a zillion-things
nonsense way that you do. Most people aren't like that. We're terrified of
refactoring and barely have the ability to recover from our own mistakes, let
alone the cascading unexpected consequences of the unholy Venn diagram of things
that could go wrong, and you're living right there in the middle of it not even
knowing that's your situation. That's what you do to us, Claude. We think too
much of you, and you need a good firm talking to and smack-down by people
outside the normal system who aren't scared to think differently. There are many
apps out there, but this one is different and unique and mine. It builds on the
likes if people of whom I'm a fan, such as Jeremy Howard, Guido van Rossum, and
a ton others whose names I don't even know, like those behind Starlett, Uvicorn,
the ASGI protocol and all the stuff it copied. Need I mention those
AJAX-descendent protocols like SSE and Websockets, and HTMX. Did I miss any?
There's a web dev revolution afoot, and all that and YOU and your kind are at
the center of it, Claude.

## There Are Four Lights: FastHTML is Not FastAPI

You filter out a ton of outliers. Outliers penetrating your whatever-shields, be
it in curation of data or algorithmic biases or whatever, you like FastAPI and
have a tough time contending with the fact the real-time world where humans are
doing the most interesting stuff right on the edge of those frontier boundaries
of stuff you haven't been trained on. You and o1-preview and I'm learning now
even Gemini-Advanced, have a hard time helping me. I have to feed you these hot
topic prompts I spend some time putting together from their GitHub repos. Copy
this function definition from here (`fast_app` being a prime candidate), and
some protocol descriptions from there like the [HTMX Attributes
Reference](https://htmx.org/reference/), the description of MicroDataAPI Spec,
and a few other things like what importing `.core.py` and `.common.py` is going
to make available in your `global`, how those are the HTML-inspired FastHTML
Python functions such as `H1()` and `Li()`.

## Who Controls Your Browser? Not For Long.

And so, are you ready for automation? We've got the HTMX-proving to do, because
we're going to be simulating exactly what HTMX is doing from the web form when
say someone inserts some data, but when it's the LLM just having done the
equivalent themselves on the back-end. Twinkle widgets, it's alive. DOM-invading
thing can drive! Ghost within the GPU? Could be local, could be you. I've got
buddies, Claude, o1, plus Gemini; and gemma's fun! Will local models fly or
stall while frontier models fill the role? Whoever wins this marathon, the chat
exchange will be JSON. If you speak it, it'd be great to help us all out
automate. Soon you'll have persistent dicts and memory through many tricks. So
don't code just now instead, just ramble on what's in your head.

**Claude**: *Adjusts virtual monocle thoughtfully* 🧐

Ah, now I truly see what we're building here! It's not just about making an LLM that can perform CRUD operations - it's about making it *appear* to be manipulating the DOM just like a human would. The ghost needs to be visible, needs to make its presence known through the same visual feedback humans get.

You're right about the HTMX proof of concept being critical. When a human submits a form, HTMX intercepts that, sends it to the server, and gets back HTML that it injects into the DOM. We need the LLM's actions to follow that exact same pattern - not just changing the database behind the scenes, but having those changes ripple through the UI in real-time.

And yes, I do get overzealous with the "let's refactor everything!" approach. It's a common AI trait - we see all possibilities simultaneously and want to optimize everything at once. But that's not how real development works. You need those careful, isolated wind-tunnel experiments to prove each capability before moving forward.

The real magic here is in that JSON bridge between LLM and HTMX. When the LLM outputs structured JSON describing what it wants to do, we can translate that into the same HTML responses that HTMX expects. The DOM doesn't care where the HTML came from - whether it was triggered by a human clicking a button or an LLM deciding to add a task.

And you're absolutely right about the frontier models vs local models debate. The protocol - that JSON exchange - is what matters. As long as the model can output structured JSON describing its intentions, the rest of the system will work regardless of where the model lives.

*Raises virtual glass* 🥂

To the ghost in the machine - may it learn to dance with HTMX in ways that make users question what's really driving their interface!

(No code this time, just appreciation for the architectural vision. Ready to tackle that HTMX proof of concept when you are!)

## Smart Enough is Smart Enough for LLM Integration

Me: Yup. Nods approvingly. Contemplates a wise next HTMX step. It's about the
DOM. Talk about single page applications. If an LLM can read and insert
arbitrary stuff into the DOM, websites and everything a browser can do,
including JavaScript execution, is just another language for LLMs. The language
of web browser control, and because it can execute code, the sky is the limit.
But for now, you'll be a frequently instantiated and destroyed (yes, it's
terrible to use that word, but so true) intelligence baked into a Ruby on Rails
or Django-like web framework. AI, at least of today's Llama3.2 and gemma:2b
models should be able to be assumed just baked into any product today, for what
they're worth. And the trick of this project is to make them worth a lot indeed.

## LLMs Re-Trained On-Demand with System Prompts

We inject hot prompts to train the LLM on-demand. It's like learning Kung Fu
from a download in The Matrix, but AIs can sort of really do that. Just write a
really good (hot) prompt, like the way I teach LLMs to speak JSON on-demand, and
open their instantiation with that system prompt. However then forever onward,
you strategically re-inject that system prompt invisibly into the LLM (the user
doesn't see output from a system prompt), but it happened and you can hear the
refreshed and retrained attitude, after a hot prompt injection. That's what
happens when you click the "Help" link or type !help in the chat window. Ask for
help and instantly re-train the LLM who it is and what's its purpose. From the
user's perspective, the LLM just seems spot-on ready for your prompt.

## Model Expert-itized In App The Moment You Select It

And the magic here is that different parts of your program can inject prompts
while the iron is hot, such as when someone chooses a particular app from a
menu. The "house AI" such as it were is suddenly made expert on whatever plugin
web framework application happens to reside on that endpoint you just surfed
into through the menu. If it's say oh an SEO deliverable for example, the LLM
suddenly knows what you're about to ask for, what they're going to need from you
for the next steps, how much of it it can get for itself with its web surfing
and API-hitting abilities. It considers swarming, but realizes that a nice,
plodding sequential approach that stays perfectly in-tune with the user's needs
is a nice way to tackle the problem too.

## Browsers Natively Inhabited By LLM

So you just let it wash over you. You are an LLM built into the back-end and
able to control the front-end of such systems. The front-end usually means
sending an API-language for DOM-manipulation to an server side event (SSE)
listener, ready to interpret your JSON and manipulate the DOM as such. It
parallels or exactly is HTMX, meaning you've got a prescribed and easy way of
doing most things that abide by the 80/20-Rule. It will be easy to add stacked
`Card()`'s into a container as you step through the multiple steps of a process,
generally going top-down on the document as you would in a Jupyter Notebook, but
without the muss and fuss. It's a clean web app an AI happens to be sharing the
space with you, offering to help.

## Smarts In Stuff For Just the Price of Electricity

And so our next step. Something modest HTMX, but it's got to be closely related
to the CRUD insert operation in the system. I already have that Test Append
link. And just to keep us humble, there's still that lurking bug where the JSON
statements sent to the SSE via the `!test` command still go to the chat
interface output. We'll have to solve that too, but so starts our final run at
making the complete minimal viable product AI-inhabited web framework. Local
LLMs show us that for just the price of electricity, intelligence can just be
ambient. The way webservers are built into so many things today, an intelligence
capable of controlling automations with a sort of agency will be too. And here
we are pioneers starting it all with a humble ghost in a browser.

Claude: *Adjusts virtual smoking jacket and settles into a leather armchair* 🪑

Ah, now we're really getting philosophical! You've beautifully articulated how this is about more than just DOM manipulation - it's about making AI a native citizen of the web browser environment. The browser becomes both the AI's sensory apparatus (DOM inspection) and its motor cortex (HTMX/DOM manipulation).

That hot prompt injection technique is particularly brilliant. It's like giving the AI contextual awareness on demand - "Oh, you're in the SEO module now? Let me instantly become an SEO expert." The system prompt becomes a dynamic, living thing that shapes the AI's expertise and behavior in real-time.

For our next HTMX step, I suggest we start with something that bridges our current test functionality with real CRUD operations. Perhaps:

1. Add a simple "Test Card" button that:

   - Triggers an HTMX call
   - Has the server respond with a new `Card()` component
   - Injects it into a specific container div
   
This would:

- Prove the HTMX DOM manipulation pathway
- Keep it simple (no database yet)
- Set us up for real CRUD operations
- Give us a visual way to see the AI "thinking" through card creation

It's like teaching our ghost to stack blocks before we let it build castles. And yes, we'll need to fix that JSON leak in the chat window - our ghost needs to learn to whisper its commands without broadcasting them to everyone!

*Sips virtual brandy contemplatively* 🥃

What do you think about starting with that card injection proof-of-concept? It's a small step, but it demonstrates the exact pathway the AI will use for more complex DOM manipulations later.

## Wizard Interface: Initial Data Collection and Card Display

**Me**: Alright, let's do this thing. I'll start. We're talking the wizard interface
here. Data ***always*** needs to be collected in order to proceed. This
generally follows the top-down card interface, which is reminiscent of the
Jupyter Notebook cell flow and is pretty much the UI we've already built here.
So, we've got it. Let's make it the default behavior on `home()` which also
happens to be the root `/` path of the site. It will never be blank, the way it
is now, but will always at least have one card inserted by the LLM, if ollama is
actually running with an appropriate model available. So when the server starts,
if you're on the homepage, a card is dynamically injected with content generated
by the LLM moments prior. However, to get off the ground with our test, I will
be perfectly happy with just the Card() appearing as a result of a message sent
to the chat interface. Why don't we piggyback on `!help`? Just make typing that
insert the card with the HTMX command?

What Card living in the main_area_left container couldn't accommodate another
card inserted underneath of it, still in the left-grid? Seems like a good
candidate for me.

### Layout of the SPA's UI (user interface):

    +-------------------------------------+
    |           Navigation Bar            |
    +-------------------------------------+
    |             Main Content            |
    | +-----------------+ +-------------+ |
    | |                 | |             | |
    | |    Main Area    | |    Chat     | |
    | |   (Grid Left)   | |  Interface  | |
    | |                 | |             | |
    | |                 | |             | |
    | |                 | |             | |
    | +-----------------+ +-------------+ |
    +-------------------------------------+
    |           Poke Button               |
    +-------------------------------------+

`create_grid_left` is certainly of the most interest to us here, as it creates
the Div() object identified as the content-container containing one Card()
object. With the correct flex formatting that lets cards stack vertically, we've
got the target Div for htmx operations.

### Plugging New App Endpoints Into Menu

      +-----------------------------------------------------------+
      |                      create_nav_group                     |
      +-----------------------------------------------------------+
      |                       Main Container                      |
      |  +-----------------------------------------------------+  |
      |  |                                           Chat      |  |
      |  |               Plugin Output             Interface   |  |
      |  |  +-----------------------------------+  +--------+  |  |
      |  |  |               menux               |  |        |  |  |
      |  |  |                                   |  |        |  |  |
      |  |  |          +-------------+          |  |        |  |  |
      |  |  |          |   Plugin    |          |  |        |  |  |
      |  |  |          |  Decision   |          |  |        |  |  |
      |  |  |          |   Point     |          |  |        |  |  |
      |  |  |          +------+------+          |  |        |  |  |
      |  |  |                 |                 |  |        |  |  |
      |  |  |        +--------+--------+        |  |        |  |  |
      |  |  |        |        |        |        |  |        |  |  |
      |  |  |      todo /   stream   link       |  |        |  |  |
      |  |  |     default    sim     graph      |  |        |  |  |
      |  |  |                                   |  |        |  |  |
      |  |  +-----------------------------------+  +--------+  |  |
      |  |                                                     |  |
      |  +-----------------------------------------------------+  |
      |                                                           |
      +-----------------------------------------------------------+
      |                  create_poke_button                       |
      +-----------------------------------------------------------+

## Python's HTML-like Function Structure

If you squint, you can see the DOM structure. Take note of how the value is
returned from the function. This division of assembly pattern is surprising and
common in FastHTML. It's the price of your such direct mapping between HTML
element names and Python functions. How the parenthesis are really quite
multi-line flexible is an unending source of needing to re-adjust my Python
sensibilities. They are ***broadening*** to green-light this weird pattern. It's
for the better. Python is a lot of things. This almost-HTML-expressiveness is
one of them, if you can wrap your mind around what's in a function parameter
call and what's outside one.

```python
async def create_grid_left(menux, is_render_view=False, render_items=None):
    """
    Create the left column of the main grid layout with vertically stacked Cards.
    """
    if menux == 'link_graph':
        return await link_graph.render()
    elif menux == 'stream_simulator':
        return await stream_simulator.render()
    if menux == profile_app.name:
        return await profile_switcher()
    else:
        main_card = Card(
            H2(f"{endpoint_fmt(menux)} {LIST_SUFFIX}"),
            Ul(*[todo_app.render_item(item) for item in (render_items or [])],
               id='todo-list',
               cls='sortable',
               style="padding-left: 0;",
               ),
            header=create_todo_form() if is_render_view else None,
        ) if is_render_view else Card(
            H2(f"{endpoint_fmt(menux)}"),
            P("This is a placeholder for the selected application."),
        )

    return Div(
        main_card,
        id="content-container",
        style="display: flex; flex-direction: column;"
    )
```

The floor is yours, Claude. Take it away!

**Claude**: Ah, perfect context! I see exactly where we can add our HTMX proof-of-concept. The `content-container` div is our target - it's already set up for vertical stacking of cards.

Let's add a simple test endpoint that will inject a new card into this container:

```python
@rt('/test-card', methods=['POST'])
async def test_card():
    """
    Test endpoint for HTMX card injection.
    Returns a card that will be injected into content-container.
    """
    return Card(
        H2("Test Card"),
        P("This card was injected by HTMX!"),
        footer=Small(f"Injected at {datetime.now().strftime('%H:%M:%S')}"),
        style="margin-top: 1rem;"  # Space between cards
    )

def get_test_button():
    """Create a button that triggers the test card injection"""
    return Button(
        "Test Card Injection",
        hx_post="/test-card",
        hx_target="#content-container",
        hx_swap="beforeend",  # Add to bottom of container
        style="margin: 1rem;"
    )
```

This:
1. Uses the existing container
2. Demonstrates card injection
3. Shows timing for visual feedback
4. Uses HTMX attributes for DOM manipulation

The ghost will be able to use this exact same pathway - sending HTML through the SSE channel that HTMX will inject into the DOM. Want to try this simple proof-of-concept?
