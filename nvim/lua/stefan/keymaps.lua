-- Cheat sheets for default key bindings:
-- - https://cdn.shopify.com/s/files/1/0165/4168/files/preview.png
-- - https://michael.peopleofhonoronly.com/vim/vim_cheat_sheet_for_programmers_screen.png
-- - https://www.rosipov.com/images/posts/vim-movement-commands-cheatsheet.png

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= false -- set default noremap=true

  vim.keymap.set(mode, lhs, rhs, opts)
end

local function dmap(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  map(mode, lhs, rhs, opts)
end

local function make_dmap(prefix)
  return function(mode, lhs, rhs, desc, opts)
    return dmap(mode, lhs, rhs, prefix .. desc, opts)
  end
end

---------------------
-- General Keymaps
---------------------
-- Make <space> a no-op, b/c it's also the leader key
map({ "n", "v" }, "<space>", "<Nop>")

-- Use jj to exit insert mode
map("i", "jj", "<ESC>")

-- Fast editing of the init.lua
map("n", "<leader>ve", ":edit $MYVIMRC<cr>")
map("n", "<leader>vs", ":source $MYVIMRC<cr>")
--
-- Clear search, diff update and redraw
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- Window management
-----------------------
-- Buffers
dmap("n", "<leader>bb", "<C-^", "[B]buffer: toggle between two buffers")
dmap("n", "<leader>bd", "<Plug>Kwbd", "[B]uffer: [d]elete (but keep split open)")
-- Windows
dmap("n", "<leader>wv", "<C-w>v", "[W]indow: split [v]ertically")
dmap("n", "<leader>wh", "<C-w>s", "[W]indow: split [h]orizontally")
dmap("n", "<leader>we", "<C-w>=", "[W]indow: make widths/heights [e]qual")
dmap("n", "<leader>wc", ":close<cr>", "[W]indow: [c]lose current")
dmap("n", "<leader>wt", ":split<cr>:resize 10<cr>:term<cr>", "[W]indow: open 10-row [t]erminal")
-- Tabs
dmap("n", "<leader>to", ":tabnew<cr>", "[Tab]: [o]pen")
dmap("n", "<leader>tc", ":tabclose<cr>", "[Tab]: [c]lose")
dmap("n", "<leader>tn", ":tabn<cr>", "[Tab]: go to [n]next") dmap("n", "<leader>tp", ":tabp<cr>", "[Tab]: go to [p]revious")
-- Quickfix / location list
dmap("n", "<leader>co", ":copen<cr>", "Quickfix: open")
dmap("n", "<leader>cc", ":cclose<cr>", "Quickfix: close")
dmap("n", "<leader>cp", vim.cmd.cprev, "Quickfix: Previous quickfix")
dmap("n", "<leader>cn", vim.cmd.cnext, "Quickfix: Next quickfix")
dmap("n", "<leader>lo", ":lopen<cr>", "Location list: open")
dmap("n", "<leader>lc", ":lclose<cr>", "Location list: close")
dmap("n", "<leader>lp", vim.cmd.lprev, "Location list: Previous location")
dmap("n", "<leader>ln", vim.cmd.lnext, "Location list: Next location")

-- UI toggles
----------------
-- Toggle line numbers
dmap("n", "<leader>nn", ":setlocal number! relativenumber!<cr>", "Toggle [n]o[n]umber")
-- Toggle wrap
dmap("n", "<leader>w", ":set wrap!<cr>", "Toggle line [w]rapping")

-- Searching and moving around
--------------------------------

-- Work on visual lines when 'wrap' is set and j/k are used w/o a count.
-- With a count (e.g., 3j, 5k), work on real lines (works well with 'relativenumber').
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search highlights
-- map("n", "<leader>nh", ":nohlsearch<cr>", {silent=true})
-- map("n", "<leader><space>", ":nohlsearch<cr>", { silent = true })
dmap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and clear hlsearch")

-- I'd use a function for this but Vim clobbers the last search when you're in
-- a function so fuck it, practicality beats purity.
map("n", "*", ":let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>", { silent = true })

-- `/' for jumping to a mark does not work well on German keyboards
map("n", "ä", "`")

-- Keep search matches in the middle of the window.
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Same when jumping around
map("n", "g;", "g;zz")
map("n", "g,", "g,zz")
map("n", "<C-o>", "<C-o>zz")

-- gi already moves to "last place you exited insert mode", so we'll map gI to
-- something similar: move to last change
map("n", "gI", "`.")

-- Editing
-------------

-- Toggle spelling and set spell language
dmap("n", "<leader>sp", "<cmd>setlocal spell!<cr>", "[Sp]elling: toggle")
dmap("n", "<leader>spde", "<cmd>setlocal spell spelllang=de_de<cr>", "[Sp]elling: enable and set lang to [de]")
dmap("n", "<leader>spen", "<cmd>setlocal spell spelllang=en<cr>", "[Sp]elling: enable and set lang to [en]")

-- Make Y behave like D (instead Y is the same as yy), fix this:
map("n", "Y", "y$")

-- Swap q and @ for macros, because q is easier to type on German keyboards
map("n", "q", "@")
map("n", "@", "q")

-- Join an entire paragraph.
dmap("n", "<leader>J", "mzvipJ`z", "[J]oin entire paragraph")

-- Split line (sister to [J]oin lines)
-- The normal use of S is covered by cc, so don't worry about shadowing it.
dmap("n", "S", "i<cr><ESC>", "[S]plit line")

-- Re-hardwrap paragraphs of text
dmap("n", "<leader>q", "gwip", "Re-hardwrap current paragraph")
dmap("v", "<leader>q", "gw", "Re-hardwrap current paragraph")

-- Keep visual selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Easier linewise reselection of what you just pasted.
dmap("n", "<leader>V", "`[V`]", "Re-select what you just pasted")

-- -- increment/decrement numbers
-- map("n", "<leader>+", "<C-a>") -- increment
-- map("n", "<leader>-", "<C-x>") -- decrement

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
dmap("i", "<C-u>", "<ESC>mzgUiw`za", "[U]ppercase current word in insert mode")

-- Folding
-------------

-- Use space to toggle folds
-- map("n", "<space>", "za")
-- map("v", "<space>", "za")

-- Make zO recursively open whatever fold we're in, even if it's partially open.
dmap("n", "zO", "zczO", "Recursively open fold we're in")

-- "Focus" the current line.  Basically:
-- 1. Close all folds.
-- 2. Open just the folds containing the current line.
-- 3. Move the line to a little bit (15 lines) above the center of the screen.
dmap("n", "<C-z>", "mzzMzvzz15<c-e>`z", "Focus current line (and fold everything else)")

-- Term
----------
-- Make Escape work in the Neovim terminal.
map("t", "<ESC>", "<C-\\><C-n>")
-- Map C-n C-n to Escape for console apps that use this key
map("t", "<C-n><C-n>", "<ESC>")
-- Map Shift+space to space as I hit this combo by accident a lot ...
map("t", "<S-space>", "<space>")

----------------------
-- Plugin Keybinds
----------------------

-- -- Lsp / Lspsaga
--
-- -- Many examples/guides wrap this in an "on_attach" function for an actual LSP
-- -- server.  We can do this here, because
-- -- - we currently don't map to "vim.lsp...."
-- -- - we use null-ls with Gitsigns and formatters for *all* filetypes
-- -- These bindings also make more sense in this file.
-- local opts = { noremap = true, silent = true }
-- map("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts) -- show documentation for what is under cursor
-- map("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts) -- see definition and make edits in window
-- map("n", "gD", "<cmd>Lspsaga goto_definition<cr>", opts) -- see definition and make edits in window
-- map("n", "<leader>ld", "<Cmd>lua vim.lsp.buf.declaration()<cr>", opts) -- got to declaration
-- map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts) -- go to implementation
-- map("n", "<leader>lf", "<cmd>Lspsaga lsp_finder<cr>", opts) -- show definition, references
-- map("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts) -- see available code actions
-- map("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts) -- smart rename
-- map("n", "<leader>df", "<cmd>Lspsaga show_buf_diagnostics<cr>", opts) -- show diagnostics for cursor
-- map("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<cr>", opts) -- show  diagnostics for line
-- map("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts) -- show diagnostics for cursor
-- map("n", "<leader>dp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts) -- jump to previous diagnostic in buffer
-- map("n", "<leader>dn", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts) -- jump to next diagnostic in buffer
-- map("n", "<leader>o", "<cmd>Lspsaga outline<cr>", opts) -- see outline on right hand side
-- map("n", "<leader>t", "<cmd>Lspsaga term_toggle<cr>", opts) -- open a floating terminal
-- map("n", "<leader>fm", function()
--   vim.lsp.buf.format({
--     timeout_ms = 5000, -- Some formatters taker longer than 1000ms
--     filter = function(lsp_client)
--       --  only use null-ls for formatting instead of lsp server
--       return lsp_client.name == "null-ls"
--     end,
--   })
-- end, opts)
