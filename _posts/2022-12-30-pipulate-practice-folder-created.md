---
date: 2022-12-30
title: Pipulate Practice Folder Created
permalink: /blog/pipulate-practice-folder-created/
headline: Exploring AI Editing & Best Practices for the Pipulate Project
description: I'm pushing myself to take the next steps in the Pipulate project, focusing on collaboration and best practices. I'm exploring ideas to use AI to edit my YouTube videos, setting up the Pipulate repo and practice folder, and activating scheduling under a systemd service. I'm using nbdev version 2 and OhAwf with the addition of the run_console feature. All the necessary software can be found on the Pipulate Software page. Come explore the possibilities with me!
keywords: Pipulate, Practice, Folder, Collaboration, Best Practices, AI, YouTube, Repo, Scheduling, Systemd, Service, nbdev, Version 2, OhAwf, Run_Console, Software
categories: youtube, systemd, ai, pipulate, collaboration, nbdev, service
layout: post
---

Think through next steps.

Push yourself relentlessly forward on the Pipulate front. What makes the
Pipulate site better is also what makes you better at work. You COULD tackle
this project with the WebDev approach, but then you'd be focusing on all the
wrong things.

It's amazing how much more of the broadly applicable,field-spanning, decades
spanning tools, tips and tricks you can cram in you're head if you're not using
up all that room in the next JavaScript web framework du jour.

Can someone become successful on YouTube without pandering to the slick? Can
you just be yourself and life-cast (not necessarily live-cast) and let the AI
editors sort it out over time?

There's a business idea for you. AI will edit all your YouTube videos together
and post onto a different channel with the optimized for busy-viewer
experience. AI TLDW versions! Perfect for TicTok-like short form videos for
starters, but then could provide much improved long-form versions too, cutting
out the fat.

I'm probably pushing myself towards that sort of thing as ext generation SEO.
In the meanwhile, I've got to get everything best-practice-like about what I do
today (or should be doing) on Pipulate. Every challenge o face day-to-day is an
opportunity to improve the Pipulate site.

And this "hidden" blog is where I do it. With Google disincentivizing content
aggregators as they seem to be now, the value of wholly unique content is
skyrocketing. Being genuinely unique is becoming easier to recognize and more
possible to reward.

I am aligning myself for those rewards.

Focus on collaboration. It's all about collaboration at this point.

So you'd think with Jupyter Notebooks and collaboration, you'd think Google
Colab, right? Or Microsoft Azure Notebooks or Binder. There's like a dozen
other approaches.

Let's get the Pipulate repo under the DrinkMe install in order.

Also make a practice directory where I actually do practice in public. Keep
authentication and client names out of it, but just load it from config files
which are kept safe through .gitignore files.

1, 2, 3... 1?

Every single time you stop and struggle for something you need to know, jump on
it!

Wow, okay I just updated Pipulate to have a pipulate and practice folder.
Nothing in there yet, but that's the beachhead, really.

Things should be bore nbdev-enabled right out of the starting gate. That's been
a missing element for the past few months.

Okay, so let's nbdev pipulate! I did it before and I can do it again. So it's
no longer nbdev init. So I cd into pipulate and:

    [py311] ubuntu@LunderVand:~/repos/pipulate (main) $ nbdev_new
    /home/ubuntu/py311/lib/python3.11/site-packages/ghapi/core.py:101: UserWarning: Neither GITHUB_TOKEN nor GITHUB_JWT_TOKEN found: running as unauthenticated
      else: warn('Neither GITHUB_TOKEN nor GITHUB_JWT_TOKEN found: running as unauthenticated')
    repo = pipulate # Automatically inferred from git
    branch = main # Automatically inferred from git
    user = miklevin # Automatically inferred from git
    author = Mike Levin # Automatically inferred from git
    author_email = miklevin@gmail.com # Automatically inferred from git
    description = Rebooting Pipulate Free & Open Source SEO Software Project # Automatically inferred from git
    settings.ini created.
    /bin/sh: 1: quarto: not found
    [py311] ubuntu@LunderVand:~/repos/pipulate (main) $

Okay, I also updated ohawf to support a cli=True argument just in case it still
has to operate in flow.run_console() instead of flow.run_local_server() mode,
which is now the preferred method, but not always available.

Okay... think. Next step? Some practice files inside the practice folder. The
pipulate folder should actually be the scheduling folder! YES! Activate
scheduling under a systemd service. I can do much of this tonight. It's
becoming easy and casual.

Big day.

The Pipulate practice folder exists, and I'm beginning to populate it with
everything found on the https://pipulate/software/ page.

I'm using nbdev again (version 2). It's back in use on ohawf.

OhAwf now supports run_console


## Categories

<ul>
<li><h4><a href='/youtube/'>YouTube</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/collaboration/'>Collaboration</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/service/'>Service</a></h4></li></ul>