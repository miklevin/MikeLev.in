---
date: 2023-08-10
title: Jekyll Minimum Layout Default HTML Stripped Down for Github Pages
headline: I Just Stripped Down the Default HTML for My Github Pages Site Launch!
description: Learn how to create a small static website with Jekyll and Github Pages. I'm taking a minimalist approach, stripping away the unnecessary JavaScript and CSS frameworks and coding up a styles.css file by hand. I'm also documenting the process, so you can follow along and launch your own site.
keywords: Jekyll, Minimum, Layout, Default, HTML, Stripped, Down, Github, Pages, JavaScript, CSS, Framework, Buy-in, Spiritual, Opinionated, Fads, Platform, Wars, Styles.css, Markdown, Static, Site, Generators, SSG's, Text, Editing, Power, Web, Publishing, DNS, Twitch, YouTube, Live-stream, 80/20-Rule, Strength, Couch, Potato, Format, AI, Automation,
categories: git, youtube, html, javascript, 80/20-rule, ai, jekyll
permalink: /blog/jekyll-minimum-layout-default-html-stripped-down-for-github-pages/
layout: post
group: blog
---


Now for the part of the site-launch that I hate. Not another JavaScript/CSS
Framework! Ugh! How many times have I researched this only to put it aside as
***not worth it***. Nearly everything you find requires an ***almost
spiritual*** buy-in and commitment to the framework. It's all so opinionated
and subject to changes based on fads and platform wars. I'm not going to do
that. I'm going to do the most boring, least sexy thing possible.

CSS is a solved problem. You don't need sass and all this fancy post-processing
tech, which although it seems very much in-tune with the spirit of static site
generators (SSG's) like Jekyll, they're just not worth it for the benefit if
you're just making a small site with the least moving parts possible. No, it's
better to just make a styles.css file and code it up by hand. It gets called
form the HTML file, and that's what this particular post will be about.

I really thought I would be using Twitch or at least YouTube to live-stream
this process, but that would be a violation of the 80/20-rule. My strength lies
in text editing, where all the power is at along these lines of web publishing,
at least a site that's not ***under*** somebody else's service (beyond DNS).
It's taking a lot to let go of this hobbling inhibition by which I feel I won't
***reach*** people if I don't put it in a couch potato format. But if I plan on
using AI to automate the creation of the videos, then I'm freed to focus on the
creation of the site, just documenting it here in text that will work as the
script for the video.

Okay, so onto the CSS. But before even CSS, let's convert our bare minimum HTML
into bare minimum Markdown, which is what Jekyll uses. I should just be able to
replace the .html extension with .md and change the html in the file to markdown
and it should work:

```
git mv index.html index.md
vim index.md
```

Then I change the contents of the file to:

    ---
    title: MyKoz.AI
    ---

    # MyKoz.AI

Then I git commit & push... watching at the https://github.com/miklevin/mysite/settings/pages
url... and there it is!

![Bare Minimum Markdown Site Launch Github Pages](/assets/images/bare-minimum-markdown-site-launch-github-pages.png)

And if you look at the `view-source` source code, you'll see how amazingly big
Github bloats this out to:

```html
<!DOCTYPE html>
<html lang="en-US">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Begin Jekyll SEO tag v2.8.0 -->
<title>MyKoz.AI | mysite</title>
<meta name="generator" content="Jekyll v3.9.3" />
<meta property="og:title" content="MyKoz.AI" />
<meta property="og:locale" content="en_US" />
<link rel="canonical" href="https://mykoz.ai/" />
<meta property="og:url" content="https://mykoz.ai/" />
<meta property="og:site_name" content="mysite" />
<meta property="og:type" content="website" />
<meta name="twitter:card" content="summary" />
<meta property="twitter:title" content="MyKoz.AI" />
<script type="application/ld+json">
{"@context":"https://schema.org","@type":"WebSite","headline":"MyKoz.AI","name":"mysite","url":"https://mykoz.ai/"}</script>
<!-- End Jekyll SEO tag -->

    <link rel="stylesheet" href="/assets/css/style.css?v=9f6433fbbc38ae36404e0902fe6b117f79c2493b">
    <!-- start custom head snippets, customize with your own _includes/head-custom.html file -->

<!-- Setup Google Analytics -->



<!-- You can set your favicon here -->
<!-- link rel="shortcut icon" type="image/x-icon" href="/favicon.ico" -->

<!-- end custom head snippets -->

  </head>
  <body>
    <div class="container-lg px-3 my-5 markdown-body">
      
      <h1><a href="https://mykoz.ai/">mysite</a></h1>
      

      <h1 id="mykozai">MyKoz.AI</h1>


      
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/anchor-js/4.1.0/anchor.min.js" integrity="sha256-lZaRhKri35AyJSypXXs4o6OPFTbTmUoltBbDCbdzegg=" crossorigin="anonymous"></script>
    <script>anchors.add();</script>
  </body>
</html>
```

Yuck! That can not stand. While it's good for reference, like maybe I'll like
to put the Facebook Open Graph tags back in when I'm up to that step, having
this bloat right out of the starting gate is unacceptable. We've got some
wrangling to do. Before we even talk about the `_config.yml` file, I do the
following:

```bash
mkdir _layouts
cd _layouts
vim default.html
```

Then I put this in the file:

```html
<html>
<head>
<title>MyKoz.AI</title>
</head>
<body>
{% raw %}{{ content }}{% endraw %}
</body>
</html>
```

Then I git add, commit & push... and here's what it looks like now:

![Jekyll Minimum Layout Default Html Stripped Down Github Pages](/assets/images/jekyll-minimum-layout-default-html-stripped-down-github-pages.png)

And when you view the source, it's much better:

```html

<html>
<head>
<title>MyKoz.AI</title>
</head>
<body>
<h1 id="mykozai">MyKoz.AI</h1>

</body>
</html>
```

Now we can start building up from there with the `_config.yml` file and
`/assets/css/style.css` file to make it look like a real site.














<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/from-registered-domain-to-bare-minimum-site-100-free-from-scratch-in-1-hour/">From Registered Domain to Bare Minimum Site 100% Free & From Scratch in 1 Hour</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-bare-minimum-styles-css-file/">The Bare Minimum Styles CSS File</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li>
<li><h4><a href='/80-20-rule/'>80/20-Rule</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li></ul>