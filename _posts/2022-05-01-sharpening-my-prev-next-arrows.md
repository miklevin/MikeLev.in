---
date: 2022-05-01
title: Sharpening My Prev/Next Arrows
headline: "Polishing My Prev/Next Arrows: A Journey of Flexbox Wrangling and Liquid Directive Neutralizing"
description: I'm proud of the effort I put into creating the formatting of the previous/next arrows on my website. I used style.scss, post.html, a non-breaking-space trick, and flexbox wrangling to make them look elegant. I'm still learning how to neutralize and escape Jekyll blog post Liquid directives, but I'm excited to share the results of my work. Click to read more!
keywords: Sharpening, Arrows, Formatting, style.scss, post.html, Non-Breaking-Space, Trick, Flexbox, Wrangling, Neutralize, Escape, Jekyll, Blog, Liquid, Directives, Results, Effort, Appealing, Proud, Work
categories: jekyll, trick, liquid
permalink: /blog/sharpening-my-prev-next-arrows/
layout: post
---


It turned out that what was "most broken" in my opinion was the formatting of
the previous/next arrows. I put so much effort into just having them at all
over the past day that it'd be silly to stop before I tweaked them to an
acceptable point. You're probably looking at them now. Makes you want to click
them, doesn't it? Well, here's the secret sauce.

Here's the style.scss

```css
@import 'jekyll-theme-hacker';

.spacer {
    padding-top: 1.5em;
    padding-bottom: 1.5em;
}

.post-nav {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
}

.post-nav-prev {
    text-align: left;
}

.post-nav-next {
    text-align: right;
}
```

And here's the post.html. I use a very old-school non-breaking-space trick
here, but it works super-well. There's some flexbox wrangling here and its
flex sub-command I'm still getting a handle on. I may make it more elegant in
the future, but the way it displays certainly looks elegant.

And of course the other tired old trick of yet-another-div because padding or
whatever doesn't work correctly on the inner one.

...opps, apparently I can't show you that until I learn about neutralizing and
escaping Jekyll blog post Liquid directives better.

Oh, and the reason vim is better than emacs is because


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/disabling-github-ci-nbdev-install-git-hooks/">Disabling Github CI nbdev_install_git_hooks</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/sharpening-my-prev-next-arrows/">Sharpening My Prev/Next Arrows</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/trick/'>Tricks</a></h4></li>
<li><h4><a href='/liquid/'>Liquid</a></h4></li></ul>