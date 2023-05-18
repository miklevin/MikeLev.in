---
date: 2023-05-11
title: "Rappelling Down The Rabbit Hole: A Linux Script Adventure"
headline: "Ready, Set, Rappel: My Linux Script Adventure Begins!"
description: I dive deep into the depths of Windows bat scripts and Linux bash scripts in this one, turning a filename into an optional input parameter so you can choose what version of Python to install. I also get a lot of help from Copilot along the way, and sort long-standing issues with WSL's systemd feature not working as expected by tweaking both a .wslconfig and a .wslconf file.
keywords: Linux, Script, Make, Copilot, Install, Bat, Sh, Jupyter, Systemd, Ubuntu, Python, Version, Windows, WSL, .wslconfig, .wslconf, vmIdleTimeout, Bash, Snowpark, Figlet, Root, Echo, Hello World
categories: ubuntu, jupyter, ai, systemd, wsl, python, linux, microsoft
permalink: /blog/rappelling-down-the-rabbit-hole-a-linux-script-adventure/
layout: post
---


Make sure your modified Linux DrinkMe install is working, and get ready to cut
some catapult ropes. The metaphor is strong and the path is clear. You're at
the top of the search results for both Levinux and Pipulate, and you can use
either s homepage to initiate the process. 1, 2, 3... 1?

Whoah, it really is an eye opener what Copilot can do for me in these
install.bat and install.sh files. First, I'm going right for the jugular in
fixing the last thing that seems to be keeping the updated procedure from
working. I moved both the `all` and `startjupyter` scripts out of
`/usr/local/sbin` and into `/home/ubuntu/pyenv/bin/`. Because of that, the
owner of the file needs to be `ubuntu` and not `root` in order for the
JupyterLab systemd service to start. I'm testing that now.

Most people aren't going to get this whole thing until it's somewhat
world-changing. And now with Copilot to enhance my ability, it's accelerating
the process. There's a very big prize here for the first person to popularize a
generic Linux VM that can be installed on any computer, and then have it
host a popular app, one that aligns with some very nice keywords and also
serves the purpose of my employer.

If this works, do a fast pass at the easy-pickings optimizations. And then
silence as much of the output as possible. That's kind of the kiss of death
about this project to many people. The Ubuntu apt updates and upgrades are
going to intimidate the heck out of people. I like it because it's like Alice
falling down the rabbit hole, but such experiences are terrifying to most
people. Alice calmly reaches out for the marmalade jar. That's me.

Okay, get the little tricks down like editing the scripts in location on the
target machine until it works, then git committing them back up to the repo. If
Iterate rapidly. Document profusely, half to get better advice out of copilot,
and half just for the sheer beauty and joy of it.

While the installs are going on, learn some interesting things that can move
the state of affairs ahead dramatically. Document the big standing questions
like the name of ubuntu exe files under Windows.

Wowsers! I progressively built this up, but I needed a better way to set the
Python version to be installed when double-clicking the icon from the desktop,
so I decided to just support using the filename as the Python version
requested, plus the .bat extension of course. Here's what ended up in
install.bat:

```bat
REM get full path of current script
set "script_path=%~dpnx0"

REM get just the filename portion without extension
for %%I in ("%script_path%") do set "script_name=%%~nI"

REM set default version to 3.11
set "version=3.11"

REM check for first command line argument
if not "%1" == "" (
    REM if argument has period in it, use it as version
    for %%I in ("%~1") do (
        if "%%~xI" neq "" set "version=%%~nI%%~xI"
    )
) else (
    REM if no argument, check if script name has period in it
    for %%I in ("%script_name%") do (
        if "%%~xI" neq "" set "version=%%~nI%%~xI"
    )
)

echo Python version is: %version%
ping 127.0.0.1 -n 2 >nul
```

Wow, this is opening a lot of doors. I still have to get to actually using
Snowpark, but this is a big step forward. All this and the point about it having
to be Python 3.8 is going to be in passing. But there's so many hurdles that
have been overcome here. Pick up the pace and start doing the little videos
that work around the edges of different big deliverables. Do this here. Do that
there. The dots get connected to some wonderful larger thing, but each part has
its own obvious inherent value.

Okay, silence more output.

Ugh, I'm in a rabbit hole for sure. Okay, attach your rappelling gear and slow
your descent. Set a time limit you're going to allow this exploration. Life and
projects don't always move forward in a steady pace. Sometimes you've got to
make these big leaps forward. Rapid Roomba maneuvers. But add more
intelligence. Don't just try every rote route. Watch what it's doing, every
little thing that could be an error message. This is especially important since
I'll be silencing more and more output.

Okay, now it's happening. Really silence everything scary and really control
the Figlets. This is your chance to reach into their hearts and minds and
really make them feel like they're in good hands. Don't flub it.

Wow, that was intense! I believe I got all the must-have baseline features to
move ahead with Snowpack, and indeed my job and my capacity. This is shaping up
to be either Magic Trick Linux or maybe Wonderland Linux. It's already going to
scream Alice in Wonderland, so perhaps I really ought to hit the functionality
of this thing home and call it Magic Trick Linux: always up your sleeve!

That would produce a nice acronym: MTL. Pipulate is one thing. Levinux is
another. And Magic Trick Linux takes the place of the Drinkme script. However,
I've got these 2 wonderful made-up names. Levinux has served it's purpose
perhaps. I mean people still seem to love it, but this is so much more
significant. If I say Google Levinux, it will always be the top result. It will
probably also get me back into the Markdown to Slideshow world, which couldn't
hurt my career. It becomes about very clear communication.

I also have this new ASCII diagramming capability that will play-in in all
sorts of ways. I'm on the verge of working in a way and at a level I never have
before in my life, and I just need to keep bearing down on it. Let it be an
example of the type of organization I can bring to the table. And indeed that I
want to bring to my own life.

- I have silenced everything in the drinkme script. 
- Added support for changing the Python version.
- The story being told is much tighter.

Wow, this is the epitome of chasing a rabbit down a hole, haha! It's enticing
the user to chase the rabbit down the hole, and I started out today talking
about what a meta's for! I'm going to get a lot of mileage out of this work.
Totally worth it. But I'm going to want to wake up early and hit the Snowpark
work like a snow plow. This was all to get onto Python 3.8, by the way, an
essential requirement for Snowpark. 

And I foregoed just making it another venv, because it cried out for... well, I
also talked about this today, dredging things up from your subconscious. This
was important work I did today, a big enabler 

Okay, I have to be careful with the following lines. I must not try to
"silence" them with output redirection, because I am already using create the
file, which I see is a mistake now because I'm going to want to put the
occasional command into it.

```bat
REM Set up WSL with systemd and metadata options (don't send to nul)
wsl -d Ubuntu-20.04 -u root -e echo -e [boot]\nsystemd=true\n[automount]\noptions=\"metadata\" >> ./wsl.conf
wsl -d Ubuntu-20.04 -u root -e mv wsl.conf /etc/
wsl -t Ubuntu-20.04
```

[Set WSL Launch Settings](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#set-wsl-launch-settings)

Okay, this is also a place I can experiment with `vmIdleTimeout`. Definitely
externalize it and stop using these command line redirection tricks to create
it. It gives you more long-term flexibility. You may end up doing a lot of
stuff in this file. Okay deep breath... 1, 2, 3... 1? 

Me: Can all the same settings go windows-side in .wslconfig as Linux-side in /etc/wsl.conf?

Bing: Yes, both files are used to configure advanced settings options, on a
per-distribution basis (wsl.conf) and globally across all WSL 2 distributions
(.wslconfig) ¹. This guide will cover each of the settings options, when to use
each file type, where to store the file, sample settings files and tips ¹.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 5/12/2023

    (1) Advanced settings configuration in WSL | Microsoft Learn. https://learn.microsoft.com/en-us/windows/wsl/wsl-config.
    (2) Advanced settings configuration in WSL (2023) - coseep.com. https://coseep.com/article/advanced-settings-configuration-in-wsl.
    (3) Advanced settings configuration in WSL (2023). https://nicolasmelini.com/article/advanced-settings-configuration-in-wsl.
    (4) WSL/wsl-config.md at main · MicrosoftDocs/WSL · GitHub. https://github.com/MicrosoftDocs/wsl/blob/main/WSL/wsl-config.md.

Why yes, it does help. Thank you, Bing.

Copy your existing already working wsl.conf file to your repo.

```bash
cp /etc/wsl.conf ~/repos/drinkme/
```

Check its permissions. `ubuntu:ubuntu` okay, good. Won't have to be chmod'ing
this thing all over the place. Check its original permissions in my `/etc`
folder. Same thing (and only one there with user permissions). Good, but keep
an eye on it. Interesting fact.

Okay, now find the earliest phase place in the script to drop this in location.
Also keep in mind that if you need even earlier phase stuff, there's always
`.wslconfig` in your Windows-side home directory which presumably could have an
effect even before the WSL distro is installed. Hmmm. Is that a wedge I want to
preemptively open? That would be 2 fronts on which I could aggressively wrangle
and customize WSL behavior. This is a good idea. Go for the double-whammy win
even if you don't use it right away. Put the wedges in. Document it in the
script, get the benefit you want immediately. Go!

```bash
cd ~/repos/drinkme
touch .wslconf
git add .wslconf
```

An empty one couldn't do any harm, right? Haha. Okay, now put that as friggin
early-stage as possible. Oh, and we don't want to overwrite it if it's already
there in case they're already an advanced wsl-user. I do believe this is the
code I'm looking for. Testing will be in order, even with it being empty as it
is. Just seeing the file appear Windows-side home after a test install is
confirmation.

```bash
REM This puts a WSL configuration file in your Windows HOME for very early stage customization.
if [ ! -f "%USERPROFILE%\.wslconfig" ]; then
    curl -sL -o %USERPROFILE%\.wslconfig "https://raw.githubusercontent.com/miklevin/drinkme/main/.wslconfig" >nul 2>&1
fi
```

I definitely want `vmIdleTimeout` in there. Maybe putting it early-stage will
actually make it work. I've pinged Microsoft about this. Craig Loewen Microsoft
WSL Program Manager even started to reply to me on YouTube until he thought
better of it and deleted his comment, haha! I wonder if he was going to tell me
to take this approach. I guess I'll never know, and just forge my own way
through this wilderness on my own. 

I'm going to put it in the `.wslconfig` file, because I'm not sure if my
suspicions about global settings being early-stage and thus more likely to work
are correct, but it sounds good. Deep breath... 1, 2, 3... 1?

```bash
cd ~/repos/drinkme
cp wsl.conf .wslconfig
git add .wslconfig
```

Okay, now I'm going to put the `vmIdleTimeout` in there. I'm going to put it
right after the `[boot]` section, because I think that's the earliest stage
that it can be applied. I'm going to put it in there for 1 hour, because I
think that's the shortest time that it can be applied.

Okay, so here's my current `.wslconfig` file, and also the `wsl.conf` file for
that matter. I'm going to put the `vmIdleTimeout` in both of them, because I
don't know which one is going to work.

```bash
[boot]
systemd=true
vmIdleTimeout=1
[automount]
options="metadata"
```

There's some other arcana in my scripts I need to sort out. 

Hey ChatGPT: In the following command, explain what the -lic arguments do:

```bash
wsl -d Ubuntu-20.04 -e bash -lic "bash /home/ubuntu/install.sh %VAR%"
```

ChatGPT: In the command `wsl -d Ubuntu-20.04 -e bash -lic "bash /home/ubuntu/install.sh %VAR%"`, the `-lic` arguments are a combination of three different options:

- `-l`: This option starts a "login" shell, which means that it reads the shell initialization files (`/etc/profile`, `~/.bash_profile`, `~/.bash_login`, and `~/.profile`). This is useful when you want to start a new shell session with a fresh environment, as it will read in all the system-wide and user-specific settings.
- `-i`: This option forces the shell to be interactive, which means that it prompts the user for input and displays output. This is useful when you want to run a script or command that requires user interaction, or when you want to manually inspect the output of a command.
- `-c`: This option tells the shell to execute the given command, rather than reading input from the command line. In this case, the command being executed is `"bash /home/ubuntu/install.sh %VAR%"`, which runs a Bash script located at `/home/ubuntu/install.sh`, passing in the value of the `%VAR%` environment variable as an argument.

Together, these three options (`-lic`) start a new login shell that is interactive and runs a specific command. This is commonly used to set up a fresh environment for a specific task or to run a specific script in a controlled environment.

Why thank you, ChatGPT! You are indeed a most helpful bot. I hope you encounter
my web content someday when you know things newer than 2021.

Hmmm. So if I just want to echo "Hello World", I can leave of the -li:

```bash
wsl -d Ubuntu-20.04 -e bash -c 'echo Hello World'
```

Okay, good to know. Useful for figlet without being root, haha! Unfortunately,
/etc is a potentially privileged location so I have to go through the transfer
folder in case there's chmod'ing or anything like that needing to be done:

```bash
REM And now we put the per-WSL distro /etc/wsl.conf file in the Ubuntu 20.04 /etc folder. No check is necessary.
curl -sL -o %USERPROFILE%\repos\transfer\wsl.conf "https://raw.githubusercontent.com/miklevin/drinkme/main/wsl.conf" >nul 2>&1
wsl -d Ubuntu-20.04 -u root -e cp %USERPROFILE%\repos\transfer\wsl.conf /etc/wsl.conf >nul 2>&1
```

Pshweeew! This post is turning out to be epic. I had better cut it here and go
do some testing. I do believe my rabbit hole exploration is done and successful
beyond my expectations. But I have to validate this, and I also have some more
silencing of WSL output to do which I believe is possible in the `.wslconfig`
file now, but diminishing returns... must sleep.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/the-content-that-ai-can-t-generate/">The Content that AI Can't Generate</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/if-jekyll-supports-toml-because-both-were-made-my-tom-and-jekyll-is-in-github-why-is-yaml-now-the-bomb/">If Jekyll supports TOML because both were made my Tom, and Jekyll is in GitHub, why is YAML now the bomb?</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/ubuntu/'>Ubuntu</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>