return {
  {
    "aklt/plantuml-syntax", -- TODO: check if TS syntax exists
    ft = "plantuml",
  },
  {
    "javiorfo/nvim-soil",
    ft = "plantuml",
    event = { "BufReadPre", "BufNewFile" },
  },
}
