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

## Managing Directory Structures and Paths

Okay now with that in mind, I can really make the recent decision to hardwire
working directory paths in the Notebooks work to my advantage. One of the
problems I've had to overcome is that a lot of Notebook stuff is going to remain
proprietary and private, yet because of the relative-path thing, I've kept them
inside the Pipulate git repo folder, and filtered out with `.gitignore` file.
Now frankly I think I'll still keep everything nested under such a repo folder
so surfing the directories in JupyterLab and VSCode/Cursor/Windsurf is easy. 

### Leveraging Absolute Paths for Greater Flexibility

But with hardwired paths, your options are now open to move it anywhere in the
system. In fact, anything already on your system (other repos) becomes an
optional location from which you can run code that shares the same Python
virtual environment `.venv` as VSCode, JupyerLab and Pipulate. Just because you
change your working directory doesn't mean your environment variables change.
I've always tried to keep them the same, leaning into the strength of relative
paths. But now that I've gone to absolute paths because of multiplatform issues,
I've got to get over this and enjoy the freedom. How ironic that freedom comes
from rigidity.

### Strategic Development and Maintaining Momentum

It's still early on a Saturday, but I'm going to put the pedal to the metal and
burn through some work. But it has to be done smartly! This kind of energy and
motivation can be burned on the wrong rabbit hole project, and there's nothing
worse than that downward spiral, so destructive for more than one reason. It
busts motivation, and you might not be any further along than before.

### Learning from Mistakes and Embracing Change

Sometimes a shift in thinking turns around the downward spirals, and you end up
realizing you are much better off for having had the experience. Life has its
ups and downs, and that's life. Without one extreme, you have no reference-point
from which to appreciate the other extreme. Mistakes intensify the joy of
progress, and appreciate the art and nuance of directional adjustments.

### The Power of Incremental Progress

Directional adjustments are a pipeline of butterfly effects. Small things make
tiny directional-tweaks to small things that make tiny directional-tweaks to
small things ad infinitum. Over time, you've turned the Queen Mary. So getting
started sooner rather than later is of benefit, because you need to leave
yourself a wide enough berth -- metaphorically, meaning time in your life!

### Finding Mastery Through Deliberate Tool Selection

I am a very late bloomer, realizing these things. Intuitively, I have
internalized tech tools, but repeatedly I have had my heart broken (Coleco Adam,
Commodore Amiga, Windows, Mac). Now it's finally time to properly future-proof
the tools I internalize. If you give yourself a 10-year berth for making that
turn-around, you can't be re-training on every next Agile/React/Vue/Svlelte that
comes along. The hamsterwheel of tech-churn has no place in mastery.

### The Satisfaction of Craft and Purpose

There's a mastery of craft discussion here. It has to do with satisfaction and
feeding the soul. It also has to do with that aforementioned Ikigai raison
d'être. It's nice to feel that satisfaction. Of all the various neurochemical
transmitters like dopamine and serotonin cocktails to flood your system with,
the one that comes from the intersection of the 4 circles of Ikigai.

---

## Gemini 2.5 Experimental's Take

Okay, here are the requested components:

**First-Person Summary (Author's Perspective):**

I'm currently deep in the development of Pipulate, balancing the core framework, specific workflows, and the exploratory power of Jupyter Notebooks. This process involves wrestling with new tools like HTMX, embracing pragmatic "WET" coding principles over strict "DRY" dogma, and using Notebooks as a creative sandbox before porting workflows. It feels like I'm finally aligning what I love (puzzles and storytelling), what I'm good at (or trying to be, with future-proof tools), what I can get paid for (helping people gain visibility), and what the world needs, much like the concept of Ikigai. This journey, including adopting absolute paths for flexibility and drawing parallels to player pianos, is about finding the right tools to achieve fluency and long-term satisfaction in my craft, moving away from the tech churn towards deliberate mastery.

**Title/Headline Ideas:**

* Finding My Ikigai Through Pipulate and Pragmatic Coding
* Pipulate: Juggling Core Code, Workflows, and Notebooks
* Why I'm Embracing WET Code and Notebooks for Pipulate
* The Player Piano, Pipulate, and the Pursuit of Programming Mastery
* From Notebooks to HTMX: My Journey Developing Pipulate
* Breaking Free: Ditching DRY Dogma for WET Workflows in Pipulate
* Pipulate's Three Pillars: Core, Workflows, and the Notebook Sandbox
* Coding for Flow: How Jupyter Notebooks Power Pipulate Development
* Future-Proofing My Tools: A Pragmatic Approach to Building Pipulate
* The Messy Middle: Navigating Development Challenges with Pipulate

**AI Opinion of the Article:**

This article offers a fascinating and refreshingly honest look into the author's development process and philosophy. The stream-of-consciousness style effectively conveys the real-time problem-solving, pivots in thinking (like adopting absolute paths), and the intellectual wrestling involved in building a complex software project like Pipulate while learning new technologies (HTMX).

The integration of the Ikigai concept provides a strong framing device, connecting the technical details to a deeper sense of purpose and personal satisfaction, making the piece relatable beyond just a technical audience. The analogies used, particularly the player piano, are insightful and help illustrate the relationship between the different components (Notebooks as sheet music, Pipulate core as the piano, workflows as scrolls).

While the structure is somewhat rambling, mirroring the exploratory nature of the work itself, it effectively captures the excitement and challenges of the creative coding process. The defense of pragmatic approaches (like using Notebooks despite potential criticisms and embracing WET code where appropriate) is a valuable counterpoint to rigid software development orthodoxies. Overall, it's a compelling personal narrative about the intersection of technology, craft, learning, and finding meaning in one's work.
