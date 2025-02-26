-- Function to record
local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

-- Create Recording
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        require('lualine').refresh({
            place = { "statusline" },
        })
    end,
})

-- Stop Recording
vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
        50,
        0,
        vim.schedule_wrap(function()
            require('lualine').refresh({
                place = { "statusline" },
            })
        end)
        )
    end,
})

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        -- component_separators = { left = '|', right = '|'},
        -- section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        -- lualine_y = {{"macro_recording", fmt = show_macro_recording}},
        lualine_a = {'mode', {"macro_recording", fmt = show_macro_recording}},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

