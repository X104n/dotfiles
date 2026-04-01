return {
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Keymaps available whenever an LSP attaches to a buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }
                    vim.keymap.set("n", "gd",         vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K",           vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn",  vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca",  vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr",          vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>e",   vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d",          vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d",          vim.diagnostic.goto_next, opts)
                end,
            })

            lspconfig.lua_ls.setup({ capabilities = capabilities })
        end
    }
}
