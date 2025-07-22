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

        map('n', '<leader>gb', gitsigns.blame, { desc = '[G]it [B]lame' })
        map('n', '<leader>gd', function()
          gitsigns.diffthis '~1'
        end, { desc = '[G]it [D]iff against last commit' })
        map('n', '<leader>gd', function()
          gitsigns.diffthis '~'
        end, { desc = '[G]it [D]iff against head' })
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]it [S]tage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]it [R]eset hunk' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
        map('n', '<leader>gj', function()
          gitsigns.nav_hunk 'next'
        end, { desc = '[G]it [J]ump to next change' })
        map('n', '<leader>gJ', function()
          gitsigns.nav_hunk 'prev'
        end, { desc = '[G]it [J]ump to previous change' })
        gitsigns.setup {
          signcolumn = true,
          numhl = true,
        }
      end,
    },
  },
}
