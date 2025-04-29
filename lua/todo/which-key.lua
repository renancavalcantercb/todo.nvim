local M = {}

function M.setup()
    local wk = require("which-key")
    
    wk.add({
        { "<leader>[", group = "todo" },
        { "<leader>[[", "<cmd>lua require('todo').add_todo_item()<CR>", desc = "Add new task" },
        { "<leader>[x", "<cmd>lua require('todo').check_task()<CR>", desc = "Mark as completed" },
        { "<leader>[-", "<cmd>lua require('todo').mark_in_progress()<CR>", desc = "Mark as in progress" },
        { "<leader>[]", "<cmd>lua require('todo').edit_task_description()<CR>", desc = "Edit description" },
        { "<leader>[c", "<cmd>lua require('todo').count_tasks()<CR>", desc = "Count tasks" },
        { "<leader>[t", "<cmd>lua require('todo').toggle_task_state()<CR>", desc = "Toggle task state" },
        { "<leader>[s", "<cmd>lua require('todo').add_subtask()<CR>", desc = "Add subtask" },
        { "<leader>[f", "<cmd>lua require('todo').toggle_filter()<CR>", desc = "Toggle filter" },
        { "<leader>[o", "<cmd>lua require('todo').sort_tasks()<CR>", desc = "Sort by status" },
        { "<leader>[d", "<cmd>lua require('todo').add_deadline()<CR>", desc = "Add deadline" },
        { "<leader>[D", "<cmd>lua require('todo').remove_deadline()<CR>", desc = "Remove deadline" },
        { "<leader>[l", "<cmd>lua require('todo').check_overdue_tasks()<CR>", desc = "List overdue tasks" },
        { "<leader>[O", "<cmd>lua require('todo').sort_by_deadline()<CR>", desc = "Sort by deadline" },
    }, {
        mode = "n",
    })
end

return M 