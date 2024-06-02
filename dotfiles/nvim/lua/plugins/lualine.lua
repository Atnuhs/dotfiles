local palette = require('catppuccin.palettes').get_palette("frappe")
local switch_color = {
  active = { fg = palette.crust, bg = palette.yellow },
  inactive = { fg = palette.green, bg = palette.crust},
}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

return {
    {
        'hoob3rt/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            options = {
                section_separators = { left = '', right = ''},
                component_separators = { left = '', right = '' },
                globalstatus=true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {{
                    'filename',
                    newfile_status = true,
                    path = 1,
                    shorting_target = 24,
                    symbols = { modified = '_󰷥', readonly = ' ', newfile = '󰄛' },
                }},
                lualine_c = {},

                lualine_x = {
                    { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
                    {"filetype"},
                },
                lualine_y = { 'encoding' },
                lualine_z = {
                    { 'fileformat', icons_enabled = true, separator = { left = '', right = '' } },
                },
            },
            tabline = {
                lualine_a = {
                    {
                        'buffers',
                        buffers_color = switch_color,
                        symbols = { modified = '_󰷥', alternate_file = ' ', directory = ' ' },
                    },
                },
                lualine_b = {},
                lualine_c = {},
                    lualine_x = {
                        { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' }, source = diff_source },
                    },
                lualine_y = {
                    'branch'
                },
                lualine_z = {
                    { 'tabs', tabs_color = switch_color },
                },
            },
            -- extensions = { 'fugitive' }
        }
    }
}
