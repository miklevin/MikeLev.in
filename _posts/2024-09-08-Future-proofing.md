---
title: Future-proof Your Tech Skills
permalink: /futureproof/future-proof-tech-skills/
description: This article advocates for a "future-proof" approach to tech skills, focusing on mastering fundamental tools like Linux, Python, vim, and git (the "LPvg stack"). This approach emphasizes adaptability, independence, and long-term relevance in a rapidly changing technological landscape. It encourages professionals to develop technical skills as a complement to their domain expertise, enabling them to better serve clients and navigate the evolving world of AI and automation. The article also highlights the importance of clear communication protocols between humans and AI systems, as well as the benefits of leveraging local AI infrastructure for greater control and flexibility.
layout: post
---

I believe in mastering a set of fundamental, versatile tools that I call the "LPvg stack". These form the core of what I consider a future-proof skill set. I advocate for avoiding the "hamster wheel" of constantly chasing the latest tech trends and instead focusing on timeless fundamentals that remain relevant across different eras of technology.

## Bridging Domain Expertise with Technical Mastery

You don't have to be a dedicated developer to benefit from these technical skills. I advocate for a different approach that puts service and client needs first:

1. Become an expert in your chosen field or domain - whatever truly excites you and serves your clients' needs.
2. Develop tech skills as a complementary toolset to enhance your primary expertise and deliver better results.
3. Remember that technical skills should support, not overshadow, your core mission of serving clients or pursuing your passion.

This combination allows you to:

- Maintain independence while staying focused on client outcomes
- Automate tasks to spend more time on high-value client work
- Bridge the gap between your field and technology to better serve clients
- Adapt quickly to technological changes that affect your clients
- Prototype and implement solutions that directly address client needs

The goal is to empower professionals to leverage technology effectively while keeping client service at the forefront. This balance creates unique opportunities at the intersection of domain expertise, tech skills, and client success.

## Building a Future-Proof Development Arsenal

This toolkit offers a pragmatic approach to software development, emphasizing independence, adaptability, and sustainability. By leveraging open-source and AI-enhanced components, it helps developers create portable applications that avoid vendor lock-in and complex frameworks. The result is a flexible solution that promotes consistent workflows, builds valuable muscle memory, and ensures applications remain relevant as technology evolves. Focusing on open standards and portability serves as a form of future-proofing, allowing for scalability without sacrificing autonomy.

## Crafting a Cross-Platform Development Environment

This approach showcases the connection of fragmented tools and concepts into a cohesive development workflow. By mastering Linux, Python, Vim, and Git, and leveraging technologies like NixOS, Nix Flakes, JupyterLab, CUDA, FastHTML, and local LLMs, developers can create a portable, reproducible environment ready to spin up at any moment, anywhere. This foundation prioritizes agency in development, offering a consistent starting point for any project while avoiding over-engineering. The result is a streamlined approach that balances practicality and reusability, making it easier to focus on solving problems and creating new solutions without getting lost in architectural abstraction.

## The LPvg Stack: A Time-Tested Foundation

While AI may seem to herald unprecedented change, it's important to remember that humanity has successfully navigated through the industrial, atomic, and information ages. We've always found ways to adapt. This current shift is yet another opportunity to evolve our way of living and working. As you embark on this journey of adaptation, consider following the path I've taken as a 50-something professional: cultivating neuroplasticity, sidestepping the relentless "hamster wheel" of tech trends, and instead mastering a carefully curated set of versatile, timeless tools. Throughout this site, I'll guide you through my focus areas:

- **Linux, Python, vim & git**: Mastering the future-proof LPvg minimum subplatform
- **Re-acquiring Math Skills**: Picking up where my 1970s K-12 education let me down
- **Staying at the Top of My Field**: Protecting my earning capacity as things change
- **The minimal tool-chain for AI**: Expanding LPvg to include vector databases, etc.

<div class="mermaid">
graph TD
    A[Tech Skills] --> B{Choose Path}
    B -->|Hamster Wheel| C[Constant Churn]
    B -->|Future-proof| D[LPvg Stack]
    C --> E[Vendor Lock-in]
    C --> F[Subscription Fees]
    C --> G[Rapid Obsolescence]
    D --> H[Linux]
    D --> I[Python]
    D --> J[vim]
    D --> K[git]
    D --> L[Nix/NixOS]
    H --> M[Fundamental Skills]
    I --> M
    J --> M
    K --> M
    L --> N[Reproducible Environments]
    M --> O[Resist Obsolescence]
    N --> O
    O --> P[Long-term Viability]
</div>

## The Enduring Power of Text-Based Computing

It's all about text files and pushing bits around. Even after the rise of AI,
this fundamental concept will persist. User interfaces may change, and barriers
for entry will lower for non-programmers, but interacting with AIs won't absolve
you from learning to code. It just makes initial sketching easier. However,
complex problems remain complex.

While Jensen Huang says you won't have to learn to code and calls Python weird,
he admits that the first time you talk to AI will be in English, but the second
time it can <a href="https://www.youtube.com/shorts/NSBdLouwEDM">give you the
Python code</a>. See the contradiction? You won't need to learn coding unless
you want to do second-pass refinements. English isn't reliable enough to build
automated systems around, and Python has become the lingua franca of tech.

## Mastering Human-AI Communication

The LPvg stack becomes even more powerful when we consider how to effectively communicate with AI systems. The key to future-proofing your skills isn't just about using AI tools - it's about establishing reliable communication protocols between humans and machines.

### Building Robust Communication Protocols

While LLMs excel at natural language, automation requires more structured communication. The future-proof approach is to:

1. Use simple, well-defined JSON structures as an intermediary language
2. Implement validation functions that both humans and AIs can understand
3. Create clear input/output contracts that survive API changes

This approach allows domain experts to effectively "download" their expertise into AI systems without expensive training or fine-tuning - similar to Neo learning Kung Fu in The Matrix, but real and practical.

### Leveraging Local AI Infrastructure

The LPvg stack naturally supports running small, efficient AI models locally:

- Linux provides the operating system foundation
- Python offers excellent AI/ML libraries
- vim enables quick editing of prompt templates
- git tracks changes in AI behavior

This combination lets you build reliable AI-integrated systems that run on basic hardware, avoiding vendor lock-in while maintaining control over your tools and data.

### Designing Sustainable AI Systems

When building AI-integrated systems, focus on:

1. Reducing code surface area for easier AI comprehension
2. Using asynchronous communication channels (like email queues)
3. Building self-documenting systems that both humans and AIs can learn from
4. Maintaining simple, consistent interfaces for long-term stability

The goal isn't to chase the latest AI trends, but to build sustainable systems that gracefully incorporate AI capabilities while remaining maintainable and understandable.

## Escaping the Technology Hamster Wheel

Tech fads reset every 5 to 10 years. If you're on that hamster wheel, such as
with modern JavaScript frameworks, you go from Angular to React to Vue to
Svelte, constantly relearning, retraining, and either migrating or abandoning
old code bases. Generally, the concept of a "framework" is to blame. But Python
hit a fundamental level and IS the framework. Even when you use a framework on
top of Python, such as Flask, FastAPI, or FastHTML, switching is much easier.
Python interfaces remain remarkably stable over the years, allowing your
intuition and muscle memory to improve.

The new breed of AI text-editors emphasizes this point. Your text editor is
where you spend a significant amount of time. It's even more essential than your
bed or chair because it becomes ingrained in your fingers through muscle memory
and shortcuts. Switching text editors can be more disruptive than switching
programming languages. Think VSCode is here forever? It's already under attack
from Cursor. As with PFE, Notepad++, TextMate, Sublime Text, Atom, and Brackets,
it will come and go. Vim (vi, nvim, etc.), the one all the others try to
emulate, will be the only safe harbor for your fingers. 

## Investing in Timeless Technical Skills

If you develop muscle memory from years of practice in this slightly
less-than-sexiest of tech (at least as a secondary tech-stack you know), then
you won't become obsolete. LPvg skills may not be as trendy or seemingly
valuable as the current fad, but they will keep your skills relevant and provide
an alternative to popular approaches, offering some freedom from vendor lock-in.

## The Universal Foundation: Core Tools for Every Developer

No matter how jazzed up or convenient power-tools become, you'll notice an
underlying system of Linux, Python, vim, and git that even they rely on. Windows
and Mac strive to be Linux for the developer. All text editors offer a vim
emulation mode. When's the last time Python hasn't been the default answer AIs
want to give you (except for Claude artifacts). And git is... well, git. I'm
sort of advocating the pee in the pool of tech. These are the 80/20-rule "good
enough" tools that have become free, time-tested and are just accessible enough
for the average person.

## Learning from Technology's Past: The Amiga Legacy

It's not always smooth sailing. The carpet can be pulled out from under you, no
matter how well you prepare. The idea is to make smart choices, so a good deal
of what you know and your hard-won muscle memory and habits remain applicable.

## Embracing Timeless Abstractions Over Temporary Hardware

I fell in love with the Amiga Computer some 30 years ago and have been trying to
recapture that magic ever since. I've concluded that you shouldn't fall in love
with your hardware or the particulars of your system. Instead, if you can love
some of the higher-level abstractions that cut across time, space, and problem
domains, you'll be okay.
