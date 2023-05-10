---
date: 2022-05-07
title: My Blogging System Is Now My Weekly Report System Too
headline: I Have Created a System for Writing Weekly Reports with My Vimminess!
description: I have created a system for writing weekly reports that is similar to how I write blog posts. I have set up the necessary files, scripts, and repository, and tested the release. I encountered a problem with the git push, but I was able to create a blog post, move it to my Github private repo, and render the markdown into HTML. Now I have a system in place to make the process flow with my vimminess!
keywords: weekly-reports, system, files, scripts, repository, release, git-push, blog-post, Github, private-repo, markdown, HTML, vimminess, sites.txt, gaids.txt, script, release-scripts, copy-paste, email
categories: python, git, html, email
permalink: /blog/my-blogging-system-is-now-my-weekly-report-system-too/
layout: post
---


Okay, what a kick-ass weekly report. Now make them easy to deliver. I'd be
crazy not to continue writing them in vim exactly like this. Now I have to
treat weekly reports exactly like another web property. Even put it in all.sh
and sites.txt, but just don't publish the results.

But DO have a way to render the local markdown into HTML so I can copy/paste a
version that had filtered out the hard linebreaks I use in vim. Is it finally
time for local Jekyll?  Maybe, but not for immediately because that's a
violation of the 80/20-rule.  Instead, quickly set it up as just another web
property without the publishing aspect. It can even commit to github! Wow!
Okay, 1, 2, 3... 1?

    mkdir WeeklyReports.zd... done!
    cd WeeklyReports.zd
    git init
    touch foo.txt
    git add foo.txt
    commit -am "Kung Foo"

Okay, don't just copy/paste the next step. You have to really commit it to
memory.

    git branch -M main

How to commit that to memory? Hmmm. I ONLY ever really use the branch command
once in the history of a repository, although I should probably do it a lot
more.

Don't get (too) distracted. Finish this weekly report thing. It's critical. I
already just pushed out that blog-post on MikeLev.in about constantly being
channeling... because I suddenly had some clarity on some current channeling,
LOL! Okay, back to business!

Oh, :b1. I keep coming back to you. I want to :b2 'cause it's always a :blast.
:b3 for my kid and :b4 for my caste.

Ugh, I got that tweet out too... another distraction. But I learned the
alt-text system on pictures in Twitter... interesting! Important for optimizing
for Twitter, for sure. Is THIS Private Journal entry going to become another
MikeLevinSEO.com blog post? Yeah, probably.

Finish my WeeklyReport.zd system. Make weekly reports for the history books,
although none of them are actually going to be published anywhere except for my
boss. The key thing now is...

Put it in sites.txt just like any other site. AND I have to put it in
gaids.txt... ugh. Necessary evil. Foobarspam!

    G-foobarspam WeeklyReports.zd       Mike Levin's Weekly Reports
    G-RX2D1N1P2Y MikeLev.in             Mike Levin
    G-RNSSPXFB53 MikeLevinSEO.com       Mike Levin SEO
    G-K5EQ2QQG5D PythonicAlly.com       Pythonically
    G-ZNMVJFLRD2 LinuxPythonvimgit.com  Linux, Python, vim & git
    G-L7L2XR3J2G MikeAtEleven.com       Mike At Eleven
    G-9YEC9X0GDW TardigradeCircus.com   Tardigrade Circus
    G-L3QGENNVJ3 RemovableFinger.com    Removable Finger
    G-K86B8JW5Q5 Mike-Levin.com         Mike Levin Dot Com
    G-TJRX2PSWKT LunderVand.com         LunderVand
    G-HL9DEK1TSG WhatsaMetaFor.io       What's A Meta For
    G-N4RYB5DCV4 GuerillaTech.com       Guerilla Tech
    G-YXNMZY6Z6F TicTacUFOSightings.com Tic Tac UFO Sightings
    G-1JFHT28DRL PythonicAlly.org       Your Pythonic Ally
    G-45KYH6XTTX Pipulate.com           Pipulate
    G-0H19QDRNTL Levinux.com            Levinux

Okay, wow. Not bad. Is that enough for a test release? There's going to be
plenty of "setup folders" not in there. Maybe it's time for a site
initialization script so I don't have to keep editing them temporarily in and
out of my release scripts. Do a release and watch the errors... ooh, nice:

    [main 6261f91] Updating all
     7 files changed, 185 insertions(+)
     create mode 100644 .gitignore
     create mode 100644 _config.yml
     create mode 100644 _includes/youtubePlayer.html
     create mode 100644 _layouts/default.html
     create mode 100644 _layouts/post.html
     create mode 100644 assets/css/style.scss
     create mode 100644 assets/images/green-arrow.png
    fatal: No configured push destination.
    Either specify the URL from the command-line or configure a remote repository using

Regarding the git-push failing, I had only really set the main branch of the
new private repo so far. I've still got to make the endpoint. I'll worry about
committing this to memory later. I know they HAVE to be done. I just always
forget the precise commands. Github tells you when you make the repo, but still
after this many years it should flow out of my fingers naturally.

```bash
git remote add origin git@github.com:miklevin/WeeklyReports.zd.git
git push -u origin main
```

One more release... Okay, of course I had to put a journal.md file in location
in WeeklyReports.zd... and BAM! The barebones blog is sliced & diced and in the
Github private repo. This is too easy. Let me move THIS post over to
MikeLevinSEO.com because there's nothing proprietary. My Google Analytics IDs
aren't proprietary because that's in the view-source of every page using GA on
the Internet, LOL!

Okay, it's moved over. But before I even do another release, actually copy my
weekly report over to the new... oh, it should be in my vim buffers the next
time I quit and re-run ./all.sh... And it is. But ugh! That throws off my
numbering system, especially in light of [this tweet](https://twitter.com/miklevin/status/1522935319531868160)
But no biggie. I just need to think through the order. Maybe my weekly report
is :b5... for sur-vive? Stay alive? Obi-Wan, 2B or not 2B, my kid at 3 because
only positions 1, 2 & 3 are really "fixed" and I won't push them down to 11.
Oh, the dilemmas of a nerd.

    :ls
      1 %a   "./journal/journal.txt"        line 1
      2      "./WeeklyReports.zd/journal.md" line 0
      3      "./MikeLev.in/journal.md"      line 0
      4      "./MikeAtEleven.com/journal.md" line 0
      5      "./MikeLevinSEO.com/journal.md" line 0
      6      "./LinuxPythonvimgit.com/journal.md" line 0
      7      "./PythonicAlly.com/journal.md" line 0
      8      "./TardigradeCircus.com/journal.md" line 0
      9      "./RemovableFinger.com/journal.md" line 0
     10      "./Mike-Levin.com/journal.md"  line 0
     11      "./LunderVand.com/journal.md"  line 0
     12      "./WhatsaMetaFor.io/journal.md" line 0
     13      "./GuerillaTech.com/journal.md" line 0
     14      "./TicTacUFOSightings.com/journal.md" line 0
     15      "./PythonicAlly.org/journal.md" line 0
     16      "./Pipulate.com/journal.md"    line 0
     17      "./Levinux.com/journal.md"     line 0
     18      "~/.vimrc"                     line 0
     19      "./helpers/make_helpers.py"    line 0
     20      "./blast.sh"                   line 0
    Press ENTER or type command to continue

Yeah, the jumping around is definitely awkward now. Adi keeps :b3. That's what
:b4 is for. I have to get out my weekly report :b4 it's too late! Done. :b5 to
stay alive, because that's what vocations are for, uh'duhhhh

Wow, that is so done, done and done it's amazing. This whole blog publishing
process through just my normal day-to-day journaling (tapping my vim
superpowers) is as appealing as shooting my YouTube videos now, just for
general free-flowing communication. When the two combine... oh shit.

Don't get ahead of yourself. The last step now is local markdown rendering.
It's critical for copy/pasting a version into email for the boss. Think!
Pythonic! Think pythonically. Render local markdown super-duper easy. This
sounds like a job for PyPI.org!

    pip install markdown

Again, uh'duhhh

And here's the [Python to Markdown Reference](https://python-markdown.github.io/reference/)

And here's the instructions for [Python to Markdown Command Line](https://python-markdown.github.io/cli/)

And so...

```bash
/github/WeeklyReports.zd/_posts$ python -m markdown 2022-05-07-post-1.md > browseme.html
```

Double-click browsme.html, copy/paste from browser (local machine!) to email.
Add title and greetings. Hit send. Weekly report sent and killer system in
place to make it flow along with all the rest of my vimmy vim vimminess! Woot!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/getting-into-the-flow-or-the-zone/">Getting Into The Flow Or The Zone</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/my-blogging-system-is-now-my-weekly-report-system-too/">My Blogging System Is Now My Weekly Report System Too</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/email/'>Email</a></h4></li></ul>