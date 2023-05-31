---
date: 2022-05-22
title: I Don't Want To Blow Up
headline: "Learn Vim: Unlock the Power of a Text Editor with WSL and Vimtutor"
description: "As a tech enthusiast, I use Linux, Python, Vim and Git as my go-to tools. I'm a big fan of Bram Moolenaar's plain old Vim from 1991, as it's more future-proof and resistant to obsolescence. Are you looking to learn Vim? I'm encouraging you to do so - just type `wsl --install` in a DOS COM to get started. Vim is a powerful tool and is much more fundamental than the full web stack."
keywords: Linux, Python, Vim, Git, Bram Moolenaar, DOS COM, JavaScript, NodeJS, Text Editor, Terminal, Sun
categories: linux, vim, javascript, text editor, python, git
permalink: /blog/i-don-t-want-to-blow-up/
layout: post
---


> I don't want to blow up<br />
> I'm sad Toys R Us is gone<br />
> I get a million views on YouTube<br />
> Sometimes when I'm on<br />
> <br />
> But it doesn't persist<br />
> And I throw it away<br />
> Cause I'm here for catharsis <br />
> And a whole lot of play<br />
> <br />
> The job that I do <br />
> Pays so good so this guy<br />
> Is just streaming for you <br />
> For the pandas and py<br />
> <br />
> A joke from a geek<br />
> Can either trigger or trot<br />
> You along the right path<br />
> For your life. Maybe not<br />
> <br />
> The mind that is open<br />
> Is the place we begin <br />
> That apple would tell ya<br />
> Is a place of great sin<br />
> <br />
> I'm gonna share what I do<br />
> For my sisters and brethren<br />
> You get Linuxy too<br />
> From your Windows 11<br />
> <br />
> You fire up COM<br />
> In the past it was DOS<br />
> And it's still really dumb<br />
> We're slashing back like a BOSS<br />
> <br />
> The following words <br />
> Are gonna carry y'all<br />
> Through a glass-looking wardrobe<br />
> wsl —install<br />
> <br />
> Now you wait just a minute<br />
> Maybe twenty. Oh shoot!<br />
> Tune back here real soon<br />
> Cause I gotta reboot <br />
> <br />
> But when we come back <br />
> We'll be in a place where they say<br />
> Is so scary and intimidating<br />
> That's to keep you away.<br />
> <br />
> Cause if you learn a few things<br />
> Such as ls means list<br />
> You're gonna make a few dings<br />
> And get Ellison pissed<br />
> <br />
> You don't need a sequel <br />
> Cause the data's right here<br />
> There's a whole lot to love<br />
> Without VS Code near<br />
> <br />
> Cause the world that you're leaving<br />
> When you pass through those gates<br />
> Has the powers believing<br />
> Control y'own fates<br />
> <br />
> They know they must let ya<br />
> They couldn't before <br />
> But they're still gonna get ‘cha<br />
> By controlling the door<br />
> <br />
> The Terminal window<br />
> Is terminal ‘cause<br />
> When you download it<br />
> Ya make y'own laws<br />
><br />
> <cite>&#151;Mike Levin<br />

And that's all I have to say about that.

# Actually, I have a lot more to say

But a little indoctrination like this is necessary to undo decades of damage
caused by the window dressing slapped on substandard systems that are finally,
after 30 years, being replaced by something live worthy underneath you can
ditch the old stiff for and future proof yourself. Cause the new stuff is
really the food old stuff. It didn't go away then. It's coming back today. And
it's really where you've got to get to right now if you don't want to keep
having the latest full web stack faddy thing pulled out from under you every 2
to 5 years.

# Tech Poetry as Performance Art

{% include youtubePlayer.html id="mER1_kgCjho" %}

Linus Torvalds changed the world. Ken Thompson did first. Then Linux did more.

Here are the four tools I use. Use whatever you like, but the FOSS roads are
windy twisty ones with a lot of options and paralyzing dead-ends. Here's one
righteous path that has the humble advantages of future-proofing, resisting
obsolescence and wrangling disruption to very manageable levels.

- Linux
- Python (Guido van Rossum)
- vim (Bill Joy vi & Bram Moolenaar)
- git (named after Linus)

I also use a screen terminal server to exit screens without stopping jobs. Most
people will tell you to use tmux. I use gnu screen which is always there.

- tmux
- GNU screen

The text wars are not over. It's vi(m) vs. emacs as much today as it ever was.
VSCode isn't even in the wings waiting to be tagged-into the fight because it's
built on du jour full web stack tech. It won't survive coming platform
disruptions. The Web is big but it's not as big as Terminal.

- vim
- emacs

Even if you choose vi(m), there's difference. I use plain old vim from Bram
Moolenaar that came out in 1991 on the Amiga Computer on Fred Fish 591. It's
the defacto standard, generally replacing the old Bill Joy vi original in most
modern popular versions of Linux.

- vim
- NeoVim

If you're on Windows 11 and want to jump on the Linux bandwagon, open a DOS COM
and type:

    wsl --install

After that, it will be easy to type:

    vim

But you won't know how to quit. Sorry, but keep at it. It's one of the handful
of the most important decisions you'll make in your life. I'll guide you along
to super-powers. The overarching direction I'm going with these videos is:

- Keep a journal in vim
- LXD under WSL
- systemd to make Linux services

This is an alternative to the "full web stack" JavaScript NodeJS direction
everyone else is going to lead you. Poof, what do you need? Poof, what do you
need? I am not a genie. WebDev is stupid. Get out of that tiny little living
space. Learn the context that even the webservers must be run from. Learn how
to write and schedule Linux Services. It's much more fundamental, powerful and
applicable across a larger problem domain and lifetime.

Systemd is much maligned. It's still the best thing going for this sort of
thing. The init.d system that came before it, which is still alive on Gentoo
and Arch Linux, requires you to become a Unix bash shell wizard. This is valid,
but go with the flow. Get the 80/20-rule advantage. Sometimes the mainstream is
right.

We will run Linux system services in a way that makes them utterly
understandable and almost as much fun (to me) as WebDev.

We will make them understandable by still looking at their terminal output (gnu
screen).

Lots of things try to "keep you" from learning vim, including the git default
configuration which sends you to alternatives. Alternative Terminal-based
Unix/Linux text editors that will try to block you from learning vim include:

- sun text editor
- pico (Unix)
- nano (Linux)

Don't give in. Open a terminal and type:

    vimtutor


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/a-tale-of-two-pipers/">A Tale of Two Pipers</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/install-zfsutils-linux-to-prep-for-lxd-on-wsl/">Install ZFSUtils-Linux To Prep For LXD on WSL</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li>
<li><h4><a href='/text-editor/'>Text Editor</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li></ul>