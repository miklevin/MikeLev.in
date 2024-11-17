---
title: Mike Levin on AI, SEO, Linux, Python, vim & git
description: Future-proof your skills and escape the tech hamster wheel with Linux, Python, vim & git (LPvg) including NixOS, Jupyter, FastHTML and an AI stack to resist obsolescence.
author: Mike Levin AI SEO
group: home
---

# LPvg: Timeless Tech Skills for the AI Age

<div class="lpvg-container">
  <div class="lpvg-list">
    <ul>
      <li><code class="language-plaintext highlighter-rouge">`Linux`</code>: The interoperable sub-system of macOS & Windows 😉</li>
      <li><code class="language-plaintext highlighter-rouge">`Python`</code>: The new English &#151; or "<i>Lingua Franca</i>" of technology.</li>
      <li><code class="language-plaintext highlighter-rouge">`vim`</code>: How muscle-memory, aka craft, comes to programming.</li>
      <li><code class="language-plaintext highlighter-rouge">`git`</code>: Making your code unstoppable, unlosable & undoable.</li>
    </ul>
  </div>
  {% include bunny.html %}
</div>

**[LPvg](/LPvg/)** is a completely free ***future-proofing*** minimal tech-stach ***for life*** making you a 🦸‍♂️. Don't use it for ***everything***, but know you can apply it to ***anything*** &#151; because ***all tech is text***. So edit at the speed of thought and the world is your 🦪. Add fully reproducible 🐧 inside any 🍎 or 🪟 folder (without the 🐳) by using ⛏️ off the ol' 💎. The tech-setup of your dreams is one 💦 away.

Upgrade from Jabberwocky to Juggernaut and no vorpal 🤺 can stop you. This is the fully vendor-neutral 🦬 FOSS world I'm talking about folks, where 🤖 AI will only make you 💪.

### Also Down the 🐇🕳️ Here at MikeLev.in are:

<div style="margin-top: 2vw; margin-bottom: 2vw;">
  <ul>
    <li><code class="language-plaintext highlighter-rouge">`nix/NixOS`</code>: Reproducibility redefined—consistency across the code cosmos.</li>
    <li><code class="language-plaintext highlighter-rouge">`tmux`</code>: Command-line conjurer—sessions split, disconnected, and reborn.</li>
    <li><code class="language-plaintext highlighter-rouge">`Jupyter Notebooks`</code>: Code meets canvas—prototype, iterate, illuminate.</li>
    <li><code class="language-plaintext highlighter-rouge">`FastHTML`</code>: From Pythonic thoughts to web realities in a heartbeat.</li>
    <li><code class="language-plaintext highlighter-rouge">`Ollama`</code>: Listening offline AI—a secure local companion in thought.</li>
  </ul>
</div>

{% include daily-metaphors.html %}

<br />

{% include alice.html %}

<div class="next-post">
  <div class="previous-post placeholder"></div>
  <div class="next-post">
    <span class="nav-label">Enter Lundervand</span>
    <a href="{{ site.posts.first.url | relative_url }}">
      <span>{{ site.posts.first.title }}</span>
    </a>
  </div>
</div>

## Writing as a Compass in the Tech Wilderness

I don't write 📝 because I crave an audience or have products to peddle. My
words are my compass 🧭, helping me navigate the ever-shifting landscape of
technology 💻. This digital journal is my sounding board 🔊, a space where ideas
echo 🔉 and crystallize 💎. With each post, I'm forging a path forward 🛤️,
articulating the complex, and holding myself accountable to the journey I've
chosen&#151;and practicing my craft 🛠.

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

<div class="wisdom dialogue" style="border-radius: 10px; overflow: hidden; max-width: fit-content; margin: 0 auto;">
<pre style="font-size: 1.1em; line-height: 1; display: grid; grid-template-columns: auto 1fr; gap: 0.5em; padding: 1em; margin: 0;">
<span style="font-weight: bold; color: #ffb300; text-align: right;">Alice:</span> <span style="display: block;">But I don't want to go among mad people,</span>
<span style="font-weight: bold; color: #ffb300; text-align: right;">Cat:</span> <span style="display: block;">Oh, you can't help that, we're all mad here. I'm mad. You're mad.</span>
<span style="font-weight: bold; color: #ffb300; text-align: right;">Alice:</span> <span style="display: block;">How do you know I'm mad?</span>
<span style="font-weight: bold; color: #ffb300; text-align: right;">Cat:</span> <span style="display: block;">You must be, or you wouldn't have come here.</span>
</pre>
</div>

<br />

{% include wisdom.html %}

<div class="next-post">
  <div class="previous-post placeholder"></div>
  <div class="next-post">
    <span class="nav-label">Enter Lundervand</span>
    <a href="{{ site.posts.first.url | relative_url }}">
      <span>{{ site.posts.first.title }}</span>
    </a>
  </div>
</div>

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
