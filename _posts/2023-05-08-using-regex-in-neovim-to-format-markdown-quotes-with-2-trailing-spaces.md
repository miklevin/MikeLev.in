---
date: 2023-05-08
title: Using RegEx in NeoVim to Format Markdown Quotes with 2 Trailing Spaces
headline: "My Journey with Midjourney AI: Starting Out with RegEx in NeoVim"
description: Learn how to use RegEx in NeoVim to format Markdown quotes with 2 trailing spaces. I describe the process of using Vim commands to back up my journal and the paradigm of writing and editing text with vi/vim/NeoVim. I also discuss my journey with the Midjourney AI, including the Microsoft Store installation, the paid account link, and the documentation link.
keywords: RegEx, NeoVim, Format, Markdown, Quotes, Trailing Spaces, Draft Posts, Backup, Vim, Command, Paradigm, Writing, Editing, Text, Word Processors, Text Editors, Thinking, Source, Decompose, Reconstruct, Automate, Journal, YAML, Jekyll, Lashing, Discord, Server, AI, Images, Microsoft Store, IP, Email, Login, Browser, Web UI, App, Paid Account, Documentation,
categories: jekyll, ai, vim, email, text editors, yaml
permalink: /blog/using-regex-in-neovim-to-format-markdown-quotes-with-2-trailing-spaces/
layout: post
group: blog
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

{% include youtubePlayer.html id="XfLjF34wQbA" %}

Well, as much as I don't like to rely on a Discord server for AI images, it's
shaping up to be a Midjourney image world, so it's time to start my Midjourney
journey. Already have an account from ages ago. Is it in the Microsoft Store?
Yup, okay installed. But also it forced me to verify my IP from email and
opened up a login in my browser. Guess it's like Slack in that regard. Web UI
or app, doesn't matter. Step 1 done.

If I want to go the paid account route, there's this [account link](https://www.midjourney.com/account)

More documentation is here [https://midjourney.gitbook.io/docs](https://midjourney.gitbook.io/docs)










































<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/lex-luthor-s-chewing-gum-wrapper-and-self-similarity/">Lex Luthor's Chewing Gum Wrapper and Self Similarity</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/i-never-saw-a-purple-unicorn-and-never-hope-to-see-one-take-and-reverse/">I Never Saw a Purple Unicorn And Never Hope to See One... Take and Reverse!</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/email/'>Email</a></h4></li>
<li><h4><a href='/text-editors/'>Text Editors</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li></ul>