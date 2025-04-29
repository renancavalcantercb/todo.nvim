local M = {}

local utils = require("todo.utils")
local mappings = require("todo.mappings")
local autocommands = require("todo.autocommands")

M.add_todo_item = utils.add_todo_item
M.check_task = utils.check_task
M.mark_in_progress = utils.mark_in_progress
M.reset_task = utils.reset_task
M.toggle_task_state = utils.toggle_task_state
M.count_tasks = utils.count_tasks
M.edit_task_description = utils.edit_task_description
M.add_subtask = utils.add_subtask
M.toggle_filter = utils.toggle_filter
M.is_filtered = utils.is_filtered
M.restore_all = utils.restore_all
M.sort_tasks = utils.sort_tasks

function M.setup()
	autocommands.register_autocommands(mappings.key_mappings)
end

return M
