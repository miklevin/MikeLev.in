---
title: From Jupyer Notebooks to FastHTML with WebSockets
permalink: /futureproof/jupyter-notebooks-fasthtml/
description: I've been working in Jupyter Notebooks for years and love the flexibility they provide, but collaborating and scaling projects with them can be a challenge.  I'm excited to get back into web development with tools like FastHTML that simplify the process, and I'm particularly interested in using WebSockets to handle long-running tasks in my applications.  My goal is to create a streamlined workflow that combines the rapid prototyping of Jupyter Notebooks with the power and accessibility of web applications, all while maintaining a clean and manageable codebase.
layout: post
---

## Moving From Notebooks To Web Development With New Tools

I've been working in Jupyter Notebooks for years, and I think I'll continue
working in Notebooks, but now with FastHTML as a framework that reduces the Web
programming friction, and the AI assist that does much of the same, it's time to
actually get back into Web programming.

## The Allure of Notebooks in Data Science Workflow

Notebooks are fine and they can put off the need to take up the complexity of
actual web programming in many conditions. There's a "data science" workflow,
where you work really willy nilly, pip installing things left and right, running
and re-running code-blocks until it works. It's great for custom or long-running
work because you can make coding changes as you go and wait for sub-sections of
the program (code blocks) to finish running before you proceed, babysitting and
checking things as they go.

## Collaborating on Coding Projects Can Be Challenging

But if you're on a team and collaborating this sort of work, you might want to
distribute out the actual Notebook to your coworkers. Now no matter how much
Notebooks simplify coding, opening one up and seeing that code and being
expected to know what to do (no matter how much documentation you build in) can
be quite intimidating and add a lot of friction to the process; the process
being something like "Load this Notebook, change a few values and run the whole
thing".

## Scaling Limitations in Python Development

It doesn't matter how dashboard-like you try to make it, or how many ipywidgets
you use, you either get them up to speed on a certain level of **Python**
programming, or you just do the work yourself and remain a bottleneck. This is
particularly bad if you plan on "scaling". You can only scale yourself so much,
and so all roads eventually lead to Web development.

## Migrating to the Cloud: A Web App Workflow Nightmare

Okay, so you decide to move a previously Notebook-based workflow into a Web app,
fine. But now you've got a whole other can of worms, namely hosting and choosing
a tech stack that won't clobber you and require you to have a whole other career
trying to keep up to speed on the latest web framework and overly complex
"build" procedures.

## The Days of Generalist Web Development Are Back in a New Form

Sure there's AI now and everyone can be a programmer, but I challenge you to
actually create one and get it deployed and usable by your coworkers, staying on
the hook for upgrade and maintenance--all on the side, and not as your primary
job of just solving whatever problems. Notebooks and Web development are a means
to an end, but in the case of webdev in particular, it becomes an end in itself
because there's not enough hours in the day to do that plus something else. The
days of the jack-of-all-trades Webmaster are over. Or are they?

## The Awesomeness of Infrastructure as Code Simplification

And that's where today's post begins. Infrastructure as Code (IaC) is a terrible
name for the concept. If anything, it should have been Code as Infrastructure
(CaI), but I guess the IoT acronym predisposed us. Also, it doesn't properly
communicate the awesomeness of ***simplifying*** the DevOps aspect of this stuff
down to a text file that just works on everyone's machines the same way. A
single text-file that specifies a machine that will run your app is as good as
the machine that runs your app. 

## The Single Text File Defines Your Entire Development Environment

In fact, the single text-file that defines the machine that runs your app is as
good as the app itself, because it can specify the entirety of the app. This is
where git repositories (repos) come into play, because if one file defines your
entire development environment, then if that file is in a folder with all the
resources it requires, then it has everything necessary for running the app
itself. It just needs to be somewhere that knows how to do the "build".

## The Build Process Becomes Less Relevant In Modern Programming

Sigh, yes. You can't get away from some sort of build process. For those not in
the know, a "build" is an ahead-of-time process that you have to do before the
app is run so that it doesn't have to be done at the moment the app is run.
Traditionally, this is the compiled versus interpreted discussion, but there's
almost no such thing as interpreted anymore. Almost every popular mainstream
optimized programming language has some sort of o-code, p-code or just-in-time
(JIT) compiling that does some sort of mini-compile and creates some files to
keep around somewhere to speed up the next execution. Even so, they're still
often called interpreted languages, but since you don't have to deliberately
tell it to do the build, these languages are called "no build". So the compiled
versus interpreted debate has greatly become the build vs. no-build debate.

## Reducing Build Friction Essential for Efficient Development Process

I side on no-build. I side on reducing the friction of the creative process. You
want to make a change, refresh the browser to see the change, make another
change, refresh the browser to see the next change, and so on until your app is
done. Having an extra build step in there is a show-stopper for me. I don't even
want to have to manually restart a webserver to load the app back into memory.

## Converting Jupyter Notebooks to Flexibly Support AI Development

My job now is mostly to convert Jupyter Notebooks I have made in the past over
to Web apps. And even on new projects, I believe I will continue to rapidly
mock-up and prototype stuff in Notebooks, because it's just such a wonderful
environment. And for people who need that AI code assist that's popping up in
the form of GitHub Copilot and the Cursor AI editor, Project Jupyter has you
covered, as Jupyter AI is already an official plug-in. But this is not about
keeping Notebooks the primary viable platform. This is about flexibility,
supporting whatever is your AI poison. When I convert Notebooks to Web apps, I
believe my workflow in the near future is going to going from AI-assisted
JupyterLab to the new darling AI editor on the scene, Cursor.

When last my code-vomiting session left off, I was up to this magical piece of
Infrastructure as Code:

```nix
#       ____                      _       _                        .--.      ___________
#      |  _ \  __ _ _ ____      _(_)_ __ (_)_  __    ,--./,-.     |o_o |    |     |     |
#      | | | |/ _` | '__\ \ /\ / / | '_ \| \ \/ /   / #      \    |:_/ |    |     |     |
#      | |_| | (_| | |   \ V  V /| | | | | |>  <   |          |  //   \ \   |_____|_____|
#      |____/ \__,_|_|    \_/\_/ |_|_| |_|_/_/\_\   \        /  (|     | )  |     |     |
#                                                    `._,._,'  /'\_   _/`\  |     |     |
#      Solving the "Not on my machine" problem well.           \___)=(___/  |_____|_____|

# Most modern development is done on Linux, but Macs are Unix. If you think Homebrew and Docker
# are the solution, you're wrong. Welcome to the world of Nix Flakes! This file defines a complete,
# reproducible development environment. It's like a recipe for your perfect workspace, ensuring
# everyone on your team has the exact same setup, every time. As a bonus, you can use Nix flakes on
# Windows under WSL. Plus, whatever you make will be deployable to the cloud.

{
  # This description helps others understand the purpose of this Flake
  description = "A flake that reports the OS using separate scripts with optional CUDA support and unfree packages allowed.";
  
  # Inputs are the dependencies for our Flake
  # They're pinned to specific versions to ensure reproducibility
  inputs = {
    # nixpkgs is the main repository of Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # flake-utils provides helpful functions for working with Flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  # Outputs define what our Flake produces
  # In this case, it's a development shell that works across different systems
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # We're creating a custom instance of nixpkgs
        # This allows us to enable unfree packages like CUDA
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;  # This is necessary for CUDA support
          };
        };

        # These helpers let us adjust our setup based on the OS
        isDarwin = pkgs.stdenv.isDarwin;
        isLinux = pkgs.stdenv.isLinux;

        # Common packages that we want available in our environment
        # regardless of the operating system
        commonPackages = with pkgs; [
          python311                  # Python 3.11 interpreter
          python311.pkgs.pip         # Package installer for Python
          python311.pkgs.virtualenv  # Tool to create isolated Python environments
          figlet                     # For creating ASCII art welcome messages
          tmux                       # Terminal multiplexer for managing sessions
          zlib                       # Compression library for data compression
          git                        # Version control system for tracking changes
          curl                       # Command-line tool for transferring data with URLs
          wget                       # Utility for non-interactive download of files from the web
          make                       # Build automation tool for managing dependencies
          cmake                      # Cross-platform build system generator
          htop                       # Interactive process viewer for Unix systems
        ] ++ (with pkgs; pkgs.lib.optionals isLinux [
          gcc                        # GNU Compiler Collection for compiling C/C++ code
          stdenv.cc.cc.lib           # Standard C library for Linux systems
        ]);

        # This script sets up our Python environment and project
        runScript = pkgs.writeShellScriptBin "run-script" ''
          #!/usr/bin/env bash
          
          # Activate the virtual environment
          source .venv/bin/activate

          # Create a fancy welcome message
          REPO_NAME=$(basename "$PWD")
          PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo 

          # Install Python packages from requirements.txt
          # This allows flexibility to use the latest PyPI packages
          # Note: This makes the environment less deterministic
          echo "- Installing pip packages..."
          if pip install --upgrade pip --quiet && \
            pip install -r requirements.txt --quiet; then
              package_count=$(pip list --format=freeze | wc -l)
              echo "- Done. $package_count pip packages installed."
          else
              echo "Warning: An error occurred during pip setup."
          fi

          # Check if numpy is properly installed
          if python -c "import numpy" 2>/dev/null; then
            echo "- numpy is importable (good to go!)"
            echo
            echo "To start JupyterLab, type: start"
            echo "To stop JupyterLab, type: stop"
            echo
          else
            echo "Error: numpy could not be imported. Check your installation."
          fi

          # Create convenience scripts for managing JupyterLab
          # Note: We've disabled token and password for easier access, especially in WSL environments
          cat << EOF > .venv/bin/start
          #!/bin/sh
          echo "A JupyterLab tab will open in your default browser."
          tmux kill-session -t jupyter 2>/dev/null || echo "No tmux session named 'jupyter' is running."
          tmux new-session -d -s jupyter 'source .venv/bin/activate && jupyter lab --NotebookApp.token="" --NotebookApp.password="" --NotebookApp.disable_check_xsrf=True'
          echo "If no tab opens, visit http://localhost:8888"
          echo "To view JupyterLab server: tmux attach -t jupyter"
          echo "To stop JupyterLab server: stop"
          EOF
          chmod +x .venv/bin/start

          cat << EOF > .venv/bin/stop
          #!/bin/sh
          echo "Stopping tmux session 'jupyter'..."
          tmux kill-session -t jupyter 2>/dev/null || echo "No tmux session named 'jupyter' is running."
          echo "The tmux session 'jupyter' has been stopped."
          EOF
          chmod +x .venv/bin/stop
        '';

        # Define the development shell for Linux systems (including WSL)
        linuxDevShell = pkgs.mkShell {
          # Include common packages and conditionally add CUDA if available
          buildInputs = commonPackages ++ (with pkgs; pkgs.lib.optionals (builtins.pathExists "/usr/bin/nvidia-smi") cudaPackages);
          shellHook = ''
            # Set up the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            # Customize the prompt to show we're in a Nix environment
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH

            # Set up CUDA if available
            if command -v nvidia-smi &> /dev/null; then
              echo "CUDA hardware detected."
              export CUDA_HOME=${pkgs.cudatoolkit}
              export PATH=$CUDA_HOME/bin:$PATH
              export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
            else
              echo "No CUDA hardware detected."
            fi

            # Run our setup script
            ${runScript}/bin/run-script
          '';
        };

        # Define the development shell for macOS systems
        darwinDevShell = pkgs.mkShell {
          buildInputs = commonPackages;
          shellHook = ''
            # Set up the Python virtual environment
            test -d .venv || ${pkgs.python311}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            # Customize the prompt to show we're in a Nix environment
            export PS1='$(printf "\033[01;34m(nix) \033[00m\033[01;32m[%s@%s:%s]$\033[00m " "\u" "\h" "\w")'
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath commonPackages}:$LD_LIBRARY_PATH

            # Run our setup script
            ${runScript}/bin/run-script
          '';
        };

      in {
        # Choose the appropriate development shell based on the OS
        devShell = if isLinux then linuxDevShell else darwinDevShell;  # Ensure multi-OS support
      });
}
```

## Darwinix: A Flexible Unix-Like OS for Efficient System Building

It's called Darwinix, for the win! Or would that be Darwin for the Apple Unix?
Or would that be asterisk-nix for Unix/Linux-like OSes? Or would that be nix for
the NixOS package manager that makes this IaC stuff so effective? Yes! And you
can find it here:
[https://github.com/miklevin/darwinix](https://github.com/miklevin/darwinix)

## The Power of Nix in System Development and Maintenance

Foundational work sucks, because foundational work takes so much work, and then
inevitably all changes in a couple of years when you go back to look at it
again. That may even be the case here, but so long as the systems can still be
built from Nix, adjusting the foundations is just adjusting a single text file.
And that makes so much difference in terms of lowering fatigue, keeping your
motivation and initiative from receiving a punch in the stomach, and generally
future-proofing yourself and your work. You can adjust fast because since an
entire system-build is so nixaliciously easy, it's like adjusting the shape of
icebergs from your fingertips.

## Simplifying Web Development with Lightweight Frameworks

Now if the foundational ***web framework*** changes, like 10 versions of `node`
and `react`, then I can't help you. My advice for the small-time Web developer
like me is to get the frig off the hamster wheel of heavyweight js-frameworks.
Those are the ones with the long, complicated "build" (in the build vs. no-build
debate) procedures. The complexity of the builds is rivaled only by the
complexity of the components and sheer number of files involved. Once on a
framework like those, it generally forces you into VSCode as your editor, or
some other proprietary IDE geared towards alleviating their particular workflow.
Otherwise, these frameworks would be unusable based on their sheer complexity.
Getting a basic `Hello World` going is easy under React, Vue or Svelte, but if
when you try to go farther you fall off a cliff.

## Rediscovering My Passion for Web Development with Darwinix

Well, the current state of the Nix Flake that I've coined `Darwinix` serves as a
great place to derive a nice web development platform on, now that there's one
that actually appeals to me again. I'm from the Linux LAMP days where you chose
between the Linux, Apache, MySQL, PERL/PHP/Python platform or the Microsoft
IIS/ASP/SQLServer platform. Netscape was sort of still in the picture, but
dying. So the tech choices were pretty limited, so you could learn one and use
your excess capacity to learn all the rest of the not yet mind-bogglingly
complex parts, and turn yourself into a full-fledged Webmaster. I loved those
days. I could have empire-built and become some sort of tech billionaire, but I
was clueless and was really just into playing around with the tech. I loved it.

But the love got sucked out of it as the Web developed and Conway's Law combined
with Parkinson's Law to create an unholy alliance of enshitification. What am I
talking about? Hey Perplexity, help me enlighten the folks.

---

## Understanding Conway's Law and Parkinson's Law in Organizational Design

Perplexity.AI: The law you're referring to is known as Parkinson's Law. While
Conway's Law deals with organizational structure and system design, Parkinson's
Law addresses how work expands to fill the time available for its completion.
Let's compare these two laws and explore their implications:

## Conway's Law

Conway's Law states that organizations design systems that mirror their own
communication structure[1]. In software development, this means that the
architecture of a system often reflects the structure of the team that built it.

## Parkinson's Law

Parkinson's Law, on the other hand, observes that work expands to fill the time
available for its completion. In the context of software development and project
management, this can be extended to resources in general, not just time.

## Comparison

**Scope:**
- Conway's Law: Focuses on system design and organizational structure
- Parkinson's Law: Addresses resource utilization and task expansion

**Application:**
- Conway's Law: Often used in software architecture and team organization
- Parkinson's Law: Applicable to project management and resource allocation

**Implications:**

- Conway's Law: Suggests aligning team structure with desired system
  architecture
- Parkinson's Law: Warns against overallocation of resources and emphasizes
  efficient planning

## Parkinson's Law in Software Development

In software development, Parkinson's Law can manifest in several ways:

1. **Feature creep:** As more time or resources become available, there's a tendency to add more features, potentially complicating the project.
2. **Overengineering:** With excess time or resources, developers might create overly complex solutions to simple problems.
3. **Inefficient resource use:** Teams may unconsciously slow down work to fill the allocated time, rather than completing tasks efficiently.
4. **Budget expansion:** Projects may consume all available budget, even if the core requirements could be met with less.

## Mitigating Parkinson's Law

To counteract the effects of Parkinson's Law in software development:

1. **Set clear, specific goals:** Define project scope and deliverables precisely.
2. **Use time-boxing:** Allocate fixed time periods for tasks to encourage efficiency.
3. **Implement agile methodologies:** Short sprints and regular reviews can help maintain focus and prevent unnecessary expansion.
4. **Encourage a minimum viable product (MVP) approach:** Focus on delivering core functionality before adding extra features.
5. **Regular progress reviews:** Conduct frequent check-ins to ensure work is progressing efficiently and resources are being used effectively.

By understanding both Conway's Law and Parkinson's Law, software development
teams can better structure their organizations, design their systems, and manage
their resources for optimal efficiency and effectiveness.

---

## Being a 1-Person App Developer Is Totally Doable

Teams? We don't need no stinkin teams. We can be a 1-person rogue maverick web
developer on the side in our organization and thumb our nose first at Conway,
then at Parkinson, then develop an app on our local machines and screenshare our
coworkers into a stunning experience. When they ask where they can reach it,
tell them `localhost:5001`, haha! 

## The Complexity of Hosting Web Applications

But no, really these web apps are a cinch to host on your home machine (free,
aka localhost), but then take a bit deeper know-how and money to host on a
publicly accessible website. Suddenly, it's publicly accessible and you have to
deal with login (which has both multi-user and security issues in how the app is
designed), as well as potential scaling issues. It gets back to the fact that
everything is easy in Notebooks, but then when you make it a Web app, complexity
explodes. Complexity explodes due to web frameworks. Complexity explodes due to
multi-user support, security, hosting and costs. And finally, complexity
explodes due to the implied level of support you have to give that Web app now
forever forward, adding a little slice of cumulative maintenance technical
liability to your life which you really have to pay attention to like its your
new full-time job, because if people use it and come to rely on it and it
breaks, you look like a bozo. I generally avoid switching ad hoc Notebook work
to Web applications if I can help it.

## The Power of Nix Flakes in Simplifying Web Development

But the world has changed. Notebooks alone are insufficient, and you sometimes
just have to bite the bullet and eliminate all the complexity for the user who
isn't going to want to run it in a Notebook. But thanks to Nix Flakes and the
incredible reliability of taking control of an app running on ***their
localhost***, everything is different. Web apps that aren't really on the Web
are now on the table, in which case we lower-case the "W", and they're web apps.
For those not familiar, Web is upper-cased because it's a proper noun, like the
Internet. But there are also internets and webs. It just means it's not ***the
Internet*** or ***the Web***, but rather some generic internet or web not part
of the main thing. So we can create ***web apps*** (running on localhost)
without them being on the ***Web***. And ***that*** is a bandwagon I can jump
on.

## Why You Should Be Cautious When Offering A Web App

If push comes to shove and somebody really wants what you create as a lower-case
web app as an upper-case Web app, then you rope them and their resources into
solving the hosting, costs, maintenance, security and related exploding
complexity and tech liability issues. It's like sure, what I've written can be
deployed to the cloud. I can do it in the next five minutes. Is it okay the
world to potentially have all that data? Because I don't know if I can secure
it. And how about compliance laws? Do you want to take that risk? How about as
an alternative we just screenshare them in so they can see the app run? Or if
they really need the app themselves, how about we just send them this `nix
flake` and the install instructions?

## FastHTML Enables Web Development Side by Side with JupyterLab

Okay, you get the idea, I hope. That previous Nix Flake only brings things as
far as a JupyterLab environment for running Notebooks. But it's ready to go
side-by-side with a Python-centric, beautifully simplified no-build web
development environment called FastHTML.

## FastHTML Builds on Existing Technologies for Lightweight API

FastHTML is built on a few other technologies that solved a lot of the difficult
problems, then does the final lightweight gluing together into a completely
sensible lightweight API. This in the spirit of Python's massively popular Flask
web microframework that builds upon the Werkzeug package to route http requests
to Python functions and the Jinja2 templates to provide a PHP-like curly brace
HTML templating system. There's tons of other frameworks now that have been
inspired by Flask, and even supplanted it in many cases, namely FastAPI. 

## FastHTML Built on Uvicorn and Starlette for Modernized Flask Experience

Instead of Werkzeug, FastHTML uses the combination of Uvicorn and Starlette for
its web server and ASGI implementation. This represents a general ground-up
modernization of Flask, but while keeping API-compatibility. Most people miss
this nuanced fact about Python frameworks replacing each other. Unlike in the
JavaScript world where APIs are radically different from say Angular to React,
and when you switch from one to the other you have to redesign everything,
Python strives to continuously reuse timeless underlying APIs and you can switch
from Flask to FastHTML seamlessly. 

## Python Takes Stable Winning APIs as Serious Conventions

You see the same thing in the Pandas data science package which set the tone of
the API, but things that need to deal with larger datasets or multi-dimensional
arrays have adopted similar APIs while improving performance and capabilities. 
For example, Polars offers a Pandas-like interface for significantly faster data
processing of large datasets. Similarly, Xarray extends the Pandas API to work
with labeled multi-dimensional arrays (versus SQL-like row & columns).

In both cases, users familiar with super-popular Pandas can transition to these
more specialized tools with minimal changes to their code, muscle-memory and
know-how (more future-proofing strategy here). This is typical in the Python
world and doesn't get enough coverage. So switching from Flask, which Python
people just pick up as a matter of course over time, to FastHTML is a
no-brainer. This was critical in winning me back to having an open mind about
webdev again.

## Surviving the AI-Disrupt: A Tech Enthusiast's New Focus

But these next few chisel-strikes to make it a reality have to be very careful
and measured. Otherwise, things go out of control and I lose the love for it.

This is about infusing tech enthusiasm viability into the next 2 to 5 years
before things change enough again for another major-ish recalibration. I made it
through this recalibration mostly unscathed, given my Linux, Python, vim & git
(LPvg) focus of the past few decades. It's survived quite a few disruptions, and
the test now is whether it survives the AI-disrupt. I've also expanded what that
minimal tech stack platform really means to me, adding Jupyter Notebooks as an
extension of Python as an honorary member of the short stack. And in a similar
sense, I'm adding Nix and NixOS as an honorary extension of Linux.

## Adding FastHTML Stack to Multi-OS Notebook for Clean Development

Now, with this multi-OS Notebook-friendly Nix Flake in-hand, it's time to add
short stack web development capabilities, FastHTML in particular. I've frankly
already done this on vastly more complex versions of this nix flake documented
earlier in this blog. Only now, I'm going to do it cleanly and cautiously so I
don't lose control due to AI meandering. So I've already attended to all the
data science stuff. Technically, I could do a few more things to ensure the cuda
components I took the time to make sure were active actually get used by the
pandas stuff that could benefit from it, but that requires a few conditional pip
installs and could be a rabbit hole. 

## To Stream or Not to Stream is Not The Question

I have to finish fleshing out the main component pieces. I already decided I'm
using FastHTML for all the reasons discussed earlier in this blog, but when I
implemented my first web app in it, I was going fast and furious and ended up
using something called ZeroMQ, for zero-wait message queue, or just zmq for
short. I knew it from the past and I believe it is or was the reason Jupyter is
so responsive of a web app. Whole nodejs servers are more popularly used for
this sort of stuff, and since Python gained asynchronous support, more formal
ways of doing this stuff have popped up. Starlette, the Flask-like thing that
FastHTML sits on, supports all this async stuff, being the modernized ASGI
version. 

## Conquering Continuous Message-Streaming for Efficient In-App Performance

So anyway, my first order of business is just a little bit more than the
FastHTML "Hello World" app which I've already done. What I need to conquer next
is continuous message-streaming in-app. It's a bit odd, but a large part of what
I do is long-running tasks which very well may be run by the very same
`filename.py` file that's running the webserver. Why look in multiple places to
see what's going on if you can look in just one file? It's an anti-pattern for
sure, but a ton of stuff I'm doing here is. I'm feeling emboldened by AI and
DHH. While none of this is Ruby on Rails, it does invoke it's spirit a bit. The
whole no-build mindset, for example.

## Starlette Handles Routing and WebSocket Integration in FastHTML

Okay, so long-running requests. FastHTML is built on Starlette. Starlette is to
FastHTML what Werkzeug is to Flask. It handles what the industry has come to
call routing, but is what maps web URL requests to particular Python functions.
It's what lets you out those little @decorators on top of a function to *wrap*
one function inside another. It's a bit of mind-bending syntactical sugar, but
it's great for using Python for web development. I wish people would say that
more clearly. But I bring it up because Starlette also handles WebSockets, the
thing that's being used for chat applications in web browsers so much lately.
There used to be other ways, but WebSockets has sort of formalized into the
right way, although it has a bit more complexity than I'd like. So pardon me
while I dive into an AI dialogue while I sort it out.

---

**Me**: What's more popular these days, zmq or websockets?

**ChatGPT 4o**: WebSockets are generally more popular and widely used these days
compared to ZeroMQ, especially for web applications that require real-time
communication, such as online multiplayer games, live data feeds, and chat
applications. This is primarily because WebSockets are natively supported by web
browsers and provide a full-duplex, low-latency connection between a client and
server, making them suitable for many real-time web use cases.

On the other hand, ZeroMQ is favored in scenarios where speed and flexibility
are paramount, such as distributed systems or applications that need low-level
control over the messaging layer. ZeroMQ can outperform WebSockets in terms of
throughput, and it supports a wide range of transports, including TCP,
inter-process communication (IPC), and multicast, making it ideal for highly
concurrent or high-performance use cases.

In terms of popularity, WebSockets are more accessible and commonly chosen for
typical web development projects, whereas ZeroMQ is more specialized and used in
niche areas like financial services, high-frequency trading, or IoT systems that
require custom transport protocols.

---

**Me**: Can you give me the most basic hello world example of websockets?


**ChatGPT 4o**: Here’s a basic “Hello, World!” example using WebSockets with Python.
This example uses the websockets library, which is a popular choice for handling
WebSocket communication in Python.

Step 1: Install the websockets library

If you don’t already have the library installed, run:

```bash
pip install websockets
```

Step 2: Create a WebSocket Server

Save this code as server.py:

```python
# server.py
import asyncio
import websockets

async def hello(websocket, path):
    # Send a hello message to the client
    await websocket.send("Hello, World!")
    # Wait for a response from the client
    response = await websocket.recv()
    print(f"Received message from client: {response}")

# Start the WebSocket server
start_server = websockets.serve(hello, "localhost", 8765)

# Run the server until it is manually stopped
asyncio.get_event_loop().run_until_complete(start_server)
print("WebSocket server started at ws://localhost:8765")
asyncio.get_event_loop().run_forever()
```

Step 3: Create a WebSocket Client

Save this code as client.py:

```python
# client.py
import asyncio
import websockets

async def hello():
    # Connect to the WebSocket server
    async with websockets.connect("ws://localhost:8765") as websocket:
        # Receive the "Hello, World!" message from the server
        greeting = await websocket.recv()
        print(f"Server says: {greeting}")
        
        # Send a response back to the server
        await websocket.send("Hello from the client!")

# Run the client
asyncio.get_event_loop().run_until_complete(hello())
```

Step 4: Run the Server and Client

1. Open two terminal windows.
2. Run the server script in one terminal:

```bash
python server.py
```

3. Run the client script in the other terminal:

```bash
python client.py
```

Expected Output

When you run the server and client, you should see:

- On the server side:

```
WebSocket server started at ws://localhost:8765
Received message from client: Hello from the client!
```

- On the client side:

```
Server says: Hello, World!
```

This is a basic example of WebSocket communication between a server and a
client. The server sends a “Hello, World!” message, and the client responds back
with “Hello from the client!”.

---

Me: Interesting! Please give me the hello world for zeromq (zmq) now please.  


ChatGPT 4o: Here’s a basic “Hello, World!” example using ZeroMQ (zmq) with Python. This example demonstrates a simple request-reply pattern between a server (which responds with “World”) and a client (which sends “Hello”).

Step 1: Install the pyzmq library

If you don’t already have the library installed, run:

pip install pyzmq

Step 2: Create a ZeroMQ Server

Save this code as server.py:

```python
# server.py
import zmq

# Create a ZeroMQ context
context = zmq.Context()

# Create a REP (reply) socket
socket = context.socket(zmq.REP)
# Bind the socket to a local address and port
socket.bind("tcp://*:5555")

print("ZeroMQ server started at tcp://localhost:5555")

# Wait for client requests and respond
while True:
    # Wait for the next request from the client
    message = socket.recv_string()
    print(f"Received request: {message}")

    # Send back the response
    socket.send_string("World")
```

Step 3: Create a ZeroMQ Client

Save this code as client.py:

```python
# client.py
import zmq

# Create a ZeroMQ context
context = zmq.Context()

# Create a REQ (request) socket
socket = context.socket(zmq.REQ)
# Connect to the server
socket.connect("tcp://localhost:5555")

# Send a request to the server
print("Sending request: Hello")
socket.send_string("Hello")

# Receive the server's response
message = socket.recv_string()
print(f"Received reply: {message}")
```

Step 4: Run the Server and Client

1. Open two terminal windows.
2. Run the server script in one terminal:

```python
python server.py
```

3. Run the client script in the other terminal:

```python
python client.py
```


Expected Output

When you run the server and client, you should see:

- On the server side:

```
ZeroMQ server started at tcp://localhost:5555
Received request: Hello
```

- On the client side:

```
Sending request: Hello
Received reply: World
```


Explanation

- Server:
- Uses a REP (reply) socket to listen for incoming requests from clients.
- When a client sends a message (e.g., “Hello”), the server receives it and replies with “World”.
- Client:
- Uses a REQ (request) socket to send a “Hello” message to the server.
- Waits for the server’s response and prints it (e.g., “World”).

This example shows the simplest way to create a request-reply pattern using
ZeroMQ in Python. It demonstrates the basic workflow of sending and receiving
messages using the zmq library.

---

Me: Okay so I'm writing a single page application in fasthtml which is basically
starlette with HTMX. There will be htmx endpoints which start long-running tasks
that need to stream communication back to the initial calling page. I won't be
running separate server and client files in separate terminals. I tell all be
under a single .py file but it's an asgi server and can do stuff asynchronously.
So you get it? Parts are talking to themselves, but still a mechanism is
necessary to send streaming messages back from Ajax calls. Does that make sense?
Analyze the problem and break down the best potential solutions. 


ChatGPT 40: Given the problem context, where a single ASGI-based application
handles asynchronous, long-running tasks with real-time communication back to
the browser using HTMX, the solution must account for several key aspects:

1. Long-Running Task Management: Since long-running tasks can block the main thread, they should be run asynchronously in the background.
2. Real-Time Communication: HTMX and AJAX requests don’t directly support server-sent events (SSE) or WebSocket-like behavior. However, it is possible to use mechanisms like WebSockets or SSE to send updates back to the frontend.
3. Intra-Process Communication: You want to communicate back to the original calling context (HTMX-triggered endpoint) within the same application instance. Since this isn’t a multi-file setup, you need to manage communication without external servers or files.

Potential Solutions

1. Using Server-Sent Events (SSE):
  - How It Works: Server-Sent Events allow you to stream messages from the
    server to the client over HTTP. It’s easy to implement with Starlette and
    can be integrated with HTMX using an <iframe> or a hidden <div> that listens
    for updates.
  - Implementation: You can create an SSE endpoint in Starlette that streams
    events based on the progress of your long-running task. The browser can
    consume these events and update the UI accordingly.
  - Pros: Simple to implement, supported by browsers, and integrates well with
    HTMX.
  - Cons: Unidirectional communication (server-to-client only), and not as
    powerful as WebSockets.
2. Using WebSockets:
  - How It Works: WebSockets provide a full-duplex communication channel between
    the client and the server. With Starlette, you can create a WebSocket
    endpoint and push updates from your long-running task back to the client in
    real time.
  - Implementation: Create a WebSocket route in your Starlette app and, upon
    connection, subscribe to events that your background tasks publish. Use a
    UUID or session ID to match tasks with WebSocket connections.
  - Pros: Full-duplex communication, real-time updates, and robust handling of
    asynchronous communication.
  - Cons: Slightly more complex to implement and manage than SSE, especially for
    matching HTMX-triggered events with WebSocket connections.
3. Using asyncio.Queue for Message Passing:
  - How It Works: Since the long-running tasks are managed asynchronously, you
    can use asyncio.Queue for internal message passing within the application
    context. The HTMX-triggered endpoint can subscribe to a queue and stream
    results back to the client incrementally using SSE.
  - Implementation: Create an asyncio.Queue for each request that expects
    updates. Use the queue to pass messages between your long-running task and
    the HTMX endpoint, which then streams results back using Response or SSE.
  - Pros: Efficient intra-process communication, no external servers needed,
    easier to manage with async.
  - Cons: Managing multiple queues for multiple clients can get complex.
4. Combining Background Tasks with HTMX Polling:
  - How It Works: This approach involves running long-running tasks in the
    background and having the frontend poll a separate endpoint to get the
    status of the task.
  - Implementation: Use the BackgroundTasks feature of Starlette to run tasks in
    the background, and have an HTMX endpoint that the frontend periodically
    queries for status updates.
  - Pros: Simplifies server-side communication.
  - Cons: Involves repeated HTTP calls, which can be less efficient than
    streaming.

Recommended Solution: WebSockets with asyncio.Queue

Given the real-time nature of the communication and the need to manage async
tasks within the same process, a combination of WebSockets and asyncio.Queue is
a robust solution.

Implementation Approach:

1. Create WebSocket Connection: Use Starlette’s WebSocket support to establish a WebSocket connection when the HTMX request is made.
2. Task Management with asyncio.Queue: When a long-running task starts, create an asyncio.Queue to hold status updates. The task can push updates to this queue.
3. Streaming Updates: The WebSocket endpoint can read from the queue and send updates to the frontend. The frontend can then dynamically update the page based on the WebSocket messages.
4. Clean-up: Once the task is complete, close the WebSocket connection and clean up the queue.

Code Example: WebSocket with asyncio.Queue

```python
import asyncio
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from starlette.websockets import WebSocketState

app = FastAPI()

# Global dictionary to hold queues for communication between tasks and WebSocket connections
task_queues = {}

@app.get("/")
async def get():
    return """
    <!DOCTYPE html>
    <html>
        <head>
            <title>WebSocket with FastAPI</title>
            <script type="text/javascript">
                function startTask() {
                    let ws = new WebSocket("ws://localhost:8000/ws");
                    ws.onmessage = function(event) {
                        document.getElementById("log").innerHTML += "<br>" + event.data;
                    };
                    ws.onclose = function() {
                        document.getElementById("log").innerHTML += "<br>Task complete.";
                    };
                }
            </script>
        </head>
        <body>
            <h1>FastAPI WebSocket Example</h1>
            <button onclick="startTask()">Start Long Task</button>
            <div id="log"></div>
        </body>
    </html>
    """

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    queue = asyncio.Queue()
    task_id = id(websocket)
    task_queues[task_id] = queue

    try:
        # Start long-running task in the background
        asyncio.create_task(long_running_task(queue))

        # Stream messages from the queue to the WebSocket
        while True:
            message = await queue.get()
            if websocket.application_state == WebSocketState.CONNECTED:
                await websocket.send_text(message)
            else:
                break
    except WebSocketDisconnect:
        pass
    finally:
        del task_queues[task_id]

async def long_running_task(queue):
    for i in range(5):
        await asyncio.sleep(1)  # Simulating a long task
        await queue.put(f"Step {i + 1} completed")
    await queue.put("Task complete")
```

Explanation of the Code:

1. Main Page: A simple HTML page with a button that initiates a WebSocket connection.
2. WebSocket Endpoint: The /ws endpoint starts a long-running task and streams its progress through a shared asyncio.Queue.
3. Long-Running Task: A background task that simulates a time-consuming process and sends updates to the WebSocket.

This solution keeps everything in a single Python file, uses the ASGI
framework’s async capabilities, and streams messages back to the frontend
efficiently.

---

Alright, so there's my next step. However, the `Darwinix` Nix Flake for multi-OS
support is such a clean pristine example, I'm not going to risk ruining it by
incorporating feature creep. No, instead this is where we move the work over to
Pipulate, since this becomes the infrastructure foundation for the next revision
of my free and open source SEO software package, just in time for the rise of
AI. And of course when I do proprietary stuff, it will be built on that.

<div class="mermaid">
graph LR
    A[Darwinix] --> B[Pipulate] --> C[Proprietary]
</div>

Okay, I moved all the recent pipulate work into a wip (work in progress) folder
and put the darwinix base nix flake, requirements.txt and ollama_check.py in
there. Speaking of which, let's check Ollama connectivity...

```bash
(nix) [mike@nixos:~/repos/pipulate]$ python ollama_check.py 
Using model llama3.2:latest
Raring to ruminate.
(nix) [mike@nixos:~/repos/pipulate]$
```

Okay, so I will have the thing doing the chatting. Now let's drop that
recommended solution: WebSockets with asyncio.Queue, into place.

Okay, the code example ChatGPT 4o gave me at first as the `Hello World` of
WebSockets didn't work, so I worked with Claude 3.5 Sonnet in Cursor AI until we
worked it out, and this code sample is working. But I had to run it with a
special `uvicorn` command:

    uvicorn server:app --host 0.0.0.0 --port 8000 --reload

## The working WebSockets Hello World code:

```python
import asyncio
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from starlette.websockets import WebSocketState
from fastapi.responses import HTMLResponse  # Add this import

app = FastAPI()

# Global dictionary to hold queues for communication between tasks and WebSocket connections
task_queues = {}

@app.get("/", response_class=HTMLResponse)  # Specify the response class
async def get():
    return """
    <!DOCTYPE html>
    <html>
        <head>
            <title>WebSocket with FastAPI</title>
            <script type="text/javascript">
                function startTask() {
                    let ws = new WebSocket("ws://localhost:8000/ws");
                    ws.onmessage = function(event) {
                        document.getElementById("log").innerHTML += "<br>" + event.data;
                    };
                    ws.onclose = function() {
                        document.getElementById("log").innerHTML += "<br>Task complete.";
                    };
                }
            </script>
        </head>
        <body>
            <h1>FastAPI WebSocket Example</h1>
            <button onclick="startTask()">Start Long Task</button>
            <div id="log"></div>
        </body>
    </html>
    """

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    queue = asyncio.Queue()
    task_id = id(websocket)
    task_queues[task_id] = queue

    # Start keep-alive task
    asyncio.create_task(keep_alive(websocket))

    try:
        # Start long-running task in the background
        asyncio.create_task(long_running_task(queue))

        # Stream messages from the queue to the WebSocket
        while True:
            message = await queue.get()
            if websocket.application_state == WebSocketState.CONNECTED:
                await websocket.send_text(message)
            else:
                break
    except WebSocketDisconnect:
        pass
    finally:
        del task_queues[task_id]

async def long_running_task(queue):
    for i in range(5):
        await asyncio.sleep(1)  # Simulating a long task
        await queue.put(f"Step {i + 1} completed")
    await queue.put("Task complete")

# Add a keep-alive mechanism to ensure the connection remains open
async def keep_alive(websocket: WebSocket):
    while True:
        await asyncio.sleep(10)  # Send a ping every 10 seconds
        if websocket.application_state == WebSocketState.CONNECTED:
            await websocket.send_text("ping")  # Optional: send a ping message
```

...with output that looks like:

    FastAPI WebSocket Example

    [Start Long Task] <--button

    Step 1 completed
    Step 2 completed
    Step 3 completed
    Step 4 completed
    Step 5 completed
    Task complete
    ping
    Step 1 completed
    Step 2 completed
    Step 3 completed
    Step 4 completed
    Step 5 completed
    Task complete
    ping
    ping
    ping
    ping
    ping
    ping

Wow, so I've got Websocket communication. Let's commit that to pipulate and
systematically work up from here.

Okay, with the pre-FastHTML WebSockets test a success, we can move onto
finagling the equivalent behavior out of [the FastHTML WebSockets API
implementation](https://docs.fastht.ml/explains/websockets.html) 

Success! Well, of a sort. This is simply success simulating the chat app that
they include on the FastHTML website. It's not the long-running task simulation
that I want, but it is WebSockets communication with just FastHTML code. And the
command to start the server is a nice traditional Python one and not that
convoluted uvicorn thing...

```bash
python server.py
```

...and here's the code:

```python
from fasthtml.common import *

app = FastHTML(ws_hdr=True)  # Enable WebSocket header
rt = app.route

# Home route
@rt('/')
def home():
    cts = Div(
        Div(id='notifications'),  # Div to display notifications
        Form(Input(id='msg'), id='form', ws_send=True),  # Form to send messages
        hx_ext='ws',  # Enable HTMX WebSocket extension
        ws_connect='/ws'  # Connect to the WebSocket endpoint
    )
    return Titled('WebSocket Test', cts)

# WebSocket connection management
users = {}

def on_conn(ws, send):
    users[str(id(ws))] = send  # Store the send function for the connected user

def on_disconn(ws):
    users.pop(str(id(ws)), None)  # Remove the user on disconnect

# WebSocket route
@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str, send):
    await send(Div('Hello ' + msg, id='notifications'))  # Send a greeting message
    # Optionally, you can broadcast the message to all connected users
    for u in users.values():
        await u(Div('User said: ' + msg, id='notifications'))

# Start the server
serve()
```

Ugh! It's taken me lots of little tries, but I finally have something close to
the barebones minimum template for long-running tasks using WebSockets under
FastHTML. I can strip out FastAPI, ZeroMQ (zmq) and all the other approaches I
was looking at to pull this off. This looks like the smallest, simplest amount
of code yet I've seen to do this long-running task invocation from an HTMX link
thing. This might sound like gobbledygook, but believe me this is fundamental.
This is my Pipulate app I'm working on, and long-running background tasks on a
local webserver is what it is to pipulate. And here's that success assured
moment...

```python
from fasthtml.common import *
import asyncio

app, rt = fast_app(ws_hdr=True)

msgs = []
@rt('/')
def home(): return Div(
    Div("foo", id='msg-list'),
    Form(Input(id='msg', name='msg', placeholder='Type a message...'),  # Input for new messages
         Button("Send", type='submit', ws_send=True)),  # Button to send message
    hx_ext='ws',  # Enable HTMX WebSocket extension
    ws_connect='/ws'  # Connect to the WebSocket endpoint
)

users = {}
def on_conn(ws, send): users[str(id(ws))] = send
def on_disconn(ws): users.pop(str(id(ws)), None)

@app.ws('/ws', conn=on_conn, disconn=on_disconn)
async def ws(msg: str):
    if msg:  # Check if the message is not empty
        msgs.append(msg)  # Append the message to the list
        # Simulate a long-running task
        await long_running_task(msg)  # Call the long-running task

async def long_running_task(msg: str):
    # Simulate a long-running task
    for i in range(5):
        await asyncio.sleep(1)  # Simulate processing time
        # Send progress updates to all users
        for u in users.values():
            await u(Div(f"Processing '{msg}'... Step {i + 1}/5", id='msg-list'))

    # Final update after the task is complete
    for u in users.values():
        await u(Div(f"Task complete for message: '{msg}'", id='msg-list'))

serve()
```

I've got me a lot of refactoring to do from my previous zmq version. This is
much better. Lean into FastHTML!
