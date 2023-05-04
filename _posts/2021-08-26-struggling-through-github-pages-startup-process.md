---
date: 2021-08-26
title: Struggling Through Github Pages Startup Process
headline: Successfully Setting Up Website on Github Pages After Hours of Struggle
description: I just finished setting up a new website on Github Pages, after a long and complicated process of setting up DNS, Git repositories, Jekyll templating, and more. I'm happy with the result, but now it's time to get to work - so I'll have to wait a couple days to enjoy the fruits of my labor.
keywords: Github Pages, DNS, Git, Repositories, Jekyll, Templates, Default.html, Banner, Google Analytics, Pico/Nano, CNAME, Config.yaml, Google Search Console, TXT Record, Propagate
categories: templates, jekyll, google analytics, git, github pages
permalink: /blog/struggling-through-github-pages-startup-process/
layout: post
---


Hello World! Launching LinuxPythonvimgit... gotta think about how I'll write
it. Linuxpythonvimgit... yeah, that flows best. But LPvg is the "stack"
acronym. Think! 1, 2, 3... 1?

{% include youtubePlayer.html id="v-D4Y7rBafU" %}

1. Set up DNS. Show the nice people the "before" (no site)
2. DNS propagates almost instantly. Show them Github 404 page.
3. Make a git repo. No Github in the picture yet (except DNS).
4. Add a new repo to Github. Name of directory really inconsequential.

Ugh! Forgot to cd into the folder again! Let's make a few adjustments...
Okay, that's better. Folder name doesn't matter, but I think I'll go for 100%
consistency in my convention. Also moved .git invisible folder and the index.md
file I made into the better named folder.

Now do step 4 for real...

5. We make the branch we're working on named main...
6. We identify the location of the remote repo (on Github)...
7. We do the first push which must name the branch...

Wait a moment, and show the nice people the "after"...

While we wait, we show that the 2nd push is easier...

See... just "git push" on the 2nd push!

Oops! Missed an important step...

8. Go to Github / Repo / Settings / Pages and configure!
9. Choose a Theme (combined it with step 8)

I think we're just still waiting for the Jekyll magic to kick in for the first
time on this site.

And there it is. It overwrote my index.md. Let's fix...

Oh yeah, always do a git pull after these steps. Github wrote stuff into the
repo!

It didn't overwrite my index.md. It automatically used a different branch of
the repo. I'll have to delete that branch.

Hmm... Okay, after switching Github Pages feature back to main branch of repo,
I had to reset a few blanked settings including Theme and custom domain. Once I
did it was pretty quick.

And finally I'll expose a bit of the Jekyll system that's going on here.
Ultimately I'm trying to dramatically reduce my "Tech Liability" of running a
bunch of sites, getting WordPress and the unending upgrades and security risks
out of the picture. That's a vast simplification of the publishing process, but
there's always a cost. And in this case, it's learning yet another templating
system... oh, and framework convention... yuck!

Let's go look at the Jekyll documentation... okay, so there's a whole
curly-brace based templating system... just like everything else that like
almost ever was... except back when it was <% %>. Pointy/percents of the
ancient Microsoft HDC/IDX conventions have made way for the {{ }} conventions
of... uh... maybe Ruby stuff that came after. Python people will know the
Django framework and Jinja template system extraction... all the same really.
Some syntax invented for intermixing with HTML and a subset of some language's
logic used for variable logic flow. Jekyll no different.

So I'm jumping right into a global default template that goes in a conventional
location. Let me show you those kooky framework conventions of Jekyll...

So I'm about to drop a x_layout/default.html down on this site to eliminate the
header...

Ugh! Gotta turn off markdown rendering in vim in markdown files. Who needs it?
Just slows down these pages when they reach a few hundred thousand lines (which
they do). Okay, I digress.

That Google Analytics code is from mikelevinseo.com. While I'm doing this step,
I might as well get the correct GA tracking in

9. Add the x_layout/default.html (ignore the x's) in order to remove default
banner of theme and to add GA code.
10. Get your GA tracking code (funky process)
11. Don't forget to git add the layout folder!

There you saw Github dropping new files into the folder. I momentarily
interacted with the Pico/Nano program which is automatically used by git
because they don't want to drop the uninitiated into vi/vim.

It takes a Ctrl+O Enter to write the file out and a Ctrl+X Enter to quit the
program. It's just to document the merge changes. But there are no file
collisions in this case, so no merge issues. See? The CNAME file and
config.yaml file got put in location by the Github Jekyll system.

Changes Jekylling. That's the before. See, header still there and no GA code...

That'll take a moment to propagate. Let's go the full distance and set up
Google Search Console, which is mainly a matter of site verification.

12. Set up Google Search Console. (TXT record)

That DNS entry is taking a moment to propagate. That's just the way with that
minor miracle called the Domain Name System. When you think about what it's
doing, it's amazing it's as fast as it is, so sometimes you just have to wait.

Okay, I know I did it right. That one it's saying it found... does not match
what's showing, so it must have been one of those 2 I deleted out right at the
beginning. One was a parking record and the other WAS a text record, so that
must be it. I'll just be patient. It's not like you're going to see data come
in right away as GSC has a couple days delay.

Anyhow, that's pretty much it. You saw everything but registering the domain in
launching a new site on the Github Pages system in this live stream. I'm very
happy with it. But now it's coming on 5:00 AM and I really got to get started
with my work.

Got some SERPs to scrape. Later gators!



## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/google-analytics/'>Google Analytics</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/github-pages/'>Github Pages</a></h4></li></ul>