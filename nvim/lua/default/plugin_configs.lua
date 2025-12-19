require('nvim-autopairs').setup {
    check_ts = true, -- optional: enables Treesitter integration
}
-- Color scheme.
vim.cmd('colorscheme github_dark')

-- Vimtex config.
vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_compiler_latexmk = {build_dir = '', callback = 1, continuous = 1, executable = 'latexmk',
  options = {'-pdf', '-pdflatex=lualatex', '-interaction=nonstopmode', '-synctex=1',},
}
vim.g.grammarous_jar_url = 'https://www.languagetool.org/download/archive/LanguageTool-5.9.zip'

-- lualine config
require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'github_dark',
      section_separators = '',     -- Remove section separators
      component_separators = { left = '', right = '' }, -- Powerline style
      section_separators   = { left = '', right = '' }, -- Powerline style
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
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
    tabline = {
        lualine_a = {'buffers'},
        lualine_b = {'tabs'},
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
require('nvim-treesitter').setup {
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "rust", "c", "latex"}, -- put the language you want in this array
    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "" },                                                       -- List of parsers to ignore installing
    sync_install = false,                                                          -- install languages synchronously (only applied to `ensure_installed`)
    highlight = {
      enable = true,       -- false will disable the whole extension
      additional_vim_regex_highlighting = false,
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
}

-- autopairs
local npairs = require("nvim-autopairs")
local ap_rule = require("nvim-autopairs.rule")
npairs.add_rule(ap_rule("$","$","tex"))

vim.keymap.set('n', '<leader>bm', function()
  require("buffer_manager.ui").toggle_quick_menu()
end, { desc = "Toggle Buffer Manager" })

require('telescope').setup{
  pickers = {
    buffers = {
      mappings = {
        n = {
          ["<C-d>"] = "delete_buffer", -- delete in normal mode
        }
      }
    }
  }
}
