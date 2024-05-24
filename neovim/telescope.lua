local telescope = require("telescope")

telescope.setup {
  pickers = {
    current_buffer_fuzzy_find = {
      previewer = false,
      sorting_strategy = "ascending",
    },
    find_files = {
      find_command = {
        "fd",
        "--type",
        "f",
        "--hidden",
        "--exclude",
        ".git",
      },
    },
  },
  extensions = {
    project = {
      base_dirs = {
        { "~/development", max_depth = 4 },
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_cursor(),
    },
    zoxide = {
      prompt_title = "[ Change directory to... ]",
      mappings = {
        default = {
          after_action = function(selection)
            local path = selection.path
            vim.cmd("Oil " .. path)
            vim.cmd("1TermExec open=0 cmd='z " .. path .. "'")
            vim.api.nvim_feedkeys("_", "", false)
          end
        },
      },
    }
  },
}

telescope.load_extension("fzf")
telescope.load_extension("project")
telescope.load_extension("ui-select")
telescope.load_extension("zoxide")
