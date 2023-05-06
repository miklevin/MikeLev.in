---
date: 2022-08-15
title: Choosing Best CSS Framework For Github Pages and Jekyll
headline: Exploring CSS Frameworks for Jekyll and Github Pages
description: "I'm looking for a CSS framework that provides a modern look, is search-friendly, has been around the longest, and allows me to produce clean, vanilla HTML code. After considering Bootstrap, Foundation, Bulma, Semantic, and UIkit, I decided to go with Foundation because it doesn't require btn classes. I activated lpvg.org on Github pages, created a `_layouts` folder and default.html file, and reminded myself to take baby steps."
keywords: CSS, Framework, Modern, Look, Search-Friendly, Longest, Clean, Vanilla, HTML, Bootstrap, Foundation, Bulma, Semantic, UIkit, Btn, Classes, Github, Pages, Jekyll, Experiment, Rabbit, Holes, Baby, Steps, Categories, Feature, Blogging, Software, To-Do, List
categories: html, experiment, github, blogging, jekyll
permalink: /blog/choosing-best-css-framework-for-github-pages-and-jekyll/
layout: post
---


Let's push and push and push on that YouTube front. Wrap in Reddit. Twitter,
Facebook and all that is nothing compared to the YouTube/Reddit front. I'll
maybe announce my videos on Twitter and keep the old Levinux crowd in the loop
with the MikeLevinux page, but that's out of consistency, loyalty to those
audiences and helping search a wee little bit.

Oh, search. Yes, I'm always reaching out to people who search and not surfers.
It's seekers I'm seeking and not slaves to the YouTube algorithm. The YouTube
algorithm has rarely been kind to me and I should assume it never will. It's
for those who predict and pander. Ha ha, and that's from an SEO who makes a
career out of showing others how to do exactly that. Perhaps I should practice
more of what I preach just to bank a little more online success and keep my
skills sharp. Hmm, yes maybe I will. Why am I pushing on the YouTube front if
not for that? Oh yeah, it's more for attaining levels on the Maslow hierarchy
of needs. I think I'm seeking "my people".

Here's a journal entry that started out on the private side and I moved over to
the public side because this is precisely the sort of process-sharing I wish to
reside here. There's plenty of weakest link in the chain analysis to do for my
YouTube, Web and social media presence. The main thing is that I'm working on
my tooling an thought-processing and general skills. I'm NOT working on
actually boosting my public-facing presence. The two probably should go
together more than I've liked to believe recently, and so to have credibility
on the tooling, thought-processing, skills front I need more credibility on the
public-facing front.

Sighhh, okay so be it.

1, 2, 3... 1?

I need even better organization on the public-front that performs better in
Google Search and reflects the current actual state of my thinking. It needs
more flexibility and less fringe design wackiness. And if I'm going mainstream,
I should go as mainstream-but-timeless as I can. That means not Google's
Material UI nor any of the cool-kids modern JavaScript frameworks. Instead, I
should probably stick to those that will give me a modern look, be most
search-friendly, been around the longest, and perhaps allow me to produce the
most clean, vanilla HTML code. Specifically bootstrap.js, the old Twitter
original library that kicked off the movement, comes to mind. Does it meet the
criteria? Will it force me to use sass pre rendering tools? If it does, will
Jekyll do the heavy lifting for me (it's pre-rendering anyway).

Quick googling shows Bootstrap vs. Foundation, Bulma, Semantic and UIkit. Look
at which uses not class propagating HTML and is friendly with Github Pages and
Jekyll. I want as simple, flexible and future-proof as possible. Ugh, the
tutorials on the topic are ugly. All this stuff is ugly. I'm not thrilled with
how the Web works with HTML, the DOM, JavaScript and CSS. But that's the
downfall of every tool, evolved, reality-based and compromised. Idiomatic
approaches are only clear in hindsight and by that time the pee is in the pool
and isn't coming out. Okay, so live with it. Which is the solution I can live
with most happily over the years? Chosen tools become a part of you, so choose
carefully.

The best approach is to throw a throwaway domain to the cause. Put something
out with the least code. Use elements to do the styling. Anything inside a nav
element gets styled as the nav I define. I shouldn't have to liter everything
up with btn classes, yuck! Less code. More abstraction. Less classes, more
purposeful elements.

Foundation! Ugh, it only took me minutes looking at Bootstrap and all those
btn-this and btn-that's to become fatigued before I even downloaded the
includes. Do not fall into the btn-trap! The word is semantic markup. Stick
with the most clean, semantic, plain-vanilla HTML as you can. That's
future-proofing. Boostrap is the opposite of future-proofing, mixing all its
special implementation code in with your main content.

Beware rabbit holes! If any of these CSS frameworks lead you down a rabbit
hole, back off and rethink!

Okay, follow the love. I've got a few competition projects right now, including
ones I have to get done for work. Is there a really quick one-off I can do? I
need an experimental sight where I can experiment with CSS frameworks under
Jekyll without impacting my main site. I should also point out why this is one
my mind.

Let's develop the lpvg.org site. It's one I need to develop soon/fast to lead
this movement anyway. Do the first baby-step of this project then back off and
do different work. 1, 2, 3... 1? Go visit site and see if there's anything
there. No, not even my CMS system. Perfect, so it's a fresh start. 1, 2, 3...
1? See if I have a repo yet. The folder is there, but it's not a repo yet. Make
it a "Hello World" Github Page.

Think about organizing your recently deployed categories feature of your
blogging software. Life is a lot of little journeys. Here are some of mine you
might be interested in. That's not for this project, but that's definitely
something to keep in mind. Drop it into your todo list at the bottom of this
document.

Ugh, okay, do the baby steps. I activated lpvg.org on Github pages. I put a
\layouts folder in place and a default.html file in location. I stripped it
down to the bare essentials.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/why-linux-fights-obsolescence-and-lxd-is-key/">Why Linux Fights Obsolescence and LXD is Key</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/why-pages-aren-t-usable-on-mobile-fixing/">Why Pages Aren't Usable On Mobile, Fixing!</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/experiment/'>Experiment</a></h4></li>
<li><h4><a href='/github/'>Github</a></h4></li>
<li><h4><a href='/blogging/'>Blogging</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li></ul>