---
date: 2023-08-05
title: Get My Cause? Jupyter Ubuntu! (Jupyter Notebook on Ubuntu on Windows)
headline: I'm transitioning my workflow to a new machine and embracing Linux with Jupyter Ubuntu!
description: Learn how to install Jupyter Notebook on Ubuntu on Windows with this step-by-step guide. Follow along as Mike Lev.in walks you through the process of setting up a server-build script, renaming the drinkme repo, and creating a Jupyter Ubuntu.bat script to install JupyterLab on Ubuntu Linux.
keywords: Windows 10, Windows 11, Windows Subsystem for Linux, WSL, Linux, Ubuntu, Debian-derived, JupyterLab, Python, Web browser, Microsoft Edge, Google Chrome, Levinux, Marcus Aurelius, Stoic philosophy, minimalism, server build scripts, batch files, DOS, Disk Operating System, Alice's Adventures in Wonderland, Wizard of Oz, MyKoz, My Cause, Mike OZ, AReal/OS, Jupyter Ubuntu
categories: linux, microsoft, jupyter, levinux, wsl, ubuntu, python
permalink: /blog/get-my-cause-jupyter-ubuntu-jupyter-notebook-on-ubuntu-on-windows/
layout: post
group: blog
---


I'm getting ready to yank my whole productivity system over to a new machine. I
have a Windows 10 and a Windows 11 machine that I shake and bake between.
That's like pouring the bread crumbs from one side to the other for those who
don't know the old-school reference. I decided to start the process with a
journal entry here on the Windows 11 machine that I'm trying to leave behind.
It's got a cracked screen, and well it's Windows 11. Otherwise the hardware is
identical, which is important for the next step.

If you ever have the choice of getting a top of the line laptop or two mid-range
laptops, go for the two mid-range laptops. You can shake and bake between them,
essentially incorporating "switching hardware" into your comfortable workflow.
The reason this is important is for developing the technical equivalent of
emotional resilience. You can't be too dependent on any one machine, or you
will be in a world of hurt when it breaks. And it will break.

Also, each time you switch hardware, it's an opportunity to change or test some
small thing. In this case, I'm moving back to a Windows 10 machine that's
stripped down to the bare essentials. It had a irrecovably corrupted crash, so
I had to actually reinstall Windows 10 from scratch using the product key and
all, so I'm using it as the ideal opportunity to "flow" back my entire scripted
workflow. Many people talk about virtual machines (VMs) or containers (Docker)
for this sort of work, but not me. It's all about server build scripts.

A server-build script that knits your system back together "from scratch" is so
much better than some bloated VM or container file. You can hardly move those
around without some hard drive or fast network connection. But a server build
script is just a text file that knows how to build your system back up from
parts. 

In the voice of that old commercial: "Parts, what parts?" to which the reply is
"Parts is parts...", which is a reference to the old Wendy's commercial nobody
will remember but me, the parts mostly reside in the latest and greatest
sources for the operating system (OS), which in this case Ubuntu 22.04 from the
Microsoft distribution for their Windows Subsystem for Linux (WSL). I could use
any Debian-derived Linux, but I'm using Ubuntu under WSL because of the massive
popularity of the Windows platform and formidable resources Microsoft has for
getting your old Windows laptop hardware running again. 

While you ***can*** install Linux OS on the metal using a USB keychain drive or
such, I don't think it's worth the trouble. I'm not a Linux purist. I'm a
pragmatist. Why not take the Microsoft hardware support if they're offering it,
and just run Linux inside Windows? It's a no-brainer.

This is the road less traveled, and certainly leaves what most people think is
the sexiest bit on the table, the part of Linux that seems to inexplicably
inspire the most passion: the desktop environment. I'm not a desktop
environment guy. I'm a command-line guy. I'm a server guy. I'm a scripting guy.
Once you make it a discussion of super-subjective desktop environments, you
undermine the whole reproducibility, portability and timelessness part of the
argument I'm making here. Desktops are plastic. They change. They follow trends
and fashions. They are not timeless. They are not reproducible. They are not
portable. They are not the stuff of server build scripts.

But building a server from parts so that you always have the same working
environment sounds so boring. Does that mean you "work" in an environment other
than a desktop? Yes. It means you work in a terminal. But I know how scary that
is for the mainstream population. I'm not trying to convert you quickly. I'm
trying to get you to use a Web browser with a Linux version of Python as an
intermediary step. You have to learn Python anyway, right? You've been looking
for a way anyway, right? Well, here it is. It's the ideal way that transitions
you to the world that runs the world: Linux servers!

Okay, so my server build script (I need a sexy name for that) is a text file
that you can copy and paste onto your Windows desktop. There's actually a few
text files that constitute the server-build script. The one that goes on your
Windows desktop, one I've been calling "drinkme.bat" for it's Alice's
Adventures in Wonderland reference, is the one that you double-click to run. It
fetches the main "install.bat" file, which I've come to calling "Rabbit
Hole.bat", which is the one that actually does the Windows-side work. Batch
files (with a .bat extension) are very old-school DOS (Disk Operating System)
stuff. This is what PCs used before there even was a Windows. It's the
equivalent of a shell script on Linux.

So the drinkme.bat file can stay the same pretty much forever... hmmm, maybe
not. It's time to change the "identity" of my Github repo from "drinkme" to the
new OS name I came up with this week: MyKoz! It has a nice Science Fiction ring
to it like the movie Zardoz, but it also works on so many other levels, as in
sounding like "My Cause" or "Mike OZ" (I love The Wizard of OZ as much as Alice
in Wonderland), or even in combination with MyKoz AReal/OS, it sounds a little
bit like Marcus Aurelius, the Roman Emperor whose Stoic philosophy is very much
reflected in the whole technological minimalism thing I'm doing here.

I know that's above the heads of most folks, and even just saying that will
come off as condescending. But so what? I'm going to be me, and people who get
bent over that sort of thing can get bent. Go read Marcus Aurelius's book
Meditations. It's not even that long and is in the category of "must read" for
anyone who wants to be a better person. It's not a religious book. It's a
philosophical book. It's a book about how to be a better person. I'd like to
say it's made a big impression on me, but it hasn't. I came to it way too late
in life, and if someone can get some good out of me mentioning it, then I'm
happy to do so.

Okay, so hit the iron while it's hot. Go rename the drinkme repo in Github to
MyKoz. Then go change the drinkme.bat file to MyKoz.bat. Then the file I've
named "Rabbit Hole.bat" might be better named "Replace Ubuntu.bat" because that
is what it does. It replaces the Ubuntu 20.04 LTS (Long Term Support) version
of Linux that currently gets installed by default by the Windows Subsystem for
Linux (WSL) with a new one configured for serving JupyterLab from the Linux
subsystem. It serves it into a Windows-side Web browser like Microsoft Edge or
Google Chrome. It's a seamless experience. You don't even know you're running
Linux. You just know you're running JupyterLab, which is a Web-based
programming environment that is the best thing since sliced bread. And it's
better still when Linux is serving it up, because it gets your foot in the
local Linux door.

Ugh, this takes bravery. It breaks everything temporarily, but it's not popular
yet, so the timing is right. Life changes on a dime (another ancient
expression), and so let's drop that dime on drinkme... okay, the repo is now
https://github.com/miklevin/mykoz

Wow, that's a big friggin deal! It's broken for everyone now including myself,
but that's okay because it's not popular yet. The local drinkme folder in my
repos folder needs to be renamed. That's a normal OS (Linux) rename, so I use
the command `mv drinkme mykoz`. Then I need to change the git repo endpoint. 
That's done with this command after cd'ing (changing current directory) into
mykoz:

```bash
git remote set-url origin git@github.com:miklevin/mykoz.git
```

Next, I do a `git pull` to make sure I did that correctly. Check! Nice, it's
almost like I've done this sort of thing many times before. Then I need to
change the name of the drinkme.bat file to... mykoz.bat? No, this is an
opportunity to get rid of some mystery. It doesn't really install mykoz. It
just gets what you need to do the install. So let's:

```bash
git mv drinkme.bat getmykoz.bat
```

Nice! Okay, now we need to redirect a few places where the old name is used. I
have a /ux/ that goes way back to Levinux, but Levinux while it still exists is
not what I want to be known for. It's taken on a sort of life of its own and
can take care of itself. It's for Linux tire-kickers who want to try Linux
without installing it, but it's besides the point (a curiosity) now that Linux
is so formally supported under Windows. The right way to do it is just to
plunge in so that you can start being productive. And choosing to back-end your
local JupyterLab with WSL Linux Python is so much better than using Levinux. It
starts the actual process. But redirecting these locations is actually a lower
priority than fixing the scripts functionally and messaging-wise.

Okay, so the now-named getmykoz.bat script gets to decide the name of the file
it creates when it fetches the actual install.bat script, which is aptly named
install.bat in the mykoz repo. However, after you click on getmykoz.bat, is
there something better than install.bat we can name it? Install what?
Currently, I name it "Rabbit Hole.bat" but the Alice metaphors are going away
during these steps that are critical to be as literal as possible. So in the
spirit of "get my koz" (get my cause), let's name the installer script
"Jupyter Ubuntu.bat". That's what it does. It installs JupyterLab on Ubuntu
Linux. It's a little bit of a mouthful, but it's clear. And you can almost
think of it as a command. "Jupyter Ubuntu!" It's a command to install Jupyter
on Ubuntu. It's a command to get my cause. It's a command to get mykoz.

Get my cause? Jupyter Ubuntu! Get my joke? It's awesome because it's spot-on
literal, but also packed with meaning.

Okay, I changed the name of the installer script to "Jupyter Ubuntu.bat" in the
version that's in the repo in Github. However, I have it at least 3 other
locations: my site's homepage and in the /ux/ folder, the /drinkme file and the
/mykoz/ folder. So it's time to change it on my homepage and /mykoz/, but then
turn those other 2 into meta redirects to the homepage. 

Plow through this. First the 2 locations that are not being redirected... okay,
done. Now refresh your memory on a Jekyll-style redirect. I can't do the
preferred 301 permanent server-style redirect because I don't have that level
of control over how github.io hosts pages. This is where old fashioned search
is going away in favor of conversational search. It's been awhile since I did a
Bing quote here:

Me: How do you do a redirect on a Github Pages github.io Jekyll page?

Bing: Hello, this is Bing. There are two ways to do a redirect on a GitHub Pages Jekyll site¹:

- Using the **JekyllRedirectFrom plugin**, which is whitelisted by GitHub Pages and can be used to set up multiple redirects for a URL. You need to add `jekyll-redirect-from` to your `_config.yml` file and then use the `redirect_from` or `redirect_to` keys in your front matter.
- Using a **redirected layout**, which uses a meta refresh tag to redirect the user to another URL. You need to create a layout file called `redirect.html` in your `_layouts` folder and then use the `redirect_to` key in your front matter.

For more details and examples, please see ¹. I hope this helps. 😊

¹: [How to redirect URLs on Jekyll site hosted on GitHub Pages](https://superdevresources.com/redirects-jekyll-github-pages/)

Source: Conversation with Bing, 8/4/2023

    (1) How to redirect URLs on Jekyll site hosted on GitHub Pages. https://superdevresources.com/redirects-jekyll-github-pages/.
    (2) GitHub - jekylltools/jekyll-random-redirect: Redirect to a random .... https://github.com/jekylltools/jekyll-random-redirect.
    (3) About GitHub Pages and Jekyll - GitHub Docs. https://docs.github.com/articles/redirects-on-github-pages.

Bing really does a great job with this. Google is starting to catch up, but
only in the Google mobile app where you can toggle between a conversational
result and one that has the citations interlaced with the result. But it
doesn't give such wonderful blog-ready markdown code as Bing.

Well, I'm not adding a Github plugin to my Jekyll site just for this. I tried
that in the past and it only did a meta redirect (HTML-based and not server
based) anyway. So I'll just do the meta redirect manually on a markdown page.
The recommendations make it complected with layouts and liquid template
variables, but for posterity's sake, here's the simplest way to do it:

```html
<!DOCTYPE html>
<html>
<head>
<link rel="canonical" href="{{ page.redirect_to }}"/>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="refresh" content="0;url=https://mikelev.in/mykoz/" />
</head>
<body>
    <h1>Redirecting...</h1>
      <a href="https://mikelev.in/mykoz/">Click here if you are not redirected.<a>
      <script>location='https://mikelev.in/mykoz/'</script>
</body>
</html>
```

Okay, all roads now lead to either my homepage or the /mykoz/ page. That's
enough for one journal entry, don't you think?

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/simplifying-websites-and-life-with-single-long-text-files/">Simplifying Websites and Life with Single Long Text Files</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-tow-it-ism-tech-philosophy/">The Tow-It-Ism Tech Philosophy</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/levinux/'>Levinux</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>