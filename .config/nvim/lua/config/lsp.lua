vim.lsp.enable('luals')
vim.lsp.enable('ruff')
vim.lsp.enable('clangd')
-- vim.lsp.enable('basedpyright')
-- vim.lsp.enable('pyright')
vim.lsp.enable('zls')
vim.lsp.enable('ty')
-- vim.lsp.enable('pyrefly')
vim.lsp.enable('termux_language_server')

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
vim.keymap.del('n', 'gO')

local function gd_jump_first()
    local params = vim.lsp.util.make_position_params(0, "utf-16")

    vim.lsp.buf_request(0, "textDocument/definition", params, function(err, locations, ctx, _)
        if err then
            vim.notify(err.message or tostring(err), vim.log.levels.ERROR)
            return
        end

        if locations == nil then
            return
        end

        if #locations == 1 then
            vim.lsp.util.show_document(locations[1], "utf-16", { focus = true })
            return
        end

        local items = vim.lsp.util.locations_to_items(locations, "utf-16")
        vim.fn.setqflist({}, " ", { title = "LSP definitions", items = items })

        vim.lsp.util.show_document(locations[1], "utf-16", { focus = true })

        local win = vim.api.nvim_get_current_win()

        vim.cmd.copen(math.max(5, math.min(10, #locations)))

        vim.api.nvim_set_current_win(win)
        vim.cmd.normal({ 'zz', bang = true })
    end)
end

vim.keymap.set("n", "gd", gd_jump_first, { desc = "LSP definition: jump first, keep qf for multiple" })

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server

        -- vim.keymap.set('n', 'K',
        --     '<cmd>lua vim.lsp.buf.hover()<cr>',
        --     { buffer = event.buf, desc = "Show docs" }
        -- )
        -- vim.keymap.set('n', 'gd',
        --     '<cmd>lua vim.lsp.buf.definition()<cr>',
        --     { buffer = event.buf, desc = "Go to definition" }
        -- )
        vim.keymap.set("n", "gd", gd_jump_first, { silent = true })

        vim.keymap.set('n', 'gD',
            '<cmd>lua vim.lsp.buf.declaration()<cr>',
            { buffer = event.buf, desc = "Go to declaration" }
        )
        vim.keymap.set('n', 'gi',
            '<cmd>lua vim.lsp.buf.implementation()<cr>',
            { buffer = event.buf, desc = "Go to implementation" }
        )
        vim.keymap.set('n', 'go',
            '<cmd>lua vim.lsp.buf.type_definition()<cr>',
            { buffer = event.buf, desc = "Go to type definition" }
        )
        vim.keymap.set('n', 'gr',
            '<cmd>lua vim.lsp.buf.references()<cr>',
            { buffer = event.buf, desc = "Go to references" }
        )
        -- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { buffer = event.buf, desc = "Show signature" })
        vim.keymap.set('n', 'gn',
            '<cmd>lua vim.lsp.buf.rename()<cr>',
            { buffer = event.buf, desc = "Rename" }
        )
        vim.keymap.set({ 'n', 'x' }, '<leader>o',
            '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
            { buffer = event.buf, desc = "Format file" }
        )
        vim.keymap.set('n', 'ga',
            '<cmd>lua vim.lsp.buf.code_action()<cr>',
            { buffer = event.buf, desc = "Show code actions" }
        )

        vim.keymap.set('i', '<C-s>',
            function()
                vim.lsp.buf.signature_help(floating_opts)
            end,
            { buffer = event.buf, desc = "Show docs" }
        )
        vim.keymap.set('n', 'K',
            function()
                vim.lsp.buf.signature_help(floating_opts)
            end,
            { buffer = event.buf, desc = "Show docs" }
        )

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
