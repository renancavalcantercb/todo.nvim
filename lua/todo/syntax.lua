local M = {}

function M.setup()
	vim.cmd([[
        syntax enable
        syntax match TodoPending /\[ \]/
        syntax match TodoCompleted /\[x\]/
        syntax match TodoInProgress /\[-\]/
        syntax match TodoDeadline /@\d\{4}-\d\{2}-\d\{2\}/
        syntax match TodoOverdue /@\d\{4}-\d\{2}-\d\{2\}/ containedin=TodoDeadline

        highlight TodoPending ctermfg=grey guifg=#808080
        highlight TodoCompleted ctermfg=green guifg=#00FF00
        highlight TodoInProgress ctermfg=yellow guifg=#FFFF00
        highlight TodoDeadline ctermfg=blue guifg=#0000FF
        highlight TodoOverdue ctermfg=red guifg=#FF0000
    ]])
end

return M
