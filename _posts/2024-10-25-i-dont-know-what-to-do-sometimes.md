---
title: I Don't Know What to Do Sometimes
permalink: /i-dont-know-what-to-do-sometimes/
description: 
layout: post
sort_order: 1
date: 2024-10-24
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
it's a real ruby of an idea. However, **W**e **E**njoy **T**yping because our
text editor is vim (nvim these days), and it's just a form of expressing
yourself. And if you enjoy talking as so many people do to hear their own voices
(guilty as charged), you might also like typing, starting out with journaling to
vomit your ideas up onto the page and sort out what you think by actually giving
yourself a chance to do so, and then applying all those skills over to
professional coding&#151;just another form of expressing yourself.

## I Changed My Mind About Ruby on Rails as a Blogger

So, I used to hate tools like ***Ruby on Rails***, these opinionated web
frameworks built on a language not mainstream enough for the AIs to not want to
teach you how to code in. Every library out there is not ***made first*** for or
***also*** made for Ruby the way it is for Python. Being in the mainstream in
the free and open source software world (FOSS) such as Python has grow to become
is nice. The tooling and community support is outstanding, and if the language
itself gels with the way you think, as Python does with me, all the better! and
doing anything in Ruby ironically felt ***unpure***, which is really funny
because it's a purity language (uncompromisingly OO yadda yadda), and so I kept
all things Ruby out of my toolbox...

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

Yup, those old habits aren't gone, and I am a confirmed member of the **WET**
(we enjoy typing) movement. Usually, vim is behind it. Okay, get that orange
juice, go think, and come back and turn this article from not knowing what to do
to knowing precisely what to do and why, finish the port, and be in shape for a
potential demo of your work tomorrow.
