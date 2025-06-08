---
title: "From GitHub Pages to Home Hosting: Building a Robust Jekyll Development Environment"
permalink: /futureproof/github-pages-home-hosting-jekyll/
description: In this post, I'm detailing my journey from relying on GitHub Pages for my Jekyll sites to building a more robust local development workflow. The core challenge was managing multiple Jekyll projects simultaneously, each with its own dependencies and port configurations. I solved this by creating a Nix flake that provides a consistent and isolated environment, including a custom script called `jes` to simplify running and managing these local Jekyll servers. This setup not only makes my current development much smoother but also lays crucial groundwork for my ultimate goal of moving all my sites to a self-hosted NixOS server at home.
meta_description: Guide to creating a Nix flake for a multi-site Jekyll development environment, managing ports, Ruby versions, and gems with a custom `jes` script for local hosting.
meta_keywords: jekyll, nix, nix flake, development environment, local development, multiple sites, github pages, home hosting, ruby, bundler, rouge, gem management, port configuration, jes script, nixos, nixpkgs, flake-utils, ruby version management, stdenv, pkg-config, openssl, zlib, libffi, libxml2, libxslt, static site generator, web hosting, devshell
layout: post
sort_order: 2
---

## Understanding Jekyll, Nix, and Local Web Development: Getting Started

Websites are often built using tools that help manage content and structure. One such tool is **Jekyll**, a popular "static site generator." This means it takes your raw content (like text written in a simple format called Markdown) and templates (which define the look and feel), and builds them into a complete set of HTML, CSS, and JavaScript files that can be easily hosted online. Many developers use services like **GitHub Pages** to host these static sites for free. GitHub Pages works seamlessly with Jekyll, automatically rebuilding and publishing your site when you update your content.

However, before publishing online, developers need to work on their sites locally on their own computers. This can become complex if you're managing multiple Jekyll websites, each potentially needing different settings or software versions. The article you're about to read delves into creating a sophisticated local development setup using a tool called **Nix**. Nix helps create reproducible and isolated environments, meaning the setup will work consistently across different computers and prevent conflicts between projects. The author is building this local environment not just for current development needs, but also as a stepping stone towards an even more ambitious goal: "home hosting," which means running their websites on a server they manage themselves at home, rather than relying on commercial services.

---

## The Journey Begins

In the world of web hosting, there's a fascinating dance between simplicity and complexity. Commercial web hosts have mastered the art of serving multiple websites from a single IP address using technologies like Server Name Indication (SNI) and name-based virtual hosting. This capability, once the domain of enterprise infrastructure, is now within reach of home users thanks to modern tools and practices.

My journey towards home-hosting multiple websites began with a simple need: to efficiently develop and preview multiple Jekyll-based sites locally before pushing them to GitHub Pages. This seemingly straightforward requirement led to the creation of a robust development environment that not only solves immediate needs but also serves as a stepping stone towards a full home-hosting setup.

## Current Setup: GitHub Pages and Jekyll

Like many developers, I host my websites on GitHub Pages. It's a fantastic service that offers:
- Free hosting for static websites
- Direct integration with Git repositories
- Automatic builds and deployments
- Built-in support for Jekyll

Jekyll, the static site generator powering GitHub Pages, is a powerful tool that:
- Converts Markdown and other text files into static websites
- Provides built-in support for blogs, documentation, and portfolios
- Offers a rich ecosystem of plugins and themes
- Embraces convention over configuration

However, while GitHub Pages handles the hosting, local development requires a reliable environment that can:
1. Run multiple Jekyll sites simultaneously
2. Handle dependency management effectively
3. Provide consistent behavior across different machines
4. Automatically detect and fix common issues

## The Development Environment Challenge

The challenge of running multiple Jekyll sites locally led to the creation of a Nix-based development environment. Nix, with its declarative approach to system configuration, provides the perfect foundation for a reproducible development setup.

Here's what we needed to solve:

1. **Multiple Sites, Multiple Ports**: Each Jekyll site needs its own port for local development
2. **Dependency Management**: Ruby gems and their native extensions can be tricky
3. **Version Conflicts**: Ruby version mismatches can break the entire setup
4. **Environment Isolation**: Each site should have its own gem environment

## The Solution: A Nix Flake for Jekyll Development

The solution came in the form of a Nix flake that provides a complete development environment. Let's look at the key components:

### 1. Environment Configuration

```nix
{
  description = "Nix flake for Jekyll environment with Rouge for syntax highlighting and Bundler support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          requests
          simplenote
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.ruby
            pkgs.jekyll
            pkgs.rubyPackages_3_2.rouge
            pkgs.neovim
            pkgs.git
            pythonEnv
            pkgs.stdenv.cc.cc.lib
            pkgs.pkg-config
            pkgs.openssl
            pkgs.zlib
            pkgs.libffi
            pkgs.libxml2
            pkgs.libxslt
          ];
        };
      });
}
```

### 2. The `jes` Command

The heart of our solution is the `jes` (Jekyll Environment Script) command. It handles:

- Automatic port configuration
- Ruby version compatibility checks
- Gem installation and management
- Site-specific server management

```bash
jes() {
  echo "Jekyll Environment Script v1.0.6"
  
  # Find the Jekyll root (where Gemfile exists)
  site_root="$current_dir"
  while [[ "$site_root" != "/" && ! -f "$site_root/Gemfile" ]]; do
    site_root="$(dirname "$site_root")"
  done

  # Read port from .port file or use default
  if [ -f "$site_root/.port" ]; then
    port=$(cat "$site_root/.port")
    echo "Using port $port from .port file"
  else
    port=4000
    echo "No .port file found, using default port $port"
  fi
}
```

### 3. Ruby Version Management

One of the most critical aspects is handling Ruby version mismatches:

```bash
check_ruby_version() {
  echo "Checking Ruby environment..."
  
  # Save current environment
  local old_gem_home="$GEM_HOME"
  local old_gem_path="$GEM_PATH"
  local old_path="$PATH"
  local old_bundle_gemfile="$BUNDLE_GEMFILE"
  local old_bundle_path="$BUNDLE_PATH"
  
  # Set environment for checks
  export GEM_HOME="$site_root/.gem"
  export GEM_PATH="$GEM_HOME"
  export PATH="$GEM_HOME/bin:$PATH"
  export BUNDLE_GEMFILE="$site_root/Gemfile"
  export BUNDLE_PATH="$GEM_HOME"
}
```

### 4. Site-Specific Server Management

To allow multiple sites to run simultaneously, we need to be careful about which server we stop:

```bash
# Kill any running Jekyll processes in this directory only
echo "Stopping any existing Jekyll servers in $(basename "$site_root")..."
pkill -f "jekyll serve.*$site_root" || true
```

## Using the Environment

To use this environment:

1. Create a `.port` file in your Jekyll site directory with your desired port number
2. Run `nix develop` to enter the development environment
3. Use `jes` to start your Jekyll server
4. Use `jes-stop` to stop all Jekyll servers
5. Use `rebuild-gems` if you encounter native extension issues
6. Use `reset-ruby-env` for a complete environment reset

## The Road Ahead

This development environment is just the first step towards a full home-hosting setup. The next phases will include:

1. Setting up a NixOS server on recycled hardware
2. Configuring Nginx for multiple site hosting
3. Implementing SSL/TLS with Let's Encrypt
4. Setting up dynamic DNS for the home IP
5. Creating automated deployment pipelines

## Conclusion

The journey from GitHub Pages to home hosting is not just about moving servers—it's about understanding the entire stack and building robust tools that make development and deployment easier. The Jekyll development environment we've created solves immediate needs while providing a foundation for future expansion.

In a future post, we'll look at setting up the NixOS server and configuring it for multiple site hosting. Stay tuned!

---

## AI Analysis

* **Title/Headline Ideas & Filenames:**

    * Title: Crafting a Multi-Site Jekyll Dev Environment with Nix Flakes
        Filename: `multi-site-jekyll-dev-environment-nix-flakes.md`
    * Title: From GitHub Pages to Home Server: A Nix-Powered Jekyll Workflow
        Filename: `github-pages-home-server-nix-jekyll-workflow.md`
    * Title: Solving Jekyll's Multi-Site Mayhem: A Developer's Nix Flake Solution
        Filename: `jekyll-multi-site-nix-flake-solution.md`
    * Title: Building a Reproducible Jekyll Development Setup with Nix and the `jes` Script
        Filename: `reproducible-jekyll-dev-setup-nix-jes-script.md`
    * Title: Nix for Jekyll: Streamlining Local Development for Multiple Websites
        Filename: `nix-for-jekyll-local-development-multiple-websites.md`

* **Strengths:**
    * **Practical Problem-Solving:** The article addresses a real-world challenge faced by developers working with multiple Jekyll sites (port conflicts, dependency management).
    * **Reproducibility:** Leveraging Nix flakes is a significant strength, as it promotes a highly reproducible and isolated development environment, which is a best practice.
    * **Clear Motivation:** The author clearly outlines the "why" behind creating this environment, linking it to both immediate needs and a longer-term home-hosting goal.
    * **Code Examples:** The inclusion of the Nix flake configuration and snippets of the `jes` script provides concrete implementation details.
    * **Structured Approach:** The article is logically structured, moving from the problem statement to the solution components and future plans.

* **Weaknesses:**
    * **Assumed Knowledge:** The article assumes a high degree of familiarity with Nix, Nix flakes, Ruby, Bundler, and Jekyll internals. A reader without this background would likely find it difficult to follow.
    * **Incomplete Scripts:** While snippets of the `jes` command and `check_ruby_version` function are provided, they are not complete. This could be frustrating for readers trying to implement the solution directly from the article as presented. (e.g., `current_dir` in `jes` is not defined in the snippet, and the script logic is truncated).
    * **Niche Focus:** The specific combination of Nix for Jekyll development, while powerful, caters to a relatively niche audience within the broader web development community.

* **AI Opinion:**
This article provides a valuable, albeit highly technical, walkthrough of creating a sophisticated local development environment for managing multiple Jekyll websites using Nix flakes. For developers already versed in Nix and facing the described challenges with Jekyll, this content is likely very useful and offers a robust solution. The clarity is high for its intended audience, but the steep learning curve of Nix means it's not easily accessible to beginners or those unfamiliar with declarative package management. The article serves well as a technical log or a blueprint for a specific problem, demonstrating a practical application of Nix for web development workflows. Its potential for a book chapter is strong, provided it's expanded with more complete examples and perhaps some foundational explanations of Nix for those less familiar.
