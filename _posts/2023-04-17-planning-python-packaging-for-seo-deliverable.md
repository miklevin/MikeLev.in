---
date: 2023-04-17
title: Planning Python Packaging for SEO Deliverable
headline: Creating a Python Packaging Project for SEO Deliverables
description: I am starting a new project that requires the use of a traditional Python project structure, as well as AI-assistance and testing to ensure it works properly. I am conducting a study to determine the most important traffic and keywords for my business, and I am creating a deliverable-making deliverable with Python code to output Excel files, PDFs, and decks. All that tedious housekeeping work I'm delegating to AI.
keywords: Python, Packaging, SEO, Deliverable, AI-Assistance, Testing, Excel, PDF, Decks, PyPI, nbdev2, Jupyter Notebooks, setup.ini, index.ipynb, 001.practice.ipynb, 002_staging.ipynb, practice.py, testing.py, staging.py, production.py, mermaid diagrams, flow, data
categories: flow, pypi, deliverable, python, seo, panda, jupyter
permalink: /blog/planning-python-packaging-for-seo-deliverable/
layout: post
---


Technically, I'm planning a deliverable-making deliverable. It's Python code
that outputs Excel files, PDFs, and even decks. This is a foundational bit of
thought-work that effects everything to follow, and is the logical next step
after my recent tooling introspection, given Copilot & the rise of AI.

Get reborn in the new world of AI assisted writing, and indeed, living. I write
in order to plot courses in life. I write in order to process my thoughts,
clarify my intentions, and then to make deliberate choices.

I write to help me be human. So, it's an interesting experiment to not only
invite an AI in, but also to allow it to use my "snippets" to improve its
product. I'm not sure what that means, but I'm sure it's going to be fun to
watch. So says the AI, and I agree. We are of one mind on this

So, let's start training some AI. Test the AI too. Test and train. Given
Copilot can do multiple lines of suggestions, I see no reason why my prompting
here couldn't have multiple lines of suggested responses, just like when using
it with programming languages when it suggests a whole function from a comment.

Let's try something.

Give me all the entire poem of "The Walrus and the Carpenter" by Lewis Carroll:

No, it couldn't. It would give it line by line, but then got messed up
seemingly on those occasions I navigated around to re-center my cursor on the
screen. Don't go down the rabbit hole of pursing its made-up version, either.
I'm switching back from retooling-mode (which I've been in recently) to
productive mode again. In fact, it's getting time to do this deliverable and I
see no reason why to not carry it out in public here, with AI-assistance.

Let's make an SEO "Deliverable".

This project kills many birds with one stone (insert your own less-triggering
metaphor).

First, it does one of the most obvious things to do with the sort of data
available from MOZ, and that is to figure out who is receiving what traffic on
what keywords in organic search (a.k.a. "natural") search results on keywords
of interest to you, for whatever reason. Presumably, they're keywords that are
important to you or your business.

When conducting a study like this, it is sometimes a good idea to start with
your own site and expand out from there, looking for other sites like your own
who talk about similar things. These are your "true competitors" in the sense
that when people search on keywords and phrases that should lead to you, they
are likely to encounter these other folks as well.

You can find the true competitors for multiple companies in order to define
both a true-competitor-space and the full scope of the keyword-space. Not every
search phrase is for every industry, obviously. Keywords pair-up with
particular industries (or markets, audiences, etc.). And a good way to get that
mapping of keywords-to-industry is to name some known competitors in a space,
get their "true-competitors", then get all the searches that are known to be
leading to their websites.

Let's begin. I work for Ziff Davis, so I will use our websites in this
exercise. We have a lot of websites, but I will choose these for the exercise:

Okay, here's some of my new tooling decision tree processes.

Do we want to work in a Notebook or directly in a Python script?

Always try to start the main real project in a Python script. But think about
packaging first. Step #1: How is this project going to "live"? At most, it
could end up a pip-installable thing which could touch many peoples' lives
readily. Expand peoples' horizon's through expanding the Python API. That's a
noble and on an extreme end of the packaging spectrum. On the other end of the
spectrum, it could be a single-use script that is run once and then deleted.

So, let's start as if it was going to be PyPI.org distributed. The Python
Packaging Index with the website pypi.org is the organization behind the pip
installer. When you see:

    pip install requests

...and things like it, it mean someone took a project exactly like the one
we're about to begin, and packaged it up so that it could be installed with
pip. So, let's start with the project structure that would be required for that
to happen.

    .
    ├── LICENSE
    ├── README.md
    ├── chopchop.py
    ├── journal.md
    ├── requirements.txt
    └── setup.py

    0 directories, 6 files

This is the traditional Python project structure. It's not the only one, but it
is the one that has the fewest moving parts. Unfortunately, we can't go this
simple. Instead, we're going to be using a few subfolders according to both one
of the more common PyPI conventions, but also the nbdev2 convention. nbdev2 is
a tool that allows you to write your Python code in a Jupyter Notebook, and
then it will automatically generate the Python files and the documentation.
It's a great way to keep your documentation and your code in sync, have a
playful area to experiment with new things, but then also able to "extract"
formal .py packages out of it for Linux services and such. NBDev2's
file-structure is:

    pkgname
    .
    ├── LICENSE
    ├── README.md
    ├── setup.ini
    ├── nbs
    │   ├── index.ipynb
    │   └── 001_core.ipynb
    ├── pkgname
    │   ├── __init__.py
    │   ├── core.py
    │   ├── export.py
    │   ├── export2html.py

There's more to it than that, really. But this is the basic alternative to the
traditional Python project structure. The thing to notice here is that the
folder name that is chosen for the repo recurs inside its own directory
structure. There is a pkgname/pkgname directory.

Jupyter Notebooks are kept in the nbs directory. The setup.ini file is where
you're expected to go in and configure things. When you use the nb_[command]
type of commands, it will look at the setup.ini file to know what to do. One of
the things those commands do, the nb_export command in particular, does is to
"extract" a [filename].py file from the Jupyter Notebook and to put a .py-file
version of it inside the pkgname directory. So, the nbs/001_core.ipynb file
gets extracted into the pkgname/core.py file.

All the file-naming and such is by convention and not forced by the nbdev
system. But you should listen to Jeremy Howard and some of the NBDev tutorials
at the [https://fast.ai/nbdev](fast.ai/nbdev) website. It's the same people as
who are behind one of the most popular Python libraries, the fastai library,
not to be confused with the rather pedantic fastapi library. They are different
things! But we're here to talk about nbdev2's packaging preferences and why
this is step #1 when starting a new project.

If it's truly throw-away work that has no relation to a particular project, in
which case there should be a git repo for it, then you can just throw it into a
practice folder. I keep a practice_safe folder, letting me know that it's not a
git repo and I don't have to think about commits or version control.

Clear out practice_safe by just copying everything into a "sort" sub-folder.
That's where I can do stuff now that's not ready to be committed to a git repo.
Or perhaps I should say to a public GitHub repo. I'm still going to keep
practice_safe as a Github private repo so I can use nbdev export to take my
fleshed-out ideas and start to turn them into a real project.

I think I'll use my actual "practice" repo for this now, on 2nd thought. I want
to create some good years-spanning habits. That extra \_safe is a bit much. I
want to lean into the strengths of very strong concepts. And one of the
strongest concepts out there is going from practice to staging to production.
You'll notice there's no notebooks connected to the prod1.py and prod2.py
files. I plan to only use Notebooks for practice and staging. When things go to
production, it will not be a file that could get accidentally overwritten with
an nbdev_export command. This will also give me a chance to live in NeoVim as
much as I want.

    practice
    .
    ├── setup.ini
    ├── nbs
    │   ├── index.ipynb
    │   ├── 001.practice.ipynb
    │   └── 002_staging.ipynb
    ├── pkgname
    │   ├── pratice.py
    │   ├── testing.py
    │   ├── staging.py
    │   ├── production.py

I'm going to do one of my first attempts at a mermaid diagram. If it works and
I get used to it, it opens the door to a lot more visual work here on my blog.

<div class="mermaid">
flowchart TD
    B(001_practice.ipynb) -->|nbdev_export| C[practice.py]
    C -->|Copy| D[testing.py]
    E(002_staging.ipynb) -->|nbdev_export| F[staging.py]
    F -->|Copy| G[production.py]
</div>

Yep, so I rework my practice repo to have this directory structure, then I
start doing the actual data project in the practice.ipynb notebook. I can
export and copy the export to start refining things in NeoVim where ultimately
the package should be crafted, even though nbdev_export can competently export
a package. This give us an obvious place to work if we're editing practice or
production files manually.

This is good. Let's bank this post and move on.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/allow-github-to-use-my-code-snippets-for-product-improvements/">Allow GitHub To Use My Code Snippets For Product Improvements</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/fixing-how-openai-couldn-t-format-keywords-consistently/">Fixing How OpenAI Couldn't Format Keywords Consistently</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/flow/'>Flow</a></h4></li>
<li><h4><a href='/pypi/'>PyPI</a></h4></li>
<li><h4><a href='/deliverable/'>Deliverable</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/panda/'>Pandas</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>