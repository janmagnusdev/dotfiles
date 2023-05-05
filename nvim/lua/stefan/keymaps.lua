-- Cheat sheets for default key bindings:
-- - https://cdn.shopify.com/s/files/1/0165/4168/files/preview.png
-- - https://michael.peopleofhonoronly.com/vim/vim_cheat_sheet_for_programmers_screen.png
-- - https://www.rosipov.com/images/posts/vim-movement-commands-cheatsheet.png

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= false -- set default noremap=true

  vim.keymap.set(mode, lhs, rhs, opts)
end

---------------------
-- General Keymaps
---------------------
-- Make <space> a no-op, b/c it's also the leader key
map({ "n", "v" }, "<space>", "<Nop>")

-- Use jj to exit insert mode
map("i", "jj", "<ESC>")

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
map("n", "<leader>bb", "<C-^>", { desc = "[B]buffer: toggle between two buffers" })
-- Windows
map("n", "<leader>wv", "<C-w>v", { desc = "[W]indow: split [v]ertically" })
map("n", "<leader>wh", "<C-w>s", { desc = "[W]indow: split [h]orizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "[W]indow: make widths/heights [e]qual" })
map("n", "<leader>wc", ":close<cr>", { desc = "[W]indow: [c]lose current" })
map("n", "<leader>wt", ":split<cr>:resize 10<cr>:term<cr>", { desc = "[W]indow: open 10-row [t]erminal" })
-- Tabs
map("n", "<leader>to", vim.cmd.tabnew, { desc = "[T]ab: [o]pen" })
map("n", "<leader>tc", vim.cmd.tabclose, { desc = "[T]ab: [c]lose" })
map("n", "<leader>tn", vim.cmd.tabn, { desc = "[T]ab: go to [n]next" })
map("n", "<leader>tp", vim.cmd.tabp, { desc = "[T]ab: go to [p]revious" })
-- Quickfix / location list
map("n", "<leader>co", vim.cmd.copen, { desc = "Quickfix: open" })
map("n", "<leader>cc", vim.cmd.close, { desc = "Quickfix: close" })
map("n", "<leader>cp", vim.cmd.cprev, { desc = "Quickfix: Previous quickfix" })
map("n", "<leader>cn", vim.cmd.cnext, { desc = "Quickfix: Next quickfix" })
map("n", "<leader>lo", vim.cmd.lopen, { desc = "Location list: open" })
map("n", "<leader>lc", vim.cmd.lclose, { desc = "Location list: close" })
map("n", "<leader>lp", vim.cmd.lprev, { desc = "Location list: Previous location" })
map("n", "<leader>ln", vim.cmd.lnext, { desc = "Location list: Next location" })

-- UI toggles
----------------
-- Toggle cursor column
map("n", "<leader>c", "<cmd>set cursorcolumn!<cr>", { desc = "Toggle [c]o[n]umber" })
-- Toggle line numbers
map("n", "<leader>nn", "<cmd>setlocal number! relativenumber!<cr>", { desc = "Toggle [n]o[n]umber" })
-- Toggle wrap
map("n", "<leader>w", ":set wrap!<cr>", { desc = "Toggle line [w]rapping" })
-- Toggle cursorcolumn
map("n", "<leader>c", ":set cursorcolumn!<cr>", { desc = "Toggle [c]ursorcolumn" })

-- Searching and moving around
--------------------------------

-- Work on visual lines when 'wrap' is set and j/k are used w/o a count.
-- With a count (e.g., 3j, 5k), work on real lines (works well with 'relativenumber').
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search highlights
-- map("n", "<leader>nh", ":nohlsearch<cr>", {silent=true})
-- map("n", "<leader><space>", ":nohlsearch<cr>", { silent = true })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- I'd use a function for this but Vim clobbers the last search when you're in
-- a function so fuck it, practicality beats purity.
map("n", "*", ":let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>", { silent = true })

-- Keep search matches in the middle of the window.
map("n", "n", "nzzzv", { desc = "Jump to next search result" })
map("n", "N", "Nzzzv", { desc = "Jump to prev search result" })

-- Same when jumping around
map("n", "g;", "g;zz", { desc = "Goto older change" })
map("n", "g,", "g,zz", { desc = "Goto newer change" })
map("n", "<C-o>", "<C-o>zz", { desc = "Goto older position in jumplist" })
map("n", "<C-i>", "<C-i>zz", { desc = "Goto newer position in jumplist" })

-- gi already moves to "last place you exited insert mode", so we'll map gI to
-- something similar: move to last change
map("n", "gI", "`.", { desc = "Goto last change" })

-- Editing
-------------

-- Toggle spelling and set spell language
map("n", "<leader>sp", "<cmd>setlocal spell!<cr>", { desc = "[Sp]elling: toggle" })
map(
  "n",
  "<leader>spde",
  "<cmd>setlocal spell spelllang=de_de<cr>",
  { desc = "[Sp]elling: enable and set lang to [de]" }
)
map("n", "<leader>spen", "<cmd>setlocal spell spelllang=en<cr>", { desc = "[Sp]elling: enable and set lang to [en]" })

-- Make Y behave like D (instead Y is the same as yy), fix this:
map("n", "Y", "y$")

-- Swap q and @ for macros, because q is easier to type on German keyboards
map("n", "q", "@")
map("n", "@", "q")

-- Join an entire paragraph.
map("n", "<leader>J", "mzvipJ`z", { desc = "[J]oin entire paragraph" })

-- Split line (sister to [J]oin lines)
-- The normal use of S is covered by cc, so don't worry about shadowing it.
map("n", "S", "i<cr><ESC>", { desc = "[S]plit line" })

-- Re-hardwrap paragraphs of text
map("n", "<leader>q", "gwip", { desc = "Re-hardwrap current paragraph" })
map("v", "<leader>q", "gw", { desc = "Re-hardwrap current paragraph" })

-- Keep visual selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Easier linewise reselection of what you just pasted.
map("n", "<leader>V", "`[V`]", { desc = "Re-select what you just pasted" })

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
map("i", "<C-u>", "<ESC>mzgUiw`za", { desc = "[U]ppercase current word in insert mode" })

-- Folding
-------------

-- Use space to toggle folds
-- map("n", "<space>", "za")
-- map("v", "<space>", "za")

-- Make zO recursively open whatever fold we're in, even if it's partially open.
map("n", "zO", "zczO", { desc = "Recursively open fold we're in" })

-- "Focus" the current line.  Basically:
-- 1. Close all folds.
-- 2. Open just the folds containing the current line.
-- 3. Move the line to a little bit (15 lines) above the center of the screen.
map("n", "<C-z>", "mzzMzvzz15<c-e>`z", { desc = "Focus current line (and fold everything else)" })

-- Term
----------
-- Make Escape work in the Neovim terminal.
map("t", "<ESC>", "<C-\\><C-n>")
-- Map C-n C-n to Escape for console apps that use this key
map("t", "<C-n><C-n>", "<ESC>")
-- Map Shift+space to space as I hit this combo by accident a lot ...
map("t", "<S-space>", "<space>")
