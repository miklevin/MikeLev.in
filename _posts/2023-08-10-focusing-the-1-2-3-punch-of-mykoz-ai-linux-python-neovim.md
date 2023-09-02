---
date: 2023-08-10
title: Focusing the 1, 2, 3 Punch of MyKoz.AI (Linux, Python, NeoVim)
headline: Unlocking the Path to Tech Wizardry with MyKoz.AI's 1-2-3 Punch of Linux, Python, and NeoVim
description: "In this post I distill down the focus of MyKoz.AI into mastering the 1, 2, 3 punch: Linux, Python, and NeoVim with each having a main site navigation link. I adjust the anchor text hover highlight to be sticky as you visit each page, surprisingly still tricky in HTML. Jekyll Liquid template to the rescue!"
keywords: Linux, Python, NeoVim, Jekyll, Simple.css, Website, SEO, Levinux, WSL, Windows Subsystem for Linux, Windows 10, Windows 11, Server Install Script, Kooky, Arcane Knowledge, Global Transformation, Macrotrends, Professional Certificate, Technical Skills, Flexibility, Motivation, Curiosity, Employers, Future of Jobs Report, Suspended Disbelief, Timeless Tech Wizard, Existential Job Crisis, Coursera, Ret
categories: jekyll, python, seo, motivation, linux, wsl, vim, levinux, microsoft
permalink: /blog/focusing-the-1-2-3-punch-of-mykoz-ai-linux-python-neovim/
layout: post
group: blog
---


Okay, so today I went from MyKoz.AI just being a registered domain with a
domain registrar parking page to it being a 1-page hosted website on GitHub
Pages. I'm using Jekyll, which is a static site generator. I'm using the
minimal Simple.css framework, heavily stripped-down and modified. I'm not using
any provided Jekyll templates and have instead just spun my own, which because
Github moved things around and I had good starting points, turned out to
actually be the path of least resistance.

I want to get this sufficiently underway that I can start referring people to
MyKoz.AI and so that it's positioned to pick up the SEO juice from all the
folks who will be going into existential job crisis mode over the next few
years and months. At the rate it's going with articles and frenzies, it could
be days. It could be the perfect storm if I play this right. Let's play this
right. Think it through.

Few people in life have "something to offer" the way I do. I mean how many
people consider themselves like the best in the world at a thing and are going
out of their way to help others benefit from it? I think I may be one of the
best in the world at writing kooky Linux install scripts. I made Levinux in
something like 2010, and it's still going strong. It can hardly be killed if I
wanted to. I accidentally wiped out the Github repo and all of its stars, but
it still has like 1,000 followers on Facebook. And that's with it based on
dead-end tech that was only really good for Linux tire-kicking.

Now, I've got it down. Now, the next rendition of my kooky server install
script works with WSL, which is the Windows Subsystem for Linux. And it works
well on Windows 10 and 11, which means I've got the majority of the
computer-using world as my potential target audience. Now I've just got to
convince them to approach a project like this with the same mindset as they put
into games or watch movies. Suspended disbelief. You too can become a timeless
tech wizard, mastering all that arcane knowledge that's so deep-rooted in tech,
it's never going away no matter how much disruption's coming down the pike.
Yes, that could be you orchestrating the change instead of being steamrolled by
it!

Here's some text that just came in a Coursera email today:

> Prepare for the workplace of the future
> 
> Did you know? Between now and 2027, 60% of workers will need retraining due to
> global transformation and macrotrends.
> 
> That's one of many findings in the World Economic Forum's 2023 Future of Jobs
> Report, which explores how skills and jobs will evolve over the next 5 years.
> 
> Whether you'd like to switch fields or grow in your current role, a
> Professional Certificate will equip you with in-demand technical skills, as
> well as signal to employers you possess skills like flexibility, motivation,
> and curiosity, which are increasingly important to employers.

That's one approach, but naturally I'm going to be using SEO to bring people
in. To that end, I need to do a few more setup things on the site today. Not
the least of which is actually fill the content into the site.

I have 3 links on the site. The 3 buttons look great! It works well on desktop,
but especially on mobile. I need a page on each of these buttons. I'm reducing
future-proofing yourself into 3 easy steps. I need to have that messaging down!

1. Get a Linux server running on your Windows PC.
2. Start using Python in Linux Jupyter Notebooks.
3. Start writing daily journal entries in NeoVim.

Wow, I need to put a proportional font on my website! That way I can do all my
ASCII art without all the rigmarole of creating snapshot graphics like I'm
currently doing here on MikeLev.in. It makes sure everyone sees it exactly the
same, but that sort of defeats the purpose, doesn't it?

Wouldn't it be nice if I could just update the diagrams and stuff using vim in
a forever improving and evolving way? I think so. I think that's the way to go.

Okay, so my next step is clear. I need a Linux, Python and NeoVim page under
MyKoz.AI. Go do that...

Okay, yay! It's done. Now turn the MyKoz.AI h1 into a homepage link. Alright,
I've got the hover color correct now too. And finally, we do that nifty little
trick of making the hover-color "stick" as the currently selected site-section
color in navigation. It's amazing such tricks aren't built into HTML and such
these days, and they COULD be programmed in JavaScript, but that's overkill on
a static site. So we just use Jekyll logic to do it when the site generates.

Here's the trick of making a mouse hover color "stick" as the current page
color if you're using a static site generator like Jekyll that uses the Liquid
template system:

```html
{% raw %}<a {% if page.group == 'linux' %}class="current" {% endif %}href="/linux/">Step 1</a>
<a {% if page.group == 'python' %}class="current" {% endif %}href="/python/">Step 2</a>
<a {% if page.group == 'neovim' %}class="current" {% endif %}href="/neovim/">Step 3</a>{% endraw %}
```

















<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/a-simple-and-bare-minimum-styles-css-file/">A Simple and Bare Minimum Styles CSS File</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/30-questions-with-bing-mostly-about-seo/">30 Questions with Bing, Mostly About SEO</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/motivation/'>Motivation</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/levinux/'>Levinux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>