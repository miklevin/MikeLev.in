---
date: 2023-08-10
title: The Bare Minimum Styles CSS File
headline: Introducing CSS to MyKoz.AI with the Bare Minimum Styles CSS File
description: Learn how to create a simple and effective CSS file to assert control over your website. Follow the steps outlined in this article to create a bare minimum styles.css file and link it to default.html. Get tips on how to ensure your changes are rendered correctly. Follow the MyKoz.AI site development!
keywords: CSS, San-serif, Framework, Custom, Static Site Generator, Jekyll, Github Pages, Index.md, Default.html, _config.yml, Styles.css, HTML, HEAD, BODY, Font-family, Helvetica Neue, Helvetica, Arial, Sans-serif, Web Browser, Inspector, DevTools, Network, CSS Build, Rabbit Hole, Vim, Git, Push, Render
categories: vim, jekyll, html, static site generator, network, git
permalink: /blog/the-bare-minimum-styles-css-file/
layout: post
group: blog
---


Did I mention baby-steps yet? Well, it's not going to look like a real site yet
with this step. I'm going to introduce CSS to the picture and change the serif
font to a san-serif font as a modest first step, and one that asserts control.

One thing I will not be doing with this MyKoz.AI endeavor is coding myself into
a corner. That can happen by choosing a fancy framework or even just
over-coding your own custom stuff that becomes its own technical liability over
time. No, I'm keeping all the files that constitute this site as simple as
possible, and I'm going to be using the most basic of tools to create it.

Already, I've got just about as stripped-down of a site as is possible to have
under the Github Pages Jekyll static site generator. I've gone one `index.md`
and one `_layouts/default.html` file. The `_config.yml` file is still the
auto-generated one that I got from the first `git pull` of the repo. And I
don't even have a `styles.css` file yet. But the site is published, and I
didn't even need to make an explicit connection between index.md and
default.html. The Jekyll engine just knows to use it. 

And thus we've stripped out all the other default html view-source bloat you
get without having your own default.html file present. And so default.html
works as a sort of filter against the default. There's still a wee bit of
opinion slipped in, like the h1 tag getting a class attribute I didn't ask for,
but at least it's chosen from my own naming convention and not something
arbitrary from Jekyll.

My command-line Linux Terminal is currently is in the `_layouts` directory, so
I `cd ..` to go up one level and `mkdir css` to make a directory for my
`styles.css` file. Then I `cd css` to go into that directory and `vim
styles.css`. Whoah... what to do next?

We stand at the precipice of a very deep rabbit hole. I will avoid sharing with
you the full CSS build that we will do here, minimal it may be. Suffice to say
our first priority is to assert control. And if you haven't already done so,
you need one of your web browsers set up so that it's ***inspector*** is set so
that it never caches. Otherwise, you'll never see changes you make to CSS.
Typically, you hit `Ctrl+Shift+I` then click the little Gear, then check
`Disable cache (while DevTools is open)` under the Network section. Save
yourself worlds of frustration.

To keep things as simple as possible and just to assert control over our CSS,
we will apply a font-family to the body tag. It's the first element where that
attribute makes semantic sense. You'll never see a font display on the HTML or
HEAD elements, but you will on the BODY. So we put this in our `styles.css`...

```css
body {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}
```

The reasoning here is that these are the most supported fonts in the world, and
they are different from the default ***serif*** font of most web browsers, so
by implementing it, we will at least see a change and ***assert control*** the
next time we render (git push) the site. And from there, we can build. First
assert control, then build.

So we exit out of vim and `git add styles.css` which we don't need a path for
because we're still cd'd into the css directory. But now we need to link our
website to that css file, and for that we need to load the default.html file
into vim. So we `cd ../_layouts` to go up one level and `vim default.html` and
edit in the link element that calls the css file...

```html
<html>
<head>
<title>MyKoz.AI</title>
<link rel="stylesheet" href="/css/styles.css">
</head>
<body>
{% raw %}{{ content }}{% endraw %}
</body>
</html>
```

Now we can do a `git commit -am "Added styles.css and linked it to
default.html."` and `git push`. Wait and watch the site render.

Bingo!

![The Bare Minimum Styles CSS File](/assets/images/the-bare-minimum-styles-css-file.png)











<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/the-bare-minimum-styles-css-file/">The Bare Minimum Styles CSS File</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/focusing-the-1-2-3-punch-of-mykoz-ai-linux-python-neovim/">Focusing the 1, 2, 3 Punch of MyKoz.AI (Linux, Python, NeoVim)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/static-site-generator/'>Static Site Generator</a></h4></li>
<li><h4><a href='/network/'>Network</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li></ul>