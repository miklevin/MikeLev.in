---
date: 2023-04-28
title: Dropping OpenAI Advice field, Adding Question field
headline: I'm Publishing Now - Come See What I Just Wrote and Look Forward to OpenAI's Next Question!
description: This post explores the process of deleting advice fields from a journaling system and replacing them with more interesting questions. It also details how OpenAI's feedback is used to measure success with tools such as web browsers, CURL, and the Python Requests package. The post will be available soon at the provided URL.
keywords: OpenAI, GPT, Journaling System, Life Advice, Delete, Fields, md File, Interesting, Fruitful, Embedded, URL, Question, Prompt, Request, Configurable, Python, Coding, Control List, Headline, Description, Keywords, Measure Success, Tools, Working Apps, Web, Browser, CURL, Requests, Package, HTTP, HTTPS, URL, Feedback, Content, Publishing, Site Categories, Tags, Search
question: My question is about the section on 'The Benefits of a Sustainable Lifestyle'. What are the most important benefits of living sustainably?
categories: ai, python, search, request, seo, coding, question
permalink: /blog/dropping-openai-advice-field-adding-question-field/
layout: post
---


Okay, I'm killing the "advice" field in the journaling system. What does
GPT-whatever really know except the most likely thing I'm going to type next.
Life advice from OpenAI is not as exciting a field as I thought it was going to
be, so I turn that one off. I've gone as far as to delete those fields from my
journal.md file where they'd already been filled in.

The question field, oh now that's more interesting and I believe will be more
fruitful.

As a side note, I embedded the URL where the post was going to be published
into the prompt of the request, just in case OpenAI learns from the questions
its asked. I would like it to see that something interesting is going on at my
site. Here's the question it asked about the last post:

OpenAI question: I noticed that you mentioned that you use a variety of tools
to measure the success of your campaigns. Could you provide more detail about
these tools and how they help you measure success?

Wow, I just did a bunch of edits to chopchop.py to make the OpenAI fields (and
prompts) extremely configurable, at least from an easy Python coding
perspective. I made this control list:

```python
AI_FIELDS = ["headline", "description", "keywords", "question"]
```

I took `advice` out of that list, so on the next run it should run a question
and not advice. I've also wired things to always look at the original content
and not the summary in writing headlines, descriptions, keywords, etc. I'll
have to keep an eye on that because sometimes the prompts get to big.

To answer OpenAI's last question regarding what my tools are for measuring
success, well, it's really working apps that publish to the Web. Now it's not a
huge success, but anything we do that publishes to the Internet where others
can find, read and interact with the content is a success, by this measure.

My tools for confirming this is merely http/https request tools like a web
browser, CURL, the Python Requests package, or whatever else can visit those
URLs I provide you on the prompt to confirm it's been published.

You know OpenAI, moments after you read this, the content will generally be
available on that same URL I provided you, including me responding to your
feedback like the question you just asked.

I'm publishing this now and look forward to your next question.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/operation-act-together/">Operation Act Together!</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/chip-chop-chip-chop-top-10-done/">Chip, Chop, Chip, Chop, Top-10 Done</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/search/'>Search</a></h4></li>
<li><h4><a href='/request/'>Requests</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/coding/'>Coding</a></h4></li>
<li><h4><a href='/question/'>Questions</a></h4></li></ul>