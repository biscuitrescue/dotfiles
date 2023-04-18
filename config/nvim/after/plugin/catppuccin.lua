require("catppuccin").setup({
    flavour = "latte",
    transparent_background = true,
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
            surface1 = "#565E65",
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
