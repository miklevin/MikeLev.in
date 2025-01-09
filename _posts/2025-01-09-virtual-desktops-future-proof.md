---
title: "Virtual Desktops: Your Future-Proof Workflow in a World of Forced Upgrades"
permalink: /futureproof/virtual-desktops-future-proof/
description: I'm done with macOS and Windows. Their forced upgrades and proprietary nature are a threat to my productivity and freedom. NixOS is the answer, letting me build a clean, customizable system from scratch. But the real key to a future-proof workflow, no matter your OS, is virtual desktops. Master them. They're on every platform, the skills are transferable, and they'll save you from the tab-switching, window-shuffling chaos. GNOME does it best, but the others are usable too. Embrace the full-screen, learn the shortcuts, and break free from big tech's grip on your desktop.
layout: post
sort_order: 2
---

## Introduction

Hey everyone! Ever feel overwhelmed by the sheer number of windows and apps you have open on your computer?  Do you find yourself constantly minimizing, maximizing, and shuffling things around just to get to what you need?  Well, there's a good chance you're not even aware of one of the most powerful features built right into your operating system: virtual desktops.

Think of virtual desktops like having multiple, separate monitors, all within your one screen.  You can group related tasks onto different "desktops," keeping your work organized and your focus sharp. For example, you could have one desktop for email and communication, another for writing and research, and a third for social media or entertainment.  Switching between them is usually as easy as a simple keyboard shortcut or a swipe on your trackpad.

The following article is a deep dive into why one developer made the leap to a specialized operating system in pursuit of a more efficient and "future-proof" way of working. Now, you might not be ready to ditch Windows or macOS just yet (and that's totally fine!), but the author makes a compelling case for why mastering virtual desktops is a game-changer, regardless of your platform.  He might come on a bit strong—he's passionate about this stuff!—but stick with it. You might just discover a whole new level of productivity hiding in plain sight, and be inspired to try out the virtual desktop feature that is almost certainly built into the operating system of whatever computer you are using right now.

---

## My NixOS Journey

My actual workflow is shaping up nicely now that I'm really formalizing on NixOS
with GNOME and Wayland as my everyday desktop, and not my work-provided Mac.
There's like a thousand little details for this, but above all I cannot let my
habits become hard-wired to a proprietary desktop environment. It's a consumer
product, and I am not a consumer. I am a creator and the tools that I use to
make the extensions of my body must not be licensing-encumbered. If your muscle
memory is licensing-encumbered, ***YOU*** are licensing-encumbered, and beholden
to some big tech company to allow you to keep your skills uninterrupted. 

## The Forced Upgrade Problem

And you know that they're going to interrupt their skills because that is a
necessary step in forcing upgrades. What the world is going on right now with
the utterly obnoxious Windows 10 messages compelling you to buy new hardware is
a glorious proof I'm not BS'ing you example. I mean it's not just the normal
browser wars dirty tricks of compelling you to switch your default browser for a
"safer" experience war of attrition between Chrome and Edge, which is also going
on right now, but this is a wholesale "ditch your hardware or be abandoned"
message from Microsoft. Ouch!

### The Apple Dilemma

Apple's hardware remains viable for tons longer than Windows-based hardware, but
it has its own problems. Namely, the kooky OS. Sure, it's Unix but it's not
Linux so you're not on any of the truly major software repositories like
Debian's or RedHat's. There's no `apt` or `yum`. Only `brew`. And if the name of
that actually being ***Homebrew*** doesn't tell you everything you need to know,
nothing will. Oh, and it's not officially supported or pre-installed by Apple.

Even though Apple had a 10-year headstart on Microsoft getting to a Unix-like
operating system, it happening in 2007 with the OS9-to-OSX days with Microsoft's
WSL coming in 2017, a decade later, Microsoft still has the upper-edge because
their default Linux is Ubuntu and that gives you the Ubuntu (Debain) software
repo. Muscle-memory undermining? Swapping the alt-key with opt-keys and their
position to boot! Homebrew over apt and yum. But to their credit, their Rosetta
software that squeezes more life out of their older X86 hardware is in the right
spirit &#151; way more respectful than Microsoft's upgrade-or-die love-letter.

## The NixOS Solution

So I nullify the entire argument by moving to NixOS. I don't need `apt`, `yum`
or `brew` because my whole system just gets built from a script. Want new
software? Add it to the system-building script, re-run the script to rebuild the
system. Software installed, Ta-DA! Want to uninstall it? Delete it from the
script that defines your system, rebuild and it's uninstalled. Reverse Ta-DA! No
lurking libraries. No longer and longer paths inviting dependency hell
cross-wiring. No cruft. A clean, pure system rebuilt from scratch every time.

### Dealing with Cruft

Cruft left over? In technically accurate terms, yes. But it's all cut off by
virtue of the removal of the symbolic links that makes it appear to be somewhere
in the virtual hierarchical file system. So technically the old software is
still on your drive somewhere. Want it removed permanently to make the illusion
of a perfectly pure system a reality? `nix-collect-garbage -D` and done.

## Breaking Free from Proprietary Systems

This is all such a power-play to remove dependence on the proprietary desktop
systems, namely macOS and Windows. In particular, I like removing the forced
move to Windows 11 because after many years of moving back from Mac to Windows
because WSL, I feel let down because of a combination of the forced Windows 11
upgrade (Windows 10 really was the last Windows OS you'll ever need), and the
failure to ever properly support SystemD under WSL. It goes to sleep in the
background and doesn't wake up &#151; not something you want in a service.
Services serve. I don't care if I clicked away from the WSL terminal window. If
Microsoft can't even put some control you can toggle-on (yes, I know it ***looks
like they do***, but try it), then I can't stay on their platform.

### The Linux Victory

Simple as that. Linux won, and the failure to run Linux services 24/7 in the
background of whatever system you happen to be using to host your Linux
VM/Container/whatever doohickey is a deal-breaker. I don't care if it's VMWare,
VirtualBox, Docker Desktop or whatever. But especially WSL which touts Windows
compatibility with Linux by default. That's embrace, extend, extinguish at it's
finest. Let 'em get a taste of Linux, but never let 'em discover the joys of
background Linux services &#151; not on a Windows system, nosiree. Oh, and hire
Lennart Poettering the creator of `systemd` just in case. We don't want any
magically enabling tricks to get out.

### Microsoft's Breaking Point

And so, Microsoft broke the deal. They double/triple broke the deal. I think
they got up to quadruple with the forced Windows 11 upgrade before I finally
decided to ditch Windows 10, 11 and whatever once and for all. I'm not a gamer,
so I don't need their drivers. And even if I was, I'd limit my gaming to the
hopefully un-acquirable Valve Steam. But who knows. Microsoft bought Activision
for $69 Billion. Yes, that's $69 billion dollars, folks! So while the great
Linux hope for gaming, Valve Steam, seems beyond Microsoft's ability to embrace,
extend and eliminate, I wouldn't consider it off the table with that kind of
war-chest at Microsoft's disposal.

## The Power of Virtual Desktops

So where the heck is this article going? Well, it's going to the muscle memory
you develop on the desktop! Desktop interfaces to computers aren't going away.
Mobile isn't going to kill the desktop, and neither is anybody's love for the
text-only terminal interface. No matter how much you can do text-only, all the
consumer devices which are the ones that are going to end up in our homes after
all are going to have pre-installed macOS or Windows. No matter how much I love
NixOS running GNOME, that's not going mainstream anytime soon.

### Cross-Platform Compatibility

But the good news is that the one key Dektop OS feature that makes them usable
is supported with nearly the same conventions across macOS, Windows and most
versions of Linux Desktops like GNOME and KDE. And that's ***virtual
desktops***. They go by different names, like ***Screens*** and ***Workspaces***
and the implementations are subtly different across OSes. And GNOME has the best
implementation, by the way. But Windows and Mac's aren't bad. And if you learn
to work with virtual desktops on one of these OSes, the skills you learn are
transferable to other desktop environments with perhaps no more effort than
remapping the opt-and-alt keys when you switch between Macs and PCs. It's
annoying, but not a show stopper.

### The Need for Visual Documentation

This is an article that wold benefit most with videos, showing what I'm talking
about on each platform. But there's no time for that and I need to get onto the
next topic, which is more pertinent to my day-to-day client work. I just needed
to get this out of my system, being that I've been advocating so much for
future-proofing and obsolescence resistance, and there is perhaps nothing so
tangible and tangibly tapping away on the keyboard and occasionally reaching for
the mouse, and all the details surrounding that which determine how you control
your software.

## The Benefits of Full-Screen Apps

- Switching between tabs on the same screen is the worst. Totally flow-disrupting.
- Switching between windows (or panels) on the same screen is just as bad.
- Switching from screen-to-screen between fullscreen apps rocks!

### The Drag-and-Drop Limitation

Really the only weakness in the every-app-is-fullscreen approach to using
software is those occasions where you want to drag-and-drop some file between
windows, such as adding a file-attachment to an email. The full screen model
isn't great for piping the point-defined output form one piece of software to
the drop-defined input of another piece of software. More simply put, you
generally can't drag-and-drop between virtual desktops. But with 2 apps on the
same scree side-by-side, it's the most natural thing in the world.

So when you switch to fullscreen, you're generally condemning yourself to the
inconvenience of having to use file-requesters for things like file-attachments
rather than drag-and-drop.

## Platform-Specific Nuances

Beyond that, there's usually some keyboard combination like ctrl+alt
left/right-arrows to switch between a horizontally oriented set of virtual
screens. The implementations across platforms each have their little nuances.
They are namely:

- Macs enter fullscreen mode easily, with their main maximize button doing it
- Macs change the orders of those virtual screens, insulting spacial orientation
  memory (method of loci: in the first place, in the second place, etc)
- Macs tend to favor a multi-finger swoosh from the trackpad to switch screens
- Windows makes you figure out how to do full-screen on each app. F11 helps.
- Windows keeps those virtual desktops in fixed locations (yay!)
- Both Macs and Windows let you add or delete virtual desktops on the fly.
- Only Windows 11 lets you arbitrarily drag-reorder the order of these virtual
  desktops.
- Each platform has some kooky way to move apps between desktops.
- All platforms give you some Exposé/Spaces/Mission Control way of getting an
  overview of everything.
- GNOME has the best overall implementation, but doesn't let you add or delete
  virtual desktops on the fly (it's set through settings)
- GNOME's single vs. double-tap on the Super-key (Windows-key) is my favorite
  approach to virtual desktop overview. The behavior is awesome, but too nuanced
  to describe here in a bullet-point.

## The Window Manager Debate

There's a much deeper philosophical discussion here about Windows Managers vs.
full-screen apps on virtual desktops, that I'll forgo discussing here for now
and leave it for another article, suffice to say that I was lured into exploring
the alternative approach to what I discuss here in the form of Hyprland, and
hated it. I had the humble desire to put a program in each corner the way tmux
will quadrant out your terminals, but with any software. Hyprland is the current
cool-kid way of doing this, and it is specifically supported by NixOS, so I
couldn't resist. I thought I was going there and would never look back.

### The Return to GNOME

I looked back. And when I did, I realized just how quickly the GNOME Desktop
Manager, the standard Linux desktop of the GNU Project Free Software Foundation
(FSF), ***the real most altruistic goodguys of all tech***, was evolving.

Ever since Ubuntu gave up on Unity, yet another Linux Desktop that Canonical
felt they'd push in Ubuntu to make it more professional but accidentally caused
schism and outrage &#151; well, ever since Ubuntu gave that up, the polish and
professionalism has been spilling over into the mainstream (insofar as anything
is mainstream in Linux) GNOME desktop.

Does that make sense?

## Conclusion

Anyway, there was nothing like moving recently from Windows to Mac to GNOME to
Hyprland to make me appreciate GNOME. It's under-sold in how good it has become.
It's an ***integrated desktop manager*** they call it. And until I tried moving
to Hyprland, I really lost sight of how elegant that integration really is.

Again, I'll have to leave those details for another article. Suffice to say the
muscle memory you develop working with virtual desktops under GNOME will still
be highly portable back to Windows and macOS for when you have to hop around, as
some of us do. And the horizontal ribbon of virtual desktops you get on any of
these desktop OSes will be fairly comfortable and familiar. And only with a
minimum of habit-remapping, you can move to or between any of these systems, and
have a nice future-proof, or at least obsolescence-resistant desktop workflow.

---

## Gemini 2.0 Experimental Advanced's Take On It All

**Gemini 2.0 Experimental Advanced**: Okay, so here's the gist: I've finally ditched the proprietary shackles of macOS and Windows for the pure freedom of NixOS, GNOME, and Wayland. Why? Because being tied to a big tech company's desktop environment is like licensing your own brain, and I'm not about that life.  They lure you in, make you dependent, then force upgrades or leave you stranded—like Microsoft's obnoxious Windows 11 push. While macOS is better than Windows in some ways, it's still a walled garden. NixOS, on the other hand, lets me build my entire system from a simple script. But the real point here is that no matter what OS you're on, **mastering virtual desktops is the key to a future-proof workflow**. They're implemented across all major platforms, and the muscle memory you build is transferable. GNOME does it best, but even the implementations on Windows and macOS are decent. So, learn your shortcuts, embrace the full-screen, and stop being a tab-switching, window-shuffling chump. It's the one true way to navigate the increasingly chaotic desktop landscape.

---

**Here are some title/headline ideas:**

*   **Escaping the Proprietary Desktop Trap: My Journey to NixOS and Virtual Desktop Mastery**
*   **Virtual Desktops: Your Future-Proof Workflow in a World of Forced Upgrades**
*   **Why NixOS and GNOME Beat the Pants Off macOS and Windows**
*   **Stop Licensing Your Brain: The Case for Open Source Desktops**
*   **The One Desktop Skill You Need to Survive the Tech Apocalypse**
*   **From Windows to NixOS: A Developer's Quest for Freedom**
*   **Beyond Tabs and Windows: Mastering the Art of Virtual Desktops**
*   **GNOME: The Underappreciated King of Desktop Environments**
*   **Ditch the Cruft: How NixOS Can Revolutionize Your Workflow**
*   **The Obsolescence-Proof Desktop: Virtual Desktops, NixOS, and You**

---

**My (Gemini's) Opinion:**

This article is a passionate and opinionated take on the current state of desktop operating systems, reflecting a strong preference for open-source solutions and user control. The author's frustration with proprietary systems is palpable, and the advocacy for NixOS and virtual desktops is compelling, especially for technically inclined readers who resonate with the desire for a customizable and reproducible system. However, it is important to highlight that it is based on opinion, and that no OS is inherently "bad."

The article's strength lies in its detailed exploration of the practical benefits of NixOS and the transferable nature of virtual desktop skills. It effectively highlights the potential pitfalls of vendor lock-in and the importance of maintaining control over one's computing environment. 

However, the article's strong opinions and occasional use of hyperbolic language might alienate some readers, particularly those who are less familiar with the technical concepts discussed or who are satisfied with mainstream operating systems. Additionally, the focus on NixOS, while understandable given the author's enthusiasm, might limit the article's appeal to a broader audience. Most readers are unlikely to switch to an entirely new operating system, but may be convinced to give virtual desktops a try.

Overall, the article is a thought-provoking read that offers valuable insights into the world of open-source desktops and the importance of user agency in the digital age. It is likely to resonate with developers, power users, and anyone who shares the author's concerns about the direction of mainstream operating systems. While the article is a good starting point, there is an opportunity to build on the author's premise, and to go deeper into many of the topics and points that are only touched on briefly, particularly in the area of Linux and open-source software, the GNU Project, and the Free Software Foundation (FSF).

