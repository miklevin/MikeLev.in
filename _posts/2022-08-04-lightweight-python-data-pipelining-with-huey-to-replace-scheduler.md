---
date: 2022-08-04
title: Lightweight Python Data Pipelining With Huey (to Replace Scheduler)
headline: "Replacing My Scheduling System With Huey: My Experience With Setting Up and Monitoring a Lightweight Python Data Pipelining Tool"
description: I replaced my existing scheduling system with Huey, a lightweight Python data pipelining tool. I followed the Huey documentation and wrote a configuration file, and after putting it in place, it worked as expected! I'm sharing my experience of setting up Huey, including how I used the huey_consumer.py script and a systemd service to monitor it.
keywords: Huey, Python, Data Pipelining, Scheduler, Configuration File, huey_consumer.py, Systemd Service, Monitoring, Setup, Working Directory, Executable, Standard Output, Standard Error
categories: python
permalink: /blog/lightweight-python-data-pipelining-with-huey-to-replace-scheduler/
layout: post
---


Time to finally do the Huey work!

Get to know Huey, from scratch. Set it up from documentation.
https://huey.readthedocs.io/en/latest/guide.html

This is in addition to the PyPI/Github documentation with the repo.
https://pypi.org/project/huey/

These documents each give slightly different insights as to a system like this.
While it has many similarities to the scheduling system I just set up over on
the Munchkin container, there are differences.

Foremost, there can be tasks that are not necessarily scheduled that are just
sort of sitting there awaiting further instructions. The example they give is
this:

```python
# demo.py
from huey import SqliteHuey

huey = SqliteHuey(filename='/tmp/demo.db')

@huey.task()
def add(a, b):
    return a + b
```

Okay, so the file is named demo.py. There is something called the Huey
Consumer, whose file is huey_consumper.py. And it apparently gets invoked as:

    $ huey_consumer.py demo.huey

I have to try that. That makes me wonder. I guess huey is installed in such a
way as that script file can be invoked as a program. I know such tricks exist
as is used all over nbdev, but usually they're sbin-like and don't use file
extensions. Either way, it has to be tried to be understood. Does the
command-line lock-up until a Ctrl+C? This looks like in ideal candidate to be
called through systemd. Such things should be services. Perfect.

Okay, so the next step is clear.

Start a video. Capture the experience. Follow the Huey tutorial.

    periodic_task(validate_datetime, retries=0, retry_delay=0, priority=None,
    context=False, name=None, expires=None, **kwargs)

huey_consumer.py demo.huey

Notice this is not called the same way as scheduler.py. Huey gets called
through huey_consumer.py, and in the example they don't give a path leading to
it. This is typical when importing pip installed packages from within Python
code. But when it's on the command-line, it means stuff has been added to the
path or put in the existing path.

To figure out what's really going on here, we have to list the contents of the
path variable in the Linux container's environment variables with printenv. Oh!
It's important to note that we get a different path variable based on whether
we have our Python virtualenv activated or not. Here is our default path
without source ~/py310/bin/activate:

    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

And here it is with my py310 venv activated:

    PATH=/home/ubuntu/py310/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

And then we simple replace colons with line returns, and here they are:

    /home/ubuntu/py310/bin
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin
    /usr/games
    /usr/local/games
    /snap/bin

Okay, that won't take long to figure out. Not many choices. And since it was
something pip installed with venv isolation, the money is on it being in the
first entry. I guess it's also worth noting that once we had the Python venv
virtual environment activated, we could have also used the whereis command to
get the path to the executable:

    (py310) ubuntu@Huey:/etc/systemd/system$ whereis huey_consumer.py
    huey_consumer: /home/ubuntu/py310/bin/huey_consumer.py /home/ubuntu/py310/bin/huey_consumer

But it's good to know what your complete path is, so printenv is a bit more
important than whereis, but knowing both is great in situations like this.

Okay, so the path is tested. I can launch huey_consumer.py demo.py from the
command-line and even funnel it through the GNU screen terminal server, and so
success is assured in turning Huey into a monitor-able Linux daemon .service
file. And here it is:

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

And in fact it worked!


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/how-to-share-an-ssh-key-with-linux-container-to-eliminate-passwords/">How to Share an SSH Key with Linux Container to Eliminate Passwords</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/use-perceptual-image-hash-as-database-primary-key-for-cats/">Use Perceptual Image Hash as Database Primary Key for Cats</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li></ul>