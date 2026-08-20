-- Or use default settings
require("eza-preview"):setup({})

-- DuckDB plugin configuration
require("duckdb"):setup()
-- DuckDB plugin configuration
-- require("duckdb"):setup({
--   mode = "standard"/"summarized",            -- Default: "summarized"
--   cache_size = 1000,                         -- Default: 500
--   row_id = true/false/"dynamic",             -- Default: false
--   minmax_column_width = int,                 -- Default: 21
--   column_fit_factor = float                  -- Default: 10.0
-- })

-- require("git"):setup()
-- THEME.git = THEME.git or {}
-- THEME.git.modified = ui.Style():fg("blue")
-- THEME.git.deleted = ui.Style():fg("red"):bold()
-- THEME.git.modified_sign = "M"
-- THEME.git.deleted_sign = "D"

require("mermaid"):setup({
  -- All keys are optional; defaults shown.
  backend = "mmdc",                 -- "auto" | "mermaid.ink" | "mmdc"
  format = "png",                   -- "png" | "svg"
  endpoint = "https://mermaid.ink", -- HTTP base (kroki / self-hosted work too)
  timeout = 10,                     -- curl --max-time, seconds
  glow_timeout = 15,                -- wall-clock cap on glow, seconds
  image_rows = nil,                 -- nil = follow zoom step; integer = fixed rows
  read_limit_mb = 8,                -- ceiling on io.read
})
