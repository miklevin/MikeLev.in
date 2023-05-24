---
title: Levinux Tiny Virtual Linux for Education
description: Levinux is a tiny virtual Linux server built on Tiny Core Linux and QEMU designed to give you a first (sometimes positive) experience with logging into text-based Terminal environments, the ssh command, and the vi editor. Having stuck your hand in the Gom Jabbar, you are now on the path to becoming a literate human.
permalink: /levinux/
layout: default
group: levinux
---

# Levinux Tiny Virtual Linux for Education

## Watch the Opening Sequence of Dune to "Get It"

{% include youtubePlayer.html id="QrCfivcQe48" %}

The Levinux Linux VM is something I built long ago. I'm talking 15 years ago
now. Some of you weren't even born yet. The itch that I was scratching was the
fact that Linux had become the one true path to future-proofing yourself in
tech. Specifically the old fashioned but text-based interface called the
***command-line*** and the SSH command to get to one on other machines. 

But it was scary! And it was hard to get started. So I built Levinux to give
people a taste of it. It was a ***tiny*** Linux server that ran in a ***virt
machine*** whether you were on a Mac, Windows, or Linux machine. It was a tiny
miracle, and still has a fan base today for its original form.

At first I wanted to make Levinux into a whole Noah's Ark for your data,
creating a nomadic floating development environment and code execution platform
that could go onto your USB stick or into your Dropbox and be with you for
life. It was (and still is) a beautiful vision. But I was too early. And my
skills at compiling QEMU C-code and building Linux kernels were not up to the
task. I am just not that kind of programmer. I'm a marketing guy!

But I needed practice. The world needed practice. It's outdated, but still
generally work and you can [get Levinux here](https://levinux.com/).

So why not wrap it in the guise of a sort of low-expectations game? If it works
for you, great. If not, go edit a file in Word or something. The connections to
Alice's adventures going through the Rabbit Hole into Wonderland were obvious
to me, as well as Neo taking the red pill to become aware of the Matrix. But it
took some time to realize I was building the Gom Jabbar pain-box from the
opening scene of Dune.

So are you ready for some pain, my almost human friends? I'm going to give you
a little taste of the pain that is the command-line. If you can ignore the fact
that the smell of your flesh burining is just an illusion, you'll be on your
way to becoming literate. You will be literate enough to realize that the sole
purpose of VSCode is to keep you from discovering the ssh program and its
utility, the vi text editor and its power, and the command-line in general.

You must realize that Microsoft now includes Linux as a standard part of
Windows. They have hired the creator of Python (another sub-theme here in
Levinux), and they have bought GitHub for $7.5 billion. They killed the Atom
FOSS text editor that came with GitHub and baked-in kooky roundabout ways to
use SSH and Git into VSCode that will block you from ever properly learning
them. So everything I'm saying is true and correct, and Microsoft knows it.

You know how much money I make on you? Zero! Zilch! I'm even turning off
monetization on all my YouTube videos to make this point. I can future-proof
you and your tech career for free. I can make you literate. You can believe me
because I ask you for no money. I'm not selling you anything. I'm not even
asking you to buy my book. I'm just asking you to learn.

And that's Levinux. After you're done with this little toy, you move onto one
of the many ways you can have a modern, high-performance Linux server running
on your local hardware, be it a Mac, Winodws, or Linux machine. It's usually a
laptop and it's usually a personal preference. Who cares what it is! The point
is that your "host" hardware and "host" OS don't matter. Only your ability to
quickly rebuild a ***normalized*** Linux server from scratch matters.

No, it's not Docker. Docker is for chumps. You're going to have to learn even
more kooky "compositing" AIs. It's proprietary and locks you into images that
you don't know what's going on. What I'm proposing isn't even as hardcore as it
gets, because there's also ***Linux From Scratch***, which is a whole different
thing. Some Jedi's build their own lightsabers. Not me! Microsoft gave us WSL
and Mac has Multipass. Ubuntu did a lot of the work for us and we're going to
use that.

Now don't get bent on particular Linux repos here. I'm aligning with Debian,
not Ubuntu. And I'm only doing that because the ***snap store*** and Flatpak,
Npackd, GNOME Software and Ketarin... they're all stupid too. I mean you
already have the aptitude (apt) program if you're on a Debian derivative Linux
and you already have the yum program if you're on a Red Hat derivative Linux.
Apt and yum are all you need to build a server "from scratch" quite
competently, without all the overhead of yet-another-docker-thingy.

Low overhead, my friends! High performance. Minimal liability. Reduced
dependencies. We all stand on the shoulders of giants. There's no way around
that. Just know that many of these giants ***want*** you standing on their
shoulders because they plan to eat you. And no, this is not paranoid ramblings
because the solution I'm proposing is a deeply compromised one that the purists
like Richard Matthew Stallman (RMS) would never approve of. He'd tell you if
you want Linux, just run Linux. Or GNU/Linux, he'd say.

The path I'm taking you has you keeping your favorite host hardware, whatever
Apple Mac M2 or Windows 11 slick or cheap or readily available laptop you
happen to have or prefer. Until buying Linux laptops becomes a common thing, we
make do with what we have. But what we have now is the ultimate trick of using
a Linux VM, which all host OSes must now support for credibility as a developer
platform's sake, and ***normalize*** it to run standard Linux cloud code. 

Your Python code won't need its backslashes changed to forward slashes (if your
on Windows), nor will it need your Upper-case home directory paths changed to
lower-case (if you're on Mac). You won't need to homebrew chocolatey snap your
flatpaks, or any of that nonsense. You just run one script and have a fully
functioning, fully standard Linux server that will start running the ***real***
version of Python right in your browser (Edge, Safari, Chrome, Firefox, etc.)

