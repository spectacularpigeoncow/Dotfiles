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
-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/X:b9B4Ny
vim.cmd [[
 augroup NvimTree
   autocmd!
   autocmd VimEnter * NvimTreeOpen
 augroup END
]]
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
 program = "${file}",
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


