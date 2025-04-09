---
title: Mike Levin on Tech Skills, AI & SEO
description: Mike Levin is a Technical SEO expert in NYC who shares his passion for future-proofing tech skills through Linux, Python, vim, and git. With 25+ years of experience in SEO and web development, he helps others master timeless tools while building AI-powered SEO automation systems.
author: Mike Levin AI SEO
group: home
permalink: /list/
---

{% assign sorted_posts = site.posts | sort: 'date' %}
{% assign grouped_posts = sorted_posts | group_by_exp: "post", "post.date | date: '%Y-%m-%d'" | reverse %}
{% assign first_post = sorted_posts | last %}
{% assign latest_day = grouped_posts | first %}
{% assign latest_posts = latest_day.items | sort: 'sort_order' | reverse %}
{% assign latest_post = latest_posts | first %}

<ol reversed>
  {% assign total_posts = site.posts.size %}
  {% assign post_counter = 0 %}
  {% for day in grouped_posts %}
    {% assign day_posts = day.items | sort: 'sort_order' | reverse %}
    {% for post in day_posts %}
      <li value="{{ total_posts | minus: post_counter }}"><hr />
        <h3><a href="https://mikelev.in{{ post.url }}" class="arrow-link">{{ post.title | escape}}</a></h3>
        <span class="post-date">{{ post.date | date: "%B %d, %Y" }}</span>
      </li>
      {% assign post_counter = post_counter | plus: 1 %}
    {% endfor %}
  {% endfor %}
</ol>

