---
date: 2022-07-25
title: Removing Password Authentication from SSH Services
headline: Securely Eliminating Passwords with OpenSSH and Linux Containers
description: I created a new Linux container with OpenSSH service and disabled the ability to challenge passwords, then moved keys over to eliminate passwords. I also set up a shared folder with three sub-folders, changed permissions on the keys, and restarted the SSH service. Read my blog post to learn how I did it.
keywords: Linux, OpenSSH, Password Authentication, SSH Services, Shared Folder, Sub-Folders, Permissions, Keys, Restarting
categories: linux
permalink: /blog/removing-password-authentication-from-ssh-services/
layout: post
---


1. Get a new LXD container that doesn't trigger the warning.
   - Don't forget to use NAT networking mode.
   - Add port 2222 to port 22 NAT map.
2. Login locally to give ubuntu user a password and add openssh-server service.
3. Ensure that you can login using the ssh program (re-figure-out IP?)
4. Get rid of the password challenge.
5. Move keys over to get rid of passwords.
6. Get keys in place to git clone from github without challenge.

# Eliminating Password From OpenSSH on NAS Linux Container

{% include youtubePlayer.html id="JLEjZrJVg6U" %}

Create new keys? They're auto-generated in /etc/ssh/ but just in case:

    ssh-keygen -t rsa -C "email@address.com"

Do we need to turn off the ability to challenge passwords? I so:

- sudo vim /etc/ssh/sshd_config
- PasswordAuthentication no
- ChallengeResponseAuthentication no

What I'm sure I do need is a list of authorized keys. If only one then it's the
same as the actual public key being used. One public key, one line.

Much of this video went into creating the ~/data shared folder. Now all
locations have the same 3 folders:

- data
- github
- py310

That's a good setup for the videos to come!

systemd-way to restart a service:

    sudo systemctl restart ssh

It wasn't even necessary. But it was very necessary to chmod the files
correctly:

    sudo chmod 600 id_rsa

And so on.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/linux-container-under-windows-10-wsl-supporting-graphics">Linux Container Under Windows 10 WSL Supporting Graphics</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/new-container-station-lxd-ubuntu-18-04-image-and-ssh-server-install">New Container Station LXD Ubuntu 18.04 Image and SSH Server Install</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>