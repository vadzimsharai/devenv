return {
    "AstroNvim/astrolsp",

    opts = {

        features = {
            codelens = true,
            inlay_hints = true,
            semantic_tokens = true,
        },

        -- formatting = {
        --     format_on_save = {
        --         enabled = false,
        --         allow_filetypes = {},
        --         ignore_filetypes = {}
        --     },
        --     disabled = {},
        --     timeout_ms = 1000

        -- },

        -- servers = {},

        -- config = {},

        -- handlers = {},

        -- autocmds = {eslint_fix_on_save = true}

        --     lsp_codelens_refresh = {

        --         cond = "textDocument/codeLens",

        --         {

        --             event = {"InsertLeave", "BufEnter"},

        --             desc = "Refresh codelens (buffer)",
        --             callback = function(args)
        --                 if require("astrolsp").config.features.codelens then
        --                     vim.lsp.codelens.refresh {bufnr = args.buf}
        --                 end
        --             end
        --         }
        --     }
        -- },

        -- mappings = {
        --     n = {

        --         gD = {
        --             function() vim.lsp.buf.declaration() end,
        --             desc = "Declaration of current symbol",
        --             cond = "textDocument/declaration"
        --         },
        --         ["<Leader>uY"] = {
        --             function()
        --                 require("astrolsp.toggles").buffer_semantic_tokens()
        --             end,
        --             desc = "Toggle LSP semantic highlight (buffer)",
        --             cond = function(client)
        --                 return
        --                     client.supports_method "textDocument/semanticTokens/full" and
        --                         vim.lsp.semantic_tokens ~= nil
        --             end
        --         }
        --     }
        -- },

        -- on_attach = function(client, bufnr) end
    }
}
