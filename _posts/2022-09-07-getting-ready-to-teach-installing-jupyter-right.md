---
date: 2022-09-07
title: Getting Ready to Teach Installing Jupyter Right
permalink: /blog/getting-ready-to-teach-installing-jupyter-right/
headline: "Creating Linux Containers Under WSL: Bridging and Proxying for Access to Jupyter"
description: I'm setting up Linux containers under WSL for testing purposes, using a magical incantation to install Jupyter. I'm running into issues with the container having a different internal IP than the one on Windows-side, so I'm researching commands like lxc config and jupyter server to bridge, NAT, and proxy. After setting a password on Jupyter, I was able to access the LX - come read my blog post to find out how!
keywords: Linux, Containers, WSL, Testing, Jupyter, Incantation, IP, Bridge, NAT, Proxy, Password, LXD, Config, Server, Accessible
categories: jupyter, lxd, linux, wsl
layout: post
---

I've done quite a run of videos lately. I've even deleted a few super-short
posts here so as to not litter this blog (even more) with disjointed and
incomplete thoughts. All my focus is going over on those vids and I only just
come over here to type when I have to think things through. First, I feel I
should preserve this most magical incantation which is becoming the
.bash_profile of new LXC Linux containers under WSL that I'm creating more
frequently for testing.

```bash
# EXECUTE THESE FROM WSL TO GET COMMON LOCATIONS
# lxc config device add containername data disk source=/home/healus/data/ path=/home/ubuntu/data/
# lxc config device add containername dotssh disk source=/home/healus/.ssh/ path=/home/ubuntu/.ssh/

# EXECUTE THIS TO LOGIN TO CONTAINER
# lxc exec containername -- su --login ubuntu

# EXECUTE THESE FROM INSIDE CONTAINER
# sudo apt update
# sudo apt upgrade
# cp ~/data/home/.screenrc ~/
# cp ~/data/home/.bash_prompt ~/

# sudo add-apt-repository ppa:deadsnakes/ppa
# sudo apt install python3.10
# sudo apt install python3.10-venv
# python3.10 -m venv ~/py310

# Log out and into container (to execute new .bash_profile)

# pip install jupyterlab

export SCREENDIR=$HOME/.screen
source ~/py310/bin/activate
source ~/data/display.sh
source ~/.bash_prompt
```

This gets things right up to the point where I apt install x11-apps, Firefox or
things like it. It's clearly in prep for Jupyter, which is the really big win
that awaits. That plus nbdev and I just may spark a revolution. It's the best
way to install Jupyter on Windows. All roads lead to WSL2 (Docker in
particular), so I figure why not?

For the Jupyter install, so far I figured out that I can get it to work with
the Linux Firefox browser under either WSL or LXC under WSL. But only in the
WSL-only case can I get it to come up under localhost:8888 on the native
Windows side under Edge, and an Edge (fullscreen) app in particular where it
both looks and performs best. That's my goal, but with it being served from LXD
under WSL. There are snafus.

The place it appears to break down is serving it from LXD. There's some special
Microsoft WSL magic going on making localhost on WSL also localhost on Windows.
That's a gift. Take it! Stick with the defaults and lean into what Microsoft's
trying to make easy to occur. Nobody's trying to make hosting under LXD under
WSL easy. That's in my court. Stick close to the defaults and sprinkle as
little magic pixy dust in that's actually required to get the job done.

I have to understand the networking context of both better, but especially of
LXD default, which is to use that lxbr0 bridge. Think! What do you need to
know? I need big picture like the way I understand QEMU as a virtual LAN with
its own internal IPs and DHCP server. Which of these is doing that and with
what variations on the theme? Okay, let's list what we know. For the sake of
clarity, focus on IPv4. Take note of the IPv6's, but write things out based on
v4 observations, because it's easier to visually recognize subnets and such.

My machines all have a public IP, which is actually the IP of my ISP network
drop and router. It is also an Internet gateway making all machines on the
inside have that IP for public request purposes. The WiFi router itself does
the LAN trick, so all machines on WiFi as physical hardware gets assigned an
internal IP. Internal IPs can be seen by going into PowerShell and typing
ipconfig.

Okay, typing ipconfig from PowerShell shows me my main internal IP subnet which
is the same thing used on my NAS, phones and anything else connecting to the
Internet through the router. They're all dynamically assigned an IP on the main
outer network in my house. But there's also another IP that's shown here, and
it's also an internal number and labeled Ethernet adapter vEthernet (WSL).
However, it end in a .1 for its last octet which is very suspicious.
Windows-side stuff is going to act as the router (and Internet gateway) for
WSL-side stuff. So we're a bloodhound on the trail of clues.

I fire up WSL and type ifconfig from in there. Yes, it's ipconfig on Windows
and ifconfig on Linux. Go configure. Now ifconfig shows two interfaces as well,
the first being a private IP octet that shares only the first two octets with
the second private IP from Windows-side. Curious! The second interface listed
is just the traditional lo: loopback 128.0.0.0 there's no place like home. So
that doesn't tell us anything more about LXD yet.

Okay, I boot and log into the LXC container and see that ifconfig isn't there.
So I sudo apt install net-tools and check again. Ooh, a completely different
internal IP different even from the first octet. This thing is deeply isolated.
No Microsoft "make it easy" tricks here. I'm going to have to bridge, nat,
proxy or whatever on my own to get this thing accessible WSL-side, and thus
Windows-side. My gut tells me it's going to be lxc config commands that do
this. Stay away from editing routing tables. That stuff is moving targets,
nftables vs. iptables and all that. Yuck. I'm not a netadmin.

Okay, deep breath. Think! What are people searching on that I should be
searching on. What's the winning concept here? Hmmm. I believe it must be
general hosting from an LXD container. Normally that'd be a security risk I'd
avoid, preferring and leaning into the localhost loopback modes, but in this
case even if you expose it to the outer network, it's still isolated by being
part of the WSL inner network. There's no harm in it! Wow, okay. So it's
exposing LXD to the world for hosting purposes I'm interested in. And in doing
so, we may just be leaving localhost behind as a Jupyter address. We'll see.

Hmm, go look at the lxc command with lxc --help. Well, this is illuminating.
There's a lot of stuff in there, even aliases. Okay, think! Try lxc info...
wow! Yeah, I'll be able to do the Jupyter video tomorrow. There's a light touch
waiting here. It may be setting public to true. There's a few other leads like
proxy.

Ah ha! A key thing to do is:

    lxc config show quadling

Interesting! Okay, now research how to run Jupyter from an IP instead of
localhost.

    jupyter server --generate-config
    jupyter server password

And now it's accessible from Linux Firefox with the IP:

http://10.36.5.171:8888/

And now we have the basis for an lxc config proxy:

    lxc config device add quadling jupyme proxy listen=tcp:0.0.0.0:8888 connect=tcp:127.0.0.1:8888

Success!

It is just at the price of having to set a password on Jupyter.

Okay, document these steps in your video notes then copy the unified video
notes back here and use it as your starting point.

```bash
# EXECUTE THESE FROM WSL TO GET COMMON LOCATIONS
# lxc config device add containername data disk source=/home/healus/data/ path=/home/ubuntu/data/
# lxc config device add containername dotssh disk source=/home/healus/.ssh/ path=/home/ubuntu/.ssh/
# lxc config device add quadling port8888 proxy listen=tcp:localhost:8888 connect=tcp:localhost:8888

# EXECUTE THIS TO LOGIN TO CONTAINER
# lxc exec containername -- su --login ubuntu

# EXECUTE THESE FROM INSIDE CONTAINER
# sudo apt update
# sudo apt upgrade
# cp ~/data/home/.screenrc ~/
# cp ~/data/home/.bash_prompt ~/

# sudo add-apt-repository ppa:deadsnakes/ppa
# sudo apt install python3.10
# sudo apt install python3.10-venv
# python3.10 -m venv ~/py310

# Log out and into container (to execute new .bash_profile)

# pip install jupyterlab
# jupyter server --generate-config
# jupyter server password
# jupyter lab --ip 0.0.0.0 --port 8888 --no-browser


export SCREENDIR=$HOME/.screen
source ~/py310/bin/activate
source ~/data/display.sh
source ~/.bash_prompt
```


## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/lxd/'>LXD</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li></ul>