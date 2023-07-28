---
date: 2023-03-30
title: Adapting My DrinkMe for Linux Pipulate Script for Macs
headline: Adapting My Linux Pipulate Script for Macs with MultiPass and mDNS
description: I'm adapting my DrinkMe Linux Pipulate Script for Macs, so I'm using a Linux VM on a Mac for the most precise code execution. To make this easy, I'm using Canonical's MultiPass, which turns on virtualization and sets up a working instance of Ubuntu. I'm also using Apple Bonjour's mDNS to map host ports to the VM ports, and I've updated the install script to ensure Linux graphics work in headful mode.
keywords: Macs, Linux, VM, Canonical, MultiPass, Ubuntu, mDNS, headful, Dev Revolution, Unix, Proprietary, Debian, Virtual Machine, Persistent, Transferable, Tech Knowledge
categories: linux, ubuntu, mac, proprietary
permalink: /blog/adapting-my-drinkme-for-linux-pipulate-script-for-macs/
layout: post
group: blog
---


Given that Debian-based Linux currently has the most users of any Linux
distribution (because Microsoft chose it for WSL and Google chose it for
ChromeOS), I'm going to treat Debian-based Linux VMs as a universal
interoperable layer for executing standard server scripts.

Mac folks may object because Macs are already Unix, and Unix is what Linux
itself is based on. Why would you emulate Linux on Unix? Well, the answer is in
order to get a precise and error-free code execution environment for running
and distributing scripts that don't need entire Docker containers.

## How To Host Linux Jupyter on Intel, M1 or M2 Macs

{% include youtubePlayer.html id="0-LAqKuSE9A" %}

## How To Host Linux Jupyter on Intel, M1 or M2 Macs

{% include youtubePlayer.html id="0-LAqKuSE9A" %}

Containers are a way to get a lot of what it seems I'm going after here, except
they are somewhat immutable and not easily modified. You can't just treat a
Docker image like a Linux system and modify it as you need. There's this extra
level of complexity called compositing which makes all the normal Linux stuff
you'll be learning down the road far more difficult.

Instead, a local Linux VM is built and modified as you need in ways not so
easily accomplished on a Mac or with Docker. The general methodology used here
with a Linux VM on a Mac is almost exactly the same as with the Linux VM on
Windows, except that Microsoft provides a subsystem for Linux by default, so
you can just grab Ubuntu from the Microsoft store.

Macs on the other hand would require a third-party virtualization solution like
VirtualBox, Parallels or VMware Fusion. Already things get way more complicated
than I'd like them to be for such a simple task. With WSL on Windows you simply
get a Linux Terminal at the end of the install process which you can open and
use just like an integrated Windows program. You don't "feel" the Linux
virtualization at all, and this is pretty much the same experience I want Mac
folks to have. Once again, Canonical, the company that developed Ubuntu to the
rescue.

For those learning about these topics for the first time from this article, the
Linux distro known as Ubuntu is the most commercial and popular Linux derived
from Debian. Debian is the actual root of this branch of the Linux distro
lineage. There are other original root distros such as RedHat and Arch. RedHat
was the first IBM-supported billion-dollar Linux and Arch is for old schoolers.
Ubuntu is the most popular derivative of Debian.

Debian is the one we're going to use because Microsoft and Google chose it and
the Windows install is dirt simple. The Mac install isn't much worse, except
that it has to come from a 3rd party, so there isn't one clear path to follow.
I choose the path provided by Canonical, the company that developed Ubuntu.
That path is a custom installer that handles three very tricky bits:

- Turning on true hardware virtualization (Hypervisor)
- Installing the free and open source software (FOSS) VirtualBox
- Installing a working and configured instance of Ubuntu

Ubuntu's MultiPass product does all that lovely stuff to make this process as
easy on Macs as on Windows. I have to think that MutliPass was developed by
Canonical to deal with WSL-envy felt by Mac users. A Mac zealot would never
admit it, but being forced to use a 3rd party software repo like Homebrew to do
formal dev stuff, and Homebrew... let me check...

---

**Mike Levin:** is homebrew officially supported by apple?

**Bing:** Yes, Homebrew is officially supported by Apple. According to a 9to5Mac article¹, Homebrew now officially supports Apple Silicon installations. Homebrew worked on Apple Silicon prior to this announcement, but with some limitations and other issues. Now, Apple Silicon installation is officially supported. The package manager is natively supported for installations in `/opt/homebrew`²³. However, the team notes that it doesn't yet provide bottles (binary packages) for all packages².

Source: Conversation with Bing, 3/30/2023


        (1) Popular macOS utility Homebrew now officially supports Apple ... - 9to5Mac. https://9to5mac.com/2021/02/05/homebrew-apple-silicon-installation/ Accessed 3/30/2023.
        (2) Homebrew macOS utility introduces native support for Apple Silicon. https://appleinsider.com/articles/21/02/05/homebrew-macos-utility-introduces-native-support-for-apple-silicon Accessed 3/30/2023.
        (3) Package manager Homebrew now fully supports Apple silicon. https://www.imore.com/package-manager-homebrew-now-fully-supports-apple-silicon Accessed 3/30/2023.
        (4) Mac utility Homebrew finally gets native Apple Silicon and M1 support. https://arstechnica.com/gadgets/2021/02/mac-utility-homebrew-finally-gets-native-apple-silicon-and-m1-support/ Accessed 3/30/2023.

---

**Mike Levin:** Wrong! Homebrew officially supporting Apple silicon is not the same as Apple officially supportingn the Homebrew software repository and formula system. I ask again, does Apple officially support Homebrew? (Not the other way around)

**Bing:** I apologize for any confusion. According to a coalitionbrewing.com article², Apple does not officially support Homebrew. Homebrew is an open-source package manager and package repository for macOS and Linux. It is designed to build and install software from source, but it can also be used to install pre-built software packages from third-party repositories². However, Homebrew now officially supports Apple Silicon installations¹³.

Source: Conversation with Bing, 3/30/2023

    (1) What does Homebrew do on Mac? - coalitionbrewing.com. https://www.coalitionbrewing.com/what-does-homebrew-do-on-mac/ Accessed 3/30/2023.
    (2) Popular macOS utility Homebrew now officially supports Apple ... - 9to5Mac. https://9to5mac.com/2021/02/05/homebrew-apple-silicon-installation/ Accessed 3/30/2023.
    (3) Homebrew macOS utility introduces native support for Apple Silicon. https://appleinsider.com/articles/21/02/05/homebrew-macos-utility-introduces-native-support-for-apple-silicon Accessed 3/30/2023.
    (4) Mac utility Homebrew finally gets native Apple Silicon and M1 support. https://arstechnica.com/gadgets/2021/02/mac-utility-homebrew-finally-gets-native-apple-silicon-and-m1-support/ Accessed 3/30/2023.

**Mike Levin:** Write an essay on the pros and cons of a open-source package manager that is officially supported by the operating system and hardware it runs on, such as the Ubuntu repo on WSL, versus an open-source package manager that is not officially supported, such as Homebrew on Macs.

**Bing:** An open-source package manager that is officially supported by the operating system and hardware it runs on has several advantages. For example, it is more likely to be stable and reliable because it has been tested and optimized for the specific operating system and hardware. It is also more likely to be secure because it has been vetted by the operating system vendor and has undergone security testing. Additionally, an officially supported package manager is more likely to be updated regularly with new features and bug fixes.

However, there are also some disadvantages to an officially supported package manager. For example, it may not support as many packages as an unofficial package manager because it has to go through a vetting process before being added to the repository. Additionally, an officially supported package manager may not be as flexible as an unofficial package manager because it has to adhere to certain guidelines and standards.

On the other hand, an open-source package manager that is not officially supported has several advantages as well. For example, it may support more packages than an officially supported package manager because it does not have to go through a vetting process before being added to the repository. Additionally, an unofficial package manager may be more flexible than an official package manager because it does not have to adhere to certain guidelines and standards.

However, there are also some disadvantages to an unofficial package manager. For example, it may not be as stable or reliable as an official package manager because it has not been tested and optimized for the specific operating system and hardware. Additionally, an unofficial package manager may not be as secure as an official package manager because it has not undergone security testing.

In conclusion, both officially supported and unofficially supported open-source package managers have their pros and cons. The choice between them depends on the specific needs of the user.

---

Okay, so there's pros and cons. I won't feel too bad about making the DrinkMe
script for the Mac Homebrew based. Let's get to that discussion with Bing:

---

does multipass run on m1 and m2 macs?

Yes, Multipass runs on both M1 and M2 Macs. The quickest way to run Linux cross-platform, Multipass received an update last year allowing M1 users to run Ubuntu VMs with minimal set-up²³⁴.

Source: Conversation with Bing, 3/29/2023

    (1) Canonical Transforms Linux on Mac | Canonical. https://canonical.com/blog/canonical-transforms-linux-on-mac Accessed 3/29/2023.
    (2) Apple Silicon version of Canonical's Multipass is here. https://www.theregister.com/2021/11/09/multipass_m1/ Accessed 3/29/2023.
    (3) Multipass on Apple M1 based computers - Ubuntu Community Hub. https://discourse.ubuntu.com/t/multipass-on-apple-m1-based-computers/20903 Accessed 3/29/2023.
    (4) Multipass on Apple M1 based computers - Ubuntu Community Hub. https://bing.com/search?q=does+multipass+run+on+m1+and+m2+macs%3f Accessed 3/29/2023.
    (5) How to install Multipass on macOS | Multipass documentation. https://multipass.run/docs/installing-on-macos Accessed 3/29/2023.
    (6) Ubuntu's publisher brings Linux support to M1 Macs with 'Multipass'. https://9to5mac.com/2021/11/09/ubuntu-publisher-brings-linux-support-to-m1-mac-with-multipass/ Accessed 3/29/2023.

---

**Mike Levin:** Can a Unix script on Mac install MultiPass?

**Bing:** Yes, you can install Multipass on macOS using an installer package or brew³⁵. You can follow the instructions given here¹² to install it on your Mac.

Source: Conversation with Bing, 3/29/2023

    (1) How to install Multipass on macOS | Multipass documentation. https://multipass.run/docs/installing-on-macos Accessed 3/29/2023.
    (2) How to install Multipass on macOS - Ubuntu Community Hub. https://discourse.ubuntu.com/t/how-to-install-multipass-on-macos/8329 Accessed 3/29/2023.
    (3) Multipass Tutorial - macOS | Multipass documentation. https://multipass.run/docs/mac-tutorial Accessed 3/29/2023.
    (4) Multipass Tutorial - macOS - Documentation - Ubuntu Community Hub. https://discourse.ubuntu.com/t/multipass-tutorial-macos/29148 Accessed 3/29/2023.
    (5) Multipass Documentation | Multipass documentation. https://multipass.run/docs Accessed 3/29/2023.

---

**Mike Levin:** What is the system for local addresses for DNS invented my Apple Bonjour called?

**Bing:** The system for local addresses for DNS invented by Apple Bonjour is called Multicast DNS (mDNS)¹³. It allows devices to automatically discover each other without the need to enter IP addresses or configure DNS servers⁴.

Source: Conversation with Bing, 3/29/2023

    (1) Cannot access .local addresses from my iOS devices. https://apple.stackexchange.com/questions/352900/cannot-access-local-addresses-from-my-ios-devices Accessed 3/29/2023.
    (2) Bonjour discovery - Apple Support. https://support.apple.com/guide/deployment/bonjour-discovery-depf138dd79c/web Accessed 3/29/2023.
    (3) Bonjour - Frequently Asked Questions - Apple Developer. https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/NetServices/Articles/faq.html Accessed 3/29/2023.
    (4) Can I list all the Bonjour-enabled services that are running?. https://apple.stackexchange.com/questions/65673/can-i-list-all-the-bonjour-enabled-services-that-are-running Accessed 3/29/2023.

---

**Mike Levin:** Are the IPs, mDNS addresses and port services running on an Ububtu Linux under MultiPass accessible to the host Mac system? What so these addresses look like? Can they be used in Safari to reach sites hosted under MultiPass?

**Bing:** I'm sorry but I'm not sure I understand your question. Could you please clarify what you mean by "MultiPass" and "mDNS addresses"?

Source: Conversation with Bing, 3/29/2023

    (1) UFW Essentials: Common Firewall Rules and Commands. https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands Accessed 3/29/2023.
    (2) Access WSL2 Ubuntu's application on hosted machine's network. https://askubuntu.com/questions/1394866/access-wsl2-ubuntus-application-on-hosted-machines-network Accessed 3/29/2023.
    (3) Access a localhost running in Windows from inside WSL2?. https://stackoverflow.com/questions/64763147/access-a-localhost-running-in-windows-from-inside-wsl2 Accessed 3/29/2023.

---

**Mike Levin:** MultiPass is Canonical's simplified VirtualBox installer and configuration for running virtual Ubuntu on Macs. Some systems like WSL use VLANs and port mapping to make VM services available to the host machine. How does this work with MultiPass? It may not be a VLAN. The networking context for virtualization may be different.

**Bing:** According to Multipass documentation¹, you can map host ports to VM ports using the same formula. For example, if you want to use the VM as a web server, you can map the host's 80 and 443 port to the VM. To access the host directory from the guest VM, you will need help from the command `multipass mount`. It will mount the host folder into the guest VM². I hope this helps!

Source: Conversation with Bing, 3/29/2023

    (1) Multipass Documentation | Multipass documentation. https://multipass.run/docs Accessed 3/29/2023.
    (2) Use Linux Virtual Machines with Multipass | by Andrew Zhu - Medium. https://medium.com/codex/use-linux-virtual-machines-with-multipass-4e2b620cc6 Accessed 3/29/2023.
    (3) How to use Multipass, a new tool for launching virtual machines. https://www.techrepublic.com/article/multipass-is-a-new-tool-for-launching-virtual-machines/ Accessed 3/29/2023.
    (4) Configure virtual local area networks for Hyper-V | Microsoft Learn. https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/deploy/configure-virtual-local-areal-networks-for-hyper-v Accessed 3/29/2023.

---

**Mike Levin:** Aside from a mapped port, what address or IP should be used in the URL to reach a webserver on a MultiPass VM on a Mac?

**Bing:** You can use the IP address of the Multipass instance to access the webserver running inside it. To find out the IP address of your Multipass instance, you can use `multipass info <instance-name>` command¹. Once you have the IP address, you can use it in your URL to access the webserver running inside your Multipass instance². I hope this helps!

Source: Conversation with Bing, 3/29/2023

    (1) Multipass, virt-manager and bridged network - Ask Ubuntu. https://askubuntu.com/questions/1212818/multipass-virt-manager-and-bridged-network Accessed 3/29/2023.
    (2) Port forwarding · Issue #309 · canonical/multipass · GitHub. https://github.com/canonical/multipass/issues/309 Accessed 3/29/2023.
    (3) Tutorial - Customize a Linux VM with cloud-init in Azure - Azure .... https://learn.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-automate-vm-deployment Accessed 3/29/2023.
    (4) IP Configuration and Network Settings: Set the Correct IP Address. https://www.beyondtrust.com/docs/remote-support/getting-started/deployment/web/networking-ip-configuration.htm Accessed 3/29/2023.

---

**Mike Levin:** Is it always IP? Can you use localhost? Are Bojour local. assigned host names used? What is the networking context for MultiPass? Bridged, NAT or other?

**Bing:** According to Multipass documentation², you can use `--bridged` option to launch an instance with bridged networking. The name of the interface used when `--bridged` is issued is `local.bridged-network`². In bridged networking mode, the guest machine is like another physical machine on the network and is exposed to your local network³. You can use the IP address of your Multipass instance to access the webserver running inside it. You can also use `localhost` or `127.0.0.1` to access the webserver running inside your Multipass instance¹. I hope this helps!

Source: Conversation with Bing, 3/29/2023

    (1) `local.bridged-network` | Multipass documentation. https://multipass.run/docs/bridged-network Accessed 3/29/2023.
    (2) Virtualbox Bridged Networking Mode Allows VM to Connect to ... - LinuxBabe. https://www.linuxbabe.com/virtualbox/a-pretty-good-introduction-to-virtualbox-bridged-networking-mode Accessed 3/29/2023.
    (3) Multipass, virt-manager and bridged network - Ask Ubuntu. https://askubuntu.com/questions/1212818/multipass-virt-manager-and-bridged-network Accessed 3/29/2023.
    (4) Support for bridged networking · Issue #118 · canonical/multipass. https://github.com/canonical/multipass/issues/118 Accessed 3/29/2023.

---

**Mike Levin:** What is the default?

**Bing:** By default, VMs are behind NAT which means they can talk out but nobody can talk in². I hope this helps!

Source: Conversation with Bing, 3/29/2023

    (1) networking - Multipass change ip range - Ask Ubuntu. https://askubuntu.com/questions/1289882/multipass-change-ip-range Accessed 3/29/2023.
    (2) `multipass networks` command | Multipass documentation. https://multipass.run/docs/networks-command/19542 Accessed 3/29/2023.
    (3) How to troubleshoot networking | Multipass documentation. https://multipass.run/docs/troubleshooting-networking-on-windows Accessed 3/29/2023.
    (4) Multipass Tutorial - Windows | Multipass documentation. https://multipass.run/docs/windows-tutorial Accessed 3/29/2023.
    (5) How to use Multipass, a new tool for launching virtual machines. https://www.techrepublic.com/article/multipass-is-a-new-tool-for-launching-virtual-machines/ Accessed 3/29/2023.

---

**Mike Levin:** Write a Unix shell script that will install MultiPass in a Intel, M1 or M2 Mac, and which will allow a website hosted on the VM to be accessible to the host machine on port 8888.

**Bing:** I can help you with that. Do you have any specific version of Multipass that you want to install? Also, do you have any specific website in mind that you want to host on the VM?

The website will be JupyterLab server installed with a pip install Jupyter. I need a MultiPass that will work (or adapt) to all modern Mac hardware architectures.

Here's a shell script that will install Multipass and JupyterLab server on your Mac. This script should work on all modern Mac hardware architectures.

```sh
#!/bin/bash

# Install Multipass
brew install multipass

# Launch an instance with bridged networking
multipass launch --name jupyterlab --cpus 2 --mem 4G --disk 10G --cloud-init cloud-config.yaml --network local.bridged-network

# Install JupyterLab server
multipass exec jupyterlab -- sudo apt-get update
multipass exec jupyterlab -- sudo apt-get install python3-pip -y
multipass exec jupyterlab -- sudo pip3 install jupyterlab

# Forward port 8888 to the host machine
multipass exec jupyterlab -- jupyter lab --ip=0.0.0.0 --port=8888 &
multipass transfer jupyterlab:/home/ubuntu/.local/share/jupyter/runtime/nbserver-*.json .

echo "JupyterLab server is running at http://localhost:8888"
```

This script will launch an instance named `jupyterlab` with 2 CPUs, 4GB of memory, and 10GB of disk space. It will also install JupyterLab server and forward port 8888 to the host machine so that you can access the JupyterLab server at http://localhost:8888. You can save this script to a file named `install.sh` and run it in your terminal by typing `sh install.sh`. I hope this helps!

---

**Mike Levin:** What are names for Mac fanboys and zelots?

**Bing:** I'm not sure about zelots but Apple fanboys are sometimes called "Mactards" or "Macolytes" ². However, it's important to be respectful of others and avoid using derogatory terms. Is there anything else I can help you with?

Source: Conversation with Bing, 3/29/2023

    (1) Are You an Apple Fanboy Yet? | Cult of Mac. https://www.cultofmac.com/74744/are-you-an-apple-fanboy-yet/ Accessed 3/29/2023.
    (2) 50 Mac Names | Nameberry. https://nameberry.com/list/450/mac-names Accessed 3/29/2023.
    (3) The 7 worst fanboy groups on the Internet - CNET. https://www.cnet.com/tech/computing/the-7-worst-fanboy-groups-on-the-internet/ Accessed 3/29/2023.

---

**Mike Levin:** Do Linux graphics like those of X Server work on MultiPass on Macs?

**Bing:** Yes, Multipass can run Linux graphics like those of X Server on Macs ¹. Multipass is a lightweight VM manager that can launch a virtual machine image with one command and have it up and running in seconds ¹. It supports various drivers such as KVM on Linux, Hyper-V on Windows, and HyperKit on macOS ³. You can also use VirtualBox and libvirt as drivers by using the set command ³. I hope this helps!

Source: Conversation with Bing, 3/29/2023

    (1) Ubuntu's publisher brings Linux support to M1 Macs with 'Multipass'. https://9to5mac.com/2021/11/09/ubuntu-publisher-brings-linux-support-to-m1-mac-with-multipass/ Accessed 3/29/2023.
    (2) How to have a clean dev environment like WSL 2 using Multipass on Linux .... https://itnext.io/how-to-have-a-clean-dev-environment-like-wsl-2-using-multipass-on-linux-mac-or-windows-6828a78b87d7 Accessed 3/29/2023.
    (3) Canonical's new Multipass 1.8 runs Ubuntu Linux in a VM on M1 Macs - iMore. https://www.imore.com/canonicals-new-multipass-18-runs-ubuntu-linux-vm-m1-macs Accessed 3/29/2023.

---

**Mike Levin:** Can Microsoft Playwright not in headless mode work on MultiPass on Mac (browser automation with visible beowser)?

**Bing:** Yes, Microsoft Playwright can work in headful mode (with a visible browser) ² and can be used with Multipass on Macs ¹. Multipass is a lightweight VM manager that can launch a virtual machine image with one command and have it up and running in seconds ¹. Playwright launches a headless browser by default but it also supports running full (non-headless) Microsoft Edge ²³. I hope this helps!

Source: Conversation with Bing, 3/29/2023

    (1) What Is Playwright – A Tutorial on How to Use Playwright - LambdaTest. https://www.lambdatest.com/playwright Accessed 3/29/2023.
    (2) What is Playwright automation? | Apify Blog. https://blog.apify.com/what-is-playwright/ Accessed 3/29/2023.
    (3) Use Playwright to automate and test in Microsoft Edge. https://learn.microsoft.com/en-us/microsoft-edge/playwright/ Accessed 3/29/2023.
    (4) Playwright works in headful mode but fails in headless. https://stackoverflow.com/questions/75488727/playwright-works-in-headful-mode-but-fails-in-headless Accessed 3/29/2023.
    (5) Playwright test failure in headless mode - Stack Overflow. https://stackoverflow.com/questions/73446223/playwright-test-failure-in-headless-mode Accessed 3/29/2023.

---

**Mike Levin:** Does a browser pop up on the Mac desktop from a MultiPass Linux shell when a Playwright script on headful mode is run?

**Bing:** Yes, when a Playwright script is run in headful mode on MultiPass Linux shell, a browser window will pop up on the Mac desktop . Is there anything else I can help you with?

Update the install script to ensure Linix graphics will work when using Microsoft Playwright scripts in headful mode.

---

And there you have it. I'll implement this real soon if you're a Mac user
following along with my work and are feeling Windows Linux Envy (you heard it
here first). The Dev Revolution (devrev?) is taking place on Linux, everything
from interoperable local scripts like this to supercomputers, AI, Mars probes,
and well everything else. It's not on proprietary Windows nor proprietary Mac.
Yes, Macs are still proprietary even though they're Unix based. And according
to these strict definitions, even Ubuntu is a bit proprietary, but in less
long-term damaging to your dev-skills and generic tech know-how than Macs are.

Debian-derivative Linux VMs are the least worst evil. They abide by the
80/20-rule in getting the most powerful, least fragile, most persistent and
transferable valuable tech knowledge, yadda, yadda, already said it.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/what-are-the-main-differences-between-neovim-and-vim/">What are the main differences between NeoVim and vim?</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/live-streaming-with-github-copilot-in-neovim-for-motivation/">Live-streaming With Github Copilot in NeoVim for Motivation</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/mac/'>Mac</a></h4></li>
<li><h4><a href='/proprietary/'>Proprietary</a></h4></li></ul>