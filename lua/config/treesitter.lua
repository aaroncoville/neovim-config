local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all"
    ensure_installed = { "bash", "c_sharp", "css", "dockerfile", "elixir", "fish", "gitignore", "gitattributes", "html", "http", "java", "javascript", "json", "kotlin", "lua", "regex", "rust", "scala", "scss", "sql", "tsx", "typescript", "vim", "vue", "yaml" }, 

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
  }
end

return M
