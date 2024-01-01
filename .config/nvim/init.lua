vim.g.mapleader = " "

--------------------------------------------------------------------------------
--- Plugins
--------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

--------------------------------------------------------------------------------
--- Keymaps
--------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file [e]xplorer" })

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Window navigation
require("tmux")

if is_tmux() then
    setup_vim_tmux_navigation()
else
    vim.keymap.set("n", "<M-H>", "<C-W>h")
    vim.keymap.set("n", "<M-J>", "<C-W>j")
    vim.keymap.set("n", "<M-K>", "<C-W>k")
    vim.keymap.set("n", "<M-L>", "<C-W>l")
    vim.keymap.set("n", "<M-UP>", "<C-W><UP>")
    vim.keymap.set("n", "<M-DOWN>", "<C-W><DOWN>")
    vim.keymap.set("n", "<M-LEFT>", "<C-W><LEFT>")
    vim.keymap.set("n", "<M-RIGHT>", "<C-W><RIGHT>")
end

--------------------------------------------------------------------------------
--- Options
--------------------------------------------------------------------------------

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true

-- Display whitespace
vim.opt.list = true
vim.opt.listchars = {
    trail = "•",
}

-- Disable highlight on search
vim.o.hlsearch = false

-- Sync clipboard between OS and Neovim
vim.o.clipboard = "unnamedplus"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true


-- Remove background color
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_command("highlight EndOfBuffer guibg=NONE ctermbg=NONE")

-- Setup toggle comment plugin
require("Comment").setup()

-- Harpoon

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ha", function () harpoon:list():append() end, { desc = "[A]dd file to [h]arpoon" })
vim.keymap.set("n", "<leader>hr", function () harpoon:list():remove() end, { desc = "[R]emove file to [h]arpoon" })
vim.keymap.set("n", "<leader>hc", function () harpoon:list():clear() end, { desc = "[C]clear [h]arpooned files" })
vim.keymap.set("n", "<leader>hl", function () harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[L]ist [h]arpooned files"})

for i=1,9 do
    vim.keymap.set("n", "<leader>h" .. i, function () harpoon:list():select(i) end, { desc = "Select [h]arpooned file [" .. i .. "]" })
end

vim.keymap.set("n", "<leader>hn", function () harpoon:list():next() end, { desc = "[N]ext [h]arpooned file" })
vim.keymap.set("n", "<leader>hp", function () harpoon:list():prev() end, { desc = "[P]revious [h]arpooned file" })

-- WhichKey

require("which-key").setup()

vim.o.timeout = true
vim.o.timeoutlen = 300

--------------------------------------------------------------------------------
--- Fuzzy Finder
--------------------------------------------------------------------------------

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })


--------------------------------------------------------------------------------
--- Treesitter
--------------------------------------------------------------------------------

require("nvim-treesitter.configs").setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "lua", "vimdoc", "vim" },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<M-space>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
}

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })


--------------------------------------------------------------------------------
--- LSP
--------------------------------------------------------------------------------

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("sk", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })

    vim.cmd[[
    autocmd BufWritePost *.rs Format
]]
end

--  If you want to override the default filetypes that your language server will attach to you can
--  define the property "filetypes" to the map in question.
local servers = {
    -- gopls = {},
    -- pyright = {},
    -- tsserver = {},
    -- html = { filetypes = { "html", "twig", "hbs"} },

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end
}

-- manage some LSPs without mason

local lspconfig = require("lspconfig")

-- NOTE: Install rust with 'rustup component add rust-analyzer'

local function get_rust_toolchain()
    local toolchain = vim.fn.system("rustup default")

    local space_index = string.find(toolchain, " ")
    if space_index ~= nil then
        toolchain = toolchain:sub(1, space_index - 1)
    end

    return toolchain
end

lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
        "rustup", "run", get_rust_toolchain(), "rust-analyzer",
    },
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy"
            }
        }
    }
}

lspconfig.clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
        "clangd", "--log=verbose", "--query-driver=\"/snap/bin/zig\""
    }
}

lspconfig.omnisharp.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

--------------------------------------------------------------------------------
--- Cmp
--------------------------------------------------------------------------------

local cmp = require "cmp"
local luasnip = require "luasnip"
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered({
            winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None'
        }),
    },
}


--------------------------------------------------------------------------------
--- GitHub Copilot
--------------------------------------------------------------------------------

vim.g.copilot_assume_mapped = true


--------------------------------------------------------------------------------
-- Debugging
--------------------------------------------------------------------------------

local dap = require("dap")
local dapui = require("dapui")

-- Keymaps
vim.keymap.set("n", "<F5>", function () dap.continue() end, { desc = "Start debugging" })
vim.keymap.set("n", "<F7>", function () dap.step_over() end, { desc = "Step over" })
vim.keymap.set("n", "<F8>", function () dap.step_into() end, { desc = "Step into" })
vim.keymap.set("n", "<F9>", function () dap.step_out() end, { desc = "Step out" })
vim.keymap.set("n", "<leader>b", function () dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })

-- UI
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Adapters
local nvim_data_dir = vim.fn.stdpath("data")
local codelldb_path = nvim_data_dir .. "/mason/packages/codelldb/extension/adapter/codelldb"
local codelldb_port = 13000

dap.adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = codelldb_port,
    executable = {
        command = codelldb_path,
        args = { "--port", codelldb_port },
        detached = jit.os ~= "Windows",
    }
}

-- Configurations
require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "rust" } })
