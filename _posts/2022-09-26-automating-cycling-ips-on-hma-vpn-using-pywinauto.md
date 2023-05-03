---
date: 2022-09-26
title: Automating Cycling IPs on HMA VPN Using PyWinAuto
permalink: /blog/automating-cycling-ips-on-hma-vpn-using-pywinauto/
headline: Successfully Automating Cycling IPs on HMA VPN with PyWinAuto
description: I was hesitant to install Python from the Microsoft Store, but it was necessary to write a script with pywinauto that automates cycling IPs on HMA VPN. I'm happy to report that the script runs successfully and checks for goodip.txt to make sure it changes the IP address. Read my blog post to find out more about my journey of writing this script.
keywords: Cycling IPs, HMA VPN, PyWinAuto, Python, Microsoft Store, Script, Automation, Goodip.txt, Change IP, Journey, Module
categories: journey, automation, script, python
layout: post
---

Alright, I usually like to make one long post on each project but this one
deserves being broken into two. The first was essentially the creation of a
do-nothing machine, a.k.a. useless box. But it will be far from useless as soon
as this next bit is in place. Deep breath! Once again, the code I'm borrowing
from is:

[https://stackoverflow.com/questions/69705923/control-windows-app-hma-vpn-using-pywinauto](https://stackoverflow.com/questions/69705923/control-windows-app-hma-vpn-using-pywinauto)

```python
from pywinauto import Desktop,Application
vpn_app = Application(backend="uia").start('C:\Program Files\Privax\HMA VPN\Vpn.exe')
dialog=Desktop(backend="uia").HMA
panel0=dialog.Pane
# Command to connect / disconnect the VPN: connect_button.click()
connect_button=panel0.ConnectButton
# Command to change the IP address: changeIP.click()
connect_button.get_toggle_state()changeIP=panel0.Button5
# Check VPN state:
# 0 if disconnected
# 1 if connected
print(connect_button.get_toggle_state())

# Command to connect / disconnect the VPN: connect_button.click()
connect_button=panel0.ConnectButton
connect_button.click()

# Command to change the IP address: changeIP.click()
changeIP=panel0.Button5
changeIP.click()

# Check VPN state:
# 0 if disconnected
# 1 if connected
print(connect_button.get_toggle_state())
```

I don't need all of that. I just need... well, first to pip install pywinauto.
Okay, done. The pip wheels system is awesome, by the way. Next is I put the
import statement in my file (no step too small to document when you're
compelling yourself forward). Make sure the libraries import...

Ugh! I had a realization. Even my Windows-seeming Python terminals are actually
Linux. Now that I've scrapped JupyerDesktop's bundled version of Python, I have
no real Windows Python on my machine. And now I want the one from the Microsoft
Store so that it stays up to the latest! Ensure I don't already have one by
going to PowerShell and typing Python. Nope! It actually brings me to the
Microsoft Store, haha! Okay... I've been very reluctant to get this version in
the past, but the time is right.

Okay, throw caution to the wind and pip install pywinauto from a PowerShell...
it worked! Now run my script... yay! It ran and it forced HMA to run too. Big
progress. This is awesome. I hate installing Python from the Microsoft store,
but this is the current reality. What's the version? 3.10.7... Awesome? Okay
time to pip uninstall pywinauto from the Linux platform where it's meaningless.
Done. Okay, and the program's function (so far) has been tested under the new
Windows python.exe.

Next I need it actually cycling the IP whenever goodip.txt is deleted.
Fast-forward through a lot of experimentation, and here it is! I'll never lose
it again.

```python
from pathlib import Path
from time import sleep, time
from pywinauto import Desktop, Application

vpn_app = Application(backend="uia").start('C:\Program Files\Privax\HMA VPN\Vpn.exe')
dialog=Desktop(backend="uia").HMA
panel0=dialog.Pane
sleep(2)

# Connect VPN if not connected
connect_button=panel0.ConnectButton
if not connect_button.get_toggle_state():
    connect_button.click()
    sleep(10)

print("Starting")

start = time()
while True:
    if Path("goodip.txt").exists():
        print(f"{int(time() - start)} ", end="", flush=True)
        sleep(1)
    else:
        print("Need new IP")
        with open("goodip.txt", "w+") as fh:
            fh.write("foo")
        changeIP=panel0.Button5
        changeIP.click()
        sleep(10)
        start = time()
```


## Categories

<ul>
<li><h4><a href='/journey/'>Journey</a></h4></li>
<li><h4><a href='/automation/'>Automation</a></h4></li>
<li><h4><a href='/script/'>Script</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>