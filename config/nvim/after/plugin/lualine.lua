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

-- lualine_y = {{"macro_recording", fmt = show_macro_recording}},
-- local colors = require("catppuccin.palettes").get_palette()
-- local colors = {
--     bg       = '#282c34',
--     fg       = '#bfc7d5',
--     yellow   = '#ecbe7b',
--     cyan     = '#46d9ff',
--     darkblue = '#081633',
--     green    = '#98be65',
--     orange   = '#da8548',
--     violet   = '#a9a1e1',
--     maroon  = '#a9a1e1',
--     blue     = '#51afef',
--     red      = '#ff6c6b',
-- }
-- local colors = {
--     bg       = '#292D3E',
--     fg       = '#bfc7d5',
--     yellow   = '#ffcb6b',
--     cyan     = '#89DDFF',
--     darkblue = '#081633',
--     green    = '#C3E88D',
--     orange   = '#F78C6C',
--     violet   = '#c792ea',
--     maroon  = '#939ede',
--     blue     = '#82b1ff',
--     red      = '#ff5370',
-- }
-- local colors = {
--     bg       = '#282a36',
--     fg       = '#ffffff',
--     yellow   = '#ff5555',
--     cyan     = '#8be9fd',
--     darkblue = '#6272a4',
--     green    = '#50fa7b',
--     orange   = '#ffb86c',
--     violet   = '#bd93f9',
--     maroon   = '#ff79c6',
--     mauve    = '#ff79c6',
--     blue     = '#bd93f9',
--     red      = '#ff5555',
-- }
-- local colors = {
--     bg       = '#1c2023',
--     fg       = '#c7ccd1',
--     yellow   = '#c7ae95',
--     cyan     = '#95c7ae',
--     darkblue = '#747c84',
--     green    = '#aec795',
--     orange   = '#fab387',
--     violet   = '#ae95c7',
--     maroon   = '#c795ae',
--     mauve    = '#c795ae',
--     blue     = '#95aec7',
--     red      = '#f38ba8',
-- }

-- local conditions = {
--     buffer_not_empty = function()
--         return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
--     end,
--     hide_in_width = function()
--         return vim.fn.winwidth(0) > 90
--     end,
--     check_git_workspace = function()
--         local filepath = vim.fn.expand('%:p:h')
--         local gitdir = vim.fn.finddir('.git', filepath .. ';')
--         return gitdir and #gitdir > 0 and #gitdir < #filepath
--     end,
-- }
--
--
-- -- Config
-- local config = {
--     options = {
--         -- Disable sections and component separators
--         component_separators = '',
--         section_separators = '',
--         theme = {
--             normal = { c = { fg = colors.fg, bg = colors.bg } },
--             inactive = { c = { fg = colors.fg, bg = colors.bg } },
--         },
--     },
--     sections = {
--         -- these are to remove the defaults
--         lualine_a = {},
--         lualine_b = {},
--         lualine_y = {{"macro_recording", fmt = show_macro_recording}},
--         lualine_z = {},
--         -- These will be filled later
--         lualine_c = {},
--         lualine_x = {},
--     },
--     inactive_sections = {
--         -- these are to remove the defaults
--         lualine_a = {},
--         lualine_b = {},
--         lualine_y = {},
--         lualine_z = {},
--         lualine_c = {},
--         lualine_x = {},
--     },
-- }
--
-- -- Inserts a component in lualine_c at left section
-- local function ins_left(component)
--     table.insert(config.sections.lualine_c, component)
-- end
--
-- -- Inserts a component in lualine_x ot right section
-- local function ins_right(component)
--     table.insert(config.sections.lualine_x, component)
-- end
--
-- ins_left {
--     function()
--         return '▊'
--     end,
--     color = { fg = colors.blue }, -- Sets highlighting of component
--     padding = { left = 0, right = 1 }, -- We don't need space before this
-- }
--
-- ins_left {
--     -- mode component
--     function()
--         return ''
--     end,
--     color = function()
--         -- auto change color according to neovims mode
--         local mode_color = {
--             n = colors.red,
--             i = colors.green,
--             v = colors.blue,
--             [''] = colors.blue,
--             V = colors.blue,
--             c = colors.maroon,
--             no = colors.red,
--             s = colors.peach,
--             S = colors.peach,
--             [''] = colors.peach,
--             ic = colors.yellow,
--             R = colors.mauve,
--             Rv = colors.mauve,
--             cv = colors.red,
--             ce = colors.red,
--             r = colors.cyan,
--             rm = colors.cyan,
--             ['r?'] = colors.cyan,
--             ['!'] = colors.red,
--             t = colors.red,
--         }
--         return { fg = mode_color[vim.fn.mode()] }
--     end,
--     padding = { right = 1 },
-- }
--
-- ins_left {
--     -- filesize component
--     'filesize',
--     cond = conditions.buffer_not_empty,
--     color = { fg = colors.peach, gui = 'bold' },
-- }
--
-- ins_left {
--     'filename',
--     cond = conditions.buffer_not_empty,
--     color = { fg = colors.maroon, gui = 'bold' },
-- }
--
-- ins_left { 'location', color = { fg = colors.green, gui = 'bold' } }
--
-- ins_left { 'progress', color = { fg = colors.green, gui = 'bold' } }
--
-- ins_left {
--     'diagnostics',
--     sources = { 'nvim_diagnostic' },
--     symbols = { error = ' ', warn = ' ', info = ' ' },
--     diagnostics_color = {
--         color_error = { fg = colors.red },
--         color_warn = { fg = colors.yellow },
--         color_info = { fg = colors.cyan },
--     },
-- }
--
-- -- Insert mid section. You can make any number of sections in neovim :)
-- -- for lualine it's any number greater then 2
-- ins_left {
--     function()
--         return '%='
--     end,
-- }
--
-- ins_left {
--     -- Lsp server name .
--     function()
--         local msg = 'No Active Lsp'
--         local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
--         local clients = vim.lsp.get_active_clients()
--         if next(clients) == nil then
--             return msg
--         end
--         for _, client in ipairs(clients) do
--             local filetypes = client.config.filetypes
--             if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--                 return client.name
--             end
--         end
--         return msg
--     end,
--     icon = ' LSP:',
--     color = { fg = colors.mauve, gui = 'bold' },
-- }
--
-- -- Add components to right sections
-- ins_right {
--     'o:encoding', -- option component same as &encoding in viml
--     fmt = string.upper, -- I'm not sure why it's upper case either ;)
--     cond = conditions.hide_in_width,
--     color = { fg = colors.green, gui = 'bold' },
-- }
--
-- ins_right {
--     'fileformat',
--     fmt = string.upper,
--     icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--     color = { fg = colors.green, gui = 'bold' },
-- }
--
-- ins_right {
--     'branch',
--     icon = '',
--     color = { fg = colors.violet, gui = 'bold' },
-- }
--
-- ins_right {
--     'diff',
--     -- Is it me or the symbol for modified us really weird
--     symbols = { added = ' ', modified = '柳 ', removed = ' ' },
--     diff_color = {
--         added = { fg = colors.green },
--         modified = { fg = colors.orange },
--         removed = { fg = colors.red },
--     },
--     cond = conditions.hide_in_width,
-- }
--
-- ins_right {
--     function()
--         return '▊'
--     end,
--     color = { fg = colors.blue },
--     padding = { left = 1 },
-- }
--
-- require('lualine').setup(config)
-- Now don't forget to initialize lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
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

