---
title: "From Coleco Adam to NixOS: A Quest for a Deterministic System"
permalink: /futureproof/coleco-adam-nixos/
description: This article explores the journey of finding a stable and reliable computing environment, emphasizing the importance of deterministic systems like NixOS for long-term productivity and skill preservation. It touches upon the pitfalls of traditional approaches to system maintenance and the drawbacks of popular technologies like Docker and complex JavaScript frameworks.
layout: post
sort_order: 1
---

In a world of constant technological churn, where software and platforms become obsolete faster than ever, finding a stable and reliable computing environment is a challenge. This article explores the author's journey through various computing platforms and their eventual discovery of NixOS, a powerful operating system that offers a deterministic and reproducible approach to system configuration. Discover how NixOS can help you escape the upgrade treadmill, preserve your valuable skills, and build a computing foundation that lasts a lifetime.

---

## Note-Taking Evolution 

I have switched to Trilium for self hosted personal notes, the Web interface still has something to be desired compared to the native mobile apps. At least, it gives me something to copy and paste between four idea, transport and long-term archive and organization.

I find Trilium has features that people tout in Obsidian while being truly fully free and open source and easy to install on NixOS. I never heard of it before my research, even though I thought I did, but I was thinking of Joel Spolsky's Trello. It was list management and either case, but the later was gobbled up by Atlassian. Trilium is something new to me, and quite surprising.

## The Octopus Analogy

I'm not gonna talk about  Trilium so much here is how cell hosting became a lot more of a reality under NixOS. I used to talk about tech as being a lot like throwing an octopus up into a tree, and your tech worked so long as it was hanging on for dear life. As time watches on, tentacle after tentacle releases until the octopus falls out of the tree. That's when Microsoft or whoever steps in and forces you to pay for something.

### System Decay

It's really that way in the free open source world as well because after a while, enough installs and removals of software is going to fill your system full of cruft, making it larger less stable, and more unpredictable over time. Files get left behind. Alternative paths to check get longer. The chance of path checking resulting in the wrong library getting chosen gets large larger. Race conditions unwittingly set in.

So if it's not proprietary software, forcing you to upgrade so that they can meet their quarterly revenue numbers, it's the gradual decay  and zombieification of even the champion of stability, Linux. Many people will suggest virtual machines or containers at this point, but I ask why? It doesn't solve the problem of all these problems still occurring in the host OS on the bare metal hardware hosting Docker. You are just doubling or quadrupling the surface area and complexity of your system, depending on how many docker images you use.

## A 40-Year Journey

### The Coleco Adam Years

Arguably, I've been fighting this problem for 40 years ever since my first computer, the Coleco Adam. Now it was actually incredibly stable. It was just a soon to be dead platform with very little that I learned to transferable to other platforms. It was one of the earliest examples of how very little of your muscle memory beyond mirror keyboard might be transferable with bad platform choices. Unless you count how to load programs from digital cassette tapes counts as useful (hint: it's not).

### The Commodore Amiga Era

#### The Two-Disk Boot System

It turns out that the lessons I learned from the second computer after that, the
Commodore Amiga were as useful as the Coleco Adam's lessons were unuseful. The
whole system got loaded from disk right down to the kernel. First, Kickstart.
Then, Workbench. I never understood it in those days, but this two disc load
technique spared them from paying a few extra dollars per machine for a ROM
which would've had to have been upgraded constantly anyway. With two disks, they
could change the personality of the machine right down to the lowest level on
every operating system upgrade.

#### Flexible System Configuration

And such, an Amiga user could have radically different systems based on their
start disks. Yes, this was typically before even hard drives were commonly
available. A hard drive was a luxury. So if you were using a large program, it
would be the third disk you put in. And if you didn't have two floppy drives,
you were gonna be doing a lot of disc swapping every time it needed to retrieve
something from the operating system while you were using the third-party
program.

#### Early Seeds of Modern Systems

This complete personality-shifting of the Amiga based on the boot disks gave me
a taste for something that wasn't VMs and wasn't containers, but was much more
like a retro game console cartridge, or what I came to know as the Raspberry Pi
SD-cards. And while the concept of a server-build script wasn't quite there yet,
there was this wonderful Unix-like AmigaDOS operating system and a standard
`startup-sequence` that gave me a nice preview of Unix universiality. That
universal underlying OS is an important step towards a generic
infrastructure-as-code (IaC) system like nix that lets you deterministically
build your whole system from a script.

#### The Unix Connection

Although technically AmigaOS was based on TRIPOS and not Unix, it was still very
Unix-inspired and plenty of the know-how I got from my Amiga days carried over
when I took up Linux &#151; different than the Coleco Adam's utterly proprietary
and dead-end EOS (Elementary Operating System) and OS-7 operating systems.

## Modern System Management

### The Raspberry Pi Perspective

I didn't realize it at the time, but I was learning more of a cartridge based approach to hardware akin to game consoles. Today people might know this as how the Raspberry Pi works with microSD cards. It's actually quite easy to swap the boot drive out. You would hardly think of using docker with a Raspberry Pi because of all that overhead on a platform where you're trying to stay efficient, and you can just install everything you need directly, and then image the whole SD card. In a lot of ways, it's like docker then, but instead of all the overhead of two systems, you have just made your first system much easier to swap out.

### Beyond Simple Imaging

Even in this Raspberry Pi scenario, you are still dealing with disk images, much like docker files or ISO images. What if you want to expand or change the image? What if you want a different software load? Do you have to choose which image to start with, install software and then image the disk again for archival purposes? This is not a very pleasant iterative process. Shouldn't your systems be able to iteratively get better overtime? Shouldn't you be able to tweak and refine without all this full system imaging overhead nonsense?

## Infrastructure Complexities

I have layered in the Trilium self hosted notes app which has considerable details to work out when adding to the master image, to my system. Is it going to only run on the machine you install it on, which is kind of server like? Or are you going to host it to other devices? On the Internet at large and dealing with all those security issues were just to devices on your LAN at home? And if only on your home network, what about the security there?

So it's not merely installing software at a certain point as if a Mac or Windows machine that you're trying to back up and restore with your programs and personal data. At some point, it becomes more like a whole IT infrastructure with all the details of how servers host and secure apps. Instead of just imaging a hard drive, you are imaging a whole network configuration. And there needs to be someway to rehydrate it all.

### The Home Server Challenge

People with media servers  like Plex at home they have encountered these issues. Throwing the octopus up into the tree is bad enough when it's just a laptop. But imagine now all these nuanced little details of a home network. The common, overtrained wisdom of the LLMs right now at this point is to use Docker with some form of junior Kubernetes like the Docker desktop on the server or k8 or one of the other infinite varieties of doing this.

## The NixOS Solution

Using virtual machines or containers is just one form of black boxing components of your system so you don't have to think about them. But it causes bloat, docker composing complexity (one more kooky temperamental API) and doesn't really solve the file cruft and lack of a master orchestrator at the parent OS or bare metal hardware first OS installed layer— the octopus can still fall out of the tree.

Other solutions exist, which are also black boxing components of your system, just had a much better point. The point at which all problems are solved is by black boxing your components in the server build a script that builds that parent bare metal OS onto the hardware. If it were a Raspberry Pi, it would be like having a script that builds the operating system image onto the SD card in the first place.

When you build your server (or merely "home machine") from a script, value is then no longer in the SD card image— a black box that you might like to look into and have more fine grain control. The value becomes in the script itself that builds the black box. NixOS is that. It's why it's such a big deal in such a small crowd. Few know they have this itch. Fewer still have researched how to scratch it beyond the LLM over-trained disservicing Docker approach. If fewer than that still have spun their own versions of Linux to scratch this itch themselves. I did that. That was Levinux— disposable QEMU servers built from recipe scripts. NixOS, and Guix (the other entry into this deterministic server script building space) kicks Levinux's ass. And I'm glad. I've been waiting for these.

## Reflections on Progress

Now I can iteratively improve my home system over time. I imagine if my first Coleco Adam system were built from some sort of deterministic script and the concept of "home machine" for life got into my head. How much further along would I be in preserving all my skills, future proofing and resisting obsolescence now, 40 years later? A heck of a lot further, is the answer. But I was not ready then, and I don't think the system themselves were either. I was born the same year as Unix was invented (and not 50 miles away) — where most of this repurposeability of components and portability of software comes from.

### The Long Road to Understanding

It took another half century, practically for me to piece together all the parts. Or perhaps more technically, wait for the parts to be invented and peace them together as they are. And even then, sometimes it takes a decade for those parts to come to my attention (nix). Or perhaps it's not merely come to my attention, but to be refined enough for a more typical member of the public, such as myself to be able to use (nix again).

### Embracing the Present

So instead of lamenting the world that could've been, I am rejoicing the world that is. I am totally immersing myself in it and trying to make it bear the fruits of reward — which will double as validation that I am correct, if indeed I am. I keep an open mind even to that. There are opposing camps of learn, fast, relearn, often, and spend tons of money for power tools from vendors. There is legitimacy to that. Why learn anything if everything you know is just going to change and a power-tool you get to work at-hand done faster, anyway?

### Building the Essential Toolkit

It took me a while, but I also added  GIMP and Inkscape to the list of apps that get installed by default at that parent bare metal home OS level. Anything that I think is fundamental that should cut through the years goes there. I say this, as if there were lower levels of virtualization like Docker images or VMs. There's not. Or there need not be. Instead, you can have kind of like flakes or shards of OS that wedge in from git repository folders. These are typically your development environments and can carry versions of Python, NodeJS or anything else you want isolated and sharable. They're called Nix Flakes, or `flake.nix` files.

### Cross-Platform Solutions

And if everything I said, hasn't been amazing enough, these next flakes can actually run out of the sub directories or folders of Mac and Windows systems as well. This effectively solves the "It doesn't run on my machine" problem. This seems hard to believe, but to hit the point home further all the little nuances in details that go wrong on a platform like macOS where all the cool kids are have been solved by a company called Determinate Systems that picks up where the default Mac Nix installer (not bad in its own right) leaves off. They had things like uninstall, and survival of Nix through macOS upgrades.

### Windows Integration

On Windows? Better still! Microsoft has gotten into 90% of the way with their window subsystem for Linux (WSL). So just use NixOS directly on that, or if you prefer, let it install Ubuntu by default and use the nix command from within it as the ultimate interoperability layer, wiping away any Linux distro dependent weirdness (apt vs yum vs pacman).

### The Depth of Possibilities

I feel this article could go on forever as I had other things that have been layered onto my  `configuration.nix` file that builds home. And the pedantic Nix-aware out there hearing me say this builds home might want to chime in at this point and talk about Nix Home Manager. And yes, indeed, this rabbit hole goes as deep as you want it too. You could manage a separate home profiles under nix. I don't. There's a certain point that once you simplify, you stop turning the dial again towards complex. Or perhaps more accurately, you don't turn it more towards complex then your particular situation demands. But you have peace of mind that if your situation became more complex, the dial goes to 11.

### The Promise of Iterative Improvement

And so, to bring this all home the point is that constant iterative improvement is actually possible on the computer system you call home — be it your laptop or some complex web development server type machine.

### A Message to Young Developers

If you're a young person starting out, and you want your accomplishments to sort of compound and snowball overtime without the giant reset button of tech being pressed on you, which is a young person you have probably not encountered much yet, this provides a path. But having not lost a decade of expertise to such things as Macromedia Flash (.flv/.swf) or Active Server Page (.asp) going away, you haven't felt the pain yet.

### The Coming Changes

You younguns have no itch to scratch. You have battle wounds still to suffer. You don't see it, but the same thing is about to happen with the NodeJS full stack, React and single page applications (SPA) because the plethora of new web crawlers out there are not gonna spend the resources to execute your JavaScript. Google might. But everyone else is gonna flip the bird at you and go crawl somebody else's data who makes it easier. If websites are to be influencers, they must be HTML.

### The Return to HTML

And so perhaps this brings me to where I want to end this article. The poignant point that should resonate. HTML is making a comeback. It's a 30 year-old technical specification regarding hyper text, which has a unique future proofing and obsolescence resistance aspect to it. This is what the web was born on. That is the fire that fueled its growth, and this little JavaScript infatuation we've gone through is so that over-schooled comp-sci graduates can turn everything into a large enterprise project with multi-user, concurrent scaling and security concerns that we mere mortals really need to deal with every day in our humble little Jupiter Notebook where we just want to practice our programming literacy.

### Conway's Law and Complexity

Their concern is to introduce Conway's Law into every endeavor so that they or someone with their same credentials and worldview must be in the picture to keep the machines running. Conway's law approximately states that every project will become as complex and convoluted as the people working on it. Their concerns become your concerns. But as soon as you start talking about a single machine and apps that are never gonna be hosted on the web at large, these concerns change and complexity plummets. The impossible becomes possible. The possible becomes trivial. The trivial becomes muscle memory and habits. Muscle memory and habits becomes modern programming literacy.

    React? Redux? Retreat!
    I won't admit defeat.
    There once was AJAX.
    Today, it's hx
    Determinate Nix be elite.

    Simplicity can rule the day
    Pipulate shows you the way.
    It's like a framework
    But pattens we shirk
    So hydrate that nix flake away!

    We want a vacation to sink
    Deep down where we no longer think
    And lose track of our code
    Down sovereignty rode
    Into their piggyback — CLINK!

    I'll tell you that most satisfaction
    Comes from a craft where a fraction
    Of noise that we're sufferin
    To build that MacGuffin
    Is needed. It's all a distraction.

    It is Linux, Python and git
    That principally is always fit
    As one valid way
    To save the day
    Letting you make it from bit.

    Yes, freely with words I'm a wheeler
    For open source is a bold dealer
    While the rabbit hole's deep
    It's not so black what you seek
    Isn't found with a minimal feeler.

    Assume how that it could now be
    The time where the singular we
    Need align US with THEM
    So as boss we can STEM
    Tides bad to what we'd rather see.

    If you read all the way here to this
    Come on let me give you a kiss
    It's easy to make
    Those who made a mistake
    Get canceled. Yet still we persist.

---

## Article Categorization Ideas from Gemini

This article explores the journey of finding a stable and reliable computing environment, emphasizing the importance of deterministic systems like NixOS for long-term productivity and skill preservation. It touches upon the pitfalls of traditional approaches to system maintenance and the drawbacks of popular technologies like Docker and complex JavaScript frameworks.

Here are some headline ideas:

* Escape the Upgrade Treadmill: Achieving Computing Longevity with NixOS
* NixOS: A Stable Foundation for a Lifetime of Computing
* From Coleco Adam to NixOS: A Quest for a Deterministic System
* The Power of Simplicity: Why NixOS is the Future of Personal Computing
* Stop Chasing Technology: Build a System That Lasts with NixOS

Here's an introductory paragraph:

> In a world of constant technological churn, where software and platforms become obsolete faster than ever, finding a stable and reliable computing environment is a challenge. This article explores the author's journey through various computing platforms and their eventual discovery of NixOS, a powerful operating system that offers a deterministic and reproducible approach to system configuration. Discover how NixOS can help you escape the upgrade treadmill, preserve your valuable skills, and build a computing foundation that lasts a lifetime.
> 
 
