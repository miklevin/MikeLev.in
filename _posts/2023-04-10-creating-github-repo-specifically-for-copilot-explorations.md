---
date: 2023-04-10
title: Creating Github Repo Specifically For Copilot Explorations
headline: Exploring the Attributes of Individual Items with Instapaper, YouTube, Twitter, and Github
description: I have updated my Github repo and am now creating one specifically for Copilot explorations. I have created files such APIs as Instapaper to list Bookmarks, Twitter to list Tweets, YouTube to list Videos, and Github to list Repos. I am using various tools to express myself by transforming the output of theses systems into Web content, using AI to coach me. Learn how I'm using Instapaper, YouTube, Twitter, and Github with AI to explore.
keywords: Github, Repo, Copilot, Explorations, Instapaper, List, Bookmarks, Twitter, Tweets, YouTube, Videos, Tools, Express, Attributes, Individual, Items, Fill-in, Descriptions, Articles, README.md, News, Following
categories: copilot, twitter, youtube, github
permalink: /blog/creating-github-repo-specifically-for-copilot-explorations/
layout: post
---


Okay, it's Monday morning not even 8:00 AM yet. The kid's still here and I need
to drop them off around 11:00 AM. If I have anything I want on the Content &
SME meeting, send it over now. Have there been any updates on the SEO front,
especially with the evolution of Bing & Bard? Not not really last week. Those
tiny constant tweaks that have been occurring on Bing have slowed down and Bard
has not done anything new nearly as interesting as starting to give out
citation links like I noticed last week.

My machine has too many things open. Go closing things down to just your
traditional first three screens... okay, done. Now document the fact that that
guy from Microsoft who works on WSL started to reach out to me on my YouTube
systemdon't video, but then he deleted his comment. I don't know if it's
because in afterthought he didn't want to be associated with a Microsoft
bad-mouther or whether his advice really didn't apply in my case after he
watched the video further because I did try both things he suggested.

Who was that guy? Oh yeah, Program Manager at @Microsoft, working on the
Windows Subsystem for Linux #WSL #WSL2.

![Craig Loewen Microsoft WSL Program Manager](/assets/images/Craig-Loewen-Microsoft-WSL-Program-Manager.PNG)

He suggests:

- Setting vmIdleTimout to a much larger number in .wslconfig (location
  %USERPROFILE%\.wslconfig)
- Use tmux to detach with a live background process, but I already do this
  through GNU screen with a forked systemd process.

Maybe he saw that I tried these things when he looked closer and took down his
comment so as not to engage with me or look foolish. Anyway, it's worth me
trying the vmIdleTimeout setting again and this time with a larger setting. It
has been awhile since I tried and getting JuptyerLab server hosted WSL
Linux-side to not timeout whenever the last Linux Shell is closed would be a
big improvement to the DrinkMe script and Pipulate Free and Open Source SEO
product.

Given these new AI superpowers that were slapped on me with Copilot, what
should I pick to do next? Something for work for sure.

Oh yeah, make a bit of a splash getting things onto the new Content & SME
meeting with the articles and Jupyter Notebooks you did last week. List them
here first. Be proud!

- [Introduction to the concept of APIs](https://mikelev.in/blog/moz-links-api-an-introduction/)
- [Walking through the Moz Links API Documentation](https://github.com/miklevin/moz/blob/main/nbs/10_links_api.ipynb)

Those are really the 2 main things. I have plenty more in mind and even
underway already, however I should update the MOZ readme to reflect these two
things.

Okay, done. I updated the readme on my [MOZ repo on Github](https://github.com/miklevin/moz)
And for my next trick?

I want to try to use Copilot fresh in a repo for explorations. It should be
completely separate from Jupyter Notebooks which currently don't support
Copilot. This guy is exploring Copilot in interesting ways.

- [co-pilot internals](https://thakkarparth007.github.io/copilot-explorer/posts/copilot-internals)
- [co-pilot explorer](https://thakkarparth007.github.io/copilot-explorer/)

Avoid rabbit holes. Flesh out some 80/20-rule approaches to getting the most
out of Copilot. Ugh, put VSCode back on your machine. List these things:

- Put VSCode back on your machine
- [Make a new Github repo for copilot explorations](https://github.com/miklevin/copilot)

Okay, I've changed the instapaper example to being listing bookmarks instead of
adding them. And because so many of my things have a service_list_element
flavor to them in order to blend those listings into this site here, I've made
an immediately obvious file-naming convention for my new github copilot repo:

- instapaper_list_bookmarks.py
- twitter_list_tweets.py
- youtube_list_videos.py
- github_list_repos.py

The idea here is to extend the reach of the stuff I do anyway, and now that I
can list them and explore the attributes of individual items, I can do more
with them. Namely, I can fill-in descriptions on my YouTube videos the way I
did on my blog posts. I can construct articles out of my tweets. I can add
README.md's to my Github repos. With Instapaper, I can just expose those items
from the news I've been following.



## Categories

<ul>
<li><h4><a href='/copilot/'>Copilot</a></h4></li>
<li><h4><a href='/twitter/'>Twitter</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li>
<li><h4><a href='/github/'>Github</a></h4></li></ul>