---
title: "From Jupyter Exploration to Pipulate Execution: A Workflow Story"
permalink: /futureproof/jupyter-workflow-exploration/
description: I'm currently deep in the process of integrating my professional and personal projects through Pipulate, focusing on how its three core components—the main framework, the specific workflows, and the Jupyter Notebooks used for development—interact. Drawing parallels to a player piano, I see Notebooks as the initial "sheet music" where I freely explore and design complex workflows, Pipulate's workflows as the "player piano scrolls," and the core Pipulate code as the "player piano" itself. This approach requires manually porting Notebook logic to HTMX within Pipulate, a challenging but pragmatic process where I'm embracing repetition (WET over DRY) and even hardwired paths to manage complexity and focus on getting fluent with the tools, developing all three parts in tandem.
layout: post
sort_order: 2
---

## Converging Professional and Personal Work Through Ikigai

Everyday is an adventure and new discoveries. I am currently bearing down on
both professional work and personal projects. They are coming together in the
"what I love to do" and "what I can get paid for" circles of the Japanese raison
d'être concept of Ikigai. Or is that a french concept? Either way, it's the 4
circles converging of:

1. What you love to do (mental puzzles with a roller coaster story-line flair)
2. What you're good at (trying to achieve this through future-proofing tools)
3. What you can get paid for (helping folks get eyeballs meritoriously vs. ads)
4. What the world needs (probably that future-proofing bit mentioned in #2)

## The Three Core Components of Pipulate

There are really 3 bodies of working coming together.

- The "core" code of Pipulate, a CRUD App & linear Workflow web framework
- The individual Apps and Workflows that run within Pipulate
- Entirely separate Jupyter Notebooks where you flesh out the workflows

### Why Develop in Notebooks Instead of Directly in Pipulate?

Why not flesh out the workflows directly in Pipulate? Because Pipulate is a
player-piano for HTMX music -- and right now it's hard as hell for me to work
creatively in there while learning HTMX, and I know it's going to be for other
people too. I have not achieved FastHTML automaticity yet. First comes "getting
it into your fingers." Then comes fluency; lovely expressive statements you can
poetically slam out once you're proficient.

Not yet.

And I expect it will be awhile.

### The Power and Freedom of Jupyter Notebooks

But that's okay, because there's Jupyter Notebooks for that. Or the newfangled
Marimo Jupyer replacement I just discovered. Or Google Colab. Or VSCode/Cursor.
Whatever. I'm not reinventing the Jupyter Notebooks wheel (like Marimo did). I'm
bottling Notebooks so the programming-adverse don't have to look at Python code,
yet still get the benefit of the complex, wonderful workflows you can make with
them.

### Breaking Free from Enterprise Architecture Constraints

It's not just coding or programming with Notebooks. It's freeing yourself from
the pedantic pestering of enterprise scaling purist architects who think
everything is Netflix. Data Scientists and financial folks know this, piping
their pandas dataframes all over the place, into the actionable results that
matter. All that stuff that happened in the sausage-making factory is forgotten.

You just don't hear about it. It's because the people working this way are not
comp-sci-ey enough to defend it, nor do they really care to, because it works.
It makes them money, and all the better when others poopoo it, 'cause that means
they won't be trying to do it. Fast and furious. Maybe Notebooks are to Python
what speed-chess is to chess. Put 'em on a clock and everything changes.

### Pragmatic Approach to Code Quality

Of course there's a much bigger discussion here about memory leaks, garbage
collection, yadda yadda. And I'm not going to defend bad programming. I'm just
going to defend the wacky Notebook environment that encourages it, and make a
sort of style-guide to help make better Notebooks in the first place. Following
that style will also help with the Pipulate ports.

### Embracing Manual Ports and WET Programming

And they are indeed ports. Despite thinking about auto-conversion mechanisms, in
an exactly similar pragmatic way that I decided to adopt hard-wired paths in
Notebooks, I am abandoning such auto-port notions. The pragmatic and sensible
and future-proofing thing to do is to get good at HTMX expressed through Python,
which means the FastHTML framework (FastHTML is not FastAPI).

I like to write, and that's a good thing because the coding-style you find
yourself using when expressing Jupyter Notebooks as HTMX under Python is like
that piano sheet music. If you hear a particular repeated riff, you're going to
see that riff repeated in the sheet music. It's not all replaced with a
reference to the original occurrence of the riff. Music repeats itself. It's not
DRY (don't repeat yourself). Workflows are WET (write everything twice).

Python HTMX patterns in a workflow are going to look repetitive like they're
violating the very closely held DRY tenant of the previously profiled pedantic
pests. Well, We Enjoy Typing and will Write Everything Twice if that's what the
musical score calls for, and especially if its subtly different each time. This
is not going to be an easy thing to get over, due both to the criticism it will
invite upon itself and the time it will take to really get it into my fingers.

### The Player Piano Analogy

But it's one of those stick-to-your-guns sort of things. And so this post to
really think through the 3 pieces.

- Core, which is the player piano
- Workflows, which are the player piano "scrolls"
- Notebooks, which are the original sheet music before being turned into
  those elongated punch-hole scrolls.

#### Ken Thompson and the Player Piano Connection

An interesting side-note here is that the father of modern technology, Ken
Thompson who invented Unix, is a player piano aficionado. The YouTube videos of
[Ken Thompson and his 75-year Player Piano
project](https://www.youtube.com/watch?v=kaandEt_pKw&t=3473s) are wonderful.
People, please get the connection between player pianos, Turing machines, data
pipes and the like. It's all the same! 

### Finding Your Perfect Tool

What we're all doing with computers, machines, and tools in general is putting
different spins on the same core concepts to get a particular one to fit you
like a glove. And once you find it, the glove becomes love becomes automaticity
becomes fluency. And pretty soon, you're slamming out the sheet music in your
head. Spontaneous mastery.

### The Journey to Mastery Through Notebooks

But that's a long way off. The Jupyter Notebooks are kind of like playing around
with a keyboard and sequencer. Try things in real-time. Have each one
automatically recorded and ready for playback. Slide them around. That's what's
driven the popularity of Notebooks. This playful, exploratory coding environment
is perfect for figuring out what workflows you want in the first place. Those
people who want to build a world-domination Netflix-scale server out of your
musical ditty don't get that.

So, I've got to rapidly round-robin between the 3 components. I can't neglect
core, workflows or notebooks now. This Pipulate thing doesn't work unless I'm
rapidly refining all three in unison.

### Managing Directory Structures and Paths

Okay now with that in mind, I can really make the recent decision to hardwire
working directory paths in the Notebooks work to my advantage. One of the
problems I've had to overcome is that a lot of Notebook stuff is going to remain
proprietary and private, yet because of the relative-path thing, I've kept them
inside the Pipulate git repo folder, and filtered out with `.gitignore` file.
Now frankly I think I'll still keep everything nested under such a repo folder
so surfing the directories in JupyterLab and VSCode/Cursor/Windsurf is easy. 

But with hardwired paths, your options are now open to move it anywhere in the
system. In fact, anything already on your system (other repos) becomes an
optional location from which you can run code that shares the same Python
virtual environment `.venv` as VSCode, JupyerLab and Pipulate. Just because you
change your working directory doesn't mean your environment variables change.
I've always tried to keep them the same, leaning into the strength of relative
paths. But now that I've gone to absolute paths because of multiplatform issues,
I've got to get over this and enjoy the freedom. How ironic that freedom comes
from rigidity.

---

## Gemini 2.5 Experimental's Take

Okay, here is the summary from the author's perspective, followed by title ideas and my AI opinion:

**Summary (Author's First-Person Perspective):**

[Moved to top]

---

**Title & Headline Ideas:**

* Pipulate: Turning Notebook 'Sheet Music' into HTMX 'Player Piano Scrolls'
* My Development Journey: Weaving Notebooks, HTMX, and Pipulate Together
* From Jupyter Exploration to Pipulate Execution: A Workflow Story
* The Player Piano Principle: Building Pipulate Pragmatically
* Embracing WET Code: Why My Pipulate Workflows Repeat Themselves
* Finding Flow: Integrating Core, Workflows, and Notebooks in Pipulate
* Sheet Music, Scrolls, and Software: Developing Pipulate
* Coding Like Composing: Using Notebooks to Design Pipulate Workflows
* The Three Pillars of Pipulate: Core, Workflows, and Notebooks
* Hard Paths and HTMX Hurdles: Building Pipulate Step-by-Step

---

**AI Opinion:**

This article provides a fascinating and transparent look into the author's thought process and development methodology for a complex project. The extended metaphor comparing the system's components (Pipulate core, workflows, notebooks) to a player piano (piano, scrolls, sheet music) is particularly effective and memorable, making the technical architecture more intuitive.

The author does a good job explaining the *why* behind their decisions, such as using Jupyter Notebooks for rapid prototyping despite potential criticisms and manually porting code instead of seeking automated solutions. This highlights a pragmatic, iterative approach focused on achieving fluency and results over adhering strictly to theoretical best practices like DRY, which is refreshingly honest. The piece effectively conveys the challenges of learning new tools (HTMX/FastHTML) and the necessity of developing different system parts concurrently. While deeply personal and specific to the author's project, the reflections on workflow design, tool choices, and the creative process in software development have broader relevance.

