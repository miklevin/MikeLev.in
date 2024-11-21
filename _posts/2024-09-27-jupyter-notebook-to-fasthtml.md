---
title: Forking a Flake of Infrastructure as Code
permalink: /forking-flake-infrastructure-as-code/
description: I've finally cracked the code to a truly portable and reproducible development environment using Nix flakes!  It was a wild ride wrestling with different technologies, but Nix was a lifesaver for managing dependencies and keeping things consistent across my Linux and Mac machines.  I even found a way to seamlessly integrate AI-assisted coding tools like Cursor AI and Jupyter AI into the mix.  The real kicker was building a FastHTML web app that taps into the Botify API – talk about a learning curve with that BQL language!  But hey, who needs sleep when you're riding the wave of efficient and cutting-edge development?
layout: post
---

Here's a refined version that maintains your voice while toning down the corniness:

---

## Finding Timeless Foundations in Linux Development Is Key

I used to feel unmoored, but now I’ve found my footing. My goal is simple: to
create a foundation that’s always there when I need it—an infinite
infrastructure I can fork whenever, for any project, in any field, at any time.
Forget about AI making you obsolete—AI still needs something to run on, and
Linux isn’t going anywhere. Everything that goes into building a Linux system is
about as close to timeless as you can get. But it's easy to get lost in the
weeds, endlessly tweaking things. As Joel Spolsky warned back in 2001, you don’t
want to become an [architecture
astronaut](https://www.joelonsoftware.com/2001/04/21/dont-let-architecture-astronauts-scare-you/)—drifting
away from practical problems and losing sight of what you’re really trying to
build.

## The Concept of Forking in Software Development Raises Assumptions

So I've spent long enough on building the foundation. Pipulate is a good
portable home. And as such, it's designed to be cloned, but not necessarily
forked. I call it forking for the concept closely aligns, but everyone working
with such systems has to struggle with how much of your templates should be
inherited from some Platonic unchanging parent object, and how much should be
fresh new custom code every time. It's all about assumptions. The more
assumptions you make, the briefer the code, but the harder it is to customize.

## Creating a Simple Master Template for Pipulate Nix Flake

The Pipulate Nix Flake got pretty long, but it's time to put a fork in it. It's
done. Oh, I'll tweak it over time. But it works, and it's short enough to not do
some complex inheritance system, or even be a real fork for that matter. For
those not into such things, forking in the `git` ecosystem has a special
meaning, maintaining a history of what projects were derived from what, even if
they radically diverge. But in this case, I don't even want that level of
connection. I want to chip off a flake, and if I look back, it will be to update
as short a master template as I possibly can.

Let's do it...

```bash
[mike@nixos:~/repos]$ git clone http://github.com/miklevin/pipulate botifython
Cloning into 'botifython'...
[gobbledygook removed]
Resolving deltas: 100% (82/82), done.

[mike@nixos:~/repos]$ cd botifython/

[mike@nixos:~/repos/botifython]$ rm -rf .git

[mike@nixos:~/repos/botifython]$ git init
Initialized empty Git repository in /home/mike/repos/botifython/.git/

[mike@nixos:~/repos/botifython]$ git add flake.nix requirements.txt server.py ollama_check.py

[mike@nixos:~/repos/botifython]$ git commit -am "First commit"
[master (root-commit) 7e94a3b] First commit
 5 files changed, 333 insertions(+)
 create mode 100644 flake.nix
 create mode 100644 ollama_check.py
 create mode 100644 requirements.txt
 create mode 100644 server.py
[mike@nixos:~/repos/botifython]$
```

Allright. That's everything necessary to do webdev work in this local directory.
Now, let's hydrate this location...

```
[mike@nixos:~/repos/botifython]$ nix develop
warning: Git tree '/home/mike/repos/botifython' is dirty
warning: creating lock file '/home/mike/repos/botifython/flake.lock': 
• Added input 'flake-utils':
    'github:numtide/flake-utils/c1dfcf08411b08f6b8615f7d8971a2bfa81d5e8a?narHash=sha256-X6rJYSESBVr3hBoH0WbKE5KvhPU5bloyZ2L4K60/fPQ%3D' (2024-09-17)
• Added input 'flake-utils/systems':
    'github:nix-systems/default/da67096a3b9bf56a91d16901293e51ba5b49a27e?narHash=sha256-Vy1rq5AaRuLzOxct8nz4T6wlgyUR7zLU309k9mBC768%3D' (2023-04-09)
• Added input 'nixpkgs':
    'github:nixos/nixpkgs/759537f06e6999e141588ff1c9be7f3a5c060106?narHash=sha256-KQPI8CTTnB9CrJ7LrmLC4VWbKZfljEPBXOFGZFRpxao%3D' (2024-09-25)
warning: Git tree '/home/mike/repos/botifython' is dirty
 ____  _             _       _       
|  _ \(_)_ __  _   _| | __ _| |_ ___ 
| |_) | | '_ \| | | | |/ _` | __/ _ \
|  __/| | |_) | |_| | | (_| | ||  __/
|_|   |_| .__/ \__,_|_|\__,_|\__\___|
        |_|                          
Welcome to the Pipulate development environment on x86_64-linux!

- Checking if pip packages are installed...
- Done. 171 pip packages installed.
- Checking if numpy is importable...
- numpy is importable (good to go!)

- Start JupyterLab and FastHTML server with: start
- Stop JupyterLab and FastHTML server with: stop
- To exit the Pipulate environment, type 'exit' twice.

Checking Ollama connectivity...
Ollama says: Using model: llama3.1:latest
"Prepare to pipe down the population... but only if you're ready to pipulate, that is!"

Learn more at https://pipulate.com <--Ctrl+Click
(.venv) [mike@nixos:~/repos/botifython]$
```

## Creating Private Botify API Repository on Mac and GitHub

Okay, this should be fully working on the Mac as well, and I want to get that
out of the way early, so I'm going to make it into a new private GitHub repo.
This will be an example of how this system can be used to make private,
proprietary stuff. Shhh! Maybe I'll make the repo public, but I'm going to be
loading it with a lot of Botify stuff. But I'm thinking that's actually okay,
because we would probably ***like*** more of the public to know how to use the
Botify API. Anyway, I go to GitHub, make a `botifython` private repo

So I go to the GitHub website and select `New Repository` and give it the exact
`botifython` name as used in the `git init` command above, switch it to a
private repo, and click the `Create Repository` button.

At this point, we want to make sure that `HTTP | SSH` under **Quick setup** is
set to SSH, then we can copy these three lines to execute into our command-line
Terminal:

```bash
git remote add origin git@github.com:miklevin/botifython.git
git branch -M main
git push -u origin main
```

When pasted into our terminal, which you can now see has activated a Python
virtual environment due to the `(.venv)` prefix on the prompt, it pushes this
new repo up to Github, connecting it to our local copy...

```bash
(.venv) [mike@nixos:~/repos/botifython]$ git remote add origin git@github.com:miklevin/botifython.git
git branch -M main
git push -u origin main
(.venv) [mike@nixos:~/repos/botifython]$ (.venv) [mike@nixos:~/repos/botifython]$ Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 48 threads
Compressing objects: 100% (7/7), done.
Writing objects: 100% (7/7), 4.44 KiB | 2.22 MiB/s, done.
Total 7 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To github.com:miklevin/botifython.git
 * [new branch]      main -> main
branch 'main' set up to track 'origin/main'.
(.venv) [mike@nixos:~/repos/botifython]$
```

## Using SSH Protocol for Seamless Git Collaboration Between Platforms

So I've now made a new git repo called botifython, tested it on my local
(Linux) machine, pushed it back up to GitHub, and now I'm going to pull it down
on my work Macbook to make sure it's portable between platforms. A huge priority
with this work is to make it shareable with my coworkers, most of whom use Macs.
But as opposed to the HTTP protocol when I cloned pipulate knowing I was going
to disconnect it from the original repo, I'm going to pull down botifython on my
Mac using the SSH protocol. This approach is often baffling to new git/GitHub
users, but with your keys set up correctly, this is the way to eliminate the use
of passwords.

    git clone git@ghithub.com:miklevin/botifython

And now I have a `botifython` folder on my Mac. I `cd` into it and type `nix
develop`...

```bash
cd botifython
nix develop
```

...and on the Macbook just like on Linux, the Nix Flake builds, the pip
installable packages are all installed, connectivity to the local Ollama LLM
ChatBot server is tested, and the Pipulate startup messages all print out.

## Mac Browser Startup Issue Resolved with Restart and Replication

When I typed `start`, it didn't open the browser and tabs automatically, but I
had just restarted my system and had been completely quit out of everything.
After starting a browser and typing `start` again (it's okay to start multiple
times), it worked! So I've got a little Mac nuance here to work out, but it's
low priority and satisfying the 80/20-rule. I now have a private botifython repo
cloned from pipulate and it works correctly on the Mac, serving both Jupyter
Notebooks and running a FastHTML server.

## How to Close the Terminal Window in Mac JupyterLab

Now here's where it gets really weird and heady. A lot of people don't like that
command-line Terminal window hanging around. And you actually can close out of
it, either by clicking out from the window's close gadget, or by typing `exit` a
few times. On the Mac, it generally forces you to click the edit gadget anyway,
but point being that even when it's gone, JupyterLab and FastHTML are still
running in your browser. And if you lose those tabs, you can always get them
back by visiting...

- http://localhost:8888 (for JupyterLab)
- http://localhost:5001 (for FastHTML)

## Using Nix Flakes with Botifython and Python Virtual Environment

Now here's where it gets really awesome. These kooky nix flakes that make such
environments portable, you'd think are somehow disconnected from the rest of the
host system, but they're not. Because a standard Python virtual environment is
being used, which is a ***very common standard*** that IDEs expect to find in
workspace folder, you can open the botifython folder in a popular modern text
editor, such as Cursor AI which is very popular right now, and it will connect
to that Python `.venv` it finds there, and when you try to run Python code, it
will use the correct Python interpreter and have access to all the pre-installed
pip packages. And now you will have the AI coding assist of Claude 3.5 Sonnet
(as of this writing), even while using an off the beaten track interoperability
tool like Nix Flakes. It's the best of all worlds.

## Using JupyterLab Offers Free Access to LLM Code Assistance

Now if you don't use your own text editor and want that AI code-assist, for free
even, it's built into JupyterLab. If you start a new Notebook in JupyterLab from
your web browser, you will find that it is already connected to your local LLM
if you're running Ollama. If not, it's just a configuration setting, and you get
Jupyter AI free in the Notebook. So you can bring your own favorite AI-enabled
editor, or you can use the generic Project Jupyter stuff that ships with the
flake.

## Switching to Mac for Work While Maintaining NixOS Skills

Okay, so now I'm actually going to switch to working directly on the Mac. I love
my day-to-day NixOS Linux machine, and I work on it as much as I can to make
sure I'm not coding vendor dependencies into my processes. But my coworkers are
going to be on Macs all the time, and I want to remain empathetic to their
experience and not introduce any Mac-exclusionary bugs.

## Experimenting with Cursor AI for Creative Writing Assistance

I also want to experiment with Cursor AI as much as possible. It's lead won't
last forever, but right now it has an interface that's better than the other
platforms I've tried in a very nuanced way. It uses those red and green
add/remove highlights that look like a git diff, and that makes all the
difference. It's subtleties like that which makes AI either a force multiplier
or a copy/paste context correlation nightmare. Sure, other platforms will
reproduce that nuance in time, but for right now, I'm going to jump on the
Cursor bandwagon and pay the $20 for a month or two if I run out of Claude 3.5
Sonnet completions.

## Living in Two Editors with Pipulate Derived Botifython Project

And so with this Pipulate derived Botifython project, I will be living in two
editors. I'm migrating stuff from Jupyter Notebooks that I run in JupyterLab, so
I will allow that to keep running. But because Cursor AI is a sort of IDE with
its own display of the terminal, I don't want `python server.py` running from
`start`. So on the Mac, I'm going to re-open a Terminal (I closed out of it to
test that I could), I'm going to...

```bash
nix develop
stop
jupyter lab
```

## Using Multiple JupyterLab Tabs on Mac Browser Is Not Error

So now I have 2 JupyterLab tabs in my Mac browser, but that's fine. They're both
connected to the same server in the background. You can tell because they both
connect to `localhost:8888`. When you accidentally spin up multiple redundant
servers like Jupyter, they tend to increment the port number, so I would see
8889 on one of them. I don't, so I know I did it correctly. I close on of the
tabs.

## Running Jupyter Lab Requires Terminal Window Keeping Open Always

It's also important to note that because I started it with `jupyter lab` instead
of `start`, it's not running invisibly and disconnected from a terminal in the
background, and I therefore have to keep the terminal window open for Jupyter to
continue to run. I can minimize it. Or I can watch the terminal output for
interesting information.

## Running FastHTML Server from Inside Cursor AI Text Editor Successfully

If you still have a tab open to `localhost:5001` for FastHTML, a refresh on the
tab will show you that `This site can't be reached`, which is fine. We only
re-started Jupyter at this point, and we want to prove to ourselves that
`server.py`, which is FastHTML, can be run from inside the Cursor AI text
editor. For that, you just go into Cursor and assuming you already opened the
git repo folder, `botifython` in my case but `pipulate` in your case if you're
following along, you can just click on `server.py` to open it in a tab then
click `Run`. A refresh on your `localhost:5001` tab should result in the return
of the FastHTML Hello World page.

And so we are in a good starting point. We can load Jupyter Notebooks into
JupyterLab in our browser, such as old Notebooks we plan on turning into Web
apps, and we can turn them into the web app by copy/pasting from the Notebook to
the Cursor AI editor.

Again, it's the best of all worlds.

## Installing Pip Requirements for Reproducible Research Environments

If I have to `pip install` requirements from the old Notebooks, I can do that
from the command-line Terminal. I just have to remember to add it to
`requirements.txt`, which is already in the git repo, for reproducibility. The
next time the repo is hydrated with `nix develop` on some other machine for
example, the new requirement will be included.

## Using Nix for Flexible Data Science Workflows in Python

This allows you to be in flexible ***Data Scientist*** mode, where you `pip
install` willy nilly, doing whatever it takes to get your app running. But then
it's also getting shaped into a nice reproducible package as you go, if you
update the `requirements.txt` file. This is not precisely the way Nix is
intended to work as it is pedantic about pinning versions, it's a compromise I
struck so that data science workflows with lots of ad hoc pip installs is easy.

## Managing Pip Version Conflicts in Python Projects Is Complicated

If this looser pip venv workflow ever works against you because of pip version
conflicts, version numbers can either be pinned in the requirements.txt file
itself, or a switch to a Python requirements management package called `poetry`
can be done. This is supposed to be possible, blending the compatible missions
of nix and poetry with `poetry2nix`. But that all gets too complicated for me.

## Using Nix Flakes Simplifies Python Package Management

Finally, the nix packaged version of each pip program (a vast amount do exist)
can be used directly in the `flake.nix` nix flake file beautifully centralizing
everything as nix had intended, but all the Python virtual environment stuff
would need to be turned off. The nix way and the pip way are diametrically
opposed, and you can't mix-and-match pix packages from the nix and PyPI repos.
You have to commit to one way or the other. While I use nix flakes to distribute
the infrastructure as a file, I use pip for all PyPI package management under a
Python virtual environment. It's like buying your home and leasing your car.

## Mastering BQL for Faster FastHTML Development and Success

Fast-forward to after an incredibly focused many hours. I have my first FastHTML
minimum viable product app done. Wow, amazing! Anyway, it's clear to me that I
need a better mastery over the BQL language that Botify uses. So what I'm going
to do is create a blog post dedicated to that.


