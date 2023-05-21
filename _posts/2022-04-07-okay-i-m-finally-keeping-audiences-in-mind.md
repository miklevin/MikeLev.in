---
date: 2022-04-07
title: Okay, I'm Finally Keeping Audiences In Mind
headline: "Exploring the Rabbit Hole: My Journey to Releasing My Project"
description: I'm creating journal entries for an audience, with the help of WhatsaMetaFor.io and the mlseo package. I'm using metaphors such as the 80/20 rule and rabbit hole evaluations to stay focused and productive. I recently took a risk and explored the nbdev rabbit hole, which led me to create a Github repository and a script to prepare my project for release. Join me on my journey and read my blog post to learn more!
keywords: Audience, WhatsaMetaFor.io, mlseo, 80/20 rule, Rabbit Hole Evaluations, nbdev, Github, Repository, Script, JupyterLab, Standalone, Issues, Documentation
categories: nbdev, git, pipulate, jupyter, audience, python
permalink: /blog/okay-i-m-finally-keeping-audiences-in-mind/
layout: post
---


Solve things in the order and way they need to be solved. Don't over-complicate
things. Make a journal entry that's appropriate for public consumption on these
very issues. Yes! The vision is that every day at least one of my journal
entries is made with a public audience in mind and the publication thereof is
really just copy/pasting between vim buffers and doing a few git commits and
pushes. THIS is the process I should start with. Pick a site, any site...

- WhatsaMetaFor.io
- guerillatech.com
- levinux.com
- linuxpythonvimgit.com
- lundervand.com
- mike-levin.com
- mikeateleven.com
- mikelev.in
- mikelevinseo.com
- pipulate.com
- pythonically.com
- pythonically.org
- removablefinger.com
- tardigradecircus.com
- tictacufosightings.com

I'm not sure about that WhatsaMetaFor.io site. It's one of those fancy
top-level domains that they can easily hike the price on you every year.
Nonetheless, it may be the perfect one for these types of "meta" entries.
What's a meta for? Well, it's for self-awareness, reflection and entering a
more deliberate "human" and less "animal" state.

Okay, so WhatsaMetaFor.io is for open-ended rambling like this... free
association from which all the meta-observations that make all the difference
arise. It's too bad that Facebook latched onto the concept of meta and ruined
its real meaning for the rest of the world. No worries. The ties to the field
of SEO with "meta" tags is still enough for the cleverness of this site name to
remain relevant. Add to that the actual metaphors I'll be writing about on this
site and it's very appropriate.

- What's a Meta For?
- What's a Metaphor?

The same thing; to help you think better. In the former, there is
self-reflective, self-descriptive, self-aware (what have you) "extra" data
layered into a system. I the case of SEO it's invisible meta tags in the head
element of an HTML file. In the case of human consciousness, it's I think
therefore I am. That's the first meta. Both are about self-awareness.

A metaphor is a story, situation or image where things stand for something else
so that the same ideas, principles or insights can be carried over to the new
thing. New ideas are difficult. They are inaccessible because of quite how much
is new when tackling a new topic. Metaphors create the bridge between older,
familiar ideas and the new. For example the field of SEO is full of metaphors
regarding link juice and the distribution of liquid authority as it flows from
link to link.

That's all well-and-good, but what about the here-and-now? I'm doing this
writing so that I can struggle my way to the next and the next and the next
steps. So most everything now is about the pip-installable mlseo package. It is
once again my own personal grab-bag of secret weapons and continuation of
making myself relevant in the now. Pipulate and Levinux are nice but old and
hard to update to the new world. Maybe keep them around for posterity, but all
new effort goes into mlseo. Probably one day I'll just make Pipulate and alias
to mlseo. Okay, so next step? 1, 2, 3... 1?

Nothing improves until you can solve your nbdev problem in which the
documentation is not really built well with nbdev_build_docs because its
default behavior is to convert every .ipynb file... wait, is this still
appropriate for this site? Forge ahead and copy/paste the parts that are
appropriate for each site into the appropriate site. Don't be artificially
limited based on your perception of some unlikely theoretical audience. You are
doing this writing primarily for yourself and primarily in your "normal"
everyday personal journal.

Okay, so that nbdev problem. Get into these things deeper. Use the metaphors.
You're on that site, dammit. Okay, so let's talk about:

- The 80/20-Rule
- Rabbit Hole Evaluations

Gotta get work done. Can't get overly-distracted by the wrong things. But it's
okay to get a little distracted by the right things. So how can you know the
difference? You stand over the edge of the rabbit hole and peer in. You may in
fact tie yourself to a tree with a rope and lower yourself down over the edge
to get a better look around. But don't start falling like Alice or you may
never come back up and out in time to finish and deliver the original work.

The Catch+22 is that your very career and abilities move forward based on
occasionally chasing the correct rabbit down the correct hole, and you just
have to get a feel for which is which, or maybe be lucky enough consecutive
times to be on a great path. Usually it requires a very deliberate, very
meta-like process to pull off rabbit-hole navigation. They most often act as
show-stoppers, pitfalls, red-herrings or what-have-you.

And so here, nbdev itself is a rabbit hole. It reinforces my decision that
JupyterLab standalone is a good idea. However there's these little gotcha's
that show me nbdev is still bleeding edge. When incorporating an async function
into 00_core.ipynb, I bleed. Do I even engage the github community? Okay, sure
why not. It could help me think through it. Focus and put something out there.
Let's do it in an existing open issue.

Corner this issue. Document it well. Get it out there on github without
creating a duplicate issue. Include barebones-to-reproduce screenshots. Ugh, to
do this in a new folder I have to initialize it as an nbdev project. Do it but
just borrow the already vetted settings.ini from another folder and make
changes to it.

Okay, nbdev_new doesn't work unless it's already a git repo. Github too? Find
out...okay, git init wasn't enough. It needs a remote.origin.url, which in
itself is an issue. It shows me that nbdev isn't really an offline tool from
scratch. You need Internet at least enough to get such a new repo in github. Do
it! Okay, so...

    Made new public repo in Github called miklevin/issues
    git branch -M main
    git remote add origin git@github.com:miklevin/issues.git

Didn't even push yet.

    nbdev_new

Success! Try nbdev_build_docs right off the bat... Okay, done. It is at
[Github]https://github.com/fastai/nbdev/issues/327 which is really amazing for
me. I usually just suffer with such things waiting for them to work themselves
out, but I can play an active role really cornering them into seeing the
problem with good documentation and screenshots. Whoop!

Okay, next? Come up with an 80/20-rule workaround. Honestly, I'm really only in
it for the README.md that it creates from the index.html and a series of other
notebooks that I will very deliberately be adding, starting yesterday with
google_analytics.ipynb

Wow, alright. That was pretty extreme. I actually made a new repo in Github and
updated the README.md to link-to and document the open nbdev case that I chimed
in on. Hopefully I got the right one.

Okay, back to 80/20-rule solutions. As much as I hate it, I need my own make
process. I'll probably just start with a unix script. I see no reason for
anything more fancy.

Think! vim release.sh... shouldn't be too hard! No, I need a prerelease.sh
because I don't really want to be pushing to pypy all the time. In fact, maybe
it should be prepare.sh because I'll still want to manually make pypi. Yes!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/journaling-as-performance-art/">Journaling As Performance Art</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/okay-i-m-finally-keeping-audiences-in-mind/">Okay, I'm Finally Keeping Audiences In Mind</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/audience/'>Audience</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>