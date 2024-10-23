lvim.keys.normal_mode["i"] = "k"
lvim.keys.normal_mode["k"] = "j"
lvim.keys.normal_mode["j"] = "h"
lvim.keys.normal_mode["h"] = "i"
lvim.keys.normal_mode["C-k"] = nil
lvim.keys.normal_mode["C-j"] = nil
lvim.keys.normal_mode["C-i"] = nil
lvim.keys.normal_mode["<C-i>"] = "<C-w>k"
lvim.keys.normal_mode["<C-j>"] = "<C-w>h"
lvim.keys.normal_mode["<C-k>"] = "<C-w>j"
lvim.keys.visual_mode["i"] = "k"
lvim.keys.visual_mode["k"] = "j"
lvim.keys.visual_mode["j"] = "h"
lvim.keys.visual_mode["h"] = "i"
lvim.keys.normal_mode["d"] = '"_d'
lvim.keys.visual_mode["d"] = '"_d'
lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
}
lvim.builtin.which_key.mappings["k"] = {
  name = "+Compile",
  c = {"[[:!clang -g % -o %:p:h/%:t:r<CR>]]","Compile C"} 
}

lvim.plugins = {
 -- other plugins...
 {
   "kyazdani42/nvim-tree.lua",
   config = function()
     require("nvim-tree").setup({
       -- your options here
     })
   end,
 },
 -- other plugins...
}
-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)
-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/X:b9B4Ny

-- add `pyright` to `skipped_servers` list
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- remove `jedi_language_server` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)


local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/fabian/.local/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}


dap.configurations.cpp = {
 {
 type = "cppdbg",
 name = "Launch file",
 request = "launch",
 program = "${fileBasenameNoExtension}",
 cwd = vim.fn.getcwd(),
 externalConsole = false,
 MIMode = "gdb",
 MIDebuggerPath = "/usr/bin/gdb",
 preLaunchTask = {
   type = "shell",
   command = "clang++ -g ${file} -o ${fileDirname}/${fileBasenameNoExtension}",
   group = {kind = "build", isDefault = true},
 },
 setupCommands = {
   {
     description = "Enable pretty-printing for gdb",
     text = "-enable-pretty-printing",
     ignoreFailures = true
   },
 },
 },
}
 lvim.builtin.dap.active = true

dap.adapters.c = {
  id = 'c',
  type = 'executable',
  command = '/home/fabian/.local/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.c = {
 {
 type = "c",
 name = "Launch file",
 request = "launch",
 program = "${fileBasenameNoExtension}",
 cwd = vim.fn.getcwd(),
 externalConsole = false,
 MIMode = "gdb",
 MIDebuggerPath = "/usr/bin/gdb",
 setupCommands = {
   {
     description  = "Enable pretty-printing for gdb",
     text = "-enable-pretty-printing",
     ignoreFailures = true
   },
 },
 },
}
dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Debug',
    program = '${fileBasenameNoExtension}',
    pythonPath = function()
      return '/usr/bin/python'
    end,
  },
}

