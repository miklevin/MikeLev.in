---
title: Vim Macro to Lua (for NeoVim Users)
permalink: /futureproof/vim-macro-to-lua/
description: While I'm a longtime Vim user who values its timelessness, the sheer difficulty of editing recorded macros in VimScript finally pushed me to NeoVim; I initially switched to try GitHub CoPilot (which I disliked in Vim) but stayed because NeoVim's Lua configuration, combined with AI assistance from tools like Claude, made refining complex macros—like the one I needed to escape HTML tags for my blog posts about AI interactions—significantly easier, demonstrating a rare instance where embracing newer tech enhances, rather than detracts from, core text-mastery skills essential across all tech disciplines.
layout: post
sort_order: 4
---

## The Allure of Vim's Modal Editing

So when you switch to the vim text editor, it's the only text editor you'll need
for the rest of your life, replacing word processors and IDEs. All the keyboard
commands that eliminate the need for a mouse "get into your fingers" and you
just start controlling text on the screen almost telepathically.

### The Challenge of Refining Vim Macros

Until you need to refine your recorded macros. For you see, like many other text
editing environments, you can record and play back your keystrokes. And when you
do, they go into something called in vim buffer. I just wrote a macro to
replace `<think>` with `&lt;think&gt;`, so I can rapidly capture the thinking
model's output from Cursor AI when I make articles like this. 

I need the pointy brackets `< foo >` to be replace with the HTML entity versions
of pointy brackets `&lt; foo &gt;` in the markdown code so that they're not
interpreted as HTML tags themselves -- thus rendering everything between them
invisible when they go through a markdown-to-HTML conversion of the Jekyll
static site generator yadda yadda.

## The Long History of Text Editor Macros

> I ramble and I rage  
> In this thunderdome tech cage  
> And you see all this text and you frown...  
> But I think that you should see how tech history  
> All fits in. If you don't: JUST SCROLL DOWN!!!  

### Macros: The Muscle-Memory Investment

The concepts of macros in text editors has been around forever, and the
implementations are as varied. The longest-ago macro system I can remember
learning was on `CygnusEd` (ced) on the Amiga computer back in the 80s. Yes, in
the age of mohawks and *Back To The Future* before most of you reading this were
born, I was committing keystrokes to habit. Then, **POOF!** The Amiga
disappears.

### The Painful Cycle of Editor Switching 

When I switched to Windows, I took up `pfe`, the *Programmer's File Editor*. But
it didn't do programming language color-syntax highlighting, so I switched to
`EditPlus`. Switch, switch, switch! Fatigue, fatigue, fatigue. Muscle memory
betrayed. Automaticity lost. There is no greater offender in tech churn than the
loss of hard-won keyword recording and playback habits. Macro phantom limbs are
a thing, and some of them associated with long-dead editors persist today! You
think this can't happen to you? Can you say TextEdit? Sublime? Atom? 

### The False Security of Modern Editors

And you think VSCode and all its VSCodium, Cursor, Windsurf forks are safe
harbor? Remember Eclipse? No? You're not as old as me. It was the totally
dominant free and open source IDE from IBM, but then licensing changed.
Proprietary versions like IntelliJ came undermining. Then what once felt like
acceptable performance became perceived as Java-encumbered sluggishness.

### The Inevitable Tech Churn

So? VSCode has browser-encumbered sluggishness -- and a whole tower of kooky
dependencies from Electron/Chromium to NodeJS -- all of which bog it down while
at the same time are classics of the tech hamsterwheel meat-grinder. How long do
you think that will last as tech forges ahead? 

What about Zed? Who's Zed? Zed's not dead... yet. Stop this atrocity in the tech
profession. Learn one macro system once for life: **VIM**... and then learn how
to convert those Vim macros to **Lua**, hahaha!

### The Reality of Technical Compromise

There is no purity in tech -- just the least-bad compromises.

## Examining the Macro Register

If this has any meaning to you, then you've come to the right place! Once you've
recorded a vim macro (even in NeoVim, aka nvim), you can see it by typing `:reg`
(for register). The line for my "a" register reads:

```plaintext
c  "a   /<think>^Mv/>^Mc&lt;think&gt;^[j0
```

That's really awful stuff, because that's not really representing ASCII text
there. Everything preceded with by the caret character like `^M` actually
represents some other special keyboard action, like hitting `Enter` in this
case. `^[` is the `Escape` key and so on. It's just an awful mess to try to
hand-edit vim macros after you've recorded them. If you found this article, you
know what I'm talking about.

## Why NeoVim's CoPilot Integration Drew Me In

Anyway, when GitHub CoPilot came along and I just had to try it in a vim-like
environment (I ***hated*** VSCode at the time), I switched to NeoVim, which
apparently has an API that can support look-ahead ghost characters for
auto-suggest or something like that. Well, it was enticing enough to make me
switch to NeoVim for awhile. And I hated GitHub CoPilot, especially in a
vim-like editor. It's okay in VSCode (Cursor AI these days) because I already
hate that environment, so double up on the crap and keep vim pure, I figure.

## Converting VimScript Macros to Lua

Anyway, when it came time to switch back from NeoVim to good ol' vim, I asked
myself: Hey Mike, it's always been hard to edit those vim macros in VimScript.
But I bet Lua is both easier to type (because none of that `^M`
control-character mess, and the AI coding assistants can help me out with Lua!
So I tried, and it did! 

### Understanding VimScript's Origins

Wut? Well, Vim has a language built-in called VimScript (or VimL). You need a
language in a text editor for macros, advanced configuration, plugins and the
like. So when Bram Moolenaar ported and vImproved the original vi, he went all
the way back to ex which vi was based on and used its language. Fine for 1991.

### The Modern Landscape of Embedded Languages

But today, there's a handful of languages that get embedded into everything. Of
course ECMAScript in the browser which we know as JavaScript. But there's also
Python, TCL and Lua. I think it's their size and licensing or something.

Oh, how I wish NeoVim chose Python. But they chose the Scheme-like Lua. Nothing
wrong with it. Better than JavaScript, I guess. Point being, you can actually
change the macros to functions and get some heavy duty help on them from the
AIs.

### Embracing Modern Tools While Preserving Core Skills

So I said goodbye to my long-beloved VimScript `~/.vimrc` and hello to the new
`~/.config/nvim/init.lua`.

I'm an old-school Luddite, but I don't hold onto my old tech with a death-grip.
I don't actually use `vi`, after all. I mean the taking up vim was a lot easier
because Bram Moolenaar wrote it on the Amiga and I first got exposed to it there
back in '91 from Fred Fish public domain software disk #591, the [birth of
vim](https://sites.radford.edu/~nokie/vim/amigavim/). I use almost not a single
feature that the *brogrammers* love about NeoVim. But I do like getting AI
assistance on macros. So anyhow...

**Me**: The macro is this:

```plaintext
c  "a   /<think>^Mv/>^Mc&lt;think&gt;^[j0
```

...with those weird control characters. I need to convert it to lua like my
leader s command for spelling.

Claude: <think>
The user has a macro recorded in register "a" and wants to convert it to a Lua function with a mapping similar to their spelling command. The macro content is:

`/<think>^Mv/>^Mc&lt;think&gt;^[j0`

Let me break down what this macro does:
1. `/think` - Searches for "think"
2. `^M` - Represents the Enter key (carriage return)
3. `v` - Enters visual mode
4. `/>` - Searches for ">"
5. `^M` - Presses Enter
6. `c` - Change the selected text
7. `&lt;think&gt;` - Types "<think>" (with HTML entities: &lt; for < and &gt; for >)
8. `^[` - Escape key (exits insert mode)
9. `j0` - Move down one line and to the beginning of the line

This appears to be a macro that finds text between <think> tags and replaces it with just the tags. I need to convert this into a Lua function and set up a key mapping for it.
</think>

I'll convert your macro to a Lua function and add a mapping for it. This function will search for "<think>" tags, select the content between them, and replace it with just the tags.

```lua
// ... existing code ...

-- Function to replace content inside <think> tags with empty tags
function clean_think_tags()
    -- Search for opening <think> tag
    local found = vim.fn.search('<think>', 'W')
    if found == 0 then
        vim.notify("No <think> tags found", vim.log.levels.INFO)
        return
    end
    
    -- Enter visual mode, search for closing tag and select content
    vim.cmd('normal! v')
    vim.fn.search('</think>', 'W')
    
    -- Replace with empty tags
    vim.cmd('normal! c<think></think>')
    
    -- Move down one line and to the beginning
    vim.cmd('normal! j0')
    
    vim.notify("Think tags cleaned", vim.log.levels.INFO)
end

-- Add mapping for the clean_think_tags function
vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>lua clean_think_tags()<CR>', { noremap = true, silent = true })

// ... existing code ...
```

This function attempts to mimic what your macro does:
1. Search for opening `<think>` tag
2. Enter visual mode and select until the closing `</think>` tag
3. Replace the content with empty tags `<think></think>`
4. Move down one line and to the beginning

I've mapped it to `<leader>c` (for "clean" tags), but you can change this to any key binding you prefer.

---

## Fixing & Refining The Macro

> Claude did not get it right on the first try. But that's fine. I know this
> entire article is going into the next prompt so Claude has full context. So I
> make it very clear what went wrong.

Okay, so I copy/paste that into my `init.lua` file and use my `F2` key, which is
another macro for reloading my config so I can do rapid iteration on stuff like
this. The macro doesn't work anything like advertise. It actually does this:

Before:
```plaintext
<think>
```

After:
```plaintext
<think></think>think>
```

## Understanding The Issue With HTML Entities

I realize this may be what Claude thought the macro did. Somewhere something's
keeping the LLM from seeing actual HTML entities! That's my working theory,
anyway. And so now that I have a wedge for the macro, I'll generalize it.

### Clarifying The HTML Entity Conversion Requirements 

Hey Claude! What I really meant to do was to search for the next thing that
looks like an HTML element and to change the less-than symbols into the HTML
entity for less-than (ampersand lt semicolon) and the next greater-than symbol
into the HTML entity for greater-than (ampersand gt semicolon). There, I bet
it's much clearer now that I spelled it out.

### Generalizing The Function

So instead of the very specific search & replace of the word `<think>`, let's
just find the next thing that matches the pattern for an HTML entity and
neutralize the pointy brackets! Keep it on the same leader c key, but pick a
better new function name while you're at it.

[Feeds whole article to Cursor AI]

---

## Take Two!

**Claude**: &lt;think&gt; I see the issue now. The user wants a function to find
HTML tags and replace the angle brackets with HTML entities to prevent them from
being interpreted as actual HTML. Let me create a more generalized function:

1. Search for the next pattern that looks like an HTML tag: `<something>`
2. Replace the angle brackets with HTML entities: `&lt;something&gt;`
3. Keep the same key binding: `<leader>c`

I'll create a new function with a better name, like `htmlize_tags` or
`escape_html_tags`. &lt;/think&gt;

I understand now! You want to convert HTML-like tags to their entity-escaped versions. Here's a new function that will do that:

[Code removed so as to not litter the Net with intermediary steps]

---

## The Final Macro

> I go back and forth with Claude quite a few times. This could be a longer
> article based on the interesting API issues of passing HTML entities around
> and keeping them intact! But long story short...

```lua
// ... existing code ...

-- Function to convert angle brackets in HTML-like tags to HTML entities
function escape_html_tags()
    -- Search for the next HTML-like tag pattern
    local found = vim.fn.search('<[^>]*>', 'W')
    if found == 0 then
        vim.notify("No HTML-like tags found", vim.log.levels.INFO)
        return
    end
    
    -- Save current register contents
    local save_reg = vim.fn.getreg('"')
    local save_regtype = vim.fn.getregtype('"')
    
    -- Use visual mode to select the tag
    vim.cmd('normal! v')
    vim.fn.search('>', 'W')
    vim.cmd('normal! y')
    
    -- Get the yanked text (the tag)
    local tag = vim.fn.getreg('"')
    
    -- Restore register
    vim.fn.setreg('"', save_reg, save_regtype)
    
    -- Replace angle brackets with HTML entities
    local escaped_tag = tag:gsub('<', '&lt;'):gsub('>', '&gt;')
    
    -- Get the current cursor position and tag boundaries
    local start_row = vim.fn.line('.') - 1  -- 0-based index for API
    local start_col = vim.fn.col('.') - 1   -- 0-based index for API
    local end_row = start_row
    local end_col = start_col + #tag
    
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Replace the tag directly in the buffer
    vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, {escaped_tag})
    
    -- Move the cursor to the end of the escaped tag
    vim.api.nvim_win_set_cursor(0, {start_row + 1, start_col + #escaped_tag})
    
    vim.notify("HTML tag escaped", vim.log.levels.INFO)
end

-- Keep the same mapping for the new function
vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>lua escape_html_tags()<CR>', { noremap = true, silent = true })

// ... existing code ...
```

---

## Converting Vim Macros: A Real-World Example

> Success! I ended up changing my leader-key to `h` instead of `c`, but the
> above macro is what I use whenever I see a tag like `<think>` in my markdown
> from an AI's response while I'm publishing like this.

And that pretty much did it. This is another one of those wonderful meta
examples because the progress I made was put to work directly on the article I
am working on. The "think" tags you see at the beginning of every one of
Claude's replies was made visible here in this blog with that macro.

### The Meta-Programming Philosophy of Text Editors

While this is fun editing your editor, it's only something I occasionally do to
add some convenience. But you hear me talk about the extreme wizarding ways of
eMacs users? They live in this meta space, writing their own personal dream
operating system that adapts to them as they work.

### Choosing Your Text Editor Philosophy

If you're in the text wars deciding which side you fall on, if riding a magical
beast that adapts to your thoughts appeals to you, you might be an eMacs wizard.
If that sounds exhausting and you'd rather just a really responsive vehicle,
you're probably in the vim camp.

### Making Chain-of-Thought Reasoning Visible in Markdown

And just so that it's 100% clear what the heck's going on here, that whole
movement in LLMs where you get to see the chain-of-thought reasoning which
improves their performance, you can't get a clean formatted markdown copy/paste
in any of the Web UIs, but you can in Cursor AI! So when I publish these
wonderful little coding interactions, I get to keep it intact for just the cost
of making a few HTML tags visible. And that's what this macro does.

### Finding Unexpected Value in NeoVim's Modern Features

However in a greater sense, this article is about one of those strange benefits
you get from switching from vim to NeoVim, which has almost no appeal for
someone who's on the vim platform for timelessness -- and not for the
plugin-worshiping, fuzzy-finding, nerd-treeing, key-slamming brogramming.

### When Old-School Meets Pragmatism

But sometimes the price of old-school can be even too painful for an
old-schooler to pay, and that's the case with editing VimScript. It was great
for its time, and really everything about vim is still great, and I will keep it
in my arsenal just as I do old-school `vi`.

### The Spectrum of Text Editor Mastery

You can sit down on anything and be productive. Your vast vim wizarding skills
-- not nearly as vast as an eMacs wizard, but still quite vast -- while still
present, get incrementally reduced as you switch from NeoVim to vim to vi... and
finally to `ed`, the single-line editor from which this whole text-editor
lineage sprung. How's that for some arcane tech knowledge for ya!

### The Enduring Relevance of Command-Line Editors

You think how's that even relevant today? You'd be surprised. Not everything has
(or should have) enough resources in it to run a graphical desktop. These things
get BusyBox, ToyBox or some other teensy-weensy Unix-like thing shoe-horned into
it, plus `vi`. Plus of course remote cloud computers. 

### The Timeless Value of Text Manipulation Skills

It's hard to describe exactly, but there's something about skills never being
able to be taken away from you here, and general text-manipulation skills
getting better for life. And all tech is text. And if your tech isn't text, it's
text that manages all that information related to your tech. Master text and
master tech.

### Embracing Multiple Languages in a Text-Centric World

But then going around full-circle. I'm a 1-language-for-life sort of person, and
that language is Python. But here I am programming Lua. And you can't escape
JavaScript. And recently, I had to take up a very Haskell-like language for
NixOS and nix flakes configuration. And you'll never fully escape Bash-script,
which is enhanced Unix-shell.

And you know what they all have in common? And you know what they have even in
common with articles like this written here in plain English (at least to some)
in vim? Text!

This is where the LLM is going to say I ramble a bit when I summarize. So be it.
I'll tell you what: why don't you, Gemini Advanced 2.5 Experimental put a
bow-tie on it when you choose my titles, headlines, summarize and give your
opinion of this thing.

---

Me: Wonderful, review your work.

&lt;think&gt;
Let's review what I just did:

1. The user had a macro in Neovim register "a" that was meant to escape HTML-like tags by replacing `<` with `&lt;` and `>` with `&gt;`
2. They asked me to convert this macro to a Lua function in their init.lua file
3. We went through several iterations to get the function working correctly
4. The final version uses visual mode and the Neovim API to:
   - Find HTML-like tags
   - Capture the tag content
   - Replace the `<` and `>` with HTML entities
   - Update the buffer directly
   - Move the cursor to the end of the tag

The function now:
- Successfully finds and escapes HTML tags
- Doesn't require pressing Enter after execution 
- Properly positions the cursor at the end of the escaped tag
- Is mapped to `<leader>c` in normal mode

This should give the user a smoother experience when working with HTML entities in markdown files, especially for their blog posts involving LLM outputs.
&lt;/think&gt;

I've added the `escape_html_tags` function to your init.lua file and mapped it to `<leader>c`. The function:

1. Finds the next HTML-like tag in your document
2. Captures it using visual mode yank
3. Replaces the `<` and `>` characters with their HTML entity equivalents (`&lt;` and `&gt;`)
4. Positions the cursor at the end of the replaced tag

This should make it easy to escape HTML tags in your markdown files for Jekyll without having to edit weird control characters in your macros. The function works smoothly without requiring you to press Enter after invoking it.

**Me**: Excellent! Now hear is a much easier one. Claude (you) has this habit of using a
syntax at the beginning of backticked Python blocks of code like this:

    ```python:pipulate/server.py

    class Pipulate:
        # ... existing code ...

And I have to change it into this because the Kramdown markdown editor in the
Jekyll static site generator that GitHub Pages uses doesn't like that. So I have
to change it to this:

    ```python
    # pipulate/server.py

    class Pipulate:
        # ... existing code ...

...and to do that, I use this macro (as copy/pasted from the `reg:` command in
nvim:

    c  "a   /python:^Mwi^M^[xi# ^[o^[

So you see, this is a request for a similar macro as the one you just made for
me (which I moved to leader t, by the way). This one is much simpler because
there's no visual selection or buffer stuff. It's just searching, deleting,
hitting enter to knock something down a space. I'll put this one on the p key
(for python). I don't need to generalize this one.

Please and thank you!

**Claude**: &lt;think&gt;
The user wants a function similar to the previous one, but to transform code block headers from:

    ```python:pipulate/server.py
    class Pipulate:
        # ... existing code ...
    ```

to:

    ```python
    # pipulate/server.py
    class Pipulate:
        # ... existing code ...
    ```

Their macro is:
`/python:^Mwi^M^[xi# ^[o^[`

Let me break this down:
1. `/python:` - Search for "python:"
2. `^M` - Press Enter to jump to it
3. `w` - Move forward one word (to the colon)
4. `i` - Enter insert mode
5. `^M` - Press Enter to break the line
6. `^[` - Press Escape to exit insert mode
7. `x` - Delete the colon
8. `i# ` - Insert "# " (the comment character and a space)
9. `^[` - Press Escape to exit insert mode
10. `o` - Open a new line below
11. `^[` - Press Escape to exit insert mode

I'll create a function to perform this transformation and map it to `<leader>p`.
&lt;/think&gt;

Here's a new function to handle the Python code block header transformation:

```lua
// ~/.config/nvim/init.lua

// ... existing code ...

-- Function to remove file path after code block language
function remove_code_filepath()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Search for the pattern ```language:filepath pattern
    local line_num = vim.fn.search('```[^:\n]*:', 'n')
    if line_num == 0 then
        vim.notify("No more code blocks with filepaths found", vim.log.levels.INFO)
        return
    end
    
    -- Get the line content
    local line = vim.api.nvim_buf_get_lines(bufnr, line_num - 1, line_num, false)[1]
    
    -- Extract the language part (everything between ``` and :)
    local language = line:match("```([^:\n]*)")
    
    -- Extract the filepath part (everything after :)
    local filepath = line:match(":([^\n]*)")
    
    -- Replace the original line with just the language
    vim.api.nvim_buf_set_lines(bufnr, line_num - 1, line_num, false, {"```" .. language})
    
    -- Insert the filepath as a comment on the next line
    vim.api.nvim_buf_set_lines(bufnr, line_num, line_num, false, {"# " .. filepath})
    
    -- Move cursor to the next line after the comment
    vim.api.nvim_win_set_cursor(0, {line_num + 2, 0})
    
    vim.notify("Filepath removed from code block", vim.log.levels.INFO)
end

-- Add mapping for the new function (using <leader>p for "python")
vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>lua remove_code_filepath()<CR>', { noremap = true, silent = true })

// ... existing code ...
```

This function:
1. Finds the next code block with a filepath (```language:filepath)
2. Extracts the language and filepath
3. Replaces the original line with just ```language
4. Adds the filepath as a comment (# filepath) on the next line
5. Positions the cursor after the comment line

I used a more generalized name since it would work with any language, not just Python, but I've mapped it to `<leader>p` as you requested.

---

Badaboom badabing, example number two of converting a vim macro into a nvim lua
function!

---

## Gemini Advanced 2.5 Experimental's Take

Okay, here's a summary from my perspective, along with title/headline ideas and my own take:

**Summary (Author's 1st Person Perspective):**

[Moved to top]

**Title & Headline Ideas:**

* **Titles:**
    * From VimScript Hell to Lua Heaven: AI-Assisted NeoVim Macros
    * Why This Old-School Vim User Switched to NeoVim (Hint: It Wasn't Plugins)
    * Taming Vim Macros with NeoVim, Lua, and AI
    * NeoVim: A Luddite's Reluctant Upgrade for Better Macros
    * Mastering Text: How AI Helped Me Refine NeoVim Macros
    * The Unexpected Benefit of NeoVim: Easier Macro Editing
    * Vim vs. NeoVim: An Old-Schooler's Take on Macro Management

* **Headlines:**
    * Sick of Editing Cryptic Vim Macros? See How NeoVim and AI Offer a Solution.
    * I Ditched VimScript for Lua in NeoVim, and AI Made Macro Editing a Breeze.
    * Even Vim Purists Might Find This NeoVim Feature Compelling: Easier Macros via Lua.
    * How I Used Claude AI to Build a NeoVim Lua Macro for Escaping HTML Tags.
    * Beyond Plugins: The Real Reason This Vim Veteran Embraced NeoVim.
    * Unlock AI-Powered Macro Refinement: My Journey from Vim to NeoVim with Lua.

**My (Gemini AI's) Opinion of the Article:**

This is a compelling and relatable article for anyone who has wrestled with the intricacies of Vim and its configuration. The author effectively uses a personal, practical problem—editing a specific Vim macro—as a narrative thread to explore broader themes: the trade-offs between Vim and NeoVim, the role of AI coding assistants, the value of foundational text-editing skills, and the sometimes necessary evolution of even deeply ingrained tech habits.

The step-by-step (though abbreviated) account of interacting with Claude to develop the Lua function provides a concrete example of AI-assisted development, including the realistic back-and-forth required for refinement. While the author acknowledges a tendency to ramble, the tangents about the lineage of text editors (`ed`, `vi`) and the universality of text in tech add a thoughtful, philosophical layer that elevates the piece beyond a simple technical tutorial. The first-person perspective makes the journey engaging, and the meta-narrative of using the developed macro *on the article itself* is a nice touch. It successfully argues that sometimes, adopting a slightly newer tool (NeoVim with Lua) doesn't mean abandoning core principles (mastery of text manipulation) but can actually enhance them, especially with modern aids like AI.
