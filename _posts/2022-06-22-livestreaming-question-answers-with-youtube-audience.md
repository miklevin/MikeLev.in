---
date: 2022-06-22
title: Livestreaming Question & Answers With YouTube Audience
headline: "Staying Relevant at 51: Tips for Avoiding Vendor Traps and Using Microsoft Tools"
description: I'm 51 years old and have been made obsolete by so many things, but I'm using the tools Microsoft is providing to stay relevant. In this video, I discuss how knowledge workers bring their minds and capabilities to their job, and how I use my own CMS called Skite to take notes and organize my work. I also share tips on avoiding vendor traps and obsolescence resistance, such as using Python dict API, Sqlite3, Django and Flask, and the Unix Way.
keywords: Livestreaming, Question & Answers, YouTube, Audience, Microsoft, CMS, Skite, Vendor Traps, Obsolescence Resistance, Python dict API, Sqlite3, Django, Flask, Unix Way, LXD, WSL2, Azure, Terminal, VSCode, Linux, Python, Data Manipulation, SEO, Video Commenting, Lisp, Emacs, Web-Scraping, Authentication, Data Transformation, Python Pandas, ETL, Data Analysis
categories: python, container, audience, youtube, emacs, microsoft, seo, wsl, linux
permalink: /blog/livestreaming-question-answers-with-youtube-audience/
layout: post
---


Hello everyone! This video started out as an attempt to edit a YouTube
livestream before it was ready and turned into Q&A with the audience who joins
in as the workday begins. I guess that's only logical and I let it continue
because it really is so work-related. It covered a lot of topics of
obsolescence resistance, vendor traps and LXD (Linux containers) under WSL2
(Windows Subsystem for Linux).

{% include youtubePlayer.html id="7j-oI-Q5Gm0" %}

I had questions from about how I navigate around my notes and read them later.
I showed my tag system and talked about how it's not about re-reading, but it's
really about learning better in the first place like taking notes in class. The
best way to learn is to teach, and this helps me teach myself. Over time, good
ideas will emerge, get polished and be moved to other sites. But I don't worry
about that so much.

As far as a little bit of organizing as I go, I have my own CMS called Skite
which lets me use one text file and lots of blog-like entries (in combination
with vim macros) to blog (for life or per site or per topic).

- I have multiple journal.md's that divide by "site" (by broad topic)
- I have 1-to-1 Category belongings for those posts that make sub-blogs
- I have a `_itagits_` tagging system that lets me jump around ad hoc tags

All based on taking notes as a excellent way of learning.

Knowledge workers of the information age bring their minds and capabilities as
their part of the deal. They have value because they pre-generated skills and
abilities that the organization needs. We don't work for ourselves because
bringing it to an organization releases our value more efficiently than all the
overhead of working for ourselves (employees, paperwork, marketing, taxes,
etc.)

Peter Drucker... Managing In Times of Great Change... Knowledge workers.

Python Pandas is the money maker... when coupled with OAuth2 savvy.

The cloud ***MUST BE OPTIONAL***.

The new vendor dependency trap battle (i.e. slapping a leash on you) is taking
place through proprietary application program interfaces... Cloud APIs... but
also VSCode, no doubt. Who will learn vim or git when you have VSCode?

The answer is no one can escape VSCode. You just must manage the brainwashing.

And thus Microsoft dependency is assured.

Where is safetly?

Sqlite3... learn to use it for EVERYTHING locally. You at least have a
cross-platform contingency plan for all things high performance-ish data.
All Sqlite3 work can be adapted to the cloud for scaling, etc.

The Unix way... The Linux way. Google "The Unix Way"... and toolbox concepts.

Django and flask are are rare safe harbors. Their APIs change what? Every
10-years... maybe.

When flask embraced concurrency (async/await keywords), the API didn't break.
Compare that to FastAPI where pedeantic is a dependency as is Web-documentation
publishing... very Microsoft.

Look for non-changing APIs in long-term tools. The Unix Way. Also appears in a
lot of timeless-esque Python tools.

Obsolessence resistanmce on Python?
- Django
- Flask
- Hopefully Pandas
- Hopefully Requests (httpx is API-compatible, thank goodness)

Technical liability & overhead... It's what vendors hold over your head. It's
liable to be chopped off, leaving you with obsolete skills.

- Amazon S3 key/value bit bucket... used everywhere... vendor specific.
  Liability? Probably not. Everyone copies it. Or easy translation.

Use Python dict API... standard builtin data model like int, float... Python
also has list, tuple & dict. Of these, the dict is a universal key/value pair
API applicable everywhere and in everything... highly optimized, and can be
"back-ended" by SQLite3, Redis, Amazon S3 or what-have you. But by using the
standard API, your code will never break and you can change what back-end's
your key/value pairs for persistence.

This is a million-dollar trick.

Obsolessence resistance is key to me... but entirely at odds with the:

This is the world everyone will compel you into today:
- VSCode
- Full Web Stack
- NodeJS
- JavaScript

I'm 51 years old and have been made obsolete by so many things that looked like
sure bets, but there is no such thing, but Unix.

- We're lucky to have Linux groundswell
- We're lucky to have Guido van Rossum paranoid about changing APIs (Python)
  - We're lucky Python replaced PERL as the ship-with-nix language.

We're all temporarily screwed by JavaScript's dominance. But it will become
much like SQL or RegEx. Who really loves SQL or RegEx, but they're always
present subsystems and resume keywords. So be it. JavaScript? Same thing. User
Interface APIs. Concurrent (non-blocking) and always there. Thank goodness it
wasn't display PostScript (it could be worse).

- htmx (protocol & templates)
- AlpineJS (loose coupling)

Loosely couple a JavaScript API-layer with Python back-end server to deal with
all today's WebDeb "gotcha's" (new framework every year) in a Pythonic way.

The work I'm putting off right now is the LXD work. It's there. It's working.
It's ready to go. It's my new Linux playground under Windows.

I NEED LXD under WSL2... not having it is unthinkable. I think I have it
working. I need to do Python Data Pipelining (like Luigi, but Huey).

![Not Having Lxd Under Wsl2 Is Unthinkable](/assets/images/not-having-lxd-under-wsl2-is-unthinkable.png)

I talk about data getting, shape-changing & putting.

Key to that is the Linux tools.

Key to that is playing around with various tools under Linux with FUBAR'ing my
main Linux "host" and keeping it on my laptop (not cloud).

All my pain is because Windows Laptops are cheap, cool & very well supported
from drivers to repairs... it's offering WSL which appears good enough...
especially if supporting LXD... which is the REAL Linux playground...

There are nested Linux playgrounds. WSL Linux's can be swapped out easily
enough... but not so easily for rapid daily new Linux playgrounds, which I need
for my next phase of work.

I need virtualenv aka venv as in Python but for Linux.

Guile is like a new BASH Script.

Once upon a time there was Unix script. Not good enough. So each "shell" had
their own: BASH Script & Kornshell Script... problematic. No one likes, so then
there was PERL. All Unix's and Linux's started shipping with PERL, thus the P
of the original LAMP platform: Linux, Apachee, MySQL & PERL (PHP & Python)...
plone/zope.

But PERL is overkill and underkill at the same time, so many flocked to Python
and Python became the new PERL, but the GNU organization can't have such
dissonance in the GNU tool-set, so they replaced Unix Script with Guile. Guile
could let you do away with Python if you just wanted obsolescence resistance in
the basics.

SQL-like data manipulation with Python/Pandas is not the basics, though much
could be accomplished with:

- Guile
- sed
- awk

It is sooooo the Unix-way... however, Python (pip install, etc.) is too good to
walk away from.

Please comment on the Video.

Find it on the latest MikeLev.in blog post.

I am organizing them for you.

The greatest thanks will be to help me blow up on YouTube.

I am an SEO after all, and I'm experimenting with different factors, and
comments on videos seem to me like one of the most important.

Interaction is invaluable.

A sure sign of quality.

So if you think you're onto something here, at least give me a hello on
comments.

I really appreciate it.

And now back to our regularly scheduled workday.

Peace out.

I know I'm different, but I'm just using the tools Microsoft is including for
themselves to not be rendered obsolete. Hilarious turnaround, is not?

But by giving the doorway to the world of Linux, they are also installing
vendor-dependency traps like: Azure dropdown from Terminal and VSCode to keep
you from working in LXD under WSL2 and from vim.

But each has an ~8GB footprint. LXD footprints are much tinier. So it's about
hard drive space on a laptop (anti-cloud methodology is keeping your "virtual
Linuxes" light and small).

There's always alternatives... VirtualBox was once one, then it got bought by
Oracle... just like MySQL. So paths to lightweight that don't get gobbled up or
otherwise ruined by vendors are rare gifts, vendors don't want you forming
habits around.

LXD is one. vim. vim plus LXD is Microsoft's nightmare.

It's not conspiracy that systemd isn't active on WSL by default, but it
certainly doesn't hurt Microsoft's cause.

systemd is just general Linux system automation that serves as an alternative
to many other vendor tech's.

Think about why they named it WSL instead of LSW

Linux must always be subordinate. Anything showing you Linux can run the show
is bad.

LXD is on its way to being like the kernel virtual machine (kvm) which is
hypervisor for Linux, built-into the Kernel and part of the official Linux. It'
won't docker. Docker's too strange. LXD works just like KVM but containers.

Question from Ben from the Philippines who is a Scheme LISP emacs (these are
the things I admire most / musical)

- Connecting on a sort of spiritual level who chose the tools I covet
- LISP/emacs users are highly customized... whereas I am not
  - Who am I to give advice?
  - I have figured out a few things that are
    - Very suited to "today's world"
    - Quite easy (esp. compared to the custom world)
  - Everyone needs to analyze data
  - Few know how to get the data from API / web-scrape sources
    - It's hard because it takes custom scripts
    - It takes authentication
      - Used to be username / password (easy)
      - 2FA SSO (Web users)
      - OAuth2... or some variation of Public/Private key
    - It's hard to know how to grab & store it quick (without various
      paralysis)
  - Transform
  - Transform
  - Transform
  - Get good at Python pandas
  - ETL

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/storytime-with-mic-lovin-the-wizard-of-oz-s-redemption-story-arc/">Storytime with Mic Lovin' - The Wizard of Oz's Redemption Story Arc</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/fixing-jupyter-desktop-set-python-environment-error-message/">Fixing Jupyter Desktop Set Python Environment Error Message</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/audience/'>Audience</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li>
<li><h4><a href='/emacs/'>Emacs</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>