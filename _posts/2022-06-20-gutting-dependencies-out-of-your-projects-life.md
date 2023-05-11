---
date: 2022-06-20
title: Gutting Dependencies Out Of Your Projects & Life
headline: "Juneteenth: My Journey to Becoming a Better Coder"
description: Today, I'm using Juneteenth as a day off from work to get some stuff done. I'm severing the dependency on Github Pages templates from my Jekyll static site generator and gradually getting better at coding. After making changes to the CSS file and deleting an import line, I inspected the cached CSS and transposed bits I wanted to keep. After publishing the page, the background turned white and the text and links were a more traditional color.
keywords: Juneteenth, Dependencies, Projects, Life, Static Site Generator, Coding, CSS, Import Line, Cached CSS, White Background, Traditional Color, Journey, Github Pages, Config File, SCSS, Code, Publish
categories: jekyll, dependency, coding, static site generator, publish
permalink: /blog/gutting-dependencies-out-of-your-projects-life/
layout: post
---


Gradually get better at everything. Every little thing gets done. ELTgd. And it
felt good. Good God, it feels good to get every little thing done. This is my
poetry. The poetry of life in this awkward material world where everything is
difficult, the likelihood of your existence is mind bogglingly improbable, and
that's just your starting point. Let's see... every little thing.

Today's Juneteenth and that's a day off from work. Nice! Get some stuff done
that you normally wouldn't. Of course there's packing for the move, but that
will happen sooner or later per desperation. Get stuff done that takes that
special inspired energy that only mornings like this can provide.

Jekyll static site generator stuff. What's most broken?

Dependency on Github Pages templates. Sever that connection. On which site?
This one, of course! Sever the connection. Generate the site and be ready to go
back in a pinch. What creates the connection? It's a selection in Github Pages
settings that writes into your \_config.yml file. There are also sometimes
plugins connected to that theme which would also need to be removed.

Okay, I just removed the 2 lines in the config file that set the theme and
plugin. I committed and pushed the change. Be ready to go look at the site now.
This is going to be an interesting process, and very symbolic. Cut out
dependencies.

Okay, watch for errors in your email. Yep. They're much more informative than
they used to be. It reads:

    ---------- Forwarded message ---------
    From: GitHub <support@github.com>
    Date: Mon, Jun 20, 2022 at 8:14 AM
    Subject: [miklevin/MikeLev.in] Page build failure
    To: Mike Levin gets you onto Linux, Python, vim & git!


    The page build failed for the `main` branch with the following error:

    Your SCSS file `assets/css/style.scss` has an error on line 1: File to import
    not found or unreadable: jekyll-theme-hacker. Load path:
    /hoosegow/.bundle/ruby/2.7.0/gems/jekyll-theme-primer-0.6.0/_sass. For more
    information, see
    https://docs.github.com/github/working-with-github-pages/troubleshooting-jekyll-build-errors-for-github-pages-sites#invalid-sass-or-scss.

    For information on troubleshooting Jekyll see:

      https://docs.github.com/articles/troubleshooting-jekyll-builds

    If you have any questions you can submit a request at
    https://support.github.com/contact?tags=dotcom-pages&repo_id=395107155&page_build_id=351029098

That css file it's referring to currently reads like this:

    @import 'jekyll-theme-hacker';

    .container {
        max-width: initial;
    }
    body {
        font-family: medium-content-sans-serif-font, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        line-height: initial;
        font-size: 125%;
        text-rendering: optimizeLegibility;
        -webkit-font-smoothing: antialiased;
        margin: 1%;
    }
    #main_content h1 {
        font-size: 1.6em;
    }
    #main_content h2 {
        font-size: 1.4em;
        margin-top: .5em;
    }
    #main_content h3 {
        font-size: 1.2em;
    }
    #main_content h4 {
        font-size: 1.4em;
    }
    ul li {
        list-style-image: url(/assets/images/green-arrow.png);
    }
    img {
        vertical-align: middle;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }
    header {
        width: 100%;
        font-family: monospace;
        white-space: pre;
        font-size: 1.8vw;
        background: black;
        border-bottom: initial;
        padding: initial;
    }
    nav {
        text-align: center;
        font-size: 1.3em;
        margin-bottom: .5em;
    }
    footer {
        text-align: center;
        font-size: .75em;
    }
    .spacer {
        padding-top: .5em;
        padding-bottom: .5em;
    }
    .post-nav {
        display: flex;
        justify-content: flex-end;
        // justify-content: space-between;
        flex-wrap: wrap;
    }
    .post-nav-prev {
        margin-right: auto;
        // text-align: left;
        padding-top: .5em;
        padding-bottom: .5em;
    }
    .post-nav-next {
        text-align: right;
        padding-top: .5em;
        padding-bottom: .5em;
    }
    .rotate {
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 65vh;
        animation: rotation 8s infinite linear;
        object-fit: cover;
    }
    @keyframes rotation {
        from {
            transform: rotate(0deg);
        }
        to {
            transform: rotate(359deg);
        }
    }

I also deleted some empty frontmatter double-lines so as to not mess up
rendering here. I don't know if the indent would neutralize it. Clearly I need
to delete the line:

    @import 'jekyll-theme-hacker';

Commit and push... wait for email, refresh site. One of the precautions I took
was to bring up the site in a second web browser and pull up the Google
developer interface so I can inspect the cached CSS even after it's gone. I can
then transpose bits I want to keep from the cached version back over into the
css file. I may change it from scss to just plain css.

Bingo! The background turned white.

The text and links, while still in the fonts that I like using, are all a much
more traditional color with unvisited links in blue and visited links in
purple. Oh, a beautiful connection to the past. Keep it this way for a little
bit. No more Github Pages templates, at least on this site.

And without my old content management system pushing stuff from
~/github/helpers/templates out anymore, it won't revert. Woot! Okay, now we're
gutting. Let's keep gutting.

Hit @p to publish ***THIS*** page and see if it looks correct.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/removing-a-package-from-pypi-org-a-pip-installable-app-i-created/">Removing a Package From PyPI.org (a pip installable app I created)</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/qnap-container-station-lxc-end-of-support-notification-move-to-lxd/">Qnap Container Station Lxc End Of Support Notification, Move To Lxd</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/dependency/'>Dependencies</a></h4></li>
<li><h4><a href='/coding/'>Coding</a></h4></li>
<li><h4><a href='/static-site-generator/'>Static Site Generator</a></h4></li>
<li><h4><a href='/publish/'>Publish</a></h4></li></ul>