---
date: 2023-04-02
title: Hey Diddle Diddle, Now NeoVim's My Fiddle
headline: "Exploring New Habits: 10 Years of NeoVim and the Microsoft Tax"
description: I'm setting up macros in my NeoVim text editor to turn my journal entries into web pages. After 10 years of using this text editor, I'm vlogging the process and exploring new habits. As an advocate for Linux, Python, vim, and git, I still have to pay a Microsoft tax for tools like Github Pro, Github CoPilot, and Microsoft 365. I'm currently formatting the output of a new dice.py file.
keywords: NeoVim, Text Editor, Vlogging, Linux, Python, Vim, Git, Github Pro, Github CoPilot, Microsoft 365, Philadelphia, New York City, Internet, Microsoft Independent, Old-School, Tech, Dice.py, Program
categories: text editor, neovim, python, git, linux, vim, github copilot, internet, new york city
permalink: /blog/hey-diddle-diddle-now-neovim-s-my-fiddle/
layout: post
---



So this session is about NeoVim macros and maintaining compatibility with vim
while still working in an acceptable fashion. So they may change a little, but
they'll change the same way (hopefully) between vim and NeoVim.

This is mostly about editing ~/.config/nvim/init.vim

This is now in my default vim buffers. In fact, I copied the following reminder
to myself from that file:

> It's time to fix my macros. And update Slice & Dice.

This is me setting up some macros in my text editor to turn journal entries
such as this one into web pages like...

I'm on a new text editor. It's ***almost*** exactly the same as my last text
editor but not quite. This video is me working out some problems in the macros
I use do do this text-to-website blogification.

On the YouTubes, there's lots of slick talkers and good video editors. They
have great equipment and can show a crisper self over a higher res screen. Not
me. This is the 1-screen I work on. Virtual Desktops are the rest.

~10 years. It took me about 10 years to know these "difficult" things.

But the secret is, when you really examine it, it's no more difficult than so
many other things in life. The thing is, on those other things in life, like
driving and literacy with the spoken language, the interfaces don't change on
you all the time, like they do in tech.

Tech is special because it drives away those who are not particularly quick on
the update... the opposite of multi-lingual fast learners. It's okay to learn
slow if the APIs don't change on you.

So what you're seeing here is a person of moderate skills locking in on tools
over 10+ years that basically don't change (in a good way).

This isn't a particular job. This is me just being me. I couldn't imagine not
being able to just have a text editor in life. For me, it's like driving. I
don't drive for a living. but it certainly plays a role. Same thing. Vim.

> Linux, Python, vim & git.
> They don't change much.
> Just bit by bit.
> For decades long,
> Their interfaces are the same.
> I'm not a genius.
> This poem's lame.

Here's what I'm doing... I vlog while I drive because dash cam's. It's no
different than talking, so I figure same thing here with "work" vlogging. I
have Copilot in NeoVim, and that's going to be of interest to some people out
there thinking of doing similar stuff.

The fact that what's intended for coding can be there for daily journaling, I
mean where else are you going to get that (right now) except from me?

- It's the satisfaction of craft, as in arts & crafts... and craftsmanship.
- This is actually quite difficult in tech because things change so fast.

This is me just waking up in the morning and thinking through my day. I'm
trying to form new habits, and explore some new territory.

My accent is Philadelphia, but I'm in New York City... though one of the outer
boroughs. I'm not a New Yorker. I'm a Philadelphian. I'm a Philly guy.

Anyhoo... I had the success in this video that I wanted. Now I'll just do some
cleanup work to stage things for the next step.

This is "grounding" stuff, for the very reason that it's:

- It's old school
- It's all still in use
- It allows you to get better over time
- There's almost no end to the depth of this small set of tools
- You know where to focus
- Many times, it's in your text editor
- This will help you feel the connection between language and thought
- Language itself is a tool for thinking... encoding thoughts.
  - Clarification
  - Exploration
  - Deliberation (and choice, decision-making, yadda yadda)
  - Free will

You can "get in the zone" and do your thing, effectively filtering out the
world.

The Internet is awesome... it's a network designed to allow resiliency...
re-routing communication in case of disasters. It got de-militarized and kept
the Cable and Telecom companies from making the Information Super Highway (in
other words, a cash register for them).

We got the free and open Internet (for awhile) but for anything that takes big
bandwidth, we still have to pay Information Super Highway tolls.

Tools have toll. Tolls for tools. That's the Micro$oft way. I pay. I pay for:

- ~$100/yr. Github Pro
- ~$100/yr. Github CoPilot
- ~$100/yr. Microsoft 365

I would like not to. And even with all my Linux, Python, vim & git (LPvg)
advocacy, I still can't not pay the Micro$oft tax.

So I do what I can teaching the old-school ways of tech that ***can*** make you
Microsoft independent, but why punish yourself? Yield and lean into the
strength of tools (power-tools like VSCode included), but don't become sheeple.

- Use what you want
- But know what you're doing
  - And what you're doing is sometimes allowing a vendor to "own" you.

Thinking through next steps.

- Format the output... don't just slice... dice! haha
- Bring the new dice.py into "all" program.

My new ~/repos/skite/dice.py file is in my "all" program.

```python
import argparse


aparser = argparse.ArgumentParser()
add_arg = aparser.add_argument
add_arg("-f", "--folder", required=True)
args = aparser.parse_args()

print(f"Hello World {args.folder}")
apath = args.folder
myloc = apath.split("/")[-1]
print(f"My Folder is {myloc}")
journal = "journal.md"  # Maybe get this from CLI args
file = f"/home/ubuntu/repos/hide/{myloc}/{journal}"


def split_file(filename):
    delimiter = 80 * '-'
    with open(filename) as f:
        chunk = []
        for line in f:
            chunk.append(line)
            if delimiter in line:
                yield chunk
                chunk = []
        if chunk:
            yield chunk


for i, chunk in enumerate(split_file(file)):
    with open(f'/home/ubuntu/repos/hide/{myloc}/files/file_{i}.txt', 'w') as f:
        f.writelines(chunk)

print("Done")
```


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/playing-with-bard">Playing with Bard</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/neovim-s-execute-command-doesn-t-even-show-output-in-neovim-of-m-s">NeoVim's :execute Command Doesn't Even Show Output In NeoVim of ^M's</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/text-editor/'>Text Editor</a></h4></li>
<li><h4><a href='/neovim/'>NeoVim</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/github-copilot/'>Github Copilot</a></h4></li>
<li><h4><a href='/internet/'>Internet</a></h4></li>
<li><h4><a href='/new-york-city/'>New York City</a></h4></li></ul>