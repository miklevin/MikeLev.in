---
title: Ollama Websocket Chat
permalink: /futureproof/ollama-websocket-chat/
description: I detail my journey of building a reproducible development environment using Nix flakes, focusing on creating a "home" script to streamline setup across platforms. I discuss the challenges of managing dependencies and ensuring consistency across different operating systems, and I highlight the benefits of Nix's declarative approach and immutable store. I also share my experiences with web development frameworks and the importance of choosing the right tools for building modern web applications.
layout: post
---

## A Look Back At My Web Development Experimentation History

Okay, now some of the headiest web programming I've ever done. Now I've done all
sorts of experimential data streaming over the years, back to when you had to
cobble together your own ajax streaming. HitTail from 2006 used the Rico
JavaScript framework. It's no longer supported, because it's no longer needed
due mostly to WebSockets, server-side events (sse) and related push technology,
bringing efficiency to pooling. 

## The Futility of Continuous Connection Maintenance Efforts

Pooling for those who had to work this way was setting a time-delay for
something to ping out a request for a clockwork response; a busy-loop, in other
words. It is my opinion that even this modern stuff that "keeps a connection
open" is really only still somehow doing repeated requests to keep the conection
ongoing. It's just that the complexity and responsibility for how frequent to
ping and such is shifted elsewhere in such a way that real-time chat and very
responsive user interfaces are possible.

## Using ZeroMQ for Efficient Data Streaming in Python Applications

Anyhow, there was tons of alterntives from just yielding from a Python 3.x
function with a yield, for a generator-like next, next, next data-stream of
returned values instead of a single responsse. It's not much talked about as a
streaming technique, but it is still very effective. But more recently, I've
been using ZeroMQ (zmq), which is a no-wait message queuing system built in such
a way that local components can talk to eachother fast, even if they're not in
eachother's scope or memory space. It's so easy to implement, and so reliable.
It's hard to not use now.

## Chatbots Are Overwhelming Browsers With WebSocket Capabilities

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

## Using AI to Create Seamless Todo List Interactions

I can now imagine gluing these together. I can also imagine failing to do so.
The solution? A cautious AI-assisted one. First, let me thing what blending
these two apps would mean. I believe it is that every time you did an action on
the todo list, there would be a corresponding streaming communication in the
background. In essence, every time you interacted with the app, it has a chance
to chat with you. 

## The Rise Of AI-Powered Chat Integration In FastHTML Apps

Your, the user's, only way to chat back is through the use of the program, which
"it can see". In case you see the impending integration of the local Ollama
server, you would be correct. This is building up to an AI-centric
implementation of a FastHTML app, where the LLM just generally knows what you're
dong with the app all the time, because it's sitting on the HTMX communication.
There's an AI always "in the loop" on the user's interaction with the app.

## Creating Next Layer Of Opinionated Framework For Streamlined Development

Okay, so this is all making sense to me in crafting my next step, which is
nothing less than the next layer of opinionated application-building framework.
Ugh! But I don't want to start from FastHTML scratch every time. I'm designing a
sort of Django extra level of opinion, but now with a War Games and Matrix
inspired streaming typing effect. Okay, deep breath...

## Building a Chatty Todo App with Personality and Flair

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

## FastHTML HTMX App Simulates Long-Running Application Effectiveness

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

## Combining Python Programs for Ollama Chat Functionality

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

---

And it worked on the first try! Amazing! However, I see there's no streaming
effect.

I'll spare you all the details of the back and forth with Claude 3.5 Sonnet
through Cursor AI that led me to sorting it all out. But I made sure that the
chunk-by-chunk streaming effect was visible.

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
model = "llama3.2"  # or whatever model you have installed
conversation = [
    {"role": "system", "content": "You are a Todo App with attitude. Be sassy but helpful."},
]

def mk_input():
    return Input(id='msg', name='msg', placeholder='Type a message...', autofocus='autofocus')

@rt('/')
def get(): 
    return Titled("Pipulate Todo App", 
        Div(id='msg-list'),
        Form(mk_input(),
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
        
        # Send user message immediately
        for u in users.values():
            await u(Div(f"You: {msg}", id='msg-list'))
        
        # Start streaming response
        response = chat_with_ollama(model, conversation)
        conversation.append({"role": "assistant", "content": response})
        # Simulate typing effect
        words = response.split()
        for i in range(len(words)):
            partial_response = " ".join(words[:i+1])
            for u in users.values():
                {% raw %}await u(Div(f"Todo App: {partial_response}", id='msg-list', _=f"this.scrollIntoView(\{\{behavior: 'smooth'\}\});"))
            await asyncio.sleep(0.1)  # Adjust delay as needed
        # Clear the input field after the response is complete and keep it focused
        clear_input = Input(id='msg', name='msg', placeholder='Type a message...', value='', 
                            hx_swap_oob="true", autofocus='autofocus')
        for u in users.values():
            await u(clear_input)

serve()
```

This is after lots and lots of experimenting, I have side-by-side todo and chat
app wehre the chat app is aware of everything you do in the todo app, and
comments on it...

```python
from fasthtml.common import *
import asyncio
import requests
import json
from check_environment import get_best_model
from todo_app import render, todos, Todo, mk_input as todo_mk_input
from starlette.concurrency import run_in_threadpool

app, rt, todos, Todo = fast_app("data/todo.db", ws_hdr=True, live=True, render=render,
                                id=int, title=str, done=bool, pk="id")

# Choose the best available model
model = get_best_model()

# Define the MATRIX_STYLE constant
MATRIX_STYLE = "color: #00ff00; text-shadow: 0 0 5px #00ff00; font-family: 'Courier New', monospace;"

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
conversation = [
    {"role": "system", "content": "You are a Todo App with attitude. Be sassy but helpful."},
]

def mk_input():
    return Input(id='msg', name='msg', placeholder='Type a message...', autofocus='autofocus')

@rt('/')
def get(): 
    todo_form = Form(Group(todo_mk_input(),
                    Button('Add')),
                    hx_post='/todo', target_id='todo-list', hx_swap="beforeend")
    return Titled("Pipulate Todo App", 
        Container(
            Grid(
                Card(
                    H2("Todo List"),
                    Ul(*todos(), id='todo-list'),
                    header=todo_form
                ),
                Card(
                    H2("Chat Interface"),
                    Div(id='msg-list', cls='overflow-auto', style='height: 60vh;'),
                    footer=Form(
                        Group(
                            mk_input(),
                            Button("Send", type='submit', ws_send=True)
                        )
                    )
                ),
                cls="grid"
            )
        ),
        hx_ext='ws',
        ws_connect='/ws',
        data_theme="dark"
    )

@rt('/todo')
async def post(todo:Todo):
    inserted_todo = todos.insert(todo)
    
    # Start the AI response in the background
    asyncio.create_task(generate_and_stream_ai_response(
        f"A new todo item was added: '{todo.title}'. Give a brief, sassy comment or advice in 40 words or less."
    ))
    
    # Return the inserted todo item immediately
    return inserted_todo, todo_mk_input()

async def generate_and_stream_ai_response(prompt):
    conversation.append({"role": "user", "content": prompt})
    response = await run_in_threadpool(chat_with_ollama, model, conversation)
    conversation.append({"role": "assistant", "content": response})
    
    # Simulate faster typing effect
    words = response.split()
    for i in range(len(words)):
        partial_response = " ".join(words[:i+1])
        for u in users.values():
            await u(Div(f"Todo App: {partial_response}", id='msg-list', cls='fade-in',
                        style=MATRIX_STYLE,
                        {% raw %}_=f"this.scrollIntoView({{behavior: 'smooth'}});")){% endraw %}
        await asyncio.sleep(0.05)  # Reduced delay for faster typing

@rt('/{tid}')
async def delete(tid:int):
    todo = todos[tid]  # Get the todo item before deleting it
    todos.delete(tid)
    
    # Start the AI response for deletion in the background
    asyncio.create_task(generate_and_stream_ai_response(
        f"The todo item '{todo.title}' was just deleted. Give a brief, sassy comment or reaction in 40 words or less."
    ))
    
    return ''  # Return an empty string to remove the item from the DOM

@rt('/toggle/{tid}')
async def get(tid:int):
    todo = todos[tid]
    old_status = "Done" if todo.done else "Not Done"
    todo.done = not todo.done
    new_status = "Done" if todo.done else "Not Done"
    updated_todo = todos.update(todo)
    
    # Start the AI response for toggle in the background
    asyncio.create_task(generate_and_stream_ai_response(
        f"The todo item '{todo.title}' was just toggled from {old_status} to {new_status}. Give a brief, sassy comment or reaction in 40 words or less."
    ))
    
    return updated_todo

users = {}
def on_conn(ws, send): users[str(id(ws))] = send
def on_disconn(ws): users.pop(str(id(ws)), None)

@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    if msg:
        global conversation
        conversation.append({"role": "user", "content": msg})
        
        # Send user message immediately
        for u in users.values():
            await u(Div(f"You: {msg}", id='msg-list', cls='fade-in', style=MATRIX_STYLE))
        
        # Start streaming response
        response = chat_with_ollama(model, conversation)
        conversation.append({"role": "assistant", "content": response})
        
        # Simulate typing effect
        words = response.split()
        for i in range(len(words)):
            partial_response = " ".join(words[:i+1])
            for u in users.values():
                await u(Div(f"Todo App: {partial_response}", id='msg-list', cls='fade-in',
                            style=MATRIX_STYLE,
                            {% raw %}_=f"this.scrollIntoView({{behavior: 'smooth'}});")){% endraw %}
            await asyncio.sleep(0.1)  # Adjust delay as needed
        
        # Clear the input field after the response is complete and keep it focused
        clear_input = Input(id='msg', name='msg', placeholder='Type a message...', value='', 
                            hx_swap_oob="true", autofocus='autofocus')
        for u in users.values():
            await u(clear_input)

serve()
```

...but it does require the following external local package to check for the
latest local llama...

```python
from fasthtml.common import *
import asyncio
import requests
import json
from check_environment import get_best_model
from todo_app import render, todos, Todo, mk_input as todo_mk_input
from starlette.concurrency import run_in_threadpool

app, rt, todos, Todo = fast_app("data/todo.db", ws_hdr=True, live=True, render=render,
                                id=int, title=str, done=bool, pk="id")

# Choose the best available model
model = get_best_model()

# Define the MATRIX_STYLE constant
MATRIX_STYLE = "color: #00ff00; text-shadow: 0 0 5px #00ff00; font-family: 'Courier New', monospace;"

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
conversation = [
    {"role": "system", "content": "You are a Todo App with attitude. Be sassy but helpful."},
]

def mk_input():
    return Input(id='msg', name='msg', placeholder='Type a message...', autofocus='autofocus')

@rt('/')
def get(): 
    todo_form = Form(Group(todo_mk_input(),
                    Button('Add')),
                    hx_post='/todo', target_id='todo-list', hx_swap="beforeend")
    return Titled("Pipulate Todo App", 
        Container(
            Grid(
                Card(
                    H2("Todo List"),
                    Ul(*todos(), id='todo-list'),
                    header=todo_form
                ),
                Card(
                    H2("Chat Interface"),
                    Div(id='msg-list', cls='overflow-auto', style='height: 60vh;'),
                    footer=Form(
                        Group(
                            mk_input(),
                            Button("Send", type='submit', ws_send=True)
                        )
                    )
                ),
                cls="grid"
            )
        ),
        hx_ext='ws',
        ws_connect='/ws',
        data_theme="dark"
    )

@rt('/todo')
async def post(todo:Todo):
    inserted_todo = todos.insert(todo)
    
    # Start the AI response in the background
    asyncio.create_task(generate_and_stream_ai_response(
        f"A new todo item was added: '{todo.title}'. Give a brief, sassy comment or advice in 40 words or less."
    ))
    
    # Return the inserted todo item immediately
    return inserted_todo, todo_mk_input()

async def generate_and_stream_ai_response(prompt):
    conversation.append({"role": "user", "content": prompt})
    response = await run_in_threadpool(chat_with_ollama, model, conversation)
    conversation.append({"role": "assistant", "content": response})
    
    # Simulate faster typing effect
    words = response.split()
    for i in range(len(words)):
        partial_response = " ".join(words[:i+1])
        for u in users.values():
            await u(Div(f"Todo App: {partial_response}", id='msg-list', cls='fade-in',
                        style=MATRIX_STYLE,
                        {% raw %}_=f"this.scrollIntoView({{behavior: 'smooth'}});")){% endraw %}
        await asyncio.sleep(0.05)  # Reduced delay for faster typing

@rt('/{tid}')
async def delete(tid:int):
    todo = todos[tid]  # Get the todo item before deleting it
    todos.delete(tid)
    
    # Start the AI response for deletion in the background
    asyncio.create_task(generate_and_stream_ai_response(
        f"The todo item '{todo.title}' was just deleted. Give a brief, sassy comment or reaction in 40 words or less."
    ))
    
    return ''  # Return an empty string to remove the item from the DOM

@rt('/toggle/{tid}')
async def get(tid:int):
    todo = todos[tid]
    old_status = "Done" if todo.done else "Not Done"
    todo.done = not todo.done
    new_status = "Done" if todo.done else "Not Done"
    updated_todo = todos.update(todo)
    
    # Start the AI response for toggle in the background
    asyncio.create_task(generate_and_stream_ai_response(
        f"The todo item '{todo.title}' was just toggled from {old_status} to {new_status}. Give a brief, sassy comment or reaction in 40 words or less."
    ))
    
    return updated_todo

users = {}
def on_conn(ws, send): users[str(id(ws))] = send
def on_disconn(ws): users.pop(str(id(ws)), None)

@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    if msg:
        global conversation
        conversation.append({"role": "user", "content": msg})
        
        # Send user message immediately
        for u in users.values():
            await u(Div(f"You: {msg}", id='msg-list', cls='fade-in', style=MATRIX_STYLE))
        
        # Start streaming response
        response = chat_with_ollama(model, conversation)
        conversation.append({"role": "assistant", "content": response})
        
        # Simulate typing effect
        words = response.split()
        for i in range(len(words)):
            partial_response = " ".join(words[:i+1])
            for u in users.values():
                await u(Div(f"Todo App: {partial_response}", id='msg-list', cls='fade-in',
                            style=MATRIX_STYLE,
                            {% raw %}_=f"this.scrollIntoView({{behavior: 'smooth'}});")){% endraw %}
            await asyncio.sleep(0.1)  # Adjust delay as needed
        
        # Clear the input field after the response is complete and keep it focused
        clear_input = Input(id='msg', name='msg', placeholder='Type a message...', value='', 
                            hx_swap_oob="true", autofocus='autofocus')
        for u in users.values():
            await u(clear_input)

serve()
```

Me: Break down for me the system by which any htmx call here can also have an accompanying commentary by the LLM.

Claude: I'd be happy to break down the system for you. This code implements a Todo app with an integrated chat interface that provides commentary using an LLM (Language Learning Model) for various actions. Here's how the HTMX calls are linked with LLM commentary:






# HTMX and LLM Integration in Todo App

1. **LLM Setup**:
   - The app uses Ollama, a local LLM service, accessed via `chat_with_ollama` function.
   - A conversation history is maintained to provide context for the LLM.

2. **HTMX Endpoints**:
   - `/todo` (POST): Add a new todo item
   - `/{tid}` (DELETE): Delete a todo item
   - `/toggle/{tid}` (GET): Toggle todo item status

3. **WebSocket Integration**:
   - A WebSocket connection (`/ws`) is used for real-time communication.
   - Users can send messages directly through the chat interface.

4. **LLM Commentary Process**:
   - When an HTMX call is made to modify the todo list, it triggers an asynchronous task to generate LLM commentary.
   - This is done using `asyncio.create_task(generate_and_stream_ai_response(...))`.

5. **Asynchronous Response Generation**:
   - The `generate_and_stream_ai_response` function:
     a. Adds the event to the conversation history
     b. Requests a response from the LLM
     c. Streams the response word by word to simulate typing

6. **Real-time Updates**:
   - Responses are sent to all connected users using WebSockets.
   - The UI is updated in real-time, with a typing effect for the LLM's responses.

7. **Specific HTMX-LLM Interactions**:
   - Adding a todo: Triggers commentary on the new item
   - Deleting a todo: Prompts a reaction to the deletion
   - Toggling a todo: Generates a comment on the status change

8. **UI Integration**:
   - The todo list and chat interface are displayed side by side.
   - LLM responses appear in a Matrix-like style (green text with glow effect).

This system ensures that every significant action in the todo app is accompanied by a contextual, "sassy" comment from the LLM, enhancing user engagement and providing a unique, interactive experience.


This system cleverly integrates HTMX for handling UI updates with an LLM for providing dynamic commentary. The key to this integration is the use of asynchronous tasks that are triggered by HTMX calls, allowing the app to respond quickly to user actions while generating LLM commentary in the background.

Would you like me to elaborate on any specific part of this system?

---

And now with checkboxes!

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


Me: Break down for me the system by which any htmx call here can also have an accompanying commentary by the LLM.


Claude: I'd be happy to break down the system for you. This code implements a Todo app with an integrated chat interface that provides commentary using an LLM (Language Learning Model) for various actions. Here's how the HTMX calls are linked with LLM commentary:

# HTMX and LLM Integration in Todo App

1. **LLM Setup**:
   - The app uses Ollama, a local LLM service, accessed via `chat_with_ollama` function.
   - A conversation history is maintained to provide context for the LLM.

2. **HTMX Endpoints**:
   - `/todo` (POST): Add a new todo item
   - `/{tid}` (DELETE): Delete a todo item
   - `/toggle/{tid}` (GET): Toggle todo item status

3. **WebSocket Integration**:
   - A WebSocket connection (`/ws`) is used for real-time communication.
   - Users can send messages directly through the chat interface.

4. **LLM Commentary Process**:
   - When an HTMX call is made to modify the todo list, it triggers an asynchronous task to generate LLM commentary.
   - This is done using `asyncio.create_task(generate_and_stream_ai_response(...))`.

5. **Asynchronous Response Generation**:
   - The `generate_and_stream_ai_response` function:
     a. Adds the event to the conversation history
     b. Requests a response from the LLM
     c. Streams the response word by word to simulate typing

6. **Real-time Updates**:
   - Responses are sent to all connected users using WebSockets.
   - The UI is updated in real-time, with a typing effect for the LLM's responses.

7. **Specific HTMX-LLM Interactions**:
   - Adding a todo: Triggers commentary on the new item
   - Deleting a todo: Prompts a reaction to the deletion
   - Toggling a todo: Generates a comment on the status change

8. **UI Integration**:
   - The todo list and chat interface are displayed side by side.
   - LLM responses appear in a Matrix-like style (green text with glow effect).

This system ensures that every significant action in the todo app is accompanied by a contextual, "sassy" comment from the LLM, enhancing user engagement and providing a unique, interactive experience.


This system cleverly integrates HTMX for handling UI updates with an LLM for providing dynamic commentary. The key to this integration is the use of asynchronous tasks that are triggered by HTMX calls, allowing the app to respond quickly to user actions while generating LLM commentary in the background.

Would you like me to elaborate on any specific part of this system?

---

Me: Show me how to make htis ability to send messages to the chat box the
cleanest API you ever did see. Make chatbox callback functions aware of events
during long-running callback processes the cheanest and happiest API you ever
did see. What should we call it for humans (like Requests)? Show me how we'd
clean it up.

Claude: Certainly! Let's create a clean and elegant API for handling chat
messages and long-running processes. We'll call this new API "Chatter" for its
simplicity and ease of use. Here's how we can refactor the code to make it
cleaner:

```python
async def generate_and_stream_ai_response(prompt):
    conversation.append({"role": "user", "content": prompt})
    
    async def send(content: str):
        for u in users.values():
            await u(Div(content, id='msg-list', cls='fade-in', style=MATRIX_STYLE))
    
    async def update(content: str):
        for u in users.values():
            await u(Div(content, id='msg-list', cls='fade-in', style=MATRIX_STYLE,
                        {% raw %}_=f"this.scrollIntoView({{behavior: 'smooth'}});")){% endraw %}
    
    async def finish():
        pass  # No need to clear input or refocus in this case
    
    chatter = Chatter(send, update, finish)
    await chat_handler(chatter, prompt)

# Update the post, delete, and toggle routes to use the new API
@rt('/todo')
async def post(todo:Todo):
    inserted_todo = todos.insert(todo)
    asyncio.create_task(generate_and_stream_ai_response(
        f"A new todo item was added: '{todo.title}'. Give a brief, sassy comment or advice in 40 words or less."
    ))
    return render(inserted_todo), todo_mk_input()

# Similarly update the delete and toggle routes...
```

This new "Chatter" API provides a clean and flexible way to handle chat
interactions and long-running processes. It separates the concerns of message
handling, updating, and finishing, making the code more modular and easier to
maintain. The API is also more intuitive for humans to use, similar to how the
Requests library simplified HTTP requests in Python.

You're correct that the send, update, and finish callables are very similar in this implementation. They all involve sending content to the user's WebSocket connection. However, their purposes are slightly different:

1. send: Used to send the initial message or response.
2. update: Used to update the message incrementally (like streaming the AI response word by word).
3. finish: Used to perform any cleanup or final actions after the message is complete.

The Chatter design is indeed similar to opening and closing a connection, with the ability to update in between. It's a flexible pattern that allows for different behaviors at different stages of the chat interaction.
For your example of appending dots to an object's text node, you could use Chatter like this:

```python
async def long_running_task(chatter: Chatter):
    await chatter.send("Processing")
    for _ in range(10):
        await asyncio.sleep(1)
        await chatter.update("Processing" + "." * (_ + 1))
    await chatter.finish()

# In your WebSocket route or elsewhere
chatter = Chatter(send, update, finish)
await long_running_task(chatter)
```

You're right, and I'm glad it's working! Let's examine how Chatter is used in the program and discuss its design.

Chatter is primarily used in the WebSocket route:

```python
@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    if msg:
        global conversation
        conversation.append({"role": "user", "content": msg})
        
        user_id = str(id(ws))
        async def send(content: str):
            await users[user_id](Div(content, id='msg-list', cls='fade-in', style=MATRIX_STYLE))
        
        async def update(content: str):
            await users[user_id](Div(content, id='msg-list', cls='fade-in', style=MATRIX_STYLE,
                                    {% raw %}_=f"this.scrollIntoView({{behavior: 'smooth'}});")){% endraw %}
        
        async def finish():
            clear_input = Input(id='msg', name='msg', placeholder='Type a message...', value='', 
                                hx_swap_oob="true", autofocus='autofocus')
            await users[user_id](clear_input)
        
        chatter = Chatter(send, update, finish)
        await chat_handler(chatter, msg)
```

You're correct that the `send`, `update`, and `finish` callables are very similar in this implementation. They all involve sending content to the user's WebSocket connection. However, their purposes are slightly different:

1. `send`: Used to send the initial message or response.
2. `update`: Used to update the message incrementally (like streaming the AI response word by word).
3. `finish`: Used to perform any cleanup or final actions after the message is complete.

The Chatter design is indeed similar to opening and closing a connection, with the ability to update in between. It's a flexible pattern that allows for different behaviors at different stages of the chat interaction.

For your example of appending dots to an object's text node, you could use Chatter like this:

```python
async def long_running_task(chatter: Chatter):
    await chatter.send("Processing")
    for _ in range(10):
        await asyncio.sleep(1)
        await chatter.update("Processing" + "." * (_ + 1))
    await chatter.finish()

# In your WebSocket route or elsewhere
chatter = Chatter(send, update, finish)
await long_running_task(chatter)
```

This design allows for a clean separation of concerns:

1. The `chat_handler` or `long_running_task` doesn't need to know how the messages are sent or updated.
2. The WebSocket route doesn't need to know the details of how the chat or task is processed.
3. You can easily swap out the implementation of `send`, `update`, and `finish` without changing the `chat_handler` or `long_running_task`.

While in this specific use case the functions are similar, the Chatter pattern provides flexibility for more complex scenarios where you might want different behaviors for initial send, updates, and finishing touches.

Me: Can a send work without an update and a finish? What's the minimal use-case, for eaxample a rapid default message that's just supposed to show as fast as possible at the end of an object click.

Absolutely! The Chatter API is flexible, and you can certainly use just the send function without update or finish for simpler use cases. Here's an example of how you could implement a minimal use-case for a rapid default message:

```python
from dataclasses import dataclass
from typing import Callable, Awaitable

@dataclass
class SimpleChatter:
    send: Callable[[str], Awaitable[None]]

async def quick_message(chatter: SimpleChatter, msg: str):
    await chatter.send(msg)

# In your route or WebSocket handler
@rt('/quick_action')
async def handle_quick_action():
    user_id = str(id(request))
    
    async def send(content: str):
        await users[user_id](Div(content, id='msg-list', cls='fade-in', style=MATRIX_STYLE))
    
    chatter = SimpleChatter(send)
    await quick_message(chatter, "Action completed!")
    
    return "OK"
```

Absolutely! The Chatter API is flexible, and you can certainly use just the `send` function without `update` or `finish` for simpler use cases. Here's an example of how you could implement a minimal use-case for a rapid default message:

```python
from dataclasses import dataclass
from typing import Callable, Awaitable

@dataclass
class SimpleChatter:
    send: Callable[[str], Awaitable[None]]

async def quick_message(chatter: SimpleChatter, msg: str):
    await chatter.send(msg)

# In your route or WebSocket handler
@rt('/quick_action')
async def handle_quick_action():
    user_id = str(id(request))
    
    async def send(content: str):
        await users[user_id](Div(content, id='msg-list', cls='fade-in', style=MATRIX_STYLE))
    
    chatter = SimpleChatter(send)
    await quick_message(chatter, "Action completed!")
    
    return "OK"
```

In this minimal use-case:

1. We define a `SimpleChatter` class that only has the `send` method.
2. The `quick_message` function takes this `SimpleChatter` and immediately sends the message.
3. In the route handler, we create a `SimpleChatter` with just the `send` function and use it to display a quick message.

This approach is perfect for scenarios where you just need to show a message as quickly as possible, such as:

- Confirmation messages after a user action
- Quick error notifications
- Status updates that don't require streaming or updates

By using this simplified version of Chatter, you maintain the separation of concerns and the flexibility to expand later if needed, while keeping the code minimal for simple use-cases.

Remember, the beauty of this pattern is its flexibility. You can create different variations of the Chatter class based on your specific needs, from this simple one-method version to more complex implementations with multiple stages and behaviors.

---

Fast-forward to staying up straight through the night. This program is way too
big to display here, but I'll do it anyway. Meet the framework for the new
`Pipulate`...

```python
import asyncio
import json
import re
from dataclasses import dataclass
from typing import Callable, Awaitable

import requests
from starlette.concurrency import run_in_threadpool

from fasthtml.common import *


# Configuration and Constants
MAX_LLM_RESPONSE_WORDS = 30
SEARCH_WIDTH = "100px"
ACTIONS_WIDTH = "120px"
CHAT_INTERFACE_WIDTH = "150px"
LOGO_WIDTH = "100px"
NAME = ""

# Styles
MATRIX_STYLE = (
    "color: #00ff00; text-shadow: 0 0 5px #00ff00; "
    "font-family: 'Courier New', monospace;"
)
USER_STYLE = (
    "color: #ffff00; text-shadow: 0 0 5px #ffff00; "
    "font-family: 'Courier New', monospace;"
)

# Initialize conversation
conversation = [
    {
        "role": "system",
        "content": f"You are a Todo App with attitude. Be sassy but helpful in under {MAX_LLM_RESPONSE_WORDS} words, and without leading and trailing quotes.",
    },
]

# Active users connected via WebSocket
users = {}


@dataclass
class Chatter:
    send: Callable[[str], Awaitable[None]]
    update: Callable[[str], Awaitable[None]]
    finish: Callable[[], Awaitable[None]]


@dataclass
class SimpleChatter:
    send: Callable[[str], Awaitable[None]]


def limit_llm_response(response: str) -> str:
    """Limit the LLM response to a maximum number of words."""
    words = response.split()
    return ' '.join(words[:MAX_LLM_RESPONSE_WORDS])


def parse_version(version_string):
    """Parse a version string into a list of integers and strings for comparison."""
    return [int(x) if x.isdigit() else x for x in re.findall(r'\d+|\D+', version_string)]


def get_best_llama_model(models):
    """Select the best available LLaMA model from the list of models."""
    llama_models = [model for model in models if model.lower().startswith('llama')]
    if not llama_models:
        return None

    def key_func(model):
        parts = model.split(':')
        base_name = parts[0]
        version = parts[1] if len(parts) > 1 else ''
        base_version = re.search(r'llama(\d+(?:\.\d+)*)', base_name.lower())
        base_version = base_version.group(1) if base_version else '0'
        return (
            parse_version(base_version),
            1 if version == 'latest' else 0,
            parse_version(version),
        )

    return max(llama_models, key=key_func)


def get_available_models():
    """Retrieve the list of available models from the Ollama API."""
    try:
        response = requests.get("http://localhost:11434/api/tags", timeout=10)
        response.raise_for_status()
        return [model['name'] for model in response.json()['models']]
    except requests.exceptions.RequestException:
        return []


def get_best_model():
    """Get the best available model or default to 'llama2'."""
    available_models = get_available_models()
    return get_best_llama_model(available_models) or (available_models[0] if available_models else "llama2")


def chat_with_ollama(model: str, messages: list) -> str:
    """Interact with the Ollama model to generate a response."""
    url = "http://localhost:11434/api/chat"
    payload = {
        "model": model,
        "messages": messages,
        "stream": False,
    }
    headers = {"Content-Type": "application/json"}
    response = requests.post(url, data=json.dumps(payload), headers=headers)
    if response.status_code == 200:
        return response.json()['message']['content']
    else:
        return f"Error: {response.status_code}, {response.text}"


def render(todo):
    """Render a todo item."""
    tid = f'todo-{todo.id}'
    checkbox = Input(
        type="checkbox",
        name="english" if todo.done else None,
        checked=todo.done,
        hx_post=f"/toggle/{todo.id}",
        hx_swap="outerHTML",
    )
    delete = A(
        'Delete',
        hx_delete=f'/{todo.id}',
        hx_swap='outerHTML',
        hx_target=f"#{tid}",
    )
    return Li(
        checkbox,
        ' ',
        todo.title,
        ' | ',
        delete,
        id=tid,
        cls='done' if todo.done else '',
        style="list-style-type: none;"  # Add this line
    )


# from todo_app import todos, Todo, mk_input as todo_mk_input
def todo_mk_input(): 
    return Input(placeholder='Add a new item', 
                 id='title', 
                 hx_swap_oob='true',
                 autofocus=True)  # Add this line


# Define a function to create the input group
def mk_input_group(disabled=False, value='', autofocus=True):
    """Create the chat input group."""
    return Group(
        Input(
            id='msg',
            name='msg',
            placeholder='Chat...',
            value=value,
            disabled=disabled,
            autofocus='autofocus' if autofocus else None,
        ),
        Button(
            "Send",
            type='submit',
            ws_send=True,
            id='send-btn',
            disabled=disabled,
        ),
        id='input-group',
    )


async def generate_and_stream_ai_response(prompt: str):
    """Generate and stream AI response to users."""
    response = await run_in_threadpool(
        chat_with_ollama,
        model,
        [{"role": "user", "content": prompt}],
    )
    words = response.split()
    for i in range(len(words)):
        partial_response = " ".join(words[: i + 1])
        for u in users.values():
            await u(
                Div(
                    f"{NAME}{partial_response}",
                    id='msg-list',
                    cls='fade-in',
                    style=MATRIX_STYLE,
                    {% raw %}_=f"this.scrollIntoView({{behavior: 'smooth'}});")){% endraw %}
                )
            )
        await asyncio.sleep(0.05)  # Reduced delay for faster typing


async def quick_message(chatter: SimpleChatter, prompt: str):
    """Send a quick message to the chat interface."""
    response = await run_in_threadpool(
        chat_with_ollama,
        model,
        [{"role": "user", "content": prompt}],
    )
    words = response.split()
    for i in range(len(words)):
        partial_response = " ".join(words[: i + 1])
        await chatter.send(f"{NAME}{partial_response}")
        await asyncio.sleep(0.05)  # Adjust this delay as needed


def create_nav_menu(selected_chat="Chat Interface", selected_action="Actions"):
    """Create the navigation menu with a filler item, chat, and action dropdowns."""
    common_style = (
        "font-size: 1rem; height: 32px; line-height: 32px; "
        "display: inline-flex; align-items: center; justify-content: center; "
        "margin: 0 2px; border-radius: 16px; padding: 0 0.6rem;"
    )

    def create_menu_item(title, hx_get, summary_id):
        """Create a menu item."""
        return Li(
            A(
                title,
                hx_get=hx_get,  # Keep the original hx_get
                hx_target=f"#{summary_id}",
                hx_swap="outerHTML",
                hx_trigger="click",
                hx_push_url="false",  # Prevent URL changes
                cls="menu-item",
            )
        )

    chat_summary_id = "chat-summary"
    action_summary_id = "action-summary"

    # Filler Item: Non-interactive, occupies significant space
    filler_item = Li(
        Span(" "),  # Empty span as a filler
        style=(
            "flex-grow: 1; min-width: 300px; "  # Allows it to grow and ensures a minimum width
            "list-style-type: none;"  # Removes the bullet point
        ),
    )

    chat_menu = Details(
        Summary(
            selected_chat,
            style=(
                f"{common_style} width: {CHAT_INTERFACE_WIDTH}; "
                "background-color: var(--pico-background-color); "
                "border: 1px solid var(--pico-muted-border-color);"
            ),
            id=chat_summary_id,
        ),
        Ul(
            create_menu_item("Todo Chat", "/chat/todo_chat", chat_summary_id),
            create_menu_item("Future Chat 1", "/chat/future_chat_1", chat_summary_id),
            create_menu_item("Future Chat 2", "/chat/future_chat_2", chat_summary_id),
            create_menu_item("Future Chat 3", "/chat/future_chat_3", chat_summary_id),
            dir="rtl",
            id="chat-menu-list",
        ),
        cls="dropdown",
        id="chat-menu",
    )

    action_menu = Details(
        Summary(
            selected_action,
            style=(
                f"{common_style} width: {ACTIONS_WIDTH}; "
                "background-color: var(--pico-background-color); "
                "border: 1px solid var(--pico-muted-border-color);"
            ),
            id=action_summary_id,
        ),
        Ul(
            create_menu_item("Action 1", "/action/1", action_summary_id),
            create_menu_item("Action 2", "/action/2", action_summary_id),
            create_menu_item("Action 3", "/action/3", action_summary_id),
            create_menu_item("Action 4", "/action/4", action_summary_id),
            dir="rtl",
            id="action-menu-list",
        ),
        cls="dropdown",
        id="action-menu",
    )

    search_group = Group(
        Input(
            placeholder="Search",
            name="nav_input",
            id="nav-input",
            hx_post="/search",
            hx_trigger="keyup[keyCode==13]",
            hx_target="#msg-list",
            hx_swap="innerHTML",
            style=(
                f"{common_style} width: {SEARCH_WIDTH}; padding-right: 25px; "
                "border: 1px solid var(--pico-muted-border-color);"
            ),
        ),
        Button(
            "×",
            type="button",
            onclick="document.getElementById('nav-input').value = ''; this.blur();",
            style=(
                "position: absolute; right: 6px; top: 50%; transform: translateY(-50%); "
                "width: 16px; height: 16px; font-size: 0.8rem; color: var(--pico-muted-color); "
                "opacity: 0.5; background: none; border: none; cursor: pointer; padding: 0; "
                "display: flex; align-items: center; justify-content: center; "
                "border-radius: 50%;"
            ),
        ),
        style="display: flex; align-items: center; position: relative;",
    )

    nav = Div(
        filler_item,  # Add the filler item first
        chat_menu,
        action_menu,
        search_group,
        style=(
            "display: flex; align-items: center; gap: 8px; "
            "width: 100%;"  # Ensure the nav takes full width
        ),
    )

    return nav


# Application Setup
app, rt, todos, Todo = fast_app(
    "data/todo.db",
    ws_hdr=True,
    live=True,
    render=render,
    id=int,
    title=str,
    done=bool,
    pk="id",
)

# Choose the best available model
model = get_best_model()

# WebSocket users
users = {}


def on_conn(ws, send):
    """Handle WebSocket connection."""
    users[str(id(ws))] = send


def on_disconn(ws):
    """Handle WebSocket disconnection."""
    users.pop(str(id(ws)), None)


# Route Handlers
@rt('/')
def get():
    """Handle the main page GET request."""
    nav = create_nav_menu()

    nav_group = Group(
        nav,
        style="display: flex; align-items: center; margin-bottom: 20px; gap: 20px;",
    )

    return Titled(
        "Pipulate Todo App",
        Container(
            nav_group,
            Grid(
                Div(
                    Card(
                        H2("Todo List"),
                        Ul(*[render(todo) for todo in todos()], id='todo-list', style="padding-left: 0;"),  # Add style here
                        header=Form(
                            Group(
                                todo_mk_input(),
                                Button("Add", type="submit"),
                            ),
                            hx_post="/todo",
                            hx_swap="beforeend",
                            hx_target="#todo-list",
                        ),
                    ),
                ),
                Div(
                    Card(
                        H2("Chat Interface"),
                        Div(
                            id='msg-list',
                            cls='overflow-auto',
                            style='height: 40vh;',
                        ),
                        footer=Form(
                            mk_input_group(),
                        ),
                    ),
                ),
                cls="grid",
                style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px;",
            ),
            Div(
                A(
                    "Poke Todo List",
                    hx_post="/poke",
                    hx_target="#msg-list",
                    hx_swap="innerHTML",
                    cls="button",
                ),
                style="position: fixed; bottom: 20px; right: 20px; z-index: 1000;",
            ),
        ),
        hx_ext='ws',
        ws_connect='/ws',
        data_theme="dark",
    )


@rt('/todo')
async def post_todo(todo: Todo):
    """Handle adding a new todo item."""
    if not todo.title.strip():
        # Empty todo case
        asyncio.create_task(
            generate_and_stream_ai_response(
                "User tried to add an empty todo. Respond with a brief, sassy comment about their attempt."
            )
        )
        return ''  # Return empty string to prevent insertion
    
    # Non-empty todo case
    inserted_todo = todos.insert(todo)

    asyncio.create_task(
        generate_and_stream_ai_response(
            f"New todo: '{todo.title}'. Brief, sassy comment or advice."
        )
    )

    return render(inserted_todo), todo_mk_input()


@rt('/{tid}')
async def delete(tid: int):
    """Handle deleting a todo item."""
    todo = todos[tid]  # Get the todo item before deleting it
    todos.delete(tid)

    # Adjusted prompt for brevity
    asyncio.create_task(
        generate_and_stream_ai_response(
            f"Todo '{todo.title}' deleted. Brief, sassy reaction."
        )
    )

    return ''  # Return an empty string to remove the item from the DOM


@rt('/toggle/{tid}')
async def toggle(tid: int):
    """Handle toggling a todo item's done status."""
    todo = todos[tid]
    old_status = "Done" if todo.done else "Not Done"
    todo.done = not todo.done
    new_status = "Done" if todo.done else "Not Done"
    updated_todo = todos.update(todo)

    # Adjusted prompt to include the todo title
    asyncio.create_task(
        generate_and_stream_ai_response(
            f"Todo '{todo.title}' toggled from {old_status} to {new_status}. "
            f"Brief, sassy comment mentioning '{todo.title}'."
        )
    )

    return Input(
        type="checkbox",
        name="english" if updated_todo.done else None,
        checked=updated_todo.done,
        hx_post=f"/toggle/{updated_todo.id}",
        hx_swap="outerHTML",
    )


@rt('/poke')
async def poke():
    """Handle poking the todo list for a response."""
    response = await run_in_threadpool(
        chat_with_ollama,
        model,
        [
            {
                "role": "system",
                "content": "You are a sassy Todo List. Respond briefly to being poked.",
            },
            {
                "role": "user",
                "content": "You've been poked.",
            },
        ],
    )
    return Div(f"{NAME}{response}", id='msg-list', cls='fade-in', style=MATRIX_STYLE)


@rt('/chat/{chat_type}')
async def chat_interface(chat_type: str):
    """Handle chat menu selection."""
    # Update the summary element with the selected chat type
    chat_summary_id = "chat-summary"
    selected_chat = chat_type.replace('_', ' ').title()
    summary_content = Summary(
        selected_chat,
        style=(
            f"font-size: 1rem; height: 32px; line-height: 32px; "
            "display: inline-flex; align-items: center; justify-content: center; "
            "margin: 0 2px; border-radius: 16px; padding: 0 0.6rem; "
            f"width: {CHAT_INTERFACE_WIDTH}; background-color: var(--pico-background-color); "
            "border: 1px solid var(--pico-muted-border-color);"
        ),
        id=chat_summary_id,
    )

    # Generate AI response
    prompt = f"Respond mentioning '{selected_chat}' in your reply, keeing it brief, under 20 words."
    chatter = SimpleChatter(
        send=lambda msg: asyncio.gather(
            *[
                u(
                    Div(
                        msg,
                        id='msg-list',
                        cls='fade-in',
                        style=MATRIX_STYLE,
                    )
                )
                for u in users.values()
            ]
        )
    )
    asyncio.create_task(quick_message(chatter, prompt))

    return summary_content


@rt('/action/{action_id}')
async def perform_action(action_id: str):
    """Handle action menu selection."""
    # Update the summary element with the selected action
    action_summary_id = "action-summary"
    selected_action = f"Action {action_id}"
    summary_content = Summary(
        selected_action,
        style=(
            f"font-size: 1rem; height: 32px; line-height: 32px; "
            "display: inline-flex; align-items: center; justify-content: center; "
            "margin: 0 2px; border-radius: 16px; padding: 0 0.6rem; "
            f"width: {ACTIONS_WIDTH}; background-color: var(--pico-background-color); "
            "border: 1px solid var(--pico-muted-border-color);"
        ),
        id=action_summary_id,
    )

    # Generate AI response
    prompt = f"You selected '{selected_action}'. Respond cleverly, mentioning '{selected_action}' in your reply. Be brief and sassy."
    chatter = SimpleChatter(
        send=lambda msg: asyncio.gather(
            *[
                u(
                    Div(
                        msg,
                        id='msg-list',
                        cls='fade-in',
                        style=MATRIX_STYLE,
                    )
                )
                for u in users.values()
            ]
        )
    )
    asyncio.create_task(quick_message(chatter, prompt))

    return summary_content


@rt('/search', methods=['POST'])
async def search(nav_input: str):
    """Handle search input."""
    prompt = f"The user searched for: '{nav_input}'. Respond briefly acknowledging the search."
    chatter = SimpleChatter(
        send=lambda msg: asyncio.gather(
            *[
                u(
                    Div(
                        msg,
                        id='msg-list',
                        cls='fade-in',
                        style=MATRIX_STYLE,
                    )
                )
                for u in users.values()
            ]
        )
    )
    asyncio.create_task(quick_message(chatter, prompt))
    return ''


@rt('/toggle-theme', methods=['POST'])
def toggle_theme():
    """Handle theme toggle."""
    return ''  # Theme change is handled client-side


# WebSocket Handler Modification
@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    """Handle WebSocket messages."""
    if msg:
        # Disable the input group
        disable_input_group = mk_input_group(disabled=True, value=msg, autofocus=False)
        disable_input_group.attrs['hx_swap_oob'] = "true"
        for u in users.values():
            await u(disable_input_group)

        # Process the message and generate response
        global conversation
        conversation.append({"role": "user", "content": msg})

        # Start streaming response
        response = await run_in_threadpool(chat_with_ollama, model, conversation)
        conversation.append({"role": "assistant", "content": response})

        # Simulate typing effect (AI response remains green)
        words = response.split()
        for i in range(len(words)):
            partial_response = " ".join(words[: i + 1])
            for u in users.values():
                await u(
                    Div(
                        f"{NAME}{partial_response}",
                        id='msg-list',
                        cls='fade-in',
                        style=MATRIX_STYLE,
                        {% raw %}_=f"this.scrollIntoView({{behavior: 'smooth'}});")){% endraw %}
                    )
                )
            await asyncio.sleep(0.05)  # Reduced delay for faster typing

        # Re-enable the input group
        enable_input_group = mk_input_group(disabled=False, value='', autofocus=True)
        enable_input_group.attrs['hx_swap_oob'] = "true"
        for u in users.values():
            await u(enable_input_group)


serve()
```

