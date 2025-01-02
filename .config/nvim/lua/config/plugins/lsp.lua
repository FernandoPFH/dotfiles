return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "j-hui/fidget.nvim",
        opts = {}
      },
      {
        'Dan7h3x/signup.nvim',
        branch = 'main',
        opts = {},
        config = function(_, opts)
          require('signup').setup(opts)
        end
      },
      {
        'kosayoda/nvim-lightbulb',
        config = function()
          require('nvim-lightbulb').setup {
            autocmd = {
              enabled = true,
              updatetime = 10
            }
          }
        end
      },
      {
        'zeioth/garbage-day.nvim',
        event = 'VeryLazy',
        opts = {}
      },
      {
        'sontungexpt/better-diagnostic-virtual-text',
        event = "LspAttach",
      },
      {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
          require('lsp_lines').setup()
          vim.diagnostic.config({
            virtual_text = false
          })
        end
      },
      {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
          { "nvim-lua/plenary.nvim" },
          { "nvim-telescope/telescope.nvim" },
        },
        event = "LspAttach",
        config = function()
          require('tiny-code-action').setup()
        end,
        keys = {
          {
            '<C-space>',
            function()
              require("tiny-code-action").code_action()
            end,
            desc = "Open action menu"
          }
        }
      }
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            -- Format the current buffer on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })

      require('better-diagnostic-virtual-text').setup()
    end,
  }
}
