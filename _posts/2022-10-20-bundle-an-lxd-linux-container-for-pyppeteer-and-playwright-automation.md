---
date: 2022-10-20
title: Bundle an LXD Linux Container for Pyppeteer and Playwright Automation
headline: Exploring Automation Possibilities with LXD 2 WSL, Selenium, NodeJS, and Pyppeteer
description: I'm creating a public repository to limit my dependencies and use ohawf for Google OAuth2 authentication. I'm using the LXD 2 WSL project and Chrome automation with Selenium and NodeJS Puppeteer and Pyppeteer libraries to control Google Chrome or Chromium. Join me as I explore the possibilities of this project!
keywords: LXD, Linux, Container, Pyppeteer, Playwright, Automation, Public Repository, Dependencies, ohawf, Google OAuth2, Authentication, WSL, Windows, Chrome, Selenium, NodeJS, Puppeteer, Chromium, Explore, Possibilities, JavaScript, Python
categories: container, dependency, linux, wsl, python, microsoft playwright, microsoft, javascript
permalink: /blog/bundle-an-lxd-linux-container-for-pyppeteer-and-playwright-automation/
layout: post
---


Alright. For fear of stalling out, I'm going to functionally recreate one of my
great deliverables but re-imagining it for a public repo. In the past I've made
fairly heavy usage of my pip installable pipulate or mlseo libraries for my
work, but I even just these light dependencies are too burdensome. At most I
want to limit myself to ohawf now for Google OAuth2 authentication.

Now that I have the LXD 2 WSL project working and tested on Windows 10 and 11,
it makes the most sense to start other projects from there. Make it so that you
don't have a lot to figure out because it's all baked into the server-build
script. The server-build scripts poses a lot of the intelligence of an
endeavor. Tool well now. Do well forever.

Let's talk abut Chrome automation for a moment. For the longest time the
Selenium library was the main thing for browser automation. There were a few
other weird ones like PhantomJS. There's a mostly proprietary tech called RPA
for "robotic process automation" like Microsoft's Power Automate, IFTTT and
Automation Anywhere. But these are all expensive and proprietary. There was a
lot of uncertainty.

Everything changed when Google released the JavaScript NodeJS puppeteer library
for controlling Google Chrome, or more accurately the free and open source
version of Chrome called Chromium. It could however be connected to either
Chrome or Microsoft Edge very easily and rapidly started displacing Selenium
for new automation-work.

But I hate JavaScript, and happily so do enough others that a wonderful tool
like Puppeteer doesn't stay JavaScript-exclusive for long. Pyppeteer was
written as a Python "wrapper" for the Puppeteer library and as it happened it
worked quite well from Juptyer Notebooks, and so this became my preferred
browser automation technique for a few years.

Now Pyppeteer was never really official Python support for Puppeteer, and if
that weren't bad enough, it suffered a double-whammy when Microsoft hired away
the two top contributors to to the Puppeteer project and put them to work on
Microsoft's own alternative browser automation platform called Playwright. And
so the wind was taken out of the sails of the official Google's package
Puppeteer at the same time the unofficial port to Python stalled out and
indecisively schismed.

Hmm, to make Playwright work on LXD2WSL I should make the pip installs happen
before the apt installs, because in the apt install phase I can execute
arbitrary commands, of which playwright install and puppeteer-install should
both be a part.

And one of the very first things folks should be exposed to after an lxd2wsl
server build is the sort of stuff they can't very easily do either in the cloud
nor with a native Windows desktop jupyter approach.

This is inching very close to a "canned" SEO product and launching-off point
for unlimited baked-in sub-projects.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/still-figuring-out-next-step-what-i-want-at-52/">Still Figuring Out Next Step & What I Want at 52</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/getting-my-local-24x7-place-to-run-code/">Getting My Local 24x7 Place to Run Code</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/dependency/'>Dependency</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li></ul>