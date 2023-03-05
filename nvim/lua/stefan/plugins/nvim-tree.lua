local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
   return
end

local view = require("nvim-tree.view")
local api = require("nvim-tree.api")

-- Recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Configure nvim-tree to behave like vim-vinegar:
-- - Open current file's parent directory via "-" and replace current buffer
-- - Open file with <CR> and replace current buffer
-- - But keep <leader>e (Toggle nvim-tree in vsplit) intact

local function toggle_replace()
   if view.is_visible() then
      api.tree.close()
   else
      nvimtree.open_replacing_current_buffer()
   end
end
vim.api.nvim_create_user_command(
   "NvimTreeToggleReplace",
   toggle_replace,
   { desc = "nvim-tree: Open nvim-tree in-place" }
)

local function on_attach(bufnr)
   local function opts(desc)
      return {
         desc = "nvim-tree: " .. desc,
         buffer = bufnr,
         noremap = true,
         silent = true,
         nowait = true,
      }
   end

   vim.keymap.set("n", "<CR>", api.node.open.replace_tree_buffer, opts("Open in-place"))
end

nvimtree.setup({
   on_attach = on_attach,
   actions = {
      open_file = {
         window_picker = {
            enable = false, -- Open file in window from which you opend n.t.
         },
      },
   },
   -- git = {
   --    ignore = false,
   -- },
})
