local telescope = require("telescope")

telescope.setup {
  pickers = {
    current_buffer_fuzzy_find = {
      previewer = false,
      sorting_strategy = 'ascending',
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
  },
}

telescope.load_extension('cheat')
telescope.load_extension('fzf')
telescope.load_extension('project')
telescope.load_extension('ui-select')

