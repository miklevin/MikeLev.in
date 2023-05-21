---
date: 2023-04-01
title: Powering My Way Through MOZ Links API Documentation
headline: Exploring the Power of Persuasion with MOZ Links API Documentation
description: I'm exploring the MOZ Links API with Mechvibes software, learning about the power of persuasion with Robert Cialdini's six principles, and using journaling and Python's dict native datatype to create a database to store the data and make it persistent. I'm also cleaning up a MOZ Links API Exploration Repo with NeoVim for OpenAI Github Copilot integration, making clicky sounds as I type. Join me on my journey.
keywords: MOZ Links API, Mechvibes, Robert Cialdini, Six Principles, Journaling, Python, Dict Datatype, Database, Persistent, NeoVim, OpenAI, Github Copilot, SourceForge, Clicky Sounds, Microsoft Video, CopilotX, Autocompletion, Headline/Subhead, Notebook, Persuasion, Marketing, Salespeople, Influence, Psychology, Regents' Professor, Arizona State University, Microsoft, Jupy
categories: vim, jupyter, github copilot, ai, python, database, microsoft, journaling, marketing
permalink: /blog/powering-my-way-through-moz-links-api-documentation/
layout: post
---


Hello World! This is similar to my last couple of videos, but now I'm running
Mechvibes software from SourceForge to make some clicky sounds as I type. Not
so silent. It's still AI-assisted journaling in NeoVim with Copilot. I watched
the Microsoft video on CopilotX about how it's now so much more than just
autocompletion, but I'm staying away from that for now. It's all VSCode based
and very much dependency-inducing. Think for yourself!

{% include youtubePlayer.html id="5XheKKZoGnE" %}

Gotta refine my YouTube embedding macro.

I'll pick up right where I left off with the MOZ Links API. I'll clean up and
document the code so far, and maybe hit the older V1 API. Eventually I want to
compare the 2, but for now I just want to get experienced with V2.

Thinking through Headline/Subhead issues in a Notebook is always interesting.
One H1 for the entire Notebook? Or H1s over and over above every section?
Sounds like SEO questions, and that has some validity because I'll be using
nbdev later on to convert all this to published HTML.

Hello again! Now let's clean up that MOZ Links API example...

15 sub-endpoints. Confirm...

12 standard "cost" endpoints and 3 special ones. Here's the standard one's
natural names:

1. Anchor Text
1. Final Redirect
1. Global Top Pages
1. Global Top Root Domains
1. Index Metadata
1. Link Intersect
1. Link Status
1. Linking Root Domains
1. Links
1. Top Pages
1. URL Metrics
1. Usage Data

Those 1's will render as sequential numbers when rendered on the web as HTML.

These are the 3 "weighted" endpoints:

1. Link Intersect
1. Link Status
1. URL Metrics

That block setting all the special ed values is a bit uglier than it should be.
Let's make it perhaps more beautiful but less explicit.

I know I stream at the strangest times. You use motivation when you have it.

    Anchor Text
    Final Redirect
    Global Top Pages
    Global Top Root Domains
    Index Metadata
    Link Intersect
    Link Status
    Linking Root Domains
    Links
    Top Pages
    URL Metrics
    Usage Data
    Link Intersect
    Link Status
    URL Metrics

Well, this goes a long way:

```python
for i, point in enumerate(points):
    print(f"{i + 1}. {names[i]} ({point})")
    print("Example request:")
    pprint(ed[point])
    print()
```

It outputs this:

    1. Anchor Text (anchor_text)
    Example request:
    {'limit': 5, 'scope': 'page', 'target': 'moz.com/blog'}

    2. Final Redirect (final_redirect)
    Example request:
    {'page': 'seomoz.org/blog'}

    3. Global Top Pages (global_top_pages)
    Example request:
    {'limit': 5}

    4. Global Top Root Domains (global_top_root_domains)
    Example request:
    {'limit': 5}

    5. Index Metadata (index_metadata)
    Example request:
    {}

    6. Link Intersect (link_intersect)
    Example request:
    {'limit': 1,
     'negative_targets': [{'scope': 'root_domain', 'target': 'moz.com'}],
     'positive_targets': [{'scope': 'root_domain', 'target': 'latimes.com'},
                          {'scope': 'subdomain', 'target': 'blog.nytimes.com'}],
     'sort': 'source_domain_authority',
     'source_scope': 'page'}

    7. Link Status (link_status)
    Example request:
    {'source_scope': 'root_domain',
     'sources': ['twitter.com', 'linkedin.com'],
     'target': 'moz.com/blog',
     'target_scope': 'page'}

    8. Linking Root Domains (linking_root_domains)
    Example request:
    {'filter': 'external',
     'limit': 5,
     'sort': 'source_domain_authority',
     'target': 'moz.com/blog',
     'target_scope': 'page'}

    9. Links (links)
    Example request:
    {'filter': 'external+nofollow',
     'limit': 1,
     'target': 'moz.com/blog',
     'target_scope': 'page'}

    10. Top Pages (top_pages)
    Example request:
    {'limit': 5, 'scope': 'root_domain', 'target': 'moz.com'}

    11. URL Metrics (url_metrics)
    Example request:
    {'targets': ['moz.com', 'nytimes.com']}

    12. Usage Data (usage_data)
    Example request:
    {}

    13. Link Intersect (link_intersect)
    Example request:
    {'limit': 1,
     'negative_targets': [{'scope': 'root_domain', 'target': 'moz.com'}],
     'positive_targets': [{'scope': 'root_domain', 'target': 'latimes.com'},
                          {'scope': 'subdomain', 'target': 'blog.nytimes.com'}],
     'sort': 'source_domain_authority',
     'source_scope': 'page'}

    14. Link Status (link_status)
    Example request:
    {'source_scope': 'root_domain',
     'sources': ['twitter.com', 'linkedin.com'],
     'target': 'moz.com/blog',
     'target_scope': 'page'}

    15. URL Metrics (url_metrics)
    Example request:
    {'targets': ['moz.com', 'nytimes.com']}

My next step while not great for 24x7 server compatibility really makes it look
nice in Notebooks... a trick I always lift from prior projects. There's a lot
of ways to do this. This is the one I generally settle on... Notebook
headlines...

Yep, that's very nice. Definitions next. But first, distribute!

I'm stepping through each endpoint. There are 15 of them. 12 standard-cost and
3 weighted-cost. The more expensive ones are at the end of the list. Let's add
endpoint descriptions! Same list trick. If you keep things in the same order,
they can join naturally with either the zip command or just by using the
numeric indexes of a list as keys.

This looks like a good time for a commit and push!

What a wonderful journaling session for work. I should be as productive as I am
on a Saturday morning every workday, haha!

Nobody needs to be here on the live-stream for it to have value to me. It's the
change in myself that I'm going for as the effect. Dare I discuss commitment
and consistency again? It's the one topic for which Bard reliably gives
sources. Watch: Ugh! Citations gone. Guess Bard no longer thinks they're
needed. It learned. Citations still on option #2!

**Mike Levin:** Who is Robert Cialdini?

**Bard 1:** Robert Cialdini is an American social psychologist and the Regents' Professor Emeritus of Psychology and Marketing at Arizona State University. He is best known for his work on persuasion, and his book Influence: The Psychology of Persuasion is considered a classic in the field.

Cialdini's research has shown that there are six principles of persuasion: reciprocity, scarcity, consistency, authority, liking, and consensus. These principles can be used to influence people to behave in certain ways, and they are often used by marketers and salespeople.

Cialdini is a popular speaker and consultant, and he has appeared on numerous television and radio shows. He is also the author of several other books, including Pre-Suasion: A Revolutionary Way to Influence and Persuade and Influence: Science and Practice.

Here are some of the key principles of persuasion that Cialdini has identified:

* **Reciprocity:** People are more likely to do something for you if you have done something for them first. This is known as the "rule of reciprocity."
* **Scarcity:** People are more likely to want something if they believe it is scarce or limited. This is known as the "scarcity principle."
* **Consistency:** People are more likely to do something if it is consistent with their past behavior or beliefs. This is known as the "consistency principle."
* **Authority:** People are more likely to be persuaded by someone they perceive to be an authority figure. This is known as the "authority principle."
* **Liking:** People are more likely to be persuaded by someone they like. This is known as the "liking principle."
* **Consensus:** People are more likely to do something if they believe that other people are doing it. This is known as the "consensus principle."

Cialdini's work on persuasion has been influential in a variety of fields, including marketing, sales, and politics. His research has helped us to understand how people are influenced, and it has provided us with tools that we can use to persuade others.

Bard 2:

Robert Cialdini is an American psychologist and academic. He is the Regents' Professor Emeritus of Psychology and Marketing at Arizona State University and was a visiting professor of marketing, business and psychology at Stanford University.

He is best known for his 1984 book on persuasion and marketing, Influence: The Psychology of Persuasion. It was based on three "undercover" years applying for and training at used car dealerships, fund-raising organizations, and telemarketing firms to observe real-life situations of persuasion.

Cialdini's work has been influential in a variety of fields, including marketing, business, law, and education. His six principles of persuasion are:

* Reciprocity: We are more likely to comply with a request if we have received a favor in the past.
* Commitment and consistency: We are more likely to follow through on a commitment we have made, or on a behavior that is consistent with our past actions.
* Social proof: We are more likely to do something if we see that others are doing it.
* Liking: We are more likely to be persuaded by people we like.
* Authority: We are more likely to be persuaded by people we perceive to be in authority.
* Scarcity: We are more likely to want something if we believe it is scarce.

Cialdini's work has been criticized by some for being too simplistic and for not taking into account the complexities of human behavior. However, his work remains influential and is widely used by businesses and organizations to persuade people to buy their products, donate to their causes, or comply with their requests.

---

Shift+A doesn't work in NeoVim as expected. On option #2 the citations were not
included in the copied text by Bard. This is a big deal. Bing includes the
citations in the copy-text and is a very good example of how "Bing gets it" and
Google ***still*** doesn't. How about this one little gesture of good will by
Google to the content sources?

---

**Bard 3:** Robert Cialdini is an American psychologist and academic. He is the Regents' Professor Emeritus of Psychology and Marketing at Arizona State University and was a visiting professor of marketing, business and psychology at Stanford University.

He is best known for his 1984 book on persuasion and marketing, Influence: The Psychology of Persuasion. It was based on three "undercover" years applying for and training at used car dealerships, fund-raising organizations, and telemarketing firms to observe real-life situations of persuasion.

Cialdini's work has been influential in a variety of fields, including marketing, sales, management, and education. He has been called "the world's foremost expert on the science of persuasion" and "the Godfather of influence."

Cialdini's six principles of persuasion are:

* Reciprocity: People are more likely to do something for you if you have done something for them first.
* Commitment and consistency: People are more likely to follow through on a commitment they have made, or on a behavior that is consistent with their past behavior.
* Social proof: People are more likely to do something if they see others doing it.
* Liking: People are more likely to be persuaded by someone they like.
* Authority: People are more likely to be persuaded by someone they perceive as an authority figure.
* Scarcity: People are more likely to want something if they believe it is scarce.

Cialdini's work has been criticized by some for being too simplistic and for ignoring the role of free will in decision-making. However, his work remains influential and has been used to explain a wide range of persuasive phenomena.

---

**Mike Levin:** Is Cialdini's work too simplistic? Explain. Write an argument for and against.

**Bard 1:** Whether or not Cialdini's work is too simplistic is a matter of debate.
Some people argue that his six principles of persuasion are too general and do
not take into account the complexities of human behavior. Others argue that his
work is valuable because it provides a framework for understanding how people
are persuaded.

Here is an argument in favor of Cialdini's work:

Cialdini's work is based on extensive research, and his six principles of
persuasion are based on real-world observations. His work has been influential
in a variety of fields, including marketing, business, law, and education. His
work can be used to help people understand how they are being persuaded, and to
develop strategies for resisting persuasion.

Here is an argument against Cialdini's work:

Cialdini's work is too simplistic and does not take into account the
complexities of human behavior. His six principles of persuasion are not always
effective, and they can be used to manipulate people. His work can be used to
help people understand how they are being persuaded, but it can also be used to
help people persuade others.

Ultimately, whether or not Cialdini's work is too simplistic is a matter of
opinion. There is no doubt that his work is based on extensive research and
that it has been influential in a variety of fields. However, his work is not
without its critics, who argue that it is too simplistic and does not take into
account the complexities of human behavior.

---

**Mike Levin:** Explain the principle of commitment and consistency.

Bing 1: The principle of commitment and consistency is one of the six
principles of persuasion identified by Robert Cialdini in his book Influence:
The Psychology of Persuasion.

The principle states that people are more likely to follow through on a
commitment they have made, or on a behavior that is consistent with their past
actions. This is because people want to be seen as consistent and reliable, and
they are motivated to avoid cognitive dissonance, which is the discomfort that
comes from holding two contradictory beliefs or attitudes.

There are a number of ways to use the principle of commitment and consistency
to persuade others. One way is to get people to make a small commitment early
on. This can be done by asking them to sign a petition, donate a small amount
of money, or even just agree to listen to a sales pitch. Once people have made
a small commitment, they are more likely to follow through on a larger
commitment later on.

Another way to use the principle of commitment and consistency is to remind
people of their past actions. This can be done by showing them a letter they
signed, a donation they made, or even just a photo of them doing something that
is consistent with the desired behavior. When people are reminded of their past
actions, they are more likely to follow through on their commitments.

The principle of commitment and consistency can be a powerful tool for
persuasion. However, it is important to use it ethically and responsibly.
People should not be manipulated into making commitments that they do not want
to make.

---

That's why I journal in public. It's a life hack to compel me forward, even on
a Saturday morning at 10:00 AM, LOL! And it worked well. Just look at this
process of MOZ Links API discovery. I can still do a few things to clean up and
clarify this example. Make this Notebook really useful to people. And turn it
into a viable alternative to the existing documentation, particularly for
Jupyter Notebook users.

To that end, I should put the whole process of executing the queries under the
spotlight. It's a bit lumped together and mysterious with how I'm handling the
caching and stuff. I could layer in some really cool timeless stuff here. How
much function do I really want it to serve?

Start folks out with excellent habits. Do it right. Raw data to drive capture.

Okay, philosophy time. If you're hitting an API of almost any sort, there will
be:

- A request that you issue
- A response that is received

This sets the stage for leveraging any number of a sort of key/value,
name/value, label/data or what have you. This is a concept that runs back in
tech to the dawn of time. There's something too big to refer to it by its
actual nature, so we choose a name or a label or a key, what have you. They're
all very much the same thing. The use of the label, name or key retrieves the
more complex and messy stuff. So much in tech works this way, it's ridiculous.
Python has some very good implementations, such as its dict native datatype.

Python dicts have one essential problem. They're not persistent. We fix that.

This is the biggest "outside the standard library" trick that I use asides
maybe from requests and pandas...

Hi Jens-Ole! Yeah, you're right. I know they're boring. But I need to work this
way sometimes to force myself through some of the work.

Yep, folks will tune in and out of this, but not talking is the way to go for
now. I'm comfortable talking, but the mental state is definitely different.

I as doing the trick of checking whether I already retrieved the API data, but
I'm doing it in a very Jupyter Notebook specific way, because it's a REPL
environment that keeps so much in memory without ever really exiting the
executing program until you restart the kernel.

I'll start this database project out without organizing the data files into
subfolders. When I do this later or clean it up, files like the one I'm about
to produce always go into subfolders, but I want you to see it appear when I
run it for the first time...

I'll leave yesterday's implementation showing so you can see the difference.
Setting results = {} in a separate code box is so that I don't re-run it by
accident in the Notebook session, thus wiping out the API responses I already
received. That changes because persistent database.

That created the database, merely by referencing it. It didn't write anything
into the database. I can show you that by reversing the process: see? Nothing.
No keys in the database.

Now we print the keys (endpoints in this case) that are not yet in the
database, which is all of them. And if a key is not in the database, it should
hit the API with the example request, put it in the database, commit and move
on. Watch... I'm making the clearest example I can. No obfuscation with fancy
print function features and fstrings.

Notice the 12KB filesize on the mozlinksapi.db file. Now let's run the calls...

```python
with sqldict("mozlinksapi.db") as db:
    for endpoint in points:
        if endpoint not in db:
            print(endpoint)
            result = moz(point, ed[point])
            db[endpoint] = result
            db.commit()
            print("API hit and response saved!")
            print()
````

Outputs:

    anchor_text
    API hit and response saved!

    final_redirect
    API hit and response saved!

    global_top_pages
    API hit and response saved!

    global_top_root_domains
    API hit and response saved!

    index_metadata
    API hit and response saved!

    link_intersect
    API hit and response saved!

    link_status
    API hit and response saved!

    linking_root_domains
    API hit and response saved!

    links
    API hit and response saved!

    top_pages
    API hit and response saved!

    url_metrics
    API hit and response saved!

    usage_data
    API hit and response saved!

But on the 2nd run:

    No output!

And that's caching. I can restart the Notebook and it would be the same result.
And the file is now 86 KB.

The next piece of Python code that reverses the process which used to show
nothing because the database was empty:

```python
with sqldict("mozlinksapi.db") as db:
    for key in db:
        print(key)
```

...now shows the keys in the database:

    anchor_text
    final_redirect
    global_top_pages
    global_top_root_domains
    index_metadata
    link_intersect
    link_status
    linking_root_domains
    links
    top_pages
    url_metrics
    usage_data

Okay, let's look at the actual retrieved data after a Notebook kernel
restart...

We have all the data so I don't need that other in-memory and more fragile way
of doing the same thing that I used yesterday. But still, let's show the cached
raw data:

See? There's no cost in re-running this. The data's already local and you're
now just fetching it off of your local storage. This approach creates a feeling
of freedom and safety that helps with experimenting.

But we don't want our databases to ever end up in our Github repos...

Okay, there's a lot of new stuff to commit, but a reminder it's full of
metadata garbage from iPython/Jupyter that's not very git/Github friendly. So
we save and clean notebooks before committing:

And that's a good stopping point. Later gaters. I'll talk again in my videos, I
promise. This is just to power through some work. Holding my feet to the fire,
such as it were.

Boring as watching paint dry, I know. I hope YouTube doesn't have the same
thing going as in SEO where really low-interaction content drags down your
whole site, LOL! That would explain a lot. I'm the pop-fly king in YouTube...

My systems slowing down to a crawl. Time to wrap this up... almost... Haha,
since 2007. Occasionally I have breakout content but because I'm not a
traditionally rewarded looking profile, the algorithm smacks me down quite hard
and repeatedly.

Someday. Later gaters.

# Cleaning up MOZ Links API Exploration Repo

Hello World! It's April 1st. Don't believe anything you read today.

{% include youtubePlayer.html id="uEh9kcBE2mY" %}

I'm now no NeoVim instead of vim so that I get the OpenAI Github Copilot
integration. See: https://copilot.github.com/

I'm also using the Mechvibes software from SourceForge to make some clicky
sounds as I type.

What other housekeeping?

- Renaming files
- Better README.md
- Get rid of clutter

NeoVim keeps it's .vimrc equivalent file in ~/.config/nvim/init.vim.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/continuing-my-silent-live-streaming-journaling-adventure/">Continuing My Silent Live-Streaming Journaling Adventure</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/a-conversation-about-superintelligence-with-bard/">A Conversation About Superintelligence With Bard</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/github-copilot/'>Github Copilot</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/marketing/'>Marketing</a></h4></li></ul>