local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Use jj to exit insert mode
keymap.set("i", "jj", "<ESC>")

-- Fast editing of the init.lua
keymap.set("n", "<leader>ve", ":edit $MYVIMRC<CR>")
keymap.set("n", "<leader>vs", ":source $MYVIMRC<CR>")

-- Window management
-----------------------
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [v]ertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit [h]orizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make width/height of [s]plits [e]qual" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current [s]plit [x]" }) -- close current split window
keymap.set("n", "<leader>st", ":split<CR>:resize 10<CR>:term<CR>", { desc = " Open small h[s]plit with a [t]erminal"}) -- split 10-row terminal

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

-- Work on visual lines when 'wrap' is set and j/k are used w/o a count.
-- With a count (e.g., 3j, 5k), work on real lines (works well with 'relativenumber').
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search highlights
keymap.set("n", "<leader><Space>", ":nohlsearch<CR>", { silent = true })
keymap.set(
  { "i", "n" },
  "<esc>",
  "<cmd>noh<cr><esc>",
  { desc = "Escape and clear hlsearch", silent = true }
)
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

-- Toggle spelling and set spell language
keymap.set("n", "<leader>sp", "<cmd>setlocal spell!<cr>")
keymap.set("n", "<leader>spde", "<cmd>setlocal spell spelllang=de_de<cr>")
keymap.set("n", "<leader>spen", "<cmd>setlocal spell spelllang=en<cr>")

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
keymap.set("n", "<leader>q", "gwip")
keymap.set("v", "<leader>q", "gw")

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
-- keymap.set("n", "<Space>", "za")
-- keymap.set("v", "<Space>", "za")

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
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "[M]aximize current [s]plit" }) -- toggle split window maximization

-- nvim-tree
keymap.set("n", "-", ":NvimTreeToggleReplace<CR>") -- Show file explorer, replace current buffer
keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>") -- toggle file explorer, show current file

-- telescope
-- See https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L361-L402
-- for additional bindings
keymap.set("n", "<leader>,", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>")
keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>")
keymap.set("n", "<leader>/", "<cmd>Telescope find_in_file<cr>") -- TODO
keymap.set("n", "<leader>:", "<cmd>Telescope command_history<cr>")
keymap.set("n", "<leader>.", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>ft", "<cmd>Telescope filetypes<cr>") -- list available filetypes tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gf", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- Lsp / Lspsaga

-- Many examples/guides wrap this in an "on_attach" function for an actual LSP
-- server.  We can do this here, because
-- - we currently don't map to "vim.lsp...."
-- - we use null-ls with Gitsigns and formatters for *all* filetypes
-- These bindings also make more sense in this file.
local opts = { noremap = true, silent = true }
keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts) -- see definition and make edits in window
keymap.set("n", "<leader>ld", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
keymap.set("n", "<leader>lf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
keymap.set("n", "<leader>df", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts) -- show diagnostics for cursor
keymap.set("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
keymap.set("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
keymap.set("n", "<leader>dp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
keymap.set("n", "<leader>dn", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts) -- see outline on right hand side
keymap.set("n", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", opts) -- open a floating terminal
keymap.set("n", "<leader>fm", function()
  vim.lsp.buf.format({
    timeout_ms = 5000, -- Some formatters taker longer than 1000ms
    filter = function(lsp_client)
      --  only use null-ls for formatting instead of lsp server
      return lsp_client.name == "null-ls"
    end,
  })
end, opts)
