---
date: 2022-07-29
title: Sending Emails With Python Through SMTP
headline: Learn How to Send Emails with Python Through SMTP
description: I recently created a video tutorial on how to send emails with Python. I demonstrated how to use a Python list comprehension for carriage returns and linefeeds, as well as two text files for the sender's and recipient's email addresses. I also showed how to log into the server, write the message body, and use the sendmail function to send the email. Click through to learn how to write code to send emails with Python.
keywords: Python, SMTP, Email, List Comprehension, Carriage Returns, Linefeeds, Sender, Recipient, Logging, Server, Message Body, Sendmail, Tutorial, Video, Writing Code
categories: email, tutorial, python
permalink: /blog/sending-emails-with-python-through-smtp/
layout: post
---


These last few videos were quite wondrous. I doubt they'll get any traction in
YouTube because I have not made it fun or palatable enough to absorb the
importance, but I'll keep forging ahead and forge a very clear path for folks
to follow, which I'll clean up and make more appealing. But the raw work keeps
getting pushed out.

Let's get this thing emailing them! Let's get some barebones stuff in place.

```python
import smtplib

msg = '''Dear intrepid explorer,

We can write it across multiple lines, however because we're using
smtp protocol which is archaic and IBM-PC-biased, we need to include
carriage returns and linefeeds between lines. So after we compose
our message, we can do that with a Python list comprehension.

Do you comprehend?

Sincerely,

Mike Levin'''

pcmsg = [f"\r\n{line}" for line in msg.split('\n')]

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


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/using-gnu-screen-to-monitor-linux-system-daemon-service/">Using GNU Screen to Monitor Linux System Daemon Service</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/knowing-what-gnu-screen-you-re-on-with-screenrc/">Knowing what GNU screen you're on with .screenrc</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/email/'>Email</a></h4></li>
<li><h4><a href='/tutorial/'>Tutorial</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>