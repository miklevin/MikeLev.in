---
title: It's All About the Clients
permalink: /its-all-about-the-clients/
description: 
layout: post
sort_order: 1
---

Plan every day like an adventure. Lean into your Ikagi. Practice strengthening
against your weaknesses. Learn and use names. Make associations. Let your mind
go into the needs of the clients you're servicing. Empthize with them and
imagine what they would be lookng to you for. This is what will illuminate your
path today so you can get out of it what you need for ikagai alignment, and they
can get what they need in terms of Clients. Don't get lost in the weeds or fall
down the rabbit holes. Look at your calendar.

It's a busy day, but you've still got a couple of hours before the meetings
begin. Get your client-oriented thoughts together, and also get your big-picture
and daily workflow thoughts together. You are forming new daily habits. You are
developing new muscle memory. Let this screen and this writing guide you. Don't
shy away from using the second screen on the Mac when you're in the office.
They're so easy to plug into, and it's only at the expense of a little bit of
effing-with your muscle memory. Macs, ugh! It's just like having to deal with
their renaming and moving of the alt key to option. Ugh!

Anyway, when you're in the office, you're on Macs all day, and that's got to be
okay. It's got to be okay for a few reasons. You've really got to lean into its
strengths, but in such a way as it doesn't rewire you back to Mac. Bring as much
as you can about your NixOS environment here to the office. For example, I now
have a Nix Flake in the repo that is my daily blog and public website (this). I
therefore can carry around my whole own home vim environment here. I would just
need to also my nixos repo here and in the same relative location so that the
helper scripts will activate. That will be a big boon even here and now as my
new leader-key macro system will be back instead of the @buffer approach I used
to use&#151;because vim vs. nvim and being able to get AI help on `init.lua`. Oh
that's a story for another time.

Your muscle memory needs resiliency, but not that much. That's a good use of
some of your precious valuable time right now. Go!

Ugh! The trick to not "getting lost" is to have this very daily blog entry open
full-screen and on screen 1 of the ribbon of virtual destkops. Here on the Mac
that's a challenge because it keeps rearranging the virtual desktops. The Mac is
the most insulting thing ever to muscle memory, if you're trying to keep
yourself generic and flexible in the industry. I fight Mac every time I get on
one. It is like a battle for your habits. Okay, try that again. Get this to be
my NixOS vim and not the brew installed one...

Okay, the repo is `nixos-config` and not `nixos`. I guess that makes sense to
avoid confusion with the command name. A couple of rules to help myself out when
I'm on the Mac. This daily work journal full-screen on screen 1 is no
compromise/no-undermine. For example, don't open new Terminal tabs in such a way
that this journal can get lost. It's always full-screen. It's always the only
thing on that screen. And it's always what should be on screen 1 (reshuffle
often to reset that). In this way, you always have at least 1 fixed-location,
even on a Mac.

This is all about forced-flow-state, even when on the Mac, even when in the
office looming over ground zero. And even with a day full of meetings that
you're only half prepared for. Recover, reset, initialize! Go! Clone
nixos-confg... done. But I can't resist naming it `~/repos/nixos/`. It's just
such a stronger identity.

    git clone git@github.com:miklevin/nixos-config nixos

Okay, now a few quick chisel-strikes. First, you need to put the nixos config
that you use into the flake that you use in your `~/repos/MikeLev.in/flake.nix`

Me: @flake.nix @configuration.nix I need the nvim environment expressed in
configuration.nix to also exist in flake.nix. Specifically, I need nvim
installed on `nix develop` and I need the custom path to where it finds
`init.lua` to be to the Mac's path equivalent of `~/repos/nixos/init.lua` that
will work in a nix flake. In other words, I want the same nvim enviornment on
the Mac as I have on NixOS.

**Claude**: I'll help you modify your `flake.nix` to include Neovim with the same configuration. Here's how we can update it:

```nix
{
  description = "Nix flake for Jekyll environment with Rouge for syntax highlighting";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            # ... existing packages ...
            pkgs.ruby
            pkgs.bundler
            pkgs.jekyll
            pkgs.rubyPackages_3_2.rouge
            # Add neovim
            pkgs.neovim
          ];

          # Update shellHook to set up neovim configuration
          shellHook = ''
            # Create necessary directories
            mkdir -p ~/.config/nvim

            # Create symlink to init.lua
            # Using $HOME ensures this works on both Linux and macOS
            ln -sf $HOME/repos/nixos/init.lua ~/.config/nvim/init.lua

            # Original messages
            echo "Jekyll and Rouge environments are ready."
            echo "Use: jekyll serve --livereload"
            echo "Use: rougify style monokai.sublime > assets/css/syntax.css"
          '';
        };
      });
}
```

Key changes made:
1. Added `pkgs.neovim` to `buildInputs`
2. Updated the `shellHook` to create the Neovim configuration directory and symlink
3. Used `$HOME` instead of hardcoding the path to make it work cross-platform

This setup assumes that:
1. You have the same repository structure on your Mac (`~/repos/nixos/init.lua`)
2. You want the same init.lua file to be used

When you run `nix develop`, it will:
1. Make Neovim available in the shell
2. Set up the symlink to your init.lua file
3. Use the same configuration as your NixOS setup

Note: Make sure the `~/repos/nixos/init.lua` file exists on your Mac before running `nix develop`, or modify the path in the shellHook to point to the correct location of your init.lua file.

Okay Mike, do this! Be brave. A new symlink on your Mac to get a nvim default to
load easily... go! Okay, nix develop, quit in this terminal load in that
terminal... Okay! I have my leader key macros. OMG, I can even use Function keys
on the Mac with this funky little Macbook touch-led keyboard thing. I just have
to ***hold the `fn` key down*** and the virtual keys appear. Okay, ***remember
that***.

Have a plan for all the things that are going to be done, not disappointing
anybody and not disappointing myself. And that means putting this sort of
strategic thinking in on the client issues, and real soon now too, and somewhere
other than the public work journal, haha! I share a certain amount here based on
the Robert Cialdini principle of commitment and consistency. Tell a story and
commit yourself to that story and it becomes real. We do that anyway in our
lives, so why not do it as a self-improving life-hack with intentionality and
ambition?

Yup, okay, so the visual theme of nvim on Mac is inconsistent with the visual
theme on NixOS.

Okay, that worked! But there's a difference in vim between my NixOS version at
home and the one on the Mac. Specifically, the NixOS version which uses the
unstable branch uses squiggly lines under misspellings and a much softer color
palette. In `set:spell` mode on the Mac, the misspellings are red background and
much more harsh.e: Okay, that worked! But there's a difference in vim between my
NixOS version at home and the one on the Mac. Specifically, the NixOS version
which uses the unstable branch uses squiggly lines under misspellings and a much
softer color palette. In `set:spell` mode on the Mac, the misspellings are red
background and much more harsh. I'm sure this must be talked about as "a thing"
online, but how can we easily fix that here, if easily? If not easily, then
forget it. I won't jump down the rabbit hole.

Haha, it was up to position 300 in the Cursor AI slow wait queue this morning.
Tuesday morning coming on 10:00 AM early in November. Take note, this is one of
those things you "feel" about the state of the world. Coders who pay $20/mo for
a code assistant are very demanding of them in this time.o

Claude: The difference you're seeing is likely because your NixOS system is using `nixos-unstable` while your flake is using `nixos-23.05`. We can easily switch the flake to use the unstable branch by updating the nixpkgs input:

```nix:MikeLev.in/flake.nix
{
  inputs = {
    # Change this line to use unstable instead of nixos-23.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    // ... rest of inputs ...
  };
  // ... rest of file ...
}
```

This should give you the same version of Neovim as your NixOS system, including the spell-checking appearance. If you run `nix flake update` followed by `nix develop`, you'll get the newer version.

If this doesn't solve it, then it might involve deeper Neovim configuration differences, which as you suggested, might not be worth the rabbit hole journey!
