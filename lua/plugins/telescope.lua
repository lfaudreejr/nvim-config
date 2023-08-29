local P = { 'nvim-telescope/telescope.nvim', tag = '0.1.2' }

P.dependencies = { 'nvim-lua/plenary.nvim' }

function P.config()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local actions = require("telescope.actions")
  local actions_layout = require("telescope.actions.layout")
  local transform_mod = require("telescope.actions.mt").transform_mod
  local previewers = require("telescope.previewers")
  local custom_actions = transform_mod({
    -- File browser
    file_browser = function(prompt_bufnr)
      local content = require("telescope.actions.state").get_selected_entry()
      if content == nil then
        return
      end

      local full_path = content.cwd
      if content.filename then
        full_path = content.filename
      elseif content.value then
        full_path = full_path .. require("plenary.path").path.sep .. content.value
      end

      -- Close the Telescope window
      require("telescope.actions").close(prompt_bufnr)

      -- Open file browser
      -- vim.cmd("Telescope file_browser select_buffer=true path=" .. vim.fs.dirname(full_path))
      require("telescope").extensions.file_browser.file_browser({
        select_buffer = true,
        path = vim.fs.dirname(full_path),
      })
    end,
  })

  local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
      if not stat then
        return
      end
      if stat.size > 500000 then
        return
      else
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end
    end)
  end

  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

  local opts = {
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        i = {
          ["<C-h>"] = "which_key",
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
					["?"] = actions_layout.toggle_preview,
					["<C-s>"] = custom_actions.visidata,
					["<A-f>"] = custom_actions.file_browser,
				},
				n = {
					["s"] = custom_actions.visidata,
					["<A-f>"] = custom_actions.file_browser,
					n = { ["q"] = require("telescope.actions").close },
				},
      },
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      buffer_previewer_maker = new_maker,
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  }

  telescope.setup(opts)

end

return P
