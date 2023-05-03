---
date: 2022-05-11
title: Enabling vim's Visual Block mode on Linux WSL (Ctrl+v)
permalink: /blog/enabling-vim-s-visual-block-mode-on-linux-wsl-ctrl-v/
headline: "Activating Visual Block Mode in vim on Linux WSL: My Story"
description: I recently discovered a powerful feature of vim called Visual Block mode, which allows you to quickly add text to multiple lines. However, this feature wasn't available in the Microsoft Terminal program when running vim under Linux in Windows via WSL. After a few steps, I was determined to figure out how to activate this feature and eventually succeeded. Learn how I overcame the challenge and how you can activate Visual Block mode in vim.
keywords: vim, Visual Block mode, Linux, WSL, Ctrl+v, Microsoft Terminal, Windows, VSCode, JSON, Linux on Windows, VcXsrc X-Server, markdown, files, game, activate
categories: wsl, vim, linux, vscode
layout: post
---

OMG, vim's full of tricks.

Learn a trick, improve your life.

Better life through a text editor that will not die is a thing.

Stuff that lasts forever, like vi(m) is one of those things. You might be drawn
to VSCode, but that's just Microsoft's latest attempt to corrale you in like
good livestock.

This is a righteous feedback loop of compounding returns that improves your
life better than any other skill or material asset.

So what's the best trick in vim?

In addition to all the normal ones you'll get from vimtutor (type vimtutor from
the command-line), I think the most important skill is visual-block mode. This
is not a native feature of vi that vim is based on, so it is perhaps a bit less
"pure" than other stupid vim tricks that use only vi's "core" abilities. But
vim's visual-block mode is the best return on my keystrokes.

For those who don't know, visual mode in vim is simply doing selecting text
with highlighting. Since use of the mouse is not encouraged in vim (completely
contrary to the point, in fact), such selections are made by navigating a
cursor to the beginning of the selection, hitting "v" to start the
highlighting, then navigating the cursor to the end of the selection and
hitting whatever command such as yank (the same as copy), delete or "gq" to
reformat and such.

There are other visual modes you can achieve by doing Shift+v to select a
whole-line (visual line). When in visual line mode, the "j" & "k" keys which
move your cursor up and down respectively will highlight entire lines. This is
nice because you don't have to worry about your cursor being at the beginning
of the first line and the end of the last line to get a whole bunch of lines.
It's useful for copy/pasting paragraphs and more.

But what about selecting columns of text? Or a block of text? Or more
interesting still, what if you needed to type something at the beginning of
every line in a list and you didn't want to do some fancy macro? Can you just
type on all the lines at once? The answer to all the above questions is visual
block mode, or the Ctrl+v keystrokes to start a visual selection.

So, say you typed a list and realized you wanted hyphens at the beginning of
each:

    line 1
    line 2
    line 3
    line 4

You would simply position your cursor at the beginning of line 1, press Ctrl+v,
hit "j" to go down a few lines, press Shift+i to go into insert-mode, type
minus-sign (hypen), Space, and then hit the Esc key. There will be a strange
momentary pause, but then the hyphens will appear all the way down the list.

    - line 1
    - line 2
    - line 3
    - line 4

You may not think so, but this is vastly powerful with broad application.
Getting this one skill down will improve your vim skills in many unexpected
ways. Being able to make selections of text that are not line-based, but
column-based in nature lets you move columns around in tables, edit ASCII art,
and much more.

Now the rub is that the Ctrl+v keystroke is intercepted by Microsoft Terminal
when running vim under Linux under Windows via WSL. Huh? That sounds like a
mouthful. However, this is the most mainstream way to do this imaginable.
Ubuntu 20.04 (currently) running on the Windows subsystem for Linux (WSL) in
the Microsoft Terminal program has got to be the most mainstream popular Linux
platform today. And what I consider one of the most useful actions on a Linux
platform, activating Visual Block mode in vim, is broken because of the
defaults in Microsoft Terminal which are not easy to change under Settings.

In teaching my wife vim in this environment, I got up to the inevitable step of
installing bullet-points in front of every line in a list and Ctrl+v did not
work the same way for her as it did for me. It was doing a WindowsOS
paste-operation. Ugh! Yeah, I guess it would by default. So let's go into
settings and change that.

We go into settings, which now has an actual user interface on it. It used to
be just the editing of a JSON file. Worse still, it was the prompting to
download and install VSCode in order to edit the JSON file.

You can not imagine how insulting this is to someone like me who is only using
Linux on Windows because of how good/cheap the Microsoft surface laptop
hardware is. If it weren't for Microsoft hardware being so good, I would not be
using Microsoft software, period. You just can't beat the driver support and
everything working so correctly on mainstream Intel Microsoft hardware.
Honestly, try the ARM64 hardware and look at how many drivers are broken, how
you can't get your bluetooth or stylus or fancy mouse or some-such other thing
working. Everything targets working on Windows, and you should too... for the
time being.

Okay, so you want to run Linux? No problem. Microsoft's got you covered there
too. Just forget about Linux graphics support for awhile, unless you don't mind
being on the bleeding edge or slow performance. I choose slow performance and
go with the VcXsrc X-Server app. Others go with Windows 11 plus being on the
developer track release of Windows (bleeding edge). Either way, it's really not
worth pursuing Linux with graphics under Windows right now.

But that doesn't matter. You're generally not on Linux to do graphics things,
anyway. You're on Linux so that you can have old-school superpowers of a
standard interoperable command-line. Windows COM and Powershell are neither
standard nor interoperable. They are kooky-weird backslashing insults to
techdom and will die someday soon. Or at least they will be relegated to the
not-dead-yet pile of Black Knights that the Amiga computer has been tossed
onto. Linux won and Microsoft is just trying to hide the rigor mortis.

Oh yeah, how to stop Windows from blocking Ctrl+C in vim?

Go to settings under Windows Terminal. Click "Open JSON file" in the
lower-right. If you don't have VSCode, then select Notepad as the editor.
You're going to have to edit the JSON-file Windows-side and using vim
Linux-side at this point, while possible, is not worth it. Just use Notepad and
add this entry ever-so-carefully under commands:

```javascript
        {
            "command": "unbound",
            "keys": "ctrl+v"
        },
```

Next, go to Settings / Interaction and turn on "Automatically copy selection to
clipboard". This is a step that's actually possible under the provided Settings
user-interface. The fact that un-binding Ctrl+V from the OS meaning required
editing a JSON file is one of those killer show-stoppers that sabotages the vim
learning experience. I mean, how would you ever know? Even the StackOverflow
discussions and official Microsoft support pages are unclear on this issue.
There is much talk of doing it with vim keybindings, which is the completely
wrong approach.

Close and re-open Windows Terminal. Click-drag to highlight some text. Go see
if you can paste it somewhere Windows-side like Notebook.

And finally, type a few lines in vim. Press Ctrl+v. Read at the bottom of the
screen where you usually see "INSERT" for insert-mode and see if it says
"VISUAL BLOCK". If it does, you were successful.

Anyway, this entry really covered quite a lot. But that's because Nat and I
covered quite a lot in our last vim session.

It was a great example of a Rabbit-Hole evaluation where I decided jumping down
into the rabbit hole actually ***is*** necessary. Without visual block mode in
vim, so many other tricks are dead in the water.

It is a crime to block Ctrl+v in vim. It should not be the default.
Highlighting text to copy it and not blocking Ctrl+v should be the default. I
know it will make copy/paste in all other instances more confusing, but only at
first until highlight-to-select is understood.

My vim session with Nat started out as:

- Creating a list with bullet-points
- Ctrl+v for visual block mode
- Inserting minus-signs as bullets on multiple lines at once
- Indenting and outdenting items on a list
- Shift+J to bring things onto same line
- Introduction to markdown
- Looking at markdown files

...but then became almost entirely about figuring out how to activate visual
block mode.

And this was okay.

Sometimes the game changes while you are playing it. That's just the way it is.
How long you spend before you back-up and retry is up to you.

We didn't back-up and retry this time, because visual block mode was just that
important.

## Categories

<ul>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/vscode/'>VSCode</a></h4></li></ul>