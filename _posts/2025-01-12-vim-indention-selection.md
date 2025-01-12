---
title: Vim Indention Selection (TL;DR Disappointment)
permalink: /futureproof/vim-indention-selection/
description: Need to select indented code blocks like Python functions in Vim without plugins? Sadly, there's no easy built-in way. This article explores practical workarounds using visual mode, searches, paragraph motions, and custom mappings to achieve this in vanilla Vim, NeoVim, or VSCode's Vim mode.
layout: post
sort_order: 2
---

Alright, let's get to the heart of this.  So, I was on a quest to find a simple,
plugin-free way in Vim to select entire indented blocks like Python functions or
methods. Turns out, it's a bit of a letdown. Vanilla Vim doesn't have a built-in
text object for this. You'd think it would, right? It means there is no simple
key combination or command that will automatically do this. Anyway, I dug into a
bunch of workarounds: using linewise visual mode with a search for the next
dedented line is the most reliable, although a bit clunky. 

You could also use paragraph motions if your code has consistent blank lines.
And if you're feeling adventurous, you can create custom mappings, but that's
basically writing your own mini-plugin. I even considered just moving down
line-by-line in visual mode for shorter functions. Look, if you can use plugins,
vim-indent-object is the way to go. But if you're stuck in plugin-free land,
it's a mix-and-match of these slightly awkward techniques.  It's not elegant,
but that's Vim for you.

---

## Surely o1 Pro Can Find Something I Haven't

**Me**: How do you select an indented block like a whole Python function or method in vim, nvim or VSCode/Cursor in vim mode? And not ]]. And not ]}. And not using any plugins. Indention based is fine. I say not ]] because that's a whole class. I need it to work on methods in classes. And I say not ]} because that doesn't work in Cursor in vim mode.

> Interestingly, this was one of the most fascinating o1 Pro *"details"*
> progress to watch. There were both more details, and of an almost visceral
> discovery nature as it discovered the same disappointing facts I had.

### o1 Pro Details

**Identifying Vim features**

I’m figuring out how to select indented blocks in Vim, highlighting specific text objects for indentation-based selection. The goal is to find a hassle-free way to highlight Python function texts.

**Trying another way**

I'm experimenting with cursor positioning and commands like V and % to select indented Python blocks, but the absence of curly brackets complicates this approach.

**Piecing together strategies**

I’m gathering info on macros and built-in text objects like vip for paragraph selection in Python code, considering how blank lines or docstrings might affect this approach.

**Crafting a new solution**

I'm piecing together options like search commands, code folds, and defining a custom text object with braces for selecting Python methods, while avoiding plugins as requested.

**Evaluating Vim's capabilities**

I’m thinking through Vim's built-in folding and matchit plugin for indentation-based selection. It’s curious to see if these tools might work for Python method selection.

**Testing folding techniques**

I'm thinking through various methods for manually selecting Python function texts, including fold commands and vim motions like [[ and [], and the potential usefulness of '[v'].

**Evaluating vim features**

I’m mapping out vim motions like [m and :help function-motions to think about selecting Python methods, considering options like vip for blank lines.

**Pulling together**

I'm working through manual methods like V, j, [[, and ]] to select Python functions. Options include visual mode and cursor movement.

**Evaluating options**

I’m noting the consideration of built-in text objects, manual methods, and hacks like setting foldmethod=indent to navigate Python code without plugins.

**Taking a closer look**

I’m working through various methods to select Python functions, including vip for blank lines, manual visual selections, and indentation-based navigation, while considering docstrings as potential obstacles.

**Weighing selection methods**

I'm evaluating vip for blank lines, search-based selections, and custom text objects, while carefully considering Python's lack of curly braces and potential interference from docstrings.

**Assessing custom touches**

Evaluating macros and user-defined functions. Considering search methods for top-level lines. Weighing folds and indentation-based folding. Progress is steady and thought-out.

**Evaluating folding techniques**

I’m examining folding commands and visual selections, like zv and ]], to manage and highlight Python functions effectively.

**Navigating Python functions**

I’m gathering info on vim commands like [[, ]p, and % to select Python functions. Each method offers unique advantages for navigating and managing code effectively.

**Crafting a manual method**

Navigating Python code without plugins reveals a reliance on manual methods like visual mode and search, with no built-in text object for selection. Progressing through the options thoughtfully.

**Navigating selection**

OK, let me see. I’m working through methods like placing the cursor on the first line, using V, and searching for the next non-blank line for selecting Python methods effectively.

**Charting the course**

I’m guiding through the process of using search commands to select Python functions in visual mode, emphasizing selecting the function block by moving to the next non-indented line.

**Crafting manual methods**

I’m compiling visual mode and search techniques to select Python methods, focusing on next non-indented lines and class-related patterns, as there’s no built-in method for Python function selection.

**o1 Pro**: First, the short (and somewhat frustrating) truth:

> **Vanilla Vim (and thus most Vim emulations like VSCode Vim mode) does not provide a built-in, indentation-based text object**—that is, a quick motion or text object that selects “everything at this indent level” without relying on braces/brackets or plugins.  

So if you want “press a couple keys and grab the entire indented method,” **without** using plugins like [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object), there is no single built-in motion that does this out of the box.

That said, here are some practical, no-plugin workarounds you can use in plain Vim, NeoVim, or Vim-mode in VSCode:

---

## 1. Use Linewise Visual Mode + a Search for the Next Dedent

A reliable approach for Python functions is:

1. **Go to the first line** of the function/method (the `def` line).
2. Press `V` (capital V) to start **linewise** Visual mode.
3. Search forward for the next line that has **less** (or equal) indentation than the current function. For example, if your function is indented 4 spaces inside a class, you might search for the next line starting at the same or lesser level of indentation.  

   One quick hack is to search for the next line that **starts at column zero**:
   ```vim
   /^(    \S\|\S) 
   ```
   i.e. either something at column zero `^\S` or outdented from your level. If you know your function is nested 4 spaces deep, you can incorporate those 4 spaces. Not super pretty, but it works.  

   You can also simply search for `^\S` if you’re looking for the next top-level or keep adjusting the pattern for your scenario.  

4. Once you jump to that line, press `k` (or the up arrow) once to go back inside the function. Now your selection should cover everything in between.

It’s a bit manual, but you can remember it as:

```
V        " start linewise visual
/^\S     " jump to next top-level line
k        " step back inside the block
```

If your function is nested inside a class, you’d adapt the pattern to match the class-level indentation. You can also do `n` or `N` to skip around if you overshoot.

---

## 2. Use Paragraph or Blank-Line Jumps (If Your Code Style Allows)

Sometimes you can rely on blank lines between functions/methods:

1. Go to the `def` line.
2. Press `V` for linewise visual.
3. Press `}` or `{` to jump by “paragraph.”  

This works if (and only if) your code style is consistent about leaving a blank line after each function. It’s obviously not as robust for docstrings or multiple consecutive methods.

---

## 3. Do It Manually with Motions

If the function is short or if you see exactly how many lines to go, you can:

- `V` (start linewise Visual mode)
- Move down `j j j j …` until you reach the end of the method

Yes, it’s “manual,” but in some cases it’s simpler than fiddling with search patterns.

---

## 4. Custom Mappings (Still No Plugins)

If you’re allowed to drop a snippet into your `vimrc`/`init.vim`, you can define your own “indent jump” with an `:nmap` or `:xnoremap` that essentially automates the search trick. For example:

```vim
" Example: a custom command that in Visual mode extends
" selection down until the indentation level decreases.
xnoremap <leader>i :<C-u>call SearchDedent()<CR>

function! SearchDedent() range
  " Grab the current line's indent
  let l:cur_indent = indent(line('.'))
  " Keep moving down as long as the next line's indent is >= current indent
  while (line('.') < line('$')) && indent(line('.')+1) >= l:cur_indent
    normal! j
  endwhile
endfunction
```

This is still “no plugins,” but obviously it’s writing your own miniature plugin in Vimscript…

---

## 5. Why Not Use a Plugin?

If you can bend the “no plugins” rule, [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object) (or a derivative) is by far the cleanest solution. It adds text objects like:

- `v a i` (select “all indentation block”)
- `v i i` (select “inner indentation block”)

So you could place your cursor anywhere in a Python method and do `vai` to select everything at that indent level.

But if you truly must remain plugin-free, there’s no built-in text object that does the same job.

---

## TL;DR

1. **V + manual search** is the typical fallback:  
   - `V` to start selecting from the `def` line.  
   - Search (`/^\S`) for the next less-indented line.  
   - Move back one line (`k`) if needed.  

2. Or rely on blank lines + paragraph motions (`V` then `}`).

3. Or define a small mapping in your vimrc to automate the search, still “no external plugins” but your own script.

There simply isn’t a built-in keystroke in vanilla Vim (or emulated Vim) that automatically selects “the current Python method block based on indentation” the way we wish it did.
