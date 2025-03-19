---
title: Jupyter Notebook to Pipulate Workflow
permalink: /futureproof/jupyter-notebook-pipulate-workflow/
description: 
layout: post
sort_order: 3
---

Okay, so I've got the first SEO workflow I want to automate, and it's purely
Botify! There's so much I'd love to do for the unwashed SEO masses, but think of
this enterprise crawling company employer of mine as something like my art
patrons. I don't use Patreon and I don't really need to be a YouTuber because
what I do professionally has some considerable value to the enterprise, you know
where the customers really are. Established companies need to make the
transition into the new AI SEO realities as much as everyone else. And so that's
where our first workflow conversion begins.

Over time I'll do the smaller, and frankly more fun and broader appeal stuff,
like real-time crawls where you chitchat with the LLM as you go, and it shows
you the live link-graph of the site, building it up page-by-page. Ugh! I have to
consider myself almost in a race to get to that stuff by getting through this
stuff, which is frankly easier and pays the bills. And the particulars of the
workflow are for the first time in awhile laid out so crystal clear, because of
the Jupyter Notebook I had to do for today's work. Just port that into Pipulate!

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

Okay, one of the important discoveries was that making a client folder inside of
Pipulate is key, because that makes it share the Python virtual environment, and
thus I'm working off of a common set of pip-installed tools. And JupyterLab runs
side-by-side with Pipulate as just a plain matter of course, so I'm never
struggling for a Notebook environment.

Tue Mar 18 08:31:15 PM EDT 2025

I took a nap to try to get another day in before I get another day in, haha! I
don't like to throw off the circadian rhythm, but sometimes doing it can help
you move your life forward forever and is worth it. Tomorrow I'm in the office,
so I might end up a little tired. If I time this right I can get one more nap
before I go in tomorrow. I can't bail and do another work-from-home day like I
did today because I accepted an in-person meeting with a co-worker, and that
will put just the right pressure on me to get this work now done.

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

Okay, while I'm at it, it's time to put the `nbstripout` package into use again,
which cleans notebook metadata before it gets into git repos, thus polluting the
clean `git diff`s with all this JSON notebook meta garbage. For example, the
Notebook cell output is actually recorded in the `.ipynb` so the next time you
open the Notebook, you see the exact last state (cell output and all). While
this is a really useful feature Notebook-wise, it wreaks havoc on the git
repository -- messing up the ***git diff*** feature that let you easily see only
the "delta" or differential changes between one commit and the next.

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

...and now I have nested git repos, using `.gitignore` to keep the outer one
from including the inner one in its own repo. And the inner one just doesn't
care because it has no idea - git scope is from the init'ed folder inward. And I
can use Jupyter Notebooks in either without the Notebook's JSON meta data
polluting the git repos. Neat!

It may seem pedantic and ridiculous to do all this, and even more so to cover it
all in a blog. But it's these little details that make all the difference. You
might think of the Pipulate repo folder as my new ***home,*** because so much of
the work I'm going to do now is going to be directly in there.

There's a bit of an anti-pattern here, having to do with local-first concerns --
meaning, I'm setting up a single application on my local machine, as if someone
were installing a piece of software, and then I'm keeping all its data files
directly inside its install location. This ***simplifies the paths*** to files.
I don't have to do all these ***operating system dependent*** paths using the
Python `os` or even `pathlib` libraries. Paths breaking is a big problem with
multi-platform applications. OS-dependent paths are brittle. But if you keep all
your paths relative to the same directory your Python program is installed (and
`cd`d to when run), everything just works.

Of course, this means keeping your data files inside your git repo folder, and
putting those data folders in your `.gitignore` to keep them from ever getting
committed into the repo itself. And if you want those other data files backed up
(what I'm doing with the client folder here), you're going to have to do it some
other way (like making your data its own repo). But the payoff is so much
simplification, it's totally worth it.

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
