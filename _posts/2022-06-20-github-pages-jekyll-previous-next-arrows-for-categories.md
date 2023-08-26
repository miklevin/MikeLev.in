---
date: 2022-06-20
title: Github Pages Jekyll Previous/Next Arrows For Categories
headline: Discovering a Tag-Aware Solution for Cross-Cutting & Category-Specific Navigation Arrows on Github Pages Jekyll
description: This blog post explains how I figured out a way to have two different meanings for the previous/next arrows on my site, without having to use a plugin. I found a tag-aware solution that worked for me and then implemented a one-to-many relationship between categories. I'm sharing my journey and the solutions I found so readers can benefit from my experience.
keywords: Github,Pages,Jekyll,Previous,Next,Arrows,Categories,Tag-Aware,Solution,Skite,Slice,System,Frontmatter,Route,Test,Generate,Site,Layouts,Posts,Commit,Push,Maintain,One-to-Many,Relationship
categories: 
permalink: /blog/github-pages-jekyll-previous-next-arrows-for-categories/
layout: post
group: blog
---


One of the most profoundly differentiating and SEO-lovely things I could do on
my site is to have 2 different meanings for the previous/next arrows on my
site. One at the top of the posts which is cross-cutting across the entire blog
in the order they were published. Another at the bottom of the posts which
contains the previous/next arrows to just within the category in which the post
was published.

{% include youtubePlayer.html id="b6hbN_CWSCI" %}

There are a couple of issues here. First, that's not so easy as regular
previous/next arrows within the Jekyll and Github Pages publishing system. I am
hopeful I will be able to get this to work, but there are issues that must be
worked through. First and foremost is the multiple-belonging issue. If I'm
putting alternative prev/next arrows on the one master copy of the published
content (no duplicate content) then there will only be one alternative set of
previous/next arrows, so each blog post must only be able to belong to a single
category, or else I would need multiple alternative prev/next arrows or a
win/loss scenario.

We start with the [official Jekyll documentation on posts](https://jekyllrb.com/docs/posts/).

That page has this line:

> Unlike tags, categories for posts can also be defined by a post's file path.
> Any directory above \_post will be read-in as a category.

***Now that's interesting.*** If I were to allow duplicate content, that's how
I would do it. I could also easily support the multiple belonging data
structures made possible by the many-to-many relationships of both tags and
categories. It's a bit troublesome. I don't want duplicate content and I don't
want the many-to-many relationship in categories. Tags I can understand, but
there should be more differentiation between categories and tags. They're
giving flexibility I understand, but my approach must not allow this.

Just do some general research into arrow solutions. I'm not the first person to
scratch this itch. See what others have done. There's a number of solutions
out there, but this is my favorite:

https://stackoverflow.com/questions/61287058/jekyll-link-next-previous-sorted-posts-within-a-category

I am afraid it may require a plug-in:

https://rubygems.org/gems/jekyll-category-aware-prev-next

Okay, think! What kind of experiments can you do? Well, not of the blog posts
even have a category yet. There are 2 ways to create categories. It can be
written into jekyll frontmatter or the \_posts folders can be under category
folders.

It has to be a plugin-free solution in order to avoid rabbit hole
complications. Here's one: [Tag-aware Previous/Next links for Jekyll](http://seanlaw.github.io/2015/02/22/tag-aware-previous-next-links-for-jekyll/)

Try showing their tag solution here:

{% highlight html %}{% raw %}
{% for tag in page.tags %}
  {% if tag == "pyesl"%}
    <ul>
      {% assign posts = site.tags['pyesl'] | sort:"weight" %}
      {% for post in posts %}
        {% if post.url == page.url %}
          {% assign last_inx = forloop.index0 | minus:1 %}
          {% if forloop.first == false %}
            <li class="prev"><a href="{{ BASE_PATH }}{{ posts[last_inx].url }}" title="{{ posts[last_inx].title }}">&larr; Previous</a></li>
          {% else %}
            <li class="prev disabled"><a>&larr; Previous</a></li>
          {% endif %}
          <li><a href="{{ BASE_PATH }}{{ site.JB.pyesl_path }}">PyESL</a></li>
          {% if forloop.last == false %}
            {% assign next_inx = forloop.index0 | plus:1 %}
            <li class="next"><a href="{{ BASE_PATH }}{{ posts[next_inx].url }}" title="{{ posts[next_inx].title }}">Next &rarr;</a></li>
          {% else %}
            <li class="next disabled"><a>Next &rarr;</a>
          {% endif %}
        {% endif %}
      {% endfor %}
    </ul>
  {% endif %}
{% endfor %}
{% endraw %}{% endhighlight %}

Wow, that rendered out to my site just fine. Interesting! Okay, that's a first
tiny success. Get a second tiny success.

There's issues. My skite & slice system will overwrite all the files in
\_posts, but that's where I need to put the category in as front-matter. So I'm
going to do a few git commits and pushes without slicing & dicing. Think! Go
the frontmatter route for a test. Do a particular page that will be easy to
keep showing... like this one! And so make the plan here, do one skite-gen then
put the category arrow code in... in where? Okay, the plan:

- Generate this site one more time under skite
- Add new arrows to ~/github/MikeLev.in/\_layouts/\_posts
- Put a category in frontmatter of ~/github/MikeLev.in/\_posts/2022-06-20-post-146.md
- Put a category in frontmatter of ~/github/MikeLev.in/\_posts/2022-06-20-post-145.md
- Put a category in frontmatter of ~/github/MikeLev.in/\_posts/2022-06-20-post-144.md

Commit and push without skite.

On a related note, I will also be interested in previous/next arrows in normal
Jekyll pages, or maybe collections whatever those are. Here's some folks
talking about that: https://talk.jekyllrb.com/t/previous-and-next-links-with-a-collections/3171/6

{% highlight html %}{% raw %}
{% for category in page.categories %}
<h4>Category: {{ category }}</h4>
<div class="spacer">
  <div class="post-nav">
    <div class="post-nav-prev">
    {% assign posts = site.categories[category] | sort:"weight" %}
    {% for post in posts %}
      {% if post.url == page.url %}
        {% assign last_inx = forloop.index0 | minus:1 %}
        {% if forloop.last == false %}
          {% assign next_inx = forloop.index0 | plus:1 %}
          &larr;&nbsp;<a href="{{ BASE_PATH }}{{ posts[next_inx].url }}">{{ posts[next_inx].title }}</a>
        {% endif %}
        </div>
        <div class="post-nav-next">
        {% if forloop.first == false %}
          <a href="{{ BASE_PATH }}{{ posts[last_inx].url }}">{{ posts[last_inx].title }}</a>&nbsp;&rarr;
        {% endif %}
      {% endif %}
    {% endfor %}
    </div>
  </div>
</div>
{% endfor %}
{% endraw %}{% endhighlight %}

I will have to maintain a one-to-many relationship between categories and posts
manually (versus many categories to many posts which Jekyll supports) in order
for this solution to not have funky side-effects. I'm iterating through a loop,
but expecting one and only one category to return (if any) for any given post.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/qnap-container-station-lxc-end-of-support-notification-move-to-lxd/">Qnap Container Station Lxc End Of Support Notification, Move To Lxd</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/every-little-thing-gets-done-eltgd-leads-to-more-epic-days/">Every Little Thing gets done (ELTgd) Leads to More Epic Days</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul></ul>