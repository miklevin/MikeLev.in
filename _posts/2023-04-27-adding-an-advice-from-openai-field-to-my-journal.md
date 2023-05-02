---
date: 2023-04-27
title: Adding an Advice From OpenAI Field to my Journal
permalink: /blog/adding-an-advice-from-openai-field-to-my-journal/
headline: "Exploring the Value of OpenAI: My Journey as a Cyborg with AI-Assisted Thought Processes"
description: I'm a cyborg who is exploring the value of OpenAI, utilizing AI-assisted thought processes and hotkeys to turn the AI on and off. I'm testing a function to give advice from the OpenAI API and am using it to summarize blog posts into meta descriptions, headlines, and keywords, as well as suggest life improvements.
keywords: Cyborg, AI, Hotkeys, Laptop Keyboard, OpenAI, Summarizing, Meta Descriptions, Headlines, Keywords, Life Improvements, Function, Advice, API, Testing
categories: api, ai, keywords, openai
layout: post
---

I lost time lately on turning myself into a cyborg. My thought process is
AI-assisted now by default. Yes, I keep Copilot on by default again now in
journaling, but I have a F6 hotkey that will turn it off and an F7 hotkey that
will turn it back on. F6 on my laptop keyboard is "dimmer" and F7 is
"brighter", haha! I thought that appropriate.

Okay, given that OpenAI is now a co-author on my journal, I'm going to have to
explore what more value I can get from it than just summarizing the posts into
meta descriptions, headlines and keywords. I should have it read each blog post
with a thoughtful eye and suggest life improvements. I must design a new prompt
and have the response added to the YAML front matter of the post just like with
descriptions, headlines and keywords.

You are my work advisor and life-coach. Read what I have written in the context
of everything else at https://mikelev.in/blog/ and tell me what I should do
next. My goal is financial independence and achieving my ikigai.

A question is whether I should have it read as much as it can directly from the
blog post, but not the whole thing because I don't want to pay for that much
token usage again, or whether it can do a sufficient job reading the already
rolled-up summaries? I think I'll start with the summaries and see how it goes.

I'm going to have to start a new journal post for this, because when I add a
new field to the YAML front matter, I don't want it reprocessing everything
retroactively. Okay, I wrote this function:

```python
@retry(Exception, delay=1, backoff=2, max_delay=60)
def give_advice(data):
    """Write a meta description for a post."""


    response = openai.Completion.create(
        engine=ENGINE,
        prompt=(
            f"You are my work advisor and life-coach. "
            "Read what I have written in the context of everything else at "
            "https://mikelev.in/blog/ "
            "and tell me what I should do next:\n{data}\n\n"
            "My goal is financial independence and achieving my ikigai. "
            "\nAdvice:\n\n"
        ),
        temperature=0.5,
        max_tokens=100,
        n=1,
        stop=None,
    )
    advice = response.choices[0].text.strip()
    return advice
```

It will be interesting this being the first post for which I'm asking OpenAI
API (GPT-4, presumably) to give me advice with an automated script. I have done
it through the chat.openai.com site before, but this is life-integration now.
  
My existing code should create the new advice.db if it doesn't exist (which it
doesn't) on the first run. Let's test...


## Categories

<ul>
<li><h4><a href='/api/'>API</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/keywords/'>Keywords</a></h4></li>
<li><h4><a href='/openai/'>OpenAI</a></h4></li></ul>