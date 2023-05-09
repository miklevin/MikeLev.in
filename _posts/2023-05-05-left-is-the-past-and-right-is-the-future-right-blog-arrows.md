---
date: 2023-05-05
title: Left is The Past and Right is The Future, Right? (Blog Arrows)
headline: "Exploring the Nuances of Blog Navigation: Reversing Arrows for a Configurable Past and Future"
description: I'm exploring the beauty and logic of arrow navigation. It can take some finagling to get it right, but it's a great 80/20-rule solution. With a configurable option, I'm able to make it so that the 'past' is left, and the 'future' is right - perfect for website navigation.
keywords: arrows, navigation, web, linear sequences, story-telling, prev/next, SEO, anchor text, long-tail trick, exact-matches, off-popular keywords, related pages, autocompletes, numbers, periods, floats, domain names, Copilot, 80/20-rule, Western culture, reading directions, present, configurable, ALL Blog Posts, light touch, classes, mapping, left-arrow, right-arrow, previous, next, side,
categories: seo, navigation, 80/20-rule, ai
permalink: /blog/left-is-the-past-and-right-is-the-future-right-blog-arrows/
layout: post
---


Hmm, arrows. Previous, next arrows. prev/next... so symmetrical. So logical.
Plug em at the top or bottom of your blog post and you can step through the
sequence of posts. It's perhaps my all-time favorite Web navigational device,
as they make linear sequences and story-telling more possible in the
random-access world of the Web. 

Any set of pages can be a slideshow or pages of a book, and it doesn't have to
scroll vertically for too long. Just chop it up into logically page-sized
chunks. And for SEO? Oh, they used to be great for SEO with a page of any given
topic being surrounded by a *previous* page possessing the perfect anchor text
for the current page, and a *next* page with the perfect anchor text for the
current page. Get it? Buoy, buoy, buoy.

Yes, I like arrow navigation a lot. And even though that old long-tail trick of
technically perfectly well-optimized pages for SEO isn't effective anymore
because exact-matches on off-popular keywords don't work anymore, I still like
the idea of a sequence of pages that are related to each other and the sheer
beauty and logic of well-labeled arrows as a navigational device.

What direction do the prev/next arrows that let you step through the blog? I
currently have you entering into the most recent post in a sequence,
representing ***the present***. But then to go into the past, you have to click
the forward button. Now it's probably a Western culture thing with left being
the past and right being the future, because of reading directions, so I don't
want to hardwire it either way. Go figure out how to make it configurable, then
configure it into the opposite direction as I currently have it on the ***ALL
Blog Posts*** sequence.

The fist time I tried reversing these arrows, I got this:

    Next --> <-- Previous

Haha! That's not what I meant! I meant this:

    <-- Previous Next -->

The lightest touch is way too light. Let's break it down. I have a left-arrow
and a right-arrow, both of which belong to an `arrow` class, but neither of
which explicitly belong to a previous or next arrow. That's good.

```python
larr = '<span class="arrow">&larr;&nbsp;</span>'
rarr = '<span class="arrow">&nbsp;&rarr;</span>'
```

So when these are used in conjunction with the concepts of previous and next,
they need a mapping: which belongs to which, but they also need a side: left or
right. I'm going to use a dictionary to map the previous and next arrows to
left and right arrows, and another dictionary to map which side each belongs.

```python
# Map previous and next arrows to left and right arrows:
arrow_map = {"prev": larr, "next": rarr}
# Map left and right arrows to left and right sides:
side_map = {"left": larr, "right": rarr}
```

Want to know what I'm talking about with that pedantic attention to detail? How
nuance matters? It's this next step. Sometimes the dicts that map things are
the easy part, but gluing it all together is the hard part. I need a way to
configure whether the "past" is to the left or the right. Let's go for the most
explicit language we can think of: `past_is_left`. That's a boolean, so it
should be easy to use in an `if` statement. Let's see...

The enemy here is getting your mind bent. The job of someone like me in this
situation is to deal with the complexity, but then to totally hide it and make
it fade into the background until the next time me or another developer goes
into the code, at which time the hidden complexity is not only revealed, but
immediately obvious and exuding of that beauty we all love in code.

Not to mix too many metaphors in this one post, but I talk about chisel strikes
a lot. This is definitely one of them. The steps leading up to this have been
obvious rock-preparation stuff. Examining the stone, looking for the right
angle, anticipate accidentally chopping off the statue's nose, etc. There's
always a longer pause before the actual `chisel-strike` than other steps.

The best metaphors in life are of course fire-related, wheel-related and
water-related. I should try to get one of each in here as it applies to these
topics, haha!

Okay, deep breath! Think! 1, 2, 3... 1? Don't let the code that's sitting there
already predispose you. That's one of the traps in these situations, your own
past work and a sort of myopia that comes with it. That's another reason for
this journal here in addition to the place the Python code really goes.

And yes, it's an awful lot of writing between small steps. Often the complexity
that's being hidden is exactly because of this thought process. Good labels...
oh right! Literally, ***right***. No matter how you slice it, there's going to
be a left side and a right side, so:

```python
if PAST_IS_LEFT:
    left_side = side_map["left"]
    right_side = side_map["right"]
else:
    left_side = side_map["right"]
    right_side = side_map["left"]
```

People don't use CONSTANTS enough (me included / classic projection). When
you've got what's clearly a configuration value in Python, make it
all-uppercase. It's a small point, but broad sweeping themes of your code
become recognizable. As a matter of style, you don't need to keep adding them
as globals in your functions. Just use them as needed. Their values don't
change, so the reasons for the `global` keyword don't apply. Now if it were a
mutable list or dict (that you plan to change), that's a different story. Use
the `global` keyword in every function for them, if for no other reason than to
remove ambiguity. That's the purpose of the all-upper-casing of constants, to
remove ambiguity. The `global` keyword is used on global mutable objects for
technical reasons and not of just convention.

Okay, that was the first step. Now we need to map the previous and next arrows
to the left and right sides. That's the second step, which in-turn gets bumped
to step 1 again. We're always on step 1. Read Einstein's 1st theory of
relativity, the special one. The now moment extends just a tiny bit into the
future or the past, or else the now couldn't exist. Mind-blowing, but really
helps frame step-by-step progress through the unknown.

Unknown... unknown... unknown... 1, 2, 3... 1? 

> OpenAI, of all that you see  
> How would you rate all the code made by me?  
> Am I astute? How would you grade  
> The stuff that I boot with the code that I made?  

Glitch, glitch, back from fugue state.

If you're looking for glitches in the matrix, look into the depths of your
mind, and not into the world around you. Your senses lie. Be tuned into what is
either your subconscious or channeling from another place, maybe your higher
self or maybe the cosmic whole yadda yadda don't waste too much time pondering.
Shut up and calculate.

Okay, so we've got the left and right sides. They always appear on the left and
right in their variable-name forms. Notice the quoted strings that say left and
right can appear on either side. That's the point.

This is where you often sleep on it. Righteous solutions elude. Your
subconscious knows and kicks in with aversion, anxiety, and other forms of
resistance. Procrastination is sometimes an optimization strategy. It's not
always bad, but when you find yourself in a situation like this where the
implication is that your conscious mind is not up to the task, it's a bit
insulting. Matter matter matter matter matter.

Struggle, struggle, struggle... momentary fugue state... BAM! Call this one 70%
me and 30% Copilot. I'm not gonna lie. Copilot helped. But it took a bit of
tickling and coercing to get the parts of this that I could not provide out of
my own brain:

```python
def arrow_maker(i, length, href_title_list):
    """Returns the prev/next arrows for a page. It must be given a list of
    tuples containing the hrefs and titles of the pages in the sequence. It
    must also be given the index of the current page in the sequence. It will
    return the HTML for the prev/next arrows. Path issues must be dealt with
    beforehand in the tuple sequence."""

    # Arrows always appear on their implied sides: left on left and right on right.
    larr = '<span class="arrow">&larr;&nbsp;</span>'
    rarr = '<span class="arrow">&nbsp;&rarr;</span>'
  
    # Handle arrows at beginning and end of sequence
    if not i:
        older_slug, older_title = href_title_list[i + 1]
        newer_slug, newer_title = "", ""
    elif i < length - 1:
        older_slug, older_title = href_title_list[i + 1]
        newer_slug, newer_title = href_title_list[i - 1]
    else:
        older_slug, older_title = "", ""
        newer_slug, newer_title = href_title_list[i - 1]

    if PAST_IS_LEFT:
        if not i:
            rarr = ""
        elif i == length - 1:
            larr = ""
        left_link = f'<a href="{older_slug}">{older_title}</a>'
        right_link = f'<a href="{newer_slug}">{newer_title}</a>'
    else:
        if not i:
            larr = ""
        elif i == length - 1:
            rarr = ""
        left_link = f'<a href="{newer_slug}">{newer_title}</a>'
        right_link = f'<a href="{older_slug}">{older_title}</a>'

    outer_div = '<div class="arrow-links">'
    left_div = '<div class="post-nav-prev">'
    right_div = '<div class="post-nav-next">'
    end_div = '</div>'
    
    arrow_link = f"{outer_div}{left_div}{larr}{left_link}{end_div} &nbsp; {right_div}{right_link}{rarr}{end_div}{end_div}"
    return arrow_link
```

Hmmm. There are parts of this that are tough to understand, not the least of
which is what those parameters are. I tried to make them self-explanatory, but
seeing how it's called may make it clearer. And I can hardly show it out of
context of the function it resides in, so here's the whole `yaml_chop()`
function. Look for where `arrow_maker()` is called, and look near the top of
the function for where `href_title_list` is populated:

```python
def yaml_chop():
    # __   __ _    __  __ _     |  ____ _                  _  _  _
    # \ \ / // \  |  \/  | |    | / ___| |__   ___  _ __  | || || |
    #  \ V // _ \ | |\/| | |    || |   | '_ \ / _ \| '_ \ | || || |
    #   | |/ ___ \| |  | | |___ || |___| | | | (_) | |_) ||_||_||_|
    #   |_/_/   \_\_|  |_|_____|| \____|_| |_|\___/| .__/ (_)(_)(_)
    fig("Chop the YAML!")  #    |                  |_|
    """Chop a YAMLesque text-file into the individual text-files (posts) it implies."""
    global ydict
    num_pages = len(ydict)
    href_title_list = [(f'{BLOG}{ydict[x]["slug"]}/', ydict[x]["title"]) for x in ydict]
    counter = 0
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
                for asubcat in categories.split(", "):
                    asubcat = asubcat.strip().lower()
                    if asubcat in top_cats:
                        fh.write(f"\n<li><h4><a href='/{slugify(asubcat)}/'>{cdict[asubcat]['title']}</a></h4></li>")
                fh.write("</ul>")
                counter += 1
    print("chopped!")
```

Wanna see the output? Look around.

















<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/the-time-i-learned-i-was-a-yankee-doodle-dandy/">The Time I Learned I Was a Yankee Doodle Dandy</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/reverse-chronological-writing-is-the-natural-order/">Reverse Chronological Writing is the Natural Order</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/navigation/'>Navigation</a></h4></li>
<li><h4><a href='/80-20-rule/'>80/20-rule</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>