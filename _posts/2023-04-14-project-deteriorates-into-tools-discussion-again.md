---
date: 2023-04-14
title: Project Deteriorates Into Tools Discussion Again
permalink: /blog/project-deteriorates-into-tools-discussion-again/
headline: "My Experience With MOZ Pro: Trying Out VSCode on WSL"
description: I started a project in MOZ Pro by selecting a domain and downloading the CSV file. I then added 30_data.ipynb to the repo, using the apex domain as part of the filename. After that, I had a list of competitors and I could pull their keywords. I was tempted to try VSCode running as a Linux app on WSL, but the UI was too clunky. I share my experience in this blog post.
keywords: MOZ Pro, CSV file, apex domain, competitors, keywords, VSCode, Linux, WSL, UI, clunky
categories: wsl, vscode, keywords, linux, moz pro
layout: post
---

Let's do a little project in MOZ. We'll start in MOZ Pro with a domain.

I'll go to the Competitive Research / True Competitor:

[https://analytics.moz.com/pro/competitive-research/true-competitor](https://analytics.moz.com/pro/competitive-research/true-competitor)

I download the resulting CSV file.

Do it for a few domains. Make sure the deliverable can apply to any different
site. Okay, so I guess I made the decision, this process begins with the
selection of a site and the pulling down of its true competitors.

Okay, I just added 30_data.ipynb to the moz repo.

The exports from True Competitor don't do anything to differentiate the
filenames. I'm going to use the apex domain as part of the filename, that way
if I automate it I can just append the apex to the end of the filename (but
before the .csv extension).

Okay, I have a list of competitors and I can pull all their keywords. Here's an
issue. I have 138 of 150 queries available until 04/30 so I have to use them
wisely.

Ugh, while I'm doing this I see that I haven't tested everything I want to test
in terms of dev environments to stay on top of. I tried VSCode running actually
as a Linux app on WSL, but the UI is too clunky.

I was able to get VSCode installed on WSL2, but it's not that much better than
the native Linux version. Even though I have the native VSCode interface and
it's back-ended by Linux, it's still VSCode, and I still prefer vim/NeoVim, and
in fact aside from the Copilot feature, I still prefer plain Jupyter Notebooks
over VSCode. Don't lose time on this.

What an interesting awakening and aligning. I will not allow myself to fall
down the VSCode rabbit hole. My special advantage is vim. Vim mode in VSCode is
agonizing. It defeats the purpose of muscle memory. My muscle memory transfer
from vim to NeoVim was almost seamless. The claim that vim mode in VSCode
checks off that checkmark and makes it a viable alternative is a lie.

Copilot will come to Jupyter eventually. While I'm waiting, don't go to VSCode
except insofar as to keep yourself up to date with what's going on in that
world.

Okay, so get a new workflow down. It's irresistible to start out a Notebook, so
continue feeling free to do so.

Yeah, so this blog post started out doing a particular piece of work and
devolved into a general discussion of the workflow. But that's okay. I've got
some new notions to sketch out.

I remain a vim (and now, NeoVim) person. VSCode, despite TWO more opportunities
to win me over, first from a native Linux install (on Windows), and next on a
native Windows 10 install, but connecting to WSL Linux through the WSL2 backend
system. It's quite interesting what it does, the lengths it's going to, to make
it a viable way to edit and run code Linux-side while still in a Windows-side
editor. Wow. Impressive, but still not for me. Such dependency!

I briefly had Copilot envy from Jupyter Notebooks, making me switch both to
NeoVim and VSCode to see what the code-suggestion experience is like and
whether it's something I can't life without. For a little while, I can't live
without it. I'm going to try to get past that because it feels a lot like
training wheels. It should have been called Training Wheels, haha!


## Categories

<ul>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/vscode/'>VSCode</a></h4></li>
<li><h4><a href='/keywords/'>Keywords</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/moz-pro/'>MOZ Pro</a></h4></li></ul>