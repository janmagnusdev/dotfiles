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
