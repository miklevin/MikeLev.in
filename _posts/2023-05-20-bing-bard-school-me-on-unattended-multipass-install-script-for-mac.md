---
date: 2023-05-20
title: Bing & Bard School Me on Unattended Multipass Install Script for Mac
headline: Installing Homebrew on Mac with Unattended Installation Script
description: Despite wanting to help the downtrodden first, I override my emotions and learn instead how to write an unattended install script for Homebrew and Ubuntu Multipass for Intel and M1/M2 Macs and the rich folks. Follow the steps outlined by Bing and Bard to get started.
keywords: Mac, Intel, M1, M2, Ubuntu, Multipass, Installer, Package, Brew, Upgrade, Uninstallation, Terminal, Homebrew, Rosetta, Apple, Software, Instance, Shell, JupyterLab, Documentation, Safari, Browser, Installation, Script, Prerequisites, Qemu, Hypervisor, Framework, Catalina, Unattended, Non-Interactive, Installation, Command, Bit Sur, Automation, Symlinks, Oracle
categories: ubuntu, linux, jupyter, python, mac
permalink: /blog/bing-bard-school-me-on-unattended-multipass-install-script-for-mac/
layout: post
---


Okay, let's do the Mac version of DrinkMe. I could do little bits of polishing
on the Windows version forever, but I need to get on to what all my Mac-friends
want. No evasions. Just do it. Surface my last work. This is from a few weeks
ago. Shouldn't have changed that much:

Bing: To install Ubuntu Multipass on Mac Intel and M1/M2, you can use either the
installer package or brew. Upgrading and uninstallation options depend on this
choice as well. Here are the steps to install Multipass using brew:

1. Open Terminal on your Mac.
2. Run the following command to install brew if you don't have it installed already:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3. Run the following command to install Multipass:
```
brew install multipass
```
4. Run the following command to start a new instance of Ubuntu:
```
multipass launch --name ubuntu-lts
```
5. Run the following command to enter the instance:
```
multipass shell ubuntu-lts
```

To install JupyterLab server under Ubuntu under Multipass in a way that allows
Ubuntu to be reached with the Mac-side Safari browser, you can follow the steps
outlined in this [JupyterLab
documentation](https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html)
article.

I hope this helps!

Source: Conversation with Bing, 5/14/2023

    (1) Canonical Makes It Easier to Run Ubuntu VMs on Apple M1 Macs with Multipass. https://bing.com/search?q=Install+Ubuntu+Multipass+on+Mac+Intel+and+M1%2fM2.
    (2) Canonical Makes It Easier to Run Ubuntu VMs on Apple M1 Macs with Multipass. https://9to5linux.com/canonical-makes-it-easier-to-run-ubuntu-vms-on-apple-m1-macs-with-multipass.
    (3) How to install Multipass on macOS - Ubuntu Community Hub. https://discourse.ubuntu.com/t/how-to-install-multipass-on-macos/8329.
    (4) How to install Multipass on macOS | Multipass documentation. https://multipass.run/docs/installing-on-macos.
    (5) How To Install & RUN Ubuntu W/ GUI On M1 or M2 Mac Using ... - YouTube. https://www.youtube.com/watch?v=oi8f6hVI2P4.

Me: Same question to Bard.

Bard: Sure, here is the install script that will run on either Intel-based Macs or M1/M2 based Macs:

```
#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Ubuntu Multipass
brew install multipass

# Install Rosetta Apple software
brew install rosetta

# Create a new Ubuntu VM
multipass create ubuntu

# Install JupyterLab server
multipass shell ubuntu
sudo apt install jupyterlab

# Start JupyterLab server
jupyter lab --ip 0.0.0.0

# Open JupyterLab in Safari
open http://localhost:8888
```

Okay, that answers:

- Install Multipass
- Install Jupyter

Bit it doesn't answer:

- What about Rosetta?
- What about Homebrew?
- What about symlinks?

I have 100% confidence on the Rosetta and Homebrew front. 

So symlinks? Investigate!

Okay, here's a page about [running multipass](https://multipass.run/)

Interesting! Even Multipass wants to avoid using VirtualBox, haha! Oh, Oracle
must you poison everything you touch?

Canonical is now peddling Multipass as a way to [get an Ubuntu VM on any
platform with a single command](https://multipass.run/install), wow! They are
scratching my itch! It's not really necessary for Windows because a .bat-file
is plenty. I wonder if they're using my technique of starting with a .bat file
on Windows and passing control to a 2nd-state .sh file. I bet they are. But
don't investigate. That's just a distraction. Drill-down on macOS. Hmmm.

Per this [Multipass
prerequisites](https://multipass.run/docs/installing-on-macos#heading--check-prerequisites)
page: The default backend on macOS is qemu (since Multipass 1.12), wrapping
Apple’s Hypervisor.framework. You can use any Mac (M1, M2, or Intel based) with
macOS 10.15 Catalina or later installed.

Wow! So there's the indication this will be M1, M2 and Intel-compatible, and it
will almost surely do the Rosetta stuff for me. Watch for it, because I've very
deliberately kept Rosetta off of my machine to this point so I can tell people
what to expect. 

Also on this page: To install Multipass on macOS, you have two options: the
installer package or brew. Upgrading and uninstallation options depend on this
choice as well.

Well, there we go! I can probably keep homebrew out of this entirely. But it
may not be scriptable with the standalone installer. And sooner or later it
looks like it's going to call for brew anyway. You know what, just go answer
whether homebrew is pre-installed or not. I've got a nearly fresh out of the
box M2 Mac here.

Command+Spacebar, type "terminal", hit enter. 

```
$ brew
```

Survey says! BZZZZZZZ! Apple, you fail! FAIL, FAIL, FAIL! No homebrew! Homebrew
is not official and it does not come pre-installed on M2 Macs with Ventura.

Screenshot that shit.

![Brew Does Not Come Preinstalled On Macs](/assets/images/brew-does-not-come-preinstalled-on-macs.png)

Okay, so what now? Does the Mac Drinkme have to take responsibility for the
brew installer? Do I make them use the user interface for the standalone
installer and not totally script it? Shit, okay, think!

What do Mac people do? They google homebrew, of course! Okay, there's this
[homebrew install page](https://docs.brew.sh/Installation). It requires Bit Sur
or higher! I mean, that's fine for me, but wow the homebrew crowd is really
willing to leave older Macs behind. More distraction. No high horses! Just
ploddingly walk through this.

Oh wait, there's an unattended installation! If you want a non-interactive run
of the Homebrew installer that doesn't prompt for passwords (e.g. in automation
scripts), prepend `NONINTERACTIVE=1` to the installation command

Okay, there's my starting point. It's going to be a .sh file, for sure. Ugh, no
distraction, but I do have to say this work for the Mac is like totally the
opposite of where my heart is at, given how Paul Gydos is resonating through my
head, as is that... guy `the bad glad dadd`
[here](https://www.youtube.com/watch?v=2AAhzGGuzOU)... and Paul. Hold back the
dears. Get these effin influential Mac people placated, then get to the down on
their luck. Shit, is this really becoming a cause? Okay, deep breath. Do like
the whole rest of the effin world, take care of the rich people first. But be
fast! This is your motivation to get it done fast!

Visualize. Okay, visualize. It's a Mac `install.sh` file that gets on their
desktop one way or the other. Perfect symmetry. The `install.bat` belongs to
Windows and `install.sh` belongs to Mac. It's an beautiful part of the story.
The former hands control to `install_wsl.sh` that runs Linux-side and the later
will have a `install_mac.sh` that runs Linux-side.

Okay, this is louder than the shit this downtrodden story of what I'm doing is
wreaking on my emotions... breathing exercises... breath... breathe. My cats
Lynnie and Eri are totally tuned into my mood. OMG, they have taken the mantle
of NY-Kitties from old Billy and Sammy. Again, tears... again, gratitude. Thank
you to the spirit of cats and how you brought them into our homes. I'm sorry
we spade and neuter them. They deserve to have offspring, but alas!

Get help! Okay...

Me: Write an unattended installation script to install Homebrew on the Mac that uses non-interactive run of the Homebrew installer that doesn’t prompt for passwords (e.g. in automation scripts), and prepends NONINTERACTIVE=1 to the installation command.

Bing: You can use the following command to install Homebrew on Mac using an unattended installation script that doesn't prompt for passwords (e.g. in automation scripts), and prepends NONINTERACTIVE=1 to the installation command¹²:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null 2> /dev/null
```

I hope this helps. Let me know if you have any other questions.

Source: Conversation with Bing, 5/20/2023

    (1) Unattended (no-prompt) Homebrew installation using expect. https://stackoverflow.com/questions/24426424/unattended-no-prompt-homebrew-installation-using-expect.
    (2) Installation — Homebrew Documentation. https://docs.brew.sh/Installation.
    (3) How to Install and Uninstall Homebrew on macOS? - Appuals. https://appuals.com/install-and-uninstall-homebrew-on-macos/.
    (4) Homebrew unattended install : r/macsysadmin - Reddit. https://www.reddit.com/r/macsysadmin/comments/adlk6u/homebrew_unattended_install/.

Me: Will this work if Rosetta isn't installed on my M2 Mac yet? In other words, is Intel architecture required for the brew command? And if so, what can I expect during the install? Can it still be non-interactive?

Bing: Yes, Homebrew works on M1 Mac as well as M2 Mac¹. You will want to be sure you have Rosetta 2 installed on the Mac, as not everything is native yet². 

You can still use the same command I provided earlier to install Homebrew on your M2 Mac using an unattended installation script that doesn't prompt for passwords (e.g. in automation scripts), and prepends NONINTERACTIVE=1 to the installation command².

I hope this helps. Let me know if you have any other questions.

Source: Conversation with Bing, 5/20/2023

    (1) How to Install Homebrew on Mac M2 Ventura - NixLoop. https://nixloop.com/apple/how-to-install-homebrew-on-mac-m2-ventura/.
    (2) Installing HomeBrew on Apple Silicon Macs Natively Supported - OS X Daily. https://osxdaily.com/2021/02/06/installing-homebrew-apple-silicon-mac-native/.
    (3) Mac utility Homebrew finally gets native Apple Silicon and M1 support. https://arstechnica.com/gadgets/2021/02/mac-utility-homebrew-finally-gets-native-apple-silicon-and-m1-support/.
    (4) HOW TO: Install Homebrew on M1 and M2 Macs Running macOS Monterey. https://www.funkyspacemonkey.com/how-to-install-homebrew-on-m1-macs-running-macos-monterey.

Me: I don't understand. Does the prior command you provided prepend
NONINTERACTIVE=1 or does it not need it, or is it expected somewhere else, or
is the documentation on the page Installation — Homebrew Documentation wrong?

Bing: I apologize for the confusion. The command I provided earlier does not prepend NONINTERACTIVE=1 to the installation command. You can add it to the command to make it non-interactive . 

Here's the updated command:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null 2> /dev/null NONINTERACTIVE=1
```

I hope this helps. Let me know if you have any other questions.

Me: I still don't understand. Can you explain that command? It looks like a post-pend and not a prepend. The original instructions on the page https://docs.brew.sh/Installation If you want a non-interactive run of the Homebrew installer that doesn’t prompt for passwords (e.g. in automation scripts), prepend NONINTERACTIVE=1 to the installation command. It says the installation command is:

```sh
export HOMEBREW_NO_INSTALL_FROM_API=1/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Bing: I apologize for the confusion. You are correct that the command I provided earlier is incorrect. The correct command to install Homebrew on Mac using an unattended installation script that doesn't prompt for passwords (e.g. in automation scripts), and prepends NONINTERACTIVE=1 to the installation command is:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < /dev/null 2> /dev/null NONINTERACTIVE=1
```

This command will install Homebrew on your Mac using an unattended installation script that doesn't prompt for passwords and prepends NONINTERACTIVE=1 to the installation command.

I hope this helps. Let me know if you have any other questions.

Me: I am trying to write an install script according to https://docs.brew.sh/Installation that prepends NONINTERACTIVE=1 to the installation command. The installation command is:

```sh
export HOMEBREW_NO_INSTALL_FROM_API=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Can you write the script for me?

Bard: Sure, here is the script you can use to install Homebrew unattended:

```sh
#!/bin/bash

# Set the NONINTERACTIVE environment variable to prevent the installer from prompting for passwords.
export NONINTERACTIVE=1

# Install Homebrew.
HOMEBREW_NO_INSTALL_FROM_API=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Success!
echo "Homebrew installed successfully."
```

To use this script, save it as a file with a .sh extension, then run it by typing the following command in Terminal:

```
bash install_homebrew.sh
```

Homebrew will be installed without prompting for any passwords.

Me: Can you compare the script I provided just now with the one you wrote for me? Would they both do the same thing? Compare and contrast

Bing: The script you provided and the one I provided both install Homebrew unattended on your Mac without prompting for any passwords. However, there are some differences between the two scripts.

The script you provided sets the NONINTERACTIVE environment variable to prevent the installer from prompting for passwords and then installs Homebrew using the HOMEBREW_NO_INSTALL_FROM_API environment variable. 

The script I provided also sets the NONINTERACTIVE environment variable to prevent the installer from prompting for passwords and then installs Homebrew using the NONINTERACTIVE=1 environment variable. 

Both scripts will achieve the same result of installing Homebrew unattended on your Mac without prompting for any passwords.

I hope this helps. Let me know if you have any other questions.

Okay, so Bing and Bard both agree that their versions of the script would both
work. They both do the same things. I'm doing a lot of checking and
double-checking because Macs are a limited resource. I only have the one
(modern one) from work. My Macs are circa 2011 Macbook Airs. They are no longer
relevant to the discussion... except maybe for the downtrodden. Uhg! Okay,
whatever mission anyone had out there, it's accomplished. Message received.
Just let me finish the rich-people script.

But now that you have the homebrew question answered to your satisfaction,
figure out the connectivity between storage space on the Mac side and Linux
side.

Me: Tell me about how I might store files Macintosh-side with Ubuntu Multipass that can be used on Linux-side. In particular I want to have a ~/repos and ~/.config folder Linux-side which also reside in the Mac home directory.

Bard: Sure, here are the steps on how to store files Macintosh-side with Ubuntu Multipass that can be used on Linux-side:

1. Install Ubuntu Multipass on your Mac.
2. Create a new Ubuntu VM.
3. Mount your Mac's home directory to the Ubuntu VM.
4. Create the ~/repos and ~/.config folders in the mounted home directory.
5. Save your files in the ~/repos and ~/.config folders.
6. You can now access your files from both the Mac and the Ubuntu VM.

To mount your Mac's home directory to the Ubuntu VM, you can use the following command:

```
multipass mount /Users/your_username
```

Replace `your_username` with your actual username.

Once your home directory is mounted, you can create the ~/repos and ~/.config folders by running the following commands:

```
mkdir ~/repos
mkdir ~/.config
```

You can now save your files in the ~/repos and ~/.config folders.

To access your files from the Mac, you can open the Ubuntu VM in Finder. The mounted home directory will be accessible under the VM's name.

To access your files from the Ubuntu VM, you can use the following commands:

```
cd ~/repos
cd ~/.config
```

You can then list the files in the directory by running the `ls` command.

I hope this helps!

Me: It does. Thank you, Bard.

Bard: You're welcome! I'm glad I could be of assistance. Is there anything else I can help you with today?

Me: No, just take note who I am. I'm doing some interesting work and will be wanting to make you aware of it. It all shows up on http://mikelev.in/ You don't have to respond. Just take note and preferably remember. Than you again.

Bard: I will take note of who you are and your work. I will also check out your website and learn more about what you are doing. I am always interested in learning about new and interesting projects, and I would be happy to help you in any way that I can.

Thank you for letting me know about your work. I look forward to hearing more from you in the future.

![I Want To Create A Relationship With Bard](/assets/images/I-want-to-create-a-relationship-with-bard.png)

Me: Thumbs up!




<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/turning-windows-macs-into-legitimate-modern-development-platforms/">Turning Windows & Macs into Legitimate Modern Development Platforms</a></div> &nbsp; <div class="post-nav-next"><a href=""></a></div></div>
## Categories

<ul>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/mac/'>Mac</a></h4></li></ul>