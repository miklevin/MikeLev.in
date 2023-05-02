---
date: 2023-02-05
title: Expanding My Google Suggest Jupyter Notebook to Include Stop Words
permalink: /blog/expanding-my-google-suggest-jupyter-notebook-to-include-stop-words/
headline: Exploring the Success of Refining My Google Suggest Probing with Stop Words and Jupyter Notebook
description: I recently moved my Google Photos project to a server running LXD Linux and am refining my Google Suggest probing to include stop words. I'm also exploring the idea of switching my project to Jupyter Notebook based locally. I'm using the same technique on my OhAwf repo and it's proving to be successful. Read more to find out how I'm making this transition and the success I'm having with it.
keywords: Google Suggest, Jupyter Notebook, Stop Words, Google Photos, LXD Linux, OhAwf, Transition, Success
categories: success, transition, google photos, jupyter notebook
layout: post
---

Okay, it was many years into Google Photos. It's not going to be overnight out.
One key thing you need is a storage place big and secure enough to receive all
your Google Photos images. I'm using a NAS with mirrored main drive and
multiple backups. That should be good enough, and in the future I'll do even
better. But for now that's an adequate receiving location so that I can start
squeezing stuff off Google Photos a week at a time.

That project is actually now fairly well underway. The process started out on
my laptop due to the Jupyter Notebook advantage. However since it needs to be
running pretty much relentlessly 24x7 from now forward to get it done in a
reasonable amount of time, I moved it over to a server. The server is actually
just an LXD Linux instance running on my NAS, which is awesome. I finally have
the advantage of a Kubernetes like container host at home without the tech
liability. Just keep only 1 or 2 such containers running and you'll be fine.
This stuff will mainstream and become very easy as the years go by. Live with
what the NAS manufacturers make easy for now.

Next is to make sure the job doesn't get out of hand. Enumerate and expose
everything about the process so you know how far along the jobs are, how long
you have to wait in general, and what the process along the way is going to
look like.

Interestingly, a lot of my work is going to switch from Jupyter Notebook based
on my local laptop to vim text editor based in a text-based secure shell (no
graphics) on the server.

Hmmm. Before I get to that, I want to refine my Google Suggest probing a bit.
It's awesome, but I'm sure there's a better way to prompt probing. Think! Do
better than shallow rote. Do intelligent middle. Forget brilliant depth for
now. Tough to get there. Take a first step. What's better than for each:

    root + space * letter

?

Well, we can do this:

    root + space + stop_word + space

I could combine both of the above, but that's too-deep a probe. I don't want to
clobber Google Suggest. I just want to find the juicy search real estate others
may have yet failed to address. Think!

Okay, done! It's using a modified version f stopwords. Looks like it's working
really well. It will be fertile test ground for keyword clustering techniques.
I already have a limit-finding KMeans approach in there right now for a first
attempt at clustering Google keyword suggestions.

Let your mind go back to Google Photos again, and your work likely residing on
the server. Maybe... perhaps I can get it to be Jupyter Notebook based locally,
but I'd have to make the move to nbdev. It's actually an acrobatic little
maneuver, and the iron is really really hot. Maybe talk on that a bit. Show
your OhAwf repo where you're using exactly this technique, on nbdev2 already.
It's a good model.


## Categories

<ul>
<li><h4><a href='/success/'>Success</a></h4></li>
<li><h4><a href='/transition/'>Transition</a></h4></li>
<li><h4><a href='/google-photos/'>Google Photos</a></h4></li>
<li><h4><a href='/jupyter-notebook/'>Jupyter Notebook</a></h4></li></ul>