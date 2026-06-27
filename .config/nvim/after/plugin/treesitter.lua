local exts = {
  "c", "vim", "vimdoc", "query",
  "python", "zig", "c_sharp", "cpp", "haskell",
  "html", "css", "javascript", "typescript",
  "lua", "bash",
}

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local treesitter = require('nvim-treesitter')
        local lang = vim.treesitter.language.get_lang(args.match)
        if vim.list_contains(treesitter.get_available(), lang) then
            if not vim.list_contains(treesitter.get_installed(), lang) then
                treesitter.install(lang):wait()
            end
            vim.treesitter.start(args.buf)
        end
    end,
    desc = "Enable nvim-treesitter and install parser if not installed"
})
