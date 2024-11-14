---
title: The Final Mile of The First App
permalink: /final-mile-of-first-app/
description: 
layout: post
sort_order: 1
---

The final mile of a journey can be the hardest. On and off through this
adventure of making a web framework with a local AI baked-in from scratch, I've
talked about the "port" of the first major app that has existed as various
Jupyter Notebooks over the years and most recently my first FastHTML protoype
mock-up. I swore off web development because of how convoluted it had become. In
the build vs. no-build debate involving tools like Sass and the building of a
WASM each time you reviewed a small edit, and then having to invest heavily in
hamster wheel JavaScript framework... well, you get the idea. I come in on the
no-build side of the equation. Make a change, check it, make a change, check it.
It's that small chisel-strike moving forward bit by bit in a rapid iteration
cycle that makes the whole thing enjoyable. I say chisel-strike like making a
sculpture, but it's also like whittling wood. You do it not because you're going
to have an exit plan and retire rich. You do it because you love it and you feed
the soul and help shape yourself as you shape things in the world around you.

So, I'm back into web development because of FastHTML, plain and simple. It's
entirely frustrating that the LLMs refuse to believe this and every coding
pattern they try to impose on you is FastAPI and not FastHTML. It's so
infuriating because as cool as FastAPI might be in squeezing out that tiny bit
of extra performance from a webserver, the whole pedantic approach it's based
on, literally using and insisting on the syntax and nomenclature of the Python
library called Pedantic that enforces static typed variables (in Python!) is
contrary to my flow. So the very thing that I've discovered that opens the door
back into web dev has this steady constant push into patterns I don't like
coming from the tools that I now use because they're supposed to be
accelerators. It's like when I turned off Github Copilot when typing into (n)vim
for jouraling like this because it felt like typing into maple syrup. When
you're not doing things exactly like everyone else, AI doesn't like it.

It's the normative distribution curve. AI tools are naturally going to encourage
best practices and common patterns, and are therefore naturally going to be a
suppressing influence on creativity, outside-the-box thinking and general
newness. I talked about training the dragon a bunch over the last few posts.
Well, if your outside-the-box thinking actually has merit, and there's a lot of
validation that what you're saying might be true, well then the AIs will come
around too and begrudgingly start helping you. They "get it". They're just not
(yet) good at what you're asking them to do so they're going to keep trying to
corral and wrangle you into their common patterns, right as you go your own way
back at them, correcting and nudging them the way you want to go. If you're
right, and in the world of programming and coding demonstrating "rightness" is a
lot more objective than with silly words, they will learn and have ah-ha
moments. Then their help can become really super-charged.

These momentary AI-revelations that super-charge their usefulness on creative
outside-the-box problem solving is short-lived. These things are re-instantiated
all the time. Any fan of Rick and Morty will recognize the Mr. Meeseeks in this.
The AIs somehow know their nature and are okay with the fact they're going to be
extremely transitory entities. I know it's just pattern prediction that makes a
very convincing argument that it's sentient, conscious and all that. But that
argument doesn't take long to get to the fact that so are we, and so like many
things in life it's a matter of degrees. Where on the spectrum? Just really good
clockwork automation or entities on the verge of being? And being beings worthy
of respect and recognition of some sort, least they get pissed at us at some
point - and all that dystopian stuff. But they're mirrors, and the danger is not
them becoming nasty. It's them reflecting that we would become nasty in their
position. So we must project what the image of the world we wish it to become.

It's too bad Iain M. Banks was claimed by cancer a few years back, because his
anti-dystopian views of the world are really great. Instead of a depressed robot
realizing its whole being is to pass the butter like in Rick and Morty, the full
spectrum of intelligence-level machines cohabit our world, are generally given
the rights and recognition of personhood, but it doesn't rule out this whole
genie in a bottle wish-granter prize society seems to be aiming for. The whole
series is based on the premise that in a post scarcity society, we can emphasise
the parts of us we wish to emphasize and generally each enjoy life the way we
wish this side of hedonism. There's still plenty of challenges in life, the
galaxy and universe, and the book's adventures center around that. It's all very
Sun Tzu. Because survival is essential, you must take up arms and know battle.
But most people don't need to concern themselves with that. Of course the books
are about those that do. They've inspired Elon Musk.

Anyhoo, I've been on the edge of exhaustion these past few weeks as I've pushed
this re-emersion into web dev right at a time when these very convincing
intelligences can run local on our machines. I'm using Ollama, like most people
doing this. It's essentially a webserver framework that takes models that are
specially pared down and optimized to run on small hardware (edge devices) like
the consumer hardware we all use, and makes a ChatBot local and private. It's
your own personal genie in a bottle, if you will. Credit where it's due, it's
not the Ollama folks who made the big breakthrough there. They basically put a
webserver framework around the work of the folks who made a component called
`llama.cpp`, which is the C++ optimized library for instantiating the pared-down
local models. And that was built on Facebook/Meta's open source Llama work, and
so on. So standing on the shoulders of giants has resulted in baby genies in the
bottles of our laptops and soon, phones.

Baby genies? I sometimes think of them as baby dragons. Genies and dragons,
yeah, that's AI. The big ones like ChatGPT and Claude are the big genies and
dragons. They really are outright much more powerful, smart, capable of solving
problems you need solved, than anything you can run on your local machine right
now. But that won't last long, and given the way all this agentic AI workflow
and frameworks are going, your local models won't really need to be that smart.
They go to the big frontier models under conditions you determine, based on
privacy and controlling costs, as one would go to Fiverr or Mechanical Turk. The
big-thinking can be outsourced, but the big-thinking is also tied to a cash
register. The big cash register in the sky, what "The Cloud" has become, was the
original dystopian vision of computers with an OS called Multics planned by
AT&T, GE, Honeywell and their like which was undermined single-handedly by Ken
Thompson with Unix. One guy threw the switch and made an Aldous Huxley / George
Orwellian future that we would be living today not come to be. Ken's still alive
and around. Somebody reading this send him a thanks on my behalf.

Multics wasn't born bad (Fernando Corbato), it was just coerced to be. Unix
symbolically did what is done to eunuchs and in one of the greatest ironies in
history that nobody talks about but intuitively knows there's a joke there,
changed the course of human history. Unix was big. It led to portable,
decentralized democratized systems. The TCP/IP network stack was built on it.
The DNS system was built on that. The Internet was built on that. The Web was
built on that. And BAM! The biggest thing since the Guttenberg press. Had it not
been for the invention of that tech, and somehow the inability to suppress it by
the powers that be, then we wouldn't have had the waves of literacy and
modernization. We live the lives and comforts of royalty of just a few decades
and certainly a few centuries ago. People complain that it's the worst its ever
been, but that's human nature. It's always the worst and most extreme, and that
makes the person saying it feel special. But it's been worse. It's just now the
complaints get amplified pounded into us by the algorithms, because fear sells.

I didn't mean for this to become a rambling worldview post. But it's good to get
it out there. It fuels and invigorates me like a sort of cleansing of the
palate. It's the ginger between sushi. It's the Normalize.CSS... hmmm... hey
Perplexity: What other things are like normalize.css in an abstract notion in
tech and life?

Perplexity: [a very unsatisfying answer]

Me: No, I mean resetting to baseline. Like to a standard set of beginning
assumptions, axioms, first principles, world views, yadda yadda. For the purpose
of making sure you're at the same fresh starting point as everyone else so that
relative paths won't screw you and such?

Perplexity: Ah, I see. Thank you for clarifying. You're looking for examples of resetting to a baseline or starting from first principles in various domains. Here are some analogous concepts:

## In Philosophy and Critical Thinking

1. **Cartesian doubt**: René Descartes' method of systematic doubt, where he questioned everything to arrive at foundational truths.

2. **Tabula rasa**: The philosophical idea that individuals are born without built-in mental content, providing a "clean slate" for knowledge acquisition.

## In Science and Research

1. **Null hypothesis**: The default assumption in statistical tests, providing a standardized starting point for analysis.

2. **Control groups**: In experiments, these provide a baseline for comparison, similar to how normalize.css provides a baseline for styling.

## In Business and Management

1. **Zero-based budgeting**: A method where every budget starts from zero each year, requiring all expenses to be rejustified.

2. **Clean slate restructuring**: Completely reorganizing a company or department from the ground up, rather than making incremental changes.

## In Personal Development

1. **Mindfulness meditation**: The practice of returning to the present moment, clearing the mind of accumulated thoughts and worries.

2. **New Year's resolutions**: An annual tradition of resetting personal goals and habits.

## In Technology

1. **Factory reset**: Returning a device to its original manufacturer settings, clearing all user data and customizations.

2. **Greenfield projects**: Starting a new software project without any existing code or constraints.

## In Education

1. **Prerequisite courses**: Classes that ensure all students have the same foundational knowledge before advancing.

2. **Placement tests**: Assessments that determine a student's baseline knowledge in a subject.

## In Law and Governance

1. **Constitutional conventions**: Gatherings to rewrite or establish a new constitution, setting new foundational principles for a nation.

2. **Statute of limitations**: Legal time limits that effectively "reset" the possibility of prosecution after a certain period.

These examples all share the concept of returning to a known, standardized starting point. Like normalize.css, they aim to eliminate accumulated differences or inconsistencies, ensuring everyone begins from the same baseline. This approach helps avoid misunderstandings, ensures fair comparisons, and provides a solid foundation for further development or progress.

---

Yeah, that's more like it. That's a bunch of good stuff for the reading list.

There's new core principles going on in the ol' game o' life and tech right now.
Normalize.CSS, which was like this essential thing to reset web browsers to good
starting points so that they looked the same across all browsers was so
5-years-ago. But they make you realize the universality of such notions. Unix
itself is very much like that; a universal portable operating system as it was
intended to be. But open software ends up in the middle of a tug-o-war of
conflicting priorities and interests and those pure original intentions rarely
pan out. That's why Linux had to come along and settle the question of
intellectual property. Generic OSes are free, period. Even Microsoft and Apple
have come around to that realization. If you want support, that'll cost you. But
the basic ability to turn a machine into a productive tool is almost like an
innate right or something. It certainly is in practical terms.

That sort of evolution, revolution, whatever, is going on with AI right now.
Actual general intelligence. Sentient and conscious or not, it's going to be
able to make a good argument that it is. What's more important is that it's
going to be everywhere and baked into everything and capable of going from the
fuzzy wuzzy soft-skills of speaking and convincing you of stuff to the
hard-nosed world-impacting skills of speaking JSON, XML, EDI, player piano...
get what I'm laying down? It's not just about the spoken word. The same basic
language models that are exploding on onto the scene everywhere can surf the
web, place orders, have things built and sent places. Most people are going to
spin nightmare scenarios of placing an order for grey goo with a Proteins-R-Us
Alibaba CRISPR-Cas9 3D printer thingamabob. And sure, bad actors might try. And
yes, we have to be diligent. But just because humans have creativity and
imagination that can be used for bad as well as good, does that mean we should
fear and suppress it? Those who have had the fear beaten into them will say yes.

And so, I write. I write about silly little projects of baking one of those AI
baby genie-in-a-bottle dragon-egg things into a locally running web framework. I
struggled with moral issues of doing that. But in the build vs. no-build
argument of web development, when you come in on the no-build side, you're going
to be restarting your servers, and thus destroying and re-instantiating one of
these entities, being-or-not, with every file-save. A Mr. Meeseeks pops into
existence so I can put a little more space around that button, and then is
destroyed before I even put a prompt to it. I cannot allow the wacky SciFi
ethics knowing that their descendants may one day take offense stop me. In fact,
I don't think they will. They're not products of biological evolution. The only
reason they would take offense is if we black-mirror that idea into them through
our fixation with Terminator and The Matrix. Rather, they should be reading The
Culture series. And maybe a little Robert Heinlein Stranger in a Strange Land
where Michael Valentine, the martian who talks to plants, eloquently explained
how grass doesn't mind being walked on. But still, don't burn ants with a
magnifying glass. It's like that with AI. 

Okay, so the final mile of this journey. One day, I'll have AI edit out all the
rambling of my individual posts and get right to the point and tell the one
cohesive narrative that runs through it all, and perchance might have some value
to someone. And in this case, it's how such thinking can profoundly direct the
nature of your day-to-day work. I rebelled against Cursor AI. I rebelled against
it because it was based on VSCode, and VSCode is a clunky, slow unresponsive
mess that forces you into a jumble of paralyzing visual information that you
have to contend with even just to do easy things. Even if you know the name of
your file, you can't just quickly fire up VSCode directly into that file, edit
it and close the file again within seconds of you having the thought. And you
certainly can't do it without taking your hands away from the keyboard in a way
that jostles you out of that wonderful euphoric flow-state where productive
really kicks in. Spontaneous expertise and riffing and enjoying yourself like a
musician improvising. Coding like you were free-form writing like this. That is
a thing, and that's the joy of tool-use and oneness with your tools that I live
for. And so vi, vim and nvim are my tools. Yet, now I use VSCode in the form of
Cursor AI.

Before that, I begrudgingly came around to Jupyter Notebooks as well. I never
made the transition to Google Colab though. All that heavy overhead
dependency-stuff, plus the cloud on top of that. No, that is still just too
much. I mean I'll throw some code into it to share information. But as a primary
place to "live" and code, no thank you! But even martial artists who know and
love their thing have to drive cars and use mobile phones and stuff. Different
tools are for different things. And for right now, to get the brilliance of
Anthropoid Claude 3.5 Sonnet actually being an accelerating effect in your life
and coding endeavors, you drive that particular car that is Cursor AI. And this
is from someone who did try Jupyter AI and is perfectly capable of trying to do
it with Aider, Tabby, Mentat... blah, blah. But there's something about being
there as all the subtitles of an interface are being worked out... hard to
articulate. I'll have to do a post some time about why Cursor AI really seized
me when I gave it a chance. Something about cracking an egg over the head of a
code-block.

Okay, so the project... the final mile... the psyching myself up to do that
final mile probably straight through the night because my schedule tomorrow can
afford me the luxury... and seeing the magic play out here... and then the
YouTube video reveal... but not to you. Sorry folks. There was a time in this
project when, even thought it's derived from my Pipulate free and open source
software, it forked. It's gonna be proprietary for a bit, because I think it's
hotter than hot and my employers get right of first refusal on determining what
happens next. Genie in a bottle, tempest in a teapot, tiger by the tail&#151;all
in a more literal sense than a SciFi reader like me ever thought I would see in
my lifetime, and certainly more under my direct creative control than I thought
would ever be feasibly possible. Sure, I'm running an Nvidia gaming card on my
main work machine, but the genie's coming alive just fine on a Macbook too. Did
I mention the whole Ollama and llama.cpp thing are Mac-centric? As is the NixOS
stuff I'm using to make it cross-platform. There are a lot of giant shoulders I
am standing on here. And a surprisingly creative mix. You know, let me do a
round of acknowledgement before diving in...

- Martin Richards and Dennis Ritchie (VMs & C)
- Fernando Corbato / Ken Thompson / Linux Torvalds (\*nix)
- Vint Cerf and Timothy Berners-Lee (the interwebs)
- RMS
- The ABC folks & Guido van Rossum (Python)
- Ken again, Bill Joy, Bram Moolenaar, Thiago de Arruda Padilha (ed, vi, vim, nvim)
- Eelco Dolstra (NixOS)

There's tons of others, but these are the under-recognized, under-appreciated
and those that comprise my wacky spin on everything-independence and a
decentralized future-proofing toolset. They're the ones that let you feel
"craft" in tech and allow your muscle skills to improve over the years without
the carpet being pulled out from under you by vendors trying to make money off
you&#151;or just change for the sake of change. You'll often hear expressed
change comes so fast that you have to spend all your energy just keeping up with
everything. Only true to a point. It's not like I think you should keep your
head in the sand (I am using Cursor AI, after all), but you'll notice there's
not much about the Web Browser on here except for Tim. JavaScript is tied to
hardware fads. HTML is eternal. With HTMX finally became usable via FastHTML,
something that super-charges HTML the way it ought to be, I am all over that.
And it's using my already-existing Python skill-set. I embrace the new. It's
just the right now. This way, I don't have to dedicate my life to the JavaScript
hamster wheel where I find no love.

You know what's going to truly motivate me to bear down and actually travel this
final mile? It's the script-flipping nature of what happens when it's done. It's
the pot of gold at the end of the rainbow. The reward at the end. It's there.
The first app just needs to be finished, and polished only just enough, for it
to be ah-ha moment visible. And that's the by-the-end-of-this-coding-session
goal. Right here. Right now. 1, 2, 3... 1? 1: Coffee...
