return {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    init_options = {
        settings = {
            configuration = '~/.config/lsp/ruff.toml'
        }
    },
    root_markers = { 'pyproject.toml', '.git' }
}
