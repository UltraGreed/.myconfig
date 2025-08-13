vim.keymap.set("n", "<leader>j", function()
    vim.cmd('write')
    vim.api.nvim_command('call jupyter_ascending#execute()')
end, { silent = true })

vim.keymap.set("n", "<leader>J", function()
    vim.cmd('write')
    vim.api.nvim_command('call jupyter_ascending#execute_all()')
end, { silent = true })
