---
title: Slack & Zoom on NixOS
permalink: /slack-zoom-nixos/
description: 
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
work and home, laptop and workarea. And so, that's where the "fixed positions"
of virtual desktops come into play, a future that's well implemented and even
has similar keyboard shortcuts across Macs, Windows and most distros of Linux.
It's a good way to have fixed-position places for things even as your precise
hardware details change in life, or even over the course of the day.

## The 7-Screen Sweet Spot

I like 7 screens to work on. Personal journal on the left. Work journal on the
right. I then bounce left and right along the horizontal ribbon of virtual
desktops. It's dizzying for people unfamiliar with this workflow layout
especially on screenshare, but if it becomes your thing, it's so comfortable.
Subdividing screens into windows is awful. Apps belong fullscreen; at least for
people who rely on their muscle memory for fast action.

One virtual screen in from left is Cursor AI more and more often lately. And one
in from right is the preview of my (nearing daily) work blog. These are special
spaces because they're fixed-positions (the ends) and easy to get to without
thinking. So are the other screens if you know the keyboard shortcuts, but on
Mac, Windows and Linux, all you have to get into your fingers is "go left" and
"go right" and you're set. It's a great multi-OS muscle memory tactic.

Screens 3, 4 and 5 are usually some variation of terminals and browsers, the
output of whatever work I'm doing in Cursor and a generic purpose browser for
lookups and surfing. This is a very "fixed position" way of working, especially
the "anchor points" at the very left and very right. I can pop on over to the
left or right and I know what will be there.

But during business hours I need Slack and I need Zoom, and I got them working
under Linux NixOS (easily) and I'm increasingly unwilling to switch over to the
Mac for work purposes. The era of having to be on Windows for Microsoft Office
software is over, and I'll be damned if that's going to start again just because
I'm on a Mac for the office. I willingly went onto Mac after a very long stint
on Windows and familiarizing myself with the whole Windows Subsystem for Linux
(WSL) thing, and I need that "cool kids" Mac experience now. All the YouTubers
and influencers are on Macs. I'm no stranger to Macs, but it's always good to
refamiliarize yourself with the latest.

