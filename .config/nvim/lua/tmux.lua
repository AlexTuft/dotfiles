local tmux_directions = {
    ["h"] = "L",
    ["j"] = "D",
    ["k"] = "U",
    ["l"] = "R",
}

function is_tmux()
    return vim.env.TMUX ~= nil
end

local function tmux_vim_change_window(direction)
    local prev_window = vim.fn.win_getid()
    vim.cmd.wincmd(direction)
    local cur_window = vim.fn.win_getid()
    if prev_window == cur_window then
        vim.fn.system("tmux select-pane -" .. tmux_directions[direction])
    end
end

function setup_vim_tmux_navigation()
    vim.keymap.set("n", "<C-H>", function() tmux_vim_change_window("h") end)
    vim.keymap.set("n", "<C-J>", function() tmux_vim_change_window("j") end)
    vim.keymap.set("n", "<C-K>", function() tmux_vim_change_window("k") end)
    vim.keymap.set("n", "<C-L>", function() tmux_vim_change_window("l") end)
    vim.keymap.set("n", "<C-LEFT>", function() tmux_vim_change_window("h") end)
    vim.keymap.set("n", "<C-DOWN>", function() tmux_vim_change_window("j") end)
    vim.keymap.set("n", "<C-UP>", function() tmux_vim_change_window("k") end)
    vim.keymap.set("n", "<C-RIGHT>", function() tmux_vim_change_window("l") end)
end
