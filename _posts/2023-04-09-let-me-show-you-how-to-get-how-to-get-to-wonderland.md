---
date: 2023-04-09
title: Let Me Show You How to Get, How to Get to Wonderland
headline: Discovering the Wonders of Linux, Python, Vim & Git (LPvg) Toolset
description: I embarked on a journey to learn the Linux, Python, vim & git (LPvg) toolset, even though I was tempted to pursue the full web stack or Macromedia/Adobe Flash development. After coming to terms with the fact that I was wrong about vim not actually being terrible, I decided to learn it in pieces, starting with daily journaling. You can too. It's so worth it.
keywords: Linux, Python, Vim, Git, Web Development, Web Stack, Macromedia, Adobe Flash, User Interface, Tech, Journaling, JupyterLab, Linux-hosted
categories: journaling, git, python, jupyter, vim, linux, web development
permalink: /blog/let-me-show-you-how-to-get-how-to-get-to-wonderland/
layout: post
---


I need to get down the series of concepts that build up to the overall Linux,
Python, vim & git (LPvg) toolset way of thinking and working that I'm
advocating. It takes too much for people to get their on their own. Mine was an
unlikely journey, and I could have very easily ended up on the full web stack
or as a Macromedia/Adobe Flash developer. But I didn't. I found my way to
Python.

So overall that means that the sexiest user interface WebDev work is kinda off
the table for me. Mikey no likey. The 80/20-rule that I aspire to abide by so
much is big-time violated with the full web stack. With 80% of the overall
effort you're willing to invest in a thing, you find yourself only 20% of the
way towards where you need to be. And that's if you're lucky.

So through the timing of my going on my find-the-timeless-tech trek, or by
whatever means, I bounced around all the pieces until they each settled on a
layer of the LPvg stack. And then I started to see the whole picture. Linux
provided a sufficient approximation of the Unix environment and brought its own
GNU tools. Python was the glue that held it all together. vim was the editor
that I could use to edit all the files. And git was the version control system
that I could use to keep track of all the changes.

That's about all it takes for most of the things you'll ever need to do in
tech, if your thing isn't specifically to promote and use proprietary tools so
that somebody can make more money. There are edge cases, and you will know them
if you ever tried to do them from an LPvg perspective. Web, as I mentioned, but
also Mobile. What? Both Web and Mobile off the table? Well, not completely off
but there's also Google's GoLang, and Mozilla's RustLang, aka just Go and Rust.

But I have no intention to go rusting. Let the systems people, driver-writers
and code-optimizers hold the opinions favored by the massively scaling. I don't
like being forced to think in concurrent terms. I can't say much about Rust
because that's one I haven't tried. But Go I'm not crazy about, and also Ruby
I'm no big fan of. Being forced to think in object oriented terms, as Ruby
does, is not my thing. Python, while opinionated, doesn't force you to think
quite so OO-oriented, and certainly not so concurrency-oriented.

Many languages kludge in this feature and that, as they become beloved and
popular in other languages. A precursor to Python for Unix/Linux scripting
stuff was PERL, and PERL was definitely a kludge. It hurt it during the big
modernization during which time most things added support for object oriented
style. PERL finally made the transition, but somehow it never felt quite right.
Meanwhile, the way syntax-impacting features like list comprehensions,
functional anonymous lambdas, and the like, were added to Python, it felt like
it was always meant to be that way.

Now also never underestimate the power of licensing. Python is licensed under
the MIT license, which is a permissive license. It's not copyleft, which is
what the GPL is. The GPL is a copyleft license. It's a license that says that
if you use this software, you must also release your own software under the
same license. This is a way to ensure that the software remains free and open
source. MIT is so permissive that anyone can do anything they want with Python
and nobody has to pay Guido van Rossum a dime. And that's a good thing.

It means today that Python is used for many things, including embedding into
other products as an easy way of giving a product an API. Well, easy but maybe
not as easy as the Lua language. Lua is also a scripting language that gets
built into a lot of products. But Lua is also a lot smaller and simpler than
Python. So it's a tradeoff. But you get the idea. If you need an API or a code
execution engine, Python is a good choice. You don't have to pay anyone
anything, nor give anything back to the community.

So the Linux, Python combination is something of a two plus two equals five
situation. If you get adept at this duo, tech will never completely disapoint
you. You'll always be able to find a way to make it work. And you'll be able to
do it in a way that's not too far from the way that the pros do it. Again, the
80/20-rule is being applied here. Linux and Python are the 20% that you need to
get 80% of the way there.

And then there's vim. I've been using vim for a long time. I've been exposed to
it since 1991 on the Amiga computer through the Philadelphia Amiga Users Group,
but I didn't really start using it until 2009 when my kid was on the way and I
realized that if I wanted to continue to be a decently well paid provider for
my kid, I couldn't have everything I know in tech go obsolete on me... again.

I at first was repulsed from vim because someone who I did not respect very
much at all said to me after I told him I was taking up Linux, "Oh, so then I
guess you be having to take up vim" in such an obnoxious way that I was like
"No, I'm not going to take up vim. I'm going to use pico or nano or something.
Even the Sun text editor is better than vim." But I was wrong.

Coming to grips with the fact that that butthole was right about vim was some
of most humble pie I've ever had to eat. But I'm glad I did. Once you get past
that whole learning to quit vim thing, learning gets easier. They even build in
a vim tutor. And it's not like you have to learn it all at once. You can learn
it in pieces. For example, I recommend getting started using it for daily
journaling, so you don't have to worry about actually having to code in it
right away. Code in the much friendlier to get started with Jupyter Notebook.

At this point the real issue to address is the fact that few people are going
to want to install Linux as their primary OS. I mean, I'm not saying that
nobody will, but it's not going to be the majority of people. So what's the
solution? Well, Linux has really just become so popular for all the server
stuff, like "hosting" Jupyter Notebooks for your browser to access, that Linux
is already there in most cases. Or it's just running a script to configure
a virtual machine and build the Linux server just so.

I call this process chasing the white rabbit down the rabbit hole. The Linux VM
creates Wonderland back there somewhere on your machine. And then you can
access it from your browser. Therefore chasing the white rabbit into Wonderland
is not as scary as the command-line stuff or switching to an unfamiliar desktop
environment with less support than people feel they need.

So stay on whatever you're familiar and comfortable with. If you're a Mac user,
keep using your Mac. If you're a Windows user, keep using your Windows. But
start also using LPvg via a Linux-hosted JupyterLab accessible at
http://localhost:8888. You can do this by running the DrinkMe script found at
[https://mikelev.in/drinkme](https://mikelev.in/drinkme). You copy the contents
of that page to a local install.bat file and double-click it on your Windows 10
or 11 desktop, and Voila! You're in Wonderland.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/refining-my-vimrc-now-that-it-s-a-neovim-init-vim/">Refining my .vimrc now that it's a NeoVim init.vim</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/blog-slice-dice-system-re-written-in-a-day/">Blog Slice & Dice System Re-Written In a Day</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/web-development/'>Web Development</a></h4></li></ul>