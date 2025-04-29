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

function M.sort_tasks()
	local current_buffer = vim.fn.bufnr("%")
	local lines = vim.fn.getbufline(current_buffer, 1, "$")
	
	-- Helper function to determine task priority
	local function get_task_priority(line)
		if line:match("%[ %]") then
			return 1  -- Pending tasks first
		elseif line:match("%[%-%]") then
			return 2  -- In-progress tasks second
		elseif line:match("%[x%]") then
			return 3  -- Completed tasks last
		end
		return 4  -- Lines without tasks go to the end
	end
	
	-- Sort lines while maintaining subtask indentation
	local sorted_lines = {}
	local current_task = nil
	local current_subtasks = {}
	
	for _, line in ipairs(lines) do
		local indent = string.match(line, "^%s*") or ""
		local is_subtask = #indent > 0
		
		if is_subtask and current_task then
			table.insert(current_subtasks, line)
		else
			if current_task then
				table.insert(sorted_lines, current_task)
				for _, subtask in ipairs(current_subtasks) do
					table.insert(sorted_lines, subtask)
				end
				current_subtasks = {}
			end
			current_task = line
		end
	end
	
	-- Add the last task and its subtasks
	if current_task then
		table.insert(sorted_lines, current_task)
		for _, subtask in ipairs(current_subtasks) do
			table.insert(sorted_lines, subtask)
		end
	end
	
	-- Sort lines based on priority
	table.sort(sorted_lines, function(a, b)
		local priority_a = get_task_priority(a)
		local priority_b = get_task_priority(b)
		return priority_a < priority_b
	end)
	
	-- Update buffer with sorted lines
	vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, sorted_lines)
	print("Tasks sorted by status: Pending → In Progress → Completed")
end

function M.add_deadline()
	local line = vim.fn.getline(".")
	if not line:match("%[.?.?%]") then
		print("No valid task found on this line.")
		return
	end
	
	-- Get current date in YYYY-MM-DD format
	local date = os.date("%Y-%m-%d")
	local new_line = line:gsub("(@%d{4}-%d{2}-%d{2})?", "@" .. date)
	vim.fn.setline(".", new_line)
	print("Deadline added: " .. date)
end

function M.remove_deadline()
	local line = vim.fn.getline(".")
	if not line:match("@%d{4}-%d{2}-%d{2}") then
		print("No deadline found on this line.")
		return
	end
	
	local new_line = line:gsub(" @%d{4}-%d{2}-%d{2}", "")
	vim.fn.setline(".", new_line)
	print("Deadline removed.")
end

function M.check_overdue_tasks()
	local current_date = os.time()
	local lines = vim.fn.getbufline(vim.fn.bufnr("%"), 1, "$")
	local overdue_count = 0
	
	for _, line in ipairs(lines) do
		local deadline = line:match("@(%d{4}-%d{2}-%d{2})")
		if deadline then
			local year, month, day = deadline:match("(%d{4})-(%d{2})-(%d{2})")
			local task_date = os.time({year = tonumber(year), month = tonumber(month), day = tonumber(day)})
			
			if task_date < current_date and not line:match("%[x%]") then
				overdue_count = overdue_count + 1
			end
		end
	end
	
	if overdue_count > 0 then
		print(string.format("Found %d overdue task(s).", overdue_count))
	else
		print("No overdue tasks found.")
	end
end

function M.sort_by_deadline()
	local current_buffer = vim.fn.bufnr("%")
	local lines = vim.fn.getbufline(current_buffer, 1, "$")
	
	-- Helper function to extract deadline from a line
	local function get_deadline(line)
		local deadline = line:match("@(%d{4}-%d{2}-%d{2})")
		if deadline then
			local year, month, day = deadline:match("(%d{4})-(%d{2})-(%d{2})")
			return os.time({year = tonumber(year), month = tonumber(month), day = tonumber(day)})
		end
		return math.huge -- Tasks without deadline go to the end
	end
	
	-- Sort lines while maintaining subtask indentation
	local sorted_lines = {}
	local current_task = nil
	local current_subtasks = {}
	
	for _, line in ipairs(lines) do
		local indent = string.match(line, "^%s*") or ""
		local is_subtask = #indent > 0
		
		if is_subtask and current_task then
			table.insert(current_subtasks, line)
		else
			if current_task then
				table.insert(sorted_lines, current_task)
				for _, subtask in ipairs(current_subtasks) do
					table.insert(sorted_lines, subtask)
				end
				current_subtasks = {}
			end
			current_task = line
		end
	end
	
	-- Add the last task and its subtasks
	if current_task then
		table.insert(sorted_lines, current_task)
		for _, subtask in ipairs(current_subtasks) do
			table.insert(sorted_lines, subtask)
		end
	end
	
	-- Sort lines based on deadline
	table.sort(sorted_lines, function(a, b)
		return get_deadline(a) < get_deadline(b)
	end)
	
	-- Update buffer with sorted lines
	vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, sorted_lines)
	print("Tasks sorted by deadline.")
end

return M
