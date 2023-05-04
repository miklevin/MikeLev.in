---
date: 2022-06-15
title: LXD on WSL2 is a Few Months Ahead Of Its Time
headline: Exploring the Challenges and Solutions of LXD on WSL2 as an Early Adopter
description: As an early adopter of LXD on WSL2, I've encountered confusion between LXD and Docker, downgraded tutorials to Ubuntu 18.04, confirmed LXD requires systemd, tested to see if it is running, and encountered network context issues. I have also found various approaches to solve them. Join me as I explore the challenges and solutions of LXD on WSL2.
keywords: LXD, WSL2, Early Adopter, Confusion, Docker, Ubuntu 18.04, Systemd, Running, Network Context, Challenges, Solutions
categories: wsl2, systemd, docker, lxd
permalink: /blog/lxd-on-wsl2-is-a-few-months-ahead-of-its-time/
layout: post
---


I am almost always doing what people are really going to want to do a few
months from now.

Next try! Remind everyone why this is so worth it... that pic!

Do this until it is done. Don't give up and let the nice folks see the Charlie
Brown routine. Kick at the football and end up on your back as many times as it
takes. But don't be tricked. Intelligently adjust technique.

There still seems to be confusion about LXD vs. Docker. Clarify. Show how
Canonical is the project lead (a recent discovery of mine).

https://linuxcontainers.org/

- All tutorials are under Ubuntu 18.04, so downgrade... done!
  - Tutorials use 18.04
  - No "Snap Store" requirements (snapd)
  - Snap Store is another Canonical initiative to make installs easy
- Most evidence points to lack-of systemd being the culprit
  - Confirm that LXD actually requires systemd
    - https://linuxcontainers.org/lxd/docs/master/faq/
  - Figure out how to test if systemd is running
    - https://dannyda.com/2020/09/20/how-to-check-if-the-system-is-using-running-systemd/
    - ps --no-headers -o comm 1
- Additional evidence points to network context issues
- The problems are known and there are various approaches
  - Show the good tutorial as if no WSL
    - https://blog.selectel.com/managing-containers-lxd-brief-introduction/
  - Show the "dirty" solution from early on
    - https://blog.simos.info/how-to-run-lxd-containers-in-wsl2/
  - Show the cleaner solution... the itch is being scratched
    - https://wsl.dev/wsl2-lxd-funtoo/
  - Show wsl-distrod and how scratching the itch became a Github repo
    - https://github.com/nullpo-head/wsl-distrod

And THAT'S where we begin!

This is a holding pattern... the same way I'm on Windows 10 but telling people
on Windows 11 to wsl --install, I'm biting the bullet and chasing the rabbit
for benefit today.

It'll come into better shape tomorrow, Guaranteed.

    healus@LunderVand:~$ sudo lxd init
    Would you like to use LXD clustering? (yes/no) [default=no]:
    Do you want to configure a new storage pool? (yes/no) [default=yes]:
    Name of the new storage pool [default=default]:
    Name of the storage backend to use (btrfs, dir, lvm) [default=btrfs]:
    Create a new BTRFS pool? (yes/no) [default=yes]:
    Would you like to use an existing block device? (yes/no) [default=no]:
    Size in GB of the new loop device (1GB minimum) [default=50GB]: 10
    Would you like to connect to a MAAS server? (yes/no) [default=no]:
    Would you like to create a new local network bridge? (yes/no) [default=yes]: n
    Would you like to configure LXD to use an existing bridge or host interface? (yes/no) [default=no]: y
    Name of the existing bridge or host interface: eth0
    Would you like LXD to be available over the network? (yes/no) [default=no]:
    Would you like stale cached images to be updated automatically? (yes/no) [default=yes]
    Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]:

I have overcome big obstacles:

- systemd is installed under wsl2 and so lxd installed too
- the lxd init process runs without errors
- I'm having difficulties with the steps following that

Charlie Brown kicked the football, but doesn't know how to play the game now.
I need to put the time in on learning the lxc commands and general API.

I am feeling bleeding edge pain of early adopters.



## Categories

<ul>
<li><h4><a href='/wsl2/'>WSL2</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/docker/'>Docker</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li></ul>