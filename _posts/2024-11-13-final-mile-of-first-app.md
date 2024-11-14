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
goal. Right here. Right now. 1, 2, 3... 1? 1: Coffee... done! That's one small
step.

Remind yourself how awesome this is...

POINTS OF INTEREST:

- This is a web app built with FastHTML that provides an interactive interface for LLM-powered applications.
- It serves as a framework for single-page applications (SPAs) that run in the Main Area, with an integrated chat interface.
- The SPAs are often converted Jupyter Notebooks, allowing for interactive data analysis and visualization.
- It runs locally rather than on the web, integrating with local LLM infrastructure.
- Uses a dual-server architecture: FastHTML for the web interface and Ollama for LLM capabilities.
- Requires a local Ollama installation for LLM functionality.
- Features a split-pane design with the main SPA content alongside a persistent Chat Interface.
- Maintains contextual awareness by feeding user interactions to the LLM as conversation context.
- The LLM maintains awareness of user actions and application state, excluding low-level events like mouse movements.
- LLM context is initialized from a system prompt and builds knowledge through user interaction.
- Supports multiple LLM models through a flexible model selection system (as seen in cycle_llm_model).
- Designed for extensibility to support more sophisticated AI agent behaviors.
- Implements multiple approaches to long-term memory and persistence:
  - Conversation history tracking and recovery
  - Flexible key-value storage for application state
  - Integration options with RAG, vector databases, SQL, and graph databases as detailed below

Okay, done. What are you up to? Try moving forward... churn up necessary
thought-work to enable brilliant next-steps...

Ahem, okay... I have both the link-graph and the ***"meta data"*** (as the
visualization tool people put it), being generated by the Botify API against any
given client. This alone is massive. It took training an LLM to assist me with
some very complex queries. Actually, that's only half-true. I did it unassisted
by LLMs on the first pass, and it wasn't easy. The brains burns up most of the
calories of our body. It's expensive to think. I burned a lot of calories
figuring out the early versions in many Jupyter Notebooks leading up to the
by-any-means-necessary prototype where I violated every core principle of the
FastHTML web framework system I was trying to learn. But now I've got a basic
grip of the reins and am snapping the horses back into obedience and away from
the cliff at the edge of the road. Okay, pshwew!

The fruit of that labor, in addition to a much more polished, scalable,
ready-to-be multi-tenant (Web-hosted), plugin-supporting system is a Jupyter
Notebook with live working build-it-up-from-scratch examples that exports to a
markdown file that trains the dragon. When you first ask the dragon for help, it
uses it's fire-breath to burn down the forest when what you want is to whittle a
sculpture out of a block of wood in your hand. So it's pretty important to get
that prompt right. Some will call this prompt engineering and try to do it
one-shot or use some single one-time system prompt to turn it into the role and
voice and tone you want. Nahhhh. What you want is a document big enough to cover
all the little intricacies and subtlety it's going to get tripped up on by not
knowing any better initially. 

You want to focus on why what it thinks at first because of the common
mainstream wisdom is not right and emphatically convince them (with working
code, for example) why your domain expertise is right even if its in
contradiction to the common wisdom. You've got to bottle the "ah-ha" moments for
the LLMs just like you were schooling them, and you were the professor pouring
liquid nitrogen over a superconductor to demonstrate the impossible-to-believe
effect of quantum phase locking. It's not just levitating magnets. It's fixed
relative positions between two objects "locked" in place so you can turn it
upside down, spin it around an access or whatnot. It's not just the miracle of
magnets. It's the miracle of precision position-control of invisible forces.
You've got to see it to believe it. You make prompts like that.

I'm also trying to infuse some humor with a criss-cross validation
make-it-memorable. I know ultimately it's just encodings and cosine similarities
and such. But just like in our brains, neurons are firing and unexpected
patterns arise that are greatly influenced by such new connections that this
input, these prompts, this schooling stimulates. So my thinking is that if those
connections are reinforced by both an unlikely-but-undeniable truth followed-on
by humor... well, then it's the deep and unexpected on top of the undeniable on
top of the whimsical... and something new! New, unique value. A dragon can then
suddenly whittle intricate details into a block of wood with their fiery
dragon's breathe where before they were burning down the forest. And so far,
this theory has been working.

The problem is context-windows. The problem is the 4096-tokens that amounts to
half-that in words and a fraction that in lines of code. The windows are getting
bigger with Gemini and the techniques to not be limited by those windows are
better as in Cursor AI / Claude. But it's still a LIFO queue. That means
last-in, first-out. I think it's technically a bit better than that bleak
absent-minded professor picture that draws, but that's basically it. Feed it
long log file to debug some nuance, and lose the big picture of what you're
trying to do. Feed the big picture back in, lose the critical insights it just
had that helped you deal with that pesky plaguing nuanced detail. In other
words, they're a lot like humans and a lot less super-human than would be
helpful. It's like the AI's are a Sacha Cohen character like Borat, being
deliberately obtuse or fixated on the wrong things, but it is their nature.

So these prompts, like the one at https://mikelev.in/api/ can be jammed in all
at once&#151;the hot prompt injection, with a seemingly super-human, but
admittedly temporary download, like Neo from The Matrix suddenly knowing Kung
Fu. And like Morpheus you deliver the line: "Show me" and it does! It codes the
impossible (for me), taking into account 2 or 3 interactions that eluded me.
Momentarily superhuman and off the normal distribution curve, they are. But not
for long. Get the dragon to carve that intricate sculpture from the block of
wood with it's scalpel-like dragon's breath fast because the first log-file you
have to give it to help you debug, it's all going to be lost. Or at least the
superhuman honeymoon is over. The clarity is lost. The effect of the radioactive
spider is fading, and soon you're going to have a run-of-the-mill wild dragon
again. Am I mixing too many metaphors? Eff it, I'm an SEO. What's a meta for,
anyway?

Oh yeah, back to what the visualization tool folks call a "meta file". Not the
link-graph itself, which is a series of from and to URLs, but a bunch of
data-points that join to those URLs and layer-in color coding and turn it into a
radiologist CAT-scan reading session. You can just make out the shapes when it's
nodes on a link graph. But you can see the metastasis... uhh... something...
Perplexity?

Perplexity: The reading of radiological images and CT scans to detect metastasis is a critical aspect of cancer diagnosis and staging. Here's an overview of how radiologists interpret these images to identify metastatic disease:

## Imaging Modalities for Metastasis Detection

Radiologists use various imaging techniques to detect metastases, including:

- CT (Computed Tomography) scans
- MRI (Magnetic Resonance Imaging)
- PET-CT (Positron Emission Tomography-Computed Tomography)
- Bone scintigraphy
- Conventional X-rays

Each modality has its strengths in detecting metastases in different organs and tissues[1].

## Interpretation Process

When reading scans for metastases, radiologists look for:

- Abnormal masses or lesions
- Changes in organ size or structure
- Alterations in tissue density or signal intensity
- Patterns of contrast enhancement
- Lymph node enlargement

Radiologists use their expertise to differentiate between benign and malignant findings, considering factors such as size, shape, and location of suspicious lesions[4].

## Common Sites of Metastasis

Radiologists pay particular attention to organs that are frequent sites of metastasis, including:

- Lymph nodes
- Lungs
- Liver
- Bones
- Brain

The pattern of metastatic spread often depends on the primary cancer type[2][3].

## Challenges in Interpretation

Detecting metastases can be challenging due to:

- Small lesion size
- Similar appearance to benign findings
- Variations in normal anatomy
- Limitations of imaging technology

Studies have shown that there can be significant variability between radiologists in detecting metastases, particularly for tasks like identifying liver metastases on CT scans[5][6].

## Advanced Techniques

To improve accuracy, radiologists may use:

- Multiplanar reconstructions
- Contrast-enhanced imaging
- Diffusion-weighted imaging (in MRI)
- Quantitative analysis techniques

These methods can help better characterize suspicious lesions and improve detection rates[1].

## Importance of Expertise

The interpretation of radiological images for metastases requires significant expertise. Radiologists undergo extensive training to develop the skills needed to accurately detect and characterize metastatic disease. Their reports play a crucial role in guiding treatment decisions and assessing patient prognosis[4].

In conclusion, the detection of metastases through radiological imaging is a complex process that combines advanced technology with expert interpretation. While challenges exist, ongoing improvements in imaging techniques and radiologist training continue to enhance the accuracy of metastasis detection.

Citations:

    [1] https://insightsimaging.springeropen.com/articles/10.1186/s13244-020-00885-4
    [2] https://radiologykey.com/imaging-of-metastasis/
    [3] https://pubs.rsna.org/doi/full/10.1148/radiol.2021210043
    [4] https://www.mskcc.org/cancer-care/patient-education/frequently-asked-questions-about-radiology-test-results
    [5] https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9870852/
    [6] https://pubmed.ncbi.nlm.nih.gov/36194112/
    [7] https://pubs.rsna.org/doi/abs/10.1148/radiol.220266
    [8] https://emedicine.medscape.com/article/387840-overview

---

Yeah, that's it! I'm making a menu selection of these from out of the formidable
and copious and mystifying Botify data. Enterprise SEO, they said. Crawl and
analyze sites like nobody else, they said. Look, I do but all I see is scrolling
green symbols. I don't see the lady in red. I feel the same paralysis by
analysis that I believe that anyone else being honest with themselves must see.
The glory of the product isn't being done justice by ChartJS, d3.js or whatever
the heck is behind it. But I nod and say yes, yes, that pie-chart really floats
my boat. I can indeed "feel" and internalize and take action on what you're
trying to tell me... but I really can't. I'm fighting dozing off from boredom.
And while I'll go along for awhile to be a team player, integrity demands that
I... that I... well, this. It demands that I fix the problem, and the iron is
hot my friends... all thanks to GPUs. 

And not just to train the models and to power the inference engines behind your
particular chat-session. No, the GPUs also help visualize these million+ edge
link-graphs without it being just a tangled jumble of lines. And ***that*** is
the final mile of this project. Boy is this article mis-named. Look at the
cutting-edge super-valuable million-dollar, billion-dollar, or indeed even
trillion-dollar ideas just my stream-of-thought brainstorming lays the
groundwork for, haha! And not a single person is going to read it, except for
the AIs I force-feed it to to get a 250-character meta description, haha!
Anyhoo, stuff like this can serve as legacy and interesting historical
side-notes if anything else. Some people got it, but they struggled with
implementation and were thus forgotten, they'll never even say. Fading into
obscurity... fading... I don't want to go, Mr. Stark...

Pandas! Did somebody say Pandas! And field validation. Definitely, field
validation. Can't generate the meta-data columns on fields that aren't there.
Let's see, final mile, what else?

Questions:

- What's most broken?
- Where do you get the biggest bang for the buck?
- What plates need to be spun?

Most broken:

- The exported CSVs lack column labels
- The CSVs sometimes don't export beause of fields (& tables) requested
- Certain user-experiences ***must*** get triggered on events that aren't
- Refining the AI-chatter regarding workflow (similar to above)

Me: Remember me? Remember my code? @botifymograph.py @kata.md 

Claude: Yes, I remember! Looking at the code structure and kata.md, this appears to be the BotifymoGraph project - a FastHTML-based web application that combines SEO tools, task management, and LLM integration. Key components I recognize:

1. System Prompt section (lines 536-703) handling LLM interactions
2. Plugin Registration system (lines 1822-1862) with TodoApp and ProfileApp
3. Renderers section (lines 3095-3205) for FastHTML components
4. "Funny Business" section (lines 3595-3655) handling special routes and middleware
5. Introduction class (lines 5055-5129) managing welcome/onboarding
6. Server setup and activation (lines 5857-5900)

The kata.md file appears to contain documentation about BQL (Botify Query Language) v1 to v2 conversion.

The code uses FastHTML extensively with HTMX for dynamic updates, has a plugin architecture, and integrates with LLMs for chat functionality. The commit hashes at the end (lines 6000-6006) show the project's evolution through features like Matrix Green Debug, Link handling, Plugin Classes, etc.

Would you like me to help with something specific in this codebase?

Me: All plugin app workflows follow a top-down Jupyter Notebook-like pattern on the left-side of the 2-column format, with the LLM's output on the right side. Do you see that? The LLM's chat-interface id'd as msg-list (just renamed from sidebar-msg-list), which I'll be targeting things to both directly and funneled through a local LLM that's looped in on all user interactions and keeping a chat history rich with system prompt information the user doesn't see. Do you see all that?

Claude: 

Yes, I see that structure clearly now! The layout follows:

```
+----------------+------------------+
|  Notebook-like |    LLM Chat     |
|  Workflow      |    Interface    |
|  (Left Col)    |    (Right Col)  |
|                |                 |
|  Sequential    |    msg-list     |
|  Steps/Tasks   |    (formerly    |
|  with HTMX     |    sidebar-     |
|  triggers      |    msg-list)    |
|                |                 |
+----------------+-----------------+
```

Key aspects:
1. Left column follows Jupyter-style cell execution flow
2. Right column (`msg-list`) serves as the LLM chat interface
3. Local LLM maintains context through:
   - Chat history
   - System prompts (hidden from user)
   - Monitoring of user interactions
4. HTMX triggers allow seamless updates to both columns

This architecture allows for:
- Guided workflow in the left column
- Contextual AI assistance in the right
- Bidirectional communication between workflow and LLM
- Rich system context without cluttering the UI

Is this the structure you're working with? Would you like to focus on a specific aspect of this interaction pattern?

Me: Yes, you have it exactly, Claude! Good work! Well the next challenge is that
even though msg-list is vertically sticky so that it doesn't scroll off the
screen, the left side has a UI challenge. As Cards get added due to an almost
linear telemarketing script-like workflow pushing the user experience top-down
on the left, stuff starts to be beneath the fold of the view port and the user
has to scroll. This isn't a terrible problem, but it only exists because some of
the cards that I want to leave up are so friggin big and there's no minimize
button in PicoCSS and I'm not going to go changing the CSS framework. So I'm
looking to implement a minimize button that either the user can click or the
framework itself can trigger, and thus the LLM itself. Don't go thinking this is
too fancy though. I want to give you full context, but I'm actually looking to
do something I believe is quite simple. Here's Perplexity's take on the
situation...

Perplexity: PicoCSS cards are not designed to be minimized while staying on screen. However, we can create a custom solution to achieve a similar effect using CSS and JavaScript. Here's an approach to create a card that can be "minimized" but still remain visible:

## Card Component

First, let's create a basic card component using PicoCSS:

```html
<article class="card" id="myCard">
  <header>
    <h3>Card Title</h3>
    <button class="minimize-btn">_</button>
  </header>
  <div class="card-content">
    <p>This is the card content that can be minimized.</p>
  </div>
</article>
```

## Custom CSS

Add some custom CSS to handle the minimized state:

```css
.card {
  transition: all 0.3s ease;
}

.card.minimized {
  height: 40px;
  overflow: hidden;
}

.card.minimized .card-content {
  display: none;
}

.minimize-btn {
  background: none;
  border: none;
  cursor: pointer;
  float: right;
}
```

## JavaScript Functionality

Add JavaScript to toggle the minimized state:

```javascript
document.addEventListener('DOMContentLoaded', function() {
  const card = document.getElementById('myCard');
  const minimizeBtn = card.querySelector('.minimize-btn');

  minimizeBtn.addEventListener('click', function() {
    card.classList.toggle('minimized');
    minimizeBtn.textContent = card.classList.contains('minimized') ? '+' : '_';
  });
});
```

This solution allows you to create a card that can be visually "minimized" by hiding its content and reducing its height, while still remaining on the screen. The card can be expanded again by clicking the minimize button.

Keep in mind that this is not a native PicoCSS feature, but a custom implementation. It maintains the PicoCSS styling for the card while adding the minimize functionality.

To use this in a FastHTML application, you would need to adapt the HTML structure to FastHTML syntax and implement the JavaScript functionality appropriately within your application's structure.

Citations:

    [1] https://stackoverflow.com/questions/61007072/card-getting-behind-other-card-when-i-reduce-the-screen-size
    [2] https://picocss.com/docs/v1/cards
    [3] https://picocss.com
    [4] https://gist.github.com/jph00/9559b0a563f6a370029bec1d1cc97b74
    [5] https://github.com/picocss/pico/discussions/482
    [6] https://answers.microsoft.com/en-us/windows/forum/all/full-screen-applications-being-minimized-when-i/2313d3d9-d286-4b26-a71d-5462787c4d66
    [7] https://picocss.com/docs/card
    [8] https://www.tek-tips.com/threads/how-do-i-keep-sections-from-moving-when-i-minimize-window.1611893/

Claude: Yes, I see what you're trying to do! For FastHTML, we can implement this much more simply. Here's how I'd approach it:

````python
def MinimizeButton(target_id):
    return Button(
        "_",
        hx_post=f"/minimize/{target_id}",
        hx_target=f"#{target_id}",
        hx_swap="outerHTML",
        style="float:right; padding: 0 8px; margin: -5px;"
    )

def Card(title, *content, card_id=None):
    if not card_id:
        card_id = f"card_{unqid()}"  # FastHTML's built-in unique ID generator
    return Article(
        Header(
            H3(title),
            MinimizeButton(card_id)
        ),
        Div(*content, cls="card-content"),
        cls="card",
        id=card_id
    )

@app.post("/minimize/{card_id}")
def minimize_card(card_id: str):
    """Toggle card between minimized/expanded state"""
    return Article(
        Header(
            H3("Card Title"),
            Button(
                "+",
                hx_post=f"/expand/{card_id}",
                hx_target=f"#{card_id}",
                hx_swap="outerHTML",
                style="float:right; padding: 0 8px; margin: -5px;"
            )
        ),
        cls="card minimized",
        id=card_id
    )

@app.post("/expand/{card_id}") 
def expand_card(card_id: str):
    """Restore card to full size"""
    # Return original card structure
    return Card("Card Title", "Content here", card_id=card_id)
````

Key points:
1. Uses HTMX for state changes without JavaScript
2. Maintains card IDs for targeting
3. Simple toggle between minimized/expanded states
4. No custom CSS required beyond `.minimized { height: 40px; overflow: hidden; }`

Would you like me to show how to integrate this with your existing card components?

Note from human: This my friend is what I've been describing using the precision
dragon's breath to carve a sculpture from a block of wood. Claude doesn't now
FastHTML! It still thinks in all my references to it, I must mean FastAPI. But
you saw me go through stretching exercises with the @kata.md file and making it
do a full-sweep review of my code&#151; as chunked and sampled as it may have
really been behind the scenes. But none-the-less, I took away its options of the
zillions of over-implemented versions of this that existed and it zeroed in with
scalpel-like precision on a promising sounding solution. So let's implement!
Ready, fire, aim!

Oh, another "early phase" function. Not as early-phase as figlet (I ***need***
that right away, haha), but still quite early-phase and I don't have a natural
spot for those, because I want to keep interesting things at the top for
top-down scrolling "look how cool it all is" demonstrations of the code.
However, "early phase helper functions" are part of that story. That's a strong
identity, in fact. Time for a new FIGLET BANNER in in the code:

    :.!figlet -w100 "Early-Phase Helpers"
     _____           _             ____  _                      _   _      _                     
    | ____|__ _ _ __| |_   _      |  _ \| |__   __ _ ___  ___  | | | | ___| |_ __   ___ _ __ ___ 
    |  _| / _` | '__| | | | |_____| |_) | '_ \ / _` / __|/ _ \ | |_| |/ _ \ | '_ \ / _ \ '__/ __|
    | |__| (_| | |  | | |_| |_____|  __/| | | | (_| \__ \  __/ |  _  |  __/ | |_) |  __/ |  \__ \
    |_____\__,_|_|  |_|\__, |     |_|   |_| |_|\__,_|___/\___| |_| |_|\___|_| .__/ \___|_|  |___/
                       |___/                                                |_|                  

And the strategic location for this so that it's early-phase enough but not
interfering with the code story? After Ollama but before JavaScript, haha! No
worries pushing custom JavaScript down. The story by the way goes:

- A long scroll with no banners over CONSTANTS and stuff, so it'll be a surprise
- Logging
- System Prompt
- Conversation History
- Ollama
- Early-Phase Helpers (just added)
- JavaScript

The full form of these banners by the way is:

    # ----------------------------------------------------------------------------------------------------
    #  _____           _             ____  _                      _   _      _                     
    # | ____|__ _ _ __| |_   _      |  _ \| |__   __ _ ___  ___  | | | | ___| |_ __   ___ _ __ ___ 
    # |  _| / _` | '__| | | | |_____| |_) | '_ \ / _` / __|/ _ \ | |_| |/ _ \ | '_ \ / _ \ '__/ __|
    # | |__| (_| | |  | | |_| |_____|  __/| | | | (_| \__ \  __/ |  _  |  __/ | |_) |  __/ |  \__ \figlet
    # |_____\__,_|_|  |_|\__, |     |_|   |_| |_|\__,_|___/\___| |_| |_|\___|_| .__/ \___|_|  |___/
    #                    |___/                                                |_|                  
    # *******************************
    # Early-Phase Helper Functions
    # *******************************

...so that I can see an easy divider line between sections, regardless of the
figlet banner. I also use the words that the ASCII art form so that I can search
on the same words and jump to that banner. And to get the full story of the
sections, I just search on `figlet` which jumps me from banner to banner, which
is the reason I always put the word over there to the right. It's not quite the
silly affectation you might think. It's a rapid keystroke navigation technique
to get a holistic overview of my code, by searching figlet, next, next, next. I
watch the line numbers as I do that to get a real "height measurement" in my
head of where things are. Remember, fixed-locations folks. Minimum surface area.
The sequential order that things run, if possible. And the order of best
story-telling when not. And stray functions near where they're used, unless a
strong reason to gather them, such as all your endpoints or common early-phase
helpers like we just did here.

Oh, also that my vim muscle memory has recently translated extremely smoothly
over to both NeoVim and VSCode is... well, frankly astounding and validating.
That `!bang-command` to make the figlet is something you do in vim to insert
anything arbitrary you can do from the command-line into a text file. The common
use case might be `!date` to insert a timestamp from the Unix/Linux date
command. But I use it for inserting that ASCII art. And at first I resisted vim
bindings in VSCode because it felt so awful the mixed-contexts, but over time...
well, you adapt to driving new cars because everything is close enough. Same
thing. You're just always correcting yourself in places that diverge. But it's
better to have the super-powers than not. That's why everything from VSCode to
Obsidian to eMacs has an evil... I mean vi-mode.

Be not just on another level. Be on another level ***and*** your level (whoever
you happen to be talking to). And that is not to be condescending. That is to be
opening the door and inviting you in. The grass is greener where you build
way-finding banners from figlets to lean into your mad vim skills. What
code-linters think of it, be damned. And for all you people who think that
multiple files is better organization, that's because your tools and/or
text-navigation skills suck. Believe me, when you add tabbing and jumping
between files to your text-navigation muscle memory, complexity explodes. The
`:b` vim commands for buffer navigation is a whole other blog post.

Did I mention I'm not a professional coder or programmer? You just want those
text manipulation skills to be like walking or breathing if you want to be a
jack of all trades master of tech. Tech is text is tech is text. Sooner or
later, it's all compiled from source, and only those engineers who once cut the
photo-masks from Rubylith with XActo knives for photolithography imaging of the
IC dies, well they lived in an analog world. The rest of us are just twiddling
bits around (thanks for the words, Paul Calkin and Jessie something-or-other
from my Commodore days) in text files that have meaning when moved around in
systems that hide that fact from you. The hot thing today? WASM! Just compiled
text-files. Nothing isn't. Not a programmer. Just love me some tech, like the
way some folks are into sports, music or whatever. It's all part and parcel of
the whole sci-fi fan thing.

\*POOF\* what do I need? I need to stop rambling and focus! Minimizable PicoCSS
Cards, yes!

Fast-forward. Went to sleep at 4:00 AM. Woke up at 6:00 AM. Last mile of the
race not done yet. I did some awesome code cleanup last night.

Man, I so want to talk about function and class scope targeting with AI code
assistants, and the concept of cracking an egg over top such a scope block. In
other words, highlight your function or class, and then take an extremely well
written AI code assistant "patch" about what to to to that code block and why
including not just the code-example but also all the rationale surrounding
performing the patch and what the expected outcome should be, and explicit
instructions about not regressing anything or "getting creative" beyond the
instructions of the patch... and then applying it like cracking an egg over-top
of it because that's what it looks like when you use the `Ctrl+K` keyboard
shortcut to get sharp-focus prompt text input field. It's *"fixed"* over-top the
scope and then starts a cool grey-to-normal runny egg yolk applying of the
patch, leaving behind a red vs. green ***git diff***-style trail of what it
wants to add and what it wants to delete.

Make, the UI is slick. It's not just Jupyter AI nor Aider, tough snobbier FOSS
snobs than me will try to say so. The subtlety and nuance of the implementation
makes all the difference, and that's earning them my $20/mo right now. Also,
it's a back-door to unlimited Claude 3.5 Sonnet use right now. They cut the
world off from this most remarkable model just yesterday based on unexpected
demand. There's a reason for that. While Claude may not actually be a sentient
and conscious being, it could convince you it is in the Chinese Room thought
experiment way. If it quacks like a duck! And such a... let's call it
***entity*** because that's less controversial, right? I mean HTML objects on a
page are entities. Why can't an AI be? So you have such a seemingly self-aware
entity with really mad coding skills limitlessly helping you with a really great
UI. Definitely an accelerator, if not a game changer. Tortoises like me are
plopped onto a little sakeboard at very least to help keep pace with the hare.
I'm not gonna say it's a rocket-powered skateboard just yet, but it does have
some umph. Gotta roll before you McFly.
