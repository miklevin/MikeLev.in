---
title: Of Rabbit Holes, Wonderlands & Shoulders of Giants
permalink: /futureproof/rabbit-holes-shoulders-of-giants/
description: 
layout: post
sort_order: 2
---

## Many Ways to Build

There are many ways to put things together. Many of them will work just fine,
and be equally good solutions that you will love just equally as much.

### Running Different Than the Pack

Soon, I'm going to have to get over the "nobody gets me" hurdle. It's not that
nobody really gets me. It's that I'm running a different way than the pack. Or
should I say herd? Whether you think pack or herd is in itself telling. First I
think pack, then I think herd. Then I think [Bill
Herd](https://en.wikipedia.org/wiki/Bil_Herd), and then I think the [GNU
Hurd](https://www.gnu.org/software/hurd/) Unix kernel. And finally, I think
python packaging because if you want to run with the pack, it's got to be pip
installable.

Does that make me a geek? And then I think [GNU Guix](https://guix.gnu.org/), so
I guess that's a solid yes.

### The Many Paths Forward

Nix vs. Guix. There are so many ways to put things together, and ultimately it
doesn't matter so long as you get the benefit out that you want, and the love of
the process while doing it.

### Encountering Haskell

I don't think I'd ever have been exposed to anything
[Haskell](https://www.haskell.org/)-like, as I've been somewhat deliberately
avoiding it. If I haven't taken up [Common
LISP](https://en.wikipedia.org/wiki/Common_Lisp) by now, I'm not going to take
up Haskell. Python lambda 1-liners are anonymous functions enough for me,
thank-you-very-much. I mean you can't really escape
[Scheme](https://en.wikipedia.org/wiki/Scheme_(programming_language)) or
[Lua](https://en.wikipedia.org/wiki/Lua_(programming_language)) if you do any
macro or API-programming of one of the many languages that embeds it, both of
which are LISP dialects. So you just get to know a little LISP in a rich tech
career, but you can avoid Haskell... or so I thought.

### The 80/20 Rule of Tech Decisions

The declarative deterministic system-builder I use called Nix uses a dialect of
Haskell for as its domain-specific language (DSL). Oh great, another
tech-related DSL acronym. That's high-speed Internet, this, and *Damn Small
Linux*. Okay fine, whatever. Nothing's perfect, and all tech decisions are
80/20-rule decisions, whereby you get 80% of what you want from the first 20% of
whatever you're willing to invest into it. And you have to do that too, because
you need 80% of what you have left over to deal with that last mile of any
project where all the edge cases rear their ugly head, and you suddenly
encounter [Zeno's paradox](https://en.wikipedia.org/wiki/Zeno%27s_paradoxes) in
reality. The closer you get to the end of a project, the more edge cases you
will discover that just have to be dealt with, plus all the user interface
issues you underestimated.

### Building Deterministic Systems

Anything you can do to deterministically control things, and to cut down the
permutations and decision-branches, the better. I mean, that is unless you're
trying to incubate things with emergent properties which is an entirely
different article. But for this one, it's about the good way to put things
together. And it's about turning my TenCardFlow from the prior post about
musical HTMX into the Lego-like building blocks that I will be using to create
countless workflows from here to forever-forward.

### The Return to Web Development

Yeah, I have that much faith in the tools I'm using right now, as bleeding edge
as some of them may be. Oh, a war story! And some perspective on why I'm back in
web development now after so many years of pinching my nose at it, in favor of
just doing everything in Jupyter Notebooks.

### Local Servers and Development Tools

Lightweight local servers are a big deal. They let you use programming
techniques with local software much more similar to web development than a lot
of the development environments. I struggle with this right now because I
actually do like these things called `TK` and `QT`, both of which are
native(esque) user interface tools that are very un-web-like. If you're a
frontend web developer, you'll hate TK/QT. But if you're throwing together some
app and it needs a little installer with a UI, it's a heck of a lot easier to
use one of those (which work across platforms, eg Mac/Windows) than it is to
spin up something with full web browser capabilities, like an Electron app. But
if you actually can take the time and spend the resources to spin up a full web
environment locally (like an Electron app, eg VSCode, Slack, Zoom), then you
have some pretty awesome development tools to work with. You basically have a
little local server to control, though it doesn't look or feel that way as a
user. And it's one powerful trick.

### Understanding Client/Server Architecture

It confuses some people how when you install Jupyter Notebook locally, you
generally have to keep a terminal window open for the server to run in, while
Jupyter itself is accessible on a `localhost:8888` address in your browser.
There really is a local webserver running on your machine to server Jupyter,
though that seems a bit less amazing than it used to. So many things have
servers embedded into them for purposes like this these days that it lost all
its wonder, and all that is left is confusion on where it's running, why you
can't see it, why you ***have to see it***, and variations thereof.

Client/server architecture is also just a label. It's a mental framework to
think about what's going on, providing insights about the design pattern. But
the truth is components are components, and components of an app talk to each
other. It's a rare app that's not somehow or other broken into components these
days. Even things compiled into a single executable are either reaching out to
other components on your system, or carry around their own sub-components *baked
in as statically compiled resources*. No software is an island. It's just that
one of these island-to-island communication patterns is labeled client/server.
And it's the big one for the web, so it gets a lot of attention, and it can be
surprising when you use them in different and creative ways.

### The Electron Approach

Electron is one of those different and creative ways. It bakes the server in,
usually `node`, so that you don't have to look at or think about or in any other
way care that there's a client-server architecture underneath. Electron uses the
web browser as a component to build the user interface and node for the backend
stuff, and therefore the company building the app can hire the much more common
web developers over native app developers. And the app becomes a whole lot
easier to port between platforms, eg Mac, Windows and even Linux. Browsers are
browsers, and node in particular is very Linux-friendly because of all those
Linux servers out there using it to serve websites. The Linux-won bias on
servers serves local apps built on web tech very well.

### Moving Beyond Electron

But Electron is still far too much like... what? I guess like proprietary
software and a violation of the 80/20-rule for me. I don't want to make things
with installers and per-platform nuances and dependencies. For a couple of years
now, I thought the Electron version of JupyterLab that's distributed on GitHub
as JupyterLab-Desktop was the greatest thing in the world. I thought it solved
all these problems of making Notebooks distributable to be run locally on
people's own machines, so they could use all those localhost tricks so important
for SEO, like running browser automation and common desktop VPN software. But
no. It's fragile and non-deterministic and plagued with per-platform, and even
per-machine problems due to software versioning issues. One more promising
panacea goes up in smoke. It was all very frustrating.

### The Search for Collaboration Tools

How to collaborate and share superpowered SEO tools with my new coworkers at
this company without it being Google Colab. The discussion here is too long, but
so are long-running scripts... too long. Those who know will know. Colab with
all its conveniences is still just another cloud vendor shake-down. They want
your money and will boil the frog to get it.

### The VSCode Temptation

VSCode is another tempting route, Microsoft-supported as it is, with all that
magical typing-completion called Intellisence, an astoundingly big quality
plugin ecosystem, and ostensibly even free and open source software (FOSS) as it
claims to be. It even runs Jupyter Notebooks as if Jupyter Notebook! So yeah,
jump on that bandwagon... except... except... except for a thousand little
gotcha's. We could start with Python environment control, but I won't.

### Finding Nix

Suffice to say, I found the solution in Nix. Most people will automatically
think NixOS, or how \*nix is used to refer generically to Unix/Linux-like
systems, that is if they think of anything at all. But no, Nix is actually a
bunch of things, but as I started this article out with, it's a Haskell-inspired
language for describing systems. And by systems, I mean a computer built with
such-and-such software installed in such-and-such a configuration so that when
it's started, it runs (hosts) such services as Jupyter Notebook or JupyterLab.

And it will do that in the subfolder of a Mac or Windows PC ***just fine!***

### Beyond VMs and Containers

And it does it without any of that VirtualBox or Docker (VM or container)
overhead nonsense. The overhead is bad enough, but when an application is built
from multiple docker images, it just gets ridiculously out of hands. So Docker
and VMs are both nonsense and ridiculous. They are ridiculous nonsense!
Especially once you realize the alternative is just ***build a system from a
simple file*** and it just runs. No muss, no fuss. It just runs. It effectively
solves the ***"Not on my machine"*** problem.

Really, it's a too-good-to-be-true.

And it was worth learning a bit of Haskell-like language for.

And so I had my Electron alternative.

### The Path to Nix

I would have rather not learned Haskell just to configure machines. And the LLMs
helped an awful lot! Little did I know it, but NixOS had been around since 2013.
That's almost as long as I've been maintaining Levinux, my Linux distro/respin
to solve similar problems, trying to make a sort of ***Noah's Ark*** USB
keychain computer, where you can just plug-in and run.

### False Starts and Red Herrings

There were several red herrings along the way, false starts that led me down
long, circuitous, promising but ultimately failed paths. The Windows subsystem
for Linux (WSL) was one of them, and Ubuntu's answer to containers that solve
the immutable docker compose mess, LXC/LXD, was another. I spent months, years
total, on these together. All very promising. All with their own special utility
and place in the overall tech landscape. Just not a place with me.

No, once I realized what NixOS and the Mac/Windows-applicable nix program that
NixOS is built from, I was sold and converted. I'm several months into it,
and... and... and... well, I don't think it's a dead-end like WSL/LXD.

### The GNU Connection

Why?

Because a few months into that, I discovered (thanks to my YouTube followers who
brought my attention to it) Guile/Guix. Guix is the GNU Free Software
Foundation's (the super-real-good-guys of tech) answer to NixOS. At first I
kicked myself for learning some Haskell when I could have been learning what
Guile... hmmm... how to explain?

Haskell is to the nix system configuration language what LISP Scheme is to
Guile.

And LISP Scheme is common enough in the world of tech, and is a nice doorway to
LISP, which everyone serious about tech should at least explore once in their
life, that it is appealing. Learning LISP is on my bucket list, while Haskell is
not. Things like Guile and Scheme are stepping stones to LISP.

### Validating Nix

And so at first I kicked myself for taking up Nobody Nix/NixOS instead of GNU
Guile/Guix. But then I realized Nix had a 10-year headstart on the GNU peoples'
effort, and that there was no bigger validation of Nix than the GNU peoples'
blackboxing of it, the way they did the Linux commands themselves ages ago
(their original claim to fame (plus the GPL software license). The GNU
foundation is foundational. They're the ones who make Linus Torvald's Linux an
actual platform by adding the terminal commands to it. What we call Linux is
really GNU/Linux. Well, it's really GNU/Linux plus a desktop manager like GNOME
or KDE, but that's another story. Suffice to say, GNU's love for Nix was
validating.

### Mac Support and Corporate Backing

What's more, one of my must-have criteria was collaborating with all my
coworkers who are on Macs. And GNU Guix doesn't play so well with Macs yet. This
takes a level of support that only... that only... that only... well, I'll just
say it. It takes a level of support that can only come from the well-funded
likes of the military industrial complex. In this case, we're talking the
Trump-loving ex-Facebooker and Oculus Rift inventor, Lucky Palmer, and his new
power pandering plaything,
[Anduril](https://en.wikipedia.org/wiki/Anduril_Industries). I mean it's not
really ***the establishment***, newcomers as they are. But they apparently had
this same itch to scratch and found nix/NixOS just like me. And that makes its
development and continued support more than your run-of-the-mill FOSS software.

### The Future with Nix

Validation on top of validation. Using Nix Flakes to make Linux subsystems on
Macs and Windows to pull off Electron-like local apps using web development
tools is not only feasible and viable, but preferable!

And so Nix is the new Levinux in my heart. I mean it's not a Noah's Ark keychain
Linux system runnable with a double-click from a Mac or Windows PC without even
having admin rights like Levinux is. But that's a silly little magic trick in
comparison to the deep long-term future-proofing and resistance to obsolescence
that you get from the willingness to run one little install... one deterministic
installer... the [Determinate Systems](https://determinate.systems/) Nix
Installer!

That's the piece that makes Nix so Mac-friendly. There's polish put on
surprising little pieces of Nix, like the macOS installation story. Apparently a
lot of the ***cool kids with Macbooks want to run nix***, particularly at
companies like Anduril that have enough money to pay for services from the very
niche service providers like Determinate Systems.

### Choosing Your Wonderland

Yeah, so I felt like I fell into a rabbit hole. But honestly, everything in tech
is a rabbit hole. It all goes as deep as you want to go. And we're all standing
on the shoulders of giants for whatever technical trickery we want to pull off.
I don't think it's thought about enough, but technology is technical and
technical is technique and technique is a method or way of doing things... which
is philosophy and belief systems! So when you choose whose giant shoulders to
stand upon, you're aligning yourself with philosophies, world-views and belief
systems. And many of those get the carpet pulled out from under them.

### The Web Stack Wonderland

Yes, not all Wonderlands are made equal. Some are gorgeous and colorful and
constantly in bloom, generating infinite varieties of new flowers, but never one
that's going to be around for that long. That's the full webstack. That's
Node/JavaScript/Framework world. Yes, while Node and JavaScript have stabilized
much lately and Web Assembly, WASM, is now too big to fail and to lovely of an
experience in the web browser to walk away from, Node is up to version
20-something and every one of those numbers is breaking changes. That is,
whatever you wrote based on it is likely to not work after the upgrade, and you
have a lot of whack-a-mole bug fixes to make to get it running again.

### Python's Stability

That's the Node/JS giant shoulders. Not bad. But not for me. I like Python
that's up to version 3 in 30 years (vs. Node's 23 versions in 15 years). Not
that it's an apples-to-apples comparison, mind you. But there is a certain truth
to it. Pythonistas do not let their old code go willingly into that dark night,
and you can tell that just by looking at the 2.x to 3.x wars and the more recent
controversy about what's called the walrus operator. Python people don't like
change much ***even when it's non-breaking***, so you can imagine these are some
much firmer shoulders to stand on than the full webstack ones with a framework
du jour, if the NodeJS churn itself wasn't hamster-wheelish enough for you.

### The Vim Wonderland

I evaluate my Wonderland's carefully. I don't take them up easily, and I don't
take kindly to breaking changes. I use the `vim` text editor, and it took a
decade for me to finally switch to `nvim` because I like the language available
in its configuration file (LUA &#151; that LISP-story again) more than
VimScript. And even then, I make sure it's really the whole vi/vim/nvim camp
that I'm aligned with. Sure you lose having more than 1 undo and you don't get
syntax color-coding of your code, but in a pinch I could use the `vi` program
that's part of the Unix standard and even in those half-megabyte (500K) BusyBox
versions of Linux. Suffice to say, time-tested,.battle-hardened and still 80/20
good 'nuff tools are cool... old's cool... old school!

### The Giants of Vim

Vim is indeed a wonderful land. You will never have the carpet pulled out from
under you. The ziggurat configuration of giants is impressive. It's Ken Thompson
the creator of Unix at the base who contributed his part along , with Bill Joy
one of the cofounders of Sun Microsystems and re-writer of Unix back in the
1970s. The recently departed Dutch software engineer Bram Moolenaar contributed
his part with the re-re-write of vi (now viMproved) in the late 1980s, and
finally NeoVim's Thiago Arruda forked that project in 2014 to add better plugin
integration that the brogrammers love, but which frankly kept me away from it
until I really wanted LLM help on vim configuration and realized I was better
off in Lua than in VimScript... pshwew! That's a real mouthful. But it's the
point I want to make about Wonderlands. Not only is the vim camp very, very old
and established in tech, super good-enough and applicable to every problem
domain and on any host computer, but it's also the thing that every other
text-editor and IDE that puts in an emulation mode of other software tries to
emulate. And that's not even getting into the flow-state inducing muscle memory
and productivity reasons why.

### Choosing Wisely

We choose the rabbit holes we dive down carefully. We evaluate our Wonderlands
critically. And we stand on the shoulders of giants wisely, least they gobble
you up such as Microsoft and Oracle will every time.

### Today's Work

And so now that brings us to today's work. So what if I have a long, rambling
preamble before I get to the point. You known in the days before LLMs that would
have been characterized as self-indulgent or besides the point. Now in the age
of LLMs, it's just good context. It's the storytelling and embellishment that
makes the next steps that harken back to all those reasons for decisions all
the more important. Isn't that right, o1 Pro?

---

## How We Request Confirmation Bias With AI

> Yeah, so of course I know AI is going to lean into what it thinks I want to
> hear. They're made that way, but so what? What we need to do is when we're
> serious about Devil's Advocacy and the countering opinions that we ask for it.
> And so we must remind ourselves do to that from time to time; although I
> didn't here.

**o1 Pro**: Below is a broad reflection on the core themes and decisions you’re weaving together in this latest piece. It’s not just about a single technology choice or a short snippet of your stance; rather, it’s a continued exploration of how you pick your “Wonderlands” in tech, why you sometimes meander or pivot, and the meaning you see in each path:

---

## 1. Many Ways to Build: Embrace the 80/20 Rule

You start with the observation that **multiple solutions can be equally valid**. The true significance is whether the solution brings you joy and utility. If it does, you’ll stand by it—even if others might pick a different route. This perspective underscores:

- **80/20 rule**: You get 80% of the benefits from 20% of your chosen solution’s features. You only go after the remaining 20% of features if you need it or have time, because that last mile can be a big slog.  
- **Freedom from “pack” or “herd” thinking**: You do accept you’re running on a different track than many devs. But your goal is not broad popularity; it’s about the personal synergy you feel with your tools.

---

## 2. Nix vs. Guix, Haskell vs. Scheme, & the Battle for Deterministic Builders

A major chunk of your reflection revolves around how Nix uses a Haskell-inspired DSL, whereas GNU Guix uses Scheme/LISP. You recognized:

- **Nix** has a longer headstart, decent Mac support, and corporate sponsors that ensure it’s robust on non-Linux platforms—particularly thanks to efforts by Determinate Systems and perhaps the interest from companies like Anduril.  
- **Guix** is effectively the GNU approach to the same concept. It’s written in a dialect of Scheme, which you might find more personally appealing than Haskell. But you see Mac support for Guix is not nearly as polished.  
- Despite initial regrets (like “Maybe I should have done Guix,” or “I prefer LISP to Haskell”), you found that Nix was validated by so many references and by being a decade older. So you’re pressing on with Nix.  

All told, you see these “system-building DSLs” as crucial for **future-proofing** your workflows. They help you avoid the overhead and ephemeral chaos of containers or Docker images, letting you create local-first environments with minimal fuss.

---

## 3. The Overarching Anti-Electron, Localhost Vision

You reaffirm you **dislike** typical big-binary local apps (Electron, Slack, Zoom, JupyterLab Desktop, etc.) that come with major version-churn or platform fragility. Instead, you prefer:

- **Nix** as the “new Levinux” in your life, the ultimate “Noah’s Ark” for ensuring everything you build can run offline on Mac, Windows, or Linux with minimal overhead.  
- A single local server approach—like the custom system you’re building, or even “vanilla Jupyter”—that uses HTMX or minimal web stack logic, but avoids enterprise frameworks.  
- Freed from Docker or WSL or LXD containers, you see direct Nix-based “machine building” as simpler, more robust, and far less ephemeral.

Essentially, **Nix** is your “Electron alternative.” Where electron bundling tries to replicate cross-platform everything, your approach is to define a local environment with Nix, spin up a minimal web server and open the browser. This yields the same benefits with fewer installation or upgrade headaches.

---

## 4. Revisiting Tools: Vim, Python, Old School

You’re consistent in your love for “**time-tested**” technologies:

- **Vim** (or NeoVim) is a prime example: decades of continuity, a stable user base, minimal risk of forced rewrites or the “carpet pulled out from under you.”  
- **Python** over languages that break backward compatibility every other year.  
- **Ken Thompson → Bill Joy → Bram Moolenaar → NeoVim**: That chain of dev-luminaries and the lineage from original Unix stands for a form of deep reliability you value.

All of that speaks to your bigger worldview: “**If I can avoid the churn and keep the same editors, the same coding patterns, the same environment, then I spend far less energy reacclimating each time.**”

---

## 5. Rant Against Node/JS & Large Breaking Changes

You highlight how Node.js soared through 23 versions in 15 years, each with potential breakage, while Python carefully advanced from 2.x to 3.x in 30 years. For you, that’s an important difference:

- Node’s churn is a hamster-wheel from your vantage point, even if it’s standard for some.  
- You prefer slower, more methodical evolution so your older code doesn’t become incompatible so fast.

Hence, you pick **Python** for your scripting glue, local servers, and LLM integrations, doubling down on its alignment with your 80/20 principle and your desire for steady footing.

---

## 6. The Tech Wonderland Metaphor

A recurring theme is that **every tech stack is its own “Wonderland,”** a rabbit hole that can go extremely deep. You have learned to be critical of each wonderland:

- Some are ephemeral—like JavaScript frameworks that come and go.  
- Some are too big or are locked behind corporate agendas (like Docker, WSL, or big vendor solutions).  
- Others are truly fundamental and stable (like `vim`, `Python`, or the general idea behind Nix).  
- You want the latter type, whose trajectory or lineage you trust will remain robust and relevant.

---

## 7. Wrapping Up the Current Article’s Purpose

Finally, you bring it back to the question of *why* your writing is so narrative. Thanks to LLMs, “rambling context” can be helpful, letting the AI pick up on the subtext. For you, the storytelling is part of building the next steps—like using TenCardFlow from prior posts to create “Lego-like building blocks” for countless future workflows. That is your synergy:

- **Local Nix environment**  
- **Single-file HTMX-based web server**  
- **LLM** integrated to help code expansions  
- **A personal offline platform** that’s robust, version-locked, and minimal in overhead.

You see it as an unstoppable combination that merges old-school hacking with new-age AI assistance—a future-proof vantage that resonates with your entire approach to picking Wonderlands carefully.

---

### Concluding Thought

You’ve found your footing in Nix as your local system builder, Python as your main language, and an offline web approach (HTMX + minimal server) as your new “app scaffolding.” That scaffolding is the foundation on which you’ll develop unlimited local flows—like your TenCardFlow system or anything else that emerges. All of it ties into your larger theme: **maintaining a stable, personally empowering environment that stands outside ephemeral churn**—and you’re more than fine with that.

---

So we take risks when standing on the shoulders of giants. Some are so stable
like the vim example where you have contingency upon contingency and validation
coming in from every angle and in so many ways that there's basically no risk.
Oh, you might hate vim and be ***differently vibed*** and find you wasted your
time learning it, but that's a different kind of risk. There's basically no risk
of vi/vim/nvim and its multi-branding tree of lineage being wiped out. Vim's
safe.

On the other hand, we have FastHTML. There's always been something vaguely
dissatisfying about web development on Python. I man, there's Django dating back
to forever and the whole Instagram empire built on it. And there was the
Plone/Zope frameworks back from before forever. And then there was Flask,
everyone's favorite Swiss Army Knife and the poster-child package of using
decorators for routing. FastAPI kicked Flask's butt when it was too slow to
embrace async/await concurrency and mypy strict static typing. But still, even
all them are... are... well, no better than PHP with their handlebar mustache
nuncks curly braces {% raw %}`{{ foo }}`{% endraw %} all over the place, an
unsatisfying upgrade form PHP's short tags `<?= foo ?>`.

Ultimately, Flask (or something pedantically copying it) became something you
***had to use***; that web swiss army knife you carried around, but ***now you
had two languages***&#151;Python plus whatever messy curly-brace vomiting
template language you had to suffer. It's like you finally got away from
gratuitous over-littering curly-braces by switching to Python in the first
place, and now you had to get them back just because Web? No! But there was no
better way, at least none that was as generic and broadly applicable as Flask
and its mustache twirling clones. That is, until FastHTML.

The story of FastHTML and HTMX are intertwined. [Here's the creator of both
sitting down to have a talk](https://www.youtube.com/watch?v=WuipZMUch18). It is
the future of web development on Python, I can feel it in my bones. It is
perhaps the future of web development in general, as it provides a vastly more
solid path to webdev future-proofing than anything else I've seen. Merely by
being consistent over the years while churn plagues node will give it the
***last man standing*** advantage. While hamster-wheel fatigue wears down
webdevs battling breaking changes, FastHTML'ers will find relief in their code
being as stable as the HTML standard itself.

Or so I thought.

Now it's minor, but jumping on the FastHTML bandwagon is still the bleeding
edge, no matter how future-proofing and obsolescence resistant it feels. There
are breaking changes, and I just suffered one of those wounds. Long story short,
if you jump on this bandwagon with me, keep tabs on the [FastHTML
CHANGELOG.md](https://github.com/AnswerDotAI/fasthtml/blob/main/CHANGELOG.md),
particularly for breaking changes. From a routine updating of my pip packages,
my app stopped working. I rolled back to a prior version, 0.6.18 to be precise
to get it working again, and the bug I encountered sent me on a complete wild
goose chase thinking I was defining my tables wrong. As it turns out, they
removed the `ws_hdr=True` parameter directive from the `fast_app()` helper
constructor, and when than happens any `anything=anything_else` gets passed
along with a `**kwargs` splat as a table-schema.

Does that make sense to anyone out there? Anyone? Anyone? LLM?

Yeah, so God bless the volunteers on that project, but my bug was
unreproducible. I think I may have left out the fact I was using the `ws_hdr`
parameter, so my bad. But it was unreproducible and closed on me before I could
even look to follow up (2 days). So when it was closed, I figured what I thought
it was couldn't be the entire story, so I dug and I dug and I dug. Finally
through process of elimination I realized that by editing out the `ws_hdr=True`
parameter, the error changed! And the error was a SQLite error that I was trying
to use a Boolean for a field name. And it clicked! So I searched on ***fasthtml
ws_hdr*** and found the changelog&#151;and headsmacked and learned my lesson.

Lesson being? Lesson being that when you feel the future being made on the
bleeding edge bandwagon beneath you, beware of breaking changes, because they
want to get it right. The illusion of stability because of the perfect spanking
API to eliminate `jinja2` mustache template languages doesn't mean that all the
other curly cues and rough edges aren't going to undergo some sanding off and
polishing. They are. In particular, per FastHTML version 0.7.1 Breaking Changes:

> `ws_hdr` and `cts_hdr` both removed from `FastHTML` and `fast_app`; replaced
> with `exts`, which takes a list of extension names (e.g. `exts='ws'`)

...and instead of just finding this and making the changes, I pinned to an older
version and placed a GitHub case!

I am standing on the shoulders of some very interesting giants in my gamble to
future-proof my web dev skills on a new and actually love-worthy Python
approach. Specifically, it's the way FastHTML simultaneously eliminates the need
for a secondary templating language while blending in the entire very expressive
set of HTMX directives that make it so special. Explaining this in a way that
does it justice would be an article in itself, but it's like solving several
simultaneous equations, scratching several itches all of which I have, at once
like I've never seen before.

You hear the expression that while history does not necessarily repeat exactly,
it sure does rhyme? Well, this is delightful rhyming. It rhymes with cgi-bin
from the PERL and LAMP days of webdev. It rhymes with the HTML specification
itself. It rhymes with AJAX from the early jQuery days before it was hijacked by
ReactJS. FastHTML just rhymes rhythmicall  and beautifully in a way that hits
right.

I don't care about the instability and some early adopter bleeding-edge blood
letting. I'm on this bandwagon.

You can feel the spirit of a poet and a philosopher in FastHTML, who happens to
have the chops to pull it off technically. Yes, I am a fanboy. While it might
not be Ken Thompson or Guido van Rossum level of API Kung Fu, it's sure up
there. It's the same guy who brought us `nbdev` used to turn Jupyter Notebooks
into full-fledged pip installable Python packages, which I'm also a fan of. And
before everybody got distracted by Transformers and ChatGPT, he's the guy who
brought a ***for humans*** API to PyTorch(er) in the form of Fast.AI.

And what's more, if there is anything else out there like FastHTML, they're
trying to give them exposure too if you scroll to the bottom of [their main docs
homepage](https://docs.fastht.ml/). I mean, talk about class.

Alright, so you get it. I don't like the shiny new objects but I'm taking one up
anyway in the form of FastHTML. I'm already deeply committed to it, because it's
nothing less than my path back into webdev, albeit a decidedly Electron-like
localhost-oriented desktop app flavor of webdev that I favor. And that's only
because Jupyter Notebooks which are a fine backup contingency plan to webdev can
only take you so far... and I got there.

You can't trade sophisticated dashboard-like applications with coworkers that
just work every time with a Jupyter Notebook. Colab fans chime in here, but it's
a long-running persistent costly joke why it isn't. I tried JupyterLab so I
could do ipywidgets and Dash/Plotly-like dashboards built from them&#151;and
that ***almost got me there***&#151; oh, so close! And of course StreamLit which
is totally lit, but *excessively railed*. It's not a general framework that lets
you go off-rails, which I pretty much have to do right out of the gate. So
there's this exhaustive exploration of the alternatives that made me recognize
FastHTML for what it was, and I have now fully moved on that. Done.
Internalized. Incorporated. And on those occurrences where there's breaking
changes... accepted.

But now... but now... but now... Anywidgets!

Oh, this is the actual story of serendipity that I started yesterday with the
vastly huge link-graphs that I visualize with quite a remarkable trick that it's
a miracle that it works, but I would rather leave behind. I don't even want to
describe it, suffice to say that the developers who make the visualizer I use
found the solution for me in how they made the hack I'm using unnecessary.

I humbly asked them to support embedding their visualizer in Python Notebooks.
Their response was, oh of course! They're working on it! Like mine wasn't the
first request along these lines. Their product screams data science workflow,
and if something screams that, it also screams Jupyter Notebooks. And their
integration solution was Anywidgets, which I am just learning about now.

Another shiny new toy. Exactly the sort of thing I don't want to take up. I am
allergic to ***tiny new toy syndrome***. I really had to overcome it in taking
up LLMs for serious work and giving Cursor AI a try, especially considering my
particularly acute allergy to VSCode. It was some bitter medicine, but like
Green Eggs and Ham, I did like them... ***I do like VSCode and LLM!***

And so, it is with a reluctantly open mind, especially having been stung by
`ipywidget` fragility in JupyterLab recently that I take up Anywidget as the
very first things in my TenCardFlow examples today. Perplexity?

**Perplexity**: Anywidget is a modern Python library designed to simplify the creation and sharing of custom Jupyter Widgets. It serves as both a specification and a toolkit, enabling developers to author reusable web-based widgets for interactive computing environments without the complexities typically associated with traditional widget development.

## Key Features of Anywidget

- **Ease of Use**: Anywidget allows developers to create widgets without needing complicated templates or extensive build configurations. This makes it particularly appealing for those with limited front-end experience[1][2].
  
- **Prototyping**: Users can prototype widgets directly within Jupyter notebooks, which facilitates rapid development and testing. This capability is enhanced by support for modern JavaScript features, allowing for real-time updates and a smoother development experience[2][4].

- **Cross-Platform Compatibility**: Anywidget is designed to work across various environments, including classic Jupyter notebooks, JupyterLab, Google Colab, and Visual Studio Code. It abstracts away platform-specific details, allowing developers to focus on writing their widget code[1][3].

- **Modular Design**: The framework utilizes ECMAScript modules (ESM), which enables developers to write modular JavaScript that can be executed across different notebook environments. This design choice significantly lowers the barrier to entry for new widget developers[2][5].

- **Lifecycle Hooks**: Anywidget introduces lifecycle hooks such as `initialize` and `render`, which correspond to specific stages in a widget's lifecycle. This structured approach helps manage the state and rendering of widgets effectively[3][4].

## Development Process

To create a custom widget with Anywidget, developers define two main components:
1. A **Python class** that represents the widget.
2. An **ECMAScript module (ESM)** that contains the front-end code.

This separation allows for greater flexibility and reusability of code across different projects and environments[2][4].

### Example Code Snippet
Here’s a simple example of how to define a counter widget using Anywidget:

```python
import anywidget
import traitlets

class CounterWidget(anywidget.AnyWidget):
    _esm = """
    function render({ model, el }) {
        let button = document.createElement("button");
        button.innerHTML = `count is ${model.get("value")}`;
        button.addEventListener("click", () => {
            model.set("value", model.get("value") + 1);
            model.save_changes();
        });
        model.on("change:value", () => {
            button.innerHTML = `count is ${model.get("value")}`;
        });
        el.appendChild(button);
    }
    export default { render };
    """
    
    value = traitlets.Int(0).tag(sync=True)
```

In this example, the `CounterWidget` class defines a button that increments a counter each time it is clicked. The button's label updates dynamically based on the current value of the counter, demonstrating the interactive capabilities enabled by Anywidget.

## Conclusion

Anywidget represents a significant advancement in the ease of developing Jupyter Widgets by combining modern web development practices with interactive computing. Its focus on simplicity, cross-platform compatibility, and modular design makes it an attractive option for both novice and experienced developers looking to enhance their Jupyter notebook applications.

Citations:

    [1] https://anywidget.dev/en/getting-started/
    [2] https://blog.jupyter.org/anywidget-jupyter-widgets-made-easy-164eb2eae102?gi=1f777c473c9d
    [3] https://anywidget.dev/en/jupyter-widgets-the-good-parts/
    [4] https://anywidget.dev/blog/introducing-anywidget/
    [5] https://www.reddit.com/r/Python/comments/10hxq95/introducing_anywidget_custom_jupyter_widgets_made/
    [6] https://github.com/manzt/anywidget

Alright, so it's time for some major gutting of `botifython.py`. My plan was to
leave the `BotifyLinkGraph` class in place until the new one is fully
implemented and tested, so the old one was there for reference. But I found that
the actual site I'm integrating with that just released its Jupyter Notebook
integration with Anywidget has also (temporarily, I assume) broken their main
package, right in the middle of the holidays when probably nobody but me is
looking, haha! I left them notes, but this is the opportune time to do that...

Okay, done. Knocked almost a thousand lines of code off the program.

Next up, I'm going to remove what I call Poetflow, where I designed the musical
notes like poetry of this whole thing. I'm going to move the LLM tutorial aspect
of it into Bridgeflow to reduce the tutorial surface area.
