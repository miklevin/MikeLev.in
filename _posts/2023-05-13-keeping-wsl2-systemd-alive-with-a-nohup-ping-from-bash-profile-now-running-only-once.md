---
date: 2023-05-13
title: Keeping WSL2 systemd Alive With a nohup ping From .bash_profile, Now Running only Once!
headline: I Found the Solution to Keeping WSL2 systemd Alive With a nohup ping From .bash_profile!
description: Learn how to use existing tools to make your daily work easier. Get tips on how to layer on improvements and changes, and how to organize your files. Find out how to set up a Mac and run a nohup ping command from your .bash_profile. Get the solution to keep it running only once!
keywords: Windows 10, Windows 11, Linux, Mac, Bash Profile, Bash Scripting, YAMLchop, Vim, Pyenv, Journaling, Journal Repo, DrinkeMe, Fstab, NAS, Cloud, Apt Update, Apt Upgrade, Python 3.8, Snowpack, MikeLev.in, Configuration, Cutting Catapult Ropes, Nohup, Ping Command
categories: journaling, mac, linux, vim, microsoft
permalink: /blog/keeping-wsl2-systemd-alive-with-a-nohup-ping-from-bash-profile-now-running-only-once/
layout: post
---


Wow, you know how long it takes to change your roster of text files that you
always have loaded for daily editing and updating. Just as long as you don't
think you need it, then BAM! But this is also a great example of consecutively
layering on the improvements and changes and tweaks day by day to make things
easier. It's not framework building. It's getting better at using the tools you
already have, but which are each big enough to allow continual improvement for
life.

My file I call `all` which I used to keep in the difficult to edit
`/usr/local/sbin/` and had it full of my "first-pass" code now is kept in
`~/pyenv/bin/` and has been considerably refined with my new techniques and
prettyification, so changing the file-roster is much easier. So I am able to
easily add and move and rearrange the files that I'm editing, let Copilot into
some and keep it out of others, and generally make it easier to do my work,
keep records and document things, and move them up and down in priority.

Also, I changed the name of my `MikeLev.in` directory to `blog` and moved it
and my journal repo up from the `hide` subfolder in repos to the top level.
This sets the stage for me to actually put a fully working copy of YAMLchop so
anyone wanting to try my journaling system as a way of getting started with Vim
can do it with no effort. It's all already there when they run `DrinkMe`.
They'll have their own ***blank template*** `journal` and `blog` directories.

Anyone following along who wants to get started doing public blogging like
this, or the other if they want to do private journaling. I'll have to look at
how to keep one version of the `all` file for the public and one for me. It's
part of the cutting of the catapult ropes. This sort of writing for one's self
could be perfect storm timing.

It looks like I'll have a post-drinkme script of my own. It can also make the
`fstab` entries to mount my home cloud (NAS) shared drives. 

I'm getting ready to set up the new Mac. I've had the hardware actually for a
couple of weeks now, but I've been so focused on work that I didn't have time
for settling into new hardware. But now that `DrinkMe` has gone through it's
next major revision that silences all the `apt update` and `apt upgrade` noise
that I'm sure had people running the other direction fast, I also got rid of
some of the most major Windows problem of having to keep a Linux terminal open
at all times, and my own most urgent need of having to run Python 3.8 for
Snowpack.

It's actually quite well tested on Windows 11 now. I need to do my Windows 10
test. Hey, I'm on Windows 10 now! Do the test. I need to get across how easy it
is to just re-install Linux and how all your data (Github repos, configuration
and such) stays safely in place.

Okay, I'm back without a hitch. It's tested on Windows 10, but I really have to
take care of a little fact that I left hanging because I was so relieved to get
it working at all.

Hey ChatGPT: How can I run something a nohup'd ping command from my
.bash_profile but make sure it's not already running. It's always called ping
and it shows up with that name in ps -ax ?

ChatGPT: You can use a combination of the `pgrep` and `nohup` commands to achieve this. 

`pgrep` is a command that searches for a process by name and returns its PID (process ID) if it's running. 

`nohup` is a command that runs a command and prevents it from being terminated when the shell session ends.

Here's an example of how you can use these commands to achieve your goal:

1. Open your `.bash_profile` file using a text editor.
2. Add the following lines at the end of the file:

```
if ! pgrep -x "ping" > /dev/null
then
    nohup ping <hostname> &
fi
```

3. Replace `<hostname>` with the hostname or IP address that you want to ping.
4. Save and close the file.

Here's how this code works:

- `pgrep -x "ping"` searches for a process with the name "ping" and returns its PID if it's running.
- `> /dev/null` redirects the output to `/dev/null`, which discards it. We don't need to see the output of `pgrep`.
- `if ! pgrep -x "ping" > /dev/null` checks if the ping process is not already running.
- `nohup ping <hostname> &` runs the `ping` command with the specified `<hostname>` and redirects its output to a file called `nohup.out`. The `&` symbol runs the command in the background, which allows the shell session to continue.

So if the `ping` process is not already running, this code will start it and run it in the background. If it's already running, it won't start a new instance.

Excellent! That was the solution. Ping is only running once. Hopefully not too
many people downloaded it between this morning and now. And it's tested on
Windows 10 to boot. And I've got to get that Mac set up. That'll be my last
thing for tonight, I'll get myself staged to do the Mac work.














<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/smart-people-read-dumb-people-tell-you-they-did-after-watching-the-movie/">Smart People Read. Dumb People Tell You They Did After Watching the Movie.</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/exploring-default-behavior-of-m2-mac-preparing-to-write-mac-drinkme/">Exploring Default Behavior of M2 Mac, Preparing to Write Mac DrinkMe</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/mac/'>Mac</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>