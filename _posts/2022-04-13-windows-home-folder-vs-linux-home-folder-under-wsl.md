---
date: 2022-04-13
title: Windows Home Folder vs. Linux Home Folder Under WSL
headline: "Organizing Your Tech-Tools: Strategies for Windows Home Folder and Linux Home Folder Under WSL"
description: As an experienced user of tech-tools, I have established conventions for storing files in my local system and online. I use the 'home' folder of the operating system as my starting point, and I'm also utilizing the Windows Subsystem for Linux (WSL) to access the Linux home folder. I'm currently considering what audience my writing should appeal to, and have identified two primary groups. Read my blog post to learn more about my strategies for organizing and using tech-tools.
keywords: Windows, Home Folder, Linux, WSL, Experienced User, Tech-Tools, Local System, Online, Strategies, Organizing, Mac, Github, Audience, Writing, Groups, Tech-Tools
categories: microsoft, success, audience, linux, mac, wsl, git
permalink: /blog/windows-home-folder-vs-linux-home-folder-under-wsl/
layout: post
---


The #1 priority when getting ready to do anything tech is a starting-point.
You need to get back to where you were. This is surprisingly more difficult
than it may sound. There is where you are putting files in your local system,
and there are usernames and passwords on your Google and Github accounts for
example. It's important to use standard conventions (even if they're personal
ones) and it's important to keep notes (if even just to document your
conventions).

First, an explanation of folders, directories, git repos and Github repos.

- Folders and Directories are the same thing.
- "Repos" are folders or directories where git is being used.
- Things can be a git repo without being uploaded to Github.
- When git is being used, you can optionally keep it on Github.
- Github repos are just git repos kept on Github.
- Keeping a git repo on Github allows collaboration.
- Other sites than Github can be used, such as BitBucket.

The conventions I use are:

- Yield to wherever the OS is trying to make your "home" location
  - This is usually some location like:
    - C:\Users\username\ (On Windows)
    - /Users/username (On Mac)
    - /home/username (On Linux)
- Where there is conflict because of multiple OSes in use, "Host" OS wins
  - These days this is usually due to the Windows Subsystem for Linux (WSL)
    - All locations on Windows are "mapped" into Linux from /mnt/
    - From Linux, Windows "home" is thus accessible as /mnt/c/Users/username
    - From Windows, Linux "home" is like \\wsl$\Ubuntu-20.04\home\username
    - It's eas to make Linux use /mnt/c/Users/username from .bash_profile
    - The old Linux /home/username is still important for configuration files.
      - The most important thing in default Linux home is .ssh folder.
- Put a folder named "github" in your home folder.
  - Put all new projects into sub-folders under username/github/
  - Choose strong nicknames for these sub-folders as that becomes the repo name.
  - Everything can than easily be found quickly.
  - The username/github folder might get long.
    - That's okay.
    - It's better than hunting through different folders.

I'm starting to wonder whether whatsametafor.io is really the best place for
this sort of content. I can sort it out however I like over time. It's actually
not TOO committal.

Okay, think! Next steps? I want one of the sites to be a nice, clean experience
getting started... with Linux, Python, vim & git! Duhhh. Okay.

I've got a bit ol' mission in life now, I guess. Well, it always starts with
helping my child, wife and family. But after that, it's teaching the world
Linux, Python, vim & git in a particular way that helps make you
obsolescence-proof and disruption resistant... a new kind of literacy.

Okay, so... 1, 2, 3... 1?

WHO WILL MY WRITING APPEAL TO?

THOSE WITH A TECH-TOOLS FOCUS

- Those Disenfranchised By "Big Tech"
- Those Who Seek Tech As A Form Of Martial Arts
- Those Wanting Flowing Creative Expression Through Tech
- Anyone Trying To Become "Literate" At Programming
- Those Who Never Want To Be Obsoleted Again

THOSE WITH A DATA OR SEO-FOCUS

- Old SEOs Exploring Life After Excel
- New SEOs Breaking Into The Business

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/always-be-publishing-via-journaling/">Always Be Publishing Via Journaling</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/windows-home-folder-vs-linux-home-folder-under-wsl/">Windows Home Folder vs. Linux Home Folder Under WSL</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/success/'>Success</a></h4></li>
<li><h4><a href='/audience/'>Audience</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/mac/'>Mac</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li></ul>