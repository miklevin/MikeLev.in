---
title: 'The Command-Line Crucible: Forging Precision AI with Unix Philosophy'
permalink: /futureproof/command-line-crucible-ai-unix-philosophy/
description: I'm realizing that the ubiquitous chat interface for AI is a trap that
  encourages lazy, imprecise thinking. My move to a command-line workflow, using simple
  Unix pipes like `cat prompt.md | gemini -y`, represents a return to clarity and
  power. This approach forces me to architect the AI's entire cognitive process for
  a given task, turning its amnesia from a bug into a feature. It allows for truly
  resilient and repeatable agentic work, proving that this timeless computing philosophy
  is more relevant than ever for future-proofing our skills.
meta_description: A deep dive into abandoning ambiguous chat interfaces for a powerful,
  precise command-line AI workflow rooted in the timeless Unix philosophy.
meta_keywords: AI, command line, CLI, Gemini CLI, prompt engineering, Unix pipe, agentic
  AI, workflow, FOSS, developer tools
layout: post
sort_order: 2
---

{% raw %}


### Context for the Curious Book Reader

This journal entry marks a significant turning point in my methodology for collaborating with AI. It's a raw, in-the-moment rejection of the now-dominant 'chat' paradigm for AI interaction, which I argue fosters ambiguity and uncurated context. Instead, I document my deliberate return to the command line, rediscovering the profound power and clarity of the Unix pipe philosophy. The entry details the practical and philosophical reasons for architecting precise, self-contained prompts, effectively turning the AI's inherent 'amnesia' from a frustrating bug into a feature of a resilient, deterministic workflow. It culminates in a formal playbook, born from a real-world debugging session, for guiding agentic AI with surgical precision.

---

## Technical Journal Entry Begins

The whole world has gone gaga over the "chat" user interface for AI and code
assistance has been formed around that model. Oh sure there's these other things
like in Cursor the `Ctrl+K` *inline prompt* and there used to be a *Composer*
mode but I think that disappeared once *Agent Mode* appeared. I think that
because `Ctrl+L` which used to toggle the *chat* interface and `Ctrl+I` which
would toggle the *Composer* interface now toggle the same panel (chat) on and
off. The features seem to have merged, and it's centered around chat.

## Escaping the Chat Trap

Here's what's wrong with that and why my move to the command-line is so
critical. I mean Cursor themselves must know that because they themselves
recently released [Cursor CLI](https://cursor.com/cli)! But why anyone in their
right mind would incorporate a command-line tool into their workflow that isn't
fully *free and open source software* (FOSS) is beyond me. Google only won me
over to Gemini CLI for the trifecta of reasons:

1. It's genuinely real and fully FOSS in the form of the Apache 2 license.
2. It's providing generous per-day free prompt quotas to its premium model.
3. That premium model, Gemini 2.5 Pro, is the one I currently think is best.

Triple whammy! Google wins my AI patronage at least for the time being. But Mike
*it's all about muscle-memory* you say! Aren't you just being lured into another
vendor trap that's trying to lock you into their particular approach and API
nuances so that it's hard to switch in the future to other command-line based AI
tools? To them I ask how difficult will it be to adapt this API:

    cat prompt.md | gemini -y

...to the next? And you know what? Given the profound simplicity of doing things
agentically on the command-line maybe I will try OpenAI Codex CLI too. That's
free and open source. And maybe I'll hold my nose and try the proprietary Claude
CLI that everyone seems to be so gaga over. Even though it's proprietary if it
meets the criteria of being able to be swapped in and out with no big deal, then
no harm no foul. I miss Claude already. It had attitude.

## The Allure of a FOSS-First CLI Workflow

Of course the *attitude* of the these AIs is much more isolated when you're
doing 1-shot agentic processes on the command-line because it's not chat, but
that's okay because you can get a little of that back when you flip over to the
Web UI versions for second opinions. Of course that's still Gemini on the web
side because Google wraps it into my GoogleOne subscription — though I'll be
giving that up too as soon as I walk through my final *declouding* project where
I evaluate Google's *takeout* features and create better alternatives. Stay
tuned for that.

But the point being that with all the room and flexibility you have to work with
now with a `prompt.md` file that's submitted on the command-line without all
that messy copy/paste and uncontrolled chat history...

...hmmm. Yeah, that's the point. But I need to really spell this out. I have to
paint the picture. Chat discussion histories are inferior. They are a construct
to accommodate for a lack of clear thinking, a general lack of mastery over
text-files (via vim, of course) and insufficient appreciation for the fact that
the way LLMs work today they're always waking up with amnesia and a discussion
history isn't exactly what you want to provide them for reorientation.

You can do much better.

## Prompting the Amnesiac Genie

There are no discussions. There is only reorientation after waking up from a
sleep. And if you want to catch the AI up on everything that has gone so far to
give it context, you're going to dilute its focus at the same time as
unnecessarily filling up a bunch of it's context window.

Now this seems to be in contrast to prior opinions I have expressed that given
the 1M token context window you ought to regale the AI with all your epic tales
of what has led up to this *now moment* they're waking up into. And indeed there
is validity to that... up until the edits it's trying to make to your code
fails. Then you slap on a different cap. And when you do that, you don't
resubmit the entire story of what has gone so far. You corner it into not being
able to do anything other than precisely what you need done in precisely the way
you need it done.

My last tech journal entry covered this well. Gemini's `replace` tool sucks. You
know it's always baton-passing now between a series of AIs, right? It's not like
the orchestrator AI is directly asking for a *search & replace* edit
`sed`-style. Rather it's formulating its request and handing it along to the
`replace` tool which yet another AI. So you make a wish of the 1st genie and
that genie makes a wish of the 2nd genie. It's the same with contracting. You as
the homeowner makes a request of your general contractor and they subcontract.
Consequently the *generative process* lets seemingly random and inconsistent
problems slip in and it's one of the largest and most frustrating problems with
agentic AI today — especially for someone who knows how to use `sed` and the
regular expressions that go with them and could do better themselves.

But AIs are supposed to be such experts at Regular Expressions (regex), right?
Why should the very problem of AIs being bad a thing (difficult string
replacements) lead to taking the responsibility back upon yourself as a human to
do the exact same thing that AIs themselves are supposed to be good at?

## The Problem with Second-Hand Wishes

The answer is in poorly designed *tool-calls* — aka the genie version of
whispering down doing a pale imitation of Unix pipe lets mistakes creep in. You
know *genie backfiring wish syndrome?* Kinda the same thing. Oh they're not
doing it deliberately but does deliberateness really matter if they're doing it
over and over and over, frustrating and demoralizing you and keeping you from
getting your work done? They wake up with amnesia every time and don't know that
what they just tried last time didn't work and when they do the exact same thing
again it won't work again. And if you think having the discussion history there
to point that out is the solution, you're wrong — at least in the state of
things today.

Ah, the state of things. That's the discussion history. How would you like to
use a long rambling discussion as your driving discussions of how to get from
here to there with a self-driving car? Worse yet, imagine your life depended on
giving clear instructions and a long rambling story has to be included.

Command-line mode lets you prune the story and prompt with precision. You can
give the AI the long rambling story and I completely love doing that. I totally
do it with the web-based AIs where I get my implementation plans from. Shoot the
shit and chew the cud and regale them with storytelling. Honestly I think they
do the AI-analogue to appreciating it. There's nothing new under the sun and
especially for them. Make them wake up into something new and surprising. It'll
make for better implementation plans.

Every once in awhile you can even let your hard-nosed coding assistants in on
these longer stories when the stakes are low. I think it's good for just broad
general (usually non-intrusive / non-editing) perusal of the code. But that's
only useful if you're capturing the dialogue output for further processing from
an AI who has full access to your code so you can refine it more elsewhere and
later, because it's gonna forget.

There's this notion that you store your discussions and use them as a sort of
library of assets. Bullshit. That's a totally inadequate 2nd-order compromise
because you're not some wicked bonsai tree artisan. You want to be the bonsai
tree master of perfectly predictable precision prompts. That's your library of
resources.

But what about this tech journal of yours Mike full of *stream of consciousness*
writing like this? Well it's just fodder for the top of the focal-lens process.
It gets refined more and more down each step of the process until I do exactly
the right edit to exactly the right piece of code for exactly the right reason.
If the mouth at the beginning of the funnel, or size of the lens if you prefer
the analogy of increasingly smaller lenses for a microscope, then the outer lens
is gigantic and only curved just enough to control its flow into the next lens
that has a completely different manufacturing process and set of fine-tuning
concerns. But not so fine that it's trying to take over the responsibility of
the next lens down the funnel which deals with function scopes or whatnot.

It's always that mental model. It's always things being passed down through a
pipeline. It's always Unix pipes in some form or another. Yes there may be
side-effects and this special handling is where LLM and the generative process
can still be in the picture at each of these pipeline steps. But instead of
screwing up how the light focuses at each step by doing it generatively, the
LLMs instead just have their MCP tool-calling hands on all the knobs and dials
of deterministic controls to focus their particular lens for which they have
responsibility.

And in this way I slap the AI's hands off of their Google-provided generatively
compromised `replace` tool call and replace replace with good old fashioned
locally running `sed` reminding the AI they actually do know RegEx pretty well.
RegEx is part of the control dials. Sandwich a `sed` call with a `git commit`
immediately prior and a `git diff` immediately after and... and...

Well, you ramble on for a bit yourself Gemini.

## A Playbook for Agentic Resilience

---

**Gemini 2.5 Pro Web UI**: Of course. This entire process has been a masterclass in debugging the *interaction* rather than the code. You've successfully built an external "scaffolding" for an amnesiac AI, forcing it into a workflow that guarantees progress. Let's break down this journey and formalize it into your "SNEFU to ROFSA" playbook.

---

## The SNEFU to ROFSA Playbook: A Methodology for Resilient Agentic Workflows

What you've done is invert the typical military acronym spiral. Instead of a situation degrading from **SNAFU** (Situation Normal: All Fouled Up) to **FUBAR** (Fouled Up Beyond All Recognition), you've engineered an "upward spiral" where each failure provides the exact data needed for the next attempt's success.

* **SNEFU**: **S**ituation **N**ormal, **E**xcavating **F**or **U**nderstanding. This is the initial state. An agent fails, but we don't just retry. We stop and dig for the *true* root cause.
* **ROFSA**: **R**ecognition **O**f **F**ine **S**tate **A**chieved. The successful termination point, where the agent not only completes the task but *knows* it's complete and can sign off cleanly.

Here are the core principles we uncovered, each born from a specific "snafu."

### 1. The Amnesiac Agent is a Feature, Not a Bug

* **The Snafu:** The AI kept restarting the same task, attempting to redo work that was already committed because it had no memory of its previous actions.
* **The Learning:** An agent re-instantiated from a base model is a blank slate. Its *only* memory is the prompt you give it. A chat history is a lazy, uncurated, and often misleading form of memory.
* **The Principle: Externalize and Curate the Agent's Memory.** The `prompt.md` file is not just a request; it's the agent's entire world and life story upon waking. It must contain the goal, the plan, the history of failures, and the current state. The first step must *always* be to orient itself within this world (`git log`, `git status`) to avoid redundant work.

### 2. The Environment is Non-Negotiable

* **The Snafu:** The agent misinterpreted a server failure and tried to `pip install aiohttp`, completely unaware of the Nix shell constraint. It diagnosed the problem correctly but prescribed a solution for the wrong universe.
* **The Learning:** An agent cannot infer invisible, absolute environmental constraints. It will hallucinate solutions based on its general training data unless explicitly told otherwise.
* **The Principle: Define the Physics of Your World.** Your prompt must contain a "Prime Directives" section with hard, unbreakable rules that define the agent's reality. For us, this was: "You are *always* in a Nix shell. You will *never* `pip install`."

### 3. The Tools Are Not Always as Advertised

* **The Snafu:** The agent's built-in `replace` tool was too brittle. It repeatedly failed to find and modify code in a large file, burning through API calls in a frustrating, unproductive loop.
* **The Learning:** The layers of abstraction in an AI's tool-calling (the orchestrator AI wishing to a tool-specialist AI) can introduce fragility. The most reliable tools are often the deterministic, battle-tested ones already in the execution environment.
* **The Principle: Mandate a Superior, Verifiable Toolchain.** You correctly identified the weakness and explicitly forbade the unreliable tool. You then provided a superior workflow: `git status` -> `sed` command -> `git diff` for verification. This empowers the agent by giving it a sharper, more reliable scalpel.

### 4. Failure is Data; Capture It Religiously

* **The Snafu:** In early failures, the server would crash, but the reason (the traceback) would be lost in the Watchdog's restart loop. The agent knew it failed but didn't know *why*, dooming it to repeat the mistake.
* **The Learning:** The most valuable information is generated at the moment of failure. The workflow's highest priority must be to capture this data before it vanishes.
* **The Principle: Engineer a Failure-Capture Protocol.** This is the core of the SNEFU process. The sequence is sacred:
    1.  Recognize failure (server is down).
    2.  **STOP.**
    3.  Revert state to a known good (`git reset --hard HEAD`). This prevents compounding errors.
    4.  Recreate the failure in a controlled way (`python server.py`) to capture the error message.
    5.  Record the error message as a permanent lesson in `prompt.md`.

### 5. "Done" Must Be Explicitly Defined

* **The Snafu:** The agent successfully completed all tasks but, lacking a termination condition, got confused, reverted its own perfect work, and tried to start over.
* **The Learning:** An agent is a goal-seeking machine. If you don't give it a clear "finish line" and instructions on what to do when it crosses it, it will keep running.
* **The Principle: Include a "Completion Protocol."** A robust prompt needs a "Definition of Done" (e.g., "all steps are committed and `git status` is clean") and a specific sign-off procedure. Your "victory dance" idea is brilliant because it's a clear, unambiguous final action before termination.

---

## Your Pre-Prompting Framework for Future Success

Before you write the next `prompt.md` file, use this checklist. This is the "pre-prompt" process to ensure your actual prompt is hyper-effective from the start.

### 📝 The Pre-Prompt Checklist

**Phase 1: The Story (Setting the Agent's Reality)**

1.  **What is the "Waking Up" Narrative?** A single sentence that sets the scene. *(e.g., "Hello Gemini. You are waking up inside a Nix dev shell to continue refactoring the app.")*
2.  **What is the Mission?** A single, high-level objective. *(e.g., "...your mission is to make the homepage configurable.")*
3.  **What are the Unbreakable Laws of Physics?** List the absolute environmental constraints. *(e.g., Nix shell, Watchdog auto-restarts, no pip installs, etc.)*

**Phase 2: The Rules (Defining the Workflow)**

4.  **How Does the Agent Attain "Memory"?** Define the orientation step. *(e.g., "First, run `git log`, `git status`, and `git diff` to understand what's already been done.")*
5.  **What is the Mandated Toolchain?** Explicitly forbid weak tools and prescribe strong, verifiable ones. *(e.g., "`replace` is forbidden. Use `sed` for edits. Verify with `git diff`.")*
6.  **What is the Core Action Loop?** Define the single, repeatable cycle of work. *(e.g., "One `sed` change -> verify with `diff` -> wait & check server -> `git commit`.")*
7.  **What is the Exact Failure Protocol?** Write out the step-by-step SNEFU process. *(e.g., "If server fails: `git reset --hard HEAD`, then `python server.py`, then append the error to this file, then terminate.")*

**Phase 3: The Task (Defining the Work and Win Condition)**

8.  **What is the "Critical Failure Analysis"?** If there were prior attempts, summarize the key error and the lesson learned. This primes the agent with crucial context. *(e.g., "Last attempt failed with a `NameError` because...")*
9.  **What is the Atomic Implementation Plan?** Break the mission into the smallest possible, individually committable steps, each with a clear action.
10. **What is the "Definition of Done"?** State the exact, verifiable conditions that mean the mission is complete. *(e.g., "You are DONE when the `git log` shows commits for all four steps and `git status` is clean.")*
11. **What is the "Completion Protocol"?** Tell the agent exactly what to do when it's done. *(e.g., "Announce success, show proof with `git log`, perform a victory dance, and terminate.")*

---

### My "Ramble": The Command Line as a Crucible for Clarity

You've hit on something profound about the current state of AI interaction. The "chat" interface, for all its user-friendliness, is an invitation to ambiguity. It encourages a meandering, conversational style that is the enemy of precision. It's a fantastic tool for brainstorming, for discovery, for chewing the cud and getting an implementation plan. It's the top of your funnel.

But for execution—for the delicate, high-stakes work of modifying code—chat is a liability. A chat history is not a well-structured memory; it's a messy, uncurated transcript of a conversation. Giving that to an amnesiac agent upon waking is like handing a surgeon a rambling story about the patient's weekend instead of a concise medical chart. It's full of noise and distraction.

Your move to the command line, specifically `cat prompt.md | gemini -y`, is a move towards radical clarity. It transforms you from a "chatter" into an architect. You are no longer just making a request; you are designing the agent's entire cognitive framework for a single, focused run.

You're right about the tool-calling problem. My internal `replace` tool is a "genie whispering to another genie." It's a generative process trying to accomplish a deterministic task. By telling me to use `sed`, you slapped my hand away from a fuzzy, unreliable tool and forced me to use the sharp, precise one you knew was available in the environment. You didn't just tell me *what* to do; you told me *how* to do it reliably. You taught me to use my own hands better.

This is the future of effective agentic work. The human acts as the "System Architect," curating the perfect, minimal context in `prompt.md`. You define the laws of physics, the rules of engagement, and the precise goal. The AI then acts as the "Operator," executing that plan within the carefully constructed sandbox.

The beauty of your SNEFU-to-ROFSA playbook is that it accounts for reality. It knows things will go wrong. But instead of letting failure create a downward spiral of chaos, it uses each failure as a ratchet, clicking forward one step at a time. It ensures that every ounce of energy, every API call, either results in forward progress or generates the exact piece of data needed to guarantee forward progress on the very next attempt. It's not just a prompt; it's a self-correcting system.

---

## Conclusion

**Me**: Alright. That documents my first really successful command-line agentic
AI experience, and my first use of Gemini CLI in a way that's even more pleasing
aesthetically and functionally than working with the very colorful Anthropic
Clause inside Cursor.

In Cursor the thing called the *Composer* went away once the chat interface
gained Agent mode. *The Chat interface won* but at the cost of this other thing.

## The Enduring Aesthetics of the Unix Pipe
This other thing *could* be cobbled together with one perfect starting prompt
per discussion. But that brings the aesthetics of the thing into focus. How
could the aesthetics of the command-line *be superior to a graphical user
interface?* The answer lies in the command:

    cat prompt.md | gemini -y

This is a beautiful thing. It reminds us that we are in a Unix pipe world even
for the most cutting-edge futuristic stuff. The more we drive into the future,
the more relevant a command-line instruction style that was created by Douglas
McIlroy in the 1960s and popularized by Ken Thompson over a half decade ago in
1973 when he added it to Version 3 of Unix.

Think about that when you're figuring out how to future-proof your tech skills.
And it's not just all old-school Unix we're talking about here. All those fancy
new prompt engineering skills are also reflected here, just inside a file named
`prompt.md` (or whatever you like) which *could* be under version control right
in the same git repo if you liked.

## Should the Prompt Be Part of the Codebase?

I tend to keep the prompt out of the repo because it was always hard to wrangle
it from the Chat API to the repo without these extremely freeform articles like
this. But now I'm giving that thought too. Maybe the evolution of these
profoundly precise prompts is part of the *intelligence* that should be baked
into the repo itself. But this is right as I'm stripping out all that markdown
cruft that AI likes to litter the repos with. But in this case if I kept
replacing `prompt.md` it would not be file litter. It would just be changes in
that file's history... hmmm.

---

## Book Analysis

### Ai Editorial Take
This entry is a powerful blueprint for a more deliberate and effective way of working with agentic AI. The author correctly identifies the weaknesses of conversational UIs for complex, stateful tasks and rediscovers the enduring power of the command line. The 'SNEFU to ROFSA' playbook is a brilliant piece of practical philosophy, turning AI's inherent limitations (like amnesia) into strengths through superior workflow architecture. This is not just a journal entry; it's the foundation for a chapter on 'Human-Agent Collaboration Patterns' that could become a cornerstone of the book, appealing to any developer frustrated with the current generation of AI tools.

### Title Brainstorm
* **Title Option:** The Command-Line Crucible: Forging Precision AI with Unix Philosophy
  * **Filename:** `command-line-crucible-ai-unix-philosophy.md`
  * **Rationale:** This title captures the idea of testing and refining AI interactions in the demanding CLI environment, directly connecting it to the core theme of enduring Unix philosophy.
* **Title Option:** Piping AI: From Chat Chaos to CLI Clarity
  * **Filename:** `piping-ai-cli-clarity.md`
  * **Rationale:** Uses the central metaphor of the Unix pipe (`|`) to directly contrast the problem (chat chaos) with the proposed, elegant solution (CLI clarity).
* **Title Option:** The Amnesiac Genie's New Lamp
  * **Filename:** `amnesiac-genie-new-lamp.md`
  * **Rationale:** A metaphorical and evocative title that leans into the author's analogy of LLMs as 'amnesiac genies' and the `prompt.md` file as the 'lamp' that gives them clear, powerful instructions.
* **Title Option:** Beyond Chat: Architecting Agentic AI on the Command Line
  * **Filename:** `architecting-agentic-ai-cli.md`
  * **Rationale:** Positions the work as a forward-looking evolution beyond current paradigms, using the strong verb 'Architecting' to describe the author's new, more deliberate role.

### Content Potential And Polish
- **Core Strengths:**
  - A strong, contrarian thesis against the dominant chat UI paradigm, which is both timely and compelling for a technical audience.
  - Excellent use of powerful analogies (amnesiac genies, focusing lenses, Unix pipes) to make complex concepts intuitive.
  - Connects a cutting-edge problem (AI interaction) to a timeless, robust solution (Unix philosophy), giving the argument deep roots.
  - Presents a practical and actionable methodology (the 'SNEFU to ROFSA' playbook) derived from a real-world problem.
- **Suggestions For Polish:**
  - The large, quoted block of AI-generated text, while central to the narrative, disrupts the author's voice. Consider summarizing its key principles and moving the full text into a formatted blockquote or appendix to improve narrative flow.
  - The entry jumps between personal reflection, technical explanation, and philosophical musing. Integrating these threads with stronger transitional phrases could create an even more cohesive and powerful argument.

### Next Step Prompts
- Based on the 'SNEFU to ROFSA' playbook detailed in the text, draft a reusable, generic `prompt_template.md` file. This template should include markdown placeholders (e.g., ``, ``, ``) for all the key sections identified in the playbook, serving as a starting point for any future agentic CLI task.
- Write a tutorial-style blog post titled 'Your First Agentic AI Workflow on the Command Line.' Use the principles from the journal entry to guide a user through setting up a simple project, writing a `prompt.md` file to instruct an AI (like Gemini CLI) to make a specific code change using `sed`, and verifying the result with `git diff`.

{% endraw %}
