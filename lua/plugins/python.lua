return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        pyright = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
              require("dap").adapters.python = {
                type = "executable",
                command = "python",
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
