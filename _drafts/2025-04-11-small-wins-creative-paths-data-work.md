---
title: 
permalink: /futureproof/foo/
description: 
layout: post
sort_order: 1
---

Tings I only imagined in the past are now morning projects before the day
really gets underway. This has a potential momentum-building effect if the
morning projects dovetail gracefully into the work I have to do during the day.
The idea is to create a potentially exponential accelerating effect. Almost
nothing is worth doing competitively (unless it's for the pure joy of it) if
you're not also somehow achieving compounding returns or the snowball effect.
Why? Because there's always someone else out there doing it a little bit better
than you, a little bit different than you, and if it were something like a
zero-sum game where the prizes were divvied out to winners and losers, you
probably couldn't compete. It's not just that other single individual
outstripping and outpacing you that you're competing with, but it's also
everyone that's gunning for them, and gunning for them, and so on at infinitum
in a tireless, endless game of king-of-the-hill.

The solution to this is half do it just for the love of it. Forget the
competition and do the things you want to do for the reasons you want to do
them, and hopefully get paid for it. It's a big world, and you can find a market
for your unique skills in such a way that it doesn't undermine the love of the
work. At least in theory. And that's just the first half of the solution.

The other half is to pivot and maneuver into places nobody else has gone. True
genuine creativity is actually rare. I think it's the rarest commodity in
today's attention economy, even rarer than gold. Anyone can buy gold. All you
need is money. There's no really steep barrier to acquisition. But to be able to
produce economic product from out of thin air because of your creativity? Now
*that's* adding value in the value chain. Be the raw material ore that get
refined down into things of increasing economic value in the value chain. Not
everyone has it in them to be creative.

Most of that hypercompetition I'm talking about in the opening paragraph comes
from people copying one another and just doing tiny incremental improvements
that many people could have thought of, simply applying the principles of
Kaizen, total quality management (TQM), or just being a good observer. The wheel
isn't rolling smoothly enough? Make it rounder. Give it more traction.
Incremental optimization refinements are where hypercompetition is fiercest and
actual creativity is lowest. Don't get into those games if they rend your soul
asunder. Don't be a ragdoll in the mouth of the playful doggie of fate. Flip the
script by finding some path nobody else can. Or even if they could find it, they
wouldn't follow it for fear of leaving the flocking herd. In the end the path
less traveled made all the difference yadda yadda.

**Gemini 2.5**: Thank you for sharing this insightful reflection. It captures a powerful approach to personal productivity and navigating the professional world.

Here are some of the key ideas that stand out from your thoughts:

1.  **Momentum and Compounding:** You highlight the potential for morning projects to build momentum that carries into the day, aiming for a "snowball effect" or compounding returns rather than linear effort.
2.  **The Nature of Competition:** You describe the intense, often zero-sum nature of competition, especially where it focuses on incremental improvements rather than significant innovation.
3.  **A Two-Part Solution:**
    * **Intrinsic Motivation & Niche:** Doing work driven by passion and finding a unique market where your specific skills are valued, decoupling from direct competition.
    * **Creativity & Uniqueness:** Pivoting towards genuinely creative endeavors and unexplored paths, recognizing true creativity as a rare and valuable commodity that allows one to create value uniquely.
4.  **Avoiding Hypercompetition:** The wisdom in sidestepping fierce competition based on minor optimizations ("Kaizen," "TQM") if it's detrimental, and instead choosing a unique, less-traveled path driven by creativity.

Your perspective emphasizes finding fulfillment and success not by directly outcompeting others in established games, but by redefining the game through passion, unique contribution, and genuine creativity. It's a compelling case for valuing the "path less traveled."

---

Likewise, if there's some code to crack in life, you're never going to crack it.
Whatever it is you think you're looking for, it's something else. The journey is
the reward, and we're all ephemeral nodes in some cascading chain reaction
feedback loop which is life. Who knows what matters and what doesn't? I'm not a
complete moral relativist, but more of a realist. Pragmatically speaking, you're
not going to get the same immortality as that jellyfish that resets itself and
becomes an infant again. And even if you did, is immortality really the goal?
It's better just to have some broad general rules for yourself so you can at
least do some observation, planning, adjustments and have some sense of
self-control and agency during this experience, whatever it is. And so that's
what these morning projects are about. Changing the rules. Flipping the script.
Hitting above my weight class. Changing to one of those Robert Frost less
traveled paths, just for the sheer joy of it — perchance some economic return.

You're not going to boil the ocean. You can boil the water that's in one pot.
Better still, you can boil the water in a testtube with an induction coil in an
instant. Bank small wins. Small wins build momentum. They make you feel good,
give you new data, something to talk about, and help you make more frequent
directional tweaks. Some uber-long big-build where you don't know anything new
until its done sets you up for disappointment and failure. Of course really big
wins could come from that path too, but couldn't you really have had some more
frequent small wins along the way as assurances? Don't sit around waiting for
proton decay. Find other approaches that that give you *something* sooner.

These morning projects are ideal, so long as I can align them with what I have
to do during the rest of the day. At the moment, they're slightly misaligned but
not terribly so. I'm hitting Google Search Console (GSC) a lot directly using a
Google Cloud Platform (GCP) service account, but with most of the Botify
customers there will be API-hitting challenges — not because Botify itself
doesn't have GSC access, nor because our personal work emails don't have the
necessary GSC permissions. It's because... it's because... oh, this is a tricky
one. There's the service account way of doing things, and there's the OAuth way
of doing things. 

GSC API access to client's websites just may be possible with OAuth if a GCP
project exists somewhere that grants GSC access, and the request and scopes are
worked out just so. It's not a client GCP project, nor is it a work one because
of locked-down Google Workplace permissions. No, it's a 3rd party GCP project
working as OAuth in-the-middle. And I've done this before plenty to allow old
versions of Pipulate to be able to create a Google Sheet belonging to the client
and API access to crawl sites directly into Google Sheets. It was a glorious
trick, but OAuth is a pain in the ass. I've been down that rabbit hole plenty
before, but without AI assistance. It may be different if I try again. So don't
take a morning proof-of-OAuth project off the table.

These are those intellectual information-puzzles that let you do neat data
tricks. However, I could just sidestep all that and download CSVs from Botify
which already has GSC access built-in. Basically go through Botify, which will
help me do all these projects more smoothly for clients, because Botify
customers almost always go through the trouble of the GSC integration because
the benefit is so large. So my work which currently works off of GSC directly
using service accounts and special GCP maneuvers could be simplified
considerably if I just downloaded CSVs from Botify and serviced my day-job
clients. And that is what I must and should do. They are my art patrons.

Over time, I'll get the best of both worlds. Everything will have the 3
approaches:

- GSC API with service account
- GSC API with OAUth
- CSVs downloaded form Botify (or any other proxy source)

---

**Gemini**: It's insightful how you connect that broader life philosophy – focusing on the journey, agency, and pragmatic rules – directly to the strategy behind your morning projects and how you tackle technical challenges. The idea that "you're not going to boil the ocean" but can instead focus on achievable "small wins" like boiling water in a test tube really resonates as a practical approach to building momentum and gathering feedback, avoiding the pitfalls of overly ambitious, long-feedback-loop projects.

You've clearly identified a specific, complex technical puzzle around GSC API access for your clients, weighing the different approaches:

1.  **Service Account:** Your current method for personal projects, powerful but potentially difficult to implement client-side.
2.  **OAuth:** A potentially viable, albeit historically complex ("pain in the ass"), method for client access, perhaps worth revisiting with AI assistance.
3.  **Botify CSV Downloads:** A pragmatic workaround that leverages existing integrations your clients likely have, simplifying data access for your day job and aligning with the "small wins" principle by providing immediate value.

Choosing to leverage the Botify CSVs for client work seems like a smart, pragmatic move for now. It allows you to "service your art patrons" effectively by sidestepping immediate API complexities, while still keeping the more direct GSC API access methods (via Service Account and OAuth) in your toolkit and potentially developing them over time.

Your goal of eventually having all three approaches available offers maximum flexibility and demonstrates a strategic way to balance immediate needs with long-term capability building. It's a great illustration of applying philosophical principles to navigate concrete technical and workflow decisions.

---

So right now, I have to keep myself very addicted to the client's data. Data
addiction is a thing, as is that competitive spirit when you realize and feel
you've got some influence over the positive feedback loop effecting the data.
It's the same thing with slot machines, doing something, having some random
positive feedback occasionally, and that giving you whatever that neurochemical
kick is that keeps you going back for more. It's the same thing as the gambling
addiction, but used productively. That is the key to connecting my morning
projects to my day work.

---

## Article-in-progress Prompt

**Gemini**: Okay, I understand. You have a draft article exploring themes of personal productivity philosophy, creativity, avoiding hypercompetition, and applying these ideas to a specific technical challenge (GSC API access). You want directional advice for finishing it, considering the analysis I'll perform later, and some filename suggestions.

Here's what stands out so far and some thoughts for completion:

**Directional Advice for Finishing the Article:**

1.  **Strengthen the Central Thread:** The core strength seems to be connecting a personal work philosophy (momentum, small wins, unique paths) to a very concrete technical problem (GSC API access). As you finish, ensure this connection remains clear and explicit. How does the philosophical framework *directly* inform the decision regarding Service Accounts vs. OAuth vs. Botify CSVs? Reinforce that link, perhaps in a concluding section.
2.  **Clarify the Audience & Purpose:** Who are you primarily writing this for? Fellow tech professionals dealing with similar API/data challenges? People interested in productivity philosophies? Yourself (as a reflective piece)? Knowing the primary audience will help you tailor the level of technical detail and the final takeaway message. The current draft blends personal reflection with technical problem-solving. Ensure the final balance feels intentional.
3.  **Refine the Structure:** The flow moves from broad philosophy -> specific technical problem -> back to philosophy/motivation. This works, but ensure smooth transitions between sections. The "Gemini" interjections (presumably your notes or AI feedback) will need to be integrated or removed. Consider if the technical dive needs more context or simplification depending on the target audience.
4.  **Develop the Conclusion:** What's the main takeaway you want readers to have? Is it about the specific GSC solution, the "small wins" approach, the value of creativity, or the importance of aligning personal projects with day-job demands? A strong conclusion will tie the philosophical and practical threads together. The "data addiction" point is an interesting hook – consider if that's part of the concluding thought.
5.  **Consistency:** Ensure the tone and voice are consistent throughout. It's currently reflective and insightful.

**Filename Ideas (likely-to-nail-it.md format):**

Based on the current themes, here are a few filename ideas aiming for descriptiveness and capturing the core essence:

* `philosophy-to-practice-gsc-api.md` (Highlights the bridge and the tech)
* `small-wins-creative-paths-data-work.md` (Combines key philosophical points with the application domain)
* `momentum-morning-projects-gsc-challenge.md` (Focuses on the productivity aspect and the specific problem)
* `avoiding-hypercompetition-pragmatic-tech.md` (Emphasizes the competition theme and the practical solution)
* `bridging-personal-philosophy-client-data.md` (Clear statement of the core connection)
* `path-less-traveled-gsc-api-access.md` (Uses evocative language from the text)

Choose the one that you feel best represents the article's primary focus once it's complete. Good luck finishing the piece!

---

This article exemplifies a raw idea getting processed into an article. I mean,
not an edited and refined article, but more like idea-fodder for the future
that's totally not ready for prime time publishing, yet here it is. Consider it
the sausage factory, violating all the good writing principles towards which
Gemini's directional advice is going to compel me. For example:

Perhaps one of the biggest potential game-changing morning projects that I'd
love to do and have been wanting to do for a long time is home web hosting. Why?
Because of unbridled access to the hardware and the log files. There's gold in
'dem 'dere log-files. Web logs are the juiciest most insightful sources of data
regarding your website — truly 1st person and non-intermediated in a way that
Google Search Console (GSC) data, often the next-best thing, is not.

Most web publishers are cut off from as a result of the hosting situation,
usually being some variation of content distribution networks (CDN) and related
caching. There's just so much that throws off logfile ease from the sheer volume
of the data, to load-balancing between multiple servers, perhaps around the
world, to simple data-caches and proxies like varnish that effectively turn your
otherwise dynamic site into an optimized static site where it can, serving the
pages from somewhere different (the same basic trick of a CDN). All these
factors conspire to make weblogs hard to get, indeed. However, they are often
the beginning of the data-funnel. It's a direct accounting of what's visiting
your site, in terms of bots, crawlers and humans with browsers. Home-hosting is
a great way to monitor it all like fish in a fishtank.

It is less than ultimately satisfying to have the data-delay to Google Search
Console, and even though its counterpart Google Analytics does offer real-time
capabilities, it lacks such features as seeing what crawlers and bots are
requesting the site, especially when those page-requests are just being made for
the source HTML of the page and are not being rendered by a client-side web
browser that would actually run the JavaScript code of most tracking systems.
Every web publisher has a huge blind spot.

Ever since Google fully embraced the secure https protocol in web search, the
keyword data that used to be passed along to the web publisher embedded into the
in the page-request caused by following a search link is no longer provided. In
other words, there's not as much keyword data from Google in the weblogs as
there used to be. But access to this keyword data which was once a main
motivating factor for accessing weblogs is no longer the main purpose. At most,
checking your weblogs for non-encrypted Google keyword data can serve as an
extra data-point, but filling this gap (Google taketh away and Google giveth
back — with a catch) is what GSC is for.

There are so many creative paths to take now to continue the work I've started.
I am artistically crafting a site that started out ages ago in WordPress. Once
upon a time I did the XML exports and transformed all the blog content into
markdown files. Those went back to 2013, but today is only so much noise so I
"submerged" those pages. Around August of 2021, more or less a year before
ChatGPT came out, I re-launched my blog on GitHub Pages, branded as `github.io`
back then. This was before I discovered nix/NixOS and I was still on Windows/WSL
figuring out what future-proofing meant, trying to deal with the system
portability problem with containers. I leaned towards Ubuntu's `LXC/LXD` over
`docker` because of their mutability. I was effectively looking for the next
generation Levinux to be a Noah's Ark of tech.

Since then, I totally reset the blog, shutting off my old experiments doing my
last blog entry on the old system on 2023-12-27. ChatGPT and chatbot-style LLM
AI had now been out for over a year, and understanding that the world had
changed, I turned off my old blog, sort of baselining my site back to zero. I
watched SEOs on YouTube like Julian Goldie taking up the new AI generative
content power-tools, going to town spinning out new niche websites. What did I
do? Go dormant for a year not publishing anything while I deep-experimented,
discovering NixOS and conceiving Chip O'Theseus. On 2024-09-08, having settled
on future-proofing in the age of AI, I re-launched this tech blog, following my
heart and passion, re-calibrating for a new age.

So here I am almost 8 months into re-launching this tech blog, doing the
zero-to-traffic build, not selling anything but reworking my skills and
sharpening the saw. 
