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
		incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },

    indent = { enable = true },
		endwise = { enable = true },

    -- vim-matchup
    matchup = {
      enable = true,
    },

    -- nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ["<leader>rx"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>rX"] = "@parameter.inner",
        },
      },

      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },

      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
  }
end

return M
