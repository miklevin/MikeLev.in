---
date: 2022-07-30
title: Fixing Broken Jekyll Rouge Code Color Coding in Github Pages Theme
headline: My Website, MikeLev.in, Re-Connected to Github Pages with Proper Color-Coding
description: I recently changed the theme of my website, MikeLev.in, and had to make some tweaks to get the programming code color-coding working properly. After some research, I found the .css file I needed and made one entry in my style.css file. With these changes, the fancy color-coding is now working on my website.
keywords: Jekyll, Rouge, Code, Color-Coding, Github, Pages, Theme, CSS, Website, MikeLev.in, Hacker, Styles.scss, Imports, Fancy
categories: git, jekyll
permalink: /blog/fixing-broken-jekyll-rouge-code-color-coding-in-github-pages-theme/
layout: post
group: blog
---


A few months ago I severed the connection between this website (MikeLev.in) and
the Github Pages Jekyll default Hacker theme that I started out with. While the
Hacker theme was nice, there were enough little customizations I made that it
no longer made sense to tie the two together. So I went in brute-force and
undid all the scss (Syntactically Awesome Style Sheet) magic that's built into
the default themes like Architect, Cayman, Minima and the others. I was never
much of a Web Development person and it just seems like unnecessary complexity
if your CSS is simple.

However when I replaced the styles.scss with just a plain old .css file, thus
removing all the chained-dependencies, I somehow broke the imports that
color-code programming code like Python, JavaScript and BASH files. I know
enough about HTML/CSS to know that something isn't being loaded, probably a
.css file through an include, so I went on a hunt and discovered that during
the configuration process on the server-side with Ruby, there's a step:

    rougify style github > assets/css/syntax.css

...and when you do this it outputs a file into location. So I could do away
with the whole server-side rendering bit if I just found one of those files on
some other site and grabbed it. I found one
(here)[https://github.com/danielsaidi/website_danielsaidi/blob/master/assets/css/syntax.css]
and just put it in location on my site. Then I added the line that loads into
my:

    ~/github/MikeLev.in/_layouts/default.html

...file. It needs just one line edited in:

    <link rel="stylesheet" href="/assets/css/syntax.css" />

...and that's pretty much it. The fancy color-coding came back, whether I used
Github Pages code fencing style or the embedded Ruby code style. I did have to
make one attritional entry in my normal style.css file. I may have to modify it
if I find too much stuff indented:

```css
.highlight, .highlight .w {
    margin-left: 1em;
}
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/fixing-broken-jekyll-rouge-code-color-coding-in-github-pages-theme/">Fixing Broken Jekyll Rouge Code Color Coding in Github Pages Theme</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/do-you-still-really-need-windows-switching-to-linux-in-2022/">Do You Still Really Need Windows? Switching To Linux in 2022</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li></ul>