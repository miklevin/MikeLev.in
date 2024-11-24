---
title: Mike Levin on AI, SEO, Linux, Python, vim & git
description: MikeLev.in is a website run by Mike Levin, an SEO expert in NYC. He focuses on using local-first, open-source tools and technologies like Linux, Python, vim, and git. He's a proponent of the Unix philosophy and minimalist coding practices, and is currently developing a workflow management system called Pipulate.
author: Mike Levin AI SEO
group: home
---

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebPage",
  "name": "Mike Levin on AI, SEO, Linux, Python, vim & git",
  "description": "Future-proof your skills and escape the tech hamster wheel with Linux, Python, vim & git (LPvg) including NixOS, Jupyter, FastHTML and an AI stack to resist obsolescence.",
  "author": {
    "@type": "Person",
    "name": "Mike Levin"
  },
  "mainEntity": {
    "@type": "Blog",
    "blogPost": [
    // ... individual posts can be referenced here
    ]
  }
}
</script>

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

**[LPvg](/LPvg/)** is a completely free ***future-proofing*** minimal tech-stach ***for life*** making you a 🦸‍♂️. Don't use it for ***everything***, but know you can apply it to ***anything*** &#151; because ***all tech is text***. So edit at the speed of thought and the world is your 🦪. Add fully reproducible 🐧 inside any 🍎 or 🪟 folder (without the 🐳) by using ⛏️ off the ol' 💎. The tech-setup of your dreams is one 💦 away *(if you can hydrate a DOM, you can hydrate a LAN).*

Simply upgrade from Jabberwocky to Juggernaut and no vorpal 🤺 can stop you. This is the fully vendor-neutral 🦬 **FOSS**-world I'm talking about folks, where 🤖 **AI** will only make you 💪!

{% include daily-metaphors.html %}

### Also Down the 🐇🕳️ Here at MikeLev.in are:

<div style="margin-top: 2vw; margin-bottom: 2vw;">
  <ul>
    <li><code class="language-plaintext highlighter-rouge">`nix/NixOS`</code>: Reproducibility redefined&#151;not the death of Docker, but close.</li>
    <li><code class="language-plaintext highlighter-rouge">`tmux`</code>: Like having devops sysadmin powers with only 1/4th of being an a-hole.</li>
    <li><code class="language-plaintext highlighter-rouge">`Jupyter Notebooks`</code>: No, not Colab. No, not VSCode. <b><i>Project Jupyter!!!</i></b></li>
    <li><code class="language-plaintext highlighter-rouge">`FastHTML`</code>: WebDev & HTML the way it should be. Better than React.</li>
    <li><code class="language-plaintext highlighter-rouge">`Ollama`</code>: 'Cause AI doesn't cost any more than electricity now.</li>
  </ul>
</div>

{% include wisdom.html %}

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
  {% assign post_counter = 0 %}
  {% for day in grouped_posts %}
    {% assign day_posts = day.items | sort: 'sort_order' | reverse %}
    {% for post in day_posts %}
      <li value="{{ total_posts | minus: post_counter }}"><hr />
        <h3><a href="{{ post.url }}" class="arrow-link">{{ post.title | escape}}</a></h3>
        <span class="post-date">{{ post.date | date: "%B %d, %Y" }}</span>
        {% if post.description %}
          <p>{{ post.description | escape }}</p>
        {% endif %}
        <script type="application/ld+json">
        {
          "@context": "https://schema.org",
          "@type": "BlogPosting",
          "headline": "{{ post.title }}",
          "datePublished": "{{ post.date | date_to_xmlschema }}",
          "url": "{{ post.url | absolute_url }}"
        }
        </script>
      </li>
      {% assign post_counter = post_counter | plus: 1 %}
    {% endfor %}
  {% endfor %}
</ol>

---

<div class="next-post">
  <div class="previous-post placeholder"></div>
  <div class="next-post">
    <span class="nav-label">Enter Lundervand</span>
    <a href="{{ site.posts.first.url | relative_url }}">
      <span>{{ site.posts.first.title }}</span>
    </a>
  </div>
</div>

<br />

Here's a breakdown of the topics covered in the article, organized into a comprehensive outline:

## Outline of Topics Covered

1.  **Future-Proofing Your Tech Skills**

    *   Mastering the "LPvg stack" (Linux, Python, vim, and git)
    *   Balancing domain expertise with technical skills
    *   Building a future-proof development arsenal
    *   Crafting a cross-platform development environment
    *   The importance of future-proofing and lifelong learning
    *   The power of text-based computing and coding
    *   Human-AI communication and robust protocols
    *   Leveraging local AI infrastructure and designing sustainable AI systems
    *   Escaping the technology hamster wheel and investing in timeless skills
2.  **Deep Dive into Specific Technologies**

    *   Linux, Python, Vim, and Git (LPvg)
        *   The portability of Unix and its open-source legacy
        *   The power and benefits of the LPvg stack
        *   Interactive learning with Jupyter Notebooks and JupyterLab
        *   Efficient web development with FastHTML and HTMX
        *   The role of Nix in building reproducible environments
        *   Simplifying environment sharing and configuration management
        *   The limitations of containers and the benefits of a repository system
        *   Mastering LPvg for lifelong improvement and technological empowerment
    *   NixOS and Flakes
        *   Understanding the NixOS language and its functional paradigm
        *   The philosophical appeal of NixOS's declarative system
        *   Building a NixOS system from scratch and key language principles
        *   Abstract data structures and syntax rules in Nix expressions
        *   The role of attribute sets and function argument patterns
        *   Getting started with Nix Flakes for reproducibility
        *   The quest for a timeless development environment
        *   The limitations of virtual machines and containers
        *   The benefits of Nix Flakes for version control and git management
        *   Creating a portable JupyterLab environment with Nix Flakes
        *   The dilemma of cloud vs. local development
        *   Building a shareable development environment with Nix Flakes
        *   Refining Nix Flakes for cross-platform compatibility
        *   Building a versatile `flake.nix` for seamless development
        *   Adding CUDA support and a virtual environment for flexibility
        *   Integrating Jupyter AI and local LLMs for AI-assisted development
        *   Setting up a NixOS system and creating reproducible data science environments
        *   Using NixOS and Nix with pip install dotenv for managing environment variables
        *   Setting up a cross-platform development environment with FastHTML and Cursor AI
        *   The DevOps renaissance and how infrastructure as code is redefining digital craftsmanship
        *   Building a Python web development environment within Nix and handling secrets
        *   Transitioning from Jupyter Notebooks to FastHTML with WebSockets
        *   Unpacking FastHTML databases and understanding CRUD operations
        *   Building a plugin-ready framework and abstracting base functionality
        *   Object-oriented base class plugins and dynamic app registration
        *   Integrating a custom SPA plugin and avoiding configuration collisions
        *   Advanced data science enhancements with Pandas and Bokeh
        *   Soft launching Botifython and managing updates with Nix flakes
3.  **The Big Tech Picture**

    *   Understanding the historical context of technology to maintain agency
    *   Early computing origins and the birth of virtual machines
    *   The genesis of Multics and Unix
    *   The development of C and its role in bridging low-level control and high-level abstraction
    *   Evolution of scripting and high-level languages
    *   The rise of Python and its empowering features
    *   An alternative timeline with ITS and LISP
    *   The recurring theme of virtual machines and isolation
    *   The spread of Unix and the emergence of Linux
    *   Vim: Efficiency, muscle memory, and mastery in text editing
    *   The text editor and IDE wars
    *   Jupyter: Bridging accessibility and advanced computing
    *   The underlying thread of seizing agency through knowledge and tools

**I hope this outline is helpful!**

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
