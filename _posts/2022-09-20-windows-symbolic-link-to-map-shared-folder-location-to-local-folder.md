---
date: 2022-09-20
title: Windows Symbolic Link to Map Shared Folder Location to Local Folder
headline: "Mapping Shared Folder Location to Local Folder: My Journey to Get My Repos Folder Working on Windows and WSL"
description: I recently set up a shared folder on my NAS to use as a repos drive. After a lot of work, I managed to get it working in both Windows and WSL, but the performance dropped too much when I moved the repos folder to the NAS. I had to reverse my work, updating the firmware on my NAS, renaming the Windows 'D' drive to an 'R' drive, and running an install.bat script and creating an apt_installs.sh file.
keywords: Windows, Symbolic Link, Map, Shared Folder, Location, Local Folder, NAS, Repos Drive, Firmware, Rename, Install.bat, Apt_installs.sh, Chrome OS, Linux, Commands, Restart
categories: linux, microsoft
permalink: /blog/windows-symbolic-link-to-map-shared-folder-location-to-local-folder/
layout: post
group: blog
---


It's really nice when what I want to do for the public is what I ***have to***
do for myself. Starting up the Linux Jupyter service after a Windows restart
was the perfect example. I restart my machine from scratch more often than I
really have to just to clear my mind. Clear computer, clear mind.

Anyhoo, the next thing is to change my shared data drive on my NAS to a shared
repos drive (instead). Oh, a firmware update. ***ALWAYS*** do your NAS firmware
updates. I owned my NAS for maybe a good 2 full years before I finally set it
up and as it turns out I'm happy I didn't have it on for those 2 years. It was
really hostile out there. It still is, but QNAP has stepped up and with such
high profile NAS hacking, I can lock things down and harden it right away with
no Internet connectivity.

So I'm going to be breaking my "D" drive (for data) on my Windows machines, and
switching it to an "R" drive (for repos). And while that's going on, refresh my
memory regarding the mounts.

Mounting a drive across systems is not the same as creating a symbolic link
within a system. Symbolic links are easier. There's fewer moving parts.
Mounting may touch heterogeneous systems across weird boundaries, such is the
case here. Another difference is that symbolic links don't need target
directories in location while mounted drives do. Think! Does this have any
ramifications on the WSL2LXD project? It shouldn't. Oh wait, what was once just
a directory Windows-side becomes the R-drive. Can a shortcut make it look like
a directory again? Yes, it looks like subst r: C:\Folder\Example

Okay, on the NAS web interface, change the name and path of the data share to
repos. Okay go into Hybrid Backup Sync HBS3 and update the jobs so its backup
up the location with the new name. Done. Okay, take a look at what happened to
my "D" letter drive. An error occurred while reconnecting D to NAS address.
Microsoft Windows Network: The local device name is already in use. This
connection has not been restored.

Strange message. Anyway, it turns out that I'm going to keep the actual path of
the shared folder on the NAS as /data and just rename it as repos. This has the
desired effect without having to move a whole bunch of huge files around.

The command I will be using now is:

    subst r: C:\Users\mikle\repos
    NOTE: THIS DID NOTE WORK!

...except that I have a repos folder there already. Copy its contents into the
new location. No, Move the files. I'm going to be deleting them from here
anyway. This is big for me, moving my main repos off my local machine and onto
the NAS. About 4GB of data which is going to take about 2.5 hours to finish.
But it is totally worth it because now any machine I sit down at in my house
will be equally up-to-date for journal entries without having to deal with git.

I the meanwhile, I want to get some work done. Specifically it's stuff that's
going to take graphics capabilities on the Linux side.

Oh, it sped up immensely. Only 6 minutes left.

Still, think! Graphics on Linux-side is really a matter of doing a series of
apt installs. I want genuine Chrome OS and not just the Chromium that installs
automatically with pyppeteer. And I think I'd like to keep the pyppeteer issues
separate from the Chrome issues. So focus on the Chrome install first. And by
that I mean focus on getting apt_installs.sh working. 1, 2, 3... 1?

Thought-work. This is something that should happen once, just when the
install.bat script is run. It should be preserved though, just in case. And so
it should use whatever is in the same folder as install.bat because that's the
only reasonable decision there. It will have access to the entire ~/repos
location and so it should move the finished one into ~/repos/temp which is used
for other purposes during the install. That way even if you blow away the file
you created, there'll be a residual copy left over.

apt_installs.sh won't be there for a lot of people doing my process because
they'll have just created a batch file Windows-side the copy/paste way. I'll
make sure they know they ***can*** create these files, but most of the time
they won't be there. So I need logic similar to the one that checks for the
existence of the repos folder before it creates one, but checking the existence
of a file.

Okay, the entire repos folder is moved over to my NAS. I have "R" mapped to
\\EchidNAS\repos. I made a new empty repos folder in my Windows home folder.
And now to mount it from under WSL. Okay, now my WSL instance is ahead of my
Windows, haha!

    sudo mount -t drvfs '\\EchidNAS\repos' /home/healus/repos

Let's get a ~/repos folder working in Windows, which in PowerShell would really
be a $env:USERPROFILE\repos folder working. Okay, got it working. You need to
run PowerShell as Administrator (of course).

    New-Item -ItemType SymbolicLink -Path "C:\Users\mikle\repos" -Target "\\EchidNAS\repos"
    NOTE: THIS WAS NOT LINKABLE IN-TURN FROM WSL

Ugh, I'm going to have to make good note of this because I'm going to have to
do that on all my Windows machines.

And finally do a complete (and true) restart to see if it sticks.

    shutdown -f -r -t 10

Oops, my WSL Ubuntu 20.04 lost repos (of course). I mean the folder's still
there, but it's not the network drive silly. I need to re-mount it:

    sudo mount -t drvfs '\\EchidNAS\repos' /home/healus/repos

...and then make it persistent updating the line in my /etc/fstab from:

    \\EchidNAS\data /home/healus/repos drvfs defaults 0 0

to:

    \\EchidNAS\repos /home/healus/repos drvfs defaults 0 0

And another restart!

After quite a bit of work, I've managed to get things pretty much the way it's
supposed to be. That convoluted PowerShell command up there is much more easily
accomplished in a COM window with Amin rights using this command:

    mklink /d %USERPROFILE%\repos R:

However, there's a problem here that's going to be unique to me because my
repos directory is a Windows-style symlink to a letter-drive which assigned to
an SMB-style network shared location.

Okay, so this is imperfect world stuff. Run the script to ensure that it will
work for most people correctly. A repos folder is made in their Windows home
and that's used cross-operating system, and most people can start from there.
For me, my repos directory appears to be there because of a Windows-style
symbolic link, but the cross-OS stuff won't work. Instead I'll have an "empty"
repos folder Linux-side like everyone else and I'll have to do the mount and
/etc/fstab edit to get my real repos folder. So be it.

Do a full install now (run the script) and ensure that I do have a blank repos
folder so the video demos are solid.

Okay, so it does work solid for everyone else, LOL! They get ~/repos and
~/repos/transfer. But for me, I'm going to have to have to do the following
commands logged into WSL but not LXD:

    sudo mount -t drvfs '\\EchidNAS\repos' /home/ubuntu/repos
    lxc config device add jupyter repos disk source=~/repos path=/home/ubuntu/repos

And then I have to sudo vim /etc/fstab to append this because I can't
echo-append it directly in. I'll have to investigate that.

    \\EchidNAS\repos /home/ubuntu/repos drvfs defaults 0 0

But now that I've done those things, I should be able to reboot my system and
have my NAS-hosted repos folder there. Try it!

PERFORMANCE DROPPED TOO MUCH WITH REPOS ON NAS

Well I really outsmarted myself there. Moving my repos folder onto the NAS was
a complete disaster, but it was for the best. I basically undid all my work and
went back to a separate data folder on the NAS (home cloud) and a local repos
folder. I'm basically reversing most of the stuff from the last few posts and
hoping I can get to sleep early enough to hit the work I urgently need to
deliver for work.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/created-windows-shortcut-to-start-linux-jupyter-on-lxd/">Created Windows Shortcut To Start Linux Jupyter on LXD</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/wsl2lxd-is-now-lxdwin-apt-pip-installs-done-graphics-implemented/">WSL2LXD is now lxdwin, Apt & Pip Installs Done. Graphics Implemented.</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>