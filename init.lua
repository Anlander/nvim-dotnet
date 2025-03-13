vim.cmd "filetype plugin indent on"
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.cshtml", "*.razor" },
  callback = function()
    vim.bo.filetype = "razor"
    print("Filetype set to Razor for file: " .. vim.fn.expand "%")
  end,
})

vim.lsp.buf_request(0, "textDocument/completion", {
  textDocument = { uri = vim.uri_from_bufnr(0) },
  position = { line = vim.fn.line "." - 1, character = vim.fn.col "." - 1 },
}, function(err, result)
  print(vim.inspect(result))
end)
--
-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
