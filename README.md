todo.nvim - A Simple TODO Management Plugin for Neovim
-------------------------------------------------------

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
```
