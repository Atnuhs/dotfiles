local status1, dap = pcall(require, 'dap')
if(not status1) then
    print("nvim-dap is not called")
    return
end
local status2, dap_go = pcall(require, 'dap-go')
if (not status2) then
    print("nvim-dap-go is not called")
    return
end
dap.init = {
    plugin = true,
    n = {
        ['<leader>db'] = {
            "<cmd> DapToggleBreakpoint <CR>",
            "Add breakpoint at line"
        },
        ["<leader>dus"] = {
            function()
                local widgets = require('dap.ui.widgets');
                local sidebar = widgets.sidebar(widgets.scopes);
                sidebar.open()
            end,
            "Open debugging sidebar"
        }
    }

}


dap_go.setup = {
    dap_configurations = {
        {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach"
        },
    },


    delve = {
        path = "div",
        initiallize_timeout_sec = 20,
        port = "${port}",
        args = {}
    },

    plugin = true,
    n = {
        ["<leader>dgt"] = {
            function()
                require('dap-go').debug_test()
            end,
            "Debug go test"
        },
        ["<leader>dgl"] = {
            function()
                require('dap-go').debug_last_test()
            end,
            "Debug last go test"
        }
    }

}
