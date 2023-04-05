local M = {}

-- Patterns used by "get_root()"
M.root_patterns = { ".git", "lua" }

-- Return the root (i.e., project) directory for the current buffer based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
-- See: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil

  ---@type string[]
  local roots = {}

  -- Find all LSP workdirs or (as fallback) the LSP root dir.
  -- Filter all dirs that are no parents of the current file.
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end

  table.sort(roots, function(a, b)
    return #a > #b
  end)

  ---@type string?
  local root = roots[1]  -- Use first candidate
  if not root then
    -- Fallback to searching for root patterns
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    -- Use found root or fallback to cwd()
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end

  ---@cast root string
  return root
end

-- Guess line length from settings in pyproject.toml
---@return number
function M.py_line_length()
  local default = 88
  local Path = require("plenary.path")
  local cur_path = Path:new(vim.fn.expand("%:p:h"))
  local pyproject
  for _, p in pairs(cur_path:parents()) do
    pyproject = Path:new(p, "pyproject.toml")
    if pyproject:exists() then
      local data = pyproject:read()
      local ll = string.match(data, "line.length%s*=%s*(%d+)")
      if ll then
        return tonumber(ll) or default
      end
    end
  end
  return default
end

-- Return name of current virtual env
---@return string
function M.get_venvname()
  for _, v in pairs({ vim.env.VIRTUAL_ENV, vim.env.CONDA_PREFIX }) do
    if vim.fn.isdirectory(v) == 1 then
      return vim.fn.fnamemodify(v, ":t")
    end
  end
  return ""
end

-- Strip spaces from text
---@param text string
---@return string
function M.strip(text)
  ---@type string
  local result = string.gsub(text, "%s+", "")
  return result
end

return M
