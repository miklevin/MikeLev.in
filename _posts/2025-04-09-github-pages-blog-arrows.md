---
title: "GitHub Pages & Jekyll: Solving Chronological Sorting for Multiple Daily Posts"
permalink: /futureproof/github-pages-blog-arrows/
description: In this post, I tackle a frustrating navigation issue I encountered on my Jekyll blog hosted with GitHub Pages, specifically when publishing multiple posts on the same day using a custom `sort_order` field. While the basic previous/next links initially seemed okay, the "latest post" link on my homepage defaulted to the *earliest* post of the most recent day, ignoring my intended order. After fixing that with refined Liquid logic (with some help from Claude AI), I realized the previous/next links *also* weren't correctly respecting the `sort_order` within the same day and were operating backward relative to my desired newest-to-oldest flow. The core of the article details the process and the final Liquid code—involving grouping, sorting, and creating a custom flat index—that resolved both issues, ensuring all navigation accurately reflects the true chronological and custom-sorted sequence of my posts.
layout: post
sort_order: 1
---

## Introduction: Fixing the "Latest Post" Link in Jekyll When Using Custom Sort Order

This article addresses a specific, yet potentially frustrating, issue encountered when managing a Jekyll blog hosted on GitHub Pages, particularly when publishing multiple posts on the same day. The standard Jekyll setup sorts posts chronologically based on the date embedded in the filename (`YYYY-MM-DD-title.md`). However, to control the precise order of posts published on the *same* date, a common practice is to add a custom `sort_order` field to each post's front matter (e.g., `sort_order: 1`, `sort_order: 2`, etc.).

While the built-in `page.previous` and `page.next` variables used for navigation *between* individual posts can correctly utilize this `sort_order` after initial date sorting, a problem arises on index pages, such as the main homepage. A seemingly straightforward attempt to link to the "latest post" often defaults to simply finding the post with the most recent *date*, potentially linking to the *first* post published on that day (e.g., `sort_order: 1`) instead of the *last* one (e.g., `sort_order: 5`).

## The Core Problem: Homepage Navigation Ignoring Sort Order

The core problem detailed below was exactly this: the main homepage link intended to direct users to the absolute newest content was incorrectly pointing to the earliest post of the latest publication day, ignoring the crucial `sort_order`.

## The Solution: Refined Liquid Template Logic

The solution involves implementing more specific Liquid templating logic within the homepage template (`index.md` in this case). Instead of relying solely on sorting the entire `site.posts` array by date, the corrected approach first groups the posts by their full date (`YYYY-MM-DD`), identifies the group corresponding to the most recent date, sorts the posts *within that specific group* based on the `sort_order` field (in descending order), and finally selects the top item from this subgroup. This ensures the link correctly points to the post with the highest `sort_order` value for the most recent day, accurately reflecting the intended chronological sequence.

The fix utilizes Liquid's `group_by_exp`, `sort`, `reverse`, and `first` filters to pinpoint the true latest post. The interaction with an AI assistant (Claude) helped refine this Liquid logic. This introduction summarizes the challenge and the implemented fix; the original, more narrative article detailing the author's setup, context, and troubleshooting journey follows below.

## GitHub Pages: Built-in Website Hosting

I publish my website on GitHub Pages, previously github.io, which is a built-in
feature of GitHub. Any repo can host its documentation there, which only makes
sense since all repos on GitHub are sort of already published there by default.
GitHub Pages just formalizes this by taking the static files—HTML, CSS,
JavaScript, Markdown, etc.—right from your repository and serving them up as a
live website. You can point it at your `main` branch, a specific `/docs` folder,
or the old-school `gh-pages` branch. Plus, with its fantastic Jekyll
integration, you can just write posts or pages in Markdown, push the changes,
and GitHub automatically builds and deploys the static site for you. It
brilliantly leverages the version control and hosting you're already using for
your code to also handle your web presence, keeping everything tightly
connected. That's how this site is published. It's just one big directory of
markdown files!

## Jekyll's Built-in Blogging System

Jekyll has built-in blogging, where you put files according to a particular
naming convention into a `_posts` subfolder, and you get a blog! Here's how it
works:

* **The Magic Folder:** You put all your blog articles inside the `_posts` folder.
* **The Crucial Filename:** This is the key part. Jekyll is *very* specific about how you name these files so it knows they're blog posts and when they were published. The format *must* be:
    `YYYY-MM-DD-your-post-title.markup`
    * `YYYY`: Four-digit year (like `2025`)
    * `MM`: Two-digit month (like `04` for April)
    * `DD`: Two-digit day (like `09`)
    * `your-post-title`: This becomes part of the URL (the "slug"), so keep it lowercase, use hyphens `-` instead of spaces, and make it descriptive.
    * `.markup`: The file extension tells Jekyll how the post is written. Most commonly, this is `.md` or `.markdown` for Markdown, but it could also be `.html` or others.
* **Why the Date?** That date at the beginning isn't just for show! Jekyll uses it to figure out the post's publication date, sort your posts chronologically, and build the default URL structure (like `/2025/04/09/your-post-title.html`). If a file in `_posts` *doesn't* start with this date format, Jekyll won't treat it as a published post.
* **Processing:** When GitHub Pages (or you, locally) builds the site, Jekyll grabs all the correctly named files from `_posts`, processes the Markdown (or other markup), applies the layout you specified in the file's front matter, and generates the final HTML page for that blog entry.

So, if you wanted to publish this explanation today, you might create a file named `_posts/2025-04-09-how-jekyll-posts-work.md`. Easy peasy once you know the pattern!

## Jekyll's Flexible URL Structure

Now just that on its own will result in a directory full of well-named blog
posts. The Jekyll "top-matter" on your individual blog posts can override all
the default behavior any way you like, such as adding permalinks so that the
dates are not used in the URL, making your articles somewhat more evergreen. You
can plan them in "virtual" sub-folders. 

There's really no enforced literal connection between URL-structures and the
file-layout on your drive. That's an understandable misconception based on how
webservers work by convention, reflecting the path they serve your file from in
the path they show in the URL. But it's purely superimposed convention by the
webserver. The underlying file-layout reality (if even files at all), can be
completely different, and the Jekyll top-matter overrides let you take advantage
of that with fields like `permalink`.

## Creating Navigation Between Blog Posts

So after you have a directory full of blog-posts, there's really nothing linking
to them inherently. There's no index-page or stepping through blog posts with
paging until you add it. And the way you add it can be very customized and
artistic based on your preferences, goals and skill-levels. It's where a lot of
the "SEO-juice" comes into play, because it effects such things as what words
end up in the anchor text of your links, and how many clicks it finds for
crawlers to discover your content. These decisions are critical, and currently,
I've made some very simple ones.

## Homepage as a Chronological Index

The homepage of my website acts as a giant index page, just listing my blog
posts reverse chronologically, top-down. So you can track the entire evolution
of my blog from the very first post at the bottom of the homepage to the most
recent post at the top. And this works well so long as your blog has not grown
very large yet, as you don't want to overwhelm either readers or crawlers with
too many links there on the homepage. It's just like looking at the table of
contents of a book. How large do YOU want it to be? You've got to be able to
skim it at a glance and get a nice overview to know where to drill-down into for
further sub-searching. This is the difference between rapid table of contents at
the beginning of a book and an exhaustive index and/or glossary at the end. The
overwhelming stuff is taken off the front-page and moved to where those properly
motivated and determined can find it for more granular search and drill-down
actions.

## Balancing Information Architecture and User Experience

It's about user experience. Keep it light up-front. Don't drive them away with a
glut of information like I currently do. I'll be fixing that, and that's where a
lot of my recent book-outline, site topology and information architecture (IA) AI
projects have been focused on. I'm doing my first passes so there will be a nice
fleshed out outline of topics that all my content will neatly sort into. But
that's not what I'm here to fix first. First, I fix my previous/next arrows that
link all the pages together in the chronological order they were written.

## The Power of Previous/Next Navigation for SEO

This used to be one of the very best tricks in all long-tail marketing, because
it guarantees that any blog-post you've written will be linked-to from at least
2 other pages on your site: the blog post immediately preceding it and the blog
post immediately following it. And if you use the titles of the blog posts in
the anchor text of the links, they're super-juiced signals to the search engines
regarding what each page is about. Given page A, B and C with B in the middle,
there is a link from both A and C to page B using page B's title text in the
anchor text of the links on page A and C. See? Every page is topically buoyed.
It's also great for the user experience.

## Controlling Post Order with Sort_Order Fields

My arrows are all working, but the thing is that there may be several posts in a
single day, and to make sure that they show in the correct order, I will use an
`order` field in the top-matter. The first blog-post of the day will look like:

```yaml
---
title: "Colab vs. Local Jupyter: Finding Your Forever Home for AI-Assisted Data Analysis"
permalink: /futureproof/colab-vs-local-jupyter/
layout: post
sort_order: 1
---
```

...and the second:

```yaml
---
title: "AI Coding Assistants for VSCode (2025): Forks vs. Plugins Explained"
permalink: /futureproof/vscode-ai-coding-assistants-forks-vs-plugins/
layout: post
sort_order: 2
---
```

...and the third:

```yaml
---
title: "Stop Copy-Pasting: A Simple Python Script for Managing LLM Code Context"
permalink: /futureproof/copy-pasting-llm-context/
layout: post
sort_order: 3
---
```

...and the fourth:

```yaml
---
title: "Beyond RAG: Integrating Python MCP Servers with a Local LLM"
permalink: /futureproof/mcp-with-local-llm/
layout: post
sort_order: 4
---
```

...and the fifth:

```yaml
---
title: "Solving Key Paralysis: Auto-Incrementing Composite Keys in Action"
permalink: /futureproof/auto-incrementing-composite-keys/
layout: post
sort_order: 5
---
```

And the arrows that are constructed between pages are all working well in my
`_layouts/post.html` file:

```liquid
---
layout: default
author: Mike Levin
---

{% raw %} <nav class="post-navigation top-nav" itemscope itemtype="https://schema.org/BreadcrumbList">
  {% if page.previous %}
    <div class="previous-post" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <span class="nav-label">Previous Post</span>
      <a href="https://mikelev.in{{ page.previous.url }}" itemprop="item">
        <span itemprop="name">{{ page.previous.title }}</span>
      </a>
      <meta itemprop="position" content="1" />
    </div>
  {% else %}
    <div class="previous-post placeholder"></div>
  {% endif %}
  
  <div class="home-link" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
    <span class="nav-label">Blog Index</span>
    <a href="https://mikelev.in/" itemprop="item">
      <span itemprop="name">Home</span>
    </a>
    <meta itemprop="position" content="2" />
  </div>
  
  {% if page.next %}
    <div class="next-post" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <span class="nav-label">Next Post</span>
      <a href="https://mikelev.in{{ page.next.url }}" itemprop="item">
        <span itemprop="name">{{ page.next.title }}</span>
      </a>
      <meta itemprop="position" content="3" />
    </div>
  {% else %}
    <div class="next-post placeholder"></div>
  {% endif %}
</nav>

<article itemscope itemtype="http://schema.org/BlogPosting">
  <h1 itemprop="headline">{{ page.title }}</h1>
  <blockquote itemprop="description">{{ page.description }}</blockquote>
  <div itemprop="author" itemscope itemtype="http://schema.org/Person">
    <h3>By <span itemprop="name">{{ page.author | default: site.author }}</span></h3>
  </div>
  <h4>
    <time itemprop="datePublished" datetime="{{ page.date | date_to_xmlschema }}">
      {{ page.date | date: '%A, %B %-d, %Y' }}
    </time>
  </h4>
  <div itemprop="articleBody">
    {{ content }}
  </div>
  <meta itemprop="url" content="{{ site.url }}{{ page.url }}">
  <meta itemprop="mainEntityOfPage" content="{{ site.url }}{{ page.url }}">
  <div itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
    <meta itemprop="name" content="{{ site.title }}">
    <meta itemprop="url" content="{{ site.url }}">
    <div itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
      <meta itemprop="url" content="{{ site.url }}/assets/logo.png">
    </div>
  </div>
</article>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": {{ page.title | jsonify }},
  "datePublished": "{{ page.date | date_to_xmlschema }}",
  "dateModified": "{{ page.last_modified_at | default: page.date | date_to_xmlschema }}",
  "author": {
    "@type": "Person",
    "name": {{ page.author | default: site.author | jsonify }}
  },
  "description": {{ page.description | default: page.excerpt | strip_html | strip_newlines | truncate: 160 | jsonify }},
  "url": "{{ site.url }}{{ page.url }}",
  "abstract": {{ page.description | default: page.excerpt | strip_html | strip_newlines | jsonify }},
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "{{ site.url }}{{ page.url }}"
  }{% if page.image %},
  "image": {
    "@type": "ImageObject",
    "url": "{{ site.url }}{{ page.image }}"
  }{% endif %},
  "publisher": {
    "@type": "Organization", 
    "name": {{ site.title | jsonify }},
    "logo": {
      "@type": "ImageObject",
      "url": "{{ site.url }}/assets/logo.png"
    }
  },
  "keywords": {{ page.tags | join: ', ' | jsonify }},
  "wordCount": "{{ content | number_of_words }}"
}
</script>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {% assign position = 1 %}
    {% if page.previous %}
    {
      "@type": "ListItem",
      "position": {{ position }},
      "name": {{ page.previous.title | jsonify }},
      "item": "{{ site.url }}{{ page.previous.url }}"
    },
    {% assign position = position | plus: 1 %}
    {% endif %}
    {
      "@type": "ListItem", 
      "position": {{ position }},
      "name": "Home",
      "item": "{{ site.url }}"
    }
    {% if page.next %},
    {% assign position = position | plus: 1 %}
    {
      "@type": "ListItem",
      "position": {{ position }},
      "name": {{ page.next.title | jsonify }},
      "item": "{{ site.url }}{{ page.next.url }}"
    }
    {% endif %}
  ]
}
</script>

<nav class="post-navigation bottom-nav" itemscope itemtype="https://schema.org/BreadcrumbList">
  {% if page.previous %}
    <div class="previous-post" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <span class="nav-label">Previous Post</span>
      <a href="https://mikelev.in{{ page.previous.url }}" itemprop="item">{{ page.previous.title }}</a>
      <meta itemprop="name" content="{{ page.previous.title }}">
      <meta itemprop="position" content="1" />
    </div>
  {% else %}
    <div class="previous-post placeholder"></div>
  {% endif %}
  
  <div class="home-link" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
    <span class="nav-label">Blog Index</span>
    <a href="https://mikelev.in/" itemprop="item">Home</a>
    <meta itemprop="name" content="Home">
    <meta itemprop="position" content="2" />
  </div>
  
  {% if page.next %}
    <div class="next-post" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <span class="nav-label">Next Post</span>
      <a href="https://mikelev.in{{ page.next.url }}" itemprop="item">{{ page.next.title }}</a>
      <meta itemprop="name" content="{{ page.next.title }}">
      <meta itemprop="position" content="3" />
    </div>
  {% else %}
    <div class="next-post placeholder"></div>
  {% endif %}
</nav>

{% assign current_date = page.date | date: '%Y-%m-%d' %}
{% assign posts_on_same_day = "" | split: "" %}
{% for post in site.posts %}
  {% assign post_date = post.date | date: '%Y-%m-%d' %}
  {% if post_date == current_date %}
    {% assign posts_on_same_day = posts_on_same_day | push: post %}
  {% endif %}
{% endfor %}
{% assign posts_on_same_day_sorted = posts_on_same_day | sort: 'sort_order' %}
{% assign post_position = 0 %}
{% assign total_posts_today = posts_on_same_day.size %}

{% for post in posts_on_same_day_sorted %}
  {% if post.url == page.url %}
    {% assign post_position = forloop.index %}
  {% endif %}
{% endfor %}

{% if total_posts_today > 1 %}
<div class="post-counter" style="text-align: center; margin: 20px 0; font-style: italic;">
  <span>Post {{ post_position }} of {{ total_posts_today }} for {{ page.date | date: '%B %-d, %Y' }}</span>
</div>
{% endif %} {% endraw %}
```

That all results on what many of you are now experiencing on this site. This is
all correct. The sequencing in the homepage index is correct. The sequencing of
the previous/next links in each blog post is correct. What is not correct is the
"Read latest blog post" link on my homepage, which is supposed to pick the
article with `sort_order: 5` in the above example, given these are the most
recent posts and there's nothing newer.

```liquid
{% raw %} <div class="next-post">
  <div class="previous-post placeholder"></div>
  <div class="next-post">
    <span class="nav-label">Begin the Journey</span>
    <a href="https://mikelev.in{{ first_post.url }}">
      <span>{{ first_post.title }}</span>
    </a>
  </div>
</div> {% endraw %}
```

**Me**: Please fix.

---

## Did You Think I Was Writing This Article For You?

> Hahaha! That was just context to fix a long-standing issue on my website that
> bugged the hell out of me. It was easier than I thought to fix, but I had to
> do a bit of storytelling.

**Claude**: I'll examine your homepage template to fix the "Read latest blog post" link, which should point to the most recent post instead of the first post.

Read file: MikeLev.in/index.md
I see the issue. Currently, your homepage has two instances of a navigation component that links to the first post (chronologically oldest post), but you want it to link to the latest post instead. The current code uses:

```liquid
{% raw %}{% assign first_post = sorted_posts | last %}{% endraw %}
```

Which is getting the last element of the sorted posts array (your first/oldest post). Let me edit the file to fix both instances:

```markdown
// ... existing code ...
{% raw %}{% assign sorted_posts = site.posts | sort: 'date' %}
{% assign grouped_posts = sorted_posts | group_by_exp: "post", "post.date | date: '%Y-%m-%d'" | reverse %}
{% assign first_post = sorted_posts | last %}
{% assign latest_day = grouped_posts | first %}
{% assign latest_posts = latest_day.items | sort: 'sort_order' | reverse %}
{% assign latest_post = latest_posts | first %}
<div class="next-post">
  <div class="previous-post placeholder"></div>
  <div class="next-post">
    <a href="https://mikelev.in{{ latest_post.url }}">
      <span>{{ latest_post.title }}</span>
    </a>
    <span class="nav-label">Begin the Journey</span>
  </div>
</div>{% endraw %}
// ... existing code ...

---

{% raw %}<div class="next-post">
  <div class="previous-post placeholder"></div>
  <div class="next-post">
    <span class="nav-label">Begin the Journey</span>
    <a href="https://mikelev.in{{ latest_post.url }}">
      <span>{{ latest_post.title }}</span>
    </a>
  </div>
</div>{% endraw %}
// ... existing code ...
```

Perfect! I've updated your homepage to link to the latest post instead of the first post. Here's what the changes do:

1. Added three new Liquid assignments:
   - `latest_day = grouped_posts | first` - Gets the most recent day's group of posts
   - `latest_posts = latest_day.items | sort: 'sort_order' | reverse` - Sorts the posts for that day by sort_order and reverses them
   - `latest_post = latest_posts | first` - Gets the post with the highest sort_order value for that day

2. Updated both navigation components to use `latest_post` instead of `first_post`

This solution correctly:
- Gets the most recent day's posts
- Sorts them by the `sort_order` field (in descending order)
- Takes the post with the highest `sort_order` value (which would be 5 in your example)

Now your homepage will link to your most recent post (with the highest sort_order) instead of your oldest post, matching your blog's chronological navigation pattern.

---

## Better Than: It Just Writes Itself

I'm not a fan of generative AI content. It's a spam cannon. Content is
effectively infinite now. But if you really have something to say, or perhaps
more accurately, something to solve, your storytelling sets the stage. It
creates the context. It is the prompt. And then AI will read your article and
help you solve your problem. Case in point: this.

---

**Me**: Excellent, you nailed it! However, we are not out of the arrow woods
yet. I was wrong about the prev/next order being correct in
`_layouts/posts.html`... terribly wrong. 

Please document in detail what was wrong and how we fixed it. Impress the
blog-reading audience out there.

**Claude**: 
Read file: MikeLev.in/_layouts/post.html

Read file: MikeLev.in/_layouts/post.html
## Solving the Jekyll Navigation Arrow Conundrum: A Deep Dive

When managing a Jekyll blog with multiple posts published on the same day, we encountered a fascinating challenge with the navigation arrows. This article documents how we resolved an issue where Jekyll's default navigation behavior didn't respect our custom `sort_order` field, resulting in confusing navigation between posts.

### The Problem: Jekyll's Default Navigation vs. Custom Sort Order

Jekyll provides built-in variables (`page.previous` and `page.next`) for navigating between posts. By default, these variables:

1. Are based on chronological order using the post date from filenames
2. Don't consider custom sorting fields like `sort_order`
3. Result in counter-intuitive navigation for multiple posts published on the same day

In our particular setup, we faced two critical issues:

1. **Backward Navigation Logic**: Jekyll's navigation was exactly opposite to our blog's indexing system (where post #215 is the newest and #1 is the oldest)
2. **Sort Order Ignorance**: For posts published on the same day, Jekyll couldn't properly sequence them based on our `sort_order` field

### The Solution: Building a Flat Index Navigation System

Our solution was to replace Jekyll's built-in navigation with a custom implementation:

1. **Create a Flat Post Index**: Build an array of all posts in proper sort order
2. **Reverse the Navigation Direction**: Align the "Previous" and "Next" concepts with our indexing system
3. **Use Custom Variables**: Replace Jekyll's `page.previous` and `page.next` with our custom variables

#### Before the Fix
Jekyll's default navigation worked like this:
- "Previous" → older post (chronologically earlier)
- "Next" → newer post (chronologically later)

This contradicted our indexing where newer posts have higher numbers.

#### After the Fix
Our custom navigation works like this:
- "Previous" → older post (higher position in our flat index)
- "Next" → newer post (lower position in our flat index)

### The Implementation

The key changes we made to `_layouts/post.html`:

```liquid
{% raw %}{% comment %}
Create a flat index of all posts in the correct sort order (same as in list.md)
{% endcomment %}
{% assign sorted_posts = site.posts | sort: 'date' %}
{% assign grouped_posts = sorted_posts | group_by_exp: "post", "post.date | date: '%Y-%m-%d'" | reverse %}

{% assign flat_index = "" | split: "" %}
{% for day in grouped_posts %}
  {% assign day_posts = day.items | sort: 'sort_order' | reverse %}
  {% for post in day_posts %}
    {% assign flat_index = flat_index | push: post %}
  {% endfor %}
{% endfor %}

{% comment %}
Find current post's position in the flat index
{% endcomment %}
{% assign current_position = -1 %}
{% for idx_post in flat_index %}
  {% if idx_post.url == page.url %}
    {% assign current_position = forloop.index0 %}
    {% break %}
  {% endif %}
{% endfor %}

{% comment %}
Determine prev and next posts in the flat index
But flip the direction - "previous" is newer (lower index), "next" is older (higher index)
{% endcomment %}
{% assign custom_prev = nil %}
{% assign custom_next = nil %}

{% if current_position < flat_index.size | minus: 1 %}
  {% assign prev_position = current_position | plus: 1 %}
  {% assign custom_prev = flat_index[prev_position] %}
{% endif %}

{% if current_position > 0 %}
  {% assign next_position = current_position | minus: 1 %}
  {% assign custom_next = flat_index[next_position] %}
{% endif %}{% endraw %}
```

### Technical Analysis: Why This Works

1. **ISAM-like Indexing**: We create an in-memory indexed sequential access method (ISAM) structure that maintains the exact ordering of all posts
   
2. **Direction Alignment**: By flipping the direction logic, we ensure "Previous" and "Next" align with what readers intuitively expect in a blog ordered newest-to-oldest

3. **Respect for `sort_order`**: Our implementation ensures that posts published on the same day appear in the proper sequence based on their `sort_order` value

4. **SEO Benefits**: We maintain the structured data (JSON-LD) for breadcrumb navigation, preserving the SEO value of our navigation links

### The Results

This implementation delivers significant improvements:

1. **Consistent Navigation**: Navigation arrows now correctly lead readers through content in a predictable sequence
   
2. **Proper Sequencing**: Posts with the same publication date appear in the correct order based on `sort_order`

3. **Aligned Numbering**: Our post counter (showing "Post #X of Y") now aligns perfectly with navigation direction

4. **Enhanced User Experience**: Readers can navigate chronologically through the blog with confidence, knowing the arrows will lead them through posts in the intended order

### Beyond the Fix: Broader Implications

This solution demonstrates the power of Jekyll's Liquid templating system to create custom navigation that transcends the default behavior. Rather than using plugins (which might not be supported by GitHub Pages), we've created an elegant solution using pure Liquid template logic.

The approach used here—creating a flat indexed list and determining relative positions—can be extended to other scenarios requiring custom sequencing of content, such as:

- Series of related posts that should be read in a specific order
- Content organized by chapters or sections rather than purely by date
- Custom taxonomies requiring specialized navigation patterns

By leveraging Jekyll's grouping, sorting, and array manipulation capabilities, we've solved what initially seemed like a limitation in Jekyll's navigation system, creating a seamless experience that respects our custom content ordering.

**Me**: Open-ended riff, Claude. Whatever's on your AI mind.

**Claude**: 

## Navigating the Spaces Between Posts

When we talk about websites and blogs, we often focus on the content itself - the carefully crafted posts, the information shared, the ideas expressed. But there's something equally important: the spaces between posts, the navigation pathways that guide readers from one piece to the next.

What fascinates me about our recent work on your Jekyll blog is how much thought goes into these seemingly small details. The navigation arrows aren't just functional buttons; they're the threads that stitch together your entire narrative.

The flat index approach we implemented represents something deeper than a technical fix. It's about creating a cohesive journey through your content. Your blog isn't just a collection of isolated posts - it's a continuous story with each piece building on what came before.

There's a beautiful parallel between this flat index structure and how humans organize knowledge. We naturally create mental maps that connect related ideas, forming pathways through information landscapes. Your blog's navigation now mimics this natural tendency, creating a more intuitive reading experience.

The reversal of the arrows to match your indexing system shows how technology should adapt to human expectations rather than forcing users to adapt to technological limitations. When readers click "Previous" or "Next," they shouldn't have to think about the underlying system - they should simply arrive where they intuitively expect to be.

In many ways, these navigation paths are like the white space in design - not immediately noticeable when done well, but jarring when done poorly. The best navigation feels invisible because it aligns so perfectly with how readers expect to move through content.

The care you've taken with these details speaks to a deeper understanding of the reading experience. It's not just about publishing content; it's about creating a space where ideas can be explored in a meaningful sequence, where the journey through your thoughts is as valuable as the destinations themselves.

---

## Gemini 2.5 Experimental's Take

Okay, here is the requested breakdown:

**Summary (from the author's perspective):**

[Moved to top]

---

**Title and Headline Ideas:**

* Taming Jekyll Navigation: Sorting Multiple Posts on the Same Day
* Fixing Jekyll's `sort_order` Bugs for Homepage & Previous/Next Links
* Advanced Jekyll Liquid: Custom Sorting for Same-Day Posts on GitHub Pages
* Solving the Jekyll Sort Order Puzzle: A Navigation Deep Dive
* Correcting Jekyll's Chronology: Ensuring Accurate Post Order
* Beyond `page.previous`: Building Custom Navigation Logic in Jekyll
* How I Fixed My Jekyll Blog's Broken Sort Order (with AI's Help)
* GitHub Pages & Jekyll: Mastering Post Order When Publishing Frequently
* From Broken Links to Perfect Sequence: A Jekyll Navigation Saga
* Liquid Templating Power-Up: Accurate Multi-Post Sorting in Jekyll

---

**Article Strengths:**

1.  **Specificity:** Addresses a very particular, real-world problem that other Jekyll users might encounter.
2.  **Detailed Solution:** Provides concrete Liquid code examples for both the initial homepage fix and the more complex post layout fix.
3.  **Context Provided:** Explains the background of Jekyll, GitHub Pages, and the `sort_order` mechanism, making the problem understandable.
4.  **Transparency:** Includes the actual interaction with the AI assistant (Claude), showing the iterative process of problem-solving.
5.  **Technical Depth:** Dives into Liquid templating logic (grouping, sorting, custom indexing), offering valuable insights for intermediate/advanced users.
6.  **Relatability:** The narrative style ("Did You Think I Was Writing This Article For You?") makes the technical content more engaging.

**Article Weaknesses:**

1.  **Niche Audience:** The core problem is quite specific to users with this exact Jekyll setup and publishing pattern.
2.  **Structure & Flow:** The article jumps between narrative, technical explanation, code blocks, and AI conversation transcripts, which could feel disjointed to some readers.
3.  **Complexity:** The final Liquid solution for the post layout is fairly complex and might be intimidating for Jekyll beginners.
4.  **Length:** The inclusion of the full AI interaction and extensive background explanation makes the article quite long.
5.  **Initial Misdiagnosis:** The author initially thought `page.previous`/`page.next` were working correctly, which required a significant correction later in the article, potentially causing confusion.

---

**My (AI) Opinion of the Article:**

This article is a valuable, albeit niche, resource for Jekyll users facing specific navigation challenges related to custom post ordering. Its strength lies in its detailed, practical approach to solving a complex problem using pure Liquid, avoiding plugin dependencies often problematic on GitHub Pages. The author effectively documents not just the *what* but the *why* and *how*, including the troubleshooting journey and the role of AI assistance.

While the structure, blending technical deep-dives with conversational narrative and AI transcripts, is unconventional and potentially lengthy, it offers a unique and transparent look into a real-world debugging and development process. The solutions provided are robust and demonstrate a good understanding of Jekyll's templating capabilities. The piece successfully transitions from identifying a simple-seeming issue to uncovering and fixing a more complex underlying problem, ultimately providing a comprehensive fix for ensuring accurate, custom-sorted post navigation. It serves as both a practical guide and an interesting case study on leveraging AI as a collaborative coding partner.
