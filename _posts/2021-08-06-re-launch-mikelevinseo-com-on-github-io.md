---
date: 2021-08-06
title: (Re)Launch MikeLevinSEO.com on Github.io
headline: Relaunching My Blog/Journal on Github.io - Join Me on This Journey!
description: I'm excited to announce the relaunch of my blog/journal on Github.io! After finding the DNS, deleting records, and setting up the Github repository, I enabled Github Pages, added the domain to Github settings, and customized the template. To top it off, I added Google Analytics and Search Console tracking. Come check out my new blog and join me on this journey!
keywords: Github.io, DNS, ANAME, CNAME, Github Pages, Domain, Google Analytics, Search Console, Relaunch, Blog, Journal, Template, Customize, Tracking, Journey
categories: google analytics, template, journey, github pages
permalink: /blog/re-launch-mikelevinseo-com-on-github-io/
layout: post
---


I liked the way things were proceeding yesterday. I made a good start and then
it was aborted. Is that an okay word to use anymore? Just like adopted.
Everyone takes something personal and those are two loaded words. But the fact
remains, I'm getting into it again today. And this is in fact how I'll publish
my "book". I should probably just call it a blog to alleviate the
out-of-proportion expectations on myself. I hate the word blog. It's a journal.
So where was I? Ah, this itself is an important point. The journal provides a
steadiness and continuity of thought. You CAN pick up were you left off.

This is sort of a smoking bullet situation. THIS is where distraction sneaks
in, keeping me from being productive. New stuff. Discovery. Committing to
decisions, actions and follow-through. 1, 2, 3... 1? Find DNS for
mikelevinseo.com in GoDaddy... done.

Okay, delete all the ANAME and CNAME records on mikelevinseo.com. Keep only the
NS and SOA (start of authority) entries... done.

Okay, now find that article on how to make multiple registered domains resolve
to github.io under one Github account... okay done https://deanattali.com/blog/multiple-github-pages-domains/

Okay now make a new github repository that's going to contain the static
markdown pages for this new blog/journal site... okay, done. Love having these
skills. Almost second nature now.

Okay we now turn on the Github github.io features. It's got a new tab of its
own called Pages. We tell it which branch to use. We tell it to enforce https.

There are 4 A records for Github's nameservers. However the actual resolution
of the site's name is a bit of a mystery. I don't want www. I want it to be
hosted on the "naked" apex domain (registered domain). And so I look in the
Github settings again... yep, you just enter it in Github settings. Woot!

It published README.md as the github.io homepage. Look into that later. But for
now just start putting these journal entries starting with yesterday and today
up there.

Okay, that's done. But a final last touch or two. Namely that annoying "View on
Github" badge is showing in the template. Ugh! I don't even want to go through
this customization process again. I already did this work for
tictacufosightings.com, the prior site I used github.io for.

Okay, that's done. Also added Google Analytics and Search Console tracking.
That's it for now. I've got the pattern down for slamming out new websites. It
goes something like this:

- Create a new Github repo.
- Use Github settings to say it's a github.io site.
- Pick a registered domain and add the 4 ANAME records for DNS.
- Add the registered domain to the repo's Github settings.
- Use layouts/default.html to customize template and add GA code.

<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/re-launch-mikelevinseo-com-on-github-io">(Re)Launch MikeLevinSEO.com on Github.io</a></div> &nbsp; <div class="post-nav-next"><span class="arrow">&nbsp;</span></div></div>
## Categories

<ul>
<li><h4><a href='/google-analytics/'>Google Analytics</a></h4></li>
<li><h4><a href='/template/'>Template</a></h4></li>
<li><h4><a href='/journey/'>Journey</a></h4></li>
<li><h4><a href='/github-pages/'>Github Pages</a></h4></li></ul>