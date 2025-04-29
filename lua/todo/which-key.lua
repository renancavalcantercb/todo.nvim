local M = {}

function M.setup()
    local which_key = require("which-key")
    
    which_key.register({
        { "", "<leader>[D", desc = "Remove deadline", cmd = "lua require('todo').remove_deadline()<CR>" },
        { "", "<leader>[c", desc = "Count tasks", cmd = "lua require('todo').count_tasks()<CR>" },
        { "", "<leader>[]", desc = "Edit description", cmd = "lua require('todo').edit_task_description()<CR>" },
        { "", "<leader>[t", desc = "Toggle task state", cmd = "lua require('todo').toggle_task_state()<CR>" },
        { "", "<leader>[f", desc = "Toggle filter", cmd = "lua require('todo').toggle_filter()<CR>" },
        { "", "<leader>[s", desc = "Add subtask", cmd = "lua require('todo').add_subtask()<CR>" },
        { "", "<leader>[o", desc = "Sort by status", cmd = "lua require('todo').sort_tasks()<CR>" },
        { "", "<leader>[-", desc = "Mark as in progress", cmd = "lua require('todo').mark_in_progress()<CR>" },
        { "", "<leader>[[", desc = "Add new task", cmd = "lua require('todo').add_todo_item()<CR>" },
        { "", "<leader>[l", desc = "List overdue tasks", cmd = "lua require('todo').check_overdue_tasks()<CR>" },
        { "", "<leader>[x", desc = "Mark as completed", cmd = "lua require('todo').check_task()<CR>" },
        { "", "<leader>[O", desc = "Sort by deadline", cmd = "lua require('todo').sort_by_deadline()<CR>" },
        { "", "<leader>[d", desc = "Add deadline", cmd = "lua require('todo').add_deadline()<CR>" },
        { "", group = "todo" },
    }, {
        mode = "n",
    })
end

return M 