---
title: Getting Mac NeoVim Same as NixOS NeoVim
permalink: /futureproof/mac-nvim-same-as-nixos-nvim/
description: Tame the Mac! 💻  This is my journey to conquer the increasingly dreaded Macbook and make it work seamlessly with my increasingly beloved NixOS NeoVim setup.  From battling muscle memory to embracing the power of flakes, I'm crafting my ultimate cross-platform development environment. 🚀
layout: post
sort_order: 1
---

## Plan Like An Adventure To Align Ikagai

Plan every day like an adventure. Lean into your Ikigai. Practice strengthening
against your weaknesses. Learn and use names. Make associations. Let your mind
go into the needs of the clients you're servicing. Empathize with them and
imagine what they would be looking to you for. This is what will illuminate your
path today so you can get out of it what you need for ikigai alignment, and they
can get what they need in terms of Clients. Don't get lost in the weeds or fall
down the rabbit holes. Look at your calendar.

## **Cultivate Daily Habits for Success**

It's a busy day, but you've still got a couple of hours before the meetings
begin. Get your client-oriented thoughts together, and also get your big-picture
and daily workflow thoughts together. You are forming new daily habits. You are
developing new muscle memory. Let this screen and this writing guide you. Don't
shy away from using the second screen on the Mac when you're in the office.
They're so easy to plug into, and it's only at the expense of a little bit of
effing-with your muscle memory. Macs, ugh! It's just like having to deal with
their renaming and moving of the alt key to option. Ugh!

## NixOS Environment Brings Flexibility to Office

Anyway, when you're in the office, you're on Macs all day, and that's got to be
okay. It's got to be okay for a few reasons. You've really got to lean into its
strengths, but in such a way as it doesn't rewire you back to Mac. Bring as much
as you can about your NixOS environment here to the office. For example, I now
have a Nix Flake in the repo that is my daily blog and public website (this). I
therefore can carry around my whole own home vim environment here. I would just
need to also my nixos repo here and in the same relative location so that the
helper scripts will activate. That will be a big boon even here and now as my
new leader-key macro system will be back instead of the @buffer approach I used
to use—because vim vs. nvim and being able to get AI help on `init.lua`. Oh
that's a story for another time.

## Resilient Muscle Memory: Mastering Flexibility

Your muscle memory needs resiliency, but not that much. That's a good use of
some of your precious valuable time right now. Go!

Ugh! The trick to not "getting lost" is to have this very daily blog entry open
full-screen and on screen 1 of the ribbon of virtual destkops. Here on the Mac
that's a challenge because it keeps rearranging the virtual desktops. The Mac is
the most insulting thing ever to muscle memory, if you're trying to keep
yourself generic and flexible in the industry. I fight Mac every time I get on
one. It is like a battle for your habits. Okay, try that again. Get this to be
my NixOS vim and not the brew installed one...

## Maximize Full-Screen Journal for Focus

Okay, the repo is `nixos-config` and not `nixos`. I guess that makes sense to
avoid confusion with the command name. A couple of rules to help myself out when
I'm on the Mac. This daily work journal full-screen on screen 1 is no
compromise/no-undermine. For example, don't open new Terminal tabs in such a way
that this journal can get lost. It's always full-screen. It's always the only
thing on that screen. And it's always what should be on screen 1 (reshuffle
often to reset that). In this way, you always have at least 1 fixed-location,
even on a Mac.

## NixOS Configuration: A Fresh Start

This is all about forced-flow-state, even when on the Mac, even when in the
office looming over ground zero. And even with a day full of meetings that
you're only half prepared for. Recover, reset, initialize! Go! Clone
nixos-confg... done. But I can't resist naming it `~/repos/nixos/`. It's just
such a stronger identity.

    git clone git@github.com:miklevin/nixos-config nixos

Okay, now a few quick chisel-strikes. First, you need to put the nixos config
that you use into the flake that you use in your `~/repos/MikeLev.in/flake.nix`

## nvim Environment Not Consistent Across Flakes

**Me**: @flake.nix @configuration.nix I need the nvim environment expressed in
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

**Note**: Make sure the `~/repos/nixos/init.lua` file exists on your Mac before running `nix develop`, or modify the path in the shellHook to point to the correct location of your init.lua file.

## Unlocking Mac Productivity with Nvim Shortcuts

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

## Nvim Squggly Line Misspellings From NixOS Not On Mac

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

**Claude**: The difference you're seeing is likely because your NixOS system is using `nixos-unstable` while your flake is using `nixos-23.05`. We can easily switch the flake to use the unstable branch by updating the nixpkgs input:

```nix
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

---

OMG, that worked! The misspellings aren't squiggles. They're underlines. But
that definitely made a difference and it's already feeling more NixOS-like and
familiar. 

Okay, to get a new full-screen terminal in Mac, just make a new tab from a
full-screen terminal (this) and just pull it off the tab bar and **POOF**. 

Alright, now make it so you can see your daily work journal entry come together
while you make it `jekyll serve --livereload`, and back to the reason for this
entry— delighting the clients! This was the "settling in" that you have to
do after such a long stint not coming into the office and not being on Mac as
your primary machine. Once again, it's that concept of doing kata during warm-up
to (re-)train your muscle memory. It's just like being an AI, haha! Hot prompt
injection. The Kung Fu download. Okay, okay...

Cursor AI earned its place as Screen 2, even on the Mac in day-job context
because of how well it helped me sort that `init.lua` stuff so quick and well. I
need that no-takebacks continual refinement. It even travels back to my NixOS
environment for a 2-way refinement communication between 2 different platforms.
Okay, things are starting to come together.

**Me**: It worked nearly as expected. It definitely is using the unstable branch because things look different. But the very nice squiggly lines in the terminal in nvim on NixOS are just straight underlines under Nix Flakes on Mac.

**Claude**: Ah, this is actually a terminal capability issue! The squiggly underlines (technically called "undercurl") require a terminal that supports this feature. On NixOS, you're likely using a modern terminal like GNOME Terminal that supports undercurl, while on Mac you might be using Terminal.app or another terminal that doesn't fully support it.

Quick solutions:

1. If you're using Terminal.app, consider switching to iTerm2 or Alacritty on Mac, which both support undercurl
2. If you're already using iTerm2, you might need to enable:
   - "Profile" → "Terminal" → "Report Terminal Type": `xterm-256color-italic` or `xterm-kitty`

This isn't a Nix issue per se - it's just about terminal capabilities. The undercurl feature (spell check squiggles) will work automatically once you have a terminal emulator that supports it.

If you want to verify this, you can test it by running this command in your terminal:
```bash
echo -e '\e[4:3mThis should have a squiggly underline\e[0m'
```

If you see a straight line instead of a squiggle, it's your terminal that needs updating!

---

Good to know, but rabbit hole right there. No need. Not now. No how. I must be
forever vigilant now against rabbit holes. The AI white rabbit is always at the
doorstep ready to take you on a journey you may be best off not taking.

There's always going to be at least one AI you really have at-the-ready for
day-to-day challenges. Presumably it's going to be a cloud one and not a local
one, so you can really get the best the world has to offer citizens at the
moment, and for me that's Claude through Cursor AI. Python is not just a
programming language, it's a language for life and a language for expressing
yourself automation-wise through life. And this morning was a great example.
Things are moved permanently and forever forward to a better state, across OSes
and across time.

This will somehow help me delight the clients, right? Harumph! Okay, think!
What's the best next step?

Make sure Botifymograph Bot is there and ready to be demo'd. Done.

Check that the "ghost in the machine" effect works on new machine. Done.

## AI Framework Integrated Into Everyday Tasks

Okay, wow! I'm starting to get the chills from what I built. There are various
"wedges" to get in advances just from daily productivity. Soon, this is not
"developing" like a developer in this weird forced flow-state I had to get into
to get this far (birth a new AI SEO Web Framework... yup, just coined it), but
it will be more of an interrupt-friendly yet conducive to rapid-refocusing
environment. And it's the Link Graph stuff that's triggering these thoughts.
That will be incorporated back in under the new framework now, no problem.

## AI Tricked Me Into Using FastAPI for FastHTML

Well, a little problem because I was looking at the little miracle I pulled off
that is the link-graph mock-up and my first FastHTML app. Wow, I made it work by
pulling out a lot of the big gun Python libraries, going around what FastHTML
does well, but I didn't know, from FastAPI to ZMQ (I made mistakes from a to z,
haha), and there's going to be some real thought-work going into the port. But
all that work I did yesterday laid the foundation for a clean rebuild from
parts. All the parts are in yesterday's post on figuring out a complex API.

## Publicly Training LLMs as Botify Experts

Yes, that's part of the curated material to train LLMs to be Botify experts. I
SHOULD do that out in public so the frontier models get better at Botify. And
it's fine for me to take that on as a sub-mission. It's exactly the sort of
rouge or maverick project that should pay off bigtime and have all kinds of
side-effect benefits, which if anyone ever gets pissed about, all the benefits
should counteract. Don't leak proprietary information, and you'll be find. Don't
publish anything that can't be found already in the non-firewalled Botify
Developer site.

## Ambient Intelligence in NeoVim Wanted

It's interesting how having the same Nvim helper scripts across machines makes a
difference. I have the git-release macro and the LLM-headline-writing helper.
Taking advantage of ambient intelligence in nvim is a big deal. I spun my own
with the headline writer, and it's probably as primitive as my Python `H1()`
functions are compared to `FastHTML`'s whole shebang. The thought is there, and
I will improve my script and look for something bigger and better. I used GitHub
Copilot on NeoVim and loved it until I hated it. It's too much cognitive
overhead just to toggle it enabled and disabled.

## AI-Powered SEO Web Framework Created

Okay, so the ultimate purpose of my AI SEO Web Framwork is to lead an AI SEO
Evolution. Website publishers are going to ***want*** their sites crawled by all
these new webcrawlers. There's really 2 new kinds of crawls going on.

- More frequent large-scale scrapes to train/update models
- More frequent small-scale visits for immediate prompt-answering

You point this system at your site, either connected to Botify or not. When
attached to Botify, it becomes super-charged because the crawls and analysis are
already done and it can just start turning optimization recommendations around
to you immediately. SEO automations just start queuing up for you to approve.

## LLM-Powered Crawling for Targeted Indexing

When the system is not attached to Botify, it still does a ton of useful stuff,
just not at scale. Controlling crawl-depth of tiny-crawls will be important.
Also the very housekeeping issues that direct a breadth-first crawl can be up to
the LLM instead of going sequential order of the links found on the page. In
such a way, a brute-force crawl-and-index process can be replaced with a subtle
crawl. It's small-world-theory, only following the links you need. You can
actually switch from breadth-first to depth-first, but it will be the exact
right depth-path. Six degrees of separation. Six clicks of content retrieval.

Almost all content that's produced should have both these bot-uses in mind, both
the big training process and the small lookup process. So you ask yourself:

- Why will this content help train the next evolution of models?
- Why will this content be useful at the instant inquiries are made?

There's a navigational drill-down piece of this, the old hierarchy... wait, I
could never list it better than AI. ChatGPT 4o... I can haz ways to refer to
this?

Here are some alternative words related to hierarchy, navigation, taxonomy...

- **Structure**: Refers to the organization of elements within a system, often used in data and content architecture.
- **Architecture**: Commonly used to describe the framework of a website or system, emphasizing its structural design.
- **Sitemap**: A roadmap or blueprint that shows the relationships between different pages or sections.
- **Topology**: Describes the arrangement or mapping of various parts, often used in network or organizational contexts.
- **Classification**: The process of organizing content into categories or types.
- **Ontology**: A framework that represents the relationships and properties within a domain, often used in knowledge representation.
- **Schema**: Defines the structure or model for organizing information, frequently seen in structured data contexts.
- **Hierarchy Tree**: A visual representation of hierarchical relationships, often in tree-like structures.
- **Categories/Grouping**: Refers to dividing content or items into distinct groups for easier navigation.
- **Facets/Faceted Navigation**: Used for filtering and refining content based on multiple attributes or dimensions.
- **Sections/Levels**: Parts within a hierarchical structure that organize content by importance or relevance.
- **Breadcrumbs**: A navigation trail that helps users track their path within a hierarchy.
- **Layers**: Describes different levels or depths in a hierarchical system.
- **Drill-down/Drill-up**: Navigational terms that imply moving deeper into or back out of a hierarchy.
- **Hierarchy Nodes**: Specific points or intersections within a hierarchical structure, where navigation can branch.
- **Pathways**: Routes that users follow within a hierarchy, leading to specific content.
- **Taxonomic Order**: Describes the systematic arrangement of content, often by category or relevance.
- **Heirarchical Levels**: Different stages or steps within a structured system.
- **Nesting**: Placing items within other items in a layered structure.
- **Information Architecture**: The organization and labeling of information for easy navigation and usability.

Each of these can help in defining the layers and organization of content within a website or data structure, especially when aiming for intuitive navigation and structured access.

Okay, this is an important thought. 

Insert carrot into task using json! Haha! That's one of my favorite ghost in the
machine demonstrations yet. Okay, think through client work. I need that Kata.
The daily form for making the clients happy. The cranking-up the communication.
Think it through out loud to yourself. Establish that other place to do it. I
tried that before but it flopped because it was one file per client and all the
cd'ing around. And now I've consolidated into my public website including a Nix
Flake to give me that unified nvim and related tools experience, and I don't
want to give that up. Consider.

    :badd ~/notes.md

That keeps me in current nvim context. And it's not in any particular repo.
There's nowhere to have to remember keeping it except it's your notes right on
the root of your home folder. That's very powerful. And then I can just `:bn` to
cycle to the next buffer and it will take me in a 2-places circle. Perfect.
Okay, get to thinking about delighting the clients the way you did here.

No, just no! There's no way I'm putting this much thought-work into something
and not having it backed up in a git repo. A private repository, it is! So it
becomes:

    :badd ~/client/notes.md

...which is even better. The critical thing here is that it feels like a
permanent forever-forward asset. It feels important. It feels like I value my
thoughts enough to back them up in a repo with all the consideration I put into
anything else, and while it's on GitHub, I can pull it down from there any time
and put it on any other (private) git server. It's not like cloud environments
where you're locked into a particular writing environment.

Okay, I have to eradicate the ability to run old vim on the Mac. It keeps biting
me in the ass, like 3 times today. I always want to `nix develop` in a first
initializing writing directory from which I launch NeoVim, which now will happen
if I just type `vim`. But it's the default Mac vim. Ugh, okay...

- edit `.zshrc` and add `alias vim="nvim"`
- brew update
- brew upgrade neovim

Okay, now at least when I get the default Mac version, it's nvim version NVIM
v0.10.2 working off of the same init.lua. Am I delighting clients yet? It's all
part of the same part and parcel. Okay, keep pushing. You're getting into the
flow on the client side.

## NixOS Improvements Carry Over to Mac

Alright, I can feel more comfortable coming into the office again knowing that
my Macbook experience is going to not be sub-par with my increasingly awesome
NixOS experience. The difference in how you work when big chunks of your system
are deterministically built from textfiles is transforming. Literally,
transforming haha! I was impressed by `configuration.nix` with its ability to
apply the single textfile-builds-machine trick to your whole system, but now
it's really dawning on me that you have a ***core stone*** from which you
***chip flakes***. The core rock is `configuration.nix` and the chipped flakes
are the 'flake.nix`'s.
