return {
  {
    "simrat39/symbols-outline.nvim",
    init = function(_, bufnr)
        require("symbols-outline").setup()
        vim.keymap.set("n", "<leader>cO", "<cmd>SymbolsOutline<cr>", { silent = true, buffer = bufnr, desc = "Symbols Outline" })
    end,
  },
}
