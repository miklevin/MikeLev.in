---
date: 2022-09-16
title: Install Script and Start Script for Jupyter on LXD on WSL on Windows
headline: Jupyter Now Runs on LXD on WSL on Windows - Read My Blog Post to Learn More!
description: I've created a script that enables Jupyter to run on LXD on WSL on Windows. I've included an install script for the desktop, a start script for when the system reboots, and some other commands to start Jupyter in the background. I'm currently testing the installation process to make sure everything works properly. Come read my blog post to learn more about this exciting development!
keywords: Jupyter, LXD, WSL, Windows, Install Script, Start Script, Desktop, Reboot, Background, Testing, Installation Process
categories: jupyter, wsl, container, microsoft, desktop
permalink: /blog/install-script-and-start-script-for-jupyter-on-lxd-on-wsl-on-windows/
layout: post
group: blog
---


The WSL 2 LXD install script is done and now I just need a way to get Jupyter
started (before I do daemons which I'll do a video on) after a reboot.

WSL -d Ubuntu-18.04 needs this in its /usr/local/sbin

    until
            lxc jupyterstart 2>/dev/null
    do
            sleep 1
    done

Wow, it's working. I just silenced jupyterstart with >/dev/null. Just pushed
that one. It's nice to see the visit localhost message on an LXD host login.
Speaking of which, the magic command to start Jupyter in the background is
reduced to:

    wsl -d Ubuntu-18.04 -e bash -c "exit"

You don't even need to do anything in the session, so you can logout
immediately. It just needs to be a bash session so the .bash_profile runs,
which in turn runs the /usr/local/sbin/j program, which uses that above
program to use an lxd alias... pshwew!

You know those expressions that the ancient magic is often the most powerful.
Well that's poo poo'd by the modern Microsoft crowd who like being forced into
proprietary power-tools just to get simple tasks done. But for everyone else,
there's Unix brought to you today in the flavor of Linux, and it's some
powerful ancient magic. I just coded up my greatest spell since Levinux, some
10 years ago. And it's a better spell-casting and sharing environment than it
was back then, so the time is ripe.

Okay, .bat files! Visit https://raw.githubusercontent.com/miklevin/wsl2lxd/main/install.bat

Select all and copy.

Go to your desktop, right-click and select New / Text Document.

Rename that text document install.bat. Be sure you actually give it the file
extension. The default mode is to hide known file-extensions which will result
in you naming it install.bat.txt which will not work. You may have to go to an
explorer window (Win+E) and go to View / Options, click the "View" tab and
uncheck "Hide extensions for known file types".

Right-click install.bat and select Edit. Launch with Notepad.

Click in the document, paste and Ctrl+S to save it. You can then close the
document. If it warns you, then you didn't save. Use File / Save from the
dropdown menu if needed.

Now just double-click the icon and hit Enter on your keyboard to allow the
script to start running. Sit back and wait awhile.

There is no more interactivity until the script is done, at which time it waits
for you to hit any key to release the script. The black screen will disappear.

Hit any key to dismiss the install window.

Go to Edge (because we'll be making an App of it) and visit
http://localhost:8888.

Enter the password "foo" and click the Login button.

Click ... / Apps / Install this site as an app

Okay, this takes care of the install and first run. But on subsequent runs
there needs to be a way to start the server.

Right-click on your desktop and select New / Text Document. Rename it to
start.bat and put this inside:

    wsl -d Ubuntu-18.04 -e bash -lic "exit"

Now after any fresh restart of your machine or accidental closing of the
Jupyter server, you can get it running again just by double-clicking this icon.

I'm still making sure that's solid. If it doesn't work, open a COM or
PowerShell window and type:

    wsl -d Ubuntu-18.04

...which will log you into the WSL "outer" Linux whose .bash_profile should
automatically start the Jupyter server in the LXD "inner" Linux.

Okay, wow this has been epic. Many echoes of Levinux. Walk away from it for a
little bit. I've got some other work to do. Test the install process one more
time just to make sure its latest status is proven working and percolating in
the background for next steps... done!


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/already-renamed-jupyme-to-wsl2lxd/">Already Renamed Jupyme to WSL2LXD</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/ubuntu1804-exe-ubuntu2004-exe-and-ubuntu2204-exe-oh-my/">ubuntu1804.exe, ubuntu2004.exe and ubuntu2204.exe Oh My!</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/container/'>Containers</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/desktop/'>Desktop</a></h4></li></ul>