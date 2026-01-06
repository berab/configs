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

-- Install your plugins here
return packer.startup(function(use)
    -- General
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/plenary.nvim" -- Have packer manage itself
    use "nvim-telescope/telescope.nvim"
    use "projekt0n/github-nvim-theme"
    use "stevearc/oil.nvim"
    use "neovim/nvim-lspconfig"
    use "folke/which-key.nvim"
    use "tpope/vim-fugitive"
    use { -- So no global vim variable warnings
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        config = function()
            require("lazydev").setup({
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            })
        end,
    }
    use "tpope/vim-surround"
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use{
        "olimorris/codecompanion.nvim",
        config = function()
            require("codecompanion").setup()
        end,
        requires = {"nvim-treesitter/nvim-treesitter",}
    }
    use {
        "akinsho/toggleterm.nvim", 
        tag = '*', 
        config = function()
            require("toggleterm").setup()
        end
    }
    use {"Vimjas/vim-python-pep8-indent"}
    -- use {"mfussenegger/nvim-dap"}
    -- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    -- use {"mfussenegger/nvim-dap-python"}

    -- Comments
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- Autopairs
    use "windwp/nvim-autopairs"
    -- Status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- Tex 
    use {
        'lervag/vimtex', 
    }
    use {
        'Automattic/harper', 
        ft = {'markdown', 'tex'}, 
    }
    use "rhysd/vim-grammarous" 
    -- Coding, Syntax etc.
    use 'rust-lang/rust.vim'
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
        ft = {'csv', 'csv_semicolon', 'csv_whitespace',}
    }
    -- completion plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    -- use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    -- snippet engine
    use {
        "L3MON4D3/LuaSnip",
        requires = { "L3MON4D3/jsregexp" }
    }
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
