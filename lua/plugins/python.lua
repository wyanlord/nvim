return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        pyright = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
              local dap = require("dap")
              dap.adapters.python = {
                type = "executable",
                command = "/usr/bin/python3",
                name = "python",
                args = { "-m", "debugpy.adapter" },
              }
            end,
          })
        end,
      },
    },
  },
}
