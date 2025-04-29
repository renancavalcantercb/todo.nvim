# todo.nvim - A Simple TODO Management Plugin for Neovim

![Version](https://img.shields.io/github/v/tag/renancavalcantercb/todo.nvim?label=version)
![GitHub repo size](https://img.shields.io/github/repo-size/renancavalcantercb/todo.nvim)
![GitHub issues](https://img.shields.io/github/issues/renancavalcantercb/todo.nvim)

Manage your tasks directly in Neovim with syntax highlighting, dynamic key mappings, and easy task management for `.todo` files.

## Features

- Add, Check, Reset, and Mark Tasks as "in progress" directly in `.todo` files
- Toggle Task State with a single key (cycle between `[ ]`, `[-]`, `[x]`)
- Automatic task sorting by status
- Deadline support with visual indicators
- Count Tasks:
  - Total tasks
  - Completed tasks
  - Tasks in progress
- Syntax Highlighting for task statuses:
  - `[ ]` for **Pending** (grey)
  - `[x]` for **Completed** (green)
  - `[-]` for **In Progress** (yellow)
  - `@YYYY-MM-DD` for **Deadlines** (blue)
  - Overdue deadlines highlighted in **red**
- Dynamic Key Mappings for quick and easy task actions
- Subtask support with proper indentation
- Task filtering system
- Modular and maintainable codebase, perfect for contributors

## Key Mappings

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
| `<Leader>f`      | Toggle between filtered views (all/pending/in-progress/completed) |
| `<Leader>o`      | Sort tasks by status (pending → in-progress → completed) |
| `<Leader>d`      | Add today's date as deadline    |
| `<Leader>D`      | Remove deadline from task       |
| `<Leader>l`      | List overdue tasks              |
| `<Leader>O`      | Sort tasks by deadline          |

## Installation

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

## Usage

1. Create or open a file with the `.todo` extension
2. Use the key mappings to manage tasks
3. Check the task summary with `<Leader>c`
4. Sort your tasks with `<Leader>o`
5. Add deadlines with `<Leader>d`
6. Check overdue tasks with `<Leader>l`

### Example TODO File

```plaintext
[ ] Buy groceries @2024-03-20
[ ] Call mom @2024-03-25
[-] Write report @2024-03-18
[x] Pay bills @2024-03-15
    [x] Electricity
    [ ] Water
```

## Task States

- `[ ]` - Pending task
- `[-]` - Task in progress
- `[x]` - Completed task

## Deadline Format

- Use `@YYYY-MM-DD` format for deadlines
- Example: `[ ] Buy groceries @2024-03-20`
- Overdue deadlines are highlighted in red
- Tasks without deadlines go to the end when sorting by deadline

## Planned Features

### Task Management
1. Task Priorities:
   - Add priority levels (P1, P2, P3)
   - Sort by priority
   - Visual indicators for priority levels

2. Tags and Categories:
   - Add tags with # syntax
   - Filter by tags
   - Category-based organization

### Visual Enhancements
1. Custom Highlight Groups:
   - Configure colors for task states
   - Add icons for different states
   - Progress bar in status line

### Integration
1. Export Tasks:
   - Export to JSON, Markdown, or plain text
   - Import from other todo formats
   - Sync with external todo services

2. Telescope Integration:
   - Search across multiple todo files
   - Filter tasks globally
   - Quick task navigation

### Automation
1. Recurring Tasks:
   - Support for daily, weekly, monthly tasks
   - Automatic task reset
   - Task templates

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
