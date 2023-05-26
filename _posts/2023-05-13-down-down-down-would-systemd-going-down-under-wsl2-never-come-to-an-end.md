---
date: 2023-05-13
title: Down, down, down! Would systemd going down under WSL2 never come to an end?
headline: I Tried Everything to Keep Systemd Alive - Here's What Finally Worked!
description: I explored a litany of ways including the formal ones to prevent Linux systemd services from going down under WSL. After trying the .wslconfig and wsl.conf files, a systemd .service file, a cron job and .bashrc, I finally a added the nohup ping busy-task to .bash_profile to keep Linux services running under WSL2. But at a price. s
keywords: date, Sat, May, 13, 2023, systemd, WSL2, Craig Loewen, Microsoft, WSL Program Manager, YAML, TOML, .INI, key/value pairs, vmIdleTimeout, %userprofile%, .wslconfig, wsl.conf, Linux, terminal, background, global scope, local scope, command, Python, venv, virtual environment, path, neovim, Markdown, link, cursor, Intel
categories: python, yaml, systemd, wsl, microsoft, vim, linux
permalink: /blog/down-down-down-would-systemd-going-down-under-wsl2-never-come-to-an-end/
layout: post
---


Okay, time to fix a long-standing problem. There's supposed to be a more formal
way, and I've explored it. In griping about it on the YouTubes, I even
attracted the attention of Craig Loewen, the Microsoft WSL Program Manager who
started to respond then deleted it. Don't know why, LOL! Maybe the solution he
was proposing didn't really work, or because I'm a prickly mofo. Probably the
later.

Anyhoo, the formal way that WSL's inability to keep running Linux systemd
services in the background when the last Linux terminal is closed is to have a
directive in either your Windows-side global scope WSL configuration file
called `.wslconfig` that's kept in your USERPROFILE directory, or in your
per-WSL-instance side local scope configuration file called `wsl.conf` kept in
your /etc directory Linux-side.

The "language" on both is supposed to be the same. And all the good stuff
should go global so it runs early-stage because wsl.exe has access to it before
the Linux instance is instantiated. The format appears to be Microsoft's
long-standing `.INI`, like a precursor to the aforementioned YAML and TOML
files, but it's from Microsoft and uses "equals" for key/value pairs instead of
colons which JSON made all the cool kids prefer. YAML, TOML, INI, who cares?
Here's what one looks like, and my most recent attempt:

```
[boot]
systemd=true
vmIdleTimeout=1000
[automount]
options="metadata"
```

Me: Hey Bing, what does vmIdleTimeout mean?

Bing: The `vmIdleTimeout` is a configuration option that controls the idle
timeout of the WSL2 virtual machine (VM) ¹. The timer starts once all WSL2
distributions/instances/containers have terminated. Once you exit the last WSL2
distribution/instance, assuming no other processes are running in the
background, a 15-second timer starts, after which the instance itself is
terminated ²³.

You can add `%userprofile%.wslconfig` option to control the VM idle timeout
(wsl2.vmIdleTimeout=<time_in_ms>) ¹. You can also add `[wsl2] vmIdleTimeout=-1`
in `%userprofile%/.wslconfig` to completely disable the timeout ².

I hope this helps. Let me know if you have any other questions.

Source: Conversation with Bing, 5/13/2023

    (1) Releases · MicrosoftDocs/WSL · GitHub. https://github.com/MicrosoftDocs/WSL/releases.
    (2) vmIdleTimeout has no effect - bytemeta. https://bytemeta.vip/repo/microsoft/WSL/issues/8654.
    (3) vmIdleTimeout has no effect · microsoft WSL · Discussion #8659. https://github.com/microsoft/WSL/discussions/8659.
    (4) vmIdleTimeout has no effect · Issue #8654 · microsoft/WSL. https://github.com/microsoft/WSL/issues/8654.

Me: Show me an example of a .wslconfig file that does this (turns vmIdleTimeout to -1)

Bing: You can add `vmIdleTimeout=-1` in `%userprofile%/.wslconfig` to completely disable the timeout ¹. 

Here is an example of a `.wslconfig` file that does this:

```
[wsl2]
vmIdleTimeout=-1
```
You can add this to `%userprofile%/.wslconfig` ¹.

I hope this helps. Let me know if you have any other questions.

Source: Conversation with Bing, 5/13/2023

    (1) vmIdleTimeout has no effect · microsoft WSL · Discussion #8659. https://github.com/microsoft/WSL/discussions/8659.
    (2) vmIdleTimeout has no effect · microsoft WSL · Discussion #8659. https://github.com/microsoft/WSL/discussions/8659?sort=top.
    (3) Release Notes for WSL | Microsoft Learn. https://learn.microsoft.com/en-us/windows/wsl/release-notes.
    (4) Advanced settings configuration in WSL | Microsoft Learn. https://learn.microsoft.com/en-us/windows/wsl/wsl-config.
    (5) Verify that config value applied in WSL - Super User. https://superuser.com/questions/1745166/verify-that-config-value-applied-in-wsl.
    (6) vmIdleTimeout has no effect · Issue #8654 · microsoft/WSL. https://github.com/microsoft/WSL/issues/8654.

Okay, I did that. I could just `wsl --shutdown` and restart the instance, but
why do that when you can restart your entire system. Nuke the place from orbit,
it's the only way to be sure. And even then, there's Intel's Management Engine
(IME) to contend with, always checking if I AM ME, hahaha! Oh, Intel, I am so
going to be on free and open source hardware someday.

Okay, back. Top-10 answers on the board, survey says: Bzzzzzz! There's
something called the 8-second rule currently in WSL2 land with systemd
documented on [this
page](https://learn.microsoft.com/en-us/windows/wsl/wsl-config)

I need to document the alt-left and right square-bracket feature in neovim to
the nice people. I was reminded of this because opening left-square-bracket to
open a Markdown link like the one I just did above is currently being
interfered with on my system now in NeoVim. The opening bracket goes to the
right of the cursor and doesn't get left "behind" the cursor the way it's
supposed to. What makes it worse is that my traditional vim shortcut for
chopping off things to the right of the cursor, hitting the `Esc` key, then
`Shift+A` then `Backspace` dValentine Michael Smithoesn't work because my cursor can never actually
get to the right of the opening square bracket, see? It's almost certainly
Copilot related, and maybe it can help me fix it. 

The solution is to: `:set paste` then `Shift+Insert` then `:set nopaste` and
then `Shift+Insert` again. I'm going to try to fix it with Copilot.

Nope, sorry Copilot. That isn't a solution at all. It's a rabbit hole to fix
correctly and I'm sure it will cause a ruckus in a very small crowd and will
get fixed over at Github, but the magic keystrokes in the meanwhile are:

While in insert-mode, type TWO open-square-brackets, then do your typing, then
over-type by 1-character (a space) and hit the `Esc` key and then hit `x` for
delete twice, which will get rid of the extra opening square bracket hanging
off to the right, plus the extra space you typed. Awful short-term solution and
I hope it doesn't seep into long-term muscle memory, but 80/20-rule you know.

Back to the main thing: misrepresentation of yet another WSL feature. My
`.wslconfig` is in my Windows home directory (USERPROFILE) and it looks like
this:

```
[wsl2]
vmIdleTimeout=-1
```

...as instructed. And as I mentioned, there's this 8-second rule on that page I
was constructing the link to before I got square-bracketstracted. 

I had such high hopes of solving the WSL2 timeout problem, but alas! I still
may be doing something wrong, and I'm going to put that same .INI directive
into the Linux-side `/etc/wsl.conf` to see if that makes a difference. BRB!

Here's my new `/etc/wsl.conf` file:

```
[boot]
systemd=true
[automount]
options="metadata"
[wsl2]
vmIdleTimeout=-1
```

I'm back... 8-second-rule test... bzzzzz! No dice. Fail. Microshafted again.
Okay, I've exhausted the supposed-to-work routes. No errors are being reported
on these .INI values so I assume I'm not doing it wrong. My next step is to
create a busy-task that's broken off with nohup as all the bullshit advice
suggests. It's bullshit because... well, if I have to explain the irony of
using nohup to keep systemd from falling asleep on you, the you got some
learnin' to do, son. I don't think it's the Linux-clueful that WSL is
targeting, exactly.

Okay, deep breath. What would Azrael build when he dips into his fugue state?
It's not to be overbuilt. That's rule #1. If it's not on your utility-belt when
you need it, what good is it. Minimal new files. Minimal new overhead. No
new... no new... no new... SERVICE! It belongs right smack dab in the middle of
the same service that I'm trying to keep from falling asleep.

I already tried nohupping the gnu screen session, but that broke Jupyter. All
screen sessions became "dead terminals" and I'm not sure why. But that's a
whole lotta movin parts all piped through each other. So for folks following
along (hahaha, as if), systemd replaces the old-school init system, and it
starts services. You drop filename.service files into a directory and you
magically have systemctl enable, disable, start, stop and all those lovely
service-control actions available.

But the program-code isn't in the .service file. It's in whatever it's pointing
to, which is a command that I wanted to be really obvious and easy to type, so
I named it `startjupyter` and dropped it in `/usr/local/sbin` which is always
in your terminal's `path` environment variable and has such advantages as being
able to be typed from anywhere, and not having to type the `.sh` extension. I
have since realized that Python `venv` virtual environments are also in the
magic path and have much more permissive file permissions, so are way easier to
update and I moved `startjupyter` to `~/pyenv/bin/startjupyter`. It gets put
there by the `DrinkMe` script. Followed along? Good.

So I'm going to put the busy-task in the same place. I actually don't even need
to edit my `jupyter.service` file which is the one in `/etc/systemd/system`,
another terribly annoying place to update things. All is good in there, because
that's what references the easily modified `startjupyter` script, which FYI
looks like this:

```bash
#! /usr/bin/env bash

# To have access to an X-Server under Jupyter
export WSL2_GUI_APPS_ENABLED=1
export DISPLAY=:0
export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
export WAYLAND_DISPLAY=wayland-0
export PULSE_SERVER=/mnt/wslg/pulseserver

# To make Jupyter configs live in Windows space
export JUPYTER_CONFIG_DIR=/home/ubuntu/.jupyter
export JUPYTER_CONFIG_PATH=/home/ubuntu/.jupyter

source /home/ubuntu/pyenv/bin/activate

# To prevent double-running
cd ~/repos
screen -wipe >/dev/null 2>&1
if ! screen -list | grep -q "jupyter"; then
    screen -dmS jupyter /home/ubuntu/pyenv/bin/jupyter lab --ip 0.0.0.0 --port 8888 --no-browser --ServerApp.password='[hashed password]'
fi
```

Now the amount of good stuff going on in there is a whole 'nother blog post,
suffice to say I don't want things running twice that have a propensity to
run twice. Now if my premise is correct, I can just add another defensively
double-run-blocking few lines to the bottom of that script and I'm good to go.

Because the 8-second rule, the keep-alive pinging should be 6 seconds to
provide a generous 2-second overlap:

```bash
nohup ping -i 6 8.8.8.8 >/dev/null 2>&1 &
```

This is how you usually break a task off from its invoking console so you can
close the console without the task running. That's the ampersand at the end.
The part before that redirects both its standard output and its error output to
a place that only Valentine Michael Smith from Robert Heinlein's "Stranger in a
Strange Land" could appreciate. In short, it should be able to poof out of
existence and still be somewhere.

Do we still have the running twice problem? Ugh, having enumerable screens is
the key to housekeeping double-runs and we're not funneling nohup ping through
gnu screen. I tried that with the Jupyter session and it didn't work. So we're
maybe just going with 1-line here. If I accumulate mystery pingers, no big
deal. Hmmm, now I need a Microsoft IP to direct the pinging at. Who would get
the joke? The WSL-team, of course! What was that URL again? Oh yeah,
https://learn.microsoft.com/

```bash
nslookup https://learn.microsoft.com/

Server:         172.17.224.1
Address:        172.17.224.1#53
```

So all together, it's:

```bash
#! /usr/bin/env bash

# To have access to an X-Server under Jupyter
export WSL2_GUI_APPS_ENABLED=1
export DISPLAY=:0
export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
export WAYLAND_DISPLAY=wayland-0
export PULSE_SERVER=/mnt/wslg/pulseserver

# To make Jupyter configs live in Windows space
export JUPYTER_CONFIG_DIR=/home/ubuntu/.jupyter
export JUPYTER_CONFIG_PATH=/home/ubuntu/.jupyter

source /home/ubuntu/pyenv/bin/activate

# To prevent WSL2 from inhibiting Linux services
nohup ping -i 6 172.17.224.1 >/dev/null 2>&1 &

# To prevent double-running
cd ~/repos
screen -wipe >/dev/null 2>&1
if ! screen -list | grep -q "jupyter"; then
    screen -dmS jupyter /home/ubuntu/pyenv/bin/jupyter lab --ip 0.0.0.0 --port 8888 --no-browser --ServerApp.password='[hashed password]'
fi
```

BRB! Okay, back... 8-second rule? Fail! Check screen to see the service is
still running... check! Did I "break off" the nohup task too forcefully with
both output redirection and the ampersand? Run that ping again from a normal
WSL terminal and close the terminal and do the 8-second rule test... (oh yeah
gotta close my journal too 'cause that's a Linux terminal that would keep
systemd alive, sheesh!). It's also worth mentioning that I removed the
redirection and ampersand to make sure the ping command is working:

```bash
PING 172.17.224.1 (172.17.224.1) 56(84) bytes of data.
64 bytes from 172.17.224.1: icmp_seq=1 ttl=128 time=0.666 ms
64 bytes from 172.17.224.1: icmp_seq=2 ttl=128 time=0.688 ms
64 bytes from 172.17.224.1: icmp_seq=3 ttl=128 time=0.871 ms
64 bytes from 172.17.224.1: icmp_seq=4 ttl=128 time=1.08 ms
64 bytes from 172.17.224.1: icmp_seq=5 ttl=128 time=0.566 ms
64 bytes from 172.17.224.1: icmp_seq=6 ttl=128 time=0.792 ms
64 bytes from 172.17.224.1: icmp_seq=7 ttl=128 time=0.805 ms

--- 172.17.224.1 ping statistics ---
7 packets transmitted, 7 received, 0% packet loss, time 36040ms
rtt min/avg/max/mdev = 0.566/0.781/1.084/0.155 ms
```

...back! Holy smokes! It worked! Running ping from a normal WSL terminal,
replete with output redirection and ampersand, and closing the terminal, and it
keeps on pinging, thus keeping systemd from sleeping. I don't know whether to
be happy that I can solve this problem for DrinkMe users or angry at the
implications. Anything running under the context of a Linux service as the 
kibosh put on it. It could still be sensitive to the context of the service,
such as forking vs. simple, oneshot or whatnot. I'm not going to worry about
it because I'm certainly not going to experiment with that when I've got the
rather unappealing but working solution in hand.

Not to put too fine a point on it, but this means that if you're on the verge
of discovering the life-changing implications of summoning and controlling
Linux daemons and you're using Linux through Microsoft's "highly compatible"
and "highly standard" (real Linux kernel, yadda yadda), you're going to have a
sort of flakiness introduced to the discovery process that's going to
coincidentally sour your taste for it and put you on other paths, perchance
Windows services, hmm? 

And Microsoft even hired Lennart Poettering, the creator of systemd, to work on
WSL2, so they should definitely have the technical expertise to solve this
problem. Let me also add that I rigorously tested the advertised solution to
this, the `vmIdleTimeout` setting in `/etc/wsl.conf` and
`USERPROFILE\.wslconfig`, and it didn't work. I'm going to put the thoughts
aside that this naturally leads to and focus on solutions. Let me just say that
the world's pretty lucky that Python still works, because they hired Guido van 
Rossum too.

I'm going to think through the best context to get a nohupped pinging task
running on 1st-time Linux startup. I must avoid double-running because this
task is particularly susceptible to that, silencing output as it is. I could
have it write the log file, but ugh! Okay, think. All my old go-to's like
`rc.local` are off the table because the old sysvinit system is likely disabled
once systemd is enabled. Hmmm. Not `.bash_profile` because that's only for
interactive shells. I could put it in `.bashrc` but that too implies an open
terminal, at least once.

Hey Bing: Where can I put something to run once on a Linux WSL2 with systemd
enabled, but not as a systemd service? .profile or something like that?

![How To Keep Systemd Running Under Wsl Ping Conf](/assets/images/how-to-keep-systemd-running-under-wsl-ping-conf.png)

Haha, it won't even let me copy the Markdown source of this answer.
Serendipiseriously? Oh, Microsoft, if I didn't view the world through
snafu-colored glasses, I'd think you're up to something.

And another place that relies on whether or not Microsoft decided to support it
there or not, exactly like `vmIdleTimeout`. But it's built for these purposes,
and to win over the developers, and it's an easy test, and so now my `wsl.conf`
looks like this:

```bash
[boot]
systemd=true
command=nohup ping -i 6 172.17.224.1 >/dev/null 2>&1 &
[automount]
options="metadata"
```

BRB... OMG, NO! So every official and prescribed way of doing this doesn't
work, and I've been backed into doing a hack that has no official Microsoft API
in the picture. Let's see if .profile is an Ubuntu thing. 

Me: What's the difference between .bashrc and .profile. Where is the best place to put something to run once on Linux boot without the risk of double-running by opening subsequent Terminals?

Bing: The **.bashrc** file is executed every time a new shell is opened, while **.profile** is only executed when you log in to your computer¹. This means that if you want to set an environment variable that should be available every time you open a new shell, you should add it to your **.bashrc** file¹⁴. 

To run something once on Linux boot without the risk of double-running by opening subsequent Terminals, you can add the command to **/etc/rc.local** file²³. This file is executed after all other init scripts have completed². 

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 5/13/2023

    (1) Bashrc vs Bash_profile: When To Use Each One In Writing?. https://thecontentauthority.com/blog/bashrc-vs-bash_profile.
    (2) .bashrc vs .bash_profile | Linuxize. https://linuxize.com/post/bashrc-vs-bash-profile/.
    (3) Choosing between .bashrc, .profile, .bash_profile, etc. https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc.
    (4) linux - What are the functional differences between .profile .bash .... https://serverfault.com/questions/261802/what-are-the-functional-differences-between-profile-bash-profile-and-bashrc.
    (5) Difference Between .bashrc, .bash-profile, and .profile | Baeldung on Linux. https://www.baeldung.com/linux/bashrc-vs-bash-profile-vs-profile.
    (6) What’s the Difference Between .bashrc and .profile on Linux?.

Me: I can't use rc.local because it's a systemd system, but the purpose is to keep systemd from going to sleep, so I can't use it. It has to be something that works on Ubuntu.

![Please No Circular Discussions Bing Dont Use Systemd At All](/assets/images/please-no-circular-discussions-bing-dont-use-systemd-at-all.png)

Please no circular discussions, Bing. Don't use systemd at all. I'm trying to
keep systemd from going to sleep, so any solutions that use systemd won't work.
Any solutions using sysvinit won't work either because they're disabled when
systemd is enabled. Don't use .bashrc because that's only when a user logs in,
and it's running a web service the user never has to log in for.

Bing prefers not to continue the discussion, haha! I guess it's off to Google I
go. bard.google.com

Me: I'm trying to keep systemd from going to sleep, so any solutions that use systemd won't work. Any solutions using sysvinit won't work either because they're disabled when systemd is enabled. Don't use .bashrc because that's only when a user logs in, and it's running a web service the user never has to log in for.

Bard: Here are some solutions to keep systemd from going to sleep without using systemd or sysvinit:

1. **Use a cron job.** Create a cron job that runs a script that checks if the system is about to go to sleep and, if so, cancels the sleep. The script could be something like this:

```
#!/bin/bash

# Check if the system is about to go to sleep
if [ -f /etc/pm/sleep.d/zzz ]; then

  # Cancel the sleep
  rm /etc/pm/sleep.d/zzz

fi
```

To create a cron job, open a terminal and type the following command:

```
crontab -e
```

This will open the crontab editor. Add the following line to the crontab editor:

```
0 * * * * /path/to/script
```

This will run the script every hour.

2. **Use a watchdog timer.** A watchdog timer is a device or software that monitors the system and restarts it if it stops responding. There are many different watchdog timers available, both hardware and software. To use a watchdog timer, you will need to install the appropriate software or hardware. Once the watchdog timer is installed, you can configure it to restart the system if it goes to sleep.
3. **Use a power management daemon.** A power management daemon is a software program that manages the power consumption of a system. There are many different power management daemons available, both open source and proprietary. To use a power management daemon, you will need to install the appropriate software. Once the power management daemon is installed, you can configure it to prevent the system from going to sleep.
4. **Use a custom kernel.** If you are comfortable compiling your own kernel, you can add a kernel parameter that prevents the system from going to sleep. The kernel parameter is called `no_sleep`. To add the kernel parameter, you will need to edit the `/etc/default/grub` file. Find the line that says `GRUB_CMDLINE_LINUX_DEFAULT` and add the `no_sleep` parameter to the end of the line. For example, the line might look like this:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash no_sleep"
```

Once you have edited the `/etc/default/grub` file, you need to run the `grub-update` command to update the GRUB configuration. After you have updated the GRUB configuration, you need to reboot the system.

I hope this helps!

Whoah! Yeah, that does help, Bard. Thank you very much. Think!

Me: I have a ping script that I want to keep running. I can only issue commands to Linux from Windows-side using wsl commands. Give me a command I can put in a Windows bat script that will configure the Ubuntu 20.04 Linux to run the ping script once on Linux startup. My experiments show me doing under nohup is best.

Bard: Sure, here is the command you can put in a Windows bat script that will configure the Ubuntu 20.04 Linux to run the ping script once on Linux startup:

```
bash -c "nohup /path/to/ping_script &>/dev/null &"
```

This command will run the ping script in the background and ignore any output. The `nohup` command prevents the script from being killed when you exit the terminal. The `&>/dev/null` redirects both the standard output and standard error streams to `/dev/null`, which discards any output.

Here is an example of how you would use this command in a Windows bat script:

```
@echo off

rem This bat script will configure Ubuntu 20.04 Linux to run the ping script once on Linux startup.

rem Set the path to the ping script.
set PING_SCRIPT=C:\path\to\ping_script

rem Run the ping script in the background and ignore any output.
bash -c "nohup %PING_SCRIPT% &>/dev/null &"

rem Exit the bat script.
exit
```

I hope this helps!

Me: Wow, Bard. You continue to impress. But I need this command to configure the Linux-side to run this command, which happens to be /home/ubuntu/pyenv/bin/keep_alive, to run every time Linux starts. I only have one opportunity during setup of the Linux instance with a wsl setup/install script to configure Linux this way. There will be a late-stage wsl --shutdown in the install script, so you don't have to start it. Just set it up so it will start.

Bard: Sure, here is the command you can put in a Windows bat script that will configure the Ubuntu 20.04 Linux to run the `keep_alive` command every time Linux starts:

```
wsl config -o start --command "/bin/bash -c 'nohup /home/ubuntu/pyenv/bin/keep_alive &>/dev/null &'"
```

This command will use the `wsl config` command to configure the Ubuntu 20.04 Linux to run the `keep_alive` command every time Linux starts. The `start` option specifies the command that will be run when Linux starts. The `-o` option specifies the option to set. The `command` option specifies the command that will be run. The `nohup` command prevents the command from being killed when you exit the terminal. The `&>/dev/null` redirects both the standard output and standard error streams to `/dev/null`, which discards any output.

Here is an example of how you would use this command in a Windows bat script:


@echo off

rem This bat script will configure Ubuntu 20.04 Linux to run the keep_alive command every time Linux starts.

rem Run the wsl config command to configure Linux to run the keep_alive command on startup.
wsl config -o start --command "/bin/bash -c 'nohup /home/ubuntu/pyenv/bin/keep_alive &>/dev/null &'"

rem Exit the bat script.
exit


I hope this helps!

Me: Thank you, but that looks like it uses a custom Microsoft WSL API to do that, and I already tried it directly through editing wsl.conf and it doesn't work as advertised. Assume nothing using the official Microsoft APIs will work as advertised and do this with cron or equivalent that would work the exact same way whether or not it was under WSL. All the other criteria still apply such as it having to be a 1-time setup and accomplished through a command that has to execute Windows-side in a bat file, the wsl.exe command being used to do a Linux command being the 1 time a Windows API can be used.

Bard: I understand. Here is the command you can put in a Windows bat script that will configure the Ubuntu 20.04 Linux to run the `keep_alive` command every time Linux starts using cron:


wsl.exe -d Ubuntu -e "crontab -e; echo '*/1 * * * * /home/ubuntu/pyenv/bin/keep_alive' >> /etc/crontab"


This command will use the `wsl.exe` command to run the `crontab` command in the Ubuntu Linux instance. The `-d` option specifies the distribution to run the command in. The `-e` option specifies the command to execute. The `crontab` command is used to create and manage cron jobs. The `-e` option allows you to edit the crontab file. The `*/1 * * * *` cron expression specifies that the command will be run every minute. The `/home/ubuntu/pyenv/bin/keep_alive` command is the command that will be run.

Here is an example of how you would use this command in a Windows bat script:


@echo off

rem This bat script will configure Ubuntu 20.04 Linux to run the keep_alive command every minute.

rem Run the wsl.exe command to run the crontab command in Ubuntu Linux.
wsl.exe -d Ubuntu -e "crontab -e; echo '*/1 * * * * /home/ubuntu/pyenv/bin/keep_alive' >> /etc/crontab"

rem Exit the bat script.
exit


I hope this helps!

It does Bard, thank you! I can work with that solution. Dropping a cron command
in on Linux WSL instance creation! Nobody's going to turn off the cron API
anytime soon. More old-school than even I'm comfortable with (I love RegEx but
hate crontab), but easily tested. Examine the command... No doubt this is going
to have to be superuser context. So let's start with a working line from
`install.bat` as a template:

```
wsl -d Ubuntu-20.04 -u root -e sudo apt update >nul 2>&1
```

Now let's modify it accordingly:

```
wsl -d Ubuntu-20.04 -u root -e "crontab -e; echo '*/1 * * * * /home/ubuntu/pyenv/bin/keep_alive' >> /etc/crontab"
```

Now I copy/paste that into both a CMD and a Powershell to make sure it works in
either...

OMG! Cron is turned off too in WSL2. I can't believe it. I'm going to have to
really hack the shit out of this. Think! `.bashrc` after all? Just one line to
add to test, so that's the biggest potential payoff with the least work given
this mess so far. Still need to restart, so BRB... OMG, NO! Double-check that
this command when issued from a normal terminal:

```
nohup ping -i 6 172.17.224.1 >/dev/null 2>&1 &
```

...and the terminal closed (and this journal closed)... No, not my imagination,
definitely working. 8-second rule lots of positive result refreshes later, and
it's working as hoped. Sooooo `.bash_profile`? Yup, .bash_profile. Wow, go
figure! So the user has to open a Linux terminal at least once to get Juptyer?
Sigh, yes. 

That's how it stands. Anything else outside the formal places you do this stuff
is too hacky for Magic Trick Linux to be above reproach. When the
snooty-mc-snoot-snoots go over it with a fine-toothed comb, I can't have hacker
shit. Alice metaphors are not hacker shit. Oh wait... red pill you say? Okay,
it's on a spectrum. It's not pathologically hacker.

Update the installer language... Done. Test on Windows 11. Done. A terminal
needs to be open even the first time, so be it. And I took no defenses against
not double-running the ping command from .bash_profile. I hope this thing takes
off, haha!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/intense-round-of-pre-productivity-tooling-refinement/">Intense Round of Pre-Productivity Tooling Refinement</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/undisruptable-unsuppressible-unstoppable-unbreakable-unconquerable-indomitable/">undisruptable. Unsuppressible. Unstoppable. Unbreakable. Unconquerable. Indomitable.</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>