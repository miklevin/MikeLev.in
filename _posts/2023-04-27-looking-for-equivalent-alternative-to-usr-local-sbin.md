---
date: 2023-04-27
title: Looking For Equivalent Alternative to /usr/local/sbin
headline: Successfully Publishing from Windows 11 with NeoVim - Testing and Troubleshooting Drafts
description: "I recently published from a Windows 11 laptop using NeoVim's new terminal macro and I'm starting to see the vimscript command: if has('nvim'). With this, I'm hoping to have a single .vimrc that works for both vim and NeoVim. I tested moving a draft post between machines and it worked, but I noticed that when I add anything to my spell-check library with the zg command, I lose syntax highlighting in NeoVim."
keywords: Windows, 11, laptop, terminal, macro, NeoVim, vimscript, if, has, nvim, single, .vimrc, vim, draft, post, machines, zg, command, spell-check, library, syntax, highlighting, switch
categories: draft, neovim, .vimrc, vim, macro, terminal
permalink: /blog/looking-for-equivalent-alternative-to-usr-local-sbin/
layout: post
---


Okay, I did my first successful publish from the Windows 11 laptop, using the
new :terminal macro in NeoVim, so no more separate command-lines to manually
execute the publishing command. It's working well and is one of my big
divergences from vim compatibility in my init.vim. I'm starting to see the
vimscript command: if has("nvim"), and so I have hope of keeping a single
.vimrc that works both for vim & NeoVim, but that's in the future.

Now that I published from a different machine, it's time to do so once more
with a post in draft form (no title tag), and see the draft move over between
machines. Theoretically, between my "all" script that gets my journals and
other misc files loaded daily, and my release system, I should be able to move
my whole environment around onto any Windows machine upon which I've run the
drinkme script.

Odd, whenever I add anything to my spell-check library with the zg command, I
lose syntax highlighting in NeoVim. Not a big deal, I can flip it back on with
a macro to reload my init.vim, but it's a little annoying and something to keep
in mind. Anyway, switch back to my old machine to ensure flexibility.

And here's my draft on my old machine. Yes, the "r" key is a bit stubborn. The
backspace key seems to be working again. Whatever it was yesterday has cleared
up a bit. Maybe I let the keyboard get wet or something and the mechanisms had
to dry out. In either case, there's still a bit of annoyances left in the
keyboard and I'm glad to be on a "like new" keyboard, and an even better laptop
but for the cracked screen. I wish I could combine the best parts of each into
one, but alas, Microsoft and designed obsolescence again! These things are not
designed to open.

If I have nothing to publish, I should be able to effectively switch machines
with all my important repos updating along with me just by loading and quitting
my journals/daily-text-files by just quitting my "all" script, which is always
still actually running when I'm editing, because it's the script that got those
files all loaded into NeoVim in the first place, so when I quit, it finishes
running the script by committing and pushing the respective repos.

And in that way, I can just stop working on one machine and start working on
another machine, and my local work comes with me. Sure, cloud is involved but
whenever I like I can switch from Github to whatever git repo server I wish to
run on my home NAS cloud.

Yep, confirmed. Bopping around on different hardware is like one of the key
points of the drinkme script. I think I underplay the importance of an "all"
script in all this for adding context to the files you're actually generally
working with on a day-to-day basis. If it's a reasonably similar set of files
each day, or *should be*, or is the same for maybe weeks at a time, then
loading everything all at once in NeoVim makes a lot of sense. Most important
files go in first and last buffer, because they're always easy to get to with a
`:b1` and `:blast`.

Everything else of import goes in between, and from buffer-1, you can
`Ctrl+Space` rapidly through them, or list them with a `:ls`.

The `all` script is running just fine on the Windows 11 machine without
modification, and that was a step forward. The problem now is that living in
the /usr/local/sbin folder as it does in order to get into a common global path
for commands and eliminate the need for file-extensions, it requires sudo to
edit, and as such is not a good candidate file for the `all` script, nor is
Copilot active in sudo nvim editing.

Maybe I'll find some other path that makes it easier to edit the `all` script
while still not requiring a .py extension nor a path entered nor running from a
particular directory. /usr/local/sbin is a very special and awesome place for
commands, but it's not a great place for scripts that you want to edit
regularly. I should look at how nbdev installs their OS-independent commands.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/adding-an-advice-from-openai-field-to-my-journal">Adding an Advice From OpenAI Field to my Journal</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/neovim-publishing-macro-using-terminal-expand">NeoVim Publishing Macro Using :terminal & expand()</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/draft/'>Drafts</a></h4></li>
<li><h4><a href='/neovim/'>NeoVim</a></h4></li>
<li><h4><a href='/vimrc/'>.vimrc</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/macro/'>Macro</a></h4></li>
<li><h4><a href='/terminal/'>Terminal</a></h4></li></ul>