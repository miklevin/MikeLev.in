---
date: 2022-07-31
title: Do You Still Really Need Windows? Switching To Linux in 2022
headline: "Switching to Linux in 2022: Why Windows is Becoming Obsolete and Why Containers Under Linux are the Best Way to Future-Proof Your Work"
description: As tech becomes more and more essential to our daily lives, I'm discussing the importance of understanding generic tech, and why Windows is becoming obsolete. I'm exploring why Linux is the way to go, and why using containers under Linux is the best way to future-proof your work. I'm also discussing why Docker should be used from Windows and why it's important. Join me as I explain why it's essential to keep up with tech trends.
keywords: Windows, Linux, Containers, Docker, Tech Trends, Dev, Microsoft, Linux Terminal, Future-Proofing, Generic Tech, Proprietary, Literacy
categories: linux terminal, proprietary, linux, container, microsoft
permalink: /blog/do-you-still-really-need-windows-switching-to-linux-in-2022/
layout: post
---


Livecast from last night moved to this morning because my kid showed interest
in doing stuff together, yay! Back to the livestreaming... what a great point I
left off at. Stay humble getting livestreaming going again. Start simply with
.screenrc and see where that goes.

{% include youtubePlayer.html id="2KyHhFpcPks" %}

- You're stuck on a Windows 10 or 11 laptop
- The world is moving to Linux for all things "dev"
  - Particularly true of machine learning models that use your GPUs
  - M$ made sure your WSL2 Linux instance has GPU access (amazing)
- Microsoft made it "easy" to get a (non-graphics) Linux Terminal
- It's best to use containers under Linux (future-proofing)
  - You don't want to be tied to particular hardware instances
  - You don't want to be forced to use cloud services (you have places to run
    code)
- In those containers, the first skill to learn is controlling Linux Services
  called daemons (easier than you think).
- The "screen" program is the way to monitor your "python" running services.

Today we talk about "places to run code" and all the stupid labels of what our
setup (on our laptop) really is.

- Show how to know you're in a "gnu screen terminal session" (vs. direct)

When you install WSL you get the unified Windows Terminal installed I believe
automatically when you wsl --install. This functionally eliminates the need for
3rd party terminals. The "Unix-like Terminal" is now just a standard part of
Windows. This is a huge new reality. This shows us probably:

- Windows as you know it is going away (~5 years)
  - DOS Command Prompt will go away
  - PowerShell 5.x will go away
  - BASH Shell takes over the world (again)

- Show .screenrc "installed" to tell "screen sessions" from not.

What I am not (who I am not targeting):
- "Classing" developer or sysadmin or devops

What I am (who I am targeting):
- People who consider "tech" as just general literacy (like reading, writing &
  math)

What?

Yes. Since Unix-like OSes won, tech like this is general literacy. Just like
knowing English is knowing read/write, knowing \*nix is knowing generic pluming
of tech for much broader reasons (better life) than being a classic developer,
sysamins or devops.

Everyone

Who shouldn't know "generic" tech. There is generic tech now that the
proprietary stuff is on its way out.

You're going to hear a lot about Docker. Hype.

Why not "just use docker" for this? And why not Docker from Windows for even
more simplicity?


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/you-won-t-be-using-windows-in-5-years/">You Won't Be Using Windows in 5 Years</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/share-folder-between-windows-wsl-linux-container-and-home-cloud/">Share Folder Between Windows, WSL Linux, Container and Home Cloud</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux-terminal/'>Linux Terminal</a></h4></li>
<li><h4><a href='/proprietary/'>Proprietary</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>