---
date: 2022-08-01
title: Write a Linux Scheduler Service in Python
headline: Creating a Lightweight Linux Scheduler Service in Python with the 'schedule' Package
description: I'm creating a lightweight Linux Scheduler Service in Python that uses the 'schedule' package to define and execute Python functions. I'm exploring ways to manage files and keep scheduled tasks in separate folders. In this blog post, I'll be taking you through the process of setting up a precursor to a data pipelining video. Read on to learn how to create a powerful, yet lightweight, scheduling system!
keywords: Linux, Scheduler, Service, Python, Schedule, Package, Manage, Files, Separate, Folders, Pipelining, Video, Define, Execute, Functions, Apache, Airflow, Luigi, Lightweight, Precusor, Data, Tasks
categories: service, python, linux
permalink: /blog/write-a-linux-scheduler-service-in-python/
layout: post
---


{% include youtubePlayer.html id="Cea6JCesCmc" %}

These are the notes for a more involved video soon to come that takes this
scheduling stuff to the next step with scheduling external files and then data
pipelining.

Have you heard of Data Pipelining?

I'm not talking about operating system data pipes that use those vertical bars
(|) in Unix, Linux and AmigaDOS to funnel data out of one program into another,
although there are similarities. Rather, the data pipeline process is adopting
various workflow conventions so that everyone in an organization getting data
from point-A to point-B is following is doing it properly.

Honestly it's the sort of stuff that stinks of extra moving parts and technical
liability to me unless it's really, really called for. Probably the most
popular data pipeline system is Apache Airflow. In the Python world, Luigi is
pretty popular. I would rather not touch either with a 100-foot pole. I prefer
a lightweight approach. Luckily, there is lightweight data pipelining, and one
of them is Huey, which you saw me install just after creating a new Linux
container and installing Python 3.10 on the last video.

In this video I'm going to make a precursor to the data pipelining video based
on a more basic concept of scheduling.

I like to:

    pip install schedule

This gives me "scheduling for humans" in Python. You can read about it
(https://pypi.org/project/schedule/)[https://pypi.org/project/schedule/]
Their example is this:

```python
import schedule
import time

def job():
    print("I'm working...")

schedule.every(10).seconds.do(job)
schedule.every(10).minutes.do(job)
schedule.every().hour.do(job)
schedule.every().day.at("10:30").do(job)
schedule.every(5).to(10).minutes.do(job)
schedule.every().monday.do(job)
schedule.every().wednesday.at("13:15").do(job)
schedule.every().minute.at(":17").do(job)

while True:
    schedule.run_pending()
    time.sleep(1)
```

I've used this sort of scheduling to great effect for many years and when data
pipelining came along, I've resisted because this gave me most of what I wanted
with the least amount of effort. Scheduled items in the above scenario are
defined Python functions.

End of story! But this does not provide a lot of flexibility in terms of
managing files and keeping schedule-able tasks as separate folders (git/Github
repos). Processes that need to get scheduled in my way of thinking usually turn
out to be their own scripts, usually in their own repos (folder or directory).
There's a certain "tied together-ness" implied here,

All scheduled items would have to be in that file or importable as
Python modules.

```python
import shlex
from os import environ
from sys import stdout
from subprocess import Popen, PIPE


environ["PYTHONUNBUFFERED"] = "1"


# Through standard Python
def pulse():
    anow = f"{datetime.now()}"
    print(anow)
    with open("/tmp/pulse.txt", 'a') as fh:
        fh.write(anow + '\n')


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
        # Put logging here
        stdout.flush()


def onepulse():
    pyx = "/home/ubuntu/py310/bin/python3.10"
    cwd = "/home/ubuntu/github/pulse/"
    cmd = f"{pyx} {cwd}onepulse.py"
    run(cmd, cwd=cwd)

```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/build-linux-container-on-windows-and-install-python-3-10/">Build Linux container on Windows and Install Python 3.10</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/from-sending-email-in-jupyter-to-sending-email-in-linux-service/">From Sending Email in Jupyter to Sending Email in Linux Service</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/service/'>Service</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>