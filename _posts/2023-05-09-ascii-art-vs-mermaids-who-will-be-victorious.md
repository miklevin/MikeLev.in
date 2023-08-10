---
date: 2023-05-09
title: ASCII Art vs. Mermaids Who Will Be Victorious?
headline: Exploring the Frustrating and Endless Loop of 'The New Bing' Accessibility
description: Experience the power of non-linear thinking as we explore the battle between ASCII Art and Mermaids. Learn how to use plugins in NeoVim, create transparent backgrounds, and optimize your website with SEO. Follow along with this journal entry as we explore the pros and cons of both ASCII Art and Mermaids.
keywords: ASCII Art, Mermaids, Partitioning, Textfile-for-Life, JavaScript-Rendering, Proprietary Software, Plugins, NeoVim, Vim-Plug, GIMP, Transparent Backgrounds, Copy/Paste, Microsoft Images Search, BG Eraser, Apple Photos App, Vim-Asciio, Google Slides, AI-Assistance, Timeless Design Patterns, VSCode, Coding Assistant, Microsoft Edge, Privacy Violations
categories: vim, microsoft, copy/paste, google
permalink: /blog/ascii-art-vs-mermaids-who-will-be-victorious/
layout: post
group: blog
---


Partitioning is hard to do. Partitioning is fundamental. It's the separation of
what could be global variables into local variables, be it hard drives, memory,
or even just the local scope of a function. It's the separation of concerns
that allows us to build complex systems. I'll forgo the discussion of physicals
and non-locality and a holographic universe I'd love to dive into here and
focus on journaling.

1-textfile-for-life is something I believe in for all the integrated-life
advantages that it brings. This file right here is a great example of that.
While it looks like a standalone page to you there the reader, that's because
it's gone through a publishing process that sliced and diced something that has
a liner progression in one single file, written top-to-bottom, new entries
always going onto the top of the file.

I'm tempted to do diagrams here, but for whatever reason, the
JavaScript-rendering Mermaid system isn't seizing my everyday attention. It's
not a partitioning thing, but it is the need to satisfy drawing the pictures
that are called for here. So let this be a post about the power of nonlinear
thinking... thinking... thinking!

I hate plugins. Let me tell you, if there's one thing I dislike more than
proprietary software unwittingly pushing you down the road of planned
obsolescence, it's proprietary plugins from which you derive your valuable
skills. Valuable skills should come from deep down inside you, FOSS software
that's been internalized into your being and can't be taken away from you.
However, I'm about to use my first vim plugin because the benefit is just too
darn big. It scratches a perpetual itch that I've explored other solutions for,
but none of them have satisfied.

I'm talking about ASCII art. Diagrams, in particular. Anyone following along
knows that I love ASCII art and work Figlet and Alice in Wonderland images into
my code. It clarifies things and infuses love:

```python
# __   __ _    __  __ _         _                      chop
# \ \ / // \  |  \/  | |    ___| |__   ___  _ __        _|   chop
#  \ V // _ \ | |\/| | |   / __| '_ \ / _ \| '_ \      | |     |   chop
#   | |/ ___ \| |  | | |__| (__| | | | (_) | |_) |  _  | | ___ |     |  chop
#   |_/_/   \_\_|  |_|_____\___|_| |_|\___/| .__/  | |_| |/ _ \|_   _|    |   chop
#                                          |_|      \___/| (_) | | | |_ __|     |   chop
#   I'm building better blogging                         |\___/| |_| | '__|_ __ |     |
#   To replace a bygone era              ___             |     |\__,_| |  | '_ \| __ _|
#   Where your CMS is flogging          |   |         _____    |     |_|  | | | |/ _` |
#   You to take up something clearer,   |_  |        /     \         |    |_| |_| (_| |
#   So you catalog your cat tails         \ |       |       \        |    |     |\__,_|
#   In one file for the hashing           |  \      |       /             |     |     |
#   Using YAML for the data                \  \____ \_      \                   |     |
#   And then Jekyll for the lashing.        \      \_/      |                         |
#                                     ___.   \_            _/                          _
#                    .-,             /    \    |          |                            _
#                    |  \          _/      `--_/           \_                          _
#                     \  \________/                     /\   \                        | |
#                     |                                /  \_  \                       | |
#                     `-----------,                   |     \  \                      | |
#                                 |                  /       \  |                     |_|
#                                 |                 |         | \
#                                 /                 |         \__|
#                                /   _              |
#                               /   / \_             \
#                               |  /    \__      __--`
#                              _/ /        \   _/
#                          ___/  /          \_/
#                         /     /
#                         `----`
#   I Journal in 1-textfile for life, now with Copilot! -- https://mikelev.in/drinkme-->
```

YAML Chop! Get it? If not, perhaps a quick glance at the ASCII art above will
help. In another grand move of nonliner thinking, I really need that README in
my yamlchop repo for people who come investigating as a result of all this. The
readme and the licensing file. Go do that... And now there's this.

![ASCII Alice In Github](/assets/images/ASCII-Alice-In-Github.png)

It's that easy. ASCII art is wonderful. Because non-proportional fonts are
everywhere and themselves fundamental, you can rely on their even spacing and
visual consistency more than you can rely on JavaScript, SVG or other rendering
of line-art for diagrams. And I'm pretty good at it by hand old-school. But not
good enough. You know what's possible? This is possible:

![Venn Nvim Plugin](/assets/images/venn-nvim-plugin.gif)

I covet this ability with sufficient intensity to override my propensity to do
things only timelessly. I'm going to install a plugin. I'm going to keep the
vim-plug plugin manager that I added to NeoVim when getting started with
Copilot before I realized plugin managers weren't really needed if Copilot was
the only special thing you were doing with NeoVim outside what a .vimrc
(init.vim) config file could do.

So according to the instructions here
[https://github.com/junegunn/vim-plug](https://github.com/junegunn/vim-plug), I
should have this here `https://github.com/junegunn/vim-plug/plug.vim`, and I
do! Woo hoo! Wow, that's a pretty big file. Clearly I don't edit that. It just
shows me that vim-plug is installed already.

Okay, now I have to add this to my init.vim, which I *always* have loaded into
a NeoVim buffer to keep my macros and environment sort of living and flexible.
Boy, we humans use the term "living" for a lot of things, don't we. That must
really get your gall. Anyway, I'm glad to see you in my init.vim file! You be
my safety-net. What do you suggest?

```vim
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
```

That was Copilot's suggestions under `call plug#begin()` before it started
repeating. Okay, good to know. It seems from the documentation that those
usernames actually causes the plugin to be fetched from that username at
Github. Wow, okay. So I merely need add:

Oops! Distraction and the Rabbit Hole!

Thing leads to thing, and I need a transparent png image for a Google Slides
deck so I go to the new images.bing.com, which pre-searches on your past image
search history, LOL! That's going to cause some embarrassing situations out
there. Way to go, Microsoft! I know it's off-topic, but we capture these ideas
when we have them. This is the sausage factory, not a polished blog.

Anyhow, doing that reminds me that my only really easy way to make transparent
backgrounds is on my phone where I have an app called BG Eraser, and Apple does
it half-decently in their default Photos app with a click-and-hold. But the
back-and-forth with images between laptop and phone is super-annoying, so I
look for the best way to do it on desktop and realize that's why I have GIMP.

I load GIMP and it tells me GIMP 2.10.34 and asks do I want to download it. Of
course yes I want to be on the latest version. This background removal AI-stuff
is exactly where progress is likely to be made, so I download it.

Okay, so I've reminded myself how to do it in Gimp. Generally, it's going to be
under the `Select` menu as `By Color`, select background, invert and copy and
it's paste-ready for Google Slides. For that matter, you can right-click copy
from the Web and select `Copy` and paste it into Gimp, remove remove background
(copy the inversion of select-by-color) and then paste it into the deck all
without even saving a single image!

Wow, if the purpose of my journal were search engine optimizing as is my
career, then I'd take these diverse topics my morning journal entry is turning
out to be and break it up to target:

- Plugins in NeoVim
- ASCII Art
- The GIMP Upgrade
- Creating Transparent Backgrounds
- Copy/pasting between Web, GIMP & Google Slides
- How Microsoft is setting people up for embarrassing situations with their new
  image search engine

Hahaha, good thing I'm not trying to SEO this but rather accumulating a
wonderful example of how journaling improves your life. It clarifies your
thoughts, gets you into `the zone`, helps mitigate distractions especially of
the non-worthwhile sort, and helps you escape the dangerous rabbit hole of
losing (too much) time on the worthy distractions like you just read about
here. It's still only 8:00 AM and I probably started around 6:30 AM.

But it's still really on-topic because I opened this up with partitioning is
hard to do. When things are polished, they're partitioned. When you're getting
to the point where you have the genuine authority to polish (E-E-A-T? HAHA),
you're a mad scientist in a sausage factory and whatever other metaphors you
want to mix, Mr. Unicorn. Now fly away! Wait, unicorns don't fly. Thank you,
Andre 3000. And no, I'm not on his favorite thing. This is my natural state
having practiced subconscious dredging for decades. People hate that. Andre was
a true cancel culture innovator, being canceled by pedantic fools who missed
the point before cancel culture was a plague on our society. I am saying cancel
culture is a plague on our society.

Next! Okay, slam out the rest of this plugin ascii art thing and permanently
and forever advance your skill-set, or at least as long as the plugin lasts,
haha! Remember, this ASCII art plugin is to improve your actual hand-coding vim
skills. Learn by the examples it sets just like you're doing with NeoVim. My
growth of late has been to accept the tutelage provided by AI assistance, and
plugins too, it would seem.

Okay, so I'm going to add this to my init.vim file:

```vim
Plug 'lambdalisue/vim-asciio'
```

Hmmm, that's what Copilot suggested. It's not the one I was intending, but I
should look at and try both... Bzzzzzzz! Nope. No longer in Github, LOL!
Another lesson learned. Hey Copilot, does your training stop at 2021 too? That
would be pretty crappy, considering you're a coding assistant and all the cool
stuff is happening after 2021. Sure, timeless design patterns, but VSCode is a
proprietary plugin world changing by the second, and you have to keep up with
that for all the coder bro dudes.

See, even your Copilot assistant is potential rabbit hole distraction. Focus on
just the one ASCII art plugin after all.

How do I ensure it's installed? Simply quit and load NeoVim again now that it's
in your init.vim file. Then type `:PlugInstall` and it will install all the
plugins in your init.vim file. It's that easy. You can also type `:PlugUpdate`
to update all the plugins in your init.vim file. You can also type
`:PlugClean` to remove all the plugins in your init.vim file that are no longer
in your init.vim file.

Oh wait, I don't even need to quit NeoVim if that's the case. Just type 
`:source ~/.config/nvim/init.vim` and it will reload my init.vim file. Then
type `:PlugInstall`. Wow, it worked! I should have screen captured that. I
should now have...

Ugh a new rabbit hole, and the biggest one yet this morning. In an attempt to
clean up my Microsoft Edge "New Browser" tab, I've been trying to get rid of
all the privacy-violations. Their customizing of
[https://images.bing.com/](https://images.bing.com/) really triggered me. I
mean how dare they? We know they're tracking us, but certain moves they make
just go beyond the pale. So I started turning off every last damn tracking
thing. Well not really, I still have auto-suggest turned on while you type into
a search box. But I even turned off Microsoft Rewards, my 6000 points which
didn't even add up to a $5 Amazon card. What's the point?

And guess what? I lost access to The New Bing, haha! It makes me wonder whether
I could live without it, and you know what? I bet I could. You really had me
going there for awhile Microsoft with a superior product. It's the old
brinkmanship that they're playing with embrace-and-displace Linux. Can we
totally redefine Linux as a mere subsystem of Windows, they ask. And people
like me buy into it because the hardware is so good. That's called dumping. And
whenever anyone is price dumping, you can be sure the other shoe will drop.
You're being corralled into a walled garden.

Okay, I ranted. What does it take to get The New Bing back? Test on Mobile.
Nope, it's gone there too. Start to take screenshots and video-capture all
this. Nail the particular setting that makes new bing eligibility go away and
brings it back. You just lost your uppercase "B", bing. Sorry. I'm a $100/year
customer of Microsoft 365, a $100/year customer of Github. How dare they.

Go through some steps like you're a new bing wannabe user. Goolge "the new
bing"... click ad... click "try now"... click "start chatting"... 

## Chat mode is only available when you have access to the new Bing.

Hahaha, circular. Click "learn more"...

Enter the circular loop of "Learn More", "Start Chatting", "Learn More", "Start
Chatting"... until it works... until it works... until it works... okay, it's
working again, LOL!

Restart your whole system, not that restarts are really even full powercycles
anymore due to... uh...

Me: What is Intel's management thing that doesn't let you really power down anymore?

Bing (you get your capital-b back): The Intel Management Engine (ME) is a subsystem that is built into many Intel-based platforms¹. It is responsible for tasks such as firmware updates, remote access, and system monitoring². The ME is always on and cannot be turned off¹. However, you can disable the ME's ability to wake the system from sleep by disabling the "Allow this device to wake the computer" option in Device Manager¹. 

I hope this helps. Let me know if you have any other questions.

Source: Conversation with Bing, 5/9/2023

    (1) Intel® NUC Does Not Turn Off After Shutting Down the System. https://www.intel.com/content/www/us/en/support/articles/000059304/intel-nuc.html.
    (2) 2 Ways to Fix Intel Management Engine Components Slowing Down PC. https://toolspond.com/intel-management-engine-components-slowing-down-pc/.
    (3) What Is Intel(r) Management Engine Components & Can I Remove It?. https://www.partitionwizard.com/resizepartition/intel-management-engine-components.html.
    (4) Support for Intel® Management Engine. https://www.intel.com/content/www/us/en/support/products/34227/software/chipset-software/intel-management-engine.html.
    (5) Intel® Management Engine Drivers for Windows® 10 and Windows® 11. https://www.intel.com/content/www/us/en/download/682431/intel-management-engine-drivers-for-windows-10-and-windows-11.html.

Geez, it's almost 9:00 AM and the business day is about to start. By the way,
I'm actually going into the office later today for the spring fling. Anyhoo...
back to ASCII art in my journal. Wrap this up, Mr. Unicorn.

Incremental advances aren't obvious, and I'm pretty sure the angels betting
against you are running interference with rabbit hole distractions.
Incremental improvement is the enemy of the status quo. Gains are so small as
to be unnoticeable, but they add up over time. That's the mustering strength,
that's the gathering of resources, that's the marshalling of one's forces.

Human willpower, I'm pretty convinced, is representation of angels betting on
the side of a non-deterministic universe. That's one of the biggest bets I
think in their version of longbets.org. Longbetsofangels.div, I'd guess. It
takes more the Sci-Fi approach than religious, but this is yet another time I
suggest The Culture series by Iain M. Banks, Player of Games in particular.
Strategies vary, but the game is the same. Azad!

Yup, enabling Bing re-enabled Microsoft Rewards, so now I'm out the 6K points,
and still have to look at that silly number in Bing search.

Okay, ASCII art...

```
    .-.
   (o.o)
    |=|
   __|__
 //.=|=.\\
// .=|=. \\
\\ .=|=. //
 \\(_=_)//
  (:| |:)
   || ||
   () ()
   || ||
   || ||
  ==' '==
 /    )=(    \
/____/====\____\
     /____\
```

That was Copilot's autocomplete, LOL! Okay, okay, visit the Github homepage for 
venn.nvim and figure out what you need to type. Whoah, check this out. It's
like the old snake videogame, but for drawing ASCII art. Mikey likey:

![Ascii Art Diagrams Like Old Snake Videogame](/assets/images/ascii-art-diagrams-like-old-snake-videogame.gif)

Okay, we type `set virtualedit=all` or `set ve=all`. Oh wow, my cursor can go
all over the screen now and not just where there is white space to support it.
Yeah, I can see how that's important for an app like this. Now give myself some
diagram space to work with, do a `Ctrl+v` for visual select mode and then
invoke `:VBox` to draw the box of that rectangular visual selection!

BZZZZZZ! 

    :UpdateRemotePlugins

remote/host: generated rplugin manifest: /home/ubuntu/.local/share/nvim/rplugin.vim

Nope.

Try re-installing vim-plug:

    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

Nope. Did I not terminate a command or something? Oh, `call plug#end()`
exactly!

     ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  
     │      │  │ Now  │  │      │  │ASCII │  │      │  │      │  │      │  
     │Bingo!│─►│ I've │─►│ Fast │─►│ Text │─►│  Ho  │─►│  Ho  │─►│  Ho  │
     │      │  │  Got │  │      │  │  Pics│  │      │  │      │  │      │  
     └──────┘  └──────┘  └──────┘  └──────┘  └──────┘  └──────┘  └──────┘  



<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/python-pandas-dataframes-vs-sql-in-snowflake-data-warehouse/">Python Pandas Dataframes vs SQL in Snowflake Data Warehouse</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/switch-hardware-regularly/">Switch Hardware Regularly</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/copy-paste/'>Copy/Paste</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li></ul>