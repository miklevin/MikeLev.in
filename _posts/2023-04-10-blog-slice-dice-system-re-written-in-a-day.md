---
date: 2023-04-10
title: Blog Slice & Dice System Re-Written In a Day
headline: Re-Implementing my Blog with AI-Powered Summaries and 541 Posts
description: I've re-implemented my blog slice & dice system, replaced an old markdown file with an efficient system, renamed the skite repo to chopchop, and paid for an AI to summarize my 540 blog posts. I'm using a generator for my journal-to-blog transformation script, and I'm now ready to go with 541 posts and an OpenAI meta description on the blog's index page. Come see the new and improved blog!
keywords: "Slice & Dice System, Markdown File, Skite Repo, ChopChop, AI, 540 Blog Posts, Generator, Journal-to-Blog Transformation, OpenAI, 541 Posts, Meta Description, Jekyll's `_data` Directory, Macro, Manual Command, Short OpenAI Meta Description"
categories: macro, ai, openai
permalink: /blog/blog-slice-dice-system-re-written-in-a-day/
layout: post
---


Hmmm, interesting stuff. It was I think it was about a year ago when I first
implemented the blog slice & dice system, getting away from the forever
increasingly long single markdown file on the Web as a blog. That was certainly
the easiest "no software" (only editing a text file) way to do it. It was a
really good start and I'm glad I have those files to look at for the subtleties.

Instead of counting the number of posts by running through the generator twice,
I can just reverse the original list of posts. It's because the blog order is
reverse-chronological. So the first post is the most recent, and that means the
content of the files would always be changing and be hard on the git repo, as
if this MikeLev.in repo wasn't bloated already. But I need to control it where
I can.

Next? Next we put in the git commands from the old skite.py file. First move
the git commands over.

That turned out well. Now replace my @p macro with the new @q macro. And now
I'm working off of skite/chopchop.py instead of skite.py, slice.py and dice.py.
It's now quite a bit simplified. Nice. I think the skite repo has got to be
renamed to chopchop. that way, it will be chopchop/chopchop.py.

It's been a remarkably productive weekend when it comes to coding. I don't
remember the last time I achieved so much in so little time, although it was
the re-implementation of something I already had. But that's okay because now I
have a lot more flexibility.

I had OpenAI do 2-passes summarizing the entire journal post by post through
about 540 posts. It's a lot of text, and it cost me about $20. That's $20 of
reading and summarizing services by an AI that I paid for. Then I paid another
approximately $10 to summarize the summaries into meta descriptions because the
summaries were too big for their original intended use. So now I have 2 SQLite
databases: long-descriptions.db and descriptions.db. Though I just changed
long-descriptions.db to summaries.db.

For posterity, here's the current status of the code in the new file called
chopchop.py:

```python
import os
import re
import sys
import html
import shlex
import openai
import slugify
import datetime
import argparse
from retry import retry
from pathlib import Path
from slugify import slugify
from dateutil import parser
from subprocess import Popen, PIPE
from sqlitedict import SqliteDict as sqldict


# Define command line arguments
aparser = argparse.ArgumentParser()
add_arg = aparser.add_argument

add_arg("-f", "--full_path", required=True)
add_arg("-a", "--author", default="Mike Levin")
add_arg("-b", "--blog", default="blog")
add_arg("-o", "--output", default="_posts")

# Parse command line args as CONSTANTS
args = aparser.parse_args()
BLOG = args.blog
OUTPUT = args.output
AUTHOR = args.author
FULL_PATH = args.full_path

# Parse full path into path, repo, and file
parts = FULL_PATH.split("/")
FILE = parts[-1]
REPO = parts[-2] + "/"
PATH = "/".join(parts[:-2]) + "/"
print(f"FULL_PATH: {FULL_PATH}")
print(f"PATH: {PATH}")
print(f"REPO: {REPO}")
print(f"FILE: {FILE}")

# Define Constants
SUMMARY_LENGTH = 500
GIT_EXE = "/usr/bin/git"
OUTPUT_PATH = f"{PATH}{REPO}{OUTPUT}"
REPO_DATA = f"{PATH}{REPO}_data/"
print(f"Processing {FULL_PATH}")

# Create output path if it doesn't exist
Path(OUTPUT_PATH).mkdir(parents=True, exist_ok=True)
Path(REPO_DATA).mkdir(parents=True, exist_ok=True)

# Delete old files in output path
for f in os.listdir(OUTPUT_PATH):
    delete_me = f"{OUTPUT_PATH}/{f}"
    os.remove(delete_me)

# Get OpenAI API key
with open("/home/ubuntu/repos/skite/openai.txt") as fh:
    openai.api_key = fh.readline()


def neutralize_html(string):
    return html.escape(string)


def parse_journal(FULL_PATH):
    """Parse a journal file into posts. Returns a generator of posts."""
    with open(FULL_PATH, "r") as fh:
        print(f"Reading {FULL_PATH}")
        post_str = fh.read()
        pattern = r"-{78,82}\s*\n"
        posts = re.split(pattern, post_str)
        posts.reverse()  # Reverse so article indexes don't change.
        for post in posts:
            yield post


def write_post_to_file(post, index):
    """Write a post to a file. Returns a markdown link to the post."""
    lines = post.strip().split("\n")

    # Set up per-post variables
    date_str, slug = None, None
    top_matter = ["---"]
    content = []
    in_content = False

    for i, line in enumerate(lines):
        if i == 0:
            # First line is always the date stamp.
            filename_date = None
            try:
                adate = line[2:]
                date_str = parser.parse(adate).date()
                top_matter.append(f"date: {date_str}")
            except:
                # If we can't parse the date, skip the post
                print(f"Skipping post {index} - no date")
                return

        elif i == 1:
            # Second line is always the title for headline & url
            if line and line[0] == "#" and " " in line:
                title = " ".join(line.split(" ")[1:])
            else:
                return
            # Turn title into slug for permalink
            slug = slugify(title.replace("'", ""))
            top_matter.append(f"title: {title}")
            top_matter.append(f"slug: {slug}")
            top_matter.append(f"permalink: /{BLOG}/{slug}/")
        else:
            # Subsequent lines are either top matter or content
            if not line:
                # Blank line means we're done with top matter
                in_content = True
                pass
            if in_content:
                content.append(line)
            else:
                # Top matter
                pass
    file_name = f"{date_str}-post-{index:04}.md"
    full_path = f"{OUTPUT_PATH}/{file_name}"

    # Hit OpenAI to get summary and keywords
    summary = None
    with sqldict(REPO_DATA + "summaries.db") as db:
        if slug not in db:
            summary = summarize(post)
            db[slug] = summary
            db.commit()
        else:
            summary = db[slug]
    with sqldict(REPO_DATA + "descriptions.db") as db:
        if slug not in db:
            meta_description = write_meta(summary)
            db[slug] = meta_description
            db.commit()
        else:
            meta_description = db[slug]
    meta_description = scrub_excerpt(meta_description)
    top_matter.append(f"description: {meta_description}")
    top_matter.append(f"layout: post")
    top_matter.append(f"author: {AUTHOR}")
    top_matter.append("---")
    top_matter.extend(content)
    content = top_matter

    # Write to file
    print(index, full_path)
    with open(full_path, "w") as f:
        flat_content = "\n".join(content)
        f.writelines(flat_content)

    us_date = date_str.strftime("%m/%d/%Y")

    # link = f"- [{title}](/{BLOG}/{slug}/) ({us_date})<br/>\n  {meta_description}"
    link = f'<li><a href="/{BLOG}/{slug}/">{title}</a> ({us_date})<br />{meta_description}</li>'
    return link


def scrub_excerpt(text):
    """Clean up a text for use as an excerpt."""
    # Strip numbered markdown lists from text
    text = re.sub(r"\d+\.\s", "", text)
    # Strip asterisk or hyphen markdown lists from text
    text = re.sub(r"[\*\-]\s", "", text)
    # Replace double quotes with single quotes
    text.replace('"', "'")
    # Flatten wrapped lines
    text = " ".join(text.split("\n"))
    # If a period doesn't have a space after it, add one
    text = re.sub(r"\.(\w)", r". \1", text)
    return text


def trunc(text):
    """Truncate a string to a given length, but not in the middle of a word."""
    if len(text) <= SUMMARY_LENGTH:
        return text
    else:
        return text[: SUMMARY_LENGTH - 1].rsplit(" ", 1)[0] + "..."
    return text


def chunk_text(text, chunk_size=4000):
    """Split a text into chunks of a given size."""
    chunks = []
    start_idx = 0
    while start_idx < len(text):
        end_idx = start_idx + chunk_size
        if end_idx >= len(text):
            end_idx = len(text)
        chunk = text[start_idx:end_idx]
        chunks.append(chunk)
        start_idx = end_idx
    return chunks


@retry(Exception, delay=1, backoff=2, max_delay=60)
def write_meta(data):
    """Write a meta description for a post."""
    response = openai.Completion.create(
        engine="text-davinci-002",
        prompt=(
            f"Please write a meta description for the following text:\n{data}\n\n"
            "Summary:"
        ),
        temperature=0.5,
        max_tokens=100,
        n=1,
        stop=None,
    )
    meta_description = response.choices[0].text.strip()
    return meta_description


@retry(Exception, delay=1, backoff=2, max_delay=60)
def summarize(text):
    """Summarize a text using OpenAI's API."""
    chunks = chunk_text(text, chunk_size=4000)
    summarized_text = ""
    for chunk in chunks:
        response = openai.Completion.create(
            engine="text-davinci-002",
            prompt=(f"Please summarize the following text:\n{chunk}\n\n" "Summary:"),
            temperature=0.5,
            max_tokens=100,
            n=1,
            stop=None,
        )
        summary = response.choices[0].text.strip()
        summarized_text += summary
        summarized_text = " ".join(summarized_text.splitlines())
    return summarized_text.strip()


def git(cwd, line_command):
    """Run a Linux git command."""
    cmd = [GIT_EXE] + shlex.split(line_command)
    print(f"COMMAND: <<{shlex.join(cmd)}>>")
    process = Popen(
        args=cmd,
        cwd=cwd,
        stdout=PIPE,
        stderr=PIPE,
        shell=False,
        bufsize=1,
        universal_newlines=True,
    )
    flush(process.stdout)
    flush(process.stderr)


def flush(std):
    """Flush a stream."""
    for line in std:
        line = line.strip()
        if line:
            print(line)
            sys.stdout.flush()


# Parse the journal file
posts = parse_journal(FULL_PATH)
links = []
for i, post in enumerate(posts):
    link = write_post_to_file(post, i - 1)
    if link:
        links.insert(0, link)

# Add countdown ordered list to index page
links.insert(0, f'<ol start="{len(links)}" reversed>')
links.append("</ol>")
# Write index page
index_page = "\n".join(links)
with open(f"{PATH}{REPO}_includes/post-index.html", "w", encoding="utf-8") as fh:
    fh.writelines(index_page)

# Git commands
here = f"{PATH}{REPO}"
git(here, "add _posts/*")
git(here, "add _includes/*")
git(here, "add assets/images/*")
git(here, f'commit -am "Pushing {REPO} to Github..."')
git(here, "push")
```

It's actually quite a bit longer than skite.py now but it's way more easy to
read and modify. Switching from the old approach to using a generator was a
good move. It can work on journal markdown files of any size. It also provides
an excellent technique of adding front matter to a markdown file.

Whenever a new article is written (like this), I run the script and OpenAI will
write a summary and meta description for it. The OpenAI data is kept not in
this journal file but rather in separate files in Jekyll's \_data directory.
What an ideal location for that kind of stuff. I can so extend that
methodology. chopchop.py will remain dedicated to the journal-to-blog
transformation, but I ought to start thinking about a new script that will do
that command plus more, such as Instapaper and Twitter pages.

I also need to compare the command that I've been doing manually:

```bash
python ~/repos/skite/chopchop.py -f /mnt/c/Users/mikle/repos/hide/MikeLev.in/journal.md
```

...and the one that this system runs on the macro:

```bash
:execute '!python ~/repos/skite/chopchop.py -f ' . expand('%:p')
```

No better way than to test it, right?

I was at 540 published blog posts when I just ran the script. The command that
the expand thing expanded to under NeoVim when I hit Enter was:

```bash
python ~/repos/skite/chopchop.py -f /mnt/c/Users/mikle/repos/hide/MikeLev.in/journal.md
```

...which is the same as the one I've been doing manually. So I'm good to go.

Bingo! I'm up to 541 posts now and a short OpenAI meta description was used on
the blog's index page as it's description.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/let-me-show-you-how-to-get-how-to-get-to-wonderland/">Let Me Show You How to Get, How to Get to Wonderland</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/creating-github-repo-specifically-for-copilot-explorations/">Creating Github Repo Specifically For Copilot Explorations</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/macro/'>Macro</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/openai/'>OpenAI</a></h4></li></ul>