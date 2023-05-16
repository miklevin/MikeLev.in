---
date: 2023-04-28
title: Lemmatizing Keywords for Site Navigation
headline: I identified a keyword usage frequency dictionary and put it back in properly to ensure my category pages were outputting with their correct articles and capitalization.
description: "I'm experimenting with lemmatization and keyword usage frequency to create consistent category pages for my website navigation. I'm ensuring the capitalization of the categories is correct and outputting them in both the website root and in `_includes`."
keywords: Windows, Git, Release, Cdict, Category, Grid, Bingo, Lemmatization, Stemming, Root, Word, Normalized, Unique, Key, Lower-Case, Consistency, Common, Proper-Case, Usage, Experiment, Default, Statistically, Frequency, Dictionary, Capitalization, Outputting, Articles, Customize, Collision, Website, Root, Includes
categories: key, microsoft, git, unique
permalink: /blog/lemmatizing-keywords-for-site-navigation/
layout: post
---


There are blank category pages like Windows. `:b chop` and turn off the Git
release step. Put the `cdict[cat]["count]` in the category grid. Bingo.
Perfect. Go ahead and release that...

Okay, so the logic to get the counts for cdict is good, but the logic in
creating the category pages has a flaw.

Hmmm, there's something called lemmatization which is a lot like word stemming,
getting the "root" stem of a word, but which produces more common words than
the funny non-word stem fragments stemming can produce. To have consistency
when I lemmatize, I convert a keyword to lower-case before the process.

If I'm using the keyword as a unique key, I also lower-case what comes out of
the lemmatizer so the keywords are fewer overall and normalized. However, we
still need to know the most common proper-case usage.

I'm doing an experiment now to see what comes out of the lemmatizer by default
with the lower-case keyword in is correct. It should be in many case, but for
things like Windows, it could go either way.

I should control that statistically based on usage, which I had done prior but
just tore out for that key consistency I just described. I actually
accidentally wiped out the frequency usage check, which if the default out of
the lemmatizer isn't good enough, I'll put back in.

Yup. All my category pages are being produced now, but I lost my most common
capitalization, so I'll put that back in.

Yup. I identified the keyword usage frequency dictionary that I had previously
implemented and tore out a short bit ago in favor of consistent lemmatization
and put it back in properly.

Wow, it's really just another case of extreme order sensitivity. We have to be
very precise about consistently lemmatizing all keywords before being used as
keys in various dictionaries so they can always join across keys.

Okay, so let's assume all my category pages are now outputting with all their
correct articles and that the category capitalization is always correct. What
next?

It's going to be time to conditionally customize category pages without
creating collision situations. The `cat_*` pages are going to be output all the
time in both website root and in `_includes`.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/chip-chop-chip-chop-top-10-done/">Chip, Chop, Chip, Chop, Top-10 Done</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/moved-1-long-page-version-of-journal-md-to-drafts/">Moved 1-long-page version of journal.md to `_drafts`</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/key/'>Keys</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/unique/'>Unique</a></h4></li></ul>