---
date: 2023-04-01
title: "NeoVim's :execute Command Doesn't Even Show Output In NeoVim of ^M's"
headline: Debating Whether to Refactor my Blogging System or Use Another Keyboard Shortcut from NeoVim
description: "As a blogger, I'm debating whether to refactor my blogging system or to just use another keyboard shortcut from NeoVim. I asked Bing how to execute shell commands from NeoVim and found out that the :execute command doesn't even show output. Bing suggested using the `:terminal` command, mapping it to a keyboard shortcut, or using `vim.api.nvim_command` to execute a command. After realizing that this means my old macros look a little messed up"
keywords: "NeoVim, execute, command, output, refactor, blogging system, keyboard shortcut, :terminal, :execute, :terminal, `vim.api.nvim_command`, macros, Vim-compatible, crappy output"
categories: macros, neovim
permalink: /blog/neovim-s-execute-command-doesn-t-even-show-output-in-neovim-of-m-s/
layout: post
---


I'm going to clean up my blogging slice & dice system a bit. I am tempted to
re-write it just to modernize it. But don't. Do an 80/20-rule approach. Very
light touch.

Hmmm, I'm not sure if just cleaning it up is the best idea anymore. I could
probably run another system side-by-side. Just use another keyboard shortcut
from NeoVim. Go in baby-steps and reassert your control over the whole process.

Interesting case of chasing the rabbit vs. taking a much more light touch.

This is the keyboard macro for the existing blog system:

let @p = ":execute '!clear;python ~/repos/skite/skite.py -f ~/repos/hide/journal/sites.csv -x ' . expand('%:p:h') . '; read -p \"Press Enter to Continue...\"'^M"

Here's a much better way of slicing the one long markdown file into lots of
smaller files:

```python
file = "../hide/MikeLev.in/journal.md"

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
    with open(f'files/file_{i}.txt', 'w') as f:
        f.writelines(chunk)
```

So get a little wedge in here for a new system. Don't bite off more than you
can chew, but built it up in tiny bits.

This is a macro that executes a hello world program from the same directory as
my current blog slicer program.

    let @q = ":execute '!clear;python ~/repos/skite/hello.py'^M"

When you see ^M in the context of vim macros, it actually stands for the Enter
key. You get the control key by either recording a macro or typing directly in
insert mode by pressing Ctrl+V (if the OS doesn't intercept) and then the Enter
key.

Hmm, I just found the comment:

> ! does not have interaction in NeoVim.

...on this Reddit discussion. https://www.reddit.com/r/NeoVim/comments/tazw3r/how_to_do_read_interactive_command_output/

This is something of an issue. Hmmm. I don't want to refactor everything.

**Mike Levin:** how do you execute shell commands from NeoVim?

**Bing:** You can use `:terminal` to run interactive commands inside NeoVim¹⁴. You can change your mappings to run shell commands by using `nnoremap <f4> :terminal node %<CR>`¹. You can also use `vim.api.nvim_command(":1Tclear")` and `vim.api.nvim_command(":1T ".. cmd)` to execute a command².

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 4/1/2023

    (1) How to pass a shell command to a vim function and execute it in the .... https://vi.stackexchange.com/questions/31867/how-to-pass-a-shell-command-to-a-vim-function-and-execute-it-in-the-NeoVim-termi Accessed 4/1/2023.
    (2) terminal - How can I emulate :shell command in NeoVim? - Vi and Vim .... https://vi.stackexchange.com/questions/19705/how-can-i-emulate-shell-command-in-NeoVim Accessed 4/1/2023.
    (3) Running command line tasks in NeoVim - Jack Franklin. https://www.jackfranklin.co.uk/blog/executing-tasks-in-NeoVim/ Accessed 4/1/2023.
    (4) How to access shell or run external commands from within Vim. https://www.howtoforge.com/tutorial/how-to-access-shell-or-run-external-commands-from-within-vim/ Accessed 4/1/2023.
    (5) NeoVim - How to map a shell command in the lua nvim config? - Stack .... https://stackoverflow.com/questions/73099752/how-to-map-a-shell-command-in-the-lua-nvim-config Accessed 4/1/2023.
    (6) How to run terminal command in interactive mode from NeoVim?. https://vi.stackexchange.com/questions/29318/how-to-run-terminal-command-in-interactive-mode-from-NeoVim Accessed 4/1/2023.
    (7) Vim - how to run a command immediately when starting vim?. https://stackoverflow.com/questions/6821033/vim-how-to-run-a-command-immediately-when-starting-vim Accessed 4/1/2023.

**Mike Levin:** What about :execute '! command?

**Bing:** You can use `:terminal` to run interactive commands inside NeoVim¹⁴. You can also use `vim.api.nvim_command(":1Tclear")` and `vim.api.nvim_command(":1T ".. cmd)` to execute a command².

`:execute '! command'` is used to execute a shell command from Vim⁵. You can use it in NeoVim as well.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 4/1/2023

    (1) How to pass a shell command to a vim function and execute it in the .... https://vi.stackexchange.com/questions/31867/how-to-pass-a-shell-command-to-a-vim-function-and-execute-it-in-the-NeoVim-termi Accessed 4/1/2023.
    (2) How to run terminal command in interactive mode from NeoVim?. https://vi.stackexchange.com/questions/29318/how-to-run-terminal-command-in-interactive-mode-from-NeoVim Accessed 4/1/2023.
    (3) terminal - How can I emulate :shell command in NeoVim? - Vi and Vim .... https://vi.stackexchange.com/questions/19705/how-can-i-emulate-shell-command-in-NeoVim Accessed 4/1/2023.
    (4) Vim - how to run a command immediately when starting vim?. https://stackoverflow.com/questions/6821033/vim-how-to-run-a-command-immediately-when-starting-vim Accessed 4/1/2023.
    (5) Running command line tasks in NeoVim - Jack Franklin. https://www.jackfranklin.co.uk/blog/executing-tasks-in-NeoVim/ Accessed 4/1/2023.

**Mike Levin:** So is it safe to say that :terminal is the preferred way to run commands inside NeoVim because :execute '! command' is not interactive in NeoVim the way they are in vim?

**Bing:** Yes, that's correct. `:execute '! command'` is not interactive in NeoVim the way they are in Vim. `:terminal` is the preferred way to run commands inside NeoVim .

I hope this helps! Let me know if you have any other questions.

Also on this page: https://www.reddit.com/r/NeoVim/comments/khv172/how_to_run_python_code_with_user_input_in_NeoVim/

I found: In NeoVim :! only runs non-interactive programs. For interactive programs use :term This is one of the main differences between NeoVim and vim.

Ugh! While my old macros are working in NeoVim, they look a little messed up.
It's because of the reasons I just documented. NeoVim doesn't support
interactivity when using the :execute command (only for :terminal).

I have to think this one through. I either keep my macros vim-compatible for
the day (if ever) I go back to vim after ditching Copilot or switching
machines. Remind myself that a major reason a .vimrc is valuable is in how it
floats between different machines, and even between Windows and Linux-side on
the same machine. Living with crappy output using :execute may be the right way
to go. Do some experiments.



## Categories

<ul>
<li><h4><a href='/neovim/'>NeoVim</a></h4></li></ul>