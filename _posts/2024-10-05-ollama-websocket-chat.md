---
title: Ollama Websocket Chat
permalink: /ollama-websocket-chat/
description: 
layout: post
---

Okay, now some of the headiest web programming I've ever done. Now I've done all
sorts of experimential data streaming over the years, back to when you had to
cobble together your own ajax streaming. HitTail from 2006 used the Rico
JavaScript framework. It's no longer supported, because it's no longer needed
due mostly to WebSockets, server-side events (sse) and related push technology,
bringing efficiency to pooling. 

Pooling for those who had to work this way was setting a time-delay for
something to ping out a request for a clockwork response; a busy-loop, in other
words. It is my opinion that even this modern stuff that "keeps a connection
open" is really only still somehow doing repeated requests to keep the conection
ongoing. It's just that the complexity and responsibility for how frequent to
ping and such is shifted elsewhere in such a way that real-time chat and very
responsive user interfaces are possible.

Anyhow, there was tons of alterntives from just yielding from a Python 3.x
function with a yield, for a generator-like next, next, next data-stream of
returned values instead of a single responsse. It's not much talked about as a
streaming technique, but it is still very effective. But more recently, I've
been using ZeroMQ (zmq), which is a no-wait message queuing system built in such
a way that local components can talk to eachother fast, even if they're not in
eachother's scope or memory space. It's so easy to implement, and so reliable.
It's hard to not use now.

But WebSockets have formalized, and all these chatbots are popping up in the
browser, like ChatGPT and every website that's popped up after it to copy. If
chat-enabling WebSockets wasn't formalized and browser mission critical before,
this solidified it. And so, I take the simulated streaming app from the other
day:

```python
from fasthtml.common import *
import asyncio

app, rt = fast_app(ws_hdr=True, live=True)

msgs = []
@rt('/')
def get(): return Titled("Pipulate", 
    Div("foo bar baz", id='msg-list'),
    Form(Input(id='msg', name='msg', placeholder='Type a message...'),  
         Button("Send", type='submit', ws_send=True)),  
    hx_ext='ws',  
    ws_connect='/ws'  
)

users = {}
def on_conn(ws, send): users[str(id(ws))] = send
def on_disconn(ws): users.pop(str(id(ws)), None)

@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    if msg:  
        msgs.append(msg)  
        await long_running_task(msg)  

async def long_running_task(msg: str):
    for i in range(5):
        await asyncio.sleep(1)  
        for u in users.values():
            await u(Div(f"Processing '{msg}'... Step {i + 1}/5", id='msg-list'))
    for u in users.values():
        await u(Div(f"Task complete for message: '{msg}'", id='msg-list'))

serve()
```

And we take today's todo list app...

```python
from fasthtml.common import *

def render(todo):
    tid = f'todo-{todo.id}'
    toggle = A('Toggle', hx_get=f'/toggle/{todo.id}', target_id=tid)
    delete = A('Delete', hx_delete=f'/{todo.id}', 
               hx_swap='outerHTML', target_id=tid)
    return Li(toggle, ' | ', delete, ' ',
              todo.title + (' (Done)' if todo.done else ''),
              id=tid)

app, rt, todos, Todo = fast_app("data/todo.db", live=True, render=render,
                                id=int, title=str, done=bool, pk="id")

def mk_input(): return Input(placeholder='Add a new item', 
                             id='title', hx_swap_oob='true')

@rt('/')
def get():
    frm = Form(Group(mk_input(),
               Button('Add')),
               hx_post='/', target_id='todo-list', hx_swap="beforeend")
    return Titled('Todos', 
                  Card(
                  Ul(*todos(), id='todo-list'),
                  header=frm)
                )

@rt('/')
def post(todo:Todo): return todos.insert(todo), mk_input()

@rt('/{tid}')
def delete(tid:int): todos.delete(tid)

@rt('/toggle/{tid}')
def get(tid:int):
    todo = todos[tid]
    todo.done = not todo.done
    return todos.update(todo)

serve()
```

I can now imagine gluing these together. I can also imagine failing to do so.
The solution? A cautious AI-assisted one. First, let me thing what blending
these two apps would mean. I believe it is that every time you did an action on
the todo list, there would be a corresponding streaming communication in the
background. In essence, every time you interacted with the app, it has a chance
to chat with you. 

Your, the user's, only way to chat back is through the use of the program, which
"it can see". In case you see the impending integration of the local Ollama
server, you would be correct. This is building up to an AI-centric
implementation of a FastHTML app, where the LLM just generally knows what you're
dong with the app all the time, because it's sitting on the HTMX communication.
There's an AI always "in the loop" on the user's interaction with the app.

Okay, so this is all making sense to me in crafting my next step, which is
nothing less than the next layer of opinionated application-building framework.
Ugh! But I don't want to start from FastHTML scratch every time. I'm designing a
sort of Django extra level of opinion, but now with a War Games and Matrix
inspired streaming typing effect. Okay, deep breath...

I already have a server.py and a todo_app.py. And in the wip folder, I also have
ollama_chat.py which may come into play. I will endeavor to give the thing full
context of the Todo app. I will make the prompt something like "You are a Todo
App with attitude..." So I have something to figure out. I need to build up the
question even in my mind. It goes something like this.

The following chat with a local Ollama model can maintain context because it's
using the chat endpoint.

filename: ollama_chat.py

```python
import requests
import json

def chat_with_ollama(model, messages):
    url = "http://localhost:11434/api/chat"
    
    payload = {
        "model": model,
        "messages": messages,
        "stream": False
    }
    
    headers = {
        "Content-Type": "application/json"
    }
    
    response = requests.post(url, data=json.dumps(payload), headers=headers)
    
    if response.status_code == 200:
        return response.json()['message']['content']
    else:
        return f"Error: {response.status_code}, {response.text}"

# Example usage
model = "llama3.2"  # or whatever model you have installed
conversation = [
    {"role": "user", "content": "What is the capital of France?"},
]

while True:
    response = chat_with_ollama(model, conversation)
    print("Assistant:", response)
    
    conversation.append({"role": "assistant", "content": response})
    
    user_input = input("You: ")
    if user_input.lower() in ['quit', 'exit', 'bye']:
        break
    
    conversation.append({"role": "user", "content": user_input})

print("Conversation ended.")
```

A discussion between a user and this bot may look like this, indicating the API
does indeed provide context retention between prompts:

```bash
(nix:nix-shell-env) (nix) [michaellevin@Michaels-MBP:~/repos/pipulate/wip]$ python ollama_chat.py 
Assistant: The capital of France is Paris.
You: Pinky
Assistant: It seems like you were going to say "Pink Panther", but instead, you just typed "Pinky". Is there something specific about Pinky or the Pink Panther that you'd like to talk about?
You: What did I just answer?
Assistant: You didn't give an answer. This conversation started with your question about the capital of France, and then we had a brief detour into a non-sequitur ("Pinky"). Would you like to continue the conversation or start something new?
You: And the Brain
Assistant: Another reference! The Brain is a character from the Pink Panther cartoons, known for being the mastermind behind various plans and schemes. It seems we're on a theme with Pinky and the Brain!
You: Put my first response to you together with my second.
Assistant: Here are your two responses:

1. "What is the capital of France?"
2. "Pinky"

Then, when I responded with a question about what you just said ("And the Brain"), you added "Pinky and the Brain"!
You:
```

So my question to you is if an FastHTML HTMX app that can simulate a
long-running application that takes Web form input and responds using that input
on the output looks like this...

filename: server.py

```python
from fasthtml.common import *
import asyncio

app, rt = fast_app(ws_hdr=True, live=True)

msgs = []
@rt('/')
def get(): return Titled("Pipulate", 
    Div("foo bar baz", id='msg-list'),
    Form(Input(id='msg', name='msg', placeholder='Type a message...'),  # Input for new messages
         Button("Send", type='submit', ws_send=True)),  # Button to send message
    hx_ext='ws',  # Enable HTMX WebSocket extension
    ws_connect='/ws'  # Connect to the WebSocket endpoint
)

users = {}
def on_conn(ws, send): users[str(id(ws))] = send
def on_disconn(ws): users.pop(str(id(ws)), None)

@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    if msg:  # Check if the message is not empty
        msgs.append(msg)  # Append the message to the list
        # Simulate a long-running task
        await long_running_task(msg)  # Call the long-running task

async def long_running_task(msg: str):
    # Simulate a long-running task
    for i in range(5):
        await asyncio.sleep(1)  # Simulate processing time
        # Send progress updates to all users
        for u in users.values():
            await u(Div(f"Processing '{msg}'... Step {i + 1}/5", id='msg-list'))

    # Final update after the task is complete
    for u in users.values():
        await u(Div(f"Task complete for message: '{msg}'", id='msg-list'))

serve()
```

...then, could we combine the two programs so that it takes the form input and
sends it as a chat message to ollama, using the same chat endpoint as in the
example and we maintain context? Is this best achieved with one or two Python
files? `python ollama_chat.py` keeps the terminal occupied until you Ctrl+C, as
does `python server.py`. Can they and should they be combined into a single file
or not. Please identify a good implementation of making server.py chat with
Ollama instead of simulating the long-running app.

---

OMG, Claude 3.5 Sonnet actually did this on the first try...

Claude: Certainly! We can combine the functionality of the FastHTML HTMX app
with the Ollama chat capability into a single file. This approach will allow us
to maintain context in the Ollama chat while providing a web interface for user
interaction. Here's how we can implement this:

```python
from fasthtml.common import *
import asyncio
import requests
import json

app, rt = fast_app(ws_hdr=True, live=True)

# Ollama chat function
def chat_with_ollama(model, messages):
    url = "http://localhost:11434/api/chat"
    payload = {
        "model": model,
        "messages": messages,
        "stream": False
    }
    headers = {"Content-Type": "application/json"}
    response = requests.post(url, data=json.dumps(payload), headers=headers)
    if response.status_code == 200:
        return response.json()['message']['content']
    else:
        return f"Error: {response.status_code}, {response.text}"

# Initialize conversation
model = "llama2"  # or whatever model you have installed
conversation = [
    {"role": "system", "content": "You are a Todo App with attitude. Be sassy but helpful."},
]

@rt('/')
def get(): 
    return Titled("Pipulate Todo App", 
        Div(id='msg-list'),
        Form(Input(id='msg', name='msg', placeholder='Type a message...'),
             Button("Send", type='submit', ws_send=True)),
        hx_ext='ws',
        ws_connect='/ws'
    )

users = {}
def on_conn(ws, send): users[str(id(ws))] = send
def on_disconn(ws): users.pop(str(id(ws)), None)

@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    if msg:
        global conversation
        conversation.append({"role": "user", "content": msg})
        response = chat_with_ollama(model, conversation)
        conversation.append({"role": "assistant", "content": response})
        
        # Send the response to all connected users
        for u in users.values():
            await u(Div(f"You: {msg}", id='msg-list'))
            await u(Div(f"Todo App: {response}", id='msg-list'))

serve()

```

This implementation combines the FastHTML HTMX app with the Ollama chat functionality into a single file. Here's a breakdown of the changes and how it works:

1. We've imported the necessary modules from both original scripts.
2. The Ollama chat function `chat_with_ollama` is included in this file.
3. We initialize the conversation with a system message that sets the tone for our Todo App with attitude.
4. The main route ('/') now creates a simple chat interface.
5. In the WebSocket handler (`ws` function), we:
   - Append the user's message to the conversation.
   - Send the conversation to Ollama and get a response.
   - Append Ollama's response to the conversation.
   - Send both the user's message and Ollama's response back to all connected users.
6. The long-running task simulation has been replaced with the actual Ollama chat interaction.

This implementation allows you to:

- Maintain context between messages (the `conversation` list keeps track of all interactions).
- Provide a web interface for users to interact with the Ollama-powered Todo App.
- Run everything in a single Python file, simplifying deployment and management.

To run this, you would just need to execute `python server.py` (assuming you save this code as `server.py`). Make sure you have Ollama running locally on the default port (11434) and the specified model ("llama2" in this case) installed.

This solution keeps everything in one file, which is simpler for this use case. However, if the application grows more complex, you might want to consider splitting it into multiple files for better organization (e.g., separating Ollama chat functions into a separate module).
