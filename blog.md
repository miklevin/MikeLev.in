---
title: Mike Levin's Linux, Python, vim & git (LPvg) blog
permalink: /blog/
layout: default
---

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
