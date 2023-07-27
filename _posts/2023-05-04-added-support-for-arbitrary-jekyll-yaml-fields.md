---
date: 2023-05-04
title: Added Support for Arbitrary Jekyll YAML Fields
headline: I Improved my Code and Gained More Control Over My Blog Posts
description: "Clean up your drafts folder and start using `_drafts` for actual drafts! Learn how to set the publish field to false in Jekyll Front Matter, adjust list comprehension to filter out unpublished posts, and preserve fields during the YAML-chopping step. Improve the core yamlchop function with a before and after example and see the result with the first release under the new code."
keywords: Jekyll, YAML, Rebase, Drafts, Publishing, Status, Front Matter, Unpublished, List Comprehension, Filtering, Fields, Processing, Data Structure, OpenAI, Writing, Calculating, Customizations, Release, Blog Post, Unpublishing
categories: yaml, draft, jekyll, ai
permalink: /blog/added-support-for-arbitrary-jekyll-yaml-fields/
layout: post
group: blog
---


My drafts folder is really cleaned up since I "rebased" my public site repo.
And so I can start using `_drafts` for actual drafts. Let's go look at the
publishing status field in Jekyll... yup. [Jekyll Front
Matter](https://jekyllrb.com/docs/front-matter/)

I can set publish to false, and that's just a super quick fix to keep the YAML
where it is and still turn off the publishing of that one particular post. I
may have to adjust the list comprehension to filter out unpublished posts, but
that's easy.

More important is making those fields get preserved during the YAML-chopping
step. I very deliberately write the fields in a certain order and do some
processing, because those fields don't actually exist source-side. That would
be keywords, description, and headline. OpenAI writes those, so I don't just
dump the data-structure from source. There's also other fields not written by
OpenAI, but which I calculate and layer in. That's mostly just the categories
field right now.

Ah! A chance to improve the core yamlchop function! Wow, that really just
amounted to cleaning up yaml_chop(). Here's the new code:

```python
def yaml_chop():
    # __   __ _    __  __ _     |  ____ _                  _  _  _
    # \ \ / // \  |  \/  | |    | / ___| |__   ___  _ __  | || || |
    #  \ V // _ \ | |\/| | |    || |   | '_ \ / _ \| '_ \ | || || |
    #   | |/ ___ \| |  | | |___ || |___| | | | (_) | |_) ||_||_||_|
    #   |_/_/   \_\_|  |_|_____|| \____|_| |_|\___/| .__/ (_)(_)(_)
    fig("Chop the YAML!")  #    |                  |_|
    """Chop a YAMLesque text-file into the individual text-files (posts) it implies."""
    for i, (fm, body, combined) in enumerate(yaml_generator(YAMLESQUE)):
        if fm and isinstance(fm, dict) and len(fm) > 2:

            # Print a progress indicator:
            if (i + 1) % 10 == 0:
                print(f"{i+1} ", end="", flush=True)

            # Build the categories:
            keyword_list = fm["keywords"].split(", ")
            top_cats = get_top_cats()
            categories = set()
            for keyword in keyword_list:
                keyword = keyword.lower()
                nkey = normalize_key(keyword)
                if keyword in top_cats or nkey in top_cats:
                    categories.add(keyword)
            categories = ", ".join(categories)
            fm["categories"] = categories
            
            # Format the date:
            adate = fm["date"]
            date_object = datetime.strptime(adate, "%a %b %d, %Y")
            adate = date_object.strftime("%Y-%m-%d")
            fm["date"] = adate

            # Build the permalink:
            stem = slugify(fm["title"])
            fm["permalink"] = f"{BLOG}{stem}/"

            filename = f"{OUTPUT_PATH}/{adate}-{stem}.md"
            with open(filename, "w", encoding="utf-8") as fh:
                fh.write("---")
                for afield in fm:
                    fh.write(f"{afield}: {sq(fm[afield])}\n")
                fh.write("layout: post\n")
                fh.write("---\n")
                fh.write(body)
                fh.write("\n## Categories\n")
                fh.write("\n<ul>")
                for asubcat in categories.split(", "):
                    asubcat = asubcat.strip().lower()
                    if asubcat in top_cats:
                        fh.write(f"\n<li><h4><a href='/{slugify(asubcat)}/'>{cdict[asubcat]['title']}</a></h4></li>")
                fh.write("</ul>")
    print("chopped!")
```

There we go! How much cleaner is that? And now with that light touch, it
becomes more powerful. This is always the best case scenario. Through actually
cleaning up and making less code (but for comments), your code becomes more
under your control and more powerful. Now any discretionary fields I feel like
dropping into the longfile-source, I can do so, and they will be handled
automatically. This goes for Jekyll-supported fields like published, or ones
that I make up for special template-handling purposes and other customizations.
Very powerful.

Okay, I'm doing my first release under this new code. Let's see if that blog
post becomes unpublished and what it does to the arrows.


































<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/why-markdown-why-yaml-why-they-re-great-together/">Why Markdown? Why YAML? Why They're Great Together!</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/rendering-un-styled-jekyll-markdown-drafts-for-pasting-into-google-docs/">Rendering Un-Styled Jekyll Markdown Drafts for Pasting Into Google Docs</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/draft/'>Drafts</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>