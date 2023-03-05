local ok, lualine = pcall(require, "lualine")
if not ok then
   return
end

-- Return indentation info:
-- "s:3" means "3 spaces", "t:4" means tabs with 4 spaces width
local indentinfo = function()
   local et = vim.opt.expandtab:get()
   local ts = vim.opt.tabstop:get()
   local text = (et and "s" or "t") .. ":" .. ts
   return text
end

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

local get_color = require("lualine.utils.utils").extract_highlight_colors

local function setup()
   lualine.setup({
      options = {
         theme = vim.g.lualine_stylo_theme,
         component_separators = { left = "|", right = "|" },
         section_separators = { left = "", right = "" },
      },
      sections = {
         lualine_a = { "mode" },
         lualine_b = {
            "g:venvname",
            "branch",
            {
               "diff",
               -- colored = false,
               diff_color = {
                  added = { fg = get_color("diffAdded", "fg") },
                  modified = { fg = get_color("diffChanged", "fg") },
                  removed = { fg = get_color("diffRemoved", "fg") },
               },
               symbols = { added = " ", modified = " ", removed = " " },
            },
            "diagnostics",
            {
               "filename",
               path = 1,
               -- shorting_target = 40, -- Shortens path to leave 40 spaces in the window
               symbols = {
                  modified = "",
                  readonly = "",
               },
            },
         },
         lualine_c = {},
         lualine_x = {},
         lualine_y = { "filetype", "encoding", "fileformat", indentinfo, "location", "progress" },
         lualine_z = {},
      },
      inactive_sections = {
         lualine_a = {},
         lualine_b = {
            {
               "filename",
               path = 1,
               -- shorting_target = 40, -- Shortens path to leave 40 spaces in the window
               symbols = {
                  modified = "",
                  readonly = "",
               },
            },
         },
         lualine_c = {},
         lualine_x = {},
         lualine_y = { "location", "progress" },
         lualine_z = {},
      },
   })
end

return {
   setup = setup,
}
