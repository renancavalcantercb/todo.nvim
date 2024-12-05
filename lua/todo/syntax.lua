local M = {}

function M.setup()
	vim.cmd([[
        syntax match TodoCheckbox /\- \[ \]/
        syntax match TodoChecked /\- \[x\]/
        syntax match TodoInProgress /\- \[-\]/
        highlight link TodoCheckbox Todo
        highlight link TodoChecked String
        highlight link TodoInProgress Keyword
    ]])
end

return M
