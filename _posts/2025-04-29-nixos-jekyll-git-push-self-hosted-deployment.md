---
title: Migrating Jekyll from GitHub Pages to Self-Hosted NixOS via Git Push
permalink: /futureproof/nixos-jekyll-git-push-self-hosted-deployment/
description: "I'm documenting my recent experiments with site templates, which unfortunately tanked my SEO traffic, and outlining the next major step: migrating my Jekyll blog from GitHub Pages to a self-hosted NixOS server. This post serves partly as a journal entry reflecting on my experimental process, my use of AI super-prompts for planning, and partly as the setup stage, detailing the NixOS configuration (using Flakes, Git hooks, and Nginx) needed to create a Git push-based deployment system similar to GitHub Pages, but running on my own hardware."
meta_description: Configure NixOS for self-hosting a Jekyll blog via Git push deployment using SSH hooks, Nginx, and a Flake-based system configuration.
meta_keywords: NixOS, Jekyll, self-hosting, home hosting, Git, git push, deployment, post-receive hook, SSH, git-shell, Nginx, Flake, nix flake, system.nix, configuration.nix, web server, static site generator, infrastructure as code, IaC, Ruby, Bundler, Linux, server setup, blog deployment, GitHub Pages migration, git server, dynamic DNS, nix shell, SEO experiment, AI super-prompt
layout: post
sort_order: 2
---

## Understanding Secure Home Networks for Hosting: Getting Started

This article delves into the technical process of moving a personal blog from a platform like GitHub Pages to being hosted on a server run from the author's own home network. It chronicles the author's experiments with website optimization (like improving navigation), the impact these changes had on search engine visibility (SEO), and the decision to gain more control by self-hosting.

The core of the discussion focuses on setting up this home server using NixOS, a specialized Linux operating system known for making system configurations reproducible and manageable ("Infrastructure as Code"). The author details a specific plan using tools like Git (for version control and deployment), SSH (for secure connections), and Nginx (a web server) to create an automated workflow: when the author pushes blog updates using Git, the home server automatically rebuilds and publishes the site. The author also touches upon using Artificial Intelligence (AI) as a "super-prompt" tool to help generate and refine the necessary server configurations.

---

## Learning from SEO Experiments and Traffic Dips

This is an experimental site, so tanking the traffic isn't the worst thing in
the world. We learn from our mistakes, and I will come out of this with hard
facts on a particular instance with good data on that instance. That makes it
anecdotal data rather than statistical, but sometimes the exceptions reveal the
boundaries of the rule, and that is my intent here. We probe. We keep the pulse
of the evolving state of search. 

## The Freedom of a Non-Monetary Experimental Site

My site being maintained wholly in text files and in git as it is offers some
unique opportunities to experiment. It's not a monetary site — not even
advertising or affiliate links, so I have nothing to lose trying this and that.
And so I will tank my site's traffic occasionally. And so I did recently. Better
on experimental sites than on live client sites, though I have had my occasional
mishap there too. The more war stories and battle scars you accumulate where
stakes are not so high, the better. 

## Analyzing Recent Template Changes and Their Impact

On this latest round, I pushed forward on both the site templates side and on
the content front, so it is hard to correlate cause and effect. I suspect
templates since the changes were so aggressive implementing a client side
JavaScript table of contents system, and I have subsequently (just today) rolled
back all these template changes in a way that I can preserve a good bits and
implement them again when things settle down and site traffic recovery is in
full swing. 

## Documenting Changes for Future Reference

To that end, I will meticulously enumerate the changes I made to my site, one or
the combination of which tanked the traffic. I am doing this ahead of what I
hope to be one of my coming weekend projects, switching from GitHub Pages
hosting to home hosting. It was extremely interesting to know that I could start
to cause the hockey stick exponential traffic growth, even when hosting on
GitHub. However, the exponential traffic growth I briefly noticed was tied to
momentary traffic searching trends around the new Grok chatbot and its specific
idiosyncrasies. The traffic surged then waned. No exponential growth. A linear
growth pattern, and even a leveling off set back in. 

## Balancing UX Improvements with SEO Considerations

This was in part why I made the table of contents changes. I wanted to make sure
that when people discovered my site, they found it easier to navigate instead of
my extremely long and dense vertically scrolling pages. I wanted to make my site
more sticky, improve the user experience and while I believe it was successful
in the UX front (TocBot is AWESOME), it backfired on the SEO front. Yet
experiment like this are necessary in the site traffic will cover at least in
some small part sufficient for the next step, which is home hosting.

## Setting the Stage for Home Hosting Migration

The purpose of this particular article is to set the stage for that
home-hosting, and to layer in a tagging/categorization approach to my blog to
fix the homepage number of links overload problem. This blonde post is part of
the super prompt to compel me onto the next steps. Almost every article on my
blog now is the component of a super prompt to enlist ever increasing AI
intelligence to help navigate the way to the next step. Each block post is
actually the request for an implementation plan, currently which I'm putting
against Google 2.5 Experimental because it's the best at handling them at the
moment. This may change, and I leave my super-prompting process flexible to hop
around to different frontier AI models.

## My Three Daily Decision-Making Metaphors

So what's going to be the implementation request here? I'm not exactly sure, I
am working that out. I ask myself: what's most broken? Then I ask myself: where
do you get the biggest bang for the buck effort-wise? And then finally I ask
myself: what plates need to be spun to keep everything moving forward? These are
my three daily metaphors. What's most broke, where is the biggest bang for the
buck and what plates need to be spun? It addresses the progress-blocking weakest
link in the chain, the 80/20 rule best return on investment, and not letting
things fall by the wayside. 

## The Evolution of My Iterative Process

This process is designed to compel forever-improving iteration, however in
practice it is perhaps less than holy effective, or I would be a lot further
along in all my endeavors that I currently am. Though I rather suspect it is not
the rule that is less than effective so much so is my application of it. Though
things are changing now because I can filter it through AI on an almost daily
basis using sufficient context to protect continuity. Reverting to my old site
templates to get my SEO traffic back is really a spinning plate to do item that
I slammed out before the workday even began this morning. So I have answered
what plates need to be spun. Plate spinning! All I can do on that front at the
moment is wait. Perfect for a spinning plate to do item.

## Identifying Critical Path Development Needs

What's most broken is certainly not having a Pipulate Workflow out to my
coworkers that can be used on a day-in day-out basis for some critical path to
do item that has value across all clients — fueling the fire for all subsequent
things to come. Hand-in-hand with that is a YouTube video showing the use of it,
even if it's a company-only YouTube video employing Google Workspace login
criteria to keep it private. This will very much serve as practice for getting
out on YouTube again more generally — sort of like the coming out party after
going reclusive for a couple of years in order to get Pipulate updated given the
new state of the world with LLM AI. That was not work that could be conducted in
public.

## The Evolution of Code Organization with FastHTML

And that work really did amount to the experimental growth and expansion of a
base of code, and then the reeling it back in with a plug-in system. This
aligned to LLM AIs getting this massive token window that I could submit the
entire code based into as a single file, representing the single file of the
whole system — an approach that I could take because FastHTML. For those who
have not discovered the love yet, FastHTML functionally eliminates the need for
external CSS and JavaScript. However, the reality is that breaking things up
into multiple files is still the way to go in the long-run, only with a
different set of concerns. 

## XML Bundling for AI Super-Prompts

I still submit the entire code base to the massive token window frontier model
LLM AI's, only now I do it with a sort of packaging up of all the separate files
into a single XML file per the anthropic recommended syntax and protocol. It's
not highly formalized, it just happens to be what LLM's respond well to. It's an
alternative to imposing a little or no nesting structure at all — in other words
just markdown. Mere markdown was working as well for bundling the files
together, it's just that XML envelopes remove all ambiguity. I've included a
manifest and all sorts of stuff at the beginning, letting the LLM know what it's
about to encounter and what to look for as it passes the rest of the file and
where it's going to find the ultimate prompt at the end.

## Breaking Free from IDE Dependencies

Because of this XML bundling of a super-prompt, I am no longer beholden to a
particular AI code-assistant editor or IDE. Curser AI does not hold me captive,
and neither would VSCode if I switched back to it, which seems like a good idea
to get off kooky forks. It took me a while to come around to this way of
thinking, but because of the uptake of VSCode worldwide, it or its descendants
have now become part of the fabric of tech in a way that even Eclipse/IntelliJ
have not. Even as the platform it's based on, Chromium Electron evolves and
changes with the web browser, VSCode will adapt. VSCode is likely to be around
forever now while Cursor (proprietary) is not. Get all the AI code assistant API
innovations will continue Because it's been rolled back into the main VSCode
base. Classic Microsoft.

## Multi-Model AI Super-Prompt Strategy

But even without the fancy VSCode-based AI assistant editors, I am still free
because my bundle XML super-prompts can be submitted anywhere. Even though
Gemini 2.5 Experimental is out of the lead, I regularly send the same prompts to
Grok 3 as it seems determined to be the second runner-up. ChatGPT is always a
third runner-up in these super prompts, mostly because of the small context
windows of their latest models. I saw this with 4.5 recently and I see it again
with o4-mini-high. I generally have to go down to GPT-4o-mini for OpenAI to be
in the super-prompt horse race. The models boast of 1 million or 2 million token
windows, but my experience is they top-out practically at about 60K tokens. 

## Preparing for Home Hosting with NixOS

And so this is another spinning plate super prompt. The request of the AIs is to
look over my entire Jekyll codebase with me picking tbt files that are important
for it to be aware of. This is in preparation for moving a site that's currently
hosted with GitHub pages to actually be home-hosted. I'm probably not going to
play around with my templates again until some traffic recovery occurs, and as
that traffic recovery is occurring, I will probably be going into the weekend
for another round of super focused work during which I can do the hosting
switch. I already have the router in place. I already have the DMZ. I have tons
of hardware laying around that could fill in as a webserver. It's going to be
installed fresh with NixOS. 

## Hardware Flexibility with NixOS Infrastructure as Code

It almost doesn't matter what the base hardware is for the web server. A large
part of the point is that I will be able to move hosting around easily. This is
going to be a real test of the premise of nix/NixOS — infrastructure as code
(IaC). There was a little more generic than a web server serving up static
files. It will presumably also need an instance f Jekyll and all its
dependencies, but I already have a Nix Flake setting up my localhost preview
environment which I will include in the super-prompt. Life hosting I don't
suppose is going to be dramatically that different.

## Planning a GitHub Pages-Style Git Push Deployment System

And so the prompt is shaping up to be a request for planning an extremely
rudimentary git release system to mimic the way it works with GithHub Pages, aka
github.io. The server is going to be a NixOS machine configured as both a git
server that I can push to over a local home network and a webserver for nginx or
some other more appropriate webserver. It's actually going to serve the site to
the world using dynamic DNS and control your destiny with full control over and
transparency to the hosting hardware.

## Understanding the Dual-LAN Network Architecture

I'm still learning the local networking aspects of this. The main router that is
connected as to the Verizon Fios optical network terminal (OCT) and creates the
two physically separate local LANs. The Verizon-provided Fios router plugs into
one of the LAN ports and creates the traditional home network on which the
machine I do the web development is connected. It is the staging site where I
actually run Jekyll and do a localhost of preview of the site before it gets git
committed and pushed. 

## Securing Git Push Access Between Local Networks

An interesting aspect here is that I am going to be git pushing from one local
LAN to another local LAN, but on the other LAN it will be to a machine that I am
making generally accessible on the Web to allow it to provide hosting. And so
there will be another service/port/socket open there allowing it to work as a
git server, but I'm going to try to keep it locked-down security-wise. There
will probably be various options related to how to make it only accessible from
the machine I'm pushing from. For example, it's also a local LAN so maybe the
service/port/socket that allows git pushing to it might be a private network
address.

## Validating NixOS and AI-Assisted Development Workflows

Another interesting aspect is that this is testing and validation of switching
over to NixOS to facilitate the repurposability and interchangability of
hardware when using IaC. It's also the testing and validation of the context foo
system that lets me tap the frontier AI models this way. So what I want to do is
collect all the file-paths from among my system that could help.

```
/home/mike/repos/mikelev.in/flake.nix
/home/mike/repos/mikelev.in/Gemfile
/home/mike/repos/mikelev.in/_config.yml
/home/mike/repos/mikelev.in/_posts/2025-04-17-github-pages-logfiles.md
/home/mike/repos/MikeLev.in/_posts/2025-04-23-pfsense-firewall-secure-home-network-hosting-setup.md
```

## Leveraging Existing GitHub Pages Configuration Files

So those files include a lot of the hosting context of my current GitHub Pages
based system. The prompt is to plan the `configuration.nix` of the webserver
machine with the parts required to be a git host that I can push do just like I
do currently with GitHub pages.

## Designing a Git Push-Based Jekyll Publishing System

Let's outline the simplest way to achieve a Git push-based Jekyll publishing system using NixOS, focusing on a Flake-based approach (`flake.nix` and a system configuration file) as it's the modern standard for reproducibility.

The core idea is:
1.  Set up a bare Git repository on the NixOS server.
2.  Use SSH for Git pushes, authenticated via authorized keys.
3.  Use a Git `post-receive` hook script that triggers on push.
4.  The hook script checks out the code, uses Nix to get the correct Jekyll environment, builds the site, and copies it to the web server's root.
5.  Use Nginx (or another simple web server) to serve the built files.

---

**1. `flake.nix`**

This file defines the system configuration and its dependencies (primarily `nixpkgs`).

```nix
# flake.nix
{
  description = "Simple Git push-based Jekyll publishing server";

  inputs = {
    # Use a specific nixpkgs revision for reproducibility
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; # Or nixos-unstable, etc.
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      # Replace 'my-jekyll-server' with your desired hostname
      my-jekyll-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Or your server's architecture
        specialArgs = { inherit inputs; }; # Pass inputs if needed in modules
        modules = [
          # Import the main system configuration
          ./system.nix
          # You might add hardware-configuration.nix here if needed
        ];
      };
    };
  };
}
```

---

**2. `system.nix` (System Configuration)**

This file defines the users, services (SSH, Nginx), and the hook script setup.

```nix
# system.nix
{ config, pkgs, inputs, ... }:

let
  # Configuration Variables
  domainName = "your-jekyll-site.example.com"; # CHANGE THIS
  gitUserName = "gitjekyll";
  gitUserGroup = "gitjekyll";
  gitRepoPath = "/home/${gitUserName}/site.git";
  webRoot = "/var/www/${domainName}";
  tempCheckoutPath = "/home/${gitUserName}/tmp_checkout"; # Or use /tmp
  repoBranch = "main"; # Branch to deploy from
in
{
  imports = [
    # You might import specific hardware configs here
  ];

  # Basic system settings (adjust as needed)
  networking.hostName = "my-jekyll-server"; # Must match the key in flake.nix
  time.timeZone = "America/New_York";       # CHANGE THIS if needed
  networking.firewall.allowedTCPPorts = [ 80 443 22 ]; # Allow HTTP, HTTPS, SSH

  # --- User Setup ---
  users.users."${gitUserName}" = {
    isSystemUser = false;
    createHome = true;
    home = "/home/${gitUserName}";
    group = gitUserGroup;
    shell = pkgs.git.shell; # Use git-shell for restricted access
  };
  users.groups."${gitUserGroup}" = {};

  # --- SSH Server Setup ---
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      # IMPORTANT: Add your public SSH key manually (simplest approach)
      # After first boot/rebuild, run as root:
      # mkdir -p /home/gitjekyll/.ssh
      # touch /home/gitjekyll/.ssh/authorized_keys
      # nano /home/gitjekyll/.ssh/authorized_keys # Add your key here
      # chown -R gitjekyll:gitjekyll /home/gitjekyll/.ssh
      # chmod 700 /home/gitjekyll/.ssh
      # chmod 600 /home/gitjekyll/.ssh/authorized_keys
      # --- OR use nixops/declarative secrets management for better key handling ---
    };
  };

  # --- Web Server (Nginx) ---
  services.nginx = {
    enable = true;
    # Add nginx user to the git group to read webRoot files
    user = config.users.users.nginx.name; # Default is "nginx"
  };
  users.users.${config.services.nginx.user}.extraGroups = [ gitUserGroup ];

  services.nginx.virtualHosts."${domainName}" = {
    # forceSSL = true; # Enable these after getting a certificate
    # enableACME = true; # For Let's Encrypt (requires A/AAAA records)
    root = webRoot;
    locations."/".tryFiles = "$uri $uri/ /index.html";
  };

  # --- Directory and Permissions Setup (using systemd-tmpfiles) ---
  systemd.tmpfiles.rules = [
    # Create web root, owned by git user/group, readable by nginx
    "d ${webRoot} 0775 ${gitUserName} ${gitUserGroup} - -"
    # Create temp checkout dir if using home dir
    "d ${tempCheckoutPath} 0700 ${gitUserName} ${gitUserGroup} - -"
  ];

  # --- Git Hook Script ---
  # Place the script content somewhere system-wide
  environment.etc."nixos-git-hooks/post-receive-jekyll" = {
    mode = "0755"; # Executable
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail # Exit on error, unset var, pipe failure

      GIT_REPO="${gitRepoPath}"
      TMP_CHECKOUT="${tempCheckoutPath}"
      PUBLIC_WWW="${webRoot}"
      BRANCH="${repoBranch}"

      # Ensure temp dir exists and is clean
      rm -rf "''${TMP_CHECKOUT}"
      mkdir -p "''${TMP_CHECKOUT}"

      echo "----> Receiving push for branch: ''${BRANCH}"

      # Checkout the pushed branch to a temporary directory
      echo "----> Checking out ''${BRANCH}..."
      ${pkgs.git}/bin/git --work-tree="''${TMP_CHECKOUT}" --git-dir="''${GIT_REPO}" checkout -f "''${BRANCH}"

      # Build the Jekyll site using Nix Shell for environment
      # Assumes Gemfile exists in repo root for 'bundle install'
      echo "----> Building Jekyll site (using Nix)..."
      cd "''${TMP_CHECKOUT}"

      # Use nix shell to provide ruby, bundler, git (needed by some gems?)
      # 'bundle install' reads Gemfile from the checked-out repo
      # 'bundle exec jekyll build' runs the build
      # Set BUNDLE_PATH to keep gems local to the checkout (optional but cleaner)
      ${pkgs.nix}/bin/nix shell 'nixpkgs#ruby' 'nixpkgs#bundler' 'nixpkgs#git' --command bash -c '\
        echo "------> Running bundle install..." && \
        bundle config set --local path vendor/bundle && \
        bundle install --jobs 4 --retry 3 && \
        echo "------> Running bundle exec jekyll build..." && \
        bundle exec jekyll build --destination "''${PUBLIC_WWW}" --trace \
      '

      # Optional: Set correct permissions again (tmpfiles rule is good, but belt-and-suspenders)
      # ${pkgs.coreutils}/bin/chmod -R g+rX,o+rX "''${PUBLIC_WWW}"

      # Clean up temporary checkout
      echo "----> Cleaning up..."
      rm -rf "''${TMP_CHECKOUT}"

      echo "----> Deployment complete for ''${domainName}"
      exit 0
    '';
  };

  # Packages needed by the hook script *if not* using `nix shell` for everything
  # environment.systemPackages = with pkgs; [ git bash coreutils ];
  # If using nix shell, only nix itself needs to be available globally.
}
```

---

**3. Manual Setup Steps (After `nixos-rebuild switch`)**

These steps are needed once after applying the configuration:

1.  **SSH Key:** As mentioned in the `system.nix` comments, securely add your *local machine's* public SSH key to the `/home/gitjekyll/.ssh/authorized_keys` file on the server. Ensure the file and directory have the correct ownership (`gitjekyll:gitjekyll`) and permissions (`700` for `.ssh`, `600` for `authorized_keys`).
2.  **Create Bare Git Repo:** SSH into the server *as root* or use `sudo`:
    ```bash
    sudo -u gitjekyll -H bash -c 'mkdir -p /home/gitjekyll/site.git && cd /home/gitjekyll/site.git && git init --bare'
    ```
3.  **Create Hooks Directory:**
    ```bash
    sudo -u gitjekyll -H bash -c 'mkdir -p /home/gitjekyll/site.git/hooks'
    ```
4.  **Link Hook Script:** Create the `post-receive` hook by linking the file managed by Nix:
    ```bash
    ln -s /etc/nixos-git-hooks/post-receive-jekyll /home/gitjekyll/site.git/hooks/post-receive
    # Ensure correct ownership if root created the link
    chown -h gitjekyll:gitjekyll /home/gitjekyll/site.git/hooks/post-receive
    ```
    *(Note: Ensure the script placed by Nix in `/etc` is executable; the `mode = "0755"` should handle this).*
5.  **Web Root Permissions (Optional Check):** The `systemd.tmpfiles.rules` should create `/var/www/your-jekyll-site.example.com` with correct ownership/permissions. Verify this:
    ```bash
    ls -ld /var/www/your-jekyll-site.example.com
    # Should show ownership gitjekyll:gitjekyll and drwxrwxr-x permissions
    ```
6.  **Configure Local Git Remote:** On your local machine where your Jekyll site source code resides:
    ```bash
    cd /path/to/your/jekyll/site
    # Add the server as a remote (replace placeholders)
    git remote add deploy gitjekyll@YOUR_SERVER_IP_OR_HOSTNAME:/home/gitjekyll/site.git
    ```
7.  **Initial Push:** Push your desired branch (`main` in this example) to deploy for the first time:
    ```bash
    git push deploy main
    ```

---

**How it Works & Simplifications:**

* **Push Trigger:** When you `git push deploy main`, the SSH server authenticates you using your key, allows the push to the bare repo owned by `gitjekyll`, and runs commands using `git-shell`.
* **Hook Execution:** After the push completes successfully, Git automatically executes the `hooks/post-receive` script *as the `gitjekyll` user*.
* **Nix Shell:** The hook script uses `nix shell` to create an ephemeral environment with Ruby, Bundler, and Git. This ensures the build uses consistent dependencies defined by your `flake.lock` file (indirectly via `nixpkgs` input) without polluting the global system environment.
* **Build & Deploy:** `bundle install` fetches gems specified in your project's `Gemfile` (make sure you have one!), and `bundle exec jekyll build` creates the static site directly into the Nginx web root (`--destination`).
* **Serving:** Nginx serves the static files from the `webRoot`.

**Further Considerations:**

* **Jekyll Environment:** This setup assumes your Jekyll site's `Gemfile` includes `jekyll` or potentially the `github-pages` gem if you want to closely mimic that environment. The `nix shell` command only provides Ruby and Bundler; *your* `Gemfile` defines the specific Jekyll version and plugins.
* **Security:** Using `git-shell`, passwordless SSH via keys, and a dedicated user is essential. Review firewall rules. For production, manage SSH keys securely (e.g., using NixOps secrets, agenix, or similar).
* **Branch:** The deploy branch (`main`) is hardcoded in the script; make it configurable if needed.
* **Error Handling:** The `set -e` helps, but more robust error reporting could be added to the hook script.
* **HTTPS:** Added commented-out lines for enabling Let's Encrypt via Nginx's ACME support. You'll need DNS correctly pointing your domain to the server's IP.
* **Alternatives:** Caddy is another excellent, simple web server available in Nixpkgs, known for its automatic HTTPS. Systemd path units could trigger builds instead of Git hooks, but hooks are arguably simpler for this specific use case.

Don't use XML-wrapping in the reply. Just reply as normal markdown please.

---

## Gemini's Integration Plan

**Gemini**: Okay, I have reviewed the article (`prompt.md`), which outlines the
*goal of migrating your Jekyll blog from GitHub Pages to a self-hosted NixOS
*server and proposes a detailed implementation plan using a Git push-based
*deployment workflow.

Here's a breakdown of the implementation based on the plan presented in the article:

### Introduction

The core requirement is to set up a NixOS server that mimics the `git push` deployment mechanism of GitHub Pages for your Jekyll site. This involves configuring the server to act as a Git host, receive pushes via SSH, trigger a build using a `post-receive` hook, and serve the resulting static files via Nginx. The article already provides a robust NixOS configuration using Flakes (`flake.nix` and `system.nix`) as the foundation for this implementation. We will use this proposed configuration as the basis for the implementation steps.

### Required Changes

1.  **What specific code changes are needed?**
    * **NixOS Configuration:** The primary "code" changes involve creating and refining the `flake.nix` and `system.nix` files for the target NixOS server, as detailed in the article. These files declaratively define the entire server setup.
        * `flake.nix`: Defines the system's inputs (like `nixpkgs`) and outputs (the NixOS configuration).
        * `system.nix`: Configures users (`gitjekyll`), groups, SSH server (key-based auth, `git-shell`), Nginx web server (virtual host, web root), directory structures (`/var/www/...`, `/home/gitjekyll`), permissions (`systemd.tmpfiles`), and crucially, the `post-receive` hook script itself.
    * **Git Hook Script:** The `post-receive` script, defined within `system.nix` (under `environment.etc."nixos-git-hooks/post-receive-jekyll"`), contains the logic to:
        * Check out the pushed branch (`main` by default).
        * Use `nix shell` to create an ephemeral build environment with Ruby, Bundler, and Git.
        * Run `bundle install` (using the `Gemfile` from your repository).
        * Run `bundle exec jekyll build --destination <webRoot>`.
        * Clean up temporary files.
    * **Local Git Configuration:** On your development machine, you'll need to add a new Git remote pointing to the NixOS server.

2.  **Which existing components need to be modified or extended?**
    * **NixOS Server:** This is essentially a *new* setup, configured from scratch using the provided Nix files.
    * **Local Development Environment:** Your existing Jekyll source code (`_posts`, `_layouts`, `_config.yml`, `Gemfile`, etc.) remains largely unchanged in terms of content or structure. The main modification is adding the new Git remote (`git remote add deploy ...`). Your local `flake.nix` (if used for development environment) doesn't necessarily need changes unless you want to align `nixpkgs` versions.

3.  **What new components or patterns need to be introduced?**
    * **Declarative NixOS Configuration:** The use of `flake.nix` and `system.nix` to manage the server's state is the core new pattern.
    * **Git Hook Deployment:** Implementing a `post-receive` hook script on the server to automate builds upon `git push`.
    * **Service Management:** Using NixOS modules to configure system services like `sshd` and `nginx`.
    * **Dedicated User/Permissions:** Creating a non-root user (`gitjekyll`) specifically for receiving Git pushes and running builds, restricting its shell access (`git-shell`), and managing file permissions for the Git repo, checkout area, and web root.
    * **Ephemeral Build Environment:** Leveraging `nix shell` within the hook script to ensure reproducible builds without polluting the global server environment.

### Integration Strategy

1.  **How should these changes be integrated with existing functionality?**
    * The local Jekyll development workflow remains the same (editing files, previewing locally).
    * The deployment step changes from `git push origin main` (or similar for GitHub Pages) to `git push deploy main` (using the new remote name `deploy`).
    * The NixOS server integrates the Git push event (via SSH) with the automated Jekyll build process (via the hook script) and web serving (via Nginx configuration pointing to the build output directory).

2.  **What existing patterns or conventions should be followed?**
    * **Nix Flakes:** Continue using the Flake-based approach for NixOS configuration as shown in the article, promoting reproducibility.
    * **SSH Security:** Use key-based authentication only, disable password authentication, disable root login, and use the restricted `git-shell` for the deployment user.
    * **Git Hooks:** Follow standard Git hook practices by placing the executable script in `hooks/post-receive` within the *bare* repository on the server.
    * **Declarative Configuration:** Define as much of the setup as possible within `system.nix` (users, packages, services, file content like the hook script) rather than relying on manual imperative commands post-deployment. The article's plan does require some initial manual steps (key setup, repo init, hook linking), which is common, but aims for declarative management where practical.
    * **Jekyll/Bundler:** Ensure your project's `Gemfile` correctly specifies Jekyll and all necessary plugins. The `nix shell` command provides Ruby/Bundler, but your `Gemfile` dictates the actual build dependencies.

3.  **How can we ensure backward compatibility?**
    * This migration primarily changes the *hosting platform and deployment method*. The Jekyll site's source code, content, themes, and local build process are not directly affected.
    * You can maintain the old `origin` remote pointing to GitHub alongside the new `deploy` remote initially, allowing you to push to either target if needed during transition, although deploying to both simultaneously doesn't make sense long-term.
    * The primary change for the developer is the `git push` command used for deployment.

### Implementation Plan

Based on the detailed steps already provided in the article:

1.  **Recommended Order:**
    1.  **Prepare NixOS Server:** Install a base NixOS system on the target hardware. Ensure network connectivity.
    2.  **Create Nix Configuration:** Place the `flake.nix` and `system.nix` files (adapted from the article's examples with your specific `domainName`, `timeZone`, etc.) onto the server (e.g., in `/etc/nixos/`).
    3.  **Initial Build & Switch:** Run `sudo nixos-rebuild switch --flake /etc/nixos#my-jekyll-server` (adjust path and hostname). This applies the configuration, installing packages, setting up users, services, etc. Debug any errors during this phase.
    4.  **Server-Side Manual Setup (as root/sudo):**
        * Add your local machine's public SSH key to `/home/gitjekyll/.ssh/authorized_keys` on the server, ensuring correct ownership (`gitjekyll:gitjekyll`) and permissions (`700` for `.ssh`, `600` for `authorized_keys`).
        * Initialize the bare Git repository: `sudo -u gitjekyll -H bash -c 'git init --bare /home/gitjekyll/site.git'`
        * Create the hooks directory: `sudo -u gitjekyll -H bash -c 'mkdir -p /home/gitjekyll/site.git/hooks'`
        * Link the post-receive hook: `ln -s /etc/nixos-git-hooks/post-receive-jekyll /home/gitjekyll/site.git/hooks/post-receive` and `chown -h gitjekyll:gitjekyll /home/gitjekyll/site.git/hooks/post-receive`.
        * Verify web root directory (`/var/www/your-domain`) exists with correct permissions (should be handled by `systemd.tmpfiles`).
    5.  **Configure Local Git Remote:** On your development machine, navigate to your Jekyll project directory: `git remote add deploy gitjekyll@YOUR_SERVER_IP_OR_HOSTNAME:/home/gitjekyll/site.git`.
    6.  **Initial Deployment:** Push your site's code: `git push deploy main`. Monitor the output for success/failure messages from the hook script. Check the server's web root (`/var/www/...`) to see if files were generated.
    7.  **Test Access:** Try accessing the site via the server's IP address in a web browser.
    8.  **Configure DNS:** Point your domain name's A/AAAA records to the server's public IP address.
    9.  **Configure HTTPS (Optional but Recommended):** Uncomment the `forceSSL` and `enableACME` lines in the `system.nix` Nginx configuration, run `nixos-rebuild switch` again, and ensure Let's Encrypt can successfully issue a certificate.

2.  **Key Milestones:**
    * NixOS server boots with the custom configuration applied successfully.
    * SSH access as the `gitjekyll` user using key authentication is working.
    * Bare Git repository is created and accessible.
    * `post-receive` hook is correctly linked and executable.
    * First `git push deploy main` completes without error.
    * Jekyll build runs successfully on the server via the hook.
    * Static site files appear correctly in the Nginx web root (`/var/www/...`).
    * Site is accessible via HTTP using the server's IP address.
    * Site is accessible via HTTPS using the domain name (after DNS/ACME setup).

3.  **Potential Challenges & Risks:**
    * **NixOS Configuration Errors:** Syntax errors or logic issues in `flake.nix`/`system.nix` preventing `nixos-rebuild switch` from completing.
    * **SSH Permissions:** Incorrect ownership or permission modes on `/home/gitjekyll/.ssh` or `authorized_keys` preventing key authentication.
    * **Firewall Issues:** NixOS firewall (`networking.firewall.allowedTCPPorts`) or external firewalls (like pfSense mentioned in the article, or ISP blocks) preventing access to SSH (port 22), HTTP (80), or HTTPS (443). Inter-LAN communication for the Git push might require specific firewall rules.
    * **Git Hook Script Errors:** Bugs within the `post-receive` script (path issues, command failures, permission denied during checkout or build). Debugging requires checking system logs or adding logging within the script.
    * **Jekyll Build Failures:** Missing gems in the `Gemfile`, incompatible Ruby/Jekyll versions (though `nix shell` helps stabilize this), or plugin issues during `bundle install` or `bundle exec jekyll build`. Check the push output carefully.
    * **File Permissions:** The hook script (running as `gitjekyll`) needs write access to the web root (`/var/www/...`) to place the built files. The `systemd.tmpfiles` rule and adding the `nginx` user to the `gitjekyll` group aim to handle this, but verification is needed.
    * **Dynamic DNS:** Ensuring the DDNS client is configured correctly and updates reliably if your home IP address changes.
    * **Security:** Properly securing a public-facing home server requires ongoing diligence beyond the initial setup (updates, monitoring, robust firewall rules).

This plan leverages the excellent foundation laid out in your article to create a functional, self-hosted, Git-driven deployment system for your Jekyll blog using NixOS.

---

## Putting Aside Until Weekend

Okay, that plate has been spun. I have an implementation plan waiting for me for
my weekend project. It is still only Tuesday, so there will be a few days to see
if my traffic starts to recover. Also, I will start to give thought to the
tagging and categorization project that will address the homepage just getting
so long with links. Personal site projects where I carry out my SEO experiments
are important, but lower priority than things that help the clients on a
day-to-day basis, and pushing the Pipulate project forward — two paths that are
now converging! So, I bank this weekend-planning win and forge on to the next
thing.

---

## AI Analysis

* **Title/Headline Ideas:**
    * Migrating Jekyll from GitHub Pages to Self-Hosted NixOS via Git Push
    * NixOS, Jekyll, and Git Hooks: Building a Home-Hosted Blog Deployment
    * Experimenting with Self-Hosting: A NixOS Plan for Jekyll Deployment
    * From SEO Setbacks to Self-Hosting: Configuring NixOS for Jekyll
    * Super-Prompting an AI for NixOS Jekyll Server Setup

* **Strengths:**
    * Provides a highly detailed, practical NixOS configuration (`flake.nix`, `system.nix`, hook script) for a common goal (self-hosting a static site).
    * Documents the author's reasoning, troubleshooting steps (like reverting template changes), and experimental mindset, offering valuable context beyond just code.
    * Integrates modern development practices like Infrastructure as Code (IaC) with NixOS and leveraging AI for planning.
    * The specific Git push deployment mechanism described is a useful pattern.

* **Weaknesses:**
    * Blends personal journal reflections and high-level strategy with very specific, low-level technical implementation details, which can be disjointed.
    * Assumes a high degree of prerequisite knowledge (NixOS, Flakes, Jekyll, Git internals, networking concepts like DMZ, specific AI models, etc.), making it inaccessible to beginners.
    * The structure could be clearer; the Nix configuration section appears abruptly after the more narrative journal entry.
    * The "super-prompt" concept relies heavily on context likely present in other posts by the author.

* **AI Opinion:**
    This article offers significant value as a technical reference, particularly the detailed NixOS configuration for setting up a Git-based Jekyll deployment. The transparency about the author's experiments, setbacks (SEO traffic tanking), and thought process adds a layer of real-world context often missing from purely technical guides. However, its hybrid nature—part journal, part deep technical guide—and heavy reliance on specialized jargon make it challenging for readers unfamiliar with NixOS, advanced Git workflows, or the author's ongoing projects. Its primary utility lies with users attempting a similar NixOS-based self-hosting setup, for whom the provided configurations and rationale could be extremely helpful.
