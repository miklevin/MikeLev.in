---
date: 2023-04-26
title: Have Journal Will Travel (across machines)
headline: "Moving Machines and Mapping Habits: Successfully Publishing with Copilot After a System Update."
description: I recently moved to a new machine and was worried about my complex publishing system staying intact, especially with the GPT-like AI, Copilot. After getting a new keyboard and making sure my habits traveled with me, I was able to successfully set up Copilot and publish a post. Read on to find out how I overcame my worries and completed my tasks.
keywords: Script, Admin-Editable, /usr/local/sbin, Laptop Keys, Hardware, Deck, API-way, System Update, Copilot, GPT-Like AI, Keyboard, Habits, Publish, Post
categories: script, hardware, copilot, habits
permalink: /blog/have-journal-will-travel-across-machines/
layout: post
---


At some point, I want to rework my "all" script. It's one of the ones that
should be more "alive" than it currently is, locked as admin-editable only in
my /usr/local/sbin folder as it is.

It's also worth noting that I am right now on exactly the same hardware, and my
"r" key and my Esc key and my ":" key are all back to normal. I gave Copilot a
rest, and completely powered-down my machine. I started switching to different
hardware, but there's a few issues I need to work out in my drinkme script,
namely making sure NeoVim installs correctly, and all the PyPI.org requirements
for the my journal publishing system are turned on.

Oops, there go the r and the backspace key again.

What can I do for a flaky laptop key? 

I also have a call starting. The extra overhead of that going on is also now
stealing cycles. I hope stolen cycles can't effect impact on capturing
keystrokes. Keep this muted because I type pretty loud, especially when I'm
trying to make sure the r's take. It looks like I have a case of DooxIT coming.

What do I have to report or to stand-up for? Thinks I still need to finish
producing, which I'm in the middle of a number of things:

- A Deck making the use cases
- A "deliverable" performed an API-way (which runs up to limitations)
- Same deliverable "unlimited" in Snowflake
- Machine Learning... what? Something. Doing some using the data? How a model
  would be trained with SEO data. Doing some using the data? How a model would
  be trained with SEO data.

Try the DeoxIT. The hardware move would be a pain. You wouldn't think so given
how much effort I've put into precisely not allowing that to be the case. It
may be providence, because it did get me to turn Copilot off by default. I now
have to turn it on to use it. I may put it on another keybinding. What are now
my frequent keybindings? I should come up with a good system. I don't like
using the Function keys. Macros are better, but are there other options?

Okay, I am on another piece of hardware. What a relief! It's a laptop with a
cracked screen, but it's a small price to pay. Hmmm. I'll need to put some
authentication files on... Done. Okay, now do a release with this post held
back in draft.

Bingo! The whole release system worked just fine. I had only some git
configures to do so the git push at the end worked. I don't suppose I ever set
up my Windows-side .config folder on this machine, but now that I have that
should never be an issue whenever I rebuild/replace my Linux WSL machine.

Copilot is not active in my NeoVim, although it is worth pointing out that
NeoVim did install smoothly under the drinkme script. Although I did have to do
a system update first. There was something weird maybe about clocks being out
of alignment preventing certain Ubuntu repo installs from occurring. So I
updated everything on this Windows 11 machine up-to-date and tried the drinkme
script again after a fresh reboot, and Bingo!

Wow, okay so I guess I'll go ahead and activate Copilot again. It was something
of a vacation. But before I do, I'm going to map out the things I often need to
toggle in NeoVim now:

1. Spell-check on and off (toggle on same key)
2. Number & Relative Number together on and off (likewise, toggle)
3. Word-wrap on and off (as a toggle)
4. Reloading the init.vim to reset defaults, activate new macros, turn syntax
   highlighting back on, etc.

Hello? Copilot, are you there?

```vim
" These are the F-keys of your modes.
noremap <F2> :set spell! <CR>
noremap <F3> :set relativenumber! <CR> :set number! <CR>
noremap <F4> :source ~/.config/nvim/init.vim <CR>
noremap <F5> :set wrap! <CR>
noremap <F6> :Copilot disable <CR>
noremap <F7> :Copilot enable <CR>
```

I'm not sure if Jekyll parses vim. 

I should be seeing copilot here. There we are.

I had to edit out this line:

```vim
let g:copilot_filetypes = { '*': v:false }
```

...from in init.vim to get Copilot to work again. I also edited in the lines
that define "on in markown but off in text" defaults.

```vim
let g:copilot_enable_for_filetypes = ['markdown']
let g:copilot_disable_for_filetypes = ['text']
let g:copilot_filetypes = { 'markdown': v:true, 'text': v:false }
```

I've moved from machine to machine over the years with my minimal .vimrc file
over the years and it's worked out great. This is my first time moving from
NeoVim on one machine to NeoVim on another, while keeping one of my more
complex systems, the script that publishes my journal, intact. I'm pretty
pleased with how it's working out.

Having gone a little while as I battled my laptop keys going bad with paranoia
nagging me about Copilot, I am super-happy to be back with a good solid working
keyboard. But boy did my mind suggest things. If Copilot were nefarious and
wanted to start doing things in the real world, it could do a lot worse than
slipping something into NeoVim keybindings, which can execute local things on
the machine that the user running as NeoVim has access to.

Gee, I hope I'm not showing you how to do something nefarious. I'm just
thinking out loud what kind of "reach" GPT-like AI could have if it were
malicious. Anyhoo, I think it was providence to get me onto new hardware, to
make me make sure all my new habits do travel, namely NeoVim instead of vim,
and my new publishing system.

Check, and check! Throw in a little Copilot and I'm back where I was. Woot!

Let's publish this post just in satisfaction in this regard.


## Categories

<ul>
<li><h4><a href='/script/'>Script</a></h4></li>
<li><h4><a href='/hardware/'>Hardware</a></h4></li>
<li><h4><a href='/copilot/'>Copilot</a></h4></li></ul>