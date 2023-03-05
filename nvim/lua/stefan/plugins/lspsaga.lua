local ok, saga = pcall(require, "lspsaga")
if not ok then
   return
end

saga.setup({
   -- keybinds for navigation in lspsaga window
   scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
   code_action = {
      extend_gitsigns = false, -- explicitly add this in null-ls.lua
   },
   definition = {
      edit = "<CR>",
   },
   lightbulb = {
      enable = false,
   },
   outline = {
      keys = {
         expand_collapse = "<space>",
      },
   },
   ui = {
      border = "rounded",
   },
})
