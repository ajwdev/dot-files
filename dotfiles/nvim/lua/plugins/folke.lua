M = {}

return {
  {
    'folke/twilight.nvim',
    keys = {
      { "<F4>", "<cmd>Twilight<cr>", desc = "Toggle Twightlight" },
    },
  },

  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    opts = {
      open_no_results = true,
    },
    cmd = "Trouble",
    config = function()
      local repeatable = require("nvim-treesitter.textobjects.repeatable_move")
      --TODO Why doesn't this work :/
      local next, prev = repeatable.make_repeatable_move_pair(require("trouble").next, require("trouble").prev)
      M.diag_next = next
      M.diag_prev = prev
    end,
    keys = {
      {
        "]d",
        function() M.diag_next({ forward = true }) end,
        desc = "Next Item (Trouble)",
      },
      {
        "[d",
        -- function() require("trouble").prev() end,
        function() M.diag_prev({ forward = false }) end,
        desc = "Previous Item (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle focus=true<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      -- LSP things
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xr",
        "<cmd>Trouble lsp_references toggle focus=true win.position=bottom<cr>",
        desc = "LSP References (Trouble)",
      },
      {
        "<leader>xd",
        "<cmd>Trouble lsp_definitions toggle focus=true win.position=bottom<cr>",
        desc = "LSP Definitions (Trouble)",
      },
      {
        "<leader>xD",
        "<cmd>Trouble lsp_type_definitions toggle focus=true win.position=bottom<cr>",
        desc = "LSP Type definitions (Trouble)",
      },
      {
        "<leader>xi",
        "<cmd>Trouble lsp_implementations toggle focus=true win.position=bottom<cr>",
        desc = "LSP Implementations (Trouble)",
      },
      {
        "<leader>xci",
        "<cmd>Trouble lsp_incoming_calls toggle focus=true win.position=bottom<cr>",
        desc = "LSP Incoming Calls (Trouble)",
      },
      {
        "<leader>xco",
        "<cmd>Trouble lsp_outgoing_calls toggle focus=true win.position=bottom<cr>",
        desc = "LSP Outgoing Calls (Trouble)",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = 'BufReadPost',
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        SAFETY = { icon = " ", color = "warning" },
      },
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*:?]], -- pattern or table of patterns, used for highlighting (vim regex)
        keyword = "bg",                   -- "fg" or "bg" or empty
      },
    }
  },
}
