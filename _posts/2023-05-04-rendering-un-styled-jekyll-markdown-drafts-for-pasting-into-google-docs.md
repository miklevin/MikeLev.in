---
date: 2023-05-04
title: Rendering Un-Styled Jekyll Markdown Drafts for Pasting Into Google Docs
headline: I Upgraded My Game by Rendering Un-Styled Jekyll Markdown Drafts for Pasting Into Google Docs
description: "Render un-styled Jekyll Markdown drafts for pasting into Google Docs with this easy-to-implement technique. Learn how to use the `published: false` directive, the `yaml_generator` function, and a stripped-down template named `plain.html` to generate drafts that can be pasted into Google Docs."
keywords: rendering, un-styled, Jekyll, Markdown, drafts, pasting, Google Docs, up game, AI-assistance, first-hand advice, life, learnings, theories, pan out, deep breath, marshalling resources, starting, new life, predictive, GPT, think, 2, 3, step-1, now moment, data, SQlite, textfile-first, support, yaml, front matter, core code, generic,
categories: google, yaml, database, draft, theory, jekyll
permalink: /blog/rendering-un-styled-jekyll-markdown-drafts-for-pasting-into-google-docs/
layout: post
---


Okay, by how many notches can you up your game, and by what rate and cadence?
Let this be like starting a new life, but now with the AI-assistance you've
always needed. Sources of first-hand advice in my life have not been the
greatest. My parents didn't know shit and died early. I've scraped together
what learnings I could here and there, and have been blessed enough to try out
a few theories and have a few pan out. I'm the better for it, but it now feels
just like the deep breath of marshalling resources just at the beginning of
getting started.

And getting started always looks like 1, 2, 3... 1? It's always step 1 because
you can never live in anything but the now moment. And now that I understand
the predictive quality of GPT, it dawns on me that to think about 2 and 3 while
you're always doing step-1 is spot-on point. I've been living my life like the
way GPT seems to work, but without having trained on enough data. And GPT
appears to run in "batch" mode, which breaks the metaphor, because in real life
we apply what we learn right as we go.

Okay, so in adding support for the `published: false` directive in the yaml
front matter of my individual journal posts, I also cleaned up a piece of core
code and also added generic support for any arbitrary (top-hierarchy) fields I
want to use. This opens the door to other things like category, or those other
fields I was looking at like `advice` and `question` which I have since torn
out. But I may want to layer in structure data for FAQs and such, and if I do
these fields I can use on-the-fly could be useful. It's a solid alternative to
new data in SQlite every time. This is always a textfile-first approach.

Just a few points of cleaning up after that last round of work. I have to make
sure that items with the `published: false` directive are not included in the
list of posts that I create in the `_includes` folder. Hmmm. I have to filter
out the unpublished posts in a few places. It may be more efficient if I do
that in the yaml_generator. Not immediately obvious how and whether to, so take
note and revisit some other time.

The new technique of verbatim transposing YAML front-matter from source seems
to have the effect of upper-casing the first letter of bit fields like
`published: False` to Python-style instead of Ruby, which may be a no-no. Ugh,
I'd hate to have to handle that. Do a test render... 

A few things to check:

- The long-list embed on the blog page
- The short-list embed on the homepage
- The arrows on post pages

The 2 lists are fine, but I just realized the arrows are still being generated
by Jekyll, which while it has the advantage of having filtered out the
non-published post, it doesn't have the order right and should really be
handled by Python. Do it now while the iron is hot. This is not a rabbit hole.
You have nearly identical code implemented in the category pages.

Do it now while the iron is hot. This is not a rabbit hole. You have nearly
identical code implemented in the category pages.

Ugh! Too much record keeping if the yaml_generator function doesn't do the
filtering based on the published field! Move it there. Okay, done. Still not a
rabbit hole.

Okay, just deleted all the checks for the yaml published field being false from
about the code to one instance centralized in the yaml generator. This puts
even generating a draft version at risk, but that's the least bad of the evils.
I'll have to look at how to generate the draft version somewhere else for
preview. Specifically putting a fully rendered HTML version in Google Docs,
which is were we as a company do this sort of article collaboration.

After this test-render, the arrows on the posts page, and after that an HTML
version (or equivalent) to put in Google Docs. And that will be a good round of
upping your game. As realities change on you, tap your strength and lean into
the change. Muster your strength. Marshal your resources. 

Okay, the code's in place for Python-controlled prev/next arrows on the Jekyll
post pages. Render out the site with both types of arrows on each page, haha!
Take a look to see if the new arrows render correctly, and compare them to the
old especially in terms of order. The old ones couldn't tell the right order
for multiple posts on the same day (I don't put timestamps in the filename).

Pshwew! Okay, some little rabbit hole. But it's still just 3:00 PM. Not too
much time lost on Jekyll arrows. The issue is that there's one count of all the
posts that are ready to be published, and there's another count when you parse
the yaml, I had to finesse the index used in the list of tuples generated for
the arrows to not be an i of enumerate, but rather a conditional counter. This
is often the case. Stay more alert for this particular pattern. Often, you
can't trust your own i's.

Minimize tech liability. Minimize tech overhead. Minimize tech complexity.
Reduce surface area that you have to deal with. The complexity is always of
course still there, but the trick to making it well hidden is to tweak up and
surface only those bits that are the musical notes you wish to be
orchestrating. If you look at it and it looks like a mess, the process of
wrapping things in the correct interfaces has gone wrong. The wrong assumptions
were made, and a rethink is in order.

Mistakes along these lines will bog you down. Stuff getting into a content
management system that actually reduces your publishing flexibility is an
excellent example. Or a CMS that isn't search optimized. A series of little
transformations, sometimes lovingly hand-crafted and interceded with when run,
are in order... in order to get order, haha!

Okay, most little touches are done. Keeping the `published: false` directive in
the yaml front matter of a post will now prevent it from being included in the
list of posts that are generated. And the arrows on the post pages are now
Python-controlled and looking real good.

But I effectively have 3 articles now that I'd like to offer up on the MOZ
blog, and I should "package" them in a way so compelling that it'd be
ridiculous to not use, but either way be cool with it. Just eliminate reasons
not to. 

Think it through. What's the light-touch solution to go from Markdown in your
journal to rendered HTML that can be pasted into Google Docs while preserving
formatting, embedding the images, etc?

I think the answer is to just use the Jekyll-generated HTML.

Okay, the 80/20 rule is to have a security-though-obscurity version that's
rendered by Github Pages just like everything else, but there's a separate step
in site generation that handles the inverse of current: those posts that have a
published field of false. It would use different CSS by virtue of everything in
that sequence being built differently. It would not use the
`_layouts/default.html` at all, but instead a stripped down version that links
to a different CSS which is "against white" instead of "against black". It
would have no navigation at all and just be the article, graphics, etc. You
would have to know the URL (which the system will tell me), and you can then
just visit the URL and copy/paste it into Google Docs using all the effort
everyone has gone through to make sure formatting stays consistent.

My CSS would be as vanilla and unopinionated as possible so that the Google
Docs defaults are applied. The paste will be a normal `Ctrl+C` type that pastes
with formatting, and not the `Ctrl+Shift+C` that pastes plain text without
formatting. This is the right next project because it releases the built-up
potential that won't be realized so long as there are easy reasons to say no,
because I've somehow created greater publishing friction in the system than
there needs to be.

Make it copy/paste ready directly from Google Docs for whatever the current
process is by which it goes from Google Docs to CMS.

1, 2, 3... 1?

Make a super stripped-down template named plain.html:

{% raw %}
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Draft</title>
</head>
<body>
{{ content }}
</body>
</html>
```
{% endraw %}

I don't know if that will even render in a blog post. It will be a good test.
I'm using the raw tag to prevent Jekyll from processing it.

Okay, now turn everything off your process flow control and add one new
stand-alone function in the playground and add that as the only active thing in
the flow control sequence.

Okay, now I have a place to look for the drafts. Find the closest matching
function. It's yaml_chop, but interestingly I just made it filter out
everything where published is false and I need the inverse. So add an optional
parameter to yaml_chop that defaults to false, and if it's true, then it
only returns the draft versions.

Here's the drafts function.

```python
def drafts():
    print("Drafts")
    for i, (fm, body, combined) in enumerate(yaml_generator(YAMLESQUE, drafts=True)):
        print(i)
```

Here's what it invokes:

```python
def yaml_generator(full_path, reverse=False, drafts=False):
    # __   __ _    __  __ _        ____                           _
    # \ \ / // \  |  \/  | |      / ___| ___ _ __   ___ _ __ __ _| |_ ___  _ __
    #  \ V // _ \ | |\/| | |     | |  _ / _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__|
    #   | |/ ___ \| |  | | |___  | |_| |  __/ | | |  __/ | | (_| | || (_) | |
    #   |_/_/   \_\_|  |_|_____|  \____|\___|_| |_|\___|_|  \__,_|\__\___/|_|
    """Yields a stream of 3-tuples (YAML, post, original) from YAMLesque file.
    If there's no YAML, the yielded tuple will be (None, original, original)"""
    with open(full_path, "r") as fh:
        posts = CHOP.split(fh.read())
        if reverse:
            posts.reverse()  # Reverse so article indexes don't change.
        for i, post in enumerate(posts):
            rv = None, post, post  # Always rebuild source at very least.
            py, yaml_str, body = None, "", ""
            if "---" in post:
                yaml_str, body = post.split("---", 1)
                try:
                    py = yaml.load(yaml_str, Loader=yaml.FullLoader)
                    rv = py, body, post
                except yaml.YAMLError:
                    # Deliberately passing silently to prevent attempts
                    # to create pages where there is no page to create.
                    ...
            if py and "published" in py and py["published"] == False and drafts:
                # It's a draft and function invoked with drafts=True
                yield rv
            elif py and "published" in py and py["published"] == False:
                # It's a draft and function invoked with drafts=False (default)
                # so skip it.
                continue
            elif not drafts:
                yield rv
```

And the output is the 1-loop `0` from the enumerate counter as expected. It's
working!

Okay... think! Look what yaml_chop is doing to choose the template. Yup wow,
could it really be this easy:

```python
def drafts():
    print("Drafts")
    for i, (fm, body, combined) in enumerate(yaml_generator(YAMLESQUE, drafts=True)):
        # Format the date:
        adate = fm["date"]
        date_object = datetime.strptime(adate, "%a %b %d, %Y")
        adate = date_object.strftime("%Y-%m-%d")
        fm["date"] = adate

        # Build the permalink:
        stem = slugify(fm["title"])
        fm["permalink"] = f"{BLOG}{stem}/"
        print(stem)

        filename = f"{OUTPUT_PATH}/{adate}-{stem}.md"
        with open(filename, "w", encoding="utf-8") as fh:
            fh.write("---\n")
            for afield in fm:
                if afield != "published":
                    fh.write(f"{afield}: {sq(fm[afield])}\n")
                fh.write(f"{afield}: {sq(fm[afield])}\n")
            fh.write("layout: plain\n")
            fh.write("---\n")
            fh.write(body)
    print("drafts chopped!")
```

Well, it was almost that easy. I have yaml_generator serving quite a few
purposes. I don't want to spread this core code over different locations, so
there's quite a few parameters to control the behavior. The complexity of this
sort of thing has to be held at bay. This is just about the upper limit.

```
def yaml_generator(full_path, reverse=False, drafts=False, clone=False):
    # __   __ _    __  __ _        ____                           _
    # \ \ / // \  |  \/  | |      / ___| ___ _ __   ___ _ __ __ _| |_ ___  _ __
    #  \ V // _ \ | |\/| | |     | |  _ / _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__|
    #   | |/ ___ \| |  | | |___  | |_| |  __/ | | |  __/ | | (_| | || (_) | |
    #   |_/_/   \_\_|  |_|_____|  \____|\___|_| |_|\___|_|  \__,_|\__\___/|_|
    """Yields a stream of 3-tuples (YAML, post, original) from YAMLesque file.
    If there's no YAML, the yielded tuple will be (None, original, original)"""
    with open(full_path, "r") as fh:
        posts = CHOP.split(fh.read())
        if reverse:
            posts.reverse()  # Reverse so article indexes don't change.
        for i, post in enumerate(posts):
            rv = None, post, post  # Always rebuild source at very least.
            py, yaml_str, body = None, "", ""
            if "---" in post:
                yaml_str, body = post.split("---", 1)
                try:
                    py = yaml.load(yaml_str, Loader=yaml.FullLoader)
                    rv = py, body, post
                except yaml.YAMLError:
                    # Deliberately passing silently to prevent attempts
                    # to create pages where there is no page to create.
                    ...
            if clone:
                # If we're cloning, we want to yield everything.
                yield rv
            elif py and "published" in py and py["published"] == False and drafts:
                # It's a draft and we're rendering drafts.
                yield rv
            elif py and "published" in py and py["published"] == False:
                # It's a draft and we're not rendering drafts.
                # so skip it.
                continue
            elif not drafts:
                # The general default.
                yield rv
```

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/added-support-for-arbitrary-jekyll-yaml-fields/">Added Support for Arbitrary Jekyll YAML Fields</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/moving-all-openai-completion-calls-to-one-function/">Moving All OpenAI Completion Calls to One Function</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/draft/'>Drafts</a></h4></li>
<li><h4><a href='/theory/'>Theory</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li></ul>