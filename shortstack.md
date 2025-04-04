---
title: The Linux, Python, vim, git & nix Technology Short Stack
description: Discover Mike Levin's perspective on the LPvgn (Linux, Python, vim, git, Nix) short stack – a future-proof toolkit designed to combat tech obsolescence. Learn how this combination emphasizes enduring skills, simplicity, developer control, and Nix-powered reproducibility for building a sustainable and powerful technical foundation.
permalink: /shortstack/
group: home
---

# My Perspective on the Future-Proof Short Stack: LPvgn

<div style="overflow: hidden; margin-bottom: 20px;">
<img src="/images/linux-python-vim-git-LPvg-short-stack.png" alt="Linux, Python, vim & git LPvg Short Stack" style="float: right; width: 200px; margin-left: 10px; margin-bottom: 5px;">I champion a philosophy centered on enduring skills and a carefully curated set of tools designed to resist the relentless churn of the tech industry. On my website, mikelev.in, I share insights into this approach, particularly focusing on what I initially termed the LPvg stack – Linux, Python, vim, and git. I see these as fundamental and future-proof technologies. More recently, I've embraced Nix, adding another powerful dimension to this toolkit, which I now refer to as LPvgn, or simply the "short technology stack." Here, I'll outline my views on this evolved stack, explaining its benefits and overall value.
</div>

## Embracing the Counter-Revolution Against Technical Obsolescence 

My advocacy for the LPvgn stack stems from my desire to empower individuals with core competencies that remain valuable regardless of fleeting trends. I frame this as a way to escape the "tech hamster wheel" – the exhausting cycle of learning new technologies only to see them become obsolete. Adding Nix to the original LPvg stack deepens this commitment to future-proofing, providing a robust and consistent foundation for development across diverse environments. While I often use metaphors and analogies to make complex concepts accessible, the underlying goal is to persuade you of the enduring wisdom in focusing on these foundational tools.

## Core Components of the Time-Tested LPvg Foundation

At the heart of my philosophy lies the original LPvg stack, each component playing a crucial role:

* **Linux: The Universal Home:** I view any Unix-like operating system as a fundamental "home" for technical work. This includes Linux distributions, macOS (with its Darwin Unix core), and even Windows via the Windows Subsystem for Linux (WSL). For me, Linux represents the bedrock, a consistent and open foundation that "runs beneath it all." My preference for Unix-like environments stems from valuing the control and flexibility offered by command-line interfaces, which are central to my workflow.
* **Python: The Elegant Automator:** In my view, Python is the "elegant language that automates the tedious." I use it extensively for tasks like web development (with my preferred framework, FastHTML) and interacting with local Large Language Models (LLMs) via Ollama. Python's versatility and ability to simplify complex operations make it indispensable, allowing for efficient development and automation. Its broad applicability underscores my belief in its adaptability and enduring relevance.
* **vim/NeoVim: Mastery at Your Fingertips:** I am a dedicated user of the vi/vim lineage, having transitioned to NeoVim. I see these text editors as extensions of the mind, where "muscle memory meets programming artistry." The enduring nature of vim and its presence everywhere, from minimal systems to cloud servers, confirms its status as a "timeless" skill, resistant to trends. My choice reflects a commitment to efficiency and the understanding that mastering fundamental tools yields significant long-term productivity.
* **git: The Keeper of History:** For me, git is the version control system that "makes your work immortal." Its ability to track changes, facilitate collaboration, and allow easy rollbacks is crucial for managing software projects and even development environment configurations. The fact that Nix flakes, which encapsulate entire development environments, are often stored in git repositories highlights the synergy between these tools in my workflow.

## Building a Deterministic Foundation with Nix

Adding Nix to my core stack was a crucial step in my quest for a future-proof, reliable development environment. I identified a fundamental problem: platform-specific package managers (brew, apt, yum, pacman) require different scripting for different operating systems, making a truly consistent "home" difficult. While Docker and VMs are common solutions, I critique them for creating a complex and unwieldy "tangled web."

Nix, in my view, offers a more elegant solution. I describe it as a "whacky wonderful Swiss Army knife," unifying the roles of OS installers, package managers, and even Python's pip. My vision is a "home" defined by one or two configuration files (like `/etc/nixos/configuration.nix`) capable of building a familiar Linux-like environment on any machine with Nix installed. This declarative approach, defining the desired state rather than the steps, ensures reproducibility and simplifies system management, aligning with the "Infrastructure as Code" (IaC) paradigm.

Beyond system configuration, I highlight "Nix flakes" as "secondary homes" for applications. These flakes bundle all project dependencies, ensuring a consistent, isolated development experience – like feeling comfortable in your own car, regardless of the road. I emphasize the power of the `nix develop` command to enter a shell with the precise environment defined by the flake, managing both system packages and Python virtual environments. My projects, like Pipulate (using Jupyter and FastHTML), demonstrate Nix's practical application. While the functional nature of the Nix language might have an initial learning curve compared to imperative languages like Python, I believe its benefits in reproducibility and consistency are well worth the investment.

## Modern Web Development with FastHTML and HTMX

In web development, I champion a Python-centric approach using FastHTML and HTMX. FastHTML is a lightweight framework I favor, built on Python, ASGI, HTMX, Starlette, and Uvicorn. Its goal is to simplify web development by letting developers leverage Python skills and minimize reliance on complex JavaScript frameworks.

HTMX complements FastHTML; it's a small JavaScript library enabling dynamic interactions via HTML attributes, avoiding extensive JavaScript coding. This combination allows me to build interactive web applications where most logic resides server-side, written in Python – aligning with my preference for simplicity and control. The benefits I see include leveraging existing Python skills, avoiding JavaScript framework complexity, building dynamic apps efficiently, maintaining a clean codebase, and easily running apps locally. FastHTML also includes features for database interaction, simplifying data persistence. This emphasis on Pythonic web development creates a cohesive ecosystem around my core LPvgn stack.

## Practical Application Through Development Workflow

My website offers insights into my development workflow, often through my "Pipulate" project. This project exemplifies how I apply the LPvgn stack (Python, FastHTML, HTMX) to automate SEO workflows. My approach emphasizes simplicity and linear workflows, inspired by the Unix pipeline concept. For managing application state within FastHTML/HTMX, I often favor simple structures like JSON, sometimes even using the URL as a primary key. This minimalist approach avoids the complexities common in modern frontend frameworks.

Furthermore, my adoption of NixOS embodies the "Code as Infrastructure" principle, where the entire system configuration is code, allowing reproducible builds and easier management. This aligns with my overarching philosophy of control and automation.

## Breaking Free from the Technical Relearning Cycle

A recurring theme in my writing is "future-proofing" technical skills and escaping the constant relearning cycle. I argue that mastering the LPvgn stack provides a lasting career foundation because these tools are fundamental, enduring, and widely applicable. I particularly stress the value of investing in terminal skills and the vi/vim lineage as an antidote to obsolescence. The open-source nature of the stack, coupled with Nix's portability, ensures freedom from vendor lock-in and seamless transitions across operating systems.

## Core Principles: Simplicity, Control, and Unix Philosophy

My advocacy for LPvgn is deeply rooted in principles I hold dear: simplicity, control, and the Unix philosophy. I favor minimalist tools that do their job well and combine easily. Nix is central to providing complete control over the development environment, ensuring consistency. My comfort with the command line (evident in my preference for Linux, vim, git) reflects a belief in the power and directness of this interaction mode.

## Addressing Implementation Challenges

While I strongly advocate for this stack, I recognize potential challenges. The Nix language and its declarative approach can present an initial learning curve. My strong opinions on technology choices, embedded in frameworks like FastHTML, might not suit everyone. Also, while the goal is simplicity, the initial setup of NixOS or complex Nix flakes can require effort for newcomers. This specific focus might appeal more to those already aligned with these principles.

**Conclusion: The Enduring Value Proposition of the LPvgn Stack**

In conclusion, I present the LPvgn stack (Linux, Python, vim/NeoVim, git, and Nix) as a powerful and future-proof approach to software development and system administration. By combining time-tested fundamentals with Nix's deterministic environment management, I offer a compelling vision for escaping the "tech hamster wheel." The key benefits, as I've outlined, include long-term skill development, complete control over the development environment, enhanced reproducibility and portability, and alignment with the principles of simplicity and the Unix philosophy. While acknowledging potential initial hurdles, I position the LPvgn stack as my recommended pathway to sustainable technical mastery, empowering developers to build reliable, maintainable software for the long term on an enduring foundation.Okay, here is the text rewritten from my perspective, Mike Levin, focusing on the LPvgn stack, presented in a straightforward, business-like tone.

***

## My Perspective on the Future-Proof Short Stack: LPvgn

I champion a philosophy centered on enduring skills and a carefully curated set of tools designed to resist the relentless churn of the tech industry. On my website, mikelev.in, I share insights into this approach, particularly focusing on what I initially termed the LPvg stack – Linux, Python, vim, and git. I see these as fundamental and future-proof technologies. More recently, I've embraced Nix, adding another powerful dimension to this toolkit, which I now refer to as LPvgn, or simply the "short technology stack." Here, I'll outline my views on this evolved stack, explaining its benefits and overall value.

**Embracing the LPvgn Philosophy: A Counter-Revolution Against Obsolescence**

My advocacy for the LPvgn stack stems from my desire to empower individuals with core competencies that remain valuable regardless of fleeting trends. I frame this as a way to escape the "tech hamster wheel" – the exhausting cycle of learning new technologies only to see them become obsolete. Adding Nix to the original LPvg stack deepens this commitment to future-proofing, providing a robust and consistent foundation for development across diverse environments. While I often use metaphors and analogies to make complex concepts accessible, the underlying goal is to persuade you of the enduring wisdom in focusing on these foundational tools.

**The Pillars of LPvg: A Time-Tested Foundation**

At the heart of my philosophy lies the original LPvg stack, each component playing a crucial role:

* **Linux: The Universal Home:** I view any Unix-like operating system as a fundamental "home" for technical work. This includes Linux distributions, macOS (with its Darwin Unix core), and even Windows via the Windows Subsystem for Linux (WSL). For me, Linux represents the bedrock, a consistent and open foundation that "runs beneath it all." My preference for Unix-like environments stems from valuing the control and flexibility offered by command-line interfaces, which are central to my workflow.
* **Python: The Elegant Automator:** In my view, Python is the "elegant language that automates the tedious." I use it extensively for tasks like web development (with my preferred framework, FastHTML) and interacting with local Large Language Models (LLMs) via Ollama. Python's versatility and ability to simplify complex operations make it indispensable, allowing for efficient development and automation. Its broad applicability underscores my belief in its adaptability and enduring relevance.
* **vim/NeoVim: Mastery at Your Fingertips:** I am a dedicated user of the vi/vim lineage, having transitioned to NeoVim. I see these text editors as extensions of the mind, where "muscle memory meets programming artistry." The enduring nature of vim and its presence everywhere, from minimal systems to cloud servers, confirms its status as a "timeless" skill, resistant to trends. My choice reflects a commitment to efficiency and the understanding that mastering fundamental tools yields significant long-term productivity.
* **git: The Keeper of History:** For me, git is the version control system that "makes your work immortal." Its ability to track changes, facilitate collaboration, and allow easy rollbacks is crucial for managing software projects and even development environment configurations. The fact that Nix flakes, which encapsulate entire development environments, are often stored in git repositories highlights the synergy between these tools in my workflow.

## Nix: The Deterministic Foundation for a Consistent "Home"

Adding Nix to my core stack was a crucial step in my quest for a future-proof, reliable development environment. I identified a fundamental problem: platform-specific package managers (brew, apt, yum, pacman) require different scripting for different operating systems, making a truly consistent "home" difficult. While Docker and VMs are common solutions, I critique them for creating a complex and unwieldy "tangled web."

Nix, in my view, offers a more elegant solution. I describe it as a "whacky wonderful Swiss Army knife," unifying the roles of OS installers, package managers, and even Python's pip. My vision is a "home" defined by one or two configuration files (like `/etc/nixos/configuration.nix`) capable of building a familiar Linux-like environment on any machine with Nix installed. This declarative approach, defining the desired state rather than the steps, ensures reproducibility and simplifies system management, aligning with the "Infrastructure as Code" (IaC) paradigm.

Beyond system configuration, I highlight "Nix flakes" as "secondary homes" for applications. These flakes bundle all project dependencies, ensuring a consistent, isolated development experience – like feeling comfortable in your own car, regardless of the road. I emphasize the power of the `nix develop` command to enter a shell with the precise environment defined by the flake, managing both system packages and Python virtual environments. My projects, like Pipulate (using Jupyter and FastHTML), demonstrate Nix's practical application. While the functional nature of the Nix language might have an initial learning curve compared to imperative languages like Python, I believe its benefits in reproducibility and consistency are well worth the investment.

## Pythonic Web Development with FastHTML and HTMX: Embracing Simplicity

In web development, I champion a Python-centric approach using FastHTML and HTMX. FastHTML is a lightweight framework I favor, built on Python, ASGI, HTMX, Starlette, and Uvicorn. Its goal is to simplify web development by letting developers leverage Python skills and minimize reliance on complex JavaScript frameworks.

HTMX complements FastHTML; it's a small JavaScript library enabling dynamic interactions via HTML attributes, avoiding extensive JavaScript coding. This combination allows me to build interactive web applications where most logic resides server-side, written in Python – aligning with my preference for simplicity and control. The benefits I see include leveraging existing Python skills, avoiding JavaScript framework complexity, building dynamic apps efficiently, maintaining a clean codebase, and easily running apps locally. FastHTML also includes features for database interaction, simplifying data persistence. This emphasis on Pythonic web development creates a cohesive ecosystem around my core LPvgn stack.

## Development Workflow: Practical Application Through Pipulate

My website offers insights into my development workflow, often through my "Pipulate" project. This project exemplifies how I apply the LPvgn stack (Python, FastHTML, HTMX) to automate SEO workflows. My approach emphasizes simplicity and linear workflows, inspired by the Unix pipeline concept. For managing application state within FastHTML/HTMX, I often favor simple structures like JSON, sometimes even using the URL as a primary key. This minimalist approach avoids the complexities common in modern frontend frameworks.

Furthermore, my adoption of NixOS embodies the "Code as Infrastructure" principle, where the entire system configuration is code, allowing reproducible builds and easier management. This aligns with my overarching philosophy of control and automation.

## Breaking Free from the Technical Relearning Cycle

A recurring theme in my writing is "future-proofing" technical skills and escaping the constant relearning cycle. I argue that mastering the LPvgn stack provides a lasting career foundation because these tools are fundamental, enduring, and widely applicable. I particularly stress the value of investing in terminal skills and the vi/vim lineage as an antidote to obsolescence. The open-source nature of the stack, coupled with Nix's portability, ensures freedom from vendor lock-in and seamless transitions across operating systems.

## Core Principles: Simplicity, Control, and Unix Philosophy

My advocacy for LPvgn is deeply rooted in principles I hold dear: simplicity, control, and the Unix philosophy. I favor minimalist tools that do their job well and combine easily. Nix is central to providing complete control over the development environment, ensuring consistency. My comfort with the command line (evident in my preference for Linux, vim, git) reflects a belief in the power and directness of this interaction mode.

## Implementation Challenges and Considerations

While I strongly advocate for this stack, I recognize potential challenges. The Nix language and its declarative approach can present an initial learning curve. My strong opinions on technology choices, embedded in frameworks like FastHTML, might not suit everyone. Also, while the goal is simplicity, the initial setup of NixOS or complex Nix flakes can require effort for newcomers. This specific focus might appeal more to those already aligned with these principles.

## The Enduring Value Proposition of the LPvgn Stack

In conclusion, I present the LPvgn stack (Linux, Python, vim/NeoVim, git, and Nix) as a powerful and future-proof approach to software development and system administration. By combining time-tested fundamentals with Nix's deterministic environment management, I offer a compelling vision for escaping the "tech hamster wheel." The key benefits, as I've outlined, include long-term skill development, complete control over the development environment, enhanced reproducibility and portability, and alignment with the principles of simplicity and the Unix philosophy. While acknowledging potential initial hurdles, I position the LPvgn stack as my recommended pathway to sustainable technical mastery, empowering developers to build reliable, maintainable software for the long term on an enduring foundation.
