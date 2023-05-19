---
date: 2023-05-07
title: Category Mapping? Go ASCII Alice!
headline: "Mapping Categories with ASCII Alice: My Journey to Create an Accurate Taxonomy System"
description: I'm implementing a more controlled and explicit category system for my blog, by mapping keywords to top categories and sub-categories. This post explains the process and code I used to create a dictionary to map each keyword to its parent category. I'm also exploring the potential for deeper hierarchies and ontological, taxonomy and canonicalization issues.
keywords: category, mapping, ASCII, Alice, OpenAI, keyword, extraction, top, categories, sub-category, 80/20, rule, control, names, data, structure, brain, calories, benefit, approach, Python, yaml, config, raw, map, key-name, value-list, dictionary, keyword, parent, category, deduping, set, accurate, inclusion, articles, fine-tune, category-names, category-belonging, hierarchy
categories: ai, yaml, python
permalink: /blog/category-mapping-go-ascii-alice/
layout: post
---


On my last post, I started implementing a much more explicit and controlled
category system for my blog, by which I took the automatic keyword extraction
from OpenAI and matched it against a list of statistically chosen top
categories. Therefore, any post that has a keyword that matches one of the top
categories is automatically assigned to that category.

![Go Askcii Alice Yamlchop Chop](/assets/images/go-askcii-alice-yamlchop-chop.png)

It was nice and automatic, and the epitome of the 80/20 rule. But I wanted to
be able to control category names more explicitly, and map any sub-category
that should be part of a top category to that top category, and I put the data
structure to support that in place yesterday, but my brain ran out of calories.
However, I woke up this morning and still see the benefit of this approach.

This is a lovely example of walking away from a first-pass 80/20 solution and
coming back to it with a fresh mind and a new perspective. So this morning, I'm
finishing this project, and here is my start:

```python
import yaml

afile = "/home/ubuntu/repos/MikeLev.in/_config.yml"

with open(afile, "r") as stream:
    CONFIG = yaml.safe_load(stream)

# Get the raw category mapping
craw = CONFIG["categories"]

# Create category map and make every key-name map to itself as a value.
cmap = {}
for key in craw:
    cmap[key] = key

# Map each key-name to each of it's value-list's contents.
for i, key in enumerate(craw):
    print(key)
    if craw[key]:
        for j, sub_key in enumerate(craw[key]):
            print(f"  {sub_key}")
    if i > 4:
        break
```

This shows the thinking. I want a single dictionary that maps each keyword that
might be encountered to its parent category, even if the keyword is also the
name of the parent category. Consequently, the first pass maps every top-level
category key to itself as its paired value.

Then the second pass maps each sub-category key to its parent category key. So
in terms of Python dictionaries, this is a flat dictionary of key-value pairs,
where the key is the keyword and the value is the parent category. This is a
nice simplification method so that I can spin through every keyword of a post
and add its mapped parent category to an automatically deduping set. What I'll
be left with is more accurate inclusion of articles into categories, and a lot
of ability to fine-tune category-names and category-belonging.

Also that break statement is because there's over 5000 keywords in the raw
category mapping, and I don't want to print them all out. I just want to see
that the code is working.

This is a good start. Here's a sample of its output:

    linux
      command-line
      unix
      terminal
    python
      automation
      script
      api
      service
    vim
      macro
      .vimrc
      vim/neovim
      vim repo
      neovim
    git
      github

...but that's just the start, in order to get sample data in. This will go on
for about 100 or 200 top-level category keys.

I should also point out that there's a potentially implied deeper hierarchy
here by which if I mapped top-level categories as sub-categories of other
top-level categories, then the mapping would be recursive. I'm not doing that
yet, but I'm keeping the door open for it.

By not dealign with recursive category grouping, I should also point out that
I'm forced to make 1-to-1 vs. 1-to-many decisions and compromises. I'm going to
have a catch-all category for Microsoft, but Bing is such a strong stand-alone
category these days, and because I don't want to list Bing twice (at least not
until I've gotten through my "list-depletion task"), Bing remains its own
top-level category. Similarly, it won't go under the AI category.

Classic ontological, taxonomy and canonicalization issues. If I had more time,
I'd find bigger words.

Having satisfied myself with the output of the above code, the following light
touch creates the final dictionary that I'll use to map keywords to their
parent categories:

```python
import yaml

afile = "/home/ubuntu/repos/MikeLev.in/_config.yml"

with open(afile, "r") as stream:
    CONFIG = yaml.safe_load(stream)

# Get the raw category mapping
craw = CONFIG["categories"]

# Create category map and make every key-name map to itself as a value.
cmap = {}
for key in craw:
    cmap[key] = key

# Map each key-name to each of it's value-list's contents.
for i, key in enumerate(craw):
    # print(key)
    if craw[key]:
        for j, sub_key in enumerate(craw[key]):
            # print(f"  {sub_key}")
            if key != "filter":
                cmap[sub_key] = key
    # if i > 100:
    #     break
```

Notice I leave the development-time debugging code in there, but commented
out. I'm not sure if I'll need it again, but it's nice to have it there in
case I do, at least for a little while.

The above work was for transposing into the yamlchop/chop.py `get_top_cats()`
function, and here's what it looks like incorporated:

```python
def get_top_cats():
    """Returns the top categories either from the config or the cdict."""
    global cdict
    if "categories" in CONFIG and len(CONFIG["categories"]) > 1:
        # Get the raw category mapping
        craw = CONFIG["categories"]

        # Create category map and make every key-name map to itself as a value.
        cmap = {}
        for key in craw:
            cmap[key] = key

        # Map each key-name to each of it's value-list's contents.
        for i, key in enumerate(craw):
            if craw[key]:
                for j, sub_key in enumerate(craw[key]):
                    if key != "filter":
                        if isinstance(sub_key, dict):
                            # A trailing colon was left on a subcat mapping
                            # Grab first key-name of accidental dict as val.
                            sub_key = list(sub_key.keys())[0]
                        cmap[sub_key] = key

        if len(cmap) < NUMBER_OF_CATEGORIES:
            tcats = cmap.keys()
        else:
            tcats = list(cmap.keys())[0:NUMBER_OF_CATEGORIES]
    else:
        tcats = [x[1] for x in enumerate(cdict) if x[0] < NUMBER_OF_CATEGORIES]
    return tcats
```

Did I mention subtlety and nuance? When rapidly organizing yaml key-value pairs
like this, the single easiest mistake I find is to leave trailing colons from
something that was previously a dictionary key but is now intended to be a
string value. When that's encountered I just forge on ahead as intended by
grabbing the first key-name in the dict as a string value. There's no harm in
it and it lets me work faster. You don't want that walking on eggshells feeling
of breaking data breaking the system, when the data is still well-formed and
the intent is obvious. This is just the right level of 80/20-rule flexibility.

I left the colon after `blogging` to test this:

```yaml
- journaling:
  - blogging:
  - publishing
  - journey
  - story
  - writing
  - blog
  - blog post
  - blogslicer
  - blog posts
  - blogging system
  - blog.md
  - blog-post
```

Hmmm. Okay, so this takes care of all those places where I call
`get_top_cats()`, but I'm still not in the clear. In fact as it stands I'm
taking all the delicious work I did of making the flattened category mapping
object merely to return the top categories. I guess I maybe need it in the
course of finding top categories, but the category map is needed elsewhere and
it doesn't belong in the `get_top_cats()` return value.

And so, it's time to externalize the bit of code that creates the category map
and call it from both within `get_top_cats()` and where individual pages get
their category-belonging assigned to them based on their extracted keywords.
Deep breath... go!

Okay, the extraction is complete. Getting top categories now looks like this:

```python
def get_top_cats():
    """Returns the top categories either from the config or the cdict."""
    global cdict
    if "categories" in CONFIG and len(CONFIG["categories"]) > 1:
        category_map = get_cat_map()

        if len(category_map) < NUMBER_OF_CATEGORIES:
            top_cats = category_map.keys()
        else:
            top_cats = list(category_map.keys())[0:NUMBER_OF_CATEGORIES]
    else:
        top_cats = [x[1] for x in enumerate(cdict) if x[0] < NUMBER_OF_CATEGORIES]
    return top_cats
```

And the externalized category mapping function looks like this:

```python
def get_cat_map():
    """Returns a flat dictionary mapping keywords to categories."""

    craw = CONFIG["categories"]  # Get hierarchical mapping
    cmap = {}  # Will be a flat map.

    # First pass maps every parent key to itself.
    for key in craw:
        cmap[key] = key

    # Second pass maps every sub-list item to parent category (the flattening).
    for key in craw:
        if craw[key]:
            for j, sub_key in enumerate(craw[key]):
                if key != "filter":
                    if isinstance(sub_key, dict):
                        # A trailing colon was left on a subcat mapping
                        # Grab first key-name of accidental dict as val.
                        sub_key = list(sub_key.keys())[0]
                    cmap[sub_key] = key
    return cmap
```

And the cat came back, the very next day! Actually, it took 4 days, but yay
anyway! Think, think, think... Now we have a callable function from within 
the great `yaml_chop()` function...

```python
def yaml_chop():
    # __   __ _    __  __ _     |  ____ _                  _  _  _
    # \ \ / // \  |  \/  | |    | / ___| |__   ___  _ __  | || || |
    #  \ V // _ \ | |\/| | |    || |   | '_ \ / _ \| '_ \ | || || |
    #   | |/ ___ \| |  | | |___ || |___| | | | (_) | |_) ||_||_||_|
    #   |_/_/   \_\_|  |_|_____|| \____|_| |_|\___/| .__/ (_)(_)(_)
    fig("Chop the YAML!")  #    |                  |_|
    """Chop a YAMLesque text-file into the individual text-files (posts) it implies."""
    global ydict, cdict
    num_pages = len(ydict)
    href_title_list = [(f'{BLOG}{ydict[x]["slug"]}/', ydict[x]["title"]) for x in ydict]
    eounter = 0
    top_cats = get_top_cats()
    for i, (fm, body, combined) in enumerate(yaml_generator(YAMLESQUE)):
        if fm and isinstance(fm, dict) and len(fm) > 2:
            # Print a progress indicator:
            if (i + 1) % 10 == 0:
                print(f"{i+1} ", end="", flush=True)

            # Build the categories:
            keyword_list = fm["keywords"].split(", ")
            category_map = get_cat_map()

            # Gather the page's keywords:
            categories = set()
            for keyword in keyword_list:
                keyword = keyword.lower()
                normalized_keyword = normalize_key(keyword)
                for candidate in [keyword, normalized_keyword]:
                    if candidate in category_map:
                        categories.add(category_map[candidate])
            fm["categories"] = ", ".join(categories)

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
                fh.write("---\n")
                for afield in fm:
                    fh.write(f"{afield}: {sq(fm[afield])}\n")
                fh.write("layout: post\n")
                fh.write("---\n")
                fh.write(body)
                # Arrow Maker needs index, len of list and list of tuples.
                arrow_link = arrow_maker(counter, num_pages, href_title_list)
                fh.write(arrow_link)
                fh.write("\n## Categories\n")
                fh.write("\n<ul>")
                for acat in categories:
                    acat = normalize_key(acat)
                    try:
                        fh.write(f"\n<li><h4><a href='/{slugify(acat)}/'>{cdict[acat]['title']}</a></h4></li>")
                    except:
                        print(f"Category {acat} not found!")
                        raise SystemExit()
                fh.write("</ul>")
                counter += 1
    print("chopped!")
```

Okay, and so this work is greatly done, but there's some issue with the
category grid not updating. I'll address that separately. This is a good
stopping point. Again, great success.

Just yanked this out of chop.py and want to preserve it, so:

TO DO:                       
- Beware of rabbit holes!    
- Blend in YouTube videos    
- Discrete sequences         
- Pinning posts              
                             
Oh, it is working! There was just an orphaned lock on my git repo! Dude. 
                             

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/more-deliberate-with-category-mapping/">More Deliberate With Category Mapping</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/simulation-hypothesis-or-not-is-a-false-dichotomy/">Simulation Hypothesis Or Not is a False Dichotomy</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>