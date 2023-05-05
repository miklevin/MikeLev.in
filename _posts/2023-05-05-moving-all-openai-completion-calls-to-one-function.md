---
date: 2023-05-05
title: Moving All OpenAI Completion Calls to One Function
headline: Committing Changes to Streamline OpenAI Completion Calls in chop.py
description: This post outlines the process of moving all OpenAI Completion calls to one function for the chop.py to-do list. It explains the reasoning behind the decision, the 80/20-rule solution, and the resulting changes. The author has completed the changes and is now ready to test the results.
keywords: OpenAI, Completion, Function, Jekyll, Rendering, Drafts, Publishing, Journal, Tool-divergence, Dilute, Focus, To-do List, Retooling, AI, Vimmers, ODB, Chunking, Summarizing, Prompts, Character Limit, 80/20-Rule, Compromise, Variations, Implementations, Commit
categories: focus, ai, publishing, jekyll, 80/20-rule, openai
permalink: /blog/moving-all-openai-completion-calls-to-one-function/
layout: post
---


Okay, it's time to clean chop.py even more. The work today to make drafts a
real thing with Jekyll rendering but without publishing was a big step forward.
It's going to make me feel good about writing more and leveraging the most out
of this system without having to publish everything, nor it getting lost in the
trash heap of old drafts. It keeps it in draft but makes it come alive. It's
such a wonderful example of using the journal to improve the journal. Now I can
tackle problems that compels to tool-divergence and dilute focus.

I've never slammed my way so fast through a to-do list. It actually added some
startup cost to other projects I'm working on, but this is often the way with
retooling. If we never had to retool, we would get continually better at the
work we're using the tools for and that's the future I'm planning on. Things
are about to change big-time with AI and everyone's tools are about to change.
We vimmers are in a special place.

Next up on the chop.py todo list is getting rid of all the separate functions
that call `openai.Completion.create()`. In fact, they all go through `odb()`
which takes these functions as parameters and calls a function with the name of
the parameter instead. That was a bit of a hack in the first place because the
functions had to vary in their behavior. If the prompts were too big, I was
chunking them in the past, getting summarizes and using the summarized version
in subsequent prompts, but no more.

The posts are actually all close enough to that 4097 character limit that I can
just chop it down to size and not worry about it. Much better 80/20-rule
solution, and having done that I can get rid of this old compromise. It
actually eliminates a bunch of functions from the code, but at the cost of
adding a prompt dictionary. Or perhaps one prompt function, because there's
still the need to blend the post content with other text to make the different
prompt variations. Make sure you're moving towards a simpler and better
implementation, not just the different prompt variations. Make sure you're
moving towards a simpler and better implementation, not just the different one.

Wow, okay just made all the changes. Did a test run without asking for any
OpenAI completions and it worked. I'm going to commit this and then do a test
run with OpenAI completions.

Okay, I had a few tweaks to make to strip out the exec's and eval's that were
necessary for the last approach, but here's a post with OpenAI completions for
headline, meta description and keywords. And the code that made it is cleaner
and shorter. And that concludes the last code cleanup for chop.py. The rest is
stuff like pinning posts, blending in the YouTube videos and discrete
sub-sequences with their own prev/next arrows.

Having made the separate set of pages for drafts just recently, that perhaps
opens the door for a separate pass that makes the sequences with different
actual sets of pages so that they don't have 2 sets of arrows on them. I can
also canonicalize the URLs to one version or the other. I hate to plan any
features that would call for duplicate content, but the user experience of
discrete sequences with very logical and flowing prev/next order is too
compelling to pass up. 

In a way, it's the culmination of the system in as how it allows that
"trickling up" of good content effect. Giving things a logical home in a
sequence of pages besides the order I just happened to write them is... well,
it's greatly the point. Vision and revision. Brainstorming to order. Non-linear
thinking to linear thinking. Making it accessible to others.


















<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&nbsp;</span></div> &nbsp; <div class="post-nav-next"><a href="/blog/rendering-un-styled-jekyll-markdown-drafts-for-pasting-into-google-docs">Rendering Un-Styled Jekyll Markdown Drafts for Pasting Into Google Docs</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/focus/'>Focus</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/publishing/'>Publishing</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/80-20-rule/'>80/20-Rule</a></h4></li>
<li><h4><a href='/openai/'>OpenAI</a></h4></li></ul>