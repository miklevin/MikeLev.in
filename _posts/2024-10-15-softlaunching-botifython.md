---
title: Soft Launching Botifython
permalink: /soft-launching-botifython/
description: My journey upgrading Botifython's Pipulate fork with Nix flakes, transforming Jupyter Notebooks into web apps, and deploying to coworkers. From FOSS to proprietary shifts, embracing infrastructure as code, and automating SEO workflows—crafting tech with passion and precision.
layout: post
sort_order: 1
---

## Pipulate Framework Ready for Coworker Rollout After Development Milestones

I pushed hard to clean up and prep the Botifython fork of Pipulate to be ready
to roll out to my coworkers... almost. I still have to plug the apps in. The
actual ports of an existing web app, the first I cut my FastHTML teeth on, and
one that exists only in a Juptyer Notebook, into the new framework. But the new
framework is in MVP (minimum viable product) state, and yesterday I got the git
deployment trick down. Today, I make it accessible to my coworkers. As time
allows, I'll extract the free and open source software (FOSS) bits and put it
back into Pipulate.

## Upgrading Botifython Fork to Make It Accessible to Coworkers

The nix flake now does an automatic git pull to update the repo every time you
nix develop from it, but I don't want that to be the default state of the
Pipulate FOSS version, so I have to update the flake:

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
        # Define the project name variable here
        projectName = "pipulate";

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
          cmake                      # Cross-platform build system generator
          htop                       # Interactive process viewer for Unix systems
        ] ++ (with pkgs; pkgs.lib.optionals isLinux [
          gcc                        # GNU Compiler Collection for compiling C/C++ code
          stdenv.cc.cc.lib           # Standard C library for Linux systems
        ]);

        # This script sets up our Python environment and project
        runScript = pkgs.writeShellScriptBin "run-script" ''
          #!/usr/bin/env bash
          
          # Use the projectName variable
          REPO_NAME="${projectName}"
          REPO_NAME=''${REPO_NAME%-main}  # Remove "-main" suffix if it exists
          PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo 

          # Only perform git operations if projectName is "botifython"
          if [ "${projectName}" = "botifython" ]; then
            # Decrypt the private key
            # Check if key is in .ssh/
            if [ -f ./.ssh/rot ]; then
              cat ./.ssh/rot | tr 'A-Za-z' 'N-ZA-Mn-za-m' > ./.ssh/key
              chmod 600 ./.ssh/key
            fi

            # Check if there is a .git folder
            if [ -d .git ]; then
              echo "Pulling latest changes from git..."
              GIT_SSH_COMMAND='ssh -i ./.ssh/key' git pull
            else
              # Clone the repository into a temporary directory
              echo "Cloning repository..."
              git clone -c "core.sshCommand=ssh -i ./.ssh/key" git@github.com:${projectName}/${projectName}.git /tmp/${projectName}
              # Move the contents of the temporary directory to the current directory
              mv /tmp/${projectName}/* .
              mv /tmp/${projectName}/.git .
              rm -rf /tmp/${projectName}
            fi
            echo
          fi

          # Install Python packages from requirements.txt
          # This allows flexibility to use the latest PyPI packages
          # Note: This makes the environment less deterministic
          echo "- Pipulating pip packages..."
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

          # IMPORTANT: Do not remove or modify the following script creations.
          # They're essential for the 'botifython', 'bf', 'start', and 'stop' command functionalities.
          
          # CRITICAL: This line removes existing files to prevent symbolic link issues.
          # Do not remove this line as it ensures clean script creation.
          rm -f .venv/bin/${projectName} .venv/bin/bf .venv/bin/start .venv/bin/stop

          # IMPORTANT: Update the script creations to use the projectName variable
          cat << EOF > .venv/bin/${projectName}
          #!/usr/bin/env bash
          
          # Function to open URL in the default browser
          open_url() {
            if [[ "$OSTYPE" == "darwin"* ]]; then
              open "http://localhost:5001"
            elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
              if [[ -n "$WSL_DISTRO_NAME" ]]; then
                powershell.exe /c start "http://localhost:5001"
              else
                xdg-open "http://localhost:5001" || sensible-browser "http://localhost:5001" || x-www-browser "http://localhost:5001" || gnome-open "http://localhost:5001"
              fi
            else
              echo "Unsupported operating system. Please open http://localhost:5001 in your browser manually."
            fi
          }

          (sleep 5 && open_url) &

          python "$PWD/${projectName}.py"
          EOF
          chmod +x .venv/bin/${projectName}

          cp .venv/bin/${projectName} .venv/bin/bf
          chmod +x .venv/bin/bf

          cat << 'EOF' > .venv/bin/start
          #!/bin/sh
          echo "Starting JupyterLab in a tmux session..."
          tmux kill-session -t jupyter 2>/dev/null || echo "No existing tmux session named 'jupyter'."
          tmux new-session -d -s jupyter 'source .venv/bin/activate && jupyter lab --NotebookApp.token="" --NotebookApp.password="" --NotebookApp.disable_check_xsrf=True'
          echo "JupyterLab is now running in a tmux session named 'jupyter'."
          echo "To view JupyterLab server output: tmux attach -t jupyter"
          echo "To access JupyterLab, visit http://localhost:8888 in your browser."
          echo "To stop JupyterLab server: stop"
          EOF
          chmod +x .venv/bin/start

          cat << 'EOF' > .venv/bin/stop
          #!/bin/sh
          echo "Stopping JupyterLab tmux session..."
          tmux kill-session -t jupyter 2>/dev/null || echo "No tmux session named 'jupyter' is running."
          echo "The JupyterLab tmux session has been stopped."
          EOF
          chmod +x .venv/bin/stop

          # CRITICAL: Keep this PATH modification.
          # It ensures the custom scripts are accessible from the command line.
          # Do not remove or modify this export statement.
          export PATH="$PWD/.venv/bin:$PATH"

          # IMPORTANT: Keep these instructions for users.
          # They provide essential guidance on how to run the application and manage JupyterLab.
          echo "To run ${projectName}.py, type either '${projectName}' or 'bf'"
          echo "To start JupyterLab in a tmux session, type: start"
          echo "To stop JupyterLab, type: stop"
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

            # IMPORTANT: Do not remove or modify the runScript execution.
            # It sets up the entire development environment.
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

            # IMPORTANT: Do not remove or modify the runScript execution.
            # It sets up the entire development environment.
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

Pshwew! 

## Crafting A Custom Linux Distribution from Scratch Successfully

There's some magic in that flake.

- git pulls on a GitHub private repo are incorporated.
- Once you're provided the repo even in non-repo form (downloaded zip), you're
  "in". It upgrades you with an in-location git pull using provided key.
- It only does this based on the project name, so I can change the project name
  in the flake for FOSS forks (Pipulate).

## Creating a Customizable Multi-OS Operating System Platform

...and a bunch of other stuff that's been in there for awhile making it multi-OS
which I won't document again here. But that base has basically become [Darwinix,
which I forked here](https://github.com/Botifython/darwinix). There's lots of
layers that I'm crafting. The lowest is probably what the industry would call
***infrastructure as code*** or IaC. But I think that's a terrible name to
represent the fact you can replace hardware with a single text-file. The
***soul*** of your machine is how you have your software configured on top of it
in such a way that it comes back to you exactly as you instantiated elsewhere.
Hardware is not forever, but your ***nix flake*** is

## Shift in Mode for Botifython Project Incorporates FOSS Extraction

Okay, but that ***git cloning*** trick is of paramount importance here. I
actually made a new Github account specifically for this, called Botifython.
I'll likely apply all these things to the original miklevin/pipulate repo as a
FOSS extraction as I go, but I'm shifting modes because as I worked up the
layers:

- IaC nix flake machine definition
- Python virtual environment with pre-installed pip's
- FastHTML app with plugin framework running local 

## Pivoting To Proprietary FastHTML Fork For Enhanced Collaboration

...I am at the next point of customizing that local instance of a FastHTML
server into some proprietary stuff. I'm going to take the lead of DHH and work
with framework *"extractions"* from this point forward. The main branch (for me)
will be a proprietary fork, technically not a fork in the git sense because if
you fork, you can't make the repo private on Github. So I deleted the invisible
.git folder and started a fresh repo. I'll have a bit of a synchronization issue
now between the proprietary and FOSS version, but I'll cope.

## Sharing Automation Tools with Coworkers to Boost Productivity

The urgency now is to titillate my coworkers with the project, getting used to
the interface and build some anticipation while I pivot to more traditional
client work, which is starting to hit again. My calendar was cleared for quite a
few weeks by my boss to bang out this way of sharing and collaborating my work
with my coworkers, to bring automation to complex SEO procedures. I've done this
tons of time for myself in the past as a sort of secret weapon, and at some
point that concept became **pipulate**. It's gone through several iterations
over the years from crawling spreadsheets directly into Google Docs using a
***bookmarklet*** (JavaScript bookmark), to its most recent rendition as just a
bunch of **Juptyer Notebooks**.

## Pipulate Brings Back The Do-It-All Spirit Of Old Web Development

I thought Pipulate would remain just a bunch of Jupyter Notebooks forever
because I was so done with web development. The specialization and lifetime of
dedication you need to commit just to use the popular modern tools is totally
out of hand. The age of the jack-of-all-trades Webmaster was not just over some
point mid-2010s, it was clobbered into oblivion. That can-do do-it-all spirit
was impossible in practice, even if you still had it in spirit--unless you
stayed on PHP and used virtual web hosts. Then, you could still do it all.

## Why Switching from Notebooks to Web Apps Can Be Challenging

But PHP is not for me. I'm in it for the love of the work, and I love Python.
I'm not one of those people who says that the language doesn't matter, and you
can code anything in anything. That's technically true because Turing-complete
and all, but that's not for me. I still code at all because I actually found a
love-worthy coding platform in Python before I reached ultimate frustration, and
that gave me safe harbor to keep coding Python in Notebooks in a way that was
becoming increasingly popular, socialized and collaborative. But a time comes
when even a Notebook must be made simpler for a different audience if you want
that break-out level of simplicity and ease... for the user.

## The Dev's Double Burden: From Creation to Eternal Maintenance

This article could go on forever along that vein. Switching from Notebook to Web
App may make it easier for the user of the "app", but it's infinitely harder for
the developer. It's a second job, at very least. First to develop it in the
first place, then to host it and maintain it in perpetuity. It's tech liability
that bogs you down in life, plain and simple. The freedom for everyone else in
your stuff being easy to use puts you on the hook, and if popular, a very short
leash to update, maintain, fix, secure... yadda yadda forever. And if it's not
really your main job, well that's the formula for frustration and burnout.

## The Rise of Infrastructure as Code for Local Hosting

Yeah, I'm in my mid-50s and not in the position to take up that sort of nonsense
again. So nix flakes lets me shift the burden of hosting onto infinitely
scalable little instances that I indemnify myself from, haha! Local hosting is a
great option when the localhost is whatever machine you're sitting at, and it
works every time... for everyone... on every OS... forever into the future,
because versions are uniquely pinned on a uniquely "normalized" or common
platform. Linux is now so popular and pervasive that a whole instance of a Linux
virtual environment can be plugged into the subdirectory of a git repo--and by
extension GitHub, and thus easily sharable infrastructure as code.

Got that? It's a new age we're in, and not just because of AI. It's because the
lowest common denominator hardware and popular OS can host a decent highest
common denominator Linux subsystem in a folder... one that's pedantically
deterministic. That means it fixes the "not on my machine" problem by (more or
less) running the exact same way for everyone.

## The Joy of Technology as Artistic Craftsmanship

AI, you say? Well, yeah it's an accelerator. I've always tried to hit above my
weight. I'm a suburban kid with no formal tech training, no decent mentoring
(even though I worked at Commodore Computers!), and really no business acumen
nor the motivation to dedicate myself full-time to tech. So what am I? I suppose
you'd call it an artist. Or at very least, a craftsman. I fall in love with the
tools and using them. There's a sheer joy in exercising your mental muscles with
stuff. But unlike the mainstream image of tech, it's not new stuff all the time.
That's exhausting and works against craftsmanship.

## The Key to Mastering a Craft Lies in Muscle Memory

Getting better at a craft over time means letting your muscle memory improve
over time, so you think less about the tools and more about the subject of what
you're using them on. They fade transparently into the background, and you get
into the zone or the flow state, as they say. But you can't if you're always
hyper-aware of your tools because they're always changing on you. Sure yeah,
while an artist might love experimenting with new mediums, a craftsman needs the
very nature of the wood that they're woodworking to at least be semi-stable,
reliable and consistent over the years so that every time they carve a new
canoe, they don't have to feel like they have to start on concrete.

## Shifting Gears Back to Client Work

I spent so much of my effort creating that "normalized" layer for tech, and a
competent an love-worthy Python development environment on it, with a plug-in
framework that supports porting Jupyter Notebooks over to Web Apps lovingly,
that... that... that it's time to put it aside now, shift gears back to client
work, but then look for opportunities to automate the proprietary work we do
USING this framework. Shifting form "explore" to "exploit", such as the
Algorithms for Life book talks about. And of course in my mid-50s, this really
resonates with me, as I'm far further than the 30% optimal stopping distance
they suggest before switching from explore to exploit, haha! I'm going to be an
old man coding Python, joking with the AIs about how it used to be in the good
old days when they were just barely coming alive.

## Transitioning to Botifython for Automated SEO Workflows

The last thing, and I must resist diving down rabbit holes, is a 1-page website
I can direct my coworkers to that documents getting started with Botifython.
It's to show what I've done with all this time and set the stage so that once I
crank through this latest round of client work the manual way, I can start a new
phase, SEO automation. I do the manual work first, and once only probably
through a Jupyter Notebook (not giving that up / also built into
Pipulate/Botifython), but then I port it quick as a bunny into a web app.

## Setting Up Botifython GitHub Page with Jekyll Template

1, 2, 3... 1. Step 1 is setting up a GitHub Page for Botifython on
botifython.com... done. It's just a hello world. Second, apply a Jekyll
template. Doesn't matter which. It just can't look incompetent... choose one
quick from [supported Jekyll themes](https://pages.github.com/themes/). Okay,
it's got to be [github brown](https://pages-themes.github.io/midnight/) as it is
the only dark theme and the only one I can stand looking at.

Getting a git `config` file was an odd initial dependency on pushing the tech
stuff to the side. I have to be able to do rapid little updates here and there
without thinking about the different keys I have to manage. This key for this
repo and that key for that. The anser is a file like this in `~/.ssh`:

```
# Primary GitHub Account
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa
  IdentitiesOnly yes

# Secondary GitHub Account
Host bf
  HostName github.com
  User git
  IdentityFile ~/.ssh/botifython_develop
  IdentitiesOnly yes
```

This way, you have a different "address" to use on git commands instead of
github.com. It actually makes aliases for the host. But you don't have to
actually type and use that alias every time if you change the remte repo
endpoint locally. Then it's just git pulling and pushing as usual.

To change the remote endpoint for your repository to use the secondary GitHub account configured in your SSH config, you'll need to update the remote URL. Here's how to do it:

1. First, check your current remote URL:

```
git remote -v
```

2. You'll likely see something like:

```
origin  git@github.com:Botifython/botifython.git (fetch)
origin  git@github.com:Botifython/botifython.git (push)
```

3. To change the remote URL to use your secondary GitHub account, use the `git remote set-url` command:

```
git remote set-url origin git@bf:Botifython/botifython.git
```

This command changes the remote URL to use the `bf` host alias you've defined in your SSH config[1][4].

4. Verify the change by checking the remote URL again:

```
git remote -v
```

You should now see:

```
origin  git@bf:Botifython/botifython.git (fetch)
origin  git@bf:Botifython/botifython.git (push)
```

Now, when you pull or push, Git will use the SSH key specified for the `bf` host in your SSH config[1][2].

Remember that this change only affects the local repository you're currently in. You'll need to repeat this process for any other repositories where you want to use the secondary GitHub account[3].

If you encounter any issues, make sure your SSH config file is correctly set up and that you have the necessary permissions for the repository with your secondary GitHub account[4].

Citations:

    [1] https://stackoverflow.com/questions/2432764/how-do-i-change-the-uri-url-for-a-remote-git-repository/19298943
    [2] https://careerkarma.com/blog/git-change-remote/
    [3] https://devconnected.com/how-to-change-git-remote-origin/
    [4] https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories
    [5] https://www.atlassian.com/git/tutorials/syncing
    [6] https://docs.gitlab.com/ee/tutorials/update_git_remote_url/
    [7] https://git-scm.com/docs/git-remote
    [8] https://support.atlassian.com/bitbucket-cloud/docs/change-the-remote-url-to-your-repository/

---

Okay, now set the Jekyll Github Pages theme to Midnight:

```
# Site settings
title: Botifython
description: Soft launch of an SEO Automation Tool
baseurl: "" # the subpath of your site, e.g. /blog/
url: "https://botifython.com" # the base hostname & protocol for your site

# Build settings
remote_theme: pages-themes/midnight@v0.2.0

# Plugins
plugins:
  - jekyll-remote-theme

# Optional: Additional configurations
markdown: kramdown
highlighter: rouge
```

Git add, commit and push...

Okay, and make the homepage mostly about the Determinate Systems installer, so
people can "prep" for Botifython... done.

Okay, now there needs to be a minimum way to get this done. I can host a
downloadable version of an early "locked-down" botifython that doesn't really
have any features in a SEPARATE GitHub repo that I link to. It starts the
process, such as it were.

Okay, test hosting a zip file on the Botifython.com repo that controls the
Github Pages site. At very least, it's available on the public repo.

[https://botifython.com/botifython.zip](https://botifython.com/botifython.zip)

And it works! Success assured.

Okay, add the link and a paragraph about the Determinite Systems uninstall.
Perform the uninstall, reboot your machine and go to Botifython.com... a list...

- Run the Determinite Systems nix installer command
  - It will prompt you to say Yes
- When it's done, close the Terminal and open a new one
- Download botifython.zip from botifython.com
- From a Terminal, cd into that folder
  - For many Mac users, that will be `~/Downloads/botifython-main/`
- Type in: `nix develop`

Okay, it worked! 

### Stuff to fix

- The time-delay for the Window to pop up needs to be increased.
- I print the star/stop instructions for Jupyter twice.
- I need to test a fresh install on machines without Ollama runnng

Okay, I got that done by the skin of my teeth, and even sent the link to my
boos for preview.

---

# Shifting Gears

Coming up for air from some of the most intense development work of my life.
It's still just a plug-in framework with the apps not actually there yet, but
the apps already exist in other forms other places, and doing the means of
distribution and delivery was the hard part. And that's done, right down to the
github auto-updating! Think about forking a development branch.

I've been leaning on a coworker heavily for support on the client-facing front,
actually multiple coworkers and I've been doing that for weeks really, but that
truly intense period is over. It felt good and I want to recapture that
intensity, which itself was a recapture of a type of work I did in my late 20s.

The client work is anticlimatic in comparison, but I can make it loveworthy by
internalizing the client's issues and using that to help shape the Botifython
product. I have to get my YouTube videos going again, especially now.
