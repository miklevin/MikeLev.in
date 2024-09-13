---
title: Mike Levin's Linux, Python, vim & git (LPvg) Blog
permalink: /blog/
layout: default
---

# Mike Levin's Linux, Python, vim & git (LPvg) Blog

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

