---
date: 2023-04-19
title: Planning on Adding Front Matter Support to Journal Entries
headline: Ready to Take the First Steps in Adding Front Matter Support to Journal Entries?
description: I worked on a Content Gap Analysis project today and thought about adding Front Matter Support to my Journal Entries. I'm writing a program to parse a file, reconstruct it, and compare it to its source. I'm then transferring the logic into a python script and reversing the order of the posts in the live code to prevent bloat. I'm creating a new file - journal_ - to make this happen. Ready to take the first steps? Read my blog post to find out more.
keywords: Front Matter Support, Journal Entries, Content Gap Analysis, Program, Parse File, Reconstruct, Compare, Python Script, Reverse Order, Live Code, Jekyll Post-Format, New File, Journal_, Jupyter Notebook, Meta Descriptions, Subheadings, Tags, Pros and Cons, Deliverable, Agencies
categories: jupyter, deliverable, meta descriptions
permalink: /blog/planning-on-adding-front-matter-support-to-journal-entries/
layout: post
group: blog
---


Another epic day. Slammed out that Content Gap Analysis based on downloading
Keyword Explorer data from MOZ for a subdomain. It worked out great. I still
have the Excel file-formatting to do to turn it into a "canned" deliverable.
It's a deliverable-making deliverable for agencies, based on an easy-to-use
Notebook. The browser automation bit needs to be smoothed a bit.

And because it burns through MOZ Quota APIs, it's both a great way to upsell.
My "comped" account is just the $99/mo level. There's also a $179/mo level, a
$299/mo level, and a $599/mo level. It's clear to me why now. If I can
popularize these killer canned SEO-deliverables, I could help create demand for
the higher tier plans.

But right now I get to turn my attention back to my blogging tech for a bit. I
need to rewrite the OpenAI GPT-4 generated text, especially of my Meta
descriptions. It often gets it "almost right", and I have to do some
hand-editing. I'd like to do it directly in DB Browser for SQLite, a wonderful
piece of graphical database client software, but I saved everything as a
"blob". That's Binary Large Object. It's easy to do that by accident by just
saving exactly what whatever data an API returned to you. It's a great way of
avoiding encoding issues. But it's not so easy to edit in-location.

Another alternative is to maybe migrate all the data into the actual journal.md
file that gets sliced & diced to reduce the overall amount of tools and
processes I need to use. I just keep editing the journal.md file as usual and
as I go, the OpenAI-generated text gets edited into the file into the right
locations. Then I can edit it there and it always preferentially uses what's in
journal.md over what's in the database, and I can think of OpenAI's text as
just the first round of suggestions.

My fear is that such a project is a rabbit hole. It's about 6:00 PM now and if
I start this, I see it likely going late into the night and burning me. I don't
want that. I want to get to bed early and get a good night's sleep. So think it
through and see if there isn't a light-touch solution.

Okay, if I do this I don't want permalink to be there. I need to keep titles as
permalinks for now. There needs to be something to zero in on as the primary
key of the database and a slugified title is the best thing I can think of. If
permalinks come from that, I shouldn't create a permalink field unless I'm
ready for a deep rabbit hole.

But meta description, subheading, and tags are all things I want to be able to
edit in-place and don't have complex issues, except maybe not being able to
line-wrap them. It will certainly compel me to keep them short, haha! And I'll
toggle the wrap display in vim on and off a lot, no problem. Not a show
stopper.

Okay, so if I do this it needs to be profoundly easy to parse. It should look
like normal front-matter, and in all regards be valid yaml.

It also brings up whether the existing headline and date system should be
changed so that it's all just front-matter. Why have 2 systems?

Now that I've formatted a sample and looked at it that way, I see of course it
should be the standard convention. It already is!

    --------------------- 80 -->
    date: 2023-04-19
    headline:
    ---

...and the filled-in after OpenAI has its way...

    --------------------- 80 -->
    date: 2023-04-19
    headline:
    subtitle:
    description:
    tags:
    ---

There's a few field names I'll have to change in the system, namely adding
fields for date and headline instead of parsing hashtags.

I'll also change headline to subtitle. The sqlite database names should reflect
that as well. There's a lot of little touches. I don't know if I'm quite up for
it, but I can certainly take the first tiny steps. This has a huge potential
payoff. A lot of little parallel projects are converging into what I'm hoping I
can turn into a perfect storm of productivity and creative awesome.

Okay, deep breath. Think packaging again. This is part of skite. But skite
should now be chopchop. But that's a distraction. Just make the Jupyter
Notebook's home directory ~/repos/skite. That way I always know where to look
for it, and I'll use full paths to whatever files it's working on, like
/home/ubuntu/repos/hide/MikeLev.in/journal.md. That's actually where we start
out. I'm going to life chopchop.py's parsing logic to literally chop and
reconstruct the journal.md file. I'll compare to make sure source and
designation are identical, even though it's been disintegrated and
reintegrated. And that's a good starting point. Journal.md transporter, coming
up!

```python
DATADIR = "/home/ubuntu/repos/hide/MikeLev.in/"
JOURNAL = "journal.md"
FULL_FILE = f"{DATADIR}{JOURNAL}"

with open(FULL_FILE) as fh:
    for line in fh:
        print(line)
        raise SystemExit()
```

We build this up step-by-step starting in a Jupyter Notebook. If it's super
exciting and no rabbit holes, I will surgically transpose it into chopchop.py.

Next we just step through the posts. I notice some of the excessive reuse of
the `post` and `posts` variables. No wonder I was getting those flake8
warnings. I'll fix that.

```python
import re

DATADIR = "/home/ubuntu/repos/hide/MikeLev.in/"
JOURNAL = "journal.md"
FULL_PATH = f"{DATADIR}{JOURNAL}"

def parse_journal(full_path):
    with open(full_path, "r") as fh:
        print(f"Reading {full_path}")
        post_str = fh.read()
        pattern = r"-{78,82}\s*\n"
        posts = re.split(pattern, post_str)
        numer_of_posts = len(posts)
        # fig(f"{numer_of_posts} posts")
        posts.reverse()  # Reverse so article indexes don't change.
        for post in posts:
            yield "."

all_posts = parse_journal(FULL_PATH)
for apost in all_posts:
    print(apost, end="")
```

Yup. I had to remove the direction-reversal of the posts list. I reverse it in
the live code because it prevents all the Jekyll post-format date-index.md
files from receiving new content every time and bloating the repo with deltas.
It's a reverse chronological thing. If you process them from the bottom of the
file up then every post gets the same index number every time, and the changes
in the repo that git sees are minimized.

However, for this other purpose, I want to append files to the bottom of the
journal.md file. So I need to process the posts in the order they appear in
the file. Not a problem. The lesson is that I shouldn't try to combine the two
passes into one. I'll parse and step through the journal twice, once for
publishing, and once for updating it with the new OpenAI database content.
It'll always be like refilling a glass of water back up to the top after every
run. Technically, the glass is getting bigger in this case and the water is in
a sqlite database.

```python
import re
from pathlib import Path

# CONSTANTS & CONFG
DATADIR = "/home/ubuntu/repos/hide/MikeLev.in/"
JOURNAL = "journal.md"
FULL_PATH = f"{DATADIR}{JOURNAL}"
NEW_JOURNAL = f"{DATADIR}journal_new.md"
CHOPPER = (80 * "-") + "\n"

def parse_journal(full_path):
    """I am a memory-friendly generator returning oen post at a time."""
    with open(full_path, "r") as fh:
        print(f"Reading {full_path}")
        post_str = fh.read()
        pattern = r"-{78,82}\s*\n"
        posts = re.split(pattern, post_str)
        numer_of_posts = len(posts)
        # fig(f"{numer_of_posts} posts")
        # posts.reverse()  # Reverse so article indexes don't change.
        for post in posts:
            yield post


out_file = Path(NEW_JOURNAL)
if out_file.exists():
    out_file.unlink()  # delete the file

all_posts = parse_journal(FULL_PATH)
with open(NEW_JOURNAL, "a") as fh:
    for apost in all_posts:
        fh.write(CHOPPER)
        fh.write(apost)

print("Done")
```

I pretty much nailed it, except I had to prevent the CHOPPER from getting
inserted at the top of the journal. I also added a function to compare for
identical files. They came up not identical, but after stopping the extra
CHOPPER and doing a 1-time copy/paste to make the new output into the old
input, they were identical. I allowed some leeway for the old chopper size. It
could be 80 hyphens more-or-less, just in case some got added or deleted in the
course of editing the journal. But this normalization process gets them in
perfect sync.

```python
import re
from pathlib import Path

# CONSTANTS & CONFG
DATADIR = "/home/ubuntu/repos/hide/MikeLev.in/"
JOURNAL = "journal.md"
FULL_PATH = f"{DATADIR}{JOURNAL}"
NEW_PATH = f"{DATADIR}journal_new.md"
CHOPPER = (80 * "-") + "\n"

def compare_files(file1, file2):
    with open(file1, "rb") as f1, open(file2, "rb") as f2:
        while True:
            byte1 = f1.read(1)
            byte2 = f2.read(1)
            if byte1 != byte2:
                return False
            if not byte1:
                return True

def rebuild_journal(full_path):
    """I am a forward-running journal parser."""
    with open(full_path, "r") as fh:
        print(f"Reading {full_path}")
        post_str = fh.read()
        pattern = r"-{78,82}\s*\n"
        posts = re.split(pattern, post_str)
        numer_of_posts = len(posts)
        for post in posts:
            yield post


out_file = Path(NEW_PATH)
if out_file.exists():
    out_file.unlink()  # delete the file

all_posts = rebuild_journal(FULL_PATH)
with open(NEW_PATH, "a") as fh:
    for i, apost in enumerate(all_posts):
        if i:
            fh.write(CHOPPER)
        fh.write(apost)

print(compare_files(FULL_PATH, NEW_PATH))

print("Done")
```

Output:

    Reading /home/ubuntu/repos/hide/MikeLev.in/journal.md
    True
    Done

So this means it's ready for me to splice in this logic so that it's
transparent to the old process. It's a "hook", such as devs say.

Okay, done. The I regenerated the site and the blog is still in place, so I
didn't haplessly break anything. That's good. Think through next steps!

Haha, with Copilot here, it's almost like having a THIRD person. I use this
journal to think out loud and bounce ideas off of myself. So that's like 2
people. Copilot adds a third and really throws off the dynamic. It won't be
long before I put toggling Copilot between on and off on a hotkey.

Now that the new reconstructed, sort of like Star Trek transported, copy of the
journal is made on every site generation, I have some really cool ways to check
if it's working, namely seeing of my latest entry is over in that new copy
under the Jekyll data directory. I'm going to stop using the underscores when
describing those directories because it throws off the markdown formatting.

Time to turn off the final-phase Github push from ChopChop and try writing in
the front-matter. I can do that without worry about the publishing process
being interfered with because the data directory doesn't get published and
that's where I'm output the new file. I see the old file swaparoo coming up to
get me editing the version with the OpenAI generated keywords and descriptions
inserted, but not just yet.

Okay, I have the front_matter_inserter() function planned, but there's still a
1-time conversion process of the journal format. The code I just wrote to
clone-transport the journal can be used for the 1-time conversion, namely
changing the old format where a hashtag led the first line of the post using a
particular date format to the new format which will be YAML-standard. A big
part of the thrust here is that now that yaml has taken over the world for this
sort of thing, to lean into its strengths.

However, there's going to be a bit of a settling-in process for me to adjust
the vim macros and such. Let's get started.

Pshwew! I've got this thing underway. I have the 1-time conversion process
working. Now I have to decide whether to pull the ripcord and replace the
actual journal.md with the new more yaml-friendly version. Once I do, I have to
update other things to allow my blog to publish again.

Here's the function:

```python
def front_matter_inserter(pre_post):
    """Conditionally insert front matter based on whether and subfields are present."""
    #Step though the text in pre_post line by line.
    #It's a stuffed string, so we'll probably have to split it on newlines.
    #The first line is always the date. If not, return full pre_post.
    #The second line is always the tile. If not, return full pre_post.
    #If the third line is an empty line, we know we need all the front matter, fetched from databases.
    #In that case, we get headlines, descriptions and topics for the slug.
    #We always know the slug because it's the title field put through a deterministic function.
    #The slug is the database key to fetch the headline, description and topics.
    #We also know the author, but that's just a configuration variable.
    #We also know the layout, but that's just a configuration variable.
    #The topics field is actually the keywords field, which we're going to use as tags as well.
    #I'm blending together the concept of categories, tags and keywords.
    #This may change later, but OpenAI chose my keywords, so I'll use the term topics as a catch-all for now.


    # We are setting up a 1-time converson.
    # After that, we'll change the behavior of this code.
    lines = pre_post.split("\n")
    new_post = []
    for i, line in enumerate(lines):
        # line = f"date: {parts}"
        # line = f"title: {parts}"
        parts = line.split()
        if i == 0 and line[0] == "#":
            line = "date: " + " ".join(parts[1:])
        elif i == 1 and line[0] == "#":
            line = "title: " + " ".join(parts[1:]) + "\n---"
        new_post.append(line)
    return "\n".join(new_post)
```

And here's the part of the main program that calls it:

```python
# Delete the old temporary journal from `_data`
out_file = Path(OUTPUT2_PATH)
if out_file.exists():
    out_file.unlink()

# Rebuild the journal in `_data`
all_posts = rebuild_journal(FULL_PATH)
with open(OUTPUT2_PATH, "a") as fh:
    for i, apost in enumerate(all_posts):
        if i:
            fh.write(CHOPPER)
        apost = front_matter_inserter(apost)
        fh.write(apost)

fig("Compare files")
print(compare_files(FULL_PATH, OUTPUT2_PATH))
```

Do one more normal release tonight and sleep on it. It's a good point to be at.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/planning-on-adding-front-matter-support-to-journal-entries/">Planning on Adding Front Matter Support to Journal Entries</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/starting-a-new-blogging-system-create-a-title-field-under-date-to-release/">Starting a New Blogging System (create a title field under date to release)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/deliverable/'>Deliverable</a></h4></li>
<li><h4><a href='/meta-descriptions/'>Meta Descriptions</a></h4></li></ul>