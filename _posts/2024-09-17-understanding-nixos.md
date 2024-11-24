---
title: Updating NixOS
permalink: /futureproof/updating-nixos/
description: I share my experience transitioning to NixOS from traditional Linux distributions like Ubuntu and Fedora, highlighting the unique aspects of NixOS's filesystem hierarchy and package management. I explain the benefits of Nix's deterministic packaging system and how it can be leveraged on macOS and Windows using Nix Flakes. I also provide a step-by-step guide for getting started with Nix Flakes and emphasize the importance of embracing the NixOS philosophy for improved productivity and simplified software management.
layout: post
---

Switching to NixOS has been quite an adventure for me, and I wanted to create this article as a helpful guide for anyone else considering the leap. Coming from familiar Linux distributions like Ubuntu and Fedora, I understand how daunting NixOS can seem at first. Whether you're a seasoned Linux user or someone on Mac or Windows just exploring the power of the nix command, this guide aims to simplify the transition and highlight the incredible benefits Nix offers. By sharing my experiences and breaking down the essentials, I hope to make Nix and NixOS feel more approachable and less intimidating. Let’s dive in and discover how Nix can transform your software management and development workflows!

# Nix and NixOS Essentials

Switching to **NixOS** can be challenging, especially if you're coming from Debian or Red Hat-based Linux distributions like **Ubuntu** or **Fedora**. It often requires a bit of mental rewiring. My background is in Debian-oriented Linuxes, such as Ubuntu—the same distro that Microsoft selected as the default for their **Windows Subsystem for Linux (WSL)**. This choice has elevated Ubuntu's popularity to match that of billion-dollar enterprise Linux distributions like **Red Hat** and **SUSE**. Despite their differences, all these systems offer a way to update the entire system, typically avoiding the need to jump to a new major version.

## Traditional Linux Update Commands

### Ubuntu

On Ubuntu, we're accustomed to running:

```bash
sudo apt update
sudo apt upgrade
```

### Red Hat

Red Hat offers a similar experience with:

```bash
sudo dnf check-update
sudo dnf upgrade
```

### openSUSE

openSUSE uses:

```bash
sudo zypper refresh
sudo zypper update
```

### NixOS

In contrast, NixOS handles updates with:

```bash
sudo nix-channel --update
sudo nixos-rebuild switch
```

Navigating these different update mechanisms is part of the learning curve when transitioning to NixOS, but understanding these commands is essential for managing your system effectively.

---

## Embracing NixOS: A Personal Transition

I'm establishing this page as a reference to remember these details while completing my transition to NixOS.

NixOS is **very different** from other Linux distributions. While it's useful to have learned the ins and outs of Debian and Red Hat-based distros, transitioning to NixOS requires a bit of flexibility. One of the confusing aspects inherited from Unix is the [Filesystem Hierarchy Standard (FHS)](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard), which often perplexes users.

# Understanding the Filesystem Hierarchy Standard (FHS)

The **Unix/Linux Filesystem Hierarchy Standard (FHS)** can be confusing due to the apparent redundancy of directories like `bin`, `lib`, and others appearing in multiple locations. This design, while initially perplexing, serves important purposes related to system flexibility, modularity, and backwards compatibility.

## 1. Redundant-Looking Directories

You might encounter directories such as:

- `/bin`
- `/sbin`
- `/usr/bin`
- `/usr/sbin`
- `/usr/local/bin`

## 2. Rationale Behind the Structure

The seemingly redundant structure allows for:

- **Flexible Mounting:** Different parts of the filesystem can be mounted on separate physical devices or partitions. For example, `/usr` might reside on a different partition or even a network share.
  
- **System Abstraction:** Distinguishes between *essential* and *non-essential* binaries. `/bin` and `/sbin` contain critical executables needed for basic system operation and recovery, while `/usr/bin` and `/usr/local/bin` house less critical software.
  
- **Separation of Vendor-Supplied vs. Locally-Installed Software:** `/usr/local` is typically reserved for software compiled and installed by the local administrator.

## 3. Use of Symbolic Links

Many modern distributions use **symbolic links** to simplify this structure while maintaining compatibility. For example:

```bash
/bin -> /usr/bin
/sbin -> /usr/sbin
/lib -> /usr/lib
```

This approach combines the benefits of the traditional hierarchy with a more streamlined structure.

## 4. Practical Benefits

Imagine a scenario where a system's root partition (`/`) becomes corrupted or full. If all executables were in `/bin` on the root partition, the system might become unbootable or unable to run repair tools. With the FHS structure:

- **Critical Repair Tools:** Remain accessible in `/bin` and `/sbin`.
- **Larger `/usr` Partition:** Can stay intact, preserving most of the system's functionality.
- **Administrative Flexibility:** Administrators can boot into a minimal environment, mount `/usr` separately if needed, and perform repairs.

This separation also facilitates easier system updates, as most changes can be made to `/usr` while leaving the critical root filesystem untouched, reducing the risk of rendering the system unbootable.

# NixOS and the `/nix/store/`: Redefining the Filesystem Hierarchy

One of the most striking differences between NixOS and traditional Linux distributions lies in how they handle the filesystem hierarchy. While the [FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) has long dictated the structure of directories like `/bin`, `/lib`, and `/usr`, NixOS takes this philosophy to its ultimate extreme with the **`/nix/store/`**. Let’s dive into what this means and why it matters.

## Enter `/nix/store/`: A Radical Departure

NixOS replaces the traditional FHS with its own innovative approach centered around the `/nix/store/` directory.

### 1. **Unique Hashes for Every Package**

Every package in NixOS is stored in `/nix/store/` with a **unique hash** appended to its name, such as `/nix/store/abcd1234-package-name`. This hashing ensures that each version of a package is isolated, eliminating any chance of conflicts or collisions between different versions or configurations.

### 2. **Immutable and Declarative**

The `/nix/store/` is **immutable**, meaning that once a package is built and stored, it doesn’t change. This immutability aligns with NixOS’s declarative configuration model, where the entire system state is defined in configuration files, ensuring reproducibility and reliability.

### 3. **Symlinked to Conventional Locations**

Despite the unconventional storage path, NixOS maintains compatibility with traditional directory structures through **symbolic links**. For example, `/bin` might be a symlink to `/nix/store/abcd1234-bin/bin`, allowing applications and users to interact with the system as if it still adhered to the FHS.

## Taking FHS Philosophy to the Extreme

NixOS’s approach can be seen as an evolution of the FHS principles:

- **Modularity and Flexibility:** By isolating each package with a unique hash, NixOS ensures that different versions can coexist without interference, enhancing modularity and flexibility beyond what FHS offers.
  
- **Backward Compatibility:** Symbolic links bridge the gap between the traditional FHS structure and NixOS’s unique storage mechanism, maintaining compatibility with existing tools and workflows.
  
- **Ultimate Conflict Prevention:** The unique hashing system eradicates the possibility of file conflicts and version clashes entirely, a feat that FHS’s symbolic links alone cannot achieve.

## The Trade-offs: Space and Convention

While NixOS’s approach offers unparalleled benefits in terms of conflict prevention and system reliability, it does come with certain trade-offs:

- **Increased Disk Usage:**  
  Storing each package version separately means that multiple copies of similar libraries and binaries can consume more disk space compared to traditional package management systems that reuse shared libraries.
  
- **Breaking FHS Conventions:**  
  By deviating from the standard directory hierarchy, NixOS introduces a learning curve and requires users to adapt to new conventions. Tools and scripts expecting a traditional FHS layout might require adjustments to work seamlessly with NixOS’s structure.

Despite these drawbacks, the benefits of NixOS’s innovative filesystem approach—such as **atomic upgrades**, **rollback capabilities**, and **reproducible builds**—often outweigh the inconveniences for users who prioritize system reliability and flexibility.

# What Happens Under the Hood?

Let’s take a closer look at the commands we introduced earlier and what they actually do:

```bash
sudo nix-channel --update
sudo nixos-rebuild switch
```

## 1. `sudo nix-channel --update`

This command **updates the Nix channels**, which are essentially repositories containing package definitions and system configurations. By updating the channels, you ensure that you have access to the latest package versions and NixOS configurations.

## 2. `sudo nixos-rebuild switch`

This command **rebuilds your NixOS system** based on the current configuration files. It compiles any updated packages, applies configuration changes, and switches your system to the new state. The `switch` subcommand ensures that the new configuration is immediately activated without requiring a reboot.

## Final Steps: Reboot and Garbage Collection

After performing a system rebuild, it’s good practice to **reboot your machine**. This ensures that all running services and the kernel are using the latest configurations and updates.

```bash
sudo reboot
```

Once your system is back up, you can free up disk space by running a **garbage collection**. NixOS doesn’t automatically delete old packages and configurations, so this step helps reclaim space used by outdated or unused components.

```bash
sudo nix-collect-garbage -d
```

The `-d` flag tells Nix to delete all unused packages and old generations, keeping only the current system state and essential dependencies. Regular garbage collection helps maintain a clean and efficient `/nix/store/`, preventing unnecessary bloat over time.

# Nix’s Deterministic Packaging System

One of the standout features of NixOS is its **deterministic packaging system**. Thanks to the immutable and hashed nature of the `/nix/store/`, every package and its dependencies are precisely defined and isolated. This determinism ensures that builds are reproducible, meaning that the same package built on different machines or at different times will yield identical results.

## Why Determinism Matters

Deterministic builds bring several advantages:

- **Reproducibility:** You can recreate environments reliably, which is crucial for development, testing, and deployment.
- **Reliability:** Eliminates the "it works on my machine" problem by ensuring consistent behavior across different systems.
- **Security:** Immutable packages reduce the risk of unauthorized changes or tampering.

# Easier Package Management for Mac and Windows Users

While transitioning to NixOS as a full operating system can be daunting, **Mac** and **Windows** users can still harness the power of Nix without diving into the complexities of NixOS. By using the `nix` command-line tool, users on these platforms can manage packages efficiently and enjoy many of the benefits that Nix offers.

## Nix on Non-NixOS Systems

Installing Nix on macOS or Windows (via WSL) allows users to:

- **Manage Packages:** Install, update, and remove software packages with ease.
- **Isolated Environments:** Create isolated development environments that prevent dependency conflicts.
- **Reproducible Builds:** Ensure that your development setups are consistent across different machines.

Unlike traditional package managers that might require multiple steps, environment variable configurations, and manual dependency management, Nix simplifies the process significantly.

# Simplifying Software Installation with Nix Flakes

In the broader ecosystem of software development, tutorials often involve **long, convoluted installation processes**. You might find yourself running multiple commands to install dependencies, setting numerous environment variables, and configuring your system in specific ways just to get a project up and running.

## Enter Nix Flakes

**Nix Flakes** streamline this process by encapsulating all the necessary configurations and dependencies into a single, reproducible unit. With Flakes, you can:

- **Clone a Repository:** Easily clone a repository that includes a `flake.nix` file.
- **Develop with Ease:** Use the `nix develop` command to set up a fully functional development environment in one step.
- **Isolated Environments:** Each Flake creates an isolated environment, ensuring that dependencies don't clash with each other or with your system.

### Example Workflow

Instead of following a multi-step installation process, you can achieve the same result with a single command:

```bash
git clone https://github.com/your/repo.git
cd repo
nix develop
```

This approach not only saves time but also reduces the potential for errors, making the setup process much more reliable and user-friendly.

# Making Nix Accessible: From Cloning to Developing

For **Mac** and **Windows** users who are hesitant to adopt NixOS, using the `nix` command offers a gateway to experiencing Nix's powerful features without committing to a new operating system. Here's how you can get started:

## Step-by-Step Guide

1. **Install Nix:**
   
   - **macOS:** Follow the [Determinate Systems installation guide](https://determinate.systems/install/macos).
   - **Windows:** Install via [Determinate Systems installation via WSL](https://determinate.systems/install/windows).

2. **Clone a Repository with a Flake:**

   ```bash
   git clone https://github.com/your/repo.git
   cd repo
   ```

3. **Enter the Development Environment:**

   ```bash
   nix develop
   ```

   This command sets up an isolated, fully working environment based on the specifications in the `flake.nix` file. All dependencies are handled automatically, and environment variables are configured without manual intervention.

## Benefits for Developers

- **Consistency:** Ensures that all team members are working in identical environments.
- **Simplicity:** Reduces setup time and complexity, allowing developers to focus on coding.
- **Isolation:** Prevents dependency conflicts by encapsulating project-specific configurations.

# Embracing the NixOS Philosophy

Transitioning to NixOS requires embracing its unique approach to package management and system configuration. By leveraging the power of the **`/nix/store/`** and its declarative model, NixOS offers a level of control and reliability that’s hard to match with traditional Linux distributions. While there are trade-offs in terms of disk usage and adherence to conventional filesystem structures, the benefits of **reduced conflicts**, **reproducibility**, and **seamless rollbacks** make NixOS a compelling choice for those willing to adapt to its paradigm.

## Embracing Nix on Any Platform

As you continue your journey with NixOS, remember that the initial learning curve pays off with a system that’s both **robust** and **highly customizable**. With commands like `nix-channel --update` and `nixos-rebuild switch` at your fingertips, along with regular maintenance through garbage collection, you’ll find managing your NixOS system to be both powerful and rewarding.

For **Mac** and **Windows** users, leveraging the `nix` command and **Nix Flakes** provides many of the same benefits without the need to adopt NixOS as your primary operating system. Whether you're a seasoned Linux user or someone new to the ecosystem, Nix offers tools that can enhance your productivity and streamline your software management processes.

**Embrace the change**, and let Nix transform the way you think about package management and development environments. With its deterministic nature and streamlined processes, Nix makes managing software simpler, more reliable, and much more efficient.

# Conclusion: Nix for Everyone

While **NixOS** offers a revolutionary approach to Linux system management, its underlying tools, like the `nix` command and **Nix Flakes**, provide significant advantages even for users on **macOS** and **Windows**. By embracing Nix's deterministic and reproducible packaging system, you can simplify your development workflows, reduce setup times, and create reliable, isolated environments with ease.

## Embracing NixOS for Enhanced Productivity and Simplified Software Management

Don't let the initial complexity of NixOS deter you. Whether you're a seasoned Linux user or someone new to the ecosystem, Nix offers tools that can enhance your productivity and streamline your software management processes. By leveraging Nix on your current operating system, you can gradually integrate its powerful features into your workflow without the need to overhaul your entire system.

**Give Nix a try**, and discover how it can transform your approach to package management and development environments. With its deterministic nature and streamlined processes, Nix makes managing software simpler, more reliable, and much more efficient.
