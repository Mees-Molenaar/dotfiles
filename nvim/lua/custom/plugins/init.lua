-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },

  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff view' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = '[G]it close [D]iff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it file [H]istory' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it repo [H]istory' },
      {
        '<leader>gB',
        function()
          local ok, builtin = pcall(require, 'telescope.builtin')
          if not ok then
            vim.notify('Telescope is not available', vim.log.levels.ERROR)
            return
          end

          local actions = require 'telescope.actions'
          local action_state = require 'telescope.actions.state'

          builtin.git_branches {
            prompt_title = 'Diffview Compare Branch...HEAD',
            show_remote_tracking_branches = true,
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                local branch = selection and (selection.value or selection[1])
                if not branch or branch == '' then
                  return
                end

                branch = branch:gsub('^%*%s*', ''):gsub('^remotes/', ''):gsub('%s*->.*$', '')
                vim.cmd('DiffviewOpen ' .. branch .. '...HEAD')
              end)

              return true
            end,
          }
        end,
        desc = '[G]it compare [B]ranch',
      },
    },
    opts = {
      enhanced_diff_hl = true,
      use_icons = vim.g.have_nerd_font,
      view = {
        default = { layout = 'diff2_horizontal' },
        merge_tool = { layout = 'diff3_horizontal' },
      },
    },
  },
}
