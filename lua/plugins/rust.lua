return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        rust_analyzer = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = function()
              local dap = require("dap")
              dap.adapters.rust = {
                type = "executable",
                command = "/usr/bin/lldb-vscode-13",
                name = "rust",
              }
            end,
          })
        end,
      },
    },
  },
}
