local M = {}
M.config = function()
  lvim.builtin.diffview = {
    active = true,
    on_config_done = nil,
    options = {
      diff_binaries = false, -- Show diffs for binaries
      enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
      git_cmd = { "git" }, -- The git executable followed by default args.
      use_icons = true, -- Requires nvim-web-devicons
      show_help_hints = true, -- Show hints for how to open the help panel
      watch_index = true, -- Update views and index buffers when the git index changes.
      icons = { -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts:
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see ':h diffview-config-view.x.layout'.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
        },
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_horizontal",
          disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        },
        file_history = {
          -- Config for changed files in file history views.
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        listing_style = "tree", -- One of 'list' or 'tree'
        tree_options = { -- Only applies when listing_style is 'tree'
          flatten_dirs = true, -- Flatten dirs that only contain one single dir
          folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
        },
        win_config = { -- See ':h diffview-config-win_config'
          position = "left",
          width = 35,
          win_opts = {}
        },
      },
      file_history_panel = {
        log_options = { -- See ':h diffview-config-log_options'
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
          hg = {
            single_file = {},
            multi_file = {},
          },
        },
        win_config = { -- See ':h diffview-config-win_config'
          position = "bottom",
          height = 16,
          win_opts = {}
        },
      },
      commit_log_panel = {
        win_config = { -- See ':h diffview-config-win_config'
          win_opts = {},
        }
      },
      default_args = { -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },

      hooks = {
        ---@param view StandardView
        view_opened = function(view)
          local utils = require("lvim.utils");
          -- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on
          -- the right.
          local function post_layout()
            utils.tbl_ensure(view, "winopts.diff2.a")
            utils.tbl_ensure(view, "winopts.diff2.b")
            -- left
            view.winopts.diff2.a = utils.tbl_union_extend(view.winopts.diff2.a, {
              winhl = {
                "DiffChange:DiffAddAsDelete",
                "DiffText:DiffDeleteText",
              },
            })
            -- right
            view.winopts.diff2.b = utils.tbl_union_extend(view.winopts.diff2.b, {
              winhl = {
                "DiffChange:DiffAdd",
                "DiffText:DiffAddText",
              },
            })
          end

          view.emitter:on("post_layout", post_layout)
          post_layout()
        end,
      }, -- See ':h diffview-config-hooks'
    }
  }
end

M.setup = function()
  vim.cmd([[highlight DiffAdd gui=none guifg=none guibg=#103235]])
  vim.cmd([[highlight DiffChange gui=none guifg=none guibg=#272D43]])
  vim.cmd([[highlight DiffText gui=none guifg=none guibg=#394b70]])
  vim.cmd([[highlight DiffDelete gui=none guifg=none guibg=#3F2D3D]])
  vim.cmd([[highlight DiffviewDiffAddAsDelete guibg=#3f2d3d gui=none guifg=none]])
  vim.cmd([[highlight DiffviewDiffDelete gui=none guifg=#3B4252 guibg=none]])

  -- Left panel
  -- "DiffChange:DiffAddAsDelete",
  -- "DiffText:DiffDeleteText",
  vim.cmd([[highlight DiffAddAsDelete gui=none guifg=none guibg=#3F2D3D]])
  vim.cmd([[highlight DiffDeleteText gui=none guifg=none guibg=#4B1818]])

  -- Right panel
  -- "DiffChange:DiffAdd",
  -- "DiffText:DiffAddText",
  vim.cmd([[highlight DiffAddText gui=none guifg=none guibg=#1C5458]])


  require("diffview").setup(lvim.builtin.diffview.options)
end

return M
