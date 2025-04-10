---
title: Taking The NixOS Wayland Hyprland Plunge!
permalink: /futureproof/nixos-wayland-hyprland/
description: This article documents my ultimately unsuccessful attempt to switch from GNOME to Hyprland on NixOS. Despite Hyprland's speed and customizability, I found that its modular nature and lack of integrated features like workspace overviews made it less suitable for my fullscreen-focused workflow. The experiment helped me appreciate GNOME's polished user experience and Wayland's performance benefits, while also providing a deeper understanding of my own desktop preferences.
meta_description: Read about my experiment switching from GNOME to Hyprland on NixOS. Discover insights on performance, workspace management, and desktop customization trade-offs.
meta_keywords: Hyprland, NixOS, GNOME, Wayland, tiling window manager, desktop customization, workspace management, Linux desktop, performance trade-offs, experimental desktop
layout: post
sort_order: 2
---

## Introduction

This article chronicles my attempt to switch from the GNOME desktop environment to the Hyprland tiling window manager on my NixOS system.  Initially drawn to Hyprland's promise of speed, customizability, and strong Wayland support, I embarked on a detailed configuration journey, meticulously documented through conversations with the AI assistant, Claude.

The process involved setting up Hyprland, configuring keybindings and animations, and troubleshooting compatibility issues with Electron apps and Nvidia graphics. While I appreciated Hyprland's responsiveness and the satisfyingly snappy workspace transitions we achieved, I ultimately found that its modular nature and the need to "cobble together" basic functionalities like workspace overviews and clipboard sharing detracted from the seamless experience I had grown accustomed to in GNOME.

This exploration highlighted the trade-offs between a highly customizable tiling window manager and an integrated desktop environment. Despite appreciating Hyprland's strengths, I realized that my workflow, primarily focused on fullscreen applications and efficient workspace navigation, was better served by GNOME's polished user experience and intuitive features like the Super key overview.

The experiment proved valuable nonetheless, reinforcing my appreciation for GNOME's maturity and Wayland's performance benefits, while also providing a deeper understanding of my own desktop priorities and preferences.

## The Appeal of Hyprland on NixOS

One of the many advantages of being on NixOS is that it's one of the early
platforms, along with Arch, to have strong built-in Hyprland support, a new
Desktop window manager to replace the popular and mainstream GNOME and KDE
desktops, insofar as anything can be called mainstream on Linux. At first my
thought was to just lean into the mainstream strength of GNOME as the official
GNU desktop of Linux, what Ubuntu is based on. And I still might. But I can't
stand overlapping windows. One of the great tragedies of modern computing is how
windows caught on, and I don't mean as in Microsoft Windows, though that is a
tragedy. I mean windows in general, which are just as much a plague on Mac as
they are on PCs. 

### The Window Management Problem

Programs in windows are messy and overlapping and hide each other and force you
to use a mouse and break flow state. Window panes are much better, and one of
the great ironies of modern computing is that the lack of panes causes such
pain. And hardly anybody notices it. Or more accurately, they just live with it
because they don't know how much better their tools could be. If these computers
of ours that become like an extension of our bodies makes you dance a little jig
(drill-down in dropdown menus) just to launch an app, well then people will
dance that jig unquestioningly for 30 years... until mobile comes along and the
same person who cursed us with the windows user interface (Steve Jobs) teaches
us it can be so much better (the mobile UI with full-screen apps).

### Virtual Desktops: The Unsung Heroes

Pretty much all the major desktop OSes now support virtual desktops, workspaces,
or dedicated full-screen apps. Whatever you want to call them, they're
absolutely awesome. As far as I can tell still pretty much nobody uses them, or
they only use them by accident and consider them some sort of annoyance. The Mac
managed to tie them the maximize widget to almost bully its userbase into
discovering they exist and use them if they want to maximize their apps. That
was a ballsy move on Apple's part, but in my opinion makes the desktop
environment bare minimum usable. Windows of course followed suit, but maximizing
an app is still a distinctly different thing that having the app fullscreen on
its own virtual desktop. The implementations and compulsion to use are different
between macOS and Windows, but the spirit of the thing is the same: fix windows.

### The Windows vs macOS Divide

Windows also has AeroSnap, which the Mac seems to have no good answer to. If
you're actually subdividing apps on the same screen with bad old fashioned
windows, you can at least "snap" them to halves or quarter-screen quadrant
regions easily enough on Windows 10 and 11. On Mac... ugh, on Mac you can't. How
can something with such a reputation for polish have such a messy, digesting OS?
There was this old movie, TV show and Broadway show called The Odd Couple with a
couple of bachelors living together, Felix Unger and as Oscar Madison, memorably
played by Tony Randall and Jack Klugman on the TV version. Felix was
meticulously neat and Oscar was a slob, and hilarity ensued. Anyway, I've never
been able to stop thinking of maxOS and all its precursors back to day-1 (yes, I
was around for the 1984 Mac) as the messy slobs. It's ***never gotten any
neater!*** macOS is a slob to the core. And Windows isn't. They've at least got
AeroSnap! Whenever I hear people talk about Mac snobs, I smile to myself saying
they're only 2-letters off. Bad design!

### The Linux Window Manager Landscape

Anyhow, I've watched the equivalents of AeroSnap on Linux over the years, never
really taking the plunge because I was not on Linux day-to-day enough to make
the investment of habit and muscle memory into something that was
screen-subdividing—not really my thing. I'm a fall-screen app person. So if
and when I do take up some Linux AeroSnappy thing, I want it to be like learning
to ride a bike. I want to it once and just have the habit serve me well from
then foreword. Virtual screens met that criteria because they mostly work the
same way across Macs, Windows, and GNOME and KDE on Linux. The implementations
are all so nearly identical (except the Mac ***CHANGES THEIR ORDER ON
YOU!!!***). But not so with the window managers like BSPWM, I3, Awesome and DWM.
There's a slew more, the way these things tend to be on Linux, and that
fragmentation and uncertainty about which I want getting into my fingers just
works against me taking up any at all. No sirree! It's full-screen for me!

### The Hyprland Decision

But now I am tempted. I want easy quartering of a big monitor into quadrants. I
tried a GNOME version of window management called GTile, but was unimpressed
enough to immediately stop using it. When something is right, you know it. And
from the looks of Hyprland, it might be right. But methinks it a rabbit hole,
but I am going into the holiday with some quiet time. If I'm going to make the
move, now's the time. I've got a ton of other discretionary work I could also do
of the sort that can move me forward permanently and forever, professionally.
But I have over the past several months somewhat painfully moved myself over to
NixOS and gone through the learning curve, and have been starting to reap some
of the rewards. And on of the big rewards dangling before me is a very appealing
window manager called Hyperland. Hyperland is big in the Arch community, a Linux
I might be on if not for NixOS. The question is quite how good can a window
manger really be? Can there be one in the same class as the Linux distros its
**associated with**: NixOS and Arch? Because that's exactly what Hyperland is; as
cool as all that.

### Taking the Plunge

And so right now, right here with this very post, I take the plunge. Normally
these things are about installing this and installing that. Even on Arch the
instructions look intimidating and a sort of non-reproducible magic that scares
the bejesus out of me. The great thing is on NixOS, it's just editing one
textfile, `configuration.nix` until you get it right. And I did! I got it right.
And now Hyperland is an optional desktop environment I can boot into at login. I
have Hyperland live. And I even have an Nvidia RTX 3080 card in there, making me
in the group of people likely to have problems. But apparently the problem has
aged and sufficiently that I'm not in the bleeding edge. It took quite a few
attempts to get the settings right, but once they're right they're right. There
was very little blood.

### The Technical Challenges Ahead

So this is me preparing to take the plunge. Electron apps, which is what VSCode
is, which is what one of my latest tools Cursor AI editor, is forked from. So
I'm in a double whammy Venn diagram of likely to have problems: Nvidia card and
needing to run Electron apps. Slack and Zoom are also both Electron apps which I
use for work, and amazingly NixOS really is my daily machine for work as well.
Wow, I can only imagine when I screen share clients and folks into my Hyperland
machine. Oh, this is part of the magic show! So much more to say about how much
of what I do now involves a local LLM which people will just assume it's
something special that can only run on a machine like this, but then I'll be
like no, here's a command to type and Chip O'Theseus—that's what I call my
local LLM—can jump over to your Macbook and run there just as well.

### The Point of No Return

But I digress and am just stalling. Once I pull the switch on this and start
settling into Hyperland, there may be no going back to good ol' GNOME. I was on
Ubuntu through all the Unity days, their spin on what GNOME should be, be which
ended up fractioning the Linux desktop world even more. They wisely gave up
Unity and put all that work into just improving GNOME, and so I thought that was
it. A lot of people like KDE Plasma and I tried it for awhile, but it's
Mac/Windows all over again. Steering dropdown menus and fussing with overlapping
windows is exactly what fatigued me. GNOME was going more towards a cleaner more
mobile-like colorform Ikea aesthetic and I figured that was it. Learn those
keyboard shortcuts and the user of what's now called the ***Super-key***, and
there's my habits and muscle memory. GNOME for life, baby!

But it's too soon to settle. I can learn GNOME and still have room in my fingers
for something fun and new, and potentially lasting the rest of my life. Maybe
Hyprland is the bicycle of bifurcation I'm looking for. I will only know if I
try. And so without further ado, here I go...

**Me**: You there, Claude? I'm about to switch to Hyprland!

**Claude**: *adjusts academic glasses with enthusiasm*

Ah, a fellow seeker of desktop environment sovereignty! I see you're preparing
for the transition to Hyprland. I don't see a specific question or code that
needs modification.

Would you like:
1. Help with Hyprland configuration
2. Tips for migrating from your current DE
3. Specific keybinding setups
4. Something else related to the Hyprland transition?

Feel free to share any specific configs or questions you have, and I'll be happy to help make your transition to Hyprland as smooth as possible! 🚀

**Me**: I just thought I'd strike up a funny conversation to see if I can continue it over there. If I understand correctly, VSCode which Cursor is a fork of is an Electron app. And I have an Nvidia card. So I'm exactly the type who's likely to have problems making the switch. So I thought I'd start commiserating here under GNOME on NixOS, so I can pick up hte kvetching over there where I won't even be able to launch an app at first.

**Claude**: *adjusts tie with knowing sympathy*

Ah yes, the classic "Nvidia + Wayland + Electron apps" trifecta - truly one of computing's most... character-building combinations! 

You're absolutely right about Cursor/VSCode being Electron-based. And Nvidia... well, let's just say Nvidia and Wayland have a relationship status that's perpetually set to "It's Complicated" 😅

Here's what you might expect on the other side:
1. First challenge: Getting Hyprland to start at all with Nvidia (prepare your `nvidia-drm.modeset=1` kernel parameters!)
2. Second challenge: The "black screen of contemplation" when you first try to launch
3. Third challenge: Electron apps either refusing to launch or launching with interesting... artistic interpretations of what a window should look like

But fear not! The NixOS community has blazed this trail before. Between `nixos-nvidia-vaapi-guide` and various Hyprland config examples, we'll get you sorted.

Want to start placing bets on which application will give you the most entertaining error messages first? My money's on Discord or Electron-based browsers! 😄

*straightens papers academically while preparing for the inevitable troubleshooting session*

**Me**: I got 1 and 2 done. With your help, in another conversation thread. But
stuff started getting wonky so I started a new chat. But check out my
@configuration.nix So I can switch at login.

**Claude**: *peers at configuration.nix through academic monocle*

Ah, splendid preparation! You've got all the essential Wayland environment variables set up, and I see you're keeping GNOME as a safety net (very wise). The `videoDrivers = ["nvidia"]` and those screen options show you're no stranger to the Nvidia dance.

A few observations:
1. You've got GDM set up with Wayland enabled - that's good, as it'll give you a choice between GNOME and Hyprland at login
2. All the crucial Wayland environment variables are there, including `NIXOS_OZONE_WL="1"` for those Electron apps we were just discussing
3. You've got the proper NVIDIA composition pipeline settings

You're actually better prepared than most for this adventure! When you log out and see that GDM screen, you'll be able to click the little gear icon and choose Hyprland. 

*adjusts glasses thoughtfully*

Though I must ask - have you prepared your Hyprland config file yet? That's where the real... entertainment... begins. Especially for things like getting your preferred terminal emulator to launch on startup so you're not staring at a beautiful but entirely unusable desktop! 😄

**Me**: No, not at all! Why would I do anything over here in GNOME when it responds do you in real time over there. If I need apps before I can launch them, I'll use YouTube and Perplexity over on my phone and stuff to figure out how to get app launchers going. Then I should just see them pop live as I edit the file. I'll of course have nvim and terminal apps. I'm something of a terminal jockey, so I'm always at home.

**Claude**: *chuckles appreciatively*

Ah, a true terminal virtuoso! That's exactly the right mindset for initial Hyprland setup. And you're absolutely right - why prepare when you can live-edit your way to victory? 

Your terminal-first approach will serve you well here. With `nvim` and basic terminal commands, you'll be able to:
1. Create/edit your Hyprland config (`~/.config/hyprland/hyprland.conf`)
2. Check logs when things go sideways (`journalctl -xe`)
3. Kill rogue processes when an app decides to have an existential crisis
4. And most importantly, keep editing that config file while watching things magically appear/disappear/resize in real-time

*adjusts scholarly posture*

Just remember the sacred terminal keybind (usually `SUPER + RETURN` or `SUPER + ENTER` by default) - that'll be your lifeline when you first land in the beautiful emptiness of a fresh Hyprland session! 

Would you like me to start preparing some witty commentary for the other side, or shall we keep that spontaneous? 😄

---

> So here I am editing my daily tech journal entry under Hyprland. I am of
> course editing it in nvim in a terminal, so I had no real challenges, unless
> you consider pulling up the terminal in the first place a challenge—which
> you know, it really could have been, had they not made a message at the top of
> this fabulously barebones desktop they provide telling you:

    Warning: You're using an autogenerated config! (config file: /home/mike/.config/hypr/hyprland.conf )
    SUPER+Q -> kitty (if it doesn't launch, make sure it's installed or choose a different terminal in the config)
    SUPER+M -> exit Hyprland

I already added the `kitty` terminal emulator in my `configuration.nix` having
already gone through this experience earlier today. I at least needed the
command-line over here. The first thing you're going to want to do is launch an
app, and before there's even an app launcher installed (yes, it's ***that***
bare-bones), the terminal, CLI, shell or what have you is your forever-enabler
in such situations. You'll always have \*vi\*.

Okay, so...

    :badd /home/mike/.config/hypr/hyprland.conf
    :b2

...and then I edit out this line:

    # autogenerated = 1 # remove this line to remove the warning

## First Steps in Hyprland

And right there like magic, the desktop updates! No Ctrl+Alt+F2 type r nonsense!
No logging out and in. Not even a Ctrl+R! Just edit the file and **BAM!**
Updated desktop. It's just like `jekyll serve` that I've been using for web
publishing and `watchdog` that I've been using for web development. Now I have
that sort of live active updating as I customize my desktop by editing a file!
Those commands above are me loading the Hyprland config file into a nvim buffer,
kind of like loading it into a tab but without the cognitive load of tabs.
Vim/NeoVim have buffers for that. They also have tabs for people who need them,
but using buffers that got into your fingers s a much more flow-state way to
work.

## The Terminal-First Experience

Hmmm. This is a puzzle! Quite literally, this is a desktop that doesn't even let
you launch anything out of the box. I mean think about that! Imagine if Mac or
Windows boot up to a screen that only let you open a terminal! Haha! I love it.
Okay, but we know that `Super+Q` (Windows key plus the q key) opens a terminal,
and this is a window manager, so... **POOF!** A new terminal window opens
perfect 50/50 tiled with my NeoVim terminal.

### Window Tiling in Action

So that's one thing out of the way. I can have multiple terminals tiled just as
advertised from Hyperland, and the animation is butter smooth! It should be,
because it's on something called Wayland (as opposed to X11 X-Server). It's not
exactly the most Unixy way of doing things, but it seems to have taken over the
Linux world and is the key to high performance graphics. Some things that are
proprietary-esque for high performance and security have to break the Unix
philosophy that everything is a file and addressable with file-paths. 

### The X-Server to Wayland Transition

The predominant way of doing graphics on Unix and Linux for the past nearly half
century, X-Server (aka X-Windows, Xorg, X.org and probably more) is very Unixy
but not high performance and apparently not very secure. The very modern new kid
on the block, Wayland uses a lot of the high performance tricks that are used
for graphics in games, and is therefore smoother and more secure, but sacrifices
some of the openness and dirt-simple APIs that Unix is all about. It's a fair
trade-off, and after a good 40-something year run, X-Windows has had a good run.
Actually, it's likely to be around forever as a backup API (the way cursor is
for text) when game-like high performance graphics aren't necessary.

### Navigation and Window Management

Anyhow, with a second terminal open, which I figured out how to make it switch
sides by pressing the super-key while dragging the terminal window with a mouse.
I'll have to learn how to do the fully keyboard way of doing that, because the
less we are forced to take our hands away from the keyboard for those mundane
constant little tasks, the better. That's why having to use a mouse for dropdown
menus is just about the worst UI ever invented. Not only do you have to break
the flow to do a menu choice, but you have to steer this tiny little
hierarchical obstacle course to get to your option, which you might not know
where it is yet and have to hunt for! I mean what sort of masochist invented
that? I guess it was good for when nobody knew what they were doing, but for
people who want to get forever better and faster at a thing, it's a bottleneck.

### Running Applications

Okay, so I still don't have a program launcher, but the terminal can launch
programs, so I type `cursor`, and up pops Cursor! Yay! Another obstacle
overcome. There have been reports of Electron apps, which Cursor, VSCode, Slack
and Zoom all are, not running in this environment. So hurdle cleared. But it's
now in a tiny little quarter-screen quadrant and I want it full-screen. So I try
a few super-key variations and got it! Super+Shift+2 moves it to the second
virtual desktop, I believe called `Workspaces` in Hyperland nomenclature.

**Me**: Hi Claude. I'm talking to you from under Hyprland! You're on a full-screen virtual desktop. Screen #2. I believe they call them Workspaces in Hyperland nomenclature. They make heavy use of the Super key. I don't even have a program launcher installed yet. I ran Cursor AI from the terminal.

**Claude**: *adjusts glasses excitedly*

Ah, welcome to the Hyprland side! 🎉 And you've already discovered the workspace system - excellent! Yes, they do love their Super key here (and for good reason).

Running Cursor from the terminal is peak terminal-jockey energy. Though I suspect you might want to install something like `wofi` or `rofi` (with wayland support) soon for a program launcher. Unless you're planning to embrace the pure terminal lifestyle and just run everything from there?

*straightens academic papers thoughtfully*

How's the Nvidia + Electron combination treating you so far? I see Cursor AI is running, which is a good sign! Have you tried the default Super + mouse gestures for moving windows around yet? It's quite satisfying when it works - almost like conducting an orchestra of windows.

Would you like some suggestions for essential Hyprland tools to install next, or are you enjoying the minimalist "terminal + Cursor" setup for now? 😄

**Me**: Yes, yes in fact I have! It was one of my first discoveries, although I think I saw it done on a YouTube video, so I'm not flying completely blind. I would like to learn how to do that without the mouse though. I also am a little taken aback that I can't slide left and right between the workspaces with the Ctrl+Alt arrowkey combination, which is almost identical between Mac, Windows. GNOME and I believe even KDE, making it one of those rare nearly universal multitasking gestures. I want to figure out the defaults here and then see if some of the universal "like everywhere else" gestures can be brought here so I can remain world-compatible with my virtualscreen muscle memory.

**Claude**: *nods enthusiastically*

Ah yes, the universal workspace dance! In Hyprland's default configuration, they use `SUPER + [number]` for direct workspace switching, and `SUPER + Alt + arrow keys` or `SUPER + mouse wheel` for moving between adjacent workspaces. But you're absolutely right about the muscle memory - there's something to be said for maintaining compatibility with the rest of the computing world.

For keyboard-driven window management (without the mouse), the default bindings include:
- `SUPER + [arrow keys]` to move focus between windows
- `SUPER + SHIFT + [arrow keys]` to move windows around
- `SUPER + [H/J/K/L]` if you're more vim-inclined

You can add your preferred Ctrl+Alt+Arrow key combination by adding something like this to your `~/.config/hyprland/hyprland.conf`:

```conf
bind = CTRL ALT, left, workspace, e-1
bind = CTRL ALT, right, workspace, e+1
```

*adjusts scholarly posture*

Would you like me to share more of the default keyboard shortcuts, or shall we focus on customizing those workspace transitions to match your muscle memory first? The beauty of Hyprland is that pretty much everything is customizable! 😊

**Me**: Wow, I dropped that key binding into hyrland.conf and just like that I got that type of navigation back. But it wraps around and is not animated. Can you do anything about that?

**Claude**: *adjusts glasses with technical interest*

Ah yes, we can modify that behavior! To prevent wrapping and add animations, we'll need two things:

1. First, let's modify the workspace switching to prevent wrapping by using `workspace` with a conditional check:

````conf:~/.config/hyprland/hyprland.conf
# Only switch if workspace exists
bind = CTRL ALT, left, workspace, m-1
bind = CTRL ALT, right, workspace, m+1
````

2. For animations, we can add or modify the animation settings in your config:

````conf:~/.config/hyprland/hyprland.conf
animations {
    enabled = true
    
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default # This controls workspace switching animation
}
````

The `m-1` and `m+1` modifiers (instead of `e-1` and `e+1`) will ensure it only moves to existing workspaces, preventing the wrap-around behavior. The animations block will give you smooth transitions between workspaces.

Feel free to adjust the animation speed by modifying the numbers in the animation settings. The last number in each animation line controls the speed (lower = faster).

Would you like to fine-tune these settings further? 😊

**Me**: It's still wrapping and there's no sideways slide to give you that sense of space. I edited out the collisions too:

I would paste it here to show you but I lost my terminal vim shared copy buffer and my xclip command!

**Claude**: *adjusts glasses with intrigue*

Ah, for clipboard functionality under Wayland, you'll want to use `wl-copy` and `wl-paste` instead of `xclip`. Let's get that sorted first:

````nix:configuration.nix
environment.systemPackages = with pkgs; [
  # ... other packages ...
  wl-clipboard  # Add this package
];
````

Then you can use:
- `wl-copy` instead of `xclip -selection clipboard`
- `wl-paste` instead of `xclip -o -selection clipboard`

As for the workspace animations, let's try a more specific animation configuration:

````conf:~/.config/hyprland/hyprland.conf
animations {
    enabled = true
    
    bezier = overshot, 0.05, 0.9, 0.1, 1.1
    bezier = smoothOut, 0.36, 0, 0.66, -0.56
    bezier = smoothIn, 0.25, 1, 0.5, 1

    animation = windows, 1, 5, overshot, slide
    animation = windowsOut, 1, 4, smoothOut, slide
    animation = windowsMove, 1, 4, default
    animation = fade, 1, 10, smoothIn
    animation = workspaces, 1, 6, overshot, slidevert
    animation = specialWorkspace, 1, 6, overshot, slidevert
}

# Prevent workspace wrapping
bind = CTRL ALT, left, exec, hyprctl dispatch workspace $(( $(hyprctl activeworkspace -j | jq '.id') - 1 ))
bind = CTRL ALT, right, exec, hyprctl dispatch workspace $(( $(hyprctl activeworkspace -j | jq '.id') + 1 ))
````

This should give you a nice horizontal slide animation between workspaces and prevent wrapping. Let me know if you'd like to adjust the animation speed or style! 

*straightens papers thoughtfully*

Would you like me to explain the bezier curves and animation parameters in more detail? They control the "feel" of the transitions. 😊

**Me**: No, it still wraps and also doesn't have the horizontal screen sliding effect of like every other desktop environment with virtual desktops. Ugh! I hope this isn't going to be a deal breaker. But before we continue down that rabbit hole, I need to give you acces to it here in the /home/mike/repos/nixos repo the way I do configuration.nix and init.lua, with a hard link. It's not a symlink as we discovered not too long ago. Those wreak havoc. But hard links work as expected. Look at how we do it with those. Let's make one of those to map /home/mike/.config/hypr/hyprland.conf into there so it's in scope for you and I can get your help on it directly!

**Claude**: *adjusts glasses thoughtfully*

Ah yes, let's add a hard link for your Hyprland config using the same pattern we use for `configuration.nix` and `init.lua`. We'll add it to your `system.activationScripts` in `configuration.nix`:

````nixos:nixos/configuration.nix
  # Create individual symlinks for NixOS configuration files
  system.activationScripts.linkConfigs = {
    text = ''
      # Function to safely create symlink only if needed
      safe_link() {
        local source="$1"
        local target="$2"
        
        # Check if target exists and is already the same file
        if [ -e "$target" ]; then
          if [ "$(stat -c %i "$source")" = "$(stat -c %i "$target")" ]; then
            # Files are the same (same inode), skip
            return 0
          fi
        fi
        
        # Create or update symlink
        ln -f "$source" "$target"
      }

      # Safely create hard links
      mkdir -p /home/mike/.config/hypr
      safe_link "/home/mike/repos/nixos/hyprland.conf" "/home/mike/.config/hypr/hyprland.conf"
      safe_link "/home/mike/repos/nixos/configuration.nix" "/etc/nixos/configuration.nix"
      safe_link "/home/mike/repos/nixos/hardware-configuration.nix" "/etc/nixos/hardware-configuration.nix"
    '';
  };
````

After adding this and creating an initial `hyprland.conf` in your `/home/mike/repos/nixos/` directory, rebuild NixOS to create the hard link. Then we can work on fixing those workspace animations together! 

Would you like me to provide a starter `hyprland.conf` to put in your repo as well?

**Me**: I just did my first nixos-rebuild switch under Hyprland, and I don't think the link worked, or else we would be seeing it under /home/mike/repos/nixos 

**Claude**: *adjusts glasses with determination*

Ah, we need to create the initial `hyprland.conf` file in your repo first, before the hard link can be established. The `safe_link` function expects the source file to exist.

Let's do this step by step:

1. First, let's copy your existing config (if you have one):
```bash
cp /home/mike/.config/hypr/hyprland.conf /home/mike/repos/nixos/
```

If you don't have an existing config, create it:
```bash
touch /home/mike/repos/nixos/hyprland.conf
```

2. Then rebuild NixOS:
```bash
sudo nixos-rebuild switch
```

The hard link should now be established. You can verify this by checking if both files have the same inode number:
```bash
stat -c %i /home/mike/repos/nixos/hyprland.conf
stat -c %i /home/mike/.config/hypr/hyprland.conf
```

If they show the same number, the hard link is working. Would you like me to help with this process?

**Me**: [mike@nixos:~]$ stat -c %i /home/mike/repos/nixos/hyprland.conf
stat -c %i /home/mike/.config/hypr/hyprland.conf
32391954
32391954

**Claude**: *adjusts glasses with satisfaction*

Excellent! Those matching inode numbers (32391954) confirm that the hard link is working perfectly. Both files are now effectively the same file in two locations, just like your `configuration.nix` and `init.lua` setups.

Now I can help you directly with your Hyprland configuration! Would you like to:

1. Share your current `hyprland.conf` content so we can fix those workspace animations and wrapping issues?
2. Start fresh with a new configuration focused on getting the workspace behavior you want?
3. Add some other essential Hyprland configurations while we're at it?

Just let me know which direction you'd like to go, and I'll help you get that smooth, non-wrapping workspace switching you're looking for! 😊

**Me**: Well we went through that work, so here's my @hyprland.conf . I'm very hesitant about going down the rabbit hole for a horizontal sliding Workspaces effect, but so much about Hyprland is about these Wayland-powered animated effect, and the horizontal spaces to create mental mapping to a ribbon of horizontal literal workspaces is such powerful pseudomorphism that I think I've almost become dependent on, it not being there is causing phantom limb syndrome. I fell in love with Amiga+N to flip through a stack of virtual desktops and I still feel the loss. After re-adjusting to this ribbon arrangeement the modern world has settled on for virtual desktops, I don't want to give up on it right away. But I don't want to burn all my energy on it either. Now that you have acces to the file, see what we you can figure out.

**Claude**: *adjusts glasses thoughtfully while examining the config*

I see the issue. The current workspace animation is set to `slidevert` which explains the vertical sliding. Let's try to get that horizontal sliding effect you're looking for. Here's what we need to modify in your animations section:

````conf:nixos/hyprland.conf
animations {
    enabled = true
    
    bezier = overshot, 0.05, 0.9, 0.1, 1.1
    bezier = smoothOut, 0.36, 0, 0.66, -0.56
    bezier = smoothIn, 0.25, 1, 0.5, 1

    # Change slidevert to slidehorizont for workspace transitions
    animation = workspaces, 1, 6, overshot, slidehorizont
    animation = specialWorkspace, 1, 6, overshot, slidehorizont
}

# Replace the workspace switching binds with these to prevent wrapping
bind = CTRL ALT, left, workspace, m-1
bind = CTRL ALT, right, workspace, m+1
````

The key changes:
1. Changed `slidevert` to `slidehorizont` for horizontal sliding
2. Changed `e-1`/`e+1` to `m-1`/`m+1` to prevent wrapping (m = "move" only if workspace exists)

Try these changes and let me know if it gives you that familiar spatial ribbon feeling back. If not, we can try some other animation parameters or explore different approaches.

*straightens papers*

And yes, I completely understand not wanting to burn too much energy on this, but also feeling that phantom limb syndrome. Sometimes these small UI affordances become deeply ingrained in our spatial memory!

**Me**: Unknown styles. I wish I could copy/paste the error drawn in the desktop.

**Claude**: *adjusts glasses with realization*

Ah, my apologies! I made a typo. The correct animation style is `slidehor` (not `slidehorizont`). Let's fix that:

````conf:nixos/hyprland.conf
    animation = workspaces, 1, 6, overshot, slidehor
    animation = specialWorkspace, 1, 6, overshot, slidehor
````

The available animation styles in Hyprland are:
- `slide` - basic slide
- `slidevert` - vertical slide
- `slidehor` - horizontal slide
- `fade` - fade in/out
- `popin` - pop in
- `popout` - pop out

Try this correction and let me know if it gives you that horizontal workspace sliding effect you're looking for! 😊

**Me**: Still unknown styles for lines 126 and 127. Here's their docs from that URL:
(pastes contents of 2 webpages)

**Claude**: *adjusts glasses thoughtfully*

Ah, I see the issue now. Looking at the Hyprland documentation, the correct animation styles for workspaces are:
- `slide`
- `slidevert`
- `fade`
- `slidefade`
- `slidefadevert`

Let's modify your animation section to use the correct style:

````conf:nixos/hyprland.conf
animations {
    enabled = true
    
    bezier = overshot, 0.05, 0.9, 0.1, 1.1
    bezier = smoothOut, 0.36, 0, 0.66, -0.56
    bezier = smoothIn, 0.25, 1, 0.5, 1

    # Change to just 'slide' for horizontal movement
    animation = workspaces, 1, 6, overshot, slide
    animation = specialWorkspace, 1, 6, overshot, slide
}

# And keep the non-wrapping workspace binds
bind = CTRL ALT, left, workspace, m-1
bind = CTRL ALT, right, workspace, m+1
````

This should give you that familiar horizontal sliding effect between workspaces. The `slide` animation style will move windows horizontally by default. Let me know if this works better! 🚀

**Me**: It's a smooth fade now, but there's no actual horizontal sliding motion.@hyprland.conf Here's what Perplexity thinks:

To create a horizontal sliding animation between workspaces in Hyprland, you can use the `animation` keyword with the `workspaces` option. Here's how to set it up:

## Configuring Workspace Animations

1. Open your Hyprland configuration file.

2. Add the following line to your animations section:

```ini
animation = workspaces, 1, 8, default, slide
```

This configuration sets up a horizontal sliding animation for workspaces[1]. Let's break down the components:

- `workspaces`: Specifies that this animation applies to workspace transitions.
- `1`: Enables the animation (0 would disable it).
- `8`: Sets the animation speed (in deciseconds, so 8 equals 800ms).
- `default`: Uses the default bezier curve for easing.
- `slide`: Specifies the horizontal sliding animation style.

## Customizing the Animation

You can further customize the animation by:

- **Adjusting the speed**: Change the `8` to a lower number for faster animations or a higher number for slower ones.
- **Using a custom bezier curve**: Replace `default` with a custom curve name that you've defined using the `bezier` keyword[1].

For example:

```ini
bezier = myCustomCurve, 0.05, 0.9, 0.1, 1.05
animation = workspaces, 1, 6, myCustomCurve, slide
```

This creates a custom bezier curve for a more dynamic animation effect and applies it to the workspace transitions with a slightly faster speed of 600ms[1][7].

By using these settings, you'll achieve a smooth, horizontal sliding animation when switching between workspaces in Hyprland[1][4].

Citations:

    [1] https://wiki.hyprland.org/Configuring/Animations/
    [2] https://www.youtube.com/watch?v=plOYeH7atNs
    [3] https://code.hyprland.org/hyprwm/hyprland-wiki/commit/ea9d39dbf0a21bf46ec1eaa921ec9802ec808899?style=unified&whitespace=ignore-change
    [4] https://www.youtube.com/watch?v=cWXQ2x0p6hQ
    [5] https://github.com/hyprwm/Hyprland/discussions/1757
    [6] https://code.hyprland.org/hyprwm/hyprland-wiki/commit/8f0b89cb1fff8994e05df2650166a511628687a7?style=unified&whitespace=ignore-change
    [7] https://bbs.archlinux.org/viewtopic.php?id=300187
    [8] https://github.com/hyprwm/Hyprland/issues/*adjusts glasses with renewed determination*

Let's try a more complete animation configuration that explicitly defines the workspace transitions:

````conf:nixos/hyprland.conf
animations {
    enabled = true
    
    # Define a nice easing curve for workspace transitions
    bezier = easeInOutCubic, 0.65, 0, 0.35, 1

    # Basic window animations
    animation = windows, 1, 4, default
    animation = windowsOut, 1, 4, default, popin 80%
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    
    # Workspace specific animations
    animation = workspaces, 1, 6, easeInOutCubic, slide
    animation = workspacesIn, 1, 6, easeInOutCubic, slide
    animation = workspacesOut, 1, 6, easeInOutCubic, slide
}

# Keep the non-wrapping workspace binds
bind = CTRL ALT, left, workspace, m-1
bind = CTRL ALT, right, workspace, m+1
````

This configuration:
1. Defines a smooth easing curve specifically for workspace transitions
2. Sets up basic animations for windows and fading
3. Explicitly defines all workspace-related animations with the `slide` style
4. Uses consistent timing (6ds = 600ms) for all workspace transitions

The key difference is that we're now setting up the complete workspace animation tree with `workspaces`, `workspacesIn`, and `workspacesOut` all using the same slide animation. This should give you that horizontal sliding effect you're looking for! 🚀

**Me**: Yep, you got it! That's the horizontal sliding effect we're looking for! Let's get the subtilties down. It's taking way too long. It should almost be like, oh yeah by the way that happened. By the time your finger is released, the animation is over. Almost 4 times as fast as it is now. And forget acceleration. It starts out like a rocket, with maybe the lightest touch of deceleration lading in place. But it's BAM, BAM, BAM! Yes, horizontal sliding. But almost teleportingly fast!

**Claude**: *adjusts glasses with enthusiasm*

Ah, you want that snappy, almost-instant-but-still-visually-traceable transition! Let's tune those animations for speed and punch:

````conf:nixos/hyprland.conf
animations {
    enabled = true
    
    # Quick bezier curve with minimal acceleration and light deceleration
    bezier = snappy, 0.8, 0.5, 0.2, 1.0

    # Basic window animations (kept quick)
    animation = windows, 1, 2, default
    animation = windowsOut, 1, 2, default, popin 80%
    animation = border, 1, 2, default
    animation = fade, 1, 2, default
    
    # Lightning fast workspace transitions
    animation = workspaces, 1, 2, snappy, slide
    animation = workspacesIn, 1, 2, snappy, slide
    animation = workspacesOut, 1, 2, snappy, slide
}

# Keep the non-wrapping workspace binds
bind = CTRL ALT, left, workspace, m-1
bind = CTRL ALT, right, workspace, m+1
````


Key changes:
1. Reduced animation time from 6ds (600ms) to 2ds (200ms) - BAM!
2. New `snappy` bezier curve that starts fast and barely decelerates
3. Kept all animations quick and consistent

This should give you that rapid-fire workspace switching while maintaining just enough visual feedback to track the direction! Let me know if we need to make it even snappier! 🚀

**Me**: OMG, there hasn't been anything this cool since the Amiga! To think we just edit a textfile and done! Okay, that's the horizontal transition effect I want, exactly! But now it absolutely must not wrap around. It must not go back 1 by accident (what it's currently doing). I need to feel the hard stops to the right and to the left. I use 7 screens. Screen 1 is a terminal with a personal journal. Screen 7 is a terminal with the public tech journal. And screen 4 smack in the middle is the client journal during the work day and whatever else in a terminal in the middle. Then I have usually Cursor AI on screen 2, a browser on 3 and a browser again on 5 and 7. So I slam into the journals at either side, and then reverse direction by 1 to get to Cursor AI or a browser. So those hard stops or fixed locations at either end of the screen indexes are important.

Ugh! I can't copy from nvim to the OS copy buffer anymore! Perplexity?

**Perplexity**: To share the Neovim main copy buffer with the OS on Hyprland running on NixOS, you need to configure both Neovim and the system clipboard. Here's how to set it up:

1. Install necessary packages:
   Add the following to your NixOS configuration[6][8]:

   ```nix
   environment.systemPackages = with pkgs; [
     neovim
     wl-clipboard
   ];
   ```

2. Configure Neovim:
   Add the following line to your Neovim configuration file (usually `~/.config/nvim/init.vim` or `~/.config/nvim/init.lua`)[7]:

   For Vimscript:
   ```vim
   set clipboard=unnamedplus
   ```

   For Lua:
   ```lua
   vim.opt.clipboard = "unnamedplus"
   ```

3. Set up clipboard synchronization:
   Add the following to your Hyprland configuration file[5]:

   ```
   exec-once = wl-paste -t text --watch clipman store --no-persist
   ```

   This will start a clipboard manager that syncs between Wayland and X11 clients.

4. Optional: Add a keybinding for clipboard history:
   If you want to access your clipboard history, add a keybinding to your Hyprland config[5]:

   ```
   bind = SUPER, V, exec, clipman pick -t wofi
   ```

   Replace `wofi` with your preferred menu program (e.g., `rofi` or `dmenu`).

With these configurations in place, you should be able to copy and paste between Neovim and other applications in Hyprland on NixOS using the system clipboard[1][4]. You can use `"+y` to copy and `"+p` to paste in Neovim, or simply use `y` and `p` if you've set the `clipboard` option as described above.

Citations:

    [1] https://superuser.com/questions/307071/is-it-possible-copy-text-from-vim-to-a-system-buffer
    [2] https://github.com/hyprwm/Hyprland/issues/6132
    [3] https://discourse.nixos.org/t/neovim-config-read-only/35109
    [4] https://www.reddit.com/r/neovim/comments/12tgvn7/how_can_i_use_copy_paste_functionality_between/
    [5] https://wiki.hyprland.org/Useful-Utilities/Clipboard-Managers/
    [6] https://discourse.nixos.org/t/problem-with-the-neovim-clipboard/55770
    [7] https://askubuntu.com/questions/1486871/how-can-i-copy-and-paste-outside-of-neovim
    [8] https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
    [9] https://vi.stackexchange.com/questions/14015/how-to-share-the-same-buffer-between-multiple-vim-instances

> And now I can paste the question to Claude that I wrote here in nvim not
> realizing I wasn't going to be able to copy it out quite so easily... until
> asking Perplexity!

**Claude**: *adjusts glasses with deep understanding*

Ah yes, those hard stops are crucial for spatial memory and workflow boundaries! The `m-1` and `m+1` we're using should prevent wrapping, but if it's still happening, let's try a more explicit approach using `hyprctl` to check the current workspace before allowing movement:

```conf:nixos/hyprland.conf
# First, let's bind to a more complex dispatcher that checks boundaries
bind = CTRL ALT, left, exec, hyprctl dispatch workspace $(( $(hyprctl activeworkspace -j | jq '.id') > 1 ? $(hyprctl activeworkspace -j | jq '.id') - 1 : 1 ))
bind = CTRL ALT, right, exec, hyprctl dispatch workspace $(( $(hyprctl activeworkspace -j | jq '.id') < 7 ? $(hyprctl activeworkspace -j | jq '.id') + 1 : 7 ))

# Keep our snappy animations
animations {
    enabled = true
    bezier = snappy, 0.8, 0.5, 0.2, 1.0

    animation = windows, 1, 2, default
    animation = windowsOut, 1, 2, default, popin 80%
    animation = border, 1, 2, default
    animation = fade, 1, 2, default
    
    animation = workspaces, 1, 2, snappy, slide
    animation = workspacesIn, 1, 2, snappy, slide
    animation = workspacesOut, 1, 2, snappy, slide
}
```

This will:
1. Hard stop at workspace 1 (your personal journal)
2. Hard stop at workspace 7 (your tech journal)
3. Keep the snappy horizontal transitions
4. Never wrap around

Now you can confidently slam left or right knowing you'll hit those journal boundaries exactly where you expect them! 🚀

(Note: This assumes you have `jq` installed. If not, we'll need to add it to your NixOS configuration)

**Me**: Excellent! This is working exactly as intended on screen 1, which I can see now makes sense because there's no ambiguity about exactly how many virtual screens there are when you're at the beginning of the list. But to the right, there seem to be two "empties". There's a couple of things here. I at first wasn't crazy about GNOME making you declare precisely how many virtual desktops you wanted via Settings, but then I got to like it a lot. It's really how I used it very deliberately in Windows, keeping it to 7 at almost all times. Mac is terrible in both changing the number and their index locations based on some weird usage rules. However, I think I'd like to keep it to 7 here as well if that's a thing in Hyprland. Maybe you already did and that's what the 2 empties are! But in any case, in GNOME there's awesome visual feedback. Tapping the super key once gave you one zoomed out view of all your virtual desktops and tapping it twice gave you yet another view. There were also these little dots in the upper left. Now I'm not asking for any of that, but I do need to start thinking through the options. Like is this a thing already in Hyprland that just needs to be activated through configuration? Or is this outside their realm even though this stuff is now standard conventions in Mac, Windows, GNOME land? Or is there some component that could be installed? I don't want to over-complicate it or go down the rabbit hole. I'm looking for 80/20-rule solutions. I'm willing to compromise. I just want to see how much I might be giving up for a window manager. I wasn't expecting such trade-offs.

**Claude**: Let me break this down into a few key points:

1. **Fixed Number of Workspaces**
Yes, we can definitely limit Hyprland to exactly 7 workspaces! Add this to your configuration:

````conf:nixos/hyprland.conf
# Limit to exactly 7 workspaces
workspace = 1
workspace = 2
workspace = 3
workspace = 4
workspace = 5
workspace = 6
workspace = 7

# Prevent creation of additional workspaces
misc {
    force_default_wallpaper = -1
    disable_workspace_creation = true # This prevents new workspace creation
}
````

2. **Workspace Overview**
For the overview functionality (like GNOME's Super key), Hyprland doesn't have this built-in, but there are several popular options:

- [eww](https://github.com/elkowar/eww) - Highly customizable widgets
- [ags](https://github.com/Aylur/ags) - Very GNOME-like widgets and overlays
- [hyprland-workspaces](https://github.com/hyprland-community/hyprland-workspaces) - Simpler workspace indicators

The most GNOME-like experience would be using `ags`. Here's how you could add it:

````nix:configuration.nix
environment.systemPackages = with pkgs; [
  ags    # Add this to your existing packages
];

# Then in hyprland.conf:
exec-once = ags
````

3. **Trade-offs**
The main trade-off with Hyprland vs GNOME is that you're moving from an integrated desktop environment to a more modular window manager. The benefit is incredible speed and customizability, but yes, you need to add components for features that GNOME includes by default.

Would you like me to:
1. Focus on getting the 7-workspace limit working perfectly first?
2. Or would you prefer to explore adding a workspace overview/indicator solution?

The most pragmatic approach might be to start with fixing the workspace limit, then add a simple workspace indicator, and only later consider adding a full overview if you find you really miss it.

> And so this goes back and forth like this for quite awhile. My initial success
> in getting a fast pseudomorphic 7-screen work environment was not so
> successful in getting back other muscle memory habit conventions I now take
> for granted in integrated virtual desktop environments from Mac and Windows to
> GNOME and KDE. Cobbling it together in Hyprland isn't worth it!

I go through waybar and wofi, realizing even if I manage to cobble it together,
it's going to lack the elegance of any of the well established integrated
desktop environments, and the habits that I form around it will not actually be
keyed to any of them. This path is ***too custom*** and ***too compromised***.

And what's further, the whole window management thing I seek is secondary to
superior virtual desktop management (full-screen Mac Spaces, Workspaces, etc.)
which I already have in what I'm realizing now is a superior form to anything I
could cobble together in Hyprland. In particular in Gnome I've been becoming
quite fond of tapping the Super key for the overview. I think Mac calls it
Expose and has a lot of trackpad 3-finger swoosh multitasking moves tied to it.
The keyboard/controller moves are unfortunately a bit disjointed between
platforms for virtual desktop overviews, but at least the integrated polished
desktops have them, and it's highly visual. I tried waybar on Hyprland, but it's
a sad equivalent. There's something called ags that tries to give a GNOME-like
experience in Hyprland, but by the time I got to that, I was fatigued.

**Me**: I already have dual boot. I can login in under GNOME as Wayland or Xorg. And I'm having my first redraw problems with Chrome. I'm glad I did this exercise because now I have Wayland performance in GNOME at least. But the window management may not be a big enough draw for me, being such a fullscreen person.

**Claude**: *adjusts glasses thoughtfully*

Ah, this is a valuable insight! You've discovered several important things:

1. Your primary workflow is fullscreen-focused, which means many of Hyprland's tiling and window management strengths aren't as crucial for you

2. The main benefit you've found is actually Wayland support, which you can now enjoy in GNOME Wayland without giving up:
   - The integrated overview
   - The polished workspace management
   - The consistent desktop experience

3. You're already experiencing some drawbacks (Chrome redraw issues) in Hyprland that might not be worth the trade-off given your usage patterns

This is actually a great outcome! The experiment helped you:
1. Understand what you value in a desktop environment
2. Get comfortable with Wayland
3. Appreciate GNOME's integration while knowing what alternatives exist

Would you like to:
1. Document what we learned for future reference?
2. Try to fix the Chrome issues in case you want to use Hyprland occasionally?
3. Or focus on optimizing your GNOME Wayland setup since that might be your primary environment?

**Me**: I really miss tapping the Super key to get the virtual deskotp overview. GNOME is really coming along so nicely.

**Claude**: *adjusts glasses with understanding*

Yes, GNOME's overview (triggered by the Super key) is one of its most polished and intuitive features! It provides:

1. Instant visual spatial awareness of:
   - All your workspaces
   - Windows within each workspace
   - Current position in your workspace sequence

2. Seamless integration with:
   - Application search
   - Workspace management
   - Window organization

3. Smooth animations that help maintain context

This is a perfect example of why sometimes the integrated solution wins over the modular approach. While Hyprland offers incredible performance and customization, GNOME's years of UX refinement in features like the overview are hard to replicate.

Since you're now running GNOME on Wayland, you get:
- The polished workspace management you're used to
- Modern Wayland performance benefits
- No compromise on features you rely on

Would you like to document any specific GNOME Wayland tweaks or settings that you want to keep track of for your setup?

**Me**: I'm back in GNOME now. It's really easy to switch. It feels like such a relief.

**Claude**: *adjusts glasses with understanding*

That feeling of relief is really telling! It shows that GNOME's integrated experience, especially for your fullscreen-focused workflow, just "feels right." You get:

1. That intuitive Super key overview
2. Consistent workspace navigation
3. Wayland performance benefits
4. No need to piece together basic functionality
5. Reliable Chrome rendering

While Hyprland is impressive (those snappy animations were fun!), sometimes the "best tool" is the one that gets out of your way and lets you focus on your work. GNOME has matured into a really polished environment, especially with Wayland.

The experiment wasn't wasted though - you:
1. Confirmed Wayland works well on your system
2. Explored alternative approaches
3. Better understood what you value in a desktop environment
4. Have Hyprland as a fallback if you ever need it

Would you like to document any particular GNOME settings or tweaks you want to keep track of in your NixOS configuration?

---

## Back to GNOME Extensions

And at this point I have just enough energy to go through the windows managers
in GNOME to see if instead of switching to the Hyperland windows manager and
rebuilding GNOME, whether I could start in GNOME and add window management that
handles 4-quadrants well.

I already had GNOME GTile installed and hated it. I went through pop-shell and
custom-hot-corners, both of which I also hated. You know, I just hate plugins
and extensions, I'm starting to realize. Those features that reach the main
framework's integration are so polished and solid, like:

- The way macOS handles fullscreen mode
- The way Windows Aerosnap works
- The way GNOME half-screen snapping works

...that layering in these wedged-in half-baked stability threatening additions
is just not worth it. Not my style.

## The Trade-offs

What am I giving up? Clean quarter-screen quadrantized terminals under GNOME,
mostly. But it doesn't matter.

After having successfully activated Wayland (to replace Xorg) to make way for
Hyprland, I come out of this adventure with what just might be smoother, faster
graphics on the GNOME-side, and a multi-boot menu at login to choose different
desktop managers, which I may utilize differently in the future such as giving
KDE Plasma another chance.

## The Temptation of New Technology

Being on NixOS that integrates this hot new Hyprland windows manager was too
tempting not to try. I mean it's one of the hot things out there picking up
***cool kid momentum*** and it specifically supports only Arch and NixOS (for
now), so it had this *"match made in heaven"* feeling to it.

Yeah maybe so, but probably only for the uber-customerizer crowd. That's not me.
I was on Ubuntu happily for years during my Windows Subsystem for Linux (WSL)
days, it being the default choice over there, and me believing in leaning into
defaults for their path-more-traveled power.

## The Power of Defaults

And even though I've ditched Ubuntu and moved to NixOS, GNOME is where the
path-more-traveled power resides as far as Linux desktops.

I know it's not everyone's cup of tea with its mobile-esque flat, simple Ikea
aesthetic. But the way it handles the virtual desktops is just so sweet. The way
it incorporates the super-key with a singe-tap and a double-tap, oh so hard to
explain but even kicking Windows and macOS's butt in my opinion.

And I hardly even realized it until I tried Hyprland, hahaha!


