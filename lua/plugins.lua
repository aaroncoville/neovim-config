local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in profiling.
		},
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme
    use {
      "Mofiqul/dracula.nvim",
      config = function()
        vim.cmd "colorscheme dracula"
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
			cmd = "Neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }

		-- WhichKey
    use {
       "folke/which-key.nvim",
			 event = "VimEnter",
       config = function()
        require("config.whichkey").setup()
      end,
    }
		
		-- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
     end,
    }

		-- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      opt = true,
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
    }

    -- Easy hopping
    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
    }

    -- Easy motion
    use {
      "ggandor/lightspeed.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        require("lightspeed").setup {}
      end,
    }
		
    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    }

		use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
        require("config.lualine").setup()
      end,
			wants = "nvim-web-devicons",
    }

		-- Treesitter
		use {
      "nvim-treesitter/nvim-treesitter",
			opt = true,
			event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
			requires = {
				{ "nvim-treesitter/nvim-treesitter-textobjects" },
		 	},
     }

		 use {
       "ibhagwan/fzf-lua",
			 wants = "nvim-web-devicons",
     }

		 use {
			 "kyazdani42/nvim-tree.lua",
			 wants = "nvim-web-devicons",
			 cmd = { "NvimTreeToggle", "NvimTreeClose" },
			 config = function()
				 require("config.nvimtree").setup()
			 end,
		 }
		 
		 use {
			 "stevearc/dressing.nvim",
			 event = "BufEnter",
			 config = function()
				 require("dressing").setup {
					 select = {
						 backend = { "telescope", "fzf", "builtin" },
					 },
				 }
			 end,
		 }

		 -- Bufferline
		 use {
			 "akinsho/nvim-bufferline.lua",
			 event = "BufReadPre",
			 wants = "nvim-web-devicons",
			 config = function()
				 require("config.bufferline").setup()
			 end,
		 }

		-- Completion
		use {
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			opt = true,
			config = function()
				require("config.cmp").setup()
			end,
			wants = { "LuaSnip" },
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"ray-x/cmp-treesitter",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-calc",
				"f3fora/cmp-spell",
				"hrsh7th/cmp-emoji",
				{
					"L3MON4D3/LuaSnip",
					wants = "friendly-snippets",
					config = function()
						require("config.luasnip").setup()
					end,
				},
				"rafamadriz/friendly-snippets",
				disable = false,
			},
		}

		-- Auto pairs
		use {
			"windwp/nvim-autopairs",
			wants = "nvim-treesitter",
			module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
			config = function()
				require("config.autopairs").setup()
			end,
		}

		-- Auto tag
		use {
			"windwp/nvim-ts-autotag",
			wants = "nvim-treesitter",
			event = "InsertEnter",
			config = function()
				require("nvim-ts-autotag").setup { enable = true }
			end,
		}

		  -- End wise
		use {
			"RRethy/nvim-treesitter-endwise",
			wants = "nvim-treesitter",
			event = "InsertEnter",
		}

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
