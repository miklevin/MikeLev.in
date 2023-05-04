---
date: 2023-01-03
title: Per Week Tuples as a Google Photos Project?
headline: Preserving My Lifetime Experience with Google Photos API and Weekly Named Tuples
description: As a parent, I'm looking for ways to teach my kid while still making it fun. I'm exploring the capabilities of the Google Photos API, such as albums and mediaItems, and using SQLite3 and SqliteDict to rapidly organize my data better than the Google UI provides. I'm creating a project to capture my lifetime experience with data and preserve it as metadata, using weekly namedtuples to ensure the data is unique.
keywords: Google Photos API, Albums, MediaItems, SQLite3, SqliteDict, NamedTuples, Data, Metadata, Parenting, Teaching, Fun, Cloud, Data-Source, Data-Paging
categories: sqlitedict
permalink: /blog/per-week-tuples-as-a-google-photos-project/
layout: post
---


Wow, January 3rd and the first work-day of the new year. I still have my kid,
woot! That's Friday night to Tuesday! I love spending time with my kid. We have
so much in common that they are only just discovering we have in common, from
taste in media like Anime, to the very way we think. I've got to think of ways
to covey education with what little wisps of time I get here and there, without
it "feeling" like education. Learning is one of the greatest pleasures in life,
so long as it's going to help you and add the self-loving tapestry of who you
are. Favorite world leaders. Favorite scientists. Favorite inventions. Etc.

The think I've been doing lately of enumerating a life in terms of weeks, and
using a fixed, sequential integer IDs for every weeks starting from the week of
your birth may be of eventual interest to my kid. Out of the 5200 weeks of a
100-year lifetime, I am at week 2731 out of 5200, or 52% of the way through my
life as I am strongly visualizing it:

    int(eval(week).id / 5200 * 100)

It was once said to me that if I haven't "made it" by now, I'm never going to
make it. Well, I'm still learning and figuring things out with all the benefits
of the experiences, knowledge, know-how, habits and muscle memory that I've
developed so far. It's feeling more like a good starting-point than an
ending-point, so needless to say I think that statement was one of the biggest
loads of bullshit I ever heard. That kind of shit tells you more about the
person saying it than it does yourself. The 52% of my life so far (yes, I know
that's optimistic but I am optimistic) feels like just getting warmed up.

Okay, so let's take this namedtuple-per-week project to the next step. I've
been hitting Google Photos through its API a lot recently in preparation for
some bigger projects. Okay, keep track of some of those Google Photos API
resources:

- https://developers.google.com/photos/library/guides/overview
- https://developers.google.com/photos/library/reference/rest

Most of the information out there comes from Google's official sites. There's
not many folks as far as I can tell publishing about their use of the Google
Photos API. Keep in mind its capabilities from the rest reference link above:

albums

    addEnrichment	POST /v1/albums/{albumId}:addEnrichment
    Adds an enrichment at a specified position in a defined album.

    batchAddMediaItems	POST /v1/albums/{albumId}:batchAddMediaItems
    Adds one or more media items in a user's Google Photos library to an album.

    batchRemoveMediaItems	POST /v1/albums/{albumId}:batchRemoveMediaItems
    Removes one or more media items from a specified album.

    create	POST /v1/albums
    Creates an album in a user's Google Photos library.

    get	GET /v1/albums/{albumId}
    Returns the album based on the specified albumId.

    list	GET /v1/albums
    Lists all albums shown to a user in the Albums tab of the Google Photos app.

    patch	PATCH /v1/albums/{album.id}
    Update the album with the specified id.

    share	POST /v1/albums/{albumId}:share
    Marks an album as shared and accessible to other users.

    unshare	POST /v1/albums/{albumId}:unshare
    Marks a previously shared album as private.

mediaItems

    batchCreate	POST /v1/mediaItems:batchCreate
    Creates one or more media items in a user's Google Photos library.

    batchGet	GET /v1/mediaItems:batchGet
    Returns the list of media items for the specified media item identifiers.

    get	GET /v1/mediaItems/{mediaItemId}
    Returns the media item for the specified media item identifier.

    list	GET /v1/mediaItems
    List all media items from a user's Google Photos library.

    patch	PATCH /v1/mediaItems/{mediaItem.id}
    Update the media item with the specified id.

    search	POST /v1/mediaItems:search
    Searches for media items in a user's Google Photos library.

So basically don't forget that I can do more than enumerate mediaItems. There's
good stuff in here. Just remember, I want to be able to rapidly organize much
better than the Google UI provides. This includes:

Drag-sorting of icons freely and enmasse without going through a Web UI which
so far doesn't seem to be conducive to such things.

Remove duplicates with fairly sophisticated and smart rules about keeping the
versions that are first, highest resolution, been favorited, used in albums and
such.

Okay, so think it through.

The temptation is to use SQLite3 via SqliteDict as usual. It's the easiest way
to do fast data-capture of the raw, unedited data-source. Combined with using
the API-calls that resulted in the data as the database keys, this technique
has a lot going for it.

But the Google Photos API uses this "next token" approach. The token may have
some significance, but using the token as the database key doesn't make much
sense because it doesn't say (much) about the data and probably can't
(shouldn't) be used in reproducing the data-calls.

In fact, it is only the original data-call from which the next-token
data-paging started that has any real significance in terms of database-keys
that are also reproducible API-calls. There should be high degrees of
determinism built into such an app at this point. Don't make the mistakes that
would make the output variable and seemingly random.

Hmmm, my weekly namedtuples really are the ideal database keys. Can I stuff the
raw data retrieved for a whole week into a single cell? I definitely don't even
want to think about generating thumbnails from the data yet for
filesystem-friendly icons. No, it's definitely about raw data-capture still. So
the question may be how to field-stuff all the paged data for a week into a
single SQLite blob field. Why not? Performance? File-size? The file-size would
be the same either way, paged data split between database records or paged data
all stuffed into a single database record--same size. Don't sweat the file
size.

Okay, so it's a performance issue with NoSQL-style field-stuffed raw data
capture. And it always will be. Don't expect top performance with
field-stuffing (decomposed row & column will always be faster). No, live with
the performance hit. Just run the script in such a way that you don't care.
This is where GNU screen comes in. Wow, I really have to make that point as an
argument for switching to Linux, the mere fact you have GNU screen at your
disposal.

The Key to Keys is making them API Keys

You should have an education in unique constraint keys. A.k.a. primary keys in
database-land and dict keys or sets in Python land, for all dictionary
datatypes also contain a set — a set of its keys. They are unique. That is,
they only appear once.

All you have experienced thus far in life is what has prepared you to make your
next self-determined decision. Not all decisions you make are of the free-will
variety. Many are predetermined by your emotional animal, yet still quite
predictable less-sentient animal self. Labels are stupid, but let's call
sentience the ability to break the preponderance of possibility that something
occurs.

Actualization is funny. Collapsing the blurred cloud of all possible things
that could happen down into the one that actually did is called time. And time
is not fixed. For you right now where you are in time and space, you've got a
timeline. In fact, the timeline in your head is slightly faster than the
timeline in your feet because you spend much of your time standing up. Since
your head is farther from the Earth's axis of rotation, your head's moving
faster than your feet.

Nutty, right? So your timeline is unique and wholly uniquely yours. That is key
here in this discussion. It's not just your DNA genetic code that makes you
unique. It's not just the epigenetically selected smorgasbord of genes
expressed in this lifetime that makes you unique. To the best of our current
understanding, it's the whole friggin Universe as seen, experienced and lived
from your perspective that makes you unique.

You don't share a timeline with anyone you ever knew, heard of or existed. They
each have their own. This should not lead you to believe you're the only one in
this Universe and nothing really matters. Quite the opposite. There may be
nearly infinite others like you — but not exactly. And those differences are
key.

How could you make this lifetime experience of a human being quickly
searchable? Maybe you'd create fields named Name, Birthdate and Place of Birth.
If POB was 4-D coordinates in space/time relative to an always-knowable point
of reference, then that's probably be enough. Nobody else is occupying the
exact same location as you. Not likely, at least. You'd need 5D coordinates to
plot that. The Z-axis is the probably cloud of what might have happened, thus
infinite but very similar to your own parallel universes.

But in just 4D spacetime, there's some Python namedtuple that could plot it.
Some of the more pydantic out there might insist on a dataclass which provides
the ability to set what datatype each argument must use, validation rules and
the like. It is as it says using an Object-Oriented style Class to merely hold
data in dot-this/dot-that notation.  Namedtupes and Dataclasses often look in
use much like each other. But for the quick-and-dirty, especially for use in
database keys, I'll choose namedtuples every time.

So the purpose of the impending data-capture project is several-fold. We need a
better alternative to getting all of our data off the cloud than they provide
with their one-time checkout process. We want to do it with finesse m,
organizing while we go and capturing all the meta data we need, like when a
video was really shot.

A Google Photos client export doesn't necessarily preserve that data-at least
not somewhere daily accessed again without a whole other similar project of
loading and parsing files looking for the metadata. We're going to have it once
here on the first Google Photos API query l, and our purpose is to preserve it
as a sort of metadata safety-net for later. Knowing all that is here for later
querying, we can play fast and loose with experiments.

So what does a primary key-like unique constraint consist of for Google Photos
media? Think one transform down the process to know how you want to capture the
raw data. In an ideal situation, each set of arguments that go into an API-call
are used in a namedtuple, which provides both data and data label. These are
transformed easily into tuples, and tuples can be used as dictionary objects
even without SqliteDict in the picture that you see me use so often. One of the
most beautiful things Pythonic is that to ensure the uniqueness of each tuple,
you throw the tuples onto a set. What comes out is deduped tuples.

So I'll probably burn some of my daily Google Photo API quota on all the years
for which I know there will obviously be no images found. Sometimes an uploaded
graphic into Google Photos that has a ridiculously old creation date will look
like it went into your albums on that impossible date. I cleaned most of those
to some even New Years date. So the first appearance of data for date-ranges in
Google Photo should be for approximately when I started using it.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/youtube-analytics-api-delegation-driving-me-to-web-browser-automation">YouTube Analytics API Delegation Driving Me to Web Browser Automation</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/life-in-weeks-ipynb">life_in_weeks.ipynb</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/sqlitedict/'>SqliteDict</a></h4></li></ul>