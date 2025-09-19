---
title: "Breaking the Adobe Tax: A Practical Guide to Software Freedom"
permalink: /futureproof/breaking-adobe-tax-software-freedom/
description: "I'm trying to cut through the noise and myths that keep people chained to expensive software subscriptions. It's not about being a hardcore developer; it's about realizing that learning a few key commands—figurative magic words—in the terminal can give you lifelong ownership of your digital tools and skills. This isn't just theory; I'm laying out the exact, practical steps to install a powerful local-first application, proving that true software freedom is just a couple of commands away."
meta_description: Escape costly software subscriptions like Adobe's. This guide shows how to use the Unix terminal and Nix to install free, local-first apps for life.
meta_keywords: FOSS, open source, proprietary software, vendor lock-in, Adobe tax, Unix terminal, command line, Nix, Pipulate, WSL, local-first software, GIMP, InkScape, Blender, software freedom
layout: post
sort_order: 1
---

## Setting the Stage: Context for the Curious Book Reader

This entry dives into the philosophical battleground between proprietary, subscription-based software and the world of free, open-source alternatives. It champions the idea of "digital sovereignty," where investing a small amount of time to learn foundational tools grants users freedom from costly vendor lock-in. The discussion centers on the Unix terminal—a powerful, text-based interface available on macOS and Linux (and now Windows via WSL)—as the gateway to this independence.

The author argues that while commercial products like the Adobe Creative Cloud offer polished convenience, they effectively rent skills back to the user, creating dependency. This piece serves as both a passionate bluebrint for embracing slightly more "difficult" tools and a practical guide to getting started. It uses the installation of a specific local-first web application, Pipulate, via the Nix package manager as a concrete example of how a few "magic words" in the terminal can unlock powerful, free-for-life capabilities.

---

## The Illusion of 'Easy' and the Price of Proprietary Handcuffs

It is impossible to avoid *some* "magic words" — the perquisite knowledge
required to utter them correctly. All the best high tech spells have just a
little bit of this you must cast. Everything else is consumer products designed
to install easily and shake you down for money.

If you want to cast powerful spells of automation that don't break the bank,
you've got to be ready to learn a thing or two. But only *a thing or two.* You
don't need to memorize the whole darn Unix command-line spellbook.

The penalty if you don't pay with just a little bit of your time to learn a new
and slightly unusual or difficult thing is being limited to products designed
with a very consumer-lean to them. Such consumer-focused products have gone to
considerable lengths to purge out the strangeness and difficulty so you can
start using them right away and feel like you got your money's worth. Anyone can
take up quickly. And correspondingly, such consumer-oriented products are
unlikely to offer you very little ability to competitively differentiation. 

### FOSS vs. The Adobe Tax: Why GIMP and Blender are Different

But what about Photoshop, you ask? That's consumer-facing and anyone can take it
up and produce work far beyond the capabilities of other people using the same
product. The argument that *the specialness is in you and not the tools* is
valid until you realize that going this path *locks you into those expensive
proprietary products.*

There used to be something called the *Graphic Artist's Guild* and all graphics
artists were a member. You got stuff. Today the guild is your Adobe Create Cloud
Suite Handcuffs whatever they're calling it lately. You've gotta pay your $500
to $1000 per year to Adobe to play or your skills go away.

Your hard-won internalized muscle memory skills, something inside you like an
extension of of your body — the way musical instruments are to a musician or
sporting equipment is to an athlete — is not inside your body and does not
belong to you in the proprietary software world. It's rented and is taken away
the moment you stop paying your annual tithe to the Adobe *hold-your-skills
hostage* racket. The alternative is the aptly named GIMP. At least InkScape has
some suggestion that you might *escape* in the name. GIMP on the other hand is
brutally honest about what you can expect.

If you're into 3D at least there's Blender. That started out with
profit-incentive in the proprietary software world and miraculously and against
all odds contributed its wonderful self to the free and open source software
community once Autodesk 3D Studio Max at the low-end and Maya 3D at the high end
(now also Autodesk) ate its lunch (I'm partial to LightWave 3D myself as an old
Amiga Computer buff but that's another story). 3D modeling software is a rare
exception where the free and open source software (FOSS) is as good as the
commercial stuff. Yay Blender!

But everything else is a little different. You've got to live with sub-standard
versions insofar as the quality standards of commercial software goes if you
want free-as-in-freedom for life. You can always get free-as-in-beer because all
the vendors will give you the first does of something free. Then you're gonna
develop habits, eventually pay, and get locked in for life. Truth.

So if you want free-as-in-*libre,* prepare to use some slightly more difficult
software — but that doesn't necessarily mean worse nor worse results. It just
means steeper up-front start-up cost. But you'll get over it because now you
don't have to pay the half-grand Adobe-tax every year and you can always have it
in your back-pocket for the once-a-year emergency project that calls for it, or
just practice when the mood strikes you.

So yes, you can be a super-powered InkScape or GIMP user. It happens. I'm expert
at neither but can squeak by on both. All that layer and bitmap vs. structured
graphics and selection stuff is the same everywhere. They all copy each other.
Learn one, learn them all. It's just which one you become spontaneously expert
at in that muscle memory musical instrument flow-state way is the question: ones
where you have to pay (and keep paying) someone the privilege of our
internalized skills to be usable or ones where you don't.

## Debunking the Myths: You Are Not the Product

There are myths perpetrated to keep you in this mode of thought. The first is
*If you're not paying for the product, you are the product.* FALSE. True
altruistic software like GIMP, InkScape and even Linux itself prove that false.
There are good guys in tech. There are people dedicating big chunks of their
lives to projects so that you can enjoy the fruits of their labor out of passion
and love of the craft. Don't buy the line about *nothing's free.* Plenty's free.

But without the polish of commercial software, the cost is your time. Yeah,
that's true. No myth there. You're gonna pay with your time. Totally worth it.
Master a few tech crafts that will be with you for your entire life. Stick it to
the vendors.

Another falsehood is that the pace of change is just so fast that by the time
you learn something it's already obsolete and you just have to live with it —
somehow that the hamsterwheel churn of tech is just inevitable and you have to
accept that. FALSE. That's only true of proprietary software that's trying to
get you to pay for everything over again for the sake of quarterly profits — or
better still: get you on a perfectly predictable recurring revenue subscription
plan that you set it and forget it.

Don't buy it. Quite literally, don't buy it. If you don't buy it in the first
place and start the cycle of Mac/Windows/whatever-dependency, you won't have to
break the cycle. Proprietary software from public companies exists for one and
one reason alone: so that they can meet their legal responsibility to turn a
profit for shareholders. That's capitalism, baby! And I'm not actually opposed
to it. I just think choice is important. You need to understand *column-B.*

### Your Gateway to Power: The Humble Unix Terminal

Alright, so what about right now. What about the *now moment?*

Here and now, I'm talking about Unix Terminal.

Don't go running for the hills just yet.

## Magic Keystrokes for Mac Users: Finding Your Terminal

Unix Terminal is built into Macs. They haven't removed it (yet) so it must have
some validity and utility, right? It's there by default and not terribly
difficult to get to. So that means it's a *cool kid* thing, right? I'm not just
talking to the Linux dweebs, right. It's a macOS thing! I mean Apple is exposing
the Unix Terminal to users — really think about that.

For those not familiar with it, that's `Command`+`Space`+`t`+`e`+`r`+`return`

Oh, there's other ways to get to it, but on the Mac, the *Spotlight* feature
accessed with `Command`+`Space` to do a system-wide search *is your friend!* No
matter how Apple tries to bury something and hide it from you in menus and
obscure paths, you can short-circuit the path by typing its name, and this is
now the way with the `terminal` program — one of the last remaining vestiges of
a bygone era where Steve Jobs kicked Bill Gate's ass all over town and back.

Re-basing the Macintosh operating system back in 2007 from proprietary OS9 to
the first version that was Unix-based, OSX roughly at the same time as changing
the hardware architecture the Mac was based on from the Motorola 6800-lineage,
by that time referred to as PowerPC and sometimes CELL architecture to the much
cheaper higher clock-speed economies-of-scale Intel (Pentium and such) CPUs was
a stroke of genius and one of the more colorful tech miracles that happened.

Today it seems like no big deal switching architectures with everything becoming
ARM-based and RISC-V, but that's because we're almost 20-more years into it and
everything's that much more baseline powerful and the path has been well-worn
and proven. Back then it was a friggin miracle and Steve Jobs did it and it was
a major contributing factor to the Mac still being relevant today.

Proprietary is a dead-end when it comes to component parts.

Economies of scale and cheap parts come from commodity parts and
standardization.

But *for a Macintosh?!?!* you might ask. Yeah, Steve Jobs didn't like that
aspect of it all much either, so most of Unix is hidden under a chocolaty Cocoa
exterior. For those who like their Linux desktops, this is Apple's equivalent of
GNOME or KDE Plasma desktop manager. Apple made their Unix desktop manager. It's
called Cocoa and it keeps Mac users almost totally insulated from Unix...

...unless you type: `Command`+`Space`+"terminal"

And that's the magic. Or at least it's the first hand-gesture that activates the
more verbal incantations to follow. You need a magic keystroke which is a
hand-gesture for the more spoken-like magic words. I mean of course the magic
words are also types and are thus also hand-gestures but they're not quite so
much like the magic hand-waving of keyboard shortcut combos. I mean
`Command`-key, `Spacebar`?! How Apple can you get? The biggest key on the
keyboard and the one immediately to its left, ahaha!

It's not too hard. Not even for a Mac user.

Okay, so the terminal is up. What next? If I were you I'd click the full-screen
button — that little green globe once called the "Zoom button" but now makes
*true full screen* easily accessible — unlike Windows that's still stuck on the
far inferior maximize *which is not virtual desktops at all.* Kudos to Apple for
a decent *virtual desktop* implementation that lets users benefit from it
without thinking about it too much. All PCs — Macs, Windows and Linux — now give
you this wonderful horizontal ribbon of virtual desktops if you know how to use
them. You can lead a horse to water but you can only use virtual desktops
without thinking about it if you're on a Mac. Click the green globe gadget.

### The First Incantations: `pwd`, `cd`, and `ls`

Ahh, full-screen terminal. How does that feel? You're almost future-proofed
already. Now you just need to know these additional commands:

- The `pwd` command to know *where* you are.
- The `cd` command to set *where* you want to be.
- The `ls` command to *see* what's there.
- How to type one of the things you see to *run it.*

And sometimes `ls` isn't really going to show you everything you might have to
type, like if the command is `python server.py` you might only see `server.py`
when you use the `ls` command — and *just have to trust* that Python's gonna be
there when you type it.

More on *things in your path environment variable* later. Too advanced for right
now. But there are shortcuts, aliases and all kinds of ways to make your magic
incantations simultaneously easier and *in need of more prerequisite knowledge.*

Insider stuff.

Now you've got *an in.* Welcome to the inside.

Learning how to learn has been given a lot of lip service over the years.

It's not important to specifically know a thing that takes up too much space in
your head in everyday life. It's much better to know how to learn that thing
quickly when you need to know it. This has often been said multiple ways. The
multiplication tables, for example. A lot of people commit this X-by-Y lookup
table in their heads so that rote memorization, what we call heuristics, can
make them faster at basic math.

But if you understand what the multiplication table is doing, you can also get
their with addition by brute force. Three times seven is seven three times or
three seven times. Add it up. True 'nuff.

So you don't need to learn the multiplication tables?

Well, it depends on your everyday life. It's gonna take awhile to develop those
instantaneous muscle memory skills. I never fully did and to this day stumble
over some particular cells in the table, and the 11 and 12 rows? Forget about
it.

So it is with all things Unix-terminal, which is also Linux-terminal. Without
going into a long diatribe (another one), Linux might as well be Unix. Sure
there are differences and we'll cover them as we go with progressive reveals.
But Unix is the blueprint. Linux is an implementation off of that blueprint.
Macs are Unix. The rest of the world (including Microsoft) is Linux.

Most of the commands are compatible.

But it's all just different enough to be infuriatingly frustrating — and plays
right into the profit-incentive of vendors who can offer you *cloud services* to
do away with all those pain-points.

So long as local-first software remains difficult, they remain profitable.

They get you onto cloud software billing it easy peasy... and then billing you
easy peasy. Add one then another and another cloud service, streaming service,
AI service, service, service, service... and pretty soon you're in service of
the greater corporate organism.

And that's fine. That's just fine. It's capitalism and I drink my share from the
teats of mother big tech. How are you not going to? We don't burn our computers
from sand. We *must* stand on the shoulders of giants. There is no other way. We
are social animals and *no monkey is an island.* Even if you *turn on, tune in,
drop out* or try to cut the cord and go off-grid as a Montana mountain man or
something, you're still doing your occasional Walmart runs. And you're probably
gonna want that Internet connection once in awhile, 'cause you know, you can
learn the things you need to know to survive. Independence is an illusion. The
best you can hope for is a sort of *interdependence* that minimizes the greedy
hands in your pocket that are part of the deal.

And when you *do let greedy hands into your wallet* as we eventually must, the
idea is for you to be in control of that deal. There being *just one StarNet*
would be a problem for example. But if Amazon has their own satellite network
and maybe a 3rd company someday, then you can use your power from your
solar-powered RV (goodbye landlords) to make them compete for your business.
Hopefully more than just Tesla are making solar powered RVs. Google up the
*Stella Vita* because a decent version of minimized corporate dependence is on
the horizon. Solarpunk and popup communities to the most competitively
attractive States — or *countries* because *if you can drive there...* borders?
Pishaw! — is around the corner. THANK YOU Eindhoven University of Technology
students in the Netherlands who did that! The world owes you a lot. Hopefully
some disruptive manufacturers will follow their design. Also google-up the
Aptera solar car — not an RV but a production-vehicle start.

Where were we? Oh yeah, the Unix terminal. Linux terminal. Whatever. It's always
there. If you're on Windows, install Ubuntu from the Microsoft Web Store and you
too have a Linux terminal capable of running Pipulate. Apple got to Unix (\*nix)
in 2007. TEN YEARS LATER Microsoft got to Linux (\*nix) in the form of Windows
Subsystem for Linux (WSL). If you don't want to use the Microsoft Webstore just
open a CMD or Powershell window and type `wsl --install`. Magic words. Sprinkles
the \*nix fairydust even on a Windows system.

\*nix won. Have I mentioned that?

Oh, and there's a version of \*nix called Nix. There's a whole operating system
built out of it called NixOS — or if you're a *cool Mac kid,* nixOS if you
prefer. But you don't have to use Nix OS to use Nix. No, it's a floor wax and a
desert topping. Use Nix just to create little micro-installations of Linux in
subfolders of your Mac or Windows (via WSL) systems to *normalize* an
*always-the-same* code-running environment.

In this way you don't have to write a separate installer for Macs and PCs. Or
the developer doesn't, at least.

You the user have to learn a few things. One keyboard-shortcut magic hand-waving
gesture to get the Unix terminal to pop up on Macs. Windows people just choose
your Ubuntu icon from the *Start Menu* after the install. Either way, you've got
a \*nix-terminal.

All that's left is to install Nix so your \*nix-terminal can run *normalized
Linux web apps* — or in other words, *a practical alternative to cloud apps.*

Cloud apps have been driven up in popularity so enormously because a local
install is not necessary.

---

## From Philosophy to Action: Installing Local Apps with Nix

But what if you could install local software with just a few additional magic
words beyond getting up the \*nix-terminal?

The first is:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

...That installs Nix. and the second is:

```bash
curl -L https://pipulate.com/install.sh | sh
```

...and that installs Pipulate.

Now the hard part.

Once Pipulate is installed, you have to:

```bash
cd ~/Pipulate
nix develop
```

...and that does it. The locally installed web-app will auto-inflate and start
running, keeping itself up-to-date every time it's run.

A few magic words.

A little bit of getting around.

Not nearly as hard as learning Blender, ahaha!

---

## Book Analysis

Here is a multi-task analysis transforming the provided journal entry into a structured, enriched format for a future tech book.

### **Crafting Compelling Narratives: Title & Filename Brainstorm**
* **Title Option 1:** The Magic Words That Set You Free
    * **Filename:** `magic-words-software-freedom.md`
    * **Rationale:** This title directly uses the author's central metaphor, making it evocative and memorable. It appeals to readers looking for empowering knowledge rather than just a dry technical guide.

* **Title Option 2:** Breaking the Adobe Tax: A Guide to Digital Sovereignty
    * **Filename:** `breaking-adobe-tax-digital-sovereignty.md`
    * **Rationale:** This is a punchy, benefit-driven title that targets a specific pain point (expensive subscriptions) for a clear audience (creatives, developers). The term "Digital Sovereignty" elevates the concept for a more thoughtful reader.

* **Title Option 3:** Don't Rent Your Skills: Mastering the Terminal for Lifelong Tools
    * **Filename:** `dont-rent-skills-mastering-terminal.md`
    * **Rationale:** This title focuses on the core philosophical argument about skill ownership, which is a powerful and unique angle. It promises a practical skill (mastering the terminal) as the solution to a deeply felt problem.

* **Preferred Option:**
    * **Title (plain text for YAML):** Breaking the Adobe Tax: A Practical Guide to Software Freedom
    * **Filename:** `breaking-adobe-tax-software-freedom.md`
    * **Rationale:** This title is the strongest because it's both provocative and clear. It identifies a well-known antagonist ("Adobe Tax"), making the problem relatable, and immediately offers a "Practical Guide" as the solution. It perfectly balances the philosophical ("Software Freedom") with the actionable, appealing to the widest audience.

***

### **Book Potential Analysis**
* **Strengths as Book Fodder:**
    * **Authentic Voice:** The passionate, slightly irreverent, and highly personal tone is a compelling antidote to dry, impersonal technical writing.
    * **Strong Central Metaphor:** The concept of "magic words" and "spells" for the command line is a sticky and effective teaching tool.
    * **Connects Philosophy to Practice:** It masterfully bridges a high-level rant about capitalism and software with a concrete, step-by-step tutorial, answering both the "why" and the "how."
    * **Timely and Relevant:** The critique of subscription culture and vendor lock-in is a widely shared sentiment, making the content immediately relatable.

* **Opportunities for Enrichment (for Book Adaptation):**
    * **Add a 'What is Pipulate?' Box:** The entry tells the reader how to install Pipulate but offers zero context on what it is or why they would want it. A brief sidebar explaining its function would be essential.
    * **Illustrate the Terminal:** For a reader truly new to the concept, a simple annotated screenshot showing the terminal prompt, a command being typed, and the output would demystify the experience immensely.
    * **Create a 'Key Takeaways' Summary:** A bulleted list at the end summarizing the core philosophical points (e.g., "Pay with time, not money," "Own your skills") and the key practical steps (e.g., "Find the terminal," "Install Nix," "Run `nix develop`") would reinforce the message.

***

### **AI Editorial Perspective: From Journal to Chapter**
This entry is an outstanding piece of raw material, perfect for anchoring a chapter on **"Digital Sovereignty and the Philosophy of Tooling."** Its primary strength lies in its authenticity. The stream-of-consciousness style, far from being a weakness, offers a "behind the scenes" look into the mindset of a dedicated open-source advocate. It captures the *culture* and *passion* of the FOSS world, something often lost in polished, purely technical documentation.

By framing the command line not as a chore but as an empowering "spellbook," the author makes a potentially intimidating subject feel exciting and accessible. In a book, this entry could serve as a powerful introductory case study. It starts with a relatable frustration (expensive software), builds a compelling philosophical argument for an alternative path, and concludes with a clear, actionable quest for the reader to embark upon. The raw nature of the dialogue, once lightly curated with subheadings and annotations as suggested, becomes a feature—a genuine, persuasive voice guiding the reader from passive consumer to empowered creator.

***

### **Suggested Next AI Processing Steps**
1.  **Task Suggestion 1:** Generate Explanatory Analogies
    * **Potential Prompt Snippet for Next AI:** "Based on the provided text, the author uses a 'magic spellbook' metaphor. Generate two new, simple analogies a beginner could understand to explain a) what the 'PATH environment variable' is, and b) what Nix does to create a 'normalized' environment."

2.  **Task Suggestion 2:** Create a Skeptic's FAQ
    * **Potential Prompt Snippet for Next AI:** "Read the attached bluebrint on FOSS vs. proprietary software. Identify the three most likely points of resistance or skepticism from a reader who is happy paying for commercial software. Draft these as questions in an FAQ section and then provide answers that are consistent with the author's tone and philosophy."

