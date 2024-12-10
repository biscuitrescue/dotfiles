if not pcall(require, 'heirline') then return end

local os_sep = package.config:sub(1,1)
local api = vim.api
local fn = vim.fn
local bo = vim.bo

local conditions = require('heirline.conditions')
local heirline = require("heirline.utils")
local devicons = prequire('nvim-web-devicons')
-- local dap_available, dap = pcall(require, 'dap')
local dap = prequire('dap')
local util = require('anuvyklack.heirline.util')
local icons = util.icons
local mode = util.mode
local hydra = prequire('hydra.statusline')

local theme, theme_available = prequire('anuvyklack/heirline/themes/'..(vim.g.colors_name or ''))
-- local theme_available, theme = true, require('anuvyklack/heirline/themes/gruvbox-material')
if not theme_available then return end
local hl = theme.highlight
local colors = theme.colors
local lsp_colors = theme.lsp_colors

vim.o.showmode = false

local hydras_to_ignore = {
   Barbar = true,
   -- Folds = true
}

-- Flexible components priorities
local priority = {
   CurrentPath = 60,
   Git = 40,
   WorkDir = 25,
   Lsp = 10,
}

local Align, Space, Null, ReadOnly
do
   Null = { provider = '' }

   Align = { provider = '%=' }

   Space = setmetatable({ provider = ' ' }, {
      __call = function(_, n)
         return { provider = string.rep(' ', n) }
      end
   })

   ReadOnly = {
      condition = function() return not bo.modifiable or bo.readonly end,
      provider = icons.padlock,
      hl = hl.ReadOnly
   }
end

local LeftCap = {
   provider = '▌',
   -- provider = '',
   hl = hl.Mode.normal
}

local Indicator
do
   local HydraName = {
      condition = function()
         return hydra.is_active() and hydra.get_name()
                and not hydras_to_ignore[hydra.get_name()]
      end,
      heirline.surround(
         { icons.powerline.left_rounded, icons.powerline.right_rounded },
         function() return theme.hydra[hydra.get_color()] end, -- color
         {
            {
               fallthrough = false,
               ReadOnly,
               { provider = icons.circle }
            },
            Space,
            {
               provider = function() return hydra.get_name() or 'HYDRA' end,
            },
            hl = { fg = hl.StatusLine.bg, force = true },
         }
      )
   }

   local VimMode
   do
      local NormalModeIndicator = {
         Space,
         {
            fallthrough = false,
            ReadOnly,
            {
               provider = icons.circle,
               hl = function()
                  if bo.modified then
                     -- return { fg = hl.Mode.insert.bg }
                     return { fg = colors.blue2 }
                  else
                     return hl.Mode.normal
                  end
               end
            }
         },
         Space
      }

      local ActiveModeIndicator = {
         condition = function(self)
            return self.mode ~= 'normal'
         end,
         hl = { bg = hl.StatusLine.bg },
         heirline.surround(
            { icons.powerline.left_rounded, icons.powerline.right_rounded },
            function(self) -- color
               return hl.Mode[self.mode].bg
            end,
            {
               {
                  fallthrough = false,
                  ReadOnly,
                  { provider = icons.circle }
               },
               Space,
               {
                  provider = function(self)
                     return util.mode_lable[self.mode]
                  end,
               },
               hl = function(self)
                  return hl.Mode[self.mode]
               end
            }
         )
      }

      VimMode = {
         init = function(self)
            self.mode = mode[fn.mode(1)] -- :h mode()
         end,
         condition = function() return bo.buftype == '' end,
         {
            fallthrough = false,
            ActiveModeIndicator,
            NormalModeIndicator,
         }
      }
   end

   Indicator = {
      fallthrough = false,
      HydraName,
      VimMode
   }
end

local HydraHint = {
   condition = function() return hydra.get_hint() end,
   provider = hydra.get_hint,
}

local FileNameBlock, CurrentPath, FileName
do
   local FileIcon = {
      condition = function()
         return not ReadOnly.condition()
      end,
      init = function(self)
         local filename = self.filename
         local extension = fn.fnamemodify(filename, ':e')
         self.icon, self.icon_color = devicons.get_icon_color(
            filename, extension, { default = true })
      end,
      provider = function(self)
         if self.icon then return self.icon..' ' end
      end,
      hl = function(self)
         return { fg = self.icon_color }
      end
   }

   local WorkDir = {
      condition = function(self)
         if bo.buftype == '' then
            return self.pwd
         end
      end,
      hl = hl.WorkDir,
      flexible = priority.WorkDir,
      { provider = function(self) return self.pwd end },
      { provider = function(self) return fn.pathshorten(self.pwd) end },
      Null
   }

   CurrentPath = {
      condition = function(self)
         if bo.buftype == '' then
            return self.current_path
         end
      end,
      hl = hl.CurrentPath,
      flexible = priority.CurrentPath,
      { provider = function(self) return self.current_path end, },
      { provider = function(self) return fn.pathshorten(self.current_path, 2) end, },
      { provider = '' },
   }

   FileName = {
      provider = function(self) return self.filename end,
      hl = hl.FileName
   }

   FileNameBlock = {
      { FileIcon, WorkDir, CurrentPath, FileName },
      -- This means that the statusline is cut here when there's not enough space.
      { provider = '%<' }
   }
end

--------------------------------------------------------------------------------

local FileProperties = {
   condition = function(self)
      self.filetype = bo.filetype

      local encoding = (bo.fileencoding ~= '' and bo.fileencoding) or vim.o.encoding
      self.encoding = (encoding ~= 'utf-8') and encoding or nil

      local fileformat = bo.fileformat

      -- if fileformat == 'dos' then
      --    fileformat = ' '
      -- elseif fileformat == 'mac' then
      --    fileformat = ' '
      -- else  -- unix'
      --    fileformat = ' '
      --    -- fileformat = nil
      -- end

      if fileformat == 'dos' then
         fileformat = 'CRLF'
      elseif fileformat == 'mac' then
         fileformat = 'CR'
      else -- 'unix'
         -- fileformat = 'LF'
         fileformat = nil
      end

      self.fileformat = fileformat

      return self.fileformat or self.encoding
   end,
   provider = function(self)
      local sep = (self.fileformat and self.encoding) and ' ' or ''
      return table.concat{ ' ', self.fileformat or '', sep, self.encoding or '', ' ' }
   end,
   hl = hl.FileProperties,
}

local DapMessages = {
   -- display the dap messages only on the debugged file
   condition = function()
      -- local session = dap_available and dap.session()
      local session = dap.session()
      if session then
         local filename = api.nvim_buf_get_name(0)
         if session.config then
            local progname = session.config.program
            return filename == progname
         end
      end
      return false
   end,
   provider = function()
      return ' ' .. dap.status() .. ' '
   end,
   hl = hl.DapMessages
}

local Diagnostics = {
   condition = conditions.has_diagnostics,
   static = {
      -- error_icon = '󰂭 ',
      error_icon = fn.sign_getdefined('DiagnosticSignError')[1].text,
      warn_icon  = fn.sign_getdefined('DiagnosticSignWarn')[1].text,
      info_icon  = fn.sign_getdefined('DiagnosticSignInfo')[1].text,
      hint_icon  = fn.sign_getdefined('DiagnosticSignHint')[1].text,
   },
   init = function(self)
      self.errors   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info     = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
   end,
   {
      provider = function(self)
         -- 0 is just another output, we can decide to print it or not!
         if self.errors > 0 then
            return table.concat{ self.error_icon, self.errors, ' ' }
         end
      end,
      hl = hl.Diagnostic.error
   },
   {
      provider = function(self)
         if self.warnings > 0 then
            return table.concat{ self.warn_icon, self.warnings, ' ' }
         end
      end,
      hl = hl.Diagnostic.warn
   },
   {
      provider = function(self)
         if self.info > 0 then
            return table.concat{ self.info_icon, self.info, ' ' }
         end
      end,
      hl = hl.Diagnostic.info
   },
   {
      provider = function(self)
         if self.hints > 0 then
            return table.concat{ self.hint_icon, self.hints, ' ' }
         end
      end,
      hl = hl.Diagnostic.hint
   },
   Space(2)
}

local Git
do
   local GitBranch = {
      condition = conditions.is_git_repo,
      init = function(self)
         self.git_status = vim.b.gitsigns_status_dict
      end,
      hl = hl.Git.branch,
      provider = function(self)
         return table.concat{ ' ', self.git_status.head }
      end,
   }

   local GitChanges = {
      condition = function(self)
         if conditions.is_git_repo() then
            self.git_status = vim.b.gitsigns_status_dict
            local has_changes = self.git_status.added   ~= 0 or
                                self.git_status.removed ~= 0 or
                                self.git_status.changed ~= 0
            return has_changes
         end
      end,
      provider = '  ',
      -- hl = hl.Git.branch
      -- hl = hl.Git.changed
      -- hl = hl.Git.added
      -- hl = hl.Git.removed
      hl = hl.Git.dirty
   }

   Git = { GitBranch, GitChanges, Space }
end

local Lsp
do
   local LspIndicator = {
      provider = icons.circle_small .. ' ',
      hl = hl.LspIndicator
   }

   local LspServer = {
      Space,
      {
         provider = function(self)
            local names = self.lsp_names
            if #names == 1 then
               names = names[1]
            else
               -- names = table.concat(vim.tbl_flatten({ '[', names, ']' }), ' ')
               names = table.concat(names, ', ')
            end
            return names
         end,
      },
      Space(2),
      hl = hl.LspServer
   }

   Lsp = {
      condition = conditions.lsp_attached,
      init = function(self)
         local names = {}
         for _, server in pairs(vim.lsp.buf_get_clients(0)) do
            table.insert(names, server.name)
         end
         self.lsp_names = names
      end,
      hl = function(self)
         local color
         for _, name in ipairs(self.lsp_names) do
            if lsp_colors[name] then
               color = lsp_colors[name]
               break
            end
         end
         if color then
            return { fg = color, bold = true, force = true }
         else
            return hl.LspServer
         end
      end,
      flexible = priority.Lsp,

      LspServer,
      LspIndicator
   }
end

local SearchResults = {
   condition = function(self)
      local lines = api.nvim_buf_line_count(0)
      if lines > 50000 then return end

      local query = fn.getreg("/")
      if query == "" then return end

      if query:find("@") then return end

      local search_count = fn.searchcount({ recompute = 1, maxcount = -1 })
      local active = false
      if vim.v.hlsearch and vim.v.hlsearch == 1 and search_count.total > 0 then
         active = true
      end
      if not active then return end

      query = query:gsub([[^\V]], "")
      query = query:gsub([[\<]], ""):gsub([[\>]], "")

      self.query = query
      self.count = search_count
      return true
   end,
   {
      provider = function(self)
         return table.concat {
            -- ' ', self.query, ' ', self.count.current, '/', self.count.total, ' '
            ' ', self.count.current, '/', self.count.total, ' '
         }
      end,
      hl = hl.SearchResults
   },
   Space
}

local Ruler = {
   -- :help 'statusline'
   -- ------------------
   -- %-2 : make item takes at least 2 cells and be left justified
   -- %l  : current line number
   -- %L  : number of lines in the buffer
   -- %c  : column number
   -- %V  : virtual column number as -{num}.  Not displayed if equal to '%c'.
   provider = ' %9(%l:%L%)  %-3(%c%V%) ',
   hl = { bold = true }
}

local ScrollPercentage = {
   condition = function() return conditions.width_percent_below(4, 0.035) end,
   -- %P  : percentage through file of displayed window
   provider = ' %3(%P%) ',
   hl = hl.StatusLine
}

--------------------------------------------------------------------------------

local HelpBufferStatusline = {
   condition = function()
      return bo.filetype == "help"
   end,
   Space, Indicator,
   {
      provider = function()
         local filename = api.nvim_buf_get_name(0)
         return fn.fnamemodify(filename, ":t")
      end,
      hl = hl.FileName
   },
   Align, ScrollPercentage
}

local StatusLines = {
   init = function(self)
      local pwd = fn.getcwd(0) -- Present working directory.
      local current_path = api.nvim_buf_get_name(0)
      local filename

      if current_path == "" then
         pwd = fn.fnamemodify(pwd, ':~')
         current_path = nil
         filename = ' [No Name]'
      elseif current_path:find(pwd, 1, true) then
         filename = fn.fnamemodify(current_path, ':t')
         current_path = fn.fnamemodify(current_path, ':~:.:h')
         pwd = fn.fnamemodify(pwd, ':~') .. os_sep
         if current_path == '.' then
            current_path = nil
         else
            current_path = current_path .. os_sep
         end
      else
         pwd = nil
         filename = fn.fnamemodify(current_path, ':t')
         current_path = fn.fnamemodify(current_path, ':~:.:h') .. os_sep
      end

      self.pwd = pwd
      self.current_path = current_path -- The opened file path relevant to pwd.
      self.filename = filename
   end,
   hl = hl.StatusLine,
   {
      LeftCap, Indicator,
      Space,
      {
         fallthrough = false,
         HydraHint,
         { SearchResults, FileNameBlock, }
      },
      Space(4),
      -- GPS,
      Align,
      DapMessages,
      Diagnostics, Git, Lsp,
      FileProperties,
      -- Ruler, ScrollBar, ScrollPercentage
      Ruler, ScrollPercentage
   }
}

--------------------------------------------------------------------------------

local WinBarActiveLeftIcon = {
   {
      provider = '  ',
      hl = function()
         if bo.modified then
            return { fg = hl.WinBar.bg, bg = hl.Mode.insert.bg }
         else
            return { fg = hl.WinBar.bg, bg = hl.Mode.normal.fg }
         end
      end
   },
   {
      provider = '▍',
      hl = function()
         if bo.modified then
            return { fg = hl.Mode.insert.bg }
         else
            return hl.Mode.normal
         end
      end
   }
}

local WinBarInactiveLeftIcon = {
   provider = '▋',
   hl = function()
      if bo.modified then
         return { fg = hl.Mode.insert.bg }
      else
         return hl.Mode.normal
      end
   end
}

local WinBarRightIcon = {
   provider = '▍',
   hl = { fg = hl.WinBar.bg, bg = hl.Mode.normal.fg }
}

local WinBarModifiedIndicator = {
   condition = function() return bo.modified end,
   provider = icons.circle_small,
   hl = { fg = hl.Mode.insert.bg }
}

local Navic = {
   static = {
      -- create a type highlight map
      type_hl = {
         File = 'Directory',
         Module = 'Include',
         Namespace = 'TSNamespace',
         Package = 'Include',
         Class = 'Struct',
         Method = '@method',
         Property = 'TSProperty',
         Field = 'TSField',
         Constructor = 'TSConstructor ',
         Enum = 'TSField',
         Interface = 'Type',
         Function = 'Keyword',
         Variable = 'TSVariable',
         Constant = 'Constant',
         String = 'String',
         Number = 'Number',
         Boolean = 'Boolean',
         Array = 'TSField',
         Object = 'Type',
         Key = 'TSKeyword',
         Null = 'Comment',
         EnumMember = 'TSField',
         Struct = 'Struct',
         Event = 'Keyword',
         Operator = 'Operator',
         TypeParameter = 'Type',
      },
   },
   condition = function(self)
      if not prequire('nvim-navic').is_available() then
         return false
      end

      local data = prequire('nvim-navic').get_data() or {}
      if vim.tbl_isempty(data) then
         return false
      end

      local children = {}
      -- create a child for each level
      for i, d in ipairs(data) do
         local child = {
            {
               provider = d.icon,
               hl = self.type_hl[d.type],
            },
            {
               provider = d.name,
               -- highlight icon only or location name as well
               -- hl = self.type_hl[d.type],
            },
         }
         -- add a separator only if needed
         if 1 < #data and i < #data then

            table.insert(child, {
               provider = ' > ',
               hl = hl.Navic.Separator
            })
         end
         table.insert(children, child)
      end
      -- instantiate the new child, overwriting the previous one
      self[1] = self:new(children, 1)
      return true
   end,
}

local ActiveWinBar = {
   condition = conditions.is_active,
   WinBarActiveLeftIcon, Space(2), Navic, Align, WinBarRightIcon
}

local InactiveWinBar = {
   -- condition = function()
   --    return not conditions.is_active()
   -- end,
   WinBarInactiveLeftIcon, Space,
   Align,
   CurrentPath, FileName, Space, WinBarModifiedIndicator,
   Align, WinBarRightIcon
}

--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('User', { pattern = 'HeirlineInitWinbar',
   callback = function(args)
      local buf = args.buf
      local buftype = vim.tbl_contains(
         { 'prompt', 'nofile', 'help', 'quickfix' },
         bo[buf].buftype
      )
      local filetype = vim.tbl_contains(
         {
            'gitcommit', 'fugitive',
            'markdown',
            'NeogitStatus', 'NeogitPopup', 'NeogitCommitMessage',
         },
         bo[buf].filetype
      )
      if buftype or filetype then
         vim.opt_local.winbar = nil
      end
   end
})

local WinBars = {
   init = function(self)
      local pwd = fn.getcwd(0) -- Present working directory.
      local current_path = api.nvim_buf_get_name(0)
      local filename

      if current_path == "" then
         pwd = fn.fnamemodify(pwd, ':~')
         current_path = nil
         filename = ' [No Name]'
      elseif current_path:find(pwd, 1, true) then
         filename = fn.fnamemodify(current_path, ':t')
         current_path = fn.fnamemodify(current_path, ':~:.:h')
         pwd = fn.fnamemodify(pwd, ':~') .. os_sep
         if current_path == '.' then
            current_path = nil
         else
            current_path = current_path .. os_sep
         end
      else
         pwd = nil
         filename = fn.fnamemodify(current_path, ':t')
         current_path = fn.fnamemodify(current_path, ':~:.:h') .. os_sep
      end

      self.pwd = pwd
      self.current_path = current_path -- The opened file path relevant to pwd.
      self.filename = filename
   end,
   fallthrough = false,
   -- { -- Hide the winbar for special buffers
   --    condition = function()
   --       return conditions.buffer_matches({
   --          buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
   --          filetype = { '^git.*', 'fugitive', 'hydra_hint' },
   --       })
   --    end,
   --    init = function() vim.opt_local.winbar = nil end
   -- },
   ActiveWinBar,
   InactiveWinBar,
   -- {   -- A special winbar for terminals
   --    condition = function()
   --       return conditions.buffer_matches({ buftype = { "terminal" } })
   --    end,
   --    heirline.surround({ "", "" }, "dark_red", {
   --       FileType,
   --       Space,
   --       TerminalName,
   --    }),
   -- },
   hl = hl.WinBar
}

--------------------------------------------------------------------------------

require('heirline').setup({
   statusline = StatusLines,
   -- winbar = WinBars,
   -- tabline = ...,
   -- statuscolumn = ...
})

-- vim: fml=2
