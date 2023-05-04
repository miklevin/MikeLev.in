---
date: 2023-03-28
title: Marathon Live Streaming Getting Copilot Working in NeoVim
permalink: /blog/marathon-live-streaming-getting-copilot-working-in-neovim/
headline: "Successfully Installing Copilot in NeoVim: My Journey"
description: I successfully got Copilot working in NeoVim by updating the drinkme script, installing vim-plug and the Copilot plug-in from Github, and testing the authentication process. Although I'm done for the night, there are still tests and polish that need to be done. Read about my journey to get Copilot working in NeoVim on my blog.
keywords: Marathon, Live Streaming, Copilot, NeoVim, Drinkme Script, Vim-Plug, Plug-in, Authentication Process, Tests, Polish, Linux, Graphics, Browser
categories: linux, copilot, neovim
layout: post
---

Copilot on NeoVim... got it working! And it's a disjointed experience because I
journal in vim and I'm all tooled up around vim. However, vim and NeoVim are
supposed to be almost indistinguishable. And .vimrc should work in NeoVim.
Let's see if that's true. Green Lantern highlighting will tell me.

## Part 1: The Struggle

{% include youtubePlayer.html id="sPe4MJQ5NXs" %}

## Part 2: Co-Pilot in NeoVim Success

{% include youtubePlayer.html id="rWbAT2YiKdE" %}

## Part 3: Marathon Session Updating Install Script

{% include youtubePlayer.html id="u6V1JK9w__4" %}

I am now typing in NeoVim for my daily journal for the first time.

If I'm happy with this, wrap it into drinkme.

This video is really about the refinement and pairing down of the install
scripts in github.com/miklevin/drinkme.

That script turns your Windows 10 or 11 machine into a Jupyter Linux
Wonderland. But it currently does too much. I want the least possible install
that will:

- Give you a Linux Jupyter (on Windows)
- Give you a Co-Pilot NeoVim on Linux Terminal (on Windows)

Make it easy for me to get back my data drive after running the install.bat

    sudo mount -t drvfs '\\EchidNAS\repos' /home/healus/repos

...and then make it persistent updating the line in my /etc/fstab from:

    \\EchidNAS\data /home/healus/repos drvfs defaults 0 0

to:

    \\EchidNAS\repos /home/healus/repos drvfs defaults 0 0

I have been successful updating drinkme. I can't edit out the whole
requirements.txt file... done. Worked.

I have now added NeoVim to drinkme, but don't have the plugin system activated.

Also remember that I used their script to add the OpenAI plugin after vim-plug
was installed.

This is the plug-in system for NeoVim:
https://github.com/junegunn/vim-plug

This is the command to install the vim-plug on NeoVim:

    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

This is the Github Copilot page:
https://github.com/github/copilot.vim#getting-started

This is the command from that page to install the plug-in:

    git clone https://github.com/github/copilot.vim.git \
      ~/.config/nvim/pack/github/start/copilot.vim

I got it working. The drinkme script is updated. I have to test Copilot
authentication because it's remembering my authentication from my first
success. A browser pops up for the process like OAuth, so I have to make sure
the Linux graphics browser components are installed.

Hmmm. Going to re-activate Chrome. Mostly done for the night, but there's some
tests and polish that still needs to be performed.


## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/copilot/'>Copilot</a></h4></li>
<li><h4><a href='/neovim/'>NeoVim</a></h4></li></ul>