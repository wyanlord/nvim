return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        rust_analyzer = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = function()
              require("dap").adapters.codelldb = {
                type = "executable",
                command = vim.fn.stdpath('data') .. "/mason/packages/codelldb/extension/adapter/codelldb",
                name = "codelldb",
              }
            end,
          })
        end,
      },
    },
  },
}
