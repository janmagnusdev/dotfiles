local colorscheme = "stylo"
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
   vim.notify("colorscheme " .. colorscheme .. " not found!")
   return
end

-- "opt.background" detects the current system dark/light mode.
-- Don't set it explicitly!
--
-- Detect OS dark/light mode by running the following function every 3s:
-- TODO: Maybe replace with an async lua job?
local function check_is_dark_mode()
   local os_mode = vim.fn.systemlist("dm get")[1]
   if vim.opt.background:get() ~= os_mode then
      vim.opt.background = os_mode
   end
end
check_is_dark_mode()
vim.fn.timer_start(3000, check_is_dark_mode, { ["repeat"] = -1 })

-- Reload the colorscheme whenever we write the file.
vim.cmd([[
augroup color_dev
    autocmd!
    autocmd BufWritePost stylo.lua colorscheme stylo
augroup END
]])
