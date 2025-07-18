-- Fuzzy Finder (files, lsp, etc)
return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          mappings = {
            n = {
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-d>'] = require('telescope.actions').delete_buffer,
              ['<C-s>'] = require('telescope.actions').select_vertical,
            },
            i = {
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-d>'] = require('telescope.actions').delete_buffer,
              ['<C-s>'] = require('telescope.actions').select_vertical,
            },
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function()
        require('telescope.builtin').find_files {
          hidden = true,
        }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', function()
        builtin.live_grep { additional_args = { '--fixed-strings', '--ignore-case' } }
      end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find open files' })

      local initEMRTerminals = function(env)
        return function()
          local apiLaunchProfile = (env == 'prod' or env == 'Prod') and 'Apis-live' or 'Apis'
          local webLaunchProfile = (env == 'prod' or env == 'Prod') and 'Webapp-live' or 'Webapp'
          local isDev = (env == 'dev' or env == 'Dev')

          local apiCommand = "$Host.UI.RawUI.WindowTitle = 'API Terminal'; " .. 'cd C:\\Development\\Rider\\Time-Therapeutics\\TimeTherapeutics\\Apis; '
          if isDev then
            apiCommand = apiCommand .. "$Env:ASPNETCORE_CacheType = 'memory'; "
          end
          apiCommand = apiCommand .. 'dotnet run --launch-profile "' .. apiLaunchProfile .. '"'

          local webCommand = "$Host.UI.RawUI.WindowTitle = 'WebApp Terminal'; "
            .. 'cd C:\\Development\\Rider\\Time-Therapeutics\\TimeTherapeutics\\Webapp; '
            .. 'dotnet run --launch-profile "'
            .. webLaunchProfile
            .. '"'

          -- Launch each terminal with title
          os.execute([[start pwsh -NoExit -Command "]] .. apiCommand .. [["]])
          os.execute([[start pwsh -NoExit -Command "]] .. webCommand .. [["]])
        end
      end

      vim.keymap.set('n', '<leader>red', initEMRTerminals 'Dev', { desc = '[D]evelopment - EMR' })
      vim.keymap.set('n', '<leader>rep', initEMRTerminals 'Prod', { desc = '[P]roduction - EMR' })

      -- Patient App terminal with custom title
      vim.keymap.set('n', '<leader>rp', function()
        local patientCommand = "$Host.UI.RawUI.WindowTitle = 'Patient Terminal'; "
          .. 'cd C:\\Development\\Webstorm\\patient-experience\\packages\\ssr; pnpm dev'
        os.execute([[start pwsh -NoExit -Command "]] .. patientCommand .. [["]])
      end, { desc = '[P]atient App' })
      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
          layout_config = {
            height = 0.5,
            width = 0.5,
          },
        })
      end, { desc = '[/] Fuzzily search in current file' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
