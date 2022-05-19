vim.o.syntax = on
vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = true
vim.o.smartindent = true
vim.g.leader = [[ ]]

local keymap = vim.api.nvim_set_keymap

keymap('n', '<tab>t', ':tabnew<CR>', {})
keymap('n', '<tab>p', ':tabp<CR>', {})
keymap('n', '<tab>n', ':tabn<CR>', {})

require('plugins')

require'lspconfig'.gopls.setup{
	on_attach = function()
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
	end
}
