---
date: 2023-09-01
title: Google Conversational Search vs Bing Chat (No Contest)
headline: In Everyday Head-to-Head Comparisons Between Google Conversational Search and The New Bing, There's No Contest
description: I was curious how well Google and Bing would be able to tell me this esoteric little detail about where the Github Copilot plug-in for NeoVim stored its authentication details. The writing is on the wall. The wall being this blog post, and the writing being Bing's formatted results.
keywords: Google, Conversational Search, Bing, Chat, WSL, Linux, JupyterLab, Windows, Mapping, USERPROFILE, %, .config, Symbolic Links, Copilot, NeoVim, GitHub, Configuration, Per-App, Authorization, Prime Time, Formatting, Results, Publishing, MikeLev.in, Installation, Plugin, Token, Username, Messages, copilot.log, Debugging, Setup, Community, Discussion, Bignerdranch
categories: bing, git, linux, ai, wsl, jupyter, vim, google, microsoft, message
permalink: /blog/google-conversational-search-vs-bing-chat-no-contest/
layout: post
group: blog
---


The WSL install-script that I use to put Linux JupyterLab (cloud friendly) on
Windows can be re-run and all your Linux configuration stuff, like on a per-app
basis, is preserved. This is possible by mapping a Windows location under your
user home directory `C:\%USERPROFILE%\.config` to the Linux equivalent
`~/.config` with Linux symbolic links. 

I was noticing that I never had to re-authorize Copilot in NeoVim, so I was
curious if that's where it was putting the authorization, and I checked with
both `Google SGE` (their "conversational search" experiment) and the quite
ready for Prime Time `Bing Chat`. This example spectacularly illustrates how
far ahead of Google Bing really is, right down to assisting with formatting the
results (below) for publishing.

{% include youtubePlayer.html id="Zkh4ct9u9tA" %}

MikeLev.in: When you authorize Copilot on NeoVim, where does it save the authorization status?

Bing: Hello, this is Bing. I'm glad you asked about Copilot on NeoVim. Copilot is a tool that helps you write code faster and better by suggesting lines or entire functions as you type. To use Copilot on NeoVim, you need to install the copilot.vim plugin and authenticate with GitHub⁵.

According to the GitHub documentation², the authorization status for Copilot on NeoVim is saved in a file called `~/.config/nvim/copilot.json`. This file contains your GitHub username and a token that allows Copilot to access your GitHub account. You should not share this file with anyone or modify it manually.

If you have any issues with the authentication process, you can try the following steps:

- Run the `:Copilot setup` command in NeoVim and follow the instructions to copy your one-time code and open GitHub in your browser.
- If the browser does not open automatically, visit [this page](^6^) and enter your one-time code manually.
- After you authorize Copilot on GitHub, go back to NeoVim and wait for a few seconds. You should see a message that says "Successfully authenticated as [your username]".
- If you do not see this message, or if you see an error message, you can check the `:messages` command in NeoVim for more details. You can also look at the `copilot.log` file in your `~/.config/nvim` directory for debugging information.
- If the problem persists, you can try to delete the `copilot.json` file and run the `:Copilot setup` command again. You can also contact the GitHub support team or join the [GitHub community discussion](^1^) for more help.

I hope this helps you use Copilot on NeoVim more effectively. Happy coding! 😊

Source: Conversation with Bing, 9/1/2023

    (1) GitHub - github/copilot.vim: Neovim plugin for GitHub Copilot. https://github.com/github/copilot.vim.
    (2) Configuring GitHub Copilot in your environment - GitHub Docs. https://docs.github.com/en/copilot/configuring-github-copilot/configuring-github-copilot-in-your-environment.
    (3) undefined. https://github.com/login/device.
    (4) Copilot in neovim gets stuck in setup/auth · community - GitHub. https://github.com/orgs/community/discussions/50263.
    (5) Neovim + Copilot authentication not being persisted #18720 - GitHub. https://github.com/orgs/community/discussions/18720.
    (6) An introduction to GitHub Copilot Using the Plugin for Neovim. https://bignerdranch.com/blog/github-copilot-using-the-plugin-for-neovim/.
    (7) undefined. http://github.com/login/device.























<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/journal-daily-learn-vim-by-journaling-similar-tricks-for-python-linux/">Journal Daily. Learn vim by Journaling. Similar Tricks for Python & Linux</a></div> &nbsp; <div class="post-nav-next"><a href=""></a></div></div>
## Categories

<ul>
<li><h4><a href='/bing/'>Bing</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/message/'>Messages</a></h4></li></ul>