---
title: "The Next Great Web Cleanup: Designing for AI Readability"
permalink: /futureproof/web-cleanup-ai-readability-htmx/
meta_description: A developer's strategy for the next web revolution, focusing on AI readability, semantic HTML, and a FOSS-based stack over JavaScript frameworks.
meta_keywords: AI readability, web accessibility, future-proof development, HTMX, Python, NixOS, command-line refactoring, rg, xargs, sed, vendor lock-in, developer philosophy, semantic HTML, JavaScript frameworks
description: "I need to get my head straight and focus my next coding sprint. The big picture is clear: the web is about to be remade for AI readability, and the bloated JavaScript frameworks are the modern equivalent of Flash—doomed to obsolescence. My goal is to refine Pipulate into a lean, FOSS-based example of this new paradigm. To get there, I need to stop overthinking and start doing, which means applying my 'magic rolling pin' to my own codebase, trimming the fat, and proving out my workflow with small, fast, iterative changes. This weekend starts now, with a simple file rename."
layout: post
sort_order: 2
---

## Setting the Stage: Context for the Curious Book Reader

This technical journal entry is a stream-of-consciousness exploration of a developer's strategy for navigating the rapidly changing tech landscape, particularly in the age of AI. The author, working on a project called Pipulate, grapples with both high-level philosophical principles and immediate, practical coding tasks. The central theme is a rejection of the ephemeral, complex JavaScript frameworks that have dominated web development in favor of a "future-proof" stack rooted in durable, open-source technologies like Python, HTMX, and NixOS. This approach is driven by the belief that the next major shift in web design will be driven by the need for websites to be easily "readable" by AIs, much like the last shift was driven by the need for readability on mobile phones.

The entry captures the developer mid-process, connecting broad ideas—like vendor lock-in and the importance of web accessibility for AI—to a concrete refactoring task. The "magic rolling pin" is the author's personal metaphor for the iterative process of simplifying and organizing a project. This specific log documents the application of that principle to the Pipulate codebase, using newly mastered command-line tools to perform a small but significant refactoring, demonstrating a rapid cycle from high-level strategy to hands-on execution.

---

## The Coming Wave: From Mobile-First to AI-First

Alright, now it's time to pick up the pace. I am killing a lot of birds with one
stone including speeding up my process by not shying away from old school
metaphors that still work and are the best way to express an idea. The cudgel
stick of nattering nitwits is language policing. I like the trend of taking back
our language and the freedom of our minds. It was refreshing to hear NASA
officials refer to mankind instead of humankind in their announcement the other
day that they have confirmed the signature of life on Mars. I have to get over
this myself as I went along with the social conditioning of the past decade or
so to make craftsmanship something you could not master, but rather craftsperson
ship something you had to become spontaneously expert at. Blecch! What would Mad
Magazine say?

Anyhoo, I did my thought-work on doing headless Shopify. Now I just need
something to sell. The natural choice is *one-on-one* sessions in setting up
Pipulate. I should try to go for innovation in there in only selling guaranteed
*time windows* before issuing a refund. I don't want a hard-and-fast scheduling
window because like on-the-road repairmen and deliverymen, you can't assure
someone of a particular time. But you can give a window and reschedule the
window. That's the sort of thing I want to do. And maybe we only charge them
after the session has actually occurred. That way I don't nail down any sort of
concrete scheduling that would go against my vibe or conflict with my day-job
and I keep Pipulate in the free and open source world but drive up its value by
having something you have to *pay for* about it, giving me my foot in the door
with Shopify.

I need to have *something* to sell and it should be infinite inventory digital
product because that's so much easier than hardgoods, but let's face it, the
most difficult thing about Pipulate is getting over that Nix learning curve and
installation hump. In a way selling that is even better than digital product
because I don't have to have that whole paranoia about pirating and copyright.
The typical solution is to sell subscription access to a hosted solution like
any software as a service (Saas) product these days, but I don't want to even
provide hosting management myself. Pipulate gets installed on their own
machines and I'm selling them the magic unlock to cloud independence for many
things, and that takes a few moments of cheerleading, assurance and
hand-holding. That's what I'm selling.

This is the Nix shift, but I probably shouldn't put it in those words. It's just
a bit of quick magic hand-waving to first install Nix, then Pipulate, then walk
them through their first workflow or such granting them a genie in a bottle, and
we're done. I should have something as a follow-up so they can keep sending me
money if they like, presumably to keep me developing on the things they want
developed workflow-wise, but without assurances or guarantees that I can or will
follow their prescribed path. Maybe it gets them increased access to me through
a Discord server or something. Hmmm.

So what is this article? Clarifying my next round of projects! I've got another
focused weekend coding stint coming up and I don't want to squander it.

My starting point is profoundly better than before because I'm effin off
VSCode/Cursor and my magic rolling pin strategy is guided by my improving
ability to do global search-and-replaces from the command line.

But that's all foundational *what is my environment and core capabilities*
issues. That's all start-up cost. Ugh, there's so much that has been startup
cost in my repositioning for the age of AI. How do you future-proof yourself for
the next 10 or 20 years. The actual mere ability to think you can do so sounds
more like science-fiction these days than the actual science-fiction, given the
pace of change. So we look for long-term inevitabilities that are also somehow
tied to skill-sets you can develop, and it always comes up vim.

In fact, it always comes up the precise short-stack I've been talking about
forever. I hit a bullseye with this and the world just doesn't know it yet, so I
need to keep leaning in on it and bearing down on it and making stuff the
web-crawling AI-bots will discover over and over and over, and every time go
"Oh, this is different... maybe there's something to this!" And then have the
preponderance of proof and evidence to back it up. We're battling the fizzling
out effect.

You know who's battling the fizzing out effect? FastHTML! It made quite a splash
this time last year, got lots of high hopes, but the news cycle basically
drowned it out. Things like MCP eclipsed it in news and nobody built any
game-changing stuff on it in a timely enough fashion to ride the wave of its
initial splash. There has been no Rails to its Ruby. Pipulate may become that,
but I need to strip it down into its barebones state so it doesn't get confused
and obfuscated by all this other stuff, and then also have the killer-app
workflow built into it by default that everyone needs all the time, which
aligns to why anyone would buy installation training from me on Shopify.

Yes! This is Cloud independence, but optional leveraging when you need it.

This is vendor-login prevention, having a nice capable vendor-free baseline set
of capabilities that won't go obsolete on you next year.

This is getting off the hamsterwheel churn of the tech industry without jumping
on yet another new platform that's just going to churn on you too.

I don't want to turn this article into yet another Python/HTMX cheerleading
session, but I do feel I need to spell a few things out with axioms, first
principles, core assumptions or whatever you want to call them.

## Why Modern Frameworks Fail the AI Readability Test

People are having a hard time figuring out what to do next and why. That's what
I've got to address, the next-steps clarity. It's very similar to the transition
from the world of Shockwave and Flash to Mobile-first which was caused by not
merely the advent of smartphones in general, but the iPhone in particular which
both didn't support Flash and made mobile such an appealing platform for the
Web, and thus held the websites to a much higher standard. It's *readability* on
the mobile platform. So now is the same kind of *readability* on (or by) the AI
platform. It's always the same and it's most certainly not a shame. That's all.

It's funny that there's even a lack of clarity. All you have to do is
"view-source" to see the source HTML on any website and say if you were an AI,
how would you like to have to look at that and parse through all of that? Oh,
just convert it to markdown? Okay, look at all the semantics you'll lose of the
HTML tags. No problem because headlines like `<h2>`'s become hashes like `##`.
Okay, what about the `<nav>` element that has tons of semantic meaning for
navigating the site? Oh, no problem: AIs can control a web browser and execute
JavaScript, right? Well yes at just like 100x the cost because now you have to
run your webpage and all its resources like executing a program instead of just
fetching a single `.html` text-file. And even when you do that, the rendered
document object model (DOM) that makes your source-HTML look a bit cleaner and
turns all your JavaScript links into normal HTML-links (now readable in the
tree) is still a mess. AIs aren't going to want to look at a rendered DOM much
either.

Okay, so now we crank it up to 11. Today's browsers, particularly Chrome, render
an internal *accessibility-tree* using the HTML tags that actually have semantic
meaning like `<nav>` and pieces it together with all the other clues like the
`role` and `aria-label` attributes on the HTML tags, and now you've got
something far cleaner than either the source HTML and the rendered DOM, and it's
made specifically for the *visually impaired* which sounds a lot like an LLM of
the non-multi-modal variety. So what you do for the visually impaired is also
excellent for AIs — and plain old SEO for that matter. It's a win, win!

And what's best of all is it's all just stuff everybody really knows anyway but
which has been terribly, horribly derailed by the JavaScript frameworks of the
past 15 years or so, because they didn't care about accessibility or SEO. By
turning old-school web development into much more like traditional application
development you chop a 1-person job into a 10-person job and farm the work out
to lots of specialists, charge more and everybody wins — except the website
owner who wants this one little change — or worse yet, some sort of global pivot
that would require a complete scrap-and-rebuild... and lots more money.

Now there's lots of arguments for this sort of approach, especially if you're
building what we buzzword-label *an enterprise scalable application* like
Netflix. You're not going to get a Netflix app from old-school webmastering
practices. But most websites are brochure-ware. Even the spate of single-page
applications (SPA) style websites that have come out as a result of the
JavaScript frameworks are mostly just brochureware with fancy navigation. It's
unnecessary, gratuitous, overly complex and exactly analogous to Flash Shockwave
websites from the 1990s that didn't survive the mobile revolution. Nobody sees
it coming but there's a big cleanup of the web coming for AI that's nothing less
than the shift to responsive design that allowed the same website to work on
phones, mobile and desktop.

That's an easy way to frame it. Remember the Web before the iPhone? Look at the
Web now. Same with AI. But instead of all the nuances you had to master for
responsive design for multi-platform targeting, the nuances are around not
insulting the sensibilities of a visually disabled intelligence that's probably
smarter than you.

## The Vicious Cycle of AI-Generated Documentation

And THIS frames my next-step projects really well. But with this clarity of
thought comes the next issue as I peel away the layers.

I will send this article to an AI and it will produce yet more gab. LLMs have
the ultimate gift of gab and they will fill up your git repo with unlimited
markdown files in the guise of documentation and rules if you let them until you
have a 10-to-1 then 1000-to-1 to a million-to-1 ratio between the amount of code
you have and the amount of yabber you have talking about the code. I fell into
that trap, maybe not quite so severe, but that's my current situation. And I
need to fix that because the trimming-down, pairing and pruning of the markdown
without loosing things of critical value is part of the solution. The itch we're
scratching here is sending everything to the recycle bin for final review,
optional extraction of core muscle to leave on the bones. Barebones plus core
minimal ligament and muscle to hold it together with documentation, that's what
I want. And what's more, as little of it as possible should be separate markdown
files but rather should be incorporated in the best possible ways into the `.py`
Python files as docstrings and such.

Okay, this is an auspicious start to my weekend.

Stop being patient and ask yourself how you can accomplish your 10-year plan in
6 months.

Right.

This involves more rapid iteration from ideas here in the stream of
consciousness freeform style into the actual concrete doing of stuff.

By the time this weekend is out, I should be doing home-hosting. Don't bite off
more than you can chew. It's about the relentless tik's and tok's more than it
is about the size of any particular tik or tok. Home-hosting is something I've
kicked forward time and time again, even though I've done the network
segmentation for home hosting. There is picking a machine and setting it up for
hosting. But that's a big part of the point. It should be almost any machine at
all if my theory is correct about a NixOS install and application of a floating
configuration file. I could start on a retired laptop, move to a Raspberry Pi,
whatever!

## From Theory to Practice: Applying the "Magic Rolling Pin"

Okay, so methodology! What I need is a refinement of how fast I do things. It's
the process of going from thinking to doing more rapidly. Okay, apply the magic
rolling pin. Throw yourself a softball.

```bash
[mike@nixos:~/repos/pipulate]$ ls
app_name.txt           downloads                          piper_models
assets                 favicon.ico                        pipulate.egg-info
botify_token.txt       flake.lock                         plugins
browser_automation     flake.nix                          __pycache__
client                 helpers                            pyproject.toml
cli.py                 __init__.py                        README.md
config.py              install.sh                         requirements.txt
cruft                  LICENSE                            server.py
data                   logs                               tools
demo.json              mcp_tools.py                       training
discover_mcp_tools.py  modules
dist                   notebook_introduction_local.ipynb

[mike@nixos:~/repos/pipulate]$
```

Shorten the *width* of `notebook_introduction_local.ipynb` while fixing any
references to it.

```bash
[mike@nixos:~/repos/pipulate]$ rg notebook_introduction_local.ipynb 
flake.nix
138:        localNotebook = "notebook_introduction_local.ipynb";

README.md
1088:    ├── notebook_introduction_local.ipynb  # Editable (non-auto-updating) copy of hello.ipynb

[mike@nixos:~/repos/pipulate]$ 
```

## A Live Refactor: Rehearsing the `rg | xargs sed` Workflow

Perfect. There's 2 occurrences. You'd think I'd also rename the file in root,
but I know that the installation copies and puts it in location. This is a
perfect opportunity to test the new *partial install* feature that I added with
the `nix develop .#dev` command which lets me run the installation procedure
without automatically doing the `git pull` that does the auto-update off the
GitHub repo thus writing-over and cancelling out my new local work, haha! I
wrote an accidental *Useless Machine* aka "Leave Me Alone Box" haha! And I had
to support optionally disabling the auto-update if I wanted to test anything
that was part of the installation procedure. And this is perfect.

```bash
[mike@nixos:~/repos/pipulate]$ rg --null -l notebook_introduction_local.ipynb 
flake.nixREADME.md
[mike@nixos:~/repos/pipulate]$
```

Okay, so far so good. It all looks like it's on 1-line now but that's really the
null character being used as the delimiter or separator. That's exactly what I
want. I can feel this new capability gathering steam. Next I'm going to feed it
to `xargs` but without `sed`...

```bash
[mike@nixos:~/repos/pipulate]$ rg --null -l notebook_introduction_local.ipynb | xargs
xargs: WARNING: a NUL character occurred in the input.  It cannot be passed through in the argument list.  Did you mean to use the --null option?
README.md

[mike@nixos:~/repos/pipulate]$
```

Okay, very nice. This makes the need for the `-0` flag make more sense. If you
use the `--null` flag from the `rg` input which is apparently best practice
here, then you need the `-0` downstream.

```bash
[mike@nixos:~/repos/pipulate]$ rg --null -l notebook_introduction_local.ipynb | xargs -0
README.md flake.nix

[mike@nixos:~/repos/pipulate]$
```

Wow, nice. Talk about a *Useless Machine* haha! This pipes from `rg` to `xargs`
without applying it against any program needing the args. And we can do that in
a sort of testing mode by simply leaving off the `-i` argument of `sed` which
stands for *in-location* so without it doesn't actually write the search/replace
changes.

## Debugging in Real-Time: The Alias Trap and Nix Dependencies

```bash
[mike@nixos:~/repos/pipulate]$ rg --null -l notebook_introduction_local.ipynb | xargs -0 sed 's/notebook_introduction_local.ipynb/hello_world.ipynb/g'
sed: can't read README.md: No such file or directory
sed: can't read flake.nix: No such file or directory

[mike@nixos:~/repos/pipulate]$
```

Now that's a mystery I made for myself by creating an alias so that I can pipe
the color-coded version of the `rg` output through `less` but now I have to
remember to backslash `\` the `rg` program whenever I get up to the `sed` step
or I'll get that error. I will either eventually remove that alias or get into
the habit of including `\rg` in the command:

```bash
[mike@nixos:~/repos/pipulate]$ \rg --null -l notebook_introduction_local.ipynb | xargs -0 sed 's/notebook_introduction_local.ipynb/hello_world.ipynb/g'
```

...the output is too long to include here, but it is a nice test. It streams the
output to the console instead of writing the actual change into the file. So my
last step is:

```bash
[mike@nixos:~/repos/pipulate]$ \rg --null -l 'notebook_introduction_local.ipynb' | xargs -0 sed -i 's/notebook_introduction_local.ipynb/hello_world.ipynb/g'

[mike@nixos:~/repos/pipulate]$ rg notebook_introduction_local.ipynb

[mike@nixos:~/repos/pipulate]$
```

Nice. Now I actually delete the `notebook_introduction_local.ipynb` file itself
and run `nix develop .#dev`.

Oops, what a surprise: Python312Full has been removed from the Nix unstable
repo. I always thought that naming convention was unusual. So why did I use it?
At the time Python312 didn't have everything I needed. It was likely `pip` or
some other dev tool that's in and out of the Python standard library. It looks
like whatever it was is back in because making the simple edit:

```diff
    116 -   python312Full                # Python 3.12 interpreter (consistent version)                   │
    116 +   python312                    # Python 3.12 interpreter (consistent version)
```

...fixed it. Gonna update it and push it, but it's very much reminding me that
the release system where I can easily rev the version number and push the whole
thing to PyPI (where it goes to become pip installable) is very much the next
thing to do.

```bash
[mike@nixos:~/repos/pipulate]$ git commit -am "Fixed the version of Python being used"
On branch modularize
Your branch is ahead of 'origin/modularize' by 2 commits.
  (use "git push" to publish your local commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	hello_world.ipynb

nothing added to commit but untracked files present (use "git add" to track)

[mike@nixos:~/repos/pipulate]$ vim .gitignore 

[mike@nixos:~/repos/pipulate]$ git status
On branch modularize
Your branch is ahead of 'origin/modularize' by 2 commits.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   .gitignore

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	notebook_introduction_local.ipynb

no changes added to commit (use "git add" and/or "git commit -a")

[mike@nixos:~/repos/pipulate]$ rm notebook_introduction_local.ipynb 

[mike@nixos:~/repos/pipulate]$ ls
app_name.txt        client     data                   downloads    hello_world.ipynb  LICENSE       piper_models       pyproject.toml    tools
assets              cli.py     demo.json              favicon.ico  helpers            logs          pipulate.egg-info  README.md         training
botify_token.txt    config.py  discover_mcp_tools.py  flake.lock   __init__.py        mcp_tools.py  plugins            requirements.txt
browser_automation  cruft      dist                   flake.nix    install.sh         modules       __pycache__        server.py

[mike@nixos:~/repos/pipulate]$
```

## One Small Step: The Power of Rapid Iteration

Alright. That has been a massive success. The `hello_world.ipynb` file is in
location from running the partial install test.

This bodes very well.

Does this baby-step little edit on the Pipulate repo count as picking up the
pace? Is it as ambitious as Elon suggests accelerating your 10-year plan to 6
months? Maybe not, but it's a start.

---

## Book Analysis

**Crafting Compelling Narratives: Title & Filename Brainstorm:**

* **Title Option 1:** The Next Great Web Cleanup: Designing for AI Readability
    * **Filename:** `web-cleanup-ai-readability-htmx.md`
    * **Rationale:** This title is forward-looking and captures the core thesis of the entry. It attracts readers interested in future web trends, AI's impact on SEO, and the architectural principles behind building for a new kind of user (the AI).
* **Title Option 2:** From High-Level Strategy to a Single Command: A Refactoring Workflow
    * **Filename:** `strategy-to-command-line-refactoring.md`
    * **Rationale:** This title focuses on the author's process and methodology. It's compelling for developers who struggle to bridge the gap between ideas and execution, showcasing a tangible example of moving from thought to action.
* **Title Option 3:** Escaping the Hamster Wheel: A FOSS-Based Philosophy for Durable Skills
    * **Filename:** `foss-philosophy-durable-developer-skills.md`
    * **Rationale:** This title speaks to the philosophical underpinnings of the entry—the desire for vendor independence and long-term career resilience. It appeals to a broader audience of developers feeling burned out by the constant churn of the tech industry.
* **Preferred Option:**
    * **Title (plain text for YAML):** The Next Great Web Cleanup: Designing for AI Readability
    * **Filename:** `web-cleanup-ai-readability-htmx.md`
    * **Rationale:** This is the strongest option because it articulates the most novel and impactful idea in the entry. It serves as a powerful hook, framing the practical coding exercise within a significant, forward-looking industry prediction, making it highly valuable for a book chapter on future-proofing web development.

***

**Book Potential Analysis:**

* **Strengths as Book Fodder:**
    * **Strong Central Thesis:** The core idea that "AI readability" is the next major driver of web evolution, analogous to the "mobile-first" shift, is a powerful and book-worthy concept.
    * **Connects Philosophy to Practice:** The entry masterfully links high-level ideas about digital sovereignty and industry trends directly to a concrete, line-by-line command-line session, which is a rare and valuable form of technical writing.
    * **Authentic Problem-Solving:** It captures the messy reality of development, including hitting unexpected dependency issues (`Python312Full`) and dealing with self-inflicted problems (the `rg` alias), which makes the process relatable and instructive.
    * **"Show, Don't Tell" Methodology:** The author doesn't just talk about rapid iteration; they perform it live within the journal entry, demonstrating the principle in action.
* **Opportunities for Enrichment (for Book Adaptation):**
    * **Illustrate the Accessibility Tree:** When discussing the accessibility tree as the ideal target for AIs, include a simple diagram comparing raw HTML source, a rendered DOM, and the cleaned-up accessibility tree for the same web component. This would visually solidify the core technical argument.
    * **Create a "Future-Proofing Principles" Box:** Distill the author's axioms into a concise "Key Principles" call-out box. This would include points like "Prioritize Semantic HTML," "Minimize JavaScript Dependencies," and "Build for Vendor Independence."
    * **Expand on the "Fizzling Out Effect":** Briefly elaborate on the FastHTML example, defining the "Rails to its Ruby" concept more explicitly for readers who might not be familiar with that history. This would strengthen the argument for why Pipulate's success depends on having a killer app.

***

**AI Editorial Perspective: From Journal to Chapter:**

This entry is a superb foundation for a chapter on "Architecting for the Future." Its power lies in its seamless weave of blueprint, strategic plan, and tactical execution. The author isn't just presenting a finished argument; they are building it in real-time, letting the reader witness the synthesis of disparate ideas—from Shopify business models to the history of Flash, from web accessibility to Nix package management. This raw, "thinking out loud" format is a significant strength, offering an unfiltered view into how a senior developer connects macro trends to micro decisions.

The narrative arc, moving from a broad thesis about an "AI-driven web cleanup" down to a successful five-minute refactoring task, is incredibly effective. It serves as a potent case study for a chapter on "Developer Velocity" or "Closing the Strategy-Execution Gap." The entry demonstrates that large-scale vision doesn't have to lead to analysis paralysis; instead, it can fuel and inform small, immediate, and confidence-building actions. For a book, this piece is an authentic and compelling exhibit of how a clear personal philosophy can transform routine coding into a purposeful act of future-proofing.

***

**Suggested Next AI Processing Steps:**

1.  **Task Suggestion 1:** Distill Actionable Principles.
    * **Potential Prompt Snippet for Next AI:** "Analyze the provided text and extract 5-7 core principles the author advocates for 'future-proofing' a web project. Phrase each principle as a concise, actionable directive (e.g., 'Target the Accessibility Tree, Not the DOM'). For each principle, provide a one-sentence explanation of its importance based on the author's reasoning."
2.  **Task Suggestion 2:** Outline a Contrasting Viewpoint.
    * **Potential Prompt Snippet for Next AI:** "Read the author's critique of JavaScript frameworks. Now, adopt the persona of a senior front-end developer at a large tech company. Write a 2-3 paragraph rebuttal that presents the strongest arguments *for* using complex frameworks like React or Angular, focusing on benefits like scalability, component ecosystems, and hiring pipelines, providing a balanced counter-argument to the author's thesis."


