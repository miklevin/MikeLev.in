---
title: Jupyter Notebook to Pipulate Workflow
permalink: /futureproof/jupyter-notebook-pipulate-workflow/
description: 
layout: post
sort_order: 3
---

## Starting With Enterprise Botify Workflow Automation

Okay, so I've got the first SEO workflow I want to automate, and it's purely
Botify! There's so much I'd love to do for the unwashed SEO masses, but think of
this enterprise crawling company employer of mine as something like my art
patrons. I don't use Patreon and I don't really need to be a YouTuber because
what I do professionally has some considerable value to the enterprise, you know
where the customers really are. Established companies need to make the
transition into the new AI SEO realities as much as everyone else. And so that's
where our first workflow conversion begins.

### Future Plans for Interactive SEO Tools

Over time I'll do the smaller, and frankly more fun and broader appeal stuff,
like real-time crawls where you chitchat with the LLM as you go, and it shows
you the live link-graph of the site, building it up page-by-page. Ugh! I have to
consider myself almost in a race to get to that stuff by getting through this
stuff, which is frankly easier and pays the bills. And the particulars of the
workflow are for the first time in awhile laid out so crystal clear, because of
the Jupyter Notebook I had to do for today's work. Just port that into Pipulate!

### History of SEO Workflow Automation Attempts

My first attempt ages ago at one of these automated SEO workflows wasn't really
so easy. It combined the visualized link-graph (drawn from the Botify data) with
a lot of rigorous API-work - and that is some work I'll be porting pretty soon,
the LinkGraphFlow. This one I'm doing right now plays off of the last article. I
actually have a Jupyter Notebook which is the workflow! That last article is the
one I created along with the Notebook, and is a great example of something to
port.

- It's actual work I had to do. The end result was outputting the PageWorkers
  Parameter Butster JavaScript itself!
- Such work broadly applies across multiple clients (something everyone could use)
- It's mostly CSV-downloads and Pandas dataframe manipulations, so it uses API
  connections to Botify
- There's just a couple of parameters to adjust as inputs
- The accompanying visualizations are only ***optional,*** which I could
  incorporate but they're not critical to the value of the output

### Setting Up the Development Environment

Okay, one of the important discoveries was that making a client folder inside of
Pipulate is key, because that makes it share the Python virtual environment, and
thus I'm working off of a common set of pip-installed tools. And JupyterLab runs
side-by-side with Pipulate as just a plain matter of course, so I'm never
struggling for a Notebook environment.

### Late Night Development Session

Tue Mar 18 08:31:15 PM EDT 2025

I took a nap to try to get another day in before I get another day in, haha! I
don't like to throw off the circadian rhythm, but sometimes doing it can help
you move your life forward forever and is worth it. Tomorrow I'm in the office,
so I might end up a little tired. If I time this right I can get one more nap
before I go in tomorrow. I can't bail and do another work-from-home day like I
did today because I accepted an in-person meeting with a co-worker, and that
will put just the right pressure on me to get this work now done.

### Setting Up Git Repository for Client Work

Okay, so Jupyter Notebooks are actually in the picture now for the port, and I
have a folder within the pipulate folder which is hidden from the git repo (and
thus, GitHub and you, through the `.gitignore` file. So, that is going to have
to be its own repo.

```bash
cd ~/repos/pipulate/client/
echo "# client" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:miklevin/client.git
git push -u origin main
```

### Installing nbstripout for Clean Git Diffs

Okay, while I'm at it, it's time to put the `nbstripout` package into use again,
which cleans notebook metadata before it gets into git repos, thus polluting the
clean `git diff`s with all this JSON notebook meta garbage. For example, the
Notebook cell output is actually recorded in the `.ipynb` so the next time you
open the Notebook, you see the exact last state (cell output and all). While
this is a really useful feature Notebook-wise, it wreaks havoc on the git
repository -- messing up the ***git diff*** feature that let you easily see only
the "delta" or differential changes between one commit and the next.

#### Adding to Requirements.txt

Okay, I put it in the Pipulate `requirements.txt`, which currently is:

```plaintext
autopep8
isort
pylint
python-minimizer
strip-docs
tiktoken
vulture

aiohttp
beautifulsoup4
dominate
httpx
itables
jupyter-ai[all]
jupyterlab
jupyterlab-spellchecker
jupytext
loguru
nbstripout
pandas
pyfiglet
python_fasthtml
requests
rich
watchdog
```

And so the use of [`nbstripout`](https://pypi.org/project/nbstripout/) has to be
"run" once per repo. After that, it's apparently 

```bash
[mike@nixos:~/repos/pipulate]$ nix develop
CUDA hardware detected.
#  ____        _   _  __       _   _                 
# | __ )  ___ | |_(_)/ _|_   _| |_| |__   ___  _ __  
# |  _ \ / _ \| __| | |_| | | | __| '_ \ / _ \| '_ \ 
# | |_) | (_) | |_| |  _| |_| | |_| | | | (_) | | | |
# |____/ \___/ \__|_|_|  \__, |\__|_| |_|\___/|_| |_|
#                        |___/                       
Welcome to the Botifython development environment on x86_64-linux!

- Confirming pip packages...
- Done. 249 pip packages present.
- numpy is importable (good to go!)

To start JupyterLab, type: start
To stop JupyterLab, type: stop

To start the botifython server, type: python server.py

[mike@nixos:~/repos/pipulate]$ nbstripout --install
```

And that's it. It's a bit magical, but after doing that you don't have to
trigger off any commands, like `nb-clean` or anything. It just works. Here's
Perplexity's explanation of why:

**Perplexity**: The command `nbstripout --install` provides a convenient way to set up nbstripout as a Git filter for Jupyter notebooks, allowing you to automatically strip output from notebooks when committing changes. Here's why this approach is effective:

1. **Automatic configuration**: The `--install` flag sets up the necessary Git configurations automatically. It adds the filter and diff driver settings to your Git config file and creates the required `.gitattributes` file.

2. **Repository-specific setup**: By default, this command installs nbstripout for the current repository only, ensuring that it doesn't affect other projects unintentionally.

3. **Seamless integration**: Once installed, nbstripout works silently in the background. It strips output from notebooks during Git operations without requiring manual intervention.

4. **Preserves local output**: The filter only affects what Git sees, keeping your working copy intact. This means you can still view and work with notebook outputs locally.

5. **Reduces file size and diffs**: By removing output from version control, it minimizes file sizes in your repository and makes diffs more manageable, focusing on actual code changes.

6. **Flexible configuration**: While the basic installation is often sufficient, nbstripout offers additional options for customization, such as keeping certain outputs or metadata, if needed.

By using `nbstripout --install`, you set up a low-maintenance solution for managing Jupyter notebook outputs in version control, allowing you to focus on your work without worrying about cluttered Git history or large file sizes due to notebook outputs.

---

And just to assure myself this is really happening, I use the `--status` command
flag to check...

```bash
[mike@nixos:~/repos/pipulate]$ nbstripout --status
nbstripout is installed in repository '/home/mike/repos/pipulate'

Filter:
  clean = "/home/mike/repos/pipulate/.venv/bin/python" -m nbstripout
  smudge = cat
  diff= "/home/mike/repos/pipulate/.venv/bin/python" -m nbstripout -t
  extrakeys= 

Attributes:
  *.ipynb: filter: nbstripout

Diff Attributes:
  *.ipynb: diff: ipynb

[mike@nixos:~/repos/pipulate]$
```

Okay, that looks good. I'm going to do that also in the `client` subfolder I
have in Pipulate...

```bash
[mike@nixos:~/repos/pipulate/client]$ nbstripout --status
nbstripout is not installed in repository '/home/mike/repos/pipulate/client'

[mike@nixos:~/repos/pipulate/client]$ nbstripout --install

[mike@nixos:~/repos/pipulate/client]$ nbstripout --status
nbstripout is installed in repository '/home/mike/repos/pipulate/client'

Filter:
  clean = "/home/mike/repos/pipulate/.venv/bin/python" -m nbstripout
  smudge = cat
  diff= "/home/mike/repos/pipulate/.venv/bin/python" -m nbstripout -t
  extrakeys= 

Attributes:
  *.ipynb: filter: nbstripout

Diff Attributes:
  *.ipynb: diff: ipynb

[mike@nixos:~/repos/pipulate/client]$
```

## Nested Git Repos with Clean Jupyter Integration

...and now I have nested git repos, using `.gitignore` to keep the outer one
from including the inner one in its own repo. And the inner one just doesn't
care because it has no idea - git scope is from the init'ed folder inward. And I
can use Jupyter Notebooks in either without the Notebook's JSON meta data
polluting the git repos. Neat!

### The Importance of Technical Details

It may seem pedantic and ridiculous to do all this, and even more so to cover it
all in a blog. But it's these little details that make all the difference. You
might think of the Pipulate repo folder as my new ***home,*** because so much of
the work I'm going to do now is going to be directly in there.

### Simplifying Path Management in Local-First Applications

There's a bit of an anti-pattern here, having to do with local-first concerns --
meaning, I'm setting up a single application on my local machine, as if someone
were installing a piece of software, and then I'm keeping all its data files
directly inside its install location. This ***simplifies the paths*** to files.
I don't have to do all these ***operating system dependent*** paths using the
Python `os` or even `pathlib` libraries. Paths breaking is a big problem with
multi-platform applications. OS-dependent paths are brittle. But if you keep all
your paths relative to the same directory your Python program is installed (and
`cd`'d to when run), everything just works.

### Managing Data Files in Git Repositories

Of course, this means keeping your data files inside your git repo folder, and
putting those data folders in your `.gitignore` to keep them from ever getting
committed into the repo itself. And if you want those other data files backed up
(what I'm doing with the client folder here), you're going to have to do it some
other way (like making your data its own repo). But the payoff is so much
simplification, it's totally worth it.

### Reducing Complexity Through Strategic Organization

It might sound a bit complicated, but it's actually the least complicated thing
with all these corollary benefits. Over time, it reduces cognitive overhead and
decision fatigue. There's a bunch of other cool stuff being accomplished here
too:

1. A single `nix develop` from the Pipulte folder sets up both the Linux nix
   subsystem and the Python virtual environment (`.venv`).
2. I have two separate ***repo spaces,*** one for public code and one for
   private code, but they both share the same `.venv`.
3. This means that all `pip install`s are available to any Jupyter Notebooks I
   make either for private client use or for public Pipulate use.
4. I can make such Notebooks freely, knowing that when I add them to their
   repos, I won't be polluting the repos with Notebook meta JSON garbage. In
   other words, the `git diff`s will be clean and useful.
5. My Jupyter Notebooks will be sharing the same pip installed dependencies as
   my Pipulate workflows!

Okay, that cleared my mind and clarified my vision. But from here forward
(tonight), I have to put that creative energy directly into the Notebook port,
and not into thinking through the big picture. We switch from big sweeping
pitures, and the ***daily habit*** stuff of reducing cognitive overhead and
decision fatigue (one git repo to rule them all, one `.venv` to bind them, yadda
yadda), to the scalpel-like precision of the Jupyter port.

I have a drop-in plugin framework for SEO workflows! I might as well call it
Data Science workflows at this point. If I'm actually attracting an SEO audience
looking for the crawl stuff here, you're a few weeks too early. Unfortunately,
we are in a sprint and not a marathon, which is why I'm sort of knocking myself
out plowing through this, as [Goose AI](https://github.com/block/goose),
[Cline](https://github.com/cline/cline),
[OpenManus](https://github.com/mannaandpoem/OpenManus) and the like are bursting
oonto the scene, making buzz. Stop overpaying for your AI infrastructure? Ha!
***Stop paying for your AI infrastructure!***

But my message is a bit different. This is not chain-of-thought recursive
self-prompting, with browser-use thrown in for willy nilly results. This is
rigid workflows. This is AI-on-Rails! But using Python and HTMX instead of Ruby,
so you get all that lovely Python back-end power, and end-run having to do any
of that React stuff by painting directly into the browser DOM -- and doing it
all directly from your own local machine, so you can have that old webmaster
feeling again, where you can understand, and thus control and customize
everything! Ugh, there I go rambling again. Precious time, remember? 1, 2, 3...
1?

Honestly, I think I'm facing a mental block here. I wrote a whole other article
on fixing the unparsable structure data issue I was having on my website, right
as I got down to 1 in the countdown, haha!

What it is, is that I'm about to spend a lot of decision-juice. I'm going to
have to do a lot of expensive thinking. And it's late and I don't wanna. But my
world changes forever if I do, and these are precisely the types of hurdles you
get yourself over to change the world forever for yourself moving forward. It is
a demonstration and exercising of agency and autonomy. It is what it is to be
human. So let's get this show on the road!

There are many web frameworks, but there are none like mine. Armin Ronacher got
it started with Flask in 2010, routing web requests into Python through function
`@decorators`. Carson Gross made the web less gross with intercooler.js in 2013,
which eventually became HTMX -- reducing the world's need for JavaScript. And
then Jeremy Howard came out with FastHTML to connect the dots between Flask and
HTMX just in time for my birthday, August of last year (2024). Sometimes
everything just has to fall in place just-so, before a love-worthy framework
like mine can spring into existence.

Now, the code is still a bit ugly, mixing traditional procedural Python coding
style with the object oriented programming style (OOP). Sometimes I use the new
MyPy strict data typing conventions, and sometimes I don't. I use quite a few
global variables, and I'm not doing a lot of error checking, and there's no test
coverage. Some of this is intentional because of anti-enterprise-concerns and
seeking the local-first advantage. But some of it is not, and is just in
desperate need of a cleanup. But in typical Python style, pragmatic concerns of
just getting the work done win, so I'm not going to let any of that stop me --
hahaha!

So, this is all really a starting point. Working in my advantage is that the
codebase is really small. The core is 2.5K lines of code, coincidentally also
25K tokens, per the OpenAI token size reporting tool, tiktoken. The context
window for even local LLMs like Gemma 3 is up to that 128K window that Google's
Gemini set the standard for in code-assistant AIs. And so the core codebase only
takes up 1/4 of the context window. So, with more time the core codebase will
become smaller and cleaner. This is different from most frameworks. Not only
have I connected some of the best dots to connect out there right now (Python,
HTMX, local host & local LLM), but the codebase is poised to shrink!

That being said, a certain part not in core (anymore, as of very recently) is
designed to grow VERY LONG, VERY FAST.

Most people in my situation would inherit the default behavior for workflows
part of a plugin system from an OOP superclass, and then selectively override
the default behaviors when and where you have to customize.

Nosirree! Not me. Well, I mean I did try that but the complexity of overriding
superclasses in Python blew my mind -- right at the time when I was trying to
learn HTMX in the most straightforward fashion I could. I had this image of
looking at the HTMX sheet music. Unfortunately, straightforward fashion in
programming can mean...

> Verbose and verbatim -- a style forboden.  
> Pedantics insist you get DRY.  
> But it turns out that WET  
> is as clear as you get.  
> And here, I will show you just why.  

## Porting a Notebook to Pipulate

First, you have a Jupyter Notebook. Maybe you have a Colab Notebook. But then
all your files are going to disappear in 24 hours, or you have to hardware it to
Google services to get your data residing in a Google Suite product and your
cloud handcuffs are slapped on, and you're paying at least $10/mo for the
privilege of being able to do Notebook stuff, which is free and open source in
nature. So, you should be using plain vanilla Jupyter Notebooks. Pipulate will
install an easy peasy local JupyterLab environment for you on macOS or
Windows/WSL. It's multi-platform and future-proof Linux, so there's no excuse.

Okay, next you understand that ***Cells*** in a Jupyter Notebook execute from
top-to-bottom. Sure, some people run them out-of-order, but those people are
***out of order.*** We're going for reproducibility here -- not some magical
unreproducible spell-casting incantation that only the original Data Scientist
who set it up knows. In a lot of ways, what we're doing is spell incantation
distillation! We're packing up the ingredients and hiding them from the
spellcaster (not showing the user of the Notebook the Python code).

But I'm not making some auto-porting software that parses out the `.ipynb` file
and magically turns it into some schedulable task. No, that would be way too
easy. Instead, we're going to copy cell-by-cell the Python code from the
Notebook into the currently undecipherable even to me Pipulate system, and I
invented it! Promising, right!

Okay, so let's decipher a workflow and do the first port.

The best starting place currency is the [Pipulate page on
GitHub](https://github.com/miklevin/pipulate). That has to change. I have to
update the Pipulate.com domain, this website MikeLev.in and even the PyPI
location where you were once able to pip install an old version. All those
locations need to be updated, but right now my focus in on the Pipulate repo
itself, so that's where the best instructions reside.

And those instructions start with installing the nix repo system, if you haven't
already. Then you can start Jupyter by opening a terminal and:

```bash
nix develop
start
```

Simple as that. This is now going to be a commonly recurring pattern for me, and
anyone jumping on the Pipulate bandwagon. Sure, you can just try to code
something directly into Pipulate, but it's purpose is not to replace the well
established, battle-hardened Notebook way of doing things. Still mock-up your
ideas in Notebooks. Hmmm. We use the word mock-up, but really Notebooks are so
much more than that. They're fully functioning versions! Not mock-up's at all.
But they do expose an awful lot of messy details -- how the sausage is made --
that's going to intimidate a lot of your potential intended audience. These
workflows would serve you much better if they were just a web app -- a web-app
without any web hosting headache! Complete cloud independence! Own your soul and
slap those hands of your wallet.

Slap, slap, slap! Ah, the sound of independence. Now for the price of
independence.

Get a pipulate directory on your local machine. Those already on the git/GitHub
bandwagon can:

```bash
git clone git@github.com:miklevin/pipulate
```

Those not on this bandwagon yet (no GitHub account, `.ssh` keys not set up,
etc.) can just [download the `.zip` from
GitHub](https://github.com/miklevin/pipulate) (pressing the bright green `<>
Code` button and pressing "Download ZIP".

Once you've unarchived that on your machine, you can open a terminal, `cd` into
that directory and:

```bash
nix develop
start
```

See? Jupyter Notebook pops up. No? Well, then you need `nix` on your machine. Go
back to the [Pipulate page on GitHub](https://github.com/miklevin/pipulate) and
look read the install instructions more carefully. Or alternatively, go read
about the [Determinate Systems Nix
Installer](https://determinate.systems/posts/determinate-nix-installer/).

Everything has a price. And the price of cloud independence is being able to use
a universal Linux subsystem on any host system, be it macOS, Windows/WSL or some
other Linux. And today, that universal Linux subsystem is called `nix`. It's
been around since 2013 and is quite battle-hardened and used by the most
innovative defense contractor of our time, Anduril. So get some experience using
nix, and don't work for Anduril.

Pshwew! Okay... 1, 2, 3... 1? We're always at step 1. Now that you have
JupyterLabs popping up in your browser in one of the best ways you can run
Notebooks, go do a hello world program. It should look something like this:

![JupyterLab on nix](/images/jupyuterlab-on-nix.png)
