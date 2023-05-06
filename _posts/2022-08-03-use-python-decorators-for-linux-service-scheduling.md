---
date: 2022-08-03
title: Use Python Decorators For Linux Service Scheduling
headline: Exploring Coding and Diminishing Reliance on Fads with Python, Huey, and More
description: I'm using Python's schedule module to create a Linux service and switching to decorators with Huey. I'm using Windows 10 with virtual desktops and WSL2, Linux containers with LXD, and two files under /etc/systemd/system. I'm passionate about coding and writing and am focusing on learning huey scheduling, pyppeteer or Microsoft Playwright, and database persistence. Join me on my journey as I explore coding and diminishing my reliance on fads and trends.
keywords: Python, Decorators, Linux, Service, Scheduling, Windows, 10, Virtual, Desktops, WSL2, Containers, LXD, /etc/systemd/system, Coding, Writing, Huey, Pyppeteer, Microsoft, Playwright, Database, Persistence, Linux, Vim, Git, BASH, Script, C, LISP, Dialects, JavaScript, Fads, Trends
categories: microsoft, git, wsl2, lxd, python, linux, script, coding, javascript, service, database, containers, vim
permalink: /blog/use-python-decorators-for-linux-service-scheduling/
layout: post
---


We're almost at data pipelines and using Huey which I already installed from
PyPI with pip install huey on one of my Linux containers. Before I get there, I
need to take advantage of one more feature of PyPI's schedule module that I've
been using for the past few videos.

Also solve that annoying problem of having to wait a full minute for every
test. I should be able to schedule a test (like emailing myself pictures of
cats) x-seconds after I run the scheduler, and it should be able to only run
once. Get that x-seconds wait and the run-once logic done.

Then switch the scheduling to decorators, setting things up for the Huey
switch-over, which exclusively uses decorators.

{% include youtubePlayer.html id="Ty7HUjg65ZI" %}

Get ready for the livestream. On every one, try to:

- Give a few words of exposition.
  - We're on Windows 10 using virtual desktops & WSL2
  - We're using Linux containers using LXD (not Docker)
  - This is my journal. Next is JupyterLab, then is the Web browser.
- Explain what we're trying to accomplish.
- Show the set-up files (in Jupyter)
- Move it to container as a Linux service

For Joseph, here's the 2 files that pull this off on a Linux system. First is
put under /etc/systemd/system/scheduler.service:

```python
[Unit]
Description=Run Python script to handle scheduling

[Service]
Type=forking
Restart=always
RestartSec=5
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu/github/scheduler/
ExecStart=/usr/bin/screen -dmS scheduler /home/ubuntu/py310/bin/python3.10 /home/ubuntu/github/scheduler/scheduler.py
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=multi-user.target
```

The other file is the one referred to by this.

```python
import shlex
# import schedule
from time import sleep
from os import environ
from sys import stdout
from subprocess import Popen, PIPE
from datetime import datetime, date, timedelta
from schedule import every, repeat, run_pending, CancelJob


pulse_count = 0
print("The pulse service has started.")


def run(command, cwd=None):
    process = Popen(
        shlex.split(command),
        stdout=PIPE,
        cwd=cwd,
        bufsize=1,
        universal_newlines=True,
        shell=False,
    )
    for line in process.stdout:
        line = line.rstrip()
        print(line)
        stdout.flush()


def seconds_from_now(secs):
    today = date.today()
    atime = datetime.now().time()
    asoon = datetime.combine(today, atime) + timedelta(seconds=secs)
    return asoon


@repeat(every(10).seconds)
def hello():
    print("Hello World")


@repeat(every(5).seconds)
def pulse():
    global pulse_count
    pulse_count += 1
    anow = f"{pulse_count} - {datetime.now()}"
    with open('/tmp/scheduler.txt', 'a') as fh:
        print(f"{anow} is written to /tmp/scheduler.txt")
        fh.write((anow) + '\n')


@repeat(every().day.at(seconds_from_now(11).strftime("%H:%M:%S")))
def sendmail():
    print("Sending email")
    pyx = "/home/ubuntu/py310/bin/python3.10"
    cwd = "/home/ubuntu/github/scheduler/"
    cmd = f"{pyx} {cwd}sendcats.py"
    run(cmd, cwd=cwd)
    return CancelJob


while True:
    run_pending()
    sleep(1)
```

What I'm showing here is generic automation tech. It's the new stuff sweeping
across all Linux distros because systemd. Before systemd, it was easier to do
WebDev on Linux than SysAdmin work on Linux because of how painful the
precursor to systemd was. It's called SysV. It's an "init" system, meaning
controlling what happens after a hard reboot. In other words, it's your startup
procedure. Learning systemd lets you control your startup procedure with the
language of your choice. I'm using a Python scheduler. Let cronjobs be a thing
of the past. Arcane knowledge not necessary! I.e. you don't need to learn BASH
Script! And you still get the service enable/disable, start/stop/restart API of
any Linux services. It's awesome.

I am almost 52 y/o. I am not a software developer. I have no developer related
degree. I feel this coding stuff is just basic literacy. I code like I write. I
love to write. I love to express myself. What I code is for myself, even when I
code for my job. There's a lot about this that "internalizes" like a martial
arts skill. You never stop learning and getting better with a small tool-set.
If you're forever improving on a small tool-set, you don't get frustrated as
much as someone one who has to keep relearning just to keep up with the
youngun's.

There always something new & love-worthy to learn under Linux, Python, vim &
git. Opportunity arises when things like systemd land and nobody knows it.

## I LIKE THESE
- Linux
- Python
- vim
- git

## THERE ARE OTHER THINGS LIKE THESE, BUT NOT FOR ME
- BASH Script
- C & varieties
- LISP & dialects
- JavaScript

## THESE MAY NOT BE PEE IN THE POOL OF TECH
- LAMP
- ASP
- PHP
- ROR
- Full Web Stack? Node?
  - Fad or fundamental?
  - Too early to say

This video is very much mission accomplished. Next?

- Switch schedule to huey!
  - From simple scheduling (for humans)
  - To data pipelining with low tech liability (not Apache Airflow)
- Install either pyppeteer or Microsoft Playwright https://playwright.dev/
  - For Web browser automation
    - For avoiding needing API access to services
    - For automating processes that can ONLY be done in the browser
  - For screenshots
  - For Google search results
  - For saving the entire DOM
- Database persistence impervious to container deletion

- Diminishing reliance on fad (and to a lesser degree, trends)
- When you choose a small set of tools
  - Make sure they're love-worthy by you
  - Make sure they're beloved by the people you work with/hire you
  - Make sure they're the pee in the pool of tech
    - Is NodeJS? Maybe.
    - Is Python? I think yes.
    - Is systemd? I think yes.

- Think about LAMP (Linux, Apache, MySQL, PERL, PHP or Python)
  - Oracle bought MySQL
  - nxginx took over from Apache
  - Only Linux & Python survive
- Think about Active Server Page
- Think about PHP
- Think about Ruby on Rails
- Think about Adobe Flash

Technology that you don't think will disappoint you will.

Some people need to master their tools. Some don't. I do. The tech field is
hard for me. It's not so hard for the "multi-lingual" types. I find multiple
languages difficult. I've tried. My different languages would be:

- Spoken (English)
- For machines (Python)
- Drawing / Illustration (Pen & paper)


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/ubuntu-18-04-vs-ubuntu-20-04-for-lxd-under-wsl2-wizard-defaults/">Ubuntu 18.04 vs Ubuntu 20.04 for LXD Under WSL2, Wizard Defaults</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/use-perceptual-image-hash-as-database-primary-key-for-cats/">Use Perceptual Image Hash as Database Primary Key for Cats</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/wsl2/'>WSL2</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/script/'>Script</a></h4></li>
<li><h4><a href='/coding/'>Coding</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li>
<li><h4><a href='/service/'>Service</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li></ul>