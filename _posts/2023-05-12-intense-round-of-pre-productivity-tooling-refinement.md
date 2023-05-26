---
date: 2023-05-12
title: Intense Round of Pre-Productivity Tooling Refinement
headline: "Refining My Pre-Productivity Tooling: A Journey of Iterations and Refinements"
description: I'm refining my pre-productivity tooling with intense focus. I'm observing, enumerating errors, and writing down clues to help me find the right place in my code. I'm curling and copying, and experimenting with new techniques to get the script to function properly. After many iterations, I'm ready to take a break and attend an art exhibit in New York City. I'm also exploring ways to keep WSL from going to sleep in the background.
keywords: Intense, Round, Pre-Productivity, Tooling, Refinement, Abstract, Opposition, Countermeasures, Observe, Enumerate, Concrete, Facts, Unassailably, Legit, Clues, Open, Mind, Errors, Install, Script, Systemd, Cloud, WSL, Root, Sudo, Man, sudo_root, Symlink, multi-user.target.wants, j
categories: journaling, python, systemd, wsl
permalink: /blog/intense-round-of-pre-productivity-tooling-refinement/
layout: post
---



When you start to feel guilty about your path and your mind starts to stray, it
means that the ***abstract*** opposition to your path has mobilized and you
have to deploy countermeasures.

Think! That's where we go "next step?" 1, 2, 3... 1? Observe. Enumerate. Zero
in on the concrete facts, the unassailably legit clues that are sure to about
if you just open your mind to... mind to... mind to...

Enumerate the errors. Yup. Write them down, or at least transpose them to slap
that those myopia-inducing blinders on the right place in your code.

Well, here are my current errors in the install script. So much is going right.
So close, but just got to nail this anti-systemd cloud that hangs over WSL.

ERROR 1:

    The operation completed successfully.
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.

You must be silenced!

ERROR 2:

    Created symlink /etc/systemd/system/multi-user.target.wants/jupyter.service → /etc/systemd/system/jupyter.service.
    System has not been booted with systemd as init system (PID 1). Can't operate.
    Failed to connect to bus: Host is down

Come on systemd, where are you? You've got some work to do now. You're not
fooling me, cause I can see, config files will deliver.

ERROR 3:

    wsl: Unknown key 'boot.systemd' in C:\Users\mikle\.wslconfig:2
    wsl: Unknown key 'boot.vmIdleTimeout' in C:\Users\mikle\.wslconfig:3
    wsl: Unknown key 'automount.options' in C:\Users\mikle\.wslconfig:5

Huh? ChatGPT, you lied to me. You said that .wslconfg used the same format as
/etc/wsl.conf. At least I know where to look.

Okay, the `.wslconfig` file is in location `C:\Users\%USERNAME%\.wslconfig` and
generating errors, so that's a good thing. However, the `/etc/wsl.conf` file is
not in location, so I've got to address that first. 

I replaced a command-line output redirection trick I was using to create it
with a file copy and a lot can go wrong on the first try.

See, all the original scripting stuff had been broad strokes and fast passes.
I've got the whole thing fleshed out so well now, and it's time to take out the
scalpel. I curl and copy, and this should leave a trail:

```bat
curl -sL -o %USERPROFILE%\repos\transfer\wsl.conf "https://raw.githubusercontent.com/miklevin/drinkme/main/wsl.conf" >nul 2>&1
wsl -d Ubuntu-20.04 -u root -e cp %USERPROFILE%\repos\transfer\wsl.conf /etc/wsl.conf >nul 2>&1
```

Well, Scoob. It turns out the errors were just your stupidity all the time. But
come on, don't be too hard on yourself. What these scripts are pulling off is
nothing less than miraculous. I was just confusing the context of what is in
Windows-side context with what is in Linux-side context. That and the
Windows-side .wslconfig doesn't seem to support any of the keys I need so while
keeping the file, I edited out every line.

I think I've got it. May iterations. Many iterations. Many iterations.

Woot! Adam Edwards, one of the most important people in my life just reached
out to me. I'll be attending an art exhibit he's putting on this Tuesday in New
York City.

Wow, what an intense day. One of the most important articles of my life
written. I really have to get to Midjourney soon, given that it takes URLs as
input, that will really help me turn even my ASCII diagrams into polished
rendered art.

And this post now went into the weekend. Got driven to Friday night in refining
the install script with rapid incremental refinements. Don't drive yourself
sick. Get good messaging in on the script, especially encouraging people to
refresh the system often. I should do a pip freeze every time they do so I can
get their after-install pip installs back after the big refreshes. I can use
Python set functions to make it only those things that aren't in the original
requirements.txt.

Also take advantage of that long initial wait to explain what's going on. 

Maybe also allow the output of apt_install.sh to show.

Maybe do that collective redirection trick so I can globally toggle verbose
output on and off as a debug mode.

So many little touches! But the most important one is to keep WSL from going to
sleep in the background. I went to sleep before I could do that one, and woke
up and am here writing this, haha! So cut this entry and make that the subject
of a whole new post, because it deserves it.

But first! Figure out how to change your title without re-invoking OpenAI API
queries. So we look at the latest entry in each db:

```python
from sqlitedict import SqliteDict as sqldict

for adb in ["headline", "description", "keywords"]:
    dbfile = f"/home/ubuntu/repos/MikeLev.in/_data/{adb}.db"
    print(dbfile)
    with sqldict(dbfile) as db:
        for key in db:
            ...
        print(key)
```

Now we simply set a new key, create a new record and delete the old. I should
figure out how to make the system formally support this. Changing keys? Two
keys for a old/new sync? Rabbit hole. Not for today. Be glad this sort of thing
is so friggin easy in Python.

```python
new_key = 'intense-round-of-pre-productivity-tooling-refinement'

for adb in ["headline", "description", "keywords"]:
    dbfile = f"/home/ubuntu/repos/MikeLev.in/_data/{adb}.db"
    print(dbfile)
    with sqldict(dbfile) as db:
        data = db[key]
        db[new_key] = data
        del db[key]
        db.commit()
```

Now to update the YAMLchop file, I simply... ugh, I see now that honestly I
could have just updated the already committed-out (to text file) OpenAI output
in the YAML file and it just would have fixed it. I don't REALLY need to fix it
in the database as well. Even keeping that data in a database after the
yamlification is completely optional.

















<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/are-you-jacked-into-the-metaverse-or-living-in-flatland/">Are You Jacked Into the Metaverse or Living in Flatland?</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/down-down-down-would-systemd-going-down-under-wsl2-never-come-to-an-end/">Down, down, down! Would systemd going down under WSL2 never come to an end?</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li></ul>