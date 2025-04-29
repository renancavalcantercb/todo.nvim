local M = {}

function M.setup()
    local which_key = require("which-key")
    
    local mappings = {
        ["["] = {
            name = "todo",
            ["["] = { "<cmd>lua require('todo').add_todo_item()<CR>", "Add new task" },
            ["x"] = { "<cmd>lua require('todo').check_task()<CR>", "Mark as completed" },
            ["-"] = { "<cmd>lua require('todo').mark_in_progress()<CR>", "Mark as in progress" },
            ["]"] = { "<cmd>lua require('todo').edit_task_description()<CR>", "Edit description" },
            ["c"] = { "<cmd>lua require('todo').count_tasks()<CR>", "Count tasks" },
            ["t"] = { "<cmd>lua require('todo').toggle_task_state()<CR>", "Toggle task state" },
            ["s"] = { "<cmd>lua require('todo').add_subtask()<CR>", "Add subtask" },
            ["f"] = { "<cmd>lua require('todo').toggle_filter()<CR>", "Toggle filter" },
            ["o"] = { "<cmd>lua require('todo').sort_tasks()<CR>", "Sort by status" },
            ["d"] = { "<cmd>lua require('todo').add_deadline()<CR>", "Add deadline" },
            ["D"] = { "<cmd>lua require('todo').remove_deadline()<CR>", "Remove deadline" },
            ["l"] = { "<cmd>lua require('todo').check_overdue_tasks()<CR>", "List overdue tasks" },
            ["O"] = { "<cmd>lua require('todo').sort_by_deadline()<CR>", "Sort by deadline" },
        }
    }

    which_key.register(mappings, {
        prefix = "<leader>",
        mode = "n",
    })
end

return M 