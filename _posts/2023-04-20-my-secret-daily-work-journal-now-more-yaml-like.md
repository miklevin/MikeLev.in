---
date: 2023-04-20
title: My Secret Daily Work Journal now More YAML-like
headline: "Unveiling My Secret Daily Work Journal: Now with YAML-like Structure!"
description: I've created a new journaling format that uses YAML-like front-matter and a few transformations. I just hit a button, but the 1-page journal.md where I edit all my blog posts at once gets sliced & diced into individual Jekyll-style posts, gets AI suggested headline, meta description and keywords, then rolls it all back into journal.md for further editing, revision and refinement. Come see how!
keywords: Journaling, YAML-like, Parsing, Post-by-Post, Line-by-Line, Date, Title, URL Slug, Front-Matter, 3-Hyphens, Output File, Input File, Comparison Function, Testing, Publishing
categories: journaling, publishing
permalink: /blog/my-secret-daily-work-journal-now-more-yaml-like/
layout: post
---


My new yamlesque journaling format does 2 rounds of parsing. The first is
post-by-post based on parsing the approximately 80 character hyphen lines that
separate the posts. The second is parsing each post line-by-line. So it's post
by post then line by line of each post. I need to keep that in mind because I'm
about to do the front-matter handling beyond date and title.

Dare and title have fixed positions in the per-post yaml-like front-matter. I
do this because there needs to be a date as part of the filename in the Jekyll
post directories. I've learned you can simulate the blogging system with Jekyll
collections without having this requirement, but I'm leaning into the strengths
of platforms when I can, and so we use Jekyll's convention, and dates are
required, and so whenever you make a new blog post, that's the minimum
required. Yet, the post still doesn't get published until a title is given.

This is because the title gets use for so many things, per your typical
blogging software, it becomes the URL slug, the title of the page and the main
headline of the article. This helps keeps things consistent and predictable.
It's also not bad for SEO, or at least it used to be. I'm keeping an open mind
to changing this with some sort of slug or permalink field in the yaml-like
header of each post. However I'm not going to do that right now.

The importance of thinking through the parsing steps here is to have it very
clear in my mind that this is a 2nd-order parsing step. The first-order parsing
is kept completely intact. It appears in 2 places: parse_journal() and
rebuild_journal(). Every time something is done to the original journal.md
file, it gets momentarily out of sync with the rebuilt journal, but then after
the site is built, they get in sync again after new front-matter is created as
part of rebuilding the journal, which is then copied back into location as the
original journal. Or at least, it will be. That's today's plan.

It's also interesting to note that parse_journal() and rebuild_journal() are
both actually Python generators, which work a lot like factory classes, though
no one will call them that in the Python world. It's a factory class because
you have to build a generator as an object, and then you call an instance of
that object to get the generator. It follows the creation pattern of a factory
class because the API of a generator is so specific. Create a handle to
something much bigger, and then call it to get the next thing in the sequence.
It's a great method to handle data-sources of potentially infinite size, as the
whole thing is never really loaded in memory. It "yields" a post a time from
the larger document.

It is during that per-page yielding that line-by-line parsing of the page
(post, article, journal entry or what have you) that we handle the
front-matter. There's a strongly deterministic single-path way to do this for
the first 2 fields. And in fact if there's only 1 field filled-in which is
always a possibility because that's how we keep things in draft mode (by not
giving it a title right away), then we return the post as-is, and move on to
the next post. There is never a title but no date because the date gets filled
in with a vim macro to establish the new post. And if not, it also just moves
on and skips it. That's the case normally for the top of the journal above the
first post, and the bottom of the journal below the last post.

These 2 locations, the top and bottom of the journal, have special handling and
lots of potential uses. They're easy to get to in vim, because of the `gg` and
`G` commands. The top of the journal is also of course always first shown when
you load journal.md, so it's a great place for some branding and maybe a very
quick to-do list. A to-do list at the top can't be too long or it will get in
the way of the first post. You want it to look like a blogging/journaling
system when you load the file. The very bottom of the journal with a shift-G is
a great place for longer to-do lists because it's normally out of the way, but
still very easy to get to.

Okay, so on that per-post basis, we look at the first 2 fields for very
particular things, and on the 3rd line, we look for various possible
conditions. It may be:

- a blank line, which would be a mistake and we need to know more
- a line that is exactly the 3-hyphens which closes the front-matter
- another yaml-like field, and usually ones in a predictable order

I don't want to rely on that predictable order. I want the yaml-like fields in
the front matter to be able to be in any order. So finding a field basically
means throw it into something that will be a dictionary, and then we can write
then in the desired consistent order when we rebuild the journal.

So the flow looks something like:

- Parse the first 2 fields predictably.
- Pay special attention to the 3rd line.
  - If it's a blank line, then keep parsing top-matter.
  - If any field is found, then keep parsing top-matter.
  - If any non-empty line is found that is not a field, then stop parsing
    top-matter. This can stand in place of finding the closing 3-hyphens.

Thinking through the 3rd line may be very close to the logic for all the rest
of the potential top-matter lines until we're in-content. There's a concept of
flipping to "in-content" mode, and that's when we're no longer parsing the
top-matter. Things get easier then because every subsequent line is handled
just the same.

All the parsing work happens in write_post_to_file() which handles each yielded
post from the aforementioned generators. It's awesome. It's a pattern I haven't
encountered before Python and while it takes a bit to wrap your head around,
it's clearly the right way to do this. The journal itself can grow to unlimited
size and it only adds to the processing time. The per-post function handler
doesn't have to know anything about it. But I need to remind myself of this.

The write_post_to_file() function is also the longest function I have in the
system. I have to be careful. We turn DISABLE_GIT to True so that I can't make
any mistakes that unpublishes my blog. There's a step that deletes everything
in the posts directory, and then rebuilds it. If I delete without a rebuilt and
then do the git thing, it has the effect of unpublishing the journal and
producing a ton of 404 errors. So that's an important dev-mode toggle.

The whole chopchop.py file has become too large to show the whole thing every
time, which is my inclination to keep full context all the time. But here's the
portion of the code I wrote as a result of this thought-work. An interesting
thing is that the thought-work trickles from here in this journal to the
comments in the code.

I won't keep all the comments, but this is the code-writing style that Copilot
works well with, because you describe to it what you're trying to do as you
step into doing it. You just might get a big, wonderful code suggestion that's
better than what you might have written yourself, and thus you really learn
something right at the perfect moment when you're open and suggestible to it.

For example, I would never think to use the .endswith() method on a string to
check for the colon at the end of a yaml-like field. I lean towards slices and
negative one indexes such as foo[-1] to get the last character of a string. But
this way is more explicit. It's a good thing to learn.

```python
# The duty past here is to continue parsing top matter
# until we hit the "---" front-matter end-parsing marker.
# If it's a blank line, it's ambiguous, but we want it to
# be able to end the top-matter if the "---" is missing.
# The first behavior split is whether we're in_content or not:
if in_content:
    # We're in the content, so just add the line
    content.append(line)
else:
    # We're in the top matter, so add the line
    # and check for the end of the top matter.
    # Each top-matter line is expected to be a yaml-like line.
    # If it's not a yaml-like line, there's 2 possibilities:
    # 1. It's a blank line, which means keep parsing top matter because a field might come next.
    # 2. It's a line of content, which means we're done with top matter.
    if line:
        # Check if it's a yaml-like line. ":" in line isn't good enough
        # because a sentence might use a colon. Instead, check for a colon at the end of the first word.
        if line.split(" ")[0].endswith(":"):
            # It's a yaml-like line, so add it to the top matter
            top_matter.append(line)
        else:
            # It's not a yaml-like line, so we're done with top matter
            top_matter.append("---")
            in_content = True
            content.append(line)
    else:
        # Blank line, keep parsing top matter
        top_matter.append(line)
```

The system should continue to work as it did, and this change should be
transparent. Re-processing my blog and all the output files being produced
the same is my goal...

Oops, writing too many "---"'s, so here's the updated code. I've take out most
of the comments for compactness.

```python
if in_content:
      # We're in the content, so just add the line
      content.append(line)
  else:
      if line:
          if line.split(" ")[0].endswith(":"):
              top_matter.append(line)
          elif line == "---":
              # It's the end of the top matter, so we're done with top matter
              in_content = True
          else:
              top_matter.append("---")
              in_content = True
              content.append(line)
      else:
          # Blank line, keep parsing top matter
          top_matter.append(line)
```

And that did it. At first I thought the file_compare() function didn't need to
stay in the code past that 1-time transformation of the old journal format to
the new, but now that I'm doing changes whose success is measured by the
output file not changing, I'm actually glad I have it. And on that note, I just
put this console output in the code:

```python
# Compare the input and output files. If same, there's been no changes.
fig("Compare files")
files_are_same = compare_files(FULL_PATH, OUTPUT2_PATH)
print(f"Are the input and output files the same? {files_are_same}")
if files_are_same:
    print("Nothing to publish.")
elif not files_are_same and DISABLE_GIT:
    print("Something's getting published, but not to Github.")
if not files_are_same and not DISABLE_GIT:
    print("Something's getting published."
```

Okay, it's all still working and still "transparent" to the process. This is
good. Now for the big step of writing back into the journal file. This is going
very well. You have to lean into the strengths of your tools. Testing.

Fast-forward quite a bit, and my code is working. I'm writing in the new
yamlesque format, and it's looking and working well. Check the Jekyll posts...
Wow, it looks great. Okay allow the git push to occur. Give this a title. Pull
the ripcord.



## Categories

<ul>
<li><h4><a href='/journaling/'>Journaling</a></h4></li>
<li><h4><a href='/publishing/'>Publishing</a></h4></li></ul>