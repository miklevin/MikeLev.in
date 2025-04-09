---
title: Simple Blog List
group: home
permalink: /list/
---

{% assign sorted_posts = site.posts | sort: 'date' %}
{% assign grouped_posts = sorted_posts | group_by_exp: "post", "post.date | date: '%Y-%m-%d'" | reverse %}
{% assign first_post = sorted_posts | last %}
{% assign latest_day = grouped_posts | first %}
{% assign latest_posts = latest_day.items | sort: 'sort_order' | reverse %}
{% assign latest_post = latest_posts | first %}

{% assign total_posts = site.posts.size %}
{% assign post_counter = 0 %}

<ul style="list-style-type: none; padding-left: 0;">
  {% for day in grouped_posts %}
    {% assign day_posts = day.items | sort: 'sort_order' | reverse %}
    {% for post in day_posts %}
      {% assign post_number = total_posts | minus: post_counter %}
      <li><hr />
        <strong>{{ post_number }}. sort_order: {{ post.sort_order | default: "N/A" }}</strong> 
        <h3><a href="https://mikelev.in{{ post.url }}" class="arrow-link">{{ post.title | escape}}</a></h3>
        <span class="post-date">{{ post.date | date: "%B %d, %Y" }}</span>
      </li>
      {% assign post_counter = post_counter | plus: 1 %}
    {% endfor %}
  {% endfor %}
</ul>

