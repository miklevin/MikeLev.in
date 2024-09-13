---
title: Mike Levin's Linux, Python, vim & git (LPvg) Blog
permalink: /blog/
layout: default
---

# Linux, Python, vim & git (LPvg) Blog

> This is where I document the replacing of Levinux with NixOS as a portable
> tech home for life, and the updating of Pipulate Free and Open Source Software
> for the AI Age. Follow the journey.

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

