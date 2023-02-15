local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
   return
end

-- Recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- TODO: map <Space> to open/close folders in tree
nvimtree.setup({
   -- https://github.com/nvim-tree/nvim-tree.lua
   -- -- change color for arrows in tree to light blue
   -- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
   --
   -- -- configure nvim-tree
   -- nvimtree.setup({
   --   -- change folder arrow icons
   --   renderer = {
   --     icons = {
   --       glyphs = {
   --         folder = {
   --           arrow_closed = "", -- arrow when folder is closed
   --           arrow_open = "", -- arrow when folder is open
   --         },
   --       },
   --     },
   --   },
   -- disable window_picker for
   -- explorer to work well with
   -- window splits
   actions = {
      open_file = {
         window_picker = {
            enable = false,
         },
      },
   },
   --   -- 	git = {
   --   -- 		ignore = false,
   --   -- 	},
})
