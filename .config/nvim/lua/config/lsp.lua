vim.lsp.enable('luals')
vim.lsp.enable('ruff')
vim.lsp.enable('clangd')
-- vim.lsp.enable('basedpyright')
-- vim.lsp.enable('pyright')
vim.lsp.enable('zls')
-- vim.lsp.enable('ty')
vim.lsp.enable('pyrefly')

-- vim.lsp.inlay_hint.enable(true)

local function has_float()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg and cfg.relative ~= '' then
      return true
    end
  end
  return false
end

local floating_opts = {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = 'rounded',
    source = 'always',
    prefix = ' ',
    scope = 'cursor',
}

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        if has_float() then return end
        vim.diagnostic.open_float(nil, floating_opts)
    end
})

vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grt')

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<leader>o', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

        vim.keymap.set('i', '<C-s>', function() vim.lsp.buf.signature_help(floating_opts) end, opts)
        vim.keymap.set('n', 'K', function () vim.lsp.buf.signature_help(floating_opts) end, opts)

        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
        if client.name == 'ty' then
            vim.lsp.inlay_hint.enable(false)
        end
        if client:supports_method('textDocument/completion') then
            local chars = {}; for i = 33, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, event.buf, {
                autotrigger = true,
            })

            vim.cmd [[set completeopt+=menuone,noinsert,popup]]

            vim.keymap.set({ 'i', 's' }, '<C-f>', function()
                if vim.snippet.active({ direction = 1 }) then
                    vim.snippet.jump(1)
                end
            end, { expr = false, silent = true })

            vim.keymap.set({ 'i', 's' }, '<C-d>', function()
                if vim.snippet.active({ direction = -1 }) then
                    vim.snippet.jump(-1)
                end
            end, { expr = false, silent = true })

            vim.keymap.set({ 'i', 's' }, '<Tab>', function()
                if vim.fn.pumvisible() == 1 then
                    return "<C-y>"
                else
                    return "<Tab>"
                end
            end, { expr = true, silent = true })

            vim.keymap.set({ 'i', 's' }, '<CR>', function()
                if vim.fn.pumvisible() == 1 then
                    return "<C-e><CR>"
                else
                    return "<CR>"
                end
            end, { expr = true, silent = true, noremap = true })
        end
    end
})

vim.diagnostic.config({
    virtual_text = false,
})
