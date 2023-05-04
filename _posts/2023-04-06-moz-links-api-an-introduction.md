---
date: 2023-04-06
title: MOZ Links API, An Introduction
headline: Learn How to Use APIs with Python and the MOZ Links API
description: As a Python programmer, I'm here to tell you about APIs and how to use them. I'll explain the MOZ Links API, GET and POST methods, JSON format, and Python dictionaries. Plus, I'll show you how to make a request using the requests library, and how to use the 'json.dumps' and 'json.loads' functions to convert a Python object into a JSON string. Read my blog post to learn more!
keywords: API, MOZ Links API, GET, POST, JSON, Python, Dictionaries, Requests Library, Assignment, Equality, Keyword Parameters, Arguments, ACCESSID, SECRETKEY, AUTH_TUPLE, Endpoints, Jupyter Notebook
categories: moz links api, python, jupyter notebook, api
permalink: /blog/moz-links-api-an-introduction/
layout: post
---


Hello World! Do you know what an API is? They're those things that you
copy/paste long strange codes into ScreamingFrog for Links data on a crawl,
right? I'm here to tell you there's so much more than that if you're willing to
take just a few little steps. First, some basics.

### What is an API?

API stands for application programming interface, and it's just the way of
using a thing. Everything has an API. The Web is a giant API that takes URLs as
input and returns pages. But special data services like the MOZ Links API have
their own set of API-rules. These rules vary from service to service and can be
a major stumbling block for people taking the next step.

When ScreamingFrog gives you the extra Links columns in a crawl, it's using the
MOZ Links API, but you can have this capability anywhere. For example, all that
tedious manual stuff you do in spreadsheet environments can be automated. If
you take this next step, you can be more competitive and more efficient than
your competitors in designing and delivering your SEO services.

### GET vs POST

Most APIs you'll encounter use the same data transport mechanism as the Web.
That means there's a URL involved just like a website. Don't get scared! It's
easier than you think. In many ways, using APIs is just like using a website.

As with loading web pages, the request may be on one of 2 places: the URL
itself, or in the body of the request. The URL is called the "endpoint" and the
often invisibly submitted extra part of the request is called the "payload" or
"data". When the data is in the URL, it's called a "query string" and indicates
the "GET" method is used. You see this all the time when you search:

    https://www.google.com/search?q=moz+links+api <-- GET method request

When the data of the request is hidden, it's called a "POST" request. You see
this when you submit a form on the web and the submitted data does not show on
the URL. When you hit the back button after such a POST, browsers usually warn
you against double-submits. The reason the POST method is often used is that
you can fit a lot more in the request using the POST method than the GET
method. URLs would get very long otherwise. The MOZ Links API uses the POST
method.

### Making Requests

A Web browser is what traditionally makes requests of websites for web pages.
The browser is a type of software known as a ***client***. Clients are what
make requests of services. More than just browsers can make requests. The
ability to make client web requests is often built into programming languages
like Python, or can broken out as a standalone tool. The most popular tools for
making requests outside a browser are ***curl*** and ***wget***.

We are discussing Python here. Python has a built-in library called URLLIB, but
it's designed to handle so many different types of requests that it's a bit of
a pain to use. There are other libraries that are more specialized for making
requests of APIs. The most popular for Python is called ***requests***. It's so
popular that it's used for almost every Python API tutorial you'll find on the
web. So I will use it too. This is what "hitting" the MOZ Links API looks like:

```python
response = requests.post(endpoint, data=json_string, auth=auth_tuple)
```

Given that everything was set up correctly (more on that soon), this will
produce the following output:

```python
{'next_token': 'JYkQVg4s9ak8iRBWDiz1qTyguYswnj035nqrQ1oIbW96IGJsb2dZgGzDeAM7Rw==',
 'results': [{'anchor_text': 'moz',
              'external_pages': 7162,
              'external_root_domains': 2026}]}
```

This is `JSON` data. Its contained within the response object that was returned
from the API. It's not on the drive or in a file. It's in memory. So long as
it's in memory, you can do stuff with it (often just saving it to a file).

If you wanted to grab a piece of data within such a response, you could refer
to it like this:

```python
response['results'][0]['external_pages']
```

This says: "Give me the first item in the `results` list, and then give me the
`external_pages` value from that item." The result would be `7162`.

NOTE: If you're actually following along executing code, the above line won't
work alone. There's a certain amount of setup we'll do shortly, including
installing the requests library and setting up a few variables. But this is the
basic idea.

### JSON

JSON stands for JavaScript Object Notation. It's a way of representing data in
a way that's easy for humans to read and write. It's also easy for computers to
read and write. It's a very common data format for APIs that has somewhat taken
over the world since the older ways were too difficult for most people to use.
Some people might call this part of the "restful" API movement, but the much
more difficult XML format is also considered "restful" and everyone seems to
have their own interpretation. Consequently, I find it best to just focus on
JSON and how it gets in and out of Python.

### Python Dictionaries

I lied to you. I said that the data structure you were looking at above was
JSON. Technically it's really a Python dictionary or `dict` datatype object.
It's a special kind of object in Python that's designed to hold key/value
pairs. The keys are strings and the values can be any type of object. The keys
are like the column names in a spreadsheet. The values are like the cells in
the spreadsheet. In this way, you can think of a Python dict as a JSON object.
For example here's creating a dict in Python:

```python
my_dict = {
    "name": "Mike",
    "age": 52,
    "city": "New York"
}
```

And here is the equivalent in JavaScript:

```javascript
var my_json = {
    "name": "Mike",
    "age": 52,
    "city": "New York"
}
```

Pretty much the same thing, right? Look closely. Key-names and string values
get double-quotes. Numbers don't. These rules apply consistently between JSON
and Python dicts. So as you might imagine, it's easy for JSON data to flow in
and out of Python.

### Flattening Data

But beware! As data flows between systems, it's not uncommon for the data to
subtly change. For example, the JSON data above might be converted to a string.
Strings might look exactly like JSON, but they're not. They're just a bunch of
characters. Sometimes you'll hear it called "serializing", or "flattening".

### Objects Have APIs

Actual `JSON` or `dict` objects have their own little APIs for accessing the
data inside of them. The ability to use these JSON and dict APIs goes away when
the data is flattened into a string, but it will travel between systems more
easily, and when it arrives at the other end, it will be "deserialized" and the
API will come back on the other system.

### Data Flows

This is the concept of portable, interoperable data. Back when it was called
Electronic Data Interchange (or EDI), it was a very big deal. Then along came
the Web and then XML and then JSON and now it's just a normal part of doing
business.

If you're in Python and you want to convert a dict to a flattened JSON string,
you do the following:

```python
import json

my_dict = {
    "name": "Mike",
    "age": 52,
    "city": "New York"
}

json_string = json.dumps(my_dict)
```

...which would produce the following output:

```python
'{"name": "Mike", "age": 52, "city": "New York"}'
```

This looks almost the same as the original dict, but if you look close you can
see that single-quotes are used around the entire thing. Another obvious
difference is that you can line-wrap real structured data for readability
without any ill effect. You can't so easily with strings, so we show it all on
one line.

Such stringifying processes are done when passing data between different
systems because they are not always compatible. Normal text strings on the
other hand are compatible with almost everything and can be passed on
web-requests with ease. Such flattened strings of JSON data are frequently
referred to as ***the request***.

### Anatomy of a Request

Again, here's the example request we made above:

```python
response = requests.post(endpoint, data=json_string, auth=auth_tuple)
```

Now that you understand what the variable name json_string is telling you about
its contents, you shouldn't be surprised to see this is how we populate that
variable:

```python
data_dict = {
    "target": "moz.com/blog",
    "scope": "page",
    "limit": 1
}
json_string = json.dumps(data_dict)
```

...and the contents of json_string looks like this:

```python
'{"target": "moz.com/blog", "scope": "page", "limit": 1}'
```

This is one of my key discoveries in learning the MOZ Links API. This is in
common with countless other APIs out there but trips me up every time because
it's so much more convenient to work with dicts than strings. The API expects
the data to be a string, so we have to convert it at the last moment before the
actual API-call occurs.

### Pythonic Loads & Dumps

Now you may be wondering in that above example, what a dump is doing in the
middle of the code. The `json.dumps()` function is called a "dumper" because it
takes a Python object and dumps it into a string. The `json.loads()` function
is called a "loader" because it takes a string and loads it into a Python
object.

The reason for what appear to be singular and plural options are actually
binary and string options. If your data is binary, you use `json.load()` and
`json.dump()`. If your data is a string, you use `json.loads()` and
`json.dumps()`. The `s` stands for string. Leaving the `s` off means binary.

Don't let anybody tell you Python is perfect. It's just that its rough edges
are not excessively objectionable.

### Assignment vs. Equality

For those of you completely new to Python or programming in general, what we're
doing when we hit the API is called an assignment. The result of
`requests.post()` is being assigned to the variable named `response`.

```python
response = requests.post(endpoint, data=json_string, auth=auth_tuple)
```

We are using the `=` sign to assign the value of the right side of the equation
to the variable on the left side of the equation. The variable `response` is
now a reference to the object that was returned from the API. Assignment is
different from equality. The `==` sign is used for equality.

```python
# This is assignment:
a = 1  # a is now equal to 1

# This is equality:
a == 1  # True, but relies that the above line has been executed
```

#### The POST Method

```python
response = requests.post(endpoint, data=json_string, auth=auth_tuple)
```

The `requests` library has a function called `post()` that takes 3 arguments.
The first argument is the URL of the endpoint. The second argument is the data
to send to the endpoint. The third argument is the authentication information
to send to the endpoint.

#### Keyword Parameters And Their Arguments

You may notice that some of the arguments to the `post()` function have names.
Names are set equal to values using the `=` sign. Here's how Python functions
get defined. The first argument is positional both because it comes first and
also because there's no keyword. Keyworded arguments come after
position-dependent arguments. Trust me, it all makes sense after awhile. We all
start to think like Guido van Rossum.

```python
def arbitrary_function(argument1, name=argument2):
    # do stuff
```

The name in the above example is called a "keyword" and the values that come in
on those locations are called "arguments". Now arguments are assigned to
variable names right in the function definition, so you can refer to either
argument1 or argument2 anywhere inside this function. If you'd like to learn
more about the rules of Python functions, you can read about them
[here](https://docs.python.org/3/tutorial/controlflow.html#defining-functions).

## Setting Up the Request

Okay, so let's let you do everything necessary for that ***success assured***
moment. We've been showing the basic request:

```python
response = requests.post(endpoint, data=json_string, auth=auth_tuple)
```

...but we haven't shown everything that goes into it. Let's do that now. If
you're following along and don't have the requests library installed, you can
do so with the following command from the same terminal environment from which
you run Python:

```bash
pip install requests
```

Often times Jupyter will have the requests library installed already, but in
case it doesn't, you can install it with the following command from inside a
Notebook cell:

```python
!pip install requests
```

And now we can put it all together. There's only a few things here that are
new. The most important is how we're taking 2 different variables and combining
them into a single variable called `AUTH_TUPLE`. You will have to get your own
ACCESSID and SECRETKEY from the [MOZ.com
website](https://moz.com/help/links-api/getting-started/get-a-key).

The API expects these two values to be passed as a Python data structure called
a `tuple`. A tuple is a list of values that don't change. I find it interesting
that `requests.post()` expects flattened strings for the `data` parameter, but
expects a tuple for the `auth` parameter. I suppose it makes sense, but these
are the subtle things to understand when working with APIs.

Here's the full code:

```python
import json
import pprint
import requests

# Set Constants
ACCESSID = "mozscape-1234567890"  # Replace with your access ID
SECRETKEY = "1234567890abcdef1234567890abcdef"  # Replace with your secret key
AUTH_TUPLE = (ACCESSID, SECRETKEY)

# Set Variables
endpoint = "https://lsapi.seomoz.com/v2/anchor_text"
data_dict = {"target": "moz.com/blog", "scope": "page", "limit": 1}
json_string = json.dumps(data_dict)

# Make the Request
response = requests.post(endpoint, data=json_string, auth=AUTH_TUPLE)

# Print the Response
pprint(response.json())
```

...which outputs:

```python
{'next_token': 'JYkQVg4s9ak8iRBWDiz1qTyguYswnj035nqrQ1oIbW96IGJsb2dZgGzDeAM7Rw==',
 'results': [{'anchor_text': 'moz',
              'external_pages': 7162,
              'external_root_domains': 2026}]}
```

Using all upper case for the `AUTH_TUPLE` variable is a convention many use in
Python to indicate that the variable is a constant. It's not a requirement, but
it's a good idea to follow conventions when you can.

You may notice that I didn't use all uppercase for the `endpoint` variable.
That's because the `anchor_text` endpoint is not a constant. There are a number
of different endpoints that can take its place depending on what sort of lookup
we wanted to do. The choices are:

1. anchor_text
1. final_redirect
1. global_top_pages
1. global_top_root_domains
1. index_metadata
1. link_intersect
1. link_status
1. linking_root_domains
1. links
1. top_pages
1. url_metrics
1. usage_data

And that leads into the Jupyter Notebook that I prepared on this topic located
[here on Github](https://github.com/miklevin/moz/blob/main/nbs/10_links_api.ipynb).
With this Notebook you can extend the example I gave here to any of the 12
available endpoints to create a variety of useful deliverables, which will be
the subject of articles to follow.



## Categories

<ul>
<li><h4><a href='/moz-links-api/'>MOZ Links API</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jupyter-notebook/'>Jupyter Notebook</a></h4></li>
<li><h4><a href='/api/'>API</a></h4></li></ul>