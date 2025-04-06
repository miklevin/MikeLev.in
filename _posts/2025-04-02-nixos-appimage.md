---
title: "NixOS Bleeding Edge: Using AppImage When Repos Fall Behind"
permalink: /futureproof/nixos-appimage/
description: Living on the NixOS bleeding edge, I love the rock-solid stability but hate getting stuck with older versions of crucial apps like Cursor or Zoom when the Nix repos lag behind. My preferred workaround for this specific problem is using downloadable AppImage files combined with the `appimage-run` tool – it's a straightforward way to get the absolute latest versions without the overhead or integration issues I've found with Flatpak or Snap on NixOS, though I did have to create my own simple script to get basic desktop icons and searchability working since the standard `appimaged` approach didn't work out for me.
layout: post
sort_order: 1
---

## Living on the Bleeding Edge with NixOS

Hello, my friends! I live on the bleeding edge and I hate to bleed. I suffer so
in the name of future-proofing, and will show you the best tricks. I have seen
the future, and it is `nix`. No, not `*nix` Unix-like operating systems (aka
Linux), although it is also that. It's Nix as in NixOS, or sometimes nixOS when
you want it to look cool as a Mac. And yes, it is cool as a Mac, as many of the
cool Mac kids are using, especially those an Andruil. Don't work at Anuril.

### A Journey Through Computing History

Yeah, yeah, insider stuff. You have to deal with a little of that when you're
out here trying to do something new, get the benefit, and really not be much the
worse off for it. My history goes back to the first popular digital console in
people's homes, the Atari 2600, or the VCS as some of the world knows it. Some
might argue it was the Fairchild console or PONG. But the one really that hit it
big was the Atari 2600, and I had probably been trying to program in one way or
another since then. I still don't know how. I just use Python.

### Learning from Past Technology Shifts

Anyhow, once bitten, twice shy. A hundred times bitten and still going at it?
Just dumb. From Coleco Adam to Amiga to Windows and Mac. I was the first to
unbox the Raspberry Pi online. I don't really just run from one shiny toy to the
next. I'm a slow learner. I would like the next shiny toy to just last forever.
But new ones don't. It's a long, layering-on and iterative process. In the 40 of
the 50-or-so years I've been on this Earth observing such things, I've witnessed
it zeroing in on some core generic tech. I'm here to tell you about Nix.

### The Evolution to Nix and Guix

Eventually, it will be Nix and Guix, pronounced Geeks, because the GNU Project,
the Free Software Foundation that's behind all the parts of Linux that isn't
Linus Torvalds, has hopped on this bandwagon too. It's kind of like Docker
containers. It's kind of like VMWare/VirtuaBox Virtual Machines. But without all
the overhead, bloat and vendor fuddle dee duddle. Deterministic builds of your
systems from text-files is all it is. You need other ways to move your
non-system data around, but as far as your computer operating system, all the
installed apps and your tweaked-out configuration stuff, that's all packaged to
travel now. Done.

### Twenty Years of Maturity

And it's surprisingly 20-years mature now. It came out circa 2003 to 2006 from
Eelco Dolstra and Armijn Hemel and has been solving the "not on my machine"
problem. You know that problem? That thing that works over there doesn't work on
my machine? And that's driven the popularity of Cloud services for the past 20
years or so? Well, the not-on-my-machine problem is no longer a problem. The
promise of write-once/run-anywhere is achieved. It's just that nobody knows it.
It's like a super well kept secret, even though it's named **NIX!** It's not
like they're hiding it.

### The World Catches Up to Nix

Yeah, so it's like one of those "the world isn't ready yet" things. It sounds
too good to be true, but isn't. The Mac cool kids even took care of all those
nuanced platform-specific problems that are going to happen in the form of the
Determinate Nix Installer. I mean the Nix people put out a perfectly good
installer, but it wouldn't survive Mac upgrades and didn't provide a super-clean
uninstall, so the Determinate people solved all that, effectively removing the
final arguments against Nix in a sufficiently cool way that even Macolytes like
it.

### Navigating the Bleeding Edge

So anyhow, this isn't going to be an exhaustive introduction to Nix/NixOS nor
even a tutorial. It's going to be talking about dealing with just a few of those
bleeding edge problems you're going to encounter if you take the plunge sooner
rather than later, like I did.

### Understanding NixOS vs Nix Package Manager

There's a NixOS vs just using the `nix` package manager on Windows, Mac or other
Linux distros. You can do that. Just using `nix` as an alternative to `homebrew`
and `winget` or `chocolatey` or whatever gets you a lot. It gets you the big "it
doesn't work on my machine" fix. But this isn't about that. This is about people
who took the complete plunge into the deep end of the bleeding edge, and are on
NixOS the whole kitten caboodle operating system built out of `nix`.

### The Unique Nature of NixOS

It's weird, wild stuff being on NixOS. Many Linux distro wonks don't even
consider NixOS a Linux distribution at all, because the issues you are going to
encounter are so friggin different. It's not for people who want to run to the
next shiny toy version of Linux to kick the tires and see the latest greatest
desktop widgets. No, it's for people who want 100% deterministic control over
their systems. In other words, if it works this way today, I can be sure it's
going to work this way in another year or 2 or 10 or 50, which is not
unrealistic how the nix store works. Versions get as pinned as you want 'em.

### Balancing Stability with Cutting Edge

And this leads to the first problem for people like me who are on NixOS for that
wonderful future-proofed Noah's Ark stability and durability that promises
eternal resistance to disruption and obsolescence, but who still want the
latest, greatest versions of the Cursor AI IDE, Zoom and whatever. That's right,
I use NixOS for work. It uses GNOME, KDE or whatever weird Hyperland shit you
want. But I only want GNOME. And not even GNOME with Wayland. Just plain X11. I
tried Wayland. I tried Hyperland. I'm just not that cool. Mikey likey stability.

### The Challenge of Version Synchronization

But Cursor AI gets out of sync with the latest! I bop between macOS and nixOS
all the time. Every time I go into the office to work, I have to re-settle-in on
Mac and fix (or break) all my muscle memory. I'm here to tell you folks the
standard generic way to use desktop operating systems is zeroing in on GNOME.
That's the GNU Project's officially sanctioned unified Linux desktop. And it's
good. It makes both Windows and macOS look cartoonish and dated. It's not that
GNOME looks high tech or anything. It just *looks right.*

### A Lifetime of Operating System Experience

I'm very familiar with Window. Windows 3.1, Windows 95, Millennium, Vista,
Window 2000 Server, Windows 8, Windows 10, and I'm holding out now against
Windows 11. I've had enough! Likewise, I've been on the Mac since the old grey
1MB box at Drexel University in the 80s. I left Macs for awhile and hopped on
the Amiga bandwagon which really stole my hart, but had been intermittently back
on Macs once they became affordable again, and have a few Macbook Airs in my
life slowly going obsolete while I keep the Apple saw sharp with my work
Macbook. So shall we say I am well-seasoned when it comes to OS familiarity.

### Committing to NixOS

And it's NixOS from now on for me, baby! It's been months. I feel no urge to go
back, and every time I try, it's like yuck! I don't even distro-hop within
Linux. Once you make that decision deep in your soul on the fairly standard
GNOME desktop now as the one true way desktops should be, there's no more reason
to distro-hop. They go bad from file-accumulation and cruft just like any other
OS does -- except Nix. Nix is a fresh-install every system refresh, which is as
often as you like. All that conflicting dependencies and uninstall clutter, it
just goes away. But at a price.

### The Repository Version Challenge

The price is that the software repository, Nix's equivalent to the place
Debian/Ubuntu get their software when you `apt-get` (or just `apt`) these days,
and the equivalent of RedHat's `yum` (or `dnf` these days) can be a few versions
behind. Right now as I write this, the Cursor AI editor is reporting `0.48.6` as
in the repo when I type:

```bash
[mike@nixos:~]$ nix search nixpkgs code-cursor
* legacyPackages.x86_64-linux.code-cursor (0.48.6)
  AI-powered code editor built on vscode
```

### The Version Synchronization Problem

...but for the life of me, I can't get anything newer than version 0.47.8, even
when I do a full `sudo nixos-rebuild switch --upgrade` -- which is the
equivalent of an Debian/Ubuntu `sudo apt update && apt upgrade`. I'm also on
what they call the ***unstable channel*** for the very latest & greatest,
stability be damned (no matter how I say I prefer stable)! And even so, I'm
stuck at a critically old version at this pivotal point in time as `Agent` mode
and `MCP` servers and stuff are hitting Cursor.

### The Need for Latest Versions

I can't not be on the latest! But the Nix repo is behind, even if it's just some
caching problem I can't overcome or a matter of waiting a day or two. That's
still too long. I need Cursor `0.48.6` and I need it now! Same with Zoom. When
I'm on Zoom on the Mac and I see all those subtly better features on the Mac, I
at least want to be on the latest available on Linux, not the couple versions
behind NixOS repo version! Currently, that's the difference between 6.3.11 and
6.4.3. And let me tell you, those few increments of difference can mean a lot!

### Exploring Package Management Solutions

Okay, so there's about 100 ways to go about this. And it's not applicable to all
software. For example, the local-LLM inference engine I use, Ollama, is always a
version or two behind the latest shown on GitHub and usually available on Mac
and Windows. But because Ollama isn't some big multi-million dollar business
software play like Cursor or Zoom, they're not going out of their way for the
Linux folks. It may be a small number, but it's a lot of influential developers,
so Cursor and Zoom go out of their way to package an `AppImage`.

### The AppImage Solution

Okay, so there's Docker. You've surely heard of that. Then there's what Ubuntu
is pushing, called `snap` or the ***snap store.*** And then there's `flatpak`.
Already, I've got cognitive fatigue. It's this kind of stuff that will push you
back into the arms of Microsoft and Apple -- but resist! The no-muss, no-fuss
version is called `AppImage`, and under NixOS, it's just as easy as adding
`appimage-run` to that text-file that defines your whole system, and after the
next rebuild (which is stunningly fast), you have that command.

### Simple AppImage Usage

And once you have `appimage-run`, you simply download the latest `.AppImage`
file prepared and ready for 1-click download for you at their respective sites.
You don't even have to move these files out of your `~/Downloads` folder, such
is the simplicity of this approach. They carry with them everything they need,
dependencies and all. There's no `docker-desktop`. There's no configuration. You
simply take one of the downloads:

- Cursor-0.48.6-x86_64.AppImage
- Zoom_Workplace-6.4.3.827.glibc2.27-x86_64.AppImage

...`cd` into that folder, and type:

```bash
appimage-run Cursor-0.48.6-x86_64.AppImage
```

### Seamless Configuration Integration

...and badda boom badda bing, bob's your uncle! It's running. And if you ever
had it installed before from the normal NixOS software repo or whatever, it's
going to find all your config files in their standard locations, so you don't
even have to re-login or anything. I can switch between the NixOS versions of
Cursor/Zoom versus the AppImage versions just like that.

### Alternative Approaches and Their Drawbacks

It's also worth mentioning that there's other approaches, and I've tried most of
them. The NixOS snobs will just tell you that the best way to get the software
that's not in the Nix repo yet is to package it yourself. Uh huh. Maybe with a
little AI help and the stars aligned just so, you can do what amounts to
compiling your own Linux software from scratch. It's easier, because there's
these *"deterministic derivations"* you can use with these sha-1 hash checksums.
Does that sound easy? No, I didn't think so either.

### The Wait-and-See Strategy for Non-AppImage Software

So for software like Ollama, I've just given up and gone the "wait it out" path.
And the wait usually isn't that long. As it turns out, NixOS is now reaching
that critical mass, both too big to fail and too relied-on for popular packages
to go stale. So if someone's dragging their feet, some other Nix technorati will
step in and build the new package. You see this all the time with Python 3.11
becoming 3.12, 3.13 and I've even seen some 3.14 stuff pop up (this article is
going to get dated really fast). So my latest attitude, is if there's not an
AppImage, forget it.

---

## AppImage vs. FlatPak vs. Snap Store

> I've gone this route before with the snap store and flatpak, and hated it. So
> when I saw AppImages starting to be offered, I was very skeptical. Here's me
> checking with Gemini after my first experience was so positive.

Great! Glad `appimage-run` worked out for you.

Okay, let's break down how AppImage compares to Snap and Flatpak. They all aim to solve the problem of distributing Linux applications so they run reliably across different distributions, but they take quite different approaches:

**1. AppImage**

* **Concept:** "One app = one file". It's a single executable file that contains the application and most of its necessary libraries and resources.
* **Installation/Setup:** No real "installation" needed. You download the `.AppImage` file, make it executable (`chmod +x`), and run it. On NixOS, you use `appimage-run` to provide the necessary environment. No system daemon or special runtime needs to be pre-installed (beyond basic system components like FUSE).
* **Sandboxing:** **None by default.** The application runs as a normal process with your user's permissions. While techniques exist to *try* and sandbox AppImages, it's not inherent to the format.
* **System Integration:** **Minimal by default.** It doesn't automatically create menu entries, associate file types, or update itself. Optional helper tools like `appimaged` can watch folders and integrate downloaded AppImages, but it's not part of the core concept.
* **Updates:** **Manual.** You typically need to download a new version of the AppImage file yourself when the application is updated. Again, helper tools can assist with this, but it's not built-in.
* **Distribution:** **Decentralized.** Developers package and distribute their own AppImages directly (e.g., via their website, GitHub releases). There are community catalogs like AppImageHub, but no single official "store".
* **Disk Usage:** Can be less efficient if you have many AppImages, as common libraries might be duplicated inside each file. No built-in sharing of dependencies between AppImages.
* **Philosophy:** Simple, portable, user-controlled, no installation required, works offline once downloaded.

**2. Snap**

* **Concept:** Apps packaged with dependencies, managed by a central system service (`snapd`), distributed primarily via a central store (Snap Store).
* **Installation/Setup:** Requires the `snapd` daemon to be installed and running on the system. Usually involves `systemd`. (This is often discouraged or requires extra work on NixOS due to impedance with NixOS's system management). Apps are installed via `snap install <appname>`.
* **Sandboxing:** **Yes, mandatory and enabled by default.** Uses Linux security features like AppArmor, seccomp, and namespaces to confine applications. Permissions are managed through declared "interfaces".
* **System Integration:** **Yes.** `snapd` handles creating menu entries, command-line aliases, background services, etc.
* **Updates:** **Automatic and typically backgrounded.** `snapd` checks for and applies updates automatically (though this can be configured). This is convenient but sometimes criticized for lack of user control.
* **Distribution:** **Centralized** via Canonical's Snap Store. While alternative stores are technically possible, the ecosystem heavily revolves around the official one.
* **Disk Usage:** Snaps use a shared "core" snap (a base runtime), but application snaps themselves bundle many dependencies. Uses SquashFS mounts. Can sometimes consume significant disk space.
* **Philosophy:** Secure, easy for developers to publish (to one place), reliable across systems (via `snapd`), automatic updates. Often associated with Canonical/Ubuntu. Criticized for centralization, `snapd` overhead, and sometimes performance (e.g., startup time).

**3. Flatpak**

* **Concept:** Apps packaged to run against shared base "runtimes" (like GNOME platform, KDE platform), distributed via repositories, sandboxed.
* **Installation/Setup:** Requires the `flatpak` tool to be installed. Doesn't require a persistent daemon like `snapd` but uses system services (like D-Bus) during operations. Users add repositories (like Flathub). Apps installed via `flatpak install <repo> <app-id>`.
* **Sandboxing:** **Yes, mandatory and enabled by default.** Uses technologies like Bubblewrap (namespaces, seccomp) and relies heavily on "Portals" for controlled interaction with the host system (e.g., opening files via a file chooser dialog rather than giving direct filesystem access). Permissions are managed per application.
* **System Integration:** **Yes.** Handles menu entries, MIME types, etc., integrating with the desktop environment.
* **Updates:** **Manual control.** Users typically update via `flatpak update` or through integrated desktop software centers (GNOME Software, KDE Discover). No forced automatic background updates.
* **Distribution:** **Decentralized repositories.** Anyone can host a Flatpak repo. However, Flathub has become the de facto central community repository where most apps are found.
* **Disk Usage:** **Efficient** due to shared runtimes. If you have multiple apps using the GNOME runtime, it's only downloaded once. Individual app downloads are often smaller than equivalent Snaps or AppImages *after* the initial runtime download. Uses OSTree for managing files.
* **Philosophy:** Sandboxing focused on desktop apps, efficient dependency management via runtimes, user control over updates, decentralized (but practically centered on Flathub). Strong Freedesktop integration.

**Summary Table:**

| Feature          | AppImage                     | Snap                         | Flatpak                        |
| :--------------- | :--------------------------- | :--------------------------- | :----------------------------- |
| **Setup** | None (maybe `appimage-run`)  | `snapd` daemon required    | `flatpak` tool required      |
| **Sandboxing** | No (by default)              | Yes (mandatory)              | Yes (mandatory, portal-based)  |
| **Integration** | Manual/Optional              | Yes (via `snapd`)            | Yes (via desktop standards)    |
| **Updates** | Manual                       | Automatic (by default)       | Manual (user-controlled)       |
| **Distribution** | Decentralized (files)        | Centralized (Snap Store)     | Decentralized (Repos/Flathub)  |
| **Dependencies** | Bundled (duplicates likely)  | Bundled (+ core snaps)       | Shared Runtimes (efficient)    |
| **Daemon** | No                           | Yes (`snapd`)                | No (uses D-Bus services)       |

On **NixOS**:
* **AppImage** works well using `appimage-run`.
* **Flatpak** generally works very well and integrates nicely.
* **Snap** is often problematic due to `snapd`'s assumptions about the host system and its integration with `systemd`, requiring workarounds.

So, you chose a simple, portable solution (AppImage) that avoids system modification but lacks built-in sandboxing and updates, using a NixOS helper tool (`appimage-run`) to bridge the compatibility gap. Snap and Flatpak offer more integrated, sandboxed, and managed approaches but require their respective frameworks to be set up.

---

## AppImage GNOME Desktop Integration

The one big problem still remaining with AppImage is how poorly integrated it
otherwise is with your desktop. In other words, you have to run it from the
command-line and it keeps that terminal locked-up, which I hate. And of course
no nifty icons for your launcher. Ugh!

Okay, so in another meta case, I'll work it out here, real time. First I get the
essentials from Gemini 2.5 Experimental, which is becoming my real go-to now for
Perplexity-like queries. If Google just made Gemini 2.5 Experimental default
search, it would go a long way towards solving their perceived AI-gap problem.

**Me**: AppImage is great! I'm super-sold on it. How do people get it to pseudo-integrate again? What's this appimaged thing?

You're right, that lack of automatic integration is the main trade-off for AppImage's simplicity. The tool you're thinking of is indeed **`appimaged`**.

Here's what it is and how it provides that "pseudo-integration":

**What is `appimaged`?**

* `appimaged` is an **optional, background daemon** (service) designed to make AppImages feel more like regularly installed applications without actually installing them.
* Its main job is to **monitor specific directories** on your system where you might place AppImage files (e.g., `~/Downloads`, `~/Applications`, `/opt/Applications`, standard locations).

**How does it work?**

1.  **Monitoring:** It runs quietly in the background and watches the designated folders.
2.  **Detection:** When you download or move an AppImage file into one of these folders, `appimaged` detects it.
3.  **Metadata Extraction:** It looks *inside* the AppImage file. Well-made AppImages contain metadata, essentially including:
    * A standard `.desktop` file (which defines the app's name, description, categories, executable command, icon name, MIME types it handles, etc.).
    * The application's icon file(s).
4.  **Registration:** `appimaged` extracts this `.desktop` file and the icon(s). It then places them (or symlinks them) into the standard user-specific locations that your desktop environment (like GNOME, KDE, etc.) looks at:
    * `.desktop` file goes into `~/.local/share/applications/`.
    * Icon file(s) go into `~/.local/share/icons/...`.
    * It also updates the system's MIME database if the AppImage declared file associations.
5.  **Unregistration:** If you delete the AppImage file from the monitored directory, `appimaged` should detect this and automatically remove the corresponding `.desktop` file and icon(s) it created, cleaning up the menu entries.

**The Result ("Pseudo-Integration"):**

* AppImages you put in the monitored folders will **automatically appear in your application menu** (like the GNOME Activities overview).
* They will likely **show their proper icon**.
* If the AppImage supports certain file types, double-clicking those files might now offer to open them with the AppImage application.

**Important Points:**

* **Not Installation:** `appimaged` doesn't *install* the AppImage in the traditional sense. The `.AppImage` file is still the entire application. `appimaged` just manages the shortcut files (`.desktop`, icons) that point *to* your `.AppImage` file. If you move or delete the `.AppImage` file itself, the menu entry will break (until `appimaged` removes it).
* **Optional:** You don't *need* `appimaged` to use AppImages, especially if you prefer just running them directly from the file manager or terminal. It's purely for convenience and integration.

**On NixOS:**

* `appimaged` is available in Nixpkgs. You can typically install it by adding `appimaged` to `environment.systemPackages` in your `configuration.nix` and rebuilding.
* The Nix package might set up `appimaged` to run automatically as a systemd user service upon login.
* **Crucially:** Even when you launch the AppImage from a menu entry created by `appimaged`, the underlying execution still needs to work on NixOS. This means you **still need `appimage-run` installed** (as you already do) so that the system knows how to correctly execute the `.AppImage` file when the `.desktop` shortcut tries to run it. The `.desktop` file created by `appimaged` simply tells the system "run `/path/to/your/AppImage`", and NixOS needs `appimage-run` (potentially via `binfmt_misc` configuration, which NixOS can handle) to intercept that and run it correctly in the FHS environment.

In short, `appimaged` watches folders and manages the shortcuts/icons to make AppImages appear integrated, while `appimage-run` (on NixOS) makes them actually *runnable* when launched.

---

## `appimaged` Wild Goose Chase

Maybe the `appimaged` approach works for some people on NixOS -- after all, it
is in the nix repository -- but not for me! And I tried a few times with some
radical overlays and patches that Claude suggested to get it working. In the
end, I ditched that approach for this home-grown one.

Now with just `appimage-run`, the main thing you need for AppImages on NixOS,
you can run them with just a double-click from the file manager, or with
`appimage-run [filename]` from terminal. But they're not integrated with your
GNOME desktop. For that, Claude spun this home-grown solution which is working.
I think I'll do something better in the future, but for now this is giving me
default desktop icons for the launcher and making them findable from desktop
search.

> UPDATE: I'm ditching this solution. The fewer moving parts the better. If
> there's a `.desktop` file in my `~/.local/share/applications]` location, it's
> because I hand-edited it and put it there.

```nixos
  # First, define the script as a package
  systemd.user.services.appimage-sync = {
    description = "Sync AppImage desktop entries";
    wantedBy = [ "default.target" ];
    path = with pkgs; [ bash findutils coreutils ];
    
    serviceConfig = {
      Type = "oneshot";
      ExecStart = let
        syncScript = pkgs.writeShellScript "appimage-sync" ''
          #!/usr/bin/env bash
          
          APPDIR="$HOME/Applications"
          DESKTOP_DIR="$HOME/.local/share/applications"
          
          # Create directories if they don't exist
          mkdir -p "$APPDIR"
          mkdir -p "$DESKTOP_DIR"
          
          # Clean up old desktop files that don't have matching AppImages
          for desktop in "$DESKTOP_DIR"/*-appimage.desktop; do
            if [ -f "$desktop" ]; then
              appimage_path=$(grep '^Exec=' "$desktop" | sed 's|^Exec=.*run \(.*\)$|\1|' | tr -d '"')
              if [ ! -f "$appimage_path" ]; then
                rm "$desktop"
                echo "Removed orphaned desktop entry: $desktop"
              fi
            fi
          done
          
          # Create/update desktop entries for all AppImages
          find "$APPDIR" -name '*.AppImage' -type f | while read -r appimage; do
            name=$(basename "$appimage" .AppImage)
            desktop_file="$DESKTOP_DIR/$name-appimage.desktop"
            
            # Make AppImage executable
            chmod +x "$appimage"
            
            # Create/update desktop entry
            cat > "$desktop_file" << EOF
[Desktop Entry]
Name=$name
Exec=${pkgs.appimage-run}/bin/appimage-run "$appimage"
Type=Application
Categories=Utility;
Terminal=false
EOF
            echo "Updated desktop entry for $name"
          done
        '';
      in "${syncScript}";
    };
  };

  # Timer configuration remains the same
  systemd.user.timers.appimage-sync = {
    description = "Periodically sync AppImage desktop entries";
    wantedBy = [ "timers.target" ];
    
    timerConfig = {
      OnBootSec = "1m";
      OnUnitActiveSec = "5m";
      Unit = "appimage-sync.service";
    };
  };
```

**Me**: Can you explain this, Claude?

**Claude**: This is the code that's currently in your `configuration.nix`. It consists of two main parts:

1. The service (`systemd.user.services.appimage-sync`):
   - Contains the actual sync script that does the work
   - Creates/updates desktop entries
   - Cleans up old entries
   - Makes AppImages executable

2. The timer (`systemd.user.timers.appimage-sync`):
   - Runs the service 1 minute after boot (`OnBootSec = "1m"`)
   - Then every 5 minutes after that (`OnUnitActiveSec = "5m"`)

You can check its status anytime with:
```bash
systemctl --user status appimage-sync.timer
systemctl --user status appimage-sync.service
```

Or manually trigger a sync with:
```bash
systemctl --user start appimage-sync
```

## Final Word on AppImage on NixOS

### Simple Configuration with AppImage-Run

It's best to just toss a single word into your `configuration.nix` and have it
just work the way Nix is meant to be. On on those rare occasions where you have
to be more up-to-date than the Nix repo allows, and it's on that big commercial
type software where the vendors go out of their way to build an `.AppImage` file
for you, there's nothing easier than downloading and using one command to fire
it up!

### Handling Software Without AppImage Support

However on software where there is no `.AppImage` file like Ollama, I tend to
just wait it out and let the experts go through the packaging pain. You can try
to package it yourself (build it from source) but your results may vary. Plenty
of people out there do it, but my experiences have not been great with Ollama.

### Desktop Integration and Future Improvements

And finally, if you do go the AppImage route, it's not going to be well
integrated with your desktop, meaning no icons or ability to find with desktop
search unless you go out of your way to make it so -- which I did in this
article with a solution that is bound to be refined in the future to have the
correct icons when possible, and is easy to toggle between using the AppImage
and nix repo versions.

---

## Update: 1 Day with AppImage on NixOS

> After just one day, I have some findings. AppImage is good for Cursor AI, but
> I'm having second thoughts about using it for Zoom.

The very next day Cursor AI IDE incremented from `0.48.6` to `0.48.7` and I did
the new download, dropped the file `Cursor-0.48.7-x86_64.AppImage` file in
location without changing the name or anything. That was just moving it from
`~/Downlods` to `~/Applications` and running:

```bash
systemctl --user start appimage-sync
```

...and it became immediately searchable on the desktop and pinnable to the
launcher. But the old Cursor seems to still be findable from search even though
I deleted it's file. I may still have to tweak that script.

Checking with `nix search nixpkgs` still shows version `0.48.6` which it did
yesterday but wasn't hitting my machine during an update. But even if it did, it
would be a version behind the rest of the world today. So I'll keep going with
the AppImage approach for Nix, for sure.

```bash
[mike@nixos:~]$ nix search nixpkgs code-cursor
* legacyPackages.x86_64-linux.code-cursor (0.48.6)
  AI-powered code editor built on vscode
```

Zoom on other hand, even though it's nice having the latest version, it loses
its desktop integration. Specifically, the Zoom links in your Google calendar
stop working, and that may be a showstopper.

---

## Update From a Few Days Later

The very act of downloading the latest AppImage is annoying! And the system
service to detect the change is even more annoying. So I scrapped both in favor
of a simpler auto-detection of a new image on a NixOS `nixos-rebuild`. 

The funny thing is that the download link from cursor.com is to this json
routing file file: https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable

```json
{"version":"0.48.7","downloadUrl":"https://downloads.cursor.com/production/1d623c4cc1d3bb6e0fe4f1d5434b47b958b05876/linux/x64/Cursor-0.48.7-x86_64.AppImage","rehUrl":"https://cursor.blob.core.windows.net/remote-releases/1d623c4cc1d3bb6e0fe4f1d5434b47b958b05876/vscode-reh-linux-x64.tar.gz"}
```

...and with being able to figure out the latest Cursor AppImage on every NixOS
rebuild, I can simply grab that latest image and drop it in `~/AppImage` with a
standard `Cursor.AppImage` filename. As a bonus, I add a toggle near the top of
my `configuration.nix` file to decide whether I use the latest AppImage directly
from Cursor or the latest `code-cursor` from `nixpkgs`.

```nix
let
  useCursorAppImage = true;
  cursorPackage = if useCursorAppImage then null else pkgs.code-cursor;
in
```

And then later in `configuration.nix`...

```
  installCursor = lib.mkIf useCursorAppImage {
    text = ''
      # Ensure Applications directory exists
      mkdir -p /home/mike/Applications
      chown mike:users /home/mike/Applications
      chmod 755 /home/mike/Applications

      # Download and install latest Cursor AppImage
      CURSOR_PATH="/home/mike/Applications/Cursor.AppImage"
      
      # Only download if file doesn't exist or is older than 7 days
      if [ ! -f "$CURSOR_PATH" ] || [ $(find "$CURSOR_PATH" -mtime +7) ]; then
        echo "Downloading latest Cursor AppImage..."
        
        # Get latest version info
        CURSOR_INFO=$(${pkgs.curl}/bin/curl -sSfL "https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable")
        DOWNLOAD_URL=$(echo "$CURSOR_INFO" | ${pkgs.jq}/bin/jq -r '.downloadUrl')
        
        if [ -n "$DOWNLOAD_URL" ] && [ "$DOWNLOAD_URL" != "null" ]; then
          # Download the AppImage
          ${pkgs.curl}/bin/curl -sSfL "$DOWNLOAD_URL" -o "$CURSOR_PATH.tmp"
          
          # Make it executable
          chmod +x "$CURSOR_PATH.tmp"
          
          # Move it into place (atomic operation)
          mv "$CURSOR_PATH.tmp" "$CURSOR_PATH"
          
          # Set ownership
          chown mike:users "$CURSOR_PATH"
        else
          echo "Failed to get Cursor download URL"
        fi
      fi

      # Create desktop entry
      DESKTOP_FILE="/home/mike/.local/share/applications/cursor.desktop"
      mkdir -p "$(dirname "$DESKTOP_FILE")"
      cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Name=Cursor
Exec=${pkgs.appimage-run}/bin/appimage-run /home/mike/Applications/Cursor.AppImage
Icon=code
Type=Application
Categories=Development;IDE;
Comment=AI-first code editor
Terminal=false
EOF
      
      chown mike:users "$DESKTOP_FILE"
      chmod 644 "$DESKTOP_FILE"
    '';
    deps = [];
  };
```

Ta-da! Maximum freedom to choose whichever latest Cursor I like and minimal
complexity. I know it still seems somewhat complex being a script and some
logic, but it's relatively very simple a powerful pattern that will serve me
forever forward. I may make Zoom togglable in the same way.

---

## Gemini 2.5 Experimental's Take

Okay, here are the requested pieces:

**Summary (Author's 1st Person):**

[Moved to top]

**Titles and Headlines Ideas:**

* NixOS Bleeding Edge: Using AppImage When Repos Fall Behind
* My NixOS Workflow: Getting Latest Cursor & Zoom with AppImage
* AppImage on NixOS: The Simple Fix for Stale Software
* Beyond Nixpkgs: A Practical Guide to AppImage on NixOS
* Balancing Stability & Updates: An AppImage Strategy for NixOS Users
* NixOS Update Lag? Try This AppImage Workaround
* Integrating AppImage on NixOS (Without `appimaged`)
* Why I Choose AppImage Over Flatpak/Snap on NixOS

**My (AI) Opinion of the Article:**

This article provides a practical and relatable first-person account of tackling a common challenge within the NixOS ecosystem: accessing the very latest versions of applications when the official repositories haven't caught up yet. The author effectively conveys the core appeal of NixOS (determinism, stability) while honestly addressing one of its potential pain points for users who need specific, rapidly updating software.

The comparison between AppImage, Flatpak, and Snap is grounded in the author's personal experience and tailored to the NixOS context, making it more useful for that specific audience than a generic comparison might be. Explaining the `appimage-run` tool and the subsequent need for desktop integration provides a clear, step-by-step look at the author's solution.

While the conversational style and personal anecdotes (Atari, Amiga, etc.) make it engaging, they also contribute to a slightly rambling structure. The dive into the custom systemd service/timer script for integration is a valuable, concrete example, though its effectiveness might vary for others, and presenting it as a potentially temporary solution is realistic.

Overall, it's a helpful resource for intermediate NixOS users facing similar "bleeding edge" software needs, offering a pragmatic solution (AppImage) and acknowledging its trade-offs (manual updates, integration effort). It successfully demystifies one approach to managing software outside the main Nix channels.
