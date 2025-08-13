local cmp = require('cmp')
-- local cmp_action = lsp_zero.cmp_action()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
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
        -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        -- ['<C-d>'] = cmp_action.luasnip_jump_backward(),

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


