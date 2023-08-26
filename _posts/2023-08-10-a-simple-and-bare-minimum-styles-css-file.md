---
date: 2023-08-10
title: A Simple and Bare Minimum Styles CSS File
headline: I Stripped Down Simple.CSS to Create a Minimal and Polished CSS Framework for MyKoz.AI
description: I am not a web developer. This step of a project intimidates me. Instead of using the next shiny bells and whistles JavaScript Framework, I prefer to build nearly from scratch and reacquaint myself with the latest Web fundamentals. I recently customized the Simple.css Minimal CSS Framework to get the perfect balance between technical details and a polished look. Check out the before and after versions to see the transformation!
keywords: CSS, Simple.css, Minimal, Framework, Default, Customized, Buttons, Visual, Mobile, Click-Target, Links, Rounded, Copy/Paste, Before, After
categories: 
permalink: /blog/a-simple-and-bare-minimum-styles-css-file/
layout: post
group: blog
---


It seems no step is too small for its own article in this journal. I really
love building things up from scratch. There's a certain satisfaction in
building up from nothing. You learn the fundamentals, and you can always
rebuild it again from scratch ***or*** add in some fancier system for deluxe
features later on. By knowing the fundamentals, you know how things ***glue
together***. You also know when some other system is stepping in and doing its
thing, such as we discovered Jekyll does if you leave out
`_layouts/default.html`. That's a ***very opinionated*** step it takes. Glad I
filtered it out.

But now I'm facing the exact opposite problem. I'm not going to build up a
simple CSS framework with you from scratch. However, I will refer you to
`simple.css`, which at the time I was shopping around for such things was my
favorite. If you don't hold ***any opinions***, then your site will never look
like a finished, polished site. So I'm going to transpose my favorite parts
from simple.css into my own `styles.css` file.

These bits from simple.css mostly have to do with how buttons are presented.
The single biggest thing that makes a site look excessively old-school is plain
on blue/purple html navigation links. These should be rounded corner buttons
with a hover effect. And the hover effect should be a different color than the
button color. And there should be a way to keep a button highlighted when you
navigate into a subsection of a site.

Pshwew! That was the end of a long marathon session! But here's what I got.
First, I'll show you the simple.css homepage and how they present their
buttons. Then I'll show you the MyKoz.AI homepage with the same buttons. I
stripped out a lot of stuff and changed methodology a bit, favoring the vw
(view width) measurement over the rem and other measurements. I went for fully
rounded buttons, a dark theme and colors that really pop. I think I struck the
perfect balance between how simple a design and the technical details are
versus how polished it looks. I'm really happy with it.

## Simple.css Minimal CSS Framework Default

![Simple CSS Minimal CSS Framework Default](/assets/images/simple-css-minimal-css-framework-default.PNG)

I really think Simple.css is losing an opportunity to use larger visual buttons
on mobile. I mean what's the point of a nice big click-target for your finger
if you're going to turn it into an old fashioned link when presented on mobile.
And look at how nice and rounded the buttons can look these days!

## Minimal CSS Framework Customized

![Minimal Css Framework Customized](/assets/images/minimal-css-framework-customized.PNG)

Anyhow, there was a big copy/paste job to get the original simple.css into my
own styles.css with all the customizations to get the look I wanted. For anyone
interested, here's the [before](https://cdn.simplecss.org/simple.css) and
[after](https://mykoz.ai/css/styles.css).

It should still use more polish, and I'll certainly need to expand the
styles.css as I add more widgets and interfaces to the site. However, this
abides by the 80/20-Rule, and I'm still on track for soft-launching MyKoz.AI
today. There is now a shell I can plug the goods into.

I'll probably want to add custom fonts. The right custom fonts can add so much
to a website that's otherwise quite vanilla. But I won't make the same mistake
as I did on MikeLev.in. I'll host the Google Fonts, or whatever I choose for
the custom fonts, locally for performance and privacy reasons. Once you're
hosting on a site like Github, there's no reason to spread your
dependency-calls all over the place. Who needs a CDN when Microsoft's hosting?











<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/a-simple-and-bare-minimum-styles-css-file/">A Simple and Bare Minimum Styles CSS File</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/30-questions-with-bing-mostly-about-seo/">30 Questions with Bing, Mostly About SEO</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul></ul>