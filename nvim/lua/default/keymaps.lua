local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap.set

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>e", ":Oil<cr>", opts)

-- Easier register usage (for me xd)
keymap("n", "<leader>r", "@", opts)

-- Easier window close
keymap("n", "<leader>qq", ":q<cr>", opts)
keymap("n", "<leader>qa", ":qa<cr>", opts)

-- Wrap unwrap the text (useful for latex/markdown imo)
keymap("n", "<leader>wy", ":set wrap<cr>", opts)
keymap("n", "<leader>wn", ":set nowrap<cr>", opts)

-- F*ck highlighting omfg
keymap("n", "<leader>n", ":noh<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- float window for lsp errors/warning
keymap('n', '<leader>dd', function()
 vim.diagnostic.open_float()
end)
keymap('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics in location list' })
-- ...existing code...
