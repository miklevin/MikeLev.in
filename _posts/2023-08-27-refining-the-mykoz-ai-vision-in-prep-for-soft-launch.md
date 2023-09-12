---
date: 2023-08-27
title: Refining the MyKoz.AI Vision in Prep for Soft Launch
headline: I'm Refining MyKoz.AI Vision for Soft Launch on my Birthday!
description: I plan to soft-launch MyKoz.AI today, a platform to help you stay relevant in the tech world. Learn and use Linux, Python, vim & git (LPvg) to make the most of your skills. Automate browser tasks for SEO and turn Jupyter Notebooks into Linux services. Get ready to rely less on Windows and stay up-to-date with the latest technology.
keywords: Linux, Chrome, Jupyter Notebook, Command-Line, nbdev, License, Manifest, Setup Files, setup.ini, service, repo, pip-installable, packages, coding-adverse, killer app, Linux safety-net, datacenters, AIs, LPvg, messaging, ASCII, intro screens, Windows 10, Pareto Principle, 80/20-Rule, rabbit hole, YAMLChop, Github, @p macro,
categories: microsoft, jupyter, 80/20-rule, python, ai, linux, nbdev, git, lpvg
permalink: /blog/refining-the-mykoz-ai-vision-in-prep-for-soft-launch/
layout: post
group: blog
---


Happy Birthday to Me. It's time to soft-launch MyKoz.AI, today on a sleepy
Sunday. I've worked out the nuances surrounding running browser automations
with a genuine Linux Chrome from the context of both a Linux Jupyter Notebook
and the command-line, meaning a Linux daemon service. I'm doing this all with a
simplified `nbdev` arrangement so that the Notebooks are in the root of the
repo and easily found when MyKoz.AI users run the install script, load Jupyter
and click the `intro` directory. They've gone through enough by then and I
don't want them to have to identify the default nbdev `nbs` folder for
notebooks. Nor do I want all those license, manifest and setup files around. I
can't get away from the `setup.ini` and that's understandable, because it lets
me rename the directory that the `.py` files get exported to to `service` which
makes a lot more sense in this context than the repo name repeated (a
reasonable convention nbdev adopted for pip-installable packages).

So this is some solid serious dot-connecting going on here. I may actually
build something that is all:

- Easy enough for the coding-adverse to understand and be motivated to try.
- Compelling enough of a "killer app" that people will actually want to try.
- Kicks off learning Linux by making them want to move their service.

You're not "moving to Linux" so much as you are making Linux your default
safety-net home. If the other homes (fad-driven platforms) go away, you're
never left homeless.

With LPvg under your belt, you'll never be left technologically homeless. What
would boot-up the datacenters and AIs?

Okay, think this through. How close is it? Oh, the messaging is terrible. It's
too long during the install with the 4 ASCII screens. Fix that. Make a way to
skip over the intro screens.

On occasion I will want to test the `mykoz.bat` installation process on a
completely reset PC, but now that I have both my day-to-day machines on Windows
10 and in just about parity for actual productivity (there's big advantage in
that), I'll probably want to rope in other laptops into the "from scratch"
testing steps. But put that to the side for awhile, because that's a rabbit
hole and a violation of Pareto Principle (80/20-Rule) which I really must abide
by now fervently if I'm to make rapid forward progress.

When I really want to test the install script on one of my two working
machines, the thing to do is to delete the repos that would never get replaced
if the repos were already there. This is the proper behavior because I never
want to write over somebody's repo folder if they started do do their own work
in there, especially `journal`. But the new blog `chop.py` file that was once
the YAMLChop repo in Github (but is no more) is tightly integrated with the
journaling process. Bake your dependencies in whenever you can. So if the `@p`
macro kicks-off the publishing process by calling the chop program, I know it
will always be there and found if it's part of the same repo that dropped
`journal.md` (which they're probably editing) into place.

So I'll make a new script to run from the `~/repos/mykoz` cloned repo if the
user (mykoz developer) wants to do a valid install-script run and not hit
gotcha's because it had been installed on that machine before and the installer
protects against accidentally writing over work.

Therefore an actual very important point here is to perform a git commit and
push of a latest and greatest and what people are supposed to see snapshot of
each of the important repos:

- intro
- journal
- webdev
- yourservice

This should all be a very carefully controlled experience. When you update the
messaging get rid of all the Marcus Aurelius tow-it-ism stuff. Some people
might like it, but mention it once at most. Get right to the point. Reach out
to the pragmatists who have a timer in their hand for how long it takes to
seize and hold their attention. So, seize and hold their attention faster.

How? The installer! You do the ***War Games*** typing effect early on to great
effect. And they're going to see it again during the install for the Python,
apt and pip stuff. So don't over-do it near the beginning. What is the LEAST
they need to know? And what is most enticing? Benefits up-front. Almost no
background. Go straight to value-proposition. Cialdini!

If you're looking for something that's both truly unique and entertaining,
which could also help you improve your life by giving you forever-skills that
can work as an anchor of stability in these times of great change, well then
you just might have found it. Read on.

- Feeling overwhelmed by the pace of change?
- Interested in future-proofing your skills?
- Stay relevant with fundamental tech tools!
- Linux, Python, vim & git (LPvg) can do it.

- Expose yourself to Linux by using Windows.
- Learn vim by journaling in 1-file for life.
- Optionally, use that as a blogging system.
- Automate and record browser-tasks for SEO.

- Handle Google login issues for automation.
- Turn Jupyter Notebooks into Linux services.
- Use Linux services to email data, and more.
- In time rely less on Windows as Linux host.

As platforms and technology goes in and out of style, you continue to stay
relevant by knowing the fundamental principles of textfile control that can't
be interrupted with API-churn, nor gutted out of the field of tech itself.

Okay, this is heady stuff. Let's get this post out there and plan the next.

- What's most broken? (weakest link in the chain analysis)
- Where's the biggest bang for the buck?
- What plates need spinning?



<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/recording-the-subtleties-of-settling-into-reset-laptop/">Recording the Subtleties of Settling Into Reset Laptop</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/google-sge-bing-conversational-search-video-capture-automation/">Google SGE & Bing Conversational Search Video Capture Automation</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/80-20-rule/'>80/20-Rule</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/lpvg/'>LPvg</a></h4></li></ul>