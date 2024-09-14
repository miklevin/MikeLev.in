---
title: My First Nix Flake Will Be JupyterLab
permalink: /jupyter-nix-flake/
description: Exploring how to create a portable and shareable JupyterLab environment using Nix flakes, enabling consistent development workflows across NixOS and macOS.
layout: post
---

## Creating a Portable JupyterLab Environment with Nix Flakes

As someone who splits time between a NixOS desktop and a MacBook for work, I
often face the challenge of keeping my development environments in sync. I work
on automations that need to run anywhere, anytime—whether on NixOS or macOS. By
constructing the entire environment with a Nix flake, I can share it with my
coworkers, ensuring consistency and eliminating the "works on my machine"
problem. This approach not only clarifies my workflow but also helps me declare
my intent, methodology, and progress.

---

## The Journey to a Consistent Development Environment

### Embracing NixOS and Nix Flakes

My migration to **NixOS** has been a game-changer. For years, I primarily used
the Linux terminal, doing all my coding and writing (like this article) in the
**Vim** text editor. On Windows, I leaned into the Windows Subsystem for Linux
(WSL) with Ubuntu, and on Mac, I used a Homebrew-installed Vim. However, I
missed the consistency and richness of the Ubuntu software repositories. While
Homebrew is great, the slight differences on macOS can be a pain—it's Unix, not
Linux, and lacks an official free and open-source software repository.

### The Problem with Traditional Package Management

Apple's unofficial Homebrew works alongside the App Store, `pip`, `npm`, and
other package managers. Each time you try something new on the Mac, it installs
more software, gradually cluttering your system with cruft. Eventually, you
might feel the need to reinstall the OS to clean things up. Virtual
environments, containers, and virtual machines can mitigate this, but they add
complexity and overhead.

**Nix** offers a solution to this problem, even while staying on Mac. It allows
for declarative package management and system configuration, ensuring
reproducibility and consistency.

---

## Introducing JupyterLab in a Nix Flake

### Leveraging JupyterLab for Productivity

I decided to use **Jupyter Notebooks** within **JupyterLab** to be productive
right away, especially with data science methodologies using Python and Pandas.
My goal was to integrate tools like **Jupyter AI** and local LLMs (Large
Language Models) like **Llama 3.1** via **Ollama**. This setup would provide a
free local coding chatbot for those who might feel envious of more advanced AI
coding assistants. Essentially, the Nix flake I'm creating should build a
JupyterLab environment with pre-loaded notebooks from GitHub, ready to run
locally. These notebooks are the SEO deliverable-makers for my projects.

### The Dilemma: Cloud vs. Local Development

There are many choices when it comes to running code:

- **Language**: Which programming language to use?
- **Environment**: Running code locally or in the cloud?
- **Software**: Using commercial solutions or free and open-source software?

The common wisdom today leans toward using the cloud, which often pushes
developers to implement everything as a web app. But not everything needs to be
cloud-based. The approach I'm advocating is still highly deployable to the cloud
but taps into the capabilities of the local machine first.

---

## Nix Flakes: The "Not on My Machine" Fix

### Why Not Use Docker or Google Colab?

There's a temptation to jump on the **Google Colab** bandwagon. It's convenient,
with security handled via Google accounts, and no new installations are required
on your machine. However, relying solely on cloud solutions can lead to issues
like vendor lock-in and lack of control over the environment.

Technologies like virtual machines and containers attempt to solve environment
consistency but add complexity. **Nix flakes** provide a meticulous and
deterministic way of describing systems so they build exactly the same way every
time, regardless of the host hardware.

### Defining "Home" in the Development Environment

In Unix/Linux systems, the concept of "home" (`~/`) represents your
configurations, customizations, and sometimes data. It doesn't include the
"outer" system—the underlying files and binaries spread over the Filesystem
Hierarchy Standard (FHS), like `/usr/local/bin/`. Over time, systems can become
bloated with remnants of past software installs, cluttering your digital home.

---

## Building the JupyterLab Environment with Nix Flakes

### The Minimal Nix Flake for JupyterLab

To create a JupyterLab environment that works identically on Mac, Windows, or
Linux using Nix flakes (with version pinning), you can start with a minimal
`flake.nix` file like this:

```nix { description = "Pipulate JupyterLab Environment";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; flake-utils.url =
  "github:numtide/flake-utils";  # Utility functions for flakes };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem
  (system: let pkgs = import nixpkgs { inherit system; }; python =
  pkgs.python311;  # Choose your Python version pythonPackages = python.pkgs; in
  { devShell = pkgs.mkShell { buildInputs = with pythonPackages; [ jupyterlab
  numpy pandas matplotlib # Add other Python packages as needed ]; shellHook =
  '' echo "Welcome to the Pipulate JupyterLab environment!" ''; }; }); } ```

### Breaking Down the Flake

- **Inputs**:
  - **nixpkgs**: Specifies the Nix packages repository to use.
  - **flake-utils**: Provides utility functions to simplify flake development.

- **Outputs**:
  - **eachDefaultSystem**: Ensures compatibility with default systems (Linux,
    macOS, etc.).
  - **devShell**: Defines a development shell that includes JupyterLab and
    essential Python packages.

This flake allows anyone to clone the repository and run `nix develop` to enter
a shell with all the specified tools available, regardless of their underlying
operating system.

So let's break down what this flake does and how it helps us achieve a
reproducible, shareable development environment.

---

## Building a Shareable Development Environment with Nix Flakes

After some experimentation, I realized that to create a truly portable and
reproducible environment, I needed to separate my system configuration from my
development environment. This separation ensures that while my NixOS system
remains tailored to my needs, the development environment can be shared
seamlessly with my coworkers on macOS.

### Understanding the Basic Flake

The flake I provided earlier is a starting point. It defines a development shell
(`devShell`) that includes JupyterLab and essential Python packages like NumPy,
Pandas, and Matplotlib. This setup ensures that anyone using this flake will
have the same environment, eliminating the "works on my machine" problem.

However, I needed a more robust solution that could handle additional
complexities like GPU support and cross-platform compatibility. Here's how I
refined the flake.

---

## Refining the Flake for Cross-Platform Compatibility

### The Final `flake.nix`

```nix { description = "Pipulate Development Environment";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; };

  outputs = { self, nixpkgs }: let systems = [ "x86_64-linux" "aarch64-darwin"
  ]; forAllSystems = f: builtins.listToAttrs (map (system: { name = system;
  value = f system; }) systems);

      # Import local configuration if present localConfig = if
      builtins.pathExists ./local.nix then import ./local.nix else {};

      # Use the ? operator to check for cudaSupport cudaSupport = if localConfig
      ? cudaSupport then localConfig.cudaSupport else false;

    in { devShells = forAllSystems (system: { default = let pkgs = import
    nixpkgs { inherit system; }; lib = pkgs.lib;

          # CUDA-specific packages (only on your system) cudaPackages =
          lib.optionals (cudaSupport && system == "x86_64-linux") (with pkgs; [
          pkgs.cudatoolkit pkgs.cudnn (pkgs.ollama.override { acceleration =
          "cuda"; }) ]);

          # Define Python package set ps = pkgs.python311Packages;

          # Conditionally override PyTorch for CUDA support pytorchPackage = if
          cudaSupport && system == "x86_64-linux" then ps.pytorch.override {
          cudaSupport = true; } else if system == "aarch64-darwin" then
          ps.pytorch-bin else ps.pytorch;

          # Python packages including JupyterLab and others pythonPackages =
          pkgs.python311.withPackages (ps: [ ps.jupyterlab ps.pandas ps.requests
          ps.sqlitedict ps.numpy ps.matplotlib ps.nbdev ps.fastai   # For
          machine learning ps.fastapi  # For web applications ps.simplenote
          pytorchPackage ]);

          # Common development tools devTools = with pkgs; [ git vim # Add other
          development tools if needed ];

        in pkgs.mkShell { buildInputs = devTools ++ [ pythonPackages ] ++
        cudaPackages;

          shellHook = '' echo "Welcome to the Pipulate development environment
          on ${system}!" ${if cudaSupport then "echo 'CUDA support enabled.'"
          else ""} ''; }; }); }; } ```

### Breaking Down the Flake

- **Cross-Platform Support**: The `systems` list includes both `"x86_64-linux"`
  for Linux and `"aarch64-darwin"` for Apple Silicon Macs. This ensures that the
  development environment works seamlessly on both NixOS and macOS.

- **Conditional CUDA Support**: By checking for a `local.nix` file, we can
  enable CUDA support on systems that have it (like my NixOS machine with an
  NVIDIA GPU) without affecting others. This is controlled by the `cudaSupport`
  flag.

- **Python Environment**: We specify Python 3.11 and include a rich set of
  packages commonly used in data science and web development, such as
  JupyterLab, NumPy, Pandas, Matplotlib, FastAI, and FastAPI.

- **Platform-Specific Dependencies**: The flake handles platform-specific
  dependencies, such as using pre-built PyTorch binaries on macOS
  (`ps.pytorch-bin`) and enabling CUDA support on Linux when available.

- **Development Tools**: Essential tools like `git` and `vim` are included to
  ensure productivity across different systems.

- **Shell Hook**: A friendly message is displayed when entering the development
  shell, indicating the system and whether CUDA support is enabled.

### Sharing the Development Environment

With this flake, sharing the development environment becomes straightforward:

1. **Clone the Repository**:

   ```bash git clone https://github.com/yourusername/pipulate.git cd pipulate
   ```

2. **Enter the Development Shell**:

   ```bash nix develop ```

   This command sets up the development environment with all the specified
   packages.

3. **Start JupyterLab**:

   ```bash jupyter lab ```

   Now, you have a fully functional JupyterLab environment with all the
   necessary packages, regardless of whether you're on NixOS or macOS.

### Enabling CUDA Support (For Systems That Have It)

If you're on a system with CUDA support (like my NixOS machine with an NVIDIA
GPU), you can create a `local.nix` file in the project directory:

```nix { cudaSupport = true; } ```

This file is ignored in version control (by adding `/local.nix` to `.gitignore`)
to prevent affecting others. With `cudaSupport` enabled, the development shell
will include CUDA-related packages and enable GPU acceleration.

---

## Keeping System Configuration Minimal

To avoid bloating my system configuration and ensure portability, I kept my
`configuration.nix` minimal and focused on system-specific settings. Here's an
abbreviated version:

```nix # configuration.nix { config, pkgs, ... }:

{ imports = [ ./hardware-configuration.nix ];

  # System settings system.stateVersion = "24.05"; networking.hostName =
  "nixos"; time.timeZone = "America/New_York";

  # User accounts users.users.mike = { isNormalUser = true; extraGroups = [
  "wheel" ]; };

  # Desktop environment services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # System packages environment.systemPackages = with pkgs; [ firefox # Add
  other system-wide packages here ];

  # Enable Nix Flakes nix.settings.experimental-features = [ "nix-command"
  "flakes" ]; } ```

By keeping the system configuration focused, I prevent unnecessary packages and
settings from affecting my system's stability and performance.

---

## The Benefits of This Approach

- **Reproducibility**: Using Nix flakes ensures that the development environment
  is consistent across all machines, eliminating the "works on my machine"
  problem.

- **Portability**: Coworkers on macOS can easily enter the same development
  environment without complex setup.

- **Isolation**: The development environment is isolated from the system
  configuration, preventing conflicts and ensuring that system updates don't
  break the development setup.

- **Flexibility**: Conditional features like CUDA support can be enabled per
  user without affecting others.

- **Scalability**: This setup can be extended to cloud deployments or scaled
  across multiple machines as needed.

---

## Overcoming Challenges

Admittedly, this journey wasn't without hurdles:

- **Understanding Nix Flakes**: The learning curve for Nix and flakes is steep.
  I spent time troubleshooting syntax errors and understanding how to structure
  the flake properly.

- **Separating Concerns**: Deciding what belongs in `configuration.nix` versus
  the flake required careful consideration to maintain a clean and maintainable
  setup.

- **Cross-Platform Issues**: Ensuring compatibility between NixOS and macOS
  involved handling platform-specific dependencies and dealing with differences
  in package availability.

But overcoming these challenges has been rewarding. I now have a development
environment that is:

- **Consistent**: Same tools and packages, regardless of the underlying system.
- **Shareable**: Easy for coworkers to set up and use.
- **Maintainable**: Clean separation between system configuration and
  development environment.

---

## Conclusion

Moving to NixOS and embracing Nix flakes has been a game-changer for me. Not
only do I have full control over my system configuration, but I also have a
powerful tool for creating and sharing development environments. This setup
solves the "not on my machine" problem and paves the way for more efficient
collaboration.

Whether you're a solo developer or part of a team, I highly recommend exploring
Nix and flakes. It might seem daunting at first, but the benefits in terms of
reproducibility, portability, and maintainability are well worth the effort.

---

**Next Steps**:

- **Experiment Further**: I'm planning to integrate more complex setups,
  including web servers and database services, into the flake.
- **Cloud Deployment**: Looking into deploying this environment to cloud
  platforms for scalability.
- **Community Engagement**: Sharing my experiences with the Nix community to
  learn from others and contribute back.

---

By sharing this journey, I hope to inspire others to take control of their
development environments and embrace the power of Nix.
