---
title: Slack & Zoom on NixOS Workspaces
permalink: /slack-zoom-nixos-workspaces/
description: I show how NixOS makes installing Slack & Zoom easy, how I use virtual desktops across OS platforms, and how organizing fixed-position screens helps me stay in the flow with muscle memory guiding my workflow.
layout: post
sort_order: 1
---

## Using NixOS Simplifies Installation of Popular Video Conferencing Apps

Slack and Zoom on NixOS? With a 4K Webcam? Not only is it no problem, it's less
problem than it was on either Mac or Windows. On those platforms you've got to
run installers or get it out of web stores. On NixOS, you just edit the file
that defines your system (`configuration.nix`), dropping in the words `slack-us`
and `zoom` into your `environment.systemPackages` and rebuild. Voilà! Slack and
Zoom are now on your Linux system. And the webcam was just as easy. It's a new
era ladies and gentlemen. Just nobody knows it.

## Using Virtual Desktops for Fixed Positions For Muscle Memory

But now, what screens to put them on. I'm not a multi-screen person. It goes
against muscle memory. Where to look and why, especially when moving between
hardware platforms. NixOS lets your preferred work environment flow like water
and travel with you to whatever hardware situation you find yourself in.
Unfortunately, your monitor situation doesn't flow quite so water-like between
work and home, laptop and workarea. 

## Virtual Desktops Consistent Across OS Platforms

And so, that's where the "fixed positions" of virtual desktops come into play, a
future that's well implemented and even has similar keyboard shortcuts across
Macs, Windows and most distros of Linux. On the different OSes, they're
called... they're called... Hey Perplexity...

**Me**: What do Macs call virtual desktops? What do Windows call them? Gnome calls them Workspaces. Write a little about them and their general horizontal orientation of late, and similar keyboard shortcuts across OSes.

**Perplexity**: Virtual desktops are known by different names across operating systems, but they serve a similar purpose of organizing and managing multiple workspaces on a single screen.

## Terminology Across Operating Systems

**macOS**: Apple refers to virtual desktops as "Spaces"[1].

**Windows**: Microsoft calls them "Virtual Desktops"[2].

**GNOME**: The GNOME desktop environment uses the term "Workspaces"[3].

## Common Features and Orientation

In recent years, virtual desktops across different operating systems have adopted a predominantly horizontal orientation. This means users typically navigate between desktops by moving left or right, rather than up and down.

## Keyboard Shortcuts

Many operating systems use similar keyboard shortcuts for managing virtual desktops:

**Creating a new desktop/workspace:**
- macOS: Control + Up Arrow, then click "+"
- Windows: Windows Key + Ctrl + D
- GNOME: Ctrl + Alt + Up Arrow, then click "+"

**Switching between desktops/workspaces:**
- macOS: Control + Left/Right Arrow
- Windows: Windows Key + Ctrl + Left/Right Arrow
- GNOME: Ctrl + Alt + Left/Right Arrow

**Closing a desktop/workspace:**
- macOS: Control + Up Arrow, then hover over desktop and click "X"
- Windows: Windows Key + Ctrl + F4
- GNOME: Middle-click on workspace thumbnail in overview

While the specific implementations may vary, the core concept of virtual desktops remains consistent across these platforms. They allow users to organize their work by separating applications and windows into distinct workspaces, enhancing productivity and reducing clutter on the screen[1][2][3].

Citations:

    [1] https://www.cnet.com/tech/services-and-software/how-to-use-multiple-desktops-on-one-screen-in-windows-11/
    [2] https://www.howtogeek.com/197625/how-to-use-virtual-desktops-in-windows-10/
    [3] https://www.asus.com/me-en/support/faq/1044672/
    [4] https://www.reddit.com/r/YouShouldKnow/comments/zvr0lc/ysk_how_to_have_multiple_virtual_desktops_in/
    [5] https://www.windowscentral.com/how-use-multiple-desktops-windows-10
    [6] https://support.microsoft.com/en-us/windows/multiple-desktops-in-windows-36f52e38-5b4a-557b-2ff9-e1a60c976434
    [7] https://answers.microsoft.com/en-us/windows/forum/all/how-to-use-multi-desktops-in-windows-10/eb902843-c6bd-466d-a4f8-41a70b806d28
    [8] https://www.pcworld.com/article/1936035/virtual-desktops-more-space-and-order-with-windows-10-and-11.html

## Beating how Apple Conditions You to Their Keyboard Layout

So using virtual desktops is a great way to organize how you work in digital
spaces and have all that finger-training you're doing navigating around not
excessively tied to a vendor like Apple or Microsoft. It's a good way to have
fixed-position places for things even as your precise hardware details change in
life, or even over the course of the day. 

## The 7-Screen Sweet Spot

I like 7 screens to work on. Personal journal on the left. Work journal on the
right. I then bounce left and right along the horizontal ribbon of virtual
desktops. It's dizzying for people unfamiliar with this workflow layout
especially on screenshare, but if it becomes your thing, it's so comfortable.
Subdividing screens into windows is awful. Apps belong fullscreen; at least for
people who rely on their muscle memory for fast action.

## Go-Left, Go-Right, Each End is a Fixed Location

One virtual screen in from left is Cursor AI more and more often lately. And one
in from right is the preview of my (nearing daily) work blog. These are special
spaces because they're fixed-positions (the ends) and easy to get to without
thinking. So are the other screens if you know the keyboard shortcuts, but on
Mac, Windows and Linux, all you have to get into your fingers is "go left" and
"go right" and you're set. It's a great multi-OS muscle memory tactic.

## Messy In The Middle

Screens 3, 4 and 5 are usually some variation of terminals and browsers, the
output of whatever work I'm doing in Cursor and a generic purpose browser for
lookups and surfing. This is a very "fixed position" way of working, especially
the "anchor points" at the very left and very right. I can pop on over to the
left or right and I know what will be there. And the middle isn't so structured.
This way there are about 4 out of 7 ***very fixed functional locations*** and
three in the middle that are a lot more loosy goosy. But only 3 and generally
nothing I have to "find quick".

## I've Switched to NixOS for Work

But now I'm using NixOS during the business workday for work. I'm increasingly
unwilling to switch over to the Mac for work purposes. The era of having to be
on Windows for Microsoft Office software is over, and I'll be damned if that's
going to start again just because I'm on a Mac for the office. I willingly went
onto Mac after a very long stint on Windows and familiarizing myself with the
whole Windows Subsystem for Linux (WSL) thing, and I need that "cool kids" Mac
experience now. All the YouTubers and influencers are on Macs. I'm no stranger
to Macs, but it's always good to refamiliarize yourself with the latest.

## I Can Add An Extra Screen For Flexibility During Work

And during these business hours, I need Slack and Zoom at-the-ready! I need it
in a fixed location, but the 2 ends are taken and I like 7 screens. But we're
flexible. We can add an 8th. My muscle memory is just "modified" during the
business workday. I insert an 8th screen (it will actually be there all the
time). 

## Zoom to The Right During Business Hours

But now, because my image of the 7 screens with the 2 ends is so strong, I just
add 1-screen conceptually to the right as my go-to place for teleconferencing
and instant messenger communication. Distractions are pushed way over to the
right. And bouncing off the right for my work-journal but encountering Slack &
Zoom reminds me to keep my head in the game of client satisfaction. I can't just
be a super-focused developer.

During work hours I use the 8th screen for Slack, Zoom and an instance of my
work-profile browser with my calendar always showing. That way browser-based
message notifications are always enabled and I won't overlook meetings by being
focused and in the flow state. It's also of course a liability for focus, but
it's crammed all the way over there on screen 8.

## Enough Room In The Middle

When it's not work ours, I'll probably move my work journal over to screen 8 and
the blog-preview to screen 7 and have an extra bonus screen in the middle. My
miscellaneous scrap-screens go from 3 to 4. You might ask why not just stick
with 7 screens and move everything left to make room for Slack & Zoom on screen
7? It's because I tried and it puts the squeeze on the miscellaneous screens. 2
isn't enough in the middle. I'd rather have an extra one there after business
hours than too few there during.

I'm sure this makes sense to just about 1 person out there who is unlikely to
ever read this.
