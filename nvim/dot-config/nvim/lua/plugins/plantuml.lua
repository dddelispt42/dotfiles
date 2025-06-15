return {
  {
    "https://gitlab.com/itaranto/plantuml.nvim",
    version = "*",
    config = function()
      require("plantuml").setup()
    end,
  },
  {
    "aklt/plantuml-syntax", -- TODO: check if TS syntax exists
    ft = "plantuml",
  },
}
