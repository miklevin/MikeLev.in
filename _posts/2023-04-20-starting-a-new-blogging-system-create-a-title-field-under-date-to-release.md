---
date: 2023-04-20
title: Starting a New Blogging System (create a title field under date to release)
headline: Creating a Journal Entry System with AI-Generated Content
description: I'm starting a new journal entry system with the 80-long hyphen as a blog-slicer token and place-holder for the Liquid template system. I'm using Jekyll, an open source static site generator, and a macro system to ensure reverse-chronological entries.
keywords: Journal, Entry, System, 80-long Hyphen, Blog-slicer, Token, Place-holder, Liquid, Template, Jekyll, Open Source, Static Site Generator, Macro System, Reverse-chronological, AI-generated, Content, Chopper, Strings, Date-index, Function, Update, AI
categories: static site generator, open source, jekyll, template, ai
permalink: /blog/starting-a-new-blogging-system-create-a-title-field-under-date-to-release/
layout: post
---


So starting a new journal entry is a little more yamlish than the previous
system. It uses the 80-long hyphen as a blog-slicer token. It also uses it as a
sort of place-holder for "New Page" and "Opening triple-hyphen" of the Liquid
template system that Jekyll uses for front-matter. So it's easy to imagine a
blog like this as stack-combined individual pages that happen to have enough
information to blend into the Jekyll post sub-folder blogging system.

    ----------------------------- 80 -->
    date: Thu Apr 20, 2023
    ---

First, I'll acknowledge that there are other static site generators out there,
and some are even more Pythonic than Jekyll (such as Hyde and Hugo), but you're
looking for a deep sort of timelessness to your tools. You want to use APIs
that plenty of other people like you also rely upon. Free and open source
software first, please. And if not, proprietary is okay, so long as it can also
host Linux containers like LXD for persistence.

No tech is perfect. And the only times you don't step into what the mainstream
is using is if it's an excessively faddish or short-lived technology. Tech is
full of the shiny new thing. Computers, the Internet, Mobile, Cloud, VR, and
now AI. It's helping me type this right now, hahaha! But it's also a lot of
noise. And it's a lot of noise that's not really helping you get your work

Haha, sometimes it gets it. Okay, I'll get a little more work done. Thanks for
the reminder. How does the pitch go? I like to keep a journal-file of my daily
work. It's a way to keep track of what I'm doing, and insofar as I can make the
public. I only use Copilot on the journals I make public. And now with this
super-charged help, I should be able to make it meta and use it to help me
write the meta's, right? Well, yeah mostly, but...

This becomes the basis for much work moving forward. It's the ultimate
fast-publishing systems. Get fast in vim. Have a macro system for starting a
new journal entry. Make is so that it always works reverse-chronological, just
like a blogging system. Make the system for parsing one page from the next, or
one post from the next, or one journal-entry from the next, or what have you
an 80 hyphens. That's 80 minus. It's sort of like homage to the old days of
80-column text editors. You're always reminded of the optimum width to have
usable text-editing when every byte was expensive.

The answer is 80-column, and it makes me happy to make that my parsing
character for slicing the long-form journal.md, which you are usually ediiting,
to a whole series of date-index.md files put into the posts subfolder of the
Jekyll blog publishing system. It's a data transform for 1-file to multi-files.

Now the multi-files follow a very specific format used by the Jekyll static
site generator. If you want your content to be all linked-up like a blog for
example, you need to have a date in the filename. You can add additional
information after that, so I chose just a sequential index number. It doesn't
really matter except for in the git repo, because the "permalink" field in the
front-matter will determine its URL on the site.

Want a way to start learning the vim/NeoVim text editors? Start with a daily
journal. It will take the pressure off of you from learning to code. You can
just clickity-clack away at the keyboard and get used to the motions. That's
what it's all about in vim, getting it "into your fingers".

Okay, so if you're going to have a journaling system that you keep in one long
text-file for life... well, don't get ahead of yourself. Why would you do that?
Okay, well the thinking goes like this. That's the one natural order that's
going to exist anyway. You're going to start making marks somewhere on
something and the marks that you make are going to be in a natural order.

If you capture it in a journal, then you capture it in natural order. Whoa
buddy, not so fast. Does that mean you're writing always at the bottom of a
text file like you're always writing the last page in a book? Ugh, that'd be
awful. No, you always want to be at the top of a file, pushing all the rest of
the content down. We live in the digital age after all. Just put your new
entries at the top of the file. So, every once in awhile, there's got to be a
time-travelling CHOP! That chop looks like:

```python
CHOPPER = (80 * "-") + "\n"
```

And that looooong hyphen string is the token that gets used in a Python
string.split() call to chop the file into a list of strings. Each string is
yielded from a generator into one of two functions. The first creates the
individual post pages for the Jekyll post subfolder, and a second rolls back in
any new OpenAI content into the original journal file.

Once AI-generated content exists in the original journal.md file, it only gets
updated from there, and in that way you can override the AI-written text.

Actually, I'm just in the process of testing that now.

It is my belief that this is one of the best ways to take advantage of an
initial AI-generated text. You can use it as a starting point. In some cases it
gets it right, and in other cases, you have to edit this or that. The danger
then is losing that work. You don't want such updates overwritten by the
database.

Okay, I'm very pleased at how this is going. Give this one a title and let it
publish. Then do some experimentation updating meta descriptions and such.



## Categories

<ul>
<li><h4><a href='/static-site-generator/'>Static Site Generator</a></h4></li>
<li><h4><a href='/open-source/'>Open Source</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/template/'>Template</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>