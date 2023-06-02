---
date: 2023-05-13
title: undisruptable. Unsuppressible. Unstoppable. Unbreakable. Unconquerable. Indomitable.
headline: I'm determined to make sure JupyterLab runs in the background, powered by a Linux systemd service - and I'm not compromising on my principles!
description: Discover the power of running JupyterLab as a Linux systemd service with all the necessary and mostly uncompromising bits. Learn how to use Linux VMs to normalize paths, home directories, software versions, and more. Get to know the benefits of IP-cycling, web-browser automation, and other essential tools for SEO. Finally, understand the importance of free and open source tools for internalization skills and persistence of tools.
keywords: Undisruptable, Unsuppressible, Unstoppable, Unbreakable, Unconquerable, Indomitable, JupyterLab, Linux, systemd, Terminal, AI, Java, C-language, WORA, Notebook, Hosts, Google Colab, Kaggle, Azure Notebooks, Project Jupyter, Fernando Perez, iPython, MSI-installer, Cloud, AWS, IPVanish, HideMyAss, Browser Automation
categories: systemd, browser automation, linux, jupyter, ai
permalink: /blog/undisruptable-unsuppressible-unstoppable-unbreakable-unconquerable-indomitable/
layout: post
---


Undisruptable. Unsuppressible. Unstoppable. Unbreakable. Unconquerable.
Indomitable. Do these things resonate true for you. You'd think they lead to
perfection, right? Nope, if they did I'd put things like "unfailing" and
"unerring" in there. But I didn't. Ya gonna get your ass kicked and served to
you on a platter. Just look at my last post. I was determined to get a result:
JupyterLab continuing to run, powered by a Linux systemd service in the
background even when the last Linux Terminal is closed. It has some benefits,
which were the things I found to be the necessary and mostly uncompromising
bits. They include:

Running JupyterLab server as a systemd service in an identical way as every
other (non-Microsoft) systemd Linux would. Portability! This is important
because the Mac version is coming up. And a native Linux version? ***IT IS***
native Linux. All my stuff is stupid VM-wrapper tricks that just became
possible across all major platforms. This is a sea-change in tech as big as AI,
but nobody really gets it. Finally the promise of Java (and arguably even the
C-language before it) is being realized: Write Once, Run Anywhere (WORA). All
you need is a Linux VM to ***normalize*** your paths, home directories,
software versions, deployment techniques and all the rest. 

The next thing that couldn't be compromised on was making it run just as well
as it would run anywhere else, because there really are some good Notebook
hosts out there. It's a testament to their success that everyone drops the word
"Jupyter" when talking about Cloud Notebook hosts like Google Colab, Kaggle,
Azure Notebooks, etc. But they're all just JupyterLab servers. Nobody wants to
admit it but Project Jupyter came from the same guy, Fernando Perez, who
created the iPython engine that people are using as an excuse to not call it
Jupyter. "No, they're not Jupyter-hosts, they're Notebook hosts." Yeah, right.
I think I outdid the data science company's Anaconda, the Jupyter-Desktop
MSI-installer, and all Cloud servers or reasons you can read elsewhere, like in
the running install script.

The reasons tend to overlap a bit, but anyone running Jupyter locally, after
first figuring out how the frig to do it on a Mac or Windows machine, have to
deal with that strange little server-window you have to keep open all the time.
Or when you *can* close it, how to deal with it still running when you do the
frequent upgrades you should be doing with all the components. Like
Jupyter-Desktop on Windows forces you to go into Microsoft settings and
uninstall ***TWO components***, one of which is a mystery background thingie,
before you can upgrade. With the Linux version I provide, it's running under a
very formal, very hide-able, and still very monitor-able gnu screen session.
Formal APIs, commands, documentation, and everything. Much cleaner and less
mysterious than those black boxes and mystery background processes.

The Cloud you say? Ugh, I thought I covered that. No, you still want to use
Colab? Fine, go use Colab, but I'm what you call an "SEO" or a search engine
optimizer. That means I have 2 very specific things I can't compromise on. The
first is that I need to be able to change my IP from time to time,
***EASILY***. Go ahead and try to figure out how to do it on Colab. Go through
web proxies, squids or whatnot. Oh, and if you're on a popular Cloud host like
AWS, good luck with those IPs not being blocked on crawls. Me? This? I'll just
use one of the multitude of cheap VPN services out there targeting you on your
Windows or Mac machine such as IPVanish or HideMyAss. Great UIs. Cheap.
Automatable from scripts to cycle IPs and whatnot. Show-stopper for SEO. The
other thing is browser automation through tools such as Google Puppeteer or
Microsoft Playwright. The combination of IP-cycling and web-browser automation
is what makes many things the true Kung Fu experts in SEO possible. 

Did I mention undisruptable? You will be a person disrupted by an effect called
planned obsolescence if you are in the field of tech. If you're a young
hotshot, maybe on your first round of being a hardware-modding, AI prompting
crypto-mining dude, it probably hasn't happened to you yet. But you've heard of
Imposter Syndrome? You don't start out as an imposter. You get that way because
your favorite tool, no matter what it is an no matter how big and the center of
the world you think it is today (read as: VSCode, Docker, NodeJS, etc.), it
will be completely changed on you tomorrow. They may not change the product
name, but they will change the interface on you. Not just Dev-tools either.
Microsoft Office will switch to a "ribbon" user interface. Adobe will switch to
floating docking panels. And all will break your hard-earned, long-practiced
muscle memory. You will be disrupted. Then, you will be an imposter, likely
forced into management because keeping up with the changes has become a young
person's game... hahaha! In the interest of not bloating this paragraph any
farther: vim. Emacs, if you're a powerful wizard. vim, if you're like me.

But wait, Mike! You've been talking about NeoVim lately, not vim. What gives?
NeoVim is vim, for all intents and purposes. It's just a fork of vim that
supports Copilit, so you can have an AI-assistant typing along with you when
you need it. It will to that fabulously powerful auto-complete trick you're
seeing all over the web these days, mostly in VSCode, but also available in
NeoVim. And so that leads to the next uncompromising principle I had: the Linux
VM I provide must support all my work. It must be a Noah's Ark of all my secret
weapons. With just an additional light touch or two after the standard DrinkMe
install script, I've got my whole development platform, blogging system,
journal and journaling software, and all the rest. Hope floats. My dev platform
floats. This is better than Docker because it's a full VM, and you have
complete control when you want it: no kooky "compositing" API to learn, make
everything more difficult and lock you into a proprietary container format.
Just let a server-build script rebuild from scratch. No work for you either
way. The script does all the work. Be the ghost in the machine. Make no
particular instance of host-hardware (or OS) of any consequence. Nor even any
particular Docker or VM-image.

Big paragraph, huh? Hard to grok? Give yourself 20 or 30 years in the industry,
and you'll get it. Oh, you'll want to cash out by then and retire at 50? You'd
rather BE management than the guy who's managed? I guess that leads right into
the last thing. With local-running software under your control and so standard
that it'll run on any host hardware, you can develop and refine those technical
skills, those carpentry skills, those labor skills that previously were a
source of anxiety and negative conditioning because they were always being
reset on you. Imagine if your tech toolbox was not much different than a
carpenters toolbox. You'd have a hammer, a saw, a screwdriver, a drill, and a
few other basics. You can throw in a proprietary power-tool or two to get the
jobs done faster, but you don't really need them. And with all that time to
develop your craft and indeed master it, you will also find the love in it.
Because your tools are actually free and open source software with good
licences and without the traps and pitfalls of faux-open-source software, they
won't be able to take it away from you, or change the APIs on you to force you
to retrain, relearn, retool, re-buy or retire.

I'm getting ready to do what I call "cut catapult ropes". If I'm really as good
as I think I am, now that I ***want*** to sort of be successful, popping my
head up above the radar-level, perchance to be shot-down by the air-defense
systems, it's all about releasing the built-up potential that's already there.
Not doing too much new, but rather connecting the dots on everything I already
do and know, maybe sprinkling in a little accelerated and amplification effect
now because of Copilot, ChatGPT, Bing, Code Whisperer, the new one from Google.
But watch your dependences. I guess that's the last point. If your abilities
come from what is within, and free and open source tools definitely helps with
the internalization skills because of the persistence of tools.

This all comes up because I've been experimenting with the name Magic Trick
Linux for the heir apparent to Levinux, which is currently codenamed DrinkMe,
merely an install-script name. But it's coming together rapidly enough that
it's deserving of a new name and the concept of undisruptable is as near and
dear to my heart as magic tricks. Magic tricks occupied much of my youth, and
still resonates with me and gets to some of the essential vibe of what I'm
doing with DrinkMe. I don't need to use an Alice metaphor because sprinkling
just a few of those images will carry convey that as an attribute of the
distro. But undisruptable... undistruptable really gets to the heart of it.

Bad people try to disrupt you. They make drama and try to disrupt your life.
The economy can do the same thing. It's often about resources, and fear of
losing them, thereof. If someone's used to the easy flow of money, products,
lifestyle and the things they like and got used to and things become scares, be
prepared for disruption. People will want what's yours, so stuff you already
have is at risk. When things break and you have to buy replacements, you're
forced to re-settle into new hardware ***and*** be out the money. That's
double-disruption. So wheter it's a bad person or a bad economy, you want to
be undisruptable, and that means your particular "host hardware" is not
important. You can run on anything. You should apply this to your mobile phone
and tablets as well. Hardware doesn't matter.

Most humans don't think so. They covet the hardware. They get mad for matter.
They'll try to use it as power over you; a land ***lord***. Primitive emotions
like jealousy and envy are the root of it. Of course projection, and if I do
any disruption like I did with Scala, it's the disrupting of an abstract notion
like the status quo. Am I jealous or envious of the status quo? Perhaps being
the kind of person who can life a life of dull drudgery, never challenging
myself... Emotions like fear motivate me too, it just doesn't feel that way.
Wait, I know! I'll close with one of the most wonderful disruptive characters
in semi-modern Sci-Fi and Pop Culture: Q.

Let's dig up a YouTube link. Oh yes, The Best of Both Worlds. You can't do more
by playing it sage. Ciao!

{% include youtubePlayer.html id="LHoPLhpw2g4" %}










<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/down-down-down-would-systemd-going-down-under-wsl2-never-come-to-an-end/">Down, down, down! Would systemd going down under WSL2 never come to an end?</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/smart-people-read-dumb-people-tell-you-they-did-after-watching-the-movie/">Smart People Read. Dumb People Tell You They Did After Watching the Movie.</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/browser-automation/'>Browser Automation</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>