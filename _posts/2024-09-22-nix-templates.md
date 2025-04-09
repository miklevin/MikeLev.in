---
title: Getting My Nix System Together
permalink: /futureproof/nix-system/
description: I detail my process of setting up a NixOS system and creating reproducible data science environments using Nix flakes. I explain my approach to configuring NixOS, including the use of a minimal configuration.nix file and the integration of essential services like Ollama and CUDA. I also discuss the benefits of using Python virtual environments within Nix flakes to manage Python dependencies and ensure flexibility for data science tasks.
layout: post
sort_order: 1
---

Have you ever wished you could effortlessly recreate your entire computer setup on any machine, regardless of its operating system? Imagine a world where sharing your exact development environment with colleagues is as simple as sharing a text file. Enter Nix and NixOS, revolutionary tools that are changing the game in system management and software development. Whether you're a seasoned programmer or just starting out, this article will introduce you to a powerful approach that can save you countless hours of setup time, eliminate "it works on my machine" problems, and give you unprecedented control over your computing environment. Get ready to discover how Nix can transform the way you think about software installation, system configuration, and project reproducibility.

## Introduction to Nix

Nix is a funny thing. It's **3 things**, really. It's a *software packaging system*, it's an *operating system*, and it's a *language for describing Linux systems*, or parts of them. And that makes it a rather powerful way to express systems, scratching an itch I've had for years. How do you make just about everything generic and portable, de-coupled from hardware?

I've been down the virtual machine and container path. You can check out **Levinux**, an old endeavor of mine that's still a fun curiosity. But the itch it was scratching is addressed by Nix. *Linux system reproducibility*. And as an extra bonus, you've got it on Macs and Windows, not so much as reproducing a Mac or Windows system on other machines, but reproducing a Linux machine as if in the folder on Mac or Windows.

## The Power of Nix

I know that's a bit abstract. But it's great for trading systems. Not everything needs to be a Web app or something in an app store. You can still just create and trade software between computers, not much worrying what kind of computer, so long as it's somewhat modern. Actually, old or barely just Internet capable is fine too. **Nix makes trading systems easy because of high reproducibility**.

The barriers are mostly just wrapping your mind around it all. There's techie reasons it all works so well, having to do with something called a `/nix/store/` which can appear just like that as a path even on Macs and Windows, and from there, everything is packed flat, hierarchy-wise. You don't have to think about it much when you're editing text files that define systems.

## Understanding NixOS

If your system is fully Nix-built, it's likely **NixOS**. NixOS is a distribution of Linux that installs from self-booting media like USB and CDs, just like any other Linux. But after that, you can take some fairly serious control of your system from a file `/etc/nixos/configuration.nix`. You could in fact build your entire system out from there, including all your development environments and home directory stuff. But generally, NixOS users break it out to a few more files for organization.

With NixOS, especially if you're using git and working out of folders that are software repositories, it's easy to allow yourself to think of installing software into the repo. If the same software is used in folder after folder and repo after repo, it's still only stored once, because of `/nix/store/`. And therefore, when you're creating your main `/nixos/configuration.nix` it feels right leaving most things out that you won't need until later.

## My NixOS Configuration

Some of the exceptions I make are getting a few global services running, which in my mind now includes a running **Ollama LLM**. It also includes the specialized software for accelerated *Nvidia CUDA hardware performance*. From there, any repos that require a global LLM server can easily connect to it, and it's receiving the GPU speed-boost, as could any GPU-acceleratable components like Pandas. And for this reason a relatively simple `/nixos/configuration.nix` could look like this...

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

  # Enable Firefox
  programs.firefox.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    code-cursor
    coreutils
    figlet
    curl
    git
    gnome-terminal  # Updated from gnome.gnome-terminal
    google-chrome
    libreoffice
    msmtp
    neovim
    obs-studio
    screen
    vim
    wget
    xclip
    feh
    (python311.withPackages (ps: with ps; [
      simplenote
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

  # Git daemon configuration
  services.gitDaemon = {
    enable = true;
    basePath = "/srv/git";
    exportAll = true;
    user = "mike";
    group = "users";
  };

  # Create Git repository directory
  systemd.tmpfiles.rules = [
    "d /srv/git 0755 mike users -"
  ];

  # Open firewall port for Git daemon
  networking.firewall.allowedTCPPorts = [ 9418 ];

  # Create symlinks for Vim and Neovim configurations
  system.activationScripts.createVimNvimSymlinks = {
    text = ''
      mkdir -p /root/.vim
      ln -sf /home/mike/.config/nvim/init.vim /root/.vim/vimrc
      mkdir -p /root/.config/nvim
      ln -sf /home/mike/.config/nvim/init.vim /root/.config/nvim/init.vim
      mkdir -p /home/mike/.vim
      ln -sf /home/mike/.config/nvim/init.vim /home/mike/.vim/vimrc
    '';
  };

  # Shell aliases
  environment.shellAliases = {
    vim = "nvim";
    xc = "xclip -selection clipboard <";
    xv = "xclip -selection clipboard -o >";
  };
}
```

## Creating a Data Science Environment

From here, I have a template which creates a data science repo from which you can run **JupyterLab** and such. Interestingly, even though huge amounts of the Python PyPI pip installable repository is in the Nix packaging system too and could be installed "native" on Nix in one of these `flake.nix` files, I still tend to set up Python virtual environments for a few reasons.

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

## Managing Python Dependencies

Such a method requires that a standard pip `requirements.txt` file is sitting there next to it. Here's what I often start out with for basic AI-enabled Juptyer Notebooks and a cool new Pythonic web development package...

```
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

By taking this approach, you get the expected ability to `pip install` as a Python user without running up against the Nix frustrations of immutable OS where you normally can't just install things. This approach also lets you get the very latest out of PyPI (pip) that may not have reached the Nix packaging system yet, such as *FastHTML* and *JupyterAI*. 

What you loose when you use normal pip is some of the determinism (almost guaranteed to run) of Nix. But the trade-off, especially when you're doing fast-and-furious Python cobbling, is worth it.

## Simplifying the Flake

The above flake is still a bit more complicated than it needs to be, because of looking for GPU stuff. This can be simplified even a little more if you don't have to sort out accelerated hardware...

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      envWithScript = script:
        (pkgs.buildFHSUserEnv {
          name = "python-env";
          targetPkgs = pkgs: (with pkgs; [
            python3
            python3Packages.pip
            python3Packages.virtualenv
            # Support binary wheels from PyPI
            pythonManylinuxPackages.manylinux2014Package
            # Enable building from sdists
            cmake
            ninja
            gcc
        pre-commit
          ]);
          runScript = "${pkgs.writeShellScriptBin "runScript" (''
              set -e
              test -d .nix-venv || ${pkgs.python3.interpreter} -m venv .nix-venv
          source .nix-venv/bin/activate
          set +e
          pip install --upgrade pip --quiet
          pip install -r requirements.txt --quiet
            ''
            + script)}/bin/runScript";
        })
        .env;
    in {
      devShell = envWithScript "bash";
    });
}
```

## Conclusion

And there it is. That's a system and flake template. All you need is one `/etc/nixos/configuration.nix` to define your system, and then you can sprinkle `flake.nix` files throughout your system and share them with others.
