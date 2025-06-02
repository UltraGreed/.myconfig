local lsp_zero = require('lsp-zero')

lsp_zero.preset("recommended")

lsp_zero.setup_servers({
    'zls',  -- zig LSP

    'ruff', -- python linter and formatter
    -- 'pylsp', -- only used as LSP interface for mypy - type checker
    -- 'pyre', -- type checker
    'pyright',         -- type checker
    -- 'jedi_language_server', -- completions

    -- 'clangd',               -- c/cpp LSP

    'cssls',                -- css/html LSPs
    'html',

    'ts_ls', -- typescript LSP

    'hls', -- haskell

    'lua_ls',   -- lua LSP

    'taplo'     -- toml LSP
})


-- Fix Undefined global 'vim'
lsp_zero.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }

    -- Rebinds
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>o", function() vim.lsp.buf.format() end, opts)

    -- Show hint in floating window on hover
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end)

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-d>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

lsp_zero.setup()

vim.diagnostic.config({
    virtual_text = true
})


