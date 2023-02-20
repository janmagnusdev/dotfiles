-- Stuff that should probably be broken out into plugins, but hasn't proved to
-- be worth the time to do so just yet.

-- Pyproject.toml Line Length {{{
--
-- Extract a project's line length from pyproject.toml

local Path = require("plenary.path")

function PyLineLength()
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
PyLineLength()

-- }}}
-- SmartHome (vim tip 315) {{{

function SmartHome()
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
