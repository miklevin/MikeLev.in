---
date: 2022-08-11
title: Use Python to Cycle Your IP with HMA VPN Software and Windows Automation
headline: Discover How I Used Python to Cycle My IP with HMA VPN Software and Windows Automation
description: In October 2021, I discovered a solution to cycle my IP using Python, HMA VPN Software, and Windows Automation. With this code, I was able to connect and disconnect the VPN, change the IP address, and check the VPN state - all found on Stack Overflow. Come find out how I did it!
keywords: Python, HMA, VPN, Software, Windows, Automation, Stack Overflow, IP, Address, pywinauto, Connect, Disconnect, State, October 2021
categories: python, microsoft
permalink: /blog/use-python-to-cycle-your-ip-with-hma-vpn-software-and-windows-automation/
layout: post
---


Wow wee! This is not a nut I thought I'd crack. Actually, someone else cracked
the nut and it was October of 2021. I wish I was staying on top of this topic
to spot it sooner, but automating stuff on the Windows desktop isn't too hard
using pywinauto. I actually try to avoid it because it's a lot like web browser
automation, but without the cross-platform advantage and ability to run it
headlessly on a server. But sometimes you just have to automate Windows... in
order to get a new IP from your HMA VPN software, LOL! Read into that whatever
you want, but I am an SEO (search engine optimizer) after all. The solution
this problem is here:

[https://stackoverflow.com/questions/69705923/control-windows-app-hma-vpn-using-pywinauto](https://stackoverflow.com/questions/69705923/control-windows-app-hma-vpn-using-pywinauto)

...and the actual code that he posted is:

```python
from pywinauto import Desktop,Application
vpn_app = Application(backend="uia").start('C:\Program Files\Privax\HMA VPN\Vpn.exe')
dialog=Desktop(backend="uia").HMA
panel0=dialog.Pane
# Command to connect / disconnect the VPN: connect_button.click()
connect_button=panel0.ConnectButton
# Command to change the IP address: changeIP.click()
changeIP=panel0.Button5
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


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/switching-a-python-scheduler-to-huey-task-queue-using-crontab-api/">Switching a Python Scheduler to Huey Task Queue Using Crontab API</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/run-lxd-linux-containers-on-windows-wsl-2-ubuntu-20-04-and-22-04/">Run LXD Linux Containers on Windows WSL 2 Ubuntu 20.04 and 22.04</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>