---
date: 2022-08-09
title: Switching a Python Scheduler to Huey Task Queue Using Crontab API
permalink: /blog/switching-a-python-scheduler-to-huey-task-queue-using-crontab-api/
headline: Switching to Huey Task Queue Using Crontab API - My Journey and Tips!
description: In this video, I show how I successfully switched from the Python pip install schedule package to the less Pythonic crontab method of Huey. I walk through the nuances of periodic scheduling, working directory .service file values, and more. Subscribe to my channel for more tips and tricks on switching over to Huey!
keywords: Python, Scheduler, Huey, Task Queue, Crontab API, Periodic Scheduling, Working Directory, .Service File Values, Switching, Pip Install, Data Pipeline
categories: python
layout: post
---

Here's a video I didn't think I was going to do. I was going to switch over
from one Python Scheduler to another, dealing with the changing "API-language"
this entails, going from the very Pythonic "for humans" API of pip install
schedule to the much less Pythonic crontab method of Huey, a scheduler with is
also really a data pipeline task queue system like the much more popular Python
Celery package but with much lower dependencies, so you can run it without all
this devops stuff (tech liability).

Over my last several videos, I went from the pip install schedule package from
PyPI that has an API that beautifully looks like this:

```python
schedule.every(10).seconds.do(job)
schedule.every(10).minutes.do(job)
schedule.every().hour.do(job)
schedule.every().day.at("10:30").do(job)
schedule.every(5).to(10).minutes.do(job)
schedule.every().monday.do(job)
schedule.every().wednesday.at("13:15").do(job)
schedule.every().minute.at(":17").do(job)

# Or alternatively, use Python decorators:

@repeat(every(10).minutes)
def job():
    print("I am a scheduled job")
```

Task queue (for reliability).
To pip install huey whose scheduling portion of their API looks like this:
Huey is patterned after the much more popular Celery API.

```python
@huey.periodic_task(crontab(minute='0', hour='3'))
def nightly_backup():
    sync_all_data()

@huey.periodic_task(crontab(minute='*/3'))
def every_three_minutes():
    print('This task runs every three minutes')
```

So you see, Schedule allows per-line standalone scheduling instructions with a
well designed "API-language" plus the convenience of Python decorators where
those "for humans" language conventions carry over.

{% include youtubePlayer.html id="DPjuNqwUjDU" %}

Huey on the other hand only allows function decorators, which in and of itself
is not a bad thing, but the API follows the long-standing Unix conventions of
the cron program. Now while it's generally good to follow the Unix/Linux
API-standards, scheduling is one of the more difficult places to do so.

Switching my Munchkin container that currently uses the Python PyPI pip install
Schedule package over to Huey is the subject of this video.

Just get to it and make it happen. Do a series of quick, small passes even if
you're producing videos to document it and help people at large dealing with
these same issues.

- Periodic scheduling
- Exact scheduling

How to test that your scheduler is running when all you have is periodic
scheduling and you want a scheduled even to happen moments after you start the
scheduler?

There were stumbling blocks having to do with "exact scheduling" vs. periodic
scheduling, but we got it to work. Nuances:

- When using gnu screen to make a service directly monitor-able through a
  console, the systemd service must be changed from simple to forking.
- The WorkingDirectory .service file value is very important for Huey.

Don't forget to subscribe!


## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li></ul>