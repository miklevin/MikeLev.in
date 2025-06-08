---
title: Custom Branding & White Labeling SEO Software
permalink: /futureproof/custom-branding-white-labeling-seo-software/
description: I'm detailing how I enabled white-labeling for Pipulate directly within the installation process. The aim was to modify the `install.sh` script so a user could pass a custom name as a command-line argument (e.g., `Botifython`), which would then dictate both the installation directory name and the application's displayed branding by correctly generating an `app_name.txt` file *before* the Nix environment kicks in, solving an initial issue where the branding wasn't applying correctly due to script execution order.
meta_description: Guide to enabling white-labeling for Pipulate software via command-line arguments during installation using a modified bash script, Nix, and an app_name.txt file.
meta_keywords: pipulate, white label, white-labeling, install script, installation, custom branding, bash, sh -s, command line argument, curl, nix, flake.nix, app_name.txt, figlet, software customization, foss branding, directory naming, exec command, mit license, botifython, technical breakdown, install parameter, nix develop, shell hook
layout: post
sort_order: 3
---

## Understanding Software White Labeling: Getting Started

This article delves into a specific technical process called "white labeling" applied to a software tool named Pipulate. White labeling is the practice of taking a product or service created by one company and rebranding it to appear as if it's your own. Think of generic store-brand products at a supermarket – the store often doesn't make them but puts its own label on them. In the software world, this means customizing the appearance (like logos, names, colors) of a tool developed by someone else so you can offer it under your brand, often leveraging existing powerful software without building it from scratch.

The text you're about to read documents the author's process of modifying the installation procedure for Pipulate, which is Free and Open Source Software (FOSS). The goal is to allow anyone installing Pipulate to easily give it a custom name and install it into a custom directory right from the initial setup command. This involves adjusting command-line scripts (specifically, a `bash` script used for installation) and ensuring a configuration file (`app_name.txt`) is created correctly to inform the system (managed by a tool called Nix) about the desired custom branding.

---

## Pipulate's White Labeling Design

Pipulate is designed for white labeling. White labeling for those not familiar
with the term is taking a product or service made by one company and putting
your own brand name and look on it, so you can sell or present it as if it were
your own. Think of store-brand groceries – the supermarket chain often doesn't
make them, but they put their label on them.

## Software White Labeling in Practice

In the software world, this means taking a piece of software (like Pipulate!)
developed by someone else and customizing its appearance – swapping out logos,
changing color schemes, maybe even tweaking the name displayed in the interface
– to match your brand or your client's brand. The underlying engine and
functionality are usually the same, but the "paint job" is different. For right
now, I'm just swapping out some headlines in Pipulate.

## FOSS and White Labeling: A Perfect Match

For software, especially Free and Open Source Software (FOSS), this is often
quite feasible because the licenses typically allow for modification and
redistribution. You can take the core FOSS tool, give it a custom look and feel
(adjusting how it's presented), and offer it as a seamless part of your own
services or toolkit. This lets you leverage powerful existing software without
having to build it from scratch, while still maintaining your brand identity for
your clients. You can do this with Pipulate as I'm releasing it under one of the
most permissive of all licences (MIT), but of course check the specific software
license of any other software you're doing this with.

---

## Prompting White Labeling Into Existence

> I really already have most of the support for this baked in, so this is a
> matter of tweaking it to the surface and connecting the dots.

**Me**: Okay, this is all excellent! Now, I need Pipulate to be able to be
installed in a "white label" fashion. That is, it can run from any directory and
it can have its internal "branding" changed from Piulate to anything based on
the `app_name.txt` file that gets put in the `~/pipulate` (or otherwise)
directory during the install process. But we need to simplify that. Currently
the install process is:

1.  **Install Nix:**
    * Nix manages the underlying software dependencies and ensures a consistent environment.
    * Open your Terminal.
    * Copy and paste this command, then press Enter:
        ```shell
        curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
        ```
    * Follow any instructions on the screen (you might need to type "Yes").
    * **Important:** After the installation finishes, **close your Terminal window completely and open a new one.** This ensures Nix is correctly added to your system's PATH.

2.  **Install Pipulate:**
    * This command downloads Pipulate into `~/pipulate` (by default), sets up automatic updates via Git, and configures the Nix environment.
    * In the **new** Terminal window you just opened, copy and paste this command, then press Enter:
        ```shell
        curl -L https://pipulate.com/install.sh | sh
        ```
    * This might take some time the first time you run it as Nix downloads dependencies. It should automatically start the necessary services (JupyterLab and the Pipulate server) and open browser tabs when ready.

**That's it! Pipulate is installed.** You now have a self-contained, reproducible environment managed by Nix.

...but I need the second command to be more like:

```shell
curl -L https://pipulate.com/install.sh Botifython | sh
```

...taking in a command-line argument which achieves the white-labeling. This
parameter should control 2 things:

1. The directory name that the repo gets git cloned into
2. The contents of the `app_name.txt`

If I remember correctly how I designed this, most of this is already
implemented, and this whole request is really just you connecting the dots.

**Claude**: I'll help you adapt the installation process to support white labeling through a command-line argument. Looking at the install.sh script you shared, I can see this is a relatively straightforward modification.

The current script already has logic to set the target directory and detect the app name, but needs to be modified to accept a parameter. Here's what needs to be changed:

1. The script should accept a command-line argument to specify the custom name
2. This custom name should be used for both the target directory and app_name.txt
3. The curl command needs to pass this argument through to the script

Here's how the modified install process would work:

```shell
curl -L https://pipulate.com/install.sh | sh -s Botifython
```

Notice I changed the syntax slightly to use `-s` with `sh` which properly passes arguments to the script being executed. This is the standard way to pass arguments through curl|sh patterns.

The install.sh script would need these key modifications:

```bash
# At the beginning, add argument handling
CUSTOM_NAME="${1:-pipulate}"  # Default to "pipulate" if no arg provided

# Update the target directory to use the custom name
TARGET_DIR="${HOME}/${CUSTOM_NAME}"

# And later in the run-script section where app_name.txt is created:
if [ ! -f app_name.txt ]; then
  echo "$CUSTOM_NAME" > app_name.txt
fi
```

This change allows:
1. Calling `curl -L https://pipulate.com/install.sh | sh -s Botifython` would install to `~/Botifython` with "Botifython" in app_name.txt
2. Calling `curl -L https://pipulate.com/install.sh | sh` (no argument) would fall back to the default name "pipulate"

The README.md should be updated to reflect this new installation option:

```markdown
2. **Install Pipulate (or a custom-named version):**
   * Install with the default name "pipulate":
     ```shell
     curl -L https://pipulate.com/install.sh | sh
     ```
   * Install with a custom name (e.g., "Botifython"):
     ```shell
     curl -L https://pipulate.com/install.sh | sh -s Botifython
     ```
   * This will download the code into `~/[custom-name]` and set the application branding accordingly
```

The flake.nix file already has the logic to read from app_name.txt for branding, so once this file is correctly created, the welcome messages and UI should reflect the custom name.

---

## Second Try

**Me**: This  is excellent, but it doesn't apply to the first appearance of the Figlet like it should:

[A bunch of command-line output pasted]

In fact, it didn't do any of the rebranding.

**Claude**: 

I see the issue now. While the installer script takes in the custom name parameter and correctly creates the directory with the custom name (`/home/mike/Botifython`), it doesn't properly create the `app_name.txt` file at the right time or location.

The problem is in the `install.sh` script - the custom name handling needs to be applied in two places:

1. At the beginning for directory naming (which is working correctly)
2. Creating the `app_name.txt` file before starting the nix environment

The current issue is that the `app_name.txt` creation code appears at the end of the script, after the `exec` command. The `exec` command replaces the current shell with a new process, so any code after it never gets executed.

The fix should be:

1. Move the `app_name.txt` creation code before the `exec` command
2. Ensure the file is created in the target directory

Here's how the install.sh script should be modified:

```bash
# Before the exec command, add:
echo "Setting up app identity as '$CUSTOM_NAME'..."
echo "$CUSTOM_NAME" > "${TARGET_DIR}/app_name.txt"
chmod 644 "${TARGET_DIR}/app_name.txt"
echo "✅ Application identity set."
echo

# Then execute the nix develop command
exec bash -c "cd ${TARGET_DIR} && nix develop --command python server.py"

# Remove this part at the end of the file since it will never execute:
# if [ ! -f app_name.txt ]; then
#   echo "$CUSTOM_NAME" > app_name.txt
# fi
```

The issue is that you're trying to add the `app_name.txt` file after using `exec`, which replaces the current process - so that code never runs. Moving the creation of the file before the `exec` command will ensure it happens.

Also, the `flake.nix` file has logic to read from `app_name.txt`, but it needs to find this file at the root of the repository directory. The script should create this file with the proper path (`${TARGET_DIR}/app_name.txt`).

Once these changes are made, the custom name should be correctly applied to both:
1. The installation directory (`~/Botifython`)
2. The app branding via `app_name.txt` (showing "Botifython" in the figlet display)

---

## Wrapping Up SEO White Labeling

> Bingo! Now we've got easy peasy SEO software relabeling achieved.

**Me**: Excellent! That works now. Parse through this entire thing and do a recap how this white labeling is accomplished. Don't hold back on any of the details.

Claude: # White Labeling in Pipulate: A Complete Technical Breakdown

Here's a detailed breakdown of how white labeling works in Pipulate, from the installation process to the runtime experience:

## 1. Installation Command Structure

The installation uses a command-line argument pattern through curl-piped-to-shell:

```shell
curl -L https://pipulate.com/install.sh | sh -s CustomName
```

Key elements:
- `sh -s` passes arguments to the shell script being executed
- `CustomName` is the argument that controls both the installation directory and application branding

## 2. Script Initialization and Parameter Handling

At the beginning of the `install.sh` script, the custom name parameter is captured:

```bash
# Capture the first argument or default to "pipulate"
CUSTOM_NAME="${1:-pipulate}"
```

This uses Bash parameter expansion to:
- Take the first command-line argument (`$1`)
- Default to "pipulate" if no argument is provided (using the `:-` operator)

## 3. Directory Creation Based on Custom Name

The script uses this custom name to determine the installation directory:

```bash
TARGET_DIR="${HOME}/${CUSTOM_NAME}"
```

This creates a path like `/home/username/CustomName` that will house the application.

## 4. Source Code Download and Extraction

The application source is still downloaded from the original repository, keeping the core functionality identical:

```bash
ZIP_URL="https://github.com/${REPO_USER}/${REPO_NAME}/archive/refs/heads/main.zip"
```

This means regardless of branding, all instances use the same codebase from the main Pipulate repository.

## 5. Application Identity Configuration

Before starting the Nix environment, the script creates an `app_name.txt` file in the root of the installation directory:

```bash
echo "Setting up app identity as '$CUSTOM_NAME'..."
echo "$CUSTOM_NAME" > "${TARGET_DIR}/app_name.txt"
chmod 644 "${TARGET_DIR}/app_name.txt"
```

This file is the key to the white labeling system. It contains just the custom name and is readable by the application.

## 6. Nix Environment Integration

The Nix flake system (`flake.nix`) contains specific code to read this identity file:

```nix
# In the run-script section of flake.nix
if [ ! -f app_name.txt ]; then
  APP_NAME=$(basename "$PWD")
  if [[ "$APP_NAME" == *"botify"* ]]; then
    APP_NAME="$APP_NAME"
  else
    APP_NAME="Pipulate"
  fi
  echo "$APP_NAME" > app_name.txt
fi
APP_NAME=$(cat app_name.txt)
PROPER_APP_NAME=$(echo "$APP_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
figlet "$PROPER_APP_NAME"
```

This code does several important things:
- Checks if `app_name.txt` exists; if not, creates one with a default name
- Reads the application name from the file
- Formats it for display (capitalizes first letter)
- Uses `figlet` to create the ASCII art banner with the custom name

## 7. Visual Branding Execution

When `nix develop` runs, it:
1. Executes the shell hook from `flake.nix`
2. Runs the welcome script that reads `app_name.txt`
3. Displays the custom name in the large ASCII art banner
4. Uses the custom name in welcome messages

Example output with "Botifython":
```
 ____        _   _  __       _   _                 
| __ )  ___ | |_(_)/ _|_   _| |_| |__   ___  _ __  
|  _ \ / _ \| __| | |_| | | | __| '_ \ / _ \| '_ \ 
| |_) | (_) | |_| |  _| |_| | |_| | | | (_) | | | |
|____/ \___/ \__|_|_|  \__, |\__|_| |_|\___/|_| |_|
                       |___/                       
Welcome to the Botifython development environment on x86_64-linux!
```

## 8. Persistent White Labeling

This white labeling persists across restarts because:
- The installation directory retains the custom name
- The `app_name.txt` file is permanently stored in the installation directory
- Every time the environment is loaded with `nix develop`, it reads this file

## 9. Deep Integration in Runtime Experience

Beyond the welcome message, the white labeling affects:
- Browser tab titles
- Any user-facing messages that include the application name
- Internal references in generated scripts (like `run-server`, `run-jupyter`)
- Command references in help text

## 10. Technical Implementation Notes

Several important technical details make this work:
- The timing of file creation is critical - it must happen before the Nix environment is started
- The `exec` command in Bash replaces the current process, so any code after it never executes
- The white labeling is non-invasive - it doesn't modify the core codebase
- The approach uses file system paths and a simple text file rather than complex configuration

## 11. Security and Permissions

The implementation includes appropriate permission handling:
- The `app_name.txt` file has read permissions (644) to ensure it's accessible
- Other security elements (like SSH keys) maintain strict permissions (600)

## 12. User Experience Flow

From the user's perspective, the process is seamless:
1. They run a single install command with their desired name
2. The installation proceeds with that branding
3. When they open the application, all references show their custom name
4. When sharing with others, their customized name appears throughout

This white labeling approach demonstrates elegant simplicity - using a single text file to drive branding across the entire application, without modifying the core codebase or requiring complex configuration.

---

## Looking At Today's Work

**Me**: Hey Claude, contemplate today's work.

**Claude**: Looking at today's work across these three articles, I can see the evolution of a sophisticated approach to AI-assisted development for the Pipulate project.

The day started with documentation consolidation in "Agentic Coding & Wrangling AI Assistants," where you tackled the challenge of organizing knowledge for both humans and AI assistants. The key insight was identifying different documentation needs for various audiences: end users, developers, AI assistants, and local LLMs. You successfully converted scattered `.mdc` files into a comprehensive `.cursorrules` file that captures critical patterns like the HTMX chain reaction and workflow identity concepts.

This work led directly to the realization that `.cursorrules` was deprecated, which prompted "Cursor Rules Project Workspace Git Solution." Here, you solved the challenge of version-controlling Cursor rules with an elegant "reverse symlink" approach inspired by NixOS configuration management. Rather than putting symlinks in the repo pointing out, you put the real files in the repo and created symlinks pointing in, ensuring both version control and proper functionality.

Finally, in "Custom Branding & White Labeling SEO Software," you implemented a practical feature for end users - the ability to white-label Pipulate during installation. The solution was elegant: passing a custom name parameter that affects both directory naming and application branding through a simple text file.

What connects these efforts is a consistent philosophy:
1. Local-first, transparent operation
2. Minimalist design that favors simplicity over complexity
3. Attention to both human and AI-readable documentation
4. Leveraging Unix principles like symlinks and text files for configuration

You've created a system where documentation serves multiple purposes - helping humans understand the code while simultaneously training AI assistants to work more effectively with the codebase. This meta-approach to documentation shows a sophisticated understanding of the emerging human-AI collaborative development model.

---

## AI Analysis

* **Title/Headline Ideas & Filenames:**
    * Title: Implementing Command-Line White Labeling for Pipulate via Install Script
        Filename: `implementing-cli-white-labeling-pipulate-install-script.md`
    * Title: Customizing Pipulate Branding: A Guide to Installation Script White Labeling
        Filename: `customizing-pipulate-branding-installation-white-labeling-guide.md`
    * Title: Debugging and Fixing White Label Installation for Nix-Managed Software (Pipulate Example)
        Filename: `debugging-fixing-white-label-install-nix-pipulate.md`
    * Title: How to Enable Custom Branding in FOSS Installation: The Pipulate `app_name.txt` Method
        Filename: `enable-custom-branding-foss-install-pipulate-app-name-txt.md`
    * Title: White Labeling Pipulate: Using `sh -s` and `exec` for Script-Based Customization
        Filename: `white-labeling-pipulate-sh-s-exec-script-customization.md`

* **Strengths:**
    * Provides a detailed, step-by-step account of a specific technical implementation.
    * Clearly shows the iterative problem-solving process (initial attempt, problem identification, solution).
    * Includes concrete code examples (shell commands, script snippets, Nix configuration parts).
    * Explains the underlying mechanism (`app_name.txt`, script parameter handling, Nix interaction) thoroughly in the recap.
    * Grounds the technical task in a practical concept (white labeling) with relatable analogies.

* **Weaknesses:**
    * Assumes significant prior knowledge of shell scripting (Bash), Nix environment management, and potentially Pipulate itself.
    * The conversational, journal-like format (with "Me:" and "Claude:") requires careful reading to piece together the final solution.
    * Focuses narrowly on the installation script modification, lacking broader context on Pipulate's overall architecture or other white-labeling aspects (if any).
    * The debugging process, while illustrative, adds length that might obscure the final, working solution for someone just looking for the "how-to."

* **AI Opinion:**

This article serves as a valuable technical log documenting the successful implementation of a specific white-labeling feature for the Pipulate software. Its strength lies in the detailed breakdown of the problem, the debugging process, and the final working solution involving shell script modifications and interaction with the Nix environment. While its clarity is high for developers familiar with the involved technologies (Bash, Nix, command-line installations), it would be challenging for a non-technical audience or even developers unfamiliar with Nix. It's highly useful for someone needing to understand or replicate this exact installation customization for Pipulate or similar FOSS tools managed via scripts and Nix.
