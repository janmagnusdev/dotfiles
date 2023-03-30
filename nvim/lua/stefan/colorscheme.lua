local colorscheme = "stylo"
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- "opt.background" detects the current system dark/light mode.
-- Don't set it explicitly!
--
-- Detect OS dark/light mode by running the following function every 2s:
local function check_is_dark_mode()
  vim.fn.jobstart({ "dm", "get" }, {
    stdout_buffered = true,
    on_stdout = function(_, data, _)
      local os_mode = table.concat(data)
      if vim.opt.background:get() ~= os_mode then
        vim.opt.background = os_mode
      end
    end,
  })
end
local timer = vim.loop.new_timer()
timer:start(0, 2000, vim.schedule_wrap(check_is_dark_mode))

-- Reload the colorscheme whenever we write the file.
vim.cmd([[
augroup color_dev
    autocmd!
    autocmd BufWritePost stylo.lua colorscheme stylo
augroup END
]])
