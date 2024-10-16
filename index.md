---
title: Mike Levin on AI, SEO, Linux, Python, vim & git
description: Future-proof your skills and escape the tech hamster wheel with Linux, Python, vim & git (LPvg) including NixOS, Jupyter, FastHTML and an AI stack to resist obsolescence.
author: Mike Levin AI SEO
group: home
---

<div class="logo-container">
    <div class="logo-item">
        <img src="/assets/logo/Levinux.PNG" alt="Levinux Logo" />
    </div>
    <div class="logo-item">
        <img src="/assets/logo/Pipulate.PNG" alt="Pipulate Logo" />
    </div>
</div>

# LPvg: Timeless Tech Skills for the AI Age

- **`Linux`**: The open-source pulse of global computation.
- **`Python`**: Language of logic, creativity, and discovery.
- **`vim`**: The text whisperer—efficiency bound in keystrokes.
- **`git`**: The memory keeper—track, share, and never lose your way.

That's the main minimal tech-stack as a sort of swiss army knife or utility belt of tech. You don't need to use it for everything, but it is applicable to everything. With a few more tools, we lower the barrier to entry and make systems reproducible across all hardware. Plus, we'll sprinkle in the free local AI and a Python-centric web development environment.

- **`nix/NixOS`**: Reproducibility redefined—consistency across the code cosmos.
- **`tmux`**: Command-line conjurer—sessions split, disconnected, and reborn.
- **`Jupyter Notebooks`**: Code meets canvas—prototype, iterate, illuminate.
- **`FastHTML`**: From Python thoughts to web realities in a heartbeat.
- **`Ollama`**: Offline AI, always listening—your local companion in thought.

## Writing as a Compass in the Tech Wilderness

I don't write because I crave an audience or have products to peddle. My words are my compass, helping me navigate the ever-shifting landscape of technology. This digital journal is my sounding board, a space where ideas echo and crystallize. With each post, I'm forging a path forward, articulating the complex, and holding myself accountable to the journey I've chosen.

<ol reversed>
  {% assign sorted_posts = site.posts | sort: 'date' %}
  {% assign grouped_posts = sorted_posts | group_by_exp: "post", "post.date | date: '%Y-%m-%d'" | reverse %}
  {% assign total_posts = site.posts.size %}
  {% for day in grouped_posts %}
    {% assign day_posts = day.items | sort: 'sort_order' | reverse %}
    {% for post in day_posts %}
      <li value="{{ total_posts | minus: forloop.index0 }}"><hr />
        <h4><a href="{{ post.url }}" class="arrow-link">{{ post.title }}</a></h4>
        <span class="post-date">{{ post.date | date: "%B %d, %Y" }}</span>
        {% if post.description %}
          <p>{{ post.description }}</p>
        {% endif %}
      </li>
    {% endfor %}
  {% endfor %}
</ol>
