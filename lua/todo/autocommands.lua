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

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.todo",
		callback = function()
			local todo = require("todo")
			if todo.is_filtered() then
				local choice = vim.fn.confirm(
					"You are saving while a filter is active.\nSome tasks are hidden and won't be saved.\nRestore all tasks before saving?",
					"&Yes\n&No",
					2
				)
				if choice == 2 then
					-- If the user chose "No" (2), restore all tasks
					todo.restore_all()
					-- Now the save continues showing all tasks
				end
				-- If the user chose "Yes" (1), we don't do anything,
				-- the save will continue with the current filter
			end
		end,
	})
end
return M
