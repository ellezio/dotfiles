local deps = {
	{
		"j-hui/fidget.nvim",

		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},

	"folke/neodev.nvim",
	"folke/neoconf.nvim",
}

if IsNixOS == false then
	table.insert(deps, "williamboman/mason.nvim")
	table.insert(deps, "williamboman/mason-lspconfig.nvim")
end

return {
	{
		"neovim/nvim-lspconfig",

		dependencies = deps,

		config = function()
			require("neoconf").setup()
			require("neodev").setup()

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local nmap = function(keys, func, desc)
						if desc then
							desc = "LSP: " .. desc
						end

						vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
					end

					nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					nmap("<leader>ca", function()
						vim.lsp.buf.code_action({ context = { diagnostics = {}, only = { "quickfix", "refactor", "source" } } })
					end, "[C]ode [A]ction")

					local telescope_builtin = require("telescope.builtin")
					nmap("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")
					nmap("gr", telescope_builtin.lsp_references, "[G]oto [R]eferences")
					nmap("gI", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation")
					nmap("<leader>D", telescope_builtin.lsp_type_definitions, "Type [D]efinition")
					nmap("<leader>ds", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
					nmap("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

					local hover_handler = function(args)
						args = args or {}
						args.border = "rounded"
						vim.lsp.buf.hover(args)
					end
					nmap("K", hover_handler, "Hover Documentation")

					local signature_help_handler = function(args)
						args = args or {}
						args.border = "rounded"
						vim.lsp.buf.signature_help(args)
					end
					nmap("<C-s>", signature_help_handler, "Signature Documentation")
					vim.keymap.set("i", "<C-s>", signature_help_handler, { buffer = ev.buf })

					nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
					nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
					nmap("<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, "[W]orkspace [L]ist Folders")

					vim.api.nvim_buf_create_user_command(ev.buf, "Format", function(_)
						vim.lsp.buf.format()
					end, { desc = "Format current buffer with LSP" })
				end,
			})

			local lspconfig = require("lspconfig")

			local servers = {
				nil_ls = {},
				lua_ls = {},
				gopls = {},
				templ = {},
				tailwindcss = {},
				html = {
					filetypes = { "html", "gotmpl", "templ" },
				},
				htmx = {
					filetypes = { "html", "gotmpl", "templ" },
				},
				jsonls = {
					settings = {
						schemas = {
							{
								fileMatch = { "tsconfig*.json" },
								url = "https://json.schemastore.org/tsconfig.json",
							},
						},
					},
				},
				cssls = {},
				rust_analyzer = {},
				clangd = {},
				ts_ls = {
					root_dir = lspconfig.util.root_pattern("package.json"),
					-- single_file_support = false,
				},
				-- denols = {
				-- 	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
				-- },

				intelephense = {
					single_file_support = true,
					settings = {
						intelephense = {
							environment = {
								phpVersion = os.getenv("PHP_VERSION") or "7.3",
							},
						},
					},
				},
			}

			vim.filetype.add({ extension = { templ = "templ", gotmpl = "gotmpl" } })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			vim.diagnostic.config({
				float = {
					border = "rounded",
				},
			})

			if IsNixOS then
				for server_name, server in pairs(servers) do
					server = server or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					lspconfig[server_name].setup(server)
				end
			else
				require("mason").setup()
				require("mason-lspconfig").setup({
					ensure_installed = {},
					automatic_enable = true,
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}
							server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							lspconfig[server_name].setup(server)
						end,
					},
				})
			end
		end,
	},
}
