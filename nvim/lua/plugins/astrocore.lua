return {
	"AstroNvim/astrocore",

	opts = {
		features = {
			large_buf = { size = 1024 * 256, lines = 10000 },
			autopairs = true,
			cmp = true,
			diagnostics = {
				virtual_text = false,
				virtual_lines = true,
				underline = true,
			},
			highlighturl = true,
			notifications = true,
		},

		diagnostics = {
			virtual_text = true,
			virtual_lines = true,
			underline = true,
		},

		options = {
			opt = {
				relativenumber = true,
				number = true,
				spell = false,
				signcolumn = "yes",
				wrap = false,
				clipboard = "unnamedplus",
			},
			g = { clipboard = "osc52" },
		},

		rooter = {
			autochdir = true,
			-- scope of working directory to change ("global"|"tab"|"win")
			scope = "global",
			-- show notification on every working directory change
			notify = false,
		},

		mappings = {

			n = {
				-- BASIC NAVIGATION & EDITING
				["<leader>rr"] = {
					":%s/\\v//gc<Left><Left><Left><Left>",
					desc = "Replace All (prompt)",
				},

				["<C-s>"] = { "<cmd>w<CR>", desc = "save file" },
				["<C-a>"] = {
					"ggVG",
					desc = "select all and keep cursor position",
				},
				["<C-d>"] = { "<cmd>t.<CR>", desc = "duplicate line" },
				["<leader>reg"] = {
					"<cmd>registers<CR>",
					desc = "open registers",
				},

				["<leader><Tab>"] = { "<C-w>w", desc = "Switch to next window" },
				["<leader><S-Tab>"] = {
					"<C-w>W",
					desc = "Switch to previous window",
				},

				["<C-Right>"] = { "e", desc = "move to next word" },
				["<C-Left>"] = { "b", desc = "move to previous word" },
				["<C-Up>"] = { "10k", desc = "scroll up" },
				["<C-Down>"] = {
					"10j",
					desc = "scroll down",
				},

				["<C-S-Left>"] = { "^", desc = "move to start of line" },
				["<C-S-Right>"] = { "g_", desc = "move to end of line" },

				["<C-z>"] = { "<cmd>undo<CR>", desc = "undo last action" },
				["<C-r>"] = { "<cmd>redo<CR>", desc = "redo last action" },

				["d"] = { '"_d', desc = "delete without yanking" },
				["<DEL>"] = { '"_dl', desc = "delete without yanking" },
				["<BS>"] = { '"_dh', desc = "delete without yanking" },
				["<C-Del>"] = { '"_dw', desc = "delete word forward" },
				["<C-S-Del>"] = { '"_db', desc = "delete word backward" },

				["<leader>w"] = { "<cmd>w<CR>", desc = "save file" },
				["<leader>qq"] = { "<cmd>bd<CR>", desc = "Close buffer" },
				["<leader>qa"] = { "<cmd>bufdo bd<CR>", desc = "Close all buffers" },
				["<leader>qo"] = { "<cmd>%bd|e#|bd#<CR><CR>", desc = "Close other buffers" },

				-- WINDOW NAVIGATION
				["<C-w>z"] = { "<Cmd>WindowsMaximize<CR>" },
				["<C-w>_"] = { "<Cmd>WindowsMaximizeVertically<CR>" },
				["<C-w>|"] = { "<Cmd>WindowsMaximizeHorizontally<CR>" },
				["<C-w>="] = { "<Cmd>WindowsEqualize<CR>" },

				-- TERMINAL
				["<leader>tt"] = {
					"<cmd>terminal<CR><cmd>startinsert<CR>",
					desc = "Open terminal as tab",
				},
				["<leader>st"] = {
					"<cmd>!tmux new-window -- nvim +':terminal' +'startinsert'<CR><CR>",
					desc = "Open terminal in tmux window",
				},
				["<leader>sv"] = {
					"<cmd>!tmux new-window -- nvim<CR><CR>",
					desc = "Open nvim in tmux window",
				},

				-- WHICH KEY
				["<leader>wka"] = { "<cmd>WhichKey<CR>", desc = "which key all" },
				["<leader>wkq"] = {
					function()
						vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
					end,
					desc = "which key query",
				},

				-- AI

				-- ["<leader>cp"] = { "<cmd>Copilot panel<CR>", desc = "Copilot panel" },

				-- Requests (Kulala)
				["<leader>kb"] = {
					function()
						require("kulala").scratchpad()
					end,
					desc = "Open scratchpad",
				},
				["<leader>ko"] = {
					function()
						require("kulala").open()
					end,
					desc = "Open Kulala",
				},
				["<leader>kq"] = {
					function()
						require("kulala").close()
					end,
					desc = "Close window",
				},
				["<leader>kt"] = {
					function()
						require("kulala").toggle_view()
					end,
					desc = "Toggle headers/body",
				},
				["<leader>kS"] = {
					function()
						require("kulala").show_stats()
					end,
					desc = "Show stats",
				},
				["<leader>kc"] = {
					function()
						require("kulala").copy()
					end,
					desc = "Copy as cURL",
				},
				["<leader>kC"] = {
					function()
						require("kulala").from_curl()
					end,
					desc = "Paste from cURL",
				},
				["<leader>kk"] = {
					function()
						require("kulala").run()
					end,
					desc = "execute request",
				},
				["<leader>kr"] = {
					function()
						require("kulala").replay()
					end,
					desc = "Replay last request",
				},
				["<leader>ki"] = {
					function()
						require("kulala").inspect()
					end,
					desc = "Inspect current request",
				},
				["<leader>kf"] = {
					function()
						require("kulala").search()
					end,
					desc = "Find request",
				},
				["<leader>kn"] = {
					function()
						require("kulala").jump_next()
					end,
					desc = "Jump to next request",
				},
				["<leader>kp"] = {
					function()
						require("kulala").jump_prev()
					end,
					desc = "Jump to previous request",
				},
				["<leader>ke"] = {
					function()
						require("kulala").set_selected_env()
					end,
					desc = "Select environment",
				},
				["<leader>ku"] = {
					function()
						require("lua.kulala.ui.auth_manager").open_auth_config()
					end,
					desc = "Manage auth config",
				},
				["<leader>kg"] = {
					function()
						require("kulala").download_graphql_schema()
					end,
					desc = "Download GraphQL schema",
				},
				["<leader>kx"] = {
					function()
						require("kulala").scripts_clear_global()
					end,
					desc = "Clear globals",
				},
				["<leader>kX"] = {
					function()
						require("kulala").clear_cached_files()
					end,
					desc = "Clear cached files",
				},

				-- Explorer

				["<C-e>"] = {
					"<leader>e",
					desc = "Toggle Explorer",
					remap = true,
				},

				-- search (Spectre)
				["<C-S>f"] = {
					'<cmd>lua require("spectre").toggle()<CR>',
					desc = "Toggle Spectre",
				},
				["<C-f>"] = {
					'<cmd>lua require("spectre").open_file_search()<CR>',
					desc = "Search on current file",
				},

				["<leader>m"] = {
					"<cmd>WindowsMaximize<CR>",
					desc = "Maximize window",
				},

				-- AstroNvim buffer navigation
				["<leader>]"] = {
					function()
						require("astrocore.buffer").nav(vim.v.count1)
					end,
					desc = "Next buffer",
				},
				["<leader>["] = {
					function()
						require("astrocore.buffer").nav(-vim.v.count1)
					end,
					desc = "Previous buffer",
					remap = true,
					silent = true,
				},
				["<C-g>"] = {
					"<cmd>lua vim.lsp.buf.hover()<CR>",
					desc = "show type or declaration info under cursor",
				},
			},
			v = {

				["<C-Right>"] = { "w", desc = "move to next word" },
				["<C-Left>"] = { "b", desc = "move to previous word" },
				["<C-Up>"] = { "10k", desc = "scroll up" },
				["<C-Down>"] = {
					"10j",
					desc = "scroll down",
				},

				["<C-S-Left>"] = { "^", desc = "move to start of line" },
				["<C-S-Right>"] = { "g_", desc = "move to end of line" },

				["<C-z>"] = { "<cmd>undo<CR>", desc = "undo last action" },
				["<C-r>"] = { "<cmd>redo<CR>", desc = "redo last action" },
				["d"] = { '"_d', desc = "delete without yanking" },
				["<DEL>"] = { '"_dl', desc = "delete without yanking" },

				["<leader>/"] = { "gc", desc = "toggle comment", remap = true },
				["<C-c>"] = { '"+y', desc = "copy to clipboard" },
				["<C-d>"] = { "<cmd>t.<CR>", desc = "duplicate line" },
			},
			t = {
				["<ESC>"] = { "<C-\\><C-N>", desc = "terminal escape" },
				["ii"] = { "<C-\\><C-N>", desc = "terminal escape" },
				["<C-q>"] = {
					function()
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, false, true),
							"n",
							false
						)
						vim.cmd("q")
					end,
					desc = "close terminal",
				},
			},
			i = {
				["ii"] = {
					"<ESC><Right>",
					desc = "exit to normal mode",
				},
				["<C-g>"] = {
					function()
						vim.lsp.buf.hover()
					end,
					desc = "show type or declaration info under cursor",
				},
				["<C-s>"] = { "<cmd>w<CR>", desc = "save file" },
				["<C-a>"] = {
					"<ESC>ggVG",
					desc = "select all and keep cursor position",
				},
				["<C-d>"] = { "<cmd>t.<CR>", desc = "duplicate line" },

				["<C-Del>"] = { "dw", desc = "delete word forward" },
				["<C-S-Del>"] = { "db", desc = "delete word backward" },

				["<C-z>"] = { "<cmd>undo<CR>", desc = "undo last action" },
				["<C-r>"] = { "<cmd>redo<CR>", desc = "redo last action" },
				["<C-Up>"] = {
					function()
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes("<C-o><C-y>", true, false, true),
							"n",
							false
						)
					end,
					desc = "scroll up without moving cursor",
				},
				["<C-Down>"] = {
					function()
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes("<C-o><C-e>", true, false, true),
							"n",
							false
						)
					end,
					desc = "scroll down without moving cursor",
				},

				["<C-S-Left>"] = {
					function()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>^", true, false, true), "n", false)
					end,
					desc = "move to start of line",
				},
				["<C-S-Right>"] = {
					function()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>g_", true, false, true), "n", false)
					end,
					desc = "move to end of line",
				},
			},
		},
	},
}
