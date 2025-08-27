local fn = vim.fn


-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

require('lspconfig').harper_ls.setup {}

-- Vimtex config.
vim.cmd([[let g:vimtex_view_method = 'zathura']])
vim.cmd([[let g:vimtex_view_general_viewer = 'zathura']])
vim.cmd([[let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex']])
vim.cmd([[let g:vimtex_compiler_method = 'pdflatex']])
vim.cmd([[let g:vimtex_quickfix_enabled = 0]])

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use {
      'Automattic/harper', 
  }
  --
  use {
      'tpope/vim-fugitive', 
  }
  use({
  "olimorris/codecompanion.nvim",
  config = function()
    require("codecompanion").setup()
  end,
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  }
  })
  
  use {
      'lervag/vimtex', 
  }
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    -- Colorschemes
  use { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }
  use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }

  -- Markdown 
  use 'godlygeek/tabular'
  use 'preservim/vim-markdown'

  -- vim wiki
  use 'vimwiki/vimwiki'

  -- Rust
  use 'rust-lang/rust.vim'

  -- Grammar check
  vim.g.grammarous_jar_url = 'https://www.languagetool.org/download/archive/LanguageTool-5.9.zip'
  use "rhysd/vim-grammarous" -- Have packer manage itself
  -- install without yarn or npm
  -- use({
  --     "iamcco/markdown-preview.nvim",
  --     run = function() vim.fn["mkdp#util#install"]() end,
  -- })
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

    -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  use 'jose-elias-alvarez/null-ls.nvim' -- LSP diagnostics and code actions


    -- install without yarn or npm
    -- use({
    --     "iamcco/markdown-preview.nvim",
    --     run = function() vim.fn["mkdp#util#install"]() end,
    -- })

  -- Autopairs
  use "windwp/nvim-autopairs"

  -- Comments
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end

  }

  -- use 'wakatime/vim-wakatime'

  -- Status bar
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use "nvim-tree/nvim-web-devicons"
  use "folke/trouble.nvim"

  -- CSV 
  use {
    'cameron-wags/rainbow_csv.nvim',
    config = function()
        require 'rainbow_csv'.setup()
    end,
    -- optional lazy-loading below
    module = {
        'rainbow_csv',
        'rainbow_csv.fns'
    },
    ft = {
        'csv',
        'tsv',
        'csv_semicolon',
        'csv_whitespace',
        'csv_pipe',
        'rfc_csv',
        'rfc_semicolon'
    }
}
-- Folding
  -- use{ 
  --     'anuvyklack/pretty-fold.nvim',
  --   config = function()
  --       require('pretty-fold').setup()
  --   end
  --   }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

  -- lualine config
  require('lualine').setup {
    options = {
      icons_enabled = false,
      theme = 'palenight',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
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
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }

end)
