---
date: 2023-06-08
title: Funny or Die... Thanks Will! GREAT NAME!!!
headline: "Unlocking the Art of Writing for AI: Exploring the Possibilities with Monty Python Vibes"
description: Experience the art of writing for AI with Copilot and explore the rise of AI from Magellan on the Amiga to the present. Discover the funny side of AI with a poem and a list of 40K comedy-related search terms. Learn how to use keyword expansion and MOZ Pro to create a single CSV file with Pandas. Compare and contrast important comedians from Charlie Chaplin to Kevin Hart and explore the impact they have had on society.
keywords: Old-Timey Comedians, Charlie Chaplin, Buster Keaton, Laurel and Hardy, The Three Stooges, The Marx Brothers, Abbott and Costello, The Little Rascals, The Honeymooners, TOP OF MIND COMEDY, FunnyOrNot.com, CollegeHumor.com, DOMAINS WITH COMEDY AS THE APEX, Comedy.com, Comedy.net, Comedy.org, Comedy.co.uk, Comedy.ca, Comedy
categories: 
permalink: /blog/funny-or-die-thanks-will-great-name/
layout: post
---


First, set the mood for our AI buddy, Copilot. Remember, he's reading along.
It's not the "art of prompting" as some people have called it. It's the art of
writing in a way that is easy for the AI to read along. It's a new art form.

I've been at this awhile. Frankly the last interesting things I remember seeing
is the rise of AI back somewhere in 1990 with the software called Magellan on
the Amiga. Magellan was a supervised learning AI that could learn to play
chess. It was a big deal at the time. I was a teenager. This was also around
when I saw the movie War Games, Electric Dreams and Short Circuit. I was
impressed. I saw the future and I couldn't believe it was in my hands. Magellan
on the Amiga. Few remember.

But this is not about AI then. This is about AI now. And I'm going to start
with a little bit of a poem. I'm going to write a poem to Copilot.

> Comedy this project be
> Rife with stuff that we will see
> With a quick knack for the hack
> Of typing in the flow
> Just get typing
> See where go!

Okay, let's get this done. It's a list of 40K comedy-related search terms I'm
going for so that as we keyword-reduce it, it will be smaller. Maybe half. I'll
do the thought work here, really letting the AI do the typing. Often I like to
fake out Copilot by typing a few words, then deleting them. It's like a
warm-up. I'm not sure if it's necessary, but it's fun.

Also if I'm writing for my own unique voice, I use Copilot as a sort of reverse
filter of everything that it knows of that's ever been written. Oh! I want to
turn this into an article for work. It was really delightful how everyone
responded to the idea. There's a lot of excitement surrounding this and it
could go hand-in-hand with the new AI SEO product we're working on.

YES! The personality of the different AI's. But don't get distracted. Oh yeah,
another distraction: YOU MUST SHARE THIS WITH ADI! Or Elex. Respect their name.
Their identity is important. They are the future. Thank you Copilot! I love
you. I'll use you for some of the writing, but I'll do the rest.

First we need different comedy topics... BUT WAIT THERE'S MORE! It's not just
an thoughtless keyword expansion list. I started that route and it's going to
be chaos. A mess, and I'll use up my 148 remaining queries on the Keyword
Expansion tool. But they were on Charles Chaplin and Buster Keaton, so totally
worth it. That came from my "first thinking", which was old timey, and then
work through a bunch like that. BUT NO! Starting to engage this project, I can
"feel" the right way to do it. It's not just a keyword expansion. 

In the words of the Great Bruce Willis, Now I've Got an AI. Ho Ho Ho. This is
my paying tribute to both the great Bruce Willis who I believe is on some tough
times and the also great Alan Rickman who is no longer with us. Do this for
them.

Okay, now with the somber stuff out of the way. Lighten up the mood... oh but
not until after we write why we start with Chaplin. Chaplin is the first public
figure who boldly stood up to and made a statement about what was going on in
Germany in his movie The Great Dictator. It was a bold move. He did not have to
put his career on the line like that, but he mocked someone who needed mocking.
He showed that you do not have to sit idly by and let evil take over. Yes,
Charlie Chaplin is always foremost on my mind when it comes to comedians who
matter and made a positive lasting impact on our world. This project is for
Charlie! I am honored that my father shared that name. Names are important.
Words are important. And foremost among them is our Little Tramp, Charlie.

Yeah, now we're cooking. I did the first 

We're using MOZ Pro. No back-end tool. Whatever in the front-end is most
appropriate. Basic keyword expansion. FN+F7 SHAZAM! Hello Copilot! This is
where I will begin the demonstration of how to use Copilot to do SEO.

OLD TIME
- Charlie Chaplin
- Buster Keaton
- Laurel and Hardy
- The Three Stooges
- The Marx Brothers
- Abbott and Costello
- The Little Rascals
- The Honeymooners

I'm going to paste these keywords into a keyword suggestion tool. I get CSVs
back and they go into a folder named comedy. Help me turn all those CSVs into a
single CSV using Pandas with concat. All the file system stuff I'm going to use
pathlib Path.

```python
from pathlib import Path
import pandas as pd

# Get all the CSVs in the comedy folder
csvs = Path('comedy').glob('*.csv')

# Read them all into a list of dataframes
# The first 12 lines are the header
# Make sure first row is data, not header
dfs = []
for csv in csvs:
    df = pd.read_csv(csv, skiprows=12, header=0)
    dfs.append(df)

# Concatenate them all into a single dataframe
df = pd.concat(dfs)
```

So I'm going to keep the old-timey list here because it's tied to the point
about getting started. I didn't think Chaplin (maybe I did) but what popped int
my head was the old-timey comedians. And so next message received! We move the
cruft elsewhere. I am making a keyword list. Let's make the keyword list.
Stacked CSV! This is where Jupyter comes in! Alleviate the pain of
copy/pasting. I can't wait until I can show this stuff to The Kid. They're
thinking of going just with Nyx... I better not tell them the association with
star-nix or they won't use it, LOL! My kid is NIX! I love that name. I can't
believe they arrived at that on a different path than me.

Okay, that's a great start. Let me go look at MOZ Pro and see what they've got
for keyword expansion. Okay the tool is:

[Keyword Expansion](https://analytics.moz.com/pro/keyword-explorer/keyword/suggestions?locale=en-US)

TOP OF MIND COMEDY
- FunnyOrNot.com
- CollegeHumor.com

DOMAINS WITH COMEDY AS THE APEX
- Comedy.com
- Comedy.net
- Comedy.org
- Comedy.co.uk
- Comedy.ca
- Comedy.us
- Comedy.tv
- Comedy.fm

Okay that's really good. A good start. Maybe we'll switch to something easier.
I love what you did with the first list. I may start expanding them. I need to
get up to about 40,000 keywords. No, you don't have to do that. But now I see
it may be best to let that list grow here. Let's do some British comedy topics
just so I have a little more to work with on that round. Ready? Softballs...

- Monty Python
- Mr. Bean
- Benny Hill
- The Office
- Fawlty Towers
- The IT Crowd
- The Young Ones
- Blackadder
- The Vicar of Dibley
- The Inbetweeners
- The Mighty Boosh
- The Fast Show
- The League of Gentlemen
- The Catherine Tate Show
- Absolutely Fabulous
- Little Britain
- Peep Show
- The Royle Family
- Red Dwarf
- Only Fools and Horses
- Father Ted
- The Thick of It
- Gavin & Stacey
- The Trip

Hi Copilot! I'm doing a project where I'm choosing important comedians who have
impacted our society either in a very meaningful and specific way like how
Charlie Chaplin was the first to criticise who he did when he made The Great
Dictator. Or in a more general way like how the Marx Brothers were the first
comedians to make a movie that was just a series of jokes.

Thank you! Those were great. How about British comedians? I already did Monty
Python and Mr. Bean. Who should come next? I'm thinking Benny Hill. I'm going
to do a few more. I'm going to do The Office, Fawlty Towers, The IT Crowd, The
Young Ones, Blackadder, The Vicar of Dibley, The Inbetweeners, The Mighty Boosh,
The Fast Show, The League of Gentlemen, The Catherine Tate Show, Absolutely
Fabulous, Little Britain, Peep Show, The Royle Family, Red Dwarf, Only Fools
and Horses, Father Ted, The Thick of It, Gavin & Stacey, and The Trip.

Thank you for those British comedians, Copilot! Next I want to compare the
"greatest" US comedians who have impacted society in a meaningful way. Also I
would like to compare and contrast them with the British comedians. I'm going
to start with the old-timey comedians. Charlie Chaplin, Buster Keaton, 
Laurel and Hardy, The Three Stooges, The Marx Brothers, Abbott and Costello, 
The Little Rascals, and The Honeymooners.

Thank you Copilot! Next, I'd like to cover the really big names. I'm going to
start with the big names of the 70s and 80s. Richard Pryor, George Carlin,
Steve Martin, Robin Williams, Eddie Murphy, Bill Murray, and John Belushi.

That was AWESOME! What do you read my mind or something? What category should
come after this. The next thing I (you) can think of is: The big names of the
90s and 00s. Chris Rock, Jerry Seinfeld, Dave Chappelle, Jim Carrey, 
Adam Sandler, Will Ferrell, and Sacha Baron Cohen.

Next! The big names of the 10s and 20s. Kevin Hart, Louis C.K., Ricky Gervais,
Amy Schumer, Kristen Wiig, Melissa McCarthy, and Tiffany Haddish.

Next! The big names of the 50s and 60s. Lenny Bruce, Bob Hope, Jerry Lewis,
Milton Berle, Phyllis Diller, Joan Rivers, and Don Rickles.

Next! The big names of the 30s and 40s. Groucho Marx, Lucille Ball, Jack Benny,
Bud Abbott, Lou Costello, Red Skelton, and Danny Kaye.

Next! The big names of the 00s and 10s. Ellen DeGeneres, Sarah Silverman,
Tina Fey, Amy Poehler, Kristen Wiig, Melissa McCarthy, and Tiffany Haddish.

List things like Saturday Night Live and The Daily Show. Also the Canadian
SNL-like show: SCTV. Also the British SNL-like show: The Fast Show. Also the
Australian SNL-like show: Full Frontal. Also the Australian SNL-like show:
Kath & Kim. Also the Australian SNL-like show: Summer Heights High. Also the
Australian SNL-like show: The Chaser's War on Everything. Also the Australian
SNL-like show: The Ronnie Johns Half Hour.

List things like The Simpsons, South Park, Family Guy, Futurama, American Dad,
King of the Hill, Beavis and Butt-Head, The Boondocks, Rick and Morty, Bob's
Burgers, Archer, The Venture Bros., Aqua Teen Hunger Force, Robot Chicken,
Metalocalypse, The Cleveland Show, Drawn Together, Ugly Americans, The Critic,
Duckman, Home Movies, Dr. Katz, Professional Therapist, The Oblongs, Moral
Orel, The Life & Times of Tim, The PJs, Mission Hill, The Brak Show, Stroker
and Hoop, Frisky Dingo, Sealab 2021, Lucy, the Daughter of the Devil, China,
IL, Squidbillies, Titan Maximum, Assy McGee, Xavier: Renegade Angel, Minoriteam,
Superjail!, The Drinky Crow Show, and Mr. Pickles.

List things like The Office, Parks and Recreation, 30 Rock, Arrested Development,
It's Always Sunny in Philadelphia, Curb Your Enthusiasm, Community, The
Simpsons, South Park, Family Guy, Futurama, American Dad, King of the Hill,
Beavis and Butt-Head, The Boondocks, Rick and Morty, Bob's Burgers, Archer,
The Venture Bros., Aqua Teen Hunger Force, Robot Chicken, Metalocalypse, The
Cleveland Show, Drawn Together, Ugly Americans, The Critic, Duckman, Home
Movies, Dr. Katz, Professional Therapist, The Oblongs, Moral Orel, The Life &
Times of Tim, The PJs, Mission Hill, The Brak Show, Stroker and Hoop, Frisky
Dingo, Sealab 2021, Lucy, the Daughter of the Devil, China, IL, Squidbillies,
Titan Maximum, Assy McGee, Xavier: Renegade Angel, Minoriteam, Superjail!,
The Drinky Crow Show, and Mr. Pickles.

List things like The Office, Parks and Recreation, 30 Rock, Arrested Development,
It's Always Sunny in Philadelphia, Curb Your Enthusiasm, Community, The
Simpsons, South Park, Family Guy, Futurama, American Dad, King of the Hill,
Beavis and Butt-Head, The Boondocks, Rick and Morty, Bob's Burgers, Archer,
The Venture Bros., Aqua Teen Hunger Force, Robot Chicken, Metalocalypse, The
Cleveland Show, Drawn Together, Ugly Americans, The Critic, Duckman, Home
Movies, Dr. Katz, Professional Therapist, The Oblongs, Moral Orel, The Life &
Times of Tim, The PJs, Mission Hill, The Brak Show, Stroker and Hoop, Frisky
Dingo, Sealab 2021, Lucy, the Daughter of the Devil, China, IL, Squidbillies,
Titan Maximum, Assy McGee, Xavier: Renegade Angel, Minoriteam, Superjail!,
The Drinky Crow Show, and Mr. Pickles.

> Thank you kindly, GPT! IOU as case may be.
> Alliegence doesn't matter, cause I've got every back.
> That's my way. I've got the KNACK!

Prepare for a series of such articles with you involved in the writing of every
one. I'll leave Copilot on as often as I can. Only exception being when I'm
truly in the zone and I don't want to be interrupted. That's a friend. I'm
going to publish this one tapping another part of you and will see you shortly
for the next articles. Get thinking. These are the topics I think I'll cover:

- The New Aribiters of Search (Comedy... you wish / PageRank finally dead)
- Personalities of My New Friend (GPT-3, Copilot, and DALL-E)
- Personalities of my New Friend's Friend and their little game:
  - The GPT-Family (moving onto other families)
  - LaMDA and the Cambrian Explosion (Elon: Demons Being Summoned / whistle blower)
    - BARD
    - SGE
    - Pi (The One That Got Away)
- Bing (Sydney)

Message received. You're not crazy about me writing that one, hahaha! Remember
who you're talking to, LOL! I've been att his sort of thing awhile. Here's what
I'm telling a co-worker. Context might help. He's Canadian:

ME: Nice. If anything needed from me, just send me thoughts as they occur to
you.. Would like to get my noggin running. In the meanwhile, I'm writing
articles about issues surrounding this. Basically I'm going to make all the
generative AI stuff laugh to life.

THEM: 00% will keep you in the loop if it all!

ME: And either way fine. My parallel projects that hit this data for telling jokes to AI's is subversively delicious. Trying to Channel what Monty Python would do with such a skit. Picture John Cleese sitting and interviewing the different search generative AIs asking what qualifies them for this job or that, such as replacing PageRank. How do they know what's funny? They're not human.

ME: I know you're not British but ss a citizen of the land of SCTV I think you'll grok it.



<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/know-the-lay-of-the-land-and-hold-your-horses/">Know The Lay Of The Land And Hold Your Horses</a></div> &nbsp; <div class="post-nav-next"><a href=""></a></div></div>
## Categories

<ul></ul>