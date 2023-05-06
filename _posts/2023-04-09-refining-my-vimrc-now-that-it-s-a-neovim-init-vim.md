---
date: 2023-04-09
title: Refining my .vimrc now that it's a NeoVim init.vim
headline: "Exploring NeoVim and Vim: Refining my init.vim File"
description: I just updated my init.vim with some new plugins and options, making it compatible with both NeoVim and Vim. I'm testing out a macro that returns the entire path and name of the file, and I'm creating a new file called chopchop.py to replace the old skite repo. Come check out my blog post to learn more about my experience with NeoVim and Vim!
keywords: NeoVim, Vim, init.vim, plugins, options, macro, path, name, file, chopchop.py, skite repo, syntax highlighting, cursor shape, spellfile, highlight groups, key bindings, @q macro, argument, path, parse
categories: vim, neovim, macro
permalink: /blog/refining-my-vimrc-now-that-it-s-a-neovim-init-vim/
layout: post
---


Wow, I basically re-wrote by journal to blog slice & dice system in a day,
layering in OpenAI description-writing. However, all the descriptions are now
actually in an external file and not actually right here in the journal. There's
a bunch of other little changes. List them and see if you can clean up this
journal a bit for perhaps preparing it for general public use.

The difference between markdown h1's (single #) and h2's (double ##) has gone
away, so I went and replaced all the h2's with h1's. Okay, so I also have to
update my @j macro. Done.

This is my original .vimrc which I'm going to try to improve a bit with ChatGPT
and Copilot's help:

```vim
"  _       _ _         _
" (_)_ __ (_) |___   _(_)_ __ ___
" | | '_ \| | __\ \ / / | '_ ` _ \
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
" What was once .vimrc is now init.vim.
" It's time to fix my macros. And update Slice & Dice.

syntax on
syntax enable
autocmd BufEnter * :syntax sync fromstart
autocmd BufRead,BufNewFile *.md set syntax=on spell tw=79

" These change the cursor between a block and I-beam
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set tabstop=2
set shiftwidth=2
set background=dark
set backspace=indent,eol,start
set belloff=all
set clipboard+=unnamed
set encoding=utf8
set expandtab
set foldlevel=0
set hlsearch
set ignorecase
set incsearch
set mat=5
set noerrorbells
set nopaste
set nowrap
set number
set relativenumber
set ruler
set spellfile=~/repos/vim/en.utf-8.add
set t_Co=256
set textwidth=0
set wildmenu
set winheight=15
hi SpellBad ctermbg=008
hi LineNr ctermfg=grey
hi Visual ctermbg=green
hi Visual ctermfg=black
hi Cursor ctermbg=green
hi Cursor ctermfg=black

"MACRO DEFINITIONS

"Fill-in missing headlines in blog.
let @h = 'gg/^-\+$\n# [A-Za-z0-9 ,:]*$\n\n^Mz^Mjo### '

"Fill-in missing category tagging in blog.
let @t = 'gg/^-\+$\n## [A-Za-z0-9 ,:]*$\n### .*$\n\n^Mz^Mjjocategory:  ^[l'

"Turn image filename into markdown.
let @i = '0v$hyi![^[<80>ýa$a](^[<80>ýa$pa)^[<80>ýa0llv/\.^M:s/\%V\<./\u&/g^M0llv/\.^M:s/\%V\-/ /g^M0/\.^Mv/]h<80>kb^Mhdlli/assets/images/^[<80>ýa0'

"release currently edited blog.
let @p = ":execute '!clear;python ~/repos/skite/skite.py -f ~/repos/hide/journal/sites.csv -x ' . expand('%:p:h') . '; read -p \"press enter to continue...\"'"

"Test new blog release system
let @q = ":execute '!python ~/repos/skite/dice.py -f ' . expand('%:p:h')"

"Make new journal entry.
let @j = '/Beginningx of Journal^Mo^M^M^M^M^M^[kkkk80i-^[j! date +"\%a \%b \%d, \%Y"^Mi# ^[0ji^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^M^[kkkkkkkkkkkkkkkkkkkkkkzzi'

"Format poem (requires visual block selection +2 lines)
let @o = ':<80>PS%norm i> ^[A<br />^[[201~<80>kb<80>kb<80>kb<80>kb<80>kb<80>kb<80>kb<80>kb<80>kb<80>kb<80>kb<80>kbi>n<80>kb ^V^[A<br />^M0lli<cite>&#151;Mike Levin, 2022</cite>^[<80>ýa0j'

"Strip out excess line returns in blog.
let @r = ':%s/\(^\n$\)\+/\r^M'

"Replace misspelling before cursor with recommended.
let @s = '[s1z=e'

"Expand YouTube videoID to markdown for embed.
let @y = '^[0V:s/https:\/\/.*\///gcc^M0v$hdi{% include youtubePlayer.html id="^[pa" %}^[<80>ýa'

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <F2> :set spell! <CR>
noremap <F3> :set relativenumber! <CR> :set number! <CR>
noremap <F4> :source ~/.config/nvim/init.vim <CR>
nnoremap <C-SPACE> :bn<CR>

let g:copilot_enable_for_filetypes = ['markdown']
let g:copilot_filetypes = { 'markdown': v:true }
```

I just asked ChatGPT to optimize my init.vim and here's what I wrote:

```vim
" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
call plug#end()

" Options
set tabstop=2
set shiftwidth=2
set expandtab
set number relativenumber
set hlsearch incsearch
set ignorecase smartcase
set t_Co=256
set spellfile=~/repos/vim/en.utf-8.add
set textwidth=79
set clipboard+=unnamed
set background=dark
set backspace=indent,eol,start
set belloff=all
set noerrorbells
set nowrap
set foldlevel=0
set wildmenu
set winheight=15
set laststatus=2
set signcolumn=yes
set undofile
set undodir=~/.vim/undo
set autowriteall

" Mappings
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <F2> :set spell!<CR>
nnoremap <F3> :set relativenumber! <bar> :set number!<CR>
nnoremap <F4> :source ~/.config/nvim/init.vim <CR>
nnoremap <C-SPACE> :bn<CR>

" Colorscheme
if exists('+termguicolors')
  set termguicolors
endif
if has('nvim')
  hi Normal ctermbg=none guibg=none
  hi LineNr ctermfg=grey
  hi SpellBad ctermbg=008
  hi Visual ctermbg=green
  hi Visual ctermfg=black
```

I'm preserving it here in the journal, but it suggested plugins and stuff.
That's odd because I don't really use plugins.

**Mike Levin:** Don't add plugins that I'm not using and also keep it compatible with vim's .vimrc.

**ChatGPT:** Understood! Here's an optimized version of the init.vim file that should work with both NeoVim and Vim:

```vim
" Enable syntax highlighting
syntax enable

" Sync syntax highlighting when entering a buffer
autocmd BufEnter * :syntax sync fromstart

" Set markdown settings
autocmd FileType markdown setlocal spell tw=79

" Set cursor shape
if exists('&termguicolors')
  " If termguicolors is enabled, use a block cursor
  let &t_SI = "\<Esc>[1 q"
  let &t_EI = "\<Esc>[5 q"
else
  " Otherwise, use an I-beam cursor
  let &t_SI = "\<Esc>[6 q"
  let &t_EI = "\<Esc>[2 q"
endif

" Set options
set tabstop=2
set shiftwidth=2
set background=dark
set backspace=indent,eol,start
set belloff=all
set clipboard+=unnamed
set encoding=utf8
set expandtab
set foldlevel=0
set hlsearch
set ignorecase
set incsearch
set mat=5
set noerrorbells
set nopaste
set nowrap
set number
set relativenumber
set ruler
set t_Co=256
set textwidth=0
set wildmenu
set winheight=15

" Set spellfile location
set spellfile=~/repos/vim/en.utf-8.add

" Set highlight groups
highlight SpellBad ctermbg=008
highlight LineNr ctermfg=grey
highlight Visual ctermbg=green
highlight Visual ctermfg=black
highlight Cursor ctermbg=green
highlight Cursor ctermfg=black

" Map key bindings
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <F2> :set spell! <CR>
noremap <F3> :set relativenumber! <CR> :set number! <CR>
noremap <F4> :source ~/.config/nvim/init.vim <CR>
nnoremap <C-SPACE> :bn<CR>

" Define macros
let @h = 'gg/^-\+$\n# [A-Za-z0-9 ,:]*$\n\n^Mz^Mjo### '
let @t = 'gg/^-\+$\n## [A-Za-z0-9 ,:]*$\n### .*$\n\n^Mz^Mjjocategory:  ^[l'
let @i = '0v$hyi![^[<80>ýa$a](^[<80>ýa$pa)^[<80>ýa0llv/\.^M:s/\%V\<./\u&/g^M0llv/\.^M:s/\%V\-/ /g^M0/\.^Mv/]h<80>kb^Mhdlli/assets/images/^[<80>ýa0'
let @p = ":execute '!clear;python ~/repos/skite/skite.py -f ~/repos/hide/journal/sites.csv -x ' . expand('%:p:h') . '; read -p \"press enter to continue...\"'"
let @q = ":execute '!python ~/repos/skite/dice.py -f ' . expand('%:p:h')"
let @j = '/Beginningx of Journal^Mo^M^M^M^M^M^[kkkk80i-^[j! date +"\%a \%b \%d, \%Y
```

I don't like this process. There's too much nuance and special codes in .vimrc's and init.vim's.

Okay, I got Copilot to be on for markdown but off for text with this:

```vim
let g:copilot_enable_for_filetypes = ['markdown']
let g:copilot_disable_for_filetypes = ['text']
let g:copilot_filetypes = { 'markdown': v:true, 'text': v:false }
```

Wow, this is really tricky. I just got textwidth to work correctly. I had to
take out the default textwidth=0. Keep on eye on that when I'm editing other
types of files like json. I have more control over this stuff now so I can
refine it better and with more confidence over time.

The most important thing now is updating the macro that renders out the blog
with the static site generator. That's the @p macro. But I'm testing on the @q
macro right now. I'm going to get rid of some hard wiring by changing the macro
to this which returns the entire path and the name of the file you're editing:

```vim
"Test new blog release system
let @q = ":execute '!python ~/repos/skite/parseme.py -f ' . expand('%:p')"
```

The program that shows the output is currently:

```python
aparser = argparse.ArgumentParser()
add_arg = aparser.add_argument
add_arg("-f", "--file", required=True)
args = aparser.parse_args()
file = args.file
print(f"File is {file}")
```

I just noticed that NeoVim doesn't require you to turn off numbers or
relativenumbers when you're copying and pasting. That's a nice feature. I
didn't think that was the sort of thing I'd get switching from vim to NeoVim.
They did polish a few things.

Okay, think! Now we have to wrap these learnings into the new chopchop.py file.
I like chopchop much better than skite. As I clean this whole thing up, I'll
rename the name of the repo to chopchop and set it up properly in the DrinkMe
script for use. I also want to get rid of the old dumbquotes repo.

Hmmm. We probably won't need any arguments aside from that whole path.
Everything gets parsed out of it. There's never a case where I have to chop
path parts into smaller bits and send them as individual arguments. Only the
blog folder name needs to remain because you don't know what has to be used in
the permalink.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/recruiting-chatgpt-s-help-advocating-lpvg-toolset/">Recruiting ChatGPT's Help Advocating LPvg Toolset</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/let-me-show-you-how-to-get-how-to-get-to-wonderland/">Let Me Show You How to Get, How to Get to Wonderland</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/neovim/'>NeoVim</a></h4></li>
<li><h4><a href='/macro/'>Macro</a></h4></li></ul>