return {
  "jghauser/follow-md-links.nvim",
  ft = "markdown",
  config = function()
    require("follow-md-links").setup()
  end,
}