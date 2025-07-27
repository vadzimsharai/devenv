return {
    "kkharji/sqlite.lua", 
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("neoclip").setup {
                enable_persistent_history = true,
                history = 1000,
                continuous_sync = true,
                on_paste = {set_reg = false},
                on_yank = {set_reg = false}
            }
        end
    }
}
