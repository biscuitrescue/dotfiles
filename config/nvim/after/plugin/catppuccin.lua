require("catppuccin").setup({
    flavour = "mocha",
  transparent_background = false,
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  term_colors = true,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  styles = {
    comments = { "italic" },
    conditionals = { "bold" },
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
  color_overrides = {
    frappe = {
      base = "#20202A",
      rosewater = "#EAC1C1",
      flamingo = "#F0C6C6",
      pink = "#E9D1D1",
      mauve = "#f6bbe7",
      red = "#ebb9b9",
      maroon = "#c79595",
      peach = "#EEE8BA",
      yellow = "#E6DFB8",
      green = "#b1dba4",
      teal = "#AEDCB7",
      sapphire = "#BEE0A8",
      blue = "#BCCAEB",
      lavender = "#CDDBF9",
      text = "#bfc9db",
      surface0 = "#34343e",
      surface1 = "#3e3e48",
    },
    macchiato = {
      base = "#1c2023",
      rosewater = "#F4DBD6",
      flamingo = "#F0C6C6",
      pink = "#c795ae",
      mauve = "#ae95c7",
      red = "#C77C80",
      maroon = "#c79595",
      peach = "#c7ae95",
      yellow = "#c7c795",
      green = "#aec795",
      teal = "#95c7ae",
      sapphire = "#95c7ae",
      blue = "#95aec7",
      lavender = "#95aec7",
      text = "#c7ccd1",
      surface0 = "#393f45",
      mantle = "#1c2023",
      crust = "#1c2023",
      surface1 = "#565E65",
      surface2 = "#565E65",
    }
  },
  -- custom_highlights = {},
  custom_highlights = function(colors)
    return {
      -- variable = { fg = colors.red},
    }
  end,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = false,
    mini = false,
  },
})


local colors = require("catppuccin.palettes").get_palette()

local TelescopeColor = {
  TelescopeMatching = { fg = colors.flamingo },
  TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

  TelescopePromptPrefix = { bg = colors.surface0 },
  TelescopePromptNormal = { bg = colors.surface0 },
  TelescopeResultsNormal = { bg = colors.mantle },
  TelescopePreviewNormal = { bg = colors.mantle },
  TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
  TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
  TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
  TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
  TelescopeResultsTitle = { fg = colors.mantle },
  TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
}

for hl, col in pairs(TelescopeColor) do
  vim.api.nvim_set_hl(0, hl, col)
end
