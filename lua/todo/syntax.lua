local M = {}

function M.setup()
	vim.cmd([[
        syntax enable
        syntax match TodoPending /\[ \]/
        syntax match TodoCompleted /\[x\]/
        syntax match TodoInProgress /\[-\]/

        highlight TodoPending ctermfg=grey guifg=#808080
        highlight TodoCompleted ctermfg=green guifg=#00FF00
        highlight TodoInProgress ctermfg=yellow guifg=#FFFF00
    ]])
end

return M
