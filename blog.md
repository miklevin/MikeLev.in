---
title: Mike Levin's Linux, Python, vim & git (LPvg) blog
permalink: /blog/
layout: default
---

<ul>
  {% assign sorted_posts = site.posts | sort: 'date' %}
  {% for post in sorted_posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>

