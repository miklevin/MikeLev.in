---
date: 2023-07-30
title: Figuring Out Good Vim to TikTok Journaling Format
headline: Discovering How to Use Vim and TikTok Together for Journaling
description: I'm learning to incorporate my daily journaling into social media like TikTok, Twitter, and YouTube. I'm optimizing the vertical format, and using my 'Green Lantern' green highlighting trick to imply force of will. I'm figuring out the ideal number of characters across for the text, and then I can screen capture it and read it. I'm also looking for a way to show my face on the computer's desktop while I'm recording. Follow my journey and learn how to be on Linux
keywords: Windows, Windows 11, Windows 10, Linux, Subsystems, Keyboard Shortcut, Virtual Desktops, OS-wars, Mac, Command, Option, Control, Copy, Paste, Muscle Memory, Steve Jobs, OS-wars, Vim, Journal, TikTok, Twitter, YouTube, Vertical Format, Green Highlighting, Green Lantern, Zoom, OBS, Open Broadcast Software, Desktop, Version Upgrade, Fad-Shift, Timeless Tools, Microsoft, Linux
categories: muscle memory, vim, desktop, linux, twitter, youtube, mac, microsoft
permalink: /blog/figuring-out-good-vim-to-tiktok-journaling-format/
layout: post
group: blog
---


I've got to get my butt off Windows 11 and this laptop with a cracked screen. It
was an extra laptop I had lying around, and when my Windows 10 laptop died, I
just started using it. I figured it was my opportunity to give Windows 11 a
chance, and my scripts that let me do my daily journaling now just flow around
to any system that hosts Linux subsystems, which Windows 11 does as well as
Windows 10. So why not?

Why not is because I can't eliminate all distractions, and the keyboard shortcut
for switching left and right between virtual desktops doesn't have the animation
that gives you a sense of where you are in the virtual desktops. I'm constantly
losing my place, and re-orienting is itself a big flow-breaker. I can use a
four-finger swoosh on the touchpad, but now it's tied to the touchpad and
particular OS-implementations.

Much about computers is designed to lock you into a host OS environment. Few
places is this as obvious as the Windows key on keyboards, and the Command and
Option key on Macs. By standard conventions, computer keyboards had Control and
ALT keys (before Mac), but Apple went and introduced the Command and Option
keys, and Microsoft went and introduced the Windows key. And now, you need them
to switch between virtual desktops and other things. This hard-wiring your
habits to OS-keys is part of the OS-wars.

On Macs, the copy and paste commands are generally performed by using the
"Command" key and the "C" key for copy, and the "Command" key and the "V" key
for paste. On Windows, copy and paste are usually performed by using the
"Control" key and the "C" key for copy, and the "Control" key and the "V" key
for paste. So the main difference is that Mac uses the "Command" key while
Windows uses the "Control" key. Anyone switching between Macs and PCs regularly
know this can be the bane of your existence on a daily basis. Nothing
***attacks*** your muscle memory quite so hostilely as the soldier-ghost of
Steve Jobs in the eternal OS-wars.

I am currently pushing out a series of videos on "switching" to Linux from
Windows, but I think I have to re-position it a bit.

I'm coming up with a clever way of doing this, finally incorporating what I do
here in my vim journal into my social media's like TikTok, Twitter, and YouTube.
They're all favoring vertical (or TikTok) format, and I'm now leaning into it. I
just do text in here that I can screen capture my nifty ***green highlighting***
trick, and really imply that whole force-of-will thing through the ***Green
Lantern*** green color I use for vim visual select mode.

I have to figure out the ideal number of characters across for the text, and
then I can just screen capture it, and then I can just read it. I did a few
experiments yesterday, but it's time to optimize it. Get a ruler! Measure how
many centimeters up-and-down the screen is: 18cm (not including 2 lines of vim
user interface). Okay, now what's the aspect ratio for TikTok? 9:16. So that's
9cm across by 16cm down. So I can do 9cm across and ballpark it pretty well.

So then the rest of this is what ***zoom*** to use to control how much text
actually ends up on such a vertical slice of the screen. I don't want any more
to show than I can comfortably read in about a minute, which is the length of
one YouTube "short". YouTube still has a time-limit on shorts, otherwise I guess
they wouldn't be shorts. And this is right as TikTok opened their video length
limit to 10-minutes, haha! They're each trying to capture the other's audience
naturally.

Okay, so let's make a text-ruler...

```
1234567891111111111222222222233333333334444444444555555555566666666667777777777
         0123456709012345678901234567890123456789012345678901234567890123456789
```

Thanks, Copilot! It's worth noting I only got that pattern started and Copilot
immediately knew what I was trying to do and finished all that typing for me.
Now all I have to do is hold a ruler up to the screen and do Ctrl+ and Ctrl- to
zoom in and out until I get the right number of characters across.

And the answer is at 9cm across, I can fit 30 characters across at my current
(and preferred for my poor old-man eyes) zoom. Forget font-sizes. It's all
relative to how big it is on the screen. This is also with the vim rulers turned
off. I don't need them for the TikTok videos. They would only be distracting.

Okay, this can give some pretty good insight into me and my process. I should
also think about how to make this more interesting. I can maybe let my face
show. I could do that with OBS's (Open Broadcast Software) standard ability to
show your face in a corner of the screen. But you can't see your face while
you're recording. I'd like a cut-out of my face that I can see while I'm
recording. And I'd like to not have the sync-problems of using 2 different video
sources that I'd have to edit together. I want to do it in one take, easy peasy.

I need a way to show my face on the computer's desktop while I'm recording. 

{% include youtubePlayer.html id="zX5udwefa2o" %}

Are you on Windows or Mac?
Then you can be on Linux too!

No, not as new Desktop, but as
a way to keep all the skills
and muscle memory you develop
working for you for life.

Don't let all that work you
invest into something new go
to waste due to some major
fad-shift or version upgrade.

It's a myth that EVERYTHING'S
a moving target. You CAN get
better at a small set of
timeless tools for life.

Build on the fundamentals so
key that Microsoft had to
build their own mortal enemy,
Linux, into Windows 10 and 11.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/use-linux-command-line-to-resist-obsolescence-and-future-proof-yourself/">Use Linux Command Line to Resist obsolescence and Future-proof Yourself</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/making-a-fresh-start-with-lifelong-future-proofed-journaling/">Making a Fresh Start with Lifelong Future-proofed Journaling</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/muscle-memory/'>Muscle Memory</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/desktop/'>Desktop</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/twitter/'>Twitter</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li>
<li><h4><a href='/mac/'>Mac</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>