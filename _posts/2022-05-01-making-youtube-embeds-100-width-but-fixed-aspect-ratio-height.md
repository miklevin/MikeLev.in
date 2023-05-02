---
date: 2022-05-01
title: Making YouTube Embeds 100% Width But Fixed Aspect Ratio Height
permalink: /blog/making-youtube-embeds-100-width-but-fixed-aspect-ratio-height/
headline: Fixing YouTube Embeds for 100% Width and Aspect Ratio Height
description: I'm in the process of creating a series of pages with a slicer-token, date, video title, video description, and YouTube embed code, but before I can do that, I need to complete some housekeeping tasks with Jekyll. I've already adjusted the YouTube embed code to be 100% width, but now I'm working on fixing the height issue. After some research, I have found a solution that should do the trick.
keywords: YouTube, Embed, Width, Aspect Ratio, Height, Jekyll, Video, Title, Description, Code, Series, Pages, Slicer-Token, Date, Content
categories: jekyll, youtube
layout: post
---

There's a number of potential directions to go now. The temptation is to start
doing stupid SEO-tricks at the Pipulate.com site. Specifically, it's time to
spin through my >1000 YouTube videos from over the years and spit out static
wrapper-pages for them. Or more specifiably, spit out a single journal-format
page that has the slicer-token, date, video title as page title and video
description as page content, and of course the YouTube embed code. So then I
will have a series of pages that you could next, next, next through using the
prev/next arrows. And I sort and categorize the videos to make topical
groupings somehow. I may bring back the Jekyll blog post tags which I edited
out of posts.html.

That's the temptation, anyhow. But the reality is that before I do such an
indulgent project, I should really finish the last few bits of obvious Jekyll
housekeeping that call out to me. I want to externalize the Google Analytics
code so that the default.html is smaller. There's no reason to have the
specific GA implementation hardwired into default.html. Okay, so it's education
time. I really ought to install Jekyll locally at some point to have even more
hands-on, but that's the messy tech liability stuff I'm trying to avoid. If
you're going to enjoy the magic of hand-waving, Github Pages is exactly where
to do it. So keep my life simple and just find the magic gestures.

There's this [tutorial page on what Jekyll layouts are](https://jekyllrb.com/docs/step-by-step/04-layouts/)
that shows even default.html can have those Liquid curly braces in them. I'm
using something like that for the youtubePlayer.html include. So right off, I'm
going to change the size of that thing to be 100% width. Seeing YouTube embeds
create a horizontal scroll in mobile has been bugging me. So start with that
and make a tiny assertion of control...

Before

```html
<iframe src="https://www.youtube.com/embed/{{ include.id }}"
    width="560"
    height="315"
    frameborder="0"
    allowfullscreen>
</iframe>
```

After

```html
<iframe src="https://www.youtube.com/embed/{{ include.id }}"
    style="width: 100%;"
    frameborder="0"
    allowfullscreen>
</iframe>
```

@g

...yep, success! YouTube videos are now attractively screen-width, even if that
screen is a tiny mobile phone. Oops, but it's height is squashed. Research
that...

Top-10 answers on the board... survey says!
[Jim Fisher has the answer](https://jameshfisher.com/2017/08/30/how-do-i-make-a-full-width-iframe/)
the answer being use a container div with relative positioning and a 56.25% for
padding top. Go figure! Here's the code for \_layouts/youtubePlayer.html that
works for me in Edge mobile and Chrome desktop (and probably everywhere else
even semi-modern):

```html
<div>
  <div style="position:relative;padding-top:56.25%;">
    <iframe src="https://www.youtube.com/embed/{{ include.id }}" frameborder="0" allowfullscreen
      style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
  </div>
</div>
```

BAM!

## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li></ul>