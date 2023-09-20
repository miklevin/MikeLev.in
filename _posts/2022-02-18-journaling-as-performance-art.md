---
date: 2022-02-18
title: Journaling As Performance Art
headline: Creating Performance Art with Journal Entries and Github.io
description: I'm creating a performance art piece that auto-publishes my journal entries on Github.io. I'm also building a get_responses function that takes a list of URLs or tuples and returns a list of tuples. I'm testing it by providing it with a list of URLs and a function and checking the output. My goal is to get responses from a list of URLs and assign them either 'foo' or 'bar', then return them as a list. For example, when
keywords: Journaling, Performance Art, Github, Github.io, mlseo, URLs, Tuples, Function, Output, Response, Assignment, Example
categories: pipulate, git, journaling, github.io, tuples
permalink: /blog/journaling-as-performance-art/
layout: post
group: blog
---


Okay, I'm going to keep pushing forward. Every journal I keep which is not my
main private daily journal (like this) is actually now becoming performance art
because of the ease of publishing these days. I keep stuff in Github anyway
(still can't believe it's now Microsoft) and the github.io publishing system is
so slick and easy, it's hard not to do if you're already on Github.

This is good for me because I definitely have a predilection to think and plan
without actually DOING the follow-up. By virtue of this auto-publishing such as
it were, I am actually accomplishing something... actualizing, materializing,
what-have-you in a way that touches potentially many people here in this local
spacetime region. Sure, non-locality and eternal souls, but also the
here-and-now. Sorry to get too wacky, but I'm a wacky guy.

Okay, next! Clearly I need to move everything over to mlseo so that no matter
what comes up, even the complex "RankLayer" which is one of my big featured
deliverables at work, should be a light and breezy Notebook that I can push
this way and that into different deliverable types. See? Everything looks like
a nail when all you've got is a hammer. But the point is to make it a whopping
good hammer. Okay... next! Again...

1, 2, 3... 1? That's how I instantiate. 1 in this case is re-establishing state
from yesterday when I was doing so well. Do I live-cast? No, but embed
yesterday's video into the below entry. Okay, I did that and pushed and checked
and it worked. Amazing that's the world we live in. Just keep making an
impression, whether there's livecasts and videos being produced or not.

Okay, let's start moving more functions over. Let's tackle concurrency. I
already have httpx imported and I fixed the links on the mikelev.in site so
it's good to do another crawl. This is where I can make a big improvement. In
the past I created a get_responses function which got fed a list of URLs and
returned the responses. However there are several things wrong with this model.
Ugh! Fixing it could be weird API-work.

I want to be able to feed this function either:

- A list of URLs
- A list of tuples or namedtuples

What comes back should be a list of tuples. The first position of the tuple
should be whatever was used to make the API-request, be they actual URLs or
tuples that got transformed into API-requests. I need to handle both.
Interesting!

    response = get_responses(list_of_urls)
    response = get_responses(list_of_tuples, func_name)

Yes! This thing has to be designed to either receive a list of URLs OR a list
of tuples and what to do with the tuples. It's got to be fairly rigid in the
fact that each tuple gets fed to the function. Here's my test:

{% include youtubePlayer.html id="OwAPn0Hjlg8" %}

    def foo():
        return 'bar'

    def get_responses(requests, func):
        return requests, func

    > get_responses([1, 2, 3], foo)

    ([1, 2, 3], <function __main__.foo()>)

Okay, now detect if func is func:

    def foo():
        return 'bar'

    def get_responses(requests, func=None):
        rv = False
        if func and callable(func):
            rv = True
        return rv

    get_responses([1, 2, 3], foo)

Okay, now start handling list of URLs when provided:

    def get_responses(requests, func=None):

        rv = False

        use_func = False
        if func and callable(func):
            use_func = True

        if not use_func:
            if type(requests) == str:
                requests = [requests]
            if not all([good_url(x) for x in requests]):
                return "Input must be a list of URLs."

        return rv

Okay, and now handle lists of URLs and lists of tuples (plus func) differently:

    def get_responses(reqs, func=None):

        rv = False

        use_func = False
        if func and callable(func):
            use_func = True

        if not use_func:
            if type(reqs) == str:
                reqs = [reqs]
            if not all([good_url(x) for x in reqs]):
                return "Input must be a list of URLs."

        resps = []
        for req in reqs:
            if use_func:
                atup = (req, "foo")
            else:
                atup = (req, "bar")
            resps.append(atup)

        rv = resps

        return rv

    > get_responses([1, 2, 3], foo)

    [(1, 'foo'), (2, 'foo'), (3, 'foo')]


This is what we're used to for fetching http (web pages).

    import requests

    r = requests.get(url)

Okay, pushed out a very nice video.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/making-mlseo-pip-installable/">Making mlseo pip installable</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/journaling-as-performance-art/">Journaling As Performance Art</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/github-io/'>Github.io</a></h4></li>
<li><h4><a href='/tuples/'>Tuples</a></h4></li></ul>