---
title: FastHTML and Cursor AI on Linux, Mac & Windows
permalink: /futureproof/fasthtml-cursor-ai-nix/
description: In this article, I share my adventure setting up a cross-platform development environment with Nix, featuring FastHTML and the AI-powered code editor, Cursor. It's a journey through the challenges of integrating cutting-edge technologies, highlighting the elegance of Nix's package management. I delve into configuring NixOS, wrangling Python virtual environments, and rigorously testing the setup across Macs, Windows (using WSL), and Linux to ensure compatibility. Ultimately, it's a testament to creating a reproducible and robust development experience that bridges the latest in AI-assisted coding with the power and flexibility of Nix.
meta_description: Set up FastHTML and Cursor AI (`code-cursor`) in a cross-platform Nix Flake dev environment for NixOS, macOS, and Windows/WSL.
meta_keywords: Nix Flake, FastHTML, Cursor AI, code-cursor, cross-platform development, NixOS, macOS, Windows WSL, development environment, AI assisted coding, Nix unstable channel, nix develop, pip install nix, venv, buildFHSUserEnv, Python, JupyterLab, WSL setup
layout: post
sort_order: 1
---

I'm building a **FastHTML app with Cursor AI under NixOS**. The resulting Nix flake needs to be able to run on **Macs, Windows (under WSL), or Linux**. Talk about being off the beaten track and in the tech wilderness. But I'm going to make it work because there's a big payoff here.

## Navigating the Tech Wilderness

Sometimes even when you take up popular things (Mac, Cursor, Nix, FastHTML), using multiple popular things that usually don't go together can be a lonely place. The Venn diagram of the unlikely (but righteous) combination of tools I'm using here is so off the beaten track that I may be the only one in the world trying this particular combination. Even Reddit offers little guidance, and the LLMs haven't been trained on bleeding-edge stuff yet.

## Playing with Cursor on NixOS for Cross Platform Results

Taking this route may sound gratuitous or needlessly difficult, but the end result is something that can be shared across all three major platforms, so it's worth it. Playing with Cursor on NixOS is the gratuitous part, but I want to be on NixOS and I don't want to be left out.

## Embracing AI-Assisted Coding

I'm generally a **vim/neovim** user (I use `nvim` exactly as I would `vim`, virtually plugin-free), but I'm enjoying getting the advantage of **AI-assisted coding**. Normally, I'd just copy/paste from OpenAI's o1-preview or Claude Anthropic Sonnet 3.5, but the number of completions gets depleted. Once your free completions get used up, it's great motivation to get you to look at the next offering.

## Trying Out The New Code Editor That Everyone's Talking About

And the new kid on the block that you can't stop hearing about is **Cursor**. It offers yet another set of frontier model completions and a nifty user interface that gives a `git diff` style look at its AI-recommended code changes, so why not? Why not is that I'm allergic to the **VSCode-style editor** from which Cursor was derived (forked). But them being the first to get that lovely red/green git diff view of recommended code changes, plus their 2000 free completions—I want to have the Cursor experience and see what happens once the completions are over.

## Notable Tech Products Change How We Work Everyday

Are they per-day? Are they total? How do they try to coerce you onto the paid version? Whether or not I jump on the Cursor bandwagon, I have to have these experiences. I generally don't kick the tires of everything in tech because there's not enough time in the day, and it overall just pollutes your mind if you've got a well-worn muscle memory still relevant and applicable way of doing things. But game changers do come along, so you have to keep an open mind—even vim/neovim users.

## Challenges with Cursor AI on NixOS

Now I'm on **NixOS**, so right off the bat that causes weirdness testing out Cursor AI. When you're getting ready to add things to your NixOS environment, you check to see if it's in the incredibly large Nix repo. The easiest way is to check in this [Nix package search tool](https://search.nixos.org/packages). The other way is from the command line:

```bash
nix search nixpkgs
```

Either way, it's tough to find. You have to look for `code-cursor`, and it's not in the latest stable Nix channel, 24.05 at the time of this writing. Instead, you have to switch over to the **unstable channel**. Over time, it will get into the main channels, but this is the extra difficulty of being on the **bleeding edge of the bleeding edge**. I switched the main channel of my local NixOS install to unstable just to be able to add Cursor AI with a single line entry in the system packages portion of my `/etc/nixos/configuration.nix`...

```nix
# Beginning of file stuff not shown

# System packages
environment.systemPackages = with pkgs; [
  code-cursor
  coreutils
  cudaPackages.cudatoolkit
  curl
  git
  # ...other packages
];

# End of file stuff not shown
```

## The Beauty of Nix Package Management Simplifies Software Installation

And that's it. You don't need to mess around with a download or an AppImage or an installer or any of that other nonsense. Once it's packaged in the Nix package management system, it's just a single line in your configuration file, and that's the beauty of it. But imagine the pain if it weren't at least in the unstable channel. I wouldn't be doing this article.

## Using Nix for Python Package Management Simplifies Life

Anyone can add packages to the Nix software repository even if you didn't write the original package, but it's a certain set of skills that not everyone should have to have. I can't stand doing it, so I'm lucky that Cursor AI is already in there. The same rule that it's easy if already in the nix repo goes for **pip installable** Python packages as well. If the Python package is already in Nix, everything goes smoothly. But if it's not, it's pretty agonizing because you can't pick and choose what comes from Nix and what comes from a `.venv`. The following is how easy it is in just a `configuration.nix` file if your pip packages are already in the nix software repo...

```nix
# Beginning of file stuff not shown

# System packages
environment.systemPackages = with pkgs; [
  code-cursor
  cudaPackages.cudatoolkit
  curl
  git
  # ...other packages
  (python311.withPackages (ps: with ps; [
    requests
    pandas
    numpy
  ]))
];

# End of file stuff not shown
```

## Using Virtual Environments to Simplify Library Installation Complexity

As far as Python libraries like `FastHTML` that are not in the Nix repo yet, but you can still `pip install python-fasthtml`, the complexity explodes again. But I figured out a workaround that shifts all the pip-installable packages into Python virtual environments. That was the subject of the last article.

## Crafting a Minimal `configuration.nix`

So the idea is to make a fairly minimal `/etc/nixos/configuration.nix` that still knows about all the special hardware stuff on your system, installs anything global or *office-like*, but then stops. Even the Python stuff included in `configuration.nix` is just to blast the pipes out—sort of a placeholder. I will be overriding the `requests` package that gets installed here from flakes. Anything that might get installed by a flake (and by that I mean a git repo or particular application) gets left out and deferred to later.

So here I include everything required so that anything later knows I've got Nvidia CUDA acceleration, along with the browser and LibreOffice. I even get the **Ollama LLM service** running, assuming that's going to be a common resource to things that come later to access it from flakes.

```nix
{ config, pkgs, lib, ... }:
{
  # Import hardware-specific configuration
  imports = [
    ./hardware-configuration.nix
  ];

  # Set the system state version
  system.stateVersion = "unstable";

  # Boot loader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable experimental features for Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking configuration
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set time zone and locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # X Server and Desktop Environment configuration
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb.layout = "us";  # Keyboard layout
    videoDrivers = ["nvidia"];
  };

  # Graphics configuration (updated from OpenGL)
  hardware.graphics = {
    enable = true;  # Renamed from hardware.opengl.enable
    enable32Bit = true;  # Renamed from hardware.opengl.driSupport32Bit
  };

  # NVIDIA configuration
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Allow unfree packages and enable CUDA
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cuda.enable = true;

  # Audio configuration
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User configuration
  users.users.mike = {
    isNormalUser = true;
    description = "Mike";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Auto-login configuration
  services.displayManager.autoLogin = {
    enable = true;
    user = "mike";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    code-cursor
    curl
    git
    google-chrome
    libreoffice
    neovim
    wget
    (python311.withPackages (ps: with ps; [
      requests
    ]))
    cudaPackages.cudatoolkit
    ollama
  ];

  # Environment variables
  environment.variables = {
    CUDA_HOME = "${pkgs.cudaPackages.cudatoolkit}";
  };

  # Power management configuration
  services.logind = {
    lidSwitch = "ignore";
    extraConfig = ''
      HandleSuspendKey=ignore
      HandleLidSwitch=ignore
      HandleLidSwitchExternalPower=ignore
      IdleAction=ignore
    '';
  };

  # Ollama service configuration
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # Open firewall port for Git daemon
  networking.firewall.allowedTCPPorts = [ 9418 ];
}
```

## Connecting to a Code Environment for Development Work

Back to the blank canvas metaphor. After a `configuration.nix` like this, your canvas isn't so blank anymore. A few brushstrokes have been laid down about your special hardware and your "base apps" like a browser, office software, and even a large language model server. This is what's there whenever you power on your machine, so you can do basic stuff. But when it gets time to doing some development work and being able to play around with things like Cursor AI, it needs to be able to "connect" to the code and Python virtual environment established in your flake...

**NOTE:** This version turned out to be Linux-only. A Mac-friendly version comes later.

## Building the Flake

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs @ { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      localConfig = if builtins.pathExists ./local.nix then import ./local.nix else {};
      cudaSupport = if localConfig ? cudaSupport then localConfig.cudaSupport else false;
      
      cudaPackages = pkgs.lib.optionals (cudaSupport && system == "x86_64-linux") (with pkgs; [
        cudatoolkit
        cudnn
        (ollama.override { acceleration = "cuda"; })
      ]);
      
      envWithScript = script:
        (pkgs.buildFHSUserEnv {
          name = "python-env";
          targetPkgs = pkgs: (with pkgs; [
            python311
            python311.pkgs.pip
            python311.pkgs.virtualenv
            pythonManylinuxPackages.manylinux2014Package
            cmake
            ninja
            gcc
            git
            stdenv.cc.cc.lib
          ] ++ cudaPackages);
          runScript = "${pkgs.writeShellScriptBin "runScript" (''
            set -e
            export NIXPKGS_ALLOW_UNFREE=1
            export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
            echo "Welcome to the Pipulate development environment on ${system}!"
            ${if cudaSupport then "echo 'CUDA support enabled.'" else ""}
            test -d .venv || ${pkgs.python311.interpreter} -m venv .venv
            source .venv/bin/activate
            pip install --upgrade pip --quiet
            pip install -r requirements.txt --quiet
            ${script}
          '')}/bin/runScript";
        })
        .env;
    in {
      devShell = envWithScript "bash";
    });
}
```

## Software Requirements Listed for `pip`

And for completeness, here's the `requirements.txt` that it's referring to:

```
python-dotenv
requests
numpy
pandas
sqlitedict
matplotlib
python-fasthtml
jupyterlab
jupyter_ai
nbdev
```

## NixOS Enables FastHTML with Virtual Environment Support Now

So this becomes a sort of culmination of a number of prior articles here. This gives me nothing less than **FastHTML editable in Cursor AI under NixOS** with the `.venv` Python virtual environment of a Nix flake actually recognized and used by Cursor so that when you run the code from Cursor, the Terminal actually activates the venv!

## Using Cursor for Simple Git Project Development

I do absolutely nothing special in Cursor except for adding the **pipulate** git repo as a folder (I believe a Workspace in VSCode/Cursor terminology), and I can load the FastHTML hello world program into a tab:

```python
from fasthtml.common import *

# Initialize the FastHTML application
app, rt = fast_app()

# Define a route for the home page
@rt("/")
def get():
    # Return a titled page with a simple "Hello, World!" message
    return Titled("Hello World", P("Hello, World!"))

# Start the server
serve()
```

## Auto-Detected Virtual Environment Created Successfully in Terminal Console

And then I can run that code from Cursor just like you would in an IDE or VSCode, and I get the following output from the Terminal console, showing me it auto-detected and used the `.venv`:

```
/home/mike/repos/pipulate/.venv/bin/python /home/mike/repos/pipulate/server.py
(.venv) 
[mike@nixos:~/repos/pipulate]$ /home/mike/repos/pipulate/.venv/bin/python /home/mike/repos/pipulate/server.py
Link: http://localhost:5001
INFO:     Will watch for changes in these directories: ['/home/mike/repos/pipulate']
INFO:     Uvicorn running on http://0.0.0.0:5001 (Press CTRL+C to quit)
INFO:     Started reloader process [180522] using WatchFiles
INFO:     Started server process [180571]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     127.0.0.1:53198 - "GET / HTTP/1.1" 200 OK
```

## Opening Link Opens in Simple Chrome Browser Instance

And when you mouse over the `http://localhost:5001` link, you get the standard VSCode `Follow link (ctrl + click)` message, and when you do, it opens in plain old Chrome browser with the running FastHTML hello world!

## Making It Cross-Platform

Okay, now to test it on Mac... Nope! Ouch, okay, after much finagling, here's a version that works on both Mac and Linux. It's worth noting that I used the AI assist in Cursor on the Mac to get it sorted. And so now this becomes my new master template. I'm tempted to update my prior post where I proclaimed I got the template, but it turns out it was Linux-only.

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs @ { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      localConfig = if builtins.pathExists ./local.nix then import ./local.nix else {};
      cudaSupport = if localConfig ? cudaSupport then localConfig.cudaSupport else false;
      
      isLinux = pkgs.stdenv.isLinux;
      isDarwin = pkgs.stdenv.isDarwin;
      
      commonPackages = with pkgs; [
        python311
        python311.pkgs.pip
        python311.pkgs.virtualenv
        cmake
        ninja
        gcc
        git
      ];
      
      runScript = pkgs.writeShellScriptBin "runScript" ''
        set -e
        export NIXPKGS_ALLOW_UNFREE=1
        ${if isLinux then "export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH" else ""}
        echo "Welcome to the Pipulate development environment on ${system}!"
        ${if cudaSupport && isLinux then "echo 'CUDA support enabled.'" else ""}
        test -d .venv || ${pkgs.python311.interpreter} -m venv .venv
        source .venv/bin/activate
        pip install --upgrade pip --quiet
        pip install -r requirements.txt --quiet
        exec bash
      '';
      
      linuxDevShell = pkgs.mkShell {
        buildInputs = commonPackages ++ (with pkgs; [
          pythonManylinuxPackages.manylinux2014Package
          stdenv.cc.cc.lib
        ]) ++ pkgs.lib.optionals (cudaSupport && system == "x86_64-linux") (with pkgs; [
          cudatoolkit
          cudnn
          (ollama.override { acceleration = "cuda"; })
        ]);
        shellHook = "${runScript}/bin/runScript";
      };
      
      darwinDevShell = pkgs.mkShell {
        buildInputs = commonPackages;
        shellHook = "${runScript}/bin/runScript";
      };
    in {
      devShell = if isLinux then linuxDevShell else darwinDevShell;
    });
}
```

## New Master Template For Work Across Multiple Operating Systems

Okay, wow. This tests out good. No promises that it will stay in this exact shape, but this is the new master template for work across Macs, Linux, and Windows (still have to test Windows/WSL/Ubuntu, but I'm confident). It can be pulled from GitHub with:

```bash
git clone https://github.com/miklevin/pipulate
```

## Alternatives to Git if You're Not Set Up Yet

If you're not on git or don't have your public ssh key set up yet, you can alternatively:

```bash
curl -L https://github.com/miklevin/pipulate/archive/refs/heads/main.zip -o pipulate.zip
```

Or just go to [https://github.com/miklevin/pipulate](https://github.com/miklevin/pipulate) and download the zip from under the **Code** button.

Once it's cloned or downloaded and unzipped, you open a Terminal and `cd` into the folder, and type:

```bash
nix develop
```

After that, either of these two commands are tested:

- `jupyter lab`
- `python server.py`

## Testing JupyterLab on NixOS for Cross Platform Compatibility

When JupyterLab is launched, I tested `import pandas`. And so this is all sorts of "success assured" moments. I get to use my preferred environment, NixOS, which both forces me to get familiar with the **nix way** and to continue distancing myself from either a Windows or macOS desktop OS dependency, while still being able to deploy little flakes of home out to those who are using Mac and Windows.

## Testing on Windows

## Testing Windows Subsystem for Linux Performance with apt Update

Okay, for the sake of completeness, let me perform this same test on Windows. It is Windows 10 (while it lasts) running the **Windows Subsystem for Linux (WSL)** with Ubuntu 22.04 Jammy Jellyfish. It's been forever since I've done anything under WSL, so I'm doing an `apt update` and `apt upgrade` before the test. I already have `curl` on my Ubuntu, so all I have to do after the update in the Ubuntu shell is...

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
```

Ugh, some sort of per-user permission error popped up. It says:

```
error: opening lock file: '/nix/var/nix/profiles/per-user/..."
```

## Troubleshooting WSL Issues After Upgrading Windows and Ubuntu

I recalled having read something about older versions of WSL not working with Nix, but it working after an update and fresh Ubuntu. So I'm taking the following precautions. From a PowerShell...

```powershell
wsl --update
```

## Updating Windows Subsystem for Linux to Version 2.2.4

That updated me to WSL version 2.2.4. Next, I made sure all instances of Linux under WSL are not running...

```powershell
wsl --shutdown
```

## Installing Latest Ubuntu Version from Microsoft Store Successfully

Next, to make sure I'm on a really fresh and latest and Microsoft-kosher Ubuntu, I went into the Microsoft Store and searched on Ubuntu and got the latest available there, **Ubuntu 24.04 LTS**, and launched it. It went through its little install routine, and when asked, I gave username `foo` and password `bar`, then I went through the `sudo apt update`, `sudo apt upgrade` shuffle.

I then used the **Determinate Systems** install process...

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
```

Then I answered `Y` to the "are you sure" question.

Then I closed and opened the Terminal to get the new environment.

Now to git clone... oops, the SSH method of git cloning requires having an explicitly permitted SSH key assigned through GitHub. But you can still clone the GitHub repo with any SSH key on a public repository if you have any local SSH key. So next, I...

```bash
cd ~/
mkdir .ssh
ssh-keygen
```

Then you hit Enter a few times to quickly get a default key (not good practice, but all I need for testing). And now I can clone the repo the HTTP way...

```bash
git clone https://github.com/miklevin/pipulate
```

Okay, now I have a local `pipulate` repo. I `cd` into it and type:

```bash
nix develop
```

And a warning vomits up with a bunch of messages including:

```
'https://cache.flakehub.com' does not appear to be a binary cache
```

Plus a bunch of lines that read:

```
bash: shopt: progcomp: invalid shell option name
bash: complete: command not found
bash: complete: command not found
bash: complete: command not found (a bunch of these)
bash: shopt: hostcomplete: invalid shell option name
```

But then it ends at a prompt that makes it look like it worked. So, I test out both:

```bash
python server.py
```

...and...

```bash
jupyter lab
```

## Windows WSL Nix Debugging Now My Lowest Priority

And both worked in WSL fine. I'm not sure what all those messages are, but I've got some Windows WSL Nix debugging to do. It is, however, my lowest priority. It looks like it's actually working, and I'll solve those error messages in time.

## Testing MVP Across Multiple Platforms Ensures Valid Results

The important thing is that I've done a minimum viable product (MVP) test across all three platforms, like I keep asserting. That's one of the major selling points of this approach, and I don't want it blowing up in my face had I not tested it on Windows.

## Conclusion

Getting **FastHTML** and **Cursor AI** working together in Nix across Mac,
Windows, and Linux took some effort, but it's manageable. Dealing with NixOS's
quirks and the differences between operating systems wasn't straightforward, but
now I have a setup that works reliably on all three platforms. It's my preferred
platform because it's a sort of generic home location from which you can "chip
off flakes" for everyone. In the end, it is a desktop-OS agnostic approach that
keeps you relevant on all platforms, tapping the power of your local machine
while staying cloud-deployment ready. It's the best of all worlds, and does't
even shut you out of the latest and greatest toys like Cursor AI.

