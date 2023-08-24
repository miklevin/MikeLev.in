---
date: 2023-03-16
title: I Need To Get This Ready for MOZ Tutorial Use
headline: Optimizing Scripts for Efficient and Readable Use on Ubuntu-20.04
description: I have been optimizing scripts to make them more efficient and readable. I have set up a default user for Ubuntu-20.04, created a 'repos' folder for Windows/Linux file sharing, updated software repositories, installed figlet and upgraded Ubuntu 20. I have also created a shortcut for 'Linux Shell' on my desktop, deleted some files and ran a figlet command. Join me as I take you through my journey of setting up and running scripts on Ubuntu-20.04!
keywords: Scripts, Optimizing, Ubuntu-20.04, Default User, 'Repos' Folder, Windows/Linux File Sharing, Software Repositories, Figlet, Upgrade, Shortcut, Linux Shell, Delete Files, Install.sh, Reboot, Access Control List, Post-Reboot Scripts, WSL, Commands, Jup
categories: wsl, python
permalink: /blog/i-need-to-get-this-ready-for-moz-tutorial-use/
layout: post
group: blog
---


Okay, I want to optimize a few scripts, making them more efficient and easy to
read. I want to take out extra stuff. I want to go for a high level of
readability.

```bash
wsl --unregister Ubuntu-20.04
wsl --set-default-version 2

:: These are variables for the automatically created Ubuntu 20.04 user under
WSL.  set wsluer="ubuntu"

set password="foo"

:: The big install! If it's your first time, it will make you reboot your machine.
ubuntu2004 install --root

:: Once Ubuntu 20.04 is installed, this sets up the default user.
wsl -d Ubuntu-20.04 -u root useradd -m "%wsluer%"
wsl -d Ubuntu-20.04 -u root sh -c "echo "%wsluer%:%password%" | chpasswd"
wsl -d Ubuntu-20.04 -u root chsh -s /bin/bash "%wsluer%"
wsl -d Ubuntu-20.04 -u root usermod -aG adm,cdrom,sudo,dip,plugdev,lxd "%wsluer%"
ubuntu2004 config --default-user "%wsluer%"

:: This creates "repos" folder in your Windows HOME for Windows/Linux file sharing.
if not exist "%USERPROFILE%\repos" mkdir %USERPROFILE%\repos
if not exist "%USERPROFILE%\repos\transfer" mkdir %USERPROFILE%\repos\transfer
if not exist "%USERPROFILE%\.jupyter" mkdir %USERPROFILE%\.jupyter
if not exist "%USERPROFILE%\.config" mkdir %USERPROFILE%\.config
curl -L -o %USERPROFILE%\.config\bash.ico "https://raw.githubusercontent.com/miklevin/drinkme/main/icons/bash.ico"

:: If you're running from a location with these optional second-stage install files, copy them over.
echo Copying optional installer files apt_installs.sh and requirements.txt if they exist.
if exist apt_installs.sh (copy apt_installs.sh %USERPROFILE%\repos\transfer) else (curl -L -o %USERPROFILE%\repos\transfer\apt_installs.sh "https://raw.githubusercontent.com/miklevin/drinkme/main/apt_installs.sh")
if exist requirements.txt (copy requirements.txt %USERPROFILE%\repos\transfer) else (curl -L -o %USERPROFILE%\repos\transfer\requirements.txt "https://raw.githubusercontent.com/miklevin/drinkme/main/requirements.txt")

:: This makes file permissions under WSL keyed off of your Windows-side.
wsl -d Ubuntu-20.04 -u root -e echo -e [boot]\nsystemd=true\n[automount]\noptions=\"metadata\" >> ./wsl.conf
wsl -d Ubuntu-20.04 -u root -e mv wsl.conf /etc/
wsl -t Ubuntu-20.04

:: This creates the a repos, .ssh and .config folders on WSL by linking to your Windows-side.
wsl -d Ubuntu-20.04 -e bash -lic "ln -s /mnt/c/Users/%USERNAME%/.ssh/ /home/ubuntu/.ssh" >NUL
wsl -d Ubuntu-20.04 -e bash -lic "ln -s /mnt/c/Users/%USERNAME%/repos/ /home/ubuntu/repos" >NUL
wsl -d Ubuntu-20.04 -e bash -lic "ln -s /mnt/c/Users/%USERNAME%/.config/ /home/ubuntu/.config" >NUL
wsl -d Ubuntu-20.04 -e bash -lic "ln -s /mnt/c/Users/%USERNAME%/.jupyter/ /home/ubuntu/.jupyter" >NUL

:: If you keep a .vimrc and .gitconfig Windows-side, this copies them over.
wsl -d Ubuntu-20.04 -e bash -lic "cp /mnt/c/Users/%USERNAME%/.vimrc /home/ubuntu/" >NUL
wsl -d Ubuntu-20.04 -e bash -lic "cp /mnt/c/Users/%USERNAME%/.gitconfig /home/ubuntu/" >NUL
wsl -d Ubuntu-20.04 -e bash -lic "cp /mnt/c/Users/%USERNAME%/.pypirc /home/ubuntu/" >NUL

:: We update the software repository on the Ubuntu 20.04 Machine
wsl -d Ubuntu-20.04 -u root -e sudo apt update

:: With Figlet installed, I no longer need to embed ASCII art headlines.
wsl -d Ubuntu-20.04 -u root -e sudo apt install figlet
wsl -d Ubuntu-20.04 -e bash -lic "figlet -t 'Upgrading Linux...'"

:: And now the big upgrading of all the Ubuntu 20.04 software.
wsl -d Ubuntu-20.04 -u root -e sudo apt upgrade -y

:: You know what's nice? Not having to type a password every time you sudo a command!
wsl -d Ubuntu-20.04 -u root /bin/bash -c "echo 'ubuntu	ALL=(ALL:ALL) NOPASSWD:ALL'> /etc/sudoers.d/ubuntu"

:: Grab and run second-half of install that runs under WSL and set up Linux graphics.
wsl -d Ubuntu-20.04 -u ubuntu -e curl -L -o /home/ubuntu/install.sh "https://raw.githubusercontent.com/miklevin/drinkme/main/install.sh"
wsl -d Ubuntu-20.04 -e bash -lic "bash /home/ubuntu/install.sh"
echo Returning from install.sh, rebooting WSL for updated ACLs (access control list)

:: Grab post-reboot scripts. ACLs aren't sufficient for git cloning without a wsl --shutdown
wsl -t Ubuntu-20.04

wsl -d Ubuntu-20.04 -u root -e echo "Back from shutdown"
wsl -d Ubuntu-20.04 -u root -e chmod 600 /home/ubuntu/.ssh/id_rsa_drinkme
wsl -d Ubuntu-20.04 -u root -e chmod 600 /home/ubuntu/.ssh/id_rsa_drinkme.pub
wsl -d Ubuntu-20.04 -u ubuntu -e curl -L -o /home/ubuntu/repos/transfer/git_installs.sh "https://raw.githubusercontent.com/miklevin/drinkme/main/git_installs.sh"
wsl -d Ubuntu-20.04 -u ubuntu -e sh /home/ubuntu/repos/transfer/git_installs.sh

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Linux Shell.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%USERPROFILE%\AppData\Local\Microsoft\WindowsApps\wt.exe" >> %SCRIPT%
echo olink.Arguments = "-p Ubuntu-20.04" >> %SCRIPT%
echo olink.IconLocation = "%USERPROFILE%\.config\bash.ico" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%
del /Q %USERPROFILE%\repos\transfer\*

wsl -d Ubuntu-20.04 -e bash -lic "figlet -t 'Done!'"
echo.
echo Double-click the icon "Linux Shell" created where you ran the script.
echo You can then reach JupyterLab in a Windows browser at http://localhost:8888
echo From Microsoft Edge, you can make JupyterLab an app from: .../Apps/Install
echo.

set /p warning=Press [Enter] to release this console window. %
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/the-tale-of-the-planckian-and-the-wall/">The Tale of The Planckian and The Wall</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/meissner-effect-schwinger-effect-tictac-flux-liner/">Meissner Effect + Schwinger Effect = TicTac Flux Liner</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>