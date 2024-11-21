---
title: Pipulate Pipeline Born Again Now
permalink: /pipulate-pipeline-born-again/
description: 
layout: post
sort_order: 1
---

Pipulate in some form or another has been SEO software in the free and open
source software (FOSS) realm for quite some time now in one form or another,
most of them unknown and extremely niche in the industry. Nothing like my
HitTail app from the Web 2.0 days that taught bloggers how to spam effectively.
Sorry about that. But the days of the long-tail are more or less over. They're
relegated to the world of 2nd-round "RAG" lookups. That's retrieval augmented
generation for those not riding the buzzword bandwagon. And it basically just
means that when an AI can't answer something straight away from the data they've
been trained on in their base model, they'll do a 2nd-round lookup. They are
effectively prompting themselves on the rebound. In programming we used to call
it a callback function. One function executes. It executes another function
which can optionally alter the value of the first before returning it. Very
useful. 

And indeed the concept of callback functions with a fancy new name, RAG, is
indeed very big in these days of having to beef up the bare bones results coming
from increasingly slimmed-down specialized base models. For example by one
measure it's much better to train the base models on research methodologies than
to cram it full of all the research material. Why put data that has an
expiration date in the base model when you can make make the base model nearly
timeless and have all the variable data injected just-in-time by some other
system? If for no other reason than you're going to spend less money on the
electricity to run the base model. Smaller means faster and cheaper. Of course
your 2nd-round lookups, a "more traditional" search has a cost too, but now you
can swap that in and out more easily too, becoming search-service-neutral.
That's what's going on with everyone wiring it to Bing these days, because
Microsoft will sell that 2nd-round search as a service. It's not the family
jewels like it is wwith Google.

Wow, do I digress quickly when I start writing, but these are the little
subtopic explorations that put everything in context. I write tools to help do
modern data samurai investigations against whatever systems, whatever changes
and turbulence in the industry... just, whatever. And that means tooling that
connects quickly to different stuff. The tooling itself has to be what we call
lightly coupled. It has to be disconnected from one service, like a Google Web
scrape automating a browser, to another service like a bottom-feeder SERP
scraper API service harvesting Google results to repackage and sell so you don't
have to be in that arms race, to rewiring it to Bing because you can just pay
and get it all formally and above the table from them. You just don't want to
hardwire your tools to one way of doing things. But you don't want to throw away
all your work and reinvent from scratch every time either. It's one of those API
abstraction challenges. Where do you shove the complexity under the cover and
hide it so that you can deal with mostly easy code most of the time? Real
80/20-rule stuff.

Of course Python is ***the language of 80/20-rule compromise***. Pretty good at
everything, best-in-class at nothing. But even within Python, the API gets
ridiculously complex like Django configuration and the pedantic FastAPI. If
you're building a marketplace and tweaking every cpu-cycle of performance from
your servers and have Amazon investment money backing you, that's one thing. But
if you're a little ol' SEO just trying to scrape out a living with some creative
nimble tools, that's an entirely other thing, and you're going to get bogged
down to death even in Python. When shoving around the complexity, make sure it's
not all shoved in your face to have to deal with by your tools. Ah, such a big
discussion about frameworks and conventional behavior versus configuration that
I must resist. Suffice to say, I go back to Java Cocoon and Hibernate from the
late 90s with this stuff, so I've been there, done that. I know what I like and
I've got opinions. When they were calling Ruby on Rails a "joyful framework", I
was like WTF are you talking about? I had my own in VSCript in those days that
ran circles around it, that I really didn't do anything with but build private
intranets for employers. The days when VisualBasic 6 ruled the IT-consultancy
world. Late 90s.

Everything in between has basically sucked. I tried getting back onto JavaScript
on the server ***just before NodeJS came out***, haha! Talk about bad timing. It
was something called Rino. JavaScript was never not on the server. Netscape had
it in Commerce Server back in the days. Microsoft had it as the alternative
language to VBScript in ASP. JavaScript was never not there. It just didn't have
a resurgence of interest until that guy ported the optimized high performance
Google V8 JavaScript engine to a server and called it node. And then the whole
full web stack movement kicked in, bringing us to the very viable and just fine
for other people WASM build workflow.

Not for me, no thank-you, no how. I'm a tweak, save, look, tweak, save, look
sort of developer. Having that Sass build process (or whatever it is these days)
that seems to not be able to be made instant and transparent to the developer (I
wouldn't object if I didn't have to think about it) is a complete show stopper
for me. Syntactically awesome style sheets make me cringe today, no matter how
wonderful they are in practice for people who can live with that workflow.

Workflow... yeah, it's about workflow. It's the tale of ***two workflows***, not
just one. The first workflow, which the people ***making the workflows*** has to
deal with is one of development. Developing apps yes, but in the same way that
someone prepares sheet music for a player piano develops apps. You want to be
able to transition into the flow state and work like a musician. The more bells
and whistles in the tooling that jar you out of that flow state, the less
inspired the music. I have to make a sheet music writing environment that fades
into the background and just... well, lets you flow.

VSCode and all the editors derived from it, like Cursor AI and Codeium, Qodo,
Windsurf or whatever they're calling the latest darling of that forking
tug-of-war... well, they're all optional. This is about your vim keystroke
muscle memory first. I suggest vim, or nvim if you want to write your macros
with Lua. Most people are going to choose nvim (aka NeoVim) so they can feel
like a plugin pounding fuzzy searching nerdtree coding bros. Fine. Just know
that not all of us out there fit that mold. I'd probably be fine with plain old
vi from the 70s (just like me) if I didn't want a better undo and syntax color
coding. If coding is like writing or even playing music, then you're looking for
an instrument that feels like an extension of your body. And for that, you need
command-and-control keystrokes that just don't change much over the years and
decades. And that means vim in whatever form.


