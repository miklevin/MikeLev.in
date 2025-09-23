---
title: 'The LPvg Stack: Future-Proofing with Linux, Python, Vim, and Git'
permalink: /futureproof/lpvg-stack-future-proofing/
description: 'I believe the key to future-proofing your tech skills lies in a specific,
  powerful toolset: Linux, Python, vim, and git, or ''LPvg''. I''m not here to give
  you easy answers but to guide you through a set of technical recipes that build
  real, lasting prowess. My journey led me through the limitations of technologies
  like Docker and WSL to the realization that Nix offers the ''Holy Grail'': a truly
  portable, persistent digital home. This book is my argument for choosing robust,
  slightly difficult tools over the fragile, black-boxed systems that dominate the
  industry, teaching you to wield technology like a secret weapon.'
meta_description: "Discover how to future-proof your tech skills with the LPvg stack\u2014\
  Linux, Python, vim, and git\u2014and build a persistent digital home with Nix."
meta_keywords: LPvg, Linux, Python, vim, git, Nix, future-proof, Docker alternative,
  containerization, virtualization, digital home, planned obsolescence, tech skills
layout: post
sort_order: 5
---

## Setting the Stage: Context for the Curious Book Reader

Welcome to a deep dive into future-proofing your technical skills. This chapter explores the philosophy behind the LPvg stack—Linux, Python, vim, and git—arguing that true technical prowess comes from mastering a core set of powerful, enduring tools. The author charts a personal journey through the limitations of popular technologies like Docker to the discovery of Nix, a system that promises a truly persistent and portable digital 'forever-home.' It's an opinionated guide to choosing robust, effective tools over fragile, mainstream alternatives.

---

## Technical Journal Entry Begins

Welcome to Mike Levin's Little Book of Tech, aka *How To Future-Proof Yourself
In The Age of AI.*

This is a treatise on why your technical skills revolve about Linux, Python, vim
and git — the platform collectively known as "LPvg" and how to get from here to
there. 

We would xalso accept LPvg+"n" as all things `*nix` are honorary members of this
tiny tool-stack for both writing and running code including Unix and the Nix
cross-platform normalizer in particular. 

The author intends for this work to be a blend of the classic texts *Shrunk and
White's The Elements of Style* which I will completely violate, *Sun Tzu's The
Art of War* and *The UNIX-HATERS Handbook.* By the end of it you should be
cursing me for promoting anti-patterns that the world will tell you are wrong
but they will work for a unique set of concerns and use cases that they are not
thinking about: increasing your *timeless tech skills* in a way that is
*compatible with* and *assisted by* but *not dependent upon* AI.

**Faux Rule #1:** Punctuation always belongs *inside* the asterisks you're using
to italicize a word if that word ends up at the end of a sentence so that the
period gets *italicized too.* The alternative is *weird*.

**Faux Rule #2:** Yes I am talking directly to you. It may not seem that way at
first and there's a lot of reasons you may think the opposite is true such as
taking to AI because no one else would read me. But no; I have you in mind. 

**Faux Rule #3:** This book is not done and never will be. It hist gets
"extracted" or derived or summarized or synthesized or perpetually spun into
different formats for different audiences from illustrated children's books to
raw source. Book done. You can stop now. 

For those of you who got past Faux Rule #3, congratulations! You have an
attention span longer than a gnat and could be the next Einstein and this book
is for you to test exactly that. Or maybe it's your AI that might get that smart
and not you. But then maybe it could help you get a leg up over the competition
in *whatever* world we're heading into. Who knows. Not me. I don't know shit. 

I don't provide answers although I might encourage you to question. I'll give
you one very well-trodden set of technical recipes that if you follow the
instructions repeatedly enough you'll gain an odd set of skills that I really
don't think will ever go obsolete — but all cards on the table I don't *really
know that either.* It's the classical problem of induction, but we'll get to
that later. 

Making predictions is the best we can do — unless you're using the *random walk*
algorithm in which case you might just do better than predictions and "bump
into" the right answer to a question you didn't even think to ask. But you'll
know it when you see it. Yeah, this book is just like that. 

## The Illusion of Progress and Planned Obsolescence

In the early days of Roomba, the little round puck robot vacuum cleaner, it had
a lot less robot intelligence than it does today. Primitive Roomba's just sort
of crisscrossed the room backing up and turning and little and retrying each
time it encountered an obstacle and in this way could get a whole room more or
less vacuumed after 2 or 3 passes. Random walk.

How much better really are today's camera-equipped cloud-connected versions
transmitting who knows what back to mama? Better enough to give up the
simplicity of the simple much lower cost random walk models?

On December 23, 1924 leading international lightbulb manufacturers gathered in
Geneva, Switzerland to form the Phoebus cartel which forced you to buy new
lightbulbs after 1,000 hours of use. Prior to that lightbulbs could last 2,500
hours or more. Random testing was instituted to fine lightbulb manufacturers
who violated this rule. This is a fact. It formally lasted until WW2 but the
practice of planned obsolescence carries on to this day. You can fact check that
as much as you like. Tech is designed around quarterly profits and not you the
user. 

Technology stands for techniques of doing a thing which stands for human skills.
One of those human skills is figuring out how to require *less humans* to a
thing. Human techniques lead to less-human techniques until it is inhumane. We
get isolated from the butchering and stop thinking about it as such. I am not a
tree hugger, but I'm just saying look at factory farming. 

Technology inevitably progresses forward  because those who master it live and
those who don't, die. Things are rarely that simple but this one is. The tribe
that's better fed and rested and who has time to prepare for an event and is
equipped with better tools than the other side, wins. They can use the element
of surprise and ambush. I **AM** the bush. Surprise! Who wins?

## Technology as a Secret Weapon

Fire is used to keep predators away in the dark. Wheels are used to move the
previously unmovable. Bow and arrows to replace prey-chasing hordes of
spear-throwers. Long V-shaped converging walls on the savanna are used to funnel
unsuspecting panicky herds off a cliff. Who eats better that winter? And all
those bones for tool-making! Which tribe wins when that one encounters the great
unwashed masses of the tired and poor out there on the migration routes?

The history of tech is brutal but I'm advocating humane behavior even though I'm
gonna teach you how to use certain bits of modern tech to that Eureka
moment-like outside the box *drive off a cliff* surprising effect. The best tech
is surprising and a little bit difficult — with a slightly steeper barrier to
entry and learning curve than you might want. If it weren't that, everyone would
be using it and the specialness of secret weapons would cease to be. The best
secret weapons are the ones you could lay down in front of any opponent and
you'd still be fine because they lack the whatever-it-take to pick it up and use
it. 

This book is about getting you over that obstacle. Imagine their surprise when
they underestimate you in a situation where the secret to your success is all
around you, permeating every nook and cranny of the environment around you. How
much the more sweet when you can walk into those situations completely empty
handed and still enjoy those same competitive advantage... EVERY TIME? Over the
decades? Across problem domains (fields or area of specialty)?

I already told you the answer. It's Linux, Python, vim & git with an honorary
shout-out to Nix because it's just different enough from most distros of Linux
that it has to be enumerated as its own thing. And I guess Nix is the best place
to start. Nix is the most important thing. 

## The False Prophet: Limitations of Mainstream Virtualization

You're still here? Your mother was a hamster and your father smelt of
elderberries. Now go away, or I'll taunt you again.

Still here?

Okay, yes I am talking directly to you. It isn't easy admitting that Nix is the
most important thing in the world (of tech?). These things evolve and someday it
may be the GNU Project's greatly equivalent Guix (pronounced geeks), but whether
it's Nix or Guix the concept is the same. 

But before I tell you about that, I'm gonna tell you about the false positive of
the most important thing: LX. Or LX+"D" in particular. It used to be LX+"C" but
the C has been demoted to just the container-file holding the hard drive system
image and not the *"daemon"* aka *Linux Service* running the show. So yes we're
already diving in the deep end of why Docker isn't the best container format and
what I thought was the best path to future-proofing before discovering Nix. 

All tech since the original C-compiler Dennis Ritchie first wrote to compile
Unix for Ken Thompson has been *virtual machine*-based. The virtualization is
shoved around. Sometimes it's in the *compiler* like with C. Sometimes it's in a
*runtime engine* like with Java. But the virtualization layer is always there
somewhere because hardware is too complicated for there not to be one. Without a
virtualization layer to map, one set of standard machine instructions to some
kooky unique hardware, software would have to be written for each piece of
hardware specially and specifically no matter how small the difference between
hardware.

This VM (virtual machine) trick goes back farther than C to B and before that to
BCPL from Martin Richards of the University of Cambridge in 1966 and before that
from CPL (Combined Programming Language) and so on back in infinite regress back
to the Big Bang. A lot of technology vendors like Sun Java like to pretend they
invented it but they didn't. It's all repackaging of an old and necessary idea. 

## It's Virtual Machines All the Way Down

Once you have a virtual machine layer you don't want another virtual machine
layer because with each additional layer to you go a lower and lower common
denominator losing both the specialness and experience of your hardware. Old
Amiga Computer users know this but they don't know the AmigaOS is a direct port
of an OS written in BCPL called TRIPOS. This is like a bizarro cousin to Unix
and the Amiga command-line interface (CLI) had an awful lot in common with Unix
and thus Linux of today. 

It's always virtual machines all the way down, but hopefully just one step. 

And in that spirit early Unix machines (and probably others too) learned how to
not create yet another layer of virtualization but instead just manage local
resources so that it *looks like* you're virtualizing between different
operating systems running on the same hardware. This was done by just swapping a
bunch of "pointer" to change where things get loaded from off of the root
directory of the system — aka *changing root* or **chroot.**

`chroot` has been around since 1979 but nobody knew how to use it nor was chroot
available on Windows — being a Unix/Linux thing as it was. So in 2013 when Linux
and the Mac were popular Docker repackaged chroot with a much better user
interface and surrounding infrastructure, called it docker and pretended they
invented containerization as a practical alternative to virtualization. In 2016
Windows released their Windows Subsystem for Linux (WSL) and could play too. So
finally, there was a pretty easy way to get the same system "to run" across many
different host operating systems. 

The downside is that docker images are immutable. Immutable is a fancy way of
saying they can't be changed. While unchangeable disk images are a nifty way of
distributing prepackaging software, this was not the itch I was trying to
scratch. Docker couldn't be used for your base-system, not unless you never
wanted any changed to it. 

There is a technology called Docker Composer for composing multiple docker
images into one system, but now you've got massive quantities of blackboxed
systems (enormous surface area), challenges getting them to work together and
you still haven't solved the problem that your base system couldn't be written
to if it too was a docker image. So much for containerization as an alternative
to virtualization as a real nomadic digital home, right? 

## The Holy Grail: A Persistent Digital Home

The basic idea is that you would have a hard drive that could boot on any host
hardware you plug it into and when you move that drive around that system would
come back up exactly the way you left it. This universally interoperable
persistent digital home is a bit of a Holy Grail in the world of tech. It seemed
unachievable even though I gave it a pretty good shot with a circa 2010 effort
called Levinux based on QEMU, a PC emulator rather than virtualization — a
subtle distinction. I got it so that Levinux was a 20MB (not GB) tiny Linux
disto that deflated and ran on the desktop of Macs, Windows or other Linux's
with a double click, and was persistent to boot. 

Levinux was awesome but ultimately relegated to be a learning tool novelty —
mostly because AI wasn't around at the time to help get me over the
cross-platform C-compiling of static binaries complexity. But Linux persists to
this day acquiring new fans and curiously seekers and Linux tire kickers getting
their first `*nix`-like OS command-line interface experience. I packed it like a
game challenging you to log into it with a terminal like PuTTY, edit a file with
`vi` and see the local webpage hosted off of your own machine update. I then
challenged the user to `sudo em -rf /` carrying on my tradition of encouraging
people to have experiences with anti-patterns. 

What about mutable containerization? Surely there was a version of Docker that
could let you update a system drive without all that fragile composite overly
acrobatics and hullabaloo. That's the very definition of harmful abstractions to
a primary concern — my concern being a forever-home in digital realm. It sounds
so reasonable!

And indeed the makers of the popular Linux distort Ubuntu, Canonical, released
just such a tool. LXC. Done. Oh wait, it's now LXD. Okay, done. Oh wait, you
still need a HOST operating system. Hmm. I guess they want you to use Ubuntu,
right? And that's the default of the Windows `wsl --install` command so you just
install Linux on Windows and use WSL as a shim to LXD, right? WRONG! If you can
actually manage to pull that off (which I did) then Windows puts all your Linux
system services to sleep 8 seconds after you click away from the Ubuntu terminal
and there's not a damn thing you can do to change that. 

If there were I'd have stopped looking and probably still be on Windows today
confident that I could always use whatever outer host OS as a shim for LXD but
because Microsoft hired Lennart Poettering the actual other of the Linux daemon
systemd system *and still wouldn't let Linux services run 24x7x365 no matter the
`.wslconfig` and `wsl.conf` edits — inside the container outside the container
it didn't matter. Nothing panned out. Maybe there were obscure registry hacks
that could do it but if that's what it took I wasn't interested.  

## The Final Straw and the Hunt for a Real Solution

If I put Windows aside I could use LXD with Macs and or other Linux distros as a
shim but by that time I was exhausted and fed up with anything even resembling
fragility. I needed rock solid. I needed a modern Levinux designed from the
ground up by more dedicated brainiacs to the cause than I was capable or willing
to be. So I went on a hunt to satisfy all those finicky "anywhere can be home"
requirements of an LX/Levinux and I found Nix. 

It's like Nix was talking directly to me as surely as I'm talking directly to
you. I cannot describe to you how uncanny this all was right down to the
coincidence of the naming convention. For a long time now I knew it was all
about `*nix`. As I said before, `*nix` is absolutely the most important thing in
the (tech) world to anyone who had their head screwed on tight.

---

## Book Analysis

### Ai Editorial Take
This entry is a potent blend of a personal manifesto and a technical guide. Its primary strength lies in its opinionated, narrative-driven approach to complex topics, making them more engaging than a dry technical explanation. The journey from the frustrations with mainstream tools like Docker to the 'Eureka moment' with Nix is a powerful story that will resonate with developers seeking robust, non-proprietary solutions. The core 'LPvg' concept provides a solid, memorable framework. The raw, unfiltered voice is a significant asset that should be preserved and honed, not diluted, during the editing process.

### Title Brainstorm
* **Title Option:** The LPvg Stack: Future-Proofing with Linux, Python, Vim, and Git
  * **Filename:** `lpvg-stack-future-proofing.md`
  * **Rationale:** Clear, keyword-rich, and directly states the core concept (LPvg) and the primary benefit (future-proofing).
* **Title Option:** Your Digital Forever-Home: The Case for Nix
  * **Filename:** `digital-forever-home-nix.md`
  * **Rationale:** Focuses on the 'Holy Grail' concept and highlights Nix, which the author identifies as the most important discovery.
* **Title Option:** The Art of the Secret Weapon: Tech That Lasts
  * **Filename:** `art-of-the-secret-weapon-tech.md`
  * **Rationale:** Captures the author's metaphor of using specific tech as a competitive advantage and a core theme of the text.
* **Title Option:** Beyond Docker: A Journey to a Persistent Digital Environment
  * **Filename:** `beyond-docker-persistent-digital-environment.md`
  * **Rationale:** Targets readers familiar with existing containerization tech and positions the author's solution as the next evolutionary step.

### Content Potential And Polish
- **Core Strengths:**
  - Possesses a strong, unique, and compelling authorial voice that blends technical expertise with philosophical musings.
  - The narrative arc detailing the journey from Docker's limitations to the discovery of Nix is a powerful and relatable story for many developers.
  - Effectively connects specific technical choices to broader concepts like planned obsolescence and long-term skill relevance, giving the advice more weight.
- **Suggestions For Polish:**
  - Structure the 'Faux Rules' and initial philosophical points into a more formally defined introductory chapter to set the stage.
  - While the narrative is strong, incorporating more concrete, step-by-step code examples or 'how-to' snippets for beginners would broaden the audience.
  - Clarify the distinction between emulation (QEMU), virtualization, and containerization (chroot, Docker, LXD) with a concise analogy or diagram early on.

### Next Step Prompts
- Generate a detailed chapter outline for 'The LPvg Stack' based on the provided text, creating dedicated sections for the history of virtualization, the critique of Docker, the failed experiment with LXD on WSL, and the ultimate arrival at Nix as the solution.
- Draft a technical tutorial titled 'Your First Hour with Nix,' explaining how to set up a basic, persistent environment as described in the journal entry, ensuring the tutorial maintains the author's conversational and slightly provocative tone.
