return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
        window = {
            position = "float",
            popup = { -- settings that apply to float position only
                size = {height = "45", width = "150"},
                position = "50%" -- 50% means center it
            },

            mappings = {
                ["<leader>]"] = "next_source",
                ["<leader>["] = "prev_source"
            }
        }
    }
}
