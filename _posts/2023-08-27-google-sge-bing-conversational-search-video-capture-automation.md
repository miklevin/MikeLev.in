---
date: 2023-08-27
title: Google SGE & Bing Conversational Search Video Capture Automation
headline: I Automated Video Capture of Google SGE & Bing Conversational Search
description: Learn how to automate Google SGE and Bing conversational search video capture with no outside services using Linux, Bash, vim, JupyterLab, and nbdev. Get the most benefit from dabbling with Linux and future-proof your business by automating video capture of conversational search sessions and emailing the result.
keywords: Google, Bing, Conversational Search, Video Capture, Automation, August 2023 Broad Core Update, Generative Search Experience, SGE, Mobile, Google App, Tracking, Terminal, Bash Shell, Linux, Python, Vim, JupyterLab, Jupyter Notebooks, Data Science, Browser Automations, Services, Security, Logins, Control, Customization, Self-Determinacy, Cloud, APIs, Datacenter, Big Tech, Windows Server, Linux
categories: bing, vim, google, python, linux, jupyter
permalink: /blog/google-sge-bing-conversational-search-video-capture-automation/
layout: post
group: blog
---


Okay the iron is hot with both the Google August 2023 Broad Core Update now
live, and all the hubbub about Google Generative Search Experience (SGE). Bing
hardly makes the news for search anymore, but I think it's just pulled so far
ahead of Google that the news is Google responding ***at all***. And indeed if
you opted into the experiment on Google Labs, you'll occasionally see the
conversational results pop up in default web search. Not often, and more
frequently in mobile (reliably in the mobile Google app), but enough so that
it's time to do some proper tracking.

{% include youtubePlayer.html id="P5YnjUBktyE" %}

But how to track conversational search? Well, we can start at the beginning and
get fancier in time. For now, let's just take a "search" or a "query", which we
all must now call a ***prompt*** and send it to both Bing and Google and
video-capture and email the results. Let's do that with no outside services but
for a mailserver because nobody wants to run their own mailserver. But all the
machinery to log in as you and perform searches and video-record them? That
should be on machines directly under your control for several reasons:

- Security concerning your logins
- The mere ability to do it (go ahead and try to find a service)
- Saving money even if such a theoretical service existed
- Having the level of control to customize it for yourself and clients

In this project we do some stuff on our local machines that puts you on the
path to those superpowers you've heard about. It's not yet-another vendor
product or monthly subscription. No, rather it's embracing the same tech that
the people making money off of you use. They're not subject to the same rapidly
changing rules as the general public. They're building to last, because you can
only re-write your software so many times. It's far easier to swap out
hardware, so long as your software is written well to allow it.

So we're adopt some of the same slow-changing APIs as the datacenter operators
and the big tech themselves use. Few run Windows server-side anymore if they
can help it. It's just too expensive when you scale. It's also about
self-determinacy. If your own business functions, the very life-operations of
your organization, is tied to paying some other company every time you use more
of their product when others can use ***free product***, then all else being
equal those using the free product have a competitive advantage. They can grow
their business and accommodate more customers with less friction and expense.

That may sound boring to you, but it need not be. Especially if we start with
daily journaling. How in the world does daily journaling fit into a discussion
of not going obsolete in the world of tech, you ask? Easy! By using the vim
text editor for journaling. By running vim through a Bash Shell in a Linux
Terminal. Huh? Trust me, you're using a nice everyday thing that's useful to do
in order to learn a bunch of stuff that's useful to know. It goes:

- Getting a Terminal program running on your computer.
- Allowing a full-fledged Bash Shell to come up through a Terminal program.
- Being able to edit a text file with vim from that Bash Shell.
- Getting more and more adept at using Terminal, Bash and vim with an ordinary
  everyday task.
- Gradually transitioning from using vim just for journal entries to other
  things like Python programming and setting up Linux services (automations).

This is a righteous path to future-proofing, but a difficult one because of
wanting to get ***more benefit*** from dabbling with Linux in the meanwhile.
And so there is! This is what you might call the modified path that I created
for MyKoz.AI considering the difficulty of the transition for most folks. 

- Install JupyterLab to allow jumping on the Jupyter Notebooks data science
  bandwagon &#151; a good beginner path to learn Python.
- To have done the JupyterLab install on Linux under the Windows Subsystem for
  Linux (WSL) so it's all running the Linux (cloud) way.
- To dangle benefits so compelling with this approach that it seizes the
  attention of SEOs and data scientists looking to automate cheaply.
- To use `nbdev` as the mechanism to bridge the Jupyter Notebook world and the
  Linux systemd services world. Export browser automations as services!

In a final coup de grâce, I'll make the Linux service (optionally) email you
the result of the browser automation, which in this case is a `.webm` video
session of a Google SGE conversational search session and a Bing chatbot
session back-to-back so you can compare what each of them are doing on a daily
basis. I can ignite a new "data addition" here. And it's one people don't have
to pay for. And it's one that starts inching their own internal skills forward.

Okay, done. Wow, do I have something to show the folks. And still in time to
produce some videos on my birthday.

Don't worry about what to do with all this code below. It's built-into MyKoz.AI
and you won't have to retype a thing. Just change it to your prompt that you
want to track. Oh, and you'll have to set up the from and to email files if
you'll want it to email. That also requires an App Password from one of your
Google accounts to do the emailing.

If you want to make it work like it does in the video and you're on Windows,
check out [MyKoz.AI](https://mykoz.ai/). The script is just one of the sample
scripts that gets installed with JupyterLab, which is hosted on Linux under
WSL. So there's no machine configuration issues or anything. We use WSL Linux
as a

```python
#| default_exp chatshot
#| export

# Set your keyword search, query or prompt: 
prompt = "Write a Hello World program in Python"

headless = False
slow_mo = 200
width = 1280
height = 1800
short_delay = 2
long_delay = 25
delete_after_days_old = 7
min_file_size = 200 * 1024  #KBs
video_folder = "/home/ubuntu/repos/intro/videos"

#| export
import os


files = os.listdir(video_folder)

for file in files:
    file_path = os.path.join(video_folder, file)
    if os.path.isfile(file_path):
        os.remove(file_path)
        print(f"Deleted {file}")

print("Deletion of all files complete.")

#| export

import asyncio
import nest_asyncio
from playwright.async_api import async_playwright


# Create a new event loop (necessary for Playwright in Juptyer)
nest_asyncio.apply()
loop = asyncio.get_event_loop()
new_loop = asyncio.new_event_loop()
asyncio.set_event_loop(new_loop)

async def browser_automation():
    """Records Google and Bing conversational web search as video."""

    async with async_playwright() as p:
        playwright = await async_playwright().start()
        browser = await playwright.chromium.launch_persistent_context(
            accept_downloads=True,
            args=["--window-position=100,100"],
            channel="chrome",
            downloads_path="/home/ubuntu/Downloads",
            executable_path="/usr/bin/google-chrome",
            headless=headless,
            no_viewport=False,
            record_video_dir=video_folder,
            record_video_size={"width": width, "height": height},
            slow_mo=slow_mo,
            user_data_dir="/home/ubuntu/.config/google-chrome/",
            viewport={"width": width, "height": height},
        )

        # Open the browser window
        page = await browser.new_page()

        # Perform a Bing Search
        placeholder = "Ask me anything"
        await page.goto("https://www.bing.com/")
        await asyncio.sleep(short_delay)
        await page.get_by_placeholder(placeholder).click()
        # await page.get_by_placeholder(placeholder).fill(prompt)
        await page.get_by_placeholder(placeholder).type(prompt)
        await page.get_by_placeholder(placeholder).press("Escape")
        await page.locator("#search_icon svg").click()
        # try:
        #     await page.wait_for_load_state('networkidle', timeout=long_delay)
        # except:
        #     ...
        await asyncio.sleep(long_delay)
        
        # Perform a Google Search
        await page.goto("https://www.google.com/")
        await asyncio.sleep(short_delay)
        await page.get_by_label("Search", exact=True).click()
        # await page.get_by_label("Search", exact=True).fill(prompt)
        await page.get_by_label("Search", exact=True).type(prompt)
        await page.get_by_label("Search", exact=True).press("Escape")
        await page.get_by_role("button", name="Google Search").click()
        # try:
        #     await page.wait_for_load_state('networkidle', timeout=long_delay)
        # except:
        #     ...
        await asyncio.sleep(long_delay)

        await browser.close()

# Set the new event loop as the current event loop
asyncio.run(browser_automation())

files = [f for f in os.listdir(video_folder) if os.path.isfile(os.path.join(video_folder, f))]

# Deletes the smallest of multiple files.
if len(files) == 1:
    print("Already down to 1 file.")
else:
    smallest_file = min(files, key=lambda f: os.path.getsize(os.path.join(video_folder, f)))
    smallest_file_path = os.path.join(video_folder, smallest_file)
    os.remove(smallest_file_path)
    print(f"Deleted the smallest file: {smallest_file}")

# Find the newest .webm file
webm_files = [f for f in os.listdir(video_folder) if f.lower().endswith('.webm') and os.path.isfile(os.path.join(video_folder, f))]
newest_webm_file = max(webm_files, key=lambda f: os.path.getmtime(os.path.join(video_folder, f))) if webm_files else None
print(f"I will convert {newest_webm_file} to mp4.")

import subprocess
from datetime import date


def convert_webm_to_mp4(input_path, output_path):
    cmd = [
        "ffmpeg",
        "-i", input_path,
        "-c:v", "libx264",
        "-preset", "slow",
        "-crf", "40",  # Low quality (51 = lowest)
        "-r", "15",
        "-vf", f"setpts={1/2}*PTS",  # Adjust playback speed using setpts filter
        "-an",  # This disables audio
        output_path
    ]
    
    subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

input_webm_file = f"/home/ubuntu/repos/intro/videos/{newest_webm_file}"
output_mp4_file = f"/home/ubuntu/repos/intro/videos/{date.today()}.mp4"

convert_webm_to_mp4(input_webm_file, output_mp4_file)

import smtplib
from pathlib import Path
from email import encoders
from datetime import datetime
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart


file_name = Path(output_mp4_file).name

# Create the plain-text email
msg_text = f'''{prompt}

Your video recording of a Google and Bing search for {file_name} is attached.

Regards'''

# Create the HTML email
msg_html = f'''<html><head></head><body><h1>{prompt}</h1>
<p>Your video recording of a Google and Bing search for {file_name} is attached.</p>
<h3>Regards</h3></body></html>'''

with open('/home/ubuntu/repos/intro/service/mail_from.txt') as fh:
    email, paswd = [x.strip() for x in fh.readlines()]

with open('/home/ubuntu/repos/intro/service/mail_to.txt') as fh:
    mail_to = [x.strip() for x in fh.readlines()]

server = smtplib.SMTP('smtp.gmail.com', 587)
server.ehlo()
server.starttls()
server.login(email, paswd)

msgdict = MIMEMultipart()
msgdict.preamble = 'This is a multi-part message in MIME format.'
msgdict['From'] = email
msgdict['To'] = ', '.join([x for x in mail_to])
msgdict['Subject'] = prompt

# Create plain text and HTML alternatives
msg_alts = MIMEMultipart('alternative')
msgdict.attach(msg_alts)
msg_alts.attach(MIMEText(msg_text))
msg_alts.attach(MIMEText(msg_html, 'html'))

mimecats = MIMEBase('application', 'octet-stream')
with open(Path(output_mp4_file), 'br') as zfh:
    mimecats.set_payload(zfh.read())
encoders.encode_base64(mimecats)
mimecats.add_header('Content-Disposition', f"video; filename={file_name}")
msgdict.attach(mimecats)

try:
    server.sendmail(email, mail_to, msgdict.as_string())
    print ('email sent')
except:
    print ('error sending mail')

server.quit()
```








<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/refining-the-mykoz-ai-vision-in-prep-for-soft-launch/">Refining the MyKoz.AI Vision in Prep for Soft Launch</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/journal-daily-learn-vim-by-journaling-similar-tricks-for-python-linux/">Journal Daily. Learn vim by Journaling. Similar Tricks for Python & Linux</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/bing/'>Bing</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>