local M = {}

M.key_mappings = {
	["<Leader>["] = "add_todo_item",
	["<Leader>x"] = "check_task",
	["<Leader>-"] = "mark_in_progress",
	["<Leader><Leader>"] = "reset_task",
	["<Leader>c"] = "count_tasks",
	["<Leader>]"] = "edit_task_description",
	["<Leader>t"] = "toggle_task_state",
	["<Leader>s"] = "add_subtask",
	["<Leader>f"] = "toggle_filter",
	["<Leader>o"] = "sort_tasks",
}

return M
