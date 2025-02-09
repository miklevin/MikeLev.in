---
title: Becomes Title tag & H1
permalink: /futureproof/slug/
description: 
layout: post
sort_order: 1
---

I have some idea of what today's tech journal entry is going to be about, but I
want to plunge into the commitment and consistency aspect of having the properly
named file existing so that the Jekyll static site generator system detects it
and generates it locally, before I have the proper file-name for it.

And so the morning ritual after I've done a bit of thinking and writing already
to set the directional tone is:

    cp template.md 2025-01-24-change.md

This is something of a double entente, as the topic itself might actually be
"change", however that is always the case and it is even more so a reminder for
me to change the filename. Now the filenames are always overwritten by the YAML
top-matter, by the permalink field:

    title: Becomes Title tag & H1
    permalink: /futureproof/slug/
    description: 
    layout: post
    sort_order: 1

...and so I typically coordinate whatever I put in the permalink with however I
name the file. This is mostly as a matter of convenience for when looking at the
files in `ls` directory listings because the actual URL of the published entry
becomes dissociated from the filename. And so I lean into this strength to move
from complete free association writing to a more directed daily technical
journal version of it.

I'll still call it my daily technical journal as a further consistency and
commitment hack, even though I missed my first run of days in awhile. It's not
like I'm really maintaining a 1-to-1 ratio between days and articles, because it
has been 138 days since September 8, 2024 since I wrote my first fateful article
named `2024-09-08-Future-proofing.md`, and I'm only up to 122 articles. So I'm a
bit behind, but it's possible that I catch up as I sometimes do multiple in one
day. That's unusual and goes against the general theme of each article capturing
the flavor and thoughts of the day, but sometimes the topics are just so
different and incompatible that I break them out.

So, I'm trying to get much more hard-nosed about my work and less pontificating
about the overall direction of technology and the world &#151; particularly
challenging considering the rate of change and progress. But it's the perfect
time to double-down on future-proofing concepts and expert use of Botify's
industrial-strength enterprise crawler product. What's going to survive and cut
through it all? Why do I have the exact right day-job. And how do I make the
directional adjustments so that I won't need a day-job in the future, and that
practicing my Ikigai is enough?

A lot is about the alignment of what I'm good at, what I love to do, what I can
get paid for and what the world needs (the concept of Ikigai). But it's
important to qualify this isn't about living in some state of eternal dopamine
bliss or anything. No, if anything it's about forging an even harder path for
yourself than the automatic click-whirrr path of least resistance dopamine
reward seeking that alignment of these 3 circles of the Ikigai Venn diagram
might imply. That's because you must (I must) try to get forever better at
things &#151; the right things. And so there is a constant quest or journey of
seeking that has its own trials, tribulations and pains. This is the
counterbalance to the implied but non-factual blissful state of Ikigai. It takes
hard work, and that hard work is such a central theme of this tech blog.

Sometimes you have to do things you don't want to. Sometimes you do things that
seem to rub you the wrong way and go against the grain. This is especially true
as tools change and you don't know which ones are going to emerge timeless and
where to invest your practice to get the right muscle memory. It's an
experimental phase, and you have to open your mind and willingness to things for
which every fiber of your being screams no. This was the case with me taking up
Cursor AI. And while the continued use of Cursor AI might not be the endgame for
me, getting experience with such a nuanced code assistant API is absolutely
critical. I find myself on a fork of VSCode, which a year ago I would have
imagined unthinkable, because I can't not be having the Cursor AI experience
right now.

I'm over a year into my current job, having started October of 2023. October of
2024 made one year. And so now I'm already a quarter-year into year 2. There's a
similar biting the bullet and becoming that deeply expert with my employer's own
product that I have, if I am being 100% honest with myself, perhaps been a bit
remiss in achieving because of my own perception of how much value-adding
alternative skills I brought to the value proposition. This however turns out to
be more of a convenient excuse against a full deep-dive than it is a helpful
truth. And so, that sets the tone of today's tech journal. Less pontification.
Less broad brushstrokes. More hard-nosed Botify.

Every site has a core set of pages that are deemed by the Botify product as `Is
Indexable`. In our filters, it shows as:

    Is Indexable = Yes

This is going to produce some subset of pages from your site where the pages,
according to the "Is Indexable" description:

> Whether the page is indexable by search engines (e.g., returns a good HTTP
> code, does not have a noindex meta tag).

E.g. means for example, so the cases that are given are likely not the only
cases. I have to really investigate further to understand the criteria. Other
possibilities include whether it's the canonical version of the page, whether
it's not in a robots.txt exclusion filter, and a number of other things that
really are quite subjective, because they amount to requests to not be indexed
and not some technical thing about the site preventing those pages from being
indexed at all. But fleshing out my understanding of these things is part of the
point right now.

The reason I even bring up `Is Indexable` is because of the notion of going
after some core set of intentionally published pages. Oh, the layers! Whether
there is even a core set of intentionally published pages is a thing. There
certainly should be. It should be part of something akin to a theory of the
site. This is more important than ever to try to express well, because it is a
good idea to express it well to the search engines themselves, and the new breed
of intelligently directed bots that are going to come a-crawlin! There's even
industry initiatives like [llmstxt](https://llmstxt.org/) by Jeremy Howard
inspired by Anthropic prompting principles as a first-pass way of tackling this
challenge.

What's the challenge? 

- Stating what the site's about and what can be found there
- Stating how big the site is and how to navigate it
- Giving pointers on how to find what you need fast

We can see giving bots an ability to easily navigate your site quickly for
real-time interaction is going to yield competitive advantage for your site. As
recently as yesterday, OpenAI announced, demonstrated and released ChatGPT
**Operator**, a way for the bots to interact with:

- Allrecipies
- Stubhub
- OpenTable

Now perhaps it's because these sites all have formal APIs and OpenAI programmed
ahead of time proactively to ensure Operator could operate them. But also
perhaps there are important conclusions to be drawn about the general generic
operability that sites should have so LLMs can interact with them without big
deliberate integration efforts. Perhaps a site should just lean into the types
of requests and inquiries users will increasingly be deferring to their
Web-searching bot assistants.

If the prompt to Operator doesn't align to one of the canned integrations, it
will perform a Bing search and follow one of the search results, read the
article, and correlate a response for you out of a single-source result. It's
kind of like watching what Perplexity.AI does, but with a real-time view of the
browser, a clear bias towards Microsoft Bing for the initial seed search, and
only one subsequent site visited given the real-time background surfing and
amount of resources they're going to allocate and time they're going to make the
user wait. Fascinating!

Such an experience clearly isn't going to use an `/llms.txt` file at all. But it
is the first evidence of small-world-theory in real-time search. The virtual
browser popped from a Bing search to a publisher page, and then scrolled the
article extracting info from the publisher's page before my eyes. 

But this is exactly the forward-looking bigger picture stuff I'm trying to avoid
today! Let's bust a spider trap.

Just go through the moves as fast as possible. Get it into your muscle memory.
The fast first pass to get spider traps under control.

Get the core set of pages by 2 different opinions:

Pages that meet the `Is Indexable` criteria.

Go to SiteCrawler / Url Explorer and set `Is Idexable` = Yes filter.

Pages that actually are generating Google Search Console impressions (having
Google search activity of any kind).

Go to RealKeywords / Keyword Explorer



