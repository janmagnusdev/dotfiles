local ok, lualine = pcall(require, "lualine")
if not ok then
   return
end

-- Return indentation info:
-- "s:3" means "3 spaces", "t:4" means tabs with 4 spaces width
local indentinfo = function()
   local et = vim.api.nvim_get_option_value("expandtab", { scope = "local" })
   local ts = vim.api.nvim_get_option_value("tabstop", { scope = "local" })
   local text = (et and "s" or "t") .. ":" .. ts
   return text
end

local Path = require("plenary.path")

-- Return name of current virtual/Conda env
local function get_venvname()
   for _, v in pairs({ vim.env.VIRTUAL_ENV, vim.env.CONDA_PREFIX }) do
      if vim.fn.isdirectory(v) == 1 then
         return vim.fn.fnamemodify(v, ":t")
      end
   end
   return ""
end
vim.g.venvname = get_venvname() -- Only call once, venv does not change

lualine.setup({
   options = {
      theme = vim.g.lualine_stylo_theme,
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
   },
   sections = {
      lualine_a = { "mode" },
      lualine_b = { "g:venvname", "branch", "diff", "diagnostics", "filename" },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "filetype", "encoding", "fileformat", indentinfo, "location", "progress" },
      lualine_z = {},
   },
   inactive_sections = {
      lualine_a = {},
      lualine_b = { "filename" },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "location", "progress" },
      lualine_z = {},
   },
})
