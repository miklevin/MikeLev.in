---
date: 2022-07-25
title: LXD Container on Windows WSL2 Using NAS SMB/CIFS Share
headline: Successfully Setting Up LXD Container on Windows WSL2 with NAS SMB/CIFS Share
description: After struggling to set up a LXD container, I found the solution to my problem - mapping my NAS, .ssh folder, .gitconfig, and .vimrc files, and then running two commands from within the container. I also had to mount a Windows network share using the command 'sudo mount -t drvfs '\\EchidNAS\data' /mnt/data'. Now my LXD container is running as expected.
keywords: LXD, Container, Windows, WSL2, NAS, SMB/CIFS, Share, Ubuntu, Python, Scheduling, Daemon, /etc/systemd/system, Uninstall, smbclient, Python 3.7, Symbolic Link, Device, Connect, /mnt/data
categories: container, scheduling, ubuntu, wsl, python, microsoft
permalink: /blog/lxd-container-on-windows-wsl2-using-nas-smb-cifs-share/
layout: post
group: blog
---


The forcible push forward because now I have lxd/lxc containers running as
easily as I had imagined. LXD really is like it's built into Linux now. And I'm
running Linux under Windows, so LXD feels like it's built into Windows!

It's been suggested to me to run Docker for Windows (or even LXD for Windows,
which I think exists), either of which would give me Linux containers under
Windows. But that's not the goal. The goal is Linux containers under Linux in
preparation for a Windows-free future. Windows is ALWAYS optional. Any time
you're introducing a new development tool from the Windows-side, beware! You're
being boxed-in by Microsoft.

Issues for today to solve to forge forward are:

I need a place for big Sqlite files! I plan on doing a lot of work that will be
"database back-ended" (if even using the Python dict key/value API). Throw the
results of a lot of requests into a "raw data bucket". And so the container's
"virtual" hard drive does not seem an appropriate place. I'm going to map in
probably a location on my home network, from my NAS (network application
server). I can share drive locations from there and it's in the context of my
home local area network (LAN) behind router.

I already have my ~/github folder mapped (which i

Mount host's "home" location as container's "home" location:

    lxc config device add container-name home disk source=/home/${USER} path=/home/ubuntu

I need to choose between mapping WSL host-Linux's home to the LXD container or
the github folder, which is itself a symlink on the Linux host. Catch-22.
That's an interesting vid. Do a part 2.

After removing all mounts from container, try this:

    lxc config device add GlookingLass home disk source=/home/${USER} path=/home/ubuntu
    lxc config device add GlookingLass github disk source=/mnt/c/Users/mikle/github path=/home/ubuntu/github

Ugh, no luck!

Okay it seems like I have to choose the best compromise. And it was very close
to my original plan!

So first I have to re-establish this from the WSL Linux Host for LXD:

    ln -s /mnt/c/Users/mikle/github /home/healus/github

Okay, so now I have my github folder from the Windows-side symlinked into the
Linux-side.

    lxc config device add GlookingLass github disk source=/mnt/c/Users/mikle/github/ path=/home/ubuntu/github/
    lxc config device add GlookingLass dotssh disk source=/mnt/c/Users/mikle/.ssh/ path=/home/ubuntu/.ssh/

What are the other folders?

- .cache
- .config
- .local
- .ssh
- .vim
- .virtualenv

Yeah, my initial gut is right. Of all these, only .ssh needs to be mapped in,
in addition to github.

But there are a few files that could use to be moved over:

- .gitconfig
- .vimrc

Hmmm, well .vimrc is already in the vim repo. And my bash script for editing my
journals ensures it's always up-to-date there, so I should really just throw my
.gitconfig into my ~/github/vim folder and grab it out of there on a 1-time
basis from new containers.

Okay, and now finally to have a home sweet home, we just execute these 2
commands from within the container:

    cp ~/github/vim/.vimrc ~/
    cp ~/github/vim/.gitconfig ~/

Ugh! When trying to git clone I get this error:

    [py310] ubuntu@GlookingLass:~/github $ git clone git@github.com:miklevin/oauthlogin
    Cloning into 'oauthlogin'...
    error: chmod on /home/ubuntu/github/oauthlogin/.git/config.lock failed: Operation not permitted
    fatal: could not set 'core.filemode' to 'false'

All the advice on the net involves doing this:

- Launch Ubuntu WSL
- sudo create the file /etc/wsl.conf if it doesn't exist
- Open the file and add the following lines:

    [automount]
    options = "metadata"

Save the file and shutdown WSL launching wsl --shutdown from a PowerShell
Relaunch Ubuntu WSL

I did this to the Linux host machine, and it miraculously did it.

    [py310] ubuntu@GlookingLass:~/github $ ps -aux
    USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
    root         1  0.0  0.1 224520  8188 ?        Ss   16:59   0:00 /sbin/init
    root       216  0.0  0.2  94584 13048 ?        Ss   16:59   0:00 /lib/systemd/systemd-journald
    root       220  0.0  0.0  42108  3564 ?        Ss   16:59   0:00 /lib/systemd/systemd-udevd
    systemd+   234  0.0  0.0  79924  5208 ?        Ss   16:59   0:00 /lib/systemd/systemd-networkd
    systemd+   259  0.0  0.0  70496  4900 ?        Ss   16:59   0:00 /lib/systemd/systemd-resolved
    root       260  0.0  0.2 170748 17512 ?        Ssl  16:59   0:00 /usr/bin/python3 /usr/bin/netwomessage+   261  0.0  0.0  49932  4420 ?        Ss   16:59   0:00 /usr/bin/dbus-daemon --system -syslog     262  0.0  0.0 193412  4048 ?        Ssl  16:59   0:00 /usr/sbin/rsyslogd -n
    root       263  0.0  0.0  70468  5900 ?        Ss   16:59   0:00 /lib/systemd/systemd-logind
    root       264  0.0  0.0  31296  3124 ?        Ss   16:59   0:00 /usr/sbin/cron -f
    root       267  0.0  0.0  15964  2436 ?        Ss+  16:59   0:00 /sbin/agetty -o -p -- \u --noclroot       268  0.0  0.3 187228 20372 ?        Ssl  16:59   0:00 /usr/bin/python3 /usr/share/unaroot       406  0.0  0.0  64768  3780 ?        Ss   17:04   0:00 su --login ubuntu
    ubuntu     407  0.0  0.1  76404  7232 ?        Ss   17:04   0:00 /lib/systemd/systemd --user
    ubuntu     408  0.0  0.0 258496  2852 ?        S    17:04   0:00 (sd-pam)
    ubuntu     418  0.0  0.0  21612  3980 ?        S    17:04   0:00 -su
    ubuntu     429  0.0  0.0  39672  3580 ?        R+   17:04   0:00 ps -aux

There's so little running there, I should be able to know each one pretty well.
This is the "before", before I add something running automatically under
systemd.

Alright, this is right on the verge of the damn busting wide open.

It took awhile for me to get here.

Take a few deep breaths. Make sure you can build something up in good
baby-steps. Document it here. Get it running here. Then use that as your
starting point for your next step at work.

Get your dashboards running under Huey on your home network first.

Start development local on your laptop, on an LXD container under WSL. This
native Linux container development under Windows 10 without any proprietary
Windows software except for the WSL-stuff now built-in. This is the beginning
of the "into the future" transition plan off of Windows.

Document the precise next steps.

Okay, we're going to be creating a Python scheduling daemon.

Or should that be a Python Scheduling Demon for clickbait?

It all starts here:

    /etc/systemd/system

And the file that would be named pulse.service that goes in there follows a
specific convention laid out here:

    [Unit]
    Description=Run Python script to handle scheduling

    [Service]
    Type=forking
    Restart=always
    RestartSec=5
    User=ubuntu
    Group=ubuntu
    WorkingDirectory=/home/ubuntu/github/hearbeat/
    ExecStart=/usr/bin/screen -dmS heartbeat /home/ubuntu/py310/bin/python /home/ubuntu/github/heartbeat/pulse.py
    StandardOutput=syslog
    StandardError=syslog

    [Install]
    WantedBy=multi-user.target

Such a file needs to be put or created in place with admin privileges. Merely
by virtue of being there, there is now a basis set of systemctl controls for
it, or usually also "system" controls if you prefer.

Hmmm. While I feel ready to jump right into systemd stuff finally, there's just
one more bit of housekeeping I need to tend to first. And that's the use of
Windows network shares like SMB/CIFS from a container. Doesn't look like it's
built in.

I went on a wild goose chase with smbclient. It turns out it's not necessary!
Uninstall it because it also put in a lot of python 3.7 stuff. Remember to do:

    sudo apt autoremove

...to clean up after anything that's been left behind. Okay. So this looks like
it works on the WSL Linux host.

The amazingly simple answer was:

    mkdir /mnt/data
    sudo mount -t drvfs '\\EchidNAS\data' /mnt/data

However, if this is tried on an LXD container, I get:

    unknown filesystem type 'drvfs'

Interesting! This drvfs looks like a WSL thing. Since it does not work on a
container, one more command is required from the Linux WSL host in order to
make this location available to the container. But we should settle in on a
~/data convention. So next we do this on the WSL Linux host:

    sudo ln -s /mnt/data /home/healus/data

We will still want to connect it from /mnt/data in the container, so we do
this:

    lxc config device add GlookingLass data disk source=/mnt/data path=/home/ubuntu/data

And I start the container and it's there!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/learning-nix-today-means-learning-systemd/">Learning *nix Today Means Learning systemd!</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/new-container-station-lxd-ubuntu-18-04-image-and-ssh-server-install/">New Container Station LXD Ubuntu 18.04 Image and SSH Server Install</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/container/'>Containers</a></h4></li>
<li><h4><a href='/scheduling/'>Scheduling</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>