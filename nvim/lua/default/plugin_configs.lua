-- -- DAP config
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>b", "obreakpoint()<esc>", opts)

-- autopairs
require('nvim-autopairs').setup {
    check_ts = true, -- optional: enables Treesitter integration
}

-- -- Telescope keybindings
local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
keymap('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
keymap('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
--
-- " " VimTex. Idk why not workng by default
keymap("n", "<leader>ll", ":VimtexCompile<cr>")
keymap("n", "<leader>lk", ":VimtexStop<cr>")
keymap("n", "<leader>lc", ":VimtexClean<cr>")
keymap("n", "<leader>lv", ":VimtexView<cr>")

-- -- my AI Chat
keymap("n", "<leader>c", ':CodeCompanionChat Toggle<cr>')

-- -- Terminal
keymap("n", "<leader>t", ":ToggleTerm<cr>", opts)


-- -- Color scheme.
vim.cmd('colorscheme github_dark')
--
-- -- Vimtex config.
vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_compiler_latexmk = {build_dir = '', callback = 1, continuous = 1, executable = 'latexmk',
  options = {'-pdf', '-pdflatex=lualatex', '-interaction=nonstopmode', '-synctex=1',},
}
vim.g.grammarous_jar_url = 'https://www.languagetool.org/download/archive/LanguageTool-5.9.zip'
--
-- -- lualine config
require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'github_dark',
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

-- treesitter start on specific filetypes
-- getting .configs error so used this:
vim.api.nvim_create_autocmd('FileType', {
pattern = {"python", "c", "rust", "tex", "lua", "markdown", "markdown_inline", "bash"}, 
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})

-- autopairs
local npairs = require("nvim-autopairs")
local ap_rule = require("nvim-autopairs.rule")
npairs.add_rule(ap_rule("$","$","tex"))

-- For deleting buffers easily in telescope
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

-- codecompanion dont close stuff
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"companion", "codecompanion", "codecompanionchat"},  -- Adjust this if the filetype is different
  callback = function()
    vim.schedule(function()
      keymap("n", "<C-c>", "<Esc>", { buffer = true }) -- Disable in normal mode
      keymap("i", "<C-c>", "<Esc>", { buffer = true }) -- Disable in insert mode
    end)
  end,
})

-- For lspconfig xd
require('lspconfig.configs').pyright = {
  default_config = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = function(fname)
      return vim.fs.dirname(vim.fs.find({ "pyproject.toml", "setup.py", ".git" }, { upward = true })[1])
    end,
    settings = {},
  },
}

-- lsp configs
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('texlab')
vim.diagnostic.config({
 virtual_text = true,
 signs = true,
 underline = true,
 update_in_insert = false,
 severity_sort = true,
})

require("oil").setup({
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    skip_confirm_for_simple_edits = false,
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
})
