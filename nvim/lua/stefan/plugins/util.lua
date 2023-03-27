--
-- Utility plugins used by other plugins (and mini-plugins)
--
return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- makes some plugins dot-repeatable like leap
  -- Enable repeating with "." for vim-surround
  { "tpope/vim-repeat", event = "VeryLazy" },
}
