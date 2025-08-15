return {
	"lukas-reineke/virt-column.nvim",
	event = "BufReadPost",
	config = function()
		vim.opt.colorcolumn = ""

		local columns = "100"

		local gray = "#444444"
		local green = "#00ff88"
		local accent = "#cc00ff"

		require("virt-column").setup({
			char = "█",
			virtcolumn = columns,
			highlight = "VirtColumn",
		})

		vim.api.nvim_set_hl(0, "VirtColumn", { fg = gray })

		local aug = vim.api.nvim_create_augroup("VirtColumnMode", { clear = true })

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = aug,
			callback = function()
				vim.api.nvim_set_hl(0, "VirtColumn", { fg = gray })
			end,
		})

		vim.api.nvim_create_autocmd("ModeChanged", {
			group = aug,
			callback = function(args)
				local m = vim.api.nvim_get_mode().mode
				if m:match("^[vV\22]") then
					vim.api.nvim_set_hl(0, "VirtColumn", { fg = accent })
				elseif m:match("^i") then
					vim.api.nvim_set_hl(0, "VirtColumn", { fg = green })
				else
					vim.api.nvim_set_hl(0, "VirtColumn", { fg = gray })
				end
			end,
		})
	end,
}
