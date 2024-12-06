
todo.nvim - A Simple TODO Management Plugin for Neovim
-------------------------------------------------------

![Version](https://img.shields.io/github/v/tag/renancavalcantercb/todo.nvim?label=version)
![GitHub repo size](https://img.shields.io/github/repo-size/renancavalcantercb/todo.nvim)
![GitHub issues](https://img.shields.io/github/issues/renancavalcantercb/todo.nvim)

Manage your tasks directly in Neovim with syntax highlighting, dynamic key mappings, and easy task management for `.todo` files.

Features
--------

- Add, Check, Reset, and Mark Tasks as "in progress" directly in `.todo` files.
- Toggle Task State with a single key (cycle between `[ ]`, `[-]`, `[x]`).
- Count Tasks:
  - Total tasks
  - Completed tasks
  - Tasks in progress
- Syntax Highlighting for task statuses:
  - `[ ]` for **Pending**
  - `[x]` for **Completed**
  - `[-]` for **In Progress**
- Dynamic Key Mappings for quick and easy task actions.
- Modular and maintainable codebase, perfect for contributors.

Key Mappings
------------

| Key              | Action                          |
|------------------|---------------------------------|
| `<Leader>[`      | Add a new TODO item             |
| `<Leader>x`      | Mark the current task as completed |
| `<Leader>-`      | Mark the current task as in progress |
| `<Leader><Leader>` | Reset the task                |
| `<Leader>]`      | Edit the task description       |
| `<Leader>c`      | Count all tasks in the file     |
| `<Leader>t`      | Toggle the task state (`[ ]` → `[-]` → `[x]`) |
| `<Leader>s`      | Add a subtask under the current task |
|`<Leader>f`       | Toggle between filtered views (all/pending/in-progress/completed)|

Installation
-------------

1. Add `todo.nvim` to your plugin manager. Example using **Lazy.nvim**:

```lua
{
  "renancavalcantercb/todo.nvim",
  config = function()
    require("todo").setup()
  end,
}
```

2. Reload Neovim and run `:Lazy sync` (if using Lazy.nvim).

Usage
-----

1. Create or open a file with the `.todo` extension.
2. Use the key mappings to manage tasks.
3. Check the task summary with `<Leader>c`.

Example TODO File
-----------------

```plaintext
[ ] Pending task 1
[ ] Pending task 2
[-] Task in progress
[x] Completed task
    [x] Subtask 1
    [x] Subtask 2
```

Planned Features and Improvements
----------------------------------

Task Management
---------------

1. Sorting Tasks:
   - Automatically sort tasks by their state:
     - Pending tasks (`[ ]`) → In-progress tasks (`[-]`) → Completed tasks (`[x]`).
   - Add a key mapping: `<Leader>o` to sort the tasks in the file.

Visual and Syntax Enhancements
------------------------------

2. Highlight Deadlines:
   - Support tasks with deadlines, highlighting overdue and upcoming tasks.
   - Example:

     ```
     [ ] Task with deadline !2024-12-10
     ```

   - Overdue tasks will be highlighted in red, and upcoming deadlines in yellow.

3. Custom Highlight Groups:
   - Allow users to configure their own colors for task states via their Neovim config.
   - Example:

     ```lua
     require('todo').setup({
       highlights = {
         pending = "#FF0000",
         in_progress = "#FFFF00",
         completed = "#00FF00",
       },
     })
     ```

Integration
-----------

4. Export Tasks:
   - Add support for exporting tasks to common formats:
     - JSON, Markdown, or plain text.
   - New command: `:TodoExport <format>`.

5. Telescope Integration:
   - Enable searching for tasks across multiple `.todo` files using Telescope.nvim.
   - Example:

     ```
     :Telescope todo
     ```

   - Allows filtering tasks globally or by file.

Automation
----------

6. Recurring Tasks:
   - Support recurring tasks, automatically resetting them after a certain period.
   - Example:

     ```
     [ ] Daily report @daily
     [ ] Weekly sync @weekly
     ```

User Experience
---------------

7. Interactive Floating Window:
    - Provide an interactive floating window to manage tasks visually.
    - Example:
      - Show a list of tasks with actions like "complete," "edit," or "delete."
    - New key mapping: `<Leader>w` to open the task manager window.

8. Progress Bar:
    - Display a progress bar in the status line showing the percentage of completed tasks in the file.
    - Example:

      ```
      Progress: [#####-----] 50%
      ```

9. Undo Changes:
    - Allow undoing task state changes for better control.
    - Example:
      - Undo the last change to a task with `<Leader>u`.

Maintenance
-----------

10. Unit Tests:
    - Add unit tests for all major functions to ensure reliability.
