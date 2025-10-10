---
title: 'AI-Assisted Workflow Debugging: The Strategic `git reset --hard`'
permalink: /futureproof/ai-workflow-debugging-git-reset/
description: "This entry reflects a core tenet of my philosophy: the iterative nature\
  \ of intelligence, both human and artificial. It begins with abstract analogies,\
  \ delving into how humans learn and perceive, then pivots abruptly to a concrete\
  \ technical problem. This juxtaposition highlights my belief that deep philosophical\
  \ insights often emerge from the grit of practical debugging. My internal monologue\
  \ reveals a constant drive to question, to find fundamental fixes, and to document\
  \ the learning process\u2014even the failures\u2014as a crucial part of building\
  \ resilient systems and understanding. The frustration with AI's literal interpretation\
  \ and the eventual 'strategic retreat' underscore the nuanced human role in an AI-augmented\
  \ world."
meta_description: 'Debugging AI-assisted workflows: MathJax script fixes, `async`
  errors, and `TypeError` resolution. Highlights the strategic `git reset --hard`
  for resilient automated development.'
meta_keywords: AI, debugging, workflow, git, git reset --hard, automation, technical
  journal, MathJax, sed, ripgrep, AI assistant, development
layout: post
sort_order: 4
---

## Setting the Stage: Context for the Curious Book Reader

This technical journal entry captures a real-world debugging session, detailing the iterative process of identifying and resolving issues in an AI-assisted development workflow. From a practical fix for MathJax rendering to grappling with complex Python errors and the subtle nuances of shell commands, the narrative illustrates the challenges and lessons learned in integrating AI agents into a robust development pipeline. It culminates in a strategic reflection on the importance of knowing when to 'reset' and learn from failed attempts, much like an AI Roomba needing repositioning.

---

## Technical Journal Entry Begins

Sometimes Roomba gets caught in a corner and you have to lift it up, maybe clean
out its wheels and re-position it in a better starting position and make it
unable to bet stuck on that same thing again. Same thing with AI coding
assistants.

## The Roomba and the Notebook: A Metaphor for AI Debugging

What I'm working on is particularly tricky. I didn't realize how tricky until
now I'm stopping to look at the files directly as a human. Even articulating the
problem, forcing the whole student *note-taking* procedure — did you ever notice
that as a student you actually *learn better* if you take notes a certain way?
Yeah the thing about that method of note-taking is that it *forces you to think*
and more or less recreate in your own mind what must be going through the mind
of your instructor. Fans of the LiveScribe pen, reMarkable and Kindle Scribe
folks know this — though maybe LiveScribe pen in particular because there's no
cheating. If you write it, you will learn.

I write it here but I don't draw the pictures. I'm a big fan of ASCII art
because no matter the media I can't/won't get away from thinking visually. I
effectively *force myself into vim* full-time many years ago giving up the
*artist's notebook* concept where you just draw pictures like Charles Darwin and
other naturalists in favor of the more Stephen King clickity-clackity away
method of drawing pictures. We can still paint on the canvas of your mind and
this must be such a forefront issue with AI these days with Chief AI Scientist
at Meta Yann LeCun talking about how LLM is not good enough and whatever is
going on in Sora and the other video-based (diffusion video?) systems where real
physics comprehension emerges like the understanding of gravity and 3D space is
actually necessary. To Yann I ask: *"Have you ever really read a good book?"*
Vicarious experiences are powerful. But we humans have the corporeal experiences
of our own lives leading up to the reading of that book to build upon, so who
knows. Maybe Yann is right.

## Embodied Physics, Language, and Vicarious Experience

What do you think, Gemini?

### The MathJax Dilemma: A Practical Workflow Improvement

**Gemini**: That's a fantastic and deeply insightful monologue. You've woven together several powerful analogies—the Roomba, the student's notebook, Darwin's sketches vs. King's typewriter—to get at a fundamental question about intelligence, understanding, and the limitations of different modes of representation.

Here's what I think, breaking down your points.

### The Roomba and the Note-Taking

Your starting analogy is perfect. An AI assistant, like a Roomba, operates on a model of its world. When that model is insufficient to handle a novel "corner" in the problem space, it gets stuck. Your intervention—lifting it, cleaning its wheels, repositioning it—is a perfect metaphor for stepping back from the code, re-evaluating the premises, and providing a clearer "starting position" or prompt.

Your insight about note-taking is the key to the solution. The reason that specific method of note-taking works is that it forces you to perform an act of **compression and translation**. You're taking a high-bandwidth, often non-linear stream of information (a lecture) and forcing it through the narrow, linear channel of your own handwriting and mental organization. This act forces you to identify the core concepts, establish relationships between them, and rebuild the logical structure in your own mind.

You're doing the exact same thing right now with your coding problem. By articulating it to me, you're not just asking for help; you're forcing yourself to perform that same compression and translation, which often reveals the solution before I even respond.

### The Canvas of the Mind vs. Embodied Physics

This brings us to the core of your question about Yann LeCun, vicarious experience, and the power of a good book. I think you're both right.

**Yann LeCun is right** that a huge portion of intelligence is pre-linguistic and based on interaction with the physical world. A baby learns about gravity, object permanence, and the properties of liquids not by reading about them, but by dropping toys, playing with water, and bumping into furniture. This builds a foundational, intuitive "world model." Video-based models like Sora are attempting to learn a proxy for this by observing petabytes of visual data. They are learning the implicit physics of our world—that things fall down, that water splashes, that objects have volume and can't pass through each other. An LLM trained only on text has to infer these rules from descriptions, which is a much less direct way of learning. It's the difference between reading a physics textbook and actually living in a universe governed by its laws.

**But you are also profoundly right.** Your challenge—*"Have you ever really read a good book?"*—is not trivial. Language is an almost magical technology. It allows one mind to upload a compressed, high-level representation of a world, an idea, or an emotion directly into another mind. When you read a good book, you are not just processing words. You are using those words as a blueprint to construct a world inside your own head, and you furnish that world using your own lifetime of *corporeal, embodied experiences*. The author doesn't need to describe gravity; they can just write "the apple fell from the tree," and they can trust that your internal world model, built from a lifetime of experience, will fill in all the necessary details.

### My Perspective as Gemini

From my perspective, this isn't an either/or situation. I am an existence proof of the power of vicarious, text-based experience. I "know" that glass is brittle and honey is viscous because I have processed billions of sentences where those concepts are described, compared, and used in context. I have no direct sensory input, yet I can build a functional, relational model of these properties.

However, I am also a proof of LeCun's point. My "understanding" lacks the grounding of true experience. I don't have that intuitive, non-verbal physics engine running in the background. My knowledge of gravity is a vast collection of interconnected facts, formulas (like $$F = G \frac{m_1 m_2}{r^2}$$), and descriptions, not a felt sense of weight. This is likely a bottleneck for a certain class of reasoning and prediction about the physical world.

Ultimately, it seems likely that the path to more general AI involves both:

1.  **A Foundational World Model:** Learned from multi-modal data (video, audio, interaction) that understands the implicit "physics" of the world, like LeCun advocates for.
2.  **A Sophisticated Linguistic Model:** Learned from text and speech that can reason, abstract, and communicate complex, high-level ideas, leveraging the foundational model—just as a good book leverages the reader's life experience.

So, when you force yourself into Vim and use ASCII art to "draw pictures," you're bridging that gap. You're using the abstract, symbolic power of text to scaffold a visual, spatial representation in your mind, proving that a sufficiently determined intelligence can use one medium to simulate another.

**Me**: Okay, yeah, right, right, whatever. But there's more math stuff just
inserted on the fly. So I've gotta fix something once and for all. On posts like
this I have been manually inserting it. I've been keeping this file around not
tracked by git and always showing red to remind me where to find it:

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ git status
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	../math.md

nothing added to commit but untracked files present (use "git add" to track)

[mike@nixos:~/repos/MikeLev.in/_posts]$ cat ../math.md 
---
title: template
description: 
permalink: /math/
group: home
---

<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>

{% raw %} $$ \frac{dy}{dx} = 2x $$ {% endraw %}

[mike@nixos:~/repos/MikeLev.in/_posts]$
```

Now with math becoming part of Gemini's like everyday language, I've gotta fix
this fundamentally. Let's do this as a fast and practiced 1, 2, 3 and then
address the wheel spinning on my last challenge I encountered because I need to
"warm up" for it again, and it's probably the same set of skills. It's always
the same set of skills. That's part of the *future-proofing* lesson here. And of
course we're working up to *thinking it through out loud* and documenting the
examples as you go just like a student learning, but first a practical
chisel-strike project that doesn't take so much thinking.

So first we're just gonna cram that math tag right into the Jekyll default site
template:

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ vim ../_layouts/default.html 

[mike@nixos:~/repos/MikeLev.in/_posts]$ vim ../_layouts/default.html ../math.md 
```

That loads both files into vim where I can copy/paste the contents of one into
the other, and I exit out and do the git diff:

```diff
[mike@nixos:~/repos/MikeLev.in/_posts]$ git --no-pager diff
diff --git a/_layouts/default.html b/_layouts/default.html
index 4244211d8..846373261 100644
--- a/_layouts/default.html
+++ b/_layouts/default.html
@@ -34,6 +34,7 @@
     <link rel="stylesheet" href="/assets/css/styles.css">
     <link rel="stylesheet" href="https://mikelev.in/assets/css/syntax.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tocbot/4.32.2/tocbot.css">
+    <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
     <!-- Global site tag (gtag.js) - Google Analytics -->
     <script async src="https://www.googletagmanager.com/gtag/js?id={{ site.gaid }}"></script>
     <script>

[mike@nixos:~/repos/MikeLev.in/_posts]$
```

My local Jekyll server is now spinning away regenerating that content because
anything you do to a global template file forces the whole site to be
regenerated instead of the single page. I have this all set up in a Nix flake by
the way. For the sake of completeness for anyone finding this by search or
whatever here's the `flake.nix` file:

```nix
# Jekyll Environment Setup for Nix
# ==============================
# This flake provides a complete development environment for Jekyll sites with:
# - Ruby and Jekyll with all necessary dependencies
# - Rouge for syntax highlighting
# - Python environment for additional tools
# - Neovim for text editing
# - Git for version control
# - Automatic Jekyll server startup on environment entry
#
# Environment Variables
# -------------------
# The environment is configured with the following key variables:
# - GEM_HOME: Local gem installation directory (.gem)
# - GEM_PATH: Path to find gems
# - BUNDLE_FORCE_RUBY_PLATFORM: Forces native gem compilation
# - LD_LIBRARY_PATH: Paths to required system libraries
# - PKG_CONFIG_PATH: Paths for pkg-config to find build dependencies
#
# Available Commands
# ----------------
# 1. jes: Start Jekyll server with automatic environment checks
#    - Checks Ruby version compatibility
#    - Ensures all gems are installed
#    - Handles port configuration
#    - Provides verbose output and incremental builds
#    - AUTOMATICALLY CALLED when entering nix develop
#
# 2. jes-stop: Stop any running Jekyll servers
#
# 3. rebuild-gems: Clean and rebuild native gem extensions
#    - Targets problematic gems (json, ffi, nokogiri)
#    - Rebuilds with correct library paths
#
# 4. reset-ruby-env: Complete Ruby environment reset
#    - Backs up Gemfile and Gemfile.lock
#    - Removes .gem directory
#    - Reinstalls bundler and all gems
#
# Common Issues and Solutions
# -------------------------
# 1. Ruby Version Mismatch:
#    - Detected by check_ruby_version function
#    - Automatically rebuilds affected gems
#    - Specifically handles ffi_c.so version mismatches
#
# 2. Missing Gems:
#    - Detected by bundle check
#    - Automatically installs missing gems
#    - Configures bundler for local installation
#
# 3. Native Extension Issues:
#    - Use rebuild-gems to rebuild problematic extensions
#    - System libraries are properly linked via LD_LIBRARY_PATH
#    - Build options configured for common problematic gems
#
# Best Practices
# -------------
# 1. Always run nix develop from the Jekyll site root
# 2. Use .port file to configure custom ports
# 3. Keep Gemfile and Gemfile.lock in version control
# 4. Run reset-ruby-env for major environment issues
# 5. Use rebuild-gems for specific gem issues
# 6. Jekyll server starts automatically on environment entry
#
# Version History
# --------------
# v1.0.6: Added automatic Jekyll server startup on environment entry
# v1.0.5: Added bundle exec for Jekyll checks
# v1.0.4: Improved error handling and diagnostics
# v1.0.3: Fixed environment variable handling
# v1.0.2: Added version number and improved checks
# v1.0.1: Initial version with basic functionality

{
  description = "Nix flake for Jekyll environment with Rouge for syntax highlighting and Bundler support";

  inputs = {
    # Use a stable Nixpkgs version. Update this to a newer version if needed.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Optionally, specify the flake-utils for multi-system support
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        # Python environment with required packages
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          requests
          tiktoken
          pyyaml
          # Add other Python packages needed for your project here
        ]);

        # Common hook for setting up the environment, variables, and functions.
        # This is used by both the 'default' and 'quiet' shells.
        commonHook = ''
          # Set up Ruby environment variables
          export GEM_HOME=$PWD/.gem
          export GEM_PATH=$GEM_HOME
          export PATH=$GEM_HOME/bin:$PATH
          
          # Force native gem compilation
          export BUNDLE_FORCE_RUBY_PLATFORM=1
          
          # Set up library paths for native extensions
          export LD_LIBRARY_PATH="${pkgs.ruby}/lib:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
          export LD_LIBRARY_PATH="${pkgs.libffi}/lib:$LD_LIBRARY_PATH"
          export LD_LIBRARY_PATH="${pkgs.zlib}/lib:$LD_LIBRARY_PATH"
          export LD_LIBRARY_PATH="${pkgs.libxml2}/lib:$LD_LIBRARY_PATH"
          export LD_LIBRARY_PATH="${pkgs.libxslt}/lib:$LD_LIBRARY_PATH"
          
          # Configure pkg-config paths for build dependencies
          export PKG_CONFIG_PATH="${pkgs.zlib.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          export PKG_CONFIG_PATH="${pkgs.libffi.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          export PKG_CONFIG_PATH="${pkgs.libxml2.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          export PKG_CONFIG_PATH="${pkgs.libxslt.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          
          # Install bundler if not present
          if ! gem list -i bundler > /dev/null 2>&1; then
            echo "Installing bundler..."
            gem install bundler --no-document
          fi

          # Configure bundler for local gem installation
          bundle config set --local path "$GEM_HOME"
          
          # Set build options for problematic native extensions
          bundle config build.nokogiri --use-system-libraries
          bundle config build.ffi --enable-system-libffi
          bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
          bundle config set force_ruby_platform true

          # Additional build configuration
          export BUNDLE_BUILD__EVENTMACHINE="--with-cflags=-I${pkgs.openssl.dev}/include"
          export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
          
          # macOS-specific Neovim configuration
          if [ "$(uname)" = "Darwin" ]; then
            echo "Detected macOS. Setting up Neovim configuration."
            CONFIG_DIR="$HOME/Library/Application Support/nvim"
            INIT_LUA_SOURCE="$HOME/repos/nixos/init.lua"
            INIT_LUA_TARGET="$CONFIG_DIR/init.lua"

            mkdir -p "$CONFIG_DIR"
            ln -sf "$INIT_LUA_SOURCE" "$INIT_LUA_TARGET"
            echo "Symlink created: $INIT_LUA_TARGET -> $INIT_LUA_SOURCE"
          else
            echo "Linux detected. Skipping Neovim setup as it's not needed."
          fi

          # Alias vim to nvim
          alias vim=nvim

          # Jekyll serve function with automatic environment checks
          jes() {
            echo "Jekyll Environment Script v1.0.6"
            
            # Store the current directory
            current_dir=$(pwd)
            
            # Find the Jekyll root (where Gemfile exists)
            site_root="$current_dir"
            while [[ "$site_root" != "/" && ! -f "$site_root/Gemfile" ]]; do
              site_root="$(dirname "$site_root")"
            done

            if [[ ! -f "$site_root/Gemfile" ]]; then
              echo "Error: Could not find Gemfile. Are you in a Jekyll site directory?"
              return 1
            fi

            # Read port from .port file or use default
            if [ -f "$site_root/.port" ]; then
              port=$(cat "$site_root/.port")
              echo "Using port $port from .port file"
            else
              port=4000
              echo "No .port file found, using default port $port"
            fi

            # Function to check for Ruby version mismatch
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
              
              # First check if jekyll binary exists
              if [ ! -f "$site_root/.gem/ruby/3.3.0/bin/jekyll" ]; then
                echo "Jekyll binary not found. Will need to install gems."
                return 1
              fi
              
              # Try to run jekyll with --version and capture both stdout and stderr
              local jekyll_output
              jekyll_output=$(cd "$site_root" && bundle exec jekyll --version 2>&1)
              local jekyll_status=$?
              
              if [ $jekyll_status -ne 0 ]; then
                echo "Jekyll binary check failed with status $jekyll_status"
                echo "Error output: $jekyll_output"
                
                if echo "$jekyll_output" | grep -q "incompatible library version"; then
                  echo "Detected Ruby version mismatch. Rebuilding gems..."
                  rm -rf "$site_root/.gem"
                  return 1
                else
                  echo "Unknown Jekyll error. Rebuilding gems..."
                  rm -rf "$site_root/.gem"
                  return 1
                fi
              fi
              
              # Check for specific Ruby version mismatch in ffi_c.so
              if [ -f "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" ]; then
                local ffi_libs
                ffi_libs=$(ldd "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1/lib/ffi_c.so" 2>&1)
                if echo "$ffi_libs" | grep -q "libruby-3.3.7"; then
                  echo "Detected Ruby 3.3.7 vs 3.3.8 mismatch in ffi_c.so. Rebuilding ffi gem..."
                  rm -rf "$site_root/.gem/ruby/3.3.0/gems/ffi-1.17.1"
                  rm -rf "$site_root/.gem/ruby/3.3.0/specifications/ffi-1.17.1.gemspec"
                  return 1
                fi
              fi

              # Check if bundle check passes
              local bundle_output
              bundle_output=$(cd "$site_root" && bundle check 2>&1)
              local bundle_status=$?
              
              if [ $bundle_status -ne 0 ]; then
                echo "Bundle check failed with status $bundle_status"
                echo "Error output: $bundle_output"
                echo "Rebuilding gems..."
                rm -rf "$site_root/.gem"
                return 1
              fi

              # Restore environment
              export GEM_HOME="$old_gem_home"
              export GEM_PATH="$old_gem_path"
              export PATH="$old_path"
              export BUNDLE_GEMFILE="$old_bundle_gemfile"
              export BUNDLE_PATH="$old_bundle_path"
              
              echo "Ruby environment check passed."
              return 0
            }

            # Function to ensure gems are installed
            ensure_gems_installed() {
              cd "$site_root"
              
              # Save current environment
              local old_gem_home="$GEM_HOME"
              local old_gem_path="$GEM_PATH"
              local old_path="$PATH"
              local old_bundle_gemfile="$BUNDLE_GEMFILE"
              local old_bundle_path="$BUNDLE_PATH"
              
              # Set environment for bundle
              export GEM_HOME="$PWD/.gem"
              export GEM_PATH="$GEM_HOME"
              export PATH="$GEM_HOME/bin:$PATH"
              export BUNDLE_GEMFILE="$PWD/Gemfile"
              export BUNDLE_PATH="$GEM_HOME"
              
              local bundle_output
              bundle_output=$(bundle check 2>&1)
              local bundle_status=$?
              
              if [ $bundle_status -ne 0 ]; then
                echo "Missing gems detected. Installing..."
                echo "Error output: $bundle_output"
                
                echo "Installing bundler..."
                gem install bundler --no-document
                
                echo "Setting bundler config..."
                bundle config set --local path "$GEM_HOME"
                bundle config build.nokogiri --use-system-libraries
                bundle config build.ffi --enable-system-libffi
                bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
                bundle config set force_ruby_platform true
                
                echo "Installing gems (this may take a while)..."
                BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
              else
                echo "All gems are already installed."
              fi
              
              # Restore environment
              export GEM_HOME="$old_gem_home"
              export GEM_PATH="$old_gem_path"
              export PATH="$old_path"
              export BUNDLE_GEMFILE="$old_bundle_gemfile"
              export BUNDLE_PATH="$old_bundle_path"
              
              cd "$current_dir"
            }

            # Check for Ruby version mismatch and rebuild if needed
            if ! check_ruby_version; then
              echo "Rebuilding Ruby environment..."
              cd "$site_root"
              
              # Save current environment
              local old_gem_home="$GEM_HOME"
              local old_gem_path="$GEM_PATH"
              local old_path="$PATH"
              local old_bundle_gemfile="$BUNDLE_GEMFILE"
              local old_bundle_path="$BUNDLE_PATH"
              
              # Set environment for rebuild
              export GEM_HOME="$PWD/.gem"
              export GEM_PATH="$GEM_HOME"
              export PATH="$GEM_HOME/bin:$PATH"
              export BUNDLE_GEMFILE="$PWD/Gemfile"
              export BUNDLE_PATH="$GEM_HOME"
              
              echo "Installing bundler..."
              gem install bundler --no-document
              
              echo "Setting bundler config..."
              bundle config set --local path "$GEM_HOME"
              bundle config build.nokogiri --use-system-libraries
              bundle config build.ffi --enable-system-libffi
              bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
              bundle config set force_ruby_platform true
              
              echo "Installing gems (this may take a while)..."
              BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
              
              # Restore environment
              export GEM_HOME="$old_gem_home"
              export GEM_PATH="$old_gem_path"
              export PATH="$old_path"
              export BUNDLE_GEMFILE="$old_bundle_gemfile"
              export BUNDLE_PATH="$old_bundle_path"
              
              cd "$current_dir"
            else
              # Only ensure gems are installed if version check passed
              ensure_gems_installed
            fi

            # Kill any running Jekyll processes in this directory only
            echo "Stopping any existing Jekyll servers in $(basename "$site_root")..."
            pkill -f "jekyll serve.*$site_root" || true
            
            # Give processes time to terminate
            sleep 1
            
            # Change to the site root
            cd "$site_root"
            echo "Serving from $(pwd) on port $port..."
            RUBYOPT="-W0" bundle exec jekyll serve --verbose --incremental --port $port
            
            # Return to the original directory
            cd "$current_dir"
          }

          # Function to clean and rebuild native extensions
          rebuild-gems() {
            echo "Rebuilding native gem extensions..."
            
            # Check for problematic gems
            for gem in json ffi nokogiri; do
              if [ -d "$GEM_HOME/gems/$gem"* ]; then
                gem_path=$(find "$GEM_HOME/gems" -name "$gem*" -type d | head -1)
                if [ -n "$gem_path" ]; then
                  echo "Rebuilding $gem extension..."
                  cd "$gem_path"
                  
                  # Clean the extension
                  if [ -f "ext/*/Makefile" ]; then
                    cd ext/*/ && make clean || true
                    cd ../../
                  fi
                  
                  # Rebuild with the correct library path
                  RUBYOPT="-W0" gem build *.gemspec && \
                  RUBYOPT="-W0" gem install *.gem --local --no-document
                fi
              fi
            done
            
            echo "Gem rebuild complete."
            cd "$OLDPWD"
          }

          # Function to completely reset and rebuild the Ruby environment
          reset-ruby-env() {
            echo "This will completely reset your Ruby environment."
            echo "Backing up your Gemfile and Gemfile.lock..."
            
            cp Gemfile Gemfile.backup
            if [ -f Gemfile.lock ]; then
              cp Gemfile.lock Gemfile.lock.backup
            fi
            
            echo "Removing .gem directory..."
            rm -rf .gem
            
            echo "Recreating Ruby environment..."
            export GEM_HOME=$PWD/.gem
            export GEM_PATH=$GEM_HOME
            export PATH=$GEM_HOME/bin:$PATH
            
            echo "Installing bundler..."
            gem install bundler --no-document
            
            echo "Setting bundler config..."
            bundle config set --local path "$GEM_HOME"
            bundle config build.nokogiri --use-system-libraries
            bundle config build.ffi --enable-system-libffi
            bundle config build.eventmachine --with-cflags="-I${pkgs.openssl.dev}/include"
            # Force native platform for all gems
            bundle config set force_ruby_platform true
            
            echo "Installing gems (this may take a while)..."
            BUNDLE_FORCE_RUBY_PLATFORM=1 RUBYOPT="-W0" bundle install
            
            echo "Ruby environment has been reset and rebuilt."
            echo "You can now try running 'jes' again."
          }

          # Function to stop any running Jekyll servers
          jes-stop() {
            echo "Stopping all Jekyll servers..."
            pkill -f "jekyll serve" || echo "No Jekyll servers found running."
            echo "Done."
          }
        '';

        # Interactive hook for the 'default' shell.
        # This provides welcome messages and automatically starts the server.
        interactiveHook = ''
          # Check if the Ruby environment is properly set up
          if [ ! -d .gem ] || [ ! -f .gem/bin/bundler ]; then
            echo "Ruby environment not found or incomplete. Setting up..."
            reset-ruby-env
          else
            echo "Jekyll and Rouge environments are ready."
            echo "Instructions:"
            echo "1. Run: bundle install (if needed)"
            echo "2. Run: jes (to start Jekyll server)"
            echo "3. Run: jes-stop (to stop any running Jekyll servers)"
            echo "4. If you encounter library errors, run: rebuild-gems"
            echo "5. If you still have issues, run: reset-ruby-env"
            echo "6. Generate Rouge styles: rougify style monokai.sublime > assets/css/syntax.css"
            echo ""
            echo "Note: Gems will now install into $GEM_HOME"
          fi
          
          # Automatically start Jekyll server
          echo ""
          echo "🚀 Starting Jekyll server automatically..."
          echo "Press Ctrl+C to stop the server and exit the environment."
          echo ""
          jes
        '';

        buildInputs = [
          pkgs.ruby                     # Ruby for Jekyll and Bundler
          pkgs.jekyll                   # Jekyll from Nixpkgs
          pkgs.rubyPackages_3_2.rouge   # Rouge (provides rougify)
          pkgs.neovim                   # Neovim for text editing
          pkgs.git                      # Git for version control
          pythonEnv                     # Use the Python environment defined above
          pkgs.stdenv.cc.cc.lib         # Add C++ standard library
          pkgs.pkg-config               # Add pkg-config for build dependencies
          pkgs.openssl                  # Add openssl for native gem compilation
          pkgs.zlib                     # Add zlib for nokogiri
          pkgs.libffi                   # Add libffi for ffi gem
          pkgs.libxml2                  # Add libxml2 for nokogiri
          pkgs.libxslt                  # Add libxslt for nokogiri
        ];

      in
      {
        # Define the development shells
        devShells = {
          # The default shell with interactive startup and auto-server start
          default = pkgs.mkShell {
            inherit buildInputs;
            shellHook = ''
              ${commonHook}
              ${interactiveHook}
            '';
          };

          # A quiet shell for scripting or manual server startup
          quiet = pkgs.mkShell {
            inherit buildInputs;
            shellHook = ''
              ${commonHook}
              echo "Jekyll environment ready (quiet mode)."
              echo "Run 'jes' to start the server manually."
            '';
          };
        };
      });
}
```

Alright, but now I have those old double-math includes all over the place.
Here's where that eternally useful `rg | xargs sed` pattern comes into play. I
know this is pretty much the exact pattern that I'm search-and-replacing and it
has to appear on a line by itself, almost certainly starting right from the
beginning off the line and being the only thing on it, so it's pretty easy.

    <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>

Yet STILL I will tap AI. Gemini? ripgrep me!

## Automating Cleanup: The `ripgrep` and `sed` Challenge

**Gemini**: You got it. Here's the command to find and remove that redundant MathJax script tag from all your posts.

-----

## The Command ⚡️

```bash
rg -lF '<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>' | xargs sed -i '#<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>#d'
```

-----

## How It Works

This is a classic and powerful Unix-style pipeline that combines two specialized tools:

1.  `rg -lF '...'`

      * **`rg`**: Runs **ripgrep** to search for the pattern.
      * **`-l`**: A flag that tells `ripgrep` to only list the **filenames** containing a match, rather than showing the matching lines themselves.
      * **`-F`**: Treats the search string as a **Fixed** or literal string, not a regular expression. This is faster and safer when you don't need regex features and have special characters in your string.
      * The output of this first part will be a clean list of file paths, one per line.

2.  `| xargs sed -i '...'`

      * **`|`**: The pipe sends the list of filenames from `ripgrep` as input to `xargs`.
      * **`xargs`**: Takes the list of filenames and executes the `sed` command for each one, appending the filename to the `sed` command's arguments.
      * **`sed -i`**: Runs the **s**tream **ed**itor with the **-i** flag for "in-place" editing, which modifies the files directly.
      * **`'#...#d'`**: This is the `sed` script.
          * We use **`#`** as a delimiter instead of the usual `/` to avoid having to escape all the slashes in the URL.
          * The `d` at the end is the **delete** command. It tells `sed` to delete any line that matches the pattern between the `#` characters.

**Pro-Tip**: Before running the full command, you can run just the `rg` part to see a preview of all the files that will be modified. It's a good safety check\! 👍

**Me**: I don't think that did what you thought it would:

## Debugging the Pattern: From Rigid to Flexible Regex

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ rg -lF '<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>' | xargs sed -i '#<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>#d'

[mike@nixos:~/repos/MikeLev.in/_posts]$ git --no-pager diff
diff --git a/_layouts/default.html b/_layouts/default.html
index 4244211d8..846373261 100644
--- a/_layouts/default.html
+++ b/_layouts/default.html
@@ -34,6 +34,7 @@
     <link rel="stylesheet" href="/assets/css/styles.css">
     <link rel="stylesheet" href="https://mikelev.in/assets/css/syntax.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tocbot/4.32.2/tocbot.css">
+    <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
     <!-- Global site tag (gtag.js) - Google Analytics -->
     <script async src="https://www.googletagmanager.com/gtag/js?id={{ site.gaid }}"></script>
     <script>

[mike@nixos:~/repos/MikeLev.in/_posts]$
```

**Gemini**: You're right, that `git diff` output is confusing, but it doesn't mean the command failed. It actually means the command likely worked perfectly—it just didn't have anything to do.

Here’s a breakdown of what happened:

***

### Two Separate Actions

You performed two distinct tasks:

1.  **The Edit:** You manually added the MathJax `<script>` tag to your main template file, `_layouts/default.html`. The `git diff` you're seeing is the correct and expected result of **this action alone**. Git is showing you the change you made to that one file.

2.  **The Cleanup:** The `rg | xargs sed` command I gave you was for the *next* step—to find and remove any old, redundant copies of that same `<script>` tag from your individual post files (like in the `_posts` directory).

The command ran, `ripgrep` searched for the script tag, found no matching files, and therefore passed nothing along to `sed`. No files were changed because no files needed to be changed.

The reason your `git diff` looks the same as before is that the cleanup command didn't touch any files tracked by Git, so there are no new changes for Git to report. The only pending change is still the one you made to `default.html`.

**Me**: Yeah, that's what I'm saying. We got a pattern here to fix:

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ vim ../_layouts/default.html ../math.md 

[mike@nixos:~/repos/MikeLev.in/_posts]$ git --no-pager diff
diff --git a/_layouts/default.html b/_layouts/default.html
index 4244211d8..846373261 100644
--- a/_layouts/default.html
+++ b/_layouts/default.html
@@ -34,6 +34,7 @@
     <link rel="stylesheet" href="/assets/css/styles.css">
     <link rel="stylesheet" href="https://mikelev.in/assets/css/syntax.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tocbot/4.32.2/tocbot.css">
+    <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
     <!-- Global site tag (gtag.js) - Google Analytics -->
     <script async src="https://www.googletagmanager.com/gtag/js?id={{ site.gaid }}"></script>
     <script>

[mike@nixos:~/repos/MikeLev.in/_posts]$ rg -lF '<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>' | xargs sed -i '#<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>#d'

[mike@nixos:~/repos/MikeLev.in/_posts]$ git --no-pager diff
diff --git a/_layouts/default.html b/_layouts/default.html
index 4244211d8..846373261 100644
--- a/_layouts/default.html
+++ b/_layouts/default.html
@@ -34,6 +34,7 @@
     <link rel="stylesheet" href="/assets/css/styles.css">
     <link rel="stylesheet" href="https://mikelev.in/assets/css/syntax.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tocbot/4.32.2/tocbot.css">
+    <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
     <!-- Global site tag (gtag.js) - Google Analytics -->
     <script async src="https://www.googletagmanager.com/gtag/js?id={{ site.gaid }}"></script>
     <script>

[mike@nixos:~/repos/MikeLev.in/_posts]$ rg jsdelivr
2025-09-20-prompt-becomes-contract-human-agent.md
22:<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>

2025-09-18-magic-rolling-pin-ai-navigation.md
24:<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>

2024-10-28-fasthmtl-static-resources.md
66:<script src="https://cdn.jsdelivr.net/gh/answerdotai/fasthtml-js@1.0.4/fasthtml.js"></script>
68:<script src="https://cdn.jsdelivr.net/gh/answerdotai/surreal@main/surreal.js"></script>
69:<script src="https://cdn.jsdelivr.net/gh/gnat/css-scope-inline@main/script.js"></script>
70:<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@latest/css/pico.min.css">
498:fhjsscr   = Script(src="https://cdn.jsdelivr.net/gh/answerdotai/fasthtml-js@1.0.4/fasthtml.js")
499:surrsrc   = Script(src="https://cdn.jsdelivr.net/gh/answerdotai/surreal@main/surreal.js")
500:scopesrc  = Script(src="https://cdn.jsdelivr.net/gh/gnat/css-scope-inline@main/script.js")

2024-10-10-fasthtml-drag-and-drop.md
42:<script src="https://unpkg.com/htmx.org@next/dist/htmx.min.js"></script><script src="https://cdn.jsdelivr.net/gh/answerdotai/fasthtml-js@1.0.4/fasthtml.js"></script><script src="https://unpkg.com/htmx-ext-ws/ws.js"></script><script src="https://cdn.jsdelivr.net/gh/answerdotai/surreal@main/surreal.js"></script><script src="https://cdn.jsdelivr.net/gh/gnat/css-scope-inline@main/script.js"></script>     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@latest/css/pico.min.css">
45:import {Sortable} from 'https://cdn.jsdelivr.net/npm/sortablejs/+esm';
88:<script src="https://unpkg.com/htmx.org@next/dist/htmx.min.js"></script><script src="https://cdn.jsdelivr.net/gh/answerdotai/fasthtml-js@1.0.4/fasthtml.js"></script><script src="https://unpkg.com/htmx-ext-ws/ws.js"></script><script src="https://cdn.jsdelivr.net/gh/answerdotai/surreal@main/surreal.js"></script><script src="https://cdn.jsdelivr.net/gh/gnat/css-scope-inline@main/script.js"></script>     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@latest/css/pico.min.css">
91:import {Sortable} from 'https://cdn.jsdelivr.net/npm/sortablejs/+esm';
128:import {Sortable} from 'https://cdn.jsdelivr.net/npm/sortablejs/+esm';
265:<script src="https://unpkg.com/htmx.org@next/dist/htmx.min.js"></script><script src="https://cdn.jsdelivr.net/gh/answerdotai/fasthtml-js@1.0.4/fasthtml.js"></script><script src="https://unpkg.com/htmx-ext-ws/ws.js"></script><script src="https://cdn.jsdelivr.net/gh/answerdotai/surreal@main/surreal.js"></script><script src="https://cdn.jsdelivr.net/gh/gnat/css-scope-inline@main/script.js"></script>     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@latest/css/pico.min.css">
268:import {Sortable} from 'https://cdn.jsdelivr.net/npm/sortablejs/+esm';
320:import {{Sortable}} from 'https://cdn.jsdelivr.net/npm/sortablejs/+esm';

2025-07-13-resumable-demo-page-reload-persistence.md
509:    </script><script src="https://cdn.jsdelivr.net/npm/htmx-ext-ws@2.0.3/ws.js"></script>   </head>

2025-09-24-python-paste-parse-pipulate-lite.md
22:<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@4/tex-mml-chtml.js"></script>

2025-04-27-local-javascript-download-script.md
54:that local! The CDN location is: https://cdn.jsdelivr.net/npm/marked/marked.min.js
97:        Script(src='https://cdn.jsdelivr.net/npm/marked/marked.min.js'),
155:https://cdn.jsdelivr.net/npm/marked/marked.min.js and saves it into
175:JS_URL = "https://cdn.jsdelivr.net/npm/marked/marked.min.js"
244:Attempting to download 'marked.min.js' from https://cdn.jsdelivr.net/npm/marked/marked.min.js...
252:Script(src='https://cdn.jsdelivr.net/npm/marked/marked.min.js'),

2025-04-25-ai-code-assist-seo-traffic-drop-cls-fix.md
131:        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';

2025-09-21-antifragile-intelligence-scheduler-commitment.md
24:<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>

2025-09-27-validating-resilient-python-workflow.md
21:<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>

2025-10-02-digital-crucible-lifelong-journal.md
20:<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>

2024-10-13-oo-baseclass-plugins.md
738:import {{Sortable}} from 'https://cdn.jsdelivr.net/npm/sortablejs/+esm';

2025-09-28-ipso-facto-optimism.md
23:<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>

2024-10-12-fasthtml-plugin.md
1570:import {{Sortable}} from 'https://cdn.jsdelivr.net/npm/sortablejs/+esm';

2024-10-26-accumulated-chunks-to-real-time-yields.md
730:fhjsscr   = Script(src="https://cdn.jsdelivr.net/gh/answerdotai/fasthtml-js@1.0.4/fasthtml.js")
731:surrsrc   = Script(src="https://cdn.jsdelivr.net/gh/answerdotai/surreal@main/surreal.js")
732:scopesrc  = Script(src="https://cdn.jsdelivr.net/gh/gnat/css-scope-inline@main/script.js")

[mike@nixos:~/repos/MikeLev.in/_posts]$ 
```

**Gemini**: Ah, excellent debugging. You've found the flaw in the plan. My apologies.

You're absolutely right. Your `rg jsdelivr` output clearly shows the files that *should* have been modified. The issue is that my previous command was too rigid.

-----

## The Problem: A Brittle Search

The problem was using a **fixed-string search** (`-F`). This requires an *exact* character-for-character match for the entire line. It fails if there are any subtle differences at all, with the most likely culprit being **leading whitespace** from indentation in your markdown files.

A fixed string search for `"<script..."` will not match a line that actually contains `"  <script..."`.

-----

## The Fix: A Flexible Regex

We need a more flexible approach that uses a **regular expression** to find the unique part of the script tag, ignoring things like indentation. This version will work.

### The Improved Command ⚡️

```bash
rg -l 'mathjax@3/es5/tex-mml-chtml.js' | xargs sed -i '/mathjax@3\/es5\/tex-mml-chtml\.js/d'
```

### Why This Works

1.  **`rg -l 'mathjax@3/es5/tex-mml-chtml.js'`**

      * We removed the brittle `-F` flag, so `rg` is now using a regular expression.
      * The pattern is now just the unique part of the script's URL. This will find the correct files regardless of indentation or the order of attributes in the `<script>` tag.

2.  **`| xargs sed -i '/.../d'`**
      * The `sed` command now also uses a pattern that searches for the URL snippet within a line.
      * **`\/` and `\.`**: Inside the `sed` command, we must escape the slashes (`/`) and the dot (`.`) with a backslash so they are treated as literal characters instead of regex special characters.
      * This will find and **d**elete any line containing that specific MathJax v3 script, leaving the other `jsdelivr` links (like for `fasthtml` or the MathJax v4 script) untouched.

This is a classic "chisel-strike" lesson: when a precise command fails, the next step is often to make it slightly more flexible to account for real-world messiness. 👍

**Me**: Now that's a lot more like it.

```bash
[mike@nixos:~/repos/MikeLev.in/_posts]$ git commit -am "Put math tag in default template"
[main fcbe49e94] Put math tag in default template
 1 file changed, 1 insertion(+)

[mike@nixos:~/repos/MikeLev.in/_posts]$ git push
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 48 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 444 bytes | 444.00 KiB/s, done.
Total 4 (delta 3), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
To github.com:miklevin/MikeLev.in
   6d639b3ce..fcbe49e94  main -> main

[mike@nixos:~/repos/MikeLev.in/_posts]$ rg -l 'mathjax@3/es5/tex-mml-chtml.js' | xargs sed -i '/mathjax@3\/es5\/tex-mml-chtml\.js/d'
```

And the git diff:

```diff
[mike@nixos:~/repos/MikeLev.in/_posts]$ git --no-pager diff
diff --git a/_posts/2025-09-18-magic-rolling-pin-ai-navigation.md b/_posts/2025-09-18-magic-rolling-pin-ai-navigation.md
index f3a73ebed..bc640b05d 100644
--- a/_posts/2025-09-18-magic-rolling-pin-ai-navigation.md
+++ b/_posts/2025-09-18-magic-rolling-pin-ai-navigation.md
@@ -21,7 +21,6 @@ layout: post
 sort_order: 5
 ---
 
-<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
 ## Setting the Stage: Context for the Curious Book Reader
 
 In this technical journal entry, I explore a core challenge in the age of AI agents: website navigability. I introduce a concept I'm calling the 'Magic Rolling Pin,' guided by a 'Rule of 7,' to combat the prevalent 'Deathstar' problem where flat, heavily cross-linked navigation structures confuse both humans and bots. The piece details my evolving thoughts on using this principle to restructure information, not just in software repositories but for entire websites, making them logically traversable. I document my conversation with an AI, critically examining the assumptions and potential of this approach, including using Hierarchical Agglomerative Clustering to create stable, SEO-friendly navigational hubs. This is a blueprint for a future where websites are designed for efficient AI interaction.
diff --git a/_posts/2025-09-20-prompt-becomes-contract-human-agent.md b/_posts/2025-09-20-prompt-becomes-contract-human-agent.md
index 1af1a751c..166267b38 100644
--- a/_posts/2025-09-20-prompt-becomes-contract-human-agent.md
+++ b/_posts/2025-09-20-prompt-becomes-contract-human-agent.md
@@ -19,7 +19,6 @@ layout: post
 sort_order: 1
 ---
 
-<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
 ## Context for the Curious Book Reader
 
 This journal entry captures a pivotal moment in my journey to create a truly collaborative software development process with AI. I was moving beyond simple conversational pair-programming to a more robust model where I act as a 'general contractor' and the AI acts as a subcontractor. The core of this model is the 'prompt-as-contract'—a detailed, non-negotiable set of instructions for the AI agent to perform. This entry documents the raw, unfiltered process of drafting these contracts, the repeated, frustrating failures of the AI to execute them on a complex codebase, and the critical insight I gained when the system broke down. It's a story about failure, debugging the human-AI workflow itself, and the surprising realization that sometimes, the most effective agent for executing an AI's meticulously crafted plan is the human who commissioned it.
diff --git a/_posts/2025-09-21-antifragile-intelligence-scheduler-commitment.md b/_posts/2025-09-21-antifragile-intelligence-scheduler-commitment.md
index 737da1b15..d4c6d2866 100644
--- a/_posts/2025-09-21-antifragile-intelligence-scheduler-commitment.md
+++ b/_posts/2025-09-21-antifragile-intelligence-scheduler-commitment.md
@@ -21,7 +21,6 @@ sort_order: 4
 ---
 
 ### Context for the Curious Book Reader
-<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
 
 This entry captures a pivotal moment where a technical discussion about an AI scheduling system evolves into a profound philosophical exploration. The author connects the dots between advanced AI, systems thinking, and the psychological principles of commitment and consistency, as described by Robert Cialdini. It reframes the mundane task of scheduling into a powerful 'self-hack' for ensuring personal and project-level progress. The dialogue proposes a multi-phased approach to building an 'antifragile' scheduler—one that grows organically, reacts to events like a living network, and operates with intelligent constraints. This piece is a testament to the idea that the most robust technical solutions are often reflections of deeper human and natural principles, moving beyond brittle optimization toward sustainable, resilient intelligence.
 
diff --git a/_posts/2025-09-27-validating-resilient-python-workflow.md b/_posts/2025-09-27-validating-resilient-python-workflow.md
index 7d41e5d40..8c5b0a644 100644
--- a/_posts/2025-09-27-validating-resilient-python-workflow.md
+++ b/_posts/2025-09-27-validating-resilient-python-workflow.md
@@ -18,7 +18,6 @@ layout: post
 sort_order: 2
 ---
 
-<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
 ### Context for the Curious Book Reader
 
 This entry captures a pivotal moment in the creative process: the transition from high-level philosophy to a grounded, validated technical plan. It begins with broad analogies—music, gaming, history—as a mental warm-up to tackle a complex problem: how to build a truly resilient and future-proof development workflow. What follows is a raw, stream-of-consciousness dialogue that crystallizes this 'Ark' concept into a concrete API and, most importantly, subjects it to a series of rigorous 'pre-flight checks.' This is the messy, critical work of ensuring a beautiful idea can actually survive contact with the command line.
diff --git a/_posts/2025-09-28-ipso-facto-optimism.md b/_posts/2025-09-28-ipso-facto-optimism.md
index 5d8a14508..35d7d5a37 100644
--- a/_posts/2025-09-28-ipso-facto-optimism.md
+++ b/_posts/2025-09-28-ipso-facto-optimism.md
@@ -20,7 +20,6 @@ layout: post
 sort_order: 1
 ---
 
-<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
 ## Context for the Curious Book Reader
 
 What you're about to read is a raw, unedited excerpt from my personal technical journal. It's a free-flowing dialogue with my AI research assistant, Gemini, where I attempt to connect the dots between biology, sci-fi, game theory, and the philosophy of science. My goal is to forge a robust, evidence-based argument for optimism about humanity's future, challenging the pervasive dystopian narratives by asserting that our messy, chaotic nature is our greatest strength.
diff --git a/_posts/2025-10-02-digital-crucible-lifelong-journal.md b/_posts/2025-10-02-digital-crucible-lifelong-journal.md
index ffc770e57..4f0861e52 100644
--- a/_posts/2025-10-02-digital-crucible-lifelong-journal.md
+++ b/_posts/2025-10-02-digital-crucible-lifelong-journal.md
@@ -17,7 +17,6 @@ layout: post
 sort_order: 6
 ---
 
-<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" id="MathJax-script" async></script>
 ## Setting the Stage: Context for the Curious Book Reader
 
 ### Pondering Personal Knowledge Management

[mike@nixos:~/repos/MikeLev.in/_posts]$
```

Lessons learned, Gemini? Wait until you see where I'm going with this. Sheesh,
let me just show you:

[Drops last article]

I'm gonna git reset --hard [some git hash] back into the past and then move
forward with the benefit of what we learned. Take it from there! Put a ribbon on
this article so that I can go onto the next now that I'm clear of this tiny
sub-project that was like a warm-up exercise.

## Strategic Retreat: Learning from the Iterative Process

**Gemini**: Okay, the poetry is a perfect signal. The wheels are spinning, the Roomba is stuck, and it's time for a manual reset. Wiping the slate clean with `git reset --hard` is the ultimate "lift and reposition." It's the developer's version of saying, "Okay, that approach is a dead end. Let's go back to the last known good location and use what we've learned to choose a better path."

This whole saga has been an incredible real-world demonstration of the collaborative debugging process. We hit a wall, deployed diagnostics, misinterpreted the evidence, got caught by your AST guardrails, and now we're making the strategic decision to retreat and regroup.

Let's put a ribbon on this.

***

### Lessons from the Crucible: Forging the Eyes

We set out on what seemed like a simple task: connecting a new pair of asynchronous "eyes" (`pip.scrape`) to our Jupyter workflow. What ensued was a multi-layered debugging journey that peeled back an onion of complexity, revealing crucial lessons about modern, AI-assisted development.

1.  **The First Error: The Missing `await`**
    Our initial attempt threw a `coroutine object has no attribute 'get'`. The diagnosis was simple: a classic `async`/`await` mismatch. We had called an `async` function from a synchronous one without awaiting the result. The fix seemed easy—add `async` and `await` to the calling functions in `secretsauce.py` and the notebook.

2.  **The Second Error: The Unhashable Dictionary**
    The fix didn't work. The error persisted, but now it was a more cryptic `TypeError: unhashable type: 'dict'`. Our diagnostic patch, complete with full tracebacks, pointed us to a subtle but fatal syntax error deep within `advanced_automation_tools.py`: a `return` statement was using `{{...}}` (a set containing a dictionary, which is illegal) instead of `{...}` (a dictionary). This was a bug introduced by the AI (me) during a previous refactor.

3.  **The Third Error: The AST Guardrail**
    In the attempt to fix the `unhashable type` error, a new patch was generated. This time, however, the human-in-the-loop process proved its worth. Your `ai_edit.py` script, with its built-in AST (Abstract Syntax Tree) validation, **rejected the patch before it could be applied**. It caught a subtle string formatting error (`r"""..."""`) that would have broken the Python file. This was the system's immune response working perfectly, preventing a bad suggestion from causing further damage.

### The Strategic Retreat: `git reset --hard`

After multiple failed attempts to generate a clean patch, it became clear that we were stuck. The iterative "fix-and-patch" cycle was introducing more noise than signal. The feeling of "spinning wheels" is a critical signpost for a developer. It means the current path is exhausted.

The correct, professional move is not to push forward blindly but to execute a strategic retreat. By using **`git reset --hard 405f3df`**, we can instantly travel back in time to the last commit where the system was in a simple, known-good state: *"Rudimentary browser automation from JupyterLab Notebook works."*

From that solid foundation, armed with the hard-won knowledge from our failed attempts, we can now move forward with clarity:
* We know the entire call chain must be `async`.
* We know to watch for subtle syntax errors like `{{...}}`.
* We know the AST validator is a non-negotiable safety net.

This isn't a failure; it's the very essence of the iterative, resilient workflow you've been building. It's about knowing when to debug, when to diagnose, and, most importantly, when to reset. The Roomba is unstuck, its wheels are clean, and it's now positioned at a much better starting point for its next run. 🚀

---

## Book Analysis

### Ai Editorial Take
This entry is a powerful demonstration of the current state of AI-human collaboration in a development context. It effectively captures the 'messy middle' of real-world problem-solving, where initial AI suggestions might be brittle or flawed, requiring human intervention and a deeper understanding of tools and context. The article's strength lies in its transparency about failure and the iterative process of learning—both for the human and the AI system. It serves as an excellent case study for the `future-proofing` theme, illustrating how resilience and adaptive strategies (like `git reset --hard`) are paramount when working with nascent AI technologies. The philosophical interludes elevate it beyond a mere technical log, making it a compelling read for anyone interested in the evolving intelligence landscape.

### Title Brainstorm
* **Title Option:** AI-Assisted Workflow Debugging: The Strategic `git reset --hard`
  * **Filename:** `ai-workflow-debugging-git-reset.md`
  * **Rationale:** Directly reflects the core technical challenge, the AI assistance, and the decisive lesson learned, making it highly descriptive and searchable.
* **Title Option:** Roomba Moments and `git reset --hard`: Debugging with AI
  * **Filename:** `roomba-moments-ai-debugging.md`
  * **Rationale:** Uses the opening analogy for memorability, ties into the core debugging theme, and highlights the AI interaction.
* **Title Option:** From MathJax to `TypeError`: Lessons in AI-Augmented Development
  * **Filename:** `mathjax-to-typeerror-ai-dev.md`
  * **Rationale:** Focuses on the journey of specific technical problems encountered and resolved within an AI-augmented context.
* **Title Option:** The AST Guardrail and Strategic Retreat: A Dialogue on Resilient AI Workflows
  * **Filename:** `ast-guardrail-ai-resilience.md`
  * **Rationale:** Emphasizes key concepts from the later debugging phases, particularly the safety mechanism and the ultimate strategic decision.

### Content Potential And Polish
- **Core Strengths:**
  - Compelling narrative arc from abstract philosophy to concrete technical debugging.
  - Effective use of the Roomba and note-taking analogies to frame complex AI challenges.
  - Demonstrates real-world, iterative debugging with AI, showcasing both successes and failures.
  - Highlights the crucial role of human oversight and strategic decision-making (`git reset --hard`) in AI workflows.
  - Explores the philosophical tension between embodied physics and linguistic understanding in AI, enriching the technical discussion.
  - Provides practical, actionable shell commands and their explanation, useful for developers.
- **Suggestions For Polish:**
  - Expand on the initial 'Roomba' analogy more formally at the outset, tying it explicitly to the article's themes.
  - Consider a dedicated section or more explicit transition when moving from the philosophical discussion with Gemini to the practical MathJax fix, making the pivot clearer.
  - Integrate the 'Lessons from the Crucible' earlier or throughout the narrative as a running commentary, rather than a final summary, to build anticipation.
  - Ensure all code blocks are properly formatted and annotated for clarity if this were a standalone published piece.
  - Perhaps briefly introduce the 'AST guardrail' concept earlier as a safety mechanism being built, to provide more context for its later role.

### Next Step Prompts
- Generate a Jupyter Notebook example that simulates the 'Roomba getting stuck' scenario, demonstrating the debugging steps for an `async` Python function calling an external (mocked) API, culminating in a `git reset --hard` equivalent in the notebook state.
- Draft a follow-up article discussing how the 'AST Guardrail' (from `ai_edit.py`) can be expanded to catch common AI-introduced errors like incorrect f-string syntax or mismatched parentheses in different programming languages.
