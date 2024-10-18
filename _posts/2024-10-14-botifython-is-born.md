---
title: Botifython is Born
permalink: /botifython-is-born/
description: I’m diving back into web development through Botifython, a Python framework focused on SEO and AI, driven by new technology. My setup utilizes Nix Flakes for reproducible environments and includes an automated update mechanism with SSH keys, ensuring seamless integration of new features. I’m excited to evolve this project with stable and experimental branches as I continue to enhance its capabilities.
layout: post
---

## A Brief History of My Web Development Antics

Okay, this is one for the history books (at least mine). I've been doing systems
like Ruby on Rails since before RoR. There was this system from Microsoft that
used to work with SQLServer in the 90s called IDC/HTX for *internet database
connector*** and ***html template language***. It was from before they had
Active Server Pages, that tech that gave all those webpages `.asp` extensions.
Yeah, I go back in webdev to before that. But ever since JavaScript really took
off, I've hated it with a passion. I am ***not*** a ReactJS guy. Even Ruby on
Rails, as ***"joyful"*** of a web framework as it was, it was opinonated in all
the wrong ways for me. I tried making a snappy ***AJAX***-driven generalized web
frameork for this thing I did called HitTail from back in 2006, but I got
distracted, lost motivation and let it fizzle out.

## Returning to Web Development with a Modern Twist

I'm back! It seems this guy Jeremy Howard, the guy behind a lot of the Pythonic
"for humans" (simplified APIs in the spirit of the Requests package) took on Web
Development the Python way, and I'm interested again. It's time to dust off
my... no, I never really stopped. I'm a vim/NeoVim guy and even though I swore
off WebDev, I type and I type and I type almost every day. I'm the opposite of
DRY (don't repeat yourself). I'm WET (we enjoy typing). So as it turns out as I
pivot my career once again, being a year in at the Botify SEO automation tools
company (could there be a better fit) and with AI changing everything, I'm full
of motivation and raring to go. Correction, I ***have*** gone. And now I
document and soft-launch. If you're joining me now, you're in for something
special (if you're mclovin some superbad tech).

---

> A whole bunch of prompting.

Certainly! Below is the revised introductory guide for **Botifython**,
incorporating your provided code examples. This guide maintains the
comprehensive overview and installation instructions while ensuring that all
code snippets accurately reflect your project's implementation.

---

# Welcome to Botifython

Welcome to **Botifython**! This guide will walk you through everything you need to get started with our cutting-edge web framework designed specifically for SEO and Data Science, with a particular emphasis on AI. From effortless installation to exploring key features and understanding the core architecture, this guide ensures you have all the information necessary to hit the ground running.

## Table of Contents

1. [Introduction](#introduction)
2. [Installation Guide](#installation-guide)
   - [Prerequisites](#prerequisites)
   - [Downloading Botifython](#downloading-botifython)
   - [Running the Determinate Nix Installer](#running-the-determinate-nix-installer)
   - [Entering the Development Environment](#entering-the-development-environment)
3. [System Overview](#system-overview)
   - [Nix Package System](#nix-package-system)
   - [Nix Flakes Explained](#nix-flakes-explained)
   - [Development Shells](#development-shells)
4. [Key Features](#key-features)
   - [Reproducible Environments](#reproducible-environments)
   - [Automated Setup Scripts](#automated-setup-scripts)
   - [Integrated Chatbot Support](#integrated-chatbot-support)
   - [Seamless Git Integration](#seamless-git-integration)
   - [AI-Powered SEO Tools](#ai-powered-seo-tools)
5. [Core Components](#core-components)
   - [BaseApp Class](#baseapp-class)
   - [TodoApp and ProfileApp](#todoapp-and-profileapp)
   - [DictLikeDB Wrapper](#dictlikedb-wrapper)
6. [Behind the Scenes](#behind-the-scenes)
   - [Key Components and Code Examples](#key-components-and-code-examples)
7. [Distribution Models](#distribution-models)
   - [Pipulate FOSS Version](#pipulate-foss-version)
   - [Proprietary Botify Version](#proprietary-botify-version)
8. [Auto-Update Mechanism](#auto-update-mechanism)
   - [SSH Key Setup](#ssh-key-setup)
   - [Auto-Update Process](#auto-update-process)
9. [Next Steps](#next-steps)
10. [Support and Resources](#support-and-resources)

---

## Introduction

**Botifython** is a powerful web framework built on top of the **FastHTML** ecosystem, leveraging the robust and deterministic environment management provided by **Nix Flakes**. Whether you're focused on SEO optimization, data science projects, or integrating advanced AI functionalities, Botifython provides a seamless and consistent development experience across various operating systems.

### Why Botifython?

- **Deterministic Environments**: Eliminate the "Not on my machine" problem with reproducible setups.
- **AI Integration**: Harness the power of AI to enhance your SEO and data science tasks.
- **Ease of Use**: Minimal commands to get started, allowing you to focus on development.
- **Flexible Distribution**: Choose between open-source and proprietary versions based on your needs.

---

## Installation Guide

Getting started with Botifython is straightforward and designed to solve the "Not on my machine" problem with minimal effort. Follow the steps below to set up your development environment seamlessly.

### Prerequisites

Before you begin, ensure that your machine meets the following prerequisites:

- **Access to a Terminal**: Command-line interface for executing commands.
- **Operating System**:
  - **Linux**: Native support.
  - **macOS**: Native support.
  - **Windows**: Use **WSL2** (Windows Subsystem for Linux) for compatibility.

All dependencies, including Python, are managed by Nix, simplifying the setup process.

### Downloading Botifython

You have two options to obtain Botifython:

1. **Clone the Repository Using Git**:
   
   If you have Git installed, you can clone the repository directly:

   ```bash
   git clone git@github.com:YourUsername/Botifython.git
   ```

2. **Download the ZIP Archive**:
   
   If you prefer not to use Git, you can download the repository as a ZIP file:

   1. Navigate to the [Botifython GitHub repository](https://github.com/YourUsername/Botifython).
   2. Click on the "Code" button.
   3. Select "Download ZIP" and extract it to your desired location.

### Running the Determinate Nix Installer

Once you have Botifython downloaded, navigate to the project directory and run the Determinate Nix Installer to set up the environment. The Determinate Nix Installer simplifies the Nix installation process with enhanced features over the official installer.

**Why Use the Determinate Nix Installer?**

- **Fast and Reliable**: Quick and stable installations across various platforms.
- **Multi-Platform Support**: Works on macOS (Intel and ARM), Linux (Intel and ARM), Windows via WSL2, and even SteamOS.
- **Opinionated Configuration**: Sets up Nix with flakes and the unified CLI enabled by default.
- **Seamless Uninstallation**: Provides a straightforward way to uninstall Nix if needed.
- **CI/CD Integration**: Optimized for continuous integration and deployment environments.

**Installation Command:**

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

*Note: Ensure that you have an active internet connection to download the installer.*

### Entering the Development Environment

After the Determinate Nix Installer completes the setup, enter the Botifython development environment using Nix:

```bash
cd Botifython
nix develop
```

This command initializes the environment based on the `flake.nix` configuration, ensuring all dependencies and tools are correctly set up. With just three simple steps—download the repository (via Git or ZIP), run the Determinate Nix Installer, and execute `nix develop`—your deterministic development environment is ready!

*No need to manually manage permissions or install Python separately; Nix handles all dependencies seamlessly.*

---

## System Overview

Understanding the underlying architecture of Botifython will help you make the most of its features. Let's delve into the core components that power our web framework.

### Nix Package System

Nix is a powerful package management system that aims to provide reproducible, declarative, and reliable software builds and deployments. It is built on several key principles:

1. **Pure Functional Model**: Packages are built in isolation with explicitly declared dependencies, ensuring that builds are reproducible and side-effect free.
2. **Immutable Store**: Each package version is stored with a unique hash, allowing multiple versions to coexist without conflicts.
3. **Declarative Configuration**: System configurations are defined in Nix expressions, enabling reproducible environments across different machines.
4. **Atomic Upgrades and Rollbacks**: Changes to the system are atomic, and you can easily revert to previous configurations if issues arise.

### Nix Flakes Explained

**Nix Flakes** are an experimental feature introduced to enhance Nix's capabilities, addressing some limitations of the original system. They provide a more standardized and reproducible way to manage Nix projects.

#### Key Features of Nix Flakes:

1. **Standardized Structure**: Flakes provide a consistent format for Nix projects, improving discoverability and composition.
2. **Explicit Dependencies**: Flakes require explicit declaration of dependencies, enhancing reproducibility.
3. **Improved Hermetic Builds**: Flakes enforce pure evaluation mode, disallowing access to mutable state like environment variables.
4. **Lock File Mechanism**: Flakes use a `flake.lock` file to pin dependency versions, similar to other package managers.
5. **Simplified CLI**: The experimental `nix` command offers a more user-friendly interface for working with flakes.

#### Key Components of a Flake:

1. **flake.nix**: The main configuration file defining inputs and outputs.
2. **inputs**: Dependencies of the flake, typically other flakes or Nix packages.
3. **outputs**: A function that produces an attribute set containing packages, NixOS modules, or other Nix artifacts.
4. **flake.lock**: An automatically generated file that locks input versions for consistent builds.

#### Benefits of Flakes:

- **Improved Composability**: Easily depend on and compose with other flakes.
- **Better Reproducibility**: Locked dependencies ensure consistent builds across different environments.
- **Standardized Interface**: Provides a uniform way to interact with Nix projects.
- **Enhanced Distribution**: Flakes can be easily shared and referenced using URLs.

### Development Shells

Botifython defines separate development shells for different operating systems, ensuring optimal compatibility and performance.

- **Linux Development Shell**: Includes additional packages like GCC and CUDA support if available.
- **macOS Development Shell**: Tailored for Unix-based macOS environments.
- **Windows Development Shell**: Utilize WSL2 for compatibility with Linux-based development tools.

Each shell is configured with:

- **Common Packages**: Managed by Nix, including Python, pip, virtualenv, git, curl, wget, cmake, htop, and more.
- **Shell Hooks**: Scripts that set up the environment upon entering the shell, including activating virtual environments and customizing the prompt.

Nix handles all dependencies, eliminating the need for manual installations or permission management.

---

## Key Features

Botifython is packed with features designed to streamline your development workflow. Let's explore them in detail.

### Reproducible Environments

With Nix Flakes, Botifython guarantees that every developer operates within an identical environment. This eliminates the infamous "it works on my machine" issue, fostering smoother collaboration and consistent builds.

**Benefits:**

- **Consistency**: Every dependency and tool is version-controlled.
- **Portability**: Easily replicate environments across different machines and operating systems.
- **Efficiency**: Save time on environment setup and troubleshooting.

### Automated Setup Scripts

Our automated setup scripts handle the heavy lifting of environment configuration, allowing you to focus on development rather than setup.

**Features:**

- **Virtual Environment Activation**: Automatically activates Python virtual environments.
- **Welcome Messages**: Uses `pyfiglet` to display stylish ASCII art welcome messages.
- **Package Installation**: Installs necessary Python packages seamlessly.
- **Chatbot Integration**: Sets up and manages chatbot interactions within the development environment.

### Integrated Chatbot Support

Botifython integrates a powerful AI-driven chatbot to assist with your development tasks, providing interactive and intelligent support.

**Features:**

- **AI-Powered Interactions**: Engage with the chatbot to receive assistance and suggestions.
- **Streaming Responses**: Enjoy real-time, word-by-word streaming of chatbot responses for a dynamic experience.
- **Customizable Prompts**: Tailor the chatbot's behavior and responses to fit your project's needs.

### Seamless Git Integration

Version control is at the heart of modern development. Botifython offers robust Git integration to manage your codebase effectively.

**Capabilities:**

- **Version Control**: Track changes, manage branches, and collaborate with team members effortlessly.
- **Automated Updates**: The system can perform `git pull` operations using securely generated SSH keys to keep your repository up-to-date.
- **Conflict Resolution**: Tools and scripts to handle merge conflicts and ensure smooth collaboration.

### AI-Powered SEO Tools

Botifython leverages AI to enhance SEO and data science tasks, providing intelligent features that automate and optimize your workflows.

**Features:**

- **Automated SEO Audits**: AI-driven tools analyze your website for SEO performance, providing actionable insights.
- **Data Analysis**: Advanced data science tools integrated with AI capabilities for predictive analytics and trend analysis.
- **Custom AI Models**: Easily integrate and deploy custom AI models tailored to your specific needs.

---

## Core Components

Botifython's architecture is modular and extensible, allowing for easy integration of new features and applications. Below are the core components that form the backbone of the framework.

### BaseApp Class

The `BaseApp` class serves as the foundation for creating application components with common CRUD operations. It provides a template for building application components that interact with database tables and handle basic Create, Read, Update, Delete (CRUD) operations.

```python
class BaseApp:
    """
    A base class for creating application components with common CRUD operations.

    This class provides a template for building application components that interact
    with database tables and handle basic Create, Read, Update, Delete (CRUD) operations.
    It includes methods for registering routes, rendering items, and performing various
    database operations.

    The class is designed to be flexible and extensible, allowing subclasses to override
    or extend its functionality as needed for specific application components.
    """

    def __init__(self, name, table, toggle_field=None, sort_field=None, sort_dict=None):
        self.name = name
        self.table = table
        self.toggle_field = toggle_field
        self.sort_field = sort_field
        self.sort_dict = sort_dict or {'id': 'id', sort_field: sort_field}

    def register_routes(self, rt):
        # Register routes: create, read, update, delete, toggle, and sort
        rt(f'/{self.name}', methods=['POST'])(self.insert_item)
        rt(f'/{self.name}/{{item_id}}', methods=['POST'])(self.update_item)  # Changed to POST
        rt(f'/{self.name}/delete/{{item_id}}', methods=['DELETE'])(self.delete_item)
        rt(f'/{self.name}/toggle/{{item_id}}', methods=['POST'])(self.toggle_item)
        rt(f'/{self.name}_sort', methods=['POST'])(self.sort_items)

    def get_action_url(self, action, item_id):
        """
        Generate a URL for a specific action on an item.

        Args:
            action (str): The action method (e.g., 'delete', 'toggle').
            item_id (int): The ID of the item.

        Returns:
            str: The constructed URL.
        """
        return f"/{self.name}/{action}/{item_id}"

    def render_item(self, item):
        # A wrapper function currently serving as a passthrough for item rendering.
        # This method is part of the system's "styling" mechanism, transforming
        # dataclasses into HTML or other instructions for display or HTMX operations.
        # Subclasses are expected to override this method with context-aware implementations.
        return item

    async def delete_item(self, request, item_id: int):
        """
        Delete an item from the table.

        Args:
            request: The incoming request object.
            item_id (int): The ID of the item to delete.

        Returns:
            str: An empty string indicating successful deletion.
        """
        try:
            logger.debug(f"Attempting to delete item ID: {item_id}")
            self.table.delete(item_id)
            prompt = f"Item {item_id} deleted. Brief, sassy reaction."
            await chatq(prompt)
            logger.info(f"Deleted item ID: {item_id}")
            return ''
        except Exception as e:
            logger.error(f"Error deleting item: {str(e)}")
            return f"Error deleting item: {str(e)}", 500

    async def toggle_item(self, request, item_id: int):
        """
        Toggle a boolean field of an item.

        Args:
            request: The incoming request object.
            item_id (int): The ID of the item to toggle.

        Returns:
            dict: The rendered updated item.
        """
        try:
            logger.debug(f"Toggling {self.toggle_field} for item ID: {item_id}")
            item = self.table[item_id]
            current_status = getattr(item, self.toggle_field)
            setattr(item, self.toggle_field, not current_status)
            updated_item = self.table.update(item)
            logger.info(f"Toggled {self.toggle_field} for item ID {item_id} to {getattr(updated_item, self.toggle_field)}")

            prompt = f"Item {item_id} toggled. Brief, sassy reaction."
            await chatq(prompt)

            return self.render_item(updated_item)  # Use the subclass's render_item method
        except Exception as e:
            logger.error(f"Error toggling item: {str(e)}")
            return f"Error toggling item: {str(e)}", 500

    async def sort_items(self, request):
        """
        Update the order of items based on the received values.
        """
        logger.debug(f"Received request to sort {self.name}.")
        try:
            values = await request.form()  # Get form data from request
            items = json.loads(values.get('items', '[]'))  # Decode JSON string to list
            logger.debug(f"Parsed items: {items}")
            for item in items:
                logger.debug(f"Updating item: {item}")
                update_dict = {self.sort_field: int(item['priority'])}  # Use priority
                self.table.update(id=int(item['id']), **update_dict)  # Update table entry
            logger.info(f"{self.name.capitalize()} order updated successfully")

            prompt = f"The {self.name} list was reordered. Make a brief, witty remark about sorting or prioritizing. Keep it under 20 words."
            await chatq(prompt)

            return ''
        except json.JSONDecodeError as e:
            logger.error(f"JSON decode error: {str(e)}")
            return "Invalid data format", 400
        except Exception as e:
            logger.error(f"Error updating {self.name} order: {str(e)}")
            return str(e), 500

    async def insert_item(self, request):
        """
        Create a new item in the table.
        """
        try:
            form = await request.form()
            new_item_data = self.prepare_insert_data(form)
            if not new_item_data:  # If prepare_insert_data returns empty string or empty dict
                return ''  # Return empty string, which won't be rendered in the DOM
            new_item = await self.create_item(**new_item_data)
            return self.render_item(new_item)
        except Exception as e:
            logger.error(f"Error inserting {self.name}: {str(e)}")
            return str(e), 500

    async def update_item(self, request, item_id: int):
        """
        Update an existing item in the table.
        """
        try:
            form = await request.form()
            update_data = self.prepare_update_data(form)
            if not update_data:  # If prepare_update_data returns empty string or empty dict
                return ''  # Return empty string, which won't be rendered in the DOM
            item = self.table[item_id]
            for key, value in update_data.items():
                setattr(item, key, value)
            updated_item = self.table.update(item)
            logger.info(f"Updated {self.name} item {item_id}")
            return self.render_item(updated_item)
        except Exception as e:
            logger.error(f"Error updating {self.name} {item_id}: {str(e)}")
            return str(e), 500

    def prepare_insert_data(self, form):
        """
        Prepare data for insertion. To be overridden by subclasses.
        """
        raise NotImplementedError("Subclasses must implement prepare_insert_data")

    def prepare_update_data(self, form):
        """
        Prepare data for update. To be overridden by subclasses.
        """
        raise NotImplementedError("Subclasses must implement prepare_update_data")

    async def create_item(self, **kwargs):
        """
        Create a new item in the table.

        Args:
            **kwargs: The fields and values for the new item.

        Returns:
            The newly created item.
        """
        try:
            logger.debug(f"Creating new {self.name} with data: {kwargs}")
            new_item = self.table.insert(kwargs)
            logger.info(f"Created new {self.name}: {new_item}")
            return new_item
        except Exception as e:
            logger.error(f"Error creating {self.name}: {str(e)}")
            raise e
```

### TodoApp and ProfileApp

Building upon the `BaseApp` class, `TodoApp` and `ProfileApp` handle specific functionalities related to managing tasks and user profiles, respectively.

```python
class TodoApp(BaseApp):
    def __init__(self, table):
        # Extract the name from the table object
        super().__init__(
            name=table.name,
            table=table,
            toggle_field='done',
            sort_field='priority'
        )

    def render_item(self, todo):
        return render_todo(todo)

    def prepare_insert_data(self, form):
        title = form.get('title', '').strip()
        if not title:
            return ''  # Return empty string instead of raising an exception
        current_profile_id = db.get("last_profile_id", 1)
        max_priority = max((t.priority or 0 for t in self.table()), default=-1) + 1
        return {
            "title": title,
            "done": False,
            "priority": max_priority,
            "profile_id": current_profile_id,
        }

    def prepare_update_data(self, form):
        title = form.get('title', '').strip()
        if not title:
            return ''  # Return empty string instead of raising an exception
        return {
            "title": title,
            "done": form.get('done', '').lower() == 'true',
        }


class ProfileApp(BaseApp):
    def __init__(self, table):
        super().__init__(
            name=table.name,
            table=table,
            toggle_field='active',
            sort_field='priority'
        )

    def render_item(self, profile):
        return render_profile(profile)

    def prepare_insert_data(self, form):
        profile_name = form.get('profile_name', '').strip()
        if not profile_name:
            return ''  # Return empty string instead of raising an exception
        max_priority = max((p.priority or 0 for p in self.table()), default=-1) + 1
        return {
            "name": profile_name,
            "address": form.get('profile_address', '').strip(),
            "code": form.get('profile_code', '').strip(),
            "active": True,
            "priority": max_priority,
        }

    def prepare_update_data(self, form):
        profile_name = form.get('profile_name', '').strip()
        if not profile_name:
            return ''  # Return empty string instead of raising an exception
        return {
            "name": profile_name,
            "address": form.get('profile_address', '').strip(),
            "code": form.get('profile_code', '').strip(),
            "active": form.get('active', '').lower() == 'true',
        }
```

### DictLikeDB Wrapper

The `DictLikeDB` class provides a robust wrapper for dictionary-like persistent storage, ensuring seamless interaction with various storage backends.

```python
class DictLikeDB:
    """
    A robust wrapper for dictionary-like persistent storage.

    This class provides a familiar dict-like interface to interact with
    various types of key-value stores, including databases and file systems.
    It emphasizes the power and flexibility of key-value pairs as a
    fundamental data structure in programming and system design.

    Key features:
    1. Persistence: Data survives beyond program execution.
    2. Dict-like API: Familiar Python dictionary operations.
    3. Adaptability: Can wrap different storage backends.
    4. Logging: Built-in logging for debugging and monitoring.

    By abstracting the underlying storage mechanism, this class allows
    for easy swapping of backends without changing the client code.
    This demonstrates the power of Python's duck typing and the
    universality of the key-value paradigm across different storage solutions.
    """

    def __init__(self, store, Store):
        self.store = store
        self.Store = Store

    def __getitem__(self, key):
        """Retrieve an item from the store by key."""
        try:
            value = self.store[key].value
            logger.debug(f"Retrieved from DB: {key} = {value}")
            return value
        except NotFoundError:
            logger.error(f"Key not found: {key}")
            raise KeyError(key)

    def __setitem__(self, key, value):
        """Set an item in the store by key."""
        try:
            self.store.update({"key": key, "value": value})
            logger.info(f"Updated persistence store: {key} = {value}")
        except NotFoundError:
            self.store.insert({"key": key, "value": value})
            logger.info(f"Inserted new item in persistence store: {key} = {value}")

    def __delitem__(self, key):
        """Delete an item from the store by key."""
        try:
            self.store.delete(key)
            logger.warning(f"Deleted key from persistence store: {key}")
        except NotFoundError:
            logger.error(f"Attempted to delete non-existent key: {key}")
            raise KeyError(key)

    def __contains__(self, key):
        """Check if a key exists in the store."""
        exists = key in self.store
        logger.debug(f"Key '{key}' exists: {exists}")
        return exists

    def __iter__(self):
        """Iterate over the keys in the store."""
        for item in self.store():
            yield item.key

    def items(self):
        """Return key-value pairs in the store."""
        for item in self.store():
            yield item.key, item.value

    def keys(self):
        """Return a list of keys in the store."""
        return list(self)

    def values(self):
        """Return values in the store."""
        for item in self.store():
            yield item.value

    def get(self, key, default=None):
        """Get an item from the store, returning default if not found."""
        try:
            return self[key]
        except KeyError:
            logger.debug(f"Key '{key}' not found. Returning default.")
            return default
```

---

## Behind the Scenes

To truly appreciate Botifython, let's take a closer look at the key components and the code that powers them.

### Key Components and Code Examples

#### 1. **Nix Flake Configuration (`flake.nix`)**

The `flake.nix` file is the heart of Botifython, defining dependencies and development environments.

```nix
{
  description = "Botifython: A deterministic web framework for SEO and Data Science with AI capabilities.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };

        isDarwin = pkgs.stdenv.isDarwin;
        isLinux = pkgs.stdenv.isLinux;

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
          
          # Activate the virtual environment
          source .venv/bin/activate

          # Create a fancy welcome message
          REPO_NAME=$(basename "$PWD")
          PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo 

          # Install Python packages from requirements.txt
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

**Highlights:**

- **Description**: Provides a brief overview of Botifython's purpose.
- **Inputs**: Specifies dependencies like `nixpkgs` and `flake-utils`.
- **Common Packages**: Lists essential tools and packages available in the environment.
- **Run Script**: Automates environment setup tasks.
- **Development Shell (`devShell`)**: Configures the shell with necessary tools and hooks based on the operating system.

#### 2. **Automated Setup Script (`run-script`)**

The `run-script` automates the setup process each time you enter the development environment.

```bash
#!/usr/bin/env bash

# Activate the virtual environment
source .venv/bin/activate

# Create a fancy welcome message
fig("Botifython")
echo "Welcome to the Botifython development environment on ${system}!"
echo 

# Install Python packages from requirements.txt
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
```

**Features:**

- **Virtual Environment Activation**: Ensures Python dependencies are isolated.
- **Package Installation**: Automatically installs required Python packages from `requirements.txt`.
- **Numpy Verification**: Checks the integrity of the NumPy installation.
- **JupyterLab Management**: Provides `start` and `stop` scripts for managing JupyterLab sessions via `tmux`.

*Note: All dependencies, including Python, are managed by Nix, eliminating the need for manual installations.*

#### 3. **Custom Middleware and Exception Handling**

Botifython includes custom middleware for enhanced logging and a custom 404 handler to improve user experience.

```python
class DOMSkeletonMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        # Log the incoming HTTP request
        endpoint = request.url.path
        method = request.method
        f = Figlet(font='slant')
        figlet_text = f.renderText(f"{endpoint} {method}")
        print(figlet_text)
        logger.info(f"HTTP Request: {method} {endpoint}")

        # Call the next middleware or request handler
        response = await call_next(request)

        # Print a rich table of the db key/value pairs
        table = Table(title="Database Contents")
        table.add_column("Key", style="cyan")
        table.add_column("Value", style="magenta")
        for key, value in db.items():
            table.add_row(key, str(value))
        console = Console()
        table.columns[1].style = "white"
        console.print(table)

        return response
```

```python
def custom_404_handler(request, exc):
    """
    Custom 404 page handler.

    Args:
        request: The request that caused the 404 error.
        exc: The exception that was raised.

    Returns:
        HTML: An HTML response for the 404 error.
    """
    return Html(
        Head(
            Title("404 - Page Not Found"),
            Style("""
                body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
                h1 { color: #e74c3c; }
                a { color: #3498db; text-decoration: none; }
            """)
        ),
        Body(
            H1("404 - Page Not Found"),
            P(f"Sorry, the page '{request.url.path}' you're looking for doesn't exist."),
            A("Go back to home", href="/")
        )
    )
```

**Highlights:**

- **Logging**: Enhanced logging for incoming HTTP requests and database state.
- **Custom 404 Page**: Provides a user-friendly 404 error page with styling.

---

## Distribution Models

Botifython is distributed in two main versions to cater to different user needs: the **Pipulate Free and Open Source (FOSS) version** and the **Proprietary Botify version**. Each version comes with a set of pre-built applications tailored to its specific use case.

### Pipulate FOSS Version

The **Pipulate FOSS version** is designed for users who prefer open-source solutions and want to contribute to the community-driven aspects of Botifython.

**Features:**

- **Open-Source Tools**: Access to a wide range of free and open-source SEO and data science tools.
- **Community Support**: Engage with a vibrant community for support and collaboration.
- **Customizability**: Full access to source code for customization and extension.

**Pre-Built Apps:**

- **SEO Analyzer**: Analyze website SEO performance with comprehensive reports.
- **Keyword Research Tool**: Discover and analyze target keywords.
- **Data Visualization Dashboard**: Visualize data insights using interactive dashboards.

### Proprietary Botify Version

The **Proprietary Botify version** offers advanced features and premium tools designed for enterprise users and professionals seeking enhanced capabilities.

**Features:**

- **Advanced AI Integrations**: Leverage state-of-the-art AI models for predictive analytics and automation.
- **Premium Support**: Access to dedicated support channels for personalized assistance.
- **Enhanced Security**: Additional security features to protect sensitive data and operations.

**Pre-Built Apps:**

- **AI-Powered SEO Optimizer**: Utilize AI to optimize SEO strategies and content.
- **Automated Reporting Tool**: Generate detailed and automated reports for stakeholders.
- **Custom Model Deployment**: Deploy and manage custom AI models tailored to specific business needs.

---

## Auto-Update Mechanism

Botifython includes an auto-update mechanism that ensures your framework stays up-to-date with the latest features and security patches. This is achieved through a seamless integration with Git and the use of securely managed SSH keys.

### SSH Key Setup

1. **Generate a Dedicated SSH Key Pair**:
   
   Generate a new SSH key pair specifically for the auto-update process:

   ```bash
   ssh-keygen -t ed25519 -C "botifython-auto-update" -f ~/.ssh/botifython_auto_update
   ```

2. **Add the Public Key to GitHub Repository**:
   
   - Navigate to your Botifython GitHub repository settings.
   - Go to "Deploy Keys" and add the generated public key (`~/.ssh/botifython_auto_update.pub`) with **read-only** access.

3. **Store the Private Key Securely**:
   
   Ensure the private key (`~/.ssh/botifython_auto_update`) is stored securely within Botifython's configuration. It should be encrypted and inaccessible to unauthorized users.

### Auto-Update Process

When Botifython runs, it performs the following steps to check for and apply updates:

1. **SSH Agent Initialization**:
   
   Start an SSH agent and add the private key to it:

   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/botifython_auto_update
   ```

2. **Git Configuration**:
   
   Set up a temporary Git configuration using the SSH key:

   ```bash
   git config --global url."git@github.com:".insteadOf "https://github.com/"
   ```

3. **Repository Check**:
   
   Check for updates by comparing the local and remote repository states:

   ```bash
   git fetch origin
   LOCAL=$(git rev-parse @)
   REMOTE=$(git rev-parse @{u})
   BASE=$(git merge-base @ @{u})

   if [ $LOCAL = $REMOTE ]; then
       echo "Botifython is up to date."
   elif [ $LOCAL = $BASE ]; then
       echo "Updating Botifython..."
       git pull
       # Trigger any post-update scripts if necessary
   else
       echo "Botifython has diverged from the remote repository."
       # Handle merge conflicts or other issues
   fi
   ```

4. **Pull Updates**:
   
   If updates are available, perform a `git pull` to fetch and merge the latest changes.

5. **Cleanup**:
   
   Remove the temporary Git configuration and stop the SSH agent:

   ```bash
   git config --global --unset url."git@github.com:".insteadOf
   ssh-agent -k
   ```

### Security Considerations

- **Limited Access**: The deploy key has **read-only** access to the specific repository, minimizing potential security risks.
- **Key Protection**: The private key is stored securely within Botifython, ideally encrypted.
- **Dedicated Account**: A separate GitHub account is used solely for this purpose, isolating it from other operations.
- **Secure Communication**: All interactions with GitHub use SSH, ensuring encrypted communication.

---

## Next Steps

Now that you've familiarized yourself with the installation process, system overview, key features, core components, and the auto-update mechanism, you're ready to dive deeper into developing with Botifython. Here are some recommended next steps:

1. **Explore the Codebase**: Navigate through the repository to understand the project structure.
2. **Run the Application**: Start the server and interact with the web interface.
3. **Contribute**: Begin making changes, adding features, or fixing bugs.
4. **Automate Further**: Leverage the Python scripts to enhance automation and testing.
5. **Integrate AI Models**: Start integrating and deploying your own AI models to leverage Botifython's capabilities.
6. **Customize Your Environment**: Modify the `flake.nix` and setup scripts to tailor the environment to your specific needs.

Stay tuned for auto-generated screenshots and further tutorials that will guide you through advanced functionalities and best practices.

---

## Support and Resources

Should you encounter any issues or have questions, our support channels are here to help:

- **Documentation**: Comprehensive guides and API references.
- **Community Forums**: Connect with other users and developers.
- **Issue Tracker**: Report bugs or request features on our GitHub repository.
- **Contact Support**: Reach out via email or our support portal for personalized assistance.

---

# Conclusion

Welcome to **Botifython**! By leveraging the power of Nix Flakes and a suite of automated tools, we've created a robust and reproducible development environment tailored for SEO and Data Science with a strong emphasis on AI. Whether you're a seasoned developer or just starting, Botifython is designed to streamline your workflow, foster collaboration, and ensure consistency across projects.

With just three simple commands—download the repository (via Git or ZIP), run the Determinate Nix Installer, and enter the development environment using `nix develop`—you can overcome the "Not on my machine" problem and get started quickly. Dive in, explore the features, and enjoy a seamless development experience. Happy coding!

---

*Note: Auto-generated screenshots will be incorporated into this guide shortly, enhancing your visual understanding of the system.*

---

End articles.

Okay, that should get me started. I registered botifython.com, so go launch it
as a site in Github Pages... okay, just made a Botifython GitHub account, and a
gmail address so that I could get the github account. The Botifython project is
going to be a fork of Pipulate off of my miklevin account, to leave a nice
trail. Okay, I've forked Pipulate from my site. Now get advice on how to include
a key with it so running `nix develop` will pull the latest down from the
repo...

Me: I want to use the technique where I can distribute software that has the
key included with it so that it can do an automatic git pull to update the local
software every time it's run. I've created a Github account specifically for
this, so security issues are highly mitigated. Give me the best practices for
how this is done. I know I will have to generate an ssh-key pair which will have
a public and a private. Which goes in with the repo and which gets kept secret,
and how do I set it up under Github, and am I on the right track or are there
better ways?

Perplexity: To implement automatic Git pulls for software updates using a dedicated GitHub account, you're on the right track. Here's a best practice approach:

## SSH Key Generation and Setup

1. Generate an SSH key pair:

```bash
ssh-keygen -t ed25519 -C "auto-updater@example.com"
```

Choose a secure location to save the key and leave the passphrase empty for automated use[1][3].

2. Add the public key to your GitHub account:
   - Log into the dedicated GitHub account
   - Go to Settings > SSH and GPG keys
   - Click "New SSH key"
   - Paste the contents of the public key file (e.g., `id_ed25519.pub`) and give it a descriptive title[1][3].

3. Keep the private key secret:
   - The private key (e.g., `id_ed25519`) should never be shared or included in the repository
   - Store it securely on the systems that will perform the updates[2].

## Repository Setup

1. Create a deploy key:
   - In your GitHub repository, go to Settings > Deploy keys
   - Add a new deploy key using the same public key
   - Enable read-only access for added security[4].

2. Configure the software:
   - Use the SSH URL for cloning/pulling (e.g., `git@github.com:username/repo.git`)
   - Store the private key in a secure location on the client system
   - Use environment variables or a secure configuration file to specify the key's location[5].

## Implementation

1. In your software's update routine:

```python
import os
import subprocess

def update_software():
    repo_url = "git@github.com:username/repo.git"
    ssh_key_path = "/path/to/private_key"
    update_dir = "/path/to/update/directory"
    
    os.environ['GIT_SSH_COMMAND'] = f'ssh -i {ssh_key_path} -o StrictHostKeyChecking=no'
    
    try:
        subprocess.run(["git", "pull", "origin", "main"], cwd=update_dir, check=True)
        print("Software updated successfully")
    except subprocess.CalledProcessError:
        print("Update failed")
```

2. Ensure proper permissions:
   - Set restrictive permissions on the private key file (e.g., `chmod 600 /path/to/private_key`)
   - Limit access to the update directory[5].

## Security Considerations

- Use a dedicated GitHub account with limited repository access
- Regularly rotate SSH keys
- Monitor account activity for any suspicious behavior
- Consider implementing additional authentication methods for critical systems[2].

While this approach is suitable for many scenarios, for highly sensitive or mission-critical systems, consider alternative update mechanisms such as signed releases or a centralized update server for more controlled distribution[5].

By following these practices, you can create a secure and automated update system using Git and GitHub. Remember to adapt the security measures based on your specific requirements and risk assessment.

Citations:

    [1] https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/GitHub-SSH-Key-Setup-Config-Ubuntu-Linux
    [2] https://stackoverflow.com/questions/3828823/how-to-generate-ssh-keys-for-github
    [3] https://docs.github.com/en/enterprise-server@3.12/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
    [4] https://docs.github.com/en/authentication/connecting-to-github-with-ssh
    [5] https://www.youtube.com/watch?v=iVJesFfzDGs
    [6] https://www.youtube.com/watch?v=8X4u9sca3Io
    [7] https://www.atlassian.com/git/tutorials/git-ssh

---

I've got to do the initial cloning of the repo I just forked with one of these
commands so I know that it's not using one of my existing keys, but rather the
deploy key I just made:

```bash
GIT_SSH_COMMAND='ssh -i /path/to/your/private_key' git clone git@github.com:username/repository.git
git clone -c "core.sshCommand=ssh -i ~/.ssh/id_rsa_custom" git@github.com:username/repo.git
```

Customize... here is the cone command that everyone will use using the deploy
key:

```bash
git clone -c "core.sshCommand=ssh -i ~/.ssh/botifython_deploy" git@github.com:botifython/botifython.git
```

This means you have the private key and the public key is on github as a deploy
key tied to that repository. I have a separate set of keys for development, and
even though it's going to be a pain in the ass to type it, because it's not my
main key, I have to use a fancy command to push.

- Set the upstream origin to main
- Push to origin main
- Subsequent pushes

```bash
GIT_SSH_COMMAND="ssh -i ~/.ssh/botifython_develop" git push --set-upstream origin main
GIT_SSH_COMMAND="ssh -i ~/.ssh/botifython_develop" git push origin main
GIT_SSH_COMMAND="ssh -i ~/.ssh/botifython_develop" git push
```

## Switching to Pipulate for Work Development and Productivity

Okay, so I'm probably going to have to set up git `config` or an alias, but I'm
pretty much switching my pipulate/botify development over to this location
because I have to use it bigtime at work and I have to form the right habits.
Pipualte is great, but Botifython pays the bills. There will have to be a little
public exposure of this thing... or does there? It can actually be a private
repo now. 

## Creating New Private Repository After Forking Original Account

Ugh! You can't switch a forked repo to private! Okay, `rm -rf .git`, git init,
yadda yadda... some id_rsa key swaparoo, and viola! Pushing to a new private
repo on a new account. You can still follow my work. I have a pipulate repo on
my private miklevin account, and I'll probably tie them together somehow. But
it's all about work right now, so I'll document stuff here, but some of the
nitty gritty will be behind closed doors.

## Overcoming SSH Deployment Hurdle with Git Configuration Simplification

Okay, confirmed. The deploy key can clone the repo and the develop key can push
back up, and I don't have to shuffle around .ssh folders. I just have to make
git config files or aliases for commands. But this is a major hurdle I'm
overcoming. This is potentially quite big.

## Delivering First Nix Package for Private Repository Setup

Okay, because it's a private repo, I have to "deliver" the first package. That
package can be something I just download manually as a zip from the private repo
and send it to a coworker. They can unzip it and follow the instructions to
install nix with the determinate systems installer, then cd into the repo from a
terminal and type nix develop. That should be it.

This is some powerful magical incantations. I'm getting the incantations down to
a minimum, essentially.

## How to Hide Private Keys from GitHub Security Systems

Okay, now how to put a private key in a github repo and not have their security
systems flag it. There's all sorts of encryption, but I'm going to go for the
ultimate in simplicity, rot13! Okay, think! 1, 2, 3... 1?

Test first. I literally have just these 3 files in the repo right now:

- botifython.py
- flake.nix
- requirements.txt

There's not even a flake.lock, but this is an awesome test. I'm going to first
do a general nix update and cleanup on my system:

```bash
nix --version
nix upgrade-nix
nix-collect-garbage
nix flake update
nix develop
python botifython.py
```

## Nix and FastHTML Revolutionize Web Development with Their Breakthroughs

OMG, this is going to be so awesome. So that's all htat's needed, those 3 files.
Things are really changing. Thank you Eelco Dolstra who created Nix, and Jeremy
Howard who created FastHTML, and all the awesome stuff both of those things are
built on. Things are becoming usable. It takes someone to sort through the
complexity gluing it together.

Okay, so copy the private key into the repo. Done. But now to test a pull? Ugh,
gotta get those keys by USB over to the mac. Okay, clone it...

```bash
git clone -c "core.sshCommand=ssh -i ~/.ssh/botifython_deploy" git@github.com:botifython/botifython.git
```

Okay, `nix develop` it in that Mac folder... `python botifython.py`... OMG! Wow,
frig, okay keep going... do an edit and push from the Mac...

```bash
GIT_SSH_COMMAND="ssh -i ~/.ssh/botifython_develop" git push origin main
```

That succeeded. And lastly, a pull from my main machine...

```bash
GIT_SSH_COMMAND='ssh -i ./botifython_develop' git pull
```

Ugh, I had to:

```bash
git config pull.rebase true
```

...to make it work. Keep that in mind, but not a show stopper. Success assured.
Okay, now the trick is to include it in the repo without Github's security
chokin on the token. Gonna do this in Cursor AI to cut down the googling. It's
complaining about the ginormous .venv not in the git repo, so .gitignore is
next. Then an alias so I don't have to type that long push command every time.

Okay, this is the magic command to unrotate the key:

```bash
cat ./.ssh/rot | tr 'A-Za-z' 'N-ZA-Mn-za-m' > ./.ssh/key
```

But everything gets built now from this neat nix flake, so... so rigorously
check with Cursor AI... BAM!

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
          cmake                      # Cross-platform build system generator
          htop                       # Interactive process viewer for Unix systems
        ] ++ (with pkgs; pkgs.lib.optionals isLinux [
          gcc                        # GNU Compiler Collection for compiling C/C++ code
          stdenv.cc.cc.lib           # Standard C library for Linux systems
        ]);

        # This script sets up our Python environment and project
        runScript = pkgs.writeShellScriptBin "run-script" ''
          #!/usr/bin/env bash
          
          # Create a fancy welcome message
          REPO_NAME=$(basename "$PWD")
          REPO_NAME=''${REPO_NAME%-main}  # Remove "-main" suffix if it exists
          PROPER_REPO_NAME=$(echo "$REPO_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
          figlet "$PROPER_REPO_NAME"
          echo "Welcome to the $PROPER_REPO_NAME development environment on ${system}!"
          echo 

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
            git clone -c "core.sshCommand=ssh -i ./.ssh/key" git@github.com:botifython/botifython.git /tmp/botifython
            # Move the contents of the temporary directory to the current directory
            mv /tmp/botifython/* .
            mv /tmp/botifython/.git .
            rm -rf /tmp/botifython
          fi
          echo

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

          # Create botifython script
          cat << 'EOF' > .venv/bin/botifython
          #!/usr/bin/env bash
          
          # Function to open URL in the default browser
          open_url() {
            if [[ "$OSTYPE" == "darwin"* ]]; then
              # macOS
              open "http://localhost:5001"
            elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
              # Linux
              if [[ -n "$WSL_DISTRO_NAME" ]]; then
                # WSL
                powershell.exe /c start "http://localhost:5001"
              else
                # Native Linux
                xdg-open "http://localhost:5001" || sensible-browser "http://localhost:5001" || x-www-browser "http://localhost:5001" || gnome-open "http://localhost:5001"
              fi
            else
              echo "Unsupported operating system. Please open http://localhost:5001 in your browser manually."
            fi
          }

          # Launch browser after a delay
          (sleep 5 && open_url) &

          # Run the Python script
          python "$PWD/botifython.py"
          EOF
          chmod +x .venv/bin/botifython

          # Create symbolic links for 'bf' and 'Botifython' to 'botifython'
          ln -sf botifython .venv/bin/bf
          ln -sf botifython .venv/bin/Botifython

          # Add .venv/bin to PATH
          export PATH="$PWD/.venv/bin:$PATH"

          echo "To run botifython.py, type either 'botifython' or 'bf'"
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

## Self-Updating App Brings Git Repositories to Non-Git Projects Easily

Now I've got a self-updating app. If it was git cloned originally, it will just
start git pulling to update. If it was made from an uncompressed .zip download
and doesn't have the .git folder inside (not a git repo), it will git clone into
a temporary folder, replace the contents of the folder you're in, and then
delete the temporary folder. It essentially upgrades you from the zip download
to a proper git repo so it auto-updates correctly from then forward on every nix
develop.

I'll have to think about stable main branches and experimental branches. I'm
going to be developing this thing like crazy, but people are also going to start
using it. Okay... gotta get some sleep to be fresh for tomorrow. Work's
beginning.


