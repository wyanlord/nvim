return {
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("dap.ext.vscode").load_launchjs()
    end,
  },
}
