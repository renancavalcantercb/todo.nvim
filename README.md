todo.nvim - A Simple TODO Management Plugin for Neovim
-------------------------------------------------------

Features:

- Add, check, reset, and mark tasks as "in progress" directly in .todo files.
- Count total, completed, and in-progress tasks.
- Highlight task statuses with custom syntax:
  - [ ] for pending tasks
  - [x] for completed tasks
  - [-] for tasks in progress.
- Easy-to-use key mappings for quick actions.

Key Mappings
--------------

| Key           | Action                          |
|---------------|---------------------------------|
| <Leader>[     | Add a new TODO item            |
| <Leader>x     | Check the current task         |
| <Leader>-     | Mark the task as in progress   |
| <Leader><Leader> | Reset the task              |
| <Leader>]     | Edit the task description      |
| <Leader>c     | Count all tasks in the file    |

Installation
-------------

1. Add todo.nvim to your plugin manager. Example using Lazy.nvim:
   {
       "renancavalcantercb/todo.nvim",
       config = function()
           require("todo").setup()
       end,
   }

2. Reload Neovim and run :Lazy sync (if using Lazy.nvim).

Usage
------

1. Create or open a file with the .todo extension.
2. Use the key mappings to manage tasks.
3. Check the task summary with <Leader>c.

Example TODO File
-------------------

[ ] Pending task 1
[ ] Pending task 2
[-] Task in progress
[x] Completed task
