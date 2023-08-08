---
date: 2023-02-12
title: Making a SystemD Service With ChatGPT
headline: "Creating a SystemD Service with ChatGPT: A Step-by-Step Guide"
description: I'm writing a systemd service that uses GNU screen to run a python script in the background. In this blog post, I share the details of the service, including the command to be run, the user account to run the service as, and the environment variables to be set. I also explain the meaning of the word 'majordomo' and how to create a nbdev version 2 project in a folder called majordaemo.
keywords: SystemD, Service, ChatGPT, GNU, Screen, Python, Script, ExecStart, Directive, Daemonizing, Majordomo, Triple Entendre, Git, Github, Linux, Folder, Nbdev, Version 2, Project, Executable, Virtual Environment, Gmail, IMAP, Inbox, Unread, Seen Flag
categories: nbdev, python, git, ai, linux, gnu, systemd
permalink: /blog/making-a-systemd-service-with-chatgpt/
layout: post
group: blog
---


Hey ChatGPT: I'm on a headless Linux server that's connected to the net. I have
SSH access to this server and admin rights. This server is running Linux
daemons as systemd services. One of my favorite tricks is to run scripts
through the gnu screen command in the systemd .service file and to fork the
thread so that you can connect into a screen terminal session to monitor the
running of the script by viewing the console. Do you
understand?

Yes, I understand. Running scripts through gnu screen and forking the thread in a systemd service file allows you to start the script as a background service and monitor its progress in real-time through a screen terminal session. By connecting to the screen session, you can observe the output of the script, which can be useful for debugging and monitoring purposes.

It is also important to note that systemd is a popular init system used in many Linux distributions to manage system services, including starting, stopping, and monitoring daemons. By incorporating the script into a systemd service, you can ensure that the script starts automatically whenever the system is rebooted and can also control the script's execution using system management commands like systemctl start and systemctl stop.

Hey ChatGPT: That's exactly right! I want to get started writing services for systemd that use gnu screen this way. My scripts are written in python in a directory called /home/ubuntu/repos/majordaemo. Do you recognize the joke in the name?

Yes, I recognize the joke in the name "majordaemo". The name is a play on words combining the words "major daemon," which refers to important system processes in the Unix-like operating system, and "demo," which is short for demonstration or experimentation. The name suggests that these scripts in the directory are important system processes being used for demonstration or experimentation purposes.

To write services for systemd that use gnu screen, you will need to create a .service file in the /etc/systemd/system directory that specifies the details of the service, including the script to be run, the user account to run the service as, and the environment variables to be set.

In the .service file, you can specify the use of gnu screen by including the screen command in the ExecStart directive, which specifies the command to be run when the service starts. For example:

```python
[Unit]
Description=My Major Daemo Service

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/repos/majordaemo
ExecStart=/usr/bin/screen -d -m python my_script.py

[Install]
WantedBy=multi-user.target
```

After creating the .service file, you can use the systemctl command to start, stop, and monitor the status of the service. For example, to start the service, you would run sudo systemctl start my-major-daemo.service.

Hey ChatGPT: Explain the arguments to ExecStart that daemonize the gnu screen instance.

The ExecStart directive in the .service file specifies the command to be run when the service starts. In this case, the command starts a gnu screen instance and daemonizes it.

Here's an explanation of the arguments used in the ExecStart directive:

/usr/bin/screen: This specifies the path to the screen executable. This path may be different on your system.

-d -m: These arguments are used to start screen in detached mode and to create a new screen session in the background.

python my_script.py: This is the command to run your Python script, my_script.py, in the screen session.

The -d -m arguments tell screen to run in the background and create a new screen session without attaching to the current terminal session. This allows you to start the screen session as a background service and connect to it later to monitor the running of the script by viewing the console.

When the systemd service is started, it runs the ExecStart command, which starts a gnu screen instance and runs the Python script my_script.py in the background. You can then connect to the screen session to view the output of the script by running the screen -r command.

Hey ChatGPT: Shouldn't I use the -dmS parameter to daemonize the instance?

Yes, you're correct. The -dmS parameters would be a better option to use when daemonizing the gnu screen instance.

The -d parameter is used to start screen in detached mode and run it in the background. The -m parameter is used to create a new screen session in the background, and the -S parameter is used to specify a session name.

So, the correct ExecStart directive would be:

ExecStart=/usr/bin/screen -dmS my-major-daemo python my_script.py

This will start screen in detached mode, create a new screen session named my-major-daemo, and run the Python script my_script.py in the background. You can then connect to the screen session using the screen -r my-major-daemo command.

Hey ChatGPT: Show me the whole .service file again using the correct -dmS argument and the forking directive.

Here is the complete .service file, including the corrected ExecStart directive and the forking directive:

```bash
[Unit]
Description=My Major Daemo Service

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/repos/majordaemo
ExecStart=/usr/bin/screen -dmS my-major-daemo python my_script.py
Type=forking

[Install]
WantedBy=multi-user.target
```

This .service file tells systemd to run the service as the ubuntu user and sets the working directory to /home/ubuntu/repos/majordaemo. The ExecStart directive starts a gnu screen instance in detached mode, creates a new screen session named my-major-daemo, and runs the Python script my_script.py in the background.

The Type directive is set to forking, which tells systemd that the service is forking, or starting a new process, when it is started. This is necessary because the gnu screen command forks a new process when it is started.

After creating the .service file, you can use the systemctl command to start, stop, and monitor the status of the service. For example, to start the service, you would run sudo systemctl start my-major-daemo.service.

Hey ChatGPT: Do you know what a majordomo is?

Yes, a "majordomo" is a person who acts as an intermediary between a person of high rank or power and others. The term is often used to refer to someone who manages the affairs of a household or estate, or who acts as an administrative assistant to a powerful person.

It appears that the name "majordaemo" is a play on the word "majordomo", possibly indicating that the script or service being managed by systemd is acting as an intermediary or manager for some other process or service.

Hey ChatGPT: Yes, I am going to make a demonstration out of this. It's going to be a majordemo. Does that mean I have a triple entendre? Enumerate the entendres of the joke.

Yes, the name "majordaemo" could be considered a triple entendre, as it combines multiple meanings into one word.

1. A play on the word "majordomo", as described earlier, indicating that the script or service being managed by systemd is acting as an intermediary or manager for some other process or service.
1. A play on the word "daemon", a term used in Unix-like operating systems to describe background processes that run continuously and perform specific tasks.
1. A play on the word "demonstration", as you mention you're making a demonstration out of this, emphasizing the practical and educational nature of the project.

So, the name "majordaemo" can be interpreted as a background process that acts as an intermediary or manager for other processes, while also demonstrating the use of systemd and gnu screen.

Hey ChatGPT: That is exactly so! Thank you for understanding. What do you think the chances are that anyone out there in a general audience would get such a joke in the naming of a git Github repo and Linux service folder?

The chances of someone in a general audience understanding the joke in the naming of a Git Github repo and Linux service folder would likely depend on the level of technical expertise of the audience and their familiarity with the terms and concepts involved.

In a technical audience with knowledge of Unix-like operating systems, Git, and software development, the joke would likely be well understood and appreciated. On the other hand, in a general audience with limited technical knowledge, the joke may be less well understood or appreciated.

However, it's important to note that the name of a Git repository or a folder in a file system is primarily intended to provide an identifiable label or identifier, and its meaning is typically secondary to its function. So, while the joke may not be widely understood or appreciated, it can still serve its primary purpose as a label or identifier.

Hey ChatGPT: Do you know nbdev version 2, as opposed to version 1?

Yes, I am aware of nbdev version 2. nbdev is a library for Python that provides tools for building and testing Jupyter notebooks as packages.

Version 2 is a major update to nbdev, introducing new features and improvements over version 1. Some of the notable changes in version 2 include:

- A redesigned command line interface
- Improved support for multiple outputs in notebooks
- Better handling of custom library versions in notebooks
- Support for custom pre-processors

Overall, version 2 of nbdev aims to make it easier for users to develop and maintain their projects based on Jupyter notebooks, and to integrate their work with other tools and workflows.

Hey ChatGPT: I am going to make the my_script.py in the above example an exported package from nbdev 2. Help me get started. I am currently in a folder called repos. I want to make a directory called majordaemo, cd into it and initialize it as a git repo and as a nbdev 2 repo. I already have nbdev pip installed. You can use the touch program to put files for the initial commit into location.

Sure! Here are the steps to get started with creating a new nbdev version 2 project in a folder called majordaemo:

1. Create the majordaemo directory and change into it:

```bash
mkdir majordaemo
cd majordaemo
```

2. Initialize the directory as a Git repository:

```bash
git init
```

3. Initialize the directory as an nbdev project:

```bash
nbdev_new
```

This will create the necessary files and directories for the nbdev project, including a settings.ini file that you can use to configure the project.

4. Create a file for the initial commit:

```bash
touch README.md
```

5. Add the files and make the initial commit:

```bash
git add .
git commit -m "Initial commit"
```

Now that you've initialized the majordaemo directory as a Git repository and an nbdev project, you can start writing Jupyter notebooks and converting them into Python modules that can be imported and used in other projects. To convert a Jupyter notebook into a Python module, you can use the nbdev_build_lib command. To build the documentation for your project, you can use the nbdev_build_docs command.

Hey ChatGPT: Make another example of the majordaemo .service file, but this time use the description "This is a Major Daemo". Also make it so that service Restart is set to always and RestartSec is set to 5.

Here is an updated version of the majordaemo.service file that includes a description and sets the Restart option to always and RestartSec to 5:

```bash
[Unit]
Description=This is a Major Daemo

[Service]
ExecStart=/usr/bin/screen -dmS majordaemo python /home/ubuntu/repos/majordaemo/my_script.py
User=ubuntu
WorkingDirectory=/home/ubuntu/repos/majordaemo
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
```

Here is an updated version of the majordaemo.service file that includes a description and sets the Restart option to always and RestartSec to 5:

Hey ChatGPT: Again, but add the group being the ubuntu group and rename my_script.py to majordaemo.py and make the python executable come from an absolute path in a virtualenv named py311 in the /home/ubuntu/ directory.

Here is another updated version of the majordaemo.service file that specifies the group as the ubuntu group, changes the name of the script to majordaemo.py, and specifies the location of the Python executable from a virtual environment:

```bash
[Unit]
Description=This is a Major Daemo

[Service]
ExecStart=/usr/bin/screen -dmS majordaemo /home/ubuntu/.virtualenvs/py311/bin/python /home/ubuntu/repos/majordaemo/majordaemo.py
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu/repos/majordaemo
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
```
With these updates, the majordaemo.service file will run the majordaemo.py script in a detached GNU screen session, and it will always attempt to restart the service if it fails, with a 5 second delay between each restart attempt. Additionally, the User and Group options specify that the service should be run as the ubuntu user and the ubuntu group, respectively. The location of the Python executable has also been updated to reflect the path to the python binary within the py311 virtual environment.

---

Alright, now just me on my own without ChatGPT:

    cd /etc/systemd/system
    sudo vim majordaemo.service

Now go into insert mode and paste the code from above into the .service file. I
fix the .virtualenvs path because I keep my venv's right in my home directory.

Okay, so that majordaemo.service file can just sit there for awhile. It doesn't
do anything until we enable it, which isn't worth doing until there's files in
the locations that it's pointing to.

Hey ChatGPT: I want to create that /home/ubuntu/repos/majordaemo/majordaemo.py file that checks a gmail email account through IMAP, checking all unread messages and turning them to read. I have login credentials through an Application Password issued by Google.

Here is an example of a Python script that checks a Gmail email account through IMAP and marks all unread messages as read:

```python
import imaplib

# Gmail IMAP server information
imap_server = "imap.gmail.com"
imap_port = 993

# Gmail login credentials
username = "your_gmail_address@gmail.com"
password = "your_application_password"

# Connect to the Gmail IMAP server
imap = imaplib.IMAP4_SSL(imap_server, imap_port)
imap.login(username, password)

# Select the inbox folder
imap.select("inbox")

# Search for all unread messages
status, messages = imap.search(None, "UNSEEN")

# Split the messages into a list
message_list = messages[0].split()

# Loop through the list of messages and mark them as seen
for message in message_list:
    imap.store(message, "+FLAGS", "\\Seen")

# Close the connection to the Gmail IMAP server
imap.close()
imap.logout()
```

This script connects to the Gmail IMAP server and logs in using the specified username and application password. It then selects the inbox folder and searches for all unread messages. The unread messages are then marked as seen by setting the Seen flag. Finally, the script closes the connection to the Gmail IMAP server and logs out.

Note: You will need to replace the username and password variables with your own Gmail address and application password, respectively.

Hey ChatGPT: Can you give me another script to toggle all the emails back to unseen so that I can repeat the above test?

Sure, here is a script that toggles all the messages back to unread:

```python
import imaplib

# Gmail IMAP server information
imap_server = "imap.gmail.com"
imap_port = 993

# Gmail login credentials
username = "your_gmail_address@gmail.com"
password = "your_application_password"

# Connect to the Gmail IMAP server
imap = imaplib.IMAP4_SSL(imap_server, imap_port)
imap.login(username, password)

# Select the inbox folder
imap.select("inbox")

# Search for all messages
status, messages = imap.search(None, "ALL")

# Split the messages into a list
message_list = messages[0].split()

# Loop through the list of messages and mark them as unread
for message in message_list:
    imap.store(message, "-FLAGS", "\\Seen")

# Close the connection to the Gmail IMAP server
imap.close()
imap.logout()
```

This script works in a similar way to the previous one. It connects to the Gmail IMAP server, selects the inbox folder, and searches for all messages. All messages are then marked as unread by removing the Seen flag. Finally, the script closes the connection to the Gmail IMAP server and logs out.

As with the previous script, you will need to replace the username and password variables with your own Gmail address and application password.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/like-microsoft-always-said-try-to-put-a-bing-in-the-universe/">Like Microsoft Always Said, Try To Put a Bing In The Universe</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/figure-out-why-vim-journaling-is-an-asset/">Figure Out Why vim Journaling is an Asset</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/gnu/'>GNU</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li></ul>