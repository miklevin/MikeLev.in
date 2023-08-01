---
date: 2023-05-06
title: More Deliberate With Category Mapping
headline: Exploring YAML Dicts to Optimize Category Mapping
description: I'm optimizing my blog post categorization system by grouping common keywords into parent categories. I'm learning about YAML dictionaries and sub-dictionaries to create a nested structure for my categories. I'm also making sure to keep the list of categories as short as possible by using the lemmatized version of words. Finally, I'm working on a custom object shape to keep the categorization system running smoothly.
keywords: "category mapping, OpenAI, keyword extraction, YAML, mappings, dictionaries, sub-dictionaries, nested mappings, lemmatized version, top categories, `_config.yml`, `_data`, categories.yml, cdict, iPython, Jupyter, VSCode, pickle"
categories: ai, yaml, microsoft, jupyter
permalink: /blog/more-deliberate-with-category-mapping/
layout: post
group: blog
---


I like the categories that my system is auto-selecting to sort my blog posts
under. I'm itching to get to the particular linear sub-sequence of pages
project that I alluded to in previous posts, but before I do that another
light-touch 80/20-rule advancement is nagging at me. It's a sort of clumping or
grouping within the category mapping, where the keyword extraction being done
by OpenAI isn't bad, but it's leaning towards single-words, which are often
just too common to be category labels. I find myself filtering more and of
these.

I've filtered a lot of good words from the categories because the term is too
broad for a site category, not appropriate for my site or redundant with
another term. Well, instead of just filtering it all out, I can roll them up
into parent categories to optimize the category mapping. And I can use the same
`_config.yml` file that I use to do this category filtering.

Hmm, I need to know about yaml dicts. That's not something I thought I'd be
saying. So, Google tell me a little about yaml dicts. Oh wait, Google doesn't
have conversational search yet (Bard doesn't count). Bing: tell me about yaml
dicts.

Bing: In YAML, dictionaries are represented as mappings. A mapping is a collection of key-value pairs, where each key is mapped to a value ¹. 

Here is an example of a dictionary in YAML:

```
name: John
age: 30
city: New York
```

I hope this helps. Let me know if you have any other questions.

Source: Conversation with Bing, 5/6/2023

    (1) How to represent dictionaries in YAML - Educative: Interactive Courses .... https://www.educative.io/answers/how-to-represent-dictionaries-in-yaml.
    (2) What is YAML and How To Use It - Salt. https://docs.saltproject.io/en/latest/topics/yaml/index.html.
    (3) Learn YAML tutorials with examples - W3schools. https://www.w3schools.io/file/yaml-arrays/.
    (4) YAML Syntax — Ansible Documentation. https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html.
    (5) Building an array of dictionary items in YAML? - Stack Overflow. https://stackoverflow.com/questions/30221348/building-an-array-of-dictionary-items-in-yaml.
    (6) Expressions - Azure Pipelines | Microsoft Learn. https://learn.microsoft.com/en-us/azure/devops/pipelines/process/expressions?view=azure-devops.

Me: Yes, I know that much Bing, but thank you. Tell me about yaml sub-dicts.

Bing: In YAML, sub-dictionaries are represented as nested mappings. Here is an example of a sub-dictionary in YAML:

```
person:
  name: John
  age: 30
  address:
    street: 123 Main St.
    city: New York
    state: NY
    zip: 10001
```

I hope this helps. Let me know if you have any other questions.

Yes, why that is exactly what I needed to know. Thank you Bing.

Now I can roll up the categories into parent categories. But I want to make
sure I handle this correctly. Because I have an already existing "filter" list,
there's going to be colliding concepts. If I'm moving to a more nested or
hierarchical dictionary structure... then... then... oh, of course!

One of the keys becomes the filter bucket. I still have a filter, it's just
that it's sort of like the nil or null device, or whatever. It's also one of my
dictionary keys, and anything I sort under that key gets filtered. All the
other keys have the effect of mapping the synonym or shorter version of the
category into the desired category label.

Hmmm, another conflict occurs to me. My `top_cats()` function returns the list
of top categories automatically through a sort of quick site interrogation. But
this could move it to a potentially more pre-processed implementation. How
would that look?

There's a rather inclusive approach by which I output all the categories to a
file and do an one-time import of them into the `_config.yml` file. Then I have
a sort of rolling-up task which because YAML is such a simple format amounts to
copy/pasting them around, plus some indenting. Yeah, let's do that. I don't
even need to think through the implementation yet, as I can just plop all 5,000
or so that are going to be produced into a deep-sixed key, then move them out
of there as desired. 1, 2, 3... 1?

One thing to keep in mind is that I only want to ever deal with the lemmatized
version of the words to keep the list as short as possible.

Okay, so I turn off git pushing the site temporarily.

Okay, I move the check that I added recently to prevent numeric categories to a
post-processing location so that it doesn't interfere with keyword collection.
I actually want the years like 2020 and Ubuntu versions like 20.04 to be mapped
into parent categories, so the early-phase filtering of these numbers is no
longer desirable. Keep the code in there and working the same way, but move it.
Okay done and done. Next?

Look at where the lemmatized keywords are being collected. It's in word_list
(duh). Okay, so figure out the path to where you'd like a raw version of this
list saved. Obviously in the `_data` directory. So, `_data/categories.yml` is
where I'll save it. Make that path. 

```python
cat_file = f"{REPO_DATA}categories.yml"
```

And now to dump the word_list (which isn't really a list) into the file. I
don't kneed the whole dictionary, just the keys:

```python
with open(cat_file, "w") as fh:
    yaml.dump(list(word_list.keys()), fh)
```

Nice. Now dump that output into a key called all_categories in the
`_config.yml` file and do site generate. Nice, everything's still working.

Next is a biggie. Instead of flat key-value pairs, I want to have a nested
dictionary structure. The top-level shall be "categories" under which I'll have
an all and filter key. I'll move the existing filter under that key and alter
the code to use the filter from there and re-generate the site and see if the
chosen top categories for the site changed by looking at it's include file (no
actual Github Pages release necessary).

Wow, working exactly as intended. Now think! Previously the whole category
thing was all automatic and quite easy for anyone taking up the yamlchop
system, but now it's starting to require a custom object shape residing inside
of `_config.yml`. Keep an eye on that, and maybe just turn off the whole
categorization system if that custom shape isn't present.

Hmmm, what I need is in cdict. This is where having the iPython engine of
Jupyter or VSCode would be nice, but I can just pickle it too and then load it
into Jupyter:

```python
with open(f"{REPO_DATA}cdict.pkl", "wb") as f:
    pickle.dump(cdict, f)
```

Nice, now I can get all the keywords in descending order of frequency in
Jupyter:

```python
import pickle

with open("/home/ubuntu/repos/MikeLev.in/_data/cdict.pkl", "rb") as f:
    cdict = pickle.load(f)
[(x, cdict[x]["count"]) for x in cdict]
```

Now that I'm satisfied they're in descending order of frequency, I can make a
new version in Jupyter that pre-formats it to be copy/paste ready to go under
the `all` key in `_config.yml`:

```python
import pickle

with open("/home/ubuntu/repos/MikeLev.in/_data/cdict.pkl", "rb") as f:
    cdict = pickle.load(f)
for k in cdict:
    print(f"    - {k}")
```

And generate the site again (without git push)... Oops. Not good yaml. You
can't just go pasting unencoded values into a yaml file. Let's go through
proper encoding by making a yaml object and then dumping it:

```python
import pickle
import yaml

with open("/home/ubuntu/repos/MikeLev.in/_data/cdict.pkl", "rb") as f:
    cdict = pickle.load(f)
all_cats = [k for k in cdict]
print(yaml.dump(all_cats))
```

Much better. I can do the 4-space indenting across a few thousand rows in
NeoVim just as easily as in Jupyter. Most importantly, the encoding is there
and the descending by keyword frequency order is preserved.

And I'm not showing it here, but I did one more step to filter everything from
the already existing list of filtered keyword from the `all` list since I'll be
sort of doing a list depletion task from all, mapping them into other sub-keys
and I don't want to deal with duplicates. I'll process the ones from the
`filter` key and the ones from the `all` key and never see the same keyword
twice now.

Okay, I think I can get the best of both again. Because I always load the
`_config.yml` file during site generation, I can just check for the presence of
the `categories` key and if it's not there, I can just skip the explicit
categorization approach and use the implicit one that's already there. It
should basically be working that way now. Let's see... yup. Nice.

Hmm. So `_config.yml` is starting to fulfill a lot of purposes. And as much as
I don't like introducing another global variable, it would be nice to have
something like the site configuration always available, and not just loaded in
the category finder. Think! Yup. The local `_config` variable is now the global
`CONFIG` variable. That opens quite a few possibilities.

Okay, now work on the structure within the `categories` key. Put the logic in
to defend against not having enough categories to support the category grid.
Okay, that's done. Now move 100 of the most frequent keywords into top-level
categories. Okay, done. Do a real site gen letting it go out to github. Check
the category grid.

It worked. And the same old crappy topics are back of the sort I'd start
filtering. And that makes it a sort of new starting point. Instead of throwing
things into a filter, I start sorting them into parent categories. That will
start doing filtering again, but it's not really filtering I want at this
point. But things are working at least as good as the old way. So set up some
test data! Do some of the mapping. Then change how you sort posts into
categories using the new data structure.

I eliminated the `all` key under categories and moved everything under
`filter`. They functionally were doing the same thing. Now I just sort things
from filter into their best matching parent category.

I also see that rule-based matching of categories is on the table to alleviate
even this manual grouping. But I do have a good amount of sample data in there
now for better categorization. Find the location in the code where the new data
would be used.

I'm reaching the point of diminishing returns. Cut the entry here and tackle
the last step tomorrow morning. Sleep on it.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/editing-text-as-a-form-of-meditation-or-martial-arts-kata/">Editing Text As a Form of Meditation or Martial Arts Kata</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/category-mapping-go-ascii-alice/">Category Mapping? Go ASCII Alice!</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>