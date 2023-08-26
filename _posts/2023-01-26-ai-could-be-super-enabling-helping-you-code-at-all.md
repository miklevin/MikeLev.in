---
date: 2023-01-26
title: AI Could be Super-Enabling, Helping You Code At All
headline: "Gaining the Superpower of Coding with AI: My Journey of Learning Python and Editing Videos"
description: As a coding novice, I used ChatGPT to learn how to code in Python and edit videos. With the help of ChatGPT, I was able to gain the superpower of coding in Python to help me with my project. I also used OpenAI API to submit JSONL data and extract data from HTML. To store the data, I chose to use a SQLite database and DNS to translate IPs. Finally, I virtualized Linux and used a RaspberryPi-based server.
keywords: AI, ChatGPT, Python, Video, Editing, OpenAI, API, JSONL, HTML, SQLite, Database, DNS, IPs, Virtualizing, Linux, RaspberryPi, Server, NAS, Coding, Logins
categories: html, coding, python, ai, database, linux
permalink: /blog/ai-could-be-super-enabling-helping-you-code-at-all/
layout: post
group: blog
---


Start working on the script for a series of edited shorts. But edit them in
Python (maybe).

You're on Windows 10 or 11 and ChatGPT has been giving you bits of Python code
that you want to get running.

You want to claim those superpowers for yourself, so tantalizingly close that
everyone else seems to get.

**ChatGPT:**

## How do I edit video in Python?

There are several libraries available in Python for editing video files, including:

1. OpenCV: This library is primarily used for computer vision tasks, but it also has a module for video editing. You can use it to read and write video files, extract frames, and perform basic editing operations such as resizing and cropping.
1. MoviePy: This library provides a simple and easy-to-use interface for video editing. It allows you to manipulate video files using a series of functions, such as concatenating, resizing, and cutting.
1. ffmpeg-python: This is a Python wrapper for the FFmpeg library, which is a powerful tool for working with audio and video files. You can use it to perform advanced editing operations, such as merging audio and video tracks, adding effects, and more.
1. Pydub: This library provides a simple and easy-to-use interface for working with audio files, such as mp3, wav etc.

Example:

```python
import moviepy.editor as mp

clip = mp.VideoFileClip("input_video.mp4")
clip_resized = clip.resize(height=360)
clip_resized.write_videofile("output_video.mp4")
```

If I make a series of "microclips", can I arrange them in Python? The topics of
the short videos would be greatly about this. Okay, ChatGPT and things like it
are going to be able to do your coding for you. But that's FOR YOU.

Carry this project out in public in various ways:

- Reddit
- Twitter

And when you do the projects with Reddit and YouTube, also do API integrations
and teach people how. I did part of that yesterday with getting my Tweets, or
at least 1/4th of them. I have to revisit that project to get ALL my tweets. I
have not been able to prompt GhatGPT into the correct answer for that. Let's
capture a quick pass at Reddit integration:

To ChatGPT:

## How do I list all the subreddits on Reddit using Python?

You can use the praw library in Python to interact with the Reddit API and
retrieve a list of all subreddits. Here is an example of how you can use it to
list all the subreddits:

```python
import praw

reddit = praw.Reddit(client_id='YOUR_CLIENT_ID',
                     client_secret='YOUR_CLIENT_SECRET',
                     user_agent='YOUR_USER_AGENT')

subreddits = reddit.subreddit('all')

for subreddit in subreddits.hot(limit=None):
    print(subreddit.display_name)
```

In this example, we first create a praw.Reddit object by passing in the
necessary authentication details. Then we use the subreddit() method to get a
handle on the all subreddit. Finally, we use a for loop to iterate through the
hot posts of the all subreddit and print out the display_name of each
subreddit.

Note: you need to replace 'YOUR_CLIENT_ID','YOUR_CLIENT_SECRET',
'YOUR_USER_AGENT' with the actual values provided by reddit after you register
an app on reddit developer portal.

---

Ask ChatGPT:

## Give me three example sentences, one each using "the time is right", "the time is ripe" and "the time is rife". Explain the difference between each use.

1. "The time is right for us to launch our new product." - This sentence means
  that the current circumstances or conditions are favorable or appropriate for
  the launch of the new product.

1. "The time is ripe for a change in leadership." - This sentence means that
  the current circumstances or conditions are favorable or appropriate for a
  change in leadership and it is the opportune moment to do so.

1. "The time is rife with uncertainty and anxiety." - This sentence means that
  the current circumstances or conditions are characterized by a high degree of
  uncertainty and anxiety.

The difference between the three phrases is the tone they convey. The first
phrase "The time is right" is generally positive and suggests that conditions
are favorable. The second phrase "The time is ripe" again is positive but it
also suggests that the time is opportune. The third phrase "The time is rife"
is negative and suggests that conditions are unfavorable or difficult. The word
"rife" is used to convey that there is a lot of something, in this case, it is
a lot of uncertainty and anxiety.

---

Wow, even if things like ChatGPT merely become your teacher and your tutor.
Bullshit or not, ChatGPT can put things together nicely. Now use what I
learned. This is kind of like formulating my hypothesis.

- The time is right for a Free and Open Source SEO product.
- The time is ripe for big changes in the field of SEO.
- The time is rife with bad advice on how to proceed.

---

I am also training OpenAI to return ideal completions based on my provided
content rather than the stuff they crawled up to 2021. In doing so I'm asking
ChatGPT how to do so, so I ask ChatGPT:

## Show me an example of submitting JSONL to the OpenAI API using website content for the completion value.

Here is an example of how to submit JSONL to the OpenAI API using website content for the completion value in Python:

```python
import requests

# Your OpenAI API key
api_key = "YOUR_API_KEY"

# The URL of the website you want to use for the completion value
url = "https://en.wikipedia.org/wiki/Artificial_intelligence"

# Make a GET request to the website to retrieve its content
response = requests.get(url)

# Get the website's content as a string
website_content = response.text

# The prompt you want to complete
prompt = "Artificial intelligence is the simulation of human intelligence in machines that are programmed to think and learn. It is also referred to as machine intelligence. AI is a branch of computer science that deals with the creation of intelligent machines that can think and learn like humans. Some of the key areas of research in AI include natural language processing, machine learning, and computer vision."

# JSONL data to send to the API
data = [{
    "prompt": prompt,
    "completions": [website_content],
    "model": "text-davinci-002"
}]

# Make a POST request to the API
response = requests.post("https://api.openai.com/v1/engines/davinci/completions", json=data, headers={
    "Content-Type": "application/json",
    "Authorization": f"Bearer {api_key}"
})

# Print the API's response
print(response.json())
```

This example uses the requests library to make a GET request to a website to
retrieve its content, and then uses that content as the completion value for
the API. It also uses the "text-davinci-002" model and pass the API key as
headers in the request.

It is important to note that the above example uses the v1 version of the API,
which is deprecated and not recommended for use. If you want to use the OpenAI
API, please use the v2 version of the API which can be found in the
documentation.

---

This is somewhat surprising to me as all the documentation I've read so far
talks about JSONL files or CSV. Now while technically there's something there
equivalent to a 1-line JSONL file, it never gets saved to a text file so many
encoding issues are side-stepped. The submit occurs directly to OpenAI as an
Python-encoded HTML string sidestepping may text-encoding and even
text-extraction issues. There is no need to extract text?

Ask ChatGPT again:

## Show me an example of submitting multiple prompts and completions to the OpenAI API using the URLs and their content as the content for the completion value.

Here is an example of using the requests library in Python to submit multiple
prompts and completions to the OpenAI API using URLs as the content for the
completion value:

```python
import json
import requests

# Set API key
api_key = "YOUR_API_KEY"

# Define list of prompts and completion URLs
prompts = ["What is the capital of France?", "Who is the President of the United States?"]
completion_urls = ["https://en.wikipedia.org/wiki/Paris", "https://en.wikipedia.org/wiki/Joe_Biden"]

# Define API endpoint
api_endpoint = "https://api.openai.com/v1/engines/davinci-codex/completions"

# Iterate through prompts and completion URLs
for i in range(len(prompts)):
    prompt = prompts[i]
    completion_url = completion_urls[i]
    # Get content of completion URL
    completion_content = requests.get(completion_url).text
    # Define payload
    payload = {
        "prompt": prompt,
        "completions": 1,
        "temperature": 0.5,
        "stop": ".",
        "url": completion_url,
        "content": completion_content
    }
    # Make API request
    headers = {"Content-Type": "application/json", "Authorization": f"Bearer {api_key}"}
    response = requests.post(api_endpoint, json=payload, headers=headers)
    # Print response
    print(json.dumps(response.json(), indent=4))
```

Note: You will need to replace YOUR_API_KEY with your own API key to be able to
make requests to the API.

## What do temperature and stop stand for in this example?

In this example, the temperature and stop parameters are used to control the
behavior of the API's response generation.

temperature is a value between 0 and 1 that controls the randomness or
"creativity" of the response. A lower temperature (e.g. 0.1) will result in a
response that is closer to the model's most likely prediction, while a higher
temperature (e.g. 0.9) will result in a more creative and varied response.

stop is a string that tells the API when to stop generating text. This can be
used to prevent the API from generating an overly long response. In this
example, the stop parameter is set to ".", meaning that the API will stop
generating text when it encounters a period. This will ensure that the API only
generates one sentence in response to the prompt.

Fast forward hours. I couldn't get any of that above ChatGPT-provided code to
work. That it a disappointment because it indicated you could fine-tune OpenAI
with unprocessed HTML. It appeared that you could pass HTML in as part of a
single-line JSONL request to the API. I had hopes for that. What am I here even
caring? But once again I load Caffeine64.exe and connecting the power-cord so I
can run extractions against a few hundred tempchunks of parquet.

And it's no big. Big-ish data on a pretty small and modest Windows laptop, if
you know how to break a job up to about the right size across files. I chose
around 130MB chunks, after the sqlite files were turned into parquet files that
average about 40MB. Parquet is definitely more compressed than SQL, but the API
is different. There's no create, (show) record, update, delete API to a parquet
file the way there is to a sqlite file. But even then, it's multiple files
you're iterating over.

Okay, so I'm going to be running that multi-gigabyte database making extraction
in the background while I'm over on this other screen typing. I broadcast a few
videos lately and I used those subscribe alpha transparency letters around my
head. I don't think I like it. Also my big green logo's on the desktop now. I
think I need to soften it a bit. Not quite so punch-in-the-nose.

The concept of chunking a job, distributing it out, and gathering the results
to do something with them again is useful in distributed computing and to just
to process a large job on a small machine by breaking it into chunks. A lot of
data can be processed that way. I'm sure there's a word for it. But you can get
through the work of a list sequentially without many inter-dependencies, and so
chunking the work is permissible.

So a big job you'll regularly leave running overnight. You own the computing
equipment to do it, and you'll get your answers just the same as running the
job on the cloud. When you're done, you can throw away all but the essential
findings. Sometimes you keep source. But always you start with a raw data
capture of whatever comes back from the API-call. Even if still chunked, sore
it to drive. Better yet, store it to a SQLite database with your API-call
details as the dict key and the whole Python response object as the value.

When a Python dictionary becomes persistent, you've got an all-purpose, general
purpose dictionary database. It's great for using URLs as keys, so it's a
natural fit for SEO. Isn't that all the whole Internet is in a way? A giant
keyed database. Paths are unique identifiers. Protocol specifiers are also part
of the address, so you can tell an ftp from an http request. But those long
URLs are keys to the database that is The Internet.

So, DNS. DNS is one whopping with-us-for-awhile reality. No matter how much the
Internet evolves, there's still got to be a way to translate from IPs to words.
So long as using words continues to play a role in word of mouth. Hard to
imagine something becoming popular without being able to Google such and such.
But who knows in this age of AIs. Maybe DNS is a wasted layer. Just give me IPs
say the AIs, perhaps.

So we sit at home while the AIs surf the Internet. What are humans going to do?
Oh yeah, learn to code better anyway. It's not like AIs are running the show...
yet. Until they're walking around in robots, they still need us humans to copy
and paste their code intelligently between systems. The humans have to deal
with things requiring API login. You're not giving ChatGPT your Google login,
are you?

So you have to copy/paste the code, perhaps into a Linux instance of JupyterLab
running on your Windows desktop. That puts you a hair's width from 24x7 Linux
cloud server or home NAS or RaspberryPi automation. I heard about those Mac
Mini's today on YouTube and they're tempting. But they're not Linux. I could
use them as a proprietary host for VMs, but what's the point?

Sooner or later you're going to be virtualised Linux. It's best I think to have
fewest layers. So you run something that gives you Kubernetes Jr like abilities
at home with a NAS system, or right on the raw metal with a RaspberryPi-based
server. We're not going for power here. We're just going for getting it off of
your laptop. You want a place to fling done things from Jupyter.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/ai-could-be-super-enabling-helping-you-code-at-all/">AI Could be Super-Enabling, Helping You Code At All</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/chatgpt-helped-python-tweepy-my-tweets-onto-my-website/">ChatGPT Helped Python Tweepy my Tweets Onto My Website</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/coding/'>Coding</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>