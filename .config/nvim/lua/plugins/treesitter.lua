return {
	{
		"nvim-treesitter/nvim-treesitter",

		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},

		build = ":TSUpdate",

		config = function()
			vim.defer_fn(function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"go",
						"lua",
						"rust",
						"tsx",
						"javascript",
						"typescript",
						"vimdoc",
						"vim",
						"bash",
						"php",
						"templ",
						"c",
						"gotmpl",
						"html",
					},

					ignore_install = {},

					auto_install = false,
					sync_install = false,

					modules = {},

					highlight = {
						enable = true,
						disable = function(_, bufnr)
							local buf_name = vim.api.nvim_buf_get_name(bufnr)
							local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
							return file_size > 256 * 1024
						end,
					},

					indent = {
						enable = true,
						disable = function(_, bufnr)
							local buf_name = vim.api.nvim_buf_get_name(bufnr)
							local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
							return file_size > 256 * 1024
						end,
					},

					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "<c-space>",
							node_incremental = "<c-space>",
							scope_incremental = "<c-s>",
							node_decremental = "<M-space>",
						},
					},
					textobjects = {
						select = {
							enable = true,
							lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
							keymaps = {
								-- You can use the capture groups defined in textobjects.scm
								["aa"] = "@parameter.outer",
								["ia"] = "@parameter.inner",
								["af"] = "@function.outer",
								["if"] = "@function.inner",
								["ac"] = "@class.outer",
								["ic"] = "@class.inner",
							},
						},
						move = {
							enable = true,
							set_jumps = true, -- whether to set jumps in the jumplist
							goto_next_start = {
								["]m"] = "@function.outer",
								["]]"] = "@class.outer",
							},
							goto_next_end = {
								["]M"] = "@function.outer",
								["]["] = "@class.outer",
							},
							goto_previous_start = {
								["[m"] = "@function.outer",
								["[["] = "@class.outer",
							},
							goto_previous_end = {
								["[M"] = "@function.outer",
								["[]"] = "@class.outer",
							},
						},
						-- swap = {
						-- 	enable = true,
						-- 	swap_next = {
						-- 		['<leader>a'] = '@parameter.inner',
						-- 	},
						-- 	swap_previous = {
						-- 		['<leader>A'] = '@parameter.inner',
						-- 	},
						-- },
					},
				})
			end, 0)
		end,
	},
}
