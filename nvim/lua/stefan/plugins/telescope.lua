local ok, telescope = pcall(require, "telescope")
if not ok then
   return
end

-- import telescope actions safely
local ok, actions = pcall(require, "telescope.actions")
if not ok then
   return
end

-- configure telescope
telescope.setup({
   -- configure custom mappings
   defaults = {
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      mappings = {
         i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
         },
      },
   },
})

telescope.load_extension("fzf")
