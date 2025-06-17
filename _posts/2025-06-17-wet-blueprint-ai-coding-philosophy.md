---
title: "The WET Blueprint: Why Your Next App Should Repeat Itself"
permalink: /futureproof/wet-blueprint-ai-coding-philosophy/
description: "People are going to look at my Pipulate code and think it's repetitive or strange, so I have to lay out the argument right from the start. This isn't just another web framework; it's a deliberate philosophical choice. I'm making the case that the old rules of DRY development are breaking down in the face of AI and notebook-style programming. WET code, for all its supposed sins, offers a clarity and customizability that is incredibly powerful when you have an AI to help manage the 'tedious' parts."
meta_description: A blueprint for challenging DRY principles, arguing for WET (Write Everything Twice) workflows with Pipulate, a local-first framework using HTMX and AI.
meta_keywords: WET vs DRY, Pipulate, FastHTML, HTMX, coding philosophy, AI-assisted development, local-first, Nix, code convection, Literate Programming, software architecture, developer productivity, Python web framework
layout: post
sort_order: 1
---

## Setting the Stage: Context for the Curious Book Reader

This entry serves as the philosophical cornerstone for Pipulate, a local-first web framework designed for a new era of development. It directly challenges the long-standing "DRY" (Don't Repeat Yourself) principle, advocating instead for a "WET" (Write Everything Twice) approach. The author argues that modern tools, particularly Jupyter Notebooks for exploration and AI for maintenance, have fundamentally changed the trade-offs between abstract, reusable code and explicit, readable code. By leveraging technologies like FastHTML and HTMX to eliminate traditional JavaScript frameworks and templating languages, Pipulate aims to create a simpler, more transparent, and future-proof environment for building applications directly on your own machine. This text explains the "why" behind Pipulate's seemingly unconventional architecture.

---

## Getting WET With Pipulate

The purpose of this document is to make it as easy as possible getting started with designing Pipulate Workflows. 

At its heart Pipulate is yet another Flask derivative web microframework that uses conventional `@decorators` on functions to route web requests into those functions. The response from the function is the webserver's response to the browser. The webserver is represented as the conventional `app` Flask object. Pipulate is in that regard very much like FastAPI and everything that has gone before imitating Flask. 

Unlike FastAPI, Pipulate uses the Python functions themselves as the HTML templating language, doing away with an intermediary confusing mixed-language context of Jinja2 — which some people will be familiar with as the equivalent of Liquid Templates. That templating layer is removed because Pipulate uses FastHTML instead of FastAPI. 

Consequently, Pipulate code is going to look weird to both you and your LLM AI coding assistant until they catch up. We are trading one kind of confusing for another, but opting for a more future-proof and performant one. The solution to AIs wanting to believe it's FastAPI code they're looking at is to give them a preponderance of working code examples that make perfect sense.

Aside from the removal of an intermediate templating language, Pipulate manipulates the native browser document object model (DOM) directly by sending HTML fragments "over the wire" — the same way React or GraphQL might send JSON data. However instead of an intermediate client-side JavaScript library needing to receive, parse and process JSON, the HTML fragment simply hits its DOM-target exactly where it's supposed to and has exactly the effect it's supposed to. Again we have FastHTML to thank due to its support for the foundationally modernizing HTMX protocol. 

## Hitting the Metal: How Pipulate Is (and Isn't) Like Flask

If this all sounds weird to you, that's why we're putting it first in your introduction to making Pipulate Workflows. With both a templating language and JavaScript libraries stripped out, Pipulate "hits the metal" of the Web — yet does it in a future-proof and safe way (as intended). What does this look like?

A very typical Flask-inspired function looks like:

```python
@rt("/foo")
async def foo(): 
    return("bar")
```

The endpoint is `/foo` and hitting it returns the value "bar".

To turn that into over-the-wire HTML we return an HTML fragment to replace a pice of the DOM:

```python
@rt("/foo")
async def foo(): 
    return(Div("bar"))
```

### The HTMX Revolution: From JSON to Over-the-Wire HTML

The thing on your web page that calls it, because your web page is now a single-page application (SPA), knows where to route the response. So in a way it's a tale of two routers: one the Flask-way and the other the HTMX way:

```html
<div hx-get="/foo" hx-trigger="load" hx-swap="outerHTML">
    Loading...
</div>
```

Can you follow this thinking? This bit of HTML could be on a static web page. It does not even need code execution to call HTMX endpoints. This is the HTMX crawl before you walk level of understanding. It comes down to:

1. Server-side it's much like plain Flask. 
2. Browser-side you've got new `hx-[action]` attributes on all your standard HTML elements 🤯

With this simple fact, React, Angular, Vue and even Svelte all become unnecessary. It's an approach that favors an always-available chatty webserver spewing web frags like Dave Chappelle or Bill Burr spewing shards of truth right into your DOM. The approach doesn't necessarily enterprise-scale but it is particularly useful for a replacing the Electron platform for local apps with Web UIs. That's what Pipulate is. 

### A Philosophy of Local-First, Future-Proof Development

We're not trying to start a revolution here, except maybe on localhost, but if you add in this one teensy weensy extra little fact that all the work you do is runnable as-is without modification nor even alternative versions for a Mac or Windows, then you have you have a holy grail people have been searching for forever. It's future-proofed at the application level because of HTMX's tight coupling to the HTML standard (not going away anytime soon) and at the platform level with OS-normalization using Nix. You know, Unix, Linux, \*nix. The long-awaited promise of universal interoperability has arrived — no Docker required. 

The version of the above static HTMX code can also be expressed in dynamic Python server-side code under FastHTML to reveal how template languages are eliminated with aptly named Python functions, aka FT components:

```python
@rt("/")
async def index():
    return Doc(
        Body(
            Div("Loading...", hx_get="/foo", hx_trigger="load", hx_swap="outerHTML")
        )
    )
```

So yes, Pipulate code will look confusing at first and we are sorry for that. But we are not sorry that we are gently leading you into the future of web development where less is more, hosting issues go away, and local concerns trump enterprise ones. 

If you ever investigated native desktop app development for Windows or Mac and found TK, QT or Chrome-based Electron as multi-platform development choices, then you get what's going on here. Pipulate is similar to the Electron approach — using the browser as the user interface (UI), but instead of NodeJS and custom-installers, it's generic Linux with a Python web stack and only one installer for all platforms.

Standards, standards and more standards

## WET Notebooks & AI 

Easy transplants and code convection are tenants of WET coding workflows. Let me explain. 

WET stands for:

- Write everything twice 
- Write explicit/thoughtfully 
- We enjoy typing!

## The DRY Dogma and the WET Rebellion

Advocates of DRY will outright get angry at you for repeating yourself. They think nothing in existence should happen or be expressed any more than precisely that one canonical first time and all other instances should be references pointing to the pure perfect one. 

I think about the same of this as I do fat client-side JavaScript libraries. The former (DRY) makes you terrified to write a line of code and the later (fatJS) ensures that any code you do write will break within a year. I got out of Web Development after jQuery but before Bootstrap and Tailwind. Those classes have no place in my old school. 

Everything old is new again, and so now is beautifully in-between abstraction layers that let you speak expressively without overloading it with low-level implementation noise. There's a give and take. You're not going to remove completely isolating it behind wrappers behind wrappers behind wrappers. I mean sure maybe if you're Apple making the iPhone, but we can't all be Apple. There are happy mediums.

The WET coding methodology (versus DRY) strives to strike that balance. 

If the DRY camp were right, we would all stop talking and only use numbers referencing past discussions that have already happened. We would speak in the vector embedded token language that underlies LLM. In fact they do. They just translate it back into plain old WET English words so we can actually read it and interact with them. 

### The Sheet Music Analogy: Why Readability Trumps Reference

Sheet music is an excellent example. If the DRY camp won out over sheet music, composers and musicians would have to flip pages in the middle of a performance to go see what this pointer to a stanza that occurred before but happened to repeat originally was. It sounds ridiculous but this is what DRY is for machine efficiency and code management purposes. If you change the one original canonical instance everything else copy/pasted from, you don't want to go updating the potentially thousands of reuses with dangerous cross-file search and replaces. No, you generally want to just change it in one place and have all the references updated. That's DRY (don't repeat yourself) and it loosely goes hand in hand with object oriented programming (OOP). The sheet music vs. programming code shows the dramatic tension that can exist. And you'd think that DRY clearly wins/won/should-stay-won in program code, but you'd be wrong because: 

1. Notebooks
2. AI

Notebooks promote Literate Programming, a concept coined by Donald Knuth, by which working program code is embedded right into a "notebook" with the documentation of that same said code all around it. 

Now the big supporting frameworks that make DRY OPP programming style work so well in more traditional desktop or mobile apps don't work so well in notebooks. The user looks at the code and wonders: "What's inheriting from what which is why where whozit?" Notebooks get moved around to different host OS enforcements and paths change and dependencies break. And that's just on the moving-parts front. 

DRY OOP coding style is not only technically more challenging in notebooks but it also reduces the clarity of code by nature of it abstracting away important details about what's happening with the code that you can't just easily visually trace. Humans often read from left to right and from top to bottom in a lawnmower like sweeping search pattern to make sure everything happens. Code execution jumps around. This is okay and is as it should be — the essence of functions — it just doesn't help code legibility for the uninitiated. It creates the CompSci snob divide. 

Okay, so functions make the order of execution jump around and our natural spoken language tendencies need to adapt to new behavior. Fine. The benefit is worth it. The big conceptual leap is that functions can be organized differently. You can either just list them out — in *"global space"* such as it were, or you can nest them inside each other as a sort of hierarchical organization so they get carried around with their parent functions to always be there where they're going to be needed. That's OOP. In this case the parent function is called a *"class"* and the child functions are called *"methods"* — go figure. At least in the C/Java world they are. 

Python doesn't split hairs. It's all `def`'s to Python — a function, class or method by any other name operates much the same — and needs to be *defined,* hence definition or def. 

Python also supports whatever programming style you choose, OOP or not. Not is often called *procedural* or... [fill in the word] — and not *functional* as you might imagine. Though Python to a limited degree supports the functional programming style too with its `lambda` keyword — essentially saying "don't give this function a name and when it's done executing make it as if it didn't exist." This later style of programming being useful for writing extremely stable and bug-free software like that of air traffic control, though it had plenty of utility elsewhere. 

### How AI Makes WET Work: Easy Transplants & Code Convection

Sorry, I know it's all a bit complicated and confusing. But that's exactly what the WET movement is about. We of the WET camp believe getting WET is half the fun. You learn by doing and that's often in Notebooks where the other programming styles are challenged. 

Oh, did I mention AI? Take it from here, Gemini. When it comes to the previously tedious code transplants that WET search-and-replace calls for over DRY inheritance and the tedious work of giving your code a natural sort of out-with-the-old and in-with-the-new convection that keeps it both explicit (understandable to the casual reader), highly customizable (easier WET than DRY) and the latest (hard to do with frequent risky cross-file search & replaces)...

---

## What Does Gemini 2.5 Pro Think About WET?

**Gemini**: You've presented a fascinating and provocative argument for WET (Write Everything Twice) coding, especially in the context of modern development trends like notebooks and AI. It's a fresh perspective that challenges the established wisdom of DRY (Don't Repeat Yourself).

Let's break down your points and explore how AI further supports the WET philosophy, particularly regarding "easy transplants" and "code convection."

The WET vs. DRY Debate: A Reframing 🧐

You've cleverly reframed the DRY mantra, highlighting its potential drawbacks: fear of writing code and the fragility of overly abstract systems. Your analogy of speaking in numerical references versus plain English powerfully illustrates how extreme DRY can hinder human comprehension and interaction.

The sheet music analogy is particularly insightful. While DRY in programming aims for a single source of truth, sheet music often repeats musical phrases for legibility and performance flow. The "dramatic tension" you describe between these two paradigms in programming is precisely where the WET argument gains traction.

You argue that while DRY might seem to "win" for machine efficiency and code management, its victory is not absolute, especially with the rise of notebooks and AI.

Notebooks and the WET Renaissance ✍️

You correctly point out that notebooks, by promoting Literate Programming, inherently lean towards a more WET approach. In a notebook, the emphasis is on immediate clarity and sequential understanding. Deep inheritance hierarchies and complex abstractions, hallmarks of traditional OOP and DRY, can indeed obscure the flow of execution and make code harder to follow for humans.

The "What's inheriting from what which is why where whozit?" frustration is a common experience in notebooks when trying to apply rigid DRY principles. Notebooks thrive on explicit, self-contained blocks of code that are easy to read and execute sequentially. This often means repeating code snippets that might otherwise be abstracted away in a DRY codebase. This repetition, in the WET philosophy, is not a bug but a feature, enhancing readability and maintainability within the notebook environment.

AI and the WET Advantage: Easy Transplants & Code Convection 🤖

This is where your argument truly shines. AI, particularly large language models (LLMs) like myself, fundamentally shifts the landscape of code management and generation, making WET not just palatable but often advantageous.

Easy Transplants with AI 🤝

You touch upon the "tedious code transplants that WET search-and-replace calls for over DRY inheritance." Traditionally, this was a significant pain point for WET. If you had many copies of a similar code block, changing one meant meticulously finding and updating all the others. This is precisely where DRY's "single source of truth" was powerful.

However, AI dramatically changes this:

 * Intelligent Refactoring: AI can perform highly intelligent and context-aware search-and-replace operations. Instead of simple text matching, an AI can understand the intent of the code. If you modify one instance of a repeated code block, AI can suggest or even automatically apply similar, semantically correct changes to other instances, even if they're not exact textual duplicates. This significantly reduces the "tedious" aspect of WET transplants.
 * Code Generation and Adaptation: AI can generate new code snippets or adapt existing ones based on a natural language prompt or a few examples. This means that instead of copying and pasting, and then manually modifying, you can often just tell the AI what you want, and it will "transplant" a suitable code structure for you, often with the necessary modifications already applied. This makes the creation of similar-but-not-identical code much faster and less error-prone.
 * Version Control Integration: AI-powered tools integrated with version control systems can help manage and reconcile changes across WET-style codebases, making it easier to track and merge modifications even when there's repetition.

Code Convection with AI ♻️

You also mention "the tedious work of giving your code a natural sort of out-with-the-old and in-with-the-new convection that keeps it both explicit... highly customizable... and the latest." This concept of "convection" – the natural flow and updating of code – is another area where AI excels in a WET context:

 * Enhanced Readability (Explicit Code): WET, by its nature, promotes explicit code. When code is repeated, it's often because it's self-contained and immediately understandable in its local context, without needing to jump to abstract definitions. AI, when assisting with code generation or analysis, thrives on this explicitness. It's easier for an AI to understand and work with a block of code whose purpose is clear from its immediate vicinity, rather than having to resolve complex inheritance chains.
 * High Customizability: Because WET code is often less coupled by strict inheritance or abstract interfaces, it becomes inherently more customizable. You can easily tweak a repeated block of code for a specific use case without fearing ripple effects across a complex DRY system. AI further empowers this by making it trivial to generate variations of existing code blocks tailored to new requirements.
 * Keeping Code "Latest" and Secure: AI can be used to scan WET code for outdated practices, security vulnerabilities, or opportunities for modernization. Instead of a single, highly abstracted component potentially becoming a bottleneck for updates, WET allows for more granular, localized updates. AI can assist in identifying these areas and suggesting modern alternatives, facilitating a continuous "convection" of best practices throughout the codebase. The "risky cross-file search & replaces" that DRY tries to avoid can be made significantly less risky with AI's contextual understanding and refactoring capabilities.

Conclusion: The Resurgence of WET 💦

You've articulated a compelling case for WET coding, particularly in the evolving landscape of software development. While DRY remains valuable for certain types of applications and within specific architectural patterns, the rise of notebooks and the capabilities of AI are creating a powerful argument for a more contextually aware and human-centric approach to code organization.

WET, as you define it, isn't about mindless repetition. It's about:

 * Clarity and Readability: Prioritizing immediate understanding over abstract efficiency.
 * Learn-by-Doing: Facilitating exploration and iteration, especially in environments like notebooks.
 * AI-Enhanced Workflows: Leveraging AI to manage the perceived drawbacks of repetition, turning them into advantages for rapid development, easy customization, and continuous improvement.

Perhaps the future of coding isn't a strict adherence to DRY or WET, but a nuanced understanding of when and where each philosophy, augmented by AI, can best serve the goals of clarity, maintainability, and innovation. Your "beautifully in-between abstraction layers" and "happy mediums" resonate deeply with this perspective. The "CompSci snob divide" might just shrink as AI empowers more people to write and understand code, regardless of their mastery of complex abstractions.

---

## Time to Show Gemini the Pipulate README.md

**Me**: pastes Pipulate's Github repo [README.md](https://github.com/miklevin/pipulate/blob/main/README.md)

**Gemini**: You've laid out an incredibly comprehensive and thought-provoking vision for Pipulate, weaving together a strong philosophical stance on WET workflows with practical, modern technologies. It's clear you're building something that directly addresses many pain points in current development paradigms, especially for local-first, AI-assisted applications.

Pipulate: The WET-Powered Local-First AI SEO Powerhouse 🚀

Pipulate emerges as a free and open-source desktop app framework designed to revolutionize AI-assisted workflows, particularly for SEO practitioners. It champions a local-first, single-tenant approach, ensuring privacy, control, and performance by keeping all data and processing on your machine. This eliminates cloud costs, vendor lock-in, and the frustrations of cloud-based notebooks.

At its heart, Pipulate embraces WET (Write Everything Twice/Explicit) workflows. This means workflows are explicit, step-by-step, and easy to understand, directly challenging the conventional wisdom of DRY (Don't Repeat Yourself) for these specific use cases. This design choice is particularly potent when combined with local AI (Ollama) and the Jupyter Notebook-inspired workflow patterns.

Core Principles Driving Pipulate's Innovation 💡

Pipulate's philosophy is a refreshing blend of simplicity, reproducibility, and future-proofing:

 * Local-First & Single-Tenant: Your data stays yours. Pipulate runs entirely on your local machine, maximizing performance by leveraging your CPU/GPU for LLMs and scraping, while safeguarding your privacy.
 * Simplicity & Observability ("Know EVERYTHING!"): By intentionally avoiding complex enterprise patterns (like heavy ORMs or client-side state management), Pipulate keeps its state transparent and easy to debug. It's a return to the "old-school webmaster feeling" with a modern twist.
 * Reproducibility with Nix Flakes: The "works on my machine" problem is solved. Nix Flakes ensure an identical development and runtime environment across macOS, Linux, and even Windows (via WSL). This makes Docker obsolete for many user-based scenarios.
 * Future-Proofing: Pipulate builds on durable, "love-worthy" technologies: standard HTTP/HTML (via HTMX), Python (AI-supercharged), Nix, and local AI (Ollama). This combination aims to reduce the "idea-to-implementation friction" indefinitely.
 * WET Workflows, DRY CRUD: This is a critical distinction. Workflows, especially those ported from Jupyter Notebooks, benefit from their explicit, step-by-step nature (WET), making them clear and debuggable. Conversely, standard Create, Read, Update, Delete (CRUD) operations leverage a reusable BaseCrud class for efficiency (DRY). This balanced approach acknowledges that while "DRY is fly," the age of "wapidly written WET code is upon us because AI."

Key Technologies & Architecture 🏗️

Pipulate seamlessly integrates a curated stack of powerful tools:

 * FastHTML: A Python web framework that generates HTML directly from Python objects, eliminating templating languages and minimizing JavaScript.
 * HTMX: Powers dynamic, interactive UIs by enabling server-rendered HTML updates, moving away from fragile, JSON-dependent frontend frameworks.
 * MiniDataAPI: A lightweight layer for SQLite and other databases, prioritizing simplicity and Python dictionary-like schema definitions over complex ORMs.
 * Ollama: Enables running Local LLMs directly on your machine for private, cost-effective AI capabilities like in-app chat and workflow guidance. Your "Chip O'Theseus" AI learns and grows with you, even supporting MCP-calls for advanced automation.
 * Nix Flakes: The backbone for reproducible environments, ensuring consistent setups across operating systems and providing optional CUDA support for GPU acceleration.
 * SQLite & Jupyter Notebooks: Foundational for data persistence and workflow development. A full JupyterLab instance shares the same Nix-managed Python environment, providing an unparalleled development experience.

Pipulate's architecture emphasizes a server-side state management with transparent JSON blobs, creating a "Know EVERYTHING!" environment. Its pipeline workflows are designed to be resumable, interrupt-safe, and create excellent training data for fine-tuning models, all while keeping proprietary data safely on your machine.

Empowering Developers and End-Users 👥

Pipulate aims to serve two primary audiences:

 * End-Users (e.g., SEO Practitioners): They can run powerful, AI-guided workflows (often ported from Jupyter Notebooks) without needing to touch Python code, free from the frustrations of cloud services.
 * Developers: They gain a simple, reproducible environment to build these workflows, leveraging integrated tooling, local LLMs, and a streamlined web framework.

Pipulate provides an enhanced development ecosystem with a "Proven 4-Tool Helper System" (create_workflow.py, splice_workflow_step.py, manage_class_attributes.py, swap_workflow_step.py), Interactive Development Assistants (Pattern Validation, Issue Debugging, Coding Instructions), and a Comprehensive Implementation Guide. These tools are designed to eliminate common mistakes, accelerate development, and provide expert guidance.

The WET Advantage with AI: "Easy Transplants" & "Code Convection" in Practice 🌊

Your concept of WET workflows (explicit, step-by-step) directly addresses the challenges you highlighted earlier, and Pipulate is built to leverage AI to make this effective:

 * Easy Transplants: In a WET environment, where code might be repeated for clarity, AI becomes a powerful ally. While a traditional DRY advocate might cringe at manual "search-and-replace" for consistency, AI-powered refactoring can intelligently identify semantically similar code blocks and suggest or even automate consistent changes across your explicit, step-by-step workflows. This transforms a tedious manual task into an AI-assisted one.
 * Code Convection: This refers to the natural evolution and updating of code. WET workflows, being explicit and less tightly coupled by deep inheritance, are inherently more customizable and easier to modify in isolation. AI further facilitates this "convection" by:
   * Maintaining Explicitness: AI can help generate or modify code that remains clear and understandable in its local context, reinforcing the WET philosophy.
   * Simplifying Customization: The ability to easily tweak a specific step without cascading effects is a core WET strength. AI can assist in generating these tailored modifications.
   * Keeping Code "Latest": AI can analyze explicit workflow steps for outdated patterns, security vulnerabilities, or opportunities for optimization, guiding developers to implement updates precisely where needed without the risk of breaking complex, hidden dependencies.

In essence, Pipulate posits that the perceived drawbacks of WET (like managing repeated code) are negated by the intelligent assistance offered by local AI, turning them into advantages for clarity, rapid iteration, and specialized application development.

Installation & Getting Started 🛠️

Installation is straightforward, primarily involving two terminal commands:

 * Install Nix: curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
 * Install Pipulate: curl -L https://pipulate.com/install.sh | sh (or with a custom name).

Once installed, navigate to the Pipulate directory (cd ~/pipulate) and run nix develop to activate the environment and start the Pipulate server and JupyterLab.

Pipulate represents a bold, opinionated stance on software development, prioritizing user agency, transparency, and a pragmatic approach to AI integration. It's designed for those who want powerful tools without the hidden complexities and dependencies of the cloud, proving that cutting-edge AI can thrive in a local, open-source ecosystem.

---

## And Now Over to Claude 4 Sonnet in Cursor AI

> This is the LLM AI that actually works with the code in-context and just prior
> to me showing it this article carried out some clever WET work.

**Me**: [Pastes article so far to Claude in Cursor after helping with a WET task]

**Claude**: This is an excellent blueprint for the WET philosophy and Pipulate's approach! You've articulated a compelling case for why the traditional DRY orthodoxy needs to be reconsidered in the age of AI and notebooks. Let me highlight some of the strongest arguments and suggest a few areas that could be expanded:

## Strongest Arguments 💪

### 1. The Sheet Music Analogy
Your comparison between DRY programming and hypothetical sheet music that uses pointers instead of repeating passages is brilliant. It perfectly illustrates how DRY can harm **human readability** in favor of **machine efficiency**. Musicians need to see the notes where they play them, not flip pages mid-performance to find references.

### 2. The "CompSci Snob Divide" 
The observation that DRY OOP creates barriers to understanding is spot-on. When code execution jumps around through inheritance chains, it becomes harder for both humans and AI to follow the logical flow. WET workflows that read like a recipe are more accessible.

### 3. AI as the Game Changer
The key insight that AI transforms WET's main weakness (tedious search-and-replace) into a strength is the crux of your argument. AI can now handle the "code convection" that keeps WET code current and consistent across repetitions.

## Areas to Expand 📈

### 1. Concrete Before/After Examples
Consider adding a side-by-side comparison showing:
- A DRY workflow with inheritance and abstractions
- The same workflow in WET style with explicit steps
- How AI assists with maintaining the WET version

### 2. The Debugging Advantage
WET workflows are **dramatically** easier to debug because:
- Each step is self-contained and observable
- You can inspect state at every stage
- No hidden dependencies or mysterious inheritance chains
- Perfect for the "Know EVERYTHING!" philosophy

### 3. The Notebook-to-Production Pipeline
Expand on how Pipulate bridges the gap between:
- Notebook exploration (naturally WET)
- Production workflows (traditionally DRY)
- AI-assisted evolution of both

## Suggested Refinements ✨

### 1. Acknowledge DRY's Domain
Be explicit about where DRY still wins:
- System infrastructure and frameworks
- Widely-used utility functions
- Security-critical components
- Your own example: "WET workflows, DRY CRUD"

### 2. The Learning Curve Investment
Address that WET requires:
- More initial typing
- Discipline to keep repeated code in sync
- Trust that AI will handle the maintenance burden

### 3. The "Convection" Metaphor
The thermal convection analogy is fascinating but could be explained more clearly:
- Old code naturally "rises" to be replaced
- New patterns "sink" into the codebase
- AI acts as the heat source driving the circulation

## The Bigger Picture 🎯

What you're really describing is a **paradigm shift** where:
- **Human comprehension** trumps **machine optimization**
- **Local-first AI** changes the maintenance equation
- **Explicit workflows** become more valuable than **abstract frameworks**
- **Notebooks** are first-class citizens, not afterthoughts

This aligns perfectly with the broader movement toward:
- Local-first software
- AI-augmented development
- Simplified, observable systems
- Developer experience over enterprise architecture

The document effectively positions Pipulate not just as another web framework, but as a **philosophy** for how software should be built in the AI era. The combination of WET workflows, local AI, and reproducible environments (via Nix) creates a compelling vision for the future of development.

The key insight that **AI makes WET practical** while **WET makes AI effective** is the kind of symbiotic relationship that could define the next generation of development tools.

---

## Book Analysis

Here is a multi-task analysis of the provided entry, structured to transform it into foundational material for a tech book.

## Crafting Compelling Narratives: Title & Filename Brainstorm

* **Title Option 1:** The WET blueprint: Why Your Next App Should Repeat Itself
    * **Filename:** `wet-blueprint-ai-coding-philosophy.md`
    * **Rationale:** This title is provocative and frames the entry as a foundational, opinionated text. It captures the core "WET vs. DRY" debate and appeals to readers interested in development philosophies and high-level strategy. The slug is rich with primary keywords.

* **Title Option 2:** Code Convection: How Local-First AI and HTMX Make WET Code Viable
    * **Filename:** `code-convection-wet-htmx-ai.md`
    * **Rationale:** This title introduces the author's unique "code convection" metaphor and ties it directly to the enabling technologies (AI, HTMX). It attracts a more technical audience interested in how specific tools change architectural patterns.

* **Title Option 3:** The Case Against Abstraction: Building with Pipulate, FastHTML, and HTMX
    * **Filename:** `pipulate-fasthtml-htmx-abstraction.md`
    * **Rationale:** Focuses directly on the technologies and the core technical argument (reducing abstraction). It's perfect for readers searching for practical examples of building apps with this specific stack.

* **Preferred Option:**
    * **Title (plain text for YAML):** The WET Blueprint: Why Your Next App Should Repeat Itself
    * **Filename:** `wet-blueprint-ai-coding-philosophy.md`
    * **Rationale:** This title is the strongest because it's bold, memorable, and perfectly encapsulates the entry's central, contrarian theme. It sets the stage for a paradigm-shifting discussion and is the most compelling hook for a book chapter that aims to challenge conventional wisdom.

## Book Potential Analysis

* **Strengths as Book Fodder:**
    * **Strong Philosophical Core:** It provides a powerful "why" that grounds the entire project, making it more than just a technical tutorial. This is a ready-made blueprint.
    * **Memorable Analogies:** The sheet music and "speaking in vector embeddings" analogies are excellent teaching tools that make the abstract WET vs. DRY debate tangible and understandable.
    * **Authentic Voice:** The raw, opinionated, and conversational tone provides an authentic "from the trenches" perspective that is often missing from sterile technical books.
    * **Connects to Major Trends:** It successfully links its philosophy to three major industry shifts: local-first software, the rise of AI-assisted development, and the push for simpler web stacks (HTMX).

* **Opportunities for Enrichment (for Book Adaptation):**
    * **Add a "Key Principles" Summary Box:** Create a concise, scannable box list summarizing the core tenets of the WET philosophy as presented (e.g., "1. Prioritize Readability," "2. Embrace Explicitness," "3. Leverage AI for Maintenance").
    * **Create a Simple Visual Diagram:** A small diagram contrasting a DRY (abstracted) function call stack with a WET (linear, explicit) workflow would powerfully illustrate the "CompSci Snob Divide" concept.
    * **Explicitly Define the Target Audience for WET:** Add a short section clarifying who benefits most from this approach (e.g., solo developers, small teams, domain experts, rapid prototypers) and where traditional DRY is still king (e.g., large enterprise systems, core libraries).

## AI Editorial Perspective: From Journal to Chapter

This entry is far more than a simple technical log; it's a foundational blueprint that could serve as a powerful opening chapter for a book on modern, pragmatic software development. Its value lies in its raw authenticity and strong, contrarian voice. Where most technical books explain *how*, this entry excels at explaining *why*, which is infinitely more compelling.

This material would be a perfect anchor for a chapter titled **"The WET blueprint: A New Philosophy for the AI Era."** It successfully reframes a decades-old debate (WET vs. DRY) through the lens of today's most disruptive technologies: notebooks and AI. The argument that AI doesn't just enable WET but *thrives* on its explicitness is a profound insight that could resonate deeply with developers feeling the friction of legacy abstractions in a world of generative tools.

The "in-the-moment" journal style is a feature, not a bug. With light editing to add structural elements like the subheadings and summary boxes proposed, it would retain its energy while becoming more accessible. It reads like a passionate developer sharing a hard-won secret, making it an engaging and memorable piece that sets a unique and compelling tone for an entire book.

## Suggested Next AI Processing Steps

1.  **Task Suggestion 1:** Generate Explanatory Analogies.
    * **Potential Prompt Snippet for Next AI:** "Based on the 'Code Convection' metaphor in the text, generate two new, simple analogies to explain what it means for a codebase. One should be from a non-technical domain (like cooking or gardening), and the other should be a simple software-related example."

2.  **Task Suggestion 2:** Draft a "Principle in Practice" Section.
    * **Potential Prompt Snippet for Next AI:** "Review the provided text and the Pipulate README. Draft a short, practical section titled 'WET in Action: The Hello World Workflow'. Explain how the `step_01` and `step_02` methods in the `HelloFlow` class exemplify the WET philosophy of explicit, readable, and self-contained logic."

