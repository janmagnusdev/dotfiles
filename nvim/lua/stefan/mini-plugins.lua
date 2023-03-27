-- Stuff that should probably be broken out into plugins, but hasn't proved to
-- be worth the time to do so just yet.

-- Pyproject.toml Line Length {{{
--
-- Extract a project's line length from pyproject.toml

local function PyLineLength()
   local Path = require("plenary.path")
   local cur_path = Path:new(vim.fn.expand("%:p:h"))
   local pyproject
   for _, p in pairs(cur_path:parents()) do
      pyproject = Path:new(p, "pyproject.toml")
      if pyproject:exists() then
         local data = pyproject:read()
         local ll = string.match(data, "line.length%s*=%s*(%d+)")
         if ll then
            return tonumber(ll)
         end
      end
   end
   return 88
end

-- }}}

-- SmartHome (vim tip 315) {{{

local function SmartHome()
   local col = vim.fn.col(".")
   vim.cmd("normal! ^")
   if col == vim.fn.col(".") then
      vim.cmd("normal! 0")
   end
end
vim.keymap.set("n", "0", SmartHome, { silent = true })
vim.keymap.set("n", "<Home>", SmartHome, { silent = true })
vim.keymap.set("i", "<Home>", SmartHome, { silent = true })

-- }}}

-- Synstack {{{

-- Show the stack of syntax highlighting classes affecting whatever is under the
-- cursor.
local function SynStack()
   vim.cmd([[echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")]])
end

vim.keymap.set("n", "<leader>hi", SynStack)

-- }}}

-- Highlight Word {{{
--
-- This mini-plugin provides a few mappings for highlighting words temporarily.
--
-- Sometimes you're looking at a hairy piece of code and would like a certain
-- word or two to stand out temporarily.  You can search for it, but that only
-- gives you one color of highlighting.  Now you can use <leader>N where N is
-- a number from 1-6 to highlight the current word in a specific color.

local function _hiInterestingWord(n)
   -- Get word ("w") under cursor
   local word = vim.fn.expand("<cword>")
   -- Calculate an arbitrary match ID.  Hopefully nothing else is using it.
   local match_id = 86750 + n
   -- Clear existing matches, but don't worry if they don't exist.
   pcall(vim.fn.matchdelete, match_id)
   -- Construct a literal pattern that has to match at boundaries.
   local pattern = "\\V\\<" .. vim.fn.escape(word, "\\") .. "\\>"
   -- Actually match the words.
   vim.fn.matchadd("InterestingWord" .. n, pattern, 1, match_id)
end
local function hiInterestingWord(n)
   return function()
      _hiInterestingWord(n)
   end
end

vim.keymap.set("n", "<leader>1", hiInterestingWord(1), { silent = true })
vim.keymap.set("n", "<leader>2", hiInterestingWord(2), { silent = true })
vim.keymap.set("n", "<leader>3", hiInterestingWord(3), { silent = true })
vim.keymap.set("n", "<leader>4", hiInterestingWord(4), { silent = true })
vim.keymap.set("n", "<leader>5", hiInterestingWord(5), { silent = true })
vim.keymap.set("n", "<leader>6", hiInterestingWord(6), { silent = true })

vim.cmd("hi def InterestingWord1 guibg=#9bdeff ctermbg=117 guifg=#2F2F2F ctermfg=16")
vim.cmd("hi def InterestingWord2 guibg=#00f8c3 ctermbg=50  guifg=#2F2F2F ctermfg=16")
vim.cmd("hi def InterestingWord3 guibg=#88ff6d ctermbg=82  guifg=#2F2F2F ctermfg=16")
vim.cmd("hi def InterestingWord4 guibg=#ffcb71 ctermbg=222 guifg=#2F2F2F ctermfg=16")
vim.cmd("hi def InterestingWord5 guibg=#ffc0c8 ctermbg=224 guifg=#2F2F2F ctermfg=16")
vim.cmd("hi def InterestingWord6 guibg=#ddb1ff ctermbg=225 guifg=#2F2F2F ctermfg=16")
-- }}}

return {
  py_line_length = PyLineLength,
}
