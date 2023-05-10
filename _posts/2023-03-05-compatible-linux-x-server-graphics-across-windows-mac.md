---
date: 2023-03-05
title: Compatible Linux X Server Graphics Across Windows & Mac
headline: Exploring Compatible Linux X Server Graphics Across Windows and Mac
description: As a reader trying to decide between Manim and Synfig for animation software, I need to consider my individual learning style, goals, and preferences. I am looking for step-by-step instructions to install Manim and supporting libraries on Ubuntu, as well as how to access localhost port 8888 and run JupyterLab on an Intel Mac. I have found resources on Proxy for accessing host Windows in WSL2.
keywords: Linux, X Server, Graphics, Windows, Mac, Manim, Synfig, Animation, Software, Learning, Style, Goals, Preferences, Step-by-Step, Instructions, Install, Libraries, Ubuntu, Access, Localhost, Port 8888, Run, JupyterLab, Intel Mac, Proxy, WSL2, Fixing, WSL2 Localhost Access Issue, Multipass, VirtualBox, RDP, X11 Forwarding, Math, Python, GUI
categories: microsoft, access, graphic, wsl, ubuntu, mac, jupyter, python, linux, success
permalink: /blog/compatible-linux-x-server-graphics-across-windows-mac/
layout: post
---


Which FOSS is believed to have the lowest learning curve and which is also able
to advance with you especially by taking instructions from a python api? I want
a GUI to get starred and then a python API I can use as I get advanced.

Based on my web searches, there is no definitive answer to which FOSS animation software has the lowest learning curve and can advance with you by taking instructions from a python API. However, some possible candidates are:

- Synfig Studio: This is a 2D animation software that can export your animations as SVG using the Cairo renderer. It has a GUI that allows you to create vector graphics and keyframes. It also has a python API that allows you to script your animations and access advanced features³.
- Blender: This is a 3D animation software that can create models, textures, rigging, lighting, rendering and more. It has a GUI that offers many tools and options for animators. It also has a python API that allows you to customize your workflow and extend your functionality⁴.
- Manim: This is a python library that can create mathematical animations using code. It does not have a GUI but it has many examples and tutorials to help you get started. It can produce high-quality videos or GIFs of your animations.

I hope this helps. Do you have any other questions? 😊

Source: Conversation with Bing, 3/3/2023

    (1) Create your own animations with this open source motion graphics tool. https://opensource.com/article/21/12/synfig-motion-graphics Accessed 3/3/2023.
    (2) 6 Top Open Source 3D/2D Animation Software - FOSS Post. https://fosspost.org/open-source-3d-2d-animation-software/ Accessed 3/3/2023.
    (3) fossology · PyPI. https://pypi.org/project/fossology/ Accessed 3/3/2023.
    (4) FOSS Python · GitHub. https://github.com/FOSSPython Accessed 3/3/2023.
    (5) software - FOSS tools for creating high quality physics animations and .... https://scicomp.stackexchange.com/questions/12855/foss-tools-for-creating-high-quality-physics-animations-and-simulations-in-2d-an Accessed 3/3/2023.

If you wanted both to learn Math and do use your Python skills to animate, would Manim be a good choice? I know it has no GUI but if you wanted simple object vector timing animation including some key framing like abilities, could you still use Manim reasonably? Or is Synfig a better choice from the beginning with such requirements?

Get the Bing app with the new AI-powered Bing now!:
https://bingapp.microsoft.com/bing?adjust=gfv2crx_717ll9t&style=sydney

I’m afraid I can’t give you a definitive answer to which software is better for your needs. It depends on your personal preferences, goals and learning style. However, I can give you some pros and cons of each option based on what I know:

1. Manim: This might be a good choice if you want to learn math and use your python skills to animate. It can create beautiful and expressive mathematical animations using code. However, it does not have a GUI and it may have a steep learning curve for beginners. It also may not be very suitable for complex or realistic animations that are not math-related.
1. Synfig: This might be a good choice if you want to create simple object vector timing animation with some keyframing abilities. It has a GUI that allows you to draw and manipulate vector graphics and keyframes. It also has a python API that allows you to script your animations and access advanced features. However, it may not be very effective for learning math or using your python skills to animate. It also may not be very suitable for 3D or realistic animations.

Ultimately, the best way to find out which software works best for you is to try them out yourself and see what suits your needs and preferences. You can also look for online tutorials, examples and reviews of each software to get more insights.

I hope this helps. Do you have any other questions? 😊

If I wanted to start doing math animations with manim to brush up on my algebra, give me some sample code to visualize the most basic algebra 1 principles.

Manim is a Python library for creating mathematical animations, originally developed by 3Blue1Brown⁴. It allows you to create Mobjects (mathematical objects) and animate them with various methods. To visualize some basic algebra 1 principles, you can use Manim to create graphs, equations, shapes and more.

Here is some sample code to visualize the distributive property of multiplication over addition using Manim:

```python
from manim import *

class DistributiveProperty(Scene):
    def construct(self):
        # Create an equation
        equation = MathTex("(a+b)\\times c", "=", "a\\times c", "+", "b\\times c")
        # Align the equation to the left
        equation.to_edge(LEFT)
        # Add brackets around the terms
        brackets = VGroup(*[Brace(eq) for eq in equation])
        # Add labels for each term
        labels = VGroup(*[bracket.get_text(text)
                          for bracket, text in zip(brackets, ["Term 1", "Equals", "Term 2", "Plus", "Term 3"])])
        # Group the equation and the labels together
        eq_group = VGroup(equation, brackets, labels)

        # Create a rectangle with width a+b and height c
        rect = Rectangle(width=5, height=3)
        rect.set_color(WHITE)
        rect.next_to(eq_group, DOWN)

        # Create two smaller rectangles with width a and b respectively and height c
        rect_a = Rectangle(width=2.5, height=3)
        rect_a.set_color(YELLOW)
        rect_a.move_to(rect.get_left(), aligned_edge=LEFT)

        rect_b = Rectangle(width=2.5, height=3)
        rect_b.set_color(BLUE)
        rect_b.move_to(rect.get_right(), aligned_edge=RIGHT)


       # Animate the scene
       self.play(Write(equation))
       self.wait()
       self.play(LaggedStart(*[GrowFromCenter(bracket) for bracket in brackets]))
       self.play(LaggedStart(*[Write(label) for label in labels]))
       self.wait()
       self.play(FadeIn(rect))
       self.wait()
       self.play(Transform(rect.copy(), VGroup(rect_a.copy(), rect_b.copy())))
       self.wait()
```

Source: Conversation with Bing, 3/3/2023

    (1) 3b1b/manim: Animation engine for explanatory math videos - GitHub. https://github.com/3b1b/manim Accessed 3/3/2023.
    (2) GitHub - JazonJiao/Manim.js: Replicating 3Blue1Brown's math animation .... https://github.com/JazonJiao/Manim.js/ Accessed 3/3/2023.
    (3) Creating Mathematical Animations in Python using Manim - Analytics Vidhya. https://www.analyticsvidhya.com/blog/2022/08/creating-mathematical-animations-in-python-using-manim/ Accessed 3/3/2023.
    (4) Creating math animations in Python with Manim - Gilbert Tanner. https://gilberttanner.com/blog/creating-math-animations-in-python-with-manim/ Accessed 3/3/2023.
    (5) Manim Tutorial Series E01: An Invitation to Mathematical Animations .... https://www.youtube.com/watch?v=rUsUrbWb2D4 Accessed 3/3/2023.
    (6) Manim Tutorial Series E05: Interactivity | Mathematical Animations WITH .... https://www.youtube.com/watch?v=KeXBLPC1tns Accessed 3/3/2023.


That's great thanks. I can't wait to run it. I run this stuff on Ubuntu on WSLg on Windows 10. I have Linux graphics support and I'll run it from JupyterLab through Edge but it's really running the Python on WSL Linux. So graphics visualizations from Manim can be either in the browser using JavaScript abilities or a pop-out task using native Linix graphics probably under the default WSL X server. Gkve me the step by step to install Manim and the required supporting libraries is not installed by default and to do the Manim equivalent of a Hello World program to ensure graphics are working.

To install Manim on Ubuntu, you need to first install some system dependencies such as Cairo, Pango and FFmpeg. You can do this by running the following commands in your terminal:

```bash
sudo apt update
sudo apt install build-essential python3-dev libcairo2-dev libpango1.0-dev ffmpeg
```

If you don't have pip installed, you can install it by running:

```bash
sudo apt install python3-pip
```

Then, to install Manim, run:

```bash
pip3 install manim
```

To test if Manim is working properly, you can create a simple Hello World program using this code:

```python
from manim import *

class HelloWorld(Scene):
    def construct(self):
        text = Text("Hello World!")
        self.play(Write(text))
        self.wait()
```

Save this file as hello_world.py and run it with:

```bash
manim hello_world.py HelloWorld -pql
```

This should open a video player with your animation. The flags -pql mean preview (open the video player), quality (low) and renderer (OpenGL). You can change these flags according to your preferences.

For more information on how to use Manim, you can check out their documentation⁵ or their tutorials.

Source: Conversation with Bing, 3/3/2023

    (1) Installation - Manim Community v0.17.2. https://docs.manim.community/en/stable/installation.html Accessed 3/3/2023.
    (2) How to install man pages on Ubuntu Linux - nixCraft. https://www.cyberciti.biz/faq/how-to-add-install-man-pages-on-ubuntu-linux/ Accessed 3/3/2023.
    (3) Linux - Manim Community v0.17.2. https://docs.manim.community/en/stable/installation/linux.html Accessed 3/3/2023.
    (4) python3 - Error building wheel for manimpango - Ask Ubuntu. https://askubuntu.com/questions/1400417/error-building-wheel-for-manimpango Accessed 3/3/2023.
    (5) 1. Installing manim – Pause and Ponder. https://purusharthsaxena.wordpress.com/2019/01/03/1-installing-manim/ Accessed 3/3/2023.

Can I do this with a Canonical Ubuntu 22.04 instance installed by Multipass from Ubuntu without VirtualBox? This is newer than the old VirtialBox way of doing it because it's too much overhead and too many steps. simplify the above the Multipass way.

Yes, you can use Multipass without VirtualBox on Mac. By default, Multipass on Mac uses hyperkit driver for Intel Mac and qemu driver for M1 Mac¹. These drivers are more lightweight and efficient than VirtualBox.

To use Multipass without VirtualBox on Mac, you need to first uninstall VirtualBox if you have it installed. Then, you need to install Multipass from its official website . You can also install it using Homebrew by running:

```bash
brew install --cask multipass
```

Then, you can launch an Ubuntu 22.04 instance with Multipass using this command:

```bash
multipass launch --name manim --cpus 2 --mem 4G --disk 10G 22.04
```

This will create a virtual machine named manim with 2 CPUs, 4 GB of RAM and 10 GB of disk space running Ubuntu 22.04.

Next, you need to install Manim and its dependencies on the Ubuntu instance. You can do this by following the same steps as before:

```bash
sudo apt update
sudo apt install build-essential python3-dev libcairo2-dev libpango1.0-dev ffmpeg
sudo apt install python3-pip
pip3 install manim
```

To run Manim animations on your Mac, you have two options: using RDP (Remote Display Protocol) or using X11 forwarding.

Using RDP means that you will see a complete desktop environment of the Ubuntu instance on your Mac screen. To do this, you need to install xrdp and xfce4 on the Ubuntu instance:

```bash
sudo apt install xrdp xfce4
```

Then, you need to configure xrdp to use xfce4 as the default desktop:

```bash
echo "xfce4-session" > ~/.xsession
```

Finally, you need to restart xrdp service:

```bash
sudo service xrdp restart
```

On your Mac side, you need to install a RDP client such as Microsoft Remote Desktop. Then, you need to find out the IP address of your Ubuntu instance by running:

```bash
multipass info manim | grep IPv4 | awk '{print $2}'
```

This will give you an output like `192.168.64.5`. Then, open Microsoft Remote Desktop and create a new connection with that IP address as the PC name and `ubuntu` as the user name. Leave the password blank and click Connect.

You should see a login screen where you can enter `ubuntu` as both user name and password. Then, you should see a desktop environment where you can run Manim animations.

Using X11 forwarding means that you will only see one application window from the Ubuntu instance on your Mac screen. To do this, you need to install XQuartz on your Mac side and enable Allow connections from network clients in its Preferences > Security tab.

Then, you need to find out the IP address of your Ubuntu instance by running:

```bash
multipass info manim | grep IPv4 | awk '{print $2}'
```

This will give you an output like `192.168.64.5`. Then, open a terminal on your Mac side and run:

```bash
ssh -X ubuntu@192.168.64.5 # replace with your actual IP address
```

Enter `ubuntu` as both user name and password when prompted.

You should now be able to run Manim animations from within this terminal session by using commands like:

```bash
manim hello_world.py HelloWorld -ql # no preview flag needed
```

This should open a window with your animation on your Mac screen.

To access localhost port 8888 Linux-side under Multipass from your Mac browser like Safari,
you can use port forwarding feature of Multipass itself¹. For example,

```bash
multipass set local.driver.port_forwarding=true # enable port forwarding
multipass forward manim tcp:8888 # forward port 8888 from Linux-side to host-side for an instance named manim
```
This will forward port 8888 from Linux-side to port 8888 on host-side for an instance named manim.

Then,
if you run JupyterLab or Jupyter Notebook on Linux-side with port 8888,

``` bash
jupyter lab --no-browser --port=8888 # or jupyter notebook
```
You should be able to access it from Safari by entering `http://localhost:8888` in the address bar.

The networking context Multipass uses by default for communication between

Source: Conversation with Bing, 3/3/2023

    (1) How to set up the driver | Multipass documentation. https://multipass.run/docs/set-up-the-driver Accessed 3/3/2023.
    (2) How to use VirtualBox in Multipass on Windows. https://discourse.ubuntu.com/t/how-to-use-virtualbox-in-multipass-on-windows/16626 Accessed 3/3/2023.
    (3) Multipass does not play well with VirtualBox on MacOS #2322 - GitHub. https://github.com/canonical/multipass/issues/2322 Accessed 3/3/2023.
    (4) How to install Multipass on Windows | Multipass documentation. https://multipass.run/docs/installing-on-windows Accessed 3/3/2023.
    (5) How to use Multipass, a new tool for launching virtual machines. https://www.techrepublic.com/article/multipass-is-a-new-tool-for-launching-virtual-machines/ Accessed 3/3/2023.


I want to do the same thing now on a Mac. I use Ubuntu 22.04 on a circa 2020 Mac Intel laptop. Unbunti was installed with MultiPass which provides similar services as WSL and avoids having to use Parallels, VMWare Fusion, VirtualBox and QEMU. I don't know if it supports graphics. Figure that out plus whether localhost port 8888 Linix-side under MultiPass can be reached Mac side through a browser like Safari. Such a service is usually called port mapping, port forwarding, proxy and requires special networking context. Include the networking context MultiPass uses by default for communication between Mac-side and Linux-side.

To use Manim on a Mac with Multipass, you need to first install Multipass and VirtualBox on your Mac. You can download them from their official websites . Then, you need to launch an Ubuntu 22.04 instance with Multipass using this command:

```bash
multipass launch --name manim --cpus 2 --mem 4G --disk 10G 22.04
```

This will create a virtual machine named manim with 2 CPUs, 4 GB of RAM and 10 GB of disk space running Ubuntu 22.04.

Next, you need to install Manim and its dependencies on the Ubuntu instance. You can do this by following the same steps as before:

```bash
sudo apt update
sudo apt install build-essential python3-dev libcairo2-dev libpango1.0-dev ffmpeg
sudo apt install python3-pip
pip3 install manim
```

To run Manim animations on your Mac, you have two options: using RDP (Remote Display Protocol) or using X11 forwarding.

Using RDP means that you will see a complete desktop environment of the Ubuntu instance on your Mac screen. To do this, you need to install xrdp and xfce4 on the Ubuntu instance:

```bash
sudo apt install xrdp xfce4
```

Then, you need to configure xrdp to use xfce4 as the default desktop:

```bash
echo "xfce4-session" > ~/.xsession
```

Finally, you need to restart xrdp service:

```bash
sudo service xrdp restart
```

On your Mac side, you need to install a RDP client such as Microsoft Remote Desktop. Then, you need to find out the IP address of your Ubuntu instance by running:

```bash
multipass info manim | grep IPv4 | awk '{print $2}'
```

This will give you an output like `192.168.64.5`. Then, open Microsoft Remote Desktop and create a new connection with that IP address as the PC name and `ubuntu` as the user name. Leave the password blank and click Connect.

You should see a login screen where you can enter `ubuntu` as both user name and password. Then, you should see a desktop environment where you can run Manim animations.

Using X11 forwarding means that you will only see one application window from the Ubuntu instance on your Mac screen. To do this, you need to install XQuartz on your Mac side and enable Allow connections from network clients in its Preferences > Security tab.

Then, you need to find out the IP address of your Ubuntu instance by running:

```bash
multipass info manim | grep IPv4 | awk '{print $2}'
```

This will give you an output like `192.168.64.5`. Then, open a terminal on your Mac side and run:

```bash
ssh -X ubuntu@192.168.64.5 # replace with your actual IP address
```

Enter `ubuntu` as both user name and password when prompted.

You should now be able to run Manim animations from within this terminal session by using commands like:

```bash
manim hello_world.py HelloWorld -ql # no preview flag needed
```

This should open a window with your animation on your Mac screen.

To access localhost port 8888 Linux-side under Multipass from your Mac browser like Safari, you can use port forwarding feature of VirtualBox. For example,

```bash
sudo VBoxManage controlvm "manim" natpf1 "jupyter,tcp,,8888,,8888"
```

This will forward port 8888 from Linux-side to port 8888 on Mac-side for an instance named manim.

Then, if you run JupyterLab or Jupyter Notebook on Linux-side with port 8888,

```bash
jupyter lab --no-browser --port=8888 # or jupyter notebook
```

You should be able to access it from Safari by entering `http://localhost:8888` in the address bar.

The networking context Multipass uses by default for communication between Mac-side and Linux-side is NAT (Network Address Translation). This means that each Multipass instance has its own private IP address that is not directly accessible from outside but can be mapped to ports on host machine using port forwarding feature of VirtualBox.

Source: Conversation with Bing, 3/3/2023

    (1) How to set up a graphical interface | Multipass documentation. https://multipass.run/docs/set-up-a-graphical-interface Accessed 3/3/2023.
    (2) How to set up the driver | Multipass documentation. https://multipass.run/docs/set-up-the-driver Accessed 3/3/2023.
    (3) Port forwarding · Issue #309 · canonical/multipass · GitHub. https://github.com/canonical/multipass/issues/309 Accessed 3/3/2023.

Once MultiPass is installed from Canonical Ubuntu on an Intel Mac, I want everything else that needs to be done to install JupterLab Linux-side (Ubuntu 22.04) and to make Linux-side port 8888 used by Jupyter server accessible Mac-side through browsers such as Safari. Try to put it all in one easy to run Linux Unix or Bash script that will run under a Mac Terminal session. By the time it's run you should be able to open Safari, go to port 8888 and start running Python under JupyterLab which is running under Ubuntu 22.04 through MultiPass on an Intel Mac.

Hello, this is Bing. I can help you with installing JupyterLab on Ubuntu 22.04 through MultiPass on an Intel Mac.

There are different ways to install JupyterLab on Ubuntu, but one of the easiest methods is to use Anaconda¹, a popular Python distribution that comes with many useful packages and tools for data science.

To install Anaconda on Ubuntu, you need to download the installation Bash script from their website¹ and run it with bash command. You can also use wget command to download the script directly.

To install JupyterLab using Anaconda, you need to use conda command⁵ with conda-forge channel option. Conda-forge is a community-led collection of recipes and packages for conda.

To make Linux-side port 8888 used by Jupyter server accessible Mac-side through browsers such as Safari, you need to use multipass mount command to mount a directory from your Mac host into your Ubuntu instance. Then you can use multipass info command to get the IP address of your Ubuntu instance and use it to access JupyterLab from Safari.

Here is a possible Bash script that will do all these steps for you:

```bash
#!/bin/bash

# Install Anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O /tmp/anaconda.sh
bash /tmp/anaconda.sh -b -p $HOME/anaconda3

# Add Anaconda bin directory to PATH
export PATH="$HOME/anaconda3/bin:$PATH"

# Install JupyterLab
conda install -c conda-forge jupyterlab

# Mount a directory from Mac host into Ubuntu instance
multipass mount ~/Documents/jupyter ubuntu:/home/ubuntu/jupyter

# Get IP address of Ubuntu instance
IP=$(multipass info ubuntu | grep IPv4 | awk '{print $2}')

# Start Jupyter server
jupyter lab --ip $IP --port 8888 --no-browser
```

You can save this script as `install_jupyterlab.sh` and run it under a Mac Terminal session with `bash install_jupyterlab.sh`. By the time it's done, you should be able to open Safari, go to `http://$IP:8888` (replace `$IP` with the actual IP address) and start running Python under JupyterLab which is running under Ubuntu 22.04 through MultiPass on an Intel Mac.

I hope this helps! 😊

Source: Conversation with Bing, 3/3/2023

    (1) Easily Install Jupyter Notebook on Ubuntu (Step by Step) - ATA Learning. https://adamtheautomator.com/install-jupyter-notebook-on-ubuntu/ Accessed 3/3/2023.
    (2) Installation — JupyterLab 3.6.1 documentation - Read the Docs. https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html Accessed 3/3/2023.
    (3) Install JupyterLab for Python in Ubuntu 22.04 - TechPiezo. https://techpiezo.com/python/install-jupyterlab-for-python-in-ubuntu-22-04/ Accessed 3/3/2023.
    (4) How to install jupyter lab on linux mint? - Stack Overflow. https://stackoverflow.com/questions/71224438/how-to-install-jupyter-lab-on-linux-mint Accessed 3/3/2023.
    (5) Install Jupyterlab on Ubuntu - Fast & Easy - Ceos3c. https://www.ceos3c.com/linux/install-jupyterlab-on-ubuntu/ Accessed 3/3/2023.
    (6) How To Set Up a JupyterLab Environment on Ubuntu 18.04. https://www.digitalocean.com/community/tutorials/how-to-set-up-a-jupyterlab-environment-on-ubuntu-18-04 Accessed 3/3/2023.

No I will pip install it from Linux on MultiPass. Jupyter runs Linix-side. Try again without Anaconda.

I understand. If you prefer to use pip instead of Anaconda, you can also install JupyterLab with pip command²³⁵. Pip is a package manager for Python that can install JupyterLab and its dependencies.

To install JupyterLab with pip, you need to make sure you have Python 3.3 or greater⁴ and pip installed on your Ubuntu instance. You can use apt command to install them if they are not already installed.

To make Linux-side port 8888 used by Jupyter server accessible Mac-side through browsers such as Safari, you need to use multipass mount command to mount a directory from your Mac host into your Ubuntu instance. Then you can use multipass info command to get the IP address of your Ubuntu instance and use it to access JupyterLab from Safari.

Here is a possible Bash script that will do all these steps for you:

```bash
#!/bin/bash

# Install Python 3 and pip
sudo apt update
sudo apt install python3 python3-pip

# Install JupyterLab with pip
pip3 install jupyterlab

# Mount a directory from Mac host into Ubuntu instance
multipass mount ~/Documents/jupyter ubuntu:/home/ubuntu/jupyter

# Get IP address of Ubuntu instance
IP=$(multipass info ubuntu | grep IPv4 | awk '{print $2}')

# Start Jupyter server
jupyter lab --ip $IP --port 8888 --no-browser
```

You can save this script as `install_jupyterlab.sh` and run it under a Mac Terminal session with `bash install_jupyterlab.sh`. By the time it's done, you should be able to open Safari, go to `http://$IP:8888` (replace `$IP` with the actual IP address) and start running Python under JupyterLab which is running under Ubuntu 22.04 through MultiPass on an Intel Mac.

I hope this helps! 😊

Source: Conversation with Bing, 3/3/2023

    (1) Install JupyterLab for Python in Ubuntu 22.04 - TechPiezo. https://techpiezo.com/python/install-jupyterlab-for-python-in-ubuntu-22-04/ Accessed 3/3/2023.
    (2) Install Jupyterlab on Ubuntu - Fast & Easy - Ceos3c. https://www.ceos3c.com/linux/install-jupyterlab-on-ubuntu/ Accessed 3/3/2023.
    (3) Project Jupyter | Installing Jupyter. https://jupyter.org/install Accessed 3/3/2023.
    (4) How to install JupyterLab on Linux | Enable Sysadmin. https://www.redhat.com/sysadmin/install-jupyterlab-linux Accessed 3/3/2023.
    (5) How to install JupyterLab on Linux | Enable Sysadmin. https://www.redhat.com/sysadmin/install-jupyterlab-linux Accessed 3/3/2023.
    (6) Installation — JupyterLab 3.6.1 documentation - Read the Docs. https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html Accessed 3/3/2023.

Gove me an all-in-one install script that does this.

I’m sorry but I don’t understand what you mean by “an all-in-one install script that does this”. Do you mean the script that I provided in my previous message? That script should install JupyterLab on Ubuntu 22.04 through MultiPass on an Intel Mac and make it accessible from Safari. Is there something else that you want the script to do?

MultiPass is already installed as is Ubuntu 22.04. I can run vim and save the text file as a .sh file and run it with bash. We may need 2 scripts: one to do the installs and network configuration and another to start the Juputer service. Make Jupyter run as a systemd service so I can start and stop it with systemctl. Show me the complete, likely two, scripts to accomplish this.

I see. If you want to run JupyterLab as a systemd service on Ubuntu 22.04, you can follow these steps:

1. Create a file named `install_jupyterlab.sh` with the following content:

```bash
#!/bin/bash

# Install Python 3 and pip
sudo apt update
sudo apt install python3 python3-pip

# Install JupyterLab with pip
pip3 install jupyterlab

# Get IP address of Ubuntu instance
IP=$(multipass info ubuntu | grep IPv4 | awk '{print $2}')

# Create a systemd service file for JupyterLab
cat << EOF | sudo tee /etc/systemd/system/jupyter.service
[Unit]
Description=Jupyter Lab

[Service]
Type=simple
PIDFile=/run/jupyter.pid
ExecStart=/usr/bin/jupyter lab --ip $IP --port 8888 --no-browser --allow-root
User=root
Group=root
WorkingDirectory=/home/ubuntu/jupyter/
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
sudo systemctl enable jupyter.service
sudo systemctl start jupyter.service

```

2. Run the script with `bash install_jupyterlab.sh`. This will install JupyterLab and create a systemd service for it.

3. To start or stop the JupyterLab service, use `sudo systemctl start jupyter.service` or `sudo systemctl stop jupyter.service`.

4. To access JupyterLab from Safari, go to `http://$IP:8888` (replace `$IP` with the actual IP address).

I hope this helps! 😊

Source: Conversation with Bing, 3/3/2023

    (1) How to run Jupyter Lab as systemd service - TechOverflow. https://techoverflow.net/2021/06/11/how-to-run-jupyter-lab-as-systemd-service/ Accessed 3/3/2023.
    (2) How to run Jupyter Lab as systemd service - TechOverflow. https://techoverflow.net/2021/06/11/how-to-run-jupyter-lab-as-systemd-service/ Accessed 3/3/2023.
    (3) Customizing systemd services — The Littlest ... - Project Jupyter. https://tljh.jupyter.org/en/latest/howto/admin/systemd.html Accessed 3/3/2023.
    (4) A systemd script for running a Jupyter notebook server. · GitHub - Gist. https://gist.github.com/whophil/5a2eab328d2f8c16bb31c9ceaf23164f Accessed 3/3/2023.
    (5) Manage Jupyter Notebook and JupyterLab with Systemd. https://janakiev.com/blog/jupyter-systemd/ Accessed 3/3/2023.

From step 4: To access JupyterLab from Safari, go to `http://$IP:8888` (replace `$IP` with the actual IP address). Is that a feature of MultiPass? What IP do I use, the one of the Linux Ubuntu under MultiPass? What is the networking context that makes this accessible Mac-side in Safari?

Yes, that is a feature of Multipass. Multipass can launch instances with additional network interfaces that can be bridged with the host networks¹²³. This allows you to access the instance from your Mac host using its IP address.

The IP address that you need to use is the one of the Ubuntu instance under Multipass. You can get it by running `multipass info ubuntu | grep IPv4 | awk '{print $2}'` on your Mac Terminal. This will show you something like `192.168.64.2`, which is the IP address assigned to your Ubuntu instance by Multipass.

The networking context that makes this accessible Mac-side in Safari is that Multipass creates a virtual network interface on your Mac host that connects to a bridge interface on your Ubuntu instance. This way, your Mac host and your Ubuntu instance can communicate with each other using their IP addresses.

I hope this clarifies! 😊

Source: Conversation with Bing, 3/3/2023

    (1) How to add network interfaces - Ubuntu Community Hub. https://discourse.ubuntu.com/t/how-to-add-network-interfaces/19544 Accessed 3/3/2023.
    (2) How to add network interfaces - Ubuntu Community Hub. https://discourse.ubuntu.com/t/how-to-add-network-interfaces/19544 Accessed 3/3/2023.
    (3) `multipass networks` command | Multipass documentation. https://multipass.run/docs/networks-command Accessed 3/3/2023.
    (4) `multipass networks` command - Ubuntu Community Hub. https://discourse.ubuntu.com/t/multipass-networks-command/19542 Accessed 3/3/2023.
    (5) How to troubleshoot networking | Multipass documentation. https://multipass.run/docs/troubleshooting-networking-on-windows Accessed 3/3/2023.
    (6) Virtualisation - multipass | Ubuntu. https://ubuntu.com/server/docs/virtualization-multipass Accessed 3/3/2023.

So this can be done without the localhost proxy that WSL requires for a similar trick?

Yes, this can be done without the localhost proxy that WSL requires for a similar trick. WSL allows sharing IP address space for services listening to localhost, but this can cause some issues with WSL2¹⁴. To access a Windows networking app from Linux on WSL2, you need to use the IP address of your host machine⁵⁶, which can change every time you start up WSL2².

Multipass does not have this problem because it creates a virtual network interface on your Mac host that connects to a bridge interface on your Ubuntu instance. This way, you can access the instance from your Mac host using its IP address without any proxy.

I hope this answers! 😊

Source: Conversation with Bing, 3/3/2023

    (1) Fixing WSL2 localhost access issue - abdus.dev. https://abdus.dev/posts/fixing-wsl2-localhost-access-issue/ Accessed 3/3/2023.
    (2) Could not connect WSL when http.proxy is set #4461 - GitHub. https://github.com/microsoft/vscode-remote-release/issues/4461 Accessed 3/3/2023.
    (3) Accessing network applications with WSL | Microsoft Learn. https://learn.microsoft.com/en-us/windows/wsl/networking Accessed 3/3/2023.
    (4) proxy - How to connect wsl to a windows localhost? - Super User. https://superuser.com/questions/1535269/how-to-connect-wsl-to-a-windows-localhost Accessed 3/3/2023.
    (5) Proxy for accessing host Windows in WSL2 - SoByte. https://www.sobyte.net/post/2022-02/wsl2-proxy/ Accessed 3/3/2023.
    (6) Fixing WSL2 localhost access issue - abdus.dev. https://abdus.dev/posts/fixing-wsl2-localhost-access-issue/ Accessed 3/3/2023.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/consulting-with-the-new-bing-on-how-to-go-viral/">Consulting With The New Bing On How to Go Viral</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/bing-won-t-write-story-about-excessively-biased-chatbot/">Bing Won't Write Story About Excessively Biased ChatBot</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/access/'>Access</a></h4></li>
<li><h4><a href='/graphic/'>Graphics</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/mac/'>Mac</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/success/'>Success</a></h4></li></ul>