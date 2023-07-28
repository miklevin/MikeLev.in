---
date: 2022-05-05
title: Adventures Installing Manim on Windows 11 (Not Under WSL Linux)
headline: Successfully Installing Manim on Windows 10 - A Journey of Resilience and Lessons Learned
description: "I recently switched from Mac to Microsoft and discovered the power of the vim command :b1. This blog post explores the importance of developing internal resilience and extracting the lessons from life experiences. I discuss the differences between the neocortex and the pituitary gland and how the neocortex can override the signals of the pituitary gland. I also share my experience of trying to get Manim to work on my Windows 11 system, and how I ultimately got it to work on Windows 10. I"
keywords: "Windows 11, Vim command :b1, Internal Resilience, Neocortex, Pituitary Gland, Manim, Windows 10, Linux, Chocolatey, Python, JupyterLab Desktop, Virtualenv, Powershell, Mac, Driver Problem, Touchscreen, Stylus, Nbconvert"
categories: powershell, python, mac, linux, microsoft, virtualenv
permalink: /blog/adventures-installing-manim-on-windows-11-not-under-wsl-linux/
layout: post
group: blog
---


The vim command :b1 (Obi-Wan in my mind) is indeed very powerful. My process
transformed yesterday. It's amazing what just a little shift in thinking can
do. Such a little shift in thinking can work for or against you. Little shifts
in other people's thinking can work for or against you too. Watch for it. Our
brains are always getting rewired, sometimes for the better and sometimes for
the worse. But they are them and you are you, and you can only improve
yourself. Be strong and have internal resiliency.

Eternal internal resiliency is one of the most important lessons in life.
Perhaps this is one of my first blog posts for WhatsaMetaFor.io, but probably
not. I've got a web-publishing funnel shaping in my mind. Everything starts
here in my private journal, and then moves from left-to-right into my other
journals with a vim copy/paste. And one step to the right exist this,
MikeLev.in, a place for eternal rambling that's both shareable and valuable
enough to do some people some good. So, copy/paste. Done. Now you can read
this. Now it has a search-optimized URL. Now it has been actualized and
realized.

Technically, it's a vim yank/paste (not copy/paste). That alone is so symbolic.
The vi\* editor that survived a half-century lives in a bizarre parallel world
where copy/paste is and always has been yank/paste, and has been for far longer
than copy/paste has been a thing, though I suspect it's because "c" was already
used for "change" as in cw for change-word. When it came time for copy/paste in
other software, vim was not copied. Copy is more relatable and plain English. I
get it. The world is not based on vim. It's just that vim survives while
everything else goes obsolete in about 10-years and fades away. Yank you very
much.

Before I dive into any rabbit holes this morning, get a common .gitignore
across all your sites. Now it's easier to roll such cross-cutting features out.

Okay, done. ELTgd... Felt good, man. Every Little Thing gets done. Solid
mantra. THIS is where you want the benefits of compounding returns working for
you. When you make a little step forward in some project, it becomes a
resonating big step forward in life if you can extract the learning and apply
it forever forward in life. What I just did was drop a file into a location
where I copy common templates out from across (currently) 15 websites. I did it
for a few files a few days ago, but now when anything similar comes up it's...
well I guess many hundreds of times easier.

Such an act demonstrates he compounding returns of internal assets. The reason
journals like this are so important to process the thoughts, and places like
this and end-to-end secure notes, like available in Apple Notes, is so
important for keeping pointers, tips, passwords, step-by-step instructions and
such. Journals like this almost exclusively tap a human's cognitive executive
function, which is the part that lives on the surface and in the frontal
neocortex part of the brain (under the forehead). This can be an issue
sometimes, and here's my current thinking. I may be wrong, but it's my best
understanding to date.

The neocortex under your forehead is different from say the pituitary gland
that lives just above where the spinal cord comes into the brain, deep at the
lower-center of the brain. All vertebrae animals have similar pituitary glands.
It is an ancient organ that regulates cortisol which causes the release of
epinephrine, adrenaline, norepinephrine and noradrenaline... the soupy mix that
throws us into fight-or-flight response mode, which you can imagine is
important in animals with vertebra's carrying themselves around and
occasionally having to fight or flee.

Those pituitary responses came before neocortex. But with the development of
the neocortex came the capacity to override the signals of the pituitary gland,
saying: "No, that's not a real danger", thus reducing instead of amping-up the
soupy mix of fight-or-flight neurotransmitters. This is the start of
self-regulation. It's Charlie Brown noticing the football is being pulled away
and taking a moment to take stock of the situation. Maybe step back. Maybe do
some breathing exercises. Maybe listing out of few of the seemingly objective
observations of the situation that can be made upon examination.

Journals like this provide an opportunity to do just that. They tap that
executive function of the neocortex, almost exclusively... ***at first***.
Getting in touch with your inner pituitary gland motivated self comes in time
with practice. That's "channeling". You don't know even a fraction of the
things that are going on in your body to keep you alive. They're sending
messages up to the executive function that lives in the neocortex under your
forehead, but those messages are easily misinterpreted and get manifested in
the real world as scan, danger, react, scan, danger, react. It has taken over.
That's being stuck.

That's why journaling starts out so hard and then over time becomes easier. The
different parts of yourself can start talking to each other and channeling
becomes easier. The more objective reality gets differentiated from the more
subjective reality. Journal writing will itself make the pituitary gland feel
that you are under attack.

But in a moment or two you realize that you are in front of your computer
typing. This is a first and readily isolated and reproducible Charlie Brown
falling on his back moment to overcome. It's an opportunity for practice. Over
time, journaling and the general recording of important thoughts and key
insights that will help you later becomes easier. This is how humans work.
Without it, growth would be difficult. Achieving new normals is survival.
That's why we're not itchy all the time. It's not instant and it's not easy.
It's a long process that takes practice and an open mind.

In other words, get up and kick that football again, Charlie Brown! If you know
Lucy's going to pull the football away, change your timing. Back-up. Retry!
You'll get it. And we did. We got the Python math animator package Manim
installed. I'm so proud of you!

After something like a marathon session of research, during which we first
tried to get Manim to work in the Linux side of a Windows 11 system under the
Windows subsystem for Linux (WSL), we backed off. My first inclination was that
it should be possible on the Linux side because Windows 11 is known for
official Wayland (and apparently X-Windows) support built-in under WSL. This is
my biggest reason for wanting to allow the Windows 11 upgrade to occur on my
laptop. But as usual with such things, there's gotchas. Yes, you have to be on
Windows 11 for official Microsoft graphics support of Linux, however you still
have to be on the Windows Insider Track version, which is a little too bleeding
edge for me, much less dumping Nat onto an experimental version. I want things
to go right, not wrong.

Okay, so after I discovered the lie that there's graphics support for WSL2
Linux under Windows 11, Nat still wanted to try to install it under Linux
because she was getting used to (committing to) vim. I went along, still quite
doubtful but knowing that if the components installed, I could just slam VcXsrv
onto her machine like I have on my Windows 10 machine, and the manim graphics
would work, albeit quite slow through X-Windows. Ever see my [googly
eyes](https://www.youtube.com/watch?v=ey7NB7nS2z8) YouTube video on the topic?
In fact, I made two videos about [Graphics on Windows 10 Linux with VcXsrv X
Server](https://www.youtube.com/watch?v=6_mbd1hvUnE&t). Running an X-Server on
Windows is no big deal.  There's one line you have to put in your .bash_profile
to make it work:

```bash
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
```

You know what? This post should be on MikeLev.in. It's no big deal to talk
about these experiences in public. It could probably do good for some people.
Not many, but some. The venn diagram has a lot of overlapping circles, haha!
Anyhoo after banging our head against the Manim dependencies on Ubuntu under
the Windows subsystem for Linux, I explained to Nat my Rabbit Hole evaluation
process which goes something like this:

- When doing something full of unknowns, try the first thing.
- If the first thing wasn't easy, back-up, turn a little and try again (Charlie
  Brown)
- Use an insect-like or Roomba-like criss-cross pattern of exploration. You
  don't need to be that smart about it, just persistent.
- Put a time-limit on the number of times you're willing to do this.
- If still failing, ask yourself how many more unknowns still may be there.
  After such exploration, you will know a lot more. With the benefit of that
  recent experience, list the "known" unknowns (yes, you can).
- Ask yourself whether the rabbit hole is too deep. It's all about the odds,
  probability, statistics at this point. Are they working for you or against
  you?
- If against, then instead of back-up/retry, it's time to tap your executive
  function. It's like pulling over to look at a map while driving.
- If human reasoning (which is much more nuanced than Roomba movement) tells
  you it isn't going anywhere, do something reasonable yet radically different.
  It's Sherlock Holmes mode.
- Using the radically new approach, go back to step 1 and ditch your Sherlock
  cap for and restart the Roomba routine.

And so we gave up on installing under Linux WSL and switched to installing
Manim under Windows. Nat had as it turned out, already started the process.
Following the instructions at the Manim site about Chocolatey and Scoop, she
had installed Chocolatey, which is a Windows answer to a free and open source
(FOSS) software repository like the Debian-based one in Ubuntu or the
unofficial Homebrew hacker shit in the Mac. This is yet another major
deficiency in Windows, but of course like with everything where there is an
itch and the worldwide web, there's someone scratching the itch. And Chocolatey
scratches the missing FOSS-repository itch on Windows. I feel about the same
about it as I do Homebrew on Mac. If it's so great, why doesn't the vendor
support it? But whatever. A scratched itch is a scratched itch.

Another anti-Microsoft little piece of advice on the Manim site is to not use
the Python that auto-installs from the Windows Store when you type Python from
the Windows command-line (a.k.a. COM). What whaaa? The one good thing about the
Python install story on Windows, and Manim tells you not to do it? Shit, okay.
Well there's nothing wrong with getting the download from the official
Python.org except for the fact that you shouldn't have to. But whatever. We did
and installed it. Upon Nat's prompting, we even selected "Add to path" during
the installation.

So it's installed, and we type "python" from the COM window, and the Windows
Store pops again. Okay, expected because new paths that aren't in
already-opened COM. So we close and open the COM to get the new path, type
python and again the Store. I'm like shit, things couldn't really be this
terrible on Windows, could it? So I do the thing I'm always remiss to do. I
have Nat fire-up Windows Powershell and do the same type "python" test, and
voila! Python fires-up and we have a Python 3.10 interactive console from the
command-line. A few pip installs later (and one Chocolatey vim install), Nat's
doing a Python "Hello World" program.

I instruct her about blasting out the pipes with a Hello World as a first step
in any new Python (or other) execution environment. We also talk about how it's
perfectly fine to have multiple instances of Python on your machine, and how
it's not only okay but expected. FOSS software is going to get embedded into
and installed with lots of stuff. This foreshadows the virtualenv experience
we're about to have, because it dawns on me that if we're using Windows, we
could have just used the Python that's already on her machine from the
JupyterLab Desktop install. D'Ohhhh.

I gloss over the fact this could all probably have been done under the already
installed Windows-side Python 3.8 on her machine from Jupyter and dive deep
into my soul running rapid rabbit-hole evaluations on the likelihood of getting
this new Manim-enabled Python 3.10 environment working under Jupyter. Yes, I've
done the ipython "new kernel" trick under the Anaconda version of Jupyter that
runs in the browser. I hope that old command-line misery is now GUI-based
(graphical user interface) under JupyterLabs Desktop Advanced Settings. It
should be. It is not. Momentarily crestfallen, I back-up. I retry.

I google-up the "ipython new kernel" concept. For anyone not familiar, Jupyter
Notebooks are just the .ipynb format. It's a JavaScript Object Notation (or
JSON) file-format. That is to say there are lots of things that can run
Notebooks, and JupyterLabs is only one, although admittedly the first and
arguably the best. Others include Google Colab, Microsoft Azure Notebooks,
Binder, blah, blah, so many. It's a ziggurat of awesome parts (stepped pyramid
of dependencies) with the key lower-dependency being something called ipython,
which is really just Jupyter without the web browser user interface. And so
such a system can have different languages or "kernels" plugged in. While
Python is the default language for Jupyter, it is by far not the only. And the
difference between Python 3.8 and 3.10 is so small that I was very optimistic.
I just avoid that sort of shit for myself because I don't like bleeding on the
bleeding edge.

Okay, but good news! It turns out that the way to get a Python 3.10 kernel on
Standalone Desktop JupyterLab is virtualenv! So I get to kill two birds with
one stone (sorry for the metaphor, but it's still the best one). I have long
avoided virtualenv's on the new standalone Jupyter because there was no option
for it under Settings. And if you had to go to the command-line to do special
stuff each time you reinstalled Jupyter, you'd be doing it forever because the
product is advancing so quickly with a new version every month or two. But it
turns out my reasoning was exactly reversed. I was pip-installing over-and-over
to re-create my environment. And just because I could do that with a single pip
install of mlseo which I loaded with all my dependencies, it's really a worse
solution than biting the bullet and having some virtualenv's sitting in your OS
user folder (home) that you can just keep re-adding... as an alternative
jupyter language kernel! I should try Julia.

And we had to do this virtualenv source activate stuff under Windows
Powershell... or so I thought. To say such a thing is reprehensible to me
because of memories of bleeding on such edges in the past would be an
understatement. And indeed when it got up to the source/activate part of
virtualenv, I just couldn't make it work under Powershell. Off the beaten track
is surrounded by wolves... always.  And though I'm excellent at staving off
the wolves, it's something I hate.  Hate, hate, hate. f-you, Microsoft. Okay,
so it dawns on me I don't have to actually activate the venv. It just needs to
be there. Little realizations like this are gold, Charlie Brown.

Alright. So now everything clicks. I google "new ipython kernel" and get the
page [Installing the IPython
kernel](https://ipython.readthedocs.io/en/stable/install/kernel_install.html)
and the process that never really changes, kicking myself for not having done
this for myself sooner. Thanks Nat for pushing me to better places. I decipher
the terrible documentation that gave me a bad taste in my mouth for this
process in the first place, adapt it to Windows black-slashing back slashes
slash slash slash, and only with a little lost blood get the new kernel
installed. Technically, Nat did all this. I was only Googling along two-finger
expanding the magic incantations to fill the screen of my laptop and holding it
up for her to look at.

Okay, as bad as everything Microsoft really is, and it's really, really bad,
their one saving grace is kick-ass hardware. I'm on an $800 Surface laptop. Not
even one of the high-end ones or fancy ARM processor ones. It's just a
bottom-of-the-barrel what-was-in-the-store soft-touch felt keyboard model. But
it has touchscreen. And I've never had a driver problem (sorry ARM-lovers). And
the low-profile keyboard is better than Mac's. And I use the touchscreen all
the time. And that touchscreen supports a stylus whose back works like an
eraser in paint apps without me even needing to change settings. And the
stylus doesn't need to be charged or have a cap that gets lost.

Yeah, I know. Mac, mac, mac blah blah blah. Yeah, I've had a long run of
Macbook Pro's, Macbook Airs, iMacs and the whole gambit because Unix. Before
Microsoft started officially supporting Linux (Cygwin wasn't enough), I was on
Macs because Unix and the awesome hardware-build combined with Unix absolutely
clinched the deal. But Apple never added an officially supported free and open
software repo. I went from Fink to MacPorts to Homebrew, and never once did I
not feel I was bleeding. When Microsoft canonicalized Linux by choosing
Canonical's Debian-based Ubuntu as their official version for WSL, I switched
and never looked back. Actually, I did and Macs now feel off-the-beaten-track
again.  Windows won. Sorry, but Linux on Windows is now better than Unix on
Macs because official software repos.

Shall I go on? Perhaps the biggest testament to all this is that I not only
supported my wife and kid getting onto Windows instead of Mac, I'm now helping
my wife as this post went into great depth about, get onto Linux via Windows.
Clearly it's still bleeding edge where it counts, the graphics subsystem for
Linux on the Linux subsystem for Windows. And I had to back-up and retry. But
when I did, even the Chocolatey alternative worked just about as well as I'd
suspect a Homebrew formula to work.

And so success. The last step in that entire process was the fact that
Notebooks created under the new virtualenv-based Python 3.10 kernel were still
.ipynb Notebooks, which Manim doesn't like. Enter nbconvert... under
Powershell? Yep, nbconvert under Powershell. And only with a little bit of
blood. Certainly less blood than virtualenv under Powershell. And those
.ipynb-to-py files can be loaded into... vim under Powershell for final
tweaking without having to go back to Jypyter.

No solution is perfect, but with enough internal fortitude, persistence,
backing up and retrying, cognitive evaluation, and note-taking for later
reproduction of success, then imperfect can becomes good enough. I call that a
great success!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/path-f-path-mkdir-parents-true-exist-ok-true/">Path(f'{\_path}').mkdir(parents=True, exist_ok=True)</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/adventures-installing-manim-on-windows-11-not-under-wsl-linux/">Adventures Installing Manim on Windows 11 (Not Under WSL Linux)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/powershell/'>Powershell</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/mac/'>Mac</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/virtualenv/'>Virtualenv</a></h4></li></ul>