---
date: 2023-03-30
title: What are the main differences between NeoVim and vim?
headline: Discovering the Benefits of NeoVim Over Vim
description: I recently discovered the advantages of using NeoVim over Vim, including its improved maintainability, plugin system, and customizability. After learning about the ability to work with Jupyter Notebooks in Visual Studio Code, I asked Bing why Github Copilot was only integrated with NeoVim. He provided resources to help me understand and I used the Getting Started with Jupyter Notebooks in Visual Studio Code guide to learn how to use the extension.
keywords: NeoVim, Vim, Maintainability, Plugin System, Customizability, Jupyter Notebooks, Visual Studio Code, Github Copilot, OpenAI Codex API, Language Server Protocol, Microsoft, Extension, Interactive Python Coding
categories: jupyter notebooks, microsoft, github copilot, vim, neovim
permalink: /blog/what-are-the-main-differences-between-neovim-and-vim/
layout: post
---


NeoVim is a fork of Vim that aims to improve the quality of life for all developers. It inherits all the features from Vim but is more improved than Vim in maintainability, plugin system, and customizability aspects³. According to ¹, Vim uses a sliver of the system's memory and it loads instantly, all the while delivering the same features when compared to modern graphical editors like Atom and Brackets (which have underlying HTML5 engines, browsers, Node, etc.).

NeoVim has gathered a significant following among developers². According to ⁵, Vim sees NeoVim as a direct competitor. As a result, the original developers of Vim are more open to bringing innovations to Vim, which in the absence of NeoVim wouldn’t have happened.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 3/30/2023

    (1) Vim vs NeoVim: Functionalities, and Strengths. https://linuxopsys.com/topics/vim-vs-NeoVim Accessed 3/30/2023.
    (2) Vim vs NeoVim detailed comparison as of 2023 - Slant. https://www.slant.co/versus/42/62/~vim_vs_NeoVim Accessed 3/30/2023.
    (3) 7 Reasons NeoVim is Better Than Vim - linuxhandbook.com. https://linuxhandbook.com/NeoVim-vs-vim/ Accessed 3/30/2023.
    (4) How is NeoVim Different From Vim? | Baeldung on Linux. https://www.baeldung.com/linux/vim-vs-NeoVim Accessed 3/30/2023.
    (5) What is NeoVim, and how is it different from Vim?. https://vi.stackexchange.com/questions/34/what-is-NeoVim-and-how-is-it-different-from-vim Accessed 3/30/2023.


Hmmm. The display at the bottom of NeoVim screens is definitely different
somehow than standard vim. It may take me awhile to figure it all out. Most
importantly is how the blogging system works. It seems to be working, but the
output from my script that's supposed to stream to a console is not working. At
first it doesn't look like it's working, then it suddenly does, but then not
the way expected. However it seems to all work correctly in the end, so maybe
I'll just keep an eye on it.

**Mike Levin:** What do vim users have to get used to when switching to NeoVim?

**Bing:** According to ¹, you can use your existing ~/.vimrc, files, and plugins located within ~/.vim without having to symlink the files. NeoVim can use Lua and external software (for example, language servers or tools like eslint) without limitations. Vim can only use Vimscript. It can use plug-ins as far as they are written exclusively in Vimscript and can be tracked on git³.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 3/30/2023

    (1) How to share config between vim and NeoVim. https://vi.stackexchange.com/questions/12794/how-to-share-config-between-vim-and-NeoVim Accessed 3/30/2023.
    (2) How to have a NeoVim configuration compatible with Vim. https://threkk.medium.com/how-to-have-a-NeoVim-configuration-compatible-with-vim-b5a46723145e Accessed 3/30/2023.
    (3) How can I use --servername and --remote in NeoVim?. https://vi.stackexchange.com/questions/5348/how-can-i-use-servername-and-remote-in-NeoVim Accessed 3/30/2023.
    (4) Switching from Vim to NeoVim | Matthew Daly. https://matthewdaly.co.uk/blog/2018/09/09/switching-from-vim-to-NeoVim/ Accessed 3/30/2023.
    (5) Step Up Your Game with NeoVim. Why do I switch to VIM and use NeoVim .... https://medium.com/life-at-moka/step-up-your-game-with-NeoVim-62ba814166d7 Accessed 3/30/2023.
    (6) What is NeoVim, and how is it different from Vim?. https://vi.stackexchange.com/questions/34/what-is-NeoVim-and-how-is-it-different-from-vim Accessed 3/30/2023.

**Mike Levin:** What is Vimscript? What is the langauge like? What is it based on?

**Bing:** According to ¹, Vim's scripting language, known as Vimscript, is a typical dynamic imperative language and offers most of the usual language features: variables, expressions, control structures, built-in functions, user-defined functions, first-class strings, high-level data structures (lists and dictionaries), terminal and file I/O, regex pattern matching, exceptions, and an integrated debugger.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 3/30/2023

    (1) Scripting the Vim editor, Part 1: Variables, values, and expressions. https://developer.ibm.com/articles/l-vim-script-1/ Accessed 3/30/2023.
    (2) vimscript - What are/could be the potential advantages of learning VimL .... https://vi.stackexchange.com/questions/16060/what-are-could-be-the-potential-advantages-of-learning-viml-or-vim-scripting-lan Accessed 3/30/2023.
    (3) Vim (text editor) - Wikipedia. https://en.wikipedia.org/wiki/Vim_(text_editor) Accessed 3/30/2023.

**Mike Levin:** Why was Github Copilot only integrated with NeoVim and not vim?

**Bing:** According to ², Copilot status reports: "Copilot: NeoVim 0.6 required to support ghost text" so there might be a problem with the parts that show the inline preview. If you open the :Copilot panel you can see its suggestions and accept them with the enter button, but it's unwieldy to use via the separate panel.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 3/30/2023

    (1) vim9 - Using Github Copilot with Regular Vim - Vi and Vim Stack Exchange. https://vi.stackexchange.com/questions/38484/using-github-copilot-with-regular-vim Accessed 3/30/2023.
    (2) GitHub - thled/vim_copilot_cmp_issue: Minimal NeoVim setup to reproduce .... https://github.com/thled/vim_copilot_cmp_issue Accessed 3/30/2023.
    (3) Getting started with GitHub Copilot in NeoVim. https://docs.github.com/en/enterprise-cloud@latest/copilot/getting-started-with-github-copilot/getting-started-with-github-copilot-in-NeoVim Accessed 3/30/2023.
    (4) GitHub - github/copilot.vim: NeoVim plugin for GitHub Copilot. https://github.com/github/copilot.vim Accessed 3/30/2023.
    (5) Getting started with GitHub Copilot in NeoVim - GitHub Docs. https://docs.github.com/en/copilot/getting-started-with-github-copilot/getting-started-with-github-copilot-in-NeoVim?platform=windows Accessed 3/30/2023.

**Mike Levin:** What about the server hook language that VSCode uses so much?

**Bing:** Visual Studio Code uses a Language Server Protocol (LSP) which is a JSON-RPC-based protocol that allows the integration of language servers into development tools. The language server is a special kind of Visual Studio Code extension that powers the editing experience for many programming languages. With Language Servers, you can implement autocomplete, error-checking (diagnostics), jump-to-definition, and many other language features supported in VS Code ¹.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 3/30/2023

    (1) Language Server Extension Guide - Visual Studio Code. https://code.visualstudio.com/api/language-extensions/language-server-extension-guide Accessed 3/30/2023.
    (2) VSCode with Go Language Server - 我坦白~ - GitHub Pages. https://simpleowen.github.io/post/go_lps_4_vscode/ Accessed 3/30/2023.
    (3) The VS Code Server - Visual Studio Code. https://code.visualstudio.com/blogs/2022/07/07/vscode-server Accessed 3/30/2023.
    (4) VsCode Remote SSH .vscode-server taking up a lot of space. https://stackoverflow.com/questions/58453967/vscode-remote-ssh-vscode-server-taking-up-a-lot-of-space Accessed 3/30/2023.

**Mike Levin:** Is that how Jupyter Notebooks are supported in VSCode? Is LSP what Copilot is using for integration with NeoVim?

Yes, Jupyter Notebooks are supported in Visual Studio Code natively ³. The Jupyter extension provides basic notebook support for any language kernel that is supported in Jupyter Notebooks today ².

As for Copilot, it uses a different protocol called OpenAI Codex API ¹.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 3/30/2023

    (1) Working with Jupyter Notebooks in Visual Studio Code. https://code.visualstudio.com/docs/datascience/jupyter-notebooks Accessed 3/30/2023.
    (2) Introducing the Jupyter Extension for VS Code - Python. https://devblogs.microsoft.com/python/introducing-the-jupyter-extension-for-vs-code/ Accessed 3/30/2023.
    (3) Getting Started With Jupyter Notebooks in Visual Studio Code. https://towardsdatascience.com/getting-started-with-jupyter-notebooks-in-visual-studio-code-5dcccb3f739b Accessed 3/30/2023.
    (4) Announcing Support for Native Editing of Jupyter Notebooks in VS Code. https://devblogs.microsoft.com/python/announcing-support-for-native-editing-of-jupyter-notebooks-in-vs-code/ Accessed 3/30/2023.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/interrogating-bing-bard-on-utility-of-jupyter-notebooks-for-seos/">Interrogating Bing & Bard on Utility of Jupyter Notebooks for SEOs</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/adapting-my-drinkme-for-linux-pipulate-script-for-macs/">Adapting My DrinkMe for Linux Pipulate Script for Macs</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter-notebooks/'>Jupyter Notebooks</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/github-copilot/'>Github Copilot</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/neovim/'>NeoVim</a></h4></li></ul>