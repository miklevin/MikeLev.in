---
date: 2022-07-20
title: Moving Into LXD WSL2 ~/ 'Home' Once You've Moved Into Containers
permalink: /blog/moving-into-lxd-wsl2-home-once-you-ve-moved-into-containers/
headline: Creating a Comfortable and Productive Home with LXD and WSL2
description: This blog post explains how I am using Linux Containers (LXD) and WSL2 to create a comfortable and productive home, inspired by a YouTube video about a child prodigy. I'm detailing the steps I'm taking to mount my ~/github and ~/.ssh files to my container, codifying the steps to create a container, setting up a script to put a few files directly in ~/ including a .bash_profile, creating a 'helpers' repo, installing git and python
keywords: Linux Containers, LXD, WSL2, Home, YouTube, Child Prodigy, Github, Software Repositories, Portable, Bash_profile, Helpers Repo, Git, Python, Python3.10, Virtual Environment
categories: wsl2, home, github, git, python, lxd, youtube
layout: post
---

Think! Hmm, okay. Next step is still the beginning. Wow is that powerful.
Things are always in transition and I am always re-establishing "home".

This post is about that re-establishing of a comfortable and productive home.

I love listening to the YouTubes. I'm listening to one called World's smartest
person wrote this one mysterious book.

Okay, next? Next is rebooting... no, I'm doing it continuously. I'm just doing
it slowly.

Transition.

Buckminster Fuller who was a classmate of this child prodigy who predicted the
black hole reviewed some of the rediscovered works of William James Sidis, who
was a child prodigy "manufactured" by his parents. Wow, Skillshare seems to be
sponsoring everything these days. Maybe I ought to pay attention. Think about
ongoing life for Adi. The era of the Tardigrade Circus is almost upon us. That
ship HAS NOT SAILED. I will contrive myself to be at the forefront of some
interesting stuff going on which will double as an income source, a big chunk
of their higher-grades education and a way to stay relevant as we plummet into
the future.

Keep all your eggs in one basket, then copy that basket all over this place.
This post concerns making that "all over the place" portion of that wisdom
true. We already have Github for making our software repositories portable. We
need our important mapped drives now such as ~/github and ~/.ssh. That
literally gives you the keys to the (albeit your own) kingdom.

Okay now, next steps once again? Don't let yourself get distracted. It's time
to convert this journal post public. Then force yourself to "recapture state".
Recapturing state is such an important concept for picking up where you left
off in order to continue being productive.

Okay, so I'm here to report to you from the front-lines of staying relevant and
resisting obsolescence in a technologically rapidly changing world.

Things need not be so scary on the tech-front. That is, it need not be scary if
you learn it pretty deep, taking advantage of today's cheap, powerful and
abundant hardware, using it first how it was intended to be used. And that is
as a proprietary Windows 10 or 11 laptop.

This is cringe to the ears of millions. And I agree

I'm going to do a release on this journal to start getting some new published
material out there. But then I have to force next-step!

Jekyll is a humbling lesson in patience. 1, 2, 3... 1? Step 1 at this point is
to enumerate the requirements for a "new home" in Linux. What does it really
entail in terms of:

- Moving keys (mechanism?)
- Sharing the ~/github location

Before I go listing, take care of that that hugely important point. I found
this page: https://www.cyberciti.biz/faq/how-to-add-or-mount-directory-in-lxd-linux-container/
It says:

> To mount the host's /wwwdata/ directory onto /var/www/html/ in the LXD
> container named c1, run:

    lxc config device add c1 sharedwww disk source=/wwwdata/ path=/var/www/html/

So for my use, it would read:

    lxc config device add GlookingLass github disk source=/mnt/c/Users/mikle/github/ path=~/github/

I tried it and had this success:

```bash
[py310] healus@LunderVand:/mnt $ lxc config device add GlookingLass github disk source=/mnt/c/Users/mikle/github/ path=/home/ubuntu/github/
Device github added to GlookingLass
[py310] healus@LunderVand:/mnt $ lxc exec GlookingLass -- su --login ubuntu
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@GlookingLass:~$ ls
github
ubuntu@GlookingLass:~$
```

That is a success assured moment. So what are you really doing here?
Interesting! Okay, this hasn't shared your .ssh file. Try doing that as well.

    lxc config device add GlookingLass dotssh disk source=/mnt/c/Users/mikle/.ssh/ path=/home/ubuntu/.ssh/

Success! Wow, this is big. How much is it now to slam out new home instances.
These two commands only need be done once after each new container creation. So
go through all the moves, capturing them here again. You are codifying
containerization home moves. Moving home when you've moved into containers.

Okay, think! From the top:

```bash
lxc stop GlookingLass
lxc delete GlookingLass
lxc launch images:ubuntu/18.04 GlookingLass
lxc config device add GlookingLass github disk source=/mnt/c/Users/mikle/github/ path=/home/ubuntu/github/
lxc config device add GlookingLass dotssh disk source=/mnt/c/Users/mikle/.ssh/ path=/home/ubuntu/.ssh/
lxc exec GlookingLass -- su --login ubuntu
```

Okay, so with the ~/github and ~/.ssh folders from the Linux host linked, why
is this container not instantly home? What's still missing? The running of a
script to put a few files directly in ~/ including maybe a .bash_profile.

Is this my new "helpers" repo?

homer

Hmmm. Homer, haha! Maybe. Sure, why not? Nice strong identity. Has something to
do with traveling and home... maybe. Sorta.

Okay, made that repo. Since it's mapped into ~/github already I don't even need
to clone it, though doing so would be good to test the keys.

Wow, it doesn't even come with git pre-installed.

If we're using containers and we're installing Python for the first time, do we
even really need virtualenv's?

Okay, so this is the tricky part now. Let's make the script that sets these
containers up.

    sudo apt install git
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install python3.10
    sudo apt install python3.10-venv
    python3.10 -m venv py310

Wow, and that pretty much does it.

## Categories

<ul>
<li><h4><a href='/wsl2/'>WSL2</a></h4></li>
<li><h4><a href='/home/'>Home</a></h4></li>
<li><h4><a href='/github/'>Github</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li></ul>