---
date: 2022-07-30
title: Knowing what GNU screen you're on with .screenrc
headline: Unlock the Power of GNU Screen with a Custom .screenrc File
description: I'm introducing people to GNU screen and how to make it more usable with a .screenrc file. In this blog post, I'll show you how to add the .screenrc file to your ~/ (home) directory, and explain the settings I include in my .screenrc file, such as changing the default escape sequence, turning off the copyright page, changing the number of scrollback lines, and making navigating and resizing regions easier.
keywords: GNU screen, .screenrc, home directory, escape sequence, copyright page, scrollback lines, shell, environment variable, navigating, resizing regions
categories: 
permalink: /blog/knowing-what-gnu-screen-you-re-on-with-screenrc/
layout: post
---


Now that I'm introducing the nice people to GNU screen, make it a little more
usable with a .screenrc. This file should be put into your ~/ (home) directory
named .screenrc. This is just like .vimrc in that it's an invisible text file
serving as a configuration file in your \*nix home folder.

```bash
# ~/.screenrc
#
# Guy Who Tweaks This File and Adds Foul Language Comments:
#  -- Miles Z. Sterrett <miles.sterrett@gmail.com>
#
# Original Author:         Aaron Schaefer <aaron@elasticdog.com>
# Created:        Sat 05 Aug 2006 06:38:47 PM EDT
#
# Settings used to initialize screen sessions
term screen-256color
# Change default escape sequence from C-a to a backslash
#  escape ``                            # default ^Aa

# Do not display the copyright page
  startup_message off                  # default: on

# Change the number of scrollback lines
  defscrollback 10000                   # default: 100

# Ensure the default shell is the same as the $SHELL environment variable
  shell -$SHELL

# Make navigating between regions easier
  bind s split
  bind j focus down
  bind k focus up

# Make resizing regions easier
  bind = resize =
  bind + resize +1
  bind - resize -1

# Configure status bar at the bottom of the terminal
  hardstatus alwayslastline
  hardstatus string "%{= kb}[ %=%{w}%?%-Lw%?%{C}(%{W}%n*%f %t%?(%u)%?%{C})%{w}%?%+Lw%?%?%= %{b}][%{C} %Y.%m.%d %{W}%0c %{b}]"

# Turn off the visual bell
  vbell off

# End of file
```


<div class="post-nav"><div class="post-nav-next"><a href="/blog/sending-emails-with-python-through-smtp">Sending Emails With Python Through SMTP</a><span class="arrow">&nbsp;&rarr;</span></div> &nbsp; <div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/fixing-broken-jekyll-rouge-code-color-coding-in-github-pages-theme">Fixing Broken Jekyll Rouge Code Color Coding in Github Pages Theme</a></div></div>
## Categories

<ul></ul>