local M = {}

function M.register_autocommands(mappings)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = "*.todo",
		callback = function()
			vim.bo.filetype = "todo"
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "todo",
		callback = function()
			local opts = { noremap = true, silent = true }
			for keys, func in pairs(mappings) do
				vim.api.nvim_buf_set_keymap(
					0,
					"n",
					keys,
					string.format("<cmd>lua require('todo').%s()<CR>", func),
					opts
				)
			end

			vim.defer_fn(function()
				local has_syntax, syntax = pcall(require, "todo.syntax")
				if has_syntax then
					syntax.setup()
				else
					print("Warning: `todo.syntax` module not found.")
				end
			end, 100)
		end,
	})
end

return M
