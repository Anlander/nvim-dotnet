-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "wombat",
  transparency = true,
  diagnostic = {
    virtual_text = true,
    signs = true,
    float = {
      border = "rounded",
      source = "always",
      header = "",
      prefix = " ",
      severity_sort = true,
      max_width = 80,
      max_height = 20,
    },
  },

  -- transparent = true,
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    enabled = false,
  },
  statusline = {
    enabled = true,
    style = "default",
  },
}

return M
