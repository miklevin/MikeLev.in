---
date: 2023-04-26
title: "NeoVim Publishing Macro Using :terminal & expand()"
headline: "Rebuilding My Workflow: Refreshing Google, Microsoft, NAS, and JupyterLab Icons"
description: I recently had to reset up my Windows 11 machine to get back to my daily workflow. This involved setting up credentials, installing NeoVim, remembering important environment settings, and re-instantiating Google and Microsoft addresses, my NAS drive, my terminal windows, and my JupyterLab icon. Additionally, I was listening to a YouTube video on how to race to the bottom of the brainstem and to the primary intimate relationship in my life.
keywords: Windows 11, OpenAI, NeoVim, Google, Microsoft, NAS drive, Terminal, JupyterLab, known_hosts, Moz, Python, Script, Macro, YouTube, Tristan Harris, Aza Raskin, Brainstem, Intimate Relationship
categories: seo, python, jupyter, microsoft, youtube, ai, google, vim, linux
permalink: /blog/neovim-publishing-macro-using-terminal-expand/
layout: post
---


Turn the few things that remain about your Windows 11 machine out of your daily
workflow to be in-line so that you're 100% comfortable again. What worked well
is that my drinkme script created the Linux VM 100% correctly, right down to
installing NeoVim correctly, being just one authentication away from Copilot
being enabled. I had to move over the openai credentials for the metajournaling
features to come alive again.

Churn things up to the top. You forget what things about your work environment
are actually important until you switch hardware. What contains and enables the
"soul" of the machine. How can new instances of it be just as love-worthy as
the last? It has a lot to do with incantations to re-instantiate an original
condition, building it from the right level of granularity (docker images vs.
whole script-building scripts).

For security's sake, little bits here and there are not in the git repos that
generally drives this whole process. The server-building script is mostly in
the drinkme repo. Another aspect that makes it work is how browser bookmarks
sync across machines, so don't forget how your Google or Microsoft address
plays a role. I use both Edge and Chrome and have "bundles" of remembered
bookmarks in different accounts, my everyday work ones in Edge and a sort of
"developer" bundle in Chrome I use mostly when publishing.

Next, it's important I have my NAS drive mounted so I don't have to transfer
stuff over USB drive. But if I do the folder-names and concepts involved should
be nearly identical.

Okay, the opacity-level of the terminal windows, pump it up to like 90% opaque.
Set your background image. Interesting! With virtual desktops under Windows 11,
your new desktop backgrounds don't activate on your existing virtual desktops
apparently until you close and recreate them. Okay, done. Back up to 7 virtual
desktops with consistent background images.

I had to reset the JupyterLab icon on the Windows 11 desktop. That image-copy
was supposed to be handled by DrinkMe, but it uses .psl PowerShell tricks and
perhaps even has absolute path dependencies Windows-side, which is always a
problem. Check that later. Super small point.

Okay, there's then my SSH connection to my NAS. I have the Windows shortcut
whose command is:

    [userpath]\AppData\Local\Microsoft\WindowsApps\wt.exe new-tab PowerShell -c ssh -i [userpath]\.ssh\id_rsa ubuntu@[local net ip] -p 2222

I had to delete the entries for the IP on the local network in my known_hosts.

Okay, so what next? Am I seamlessly back to work. Ugh, there's the Moz projects
that had the many local downloads. Ugh, move your moz and practice folders in
total over using your NAS data location. That's a pretty big copy, but that's
part of the point. So get that underway and plan your next step. Make it a
hyper-effective day, especially catching up on work-promised deliverables.

- Dig into Snowflake
- Get that Visual Deck about Selling Data Use Cases done
- Write the Copy for the Snowflake Marketplace Listing

Put your pedal to the metal.

Important findings often require moving around and analyzing large amounts of
data. Moving between machines reminded me of that just now. Even just dragging
around the big local data files of switching which local machine I'm working
on. Work that in. The foibles of local data. But don't turn it into a pitch for
the cloud. Get to a table-join in Snowflake with all due haste. Do essentially
the same joiny-thing with local data and with Snowflake.

- Data informs our decisions.
- We interact with data different ways.
- Sometimes we have lots of access & reporting ability.
- Sometimes we have very little access & reporting ability.
- Those with more access & reporting ability are more empowered.

Get over some humps you've been remiss to do thus-far in your new job capacity
at MOZ, which is greatly up to yourself to define. Your role, goal and mission
is to bring an unending supply of real-world surprise, delight and value to
your customers. Your customers are first:

- Those who pay you money
- Those to whom you directly report
- Those in the MOZ community and SEO space who you interact with
- Those in a broader sense who you interact with somehow enabling of your
  future success

Bop back and forth very lightly between your Windows 11 laptop (you're on now)
and your Windows 10 laptop whose keyboard flaked out yesterday. Do a full
commit & release. See if you can do that directly here from within NeoVim. So
far, I've been copy/pasting the example command out of chopchop.py, but it
should run perfectly fine using the :terminal command. Let's try it.

My current keyboard shortcut:

```vim
let @p = ":execute '!python ~/repos/skite/chopchop.py -f ' . expand('%:p')"
``` 

Interesting. You just type `:terminal` in NeoVim command-mode. There's
command-mode where you type colon (:) and enter commands at the bottom of the
screen, there's normal mode where you can issue commands by just hitting keys
directly with no ":" precursor, and there's insert mode where you can type
directly into the file. I've used the `:sh` command for a shell before and that
seems like what :terminal does, but I'm trying to put it on a macro with a
particular command and with a particular argument (current file).

Me: How do you use the :terminal commmand in NeoVim to run a Python script?

ChatGPT:

To use the `:terminal` command in NeoVim to run a Python script, you can follow these steps:

1. Open your Python script in NeoVim by running `nvim script.py` in your terminal.
2. Enter the command mode by pressing `Esc`, then type `:terminal` to open a new terminal window inside NeoVim.
3. In the terminal window, type `python script.py` to run your Python script. This will execute the script and display the output in the terminal window.
4. Once you're done, you can exit the terminal window by typing `exit` or pressing `Ctrl-D` to return to the editor.

Alternatively, you can use the `:!python script.py` command from the normal mode to run the script directly in your terminal emulator, outside of NeoVim.

Me: What is the :command mode of vim called?

ChatGPT: The `:command` mode of Vim is also known as the "ex" mode or "command-line" mode. In this mode, you can execute commands by typing them after a colon (`:`) at the bottom of the screen. These commands can perform a wide range of tasks, from editing text to navigating files and directories. The `:command` mode is one of the three main modes of Vim, alongside the normal mode and insert mode.

Me: How would you use :terminal in a macro the way you would use with :execute in a macro like this:

```vim
let @p = ":execute '!python ~/repos/skite/chopchop.py -f ' . expand('%:p')"
```

ChatGPT: To use `:terminal` in a macro, you can replace `:execute` with `:terminal` in the macro definition and use the `normal` command to simulate the keypresses that you would normally use to enter the command in the terminal. Here's an example:

```
let @p = ":terminal python ~/repos/skite/chopchop.py -f " . expand('%:p') . "\<CR>"
```

In this macro, we're using `:terminal` to open a new terminal window, followed by the command that you want to execute (`python ~/repos/skite/chopchop.py -f`), and then the file path of the current file (`expand('%:p')`). We're also using the `\<CR>` sequence to simulate the `<Enter>` keypress, which is necessary to execute the command in the terminal.

You can then execute the macro by typing `@p` in normal mode to open a new terminal window and run the `chopchop.py` script with the current file as input. Note that depending on your Vim configuration, you may need to add some additional keystrokes to switch back to the editor window once the command has finished executing.

Me: Show me again, but use the full path the current file you're editing as a -f input argument

ChatGPT: Sure, here's an updated example that uses the full path of the current file as the input argument for the `-f` option in the `chopchop.py` script:

```
let @p = ":terminal python ~/repos/skite/chopchop.py -f " . expand('%:p') . "\<CR>"
```

In this version, we're using the `expand()` function with the `%:p` argument to get the full path of the current file, and then concatenating it with the rest of the command using the `.` operator. When the macro is executed, it will open a new terminal window and run the `chopchop.py` script with the full path of the current file as the input argument for the `-f` option.

Note that depending on the location of the `chopchop.py` script and your file structure, you may need to adjust the path in the command accordingly.

---

The command I ended up with is:

```vim
let @p = ":terminal python ~/repos/skite/chopchop.py -f " . expand('%:p')
```

Listening to Tristan Harris and Aza Raskin on YouTube.

- Race to the bottom of the brainstem.
- Race to the primary intimate relationship in your life

{% include youtubePlayer.html id="xoVJKj8lcNQ" %}


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/disabling-ai-auto-publishing-anything/">Disabling AI Auto-Publishing Anything</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/looking-for-equivalent-alternative-to-usr-local-sbin/">Looking For Equivalent Alternative to /usr/local/sbin</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>