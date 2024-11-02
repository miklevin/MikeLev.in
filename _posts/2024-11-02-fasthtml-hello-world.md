---
title: FastHTML Hello World
permalink: /fasthtml-hello-world/
description: Learn the basics of FastHTML, a Python web framework that skips templating languages and allows direct HTML element creation with Python functions. Discover how to build a simple "Hello World" page with structured HTML using FastHTML's function-to-element mapping.
layout: post
sort_order: 1
---

FastHTML is not FastAPI and your AI coding assistants will need frequent
reminding. There is no template language but Python function names. See...

```python
from fasthtml.common import *

app, rt = fast_app()

@rt("/")
def home():
    return "Hello World!"

serve()
```

This will return Hello World with a request to the page, but it won't have any
of the HTML tags that, well, make it HTML, so let's add those...

```python
from fasthtml.common import *

app, rt = fast_app()

@rt("/")
def home():
    return Html(
        Head(
            Title("SSE Proof of Concept")
        ),
        Body(
            H1("Hello World!")
        )
    )

serve()
```

If you view-source the HTML, you'll see:

```html
 <html>
   <head>
     <title>SSE Proof of Concept</title>
   </head>
   <body">
     <h1>Hello World!</h1>
   </body>
 </html>
```

You can start to see the 1-to-1 mappings between Python function names and HTML
elements. We don't need no stinkin template language. You can shove those
mustache curly braces up your liquid jsx nunchucks. Life's better without 'em.

In FastHTML the HTML elements are the Python function names. The things about
the HTML elements are defined with the input given to those functions. Function
input is done with argument values fed into parameter keys.

Now if you wanted to add a little (inline) style to the page, you just drop in a
style tag. Oddly, it has to go after the H1 tag, and these are nuances you just
have to get to know over time. But the payback is so worth it.

```python
from fasthtml.common import *

app, rt = fast_app()

@rt("/")
def home():
    return Html(
        Head(
            Title("SSE Proof of Concept")
        ),
        Body(
            H1("Hello World!"),
            style="padding: 2rem;",
        )
    )

serve()
```

This changes the emitted HTML to this...

```html
 <html>
   <head>
     <title>SSE Proof of Concept</title>
   </head>
   <body style="padding: 2rem;">
     <h1>Hello World!</h1>
   </body>
 </html>
```

So what you've seen so far is basically Flask without the jinja2 templates. Cool
enough. Getting templates out of your life is reason enough to take up FastHTML.


