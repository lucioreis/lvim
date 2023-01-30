-- local require = require("lvim.utils.require").require
local core_plugins = {
  { "folke/lazy.nvim", tag = "stable" },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" },
  },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "tamago324/nlsp-settings.nvim", lazy = true },
  { "jose-elias-alvarez/null-ls.nvim", lazy = true },
  {
    "williamboman/mason.nvim",
    config = function()
      require("lvim.core.mason").setup()
    end,
  },
  {
    "folke/tokyonight.nvim",
  },
  {
    "lunarvim/lunar.nvim",
  },
  { "Tastyep/structlog.nvim" },

  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("lvim.core.telescope").setup()
    end,
    dependencies = { "telescope-fzf-native.nvim" },
    lazy = true,
    cmd = "Telescope",
    enabled = lvim.builtin.telescope.active,
  },
  { "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
    enabled = lvim.builtin.telescope.active
  },
  -- Install nvim-cmp, and buffer source as a dependency
  {
    "hrsh7th/nvim-cmp",
    config = function()
      if lvim.builtin.cmp then
        require("lvim.core.cmp").setup()
      end
    end,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
    },
  },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local utils = require "lvim.utils"
      local paths = {}
      if lvim.builtin.luasnip.sources.friendly_snippets then
        paths[#paths + 1] = utils.join_paths(get_runtime_dir(), "site", "pack", "lazy", "opt", "friendly-snippets")
      end
      local user_snippets = utils.join_paths(get_config_dir(), "snippets")
      if utils.is_directory(user_snippets) then
        paths[#paths + 1] = user_snippets
      end
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = paths,
      }
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
    event = "InsertEnter",
    dependencies = {
      "friendly-snippets",
    },
  },
  { "rafamadriz/friendly-snippets",
    lazy = true,
    cond = lvim.builtin.luasnip.sources.friendly_snippets },
  {
    "folke/neodev.nvim",
    lazy = true
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("lvim.core.autopairs").setup()
    end,
    enabled = lvim.builtin.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
    config = function()
      require("lvim.core.treesitter").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    config = function()
      require("lvim.core.nvimtree").setup()
    end,
    enabled = lvim.builtin.nvimtree.active,
  },
  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("lvim.core.gitsigns").setup()
    end,
    event = "BufRead",
    enabled = lvim.builtin.gitsigns.active,
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("lvim.core.which-key").setup()
    end,
    event = "VeryLazy",
    enabled = lvim.builtin.which_key.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("lvim.core.comment").setup()
    end,
    enabled = lvim.builtin.comment.active,
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("lvim.core.project").setup()
    end,
    enabled = lvim.builtin.project.active,
  },

  -- Icons
  -- {
  --   "kyazdani42/nvim-web-devicons",
  --   enabled = lvim.use_icons,
  -- },

  -- Status Line and Bufferline
  {
    -- "hoob3rt/lualine.nvim",
    "nvim-lualine/lualine.nvim",
    -- "Lunarvim/lualine.nvim",
    config = function()
      require("lvim.core.lualine").setup()
    end,
    enabled = lvim.builtin.lualine.active,
  },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("lvim.core.breadcrumbs").setup()
    end,
    enabled = lvim.builtin.breadcrumbs.active,
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("lvim.core.bufferline").setup()
    end,
    branch = "main",
    enabled = lvim.builtin.bufferline.active,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("lvim.core.dap").setup()
    end,
    enabled = lvim.builtin.dap.active,
  },

  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("lvim.core.dap").setup_ui()
    end,
    enabled = lvim.builtin.dap.active,
  },

  -- alpha
  {
    "goolord/alpha-nvim",
    config = function()
      require("lvim.core.alpha").setup()
    end,
    enabled = lvim.builtin.alpha.active,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    branch = "main",
    config = function()
      require("lvim.core.terminal").setup()
    end,
    enabled = lvim.builtin.terminal.active,
  },

  -- SchemaStore
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("lvim.core.illuminate").setup()
    end,
    event = "VeryLazy",
    enabled = lvim.builtin.illuminate.active,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("lvim.core.indentlines").setup()
    end,
    enabled = lvim.builtin.indentlines.active,
  },

  {
    "lunarvim/onedarker.nvim",
    branch = "freeze",
    config = function()
      pcall(function()
        if lvim and lvim.colorscheme == "onedarker" then
          require("onedarker").setup()
          lvim.builtin.lualine.options.theme = "onedarker"
        end
      end)
    end,
    enabled = lvim.colorscheme == "onedarker",
  },

  {
    "lunarvim/bigfile.nvim",
    config = function()
      pcall(function()
        require("bigfile").config(lvim.builtin.bigfile.config)
      end)
    end,
    enabled = lvim.builtin.bigfile.active,
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("lvim.core.nvimsurround").setup()
    end,
    enabled = lvim.builtin.nvimsurround.active,
  },

  {
    "folke/noice.nvim",
    config = function()
      require("lvim.core.noice").setup()
    end,
    enabled = lvim.builtin.noice.active,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      lazy = true,

      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
    }
  },

  { "phaazon/hop.nvim",
    config = function()
      require("lvim.core.hop").setup()
    end
  },

  {
    "p00f/nvim-ts-rainbow"
  },

  {
    "windwp/nvim-ts-autotag"
  },

  { "ThePrimeagen/harpoon",
    config = function() require("lvim.core.harpoon").setup() end
  },

  {
    "drybalka/tree-climber.nvim"
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("lvim.core.neoscroll").setup()
    end,
    enabled = lvim.builtin.neoscroll.active
  },

  {
    "nacro90/numb.nvim",
    config = function()
      require("lvim.core.numb").setup()
    end,
    enabled = lvim.builtin.numb.active
  },

  {
    "Shatur/neovim-session-manager",
    config = function() require('lvim.core.sessionmanager').setup() end,
    ft = "alpha",
    lazy = true,
    enabled = lvim.builtin.sessionmanager.active
  },

  {
    "simrat39/symbols-outline.nvim",
    config = function() require('lvim.core.symbolsoutline').setup() end,
    enabled = lvim.builtin.sessionmanager.active
  },

  {
    "TimUntersberger/neogit",
    --dependencies = {
    -- "sindrets/diffview.nvim",
    -- opts = require("lvim.core.diffview").config(),
    -- config = function() require("lvim.core.diffview").setup() end,
    -- enabled = false -- lvim.builtin.diffview.active
    --},
    config = function() require("lvim.core.neogit").setup() end,
    event = "VeryLazy",
    enabled = lvim.builtin.neogit.active
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("lvim.core.trouble").setup() end,
    enabled = lvim.builtin.trouble.active
  },

  { -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",

    dependencies = { "nvim-treesitter" },
    event = "VeryLazy"
  },

  { -- show and a navigate to an unde tree
    "mbbill/undotree",
    config = function() require('lvim.core.undotree').setup() end,
    event = "VeryLazy",
    enabled = lvim.builtin.undotree.active
  },

  { -- Intercept ui select entries with telescope
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function() require('lvim.core.neotree').setup() end,
    branch = "v2.x",
    enabled = lvim.builtin.neotree.active,
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function() require("lvim.core.colorizer").setup() end,
    enabled = lvim.builtin.colorizer.active,
  },
  {
    "catppuccin/nvim",
    config = function() require("lvim.core.catppuccin").setup() end,
    name = "catppuccin",
    enabled = lvim.builtin.catppuccin.acitve
  }

}

local default_snapshot_path = join_paths(get_lvim_base_dir(), "snapshots", "default.json")
local content = vim.fn.readfile(default_snapshot_path)
local default_sha1 = assert(vim.fn.json_decode(content))

-- taken form <https://github.com/folke/lazy.nvim/blob/c7122d64cdf16766433588486adcee67571de6d0/lua/lazy/core/plugin.lua#L27>
local get_short_name = function(long_name)
  local name = long_name:sub(-4) == ".git" and long_name:sub(1, -5) or long_name
  local slash = name:reverse():find("/", 1, true) --[[@as number?]]
  return slash and name:sub(#name - slash + 2) or long_name:gsub("%W+", "_")
end

local get_default_sha1 = function(spec)
  local short_name = get_short_name(spec[1])
  return default_sha1[short_name] and default_sha1[short_name].commit
end

if not vim.env.LVIM_DEV_MODE then
  -- Manually lock the commit hash since Packer's snapshots are unreliable in headless mode
  for _, spec in ipairs(core_plugins) do
    spec["commit"] = get_default_sha1(spec)
  end
end

return core_plugins
