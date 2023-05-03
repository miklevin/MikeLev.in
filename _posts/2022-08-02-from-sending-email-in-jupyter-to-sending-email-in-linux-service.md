---
date: 2022-08-02
title: From Sending Email in Jupyter to Sending Email in Linux Service
permalink: /blog/from-sending-email-in-jupyter-to-sending-email-in-linux-service/
headline: I'm Learning Zawinski's Law, Python's SMTP Library, and Systemd - How I'm Testing My Work in JupyterLab
description: I'm learning Zawinski's Law, Python's SMTP library, and systemd. I'm using JupyterLab to show how to work with mail-from and mail-to files, move them into a Linux container pulse folder, and create a sendmail.py file. Come read my blog post to find out how I'm testing my work!
keywords: Email, Jupyter, Linux, Zawinski's Law, Python, SMTP, Library, Systemd, JupyterLab, Mail-from, Mail-to, Container Pulse, Sendmail.py, Testing
categories: jupyter, linux, email, jupyterlab, python, systemd
layout: post
---

Ever need a running process to reach out and let you know how things are going?
Per Zawinski's Law, the time has come the Walrus said to make our Python Linux
daemon service able to send emails using Python's standard SMTP library and the
gmail email servers. So long as we send from a gmail account, we have reliable
and sufficiently permissive infrastructure to tap. Jumping into WebDev already?
Take a moment to learn Linux basics with me, especially the world-changing
Linux service management system called systemd.

{% include youtubePlayer.html id="cY9flYebbB0" %}

- Mention Jamie Zawinski & Zawinski's law
- Show how smtplib is built into the Python Standard Library

- Show it working in JupyterLab (why JupyterLab?)
- Show the files containing mail-from login credentials and mail-to list
  - Explain why Gmail, 2FA & App Password (reasonable precautions)

- Remind about the ~/data location shared
- Move the mail-from/mail-to files into Linux container pulse folder
- Create a sendmail.py file in the pulse folder
- Run it form there (send email)

- Define a run function using Popen to Python file
- Define sendmail function that calls external program
- Test it by running directly from Python (confirm emails being sent)
- Run it as a service


## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/email/'>Email</a></h4></li>
<li><h4><a href='/jupyterlab/'>JupyterLab</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li></ul>