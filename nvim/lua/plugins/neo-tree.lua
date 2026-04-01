return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            window = { position = "left", width = 30 },
            filesystem = {
                follow_current_file = { enabled = true },  -- highlights open file in tree
                hijack_netrw_behavior = "open_current",
            },
        })

        vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", { silent = true })

        -- Auto-open when nvim starts with no file arguments
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                if vim.fn.argc(-1) == 0 then
                    vim.cmd("Neotree show")
                end
            end,
        })
    end
}

