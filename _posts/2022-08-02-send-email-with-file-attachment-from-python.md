---
date: 2022-08-02
title: Send Email With File Attachment From Python
headline: "Enhancing Email Functionality with Python: Adding HTML, Images, and Zipped Files"
description: I wrote code to enhance the sendemail.py program to include HTML and an image attachment, as well as a zipped file. I then created a program to schedule the sendmail.py file to run every 10 seconds, 5 seconds, and 1 minute, sending an email with the attached file. Read my blog post to learn more about how I did it!
keywords: Python, Email, File Attachment, HTML, Image Attachment, Zipped File, Scheduling, Task, 10 Seconds, 5 Seconds, 1 Minute
categories: html, email, python, scheduling
permalink: /blog/send-email-with-file-attachment-from-python/
layout: post
group: blog
---


{% include youtubePlayer.html id="YfTsYlzNQv4" %}

I did the work of expanding the sendemail.py program to:

- Use HTML for the body of the email message (with plain text alternative)
- Include an attached image (able to be used in HTML img tags)

I didn't show a video of this because it was basically just a bunch of tedious
code wrangling, but now I'm up to the point of including a zipped file
attachment containing multiple items.

I've done the setup work for that in Jupyter and am ready to move it into the
LXD Linux container.

I need to expand the sendmail.py file a little bit in order to attach the file.
I can do that for the video.

Get the bit of code that's not in the Jupyter Notebook yet and put it here.

```python
mimecats = MIMEBase('application', 'octet-stream')
with open(Path('cats.zip'), 'br') as zfh:
    mimecats.set_payload(zfh.read())
encoders.encode_base64(mimecats)
mimecats.add_header('Content-Disposition', "attachment; filename= %s" % filename)
msgdict.attach(mimecats)
```

I completed this project and here is the code:

```python
import shlex
import schedule
from time import sleep
from os import environ
from sys import stdout
from datetime import datetime
from subprocess import Popen, PIPE


pulse_count = 0

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


def hello():
    print("Hello World")


def pulse():
    global pulse_count
    pulse_count += 1
    anow = f"{pulse_count} - {datetime.now()}"
    with open('/tmp/scheduler.txt', 'a') as fh:
        print(f"{anow} is written to /tmp/scheduler.txt")
        fh.write((anow) + '\n')


def sendmail():
    print("Sending email")
    pyx = "/home/ubuntu/py310/bin/python3.10"
    cwd = "/home/ubuntu/github/scheduler/"
    cmd = f"{pyx} {cwd}sendcats.py"
    run(cmd, cwd=cwd)


print("The pulse service has started.")
schedule.every(10).seconds.do(hello)
schedule.every(5).seconds.do(pulse)
schedule.every(1).minute.do(sendmail)

while True:
    schedule.run_pending()
    sleep(1)
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/sending-an-html-email-with-embedded-image-from-python/">Sending an HTML Email with Embedded Image From Python</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/you-get-blinded-by-the-hardware/">You Get Blinded By The Hardware</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/email/'>Email</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/scheduling/'>Scheduling</a></h4></li></ul>