vim.g.mapleader = " "
vim.g.localmapleader = " "

local setmap = vim.keymap.set

setmap('n', "<Space>", "<NOP>", { noremap = true, nowait = true, })
setmap('n', '<leader>pv', vim.cmd.Ex, { noremap = true, silent = true, nowait = true, desc = "Explore files" })
setmap('n', '<leader>bp', vim.cmd.bp, { noremap = true, silent = true, nowait = true, desc = "Prev Buffer." })
setmap('n', '<leader>bn', vim.cmd.bn, { noremap = true, silent = true, nowait = true, desc = "Next Buffer." })
setmap('n', '<leader>bd', vim.cmd.bd, { desc = "Delete Opening buffer." })
setmap('n', 'Y', [[yg_]], { noremap = true })
setmap('n', "<C-d>", "<C-d>zz", { noremap = true })
setmap('n', "<C-u>", "<C-u>zz", { noremap = true })
setmap('n', "n", "nzzzv", { noremap = true })
setmap('n', "N", "Nzzzv", { noremap = true })
setmap('n', "<leader>y", [["+y]], { noremap = true })
setmap('n', "<leader>f", function()
    vim.lsp.buf.format()
    vim.cmd("w")
end, {
    noremap = true,
    silent = true,
    nowait = true
})
setmap('n', "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { noremap = true })
setmap('n', "<leader><leader>", vim.cmd.so, { noremap = true })
setmap('n', "<leader>;", ":", { noremap = true })
setmap('n', '<leader>q', ':q', { noremap = true, silent = false, nowait = true })
setmap('n', '<leader>w', ':w<cr>', { noremap = true, silent = false, nowait = true })
setmap('n', '<leader>x', ':x', { noremap = true, silent = false, nowait = true })
setmap('n', '<leader>!', ':lua ', { noremap = true, silent = false, nowait = true })
setmap({ 'n', 'v' }, '<leader>d', [["_d]], { silent = true, nowait = true, noremap = true })
setmap('n', '<leader>vcf', function() vim.cmd.edit("~/.config/nvim/") end, { noremap = true })
setmap('n', '<A-h>', "<C-w>h", { noremap = true, expr = false })
setmap('n', '<A-j>', "<C-w>j", { noremap = true, expr = false })
setmap('n', '<A-k>', "<C-w>k", { noremap = true, expr = false })
setmap('n', '<A-l>', "<C-w>l", { noremap = true, expr = false })

setmap('n', "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true, silent = true })
setmap('n', "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true, silent = true })

setmap('i', "<C-c>", "<Esc>", { noremap = true, silent = false, nowait = true })

setmap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = false })
setmap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = false })
setmap('v', '<leader>Y', '"+Y', { noremap = true, silent = false })
setmap('v', '<leader>y', '"+y', { noremap = true, silent = false })
setmap('x', '<leader>p', [["_dP]], { noremap = true, silent = true, nowait = true })
--
--setmap('v', '<leader>d', '"_d', {noremap = true, silent = false })
