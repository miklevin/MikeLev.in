---
date: 2023-03-31
title: Connecting to the Moz Links API V1 For the First Time
headline: "Exploring the Moz Links API V1: My First Request and What I Learned"
description: I'm trying out a new writing and video-recording habit and connecting to the Moz Links API V1 for the first time. I'm using Github Copilot, Carnac settings, and the Python requests library. I attempted my first request but got a 401. After further investigation, I was successful in making the request, though the documentation could have been clearer. Join me as I document the process of setting up a streaming channel with the Moz Links API.
keywords: Moz Links API, V1, Writing, Video-recording, Github Copilot, Carnac settings, Python requests library, POST requests, JSON string, Auth parameter, Documentation, Streaming channel, YouTube MOZ
categories: github copilot, moz links api
permalink: /blog/connecting-to-the-moz-links-api-v1-for-the-first-time/
layout: post
---


Okay, my work email is comped to the Moz Pro standard $99/mo plan. But I am
still prompted type in credit card information for the Links API. But my work
today really is with the Links API. I'll give it my credit card information in
order to get this project underway, then reach out to folks on Slack to keep it
from charging me. Put it on the right credit card just in case, haha!

I think I actually look forward to my daily journaling now with Github Copilot
there. They promote this service as built-in AP-powered pair programming, but
in this context in markdown files where you're not programming so much as just
open-ended writing, it's pair journaling. I think it's a great way to get
started. It's a great way for a non-experienced journaler to get over the hump
of facing a blank page, and it's great for a seasoned journaler to get over a
slump, funk, writer's block, whatever you want to call it.

It will be interesting to see if my writing style changes. I'm also
experimenting with the best Carnac settings, which really looks good when I'm
doing the subdivided screen thing. Normally I like my vim text editing screen
to be maximized. I used to prefer true full-screen mode, but that removes the
Windows taskbar and the Microsoft Terminal tabs. Also, the F11 key to toggle
back and forth isn't the easiest. Still, go look at what it looks like true
full screen so when you switch into that mode for focus, it still looks good.

Hmmm, it's a slightly different focused experience full-screen than it used to
be because of the Terminal window now being only 80% opaque per the JSON config
file. Interesting language opaque. They could have chosen the more intuitive
word "transparent" and that they didn't means they want 100% to be completely
opaque instead of completely transparent.

I'm shrinking my default font size to 19 in Microsoft Terminal which seems to
be the best balance between true full-screen mode and the right size in
maximized mode for the full bunny ears to show at the top of my screen after
the new journal post keyboard shortcut. Carnac overlaps a bit, but that's
fine. And there's a little left/right scrolling as I type. I'm switching to 18
to see if it gets rid of the side-to-side pop while I type. It does. The bunny
ears still look good.

Let's make Carnac narrower and less intrusive so I don't have to resize things
all the time. I could even leave it maximized when I bring the chat window over
a test. What does right offset look like? This looks good for live-streaming.
The words come right up under my mouth and then scroll up over my face. It's
very much the effect I want to have. It could be centered over my face better,
and word-wrap could be smarter in Carnac and letter-spacing could be tighter.

Shooting new videos on YouTube is a sure way to spike my views and watch time,
but that's not what it's about. YouTube viewership is just one of various
feedback loops that I'm trying to optimize. Others include Twitter, Reddit, and
most importantly of all, feedback from my employers. They may not be able to
quite what I'm trying to do, even though I spell out this FOSS mission of mine
that also leads to profitability. All roads lead to consuming MOZ services.
However, all roads also start out with free services.

I can no longer delay or chase distractions. It's time for 1, 2, 3... 1?

One is making sure I can connect to the APIs and stuff. Get it underway. The
blog part of this can be public. The recorded video will be streamed private to
MOZ maybe? Or streamed private to myself to my MOZ channel. Yes, that would be
appreciated, I think.

Make it a 100% silent video. New habits forming. They go:

- I need to write. Can it be public journal first?
  - Write in private journal if not
  - Write in public journal if so
- Do I need to record a video for the process?
  - Live-stream it to the public if possible
  - Live-stream it to my YouTube MOZ channel but private if not
    - This exposes the raw footage (no audio by choice)
    - I can change permissions to make it visible to MOZ, but still not the
      public.

Okay, now make sure the silent private MOZ channel streaming works. I had to
switch browsers because of streaming key issues. I may have to reset the key
going back to personal streaming.

Okay, now for Moz Links API...

I was just comped the $99 MOZ Pro product, and provided a credit card number to
get the API access. Up to that now.

I have a brand new github repo: github.com/miklevin/moz which I'll be working
out of. Anything public will get committed to the repo. Proprietary stuff
simply won't get committed, and I may break off a new repo when it gets to the
really interesting Data Task Force stuff.

I plan on killing many birds with one stone with that project. We will:

- Do an updated test of DA
- Perform a use case for our data for use in marketplaces like Snowflake
- Produce valuable data for our parent company's M&A department
- Provide a deliverable template for the public to use (minus proprietary
  stuff)

Okay, we have our credentials in memory. Let's see what's what...

We're going to focus on Links V2 for now. V1 will come later, but I want to
blast out the pipes such as it were. BRB, low battery...

I'll occasionally check my streaming status. This first go-around is to the
YouTube channel associated with my mike levin at moz login, and set to
"private" so no one can even see it stream live. This just means I don't have
to deal with local files and editing, and I can do that without worrying about
proprietary info leaks.

REQUEST FORMAT:

All requests are structured as JSON, and must be sent as POST requests to their
respective endpoints. The specific request syntax and parameters available for
each endpoint are documented on their respective pages.

Well, that's a pretty important point. Okay, so Requests it is...

```python
import requests

ENDPOINT = "https://lsapi.seomoz.com/v2/"
end_sub = "anchor_text"

url = ENDPOINT + end_sub

headers = {
    "Authorization": "Basic " + SECRETKEY,
    "Content-Type": "application/json",
    "Host": "lsapi.seomoz.com",
    "Content-Length": "0",
    "User-Agent": "Requests",
}
```

The command to get good formatting is:

    %load_ext lab_black


You can add custom headers to a requests request using the following format which uses a Python dictionary having a colon, :, in its syntax¹.

```python
r = requests.get(url, headers={'Authorization': 'GoogleLogin auth=%s' % authorization_token})
```

You can pass HTTP headers into a POST request using the Python requests library by using the headers= parameter in the.post() function². The headers= parameter accepts a Python dictionary of key-value pairs, where the key represents the header type and the value is the header value.

```python
headers = {
    'Authorization': 'Bearer MY_ACCESS_TOKEN',
    'Content-Type': 'application/json'
}

response = requests.post(url, headers=headers)
```

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 3/31/2023

    (1) python - How to add header in requests - Stack Overflow. https://stackoverflow.com/questions/30832536/how-to-add-header-in-requests Accessed 3/31/2023.
    (2) Using Headers with Python requests • datagy. https://datagy.io/python-requests-headers/ Accessed 3/31/2023.
    (3) Python requests – POST request with headers and body. https://www.geeksforgeeks.org/python-requests-post-request-with-headers-and-body/ Accessed 3/31/2023.
    (4) get - Python requests library how to pass Authorization header with .... https://stackoverflow.com/questions/19069701/python-requests-library-how-to-pass-authorization-header-with-single-token Accessed 3/31/2023.
    (5) api - How do I use basic HTTP authentication with the python Requests .... https://stackoverflow.com/questions/26745462/how-do-i-use-basic-http-authentication-with-the-python-requests-library Accessed 3/31/2023.

Okay, so I did my first request against the API and got 401. My request is not
shaped properly. I may also need the AccountID. Let's see...

Okay, that was the success moment. Observations:

If I just looked at the Python example more closely first, I would have been
better off. There's key principles to be aware of, especially from the Python
perspective.

The post method takes the named parameters: data and auth, and we want to
populate some variables some different ways for this. Counter-intuitively, one
is going to contain a JSON string object. So even if the temptation is to make
data a Python dictionary, don't. Make it a string. And use the json.dumps()
method to do it so you know you get it right.

On the other hand, the argument to the auth parameter is a tuple. So a
flattened json string for data and a python tuple for auth. That could have
been made clearer.

Analyzing the click-path in and why it's so confusing...

- https://moz.com/ Moz Homepage
- https://moz.com/products/api Checkerboard Icon Upper Right
- https://moz.com/help/links-api Documentation link subnav
- https://moz.com/help/links-api/getting-started/overview Left-rail doc nav
  - Some sort of disconnect occurs here. Python people like "huh?"
  - Python requests code example may belong on this page
  - I believe such info to be "overview" in nature.
- https://moz.com/help/links-api/making-calls/anchor-text Specific endpoint
  - It is not until I attempted a specific endpoint call before I encountered
    the full info on how to do a Python request. Demystified.

This needs to be shown sooner in order to hit the sweet-spot with Python people
trying to use the Links API, and there would be more if it were clearer.
Chicken-and-egg. It should be like tripping over your feet and it still works,
dirt simple.

    request = requests.post(url, data=data, auth=auth)

It further needs to be explicitly spelled out that the data parameter is a JSON
string. It's not a Python dict, nor a Python JSON object from the json module.
It is a string, and if you want to produce it from a Python dict which is what
most Python people will want to do, you can simply use the json.dumps() method
on a dict to get a string.

```python
data = {"target": "moz.com/blog", "scope": "page", "limit": 1}
data = json.dumps(data)
```

That's about it for this video. It was a great successful moment. Anything
further I do warrants a separate video.



## Categories

<ul>
<li><h4><a href='/github-copilot/'>Github Copilot</a></h4></li>
<li><h4><a href='/moz-links-api/'>MOZ Links API</a></h4></li></ul>