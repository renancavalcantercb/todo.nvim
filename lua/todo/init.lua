local M = {}

local function add_todo_item()
	vim.api.nvim_put({ "[ ] " }, "c", true, true)
end

local function check_task()
	local line = vim.fn.getline(".")
	if not line:match("%[ %]") then
		print("No pending task on this line.")
		return
	end
	local new_line = line:gsub("%[ %]", "[x]")
	vim.fn.setline(".", new_line)
end

local function mark_in_progress()
	local line = vim.fn.getline(".")
	if not line:match("%[ %]") then
		print("No pending task on this line.")
		return
	end
	local new_line = line:gsub("%[ %]", "[-]")
	vim.fn.setline(".", new_line)
	print("Task marked as in progress.")
end

local function reset_task()
	local line = vim.fn.getline(".")
	local new_line = line:gsub("%[.]", "[ ]")
	vim.fn.setline(".", new_line)
end

local function edit_task_description()
	vim.cmd("normal! ^f]a ")
end

local function count_tasks()
	local lines = vim.fn.getbufline(vim.fn.bufnr("%"), 1, "$")
	local total, completed, in_progress = 0, 0, 0
	for _, line in ipairs(lines) do
		if line:match("%[ %]") then
			total = total + 1
		elseif line:match("%[x%]") then
			completed = completed + 1
		elseif line:match("%[%-]") then
			in_progress = in_progress + 1
		end
	end
	print(
		"Task Summary:\n"
			.. "  Total: "
			.. total
			.. "\n"
			.. "  Completed: "
			.. completed
			.. "\n"
			.. "  In Progress: "
			.. in_progress
	)
end

local function toggle_task_state()
	local state_map = {
		["[ ]"] = "[-]",
		["[-]"] = "[x]",
		["[x]"] = "[ ]",
	}

	local line = vim.fn.getline(".")
	local current_state = line:match("%[.?.?%]")

	if current_state and state_map[current_state] then
		local new_line = line:gsub("%[.?.?%]", state_map[current_state])
		vim.fn.setline(".", new_line)
		print("Task state toggled to: " .. state_map[current_state])
	else
		print("No valid task format found on this line.")
	end
end

local function create_autocommands()
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
			vim.api.nvim_buf_set_keymap(0, "n", "<Leader>c", "<cmd>lua require('todo').count_tasks()<CR>", opts)
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<Leader>]",
				"<cmd>lua require('todo').edit_task_description()<CR>",
				opts
			)
			vim.api.nvim_buf_set_keymap(0, "n", "<Leader>t", "<cmd>lua require('todo').toggle_task_state()<CR>", opts)
		end,
	})
end

function M.setup()
	create_autocommands()

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "todo",
		callback = function()
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

M.add_todo_item = add_todo_item
M.check_task = check_task
M.mark_in_progress = mark_in_progress
M.reset_task = reset_task
M.edit_task_description = edit_task_description
M.count_tasks = count_tasks
M.toggle_task_state = toggle_task_state

return M
