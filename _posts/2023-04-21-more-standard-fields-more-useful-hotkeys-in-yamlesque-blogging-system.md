---
date: 2023-04-21
title: More Standard Fields & More Useful Hotkeys in YAMLesque Blogging System
permalink: /blog/more-standard-fields-more-useful-hotkeys-in-yamlesque-blogging-system/
headline: Edit AI-Generated Meta Descriptions with Improved YAML Blogging System
description: "I changed the topics field to keywords in my blog posts and used a search/replace to make sure everything was up to date. To make sure my meta descriptions were accurate, I wrote a regex pattern for vim to search for lines beginning with description: and end with any character that is not sentence-ending punctuation. I created a macro to help me quickly search for and edit the AI-generated meta descriptions. Now I can easily make sure my blog posts have the best meta descriptions possible."
keywords: YAMLesque, Blogging System, Topics Field, Keywords, Meta Descriptions, Regex Pattern, Vim, Macro, AI-generated, Wrapped Text Mode, NeoVim
categories: macro, keywords, neovim, vim
layout: post
---

Alright, let's get these category pages doing something for you. I'm producing
them now as part of the chopchop.py blogslicer process. Slice your blog, chop
chop! And when you do, spit out lots of cats. Even the language is great! Do
cats eat bats? Do bats eat cats? Well it's true that batch files produce
category pages if that's what you're asking, Alice. So let's make those
category pages a bit less nonsense.

First thing is to settle on the singular form for the category.md page and have
it use the singular form its permalink. Okay, done. Next is to lean into the
strength of the category and tag system in Jekyll. Those labels have special
significance and all the Liquid template system examples out there use these
conventions. I've used "topics" for all the keyword chosen by OpenAI, but I
think it's time for me to massage the YAML field-names into the Jekyll system
conventions. I'll switch topics to keywords...

FROM:

    ---
    date: 2023-04-20
    title: My Secret Daily Work Journal now More YAML-like
    slug: my-secret-daily-work-journal-now-more-yaml-like
    permalink: /blog/my-secret-daily-work-journal-now-more-yaml-like/
    headline: "Unveiling My Secret Daily Work Journal: Now with YAML-like Structure!"
    description: I've created a new journaling format that uses YAML-like structure and involves two
    topics: Journaling, YAML-like, Parsing, Post-by-Post, Line-by-Line, Date, Title, URL Slug, Front-
    author: Mike Levin
    layout: post
    ---

TO:

    ---
    date: 2023-04-20
    title: My Secret Daily Work Journal now More YAML-like
    slug: my-secret-daily-work-journal-now-more-yaml-like
    permalink: /blog/my-secret-daily-work-journal-now-more-yaml-like/
    headline: "Unveiling My Secret Daily Work Journal: Now with YAML-like Structure!"
    description: I've created a new journaling format that uses YAML-like structure and involves two
    keywords: Journaling, YAML-like, Parsing, Post-by-Post, Line-by-Line, Date, Title, URL Slug, Front-
    categories: [A short-list of the best stemmed selections of keywords]
    tags: [A longer, but still limited list of the best stemmed keywords]
    author: Mike Levin
    layout: post
    ---

First, I just switch the topics field to keywords.

- Change the database of OpenAI-generated keywords from topics.db to keywords.db
- Change the constant's name from TOPDB to KWDB.
- Carefully change all occurrences of topics to keywords
  - Use `:%s/topics/keywords/gc` so you can confirm every instance
  - There were 23 substitutions
- Similar search & replace with keyword_text for topic_text (only 3)

And now the radical new capability that I have. Last thing before generating
the site to make sure I didn't break anything is to make the source match the
templates. It now needs to find the keywords field in the journal.md file.

Since all the OpenAI-selected keywords have now as a result of yesterday's work
been moved from the sqlite database into each of the YAML-front-matter sections
of each post in the journal.md file, I can do a giant search/replace right in
journal.md. It's like changing a field name in a database with a search/replace
in a text file. Very powerful! Must craft the search/replace carefully! And
right here in this file I'm editing right now!

    :%s/^topics:[^\S"]/keywords: /gc

Okay, that was 566 substitutions, as expected. Looking good.

Generate the site and see what happens!

Okay, the site re-generated no problem. I've got a keywords field in the source
journal.md file from the search/replace. I've got a keywords field in the
sliced & diced output Jekyll / posts / date-index.md files. And I've got the
keywords meta tag in the view-source of the generated static HTML pages.

There's still a bunch of descriptions that are chopping off the last sentence.
Let me go search up the instances and fix them. I hear ChatGPT is good at
regex patterns, right?

Hey ChatGPT: Write a regex pattern for vim that finds lines that begin with

    description:

...and which end with any character that is not sentence-ending punctuation like a period, exclamation point or question mark.

The regex pattern for vim that finds lines beginning with "description:" and ending with any character that is not sentence-ending punctuation can be written as:

    ^description:.*[^.!?]$

Here's what this pattern means:

- `^description:` matches the beginning of the line followed by the literal string "description:"
- `.*` matches any number of characters, including zero, between "description:" and the end of the line
- `[^.!?]` matches any character that is not a period, exclamation point, or question mark
- `$` matches the end of the line

So, the combination of these three elements matches lines that begin with "description:" and end with any character that is not a period, exclamation point, or question mark.

---

Very nice! Thank you ChatGPT! It works like a charm. I'm editing those chopped
meta-descriptions now. SO MUCH EASIER than doing this sort of work in a CMS
system, don't you agree?

Shouldn't that search be a vim-macro? Yes, it should! Especially now that I
keep my .vimrc (now, init.vim) always loaded for editing along with my daily
journals, such a rapid macro creation and refinement process is possible and
desirable.

On what key? I'm looking for chopped meta descriptions. I don't use `m` yet, so
m it is. Here's the macro (LOL, I wonder of those ^M's will render):

Newsflash, no it didn't, so here it is again re-written, flattening the ^M's
(enter key) and ^[ (esc key) control codes with their string-representations.

    let @m = 'gg/^description:.*[^.!?]$^M^[:set wrap^M$A'

And now I can step through my blog posts in the big journal.md sourcefile where
I do all my all-posts-all-at-once blogging and fix the AI-generated meta
descriptions. I'll also get mure used to working in wrapped text mode in
vim/NeoVim, which is a song this hard-wrapping vimmer usually doesn't sing.

## Categories

<ul>
<li><h4><a href='/macro/'>Macro</a></h4></li>
<li><h4><a href='/keywords/'>Keywords</a></h4></li>
<li><h4><a href='/neovim/'>NeoVim</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li></ul>