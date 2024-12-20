local M = {}

M._original_lines = nil
M._current_filter = "all"

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

local filters = {
	all = function(lines)
		return lines
	end,
	pending = function(lines)
		local result = {}
		for _, l in ipairs(lines) do
			if l:match("%[ %]") then
				table.insert(result, l)
			end
		end
		return result
	end,
	in_progress = function(lines)
		local result = {}
		for _, l in ipairs(lines) do
			if l:match("%[%-%]") then
				table.insert(result, l)
			end
		end
		return result
	end,
	completed = function(lines)
		local result = {}
		for _, l in ipairs(lines) do
			if l:match("%[x%]") then
				table.insert(result, l)
			end
		end
		return result
	end,
}

local filter_order = { "all", "pending", "in_progress", "completed" }

local function next_filter(current)
	for i, f in ipairs(filter_order) do
		if f == current then
			return filter_order[(i % #filter_order) + 1]
		end
	end
	return "all"
end

function M.toggle_filter()
	local current_buffer = vim.fn.bufnr("%")
	local current_lines = vim.fn.getbufline(current_buffer, 1, "$")

	if M._current_filter == "all" then
		M._original_lines = current_lines
	end

	M._current_filter = next_filter(M._current_filter)

	if M._current_filter == "all" then
		if M._original_lines then
			vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, M._original_lines)
		end
		print("Filter: showing all tasks.")
	else
		local filtered = filters[M._current_filter](M._original_lines)
		vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, filtered)
		print("Active filter: " .. M._current_filter)
	end
end

function M.is_filtered()
	return M._current_filter ~= "all"
end

function M.restore_all()
	local current_buffer = vim.fn.bufnr("%")
	if M._original_lines then
		vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, M._original_lines)
		M._current_filter = "all"
		print("Filter cleared: showing all tasks.")
	end
end

return M
