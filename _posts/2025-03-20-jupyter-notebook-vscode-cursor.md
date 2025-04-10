---
title: Jupyter Notebooks in VSCode and Cursor AI
permalink: /futureproof/jupyter-notebook-vscode-cursor/
description: "I navigated the complexities of running Jupyter Notebooks within Cursor AI on NixOS, a niche setup that required a specific order of operations. By ensuring a running JupyterLab instance with an active kernel before launching Cursor, I unlocked seamless AI assistance for my notebooks. I also detailed how using Nix Flakes with Pipulate provides a robust and portable solution for running JupyterLab, even across different operating systems, overcoming the common hurdles faced by users in diverse environments."
meta_description: Learn how to run Jupyter Notebooks in Cursor AI using Nix Flakes and Pipulate for seamless live kernel and AI-assisted coding on NixOS.
meta_keywords: Jupyter Notebooks, Cursor AI, NixOS, Nix Flakes, Pipulate, live kernel, AI assistance, VSCode, JupyterLab, Python notebooks, notebook integration
layout: post
sort_order: 2
---

## Running Jupyter Notebooks with Cursor AI

This article is about getting AI assistance on a Jupyter Notebook in Cursor AI
under NixOS. It will possibly be useful to people using VSCode on Windows or
macOS, but I am at the center of a very unusual Venn diagram.

- I'm primarily on NixOS (my daily work machine)
- I love using Jupyter Notebooks
- I'm a Cursor AI customer

### Understanding Jupyter Notebooks

If you're anything like me, you've fallen in love with the unique code execution
environment called "Notebooks". Notebooks feel like you're executing Python code
in a web browser, and it never really stops running. So if you set `a = 1`, a
continues equaling 1 until you "restart the kernel".

```python
a = "Hello World!"
```

> Walk away, get a coffee. Come back, make a new ***Cell*** in your Notebook.
> Check the value of `a`...

```python
print(a)
```

Hello World!

## Understanding the Persistent Nature of Jupyter Variables

...and `a` still equals "Hello World!" You could continue manipulating `a` and
it's like the program is frozen mid-execution until you run the next cell. Some
people call it a Read-Eval-Print Loop or a REPL environment. It's also what you
get when you just type `python` from the terminal command-line. A guy named
Fernando Pérez created a greatly improved version of the default Python REPL in
2001, called IPython. Ten years later, he made it work in a web browser, and
called it Jupyter. Its popularity skyrocketed.

## The Power of Incremental Code Development in Notebooks

It might sound a little bit weird, but it means you can write programs as you
build them up without re-running your whole program from the top. This creates
an experimental and exploratory learning environment that's been huge with data
science and business people. You don't really have to be a professional
programmer to be quite effective with Notebooks. Because of the popularity of
Notebooks, and because the code is completely free and opens source, Google and
Microsoft built it into their own products, Colab and VSCode. There's a ton of
other versions too, like Azure Notebooks and Binder.

## VSCode's Evolution in Notebook Support

So, Notebooks became supported by VSCode! Originally, they could load the
`.ipynb` files of a Notebook, but then could only save it out as a `.py` file.
Later, their support improved, and there became very little downside of using a
Notebook in VSCode besides purity.

## My Journey from Vim to VSCode

I resisted VSCode forever. I'm one of those vim people who think you can have
one text-editor for life. The mouseless muscle-memory flow-state is totally for
me. VSCode represented everything I hate. Fee-filching faux FOSS! In other
words, VSCode was created by Microsoft to trick you into using Azure cloud
services instead of Amazon AWS. Plus, VSCode posed as free and open source
software, but actually wasn't. It's slow as molasses compared to vim, and is
totally inappropriate for uses like the journal-writing I'm doing right now.

## Transitioning to AI-Assisted Development

I was on the GitHub CoPilot bandwagon as soon as it came out, switching from vim
to NeoVim, so it supported AI -- close enough to vim to still be a purist. But I
was unhappy with the auto-complete approach to AI code assistance and let my
1-year subscription expire. Then along came Cursor AI, with a much more nuanced
approach, with the new code being presented in new GREEN/RED like git diff's. I
was sold, much like the rest of the world. The $20/mo. subscription for what
felt like nearly unlimited access to Anthropic Claude 4.5 sealed the deal. 

## The Quest for AI-Enhanced Notebooks

I was now on Cursor, a fork of VSCode, at lest part of the time. The benefit was
worth it, but my Notebooks were still in the browser in traditional JupyterLab.
Every time I loaded a Notebook I felt like I lacked the AI assistance I now
enjoyed in Cursor with `.py` files (the kind that execute all-at-once). I wanted
the Notebook environment and the AI. Now Jupyter does offer JupyterAI that can
connect to the AI model of your choice, but the user interface just isn't as
good as Cursor. And I was already paying the $20/mo. What I really wanted was
the Notebooks in Cursor. And it should be straight forward. But it wasn't.

## Understanding the Jupyter Kernel Requirements

Okay, so Jupyter Notebooks load just fine into VSCode and Cursor. The problem is
getting them to run the Notebook properly, with the ability to run each cell.
VSCode normally lets you run Python just by pumping it out to the embedded
terminal. But running Notebooks cell-by-cell is different. There has to be a
Jupyter Notebook IPython ***Python kernel*** running in the background. That's a
mouthful! But remember how Notebooks run? It's like the code execution is
"frozen" mid-run? That's a kernel. VSCode/Cursor needs one of those.

## The Critical Order of Operations

And so it comes down to a certain order sensitivity that you need to be aware
of. Notebook support in VSCode or Cursor, as it turns out comes form already
having Jupyter Notebook installed on your machine already in some form or
another. Pre-installed Juptyer comes in a lot of potential forms. Python users
might have `pip install jupyterlab` or `pip install notebook`. Data science
folks might have downloaded and installed Anaconda. There's a standalone
jupyterlab-desktop based on Electron available from GitHub. Or you might be
using a Nix Flake, such as part of the Pipualate project.

However you got the IPython kernel onto your machine, it needs to actually be
running for Notebooks to work in VSCode or Cursor. Otherwise, you get:

> Server Connection Error  
> A connection to the Jupyter server could not be established. JupyterLab will continue trying to reconnect. Check your network connection or Jupyter server configuration.

## The Solution: Pre-Running JupyterLab

Okay, so here's the trick. Run JupyterLab some other way before running VSCode
or Cursor. Make sure a running Python kernel instance is already in memory! You
do this by not only running JupyterLab some other way on your machine first, but
then also executing at least one cell of a notebook -- preferably the same
notebook you'll be using in VSCode or Cursor.

## Understanding the Technical Architecture

That's right. Think of VSCode/Cursor as only a shim or a wrapper for the proper
version of Jupyter Notebooks running in the background. I guess more
technically, you could say for the proper version of the even older product,
IPython, running in the background because as it turns out, even the nifty
web-based Jupyter is itself only a Node app cleverly connected to a running
instance of IPython, serving up a web user interface to the browser! So what
we're doing is forcing the official shim to IPython, JupyterLab, to get an
IPython kernel running in memory that VSCode or Cursor can also use.

## Connecting VSCode to Your Jupyter Kernel

Ta-DA! Now, it's still a wee bit nuanced. Once you've run JupyterLab and
executed one cell, hop on over to VSCode or Cursor and load up the same
Notebook. Try running a cell from there. It will immediately go into it's
auto-detect sequence and it might find it. If it doesn't (or possibly if it
finds multiple), it will end in a little `Select Kernel` button. Click it and
find the one that says `Python 3 (ipykernel)`, and you're set!

## Compatibility Across Platforms and Forks

You can now run the cells in VSCode or Cursor... and maybe Windsurf as well. And
maybe Codeium. There's a whole lotta VSCode forkin going on. And now that lovely
AI coding assistance that you're getting addicted to can be used on a Notebook
as well. And if you're like me on a kooky platform like NixOS, running
JupyterLab from a Nix Flake, under a Python virtual environment `.venv`, it
still doesn't matter. This trick still works.

If you still have problems, experiment with using the URL to connect
`http://localhost:8888/lab` when prompted.

## Introducing the Ultimate JupyterLab Solution

And I could stop the article right there, were it not for the fact that I have
another way for you to run JupyterLab on your machine -- I think the best way.

## Cross-Platform Considerations and Nix

If you're on Windows, you still have all those backslashes. Backslashes are
killers, I tell you! They keep any of your code from ever being cloud-friendly
or future-proofed. Macs are a little better, but not that much. Everything has
to be specially brewed, and is just not how you deploy to the cloud, either. But
Linux? Linux is fine. And you can have a Linux subsystem running out of folders
on your Windows/WSL or macOS systems with Nix Flakes.

First, install Nix:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- installspecially 
```

Then get Pipulate onto your system with either:

```bash
git clone git@github.com:miklevin/pipulate
```

...or just going to [Pipulate on GitHub](https://github.com/miklevin/pipulate)
and downloading the zip from the big green button and uncompress it. Then...

```bash
[mike@nixos:~/repos/pipulate]$ cd pipulate
[mike@nixos:~/repos/pipulate]$ nix develop
CUDA hardware detected.
#  ____  _             _       _       
# |  _ \(_)_ __  _   _| | __ _| |_ ___ 
# | |_) | | '_ \| | | | |/ _` | __/ _ \
# |  __/| | |_) | |_| | | (_| | ||  __/
# |_|   |_| .__/ \__,_|_|\__,_|\__\___|
#         |_|                          
Welcome to the Botifython development environment on x86_64-linux!

- Confirming pip packages...
- Done. 263 pip packages present.
- numpy is importable (good to go!)

To start JupyterLab, type: start
To stop JupyterLab, type: stop

To start the botifython server, type: python server.py

[mike@nixos:~/repos/pipulate]$ start
A JupyterLab tab will open in your default browser.
No tmux session named 'jupyter' is running.
If no tab opens, visit http://localhost:8888
To view JupyterLab server: tmux attach -t jupyter
To stop JupyterLab server: stop

[mike@nixos:~/repos/pipulate]$ start
```

And then you'll have JupyterLab running! It will pop open a web browser tab and
you can start using it there. Specifically, you can start a Notebook, run a
cell, and then switch over to Cursor where you can get some serious AI help. You
can even close the browser tab and even the terminal you ran it from. Jupyter
will continue running in the background until you type `stop` from a terminal
window where you `nix develop`'d from the pipulate folder.

Google tmux, if you must.

You're welcome.

## An AI Take

Alright, here's a brief summary of my article from my perspective:

[Moved to top]

Here are some title and headline ideas:

* **Titles:**
    * "Jupyter Notebooks in Cursor AI on NixOS: A Deep Dive"
    * "Unlocking AI Assistance for Jupyter Notebooks in Cursor"
    * "Nix Flakes and Jupyter: A Seamless Workflow in Cursor AI"
    * "Running Jupyter Notebooks in Cursor: A NixOS Solution"
* **Headlines:**
    * "Get AI Assistance in Cursor for Your Jupyter Notebooks (Even on NixOS!)"
    * "Solving the Jupyter Kernel Connection Error in VSCode/Cursor"
    * "The Ultimate Guide to Jupyter Notebooks and Cursor AI Integration"
    * "How to Run JupyterLab with Nix Flakes for Optimal Cursor AI Performance"

My opinion of the article:

The article provides a very detailed and specific solution to a niche problem, which is valuable for those in a similar situation. The author's personal journey and explanations of the technical nuances are helpful. The inclusion of Nix Flakes and Pipulate adds a layer of sophistication and portability to the solution. The tone is engaging, although the author's strong opinions on VSCode and other tools might not resonate with everyone. Overall, it's a useful guide for users seeking to integrate Jupyter Notebooks with Cursor AI in a complex environment.
