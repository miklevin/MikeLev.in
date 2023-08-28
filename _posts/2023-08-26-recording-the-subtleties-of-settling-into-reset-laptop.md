---
date: 2023-08-26
title: Recording the Subtleties of Settling Into Reset Laptop
headline: "Settling into my Second Laptop After a Full PC Reset: Recording the Subtleties That Count"
description: This post is about my transition plan from Windows to a Linux Terminal environment for Python programming, and the small setup steps I take to make sure everything runs smoothly. I share my tips for making Linux JuptyerLab hosted on WSL feel like a native Windows app, disabling the Control key for copy/paste in the Microsoft Terminal program, and using Microsoft Edge to install web pages as Apps. I also share my advice for customizing Edge to make it less privacy-intrusive and distracting.
keywords: Windows 10, Linux Terminal, Microsoft Edge, Web Pages, Apps, Python, Programming, ChatBot, SERPs, Videos, Settings, System, Multitasking, App Icons, Taskbar, Small Taskbar Buttons, Personalization, Control Key, Copy/Paste, Microsoft Terminal, Vim, Visual-Block, Selects, Automatically Copy Selection, Clipboard, Launch Mode, Maximized, Startup, Launch Parameters, Bell, Audible, Nbdev, YouTube,
categories: coding, chatbot, linux terminal, vim, python, nbdev, setting, microsoft
permalink: /blog/recording-the-subtleties-of-settling-into-reset-laptop/
layout: post
group: blog
---


This post is about some of the things I do after a full PC Reset back to
Windows 10, always a good idea. But I use Windows as a sort of mainstream host
environment for Linux Terminal. And there are some tiny setup things that have
to be done so vim works well and multitasking is natural. I also take advantage
of Microsoft Edge's ability to install web pages as Apps to make the Linux
JuptyerLab hosted on WSL feel like a native Windows app. This is a very cool
trick. It's a whole transition plan form Windows to a Python programming Linux
Terminal guru who can set up automations to capture ChatBot SERPs videos. Stick
with me!

I have to remember the subtleties that count. As I switch from one laptop to
another because the keyboard over on that laptop isn't as good as this one, I
am reminded that I make a change in Settings under System / Multitasking to
make sure that the `App Icons` in the taskbar are visible on all Virtual
Desktops. That's such a small touch. I also make the icons smaller. It's `Use
small taskbar buttons` under Settings / Personalization / Taskbar.

It's also worth noting if I'm doing this for myself for a later video script or
something, I also disable the use of the Control key for copy/paste in the
Microsoft Terminal program so that I can do vim visual-block selects with
Ctrl+I commands. Hand in hand with that, under Terminal Settings, I select
"Automatically copy selection to clipboard". That way just highlighting any
text in terminal automatically copies it to the clipboard which seems to mostly
make sense, and then you don't need Ctrl+C in vim and it's available for the
far more valuable way of selecting columns of text in vim.

Under Windows Terminal Settings I set Launch mode to Maximized under Startup /
Launch parameters. It's a bit tough to find, but worth it. Also turn off that
dang bell! It's under Settings / Defaults / Advanced / remove checkbox next to
Audible. Be sure to hit save!

This will probably be extracted for some YouTube video or more formalized
version on the MyKoz.AI site. I should label it ***recommended settling in***
steps or something like that. Get rid of as many reasons to hate this setup as
possible. Speaking of which, I should really do `nbdev` now, because once I
take this step with automated Python ChatBot SERPs videos... I need some snappy
name that makes this cool process recognizable.

It's good to use Microsoft Edge due to the way it lets you install websites as
Apps. I could make MyKoz.AI feel just like an app in that way. Wow! Perhaps I
can make it a mobile app simply by keeping it in a similar form as I'm using on
Github Pages. Oh, so it bears mentioning for that video or whatever, a good
thing to do early on is to make the Linux JuptyerLab that runs Linux-flavor
Python locally on your Windows system into something that feels like an App on
your Start Bar. You do that by opening Edge and visiting localhost:8888 and
giving it the `foo` password. Then you go to the 3-dot dropdown, then to Apps/
`Install this site as an app`. Make sure the name is just `JupyterLab` for
prettiness and then on the automatic window that opens up, de-select Pin to
taskbar, but keep selected `Pin to Start`. Then click `Allow`. I like resizing
everything in the Start menu to Small.

Once you decide to stay on Edge, at least part-time, for this cool
Website-as-app ability, there's a bunch you want to do to Edge to make it less
privacy-intruding and distracting. 

If you plan to sign into Edge with a Microsoft account for synchronizing your
bookmarks, do it first so you don't have to re-do a lot of these steps. After
that, be sure to go into your browser privacy settings and turn off everything
that snoops on you that you don't need. For me that's almost everything with
only `Send "Do Not Track" requests` left checked.

Way at the bottom of that screen you'll find `Address bar and search` hidden
away, because it's where you change your default search to Google. While you're
at it, you can turn off Show me site and search suggestions using my typed
characters, unless you don't mind typing your every web-surfing keystroke to
Microsoft. You can also turn off Show me suggestions from history, favorites
and other data on this device. 

After that you can make your browser look a lot more focused:

- Go to the gear and switch to Focused.
- Turn Quick Links to off.
- Turn off Show greeting.
- Turn Content to Content off.
- Click the Privacy Choices graphic.
- Turn off Share my data with third parties for personalized ads

Then in Edge Settings I go to Sidebar and turn off Always show sidebar. I also
turn off Personalize my top sites in customize sidebar. I also turn off Allow
sidebar apps to show notifications.

Another thing I do is turn dark theme on through Windows Settings /
Personalization / Colors. 

Okay, I'm almost fully settled into my second machine. Bopping back and forth
between different laptops and still doing all your stuff comfortably on each
including having latest state of everything (synced) through git and scripts is
a good goal. It won't start out that way, but as the machines get in parity and
your scripts get refined, it's very worthwhile. Not being dependent on any
particular hardware is a good thing.














<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/skipping-the-web-frameworks-for-a-more-fundamental-approach-to-dev/">Skipping The Web Frameworks For a More Fundamental Approach to Dev</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/refining-the-mykoz-ai-vision-in-prep-for-soft-launch/">Refining the MyKoz.AI Vision in Prep for Soft Launch</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/coding/'>Coding</a></h4></li>
<li><h4><a href='/chatbot/'>Chatbot</a></h4></li>
<li><h4><a href='/linux-terminal/'>Linux Terminal</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/setting/'>Settings</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>