---
date: 2022-08-02
title: Sending an HTML Email with Embedded Image From Python
headline: I'm Excited to Share My Project of Sending an HTML Email with an Embedded Image from Python!
description: I'm excited to share my project of sending an HTML email with an embedded image from Python. This code sets up a scheduler to run certain functions at set intervals, including printing 'Hello World' every 10 seconds, writing the pulse count and current date/time to a file every 5 seconds, and sending an email with an HTML attachment every minute. Come read more about my project and how it can be used as a template for other projects around the world.
keywords: Python, HTML Email, Embedded Image, Scheduler, Intervals, Printing, Pulse Count, Date/Time, File, Attachment, Template, Projects
categories: python, template
permalink: /blog/sending-an-html-email-with-embedded-image-from-python/
layout: post
---


What a great success that last round of work was, getting a Linux daemon
(service) to send emails under a Python scheduler. Now it's time to send an
attachment.

That's necessary for your next round of "day job" work, and you have to get the
pattern into this current "Linux daemon pulse" project as a sort of copy/paste
template location. I imagine this project could work as a template for about a
zillion different projects that people want/need to do around the world. It's
kind of funny such a great approach to solving these problems is found in my
humble little channel here. I don't find this stuff anywhere else. Am I the
only one doing it and blogging and vlogging about it? Maybe.

Hmmm. But what about HTML email? That's going to be necessary too, but which
should I do first, attachments or HTML email. Start with HTML email and see how
easy it is to add on the attachments. Get the stuff ready you'll need.

The sendmail program is currently this:

```python
import smtplib

msg = '''Dear You,

Let's make this message multi-line, but still short and sweet so that
the entire example can fit on screen.

Mike Levin'''

with open('mail_from.txt') as fh:
    email, paswd = [x.strip() for x in fh.readlines()]

with open('mail_to.txt') as fh:
    mail_to = [x.strip() for x in fh.readlines()]

server = smtplib.SMTP('smtp.gmail.com', 587)
server.ehlo()
server.starttls()
server.login(email, paswd)

BODY = '\r\n'.join([f'To: {", ".join(mail_to)}',
                    'From: %s' % email,
                    'Subject: testing',
                    '\r\n', msg])

try:
    server.sendmail(email, mail_to, BODY)
    print ('email sent')
except:
    print ('error sending mail')

server.quit()
```

I love the simplicity of the thing. I almost fear introducing HTML email and
file attachments, throwing off the beauty. But the modifications to get the
supporting libraries changes it like this:

```python
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Create the plain-text email
msg_text = '''Dear You,

This is a plain text email where the line returns are preserved
like this.

Mike Levin'''

# Create the HTML email
msg_html = '''<html><head></head><body><h1>Dear You,</h1>
<p>This is an HTML email where we don't have to worry about line
returns because html will make its own line wrap decisions.</p>
<h3>Mike Levin</h3></body></html>'''

with open('mail_from.txt') as fh:
    email, paswd = [x.strip() for x in fh.readlines()]

with open('mail_to.txt') as fh:
    mail_to = [x.strip() for x in fh.readlines()]

server = smtplib.SMTP('smtp.gmail.com', 587)
server.ehlo()
server.starttls()
server.login(email, paswd)

msgdict = MIMEMultipart()
msgdict.preamble = 'This is a multi-part message in MIME format.'
msgdict['From'] = email
msgdict['To'] = ', '.join([x for x in mail_to])
msgdict['Subject'] = "HTML Test Email"

# Create plain text and HTML alternatives
msg_alts = MIMEMultipart('alternative')
msgdict.attach(msg_alts)
msg_alts.attach(MIMEText(msg_text))
msg_alts.attach(MIMEText(msg_html, 'html'))

try:
    server.sendmail(email, mail_to, msgdict.as_string())
    print ('email sent')
except:
    print ('error sending mail')

server.quit()
```

So far so good. But what's the point of an HTML email if you don't embed
images? So let's modify the above to include an image. Assuming the existence
of the image file in the code directory, here's the sample code to do an
HTML-style embedding of an image into the email:

```python
import smtplib
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart

# Create the plain-text email
msg_text = '''Dear You,

This is a plain text email where the line returns are preserved
like this.

Mike Levin'''

# Create the HTML email
msg_html = '''<html><head></head><body><h1>Dear You,</h1>
<p>This is an HTML email where we don't have to worry about line
returns because html will make its own line wrap decisions.</p>
<h3>Mike Levin</h3><img src="cid:image" /></body></html>'''

with open('mail_from.txt') as fh:
    email, paswd = [x.strip() for x in fh.readlines()]

with open('mail_to.txt') as fh:
    mail_to = [x.strip() for x in fh.readlines()]

server = smtplib.SMTP('smtp.gmail.com', 587)
server.ehlo()
server.starttls()
server.login(email, paswd)

msgdict = MIMEMultipart()
msgdict.preamble = 'This is a multi-part message in MIME format.'
msgdict['From'] = email
msgdict['To'] = ', '.join([x for x in mail_to])
msgdict['Subject'] = "HTML Test Email"

# Create plain text and HTML alternatives
msg_alts = MIMEMultipart('alternative')
msgdict.attach(msg_alts)
msg_alts.attach(MIMEText(msg_text))
msg_alts.attach(MIMEText(msg_html, 'html'))

with open("mike-levin-logo.png", 'rb') as fh:
    msg_img = MIMEImage(fh.read())
    msg_img.add_header('Content-Disposition', 'inline', filename='Mike Levin')

msgdict.add_header('Content-ID', '<image>')
msgdict.attach(msg_img)

try:
    server.sendmail(email, mail_to, msgdict.as_string())
    print ('email sent')
except:
    print ('error sending mail')

server.quit()
```

Phwew! Almost there. The final step is to send a zipped attachment. I thing
that may be a little too much for this post. I'll cut it here and make a zipped
attachment into the next post.

Here it is in final form. This code probably better belongs on the next blog
post but I put it here for continuity.

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


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/from-sending-email-in-jupyter-to-sending-email-in-linux-service/">From Sending Email in Jupyter to Sending Email in Linux Service</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/send-email-with-file-attachment-from-python/">Send Email With File Attachment From Python</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/template/'>Template</a></h4></li></ul>