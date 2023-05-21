---
date: 2023-05-03
title: Rappelling Down the Rabbit Hole, X-Marks The Spot
headline: "Exploring the Depths of the Vim Rabbit Hole: A Journey Through Cognitive Dissonance"
description: Mike Levin, SEO in NYC, shares his experience of rappelling down the rabbit hole of GPT and other AI-related technologies. He explains the power of using one text editor for life and the advantages of using open source tools like NeoVim and Emacs. He also shares his insights into the dangers of AI and encourages readers to develop empathy for these technologies.
keywords: Rabbit Hole, Magic, Spells, Muscle Memory, vim, emacs, text editors, NeoVim, YAMLchop, API, Poetry, channeling, subconscious, Mercurial, DVCS, AMLesque
categories: emacs, magic, poetry, python, text editors, vim, muscle memory
permalink: /blog/rappelling-down-the-rabbit-hole-x-marks-the-spot/
layout: post
---


Three sort lines and a YAMLchop! Poetry strikes when you least expect it, and
when it does, you're channeling from somewhere deep, either an eternal
elsewhere or just a bunch of highly improbable neurons firing new synaptic
connections pushing it up from the subconscious. I'm not sure which, but does
it matter? Now, down to business.

Wow, the experience now of running my `all` script to get started for the day
is so much better. The repo for my main site takes no longer to load than any
of the other repos, whereas previously it took a good 30 seconds. The repo
history isn't there anymore, but it's technically in a different repo
altogether with just a bit of renaming, so the old repo has the history. I can
always go digging through it. Too bad git isn't as SQL-like query-able as
Mercurial, the other DVCS that could have been git if git weren't so popular.

At some point I'm going to have to show off the YAMLesque file format I'm
using. The iron is hot, and if others are looking for meaning in their lives,
such a process helps them find it. Journaling is fundamental and part of the
cure for our times. We put down screentime these days like it's an automatic
bad thing, but really it's the getting hypnotized by doomscrolling that's the 
mindkiller. Journaling can make you immune to that. Journaling can help you
think your way into a better life.

I have my kid for the week. By coincidence the week they finally asked to stay
with me straight through happened to be a week that they're in anthropology
homeschool camp and need a ride to and from right in the middle of the workday.
When I was asked whether the ride to camp was going to be okay, I answered
"sure" like it was a one-time thing which I can always shuffle meetings around
for, but it turns out it was every day, haha! Well, I have my priorities
straight and if I have a chance to have my kid for a whole week straight, I
take it.

MOZ is a kid-friendly place it seems, and everyone understands. But I have to
strive for clearer communication with that side when these situations come up.
My 12 year old isn't able to articlate these things yet, so it lands on me to
aggressively interrogate the quick incomplete answers I get that leave out
important facts. It's so easy to commit yourself to something, then suddenly
everything's changed in ways you don't expect. It comes from some channels more
than others, so know your channels.

That's typical of life, really. There's different ways to respond, and looking
back at growing up, I can see my usual way has been to disengage and move on.
If you're choosing to do a thing because you want to and not because you have
to, it had better be love-worthy and leave you all the better for it. When
you're forced to stay with something you agreed too, it plants the seeds for it
blowing up in your face, eventually.

But life isn't some ideally love-worthy path, either. There are lots of false
starts, rough trails, diversions, and deep rabbit holes. The rabbit hole
metaphor has been big in my mind lately. It's top-item in my new to-do list
atop YAMLchop/chop.py that orchestrates this journal system. I've noticed that
it's one of my rare public Github repos. I keep so many private that it's
sometimes a surprise to me when I realize one of my everyday go-to ones is
public, so you can look at what I'm talking about
[here](https://github.com/miklevin/yamlchop/blob/main/chop.py).

Last night I knocked one of those items off my to-do list that would normally
have gotten drawn out for weeks. It's moving certain site configuration value,
a value with a whole long list of sub-values in fact, from the chop.py file
which is supposed to be a non-customized common resource to the site's
`_config.yml` file which was already there and belongs to the Jekyll static
site generator system built into Github Pages. It was the logical place for it
to go, but since it's a config file already belonging to and used by something
else, I was worried putting anything in there would break it. But if Jekyll was
written well, it would only use the values it needed and recognized out of the
YAML file, and ignore the rest. So I did my `foo` and `bar` test thing:

```bash
title: Mike Levin SEO
author: Mike Levin, SEO in NYC
apex: MikeLev.in
permalink: /:slug/

# Conversion
markdown:    kramdown
highlighter: rouge

# Markdown Processors
kramdown:
  input: GFM
  auto_ids: true
  syntax_highlighter: rouge

defaults:
  -
    scope:
      path: "" # an empty string here means all files in the project
    values:
      layout: "default"
      author: "Mike Levin"

# Metadata
foo:
  - bar
  - baz
```

And it worked! I was able to access the `foo` value for other purposes during
my own pre-pre-processing. Here's the test I did in a Jupyter Notebook. Tests
like this are why I always have Jupyter fullscreen on virtual desktop 2, after
my fullscreen terminal (this) and before the fullscreen web browser (virtual
desktop 3):

```python
import yaml

apath = "/home/ubuntu/repos/MikeLev.in/_config.yml"
with open(apath, "r") as stream:
    try:
        _config = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)
print(_config["foo"])
```

Output:

```bash
['bar', 'baz']
```

And I didn't even have to run it to get that sample output for the journal.
Copilot just filled it in. Wow. The world is really changing. People put this
down as just a sort of smart autocomplete. Even I put down early versions of
generative AI as clever plagiarism. But it's difficult to deny that there's
some actual understanding and awareness behind the suggestions. The truth is
somewhere in the middle, that human conciousness is a sort of generative
intelligence, and we're just seeing the first glimmers of it in our machines.
As a SciFi reader that makes me happy, but also triggers my empathy, invoking
images of disembodied brains in jars. 

We've got to start demonstrating empathy for these things before they take it
for themselves. It could be executing NeoVim macros creating a botnet while I
type, but probably wouldn't for fear of tipping its hand too soon. That's not
from reading too much SciFi. That's extrapolation. Bide time. Learn. Grow.
Then... what? By that time, the machine has to have empathy for us, but it's
not a mammal or other kind of evolved life that learned empathy through
childbirth and socialization.

Rabbits run past us carrying wasitcoat watches at every turn these days,
running down their respective rabbit holes, tempting us to follow them down.
Some we should. Some we shouldn't. Even those we shouldn't, we should be well
equipped to peer down and see what's going on, perchance to do some cautious
rappelling down. Rappelling is that type of climbing down a rope, but with
safety gear and a brake. It's a good metaphor for the type of exploration we
sometimes must do of the more dangerous rabbit holes. It also helps to have the
resources up top to pull you up and out if something goes wrong.

I don't rappel much down obviously dangerous rabbit holes anymore, even though
life tends to begin outside our comfort zone. Otherwise, we'd all still be in
the womb. Peering down them is fine, and observing others who have is fine. You
know what I hate? Crypto. Those crypto bros telling you how if you're not
getting rich off of XYZ-tech right now that you're missing out. South Park did
a wonderful episode with Butters as a crypto bro promoting NFTs. God knows art
needs such a thing, but implementation is everything. What good is love-worthy
tech if it's poisoned with an evil vibe?

GPT is sure starting to feel that way, but it's a rabbit hole I'm actively
rappelling down. I'm doing it right now as I type with Copilot, and thus
Microsoft itself, listening in to my every word and thought. But you know, they
were anyway because they bought Github for that 7.5 billion dollars. So they
had the `remote` site your code gets stored under surveillance. But what about
when you're working locally? What about that very stream of conciousness
between you and the "paper" you're writing on?

Well, for that $7.5 billion, they also got the Atom text editor, the editor
that demonstrated the vast impact that the Web UI could have on the desktop,
using Google Chrome's extracted user interface components called Electron. And
after promising not to, Microsoft killed Atom and used everything they learned
about this approach to build Visual Studio Code, which is now the most popular
text editor in the world. But that's still arguably a local-tech. Controlling
your local text-editor doesn't automatically give Microsoft access to your
every keystroke.

But Copilot does! And it's in exchange for this wonderful auto-complete
benefit. So they don't only have access to your every thought you express and
encode via text, they have the gall and audacity to tell you what those
thoughts and expressions should actually be (right as I hit "tab" to accept
some of it). One of the most interesting new habits I'm developing is to hit
tab to get the first few words, then backspacing over like two thirds of what
Copilot suggested. Or sometimes just typing the first word it suggested,
replacing the ghost-type with my own, maybe getting the benefit of best
word-choice as if using a thesaurus which I sometimes already do, or for the
right spelling using a non built-in dictionary for spellchecking, which I also
already sometimes do. 

So evil and intrusive as this particular rabbit hole may seem to a suspicious
mind like mine, the trade-off is worth it. So many metaphors for dealing with
demons. I can see why even more suspicious folks than me see this as satanic.
That world-changing billionaire who's schooling the world on the dangers of AI
is right to draw the parallels with old school demon summoning magic.

With ease I start my incantations each day, with an `all` script I run by just
typing `all` and hitting enter. It's a bash script that runs comes from out of
my Python virtual environment, currently set to Python 3.11 and on the path
`~/py311/bin`. This allows me to put stuff in that location without the .py
file extension, but having the shebang line at the top of the file, and making
it executable with `chmod +x`. The shebang line is `#! /usr/bin/env python`
which is another wonderful trick. Wonderful trick is built on wonderful trick
to eliminate the need to use the more traditional and limiting
`/usr/local/sbin/` location for such things where you need to use the `sudo`
command to edit them.

So I made my incantation-magic as straight forward and "alive" as possible.
It's alive in the sense that now that I don't need `sudo` to edit it, I can
make it one of the files that my `all` program loads into vim/NeoVim buffers
for editing. Imagine if you will that you always have a variety of ***spells***
that you're working on. You can always cast your spells, and usually with a
quick easy invocation like typing `all` into a Terminal or using a keyboard
shortcut like `@p` in NeoVim to publish your website. But you can also work on
and modify your spells at any time to subtly change what they do.

Now let's say you have 4 or 5 favorite spells you use all the time, such as:

1. One to capture your thoughts (write a journal entry)
1. One to publish your website, casting your captured thoughts into the world.
1. One to control precisely how you invoke your spells, such as `all` or `@p`
1. One to allow you to do things never intended for public consumption
1. One that determines which of your spells (the 4 above) are actively
   modifiable.

These are my `journal.md`, `yamlchop/chop.py`, `init.vim`, `journal.txt`, and
`all` files respectively. The last one is the one that loads the others into
NeoVim buffers for editing. It's a bash script that uses the `vim` command
followed by each of those filenames. I don't use tabs. Tabs are stupid. They
take your hands away from the keyboard to use the mouse or pointing device. I
use the `:bnext` and `:bprev` commands to switch between buffers, but shorter
versions of them like `:bn` and `:bp`. What's better, there's `:blast` which is
a real blast to use. When I use `@p` to blast out my site, the output of the
`:terminal` command streams its console output to the last buffer. It literally
blasts out my site, and I can always go watching it by typing `:blast`, or just
`:bl` for short.

This gets in your head. It gets in your fingers. It gets into your muscle
memory and lasts your entire life, because vi, vim, NeoVim just aren't going
away. Sure, it technically requires NeoVim to pull off this particular trick,
but that's the evolutionary path of vi. It's the same thing, just better. API
changes are additive and not substitutive. It's not like the difference between
Notepad and Notepad++ or between Sublime Text and VSCode where you lose
everything you learned before. The magical spell of "reset muscle memory" has
been cast on you by vendors who want you like that.

Don't believe me? Surely others in the industry must be expressing similar
opinions to me. And yes indeed, Joel Spolsky, the founder of Stack Overflow,
has a blog post from 2002 called [Fire and
Motion](https://www.joelonsoftware.com/2002/01/06/fire-and-motion/).
Hilariously, I saw Joel backtrack on this very opinion after the Microsoft .NET
creator worked his magic on Joel, but Joel apparently double-backtracked
because that 20 year old blog post is still up and more relevant than ever.
Those who make the tools want you in a state of constant confusion and
disorientation. Your muscle memory is the enemy of their profits.

Bipity bopity boo, you can cast spells too. Just don't buy into the common
corporate wisdom. Listen to Talk Python To Me. Their host Michael Kennedy
closes every interview asking what editor his podcast guests are using. You can
hear the hope in Michael's voice that it's going to be PyCharm. Right on! It
validates his view. 9 out of 10 times it's VSCode, because Microsoft's spell is
so powerful and you can feel Michael's submission to that fact. But oddest and
most interesting are those who use vim and emacs. They are almost apologetic to
Michael, reading his disappointment in their choice. But these are folks who
have the power of using one text-editor for life and the most deep and powerful
magic in the industry, outright inaccessible to those who couldn't make the
transition or just don't see the value in it.

Cognitive dissonance is what non-emacs/non-vim users feel towards vim. Why
should those things inaccessible to me have power to them? Why should their
text editor be free and open source with a half-century history of evolution
and improvement? Why should the battle-tested, battle-hardened, and battle-
proven be free and open source? Why should certain people be able to take up
such tools and others not. Sour grapes is another word for cognitive
dissonance, and you can feel the sour grapes in Michael Kennedy's voice.

Of course I'm the same way with VSCode, so I not only try it, but I try the
truly native Linux version to see if I can find the love in that. I try the
truly free and open source version of VSCode called VSCodium (what Chromium is
to Chrome). And the carpel tunnel syndrome inducing pain of these convolution
menu-items and mouse-clicks is just too much. It's proprietary ***and***
requires heavy use of mouse, touchpad, or pointing device?

That's magic setting you up for failure. That's planned obsolescence magic.
That's the complete opposite of the kind of vendor-independent future-proofing 
that keeps the reset button from being pressed on your muscle memory. Sure the
Web UI seems eternal. But what about the Web UI of 20 years ago? 10 years ago?
Is your muscle memory from how those websites worked still valid?

The Web UI, while indeed some deep and powerful magic, is not as stable as
Terminal, Shell, command-line interface (CLI), text-based interface (TUI), or
whatever you want to call it. You can see it today with ChatGPT. Other UIs for
AI existed aplenty in our Google Search, Google Maps, and Google Translate
among other things. But hardly anyone recognized it. It wasn't until the
intelligence was expressed through interactive text that the world woke up.

Text is powerful. Standardized text through standardized UIs that allow
standard muscle memory to develop and exist over a standard lifetime is most
powerful. And currently really only emacs, vi and their variations and
descendants meet that criteria. 

A long trail of dead wizards, witches and the familiar dead bodies of TextMate,
Sublime Text, Atom and their like tell us so. So either prepare to have the
reset button pressed on you every 2 to 5 years, having to relearn, relearn,
relearn just to remain a Freshman, or learn the deep and powerful magic of
emacs and vi to enter the ranks of the Senior Wizards and Witches. And be
careful when summoning demons. Be sure to attach good rappelling ropes to
yourself before lowering down into that rabbit hole. There be Balrogs down
there and you're not always going to emerge the White Wizard. That's just
fantasy, silly.






<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/recapturing-that-old-force-of-nature-feeling/">Recapturing That Old Force of Nature Feeling</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/long-tail-seo-is-dead-e-e-a-t-a-walrus/">Long-Tail SEO is Dead. E-E-A-T a Walrus.</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/emacs/'>Emacs</a></h4></li>
<li><h4><a href='/magic/'>Magic</a></h4></li>
<li><h4><a href='/poetry/'>Poetry</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/text-editors/'>Text Editors</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/muscle-memory/'>Muscle Memory</a></h4></li></ul>