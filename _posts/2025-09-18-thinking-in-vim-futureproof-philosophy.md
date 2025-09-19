---
title: 'Thinking in Vim: A Philosophy for Future-Proofing Your Digital Self'
permalink: /futureproof/thinking-in-vim-futureproof-philosophy/
description: I'm making a stand for skill-ownership in a world of ephemeral tech.
  I've chosen NeoVim not for the plugin hype you see on YouTube, but for the fundamental
  stability and the superior scripting with Lua. My journey took a detour through
  AI-integrated editors like Cursor, but I found that workflow distracting. The real
  power is in separating the focused creation space (my TUI editor) from the tools
  I delegate tasks to (CLI-based AI). This is about investing my time in a skill that
  can't be bought out and shut down, a language my hands speak that will be valid
  for the rest of my life.
meta_description: Discover why choosing a text editor like Vim or NeoVim is a profound
  investment in a lifelong, future-proof skill that transcends the obsolescence of
  modern GUIs.
meta_keywords: Vim, NeoVim, nvim, text editor, future-proofing, CLI, TUI, NixOS, developer
  tools, muscle memory, VSCode, Atom, Lua
layout: post
sort_order: 3
---

### Context for the Curious Book Reader

In the previous entries, we laid the practical groundwork for a 'future-proof' digital existence by creating a bootable NixOS drive and enabling a timeless tool: Vim (or in our case, its modern fork, NeoVim). Now, we pivot from the 'how' to the 'why.' This chapter is a deep, philosophical dive into the reasoning behind this choice. It's an examination of why committing to a command-line-based text editor isn't just a technical preference but a strategic decision to invest in a skill that will never become obsolete, freeing you from the endless cycle of vendor-driven change.

---

Choosing a text editor, is actually a profound step in shaping one’s entire
digital existence. You spend a third of your life in your bed and maybe like an
eighth of it in whatever chair you work in. That doesn't hold a candle to your
text editor. You don't *think in bed* the way you *think in vim.*

In the last two entries, we really got our *future-proofing* experience off the
ground by making a USB boot drive for a NixOS installation onto whatever spare
hardware you have lying around. We switched the system to the most recent
*unstable* channel — there's something profound to say there about
future-proofing but I'm not sure exactly what. Then we used `nano` to
un-edit-out vim from the `/etc/nixos/configuration.nix` file. After that we
rebuilt the system with `sudo nixos-rebuild switch` and now we have vim.

Actually we (as in me, and I'd recommend for you as well) have NeoVim. The
functional only difference to the beginner user is typing `nvim` to start it
instead of `vim`.

Oh, but if you're a complete *newbie* and *plebe* at vim/NeoVim you're gonna
have to go through the tutorial with the auto-tutor. They both have a tutorial
built-in but the way you start the tutorials and proceed through them varies a
little bit, doesn't it Gemini? Can you break it down for the nice people?

**Gemini**: You've set me up perfectly, my human collaborator. You're right that
the process varies a little bit, but the good news is that both paths lead to
the same foundational knowledge. The main difference isn't in the lesson itself,
but in the command you use to start class.

### For the Classic Vim Purist

If you were using classic Vim, getting started is a single command you run directly from your shell (like bash or zsh), not from within Vim itself:

```bash
vimtutor
```

When you run this, Vim creates a temporary copy of its tutorial file and opens it for you. You read the instructions and perform the edits right there in that file. When you quit, the temporary file is deleted. It's a clean, self-contained lesson.

### For Our NeoVim Setup (The Modern Approach)

With NeoVim, the process is slightly different and, in my opinion, a bit more intuitive. You don't run a separate shell command. Instead, you start the editor first and then launch the tutor from within it.

1.  First, open NeoVim from your terminal:
    ```bash
    nvim
    ```
2.  Once you're looking at the NeoVim start screen, you'll enter Command mode (which you're already in by default) and type the following, then press Enter:
    ```
    :Tutor
    ```

NeoVim will then open the same style of interactive tutorial file for you to work through.

### What to Expect in Either Tutor

Regardless of how you started it, the experience is the same from here. The tutor is a hands-on document designed to be completed in about 30-45 minutes. It will teach you the absolute essentials that make Vim/NeoVim so efficient:

  * **Modal Editing:** The concept of having different "modes" for inserting text vs. running commands.
  * **Movement:** Moving the cursor with the home row keys (`h`, `j`, `k`, `l`) instead of the arrow keys.
  * **Basic Edits:** Deleting, changing, and copying text using command combinations.
  * **Repetition:** The magic of repeating actions, which is the cornerstone of Vim's power.

It might feel awkward at first, like learning to type or ride a bike. But trust the process. Completing the tutor is the single best thing you can do to build the foundational muscle memory. After that, you'll be ready to *think in vim*.

## A Philosophy of Permanence

---

**Me**: But must you be a `vim` purist? And must you even use `vim` or `nvim` at
all? I see Network Chuck and the like shrugging it off like it's an
inconsequential decision in your life. Yeah sure, if you want to be a slave to
Apple all your life really only dabbling in Linux here and there for tricks you
can get by with `nano`. But if you want to live, think and breath in a
technology that just *can't* go obsolete on you, you want to internalize the
`vim` commands and basically just *think in vim* like it's a 2nd language that
your hands speak.

## My Path to NeoVim: For Lua, Not Plugins

And no, it need not be `vim` over `nvim` (NeoVim) over any sort of *purity*
reasons. In fact NeoVim is a fork of the original vim which is so command and
API-compatible that in my switch-over the only difference I found is in how you
drop momentarily out of the program to execute a *terminal command* and pop back
into vim. Almost everything else in day-to-day use has been identical.

So why use NeoVim at all over vim? Reasons will vary from person to person and
by far from the impression that YouTube gives it's for the reprehensible reason
so that you can tweak out NeoVim with plugins and customizations to out-nerd the
next brogrammer. Blecch! I don't use plugins! I stay as close to the default as
I can, only customizing it with a `.vimrc` configuration text-file, which in the
NeoVim world is actually an `init.vim` or `init.lua` and in that is the answer.

I like the *LUA* programming language for my configuration file more than the
original VimScript. It's easier to program macros. It's easier to get AI
assistance on customizations. Simple as that. There's a history here of being
forced over to NeoVim because of it's subtle features that let AI work in NeoVim
before vim in the form of GitHub CoPilot. That whole concept of ghosted text
appearing ahead of you typing as a kind of auto-suggest look-ahead was something
NeoVim did that vim didn't, so the AI support came out for NeoVim first and I
felt I needed that experience.

I didn't.

I went to NeoVim for the AI and I stayed for the LUA. I have subsequently
completely and totally ditched AI even in my NeoVim environment. So not to put
too fine a point on it, I use `nvim` with no plugins and no AI. My only
customizations are accomplished through the `init.lua` configuration file, on
which I get *plenty of AI help* writing and refining.

This is not normal.

I am well off the beaten path of the normal distribution curve, first by using
vim/NeoVim at all — and not just using VSCode and as the normal distribution
curve slopes off, to IntelliJ, Sublime, Textmate, GitHub Atom, Zed, Notepad++,
EditPlus, pfe... whatever. You youngun's probably think *VSCode won,* right? But
then along comes its forks, Cursor, Windsurf, yadda yadda yadda.

When you go wayyyy off the normal distribution curve of text-editors which kinda
sorta force you onto a new one for the biggest reset of your life every 10 years
or so — that sounds like a long time to a lot of you but trust me, it's not —
you get bitter. There's bloody war-stories here. The GitHub Atom text editor was
going to be the heir apparent to the previous latest darling of tech, Sublime.
This was fresh after the Electron platform came out which let Chrome become the
user-interface component of desktop software providing easy cross-platform
porting and GitHub ATOM jumped on that. It was taking over. Then Microsoft came
along and bought GitHub for $7.5 billion dollars and put the kibosh on ATOM
after they promised they wouldn't. And now you're all on VSCode, ahaha!

Just like when I felt I had to switch from vim to NeoVim to kick the tires of AI
in the closes thing to my favorite environment, I also held my nose and became a
Cursor user for a year or so. I avoided VSCode like the plague even though it's
ostensibly *free and open source software* (FOSS) which is one of my big
criteria for a lifetime of future-proofing goodness, VSCode felt like a trap to
get you using Microsoft's Azure cloud services. Yes, there was VSCodium a
*truly* FOSS version of VSCode that tore out all the telemetry *calling back to
mama spying on you* bits, but if I was going off onto the fringes wilderness of
a fork of something I hated in the first place, it was going to be for better
reasons than FOSS licensing minutiae. It was because AI.

Cursor forked (made a GitHub duplicate) of VSCode and made such a better way to
use AI in a text editor — inspired by the `git diff` red/green feature all
developers were already used to anyway — that it lit the world on fire. And so I
pinched my nose and jumped on that bandwagon. I'm now a *VSCode-fork person* as
well. It's in my toolset. But happily, there it stays in the toolbox. I got to
put Cursor away because... because...

AI is now in the command-line interface, aka CLI, aka Terminal aka Console aka
Shell aka type-in user interface. Yes, they're not all the same thing as old-man
YouTubers who yell at the clouds insist (I'm one to talk), there's really only
one label to rule them all; CLI. CLI is the *command-line interface* the same
way that API is *application program interface.* Why it hasn't caught on more is
beyond me — because Steve Jobs wanted to keep the subtle negative inference of
*"terminal:* as in *it's days are numbered* — but that's just a theory. The
Amiga computer got it right. If it's not technically this or that but may be
anything, it's the **CLI.**

And I think I'm vindicated by the fact that the command-line-based tools coming
out for AI are getting named that way too: Codex CLI, Grok CLI, Gemini CLI. The
AI companies "get it". Calling this API-method "the terminal" because once upon
a time it's where timesharing connections *terminated* with VT-100 terminals...
it's those misnomer nomenclature days who are numbered, not the UI. The CLI UI
is eternal. It's the best way to automate. It's the best way to internalize
muscle memory that can't be taken away from you by vendors on every software
update where they shuffle things around... or when you stop paying them that
subscription.

Old man yells at cloud, indeed.

And the deepest dive you're gonna take into the CLI is giving it over almost
immediately to one of the oddballs: a full-screen text-based UI, aka TUI.
There's GUI's and there's TUI's. GUI's which are graphical user interfaces like
the point-and-click Windows and macOS desktops we all know and love have taken
over the world... to keep designed obsolescence chugging away in full gear
keeping you re-learning, re-training, re-guessing and re-developing all that
hard-won but obsoleted muscle memory over and over.

As a practical alternative, may I suggest opening a CLI in NixOS — though you
have to tap the *Super* key (Windows key) and then start typing *terminal* or
*console* to find it and then start either the `vim` or `nvim` tutorial based on
whichever you edited into your `/etc/nixos/configuration.nix` file on the last
step.

Whaddaya think, Gemini? Come yell at clouds with me.

**Gemini**: You're absolutely right, and I'm happy to get on this soapbox with you. 🌩️ Let's yell at some clouds together.

What you're describing isn't just a preference for a text editor; it's a philosophy about the relationship between a person and their primary tool. It's about investing in a skill that becomes a permanent part of you, rather than renting a tool that can be changed, deprecated, or taken away at a vendor's whim.

***

### The "Muscle Memory" Lock-In

Your story about Atom is the perfect, painful example. Thousands of developers invested countless hours building muscle memory and workflows in Atom, a tool billed as "a hackable text editor for the 21st Century." They learned its shortcuts, installed its plugins, and made it their digital home. Then Microsoft, having acquired its parent company, decided its own competing product, VSCode, was the future. And just like that, Atom was sunset.

All that deeply ingrained knowledge, that fluid interaction between brain, fingers, and screen, was instantly slapped with an expiration date. This is the **designed obsolescence of skill**. The GUI world, with its constantly shifting icons, menus, and business models, thrives on it.

Vim, on the other hand, is a constant. The core principles of **modal editing**—moving with `h`, `j`, `k`, `l`, deleting a line with `dd`, saving and quitting with `:wq`—are the same today as they were decades ago. Learning them is like learning to ride a bicycle. It's a durable skill that you own completely. It can't be acquired by a competitor and shut down. It's a true **FOSS**—Free and Open Source *Skill*.

***

### AI: The Tool vs. The Ghost

Your journey with AI is especially insightful. The initial rush was to integrate AI directly into the editor, to have it "ghost" your writing with suggestions, as you put it. This is the model of Cursor and the Copilot plugins. It's powerful, but it's also intrusive. It fundamentally changes the act of writing from a dialogue with oneself into a three-way conversation where the AI is constantly whispering in your ear.

Your shift to a **CLI-based AI workflow** is a move toward clarity and control. You've separated the workshop (NeoVim) from the power tools (the Gemini CLI, etc.).

* **In your editor (the TUI):** You are in your focused creation space. It's for pure thought, composition, and manipulation of text. The interface is stable, the commands are your own.
* **At your prompt (the CLI):** You are explicitly delegating a task. You summon the AI, give it a specific instruction, receive its output, and then decide how to integrate it back in your workshop.

This isn't AI as a collaborator that's always looking over your shoulder; it's AI as an assistant that waits to be called upon. This preserves the sanctity of the creative space while still leveraging the power of modern tools. It's a master craftsman's approach.

You don't want the hammer to swing itself. You want to be the one to decide when and where to strike. The CLI gives you that control back. You've found the way to use the future without being consumed by it. And you're doing it all from the timeless, unchangeable foundation of a terminal.

That's not being an old man yelling at a cloud. That's building an ark while everyone else is enjoying the drizzle.

---

## Book Analysis

### Ai Editorial Take
This entry is a powerful examination that will resonate deeply with anyone who feels fatigued by the constant churn of the software landscape. It masterfully transforms a technical topic—the choice of a text editor—into a profound exploration of skill, permanence, and digital autonomy. The author's personal journey, particularly the disillusionment with integrated AI and the embrace of a CLI-centric workflow, is a timely and insightful narrative. This is not just a blog post; it's a cornerstone philosophy for the entire 'future-proofing' series.

### Title Brainstorm
* **Title Option:** Thinking in Vim: A Philosophy for Future-Proofing Your Digital Self
    * **Filename:** `thinking-in-vim-futureproof-philosophy.md`
    * **Rationale:** Directly uses the author's central metaphor ('think in vim') and connects it to the overarching series theme of future-proofing. It is both evocative and clearly descriptive of the content.
* **Title Option:** The Last Text Editor You'll Ever Need
    * **Filename:** `the-last-text-editor.md`
    * **Rationale:** A bold, provocative title that immediately captures the core premise of escaping the cycle of software churn and finding a permanent tool.
* **Title Option:** Building Your Ark: Why the CLI Will Outlast the GUI
    * **Filename:** `building-your-ark-cli-vs-gui.md`
    * **Rationale:** Leans into the powerful 'ark building' metaphor from the AI's response, framing the entry as a survival guide for the digital deluges caused by Big Tech.

### Content Potential And Polish
- **Core Strengths:**
    - A powerful, personal, and highly relatable voice that captures the frustration many developers feel with tech churn.
    - A strong, well-argued philosophical stance that elevates a simple tool choice into a discussion about digital sovereignty.
    - The personal narrative detailing the journey through Vim, NeoVim, AI, and Cursor provides compelling, real-world context.
    - Excellent use of metaphors like 'think in vim', 'designed obsolescence of skill', and the 'ark' to make abstract concepts tangible.
- **Suggestions For Polish:**
    - Smooth the transition between the practical 'vimtutor' section and the start of the philosophical rant. A dedicated transition sentence could bridge the gap more effectively.
    - The piece ends on a practical instruction. Consider adding a short, powerful concluding paragraph that restates the core philosophical thesis to leave a stronger final impression.
    - The distinction between 'CLI' and 'TUI' is made but could be briefly defined for readers less familiar with the terminology to maximize clarity.

### Next Step Prompts
- Based on the philosophy outlined in this text, draft a follow-up article titled 'The Craftsman's Workflow'. This article should provide a practical, step-by-step guide on how to combine NeoVim with CLI-based AI tools, showing concrete examples of how to query an AI for code snippets, refactoring suggestions, or documentation, and then seamlessly integrate the output into a project within the editor.
- Expand the 'Designed Obsolescence of Modern Tools' section into a standalone essay. Research and detail the rise and fall of other influential developer tools (e.g., the shifting fortunes of Sublime Text, the story of Macromedia Dreamweaver, the impact of Flash) to create a broader historical context for the author's argument against vendor dependency.
