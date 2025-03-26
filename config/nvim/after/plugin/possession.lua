require("nvim-possession").setup({
    sessions = {
        sessions_path = "/home/cafo/.nvim/sessions/",-- folder to look for sessions, must be a valid existing path
        -- sessions_variable = ... -- defines vim.g[sessions_variable] when a session is loaded
        -- sessions_icon = ...-- string: shows icon both in the prompt and in the statusline
        -- sessions_prompt = ... -- fzf prompt string
    },

    autoload = false, -- whether to autoload sessions in the cwd at startup
    autosave = true, -- whether to autosave loaded sessions before quitting
    autoswitch = {
        enable = false, -- whether to enable autoswitch
        exclude_ft = {}, -- list of filetypes to exclude from autoswitch
    },

    save_hook = nil, -- callback, function to execute before saving a session
                    -- useful to update or cleanup global variables for example
    post_hook = nil, -- callback, function to execute after loading a session
                    -- useful to restore file trees, file managers or terminals
                    -- function()
                    --     require('FTerm').open()
                    --     require('nvim-tree').toggle(false, true)
                    -- end

    ---@type possession.Hls
    fzf_hls = { -- highlight groups for the sessions and preview windows
        normal = "Normal",
        preview_normal = "Normal",
        border = "Todo",
        preview_border = "Constant",
    },
    ---@type possession.Winopts
    fzf_winopts = {
        -- any valid fzf-lua winopts options, for instance
        width = 0.5,
        preview = {
            vertical = "right:30%"
        }
    },
    sort = require("nvim-possession.sorting").alpha_sort -- callback, sorting function to list sessions
                                                         -- require("nvim-possession.sorting").time_sort
                                                         -- to sort by last updated instead
})
