---
title: The Port For Real This Time
permalink: /the-port-for-real-this-time/
description: 
layout: post
sort_order: 1
---

## Hail Mary at Porting Apps Tonight

Ugh, it's weeks later and I still haven't ported the 2 key apps. But that's
okay. I do it tonight. I go late and long if I have to. And tomorrow, I have my
first client call that I'm managing myself in a long while. So I can do both
things without screwing up, right? Right!

## The Art of AI-Enabled Problem Solving Is Evolving Quickly

Everything becomes easier as you get more adept at AI-wrangling, right? It's
just like being an SEO or Webmaster before it. There are no hard and fast rules.
Some people might think so or try to tell you so, usually to make money off of
you some way or another, but all best are off. The deck is being reshuffled, but
thankfully some skills will shine through and serve you in any tech-enabled age.

## I've Found My Creative Spark Again Through Tiny Details of New Era

I've fallen back in love with those tiny details. I thought I might have been
burnt out, but I was challenged by my boss to to the best work of my life. And
with AI reshuffling everything the way it is, it's really when I'm at my best.
And I'm coming up from a rather deep dive on recalibrating the new reality and
aligning my skills just so, and tweaking my tool-set.

## Making Work a Show: Connecting Old and New Skills

Tomorrow, it's back to managing meetings and such, but I have to make it a show.
And the key to making it the magic show (with the substance behind it) that
makes it so enjoyable for me and everybody else, is to connect the dots of my
new work with my old job. Bring my new skills and new tools and new shows to
bear every day. Let the word and the wonder spread of this new thing, this way
Mike works that is just... just... well, words ***should*** fail.

## The Port Awaits a Fast and Eventful Few Hours Ahead

And that's why the port is going to be fun. I'm going to blast through it the
best and as fast as I can. We're talking a few hours, as opposed to the few
weeks it took me to get this far. 1, 2, 3... 1? ...is how it goes. That's the
language I use. I'm always on step #1, because you can't do anything more that
what's immediately before you. The now-moment is everything... and now... and
now... methinks App #1 in the app placeholder section is... set token!

I'm not going to make the same mistakes I made getting to this point, which is
leaving choices too open-ended for the AI. In the state they're in today, they
are only too anxious to lead you down deep, winding rabbit holes from which
there is no return&#151;at least not in the same night and not without
frustration and exhaustion. To keep frustration and exhaustion at bay by not
going rabbithole-diving, one must attach some rappelling rope at the top of the
abyss and be ready to pull yourself up at a moment's notice. And so we do that.

## Switching From ZeroMQ to WebSockets for Real-Time Communication

I have two code-bases. One was my first web app implementation under FastHTML,
and only barely at that. For interprocess communication, I used the still
amazing ZeroMQ, aka Zero-wait Message Queue, or just zmq for short. It was big
in the Python world and made it around to lots of other platforms for its
timeless inherent cross-domain value, like embedding RegEx or SQLite. However,
an alternative industry standard called WebSockets has really taken off, and
despite their different use-case sweet spots, one does not not use WebSockets
anymore. 

Everything that chats uses them, and it's that distinct real-time difference you
feel in ChatGPT, Perplexity, Anthropic and all the other chatty user interfaces
that are copying each other these days. While you could make things tighter with
zmq if it's all on the same physical hardware, why would you when you could be
learning what the world uses to write chat apps? So a big part of the porting
and refactoring is unwiring things from zmq and rewiring them to websockets.

## Using Databases Efficiently for Small Projects and Cookie-Like Persistence

## Using a Lightweight Database for Browser Persistence Options

## Using Lightweight Databases for Small-Scale Applications Only

The other major difference is the way database stuff works. Even calling it
database does it a disservice because it makes you think ***big*** stuff like a
SQL server of some sort like PostgreSQL, Redis or MySQL. Or a NoSQL database
like MongoDB or Cassandra. These things are built to support big enterprise
infrastructures. But sometimes you just want a database to replace browser
cookies. If you have total control of the server, why not just keep track of who
the user is client-side with a session-id and do all your database stuff on the
server in an extremely lightweight fashion with SQlite or even reading and
writing text files. 

## Using a JSON Data Structure for Textfile Persistence Is Smart

## Using JSON Files for Text Persistence with a Library Approach

## Using JSON for Text File Persistence with Python Libraries

If you read and write textfiles, the best candidate is using a library that
treats it as a JSON data structure so that your library takes care of all the
API-work making you feel like it's not just a textfile. And so, that's what I
did to achieve a sort of cookie-like persistence on the server. I read from and
wrote to a JSON file on the drive. It's a great strategy if you're not using
FastHTML, which I am, which wraps SQLite in this nifty little MiniDataAPI spec
wrapper making it even easier than SQL. It's an interoperable API layer that
almost any database or database-like thing can be wired to, so you can swap out
the actual physical database mechanism without changing your code.
