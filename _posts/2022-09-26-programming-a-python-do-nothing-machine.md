---
date: 2022-09-26
title: Programming a Python Do Nothing Machine
headline: Exploring the Possibilities of a Python Do Nothing Machine
description: I'm writing a program in Python to create a Do Nothing Machine. Using a command-line, I'm coding a loop that will run until a particular file is removed. The loop will print out the number of seconds it has been running, and once the file is removed, it will print 'Need new IP' and create a new file to reset the counter. Follow my journey as I create this program and explore the possibilities of the Do Nothing Machine.
keywords: Python, Programming, Do Nothing Machine, Command-Line, Loop, File, Remove, Seconds, Counter, Create, Program, Possibilities, Journey
categories: linux, python, coding, loop
permalink: /blog/programming-a-python-do-nothing-machine/
layout: post
---


This is one of those cases where I really have to use this journal to help
discipline myself to dig into my work. The current item is quite a challenge.
It is a long-running SERP job that will require cycling IPs, but I lost my
IP-cycling code and it won't run Linux-side because it automates Windows
desktop to click buttons on my desktop VPN software. Okay, so the solution is
to break it in two. I don't want to backslide on my Linux Jupyter progress but
I don't want to give up the power of automating things on a Windows desktop
through pywinauto. Okay, that's where to start.

Unlike most times, this starts coding in a command-line (as opposed to
Jupyter). And we start with the simplest of loops:

```python
from time import sleep


print("Starting")

while True:
    print(".", end="", flush=True)
    sleep(1)
```

YES! Documenting the process makes it love-worthy and now I can focus. Okay,
the flush is necessary because a period is too small to register. But I will
want a count of how many... what? Seconds? Yes! So here's that version:

```python
from time import sleep, time


print("Starting")

start = time()
while True:
    print(f"{int(time() - start)} ", end="", flush=True)
    sleep(1)
```

And so it should only ever continue while a particular file is in location.
When it is removed, the loop should stop. Okay, this is my first thought.

```python
from time import sleep, time
from pathlib import Path


print("Starting")

start = time()
while True:
    if Path("goodip.txt").is_file():
        print(f"{int(time() - start)} ", end="", flush=True)
        sleep(1)
    else:
        print("Need new IP")
        break
```

I'm not so sure the loop should stop. Rather, the new IP should be issued and a
new start time assigned. The number should always represent the number of
seconds since getting issued the new IP. I used the "touch" program to create
goodip.txt so I can recreate it easily and should test what removing it does.
Oh, removing it should put it back and reset the counter! Haha! It's a
do-nothing machine. Okay, here's my Do Nothing machine. Every time you delete
goodip.txt it restarts the timer at zero and creates a new goodip.txt file.
Woot! Okay, the rest is just pywinauto stuff.

```python
from time import sleep, time
from pathlib import Path


print("Starting")

start = time()
while True:
    if Path("goodip.txt").exists():
        print(f"{int(time() - start)} ", end="", flush=True)
        sleep(1)
    else:
        print("Need new IP")
        start = time()
        with open("goodip.txt", "w+") as fh:
            fh.write("foo")
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/failed-to-get-this-going-during-weekend/">Failed To Get This Going During Weekend</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/automating-cycling-ips-on-hma-vpn-using-pywinauto/">Automating Cycling IPs on HMA VPN Using PyWinAuto</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/coding/'>Coding</a></h4></li>
<li><h4><a href='/loop/'>Loop</a></h4></li></ul>