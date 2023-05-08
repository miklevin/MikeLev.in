---
date: 2023-05-08
title: Using RegEx in NeoVim to Format Markdown Quotes with 2 Trailing Slashes
headline: I Started My Journey with Midjourney AI - Here's How I Did It!
description: "Learn how to use Regular Expressions (RegEx) in NeoVim to format Markdown quotes with two trailing slashes. Discover how to create an automatic backup of your journal in the `_data` folder, and how to use Vim commands to add, delete, and edit text. Get started with Midjourney AI with a paid account and access documentation on their Gitbook."
keywords: Regex, NeoVim, Format, Markdown, Quotes, Trailing, Slashes, Draft, Posts, Backup, Vim, Command, Paradigm, Writing, Editing, Text, Vi, Vim, NeoVim, Word, Processors, Text, Editors, Thinking, Source, Decompose, Recompose, Automate, YAML, Jekyll, Lashing, Discord, Server, AI, Images, Microsoft, Store, Verify, IP, Email
categories: vim, email, vi, draft, ai, jekyll, yaml, microsoft
permalink: /blog/using-regex-in-neovim-to-format-markdown-quotes-with-2-trailing-slashes/
layout: post
---


Oopsie. If there's more than one post in my journal awaiting keyword extraction
and the headline and meta description writing, then it will wipe out the
anything past the first (newest) one encountered when it decomposes and
recomposes source. It effectively *deletes* the draft posts. It's a good thing
I anticipated problems along these lines and create an automatic backup of the
original version of the journal in the `_data` folder every time I generate the
site, so I can easily get it back. It's just the vim command:

```vim
:badd _data/journal-prior.md # to add the file to the buffer list
:blast # to go to the last buffer
`Ctrl+f` # to page down a bunch of times
`Shift+v` # to select a bunch of lines
`yy` # to yank them
:bd # to delete the current buffer
:b1 # to go back to the first buffer
`Ctrl+f` to page down to where to insert it
`p` to paste
```

I don't think a lot of people get it, but the whole paradigm of writing and
editing text is different under vi/vim/NeoVim than it is under word processors
or even other text editors. It's a different way of thinking about text. All
that stuff I described above, I almost just did without thinking. I had to stop
and think about it to describe it and honestly just wanted to do some sort of
Vulcan mind meld to transfer the knowledge.

What I copied and pasted is this text below about starting my journey with the
Midjourney AI. I'm going to leave it here for now and not even fix this problem
right away. It's big enough to re-introduce a To-Do list to `yamlchop/chop.py`
which I eliminated yesterday in favor of this poem in that particular real
estate of the file:


> I'm building better blogging  
> To replace a bygone era  
> Where your CMS is flogging  
> You to take up something clearer,
> So you catalog your cat tails  
> In one file for the hashing  
> Using YAML for the data  
> And then Jekyll for the lashing.  


Well, as much as I don't like to rely on a Discord server for AI images, it's
shaping up to be a Midjourney image world, so it's time to start my Midjourney
journey. Already have an account from ages ago. Is it in the Microsoft Store?
Yup, okay installed. But also it forced me to verify my IP from email and
opened up a login in my browser. Guess it's like Slack in that regard. Web UI
or app, doesn't matter. Step 1 done.

If I want to go the paid account route, there's this [account link](https://www.midjourney.com/account)

More documentation is here [https://midjourney.gitbook.io/docs](https://midjourney.gitbook.io/docs)










































<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/lex-luthor-s-chewing-gum-wrapper-and-self-similarity/">Lex Luthor's Chewing Gum Wrapper and Self Similarity</a></div> &nbsp; <div class="post-nav-next"><a href=""></a></div></div>
## Categories

<ul>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/email/'>Email</a></h4></li>
<li><h4><a href='/vi/'>Vi</a></h4></li>
<li><h4><a href='/draft/'>Draft</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li></ul>