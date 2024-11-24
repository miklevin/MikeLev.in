---
title: SSE Makes Watchdog Necessary to Force Server Live-Reload
permalink: /futureproof/sse-watchdog-force-live-reload/
description: Waiting for connections to close? (CTRL+C to force quit?) Discover why adding SSE to FastHTML demands a more heavyweight solution for live-reloading, and how using a watchdog brings your dev environment back to life—Wile E. Coyote-style—with every file save.
layout: post
sort_order: 2
---

This is super-obscure and super-important to those of us who need to maintain
that creative flow state while doing FastHTML no-build web development. We love
turning on the ***live-reload*** feature, aka ***auto-restart*** so that every
time you save a change to your file, it's immediately visible in your browser.
It's just this easy to turn on in FastHTML and it gets you spoiled fast.

```python
app, rt = fast_app(
    live=True
)
```

Simple enough, right? This even works when you start to have kooky non-http type
connections like chat-enabling websockets going on (as expected) under FastHTML
like so:

```python
app, rt = fast_app(
    live=True,
    ws_hdr=True
)
```

Still no problem. But the moment you go from from just HTTP and WebSockets to
SSE as well (server side events), you lose auto-reload and get this error
message when it tries. It needs an extra `Control-C` from the user, which sort
of defeats the purpose. It becomes unresponsive, but is still stuck running and
sort of needs an anvil dropped on its head.

```
WARNING:  WatchFiles detected changes in 'server.py'. Reloading...
INFO:     Shutting down
19:15:39 | INFO     | WebSocket disconnected
19:15:39 | DEBUG    | WebSocket connection closed
INFO:     connection closed
INFO:     connection closed
INFO:     Waiting for connections to close. (CTRL+C to force quit)
```

You get this error because you added something like this to your code:

```python
from fasthtml.common import *
from datetime import datetime

app, rt = fast_app(
    "data.db",
    live=True,  # This works fine for HTTP & WebSocket
    ws_hdr=True
)

# Simple counter to demonstrate SSE
async def counter_generator():
    count = 0
    while True:
        await asyncio.sleep(1)
        count += 1
        yield f"data: Count is {count} at {datetime.now()}\n\n"

@app.route("/sse")
async def sse(request):
    """Simple SSE endpoint that counts forever"""
    return EventStream(counter_generator())
```

The funny thing here is this really caught me off guard because there's nothing
new being imported. That `EventStream()` is the culprit and it's just another
thing from `starlette` that gets dumped into your global namespace from the
`from fasthtml.common import *` directive. Who would have thought actually using
it would turn off live-reload, but it does. Apparently the context in which
server side events run is different and the lightweight restart apparatus built
into the `uvicorn` ASGI server isn't up to the job.

### Normal Auto-Reload (HTTP/WebSocket):

```
┌──────────┐ Save  ┌──────────┐ New  ┌──────────┐
│ Server A │ File  │ Uvicorn  │ Code │ Server B │
│  Running │─────► │ Reload   │────► │ Running  │
└──────────┘       └──────────┘      └──────────┘
```

### SSE Auto-Reload Problem:

```
┌──────────┐ Save  ┌──────────┐
│ Server A │ File  │ Uvicorn  │
│  Running │─────► │ Reload   │
└──────────┘       └──────────┘
      │                 │
      │ SSE Connection  │ Stuck waiting
      │ won't close     │ for cleanup
      ▼                 ▼
┌─────────────────────────┐
│ ERROR: Need manual      │
│ Control-C intervention  │
└─────────────────────────┘
```

## FastHTML SSE Event Endpoints: A Reboot Nightmare

And now you have to hit Control+C to ***really reboot the server*** whenever a
file-save occurs. And it's all still running from the same single `server.py`
(or whatever). Sheesh! 

And that's where `watchdog` comes in.

I really don't like doing this, because so far we've avoided the Pythonic but
ugly run-like-a-script directive:

```python
if __name__ == "__main__":
    main()
```

We budding FastHTML-jokeys are spoiled by being able to use the much more
pleasant to look at and unobjectionable:

```
serve()
```

...command. However, that's because the main-check is inside of it. It's not
like you ever get away from `if __name__ == "__main__":` in Python. You just
shove around where it's hidden. But in this case, we are not going to be using
the `serve()` convenience wrapper, for that's all that it is coming in with the
`from fasthtml.common import *` directive. It's using `uvicorn` in just such a
way as to suit Jeremy Howard's web framework preferences, and I've found that's
usually the right thing. However, we are about to drop an anvil on the
webserver's head, forcing a restart that cannot be resisted. And for that, we
huff and we puff and we use this friggin technique.

### BEFORE WATCHDOG:

```python
serve()  # The way starting a server should look
```

It's hard to believe, but simply to have a more rigorous server restarting
system for the live-reload feature, you have quite a few more imports and a ton
more code. It's not all strictly necessary, but if I made a Python syntax error,
I want to know the exact nature of the error right away so I can go fix it,
which is why the `ast` (abstract syntax tree) import.

### AFTER WATCHDOG:

```python
# All the imports that weren't required before watchdog
import ast
import os
import sys
import time
import uvicorn
from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer

# Full-path of the current running "server.py" file
THIS_FILE = Path(__file__)


def check_syntax(filename):
    with open(filename, 'r') as file:
        source = file.read()
    try:
        ast.parse(source)
        return True
    except SyntaxError as e:
        print(f"Syntax error in {filename}:")
        print(f"  Line {e.lineno}: {e.text}")
        print(f"  {' ' * (e.offset - 1)}^")
        print(f"Error: {e}")
        return False


def restart_server():
    """Restart the server if the current file has been modified."""
    if not check_syntax(THIS_FILE):
        print("Syntax error detected. Please fix the error and save the file again.")
        return

    max_retries = 3
    for attempt in range(max_retries):
        try:
            os.execv(sys.executable, ['python'] + sys.argv)
        except Exception as e:
            print(f"Error restarting server (attempt {attempt + 1}/{max_retries}): {e}")
            if attempt < max_retries - 1:
                print("Waiting 5 seconds before retrying...")
                time.sleep(5)
            else:
                print("Max retries reached. Please restart the server manually.")


class ServerRestartHandler(FileSystemEventHandler):
    """Restart the server if the current file has been modified."""
    def on_modified(self, event):
        if str(THIS_FILE.resolve()) == str(Path(event.src_path).resolve()):
            print(f"{THIS_FILE} has been modified. Checking syntax and restarting...")
            restart_server()


def run_server_with_watchdog():
    """Run the server with a watchdog to restart it if the current file has been modified."""
    event_handler = ServerRestartHandler()
    observer = Observer()
    observer.schedule(event_handler, path='.', recursive=False)
    observer.start()

    try:
        uvicorn.run(app, host="0.0.0.0", port=5001)
    except KeyboardInterrupt:
        observer.stop()
    except Exception as e:
        print(f"Error running server: {e}")
        print("Attempting to restart...")
        restart_server()
    finally:
        observer.join()


if __name__ == "__main__":
    run_server_with_watchdog()
```

The introduction of a watchdog here is all about ensuring a reliable, automatic server restart whenever you save changes to your code. This is especially useful in setups where traditional live-reloading isn't enough, such as when using server-sent events (SSE), which can introduce issues with process persistence that disrupt regular server control. Let's walk through how the new watchdog-enabled setup achieves this, starting from the imports down to the execution.

### Server Restart Process:

The diagram may look whimsical, but it illustrates a serious point: sometimes
you need a heavy-handed approach (the BONK!) to ensure clean server restarts.
The watchdog acts like a reliable anvil, ensuring that no matter how stubborn
the SSE connection might be, the server will properly restart with your changes.

```
        ┌─────────────┐
        │ File System │
        │  Watchdog   │          ┌──────────────┐
        │ "MEEP MEEP" │          │  AST Syntax  │
        └──────┬──────┘          │   "Valid!"   │
               │                 └───────┬──────┘
               │ BONK!                   │
               ▼                         ▼
 ┌───────────────────────────┐     ┌──────────┐
 │    Uvicorn Server         │ ──► │   Save   │
 │"Still holding SSE conn..."│     │ Changes  │
 └───────────────────────────┘     └──────────┘
```

This pattern of using watchdog for forced restarts isn't just useful for SSE
scenarios - it's a robust solution for any situation where you need guaranteed
server restarts, such as when working with long-running background tasks or
persistent database connections that might prevent clean shutdowns.

### Step-by-Step Explanation

1. **Imports**:
   - The code adds several imports that weren’t necessary before:
     - **`ast`**: Used for syntax checking to catch errors immediately when you save.
     - **`os` and `sys`**: These allow us to manipulate system-level commands to restart the server.
     - **`time`**: Adds delay functionality if the server restart needs to be retried.
     - **`watchdog`**: This library actively monitors file changes in real-time, automatically triggering a server restart when you save changes.

2. **Defining Paths**:
   - **`THIS_FILE = Path(__file__)`**: This captures the full path to the script itself, making it possible to know when changes are saved to this specific file.

3. **Syntax Checker (`check_syntax`)**:
   - This function verifies if the latest saved code is free from syntax errors. If there’s an error, it provides details (line number, error message, and location) to make debugging faster.
   - It parses the code using Python's `ast.parse()` to catch syntax issues before reloading, so if there’s an error, the server doesn’t restart with broken code.

4. **Restarting the Server (`restart_server`)**:
   - This function ensures the server fully restarts by executing the current Python script afresh.
   - It also includes a retry mechanism, where it attempts up to three restarts if the initial restart fails, with a 5-second delay between retries.

5. **File Change Handler (`ServerRestartHandler`)**:
   - **`on_modified`**: This method of the `ServerRestartHandler` class is triggered whenever a file is modified. If the modified file is the same as `THIS_FILE`, it initiates a syntax check, and if the syntax is correct, it calls `restart_server()` to restart the server.

6. **Watchdog-Driven Server Execution (`run_server_with_watchdog`)**:
   - This function sets up the watchdog observer to monitor file changes and connects it to the `ServerRestartHandler`.
   - It then starts the FastHTML (Uvicorn) server on a specific host and port (e.g., `0.0.0.0:5001`).
   - If there’s a keyboard interrupt (e.g., pressing `Ctrl+C`), it stops the observer and terminates cleanly.
   - In case of an error during server execution, it attempts to restart the server.

7. **Executing the Code (`if __name__ == "__main__"`)**:
   - This part is crucial for running the code directly. By placing the `run_server_with_watchdog()` function inside this conditional block, it ensures that the watchdog-enabled server only runs if this script is executed directly (not when imported as a module).

### Why This Approach Works

- **Reliability with SSE**: SSE endpoints tend to spawn processes that sometimes don’t terminate with the regular FastHTML `serve()` command. By monitoring file changes directly, this setup makes sure to restart the entire application when the main file is modified, ensuring a fresh, clean slate without orphaned processes.
- **Error Handling and User Feedback**: Adding a syntax checker provides immediate feedback, avoiding partial reloads with broken code. This is invaluable for debugging, as you’re informed of syntax issues before the server even attempts a restart.
- **Automatic Recovery**: With the retry mechanism and a clean shutdown procedure, this approach reduces manual intervention, automating the server's resilience to crashes or other runtime issues.

While this solution does require more boilerplate than the elegant `serve()`
command, you can keep it in a separate development-specific file (e.g.,
`dev_server.py`) and maintain your clean `server.py` for production. This gives
you the best of both worlds - robust development reloading when you need it, and
clean production code when you don't.

In summary, this setup enables fast, error-resistant, and convenient server
restarts, maintaining live-reload convenience while working around the quirks
introduced by server-sent events. It makes development with FastHTML smoother
and more reliable, even when complex real-time features like SSE are in play.

## Dropping The Anvil on SSE & This Article

This watchdog setup is dropping that anvil on Wile E. Coyote if he were a
webserver. By adding a reliable hammer to force FastHTML’s live-reload, we
sidestep the usual Control-C dance and let our SSE-driven server rise from the
ashes of each code save, fresh and error-free. We’ve traded the sleek serve
command for a more resilient approach, keeping syntax errors in check and
ensuring that no stubborn SSE connections linger behind. It’s not just about
making the server restart—it’s about making it do so smoothly, automatically,
and reliably that we can get back into our beloved no-build webdev flow state.
