---
date: 2023-05-02
title: Recapturing That Old Force of Nature Feeling
headline: Using AI to Get Back That Old Force of Nature Feeling From When I Was Younger
description: I'm trying to recapture the old feeling of being a Force of Nature I had when younger by harnessing the power of AI-assisted coding. Learn the tricks of using Python and MermaidJS diagrams. Get to the next level with story-telling on your Powerpoint-like decks for MOZ.
keywords: force of nature, info-tech, AI-assisted coding, Python, rsplit, token limit, text-davinci-003 engine, while loop, for loop, Microsoft Office suite, Google Slides, md2googleslides, NodeJS, npm, proprietary, open-source, open-data, open-everything, open-minded, Powerpoint-like concepts, markdown, 80/20-rule, copy/paste, hand-drawn images, Note
categories: google, open-source, javascript, 80/20-rule, proprietary, copy/paste, python
permalink: /blog/recapturing-that-old-force-of-nature-feeling/
layout: post
---


The trick is to become here much like a force of nature. I can do great and
wonderful things when it comes to info-tech, shoving the bits around. However,
I'm no speed demon. No, let me restate that. I'm slow as molasses. I am the
poster child for the developer-sweetspot aided by AI-assisted coding. The
perpetual newb, I am. On my last project, it would have taken me ages to figure
out how to use rsplit to trim down the prompt input to get under that 4097
token limit that the text-davinci-003 engine has. But I described what I was
trying to do, and this more or less spit out:

```python
if required_tokens > 4097:
    while required_tokens > chop_at:
        prompt = prompt.rsplit(" ", 1)[0]
        required_tokens = num_tokens_from_string(prompt, "cl100k_base")
```

I mean how awesome is that? Not only awesome, but Pythonic! How often do you
find a legit use for the `while` loop? I mean, don't you keep away from it
because of infinite loops? I do, but when you know you're dealing with a finite
set (you know it's going to get below 4097 tokens eventually), then it's
perfectly fine to use. And it's so much more elegant than a `for` loop.

Okay, I did think `while` was the right way to go and did start typing it. In
fact, I typed the whole first 2 lines of those 4 lines. And even on the fourth,
I had to add the encoding parameter. But the knowledge to use `rsplit` like
that made the $100/year Copilot investment worth it.

These are the fans I need to flame to help me get to the next level. With
ideating here in the journal, I've got it covered. With coding in Python, I've
got it covered. What's left? Well, Powerpoint-like stuff, of course!

But MOZ isn't a Powerpoint shop, and I'm keeping away from most of the
Microsoft Office suite as much as I can these days, AI-assisted as it may be.
It's just not my vibe. Proprietary on top of proprietary. Google Slides is
where it's at. What's that you say? That's proprietary too? Oh shoot! What's a
multidisciplinary, open-source, open-data, open-everything, open-minded guy to
do? Well, I did find md2googleslides, but it's an npm NodeJS package and even
though I have Node v16.19.1 installed (a fairly recent version), I had errors
on the install. It's a classic case of choosing the least-bad of multiple
evils.

What I really ache to do is deal with the Powerpoint-deck-like concepts in
markdown and transform it at least into a 1st pass. But why? Isn't that in
itself a violation of the 80/20-rule? Why not just think it through here in
markdown in your journal and manually copy/paste it over into a well-prepared
template? And then just sprinkle in hand-drawn images, probably done on my old
Note 8 in a way where I can use a png-like transparent background and colors
that will have enough contrast against either a black or white background.

I'd like to avoid even drawing pictures if I can. MermaidJS is working. Use
that whenever you can. Re-assert your ability to do so. Refresh myself. Okay, I
can't use that triple backtick fenced codeblock system built into markdown for
mermaid because I'm no longer using the Jekyll plug-in. Instead I'm relying on
a JavaScript include file, which is fine. But instead of backticks, I need a
container div with the class set to `mermaid`. Not bad.

<div class="mermaid">
flowchart TD
    A[Hard edge] -->|Link text| B(Round edge)
    B --> C{Decision}
    C -->|One| D[Result one]
    C -->|Two| E[Result two]
</div>

That's the mermaid diagram code that Copilot suggested, haha! This is certainly
part of my ***operation force of nature*** initiative. That's why I spent so
much time in the past identifying MermaidJS and looking at my options to render
it. If I were to go back to the Jekyll plugin, what would go into my
`_config.yml`? This page is useful in that regard:
[https://just-the-docs.github.io/just-the-docs/docs/ui-components/code/](just-the-docs.github.io)

Ulch! Yuck! Tons of ambiguity. 3 different ways to do the markdown even once
installed:

- Markdown-style triple backtick fenced codeblock (most desirable)
- HTML-style `<div class="mermaid">` container (most reliable)
- Liquid template-style curly-bracket style (most annoying)

Well, 80-20 rule again. Div's are such a pervasive fact of life in HTML that
they're not the most objectionable thing, and it certainly lowers the
dependencies. I can use any include. Only issue is that the mermaid javascript
include is going to be loaded on every page of my site, mermaid diagram or not,
but that's the least of multiple evils (for now). There are lots of
future-directions I'd like to go with this, such as converting mermaid diagrams
to SVG for the best of all worlds (device independence, accessibility, etc.),
but there be rabbit holes (at the moment).

Okay, continuing on with the force of nature... no, I'm getting distracted!
It's about the Powerpoint-like decks. Don't lose focus. But the mermaid
diagrams are definitely part of that. I have to do a lot of that type of
illustration.  

So the answer is to just do what you do. Type things in markdown here. If ever
it's stuff you don't want to publish to the web (always disappointing or
anticlimactic), I can always just bop over to the private journal or just keep
it here unpublished (no title field).

Story-telling. You've got to tell stories.

And most of those stories can in fact be public ones.

The stuff that gets into forward-thinking and potentially proprietary stuff is
when we take what I mock-up with MOZ Pro and the Links API and scale it up
x1000 and such. But big secret, woo hoo. Do exactly the same thing but with
more keywords, more domains, more industries, etc.

Okay, running out of steam. Use the last of the sunlight to go grab some
groceries. Be back soon, renewed, refreshed and able to do more with less.
















<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/openai-error-invalidrequesterror-this-model-s-maximum-context-length-is-4097-tokens/">openai.error.InvalidRequestError: This model's maximum context length is 4097 tokens</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/rappelling-down-the-rabbit-hole-x-marks-the-spot/">Rappelling Down the Rabbit Hole, X-Marks The Spot</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/open-source/'>Open-Source</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li>
<li><h4><a href='/80-20-rule/'>80/20-rule</a></h4></li>
<li><h4><a href='/proprietary/'>Proprietary</a></h4></li>
<li><h4><a href='/copy-paste/'>Copy/Paste</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>