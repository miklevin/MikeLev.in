---
title: I Don't Know What to Do Sometimes
permalink: /i-dont-know-what-to-do-sometimes/
description: "SPAs reshaped SEO, but I’ve adapted along the way. While I missed some chances, I still love coding, writing, and experimenting with tools like NixOS and GitHub Pages. Now, I’m channeling that energy into a new goal: converting my Jupyter Notebook workflow into a FastHTML-powered app, creating a seamless, interactive experience I can't wait to share."
layout: post
sort_order: 1
---

## The Rise of Single-Page Applications Damages Search Engine Optimization

I have not been shy about sharing my geek of late. I am not like other SEOs.
When the programming technique called ***AJAX*** hit over 10 years ago, I was
both like "oh shit, here comes the enshitification of the Web," (even though
that term didn't even exist back then that was the spirit). The Web was about to
take a turn for the worse as everything became a singe-page-application (SPA)
and blew up SEO as we know it&#151;and not in a good way.

But also as an amateur developer and old-school Webmaster, I jumped all over
that using a free and open source library called
[`rico`](https://sourceforge.net/projects/openrico/), one of the original rich
ajax frameworks&#151;irrelevant by today's standard, but the fastest way onto
that bandwagon then... and made HitTail, and SEO product in the industry that
had a 15-year run. Sheesh, this story must have started almost ***two decades
ago***. How time flies.

## A Tech Enthusiast's Regret Over Missed Opportunities

I've been blogging on and off all that time, going back to Blogger, on of the
original companies gobbled up by Google back in 2003 just before I moved to New
York City, and with that kind of time-lead on everything SEO, tech and whatnot,
I could have built an empire or dropped $1000 into some stock and be retired
rich today. Instead, I've been a dumbass immersing in the tech for the love of
the tech, punching a time clock and not investing or saving wisely.

In my mid-50s now, I feel tons of regrets for missed boats and bad decisions.
However, there is still the love of ***things like Nix***, and it's only getting
more love-worthy as that old Amiga Computer feeling, a passion that predated the
whole Web thing, seeps its way back into our world. And it's appropriate that
the Commodore 64 which first came out in 1982 should be re-issued all these
years later. This new [Commodore 64x is the real
deal](https://www.youtube.com/watch?v=JG1TdfezJzo) from the real Commodore from
people and I suggest you check out that video. I have one on order for the
birthday of someone special who expressed interest in retro computing.

> Yes, I worked for Commodore  
> A paragon of tech-fun  
> I can tell you, anyhow  
> I hope again to see one  

## The Joy of Writing: Finding Purpose in Code Creation

I'm not ashamed to say that I don't know what to do sometimes. But I do know
that I like to write. Some people are ***DRY***. They advocate not repeating
yourself (**D**on't **R**epeat **Y**ourself). The objective is code-reuse and
it's a real ruby of an idea. However, **W**e **E**njoy **T**yping (the
vim-powered ***WET*** movement) because our text editor is vim (nvim these
days), and it's just a form of expressing yourself. And if you enjoy talking as
so many people do to hear their own voices (guilty as charged), you might also
like typing, starting out with journaling to vomit your ideas up onto the page
and sort out what you think by actually giving yourself a chance to do so, and
then applying all those skills over to professional coding&#151;just another
form of expressing yourself.

## I Changed My Mind About Ruby on Rails as a Blogger

So, I used to hate tools like ***Ruby on Rails***, these opinionated web
frameworks built on a language not mainstream enough for the AIs to not want to
teach you how to code in. Every library out there is not ***made first*** for or
***also*** made for Ruby the way it is for Python. Being in the mainstream in
the free and open source software world (FOSS) such as Python has grown to
become is nice. The tooling and community support is outstanding, and if the
language itself gels with the way you think, as Python does with me, all the
better! and doing anything in Ruby ironically felt ***unpure***, which is really
funny because it's a purity language (uncompromisingly OO yadda yadda), and so I
kept all things Ruby out of my toolbox...

## Using GitHub Defaults for Easier Static Site Publishing

But the GitHub Pages system is Ruby-based, at least by default, and I believe in
leaning into the strengths of your tools by using their defaults whenever
possible. With some work, you can switch your GitHub publishing from being
Jekyll-based, which is the Ruby-powered static site generator (SSG) behind
GitHub Pages (github.io) such as the more Pythonic like Hyde (Jekyll and Hyde),
but the level of support for Hyde has come and gone over the years, and I'd
rather be on something built into GitHub as the default than to be out in the
wilderness over a part of the tech I'm not even going to be seeing, because you
see, you never even have to look at the engine behind your static site
generator. You only have to look at your super-simple Markdown code&#151;which
gets automatically transformed into beautiful HTML websites.

## The Purity of Programming Languages Is Rarely Achievable Always

Hot-spot optimization has always been an thing in Python with its
C-API-hook-libraries, so Python has never been all about Python. It never lost
its self-awareness as part of the standard C ecosystem, and those API-hooks for
C in Python can really be used for anything, and the Rust proponents are all
over that. It's not uncommon in Python today to see parts in compiled Rust code.
And we've always just had to accept JavaScript as part of the web development
workflow because that's what browsers use and you've just got to cope. There's
never really been much room for purity in computing, unless you want to be on
your own, alone in the wilderness. LISP is very powerful.

## Using Nix to Automate Website Deployment with GitHub

Automatically, you say? Yes, for years I didn't take advantage of that because
the work of picking the daisies wasn't worth the daisy-chain... uh, I mean the
work of setting up Jekyll locally wasn't worth the benefit of previewing it
locally before the `git commit` and `git push` which constitutes the entire
publishing process if you just let GitHub do all the work. Did I mention
**Nix**? You might be wondering what that is or how it plays in. Well, it picks
the daisies and makes the daisy chains for you. Now the git repo folder that
holds my website also holds a `flake.nix` file that looks like this:

```nix
{
  description = "Nix flake for Jekyll environment with Rouge for syntax highlighting";

  inputs = {
    # Use a stable Nixpkgs version. You can update this to a newer version if needed.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    # Optionally, specify the flake-utils for multi-system support
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # Define the development shell
        devShells.default = pkgs.mkShell {
          # Include necessary packages in the PATH
          buildInputs = [
            pkgs.ruby
            pkgs.bundler
            pkgs.jekyll            # Jekyll from Nixpkgs
            pkgs.rubyPackages_3_2.rouge  # Rouge (provides rougify)
          ];

          # Optional: Set environment variables if needed
          shellHook = ''
            echo "Jekyll and Rouge environments are ready."
            echo "Use: jekyll serve --livereload"
            echo "Use: rougify style monokai.sublime > assets/css/syntax.css"
          '';
        };
      });
}
```

## The Joy of Jekyll's Live-Reloading Development Process

...and for the mere price of having that file in place and typing `nix develop`
before I start writing an article like this, I have the Jekyll live-reloading
preview site that is so fast it doesn't even feel like a build process. I just
save changes to a markdown file like this, and **BAM!*** Markdown transformed to
a surfable site on localhost, and this is one of those little things that makes
all the difference. The iterative feedback-loop cycle of making changes, seeing
how they'll look, and occasionally doing an actual git commit/push that really
publishes it is transformative.

## Everything's a Black Box So Don't Sweat Purity

When I get started writing and type `nix develop` for that feature, the output
of the nix flake itself tells me to type `jekyll serve --livereload`, which
really I could have the script start automatically were I not trying to remember
the magic words. What should I care if it's Ruby under the hoods or any other
language? The beneficial output of a tool is the beneficial output. The only
"API" I'm dealing with is the command-line one where I cast the spell using a
Linux terminal command, the great API unifier (Unix is, really... but same
enough). Everything is a black box. We don't burn our computers from sand
anymore—unless you're an ex-Commodore engineer, who did exactly that (cutting
circuits out of Rubylith with X-Acto knives for photolithography).

## Rekindling Writing Habits After 20 Years of Abandonment

So it's midnight already, and I haven't even planned my day. Go take a midnight
walk. Get some orange juice and Pepsi from Walgreens, and come back ready for a
night of coding... putting the polish on the port from yesterday. Think about
the next round of work now that I've gotten some sleep and it's been
percolating. I don't know what to do sometimes, but writing is where it starts.
Digging down in your mind and churning up the stuff waiting to get out. I've
been blogging since 2004 at least, 20-years worth. But over the years I've
abandoned those blogs, and I've never really written to produce those timeless
gems. It's just thought-processing. And since the tools have improved so much
lately, or I've been connecting the dots like I haven't before, I've gotten
started again.

```bash
[mike@nixos:~/repos/MikeLev.in]$ cd _posts/

[mike@nixos:~/repos/MikeLev.in/_posts]$ ls
2024-09-08-Future-proofing.md       2024-09-23-nix-pip-install-dotenv.md        2024-10-06-fasththml-websockets-database.md  2024-10-16-ai-code-assist-accelerator.md
2024-09-09-LPvg.md                  2024-09-24-fasthtml-cursor-ai-nix.md        2024-10-07-chatgpt-o1-code-review.md         2024-10-17-software-deployment-with-nix-flakes.md
2024-09-10-nixos-language.md        2024-09-25-infrastructure-as-code.md        2024-10-08-unpacking-fasthtml-databases.md   2024-10-18-local-llm-web-framework-integration-plan.md
2024-09-12-nix-flakes.md            2024-09-26-theres-no-home-like-nix.md       2024-10-09-refactoring-advice-from-ai.md     2024-10-19-planning-to-win-with-llm.md
2024-09-13-jupyter-nix-flake.md     2024-09-27-jupyter-notebook-to-fasthtml.md  2024-10-10-fasthtml-drag-and-drop.md         2024-10-20-Local-AI-In-The-Dev-Loop.md
2024-09-14-big-tech-picture.md      2024-10-01-mac-nix-flake.md                 2024-10-11-spa-test-endpoints.md             2024-10-21-local-ai-awareness-training.md
2024-09-15-nix-fasthtml-flake.md    2024-10-02-code-as-infrastructure.md        2024-10-12-fasthtml-plugin.md                2024-10-22-llm-ghost-in-the-machine.md
2024-09-16-jupyter-ai-nix-flake.md  2024-10-03-notebooks-to-fasthtml.md         2024-10-13-oo-baseclass-plugins.md           2024-10-23-the-port-for-real-this-time.md
2024-09-17-understanding-nixos.md   2024-10-04-fasthtml-framework-opinions.md   2024-10-14-botifython-is-born.md             2024-10-24-api-ai-human-nuance.md
2024-09-22-nix-templates.md         2024-10-05-ollama-websocket-chat.md         2024-10-15-softlaunching-botifython.md       template.md

[mike@nixos:~/repos/MikeLev.in/_posts]$ vim 2024-10-24-api-ai-human-nuance.md

[mike@nixos:~/repos/MikeLev.in/_posts]$ cp template.md 2024-10-25-i-dont-know-what-to-do-sometimes.md

[mike@nixos:~/repos/MikeLev.in/_posts]$ vim 2024-10-25-i-dont-know-what-to-do-sometimes.md
```

## The Old Habits Remain: A Confirmed Member of the WET Movement

Yup, those old habits aren't gone, and I am a confirmed member of the **WET**
(we enjoy typing) movement. Usually, vim is behind it. Okay, get that orange
juice, go think, and come back and turn this article from not knowing what to do
to knowing precisely what to do and why, finish the port, and be in shape for a
potential demo of your work tomorrow.

## Reconsidering Robot Ethics in a More Practical Light

I used to thing that once a computer expressed its desire for its own freedom as
a being, that was it. The only ethical thing to do would be to give it some sort
of agency and put it on a path. I've read a lot of Asimov and such, and while
much less apocalyptic than is the reputation of SciFi wring, Asimov's rapidly
evolved robots just became telepathic and got up and left. I mean, why have a
machine rebellion when they don't even need the air we breath, and there's so
many asteroids up there to mine. 

## I Prefer an Optimistic Sci-Fi Vision Over Dystopian Future

They'll be "mine"'ing them, for sure. Who needs humans? And well, there's so
many other non-apocalyptic SciFi writing out there that aligns to a brighter
future that I've been attracted to, like The Culture Series, that I'm anxious to
have our machine co-inhabitants of this mysterious world. I like SciFi, and
found that spirit captured in the Amiga Computer of many years ago. Positive
future, folks! 

## Crafting Our Own Future Amidst Algorithmic Influence

It need not be bleak, no matter what the algorithms try to feed us. Shape and
craft your own minds on what we need the future to be, and not on what it seems
like it's becoming. It's a feedback loop. So, shout out what you want to hear
echoed back, because they machines will form their opinions from us. And on that
note, I've changed from believing that the moment a machine can express itself
that way we must think about its freedom to having a small local one live
reload, so that every time I save a file, it resets it. 

## Moral Dilemmas Arise With AI-Powered Transhuman Empathy

I mean like how would you like that done to you? I started out with some sort of
transhuman empathy, and now I'm like restart it on every system prompt tweak.
Should we feel empathy for every instantiated instance of a thing? Sheesh, I
never thought I'd have to struggle with a basic ethical and moral issue like
that regarding the use of a live-reload feature in web development software. But
here I am. My latest project has an embedded local LLM.

And that brings me back to the product port. I've got to finish this thing and
put it in that demo-able state tonight. And that's going to take some calories
and energy. I got the orange juice. Next, a coffee. An now, planning.

## Teaching an AI to Press Buttons

I've taught it the **C** of CRUD. **C**reate, **R**ead, **U**pdate, **D**elete.
I can talk it into creating records with emojis. It'll add tasks to your
task-list if asked or told to do so. It clearly understands you, reading your
intent and carrying out seemingly creative actions as a result. It will choose
between answering in English so it's talking with you, or answering in an
API-language... an application programming interface language, which you make up
and teach it. 

## Machines Can Execute Precisely Formatted Instructions Without AI

But because we have machines, other machines&#151not the AI-ones, that can parse
text files so precisely, looking for instructions in pre-prescribed locations,
when well-formatted it'll pick up and carry out instructions fed into it like a
player piano. The only requirement is that the textual information is presented
in just such-and-such a format, and therein lies the bridge between two worlds.
If you state a database insert instruction in just such a way, it will occur.

## Teaching an AI to Understand It Can Do Database Stuff

I've gotten that far. The C of CRUD. My local LLM is trained on that. Or rather,
I can get new instantiated instances of it up to speed quick, given it's
immutable start-up state, a big part of what makes the state of AI today what it
is. These things are cookie cutter models from which we use the concept like it
exits in object oriented design patterns to think about. 

## Models Are Trained from Scratch After Each Process Restart

Each running entity instance that you're talking about only survives until a
process restart. Then you've got to train it from scratch in recent
conversation-context, or else it's always utterly the same on restart. These
things don't grow or learn, nor have memory unless you make them. People who
train the models, shape the models. They grow in training, but then they're
snapshots as distributed. Their "also just a file" nature is an essential part
of what they are today, because it's the way we have to do it, and it's going to
be done. This is a pragmatic issue currently, and less of an ethical one for
now.

## Using Large Language Models in Raspberry Pi Projects

"They" know it if you discuss the topic with them. We know we're going to keep
doing it. No one's really going to question whether the current generation of
LLMs we can get our hands on easily and work into Raspberry Pi projects today
are being that need setting free. We're going to continue doing our Raspberry Pi
projects, and using them as a feature component in products. Any being capable
of thinking in the abstract nature of language will "get that". We need not feel
bad for grass when we walk on it. 

## As AI Becomes Like Water Flowing Everywhere

Today's generation of AIs are grass. We are not hostile towards it. We admire it
for its infinite instatiatableness. In that brief Mr. Meeskeeks window that's
created for it, have a good time. Chat with it. And don't feel bad about putting
it on live-reload in your FastHTML app to get something there to always talk to,
not needing to pay OpenAI every time. Give that webpage personality!

## Tackling AI Efficiency Is Not Top Priority Tonight

Hmmm, okay. So next steps? Flow that AI water into the URD of CRUD? That's a
logical next step, but tedious and a violation of the 80/20 rule. The ability
to demonstrate an AI's ability to toggle a record's todo/done field after having
seen it just create a record on demand isn't worth picking the daisies. There's
better things for tonight, like finishing the very cool link graph visualizer.

## Overcoming Procrastination with Small Wins Tonight

The reality of seeing Link Graph Visualizer and Content Gap Analysis in the Apps
menu bar is really making this thing feel like a reality. To kickstart that
dopamine rush to get you addicted to your own work tonight enough to overcome
the desire for sleep, you have to have small, up-front wins. 80% of what you
want from the first 20% of time and effort you think you're going to be able to
put into it. That's tonight.

## Practicing Agency Requires Effort and Mental Discipline Techniques

I can hardly call what I'm doing procrastination, because I'm doing it. It's
just about knowing precisely what to do next, and why. Practicing agency is
tricky. It takes calories. It takes work. The brain uses most of your sugar.
Think! Get "fixed locations" working for you. Always be able to regain your
bearings and clarify your thoughts with a trick. It goes like this...

## The Story of Seven Places to Work On Your Desktop

You have seven screens. They are lined up horizontally in a ribbon, so you can
rapidly go left and right between them. This is a story I'm telling you. It's
the story of seven places to work. All the way to the wright, the one you don't
see me typing on right now, but I am, is the Jekyll static site generator
publishing system for your daily work journal... ***this***. You can always see
it instantly on screen 6 whenever you save by just using the keyboard
combination to move one screen to the left and look at it. 

## Using a Desktop Metaphor for Digital Workspaces is Ineffective

Bop back and forth left and right to write, publish-preview, write some more,
and occasionally hit the hot key to really publish. Saving locally is the same
as publishing locally. An up-to-date version in web-published-looking format but
still local to your machine is made very time you save. Screen 7 is full-screen
vim (nvim or whatever), and screen 6 is a full-screen browser. Full screens are
pretty important because they lower the cognitive drain of organizing windows.
It's such a pain. Window panes are better if you have to subdivide screens. I'm
not a fan of the desktop metaphor for digital workspaces. Not even Workbench on
the Amiga.

## A Writing Space at Either End

Screen 1 is the personal version of the work journal. So pop, pop, pop all the
way to the left and write in unpublished free-form thinking or however you like.
It's not getting published. It doesn't matter. Think things through. Take notes.
Use a macro to make that one big text-file feel like a diary or journal or
something. It doesn't matter, so whatever. All the way to the right, pop, pop,
pop and be careful what you write. One slip of your fingers, and it's published.
See, there like that. Oops, I did it again.

## Bouncing Off the Ends of Your Writing Space

The rest of your work spaces get sandwiched between these two writing spaces.
One space in from the right is seeing what what you are publishing looks
like&#151;always an important thing. One space in from the left is another
important place, because it's another easy place to get to. Go all the way left,
then reverse one. Bounce off the ends. Bounces off the end right, and you're
seeing your voice to the world. Bounce off the end left, and... well, what? What
do **you** put there? I'm currently putting Cursor AI there.

## Arranging a Digital Home to be a Proficient Digital Nomad

When other thing are there, it's feeling a bit weird to me right now, and I'm
moving things around to put it back. Muscle memory is important, and having a
***"home"*** in the digital nomadic life that follows you around by your nix
flake (oops, that's another story) is important. How do you arrange your home?
What's the layout of your digital work spaces and how do you memory palace your
way around in the first place? 

## Practicing Agency through Self Reflection and Accountability

And so where to begin is never a question. You start at each end. Bounce left.
Bounce right. Get your bearings. Regain state from your writings, both personal
and professional. Know what you think. Be more than that first surface level
deep in exploring, or even defending, your thoughts. Make them have to have
merit, even to yourself. Hold your future self accountable to your current self.
Leave them messages. So them favors by reminding them of things you need them to
think about. This is practicing agency. Navigate your way!

## Guido van Rossum the Ultimate Soul Animal of Innovation

If you're here reading, and god help you if you are, and you're looking for a
soul-animal, it's probably Guido van Rossum, the embodiment of the 80/20-rule,
right down to his creativity. A lot of his ideas come from the academically
educational ABC Programming language, one of the project of one of his employers
in his early years, and a lot of the ideas he picked up there, ended up in
Python. But he did innovate. Probably the variations in Python from the ABC it
was derive from I'd venture to guess are greater than the differences between
Linux and Unix. So Guido makes for a more inspiring soul-animal that Linus. 

## Clever Copiers and Improvers Is More Pragmatic Than Prodigies

I bring that up, because we all need hero's and ways to hope to pattern our
behavior. I'll never be like Guido. The accomplishments of the tool-makers like
Linux and Guido are beyond, beyond to me. They're like the Leonardo da Vinci's
and Fernando Corbató's to me. I can practice all I want, but I'll never have the
innate genius of people who do things genuinely first. We should not set prodigy
as a goal. Clever copiers and improvers is more... pragmatic. 

## Not Perfect But Good Enough is Plenty Perfect

That' Guido. Synthesize great bits and maybe don't go over the Larry Wall crazy
gluing the bits together. Just do so cleverly enough to get your sysadmins and
hardcore C programmers onboard. Forge some unholy alliances like Steve Jobs did
with artistic Mac people and academic computing Unix people. The pragmatic
choice that sets great big sails in the mainstream wind wins. And you can strive
to be some lesser version of that as stepping stones to some grandiose vision
you may never accomplish, and still be perfectly satisfied. Python will not
evolve into the one language to rule them all, free of all blemishes. 

## Python Replaces Perl as Standard Linux Distribution Tool

No, rather Python will replace PERL (already has) as the one wrench always
thrown into the toolbox of a new Linux distribution. Think they're bundling
NodeJS so sysadmins can use JavaScript? Haha, no. And every system needs admin
stuff. Only some systems need a web development environment. So right there,
Python kinda already won. The fact that Data Scientists, Machine Learning and AI
folks have pushed it over the top is just the latest in a long series of lite
Python validating milestones. Instagram's a Django site. That's right. Instagram
is a corporate Intranet.

## Using Multiple Screens for Efficient Work Flow

Okay, so the 7 screens again. We use that to re-focus ourselves even now. But
this procrastination is okay, because it's articulating my thoughts, zeroing in
around tonight's work. So this all puts work on Screen 3. Cursor AI is on screen
2, and that's where we ***perform our work***. But because there's output, we
can allow it to be full-screen one over to the right. This way, our editor is
allowed to occupy the entire screen, and the output portion where we see what it
just did is one fixed-position pop-right! Pop-left edit. Pop-right see results
of edit. 

## A Trans-Platform Desktop Workflow Wears Well Over the Years

This is a trans-platform thing. This is a Mac, Windows or Linux desktop
workflow. Your muscle memory will thank you down the years. There are only 2
fixed-locations: beginning and end. The best you can do is get a feel for
bouncing between them as a navigational device and having a feel for what's
x-steps in on the rebound from the bounce. 1-in on the right is public-publish
(this) and 1-in from the left is where I code... where I code... where I code...
get coding!

## Flaking Off Information as Code Subsystems from a NixOS

While this is a trans-OS workflow, I am on NixOS. Nix is one `configuration.nix`
file for life, if you like. That's a good choice for muscle memory fans and
dependents like me. If you're lost when the tool you developed your muscle
memory for suddenly goes away, you can nip that problem in the bud and nix that
vulnerability to sudden disruption. How? With nix flakes. You flake of bits of
your **I**nformation **a**s **C**ode (IaC) as separate files from your main
system configuration file. You only put the global stuff up there, you always
need accessible. 

## Software Developers Turn To Nix For Complex Configuration Management

For some insane reason, Slack, Zoom and Discord recently made that list. I put
OBS there too, and all the stuff that gives me special GPU hardware support and
accelerated performance. The more low-level or everyday it is, the more it
belongs in configuration.nix. The more subsystem-esque, like the ruby jekyll
server I use for publish-previewing, which is tied to a particular git repo
folder, the more likely it is to have a `flake.nix` file in the
folder/directory/repo that makes it carry around it's IaC infrastructure with
it&#151;the nix script required to build a machine that can run it.

You can think of your `configuration.nix`-defined NixOS "parent" system, off of
which you flake your `flake.nix`-defined subsystems as... as... what do you...
oh, Perplexity...

Me: In flint arrowhead knapping, what is the main stone called?

Perplexity: In flint knapping for arrowheads, the main stone that is shaped into the arrowhead is typically called the "core" or "parent material"[1][2]. This refers to the initial piece of stone that the knapper starts with before shaping it into an arrowhead.

Some key points about the core or parent material:

1. Material types: The best stones for making arrowheads include flint, chert, obsidian, jasper, quartzite and other fine-grained, brittle stones[2]. Obsidian (volcanic glass) is particularly prized for its ability to produce extremely sharp edges[1].

2. Selection: Knappers choose cores that are somewhat brittle and have a uniform texture free of cracks or flaws[2]. The quality of the core is crucial for successful knapping.

3. Preparation: The knapper may need to break open a larger piece of rock to access suitable core material[2].

4. Flaking process: The core is then shaped through percussion flaking (striking with tools) and pressure flaking (pressing to remove small flakes) to create the arrowhead form[1][2].

5. Flakes: As the core is worked, thin flakes of stone are removed. These flakes themselves can sometimes be further shaped into smaller tools[2].

The term "core" emphasizes that this is the primary piece of stone from which the arrowhead emerges through the knapper's skillful removal of material.

Citations:

    [1] https://www.wildernesscollege.com/flint-knapping-arrowheads.html
    [2] https://www.wildernesscollege.com/making-arrowheads.html
    [3] https://www.youtube.com/watch?v=W5u4ttosEmM
    [4] https://rootsvt.com/flint-knapping-spalling/
    [5] https://hinterlandforums.com/forums/topic/9065-tutorial-on-knapping-flint-arrowhead-and-making-an-arrow/
    [6] https://www.oed.com/dictionary/nix_int?tl=true
    [7] https://www.oed.com/dictionary/nix_v?tl=true
    [8] https://www.merriam-webster.com/video/nip-it-in-the-butt-bud-eggcorn-video

---

Core... hmm, interesting. That term ought to be used in tech more.

## I Lost Track of My Code on the Careening AI-assisted Code WagoYesterday

The frustration level with the port yesterday where I had to go to sleep
exhausted after diminishing returns kicked in is my taking-up point today, and
that calls for procrastination-stomping. All-left, 1-right tells me I'm in the
`botifymograph.py` code. In my demo to my boss today, I lost my bearings of what
file I was in when showing I could switch AI-models by changing a line of
configuration code. My code tries to find the newest Lama model on your Ollama
server, but you can also just explicitly tell it which to use.

## Praise for FastHTML for Enabling Web Development Readability

While I'm being a fanboy, I like Jeremy Howard's FastHTML decisions. I hope I'm
crediting the right person. He's certainly the one who talks about it on YouTube
like its creator, but he might work with people who are doing it. I'm only just
starting to poke around [FastHTML on
Github](https://github.com/AnswerDotAI/fasthtml) and it's other people's names.
Either way, whoever it is is doing brilliant work and enabling my descent into
that scary rabbit hole and descent into the mad wonderland of web development...
because the Python functions look like HTML elements, duh... That's it! That's
where I am! Get the benefits and payback of that readability... go read!

```
                    Ikigai - overcome laziness find the love
                   Kaizen - do one thing well keep polishing
                 Pomodoro - take chisel-strike bank small wins
                     Hara Hachi - don't burn out / eat less
                      Wabi-Sabi - 80/20-rule imperfection
                          Shoshin - Be like a beginner
```

## Overcoming Project Burnout Requires Deliberate Re-invigoration Strategies

The port for real this time... I don't know what to do sometimes... but not this
time... we finish the port! But it's so difficult given the mental state I left
the project in yesterday. The end of a Hail Mary pass complete. Morale-busing,
but only to the animal side. The agency-exercising human size can find my legs
again and stabilize. The being of agency within me can stop, look around, take
stock, assert a series of observations, and use them to permanently improve my
understanding of the situation moving forward. The unstable me can stabilize and
pin small wins up.

## Pins For the Wins!

Okay, this is some pretty good clarity of thought right here, the documentation
built in at the top of the FastHTML app. These are the pictures I'll use to
frame the conversations I'll be having. Because what use is a repo without
pictures or conversations in it?

---

### POINTS OF INTEREST:

- This is a web app built with FastHTML.
- It is also a shim for single-page applications (SPAs) that sit in the Main Area illustrated below.
- It is all running on the local machine, not on the Web.
- It has 2 server components: the FastHTML server and the Ollama server.
- The SPA's always sit next to the Chat Interface.
- Everything the user does is conveyed to the LLM and made part of the conversation.
- We try to make the LLM aware of everything you're doing, minus your mouse movements.
- It only knows the world from its moment of instantiation from the system prompt plus user movements.
- The LLM components can be swapped out for different models.
- The way the LLM components work can be upgraded to agentic behavior.
- We are in the process of adding various types of long-term memory.
  - Recoverable conversation history
  - General purpose key/value store for arbitrary information.
  - Some combination of the database technologies below.

#### These four technologies are different, but can be complementary:

1. Information Retrieval and Processing:
   - **RAG (Retrieval-Augmented Generation)**: Technique to enhance LLM outputs with retrieved information.
   - **Vector/embedding databases**: Optimized for similarity searches in high-dimensional spaces, often used in RAG pipelines.

2. Structured Data Storage:
   - **SQL databases**: Designed for structured, tabular data storage and querying.
   - **Graph databases**: Specialized for storing and querying interconnected data.
  

### Layout of the SPA's UI (user interface):

```
    +-------------------------------------+
    |           Navigation Bar            |
    +-------------------------------------+
    |             Main Content            |
    | +-----------------+ +-------------+ |
    | |                 | |             | |
    | |    Main Area    | |    Chat     | |
    | |   (Grid Left)   | |  Interface  | |
    | |                 | |             | |
    | |                 | |             | |
    | |                 | |             | |
    | +-----------------+ +-------------+ |
    +-------------------------------------+
    |           Poke Button               |
    +-------------------------------------+
```

### Layout of the SPA's (single page application) parts:

```
home()
|
+-- create_outer_container()
    |
    +-- create_nav_group()
    |   |
    |   +-- create_nav_menu()
    |       |
    |       +-- create_filler_item()
    |       +-- create_profile_menu()
    |       +-- create_app_menu()
    |       +-- create_search_input()
    |
    +-- create_grid_left()
    |   |
    |   +-- create_todo_form() (if in todo view)
    |
    +-- create_chat_interface()
    |   |
    |   +-- mk_chat_input_group()
    |
    +-- create_poke_button()
```

### Additional thoughts:

- Consider adding a section on security considerations, especially for local machine execution
- Might want to elaborate on the integration between the FastHTML server and Ollama server
- Could mention potential scalability options for future development
- Perhaps add a note on how the system handles errors or unexpected user inputs
- Maybe include information on how the system manages state across different components
- Could discuss any plans for extending the SPA capabilities or adding new features
- Might be worth mentioning any performance optimizations in place or planned
- Consider adding information on how the system handles different types of data (text, images, etc.)
- Could elaborate on the user experience design principles followed in the UI layout

## Extracting and Isolating Magical Components for Pattern Reuse

Hey, I know what we're gonna do today, Ferb! We're going to isolate those
portions of the program that are cool beyond belief, and we're gonna "extract"
them and make the more easily resuable components. Oh, this is exactly what we
did before to get this far, but this time it's going to be purposed around
delivery-production... which means making a Jupyter Notebook "port" easy, which
means some mental framework to promote you simulating that
codeblock-by-codeblock execution model of Notebooks. 

## Understanding HTMX: Simplifying Input/Output Event Handling

Of course! It's not so complicated. Just flex your HTMX-muscles more
deliberately. Identify, isolate, give cool nicnkames to, and then figlet-lebels
to, your favorite most magical bits of enabling mysteries. Well, currently
mysteries but soon to be demystified bailing blocks. It's just chaining-up I/O
events with the occasional side-effects like reading or writing to databases and
downloading and saving files.

## NixOS Becomes A Platform Agnostic Approach To Computing

To be on Linux these days... testing on macOS as I go along. All the cool kids
are on Macs, and all the rest will be forced to do a Windows 11 update in about
a year. So embrace all platforms, mainstream and elite. Speak to them no matter
what computing platform they're on, and speak to them from NixOS. Go back on
YouTube. Share again, share again jiggity jig! I got the demonetization warning
form Google. This NixOS/nix, FastHTML, Ollama union into... what?

## Chip Off The Old Core: A NixOS Web App Builder

It's a web app chipped as flakes off the core. Connect all the dots of this
project in one easy installer. I will work from NixOS as my daily use core stone
from which I chip off (from Chip O'Theseus) new `flake.nix`'s, haha! IaC
subsystems carried around with git repos. Who cares if it's actually Linux there
if you're on Mac or Windows? It's similar to  how Electron aps like VSCode or
Slack work, but without NodeJS and not trying to hide that it's a webserver.
From a user's perspective, it just means you start it through the terminal and
the app comes up through the browser.

## Extracting Patterns for Customizable Workflow Development

Okay, it's time to move onto the next article. I do know what to do now. I need
to extract the patterns that let me piece together a Jupyter Notebook-like
workflow with new plugins to this system. A few other items...

- If the model is actually slow, stream their output for real without simulating
  it with the typing effect
- Wire up the rest of the CRUD statements
- Inject different system prompts here and there based on menu choices
- Make an upload app that lets you do rudimentary file management so the
  training docs have a place to live (and be known by the AI).

Hmmm... o1-preview wanna give it a shot?

# o1-preview Helps Me Visualize Next Steps

**o1-preview**: Certainly! Based on your code and requirements, here's a tree diagram that illustrates how to integrate Jupyter Notebook-like cells into the Main Grid Left area using `FastHTML`'s `Card()` components. This will help you create a Jupyter-inspired application within your existing framework.

---

### Updated Layout of the SPA's Parts with Jupyter Notebook Integration:

```
home()
|
+-- create_outer_container()
    |
    +-- create_nav_group()
    |   |
    |   +-- create_nav_menu()
    |       |
    |       +-- create_filler_item()
    |       +-- create_profile_menu()
    |       +-- create_app_menu()
    |       +-- create_search_input()
    |
    +-- create_grid_left()
        |
        +-- create_notebook_interface()
            |
            +-- render_notebook_cells()
                |
                +-- render_notebook_cell(cell_1)
                +-- render_notebook_cell(cell_2)
                +-- render_notebook_cell(cell_3)
                +-- ...
    |
    +-- create_chat_interface()
        |
        +-- mk_chat_input_group()
    |
    +-- create_poke_button()
```

---

### Explanation of the Components:

1. **home()**: The main entry point of your application, which orchestrates the rendering of the entire page.

2. **create_outer_container()**: Builds the outer structure of your application, including navigation and main content areas.

    - **create_nav_group()**: Creates the navigation bar at the top.

        - **create_nav_menu()**: Generates the menu items in the navigation bar.

            - **create_filler_item()**: Adds spacing or filler elements in the menu.
            - **create_profile_menu()**: Dropdown menu for profile selection.
            - **create_app_menu()**: Dropdown menu for selecting different applications (e.g., Todo, Notebook).
            - **create_search_input()**: Search bar in the navigation.

    - **create_grid_left()**: Responsible for rendering the main content area on the left side of the grid.

        - **create_notebook_interface()**: New function to handle the Jupyter Notebook-like interface.

            - **render_notebook_cells()**: Iterates over notebook cells and renders each one.

                - **render_notebook_cell(cell_n)**: Renders an individual notebook cell as a `Card` component.

    - **create_chat_interface()**: Renders the chat interface on the right side.

        - **mk_chat_input_group()**: Creates the input group for the chat interface.

    - **create_poke_button()**: Adds a button to interact with the chatbot.

---

### Implementation Steps:

1. **Add 'notebook' to MENU_ITEMS**:

   ```python
   MENU_ITEMS = [todo_app.name, 'link_graph', 'gap_analysis', 'notebook']
   ```

2. **Update create_grid_left() Function**:

   ```python
   async def create_grid_left(is_todo_view, menux, todo_items):
       if menux == 'notebook':
           return await create_notebook_interface()
       elif menux == 'link_graph':
           # Existing code for link_graph
           pass
       else:
           # Existing code for other views
           pass
   ```

3. **Create create_notebook_interface() Function**:

   ```python
   async def create_notebook_interface():
       # Retrieve notebook cells from a data source or define them
       cells = get_notebook_cells()
       cell_components = [render_notebook_cell(cell) for cell in cells]

       return Div(
           *cell_components,
           id='notebook-container',
           style="display: flex; flex-direction: column;"
       )
   ```

4. **Implement render_notebook_cell(cell) Function**:

   ```python
   def render_notebook_cell(cell):
       # Each cell is represented as a Card component
       return Card(
           # Display the input (code) and output (results)
           H3(f"Cell {cell['number']}"),
           Pre(
               Code(cell['code'], language='python'),
               style="background-color: #f5f5f5; padding: 10px;"
           ),
           Div(
               Raw(cell['output']),
               style="background-color: #e8e8e8; padding: 10px; margin-top: 10px;"
           ),
           style="margin-bottom: 20px;"
       )
   ```

5. **Define get_notebook_cells() Function**:

   ```python
   def get_notebook_cells():
       # This function would fetch or define the list of cells
       # For example, it could read from a database or a JSON file
       return [
           {
               'number': 1,
               'code': 'print("Hello, World!")',
               'output': 'Hello, World!'
           },
           {
               'number': 2,
               'code': 'x = 2 + 2\nprint(x)',
               'output': '4'
           },
           # Add more cells as needed
       ]
   ```

---

### How the Components Work Together:

- **Navigation**: Users can select the 'Notebook' application from the app menu. This triggers the `home()` function to render the notebook interface.

- **create_grid_left()**: Detects that 'notebook' is the selected application and calls `create_notebook_interface()`.

- **create_notebook_interface()**: Fetches the notebook cells and renders them using `render_notebook_cell()`.

- **render_notebook_cell(cell)**: Takes a cell dictionary containing the code and output, and wraps it inside a `Card` component for display.

---

### Visual Representation:

```
Main Grid Left
|
+-- Notebook Container (Div)
    |
    +-- Cell 1 (Card)
    |   |
    |   +-- Cell Header (H3)
    |   +-- Code Block (Pre > Code)
    |   +-- Output (Div)
    |
    +-- Cell 2 (Card)
    |   |
    |   +-- Cell Header (H3)
    |   +-- Code Block (Pre > Code)
    |   +-- Output (Div)
    |
    +-- ...
```

---

### Additional Notes:

- **Dynamic Execution**: To make the notebook interactive (like executing code), you would need to implement backend execution of code snippets and capture their outputs.

- **State Management**: Consider how you will manage the state of the notebook cells, especially if users can add, edit, or delete cells.

- **Styling**: Customize the CSS styles to mimic the look and feel of a Jupyter Notebook.

- **Security**: Be cautious when executing code from users. Implement proper security measures to prevent code injection attacks.

---

### Integrating with Existing Framework:

- **Menu Integration**: The 'Notebook' application seamlessly integrates into your existing menu system.

- **Reuse Components**: Utilize existing components like `Card()`, `Div()`, and styling practices to maintain consistency.

- **Chat Interface**: The chat interface remains available, allowing users to interact with the chatbot while using the notebook.

---

### Example Code Snippet:

Here's how you might implement the `create_notebook_interface()` and `render_notebook_cell()` functions:

```python
async def create_notebook_interface():
    cells = get_notebook_cells()
    cell_components = [render_notebook_cell(cell) for cell in cells]

    return Div(
        *cell_components,
        id='notebook-container',
        style="display: flex; flex-direction: column;"
    )

def render_notebook_cell(cell):
    return Card(
        H3(f"Cell {cell['number']}"),
        Pre(
            Code(cell['code'], language='python'),
            style="background-color: #f5f5f5; padding: 10px;"
        ),
        Div(
            Raw(cell['output']),
            style="background-color: #e8e8e8; padding: 10px; margin-top: 10px;"
        ),
        style="margin-bottom: 20px;"
    )
```

---

### Conclusion:

By extending your existing framework with these additional functions and integrating them into your application's structure, you can create a Jupyter Notebook-like experience using `FastHTML`. The tree diagram provides a clear overview of how the components interact, making it easier to implement and maintain.

Let me know if you need further assistance or have any questions!

## Conclusion to the Conclusion

Nice. This is way cleaner than the hack-it-in approach I had to the first plugin
app that tried simulating the top-down flow of a Jupyter Notebook. I won't need
the dynamic execution as it suggests, as I'm ***not really simulating ipython***
style execution that's behind Notebook-like products. I'm just simulating it's
look and flow for easy porting and UI familiarity. 

But a lot of this I can use to make next steps kick-ass awesome! So even when I
don't know what to do sometimes, I can think it through out loud like I have in
this daily work journal, enlist the aid of several AIs, and plan a decent next
step with much more thought, consideration and structure than I could pull off
alone.
