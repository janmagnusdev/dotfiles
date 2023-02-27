local keymap = vim.keymap

-- Leader
vim.g.mapleader = ","
vim.g.maplocalleader = "ä"

---------------------
-- General Keymaps
---------------------

-- Use jj to exit insert mode
keymap.set("i", "jj", "<ESC>")

-- Fast editing of the init.lua
keymap.set("n", "<leader>ve", ":edit $MYVIMRC<CR>")
keymap.set("n", "<leader>vs", ":source $MYVIMRC<CR>")

-- Window management
-----------------------
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
keymap.set("n", "<leader>st", ":split<CR>:resize 10<CR>:term<CR>") -- split 10-row terminal

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current gab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

keymap.set("n", "<leader>co", ":copen<CR>") -- open quickfix window
keymap.set("n", "<leader>cc", ":cclose<CR>") -- close quickfix window
keymap.set("n", "<leader>lo", ":lopen<CR>") -- open location list
keymap.set("n", "<leader>lc", ":lclose<CR>") -- close quickfix window

-- UI toggles
----------------

-- Toggle line numbers
keymap.set("n", "<leader>nn", ":setlocal number! relativenumber!<CR>")

-- Toggle wrap
keymap.set("n", "<leader>w", ":set wrap!<CR>")

-- Searching and moving around
--------------------------------

-- Clear search highlights
keymap.set("n", "<leader><Space>", ":nohlsearch<CR>", { silent = true })
-- keymap.set("n", "<leader>nh", ":nohlsearch<CR>", {silent=true})
-- I'd use a function for this but Vim clobbers the last search when you're in
-- a function so fuck it, practicality beats purity.
keymap.set(
   "n",
   "*",
   ":let stay_star_view = winsaveview()<CR>*:call winrestview(stay_star_view)<CR>",
   { silent = true }
)

-- , is my leader, but ö/Ö are unused
keymap.set("n", "ö", ";", { noremap = true })
keymap.set("n", "Ö", ",", { noremap = true })

-- ` for jumping to a mark does not work well on German keyboards
keymap.set("n", "ü", "`", { noremap = true })

-- Keep search matches in the middle of the window.
keymap.set("n", "n", "nzzzv", { noremap = true })
keymap.set("n", "N", "Nzzzv", { noremap = true })

-- Same when jumping around
keymap.set("n", "g;", "g;zz", { noremap = true })
keymap.set("n", "g,", "g,zz", { noremap = true })
keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true })

-- gi already moves to "last place you exited insert mode", so we'll map gI to
-- something similar: move to last change
keymap.set("n", "gI", "`.", { noremap = true })

-- Editing
-------------

-- Make Y behave like D (instead Y is the same as yy), fix this:
keymap.set("n", "Y", "y$")

-- Swap q and @ for macros, because q is easier to type on German keyboards
keymap.set("n", "q", "@", { noremap = true })
keymap.set("n", "@", "q", { noremap = true })

-- Join an entire paragraph.
keymap.set("n", "<leader>J", "mzvipJ`z", { noremap = true })

-- Split line (sister to [J]oin lines)
-- The normal use of S is covered by cc, so don't worry about shadowing it.
keymap.set("n", "S", "i<CR><ESC>")

-- Re-hardwrap paragraphs of text
keymap.set("n", "<leader>q", "gqip")
keymap.set("v", "<leader>q", "gq")

-- Keep visual selection when indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Easier linewise reselection of what you just pasted.
keymap.set("n", "<leader>V", "`[V`]")

-- -- increment/decrement numbers
-- keymap.set("n", "<leader>+", "<C-a>") -- increment
-- keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- "Uppercase word" mapping by Steve Losh
--
-- This mapping allows you to press <c-u> in insert mode to convert the current
-- word to uppercase.  It's handy when you're writing names of constants and
-- don't want to use Capslock.
--
-- To use it you type the name of the constant in lowercase.  While your
-- cursor is at the end of the word, press <c-u> to uppercase it, and then
-- continue happily on your way.
--
-- It works by exiting out of insert mode, recording the current cursor location
-- in the z mark, using gUiw to uppercase inside the current word, moving back
-- to the z mark, and entering insert mode again.
keymap.set("i", "<C-u>", "<ESC>mzgUiw`za")

-- Folding
-------------

-- Use space to toggle folds
keymap.set("n", "<Space>", "za")
keymap.set("v", "<Space>", "za")

-- Make zO recursively open whatever fold we're in, even if it's partially open.
keymap.set("n", "zO", "zczO", { noremap = true })

-- "Focus" the current line.  Basically:
-- 1. Close all folds.
-- 2. Open just the folds containing the current line.
-- 3. Move the line to a little bit (15 lines) above the center of the screen.
keymap.set("n", "<C-z>", "mzzMzvzz15<c-e>`z")

-- Term
----------
-- Make Escape work in the Neovim terminal.
keymap.set("t", "<ESC>", "<C-\\><C-n>")
-- Map C-n C-n to Escape for console apps that use this key
keymap.set("t", "<C-n><C-n>", "<ESC>")
-- Map Shift+Space to Space as I hit this combo by accident a lot ...
keymap.set("t", "<S-Space>", "<Space>")

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
-- keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>") -- toggle file explorer, show current file

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>ft", "<cmd>Telescope filetypes<cr>") -- list available filetypes tags

-- -- telescope git commands (not on youtube nvim video)
-- keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
-- keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
-- keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
-- keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]
--
-- -- restart lsp server (not on youtube nvim video)
-- keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
