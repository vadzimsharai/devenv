return {
    "rebelot/heirline.nvim",
    dependencies = {"AstroNvim/astroui", opts = {icons = {Clock = ""}}},
    opts = function(_, opts)
        local status = require "astroui.status"

        opts.statusline[1] = status.component.mode {
            mode_text = {padding = {left = 1, right = 1}}
        }
        opts.statusline[#opts.statusline] =
            status.component.builder {
                {
                    provider = function()
                        local time = os.date "%H:%M"

                        return status.utils.stylize(time, {
                            icon = {kind = "Clock", padding = {right = 1}},
                            padding = {right = 1}
                        })
                    end
                },
                update = {
                    "ModeChanged",
                    pattern = "*:*",
                    callback = vim.schedule_wrap(function()
                        vim.cmd.redrawstatus()
                    end)
                },
                hl = status.hl.get_attributes "mode",
                surround = {separator = "right"},
                init = status.init.update_events {
                    {
                        "User",
                        pattern = "UpdateTime",
                        callback = vim.schedule_wrap(function()
                            vim.cmd.redrawstatus()
                        end)
                    }
                }
            }

        local uv = vim.uv or vim.loop
        uv.new_timer():start(1000, 1000, vim.schedule_wrap(function()
            vim.api.nvim_exec_autocmds("User", {
                pattern = "UpdateTime",
                modeline = false
            })
        end))


    end
}
