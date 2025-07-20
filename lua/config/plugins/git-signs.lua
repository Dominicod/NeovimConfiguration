return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'tpope/vim-fugitive',
    },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']l', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next [G]it change' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous [G]it change' })

        map('n', '<leader>gb', gitsigns.blame, { desc = '[G]it [B]lame' })
        map('n', '<leader>gd', function()
          gitsigns.diffthis '~1'
        end, { desc = '[G]it [D]iff against last commit' })
        map('n', '<leader>gd', function()
          gitsigns.diffthis '~'
        end, { desc = '[G]it [D]iff against head' })
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]it [S]tage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it [R]eset hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]it [S]tage buffer' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
        gitsigns.setup {
          signcolumn = true,
          numhl = true,
        }
      end,
    },
  },
}
