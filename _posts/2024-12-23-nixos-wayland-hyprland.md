---
title: Taking The NixOS Wayland Hyprland Plunge!
permalink: /futureproof/nixos-wayland-hyprland/
description: 
layout: post
sort_order: 2
---

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

Anyhow, I've watched the equivalents of AeroSnap on Linux over the years, never
really taking the plunge because I was not on Linux day-to-day enough to make
the investment of habit and muscle memory into something that was
screen-subdividing&#151;not really my thing. I'm a fall-screen app person. So if
and when I do take up some Linux AeroSnappy thing, I want it to be like learning
to ride a bike. I want to it once and just have the habit serve me well from
then foreword. Virtual screens met that criteria because they mostly work the
same way across Macs, Windows, and GNOME and KDE on Linux. The implementations
are all so nearly identical (except the Mac ***CHANGES THEIR ORDER ON
YOU!!!***). But not so with the window managers like BSPWM, I3, Awesome and DWM.
There's a slew more, the way these things tend to be on Linux, and that
fragmentation and uncertainty about which I want getting into my fingers just
works against me taking up any at all. No sirree! It's full-screen for me!

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
associated with: NixOS and Arch? Because that's exactly what Hyperland is; as
cool as all that.

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

So this is me preparing to take the plunge. Electron apps, which is what VSCode
is, which is what one of my latest tools Cursor AI editor, is forked from. So
I'm in a double whammy Venn diagram of likely to have problems: Nvidia card and
needing to run Electron apps. Slack and Zoom are also both Electron apps which I
use for work, and amazingly NixOS really is my daily machine for work as well.
Wow, I can only imagine when I screen share clients and folks into my Hyperland
machine. Oh, this is part of the magic show! So much more to say about how much
of what I do now involves a local LLM which people will just assume it's
something special that can only run on a machine like this, but then I'll be
like no, here's a command to type and Chip O'Theseus&#151;that's what I call my
local LLM&#151;can jump over to your Macbook and run there just as well.

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

