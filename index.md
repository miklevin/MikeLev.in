---
title: Mike Levin on AI, SEO, Linux, Python, vim & git
description: Future-proof your skills and escape the tech hamster wheel with Linux, Python, vim & git (LPvg) including NixOS, Jupyter, FastHTML and an AI stack to resist obsolescence.
author: Mike Levin AI SEO
group: home
---

<div class="logo-container">
    <div class="logo-item">
        <a href="/levinux/">
            <img src="/assets/logo/Levinux.PNG" alt="Levinux Logo - Linux-based educational operating system for beginners" />
        </a>
    </div>
    <div class="logo-item">
        <a href="/pipulate/">
            <img src="/assets/logo/Pipulate.PNG" alt="Pipulate Logo - Open source SEO software for data-driven marketing" />
        </a>
    </div>
</div>

---

<div class="wisdom" style="display: flex; justify-content: center; align-items: center; margin-bottom: 1vw;">
<pre style="display: inline-block; text-align: left; margin: 0; font-family: monospace; background-color: #2c3e50; color: white; border-radius: 15px; padding: 15px;">
   Ikigai - overcome laziness find the love
  Kaizen - do one thing well keep polishing
Pomodoro - take chisel-strike bank small wins
    Hara Hachi - don't burn out / eat less
     Wabi-Sabi - 80/20-rule imperfection
         Shoshin - Be like a beginner
</pre>
</div>

---

# LPvg: Timeless Tech Skills for the AI Age

<div class="lpvg-container">
  <div class="lpvg-list">
    <ul>
      <li><code class="language-plaintext highlighter-rouge">`Linux`</code>: The open-source pulse of global computation.</li>
      <li><code class="language-plaintext highlighter-rouge">`Python`</code>: Language of logic, creativity, and discovery.</li>
      <li><code class="language-plaintext highlighter-rouge">`vim`</code>: Text whisperer—zen efficiency in keystrokes.</li>
      <li><code class="language-plaintext highlighter-rouge">`git`</code>: Memory keeper—track, share & find your way.</li>
    </ul>
  </div>
  <div class="lpvg-ascii">
    <pre>
            /)  ___
      /)\__//  /   \
  ___(/_ 0 0  |     |
*(    ==(_T_)==LINUX|
  \  )   \"\  |     |
   |__>-\_>_>  \___/
    </pre>
  </div>
</div>

That's the main minimal tech-stack as a sort of **swiss army knife** 🇨🇭 or **utility belt of tech** 🦸‍♂️. You don't need to use it for everything, but it is *applicable to everything* 🌍. With a few more tools 🛠️, we lower the barrier to entry and make systems *reproducible across all hardware* (️🍎🪟🐧). Plus, we'll sprinkle in the **free local AI** 🤖🧠 and a **Python-centric** 🐍 web development environment.

<div>
  <ul>
    <li><code class="language-plaintext highlighter-rouge">`nix/NixOS`</code>: Reproducibility redefined—consistency across the code cosmos.</li>
    <li><code class="language-plaintext highlighter-rouge">`tmux`</code>: Command-line conjurer—sessions split, disconnected, and reborn.</li>
    <li><code class="language-plaintext highlighter-rouge">`Jupyter Notebooks`</code>: Code meets canvas—prototype, iterate, illuminate.</li>
    <li><code class="language-plaintext highlighter-rouge">`FastHTML`</code>: From Pythonic thoughts to web realities in a heartbeat.</li>
    <li><code class="language-plaintext highlighter-rouge">`Ollama`</code>: Listening offline AI—a secure local companion in thought.</li>
  </ul>
</div>

<div class="ascii-alice">
<pre>
                             ___
                            |   |         _____
                            |_  |        /     \
                              \ |       |       \
                              |  \      |       /
                               \  \____ \_      \
                                \      \_/      |
                          ___.   \_            _/
         .-,             /    \    |          |
         |  \          _/      `--_/           \_
          \  \________/                     /\   \
          |                                /  \_  \
          `-----------,                   |     \  \
                      |                  /       \  |
                      |                 |         | \
                      /                 |         \__|
                     /   _              |
                    /   / \_             \
                    |  /    \__      __--`
                   _/ /        \   _/
               ___/  /          \_/
              /     /
              `----`
</pre>
</div>

<div class="post-navigation">
  <div class="previous-post placeholder"></div>
  <div class="next-post">
    <span class="nav-label">Enter Lundervand</span>
    <a href="{{ site.posts.first.url | relative_url }}">
      <span>{{ site.posts.first.title }}</span>
    </a>
  </div>
</div>

## Writing as a Compass in the Tech Wilderness

I don't write because I crave an audience or have products to peddle. My words are my compass, helping me navigate the ever-shifting landscape of technology. This digital journal is my sounding board, a space where ideas echo and crystallize. With each post, I'm forging a path forward, articulating the complex, and holding myself accountable to the journey I've chosen&#151;and practicing my craft.

<ol reversed>
  {% assign sorted_posts = site.posts | sort: 'date' %}
  {% assign grouped_posts = sorted_posts | group_by_exp: "post", "post.date | date: '%Y-%m-%d'" | reverse %}
  {% assign total_posts = site.posts.size %}
  {% for day in grouped_posts %}
    {% assign day_posts = day.items | sort: 'sort_order' | reverse %}
    {% for post in day_posts %}
      <li value="{{ total_posts | minus: forloop.index0 }}"><hr />
        <h3><a href="{{ post.url }}" class="arrow-link">{{ post.title }}</a></h3>
        <span class="post-date">{{ post.date | date: "%B %d, %Y" }}</span>
        {% if post.description %}
          <p>{{ post.description }}</p>
        {% endif %}
        
        <script type="application/ld+json">
        {
          "@context": "https://schema.org",
          "@type": "BlogPosting",
          "headline": "{{ post.title }}",
          "datePublished": "{{ post.date | date_to_xmlschema }}",
          "dateModified": "{{ post.last_modified_at | default: post.date | date_to_xmlschema }}",
          "author": {
            "@type": "Person",
            "name": "{{ post.author | default: site.author }}"
          },
          "description": "{{ post.description | default: post.excerpt | strip_html | strip_newlines | truncate: 160 }}",
          "url": "{{ post.url | absolute_url }}",
          "mainEntityOfPage": {
            "@type": "WebPage",
            "@id": "{{ post.url | absolute_url }}"
          },
          {% if post.image %}
          "image": {
            "@type": "ImageObject",
            "url": "{{ post.image | absolute_url }}"
          },
          {% endif %}
          "publisher": {
            "@type": "Organization",
            "name": "{{ site.title }}",
            "logo": {
              "@type": "ImageObject",
              "url": "{{ '/assets/logo.png' | absolute_url }}"
            }
          }
        }
        </script>
      </li>
    {% endfor %}
  {% endfor %}
</ol>

---

<div class="alice-quote">
  <blockquote>
    "But I don't want to go among mad people," Alice remarked.  <br />
    "Oh, you can't help that," said the Cat: "we're all mad here. I'm mad. You're mad."  <br />
    "How do you know I'm mad?" said Alice.  <br />  
    "You must be," said the Cat, "or you wouldn't have come here."  
  </blockquote>
  <p class="quote-attribution">- Lewis Carroll, Alice's Adventures in Wonderland</p>
</div>

<div class="post-navigation">
  <div class="previous-post placeholder"></div>
  <div class="next-post">
    <span class="nav-label">Enter Lundervand</span>
    <a href="{{ site.posts.first.url | relative_url }}">
      <span>{{ site.posts.first.title }}</span>
    </a>
  </div>
</div>
