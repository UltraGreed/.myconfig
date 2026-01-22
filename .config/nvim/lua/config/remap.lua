--  explore command on space-pv
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc = "Explore filesystem"})

-- allows to drag selection up and down with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keeps cursor in place during J C-d/u n/N
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- space-p pastes over selection without losing buffer
vim.keymap.set("x", "<leader>pp", "\"_dP", { desc = "Paste preserving buffer" })

-- yank with space to use system buffer
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")

-- delete without overwriting buffer
-- vim.keymap.set("n", "<leader>d", "\"_d")
-- vim.keymap.set("v", "<leader>d", "\"_d")

-- handle missclicks
vim.api.nvim_create_user_command("W", 'w', {})
vim.api.nvim_create_user_command("Wq", 'wq', {})
vim.api.nvim_create_user_command("Q", 'q', {})

-- disables Q - Ex mode (what?)
vim.keymap.set("n", "Q", "<nop>")

-- disables ZZ - save and close
vim.keymap.set("n", "ZZ", "<nop>")

-- disables q: - vim command line history
vim.keymap.set("n", "q:", "<nop>")

-- disables q/ q? - vim search history
vim.keymap.set("n", "q/", "<nop>")
vim.keymap.set("n", "q?", "<nop>")

-- disable annoying <F1> help menu (escape missclick)
vim.keymap.set({ 'n', 'v', 'i' }, '<F1>', "<nop>")

-- tmux call
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- quickfix list
-- vim.keymap.set("n", "<CR>", "<CR>", { noremap = true })
-- vim.keymap.set("n", "<Tab>", "<Tab>", { noremap = true })
vim.keymap.set("n", "<C-m>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-i>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>m", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>i", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>q", "<cmd>ccl<CR>", { desc = "Close quickfix list" })


-- substitute on space-s
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Substitute word" })
-- chmod +x on space-x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- fold/unfold under cursor
-- vim.keymap.set("n", "<leader>f", "zA", { silent = true })

-- something-something I don't know therefore I hate it
vim.keymap.set("n", "<C-f>", "<nop>")

-- disable highlighting of last search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true, desc = "Disable search highlighting" })

-- delete last word
-- vim.keymap.set("i", "<C-H>", "<C-w>", { silent = true})

-- Execute python/zig code from current tmux pane in pane with index 1
vim.keymap.set('n', '<leader>r', function()
    vim.cmd('write')                 -- Save the file
    local file = vim.fn.expand("%")
    local ext = vim.fn.expand("%:e") -- Get file extension
    local cmd
    if ext == 'py' then
        cmd = 'tmux send-keys -t 1 C-c "python ' .. file .. '" Enter'
    elseif ext == 'tex' then
        cmd = 'tmux send-keys -t 1 C-c "xelatex --shell-escape ' .. file .. '" Enter'
    elseif ext == 'zig' or ext == 'zon' then
        cmd = 'tmux send-keys -t 1 C-c "zig build run" Enter'
    elseif ext == 'c' or ext == 'h' then
        cmd = 'tmux send-keys -t 1 C-c "meson compile -C build && ./build/main" Enter'
    else
        print("Unsupported file type: " .. ext)
        return
    end

    local clear_cmd = 'tmux send-keys -t 1 -X cancel'
    vim.fn.system(clear_cmd)

    vim.fn.system(cmd)
end, { noremap = true, silent = true, desc = "Run program" })

-- Test zig code from current tmux pane in pane with index 1
vim.keymap.set('n', '<leader>t', function()
    vim.cmd('write')                 -- Save the file
    local file = vim.fn.expand("%")
    local ext = vim.fn.expand("%:e") -- Get file extension
    local cmd
    if ext == 'zig' or ext == 'zon' then
        cmd = 'tmux send-keys -R -t 1 "zig build test --summary all" Enter '
    elseif ext == 'c' or ext == 'h' then
        cmd = 'tmux send-keys -t 1 C-c "meson test -C build" Enter'
    else
        print("Unsupported file type: " .. ext)
        return
    end

    local clear_cmd = 'tmux send-keys -t 1 -X cancel'
    vim.fn.system(clear_cmd)

    vim.fn.system(cmd)
end, { noremap = true, silent = true, desc = "Run tests" })

vim.keymap.set('n', '<leader>d', function()
    vim.cmd('write')                 -- Save the file
    local file = vim.fn.expand("%")
    local ext = vim.fn.expand("%:e") -- Get file extension
    local cmd
    if ext == 'c' or ext == 'h' then
        cmd = 'tmux send-keys -t 1 C-c "meson compile -C build && gdb ./build/main" Enter'
    elseif ext == 'zig' or ext == 'zon' then
        cmd = 'tmux send-keys -t 1 C-c "zig build && gdb ./zig-out/bin/main" Enter'
    else
        print("Unsupported file type: " .. ext)
        return
    end

    local clear_cmd = 'tmux send-keys -t 1 -X cancel'
    vim.fn.system(clear_cmd)

    vim.fn.system(cmd)
end, { noremap = true, silent = true, desc = "Run debug" })

vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set('v', 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set('v', 'k', 'gk', { noremap = true, silent = true })
