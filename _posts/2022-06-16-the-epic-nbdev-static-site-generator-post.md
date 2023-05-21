---
date: 2022-06-16
title: The Epic nbdev Static Site Generator Post
headline: "Switching to Python Programs: Setting Up a Blog Release System with nbdev"
description: I recently downgraded from Ubuntu 20.04 to Ubuntu 18.04, which broke my blog release system. To fix this, I am switching from Unix Scripts to Python Programs, using argparse and the Python Standard Library to modularize my programs and make them work from the command-line with arguments. I'm learning about the subprocess API options, setting up a virtualenv and installing Python 3.10, creating a git repo, and writing a blog post.
keywords: Python, Subprocess, API, argparse, Standard Library, Unix/Linux, 80/20-rule, run() function, Popen, virtualenv, Python 3.10, git, repo, blog post, Pandas, dataframe, namedtuple, csv, pipe delimited, Bash, Jupyter Notebook, command line, settings.ini, continuous integration, fails, read() method, cd, echo, OS-independent, PowerShell, environment variables,
categories: linux, virtualenv, panda, powershell, python, git, jupyter, 80/20-rule
permalink: /blog/the-epic-nbdev-static-site-generator-post/
layout: post
---


This recent downgrading from Ubuntu 20.04 to Ubuntu 18.04 broke by blog release
system, Ugh! It's not that files were lost. It's that my paths subtly changed
and hardwired locations broke. And I don't particularly want to just bring it
back alive the way it was. I was already mixing Unix shell scripts (bash
scripts, technically) with Python programs and as such I should really commit
entirely to Python programs because they're ***much easier to read*** and
maintain. Nobody wants to have to code in bash script, which is why PERL became
so popular as the pee-in-the-pool sysadmin devops language of default Linux
installs, and now Python is taking over that role. Python is a Unix/Linux
system automation language. Face it and use it that way. Okay, 1, 2, 3... 1?

We want to switch from Unix Scripts to Python Programs, but we very much do not
want to give up the timeless Unix/Linux API. What do I even mean by that? I
mean the way \*nix operating systems let you execute programs with parameters,
arguments, switches and what-have-you with no muss and no fuss. They just run
from the command-line as invoked, and can thus be scheduled and even strung
together with the output of one program going into the input of another. It's a
huge part of what made Unix so great and the inevitable winner (albeit through
the Linux implementations) in the Operating System Wars. In case you haven't
noticed, \*nix OSes won... period. It's not even a qualified statement. Unix
and Linux won. Windows lost. Proprietary Mac lost. VAX lost. LISP lost. CP/M
lost. DOS lost. TOPS lost. The list of corpses goes on. Need I continue?

Unix/Linux won because it's API (application program interface) is best. This
is the part we do not want to lose when we adapt our blog release system from
bash scripts that naturally lean into the Unix-way to Python programs which may
or may not lean into the Unix-way. So how do we write our Python programs so
that thy are Unixy? Easy! We modularize them and make them work from the
command-line with arguments. We use argparse. We don't use Click and we don't
use DocOpt and we don't use Typer. We don't code in stupid dependencies outside
the Python Standard Library if we don't ***really need to*** based on the API
of the Standard Library alternative being good enough, per the 80/20-rule. That
means getting 80% of the benefit from the first 20% of the effort. And the good
old Python Standard Library argparse import does exactly that.

Okay, let's get some code down. When we start a project like this, we start
with bare-bones basics. The first code-sample should be an eternal principle
and as Elon Musk would say, first principles. What's first principles of
smushing Python programs into Unix-like interfaces? It's making sure we
understand how to execute Python code from a command-line interface, more
colloquially known as the CLI. Start saying CLI. It will serve you well. I came
from the Amiga Computer community and they knew that CLI was the correct
terminology for the API you're looking for. CLI is the API you're looking for.
You have to trust someone. I'm not trying to make any money off of you except
for the YouTube advertising bucks. I'm not trying to turn you into ***micro
soft sheep***. I'm the ***Better Pied Piper***. Trust me.

What are ***my principles*** in making this new content release system?

- Easy to read
  - Able to be run by-hand to diagnose
  - Reads in a sequential top-down fashion (beware of functions)
- Working off easy-to-maintain config file
  - Intuitively editable in vim with no special tools (no json!)

1, 2, 3... 1? The API for Python under \*nix looks something like this... get
examples. Beware! Everyone wants to run advertising in front of you. Go to the
genuine Python documentation first. Start from here:
[https://docs.python.org/3/](https://docs.python.org/3/)

From there, we can find [Python subprocess to run from terminal](https://docs.python.org/3/library/subprocess.html)
and start to learn about the general API options. There appear to be many
approaches and we need not leap into the first without a deeper look.

subprocess.run appears to be the first and obvious choice, but right at the
opening of the documentation it says:

> The recommended approach to invoking subprocesses is to use the run() function
> for all use cases it can handle. For more advanced use cases, the underlying
> Popen interface can be used directly.

This is very suspicious to me. Run accommodates the 80/20-rule they appear to
be saying, but in the same breath they're making us aware of subprocess.popen.
Let's look deeper! When we find subprocess.popen's introduction, it says:

> The underlying process creation and management in this module is handled by the
> Popen class. It offers a lot of flexibility so that developers are able to
> handle the less common cases not covered by the convenience functions.

There is also a big red warning here saying that for maximum reliability:

> For maximum reliability, use a fully-qualified path for the executable. To
> search for an unqualified name on PATH, use shutil.which(). On all platforms,
> passing sys.executable is the recommended way to launch the current Python
> interpreter again, and use the -m command-line format to launch an installed
> module.

Clearly a first step is going to be getting a virtualenv (or venv) set up again
at login. On the last video, I got the ~/github folder to be served from the
Windows-side which a huge step forward in path simplification and data security
(make sure OneDrive backs it up since you're paying for it anyway?).

The example they give is:

    Popen(["/usr/bin/git", "commit", "-m", "Fixes a bug."])

I know from doing a lot of this stuff in the past, I want to use Popen over Run
for maximum options. My needs get pretty particular as we get into it and
switching from the more limited Run API to Popen API is a pain, so we start out
with Popen. It's also worth noting that we keep the command-paths short by
doing the import like this:

    from subprocess import Popen

This provides the best compromise of "standard code" (not renaming Popen using
"as" on the import as is my temptation) and short, snappy commands (as opposed
to using subprocess.Popen() everywhere).

Ugh! I just realized as I'm getting ready to code, this is another one of those
cases of "Before I tell you ***that story***, I have to tell you ***this
story***. This story being that of venv and virtualenv, but before even that,
the story of Python 3.10 under Ubuntu 18.04 and perhaps of dead snakes.

Okay, deep breath! 1, 2, 3... 1? Try installing Python 3.10 directly from
Ubuntu. Do an update/upgrade first.

Okay, now try this without any Dead Snake PPA modifications:

    sudo apt install python3.10

Woot! It worked! Welcome to 2022! Oops, no, not at all! I actually got the
wrong thing installed. Delete and purge!

    healus@LunderVand:~$ sudo apt install python3.10
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    Note, selecting 'postgresql-plpython3-10' for regex 'python3.10'
    postgresql-plpython3-10 is already the newest version (10.21-0ubuntu0.18.04.1).
    0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.

Now I have to clean it up with:

    sudo apt --purge autoremove python3.10

Ugh okay, back to dead snakes.

    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:deadsnakes/ppa

And now we can:

    sudo apt install python3.10

Which shows me this (I should have read more carefully the first time):

    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    The following additional packages will be installed:
      libpython3.10-minimal libpython3.10-stdlib python3.10-minimal
    Suggested packages:
      python3.10-venv binutils binfmt-support
    The following NEW packages will be installed:
      libpython3.10-minimal libpython3.10-stdlib python3.10 python3.10-minimal
    0 upgraded, 4 newly installed, 0 to remove and 0 not upgraded.
    Need to get 5086 kB of archives.
    After this operation, 19.5 MB of additional disk space will be used.
    Do you want to continue? [Y/n]

I answered Y, and now an attempt to run Python 3.10 succeeds:

    healus@LunderVand:~$ python3.10
    Python 3.10.5 (main, Jun 11 2022, 16:53:29) [GCC 7.5.0] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>>

We exit out with the exit() function and move onto our venv or virtualenv step.
This is critical for "***locking us into Python 3.10***" everywhere under Linux
forever forward, until we change it deliberately.

There is also some ambiguity here as to whether the correct pip is installed
for getting Python packages from PyPI, but we will cross that bridge after we
set up our Python virtual environment.

The good news here is that the virtual environment manager, venv, is now built
into Python. We want to use the latest one from Python 3.10 (and not the
pre-installed under Ubuntu 18.04 Python 3.6 version) and to do that we can use
this command. I make sure I cd home because that's where I want to keep my
venv's:

    cd ~/
    python3.10 -m venv py310

...and I get the error:

    Error: Command '['/home/healus/py310/bin/python3.10', '-Im', 'ensurepip',
    '--upgrade', '--default-pip']' returned non-zero exit status 1.

Hmmm, I suppose I was mistaken about venv being built-in. I guess like pip you
have to ensure it's there. So I do this command:

    sudo apt install python3.10-venv

It succeeded and now this command:

    python3.10 -m venv py310

...worked. If I ls from ~/ I see:

    healus@LunderVand:~$ ls
    abouts.sh  all.sh  github  hps.sh  install.sh  py310
    healus@LunderVand:~$

And that's what I expect to see. I now have a virtual environment for Python
3.10 and I have to make sure it's activated all the time. I do that by editing
my .bash\_profile file.

We can activate our new venv on a 1-time basis to test it with:

    source ~/py310/bin/activate

Try it:

    healus@LunderVand:~/github/helpers$ source ~/py310/bin/activate
    (py310) healus@LunderVand:~/github/helpers$

Nice! It works with color coding and all.

I have an old .bash\_profile file but I'm going to establish a new one and
build it up with only what I need and to do that I'm going to cd into the
github repo where I back-up my .bash\_profile and load 2 files at once. This
will have the effect of making a new one in my home ~/ directory:

    (py310) healus@LunderVand:~/github/helpers$ vim .bash_profile ~/.bash_profile

And now I just navigate between the 2 files in vim and transpose over the line:

    source ~/py310/bin/activate

...into the new .bash\_profile file. It is the only line in the file currently.
Thankfully I can test it by just exiting out of the terminal and launching a
new terminal. Confirmed, it's working as expected but I do lose the nifty
Ubuntu color coding on the prompt. No big deal. There are ways to fix that but
me detects rabbit holes... at least for now.

Okay, so now back to the story of Popen and argparse.

Honestly, it should be simpler and the fact that it is not "in my fingers" yet
is an issue. It is a problem maybe with the Python standard library that has
made the APIs elude me, and maybe make these suitable. But before going on some
sort of 3rd party pip-installable scavenger hunt, see if you can't actually get

Okay, pshwew! Am I going to go with the blogslicer identity?

What is the criteria?

How is this going to work?

First and foremost, it should be nbdev-based so it has a duality life in both a
Jupyter Notebook and as a pip installable package. To that end, be sure that
you pip install nbdev.

    pip install nbdev

Wow, that installs a lot! And on its advice:

    /home/healus/py310/bin/python3.10 -m pip install --upgrade pip

Okay and this reminds me. We can add new kernels to... no, don't go that route.
That would be Windows-side Python installs. Stick with whatever version (for
now) that ships with Jupyter Desktop. But on the Jupyter Desktop-side, upgrade
all your pip packages... I have a notebook called pipulate.ipynb in the github
mlseo repo currently which does this. Run that. It won't get the Windows
Jupyter Desktop side and WSL Ubuntu 18.04 Python side exactly in sync, but at
least all the pip versions of everything will be the latest. Okay, done.

Check for held-back versions because of dependencies:

    Package Version Latest Type
    ------- ------- ------ -----
    h11     0.12.0  0.13.0 wheel
    mistune 0.8.4   2.0.2  wheel
    pip     22.1    22.1.2 wheel
    pywin32 303     304    wheel

Okay, next?

Are we going to make this part of the blogslicer package that already exists
and was created in exactly this way? Maybe... no. Keep the two things separate.
I know how to do this:

    pip install -e .

Let
...and that is a game changer! You just cd into that repo and type that. In the
case of Jupyter Desktop, you would use a Terminal from Jupyter when doing that,
or maybe even alternatively a Jupyter magic command right from a notebook (not
sure if this will work) such as:

    %pip install -e .

I may have to pip uninstall things before using this technique, but I should be
able to have a series of side-by-side repos, each of which is a different
command used in a Popen() managed set of Linux commands.

So I'm basically designing a series of separate Linux commands in Python, which
I'll invoke using the classic full-path and -m usage so that there's no
misunderstanding, fragility or required OS trickery (eliminating the extensions
like nbdev does).

I want to do this as quickly as possible to be "back in business" since I did
this Ubuntu downgrade that broke the old release system that was in desperate
need of an overhaul anyway. Take advantage of this situation.

This is really becoming an epic post. But what I'm trying to do is epic. A true
and righteous way of working. I can't wait to get Windows-side Jupyter Desktop
out of the picture. Soon I'll be on wslg... maybe. They either have to bring it
to Windows 10 or they have to make Windows 11 virtual desktop transitions work
as well as they do in Windows 10.

Okay, so we need a name for this. We already are using blogslicer. allsites?
Nice and simple and says what it does. ssg? ssites? Yeah, that's sounding short
and sweet. ssgites? skites? skite!

    mkdir skite

Ugh! I got sick of looking at the non-color-coded prompt in the Linux Terminal
after seeing it so much during my recent work. So I googled up this solution:
https://gist.github.com/insin/1425703

    PS1="${PYTHON_VIRTUALENV}${GREEN}\u@\h ${YELLOW}\w${COLOR_NONE} ${BRANCH}${PROMPT_SYMBOL} "

It works great! I also had to change the Terminal colors to Tango Dark, which
are awesome! And finally, I transposed over just enough of my old
.bash\_profile file for things to be comfortable:

    source ~/py310/bin/activate
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    cd ~/github/
    alias profile="vim ~/.bash_profile"
    alias systemd="cd /etc/systemd/system/"
    alias open="explorer.exe ."
    . ~/.bash_prompt

Nice. It's feeling like home again. I'm really excited about getting this
static site generation system (skite) going! 1, 2, 3... 1?

I made the skite folder. Really now it's time to do the nbdev stuff. Everything
I start out this way now is automatically also going to be an nbdev project.
And so it should start out as a public repo on Github... or should it? Isn't
that only for the integration hooks? It's got to at least be a git repo. So use
Jeremy's naming convention with a new notebook... one more 00\_core.ipynb!

Okay, one thing I'm pretty sick of is remembering to run nbdev\_clean\_nbs
every time before I do a git push. Nah, don't introduce another release script
yet. Just remember to do it. Okay, get this thing as a git repo and see if
nbdev\_new works in it.

You can't use nbdev\_clean\_nbs without there being a settings.ini. There's no
settings.ini until you run nbdev\_new. You can't run nbdev\_new until it's a
git repo. So you've got to put ***some file*** in there that doesn't have the
notebook metadata pollution problem. What? Foo! And then we can delete foo
later. Just touch foo.txt.

I'm using a better bash prompt that tells which git branch you're in. I may
change it. https://gist.github.com/miki725/9783474

Okay, I did a git init, git add and git commit. But nbdev\_new still needs a
remote.origin.url. Interesting! So nbdev doesn't work unless a repo is also in
a remote repository. Okay, fine. I'll github it... and done! Wow, this is
looking pretty:

![Color Coded Bash Prompt Python Venv Virtualenv Git Branch](/assets/images/color-coded-bash-prompt-python-venv-virtualenv-git-branch.png)

Friggin' wow! This is a brave new world. Keep forging forward. Lift the
techniques you're using in blogslicer and document them here in one super-long
blog post until you can release this! Very meta!

Okay the program has to take as input a sites.csv file. Keep it csv so there's
rigid rules about columns. It could also give decent pandas practice. Yeah,
practice pandas with this. It's overkill, but beautiful overkill.

Think! Get the nbdev trick going ASAP. To that end, load the 00\_core.ipynb
file from blogslicer. It's okay to have 2 files by this name loaded at once.
One informs the other. 1, 2, 3... 1?

![Git Repo Immediately After Nbdev\_new](/assets/images/git-repo-immediately-after-nbdev_new.png)

Alright, this is something that could be documented better on the interwebs. I
know it's going to be immediately dated, but so what. I am forging the way and
this has archival value. I wish I did it back in the day. I'd get so much
credit for all the ahead-of-its-time static site generator tech I innovated. So
be it. Do it now. Use the great SSG stuff out there to better effect.

Here's what a Jupyter Notebook looks like when you're taking your deep breath
in preparation for it to become a CLI command and a pip installable PyPI.org
package:

![Sprinkling In Nbdev Magic Fairy Dust](/assets/images/sprinkling-in-nbdev-magic-fairy-dust.png)

It's hardly worth git committing it and all at this point, but I will for
posterity's sake.

![Adding All Of Nbdev Crap](/assets/images/adding-all-of-nbdev-crap.png)

Okay... next? The time has come the Walrus said to make it know if it was
invoked from Jupyter Notebook "run" or from the command-line. That's the only
purpose this program will have here at first, knowing how it was invoked. It
will work one way if run as a Notebook and another way if run from CLI...

![Jupyter Detect If Run From Notebook Or CLI](/assets/images/jupyter-detect-if-run-from-notebook-or-cli.png)

Okay, simple enough. But now we want to immediately export a "***Python
package***", which is a fancy way of saying a core.py file as a result of that
comment... oops, no can do without a settings.ini file! Rip it off from
blogslicer then modify minimally. Okay, done. Also had to add the comment line
that defines the name of the exported library. Now I have
~/github/skite/skite/core.py which is the Python package containing similar
code to the Jupyter Notebook. We're getting there.

![Nbdev_build_lib Default_exp Core](/assets/images/nbdev_build_lib-default_exp-core.png)

And now we can try running core.py. It should output "bar" and it does:

![Detecting If Run From Jupter Notebook Or Command Line](/assets/images/detecting-if-run-from-jupter-notebook-or-command-line.png)

Nice. We have the basic scaffolding now to build out. We need to parse args
coming in, if from command-line and we need to set those same args in an
in-Notebook fashion if run from Jupyter.

Ugh! Just as I suspected, I'm starting to get those annoying Github Run Failed:
CI workflow messages. I don't really want continuous integration at this point.
There's going to be a lot of stuff going on that would cause fails, so let's
turn those off!

We go into that repo's Settings / Actions / General and Disable Actions

![Github Repo Settings Actions General Disable Actions](/assets/images/github-repo-settings-actions-general-disable-actions.png)

Okay, now let's arg parse. The main thing we're going to want to take in is a
filename of a csv file. Here's the script detecting it was run from Jupyter:

![Jupyter Detecting Script Run From Jupyter](/assets/images/jupyter-detecting-script-run-from-jupyter.png)

And here is the script detecting it was run from the command-line interface
(CLI):

![Python Script Detecting It Was Run From Command Line Interface CLI](/assets/images/python-script-detecting-it-was-run-from-command-line-interface-cli.png)

It's another good time for a git commit here. Next we import both pandas and
the Path function from the pathlib package from the standard library. It's good
practice to funnel filenames through the Path() function for interoperability
of file paths between different host operating systems. I additionally made a
simple .csv file.

    foo,bar,spam,eggs
    foo1,bar1,spam1,eggs1
    foo2,bar2,spam2,eggs2

![Jupyter Reading Csv File With Pandas](/assets/images/jupyter-reading-csv-file-with-pandas.png)

Next we want to test this from the command-line version but the csv file is one
directory-level up from where core.py is run, so we can accommodate for that in
how we feed the filename. Unix-like paths are universal.

![Nbdev Exported Package Taking Argument Displaying Pandas Dataframe](/assets/images/nbdev-exported-package-taking-argument-displaying-pandas-dataframe.png)

This may not look like much, but we are laying a foundational framework... ugh!
I hate frameworks! But our framework is as close to ***"The Unix Way"*** as we
can stay while in a Jupyter Notebook.

Okay, I'm getting tired. Here's the last item for today. I'm replacing the
sites.csv file with this visually formatted pipe delimited "csv" file. CSV
stands for comma delimited, but in reality you can delimit a CSV file with
almost any character you want because Pandas lets you declare it on the
read\_csv method.

    <pre>
    site                   |title                       |gaid
    GuerillaTech.com       |Guerilla Tech               |G-N4RYB5DCV4
    Levinux.com            |Levinux                     |G-0H19QDRNTL
    LinuxPythonvimgit.com  |Linux, Python, vim & git    |G-ZNMVJFLRD2
    LunderVand.com         |LunderVand                  |G-TJRX2PSWKT
    Mike-Levin.com         |Mike Levin Dot Com          |G-K86B8JW5Q5
    MikeAtEleven.com       |Mike At Eleven              |G-L7L2XR3J2G
    MikeLev.in             |Mike Levin                  |G-RX2D1N1P2Y
    MikeLevinSEO.com       |Mike Levin SEO              |G-RNSSPXFB53
    Pipulate.com           |Pipulate                    |G-45KYH6XTTX
    PythonicAlly.com       |Pythonically                |G-K5EQ2QQG5D
    PythonicAlly.org       |Your Pythonic Ally          |G-1JFHT28DRL
    RemovableFinger.com    |Removable Finger            |G-L3QGENNVJ3
    TardigradeCircus.com   |Tardigrade Circus           |G-9YEC9X0GDW
    TicTacUFOSightings.com |Tic Tac UFO Sightings       |G-YXNMZY6Z6F
    WeeklyReports.zd       |Mike Levin's Weekly Reports |G-foobarbaz1
    WhatsaMetaFor.io       |What's A Meta For           |G-HL9DEK1TSG</pre>

...and here's the latest status of the Notebook. You will notice the lambda
function where I strip out all the extra whitespace that visual formatting
(something I love to do for love-worthy's sake).

![Parsing Visually Formatted Pipe Delimited Csv File Pandas](/assets/images/parsing-visually-formatted-pipe-delimited-csv-file-pandas.png)

I'm losing steam, but this very much sets the stage for tomorrow. Maybe an
early-morning stream? Perhaps.

Okay, just took a nap. It's just about 3:00 AM now... getting back to it in the
same post. I'm making such good progress... gotta hit this thing home. Close!

Go ahead and add a tagline for each site. Okay done, as well as adding
sites.csv to the repo as a sample input file. That's fine.

Okay, next?

Next we should use Popen against each entry. Don't do anything too filesystemy
yet. Oh, but first we actually want to be able to simply loop through the
Pandas dataframe using each row as... hmmm, I want a list of nametuples, one
for each row. If I loop through the dataframe, each row is a series objects.
Series can be turned into dicts...

![Loop Through Pandas Df Each Row As Dict](/assets/images/loop-through-pandas-df-each-row-as-dict.png)

Now each dict can be turned into a namedtuple. For those not into Python's
namedtuples yet, they're very much like dictionaries but with a different API
allowing Java-like dot notation (instead of square-bracket notation) for
grabbing values inside of an object. They're for other things too, but that's
how I'm using them now.

![Pandas Dataframe To List Of Namedtuples Better Api](/assets/images/pandas-dataframe-to-list-of-namedtuples-better-api.png)

You have no idea how painful it is to be making this epically long blog post an
not being able to generate it with Github Pages to look and see how it's coming
along. I could be running Jekyll locally to do that and that may come later.
But for now I'm really just in a race to get it finished enough so that I can
generate the site. It's all very meta and has me up at 3:45 AM working on it.
Every day should feel like Xmas Eve with gifts awaiting you!

I just added one more column to sites.csv for a ***path*** to where the site's
files can be found on the filesystem relative to where the script is run.
Currently, it is exactly the same as the "apex" column, but that is only
because I name my directories using a site's apex domain. I will probably end
up putting ~/github/ before each of the path entries.

![Pipe Delimited Visually Formatted Csv](/assets/images/pipe-delimited-visually-formatted-csv.png)

And in case you're wondering, yes I am still test-running the nbdev Python
package from the command line interface:

![Nbdev Test Running Python Package From Cli](/assets/images/nbdev-test-running-python-package-from-cli.png)

Okay, now's where it gets real. From subprocess import Popen. Refresh myself
with its API...

We should start by looking at the recommended Run() method first:

    subprocess.run(args, *, stdin=None, input=None, stdout=None, stderr=None,
    capture_output=False, shell=False, cwd=None, timeout=None, check=False,
    encoding=None, errors=None, text=None, env=None, universal_newlines=None,
    **other_popen_kwargs)¶

But instead, I'm actually using Popen() for its greater edge-case capabilities
which as I recall I ran into when last doing stuff like this:

    subprocess.Popen(args, bufsize=- 1, executable=None, stdin=None,
    stdout=None, stderr=None, preexec_fn=None, close_fds=True, shell=False,
    cwd=None, env=None, universal_newlines=None, startupinfo=None,
    creationflags=0, restore_signals=True, start_new_session=False,
    pass_fds=(), *, group=None, extra_groups=None, user=None, umask=- 1,
    encoding=None, errors=None, text=None, pipesize=- 1)

I'm getting all this from the official Python subprocess documentation at
[https://docs.python.org/3/library/subprocess.html](https://docs.python.org/3/library/subprocess.html)
which always has the problem of inadequate examples. It does give simple
examples and important patterns to consider. For example, this is another
***"open"*** operation, which should trigger in your mind by now (always) the
context manager, and indeed they have this example:

    with Popen(["ifconfig"], stdout=PIPE) as proc:
        log.write(proc.stdout.read())

While this example is interesting, I need a much more real-world example that
demonstrates to me operating system independence. Until such time as I'm
running Jupyter Desktop under Linux (with WSLg... soon!), I need to suffer the
backslashes. Back-slash, back-slash, back-slash...oh Microsoft, how cruel you
are. Anyhoo, here's my initial success building on knowledge from prior
projects. I like this pattern. Keep in mind I'm using the .read() method to get
the output, but there are options such as .readline() and .readlines() as well.

![Python Subprocess Popen Pipe Windows Shell Stdout Read](/assets/images/python-subprocess-popen-pipe-windows-shell-stdout-read.png)

One more test before we start building based on this. Happily the "cd" command
is multi-platform (Windows & Linux), but so is (amazingly) the "echo"
command... at least Windows & Bash-based Terminals under Linux. I have to make
sure I understand how parameters or arguments are passed in as members of a
Python list. This is a little bit strange at first glance, but it's consistent
across the Python subprocess APIs so you've just got to understand and live
with it. Commands that go on a single-line in the CLI are broken into members
of a list when defined Python-side.

![Python Subprocess Popen Run Input Arguments Parameters List](/assets/images/python-subprocess-popen-run-input-arguments-parameters-list.png)

> Python and Linux<br />
> OS Independence<br />
> Stuff making sense<br />
> To our AI Descendants *(almost)*<br />
> These are a few of my favorite things!<br />
> <br />
> <cite>&#151;Mike Levin, 2022</cite><br />

So in almost all fields of technical endeavor when you're trying new things and
pushing your boundaries and success is unclear, there is often a ***Eureka!***
moment as there was with Archimedes and the gold crown in the bathtub, and as
with Orville and Wilbur Wright brothers getting the ratios for flight right in
their wind tunnel experiments. You just know everything has come together
correctly. As humble as it may be in comparison, this is one of those moments
for me on a personal level. Everything is going to pay off.

![Success Guaranteed Moment New Static Site Generator System Is Born](/assets/images/success-guaranteed-moment-new-static-site-generator-system-is-born.png)

Up to this point the code is pristine and bare-bones beautiful. I am a bit
frozen. I know I must move forward, but I do an nbdev\_clean\_nbs and name this
git commit "Barebones beautiful".

What is the lightest touch I can possibly do to make this system spring to life
again? Well, for starters I can ensure that the files I need for the blog slice
& dice system are actually inside each folder. I can make sure I can actually
cd to each folder in question. I can set the criteria for doing this next step.
First and foremost:

- It must be OS-independent, working either from
  - Jupyter Desktop under Windows
  - Linux Terminal under WLS2 Ubuntu

Python pathlib Path() to the rescue! Let's keep it OS-independent, people. 1,
2, 3... ? Simply cd into each location. That's all. Change your current
directory to reside inside each folder.

Okay wow, this one was a hard one. I had to set the path to each of the folders
containing site source-contents for the static site generator process (really
slice & dicing since Github pages will do the generation, but still). Now I was
tempted to put a ~/github as a prefix to every path entry, but not all
operating systems use ~/ as a shortcut for home and I'm trying to keep this
OS-independent. So I have to allow for one convention. Paths are relative to
your "home" directory, which Python pathlib is thankfully able to get for you
on both Windows and Linux. Here it is working in Windows:

![Python Find User Home Path Os Expanduser Tilde Windows](/assets/images/python-find-user-home-path-os-expanduser-tilde-windows.png)

And here is the same script running in a Linux Terminal:

![Python Os Independent Home Path Expansion Tilde Linux](/assets/images/python-os-independent-home-path-expansion-tilde-linux.png)

So as you can see, we're going to be able to set our current working directory
correctly for the blog slice & dice command that I'm so urgently working
towards.

This is where a project either stays tightly within the grip of your reins or
the wagon goes careening out of control. Keep a tight grip!

Charlie Brown, you've been making solid contact with this football. Don't go
losing it now. Think!

Set your current working directory using the cwd parameter of Popen. Test it.
Good, no errors.

I very much do not want a split between the Linux and Windows versions of this
program, but in order to confirm we are in the correct current working
directory, the command is cd from Windows but pwd from Linux. Ugh! Okay, we
will do one bit of OS-detecting code-splitting bullshit so we can keep a tight
grip on the reins. We ***have to confirm*** the cwd argument is working on both
sides. It's hateful to me that this is necessary, but here it is confirmed
Windows-side:

![Popen Current Working Directory Cwd Windows Vs Linux Python Os Name Nt Cd Pwd](/assets/images/popen-current-working-directory-cwd-windows-vs-linux-python-os-name-nt-cd-pwd.png)

And here it is confirmed Linux-side:

![How To Check Current Folder Linux Pwd Print Working Directory Symlinks](/assets/images/how-to-check-current-folder-linux-pwd-print-working-directory-symlinks.png)

This is going to work, but it's interesting to note that the symbolic links
that made the github folder appear to be underneath my Linux-side home
directory ~/ or /home/[username] has been expanded to the Windows Subsystem for
Linux (WSL) mount point (/mnt/c/Users/[username]). Okay, I can live with that.

We're close. That was tightening the grip on the reins because this is
precisely where things are going to go wrong.

I will not attempt to create bash scripts under Python wherein one command
builds upon stateful variables and such of the previous commands. I will not
attempt to maintain state or session between different code execution
environments. Remember what we are doing here.

We are essentially replacing a "parent" bash script which previously ran the
show and is quite a logical way to do this sort of thing with a Python script
as the new "parent". This is smart because Python is tons easier to read and
manage over the long-term than Bash Script.

However, we will be calling sub-processes (sequentially) exactly as if we were
working from a bash script still. Those subprocesses may (and will) be other
Python scripts. There is a temptation here to "keep state" within subprocesses.
We must not give into this temptation.

All data regarding a "next step" must be passed in explicitly from the context
of the parent script ***every time***. Subscripts are phantoms. They have no
memory. We call them using everything they need to know on the call, and then
we exit. After that, they were never there. There is no spoon.

Okay, deep breath. It is time to slice & dice your blogs again. Forget about
supplementary pages like homepage, about pages, style.css files and all the
rest of it. Oh, we will need to add and commit all new files in assets/images
since those are so required for building pages like this. But that's the only
extra thing beyond the blogslicer command... the blogslicer command... the
blogslicer command...

This is not your first project like this. There is another. Show the nice
people blogslicer:

```python
# export

import argparse
from pathlib import Path
from dateutil import parser
from slugify import slugify
from dumbquotes import dumbquote


if hasattr(__builtins__, "__IPYTHON__") or __name__ != "__main__":
    from IPython.display import display, Markdown

    h1 = lambda text: display(Markdown(f"# {text}"))
    h2 = lambda text: display(Markdown(f"## {text}"))
    h3 = lambda text: display(Markdown(f"### {text}"))

    folder_name = "../PythonicAlly.com"
    blog_title = "Pythonic Ally"
    blog_slug = "blog"
    author = "Mike Levin"
else:
    h1 = lambda text: print(f"# {text}")
    h2 = lambda text: print(f"## {text}")
    h3 = lambda text: print(f"## {text}")

    aparser = argparse.ArgumentParser()
    add_arg = aparser.add_argument
    add_arg("-p", "--path", required=True)
    add_arg("-t", "--title", required=True)
    add_arg("-s", "--slug", required=True)
    add_arg("-a", "--author", required=True)
    args = aparser.parse_args()

    folder_name = args.path
    blog_title = args.title
    blog_slug = args.slug
    author = args.author

index_front_matter = f"""---
layout: default
author: {author}
title: "{blog_title}"
slug: {blog_slug}
permalink: /blog/
---

"""
index_front_matter += "# Welcome to The {{ site.tagline }} Blog"


journal_path = f"{folder_name}/journal.md"
output_path = f"{folder_name}/_posts/"
slicer = "-" * 80

Path(output_path).mkdir(exist_ok=True)

dates = []
counter = -1
date_next = False
with open(journal_path, "r") as fh:
    for line in fh:
        line = line.rstrip()
        if date_next:
            try:
                adate = line[3:]
                date_next = False
                adatetime = parser.parse(adate).date()
            except:
                adatetime = None
            dates.append(adatetime)
            date_next = False
        if line == slicer:
            date_next = True
            counter = counter + 1
dates.reverse()

table = []
at_top = True
index_list = []
with open(journal_path, "r") as fh:
    for i, line in enumerate(fh):
        line = line.rstrip()
        if line == slicer:
            if at_top:
                at_top = False
                table = []
                continue
            adatetime = dates[counter - 1]
            filename = f"{output_path}{adatetime}-post-{counter}.md"
            h3(f"FILE: {filename}")
            with open(filename, "w") as fw:
                title = f"Post {counter}"
                slug = title
                if table[0] == slicer:
                    table = table[1:]
                maybe = table[1]
                has_title = False
                if table and maybe and maybe[0] == "#":
                    title = maybe[maybe.find(" ") + 1 :]
                    has_title = True
                slug = title.replace("'", "")
                slug = slugify(slug)
                top = []
                top.append("---\n")
                top.append("layout: post\n")
                top.append(f'title: "{title}"\n')
                top.append(f'author: "{author}"\n')
                top.append(f"categories: {blog_slug}\n")
                top.append(f"slug: {slug}\n")
                top.append(f"permalink: /{blog_slug}/{slug}/\n")
                try:
                    fdate = adatetime.strftime("%m/%d/%Y")
                except:
                    fdate = None
                link = f"- [{title}](/{blog_slug}/{slug}/) {fdate}"
                index_list.append(link)
                top.append("---\n")
                top.append("\n")
                top_chop = 2
                if has_title:
                    top_chop = 3
                table = [f"{x}\n" for x in table[top_chop:]]
                table = top + table
                print("".join(table))
                fw.writelines(table)
            counter = counter - 1
            table = []
        table.append(line)

index_page = index_front_matter + "\n\n" + "\n".join(index_list)

with open(f"{folder_name}/blog.md", "w") as fh:
    fh.writelines(index_page)
```

Look familiar? It should. It's the previous project where I worked through many
of these same issues.

This program takes the following arguments:

- path
- title
- slug
- author

Now you might think I didn't put all of this in sites.csv. You'd be correct,
however the slug is always going to be /blog/ and the author is always going to
be yours, truly. If in the future I use this system to manage blogs with
different "slugs" and "authors", I'll update the system. Because it's so
readable now, such updates will not be a problem.

I rewrite this system in case you haven't inferred by now because I lost grip
on the reins. The wagon careened out of control. And when I downgraded my
Ubuntu OS because LXD and broke it, I took it as a sign to do this tight
re-write. Well the re-write is done and it is tight. It's tighter than
blogslicer. I will have to revisit that sometime in the future, but
80/20-friggin rule, gotta use it, it's a tool.

Okay, so construct the blogslicer command for each site.

Let's nail the path of that Python executable. Each running instance of Python
knows where its own executable is stored. And it is ***knowing steps like
this*** that keep projects like this from careening. Absolute paths are your
friends. Fixed positions are your friends. Commands that can execute
independently of each other (albeit with sequential order dependence) are your
friends. ***THAT'S*** the point I'm up to here. Tight grip! Find that
Python.exe... sys.executable! So I'm already importing os and what do I care
for memory. This isn't one of those scaling apps. So import sys too!

    python = sys.executable

No problem! Now blogslicer is going to need to be called from that.

Okay, the first attempt to execute the blogslicer command is succeeding on some
sites and failing on others. We need to zero in on the point of failure.

Okay, remember the dependencies:

    pip install python-slugify
    pip install dumbquotes

Okay, wow... I think I have it basically working. I am waiting for this epic
post to push out and sync on Github Pages.

The code is getting too long for screenshots, so I'll just put this here:

```python
# export

import os
import sys
import argparse
import pandas as pd
from pathlib import Path
from collections import namedtuple
from subprocess import Popen, PIPE

python = sys.executable
home = Path(os.path.expanduser("~"))
blogslicer = Path(home / Path("github/blogslicer/blogslicer/core.py"))
if hasattr(__builtins__, "__IPYTHON__") or __name__ != "__main__":
    from IPython.display import display, Markdown

    h1 = lambda text: display(Markdown(f"# {text}"))
    h2 = lambda text: display(Markdown(f"## {text}"))
    h3 = lambda text: display(Markdown(f"### {text}"))

    file = "sites.csv"
else:
    h1 = lambda text: print(f"# {text}")
    h2 = lambda text: print(f"## {text}")
    h3 = lambda text: print(f"## {text}")

    aparser = argparse.ArgumentParser()
    add_arg = aparser.add_argument
    add_arg("-f", "--file", required=True)
    args = aparser.parse_args()
    file = args.file

h1("Generaring sites...")
file_obj = Path(file)
df = pd.read_csv(file_obj, delimiter="|")
df = df.applymap(lambda x: x.strip())
df.columns = [x.strip() for x in df.columns]
Site = namedtuple("Site", "path, apex, title, gaid, tagline")

h2(f"Python: {python}")
h2(f"Blogslicer: {blogslicer}")
print()
for index, series in df.iterrows():
    site = Site(**series.to_dict())
    h3(site.apex)
    here = Path(home / site.path)
    cmd = f'{python} {blogslicer} -p {here} -t "{site.title}" -s "blog" -a "Mike Levin"'
    print(cmd)
    print()
    with Popen(args=cmd, cwd=here, stdout=PIPE, stderr=PIPE, shell=True) as pout:
        for line in pout.stdout.readlines():
            print(line.decode().strip())
h2('Done!')
```

Are we done here? Hmmm, no. I have to make the git portion of this work as
well. Ugh, that means for the multi-OS aspect, I need git for Windows. Check if
I have it... I don't. And I really need to to be available not just under
Windows, but from the Jupyter Desktop Terminal context. Google git for Windows
and learn the latest gory details https://git-scm.com/download/win

Good news, everyone! It seems there is a command you can execute from
PowerShell to install git. And since the Jupyter Desktop Terminal is
PowerShell, there is a decent chance that git will be available as a command
under Terminal.

    winget install --id Git.Git -e --source winget

After a huge install of mingw64 and what looks nearly like a cygwin install, I
still can't run git from a Jupyter Terminal. Ugh! It does run from a normal
PowerShell. Damn it, figure out what to do. Look at the Path.

This lets you look at PowerShell environment variables:

    dir env:

Looking over the printout, I think the culprit is PSMODULEPATH

Under Jupyter Terminal vs. Under Microsoft Terminal:

    C:\Users\mikle\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules
    C:\Users\mikle\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

Nope, they're identical! Figure out where git is located:

    (get-command git).Path

Returns:

    C:\Program Files\Git\cmd\git.exe

Okay, pshwew! Make sure that runs from Jupyter Terminal!

    C:\Program` Files\Git\cmd\git.exe

Okay, got it. You need a back-tick before the space. Wow! Make sure you've got
git on both sides.

Ugh, nonsense! Okay...

    pip install GitPython

Nope! I take that back too. However, the GitPython package did give me the
answer:

    import os
    if os.name == 'nt':
        git_exe = r"C:\Program Files\Git\cmd\git.exe"
    else:
        git_exe = "/usr/bin/git"
    os.environ["GIT_PYTHON_GIT_EXECUTABLE"] = git_exe

And I think I'll introduce my first function.

    def git(args):
        cmd = [git_exe] + shlex.split(args)
        with Popen(args=cmd, cwd=here, stdout=PIPE, stderr=PIPE, shell=True) as pout:
            print(f"GIT: {shlex.join(cmd)}")
            print(f"STDOUT: {pout.stdout.read().decode()}")
            print(f"STDERR: {pout.stderr.read().decode()}")
            print()

Ugh, Windows git was wreaking havoc on my files, especially the big repos.

    git config --global core.autocrlf true
    git config --global core.eol crlf

And I need a better method of streaming output from Popen. As much as I like
the context manager, it has to go:

```python
def git(args):
    cmd = [git_exe] + shlex.split(args)
    process = Popen(
        args=cmd,
        cwd=here,
        stdout=PIPE,
        stderr=PIPE,
        shell=False,
        bufsize=1,
        universal_newlines=True,
    )
    print(f"GIT: {shlex.join(cmd)}")
    for line in process.stdout:
        print(line)
        sys.stdout.flush()
```

I'm still having issues with Windows git changing every file in a repo.

I think I have to do this too:

    git config --global core.filemode false

And a few tweaks including blanking the folder before-hand so renamed blog
posts don't sneak in as duplicates:

```python
# export

import os

if os.name == "nt":
    git_exe = r"C:\Program Files\Git\cmd\git.exe"
else:
    git_exe = "/usr/bin/git"
os.environ["GIT_PYTHON_GIT_EXECUTABLE"] = git_exe
import sys
import shlex
import argparse
import pandas as pd
from git import Repo
from pathlib import Path
from collections import namedtuple
from subprocess import Popen, PIPE


python = sys.executable
home = Path(os.path.expanduser("~"))
blogslicer = Path(home / Path("github/blogslicer/blogslicer/core.py"))
if hasattr(__builtins__, "__IPYTHON__") or __name__ != "__main__":
    from IPython.display import display, Markdown

    h1 = lambda text: display(Markdown(f"# {text}"))
    h2 = lambda text: display(Markdown(f"## {text}"))
    h3 = lambda text: display(Markdown(f"### {text}"))

    file = "site.csv"
else:
    h1 = lambda text: print(f"# {text}")
    h2 = lambda text: print(f"## {text}")
    h3 = lambda text: print(f"### {text}")

    aparser = argparse.ArgumentParser()
    add_arg = aparser.add_argument
    add_arg("-f", "--file", required=True)
    args = aparser.parse_args()
    file = args.file

h1("Generaring sites...")
file_obj = Path(file)
df = pd.read_csv(file_obj, delimiter="|")
df = df.applymap(lambda x: x.strip())
df.columns = [x.strip() for x in df.columns]
Site = namedtuple("Site", "path, apex, title, gaid, tagline")


def git(cwd, args):
    cmd = [git_exe] + shlex.split(args)
    h2(f"git cmd: {shlex.join(cmd)}")
    process = Popen(
        args=cmd,
        cwd=cwd,
        stdout=PIPE,
        stderr=PIPE,
        shell=False,
        bufsize=1,
        universal_newlines=True,
    )
    h3('git stdout')
    for line in process.stdout:
        print(line.strip())
        sys.stdout.flush()
    print()
    h3('git stderr')
    for line in process.stderr:
        print(line.strip())
        sys.stdout.flush()
    print()


h2(f"Python: {python}")
h2(f"Blogslicer: {blogslicer}")
print()
for index, series in df.iterrows():
    site = Site(**series.to_dict())
    h3(site.apex)
    here = Path(home / site.path)
    [x.unlink() for x in Path(here / "_posts/").glob("*")]

    # Blog Slicer
    cmd = f'{python} {blogslicer} -p {here} -t "{site.title}" -s "blog" -a "Mike Levin"'
    print(cmd, end="\n\n")
    with Popen(args=cmd, cwd=here, stdout=PIPE, stderr=PIPE, shell=True) as pout:
        for line in pout.stdout.readlines():
            print(line.decode().strip())

    git(here, "add _posts/*")
    git(here, 'commit -am "Publising Blog Posts"')
    git(here, "push")

h2("Done!")
```

I need to tie this process to a vim macro again.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/there-s-no-place-like-home-you-get-to-decide-where-that-is-or-do-you/">There's No Place Like Home & You Get To Decide Where That Is... Or Do You?</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/throw-all-the-meat-veggies-into-the-stew-stir-the-blog-vlog/">Throw All The Meat & Veggies Into The Stew & Stir The Blog / Vlog</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/virtualenv/'>Virtualenv</a></h4></li>
<li><h4><a href='/panda/'>Pandas</a></h4></li>
<li><h4><a href='/powershell/'>Powershell</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/80-20-rule/'>80/20-rule</a></h4></li></ul>