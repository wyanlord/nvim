return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.sections.lualine_c[3] =
        { "filename", path = 0, symbols = { modified = "  ", readonly = "", unnamed = "" } }
    end,
  },
}
