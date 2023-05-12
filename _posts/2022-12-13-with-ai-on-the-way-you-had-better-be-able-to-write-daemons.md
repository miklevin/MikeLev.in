---
date: 2022-12-13
title: With AI On The Way, You Had Better Be Able to Write Daemons
headline: "Unlock Your WSL Potential: Learn to Create Daemons with Systemd"
description: I am engaging in controlled burns of my personal sites to optimize them for SEO, creating video content, writing to express my thoughts, taking up a 'magic spell' to free myself from Windows dependency, and planting the seed of my vibe on a homepage kernel. I am a wizard or mad scientist who wants to lead people through their WSL experience with a twist, warn them of the allures of vendor-ware, and promote HTML5, JavaScript, C, and Unix.
keywords: AI, Writing, Daemons, SEO, Video Content, Magic Spell, Windows Dependency, Homepage Kernel, Wizard, Mad Scientist, WSL, Systemd, Web Development, Vendor-ware, HTML5, JavaScript, C, Unix, Levinux, Drinkme
categories: drinkme, levinux, seo, wsl, linux, javascript, web development, systemd, journaling, ai
permalink: /blog/with-ai-on-the-way-you-had-better-be-able-to-write-daemons/
layout: post
---


Push things forward. I did a big round of trimming-down on MikeLev.in, the
whole "Best Foot Forward" SEO thing. Things can be build up from scratch
better than they existed in their original form before. Publishing techniques
have improved and we know more. It's the scrap-and-rebuild dilemma. It feels so
wasteful, but sometimes you burn down the old forest to make way for new
growth. Controlled burns. There's a big aspect of controlled burns as with
forest fire prevention in BFF SEO, and I'm engaging in it now. Perhaps a bit
more experimentally and recklessly than I'd prescribe for real sites where your
livelihood is at stake, but my personal sites are just playthings.

Blogs will be considerably less influential but are still worth doing.
Especially in my case it's really just processing my thoughts in public, an
important aspect of my identity. Part of who I am and what makes me unique is
that I'm just so comfortable with this sort of stuff. It's kind of the same
with video content. It's not polished. It's not high production value. It's
just spontaneous expression. It's just thinking out loud. It's teasing the
things I don't know that I know and don't know that I need to talk about up to
the surface. And I create what were once perfectly optimized and cross-linked
pages as I go.

Back in the early 2000s, I would have ruled with such a system. Today, it's
just noise being filtered out by the helpful content update. It's not like
stream of conciousness writing is ever to clearly emit the signals of "being
helpful" to Google, even though that rare 1/100,000 might find it so. I can
only believe that such outliers are filtered out as "not helpful". And such a
site loaded with "not helpful" content will pull down the whole rest of the
site as indicated by Google's comments on the matter. Helpful content is
promoted while not-helpful content on the site can harm the helpful content.
Therefore it is in our interest if traffic is our goal to trim and prune and
shape our sites. The era of BFF SEO (best foot forward) is also the era of
Bonsai SEO. Our sites are now bonsai trees to be clamped and snipped and bent.

Collect all your best tricks. Put them front and center. Update your MikeLev.in
homepage frequently. Practice making a series of tiny chisel-strikes. Actually,
these first few strikes on the stone of my public site are big sweeping
strikes, shaping the overall stone to the right starting shape. I haven't
removed the old content yet that's been there (URL-wise) for years -- a decade
or more in some instances, and sometimes to great effect. Even most of that's
going to be going away. New starting points. Only "helpful" content. The wizard
of helpful content.

Google wants you to find helpful content, and there is perhaps no more helpful
content in this world that will help you free yourself from your Microsoft
Windows dependency. I'm pretty sure Google would agree with this fact, though
FlexOS is not looking like the great Debian-derivative I had hoped. It's a
sales tool for Google corporate enterprise services. But still the point
stands. Taking up a "magic spell" to put you on the path to FOSS freedom and
Windows-independence is probably a good idea.

I'm going to need a way to allow my best ideas to get reviewed and refined and
percolate up to the top. Sites are going to be built for becoming optimized
over time, but they're not going to have that overly-contrived feeling at the
beginning, and the chances for misfires based on bad presumptions will be
reduced. We'll plant the seed of our vibe on some homepage kernel content and a
rudimentary nav system, and we'll let things take root and grow from there. Be
alert to whatever. Be willing to update and revise your thinking. You're not
throwing way old realities and old ways of doing things. You're using the
timeless tools and ways of doing things which are fully internalized and
automatic in order to adapt to and thrive in the new reality.

With AI rapidly on the way now, and as of today's news, Fusion energy that
returns more energy than it took, people are going to be looking and looking
and looking. Be one of the various things such people are going to find. When
they run into me, their impression should be something like:

Now here's a guy, some sort of wizard or mad scientist, who has a very
different and deliberate way of doing things. I don't know if it's good or bad
or genius or a nutcase (most likely the later), but it is at least interesting
due to its differentness.

So clearly, I want to be the pied piper leading people through their WSL
experience -- but with a twist! Anyone can shove you into the lair of the
trapdoor spider, a.k.a. Microsoft trying to introduce you to Linux with a
coded-in VSCode dependency, so that Microsoft Azure services can be marketed to
you at every turn. It is their future, and few places can you see it as clearly
as how they both succumb to market-forces to provide a Linux-based developer
environment, and ensure the micro-soft sheep are still eminently herd-able into
the shoots of predictable quarterly profits.

Yes, VSCode technically has a free and open source version, but project
yourself 10 years into the future. Can you see yourself still on the FOSS
version of VSCode and not using Microsoft paid services? No, you can't. If you
go that route, you will eventually switch to the proprietary version out of
ease or jealousy of the proprietary-version's features. You'll never learn the
text editor vim because it will seem difficult, arcane and silly in comparison
to VSCode. The fact that overwhelming evidence proves that it's not is a source
of cognitive dissonance. What do all those vim users know that VSCode users
don't? How are the rewards for taking up this particular tool or that being
distributed? The reward of short-term sexiness and high-salaries is on the M$
route that includes NodeJS installs all over the place.

There's a better way than WebDev. Who wants to create genies all over the
place, with each genie based on nodejs with its own rapidly changing version
with its own soon to be obsolete web framework that takes years to master, with
its own pinning issues to keep it all running, with an audience out there ready
to beat you up if the genie you created isn't answering fast enough and
correctly enough... \*POOF\* whaddaya need? \*POOF\* whaddaya need? \*POOF\*
whaddaya need? And that better way are the Linux services called daemons.

It's pretty funny that almost every web technology runs as a Linux daemon, but
most people don't know it as such. They know nginx, nodejs and all that stuff
web providers make it easy for you to test locally but know nothing about the
live deployment of. You hit buttons and wave your arms around and this stuff is
hosted. Well, whaddaya think that hosting tech is? It's some ***headless***
(meaning no desktop, mouse, etc.) Linux-running hardware (lowest cost, highest
reliability), which when started is told to run some software.

That software is run in a special way as to be kept running 24 hours a day, 7
days a week. So long as that hardware has power, this software is to be
running. That's just how computers work in general. They're a conglomeration of
running services... called daemons. Creating daemons used to be hard. Now, it's
easy. Now that creating daemons is easy, thanks to something called systemd,
creating daemons is a viable alternative to web development. They're
super-simple, run the world of tech, and are for some unknowable reason, still
a mystery to most tech pros who are led down the route of WebDev just because.

There's a time in your life where you're going to be very susceptible to the
allures of vendor-ware. Beware the vendor-ware for their #1 priority is to suck
you in and make you an ongoing customer. The purpose of any business (or
organization, for that matter) is to get and keep customers. In the case of an
organization, it may be to get and keep members. In today's subscription-filled
world, it may be to get and keep subscribers. The world is full of such
organizations and businesses trying to get and keep you, often for the
recurring predictable revenue you will mean to them. That is the primary role
of your relationship with them, of taking up their wares. They don't care about
you or want to make your life better. They want to find you and they want to
keep you.

This is what you're up against when you go out looking at what tech to take up
professionally. You might thing that humans adapt quickly enough that you can
take up just any old tech at any old time, do your job sufficiently, and get
along. Move onto the next thing, leaving behind your years of learning and
skill-honing that was a result of that last job.

I say No!

We deserve to have the skills we internalize, the tools that we make a part of
ourselves by developing the spontaneous mastery and muscle-memory to make their
use effortless, deserve to be with us for the rest of our lives. No vendor or
industry should have a "reset button" on your abilities. And yes this happens a
lot. Just ask any Macromedia Flash developer. We're all adapting to the new
realities of HTML5 and JavaScript. We thing this represents a fundamental that
will be with us for years to come, but so did the Flash people.

HTML5 will probably be with us a lot longer than Flash, as will JavaScript,
because "The Web" has proven itself to be such an effective user interface
(with humans) and it's built predominantly on free and open source technology.
Even the major vendors like Apple with Webkit and Google with Chromium
contribute back most of their browser tech to the free and open source software
world with adequate licences to actually allow it to be FOSS. We see this all
the time with Microsoft taking the Chrome tech for the Microsoft Edge browser.
Even Chrome was built from Apple Webkit and Mozilla Firefox. Because JavaScript
is built into the browser and part of the HTML5 spec, it's a great example of
something you can rely on being there many years into the future, which adds to
the allure of Web Development as the best technology career path &#151; and
life path, if you see your technology choices as a way of life as I do.

But you can do better than WebDev. You can do MUCH better. Don't pigeonhole
yourself so dramatically and so early on your way to becoming a technical
person, being good at technical things. There's a sort of lingua franca in
tech, in the same way English became the sort of international language of
tech, certain operating systems, programming languages, and particular programs
did too. C and Unix are perhaps the grandparents of the tech-lineage we're
mostly all standing upon, with an example of an alternative tech-lineage being
LISP. But standard C and pure Unix are not the best tools today for the
uninitiated trying to get started in an optimized way or with the upper-hand.

Okay, it's time to connect some dots. Levinux needs to lead to drinkme. Yes,
that's the way Levinux and the WSL Jupyter install script connect together. I
don't need to rename my drinkme repo into Levinux. Just make all things Levinux
lead to drinkme... just like Alice. Duhhh.

Re-assert your ability to edit the slideshow on Levinux.com... done.

Actually, I'm waiting for github.io to do it's thing. I haven't updated that
domain in a long time. I see that I'm actually promoting the drinkme script in
a way because it promotes the mikelev.in/ux url. I'm glad that's the way I'm
recycling that URL. Wow, okay.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/testing-github-pages-mermaid-diagrams/">Testing Github Pages Mermaid Diagrams</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/fusion-ignition-achieved-q-1-thanks-to-lawrence-livermore-national-laboratory/">Fusion Ignition Achieved! Q = 1 Thanks to Lawrence Livermore National Laboratory</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/drinkme/'>DrinkMe</a></h4></li>
<li><h4><a href='/levinux/'>Levinux</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li>
<li><h4><a href='/web-development/'>Web Development</a></h4></li>
<li><h4><a href='/systemd/'>Systemd</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>