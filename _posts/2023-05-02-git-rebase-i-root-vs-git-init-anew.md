---
date: 2023-05-02
title: "`git rebase -i --root` vs. `git init` anew"
headline: I'm Rebasing a Git Repo to Speed Up Editing My Public Website - Here's What I Learned!
description: "I attempted to learn how to use the `git rebase` command to clean up my git history and speed up my repository. I discovered on big repos with lots of issues, it's easier to just `git init` and do the old swaparoo with a new repo. Also explore philosophical questions about existence and the relative importance of things, and relationship to retiring an old git repo and starting anew."
keywords: git, rebase, init, commits, history, speed, operation, interactive, root, dangerous, force push, branch, remote, destructive, preserve, changes, overwrite, caution, journal, article, philosophical, importance, consciousness, path, shared experiences, local space, global space, non-local, sine wave, cyclical, circles, orbits, tech, book, visual, image, Noah's Ark, religion, YAMLchop, connecting, dots, potential,
categories: change, git, history, consciousness
permalink: /blog/git-rebase-i-root-vs-git-init-anew/
layout: post
group: blog
---


Finally doing a `git rebase -i --root` to make my public website repo faster.
It currently takes around 30 seconds to do any git operation, and I'm hoping
this will speed it up. It's taking a long time as as I suspected it would. 
It has 1,737 commits. Before the process I created a branch as a backup.

Me: How do you rebase a git repo to speed up? It's okay to lose history.

Bing: You can use the `git rebase` command to clean up your git history and speed up your repository. Rebasing is the process of moving or combining a sequence of commits to a new base commit. This is done by first rewinding your branch to the point where it diverged from the branch you want to rebase onto, then replaying your changes on top of that branch. This can be done with the following command:

```
git rebase -i <commit>
```

Where `<commit>` is the commit you want to rebase onto. The `-i` flag stands for interactive mode, which allows you to edit the commits as they are being replayed.

If you want to lose history, you can use the `--root` flag:

```
git rebase -i --root
```

This will rebase all of your commits onto an empty root commit.

Keep in mind that rebasing can be dangerous if you're not careful. It's important to make sure that you don't lose any important changes in the process.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 5/2/2023

    (1) how to use git rebase to clean up a convoluted history. https://stackoverflow.com/questions/3026218/how-to-use-git-rebase-to-clean-up-a-convoluted-history.
    (2) Git - Rebasing. https://git-scm.com/book/en/v2/Git-Branching-Rebasing.
    (3) git clean - Reduce git repository size - Stack Overflow. https://stackoverflow.com/questions/2116778/reduce-git-repository-size.
    (4) Git rebase and force push | GitLab. https://docs.gitlab.com/ee/topics/git/git_rebase.html.
    (5) Git rebase: Everything You Need to Know - How-To Geek. https://www.howtogeek.com/849210/git-rebase/.
    (6) performance - Git is really slow for 100,000 objects. Any fixes .... https://stackoverflow.com/questions/3313908/git-is-really-slow-for-100-000-objects-any-fixes.


Ooh nice, Bing finally fixed the line-return before the first citation in their
copy feature.

Me: What does it mean to rebase all your commits onto an empty root commit?

Bing: Rebasing all of your commits onto an empty root commit means that you're essentially starting your repository from scratch. This is useful if you want to completely remove all of the history from your repository and start fresh.

When you use the `--root` flag with the `git rebase` command, it creates an empty root commit and then rebases all of your commits onto that commit. This means that all of your changes will be preserved, but the history of those changes will be lost.

Keep in mind that this is a destructive operation and should only be used if you're absolutely sure that you want to remove all of the history from your repository.

I hope this helps! Let me know if you have any other questions.

Me: Will branches keep the history?

Bing: Yes, branches will keep the history after a git rebase. Rebasing only affects the branch that you're rebasing, so any other branches that are based on that branch will still have the same history.

However, if you force push your branch after rebasing, you'll be overwriting the remote branch with your new history. This can cause problems if other people are working on the same branch and have already pulled down the old history.

It's generally a good idea to avoid force pushing unless you're absolutely sure that it won't cause any problems.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 5/2/2023

    (1) Update your branch history with rebase - Azure Repos. https://learn.microsoft.com/en-us/azure/devops/repos/git/rebase?view=azure-devops.
    (2) How to Rebase Git Branch (with 3 steps) | Git Rebase | W3Docs. https://www.w3docs.com/snippets/git/how-to-rebase-git-branch.html.
    (3) git: Merge Branches but Keep Commit History - Stack Overflow. https://stackoverflow.com/questions/28550602/git-merge-branches-but-keep-commit-history.
    (4) Git rebase: Everything You Need to Know - How-To Geek. https://www.howtogeek.com/849210/git-rebase/.
    (5) Git branch diverged after rebase - Stack Overflow. https://stackoverflow.com/questions/19016698/git-branch-diverged-after-rebase.

It's funny, you'd thing rebasing could be instant, cutting off prior history
and saying "***this*** is my starting point". But it's actually a long process
of what looks like applying change after change from the beginning of the
history. It's currently counting up to 1733 and is only at 36, and it's been at
it for a few minutes already. This is likely to be a 20-minute procedure at
least, but it will save me much more time over the long-haul as my `all`
program is frequently doing git operations against this repo, making my daily
"getting started" and "winding down" procedures longer than they need be
(adding at least 30 seconds to each).

I've been hesitant to rebase in the past for fear of losing history, but
branches keep the history, and honestly who cares?

The file that I'm typing into right now is from that repo, so when it's finally
done, I'll save this file again and there should be effectively no difference
but for having added one new post, because all the files in the `HEAD` of the
repo (the latest) should remain unchanged.

![git rebase -i --root](/assets/images/git-rebase-i-root.png)

So while that's going on, let's jump from the deeply technical to the deeply
philosophical. Recurring concepts of importance:

- The question of what's most important. I.e. the relative importance of
  things.
- The level of consciousness of things. I.e. is mammalian consciousness more
  important than reptilian consciousness?
- The relative path between things. I.e. your immediate surroundings of "local
  space" vs. the "global space" of the universe.
- The value of shared experiences in local space (short paths) and global space
  (long paths) or non-local.
- The sine wave cyclical nature of so many things, apparent deep truth of
  circles, orbits and such

Yup those are the types of things that flit through my head when I'm doing a
giant hour-long rebasing of a git repo.

Other things included too-long deferred projects (including this rebasing
itself). Other projects along those lines are:

- Embedding all my YouTube videos where they appropriately go in my blog, and
  the corollary project of putting the URLs of all those blog posts at the top
  of the video descriptions on YouTube. ***That's*** a catapult-rope cutting
  project!
- Stepping up in all the surprising ways I can have a big impact at MOZ, but
  which in my first few months really haven't because of retooling issues and
  taking a deep breath... the calm before the storm.
- Framing it all in terms of some tech book with a really strong visual image
  about a normalized universal virtual machine image which I'm currently
  leaning towards: The Green Bag. It's a Noah's Ark of Tech concept, but take
  the religion out of it.
- Properly letting the world see about my latest YAMLchop work, and how these
  little things make big differences. It's one of the big lightweight
  connecting the dots and releasing built-up potential projects that I actually
  performed myself
- The heir apparent to HitTail, taking in the new realities of machine
  learning, AI and where longtail strategies or other "breaking-in" strategies
  still exist. It is probably to be the next rendition of Pipulate.

Out of a sense of caution, I copied this journal entry into my private journal
in case it gets wiped out during the rebase. 

Life in my view is likely a battle of wills or "vibes", which can also be
thought of as fundamental philosophical ideas or ideals of non-material beings,
expressing, manifesting, materializing and otherwise coming into being through
interactions with others of their kind. The notion that we are material
antennas tuning in spiritual souls is close but, but the soul-stuff actually
materializes into the antenna. The soul is likely the fundamental component of
what we call energy. What so many physicists want to see as infinitely variable
"strings" at sub-planck scales is probably just some sort of eternal beings
jamming and riffing and vibing. Music is deeply channels this concept, and at
opposite ends of the scale are "being in the zone" vs. meta-awareness. The
cyclical alternation of sine-waves as expressed through bodies that both
attract and repel ending up orbiting keeps state from settling down and the
game ending.

Not everything can be the same all the time, for it's that very sameness that
"ends the game". Difference and contention is the very engine of reality.
That's why life and death. That's why beginnings and endings. That's why wake
and sleep. In these cycles, new rounds of questions are being asked, answers
provided and conversations had. It's very much like computing the answer to the
question of life, the Universe and Everything as the Hitchhikers Guide to the
Galaxy series proposed. The improbability engine is more deep channeling, for
that's what we are. We are each improbability engines, providing the impossibly
unlikely but undeniable because materially true answers.

Got that?

As humans, we're each given roughly 100 rotations around the sun. That's
10-rotations for each of our fingers. Works out nice and even, right? Numbers
themselves are invented, especially the natural or real ones with which we
count our fingers, but that goes right to my point now doesn't it? What's more
real, the universal constants that are often not expressible in real numbers,
such as the square root of 2 and Pi, or the real numbers which are as obvious
and the hands in front of your face? What will material beings like us become
aware of first, start using, latch onto, and whether it stays that way through
larger and larger cycles, because there's cycles within larger cycles and
rhythms within larger rhythms. Whether what is a good answer at one scale is a
good answer at another scale is one of the very questions we're here to
explore.

![Git Rebase I Root Resolve All Conflicts Manually](/assets/images/git-rebase-i-root-resolve-all-conflicts-manually.png)

Ugh! The rabbit hole of rebasing just keep getting deeper.

I'm sure this is addressing some fundamental question about existence.
Redefining who you are, applying all learnings from the past, and starting new
as having all those commits "applied" and then "flattened" isn't as easy as
you'd hope. If you're a complex person with lots that happened to you in the
past, the harder it is. I basically got stuck in a `git rebase --abort` loop.

Anyhoo, the alternative is calling it done. Time to retire this repo, rename it
on Github (no harm in doing that with private repos), delete the invisible .git
folder, and `git init` anew.

Ugh and wow and pshwew! When you do the old github.io Github Pages swaparoo,
you both have to remove the CNAME entry from the repo that you're retiring as
the site source, and you have to be very vigilant about removing everything
under Settings / Github Pages on that repo too, such as changing the branch
that it's publishing from to None. You can't just remove the custom domain.
Otherwise your old site will block your new site from getting published, and it
will look like you unpublished your site. I was in that limbo for about 10
minutes before I figured it out.

This project started out as non-rabbit-holey as you can get. Just type off a
git rebasing command to chop off the history, but the complexity of actually
doing that is a rabbit hole. I used my rabbit hole detection radar to go
whoahhh! Isn't what I'm doing just about the same as copying a git repo folder
and deleting it's invisible .git folder and then `git init` anew? Yes, it is.
But that was another potential rabbit hole because of the nuance of getting a
Jekyll Github Pages site to work, especially on an ***apex domain*** (the kind
without a www subdomain), and the number of tweaks you had to do to the old
repo to stop it from interfering with the publishing of the new repo. 



<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/1-text-file-journal-for-life-as-important-as-formal-education/">1 Text-file Journal For Life as Important as Formal Education</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/being-in-the-zone-vs-thinking-about-being-in-the-zone/">Being In The Zone vs. Thinking About Being In The Zone</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/change/'>Changes</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/history/'>history</a></h4></li>
<li><h4><a href='/consciousness/'>Consciousness</a></h4></li></ul>