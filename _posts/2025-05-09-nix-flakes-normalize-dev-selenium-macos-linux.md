---
title: "Nix Flakes as `normalize.css` for Dev: Selenium Automation on macOS & Linux"
permalink: /futureproof/nix-flakes-normalize-dev-selenium-macos-linux.md/
description: After successfully testing Selenium-based browser automation on NixOS, I pushed the standalone test to GitHub and, with AI's help, got a version working on macOS. The key was adapting the Nix Flake to handle macOS's specific needs for `chromedriver` (using `webdriver-manager` in the Python script for macOS, while Linux uses the Nix-provided `chromedriver`) and an updated Python script that accommodates these differences. This resulted in a unified `flake.nix` and a single `test_selenium.py` that now successfully automates Chrome on both macOS and Linux from within a Nix-managed environment, a big step towards a truly cross-platform dev setup.
meta_description: Guide to achieving cross-platform (macOS, Linux) browser automation using Selenium and Nix Flakes, controlling host Chrome via chromedriver or webdriver-manager.
meta_keywords: Nix Flakes, Selenium, macOS, Linux, cross-platform, browser automation, chromedriver, webdriver-manager, find-browser, Python, NixOS, dev environment, host browser, Chrome
layout: post
sort_order: 2
---

## Understanding Cross-Platform Development Environments: Getting Started

When software developers build applications, they often want their tools and programs to work consistently whether they are using a Windows, macOS, or Linux computer. Achieving this "works everywhere" goal can be tricky because each operating system handles software installations and system resources differently. Nix is a powerful tool that helps create reproducible and identical software environments across these different systems. "Nix Flakes" are a modern way to define these environments.

This article discusses a specific challenge: making web browser automation (using a tool called Selenium to programmatically control a web browser like Chrome) work reliably on both macOS and Linux using such a Nix Flake setup. The author explores how to configure Nix to handle the platform-specific requirements for browser drivers (the software that lets Selenium talk to the browser) and how to write a single Python script that can then run on either system to control the browser. It's about using Nix to smooth out the differences between operating systems for a common development task.

---

## Yeah, But Will That Linux Script Run On Mac?

In my previous article, I made a bare minimum test of browser automation from
NixOS using Selenium and a Nix flake. It worked, but I was on NixOS, so that's
no real test at all. So I turned the folder which was already a git repo (they
have to be for Nix flakes) and [uploaded it to
GitHub](https://github.com/miklevin/browser).

And I employed AI of course to make the first version that worked standalone on
the Mac:

```nix
{
  # flake.nix that works on macOS

  description = "Standalone test for Selenium host browser automation with Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; }; # Good practice
        };

        # Helper script to find host browsers
        findBrowserScript = pkgs.writeShellScriptBin "find-browser" ''
          #!/usr/bin/env bash
          # set -e # Do not exit on error, allow script to report 'not found'
          BROWSER_NAME=$1
          OS_TYPE=$2 # "linux", "darwin", "wsl"

          HOST_PATH_VAR="HOST_$(echo "$BROWSER_NAME" | tr '[:lower:]' '[:upper:]')_PATH"
          HOST_PATH_VAL=$(printenv "$HOST_PATH_VAR" || true)
          if [[ -n "$HOST_PATH_VAL" && -x "$HOST_PATH_VAL" ]]; then echo "$HOST_PATH_VAL"; exit 0; fi

          if [[ "$OS_TYPE" == "darwin" ]]; then
            if [[ "$BROWSER_NAME" == "chrome" ]]; then
              FP="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"; [[ -x "$FP" ]] && echo "$FP" && exit 0
              FP="$HOME/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"; [[ -x "$FP" ]] && echo "$FP" && exit 0
            fi
          elif [[ "$OS_TYPE" == "linux" ]]; then
            if [[ "$BROWSER_NAME" == "chrome" ]]; then
              TMP_PATH=$(command -v google-chrome-stable || command -v google-chrome || command -v chromium-browser || command -v chromium 2>/dev/null)
              if [[ -n "$TMP_PATH" ]]; then echo "$TMP_PATH"; exit 0; fi
            fi
          elif [[ "$OS_TYPE" == "wsl" ]]; then
            if [[ "$BROWSER_NAME" == "chrome" ]]; then
              FP="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"; [[ -f "$FP" ]] && echo "$FP" && exit 0
              FP="/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe"; [[ -f "$FP" ]] && echo "$FP" && exit 0
            fi
          fi
          exit 1 # Exit with error if not found, so Python script can check return code
        '';

        # Derivation for the Python test script itself
        testSeleniumPy = pkgs.stdenv.mkDerivation {
          name = "test-selenium-script";
          src = ./test_selenium.py; # Assumes test_selenium.py is in the same directory as flake.nix
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/bin
            cp $src $out/bin/test_selenium
            chmod +x $out/bin/test_selenium
          '';
        };

        # The package that sets up the environment and runs the test
        seleniumTestRunner = pkgs.stdenv.mkDerivation {
          name = "run-selenium-poc";
          
          # System dependencies needed to build/run the test environment
          buildInputs = with pkgs; [
            python3Full
            coreutils # for mktemp, etc.
            bash      # for running the builder script
            findBrowserScript
            zlib          # In case any pip package (even deps of selenium) needs it
            gcc           # For compiling any C extensions during pip install
          ];
          
          # This script is the "build" process for this derivation.
          builder = pkgs.writeShellScript "run-selenium-test.sh" ''
            source $stdenv/setup # Basic Nix build environment setup
            set -e o pipefail    # Exit on error, treat unset variables as an error

            echo "--- Starting Standalone Selenium Test Runner ---"

            # Ensure all buildInputs are available in PATH for this script
            export PATH="${pkgs.python3}/bin:${pkgs.coreutils}/bin:${pkgs.bash}/bin:${findBrowserScript}/bin:$PATH"
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath (with pkgs; [ python3 coreutils bash findBrowserScript zlib gcc ])}:$LD_LIBRARY_PATH"

            # Determine EFFECTIVE_OS for find-browser (used by python script via os.environ)
            if [[ -n "$WSL_DISTRO_NAME" ]]; then
              export EFFECTIVE_OS="wsl"
            elif [[ "${system}" == *darwin* ]]; then # 'system' var is available to builder
              export EFFECTIVE_OS="darwin"
            elif [[ "${system}" == *linux* ]]; then
              export EFFECTIVE_OS="linux"
            else
              export EFFECTIVE_OS="unknown"
            fi
            echo "Builder: EFFECTIVE_OS set to $EFFECTIVE_OS"

            WORK_DIR=$(mktemp -d)
            echo "Builder: Working directory: $WORK_DIR"
            cd "$WORK_DIR"

            echo "Builder: Running the Selenium POC Python script..."
            # The python executable here is from the Nix environment with selenium installed
            python ${testSeleniumPy}/bin/test_selenium 
            
            echo "Builder: Selenium POC script finished."
            
            # Create a dummy output for Nix package requirements
            mkdir -p $out/bin
            cp ${testSeleniumPy}/bin/test_selenium $out/bin/standalone-selenium-test # Make it runnable
            echo "--- Test Runner Finished ---"
          '';
          
          phases = [ "installPhase" ];
          installPhase = "$builder";
        };

      in
      {
        packages.default = self.outputs.packages.${system}.testBrowserSelenium; # `nix build .`
        packages.testBrowserSelenium = seleniumTestRunner;

        # `nix run .#testBrowserSelenium` or `nix run .`
        apps.default = flake-utils.lib.mkApp { drv = seleniumTestRunner; };
        apps.testBrowserSelenium = flake-utils.lib.mkApp { drv = seleniumTestRunner; };

        # A dev shell for interactive testing / venv setup
        devShells.default = pkgs.mkShell {
          name = "selenium-poc-devshell";
          packages = with pkgs; [
            python3Full
            findBrowserScript
            zlib
            gcc
          ];
          shellHook = ''
            echo "Standalone Selenium POC Dev Shell"
            
            # Set up the Python virtual environment
            test -d .venv || ${pkgs.python3}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            
            # Install required packages in the virtual environment
            echo "Installing Python packages..."
            pip install --upgrade pip
            pip install selenium webdriver-manager
            
            echo "Run: python ./test_selenium.py"
            
            if [[ -n "$WSL_DISTRO_NAME" ]]; then
              export EFFECTIVE_OS="wsl"
            elif [[ "${system}" == *darwin* ]]; then
              export EFFECTIVE_OS="darwin"
            elif [[ "${system}" == *linux* ]]; then
              export EFFECTIVE_OS="linux"
            else
              export EFFECTIVE_OS="unknown"
            fi
            echo "EFFECTIVE_OS for manual testing: $EFFECTIVE_OS"
            echo "WebDriver Manager is available for automatic ChromeDriver management."
          '';
        };
      }
    );
}
```

...and the accompanying Python:

```python
# test_mac_selenium.py

import os
import subprocess
import tempfile
import shutil
import time
import sys
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.common.exceptions import WebDriverException
from webdriver_manager.chrome import ChromeDriverManager

print("--- Pipulate Standalone Selenium POC ---")

def get_host_browser_path(browser_name: str) -> str | None:
    """
    Uses the find-browser script (expected to be in PATH)
    and HOST_BROWSER_PATH environment variables.
    """
    effective_os = os.environ.get("EFFECTIVE_OS")
    if not effective_os:
        # Basic default for standalone test if not set by Nix shellHook
        if os.name == 'posix':
            uname_s = subprocess.run(["uname", "-s"], capture_output=True, text=True, check=False).stdout.strip()
            if uname_s == "Linux":
                effective_os = "linux"
            elif uname_s == "Darwin":
                effective_os = "darwin"
        if not effective_os: # Fallback
             effective_os = "linux" 
    
    print(f"Attempting to find browser '{browser_name}' for EFFECTIVE_OS '{effective_os}'")
    
    # Check user-defined environment variable first
    env_var_name = f"HOST_{browser_name.upper()}_PATH"
    user_path = os.environ.get(env_var_name)
    if user_path:
        print(f"Using browser path from env var {env_var_name}: '{user_path}'")
        # Basic existence check, WSL paths require careful handling if used cross-context
        if os.path.exists(user_path) or (effective_os == "wsl" and user_path.startswith("/mnt/")):
            return user_path
        else:
            print(f"  Path from env var '{user_path}' does not seem to exist or is invalid for this OS.")


    try:
        # find-browser script is expected to be in PATH via Nix environment
        process = subprocess.run(
            ["find-browser", browser_name, effective_os],
            capture_output=True, text=True, check=False,
        )
        if process.returncode == 0:
            path = process.stdout.strip()
            if path: # Ensure path is not empty
                print(f"'find-browser' script found {browser_name} at: {path}")
                return path
            else:
                print(f"'find-browser' script returned an empty path for {browser_name} on {effective_os}.")
                return None
        else:
            print(f"'find-browser' script failed for {browser_name} on {effective_os}. Stderr: {process.stderr.strip()}")
            return None
    except FileNotFoundError:
        print("Error: 'find-browser' script not found in PATH. Is it provided by the Nix environment?")
        return None
    except Exception as e:
        print(f"Error running 'find-browser' script: {e}")
        return None

def run_selenium_test():
    driver = None
    temp_profile_dir = None
    success = False
    print("\nStarting Selenium test run...")

    try:
        print("Initializing ChromeOptions...")
        chrome_options = ChromeOptions()
        
        # Try to find host browser; defaults to letting chromedriver find Nix's chromium from PATH if no specific path
        host_browser_executable = get_host_browser_path("chrome")
        if host_browser_executable:
            chrome_options.binary_location = host_browser_executable
            print(f"Setting Chrome binary_location to: {host_browser_executable}")
        else:
            print("No specific host Chrome/Chromium path found/set. Selenium will try to use browser from PATH (e.g., Nix's 'chromium').")

        # Removed headless mode to make browser visible
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument("--disable-gpu")
        chrome_options.add_argument("--window-size=1920,1080")

        temp_profile_dir = tempfile.mkdtemp(prefix="selenium_test_chrome_")
        chrome_options.add_argument(f"--user-data-dir={temp_profile_dir}")
        print(f"Using temporary Chrome profile directory: {temp_profile_dir}")

        # Use webdriver-manager to automatically download and manage ChromeDriver
        print("Initializing ChromeService with webdriver-manager...")
        chrome_service = ChromeService(ChromeDriverManager().install())
        
        print("Initializing webdriver.Chrome...")
        driver = webdriver.Chrome(service=chrome_service, options=chrome_options)
        print("Chrome WebDriver initialized.")

        target_url = "http://example.com"
        print(f"Navigating to {target_url}...")
        driver.get(target_url)
        title = driver.title
        print(f"Page title: '{title}'")

        if "example domain" in title.lower():
            print("SUCCESS: Correct page title found!")
            success = True
        else:
            print(f"FAILURE: Unexpected page title: '{title}'")

    except WebDriverException as e:
        print(f"WebDriverException occurred: {e}")
        if "net::ERR_CONNECTION_REFUSED" in str(e) and os.environ.get("EFFECTIVE_OS") == "wsl":
            print("Hint: This might be a WSL networking issue if trying to control a browser on the Windows host directly without proper setup.")
    except Exception as e:
        import traceback
        print(f"An unexpected error occurred: {e}")
        traceback.print_exc()
    finally:
        if driver:
            print("Quitting Chrome WebDriver...")
            driver.quit()
        if temp_profile_dir and os.path.exists(temp_profile_dir):
            try:
                shutil.rmtree(temp_profile_dir)
                print(f"Cleaned up temporary profile: {temp_profile_dir}")
            except Exception as e_cleanup:
                print(f"Error cleaning up temp profile {temp_profile_dir}: {e_cleanup}")
        
        print("--- Test Complete ---")
        if not success:
            print("TEST FAILED")
            return 1 # Indicate failure
        else:
            print("TEST PASSED")
            return 0 # Indicate success

if __name__ == "__main__":
    exit_code = run_selenium_test()
    sys.exit(exit_code)
```

...and this worked, and it was good. However, the same code would not work on
Linux of course because there's so much host OS differences between macOS and
Linux when it comes to browser automation. This is a real wrench in the works of
the whole unified-nix-for-all approach of using Nix Flakes as a sort of
`normalize.css` but for development directories. Sighhh. Still, not
insurmountable. Now that we have standalone versions that work on Mac and Linux
separately, they can be combined like this:

```nix
{
  description = "Platform-specific Selenium test environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      # Define platform-specific configurations
      mkConfig = system: let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        isDarwin = pkgs.stdenv.isDarwin;
        isLinux = pkgs.stdenv.isLinux;

        # Common packages for both platforms
        commonPackages = with pkgs; [
          python3Full
          coreutils
          bash
          zlib
          gcc
        ];

        # Linux-specific packages
        linuxPackages = with pkgs; [
          chromedriver
          chromium
        ];

        # Platform-specific shell configuration
        mkShell = pkgs.mkShell {
          name = "selenium-poc-devshell";
          packages = commonPackages ++ (if isLinux then linuxPackages else []);
          shellHook = ''
            echo "Standalone Selenium POC Dev Shell"
            
            test -d .venv || ${pkgs.python3}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            
            ${if isLinux then "export LD_LIBRARY_PATH=\"${pkgs.lib.makeLibraryPath linuxPackages}:$LD_LIBRARY_PATH\"" else ""}
            
            pip install --upgrade pip
            pip install selenium webdriver-manager
            
            export EFFECTIVE_OS="${if isDarwin then "darwin" else "linux"}"
            echo "EFFECTIVE_OS for manual testing: $EFFECTIVE_OS"
            echo "Run: python ./test_selenium.py"
          '';
        };

        # Platform-specific package configuration
        mkPackage = pkgs.stdenv.mkDerivation {
          name = "run-selenium-poc";
          buildInputs = commonPackages ++ (if isLinux then linuxPackages else []);
          builder = pkgs.writeShellScript "run-selenium-test.sh" ''
            source $stdenv/setup
            set -e o pipefail

            echo "--- Starting ${if isDarwin then "Mac" else "Linux"} Selenium Test Runner ---"

            export PATH="${pkgs.python3}/bin:${pkgs.coreutils}/bin:${pkgs.bash}/bin:$PATH"
            ${if isLinux then "export PATH=\"${pkgs.chromedriver}/bin:${pkgs.chromium}/bin:$PATH\"" else ""}
            ${if isLinux then "export LD_LIBRARY_PATH=\"${pkgs.lib.makeLibraryPath linuxPackages}:$LD_LIBRARY_PATH\"" else ""}

            export EFFECTIVE_OS="${if isDarwin then "darwin" else "linux"}"
            WORK_DIR=$(mktemp -d)
            cd "$WORK_DIR"
            python ${./test_selenium.py}
            mkdir -p $out/bin
            cp ${./test_selenium.py} $out/bin/standalone-selenium-test
          '';
          phases = [ "installPhase" ];
          installPhase = "$builder";
        };

      in {
        packages = {
          default = mkPackage;
          testBrowserSelenium = mkPackage;
        };
        apps = {
          default = flake-utils.lib.mkApp { drv = mkPackage; };
          testBrowserSelenium = flake-utils.lib.mkApp { drv = mkPackage; };
        };
        devShells = {
          default = mkShell;
        };
      };

    in
    flake-utils.lib.eachDefaultSystem (system:
      mkConfig system
    );
}
```

...and the Python that just works on both platforms:

```python
# test_selenium.py works on both macOS and Linux

import os
import subprocess
import tempfile
import shutil
import time
import sys
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.common.exceptions import WebDriverException
from webdriver_manager.chrome import ChromeDriverManager

print("--- Pipulate Standalone Selenium POC ---")

def get_host_browser_path(browser_name: str) -> str | None:
    """
    Uses the find-browser script (expected to be in PATH)
    and HOST_BROWSER_PATH environment variables.
    """
    effective_os = os.environ.get("EFFECTIVE_OS")
    if not effective_os:
        # Basic default for standalone test if not set by Nix shellHook
        if os.name == 'posix':
            uname_s = subprocess.run(["uname", "-s"], capture_output=True, text=True, check=False).stdout.strip()
            if uname_s == "Linux":
                effective_os = "linux"
            elif uname_s == "Darwin":
                effective_os = "darwin"
        if not effective_os: # Fallback
             effective_os = "linux" 
    
    print(f"Attempting to find browser '{browser_name}' for EFFECTIVE_OS '{effective_os}'")
    
    # Check user-defined environment variable first
    env_var_name = f"HOST_{browser_name.upper()}_PATH"
    user_path = os.environ.get(env_var_name)
    if user_path:
        print(f"Using browser path from env var {env_var_name}: '{user_path}'")
        # Basic existence check, WSL paths require careful handling if used cross-context
        if os.path.exists(user_path) or (effective_os == "wsl" and user_path.startswith("/mnt/")):
            return user_path
        else:
            print(f"  Path from env var '{user_path}' does not seem to exist or is invalid for this OS.")


    try:
        # find-browser script is expected to be in PATH via Nix environment
        process = subprocess.run(
            ["find-browser", browser_name, effective_os],
            capture_output=True, text=True, check=False,
        )
        if process.returncode == 0:
            path = process.stdout.strip()
            if path: # Ensure path is not empty
                print(f"'find-browser' script found {browser_name} at: {path}")
                return path
            else:
                print(f"'find-browser' script returned an empty path for {browser_name} on {effective_os}.")
                return None
        else:
            print(f"'find-browser' script failed for {browser_name} on {effective_os}. Stderr: {process.stderr.strip()}")
            return None
    except FileNotFoundError:
        print("Error: 'find-browser' script not found in PATH. Is it provided by the Nix environment?")
        return None
    except Exception as e:
        print(f"Error running 'find-browser' script: {e}")
        return None

def run_selenium_test():
    driver = None
    temp_profile_dir = None
    success = False
    print("\nStarting Selenium test run...")

    try:
        print("Initializing ChromeOptions...")
        chrome_options = ChromeOptions()
        
        # Try to find host browser; defaults to letting chromedriver find Nix's chromium from PATH if no specific path
        host_browser_executable = get_host_browser_path("chrome")
        if host_browser_executable:
            chrome_options.binary_location = host_browser_executable
            print(f"Setting Chrome binary_location to: {host_browser_executable}")
        else:
            print("No specific host Chrome/Chromium path found/set. Selenium will try to use browser from PATH (e.g., Nix's 'chromium').")

        # Removed headless mode to make browser visible
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument("--disable-gpu")
        chrome_options.add_argument("--window-size=1920,1080")

        temp_profile_dir = tempfile.mkdtemp(prefix="selenium_test_chrome_")
        chrome_options.add_argument(f"--user-data-dir={temp_profile_dir}")
        print(f"Using temporary Chrome profile directory: {temp_profile_dir}")

        # Use webdriver-manager on Mac, system chromedriver on Linux
        print("Initializing ChromeService...")
        if os.environ.get("EFFECTIVE_OS") == "darwin":
            chrome_service = ChromeService(ChromeDriverManager().install())
        else:
            chrome_service = ChromeService() # Use system chromedriver on Linux
        
        print("Initializing webdriver.Chrome...")
        driver = webdriver.Chrome(service=chrome_service, options=chrome_options)
        print("Chrome WebDriver initialized.")

        target_url = "http://example.com"
        print(f"Navigating to {target_url}...")
        driver.get(target_url)
        title = driver.title
        print(f"Page title: '{title}'")

        if "example domain" in title.lower():
            print("SUCCESS: Correct page title found!")
            success = True
        else:
            print(f"FAILURE: Unexpected page title: '{title}'")

    except WebDriverException as e:
        print(f"WebDriverException occurred: {e}")
        if "net::ERR_CONNECTION_REFUSED" in str(e) and os.environ.get("EFFECTIVE_OS") == "wsl":
            print("Hint: This might be a WSL networking issue if trying to control a browser on the Windows host directly without proper setup.")
    except Exception as e:
        import traceback
        print(f"An unexpected error occurred: {e}")
        traceback.print_exc()
    finally:
        if driver:
            print("Quitting Chrome WebDriver...")
            driver.quit()
        if temp_profile_dir and os.path.exists(temp_profile_dir):
            try:
                shutil.rmtree(temp_profile_dir)
                print(f"Cleaned up temporary profile: {temp_profile_dir}")
            except Exception as e_cleanup:
                print(f"Error cleaning up temp profile {temp_profile_dir}: {e_cleanup}")
        
        print("--- Test Complete ---")
        if not success:
            print("TEST FAILED")
            return 1 # Indicate failure
        else:
            print("TEST PASSED")
            return 0 # Indicate success

if __name__ == "__main__":
    exit_code = run_selenium_test()
    sys.exit(exit_code)
```

## Great Success

BAM! And Bob's your uncle. Or Clippy's your wizard. Or whatever. It works. And
while magic ain't real, this is some pretty powerful incantations right here.
Pardon me if I don't quote Arthur C. Clarke, but we're getting there. Things
that are just beyond my reach have come into my reach. Mickey the Sorcerer's
Apprentice now has a willing mentor wizard just fixing those spells you're
trying to cast so you don't get a network bitstorm of brooms like Mickey did
when he tried automating browsers on his own.

Anyhow, vetting the code past Gemini, it had one more nit to pick:

**Gemini**: You got it. My nitpick was that the `mkPackage` derivation in your combined `flake.nix` (which is used by `nix run .`) would have failed because, unlike your `devShell`'s `shellHook`, its builder script didn't create a Python virtual environment and `pip install selenium webdriver-manager`. This meant the `python ${./test_selenium.py}` command within that builder would execute with a Python interpreter lacking these crucial, pip-installed dependencies, leading to a `ModuleNotFoundError`. Your fix, by adding the venv creation and pip install steps into the `mkPackage` builder, ensures that the `nix run .` execution context now correctly mirrors the `devShell`'s Python environment regarding these specific packages, resolving the discrepancy.

And so, the fully complete `flake.nix`:

```nix
{
  description = "Platform-specific Selenium test environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      # Define platform-specific configurations
      mkConfig = system: let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        isDarwin = pkgs.stdenv.isDarwin;
        isLinux = pkgs.stdenv.isLinux;

        # Common packages for both platforms
        commonPackages = with pkgs; [
          python3Full
          coreutils
          bash
          zlib
          gcc
        ];

        # Linux-specific packages
        linuxPackages = with pkgs; [
          chromedriver
          chromium
        ];

        # Platform-specific shell configuration
        mkShell = pkgs.mkShell {
          name = "selenium-poc-devshell";
          packages = commonPackages ++ (if isLinux then linuxPackages else []);
          shellHook = ''
            echo "Standalone Selenium POC Dev Shell"
            
            test -d .venv || ${pkgs.python3}/bin/python -m venv .venv
            export VIRTUAL_ENV="$(pwd)/.venv"
            export PATH="$VIRTUAL_ENV/bin:$PATH"
            
            ${if isLinux then "export LD_LIBRARY_PATH=\"${pkgs.lib.makeLibraryPath linuxPackages}:$LD_LIBRARY_PATH\"" else ""}
            
            pip install --upgrade pip
            pip install selenium webdriver-manager
            
            export EFFECTIVE_OS="${if isDarwin then "darwin" else "linux"}"
            echo "EFFECTIVE_OS for manual testing: $EFFECTIVE_OS"
            echo "Run: python ./test_selenium.py"
          '';
        };

        # Platform-specific package configuration
        mkPackage = pkgs.stdenv.mkDerivation {
          name = "run-selenium-poc";
          buildInputs = commonPackages ++ (if isLinux then linuxPackages else []);
          builder = pkgs.writeShellScript "run-selenium-test.sh" ''
            source $stdenv/setup
            set -e o pipefail

            echo "--- Starting ${if isDarwin then "Mac" else "Linux"} Selenium Test Runner ---"

            # Set up PATH for Nix-provided tools
            export PATH="${pkgs.python3Full}/bin:${pkgs.coreutils}/bin:${pkgs.bash}/bin:$PATH"
            ${if isLinux then "export PATH=\"${pkgs.chromedriver}/bin:${pkgs.chromium}/bin:$PATH\"" else ""}
            ${if isLinux then "export LD_LIBRARY_PATH=\"${pkgs.lib.makeLibraryPath linuxPackages}:$LD_LIBRARY_PATH\"" else ""}

            export EFFECTIVE_OS="${if isDarwin then "darwin" else "linux"}"
            
            # Create a temporary working directory
            WORK_DIR=$(mktemp -d)
            cd "$WORK_DIR"
            
            # Create and activate a temporary virtual environment
            echo "Creating temporary Python virtual environment..."
            ${pkgs.python3Full}/bin/python -m venv .venv-runner
            source .venv-runner/bin/activate
            
            # Install required Python packages
            echo "Installing Python dependencies..."
            pip install --upgrade pip
            pip install selenium webdriver-manager
            
            # Run the test script
            echo "Running Selenium test..."
            python ${./test_selenium.py}
            
            # Create output directory and copy script
            mkdir -p $out/bin
            cp ${./test_selenium.py} $out/bin/standalone-selenium-test
            chmod +x $out/bin/standalone-selenium-test
          '';
          phases = [ "installPhase" ];
          installPhase = "$builder";
        };

      in {
        packages = {
          default = mkPackage;
          testBrowserSelenium = mkPackage;
        };
        apps = {
          default = flake-utils.lib.mkApp { drv = mkPackage; };
          testBrowserSelenium = flake-utils.lib.mkApp { drv = mkPackage; };
        };
        devShells = {
          default = mkShell;
        };
      };

    in
    flake-utils.lib.eachDefaultSystem (system:
      mkConfig system
    );
} 
```

1. **The Platform-Specific Challenge**
   - While Nix promises "works on my machine" reproducibility, browser automation reveals platform-specific complexities
   - macOS and Linux handle browser binaries, drivers, and system libraries differently
   - The `find-browser` script became crucial for handling these differences

2. **The Power of Environment Variables**
   - `EFFECTIVE_OS` became a key abstraction layer
   - Allows Python code to make platform-specific decisions without direct OS detection
   - Enables consistent behavior across platforms while respecting their differences

3. **Smart Package Management**
   - Common packages (`python3Full`, `coreutils`, etc.) work everywhere
   - Linux-specific packages (`chromedriver`, `chromium`) only included on Linux
   - Conditional inclusion prevents evaluation errors on macOS

4. **The WebDriver Manager Solution**
   - On macOS: Uses `webdriver-manager` for automatic ChromeDriver management
   - On Linux: Uses system-provided `chromedriver` from Nix packages
   - This dual approach handles platform-specific driver requirements

5. **Temporary Profile Management**
   - Both platforms need proper cleanup of temporary Chrome profiles
   - The Python code handles this consistently across platforms
   - Prevents profile-related issues that can occur on both systems

6. **Library Path Handling**
   - Linux requires explicit `LD_LIBRARY_PATH` settings
   - macOS handles library paths differently
   - Conditional path setup in the flake prevents conflicts

7. **The Unified Approach**
   - Single Python script works on both platforms
   - Platform-specific logic is handled at the Nix level
   - Python code remains clean and focused on the test logic

8. **Error Handling Improvements**
   - Better error messages for platform-specific issues
   - WSL-specific error handling for Windows users
   - Consistent cleanup in the `finally` block

9. **The Nix Advantage**
   - Despite platform differences, Nix still provides value
   - Consistent Python environment across platforms
   - Reproducible package versions
   - Unified development experience

10. **Future Considerations**
    - WSL support could be added with minimal changes
    - Additional browser types could be supported
    - CI/CD integration would be straightforward

This journey demonstrates that while Nix can't completely eliminate platform differences, it provides a powerful framework for managing them. The key is to embrace these differences while maintaining a consistent interface for developers.

---

## AI Analysis

**Title/Headline Ideas & Filenames:**

* **Title:** Cross-Platform Browser Automation: Selenium, Nix Flakes on macOS & Linux
    **Filename:** `cross-platform-browser-automation-selenium-nix-flakes-macos-linux.md`
* **Title:** Unified Dev Environments: A Nix Flake Solution for Selenium on Mac and Linux
    **Filename:** `unified-dev-env-nix-flake-selenium-mac-linux.md`
* **Title:** Bridging the Gap: Making Selenium Browser Tests Work on macOS and Linux with Nix
    **Filename:** `selenium-browser-tests-macos-linux-nix-flakes.md`
* **Title:** Nix Flakes as `normalize.css` for Dev: Selenium Automation on macOS & Linux
    **Filename:** `nix-flakes-normalize-dev-selenium-macos-linux.md`
* **Title:** From NixOS to macOS: Evolving a Selenium Nix Flake for Cross-Platform Testing
    **Filename:** `selenium-nix-flake-nixos-macos-cross-platform.md`

**Strengths and Weaknesses Analysis:**

**Strengths:**

* **Practical Cross-Platform Solution:** The article presents a working, non-trivial solution for a common pain point: getting browser automation to work consistently across different OSes (macOS and Linux) using a sophisticated environment manager (Nix Flakes).
* **Clear Evolution:** It shows the progression from a Linux-only solution to a multi-OS one, highlighting the specific changes needed (e.g., use of `webdriver-manager` on macOS).
* **Code-Centric:** Provides the full `flake.nix` and Python script, allowing readers to directly use and understand the implementation.
* **Addresses OS Differences:** Explicitly tackles how macOS and Linux differ in terms of WebDriver management and how the Nix Flake and Python script adapt.
* **Reproducibility Goal:** Stays true to the Nix philosophy of creating reproducible environments, even when dealing with external host OS components like browsers.

**Weaknesses:**

* **Complexity for Beginners:** While the solution is elegant for those familiar with Nix, the `flake.nix` itself and the concepts of platform-specific package inclusion might still be a steep learning curve for developers new to Nix. The article assumes a fair amount of Nix knowledge to fully appreciate the nuances.
* **`find-browser` Script Robustness:** The `find-browser` script, while functional for common cases, might not cover all edge cases for browser installations across all Linux distributions or more customized macOS setups without user-set environment variables. Its reliance on `command -v` for Linux might not always pick up browsers installed via less common methods if not in `PATH`.
* **WSL2 Tease:** The `find-browser` script includes stubs for WSL2, but the provided working example and discussion primarily focus on macOS and Linux. Full WSL2 testing and any necessary adjustments (especially around `msedgedriver` or Windows path handling by `webdriver-manager`) are implied as future work.

**AI Opinion:**

This article is a valuable contribution for developers navigating the complexities of cross-platform development and automation, especially within the Nix ecosystem. It demonstrates a practical and sophisticated approach to achieving consistent browser automation (Selenium) on both macOS and Linux by intelligently leveraging Nix Flakes for environment and dependency management, while adapting to OS-specific needs like WebDriver sourcing.

The solution's elegance lies in how it abstracts platform differences within the Nix Flake and conditional logic in the Python script, allowing the core automation task to remain largely platform-agnostic. The use of `webdriver-manager` for macOS is a pragmatic choice. While the setup is intricate, it reflects the inherent challenges of true cross-platform reproducibility when interacting with host system components like browsers. This is a strong example of "Nix as `normalize.css` for development directories," tackling a difficult problem head-on. It's a solid piece for those already invested in or looking to adopt Nix for serious cross-platform projects.
