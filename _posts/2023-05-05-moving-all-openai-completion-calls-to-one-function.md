---
date: 2023-05-05
title: Moving All OpenAI Completion Calls to One Function
headline: Committing Changes to Streamline OpenAI Completion Calls in chop.py
description: This post outlines the process of moving OpenAI Completion calls from many functions into to one function. It explains the reasoning behind the decision, the 80/20-rule solution, and the resulting changes. I completed the changes and is now ready to test the results.
keywords: OpenAI, Completion, Function, Jekyll, Rendering, Drafts, Publishing, Journal, Tool-divergence, Dilute, Focus, To-do List, Retooling, AI, Vimmers, ODB, Chunking, Summarizing, Prompts, Character Limit, 80/20-Rule, Compromise, Variations, Implementations, Commit
categories: success, jekyll, draft, 80/20-rule, ai
permalink: /blog/moving-all-openai-completion-calls-to-one-function/
layout: post
group: blog
---


Okay, it's time to clean chop.py even more. The work today to make drafts a
real thing with Jekyll rendering but without publishing was a big step forward.
It's going to make me feel good about writing more and leveraging the most out
of this system without having to publish everything, nor it getting lost in the
trash heap of old drafts. It keeps it in draft but makes it come alive. It's
such a wonderful example of using the journal to improve the journal. Now I can
tackle problems that compels to tool-divergence and dilute focus.

I've never slammed my way so fast through a to-do list. It actually added some
startup cost to other projects I'm working on, but this is often the way with
retooling. If we never had to retool, we would get continually better at the
work we're using the tools for and that's the future I'm planning on. Things
are about to change big-time with AI and everyone's tools are about to change.
We vimmers are in a special place.

Next up on the chop.py todo list is getting rid of all the separate functions
that call `openai.Completion.create()`. In fact, they all go through `odb()`
which takes these functions as parameters and calls a function with the name of
the parameter instead. That was a bit of a hack in the first place because the
functions had to vary in their behavior. If the prompts were too big, I was
chunking them in the past, getting summarizes and using the summarized version
in subsequent prompts, but no more.

The posts are actually all close enough to that 4097 character limit that I can
just chop it down to size and not worry about it. Much better 80/20-rule
solution, and having done that I can get rid of this old compromise. It
actually eliminates a bunch of functions from the code, but at the cost of
adding a prompt dictionary. Or perhaps one prompt function, because there's
still the need to blend the post content with other text to make the different
prompt variations. Make sure you're moving towards a simpler and better
implementation, not just the different prompt variations. Make sure you're
moving towards a simpler and better implementation, not just the different one.

Wow, okay just made all the changes. Did a test run without asking for any
OpenAI completions and it worked. I'm going to commit this and then do a test
run with OpenAI completions.

Okay, I had a few tweaks to make to strip out the exec's and eval's that were
necessary for the last approach, but here's a post with OpenAI completions for
headline, meta description and keywords. And the code that made it is cleaner
and shorter. And that concludes the last code cleanup for chop.py. The rest is
stuff like pinning posts, blending in the YouTube videos and discrete
sub-sequences with their own prev/next arrows.

Having made the separate set of pages for drafts just recently, that perhaps
opens the door for a separate pass that makes the sequences with different
actual sets of pages so that they don't have 2 sets of arrows on them. I can
also canonicalize the URLs to one version or the other. I hate to plan any
features that would call for duplicate content, but the user experience of
discrete sequences with very logical and flowing prev/next order is too
compelling to pass up. 

In a way, it's the culmination of the system in as how it allows that
"trickling up" of good content effect. Giving things a logical home in a
sequence of pages besides the order I just happened to write them is... well,
it's greatly the point. Vision and revision. Brainstorming to order. Non-linear
thinking to linear thinking. Making it accessible to others.

And for posterity, here's the new centralized function that calls
`openai.Completion.create()`:

```python
def odb(DBNAME, slug, name, data):
    #   ___                      _    ___   _   _ _ _
    #  / _ \ _ __   ___ _ __    / \  |_ _| | | | (_) |_
    # | | | | '_ \ / _ \ '_ \  / _ \  | |  | |_| | | __|
    # | |_| | |_) |  __/ | | |/ ___ \ | |  |  _  | | |_
    #  \___/| .__/ \___|_| |_/_/   \_\___| |_| |_|_|\__|
    #       |_|
    """Retrieves and saves OpenAI request not already done.
    It checks if the data is there first, so safe to re-run."""
    api_hit = False
    with sqldict(DBNAME) as db:
        if slug in db:
            result = db[slug]
        else:
            fig(f"OpenAI", DBNAME)
            chop_at = 3500
            # Chop the article down to a summarize able length
            required_tokens = num_tokens_from_string(data, "cl100k_base")
            if required_tokens > chop_at:
                while required_tokens > chop_at:
                    data = data.rsplit(" ", 1)[0]
                    required_tokens = num_tokens_from_string(data, "cl100k_base")

            # Build a prompt and get a result from OpenAI.
            aprompt = make_prompt(name, data)
            result = openai.Completion.create(
                engine=ENGINE,
                prompt=aprompt,
                temperature=TEMPERATURE,
                max_tokens=MAX_TOKENS,
                n=1,
                stop=None,
            )
            result = result.choices[0].text.strip()
            db[slug] = result
            db.commit()
            api_hit = True
    return result, api_hit
```

And the code that calls it:

```python
def sync_check():
    #  ______   ___   _  ____    ____ _               _
    # / ___\ \ / / \ | |/ ___|  / ___| |__   ___  ___| | __
    # \___ \\ V /|  \| | |     | |   | '_ \ / _ \/ __| |/ /
    #  ___) || | | |\  | |___  | |___| | | |  __/ (__|   <
    # |____/ |_| |_| \_|\____|  \____|_| |_|\___|\___|_|\_\
    """Check for new posts needing AI-writing or YAMLESQUE source-file updating."""
    fig("SYNC Check", "Checking for new posts needing AI-writing")
    for i, (fm, apost, combined) in enumerate(yaml_generator(YAMLESQUE, clone=True)):
        if fm and len(fm) == 2 and "title" in fm and "date" in fm:
            # Only 2 fields of YAML front matter asks for release.
            title = fm["title"]
            slug = slugify(title)
            ydict[slug]["title"] = title
            # Setting these values ALSO commits it to the databases
            hits = []
            rdict = {}
            for afield in AI_FIELDS:
                dbname = f"{REPO_DATA}{afield}.db"
                result, api_hit = odb(dbname, slug, afield, combined)
                rdict[afield] = result
                if api_hit:
                    hits.append(api_hit)
            print()
            if any(hits):
                for afield in AI_FIELDS:
                    print(f"{afield}: {rdict[afield]}")
                    print()
            build_ydict()  # Rebuilds ydict from database
            update_yaml()  # Updates YAMLESQUE file data from database
            new_source()  # Replaces YAMLESQUE input with synchronized output
            if any(hits):
                raise SystemExit("Review changes in source and re-release.")
```

And the prompt-building function. This code that I modeled after OpenAI's
examples has a particular multi-line appending style that I hadn't seen before
in Python. It's better than the other approaches, which include one long line,
triple-quotes, backslashes, `"".join()`ing a list and various other less pretty
ways this can be done. I didn't know this approach was even possible. I wonder
if an OpenAI person figured that out or they learned it from GPT, haha!

```python
def make_prompt(name, data):
    """Returns an OpenAI prompt for the given name and data."""
    pdict = {
        "headline": (
            f"Write a short headline for the following post:\n{data}\n\n"
            "You are the one who write this. Write from first person perspective. Never say 'The author'. '"
            "Do not reuse the title in the headline. Write something new. Use only one sentence. "
            "\nHeadline:\n\n"
        ),
        "description": (
            f"Write a concise and informative meta description for the following text:\n{data}\n\n"
            "...that will work well as summary-text in website navigation. "
            "You are the author, but never say 'The author'. Write from the first person perspective. "
            "Keep it short."
            "\nSummary:\n\n"
        ),
        "keywords": (
            f"Create a line of comma separated list of keywords to categorize the following text:\n\n{data}\n\n"
            "Do not use extremely broad words like Data, Technology, Blog, Post or Author. "
            "Use words that will be good for site categories, tags and search. "
            "Do not use quotes around keywords. "
            "\nKeywords:\n\n"
        )
    }
    return pdict[name]
```












<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/rendering-un-styled-jekyll-markdown-drafts-for-pasting-into-google-docs/">Rendering Un-Styled Jekyll Markdown Drafts for Pasting Into Google Docs</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-time-i-learned-i-was-a-yankee-doodle-dandy/">The Time I Learned I Was a Yankee Doodle Dandy</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/success/'>Success</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/draft/'>Drafts</a></h4></li>
<li><h4><a href='/80-20-rule/'>80/20-rule</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>