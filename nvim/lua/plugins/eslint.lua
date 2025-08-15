return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				eslint_d = {
					on_attach = function(client, bufnr)
						client.handlers["window/showMessage"] = function() end
					end,
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, { "eslint_d" })
		end,
	},
}
