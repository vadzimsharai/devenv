return {
    -- "copilotlsp-nvim/copilot-lsp",
    -- init = function()
    --     vim.g.copilot_nes_debounce = 500
    --     vim.lsp.enable "copilot"
    --     vim.keymap.set("n", "<tab>", function()
    --         require("copilot-lsp.nes").apply_pending_nes()
    --     end)
    -- end,

    {
        "yetone/avante.nvim",
        build = "make",
        event = "VeryLazy",
        lazy = false,
        version = false,
        opts = {
            provider = "copilot",
            providers = {copilot = {model = "claude-3.7-sonnet"}},
            selector = {provider = "snacks"}
        }
    }, {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = {enabled = false},
            panel = {enabled = false},
            filetypes = {markdown = true, help = true}
        }
    }, {
        "saghen/blink.cmp",
        optional = true,
        dependencies = {"fang2hou/blink-copilot"},
        opts = {
            sources = {
                default = {"copilot"},
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true
                    }
                }
            }
        }
    }
}
