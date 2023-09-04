return {
  -- diagnostics = {
  --   Error = " ",
  --   Warn = " ",
  --   Hint = " ", -- 
  --   Info = " ",
  -- },
  diagnostics = {
    Error = "󰅚 ", --  󰅚 󰅚
    Warn = " ",  --   󰀪
    Hint = " ",  --    󰌶
    Info = " ",  --   󰋽
  },
  file = {
    modified = " ",
    readonly = " ",
  },
  -- Git status for changed lines (e.g., in lualine)
  git_lines = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  -- Git status for file explorer
  git = {
    -- Change type
    added = " ",
    modified = " ",
    deleted = " ",
    renamed = " ",
    -- Status type
    untracked = " ",
    ignored = " ",
    unstaged = " ",
    staged = " ",
    conflict = " ",
  },
  filetypes = {
    terminal = " ", -- alt:  , 
  },
  kinds = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  },
}
