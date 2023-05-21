---
date: 2022-10-15
title: Practicing What I Preach
headline: "Exploring the Future of Operating Systems: Reflections on LXD Linux Container Jupyter Platform and Microsoft's NT System"
description: I've been busy with work and family, but I'm recommitting to writing in my journal. I'm exploring the LXD Linux Container Jupyter platform, which has been challenging but rewarding, and Microsoft's NT system, which has enabled the creation of protection rings and running concurrent operating systems. I'm amazed at how Microsoft is transitioning into the future, and I'm reflecting on the fundamentals of object-oriented and concurrency that remain.
keywords: Journal, LXD Linux Container Jupyter platform, Microsoft NT system, Protection Rings, Concurrency, Object-Oriented, Operating Systems, Hardware, Multitasking, SEO, Data Work, Writing, YouTube, Abstract Thinking, Rabbit Holes, Virtual Development Environment, Portable, Platforms, Strategy, Tools, Technology, Future
categories: success, youtube, seo, rabbit holes, future, operating systems
permalink: /blog/practicing-what-i-preach/
layout: post
---


Where oh where has Mike been? I've been a busy boy. When I am silent here and
on YouTube, it means things are a poppin professional-side. See, as much as I
love to write here in my public-facing MikeLev.in journal, it's secondary to
what's going on with work and child, my two great priorities. It would not be
that way if I did not love each so much. Finding what to do with myself is
pretty easy because I find it easy to "find the love" in all things fatherly
and... and what? A friend asked me recently what I did and answering SEO (for
search engine optimization) would simply not be enough. I am a data jokey. I
know how to access and pull data from all kinds of systems, dealing with all
the tricky authentication issues that pop up. I then know how to... well, it's
a long story. Let's jut start with this journal.

It's going to get published more frequently; more consistently over time, that
is for a combination of reasons. It's the main gist of what I have to
contribute to the world. Just keep writing. Just keep moving forward. Live
moves on, and so must you with it. And you need a way to process your thoughts,
to help achieve clarity, to flesh things out pencil-stroke by pencil-stroke
through life until you've drawn quite a good enough picture to sum up your
life. For that's all you can really hope to do if you want to leave something
behind, with the short attention-spans of our descendants, you had better sum
it up quick. Who were you and why should anyone care that you were here?
Well... that's where processing your thoughts begin. Go meta only with great
caution.

Every line of reasoning here, to go more abstract, thinking about thinking and
such is a bottomless rabbit hole, ala Alice's Wonderland, which is why those
classic two books are referred to so much in mathematics literature. One must
just back off of thinking in excessively meta-terms, even while
journal-writing, or one risks a denial to the self of getting into the zone or
flow states. Your internal artistic performers and lovers of whatever
activities you're getting absorbed into don't enjoy real-time critical judging
and heckling. Telling yourself things are stupid as if through the eyes of
others while you're trying to get into something you enjoy is a form of
self-sabotage. It kills our invaluable child-like curiosity state over time and
cuts us off from becoming dynamic, learning personalities like a child earlier
in life. Don't read the German philosophers too young. There's time for
nihilism later.

To escape bad rabbit holes, you rapel down into them rather than leap
head-first. Nine out of ten rabbit holes are wonderful life experiences and are
mistakes or learnings, side-adventures or whatever that you should have had.
They help you grow and become a better person. You wouldn't know how it was
like on the other side if you didn't try things. Thing is, it's tough to know
what to try. It's tough to know if you're dealing with that tenth rabbit-hole
that'll getcha.

Think Tom Sawyer, Huckleberry Finn. Or of course Dorothy and Alice. I find it
interesting that on the male coming-of-age literature it's on the Mississippi
River and deals with slavery, while with the female characters, it's all in
dreams and fairylands. Either way, rabbit holes are rabbit holes, and some you
won't ever come up from. This in itself is neither good nor bad. It depends on
the nature of the rabbit hole, and what it brings out in you.

If the thing that's absorbed you and become the center of your universe is a
passion you can enjoy a full life through, such as mathematics, music or art
then by all means, dive down that rabbit-hole and never come up. However, in
the case of drug or media-consumption, come up! Come up quick! If you're not
exercising one of those special qualities it is to be human, than you might as
well have been born sheep.

Ah, one of my first real beliefs. Having been born human, or existing in this
world from the unique perspective such as we do, it feels like value. There is
here a thing of value in living this life such as we do. We've been fortunate
enough to be given a turn at steering a bunch of stuff in this thing we call
our lives, using to do it the tool of language which is in itself inadequate to
quite capture the totality of the experience. The concept of the sum somehow
being greater than the parts keeps intuitively reoccurring. Somewhere I feel
the assertion that life is Maxwell's demon. There would not be unusual little
corpuscles of intelligent order were matter not somehow inclined to work that
way. Life is an order-generating creative force within all matter that fights
to overcome the second law of thermodynamics. Life is the opposite of
loss-of-information through heat. Life is smart information-preservation
systems.

Okay, so my mind is in some strange places this morning. And I still need to
get the grocery shopping done soon. And I want to crank out some more videos on
the modern toolification movement. LPvg toolification.

Yup. I think I've got some keywords. Both unique and deep. If I use a domain
for it, it'll be lpvg.org, one of the best I own. Okay, now think! Next steps!

Well, a few words about the work stuff that's kept me so off-YouTube and
off-blogging is settling into the LXD Linux Container Jupyter platform. It
subtly feels like a new platform, a bit more flaky like the Amiga. Lots of
Python kernel restarts when RAM memory or hard drive space gets small. I've had
to wrangle my scripts to make sure their memory-bound bottlenecks don't cause
spontaneous Python kernel reboots when running the script, which in this case
is on a JupyterLab server running on an LXD Linux container under the Windows
Subsystem for Linux (WSL). It's one of the tricker tricks I've pulled off
lately with lots of Levinux vibes.

Levinux is a respin of Linux I did over a decade ago to see if I could create a
portable virtual development environment that I could instantiate (with session
persistence, saved files available, etc.) on different platforms such as Mac,
Windows and other Linuxes. The answer was yes, I could. It used very popular
binaries of the QEMU PC Emulator, which has since become a core component for
Android development, combined with an extremely tiny version of Linux called
TinyCoreLinux. TCL works a tiny bit like Debian with a software repository, but
in most ways, it's like a tiny embedded Unix. While Levinux was fun to play
with (even today), it ultimately got replaced by the maturing of
containerization technologies.

More precisely, the realization of my hardware-independent portable development
platform is only barely here today. Those following in my footsteps are still
on the bleeding edge, bleeding on the edge of Microsoft's implementation of
Linux as WSL. It's a two-edged sword and I mean to dull one of those edges by
teaching everyone how to jump onto the actually significant Linux container
movement (LXD vs. Docker) from the Windows platform. Providing the ability for
users to have this opportunity is in my mind the purpose of NT, the Microsoft
"Next Technology" upon which all modern Microsoft computers are built.

NT, which eventually replaced Windows 3.1, Windows 95 and others like it with
underlying DOS (the "disk operating system" of the early Bill Gates era) with a
more memory-managed and permission-aware system. Some call them protection
rings, but that sounds too much like protection rackets to me and just too
perfect to describe the behavior of a company like Microsoft. Anyhoo with
protection rings, you can have code executing in "spaces" rigidly isolated from
each other at the OS and nearly-hardware level sufficiently to run concurrent
operating systems (and their kernels) safely. I was an Amiga user, which
inherited its preemptive multitasking system from TRIPOS of BCPL heritage, in
which such protections didn't exist. Amiga crashed... a lot.

NT-derived OSes like the Windows 10 & 11 we're on today are wonderful examples
of OSes that are designed to multitask side-by-side on the same hardware with
resources competently divvied out due to both hardware and software features
designed to make precisely this possible. A modern Windows system running the
Windows Subsystem for Linux is a wonderful example of the realization of this
vision. Wow, what a platform migration strategy! I think Microsoft is
navigating its way into the future better than IBM did when it was yanked out
of the spotlight. Microsoft knows how to weave together a transition strategy.
We are in the midst of it. It's fun to watch.

Okay, tools fit you like a glove. Gloves are tools, so it only makes sense. It
won't take long before a good tool starts feeling like an extension of your
body. Your ability to hold in your mind a simulation of that tool so that you
no long need to consciously think about it while using it (being in the zone)
makes that tool the same thing as an internal part of you. It is an internal
simulation of that tool in your mind that makes that tool so extremely useful
to you. There's little more personal than tool selection and use.

Yet with the casual changing of user interfaces, both hardware and software, by
manufacturers of tools, we are provided precious little chance to master the
user interfaces over time, thus becoming forever more capable and valuable.
The system is designed, almost rigged, for quite the opposite. Without
sufficient re-training, re-learning, re-experience-acquiring, you go old and
obsolete fast. Sure, it's easy to learn a novel new thing for the first time,
use that power to do a few impressive tricks, then to become unhireable after a
short while because it wasn't just-the-right trick for the new style of
trickery.

Much in tech falls into these categories. There's always some sexy new approach
or methodology that changes everything. Sometimes the significance is not
over-exaggerated. But there are now finally enough battle-tested time-proven
tools and methodologies that can be called "fundamentals". While it's true,
reductionism and new discoveries can always challenge fundamentals, they're
always still there working for you, as time-tested and battle-hardened as they
are. Stuff like "Object-Oriented" and "Concurrency" get layered-on


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/tried-to-start-a-project/">Tried To Start a Project</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/being-on-your-own-in-life/">Being On Your Own In Life</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/success/'>Success</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/rabbit-holes/'>Rabbit Holes</a></h4></li>
<li><h4><a href='/future/'>Future</a></h4></li>
<li><h4><a href='/operating-systems/'>Operating Systems</a></h4></li></ul>