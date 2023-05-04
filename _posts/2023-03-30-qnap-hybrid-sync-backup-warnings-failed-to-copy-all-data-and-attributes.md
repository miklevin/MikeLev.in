---
date: 2023-03-30
title: QNAP Hybrid Sync Backup Warnings Failed to copy all data and attributes
headline: NAS Backup Fails Due to Unsupported Filenames - Read How I Fixed It!
description: After experiencing a terrible headache, I decided to err on the side of caution and turn off the Copilot plugin for .txt files. I then noticed a warning that my NAS backup had failed to copy all data and attributes, and after logging in by SSH, I discovered the issue was with unsupported filenames. I resolved to fix it later - read my blog post to find out how!
keywords: "QNAP, Hybrid Sync, Backup, Warnings, Failed, Copy, Attributes, Headache, Copilot, Plugin, .txt, Files, NAS, SSH, Unsupported, Filenames, Fix, Research, GitHub, Conversation, Caution, Sleep, 5:00, AM"
categories: github, copilot
permalink: /blog/qnap-hybrid-sync-backup-warnings-failed-to-copy-all-data-and-attributes/
layout: post
---


Wow, yesterday I got a terrible headache around 4:00 PM and was out for the
day. And I had big plans! But maybe need for sleep caught up with me, because I
was out light a light until 5:00 AM this morning. Even now, it's 7:30 AM
because I had to get even a little more sleep. Sometimes you can just tell your
body needs it and can feel your body healing. I'm feeling much better now.

I want to look into how the Copilot plugin works. Does it only scan text you've
typed so far (all it would need, I presume) or does it scan the text of the
entire document you're editing? Where is the discussion taking place? On
GitHub, of course. Go find a conversation...

[Copilot FAQ](https://github.com/orgs/community/discussions/47318)

No clear answers, but in order to err on the side of caution, I'm changing the
file-type of my private file to .txt and turning Copilot off for .txt files.
That way, I can still use it for markdown, but I don't have ambiguity about
when Copilot is on or off.

Okay, next issue for the morning. My NAS backup has a warning. That's always a
pain because it doesn't give you access to the log you need to see through the
Web user interface. All it says is "Failed to copy all data and attributes".

Okay, I can log in by SSH, but I have to re-activate the admin account which I
keep disabled normally. Then I look in the folder:

    /etc/config/qsync/logs/detail/

There's small rotated logs in there and there's big rotated logs in there. The
small ones are only a report, so of no real use. The big ones are full of so
many lines! I basically just zoomed out in vim -R mode to see where things
looked different, and I found a run of lines that looked like this:

    [2023/03/28 10:12:23] # WARNING: Skip the "Photos/19/_18-12-08 17:47:40.png" file which has an unsupported filename!
    [2023/03/28 10:12:23] # WARNING: Skip the "Photos/19/_18-12-08 18:26:35.png" file which has an unsupported filename!
    [2023/03/28 10:12:23] # WARNING: Skip the "Photos/19/_18-12-08 18:25:05.png" file which has an unsupported filename!
    [2023/03/28 10:12:23] # WARNING: Skip the "Photos/19/_18-12-08 18:24:50.png" file which has an unsupported filename!

So I'm constructing filenames that can't be backed up, almost definitely the
colons in the filename. Okay, I can fix that later. Some things are not getting
backed up, but that's not a problem for now. Not a priority. It's coming up on
8:30 AM and I have my plans for the day.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/should-you-use-bing-or-bard-to-help-with-your-homework">Should You Use Bing or Bard to Help With Your Homework?</a></div><div class="post-nav-next"><a href="/blog/using-copilot-to-help-with-daily-journaling">Using Copilot to Help With Daily Journaling</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/github/'>Github</a></h4></li>
<li><h4><a href='/copilot/'>Copilot</a></h4></li></ul>