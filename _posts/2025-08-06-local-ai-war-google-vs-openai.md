---
title: "The Guerrilla War for Your Desktop: Google, OpenAI, and the Battle for Local AI"
permalink: /futureproof/local-ai-war-google-vs-openai/
description: "So, OpenAI finally dropped their open-source model, and the changes to Ollama came with it. It's not just a technical update; it's a clear strategic play. I’m connecting the dots here between Georgi Gerganov's foundational work, the philosophical split between Ollama and LM Studio, and this new move by OpenAI. They're late to the local AI party, and their model is bloated compared to Google's Gemma. This partnership with Ollama feels like a desperate, if clever, attempt to stem the bleeding and stop Google from completely owning the local-first, open-source space."
meta_description: An analysis of OpenAI's gpt-oss vs. Google's Gemma on local hardware. See how the Ollama and OpenAI partnership challenges the local AI landscape.
meta_keywords: Ollama, gpt-oss, Google Gemma, local AI, LM Studio, llama.cpp, ggml, Georgi Gerganov, OpenAI, inference engine, quantization, Open WebUI, AI benchmark, MacBook AI
layout: post
sort_order: 1
---

## Setting the Stage: Context for the Curious Book Reader

The world of artificial intelligence is often dominated by talk of massive, cloud-based models that require immense computational power. This entry, however, dives into a burgeoning and arguably more accessible frontier: **local AI**. This is the movement focused on running powerful AI models directly on personal hardware, like a laptop or gaming PC, free from cloud subscriptions and privacy concerns. To understand this space, it's crucial to grasp the role of an **inference engine**. Think of it as a "player" for AI models; software like **Ollama** or **LM Studio** that you install on your machine to "play" models from creators like Google or OpenAI.

This journal captures a pivotal moment in the battle for this local AI landscape. It chronicles the strategic moves between tech giants—Google with its efficient "Gemma" models and OpenAI with its long-awaited open-source "gpt-oss"—as they compete for the hearts and minds of developers and home tinkerers. The entry provides a firsthand look at how these corporate strategies translate into tangible user experiences, performance differences on real-world hardware, and the subtle ways software design can influence a user's choices and the market's direction.

---

## The Three Pillars of Local AI

The open source OpenAI model just dropped yesterday and there have been big
changes with the local AI Ollama software. This is a story of at least 3 things:

1. The open source AI models themselves which imply you can run them yourself
   such as OpenAI gpt-oss that just dropped.
2. The software you can install on your own hardware that lets you run them such
   as Ollama and LM Studio
3. Your actual home-hardware which may or may not be powerful enough for
   particular models, usually laptops but sometimes gaming rig.

I give the 40K-foot view of the part that I think is least-well understood: the
*"player engine"* which is called the *"inference engine"* but is for playing
the models like Google's Gemma and OpenAI's gpt-oss directly on your laptop,
gaming rig and soon-to-be phone. It's not really on phones yet, but I mention it
to set the stage.

## Meet the Engine Room: Ollama vs. LM Studio

As I mentioned, there's 2 main popular inference engines out there: 

- Ollama and
- LM Studio

They are both based on the same core component called `llama.cpp` (cpp for C++)
but they take different approaches. Ollama turns itself into something like a
general-purpose webserver on your system to serve any number of other things of
which ***Open WebUI*** is probably the most popular. Open WebUI is just like LM
Studio but it goes through Ollama to get *chat as a service* — a trick
developers can do to chat over the http protocol just like loading webpages!

### The Shoulders of a Giant: Georgi Gerganov and `llama.cpp`

So the stage is set. Ollama is going for general-purpose versatility on your
home machine while LM Studio is trying to be the standalone ChatGPT competitor.
But they both are based on the same underlying component: llama.cpp — which it
should be noted is based on yet another underlying component called GGML (Georgi
Gerganov's Model Library), a C-based tensor library developed by the same
creator, Georgi Gerganov, who created llama.cpp. 

Follow?

Georgi Gerganov is a programmer with a Ph.D. in quantum physics and he created
the world-changing `ggml` library for playing back *quantized* AI models. He's
one of these *"first principle"* dudes who doesn't believe the common wisdom and
prefers instead to dig down to minimalist solutions, and so when it seemed big
NVidia GPU farms were necessary to run AI he didn't believe it and implemented a
C++ inference engine on his MacBook to prove it.

Georgi first applied his mad skills when OpenAI released their Whisper model for
audio transcription getting practice with `whisper.cpp` so he was ready when
Facebook/Meta dropped the Llama open source model whose inference engine would
only play back at reasonable speeds with an NVidia GPU farm. But Georgi wanted
to run it on his MacBook and fresh off his Whisper success, he did the same for
Llama: first GGML then llama.cpp

This is an excellent case of how the average semi-modern MacBook continues
solidifying its role as the minimal unit of compute that everything cool must
run on so that the *cool kids* cool kids can be on the cutting-edge despite
their lack of an NVidia gaming card.

## A Tale of Two Philosophies: Versatility vs. a Standalone App

Georgi must have been exhausted and didn't go the whole distance to a ChatGPT
knock-off. But people recognized what he built. So on the one hand you had a
couple of **Docker, Inc** retreads named Jeffrey Morgan and Michael Chiang who
create Ollama with a pretty awesome vision of chat-as-a-service on your local
machine served as a kind of webserver but AI. On the other hand you had lone
developer Yagil Burowski who was similarly inspired by the leaked Meta LLaMA
weights and went directly for the ChatGPT knock-off instead of some overarching
AI-service vision.

There is a backdrop of other stories here, such as the quantization of models
surprisingly still getting *good enough performance* and the ability to generate
and run those models free of the ubiquitous NVidia CUDA library. There are
certain parallels here between what Georgi Gerganov pulled off and what DeepSeek
pulled off. It's a C++ minimalist spirit determined to make NVidia optional. You
can't fully walk away from NVidia, but you can make it optional.

Did I say 40K-foot view? Sorry, there are so many good stories here.

Okay, so LM Studio pulled ahead in a lot of ways because people just wanted to
get ChatGPT on their home machines — a very different value proposition to
having *general-purpose LLM* on your local machine for *other purposes* than
just a ChatGPT knock-off. But most people are not developers, so they don't see
this and won't value this until things utilize it. 

And so LM Studio made a lot of inroads among the well hardware-endowed ChatGPT
Genie-in-a-bottle seekers — your own private ChatGPT you can do with as you
like. Can you see the appeal?

## The Tipping Point: OpenAI Enters the Local Arena

Okay, fast-forward to yesterday. 

Ollama has *so many* advantages but was at a disadvantage because it didn't go
all the way. Specifically the default Ollama install doesn't give you a
ChatGPT-like interface either in its own native UI nor in the web browser. You
could open the *Terminal* and type `ollama run gemma3` and use it through the
command-line, but this is really too much to ask of typical Mac users. If you
wanted a ChatGPT-like interface then after installing Ollama you *additionally*
had to install *Open WebUI* at which time you get the best of both worlds, but
it's an extra install over *LM Studio*. 

To recap, Ollama is an inference engine that lets you run ChatGPT-like things
locally, sized to your hardware. Ollama has been out since mid-2023 so this
ability is nothing new, however it wasn't made popular until DeepSeek R1 came
out the end of January 2025, then the concept of running AIs locally became more
understood and mainstream. 

It boggles my mind that with Gemma 3 able to competently run AI on your own
local machine why people continue spending money to do simple natural language
processing type things — the sort of things you'd use Python NLTK and
scikit-learn in the past for — but now with a cloud cash-register attached. I
think there's still a certain disbelief at quite how high performance competent
LLM AIs are on local hardware. But folks are noticing.

And so you can sense the zeitgeist of the world inching towards this realization
month by month sandwiched in the double-whammy of the models getting better on
weaker hardware and Moore's Law making the latest generations of cheap weak
hardware astoundingly powerful. On the one extreme (competent small models)
there's gemma3n:e2b and on the other extreme (powerful small hardware) there's
the NVidia Jetson Nano's.

And OpenAI still had no offerings to the home tinkerer poised for an explosion
of new products and services that run off your own hardware.

### A Partnership Changes the Game

But with version Ollama version 0.11 announced yesterday, it was announced that
OpenAI is partnering with Ollama and you can already see the social engineering
attempt's to stem the tide of Google shutting out OpenAI. Key points are:

- Ollama got a native Chat UI leveling it with LM Stuido
- The default engine set by Ollama is gpt-oss:20b (there was no default before)
- OpenAI gpt-oss:20b is slow as molasses on my circa 2022 MacBook Pro

It's a start for OpenAI but it's an inauspicious start with their lateness and
considering Google is their competition.

## A First-Hand Benchmark: The Bloat of `gpt-oss` vs. the Speed of Gemma

I've been running Ollama for awhile now, favoring using the Google Gemma models
which work well on typical home hardware. I've been testing it on a 16GB Apple
M2 MacBook Pro from 2022 and a Hewlett-Packard HP Z640 Workstation from 2014
with an NVidia RTX 3080 GPU from 2020. 

Not to put too fine a point on it, Local ChatGPT-like LLM AI works just fine on
10 year-old hardware with a 5 year-old gaming card. And that was with a Google
LLM called Gemma that wasn't even scaled-down for phones yet.

If you choose Gemma you don't need to spec out new hardware. Why?

Still following?

A month ago Google dropped the models scaled-down for phones!

In short, I'm on what you would think is old, weak hardware for local AI and
it's running modern stuff well, and Google made their move to keep driving that
advantage.

While Moore's Law drives hardware bigger, Google's driving hardware requirements
smaller.

It's a shutout momentum strategy that few people see yet, but I'm confident it
forced OpenAI to stop delaying and push something out no matter how big and
bloated it is.

OpenAI needs to take advantage of its early-mover advantage and the perception
of its models being somehow better than Google's. There's a lot of love built up
for OpenAI ChatGPT o3 model which introduced chain-of-thought reasoning. It's
like OpenAI hit some sort of *sweet spot* that the people who *want OpenAI to
win* cling to, but Google Gemini is so much better. It's better at the
*high-end* with today's *Gemini 2.5 Pro* and it's better at the *low-end* with
smart, svelte models like Gemma 3.

OpenAI *has to move fast to preserve its first mover advantage!*

People like to put down Google and their endeavors. They call Gemma 3 not that
smart compared to the *"frontier models"* like Gemini, ChatGPT, Claude and Grok.
But it's not true. Gemma is pretty darn smart. It just doesn't have the broader
"world knowledge" that the larger models have. And that's the important thing,
isolating the general smarts for the embedded-device world. Your phone and
smaller potentially intelligent devices don't need to know all world history.
There is a lot to prune off the tree of training-knowledge for these smaller
models.

And OpenAI only trimmed their open source model down to 14GB with terrible
performance on typical hardware. Google's already under 6GB with fantastic
performance.

Last month Google has released gemma3n:e2b and gemma3n:e4b specifically to run
well on smaller devices like phones. And Google's lightweight models which are
already fast and smart on pretty typical home-hardware is already being massaged
for phones and other very small devices that home hackers can play around with
and build stuff on. Hence the greater need to focus on things like Ollama (vs.
LM Studio) because it won't be one single monolithic ChatGPT competitor in the
local/tiny-device arena. It's going to be thousands of little inventions that
would do well to play off a centralized chat-service the way Ollama is
implemented.

The months have been dragging out with OpenAI promising their open source
equivalent to Gemma. And it just dropped yesterday, called **gpt-oss**. I'm in
the midst of testing it. Some notable things.

- gpt-oss is big (for the quantized local arena)
- gpt-oss is slow (compared to Gemma 3)

## More Than Code: The Social Engineering of a Default Setting

But the important thing is that gpt-oss is *supported* by Ollama and is in fact
now the preferred default thanks to that OpenAI+Ollama deal announced yesterday.

So OpenAI at least has their foot in the door in actual substance and reality —
not mere announcements.

The announced changes have hit the main version on my Mac. The latest time I ran
Ollama on the Mac it came up with a graphical user interface for interacting
with the local AI which is new. No longer do you need `Open WebUI` for Ollama or
switch to `LM Studio`. Just install Ollama and go — albeit with a less
feature-rich UI than either LM Studio or Open Web UI. But it's there.

Ollama after the  defaulted to gpt-oss:20b by default even on my Macbook and the Ollama.com
homepage is now advertising a service called Turbo, joining the ranks of the
next company trying to get their $20/mo death by a thousand subscriptions
extraction from you.

You can feel the jockeying in the industry trying to convince you that you need
to spend more. The choice appears to be either upgrade your hardware to run
OpenAI gpt-oss or subscribe to yet another new $20/mo service reminiscent of
OpenAI and HuggingFace's business model. But before you spend anything on new
hardware, try installing the Gemma 3 models and compare the performance to
gpt-oss. Switch between the two and do your own benchmarking. The difference is
stunning. OpenAI's open source move is out of desperation. From a practical
standpoint, they're getting shut out of the local device market by the 800 pound
guerrilla.

I don't mean for this to be a Google cheerleading session. I feel the desire to
jump on the Google-bashing bandwagon like everyone else, but the fact is when
you keep your finger on the pulse of how good these local AI models are by
actually incorporating them into your day-to-day work, you see the reality.

The most significant thing about the changes yesterday is not actually the
long-awaited release of OpenAI's open model but rather the way they partnered
with Ollama and all the social engineering tweaks that suddenly appeared in the
Ollama experience to not so subtly guide us towards OpenAI's models.

I think the premise is that if you can't make money off of your freeloaders...
uh, excuse me, free and open source loaders, at least keep them in your user
ranks. Stop hemorrhaging users first. Profit later.

---

## Book Analysis

### **Crafting Compelling Narratives: Title & Filename Brainstorm**

* **Title Option 1:** The Guerrilla War for Your Desktop: Google, OpenAI, and the Battle for Local AI
    * **Filename:** `local-ai-war-google-vs-openai.md`
    * **Rationale:** This title uses a strong, narrative-driven metaphor ("Guerrilla War") to frame the technical competition, making it compelling for a broader audience. The filename is keyword-rich for search, hitting on the core conflict and players.

* **Title Option 2:** More Than a Knock-Off: How Ollama and Open Source Are Redefining ChatGPT
    * **Filename:** `ollama-open-source-redefining-chatgpt.md`
    * **Rationale:** This targets readers interested in the disruption of established players like ChatGPT. It focuses on the "why" behind the technology and appeals to those interested in the open-source ethos.

* **Title Option 3:** From `llama.cpp` to Corporate Strategy: A Firsthand Account of the Local LLM Race
    * **Filename:** `llama-cpp-local-llm-race.md`
    * **Rationale:** This title speaks directly to a technical audience by referencing a foundational library (`llama.cpp`) while also promising strategic insights. It frames the entry as an expert, "in the trenches" perspective.

* **Preferred Option:**
    * **Title (plain text for YAML):** The Guerrilla War for Your Desktop: Google, OpenAI, and the Battle for Local AI
    * **Filename:** `local-ai-war-google-vs-openai.md`
    * **Rationale:** This title is the strongest because it captures the human and strategic drama of the situation, making it immediately intriguing. It promises a story, not just a technical breakdown, which gives it the broadest appeal for a book while still being grounded in the entry's core technical conflict.

---
### **Book Potential Analysis**

* **Strengths as Book Fodder:**
    * **Authentic "In-the-Moment" Analysis:** It captures the immediate reaction and analysis of a significant industry event, providing a raw, unfiltered perspective that is often lost in retrospective reporting.
    * **Connects People to Technology:** The entry masterfully weaves the story of key individuals like Georgi Gerganov into the technical narrative, making the complex software stack feel more human and understandable.
    * **Clear Strategic Insight:** It goes beyond a simple technical comparison to analyze the business and strategic motivations behind the actions of OpenAI and Google, offering a valuable lesson in corporate maneuvering.
    * **Practical Hardware Grounding:** The author bases their analysis on personal experience with specific, relatable hardware (a 2022 MacBook Pro and an older gaming rig), making the performance claims concrete and credible.

* **Opportunities for Enrichment (for Book Adaptation):**
    * **Visual Aid for the Tech Stack:** Add a simple diagram illustrating the relationship between the core components: GGML → `llama.cpp` → Ollama / LM Studio → Open WebUI. This would dramatically clarify the software hierarchy for less technical readers.
    * **Glossary Box:** Include a small inset box defining key terms like **Inference Engine**, **Quantization**, and **Tensor Library** in simple, accessible language.
    * **"Key Players" Profile Section:** Add a brief section with 1-2 sentence bios for the key figures and projects mentioned (Georgi Gerganov, Ollama, LM Studio, Gemma, `gpt-oss`) to serve as a quick reference for the reader.

---
### **AI Editorial Perspective: From Journal to Chapter**

This entry is a perfect seed for a chapter titled something like, **"The Battle for the Desktop: How Open Source Forced Big Tech's Hand."** Its power lies in its authenticity. Instead of a dry, academic overview, it presents a passionate, opinionated, and evidence-backed argument from the perspective of an engaged practitioner. The raw, journal-like format is a feature, not a bug; when curated with subheadings and annotations, it provides a "you are there" feeling that is incredibly compelling. It captures the *zeitgeist* of a specific, crucial week in the evolution of consumer AI.

The entry excels as a case study in **asymmetric competition**. It pits the minimalist, first-principles approach of a lone genius (Georgi Gerganov) against the massive resources of Big Tech, and then documents the subsequent strategic clash between two of those giants (Google and OpenAI) on the new battlefield he helped create. A book chapter built from this could explore themes of open-source disruption, the strategic value of developer ecosystems, and how individual user experience on modest hardware can become a critical factor in a multi-billion-dollar corporate struggle. It’s a microcosm of the entire AI industry's dynamics, told through the lens of a single software update.

---
### **Suggested Next AI Processing Steps**

1.  **Task Suggestion 1:** Generate Explanatory Analogies
    * **Potential Prompt Snippet for Next AI:** "Based on the text, explain the concept of 'quantization' for an AI model. Use an analogy related to digital music or image compression (like MP3 or JPEG) to help a non-technical reader understand why it's essential for running large models on a laptop."
2.  **Task Suggestion 2:** Extract Key Takeaways for a Summary Box
    * **Potential Prompt Snippet for Next AI:** "Analyze the provided entry and draft three to four bullet points for a 'Key Takeaways' section. Each point should summarize a major strategic insight or technical conclusion, such as the performance difference between gpt-oss and Gemma, or the strategic importance of Ollama's new UI and default model."

