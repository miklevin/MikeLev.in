---
title: Mike Levin on AI, SEO, Linux, Python, vim & git
description: Future-proof your skills and escape the tech hamster wheel with Linux, Python, vim & git (LPvg) including NixOS, Jupyter, FastHTML and an AI stack to resist obsolescence.
author: Mike Levin AI SEO
group: home
---

<table class="logos">
<tr>
<td class="hplg"><img src="/assets/logo/Levinux.PNG" border=0 /></td>
<td> </td>
<td class="hplg"><img src="/assets/logo/Pipulate.PNG" border=0 /></td>
</tr>
<tr>

<!--
<td class="hptd"><b><a href="/levinux/">A Micro Linux For Your
Education</a></b><br />Dispel the fear of Linux command-line with Levinux, the
Gom Jabbar of Linux. 20 MB and no install!</td>

<td style="background: black;">&nbsp;</td>

<td class="hptd"><b><a href="/pipulate/">Pipulate Free & Open Source
SEO</a></b><br />Follow along as I re-implement my SEO software for the new AI
reality, including LLM-assisted crawls.</td>
-->

</tr>
</table>

## A Focused Approach to Tech Mastery

In light of the AI revolution and the flood of new tech offerings, I've chosen to concentrate on a specific set of tools and technologies:

- **Linux**: A versatile, open-source operating system that forms the backbone of much of the world's computing infrastructure.
- **Python**: A highly readable and versatile programming language, ideal for AI, data science, and general-purpose development.
- **Vim**: A powerful, customizable text editor that boosts productivity once mastered.
- **Git**: The industry-standard version control system, essential for collaborative development and project management.
- **Nix and NixOS**: An innovative package manager and Linux distribution that offers reproducible, declarative system configuration.
- **Jupyter Notebooks**: An interactive environment for exploring and prototyping Python ideas.
- **FastHTML**: A modern web framework for quickly turning Python concepts into web applications.
- **Ollama:** A way to run large language models locally, enabling AI-powered development without relying on cloud services.

This curated toolkit provides a robust platform for navigating the ever-changing
tech landscape without getting lost in a sea of proprietary solutions,
JavaScript frameworks and subscription-based services.

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

## Join the Journey!

> This is chronologically forward since my decision to go all-in on Nix, NixOS
> and FastHTML, so it's oldest stuff at the top and newest stuff at the bottom.
> It's a lot of thinking out loud and forging the path forward, going into the
> gory details of future-proofing in a world where we live on the fault line.

<ol>
  {% assign sorted_posts = site.posts | sort: 'date' %}
  {% for post in sorted_posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      - <span>{{ post.date | date: "%B %d, %Y" }}</span>
      {% if post.description %}
        <p>{{ post.description }}</p>
      {% endif %}
    </li>
  {% endfor %}
</ol>

