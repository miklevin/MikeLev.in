---
date: 2022-08-06
title: Turning Python Huey Data Pipeline into Schedule Repo Alternative
headline: Transitioning My Scheduler and Data Pipeline to Huey on Windows
description: I recently discovered Huey, a task scheduler for Python that is similar to Schedule but with the added convenience of a huey_consumer.py file that is automatically added to the command-line path after a pip install. I'm currently in the process of transitioning my scheduler and data pipeline dask queue from two Linux containers to Huey on my Windows system. Read my blog post to learn more about this transition!
keywords: Python, Huey, Schedule, Repo, Alternative, Task Scheduler, huey_consumer.py, Command-Line Path, Pip Install, Transition, Scheduler, Data Pipeline, Dask Queue, Linux Containers, Windows System
categories: python
permalink: /blog/turning-python-huey-data-pipeline-into-schedule-repo-alternative/
layout: post
---


My previous videos walked through setting up a scheduler and a proper data
pipeline dask queue on two different Linux containers on my Windows system. I
kept these processes separate because I understood:

    pip install schedule

...bit I didn't understand:

    pip install huey

In so many ways they are the same.

- They both allow you to schedule tasks with Python decorators at the top of
  Python functions.
- They both require you to run a long-running Python script for the scheduled
  events to occur.

In the case of Schedule though, you simply feed the file that imports schedule
and defines the scheduling to the Python interpreter:

    python scheduler.py

...however, in the case of Huey, they have a huey_consumer.py file that is
magically in the command-line path after a pip install huey. That's a bit
freaky to me, but nbdev does it as well, which I've been using for awhile now.
However nbdev eliminates the .py file-extension and makes it feel like a native
OS command (across OS's, which is an awesome trick). Huey doesn't hide the .py
extension. My ~/py310/bin directory currently contains:

    (py310) ubuntu@Huey:~/py310/bin$ ls -la
    total 56
    drwxrwxr-x 1 ubuntu ubuntu  222 Aug  1 19:25 .
    drwxrwxr-x 1 ubuntu ubuntu   56 Aug  1 19:23 ..
    -rw-r--r-- 1 ubuntu ubuntu 1987 Aug  1 19:23 activate
    -rw-r--r-- 1 ubuntu ubuntu  913 Aug  1 19:23 activate.csh
    -rw-r--r-- 1 ubuntu ubuntu 2055 Aug  1 19:23 activate.fish
    -rw-r--r-- 1 ubuntu ubuntu 9033 Aug  1 19:23 Activate.ps1
    -rwxrwxr-x 1 ubuntu ubuntu  978 Aug  1 19:25 huey_consumer
    -rwxrwxr-x 1 ubuntu ubuntu 1555 Aug  1 19:25 huey_consumer.py
    -rwxrwxr-x 1 ubuntu ubuntu  238 Aug  1 19:25 pip
    -rwxrwxr-x 1 ubuntu ubuntu  238 Aug  1 19:25 pip3
    -rwxrwxr-x 1 ubuntu ubuntu  238 Aug  1 19:25 pip3.10
    lrwxrwxrwx 1 ubuntu ubuntu   10 Aug  1 19:23 python -> python3.10
    lrwxrwxrwx 1 ubuntu ubuntu   10 Aug  1 19:23 python3 -> python3.10
    lrwxrwxrwx 1 ubuntu ubuntu   19 Aug  1 19:23 python3.10 -> /usr/bin/python3.10
    (py310) ubuntu@Huey:~/py310/bin$

Interesting! There's a huey_consumer file but without a .py extension there,
but it's still Python. It's different from the .py file too.

Huey is an alternative to Celery and Luigi. I wonder if those are this screwy.
Huey is screwy. The naming conventions boggle. But I have to wrap my mind
around it. Forget the huey_consumer that has no extension for now.

The demo.py file that I made per the minimal configuration in the
documentation looks like this:

    # demo.py
    from huey import SqliteHuey
    from huey import crontab

    huey = SqliteHuey(filename='/tmp/demo.db')

    @huey.task()
    def add(a, b):
        return a + b

    @huey.periodic_task(crontab(minute='*/3'))
    def every_three_minutes():
        print('This task runs every three minutes')

And this is turned into a service with a file in /etc/systemd/system/ named
huey.service which looks like this:

    [Unit]
    Description=Run Python script to handle scheduling

    [Service]
    Type=forking
    Restart=always
    RestartSec=5
    User=ubuntu
    Group=ubuntu
    WorkingDirectory=/home/ubuntu/github/demo/
    ExecStart=/usr/bin/screen -dmS huey /home/ubuntu/py310/bin/huey_consumer.py demo.huey
    StandardOutput=syslog
    StandardError=syslog

    [Install]
    WantedBy=multi-user.target

And so moving this work over to my other container that has only primitive
scheduling is just a matter of doing a pip install huey and putting those 2
files in place. But instead of 2 scheduler services, I'll replace the old one
with Huey. I wish huey had such a good API for setting scheduling as pip
install schedule.

<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/windows-terminal-stuck-full-screen-no-tabs-process-exited-with-code-1">Windows Terminal Stuck Full-Screen, No Tabs & process exited with code 1</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/how-to-share-an-ssh-key-with-linux-container-to-eliminate-passwords">How to Share an SSH Key with Linux Container to Eliminate Passwords</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li></ul>