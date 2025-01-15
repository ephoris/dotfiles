return {
  "lervag/vimtex",
  ft = "tex",
  config = function()
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 1
    vim.g.vimtex_view_automatic = 1
    vim.g.vimtex_toc_config = {
      layer_status = {
        content = 1,
        label = 0,
        todo = 1,
        include = 0,
      },
      show_help = 0,
      split_width = 35,
    }
    vim.g.vimtex_quickfix_mode = 0
  end,
}
