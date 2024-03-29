local M = {}
M.config = function()
  lvim.builtin.catppuccin = {
    acitve = true,
    options = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        cmp       = true,
        gitsigns  = true,
        nvimtree  = false,
        neotree   = true,
        telescope = true,
        notify    = false,
        mini      = false,
        hop       = true,
        mason     = true,
        noice     = true,
        which_key = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    }
  }
end

M.setup = function()
  local ok, catppuccin = pcall(require, "catppuccin")
  if not ok then
    return
  end
  catppuccin.setup(lvim.builtin.catppuccin.options)
end

return M
