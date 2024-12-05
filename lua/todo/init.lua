local M = {}

local function add_todo_item()
	vim.api.nvim_put({ "[ ] " }, "c", true, true)
end

local function check_task()
	local line = vim.fn.getline(".")
	local new_line = line:gsub("%[ %]", "[x]")
	vim.fn.setline(".", new_line)
end

local function mark_in_progress()
	local line = vim.fn.getline(".")
	local new_line = line:gsub("%[ %]", "[-]")
	vim.fn.setline(".", new_line)
end

local function reset_task()
	local line = vim.fn.getline(".")
	local new_line = line:gsub("%[.]", "[ ]")
	vim.fn.setline(".", new_line)
end

local function edit_task_description()
	vim.cmd("normal! ^f]a ")
end

function M.setup()
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
			vim.api.nvim_buf_set_keymap(0, "n", "<Leader>[", "<cmd>lua require('todo').add_todo_item()<CR>", opts)
			vim.api.nvim_buf_set_keymap(0, "n", "<Leader>x", "<cmd>lua require('todo').check_task()<CR>", opts)
			vim.api.nvim_buf_set_keymap(0, "n", "<Leader>-", "<cmd>lua require('todo').mark_in_progress()<CR>", opts)
			vim.api.nvim_buf_set_keymap(0, "n", "<Leader><Leader>", "<cmd>lua require('todo').reset_task()<CR>", opts)
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<Leader>]",
				"<cmd>lua require('todo').edit_task_description()<CR>",
				opts
			)
		end,
	})
end

M.add_todo_item = add_todo_item
M.check_task = check_task
M.mark_in_progress = mark_in_progress
M.reset_task = reset_task
M.edit_task_description = edit_task_description

return M
