local M = {}

function M.add_todo_item()
	vim.api.nvim_put({ "[ ] " }, "c", true, true)
end

local function update_task_state(pattern, replacement, message)
	local line = vim.fn.getline(".")
	if not line:match(pattern) then
		print("No valid task found on this line.")
		return
	end
	local new_line = line:gsub(pattern, replacement)
	vim.fn.setline(".", new_line)
	if message then
		print(message)
	end
end

function M.check_task()
	update_task_state("%[ %]", "[x]", "Task marked as completed.")
end

function M.mark_in_progress()
	update_task_state("%[ %]", "[-]", "Task marked as in progress.")
end

function M.reset_task()
	update_task_state("%[.]", "[ ]", "Task reset to pending.")
end

function M.toggle_task_state()
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

function M.count_tasks()
	local lines = vim.fn.getbufline(vim.fn.bufnr("%"), 1, "$")
	local summary = { total = 0, completed = 0, in_progress = 0 }

	for _, line in ipairs(lines) do
		if line:match("%[ %]") then
			summary.total = summary.total + 1
		elseif line:match("%[x%]") then
			summary.completed = summary.completed + 1
		elseif line:match("%[%-]") then
			summary.in_progress = summary.in_progress + 1
		end
	end

	print(
		string.format(
			"Task Summary:\n  Total: %d\n  Completed: %d\n  In Progress: %d",
			summary.total,
			summary.completed,
			summary.in_progress
		)
	)
end

function M.edit_task_description()
	vim.cmd("normal! ^f]a ")
end

function M.add_subtask()
	local current_line_number = vim.api.nvim_win_get_cursor(0)[1] - 1
	local current_line = vim.api.nvim_get_current_line()
	local indent = string.match(current_line, "^%s*") or ""
	local subtask = indent .. "    [ ] Subtask"
	vim.api.nvim_buf_set_lines(0, current_line_number + 1, current_line_number + 1, false, { subtask })
end

return M
