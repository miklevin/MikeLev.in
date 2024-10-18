-- init.lua

-- Basic Settings
local set = vim.opt

set.spell = true
set.spelllang = 'en_us'
set.spellfile = vim.fn.expand('~/.config/nvim/spell/en.utf-8.add')
set.mouse = ''
set.clipboard = 'unnamedplus'
set.textwidth = 80
set.wrap = false
set.belloff = 'all'
set.tabstop = 4
set.expandtab = true
set.shiftwidth = 4
set.softtabstop = 4
set.autoindent = true
set.smartindent = false
set.smarttab = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true
set.ignorecase = true
set.number = true
set.relativenumber = true
set.scrolloff = 5
set.wildmenu = true
set.wildmode = 'list:longest'
set.showmatch = true
set.matchtime = 2
set.matchpairs:append('<:>')
set.matchpairs:append('*:*')

-- Visual mode highlighting
vim.cmd([[hi Visual ctermbg=green ctermfg=black]])

-- Filetype Specific Settings
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "journal.txt",
    command = "set filetype=markdown"
})

-- Functions
function ollama_format()
    local save_reg = vim.fn.getreg('"')
    local save_regtype = vim.fn.getregtype('"')
    
    vim.cmd('normal! gvy')
    local selected_text = vim.fn.getreg('"')
    local result = vim.fn.system('python3 ai.py', selected_text)
    vim.api.nvim_command('normal! gvc' .. vim.fn.escape(result, '\\<>') .. '\27')
    vim.fn.setreg('"', save_reg, save_regtype)
end

function new_journal_entry()
    -- Search for the marker
    local marker = "# Beginning of Notes"
    local current_line = vim.fn.search(marker, 'nw')
    
    if current_line == 0 then
        print("Marker '# Beginning of Notes' not found.")
        return
    end

    -- Generate the new entry
    local date_cmd = "date +\"%a %b %d, %Y, %H:%M\""
    local date = vim.fn.system(date_cmd):gsub("\n", "")
    local entry = "--------------------------------------------------------------------------------\n"
                  .. "date: " .. date .. "\n---\n\n"

    -- Insert the new entry below the marker
    vim.api.nvim_buf_set_lines(0, current_line, current_line, false, vim.split(entry, "\n"))

    -- Move the cursor to the end of the inserted text
    vim.api.nvim_win_set_cursor(0, {current_line + 4, 0})

    -- Enter insert mode
    vim.cmd('startinsert')
end

function git_commit_push()
    -- Get the current buffer's file path
    local file_path = vim.fn.expand('%:p')
    
    -- Get the directory of the current file
    local dir_path = vim.fn.expand('%:p:h')
    
    -- Save the current buffer
    vim.cmd('w')
    
    -- Change to the directory of the current file
    vim.cmd('lcd ' .. dir_path)
    
    -- Get the relative path of the file within the git repository
    local relative_path = vim.fn.system('git -C ' .. vim.fn.shellescape(dir_path) .. ' ls-files --full-name ' .. vim.fn.shellescape(file_path))
    relative_path = vim.fn.trim(relative_path)
    
    -- Perform git operations
    local git_add = vim.fn.system('git add ' .. vim.fn.shellescape(relative_path))
    local git_commit = vim.fn.system('git commit -m "Update ' .. relative_path .. '"')
    local git_push = vim.fn.system('git push')
    
    -- Check for errors
    if vim.v.shell_error ~= 0 then
        vim.notify("Git operations failed:\n" .. git_add .. git_commit .. git_push, vim.log.levels.ERROR)
    else
        vim.notify("File committed and pushed successfully", vim.log.levels.INFO)
    end
    
    -- Change back to the original directory
    vim.cmd('lcd -')
end

function reload_config()
    -- Clear existing mappings
    vim.cmd('mapclear')
    vim.cmd('mapclear!')

    -- Unload the current configuration
    for name, _ in pairs(package.loaded) do
        if name:match('^user') or name:match('^plugins') then
            package.loaded[name] = nil
        end
    end

    -- Re-source the init.lua file
    vim.cmd('source ' .. vim.fn.stdpath('config') .. '/init.lua')

    -- Force re-evaluation of all autocmds
    vim.cmd('doautocmd VimEnter')

    -- Get current date and time
    local datetime = os.date("%Y-%m-%d %H:%M:%S")
    
    -- Notify with datetime
    vim.notify("Configuration reloaded at " .. datetime, vim.log.levels.INFO)
end

function correct_misspelling()
    vim.cmd('normal! [s1z=e')
end

function import_notes()
    vim.cmd('!python3 import_notes.py')
    vim.cmd('r simplenote.md')
end

function delete_notes()
    vim.cmd('!python3 permanently_delete_notes.py')
end

function toggle_line_numbers()
    vim.opt.relativenumber = not vim.opt.relativenumber._value
    vim.opt.number = not vim.opt.number._value
end

function toggle_spell_check()
    vim.opt.spell = not vim.opt.spell._value
    if vim.opt.spell._value then
        vim.notify("Spell check enabled", vim.log.levels.INFO)
    else
        vim.notify("Spell check disabled", vim.log.levels.INFO)
    end
end

function bold_dialogue_speaker()
    -- Save the current cursor position
    local start_line = vim.fn.line('.')
    local start_col = vim.fn.col('.')

    -- Search for the next line containing a valid speaker name followed by ': '
    local colon_line = vim.fn.search('^[A-Za-z0-9][A-Za-z0-9 -]*: ', 'nW')
    if colon_line == 0 then
        vim.notify("No valid dialogue found", vim.log.levels.WARN)
        return
    end

    -- Get the line content
    local line = vim.fn.getline(colon_line)
    
    -- Find the position of the colon followed by a space
    local colon_pos = string.find(line, ": ")
    if not colon_pos then
        vim.notify("Unexpected error: colon with space not found", vim.log.levels.ERROR)
        return
    end

    -- Extract the speaker part (text before the colon)
    local speaker = string.sub(line, 1, colon_pos - 1)

    -- Replace the line with the bolded version
    local new_line = "**" .. speaker .. "**" .. string.sub(line, colon_pos)
    vim.fn.setline(colon_line, new_line)

    -- Move the cursor to just after the closing asterisks and one word forward
    vim.fn.cursor(colon_line, #speaker + 4)
    vim.cmd('normal! w')

    vim.notify("Dialogue speaker bolded", vim.log.levels.INFO)
end

-- Add a mapping for the new function (e.g., <leader>b for "bold")
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>lua bold_dialogue_speaker()<CR>', { noremap = true, silent = true })

-- Traditional Function Key Mappings in Neovim:
-- F1: Help (opens Neovim's help system)
-- F2: Typically unused, available for custom mapping
-- F3: Typically unused, available for custom mapping
-- F4: Typically unused, available for custom mapping
-- F5: Typically unused, available for custom mapping
-- F6: Typically unused, available for custom mapping
-- F7: Typically unused, available for custom mapping
-- F8: Typically unused, available for custom mapping
-- F9: Typically unused, available for custom mapping
-- F10: Typically unused, available for custom mapping
-- F11: Typically unused, available for custom mapping
-- F12: Typically unused, available for custom mapping

-- Note: While F2-F12 are typically unused in default Neovim, some plugins or 
-- other configurations might use them. Always check your current setup before overwriting.

-- Mappings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- F2: Reload Neovim configuration
map('n', '<F2>', '<cmd>lua reload_config()<CR>', opts)

-- F3: Toggle spell check on/off
map('n', '<F3>', '<cmd>lua toggle_spell_check()<CR>', opts)

-- F4: Toggle line numbers on/off (both normal and relative)
map('n', '<F4>', '<cmd>lua toggle_line_numbers()<CR>', opts)

-- \j: Create a new journal entry
map('n', '<leader>j', '<cmd>lua new_journal_entry()<CR>', opts)

-- \h: Format selected text using original Ollama AI
map('v', '<leader>h', '<cmd>lua ollama_format()<CR>', opts)

-- \s: Correct misspelling before cursor
map('n', '<leader>s', '<cmd>lua correct_misspelling()<CR>', opts)

-- \g: Git commit and push changes
map('n', '<leader>g', '<cmd>lua git_commit_push()<CR>', opts)

-- \p: Import notes from SimpleNote
map('n', '<leader>p', '<cmd>lua import_notes()<CR>', opts)

-- \d: Delete notes (presumably from SimpleNote)
map('n', '<leader>d', '<cmd>lua delete_notes()<CR>', opts)

-- \t: Test mapping to confirm init.lua is loaded
map('n', '<leader>t', ':echo "Test: init.lua loaded successfully!"<CR>', { noremap = true, silent = true })

-- Print a message to confirm init.lua is loaded
print("init.lua loaded successfully!")

-- New function that works exactly like ollama_format but uses the new file location
function ollama_format_new()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get the start and end positions of the visual selection
    local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(bufnr, '<'))
    local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(bufnr, '>'))

    -- Adjust for Lua's 1-based indexing
    start_line = start_line - 1
    end_line = end_line - 1

    -- Get the selected text
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)
    local selected_text = table.concat(lines, '\n')

    -- Call the Python script
    local result = vim.fn.system('python3 /home/mike/repos/nixos/helpers/ai.py', selected_text)

    -- Split the result into lines
    local result_lines = vim.split(result, '\n')

    -- Insert the headline (first two lines) above the selection
    vim.api.nvim_buf_set_lines(bufnr, start_line, start_line, false, {result_lines[1], result_lines[2], ''})

    -- Replace the selected text with the rest of the result
    vim.api.nvim_buf_set_lines(bufnr, start_line + 3, end_line + 3, false, vim.list_slice(result_lines, 3))

    -- Move the cursor to the start of the inserted text
    vim.api.nvim_win_set_cursor(0, {start_line + 1, 0})

    -- Exit visual mode
    vim.cmd('normal! ' .. vim.api.nvim_replace_termcodes('<Esc>', true, false, true))
end

-- Add a mapping for the new function (e.g., <leader>y for "yank and process")
vim.api.nvim_set_keymap('v', '<leader>y', '<cmd>lua ollama_format_new()<CR>', { noremap = true, silent = true })

function highlight_selection()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get the start and end positions of the visual selection
    local start_line, start_col = unpack(vim.fn.getpos("'<"))
    local end_line, end_col = unpack(vim.fn.getpos("'>"))

    -- Adjust for Lua's 1-based indexing and Vim's 1-based line numbers
    start_line = start_line - 1
    end_line = end_line - 1
    start_col = start_col - 1
    end_col = end_col - 1

    -- Get the selected text
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)
    local selected_text = table.concat(lines, '\n')

    -- Print the selected text to confirm
    print("Selected text:")
    print(selected_text)

    -- Highlight the selected text
    local ns_id = vim.api.nvim_create_namespace('highlight_selection')
    vim.highlight.range(bufnr, ns_id, 'Visual', {start_line, start_col}, {end_line, end_col}, {})

    -- Schedule removal of highlight after 2 seconds
    vim.defer_fn(function()
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    end, 2000)

    -- Exit visual mode
    vim.cmd('normal! ' .. vim.api.nvim_replace_termcodes('<Esc>', true, false, true))
end

-- Add a mapping for the new function
vim.api.nvim_set_keymap('v', '<leader>y', '<cmd>lua highlight_selection()<CR>', { noremap = true, silent = true })

function highlight_current_paragraph()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get the current cursor position
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1

    -- Find the start of the paragraph
    local start_line = cursor_line
    while start_line > 0 and vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1] ~= "" do
        start_line = start_line - 1
    end

    -- Find the end of the paragraph
    local end_line = cursor_line
    local last_line = vim.api.nvim_buf_line_count(bufnr) - 1
    while end_line < last_line and vim.api.nvim_buf_get_lines(bufnr, end_line + 1, end_line + 2, false)[1] ~= "" do
        end_line = end_line + 1
    end

    -- Get the paragraph text
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)
    local paragraph_text = table.concat(lines, '\n')

    -- Print the paragraph text to confirm
    print("Selected paragraph:")
    print(paragraph_text)

    -- Highlight the paragraph
    local ns_id = vim.api.nvim_create_namespace('highlight_paragraph')
    vim.highlight.range(bufnr, ns_id, 'Visual', {start_line, 0}, {end_line, -1}, {})

    -- Schedule removal of highlight after 2 seconds
    vim.defer_fn(function()
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    end, 2000)

    vim.notify("Paragraph highlighted", vim.log.levels.INFO)
end

-- Add a mapping for the new function
vim.api.nvim_set_keymap('n', '<leader>y', '<cmd>lua highlight_current_paragraph()<CR>', { noremap = true, silent = true })

function process_current_paragraph()
    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get the current cursor position
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1

    -- Find the start of the paragraph
    local start_line = cursor_line
    while start_line > 0 and vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1] ~= "" do
        start_line = start_line - 1
    end

    -- Find the end of the paragraph
    local end_line = cursor_line
    local last_line = vim.api.nvim_buf_line_count(bufnr) - 1
    while end_line < last_line and vim.api.nvim_buf_get_lines(bufnr, end_line + 1, end_line + 2, false)[1] ~= "" do
        end_line = end_line + 1
    end

    -- Get the paragraph text
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)
    local paragraph_text = table.concat(lines, '\n')

    -- Call the Python script
    local result = vim.fn.system('python3 /home/mike/repos/nixos/helpers/ai.py', paragraph_text)

    -- Split the result into lines
    local result_lines = vim.split(result, '\n')

    -- Insert the headline (first two lines) above the paragraph
    vim.api.nvim_buf_set_lines(bufnr, start_line, start_line, false, {result_lines[1], result_lines[2], ''})

    vim.notify("AI headline inserted", vim.log.levels.INFO)
end

-- Add a mapping for the new function
vim.api.nvim_set_keymap('n', '<leader>y', '<cmd>lua process_current_paragraph()<CR>', { noremap = true, silent = true })

-- Keep the new function (renamed for clarity)
function ollama_format_paragraph()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1

    local start_line = cursor_line
    while start_line > 0 and vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1] ~= "" do
        start_line = start_line - 1
    end

    local end_line = cursor_line
    local last_line = vim.api.nvim_buf_line_count(bufnr) - 1
    while end_line < last_line and vim.api.nvim_buf_get_lines(bufnr, end_line + 1, end_line + 2, false)[1] ~= "" do
        end_line = end_line + 1
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)
    local paragraph_text = table.concat(lines, '\n')

    local result = vim.fn.system('python3 /home/mike/repos/nixos/helpers/ai.py', paragraph_text)

    -- Split the result into lines
    local result_lines = vim.split(result, '\n')

    -- Insert the headline and a blank line above the paragraph
    vim.api.nvim_buf_set_lines(bufnr, start_line, start_line, false, {result_lines[1], ''})

    vim.notify("AI headline inserted", vim.log.levels.INFO)
end

-- Update the mapping to use \h
vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua ollama_format_paragraph()<CR>', { noremap = true, silent = true })
