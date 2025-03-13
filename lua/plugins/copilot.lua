return {
  "github/copilot.vim",
  config = function()
    -- Optional configuration for copilot
    vim.g.copilot_no_tab_map = false -- Disables Tab mapping to accept suggestions
    vim.g.copilot_assume_mapped = true -- Automatically accepts suggestions
  end,
}
