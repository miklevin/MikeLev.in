---
title: NixOS Warbler Files Disappeared
permalink: /nixos-warbler-files-disappeared/
description: NixOS unstable just ate my file manager in the latest update. Turns out they're slimming down the default install, probably for those hardcore minimalists running headless systems. But hey, I like my GUI comforts, so I had to dive into the NixOS config and wrestle Nautilus back into existence. It's a cautionary tale of what can happen when you live on the bleeding edge, but also a testament to how fixable things usually are with a little persistence and the right commands.
layout: post
sort_order: 2
---

**A Deep Dive into the Fringes of NixOS: When the Bleeding Edge Cuts a Little Too Deep**

This isn't your typical Linux tweak job. This is NixOS on the unstable channel, where the latest updates flow in like a torrent, sometimes leaving you high and dry on the shores of the unexpected. Join me as I navigate the choppy waters of a recent upgrade that wiped out my file manager, leaving me stranded in a sea of command-line interfaces. 

We'll delve into the depths of NixOS configuration, explore the minimalist philosophy behind its latest release, and witness the resurrection of my beloved Nautilus file manager. If you're curious about life on the bleeding edge of Linux, brace yourself for a tale of system hardening, unexpected consequences, and the unwavering spirit of a tinkerer determined to tame the unstable beast. 

> I'm in the fringe. The fringe I'm on  
> No guile win but file gone  
> Not files like those lost to us  
> But rather much like nautilus  

I'm currently using NixOS on the unstable channel, which has recently dropped
NixOS 25.05 dropped codenamed Warbler (November 2024), upgrading me from the
previous Vicuna 24.11. This is my day-to-day worksystem. I have a Logitech MX
BRIO on this thing and run Slack and Zoom regularly for work. Would that be
mainstreamy-fringe or the fringy-mainstream?

Either way, stuff broke as one would expect it to on the bleeding edge. And so
now, I fix. First, it's clarification time of what I am on...

    [mike@nixos:~]$ sudo nix-channel --list | grep nixos
    nixos https://nixos.org/channels/nixos-unstable
    nixpkgs https://nixos.org/channels/nixpkgs-unstable

    [mike@nixos:~]$ nixos-version
    25.05beta710087.23e89b7da85c (Warbler)
    [mike@nixos:~]$ 

...and what I was on... hmmm, my boot menu shows by last NixOS version from
2024-11-17 was Vicuna 24.11pre697431.86e78d3d2084. So I've been living with this
no file program thing for a week. 

I may go back to 24.11 depending on my experience coming up. I lost my file
manager! I can't even "Select file" in a browser prompt. There is no prompt
pop-up! Now I'm all for the bleeding edge, but this is just a bit too much.
Before I give up being on the unstable channel, I'm gonna make a grab for
nautilus specifically. I don't know if that's the default one used. I never
thought to check, but NixOS uses a very default vanilla GNOME so I'm guessing
yes.

That being the case and knowing how these things work, simply asking for
nautilus should be enough to force the installation of whatever
dependency chain currently gets left out. I suspect the NixOS powers-that-be
really trim the baseline footprint on a new version release like this to control
for variables. What's further, I'm gonna guess there's a powerful NixOS
contingency out there that uses headless OSes to reduce surface area, harden
systems and whutnot. Leaving out basic desktop abilities like popping up a file
requester by default feels like a system hardening checklist item.

I'll take it!

So long as my premise is correct. And so I initially add `gnome.nautilus` to my
`environment.systemPackages = with pkgs` list and am informed that nautilus has
been promoted to root. Taken out of gnome home? Hmmm. Sus. There's no place like
gnome, but whatever. I remove the `gnome.` prefix, do my `sudo nixos-rebuild
switch`, reboot and there's the `files` program back on my app launcher panel
like this time last week before I threw caution to the wind and bravely let the
big unstable channel branch build on my system with the NixOS equivalent of
`sudo apt-get update && sudo apt-get upgrade`...

    sudo nix-channel --update
    sudo nixos-rebuild switch

And wait a half-hour. And BAM! Warbler. Took me a bit to realize. I do this to
make sure my GPU performance with the local LLM stuff I do on my RTX 3080 Ship
of Theseus (Chip O'Theseus) machine is totally tweaked out. Hitting the vision
models of Llama 3.2 on the Ollama website triggered the whole adventure.
Updating individual components just isn't worth it when your whole machine rolls
forward and back so easily in time like a time-machine with fully re-generated
systems. There's a sort of bravery here I've never felt on other systems. Truly
the right OS for a Ship of Theseus approach designed to Noah's Ark your whole
technology tool home forward in time forever.

Anyhoo I update my `configuration.nix`, reboot and there's Nautilus. I feel like
Ned Land. Or would that be Professor Aronnax? Either way, I found it.

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

  # Enable dconf and configure GNOME extensions
  programs.dconf.enable = true;
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.shell]
    enabled-extensions=['gTile@vibou']
  '';
  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = [ ];

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
    cheese
    cmake
    code-cursor
    coreutils
    cudaPackages.cudatoolkit
    curl
    discord
    feh
    figlet
    gcc
    git
    gnome-terminal
    gnomeExtensions.gtile
    google-chrome
    jq
    libreoffice
    msmtp
    nautilus
    neovim
    obs-studio
    ollama
    slack
    sqlitebrowser
    stdenv.cc.cc.lib
    tmux
    tree
    unzip
    v4l-utils
    wget
    xclip
    zlib
    zoom-us
    (python311.withPackages (ps: with ps; [
      requests
      simplenote
    ]))
    # Add your script here
    (pkgs.writeShellScriptBin "gsr" ''
      #!/usr/bin/env bash

      if [ $# -ne 2 ]; then
        echo "Usage: $0 'old term' 'new term'"
        exit 1
      fi

      find . -type f -not -path '*/.*' -not -path '*/site-packages/*' -print0 | \
      xargs -0 sed -i "s/\\b$1\\b/$2/g"
    '')
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

  # Force Neovim to use the correct init.lua through symlink
  system.activationScripts.linkNeovimConfig = {
    text = ''
      mkdir -p /home/mike/.config/nvim
      ln -sf /home/mike/repos/nixos/init.lua /home/mike/.config/nvim/init.lua
    '';
  };

  # Keep the nix-config symlink creation
  system.activationScripts.linkNixConfig = {
    text = ''
      ln -sf /home/mike/repos/nixos /etc/nixos
    '';
  };

  # Neovim configuration (without specifying a custom init.lua location)
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # Remove any customRC or configure options here
  };


  # Shell aliases
  environment.shellAliases = {
    vim = "nvim";  # Keep alias for vim to nvim
    xc = "xclip -selection clipboard <";
    xv = "xclip -selection clipboard -o >";
    gs = "grep -r --exclude-dir='.*' --exclude-dir='site-packages' -i -n";
    r = "cd ~/repos";
    n = "cd ~/repos/nixos && sudo nixos-rebuild switch";
  };

  # System activation scripts
  system.activationScripts = {
    removeOldVimSymlink = {
      text = ''
        if [ -L /home/mike/.vim/vimrc ]; then
          rm /home/mike/.vim/vimrc
        fi
      '';
      deps = [];
    };
  };

  # Enable Logitech device support
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # Enable Video4Linux support
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';
}
```

**Me**: Perplexity, explain to the nice people who Ned Land and Professor Aronnax are.

**Perplexity**: Ned Land and Professor Pierre Aronnax are two key characters from Jules Verne's novel "Twenty Thousand Leagues Under the Sea", who represent starkly different personalities and approaches to life.

**Ned Land**
Ned Land is a master harpooner from Quebec, Canada, known for his physical strength, bravery, and practical nature[1][3][5]. He is a skilled hunter with exceptional eyesight who values freedom and direct action[1][3]. As a man of the sea, Land is more comfortable with physical work and survival skills, preferring hands-on experience over intellectual contemplation[7]. He is deeply homesick aboard the Nautilus, longing to return to land and eat meat[1]. Despite his rough exterior, Land has strong moral principles, demonstrated by his willingness to save Captain Nemo from a shark attack, even though he distrusts him[1][3].

**Professor Pierre Aronnax**
Professor Aronnax is a forty-year-old Assistant Professor at the Paris Museum of Natural History, specializing in marine biology[2][4]. He is the narrator of the novel and an intellectual who authored a book called "The Mysteries of the Great Ocean Depths"[2][4]. Unlike Ned Land, Aronnax is more contemplative and fascinated by scientific discovery, initially enjoying the submarine journey and Nemo's technological marvels[2]. However, he is criticized for being passive, often observing events rather than taking decisive action[2][7].

**Their Relationship**
Despite their differences, Aronnax and Ned Land develop a strong bond during their imprisonment on the Nautilus. They ultimately work together to escape, with Land's practical skills and determination proving crucial to their liberation[6][7].

Citations:

    [1] https://www.sparknotes.com/lit/20000-leagues-under-the-sea/character-ned-land/
    [2] https://stevenrsouthard.com/character-analysis-pierre-aronnax/
    [3] https://www.shmoop.com/study-guides/20000-leagues-under-the-sea/ned-land.html
    [4] https://www.sparknotes.com/lit/20000-leagues-under-the-sea/character-pierre-aronnax/
    [5] https://www.charactour.com/hub/characters/view/Ned-Land.20000-Leagues-Under-the-Sea
    [6] https://study.com/academy/lesson/professor-aronnax-in-20-000-leagues-under-the-sea.html
    [7] https://stevenrsouthard.com/character-analysis-ned-land/

**Me**: Yes, but who found it and which would I be more like in this context?

**Perplexity**: In the context of your NixOS adventure, you would be more like Professor Aronnax. You found the solution to your file manager problem by adding `nautilus` to your system packages, demonstrating a methodical and intellectual approach to problem-solving[1]. Like Aronnax, who was fascinated by the technological marvels of the Nautilus, you show a keen interest in exploring and understanding the intricacies of your NixOS system.

Your statement "I feel like Ned Land. Or would that be Professor Aronnax? Either way, I found it" indicates that you successfully resolved the issue[1]. However, your detailed explanation of the problem, your understanding of the NixOS architecture, and your systematic approach to fixing it align more closely with Aronnax's character traits than with Ned Land's more direct, action-oriented personality.

**Me**: Yes, but didn't Ned spot it first?

**Perplexity**: In the novel "Twenty Thousand Leagues Under the Sea", Ned Land is indeed the first to spot the mysterious submarine, using his exceptional eyesight and keen observational skills as a harpooner[1]. While Professor Aronnax is the scientific narrator who analyzes and documents their journey, Ned Land is the character who initially detects the underwater vessel during their maritime expedition[1].

His practical, sailor's perspective and sharp vision make him crucial in first identifying the Nautilus, which sets the entire adventure in motion. This aligns perfectly with his character as a skilled hunter and man of action, in contrast to Aronnax's more intellectual approach.

---

Sigh, Perplexity just doesn't get geek humor like Gemini. Or would that in this context be guix humor? Anyone? Bueller?
