vim.keymap.set("n", "<leader>z", function()
    require("zen-mode").setup {
        window = {
            width = 126,
            options = {}
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.nu = true
    -- ColorMyPencils()
end)


vim.keymap.set("n", "<leader>Z", function()
    require("zen-mode").setup {
        window = {
            width = 122,
            options = {}
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = false
    vim.wo.nu = false
    vim.opt.colorcolumn = "0"
    -- ColorMyPencils()
end)
